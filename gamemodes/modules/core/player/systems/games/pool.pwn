#include <YSI_Coding\y_hooks>

#define POCKET_RADIUS 				(0.09)
#define POOL_TIMER_SPEED 			(25)
#define DEFAULT_AIM 				(0.38)
#define DEFAULT_POOL_STRING 		"Mesa de Sinuca\n{FFFFFF}Aperte 'ENTER' para jogar"
#define POOL_FEE_RATE 				(0.02)

#define MAX_POOL_TABLES 			(50)
#define MAX_POOL_BALLS 				(16) // não modifique

#define SendPoolMessage(%0,%1)		va_SendClientMessage(%0,-1,"SINUCA:" # %1)

/* ================================ VARIAVEIS ================================ */
new
	p_HideHelpDialogTimer[MAX_PLAYERS] = { -1, ... },
	PlayerText: p_HelpBoxTD[MAX_PLAYERS] = {PlayerText: INVALID_TEXT_DRAW, ...};

Float:GetDistanceFromPointToPoint( Float: fX, Float: fY, Float: fX1, Float: fY1)
	return Float: floatsqroot(floatpower(fX - fX1, 2) + floatpower(fY - fY1, 2));

Float:GetDistanceBetweenPoints( Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2 )
    return VectorSize(x1 - x2, y1 - y2, z1 - z2);

enum E_POOL_BALL_TYPE { // não modifique
	E_STRIPED,
	E_SOLID,
	E_CUE,
	E_8BALL
};

enum E_POOL_BALL_OFFSET_DATA {
	E_MODEL_ID, 					E_BALL_NAME[9],					E_POOL_BALL_TYPE: E_BALL_TYPE,
	Float: E_OFFSET_X, 				Float: E_OFFSET_Y
};

static const
	g_poolBallOffsetData[MAX_POOL_BALLS][E_POOL_BALL_OFFSET_DATA] =
	{
		{3003, 	"branca", 			E_CUE, 		0.5000, 	0.0000},
		{3002, 	"um",				E_SOLID,	-0.300, 	0.0000},
		{3100, 	"dois",				E_SOLID, 	-0.525, 	-0.040},
		{3101, 	"três",				E_SOLID,	-0.375, 	0.0440},
		{3102, 	"quatro",			E_SOLID,	-0.600, 	0.0790},
		{3103,	"cinco",			E_SOLID,	-0.525, 	0.1180},
		{3104,	"seis",				E_SOLID,	-0.600, 	-0.157},
		{3105, 	"sete",				E_SOLID,	-0.450, 	-0.079},
		{3106,	"oito",				E_8BALL,	-0.450, 	0.0000},
		{2995, 	"nove",				E_STRIPED,	-0.375, 	-0.044},
		{2996, 	"dez",				E_STRIPED,	-0.450, 	0.0790},
		{2997, 	"onze",				E_STRIPED,	-0.525, 	-0.118},
		{2998, 	"doze",				E_STRIPED,	-0.600, 	-0.079},
		{2999, 	"treze",			E_STRIPED,	-0.600, 	0.0000},
		{3000, 	"quatorze",			E_STRIPED,	-0.600, 	0.1570},
		{3001, 	"quinze",			E_STRIPED,	-0.525, 	0.0400}
	},
	Float: g_poolPotOffsetData[][] =
	{
		{0.955, 0.510}, 	{0.955, -0.49},
		{0.005, 0.550}, 	{0.007, -0.535},
		{-0.945, 0.513}, 	{-0.945, -0.490}
	},
	g_poolHoleOpposite[sizeof(g_poolPotOffsetData)] = {5, 4, 3, 2, 1, 0}
;

enum E_POOL_BALL_DATA {
	E_BALL_PHY_HANDLE[16],		bool: E_POCKETED[16]
};

enum E_POOL_TABLE_DATA {
	Float:E_X,						Float:E_Y, 						Float:E_Z,
	Float:E_ANGLE, 					E_WORLD, 						E_INTERIOR,
	E_TIMER, 						E_BALLS_SCORED, 				E_POOL_BALL_TYPE:E_PLAYER_BALL_TYPE[MAX_PLAYERS],
	bool:E_STARTED, 				E_AIMER, 						E_AIMER_OBJECT,
	E_NEXT_SHOOTER,					E_SHOTS_LEFT,					E_FOULS,						
	bool:E_EXTRA_SHOT,				bool:E_CUE_POCKETED,			E_PLAYER_8BALL_TARGET[MAX_PLAYERS],
	bool:E_READY,					E_CUEBALL_AREA,                 Float:E_POWER,
    E_DIRECTION,					E_TABLE,                        Text3D:E_LABEL, 				
    E_EXISTS,						E_ID,
}

new
	g_poolTableData 				[MAX_POOL_TABLES][E_POOL_TABLE_DATA],
	g_poolBallData 					[MAX_POOL_TABLES][E_POOL_BALL_DATA],

	p_PoolID 						[MAX_PLAYERS] = {-1, ...},

	bool: p_isPlayingPool			[MAX_PLAYERS char],
	bool: p_PoolChalking			[MAX_PLAYERS char],
	bool: p_PoolCameraBirdsEye		[MAX_PLAYERS char],
	p_PoolScore 					[MAX_PLAYERS],
	p_PoolHoleGuide 				[MAX_PLAYERS] = {-1, ...},
	Float: p_PoolAngle 				[MAX_PLAYERS][2],

	PlayerBar: g_PoolPowerBar 		[MAX_PLAYERS],
	Text: g_PoolTextdraw			= Text: INVALID_TEXT_DRAW,

	Iterator: pooltables 			<MAX_POOL_TABLES>,
	Iterator: poolplayers 			<MAX_POOL_TABLES, MAX_PLAYERS>
;

/* ================================ FORWARDS ================================ */
forward deleteBall 					(poolid, ballid);
forward RestoreWeapon 				(playerid);
forward RestoreCamera 				(playerid);
forward OnPoolUpdate 				(poolid);
forward PlayPoolSound 				(poolid, soundid);

/* ================================ HOOKS ================================ */
hook OnScriptInit() {
	// textdraws
	new powerStr[128];
    format(powerStr, sizeof(powerStr), "Força");
    AdjustTextDrawString(powerStr);

	g_PoolTextdraw = TextDrawCreate(529.000000, 218.000000, powerStr);
	TextDrawBackgroundColour(g_PoolTextdraw, 255);
	TextDrawFont(g_PoolTextdraw, TEXT_DRAW_FONT_2);
	TextDrawLetterSize(g_PoolTextdraw, 0.300000, 1.299998);
	TextDrawColour(g_PoolTextdraw, -1);
	TextDrawSetOutline(g_PoolTextdraw, 1);
	TextDrawSetProportional(g_PoolTextdraw, true);
	TextDrawSetSelectable(g_PoolTextdraw, false);

	return true;
}

hook OnGameModeInit() {
	LoadPools();
	printf("[MESAS DE SINUCA]: %d mesas de sinuca foram criadas.", Iter_Count(pooltables));
	return true;
}

hook OnPlayerDisconnect(playerid, reason){
	Pool_RemovePlayer(playerid);
	return true;
}

hook OnPlayerDeath(playerid, killerid, reason) {
	Pool_RemovePlayer(playerid);
	return true;
}

hook OnPlayerConnect(playerid) {
	g_PoolPowerBar[playerid] = CreatePlayerProgressBar(playerid, 530.000000, 233.000000, 61.000000, 6.199999, -1429936641, 100.0000, 0);
	RemoveBuildingForPlayer(playerid, 2964, 510.1016, -84.8359, 997.9375, 9999.9);

	p_HelpBoxTD[playerid] = CreatePlayerTextDraw(playerid, 30.000000, 161.000000, "Carregando...");
	PlayerTextDrawBackgroundColour(playerid, p_HelpBoxTD[playerid], 255);
	PlayerTextDrawFont(playerid, p_HelpBoxTD[playerid], TEXT_DRAW_FONT_2);
	PlayerTextDrawLetterSize(playerid, p_HelpBoxTD[playerid], 0.219999, 1.200000);
	PlayerTextDrawColour(playerid, p_HelpBoxTD[playerid], -1);
	PlayerTextDrawSetOutline(playerid, p_HelpBoxTD[playerid], false);
	PlayerTextDrawSetProportional(playerid, p_HelpBoxTD[playerid], true);
	PlayerTextDrawSetShadow(playerid, p_HelpBoxTD[playerid], 1);
	PlayerTextDrawUseBox(playerid, p_HelpBoxTD[playerid], true);
	PlayerTextDrawBoxColour(playerid, p_HelpBoxTD[playerid], 117);
	PlayerTextDrawTextSize(playerid, p_HelpBoxTD[playerid], 170.000000, 0.000000);
	return true;
}

Dialog:DIALOG_POOL_WAGER(playerid, response, listitem, inputtext[]) {
    new
		poolid = p_PoolID[playerid], string[128];
 
	if (poolid == -1) return SendErrorMessage(playerid, "Não foi possí­vel identificar a mesa de sinuca. Por favor, entre na mesa novamente.");
    if (response) {
		g_poolTableData[poolid][E_READY] = true;
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s iniciou um jogo na mesa de sinuca.", pNome(playerid));
		format(string, sizeof(string), "Mesa de Sinuca\n{FFFFFF}Aperte 'ENTER' para jogar\nIniciada por %s", pNome(playerid));
		UpdateDynamic3DTextLabelText(g_poolTableData[poolid][E_LABEL], COLOR_GREY, string);
	}
    return true;
}

hook OnPlayerUpdateEx(playerid) {
	new
		poolid = p_PoolID[playerid];

	if (IsPlayerPlayingPool(playerid) && poolid != -1) {
		new
			Float: distance_to_table = GetPlayerDistanceFromPoint(playerid, g_poolTableData[poolid][E_X], g_poolTableData[poolid][E_Y], g_poolTableData[poolid][E_Z]);

		if (distance_to_table >= 25.0) {
			Pool_SendTableMessage(poolid, -1, "(( %s foi expulso da partida de sinuca por estar fora do alcance. ))", pNome(playerid));
			return Pool_RemovePlayer(playerid), 1;
		}
	}
	return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	new Float: pooltable_distance = 99999.99;
	new poolid = Pool_GetClosestTable(playerid, pooltable_distance);

	if (poolid != -1 && pooltable_distance < 2.5) {
		if (g_poolTableData[poolid][E_STARTED]) {
			// quit table
			if (HOLDING(16) && IsPlayerPlayingPool(playerid)) {
				HidePlayerHelpDialog(playerid);
				Pool_SendTableMessage(poolid, COLOR_GREEN, "SINUCA: %s deixou a partida de sinuca.", pNome(playerid));
				return Pool_RemovePlayer(playerid);
			}

			/*// make pressing key fire annoying
			if (RELEASED(KEY_FIRE) && g_poolTableData[poolid][E_AIMER] != playerid && ! p_PoolChalking[playerid]) {
				// reset anims of player
				if (IsPlayerPlayingPool(playerid)) {
					p_PoolChalking[playerid] = true;
					SetPlayerArmedWeapon(playerid, 0);
					SetPlayerAttachedObject(playerid, 0, 338, 6, 0, 0.07, -0.85, 0, 0, 0);
					ApplyAnimation(playerid, "POOL", "POOL_ChalkCue", 3.0, 0, 1, 1, 1, 0, 1);
					SetTimerEx("PlayPoolSound", 1400, false, "dd", playerid, 31807);
					SetTimerEx("RestoreWeapon", 3500, false, "d", playerid);
				} else ClearAnimations(playerid);
				
				// reset ball positions just in-case they hit it
				if (Pool_AreBallsStopped(poolid)) Pool_ResetBallPositions(poolid);
				
				return true;
			}*/

			// begin gameplay stuff
			if (IsPlayerPlayingPool(playerid) && p_PoolID[playerid] == poolid) {
				if (RELEASED(32)) {
					if (g_poolTableData[poolid][E_AIMER] == playerid) {
						p_PoolCameraBirdsEye[playerid] = ! p_PoolCameraBirdsEye[playerid];
						Pool_UpdatePlayerCamera(playerid, poolid);
					}
				}

				if (RELEASED(128)) {
					if (Pool_AreBallsStopped(poolid)) {
						if (g_poolTableData[poolid][E_AIMER] != playerid) {
							if (g_poolTableData[poolid][E_NEXT_SHOOTER] != playerid) return SendErrorMessage(playerid, "Não é a sua vez. Por favor, espere.");
							if (g_poolTableData[poolid][E_CUE_POCKETED]) return SendErrorMessage(playerid, "Você pode apontar o taco assim que colocar a bola branca.");
							

							if (!p_PoolChalking[playerid] && g_poolTableData[poolid][E_AIMER] == -1) {
								new Float:X, Float:Y, Float:Z,
									Float:Xa, Float:Ya, Float:Za,
									Float:x, Float:y;

								GetPlayerPos(playerid, X, Y, Z);

								if (Z > g_poolTableData[poolid][E_Z] + 0.5) return SendErrorMessage(playerid, "Você não pode jogar de cima da mesa.");
								
								new objectid = PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0]);
								GetDynamicObjectPos(objectid, Xa, Ya, Za);

								new
									Float: distance_to_ball = GetDistanceFromPointToPoint(X, Y, Xa, Ya);

								if (distance_to_ball < 2.0 && Z < 999.5) {
									new
										Float: poolrot = atan2(Ya - Y, Xa - X) - 90.0;

									TogglePlayerControllable(playerid, false);

	                            	p_PoolAngle[playerid][0] = poolrot;
	                            	p_PoolAngle[playerid][1] = poolrot;

									SetPlayerArmedWeapon(playerid, WEAPON_FIST);
									Pool_GetXYInFrontOfPos(Xa, Ya, poolrot + 180, x, y, 0.085);
									g_poolTableData[poolid][E_AIMER_OBJECT] = CreateDynamicObject(3004, x, y, Za, 7.0, 0, poolrot + 180, .worldid = g_poolTableData[poolid][E_WORLD]);

									if (distance_to_ball < 1.20) {
										distance_to_ball = 1.20;
									}

					              	Pool_GetXYInFrontOfPos(Xa, Ya, poolrot + 180 - 5.0, X, Y, distance_to_ball); // offset 5 degrees
					                SetPlayerPos(playerid, X, Y, Z);
	                				SetPlayerFacingAngle(playerid, poolrot);

									if (distance_to_ball > 1.5) {
										ApplyAnimation(playerid, "POOL", "POOL_XLong_Start", 4.1, false, true, true, true, 1);
									} else {
										ApplyAnimation(playerid, "POOL", "POOL_Long_Start", 4.1, false, true, true, true, 1);
									}

									g_poolTableData[poolid][E_AIMER] = playerid;
									g_poolTableData[poolid][E_POWER] = 1.0;
									g_poolTableData[poolid][E_DIRECTION] = 0;

									Pool_UpdatePlayerCamera(playerid, poolid);
									Pool_UpdateScoreboard(poolid);

									TextDrawShowForPlayer(playerid, g_PoolTextdraw);
									ShowPlayerProgressBar(playerid, g_PoolPowerBar[playerid]);
								}
							}
						} else {
							TogglePlayerControllable(playerid, true);
							GivePlayerWeapon(playerid, WEAPON_POOLSTICK, 1);

							ClearAnimations(playerid);
	            			SetCameraBehindPlayer(playerid);
							ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, false, true, true, false, 0);

							TextDrawHideForPlayer(playerid, g_PoolTextdraw);
							HidePlayerProgressBar(playerid, g_PoolPowerBar[playerid]);

	            			g_poolTableData[poolid][E_AIMER] = -1;
	            			DestroyDynamicObject(g_poolTableData[poolid][E_AIMER_OBJECT]);
	            			g_poolTableData[poolid][E_AIMER_OBJECT] = -1;
						}
					}
				}

				if (RELEASED(4)) {
					if (g_poolTableData[poolid][E_AIMER] == playerid) {
						new Float: ball_x, Float: ball_y, Float: ball_z;

						g_poolTableData[poolid][E_SHOTS_LEFT] --;

						Pool_UpdateScoreboard(poolid);

						GetDynamicObjectPos(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0]), ball_x, ball_y, ball_z);
						new Float: distance_to_ball = GetPlayerDistanceFromPoint(playerid, ball_x, ball_y, ball_z);

						if (distance_to_ball > 1.5) {
							ApplyAnimation(playerid, "POOL", "POOL_XLong_Shot", 4.1, false, true, true, false, 0);
						} else {
							ApplyAnimation(playerid, "POOL", "POOL_Long_Shot", 4.1, false, true, true, false, 0);
						}

						new Float: speed = 0.4 + (g_poolTableData[poolid][E_POWER] * 2.0) / 100.0;
						PHY_SetHandleVelocity(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0], speed * floatsin(-p_PoolAngle[playerid][0], degrees), speed * floatcos(-p_PoolAngle[playerid][0], degrees));

						SetPlayerCameraPos(playerid, g_poolTableData[poolid][E_X], g_poolTableData[poolid][E_Y], g_poolTableData[poolid][E_Z] + 2.0);
						SetPlayerCameraLookAt(playerid, g_poolTableData[poolid][E_X], g_poolTableData[poolid][E_Y], g_poolTableData[poolid][E_Z]);

						PlayPoolSound(poolid, 31810);
						g_poolTableData[poolid][E_AIMER] = -1;
						DestroyDynamicObject(g_poolTableData[poolid][E_AIMER_OBJECT]);
						g_poolTableData[poolid][E_AIMER_OBJECT] = -1;

						GivePlayerWeapon(playerid, WEAPON_POOLSTICK, 1);
					}
					else ClearAnimations(playerid);
				}
			}
		} else {
			if (PRESSED(16))
			{
				if (IsPlayerPlayingPool(playerid) && Iter_Contains(poolplayers<poolid>, playerid)) {
					HidePlayerHelpDialog(playerid);
					Pool_SendTableMessage(poolid, COLOR_GREEN, "SINUCA: %s deixou a partida de sinuca.", pNome(playerid));
					return Pool_RemovePlayer(playerid);
				}

				new pool_player_count = Iter_Count(poolplayers<poolid>);

				if (pool_player_count >= 2) {
					return SendErrorMessage(playerid, "Essa mesa de sinuca já está cheia.");
				}
// transformar em cmd \/
				// ensure this player isn't already joined
				if (!IsPlayerPlayingPool(playerid) && ! Iter_Contains(poolplayers<poolid>, playerid)) {
					if (pool_player_count == 1 && ! g_poolTableData[poolid][E_READY]) return SendErrorMessage(playerid, "Essa mesa de sinuca não está pronta.");

					// add to table
					Iter_Add(poolplayers< poolid >, playerid);
					// reset variables
					p_isPlayingPool[playerid] = true;
					p_PoolID[playerid] = poolid;

					// start the game if there's two players
					if (pool_player_count + 1 >= 2) {
					    new random_cuer = Iter_Random(poolplayers<poolid>);

						Pool_SendTableMessage(poolid, COLOR_GREEN, "SINUCA: %s se juntou a partida de sinuca (2/2)", pNome(playerid));
					    Pool_QueueNextPlayer(poolid, random_cuer);

					    foreach (new i : poolplayers< poolid >) {
							p_PoolScore[i] = 0;
							PlayerPlaySound(i, 1085, 0.0, 0.0, 0.0);
							GivePlayerWeapon(i, WEAPON_POOLSTICK, 1);
					   }

						g_poolTableData[poolid][E_STARTED] = true;
				    	Pool_UpdateScoreboard(poolid);
						Pool_RespawnBalls(poolid);
					} else {
						g_poolTableData[poolid][E_READY] = false;
                        Dialog_Show(playerid, DIALOG_POOL_WAGER, DIALOG_STYLE_MSGBOX, "{FFFFFF}Partida de Sinuca", "{FFFFFF}Você entrou na partida de sinuca.\nAguarde o próximo jogador entrar para começar.", "Entendi", "");
						ShowPlayerHelpDialog(playerid, 0, "~y~~h~~k~~PED_LOCK_TARGET~ ~w~- Mirar taco~n~~y~~h~~k~~PED_FIREWEAPON~ ~w~- Fazer jogada~n~~y~Y ~w~- Sair do jogo~n~~n~~r~~h~Esperando por mais um jogador...");
						new string[128];
						format(string, sizeof(string), "Mesa de Sinuca\n{FFFFFF}Iniciada por %s", pNome(playerid));
						UpdateDynamic3DTextLabelText(g_poolTableData[poolid][E_LABEL], -1, string);
						Pool_SendTableMessage(poolid, COLOR_GREEN, "SINUCA: %s se juntou a partida de sinuca (1/2)", pNome(playerid));
					}
					return true;
				}
			}
		}
	}
	return true;
}

Pool_RemovePlayer(playerid){ 
	new
		poolid = p_PoolID[playerid];

	// reset player variables
	p_isPlayingPool[playerid] = false;
	p_PoolScore[playerid] = 0;
	p_PoolID[playerid] = -1;
	DestroyDynamicObject(p_PoolHoleGuide[playerid]);
	p_PoolHoleGuide[playerid] = -1;
	RestoreCamera(playerid);
	HidePlayerHelpDialog(playerid);

	// check if the player is even in the table
	if (poolid != -1 && Iter_Contains(poolplayers< poolid >, playerid)) {
		// remove them from the table
		Iter_Remove(poolplayers< poolid >, playerid);

		// forfeit player
		if (g_poolTableData[poolid][E_STARTED]) {
			// ... if there's only 1 guy in the table might as well declare him winner
			if (Iter_Count(poolplayers< poolid >)) {
				new
					replacement_winner = Iter_First(poolplayers< poolid >);

				Pool_OnPlayerWin(replacement_winner);
			}
			return Pool_EndGame(poolid);
		} else {
			// no players and is a ready table, then refund
			if (!Iter_Count(poolplayers< poolid >) && g_poolTableData[poolid][E_READY]) {
				g_poolTableData[poolid][E_READY] = false;
			}
			UpdateDynamic3DTextLabelText(g_poolTableData[poolid][E_LABEL], COLOR_GREY, DEFAULT_POOL_STRING);
		}
	}
	return true;
}

/* ================================ FUNÇÕES ================================ */
CreatePoolTable(Float: X, Float: Y, Float: Z, Float: A = 0.0, skin, interior = 0, world = 0) {
	if (A != 0 && A != 90.0 && A != 180.0 && A != 270.0 && A != 360.0) {
		format(logString, sizeof(logString), "SYSTEM: [POOL ERRO] As mesas de sinuca devem ser posicionadas em 0, 90, 180, 270 ou 360 graus.");
        logCreate(99998, logString, 5);

		return print("POOL ERROR: As mesas de sinuca devem ser posicionadas em 0, 90, 180, 270 e 360 graus."), 1;
	}

	new
		poolid = Iter_Free(pooltables);

	if (poolid != ITER_NONE) {
		new
			Float: x_vertex[4], Float: y_vertex[4];

		Iter_Add(pooltables, poolid);

		g_poolTableData[poolid][E_X] = X;
		g_poolTableData[poolid][E_Y] = Y;
		g_poolTableData[poolid][E_Z] = Z;
		g_poolTableData[poolid][E_ANGLE] = A;

		g_poolTableData[poolid][E_INTERIOR] = interior;
		g_poolTableData[poolid][E_WORLD] = world;

		g_poolTableData[poolid][E_TABLE] = CreateDynamicObject(2964, X, Y, Z - 1.0, 0.0, 0.0, A, .interiorid = interior, .worldid = world, .priority = 9999);
		g_poolTableData[poolid][E_LABEL] = CreateDynamic3DTextLabel(DEFAULT_POOL_STRING, COLOR_GREY, X, Y, Z, 2.0, .interiorid = interior, .worldid = world, .priority = 9999);

		Pool_RotateXY(-0.964, -0.51, A, x_vertex[0], y_vertex[0]);
		Pool_RotateXY(-0.964, 0.533, A, x_vertex[1], y_vertex[1]);
		Pool_RotateXY(0.976, -0.51, A, x_vertex[2], y_vertex[2]);
		Pool_RotateXY(0.976, 0.533, A, x_vertex[3], y_vertex[3]);
		new 
			walls[4];

		walls[0] = PHY_CreateWall(x_vertex[0] + X, y_vertex[0] + Y, x_vertex[1] + X, y_vertex[1] + Y);
		walls[1] = PHY_CreateWall(x_vertex[1] + X, y_vertex[1] + Y, x_vertex[3] + X, y_vertex[3] + Y);
		walls[2] = PHY_CreateWall(x_vertex[2] + X, y_vertex[2] + Y, x_vertex[3] + X, y_vertex[3] + Y);
		walls[3] = PHY_CreateWall(x_vertex[0] + X, y_vertex[0] + Y, x_vertex[2] + X, y_vertex[2] + Y);

		// set wall worlds
		for (new i = 0; i < sizeof(walls); i ++) {
			PHY_SetWallWorld(walls[i], world);
		}

		// create boundary for replacing the cueball
		new Float: vertices[4];

		Pool_RotateXY(0.94, 0.48, g_poolTableData[poolid][E_ANGLE], vertices[0], vertices[1]);
		Pool_RotateXY(-0.94, -0.48, g_poolTableData[poolid][E_ANGLE], vertices[2], vertices[3]);

		vertices[0] += g_poolTableData[poolid][E_X], vertices[2] += g_poolTableData[poolid][E_X];
		vertices[1] += g_poolTableData[poolid][E_Y], vertices[3] += g_poolTableData[poolid][E_Y];

		g_poolTableData[poolid][E_CUEBALL_AREA] = CreateDynamicRectangle(vertices[2], vertices[3], vertices[0], vertices[1], .interiorid = interior, .worldid = world);

		// skins
		if (skin == 2) {
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 1, 8401, "vgshpground", "dirtywhite", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 2, 11631, "mp_ranchcut", "mpCJ_WOOD_DARK", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 3, 11631, "mp_ranchcut", "mpCJ_WOOD_DARK", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 4, 11631, "mp_ranchcut", "mpCJ_WOOD_DARK", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 0, 10375, "subshops_sfs", "ws_white_wall1", -10072402);
		} else if (skin == 3) {
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 0, 1273, "icons3", "greengrad32", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 1, 8401, "vgshpground", "dirtywhite", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 2, 11631, "mp_ranchcut", "mpCJ_WOOD_DARK", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 3, 11631, "mp_ranchcut", "mpCJ_WOOD_DARK", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 4, 11631, "mp_ranchcut", "mpCJ_WOOD_DARK", 0);
		} else if (skin == 4) {
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 0, 1273, "icons3", "greengrad32", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 1, 946, "bskball_standext", "drkbrownmetal", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 2, 8463, "vgseland", "tiadbuddhagold", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 3, 8463, "vgseland", "tiadbuddhagold", 0);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 4, 8463, "vgseland", "tiadbuddhagold", 0);
		} else if (skin == 5) {
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 4, 11100, "bendytunnel_sfse", "blackmetal", -16);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 3, 11100, "bendytunnel_sfse", "blackmetal", -16);
		} else if (skin == 6) {
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 0, 10375, "subshops_sfs", "ws_white_wall1", -11731124);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 3, 16150, "ufo_bar", "sa_wood07_128", -16);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 4, 16150, "ufo_bar", "sa_wood07_128", -16);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 1, 9362, "sfn_byofficeint", "CJ_Black_metal", -16);
			SetDynamicObjectMaterial(g_poolTableData[poolid][E_TABLE], 2, 8463, "vgseland", "tiadbuddhagold", -16);
		}

		// reset pool handles
		for (new i = 0; i < sizeof(g_poolBallOffsetData); i ++) {
			g_poolBallData[poolid][E_BALL_PHY_HANDLE][i] = ITER_NONE;
		}
	}
	return poolid;
}

DeleteSnooker(poolid) {
    if(poolid != -1){
        new Cache:result;
        mysql_format(DBConn, query, sizeof query, "DELETE FROM `pool_tables` WHERE `ID` = '%d';", 	g_poolTableData[poolid][E_ID]);
        result = mysql_query(DBConn, query);

		Pool_EndGame(poolid);

		g_poolTableData[poolid][E_ID] = -1;
		g_poolTableData[poolid][E_EXISTS] = false;

		if (IsValidDynamicObject(g_poolTableData[poolid][E_TABLE]))
			DestroyDynamicObject(g_poolTableData[poolid][E_TABLE]);

		if (IsValidDynamic3DTextLabel(g_poolTableData[poolid][E_LABEL]))
			DestroyDynamic3DTextLabel(g_poolTableData[poolid][E_LABEL]);

		if (IsValidDynamicObject(g_poolTableData[poolid][E_AIMER_OBJECT]))
			DestroyDynamicObject(g_poolTableData[poolid][E_AIMER_OBJECT]);

		for (new i = 0; i < sizeof(g_poolBallOffsetData); i ++) {
			if (PHY_IsHandleValid(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i])) {
				PHY_DeleteHandle(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i]);
				DestroyDynamicObject(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i]));
				g_poolBallData[poolid][E_BALL_PHY_HANDLE][i] = ITER_NONE;
			}
		}

		cache_delete(result);
    }
    return true;
}

Pool_GetClosestTable(playerid, &Float: dis = 35.00) {
	new pooltable = -1;
	new player_world = GetPlayerVirtualWorld(playerid);

	foreach (new i : pooltables) if (g_poolTableData[i][E_WORLD] == player_world) {
    	new
    		Float: dis2 = GetPlayerDistanceFromPoint(playerid, g_poolTableData[i][E_X], g_poolTableData[i][E_Y], g_poolTableData[i][E_Z]);

    	if (dis2 < dis && dis2 != -1.00) {
    	    dis = dis2;
    	    pooltable = i;
		}
	}
	return pooltable;
}

Pool_RespawnBalls(poolid) {
	if (g_poolTableData[poolid][E_AIMER] != -1)
	{
		TogglePlayerControllable(g_poolTableData[poolid][E_AIMER], true);
		//ClearAnimations(g_poolTableData[poolid][E_AIMER]);

		//ApplyAnimation(g_poolTableData[poolid][E_AIMER], "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
        SetCameraBehindPlayer(g_poolTableData[poolid][E_AIMER]);
        DestroyDynamicObject(g_poolTableData[poolid][E_AIMER_OBJECT]);
        g_poolTableData[poolid][E_AIMER_OBJECT] = -1;

        //TextDrawHideForPlayer(g_poolTableData[poolid][E_AIMER], gPoolTD);
        //HidePlayerProgressBar(g_poolTableData[poolid][E_AIMER], g_PoolPowerBar[g_poolTableData[poolid][E_AIMER]]);
		g_poolTableData[poolid][E_AIMER] = -1;
	}

	new
		Float: offset_x,
		Float: offset_y;

	for (new i = 0; i < sizeof(g_poolBallOffsetData); i ++)
	{
		// get offset according to angle of table
		Pool_RotateXY(g_poolBallOffsetData[i][E_OFFSET_X], g_poolBallOffsetData[i][E_OFFSET_Y], g_poolTableData[poolid][E_ANGLE], offset_x, offset_y);

		// reset balls
		if (PHY_IsHandleValid(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i])) {
			PHY_DeleteHandle(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i]);
			DestroyDynamicObject(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i]));
			g_poolBallData[poolid][E_BALL_PHY_HANDLE][i] = ITER_NONE;
		}

		// create pool balls on table
		new objectid = CreateDynamicObject(
			g_poolBallOffsetData[i][E_MODEL_ID],
			g_poolTableData[poolid][E_X] + offset_x,
			g_poolTableData[poolid][E_Y] + offset_y,
			g_poolTableData[poolid][E_Z] - 0.045,
			0.0, 0.0, 0.0,
			.worldid = g_poolTableData[poolid][E_WORLD],
			.priority = 999
		);

		// initialize physics on each ball
		Pool_InitBalls(poolid, objectid, i);
	}

	KillTimer(g_poolTableData[poolid][E_TIMER]);
	g_poolTableData[poolid][E_TIMER] = SetTimerEx("OnPoolUpdate", POOL_TIMER_SPEED, true, "d", poolid);
	g_poolTableData[poolid][E_BALLS_SCORED] = 0;
}

Pool_InitBalls(poolid, objectid, ballid) {
	new handleid = PHY_InitObject(objectid, 3003, _, _, PHY_MODE_2D);

	PHY_SetHandleWorld(handleid, g_poolTableData[poolid][E_WORLD]);
	PHY_SetHandleFriction(handleid, 0.08); // 0.10
	PHY_SetHandleAirResistance(handleid, 0.2);
	PHY_RollObject(handleid);

	g_poolBallData[poolid][E_BALL_PHY_HANDLE][ballid] = handleid;
	g_poolBallData[poolid][E_POCKETED][ballid] = false;
}

Pool_RotateXY(Float: xi, Float: yi, Float: angle, &Float: xf, &Float: yf) {
    xf = xi * floatcos(angle, degrees) - yi * floatsin(angle, degrees);
    yf = xi * floatsin(angle, degrees) + yi * floatcos(angle, degrees);
    return true;
}

Pool_AreBallsStopped(poolid) {
	new
		balls_not_moving = 0;

	for (new i = 0; i < 16; i ++)
	{
		new
			ball_handle = g_poolBallData[poolid][E_BALL_PHY_HANDLE][i];

		if (!PHY_IsHandleValid(ball_handle) || g_poolBallData[poolid][E_POCKETED][i] || ! PHY_IsHandleMoving(ball_handle)) {
			balls_not_moving ++;
		}
	}
	return balls_not_moving >= 16;
}

Pool_GetXYInFrontOfPos(Float: xx, Float: yy, Float: a, &Float: x2, &Float: y2, Float: distance) {
    x2 = xx + (distance * floatsin(-a, degrees));
    y2 = yy + (distance * floatcos(-a, degrees));
}

Pool_IsBallInHole(poolid, objectid) {
	new
		Float: hole_x, Float: hole_y;

	for (new i = 0; i < sizeof(g_poolPotOffsetData); i ++)
	{
		// rotate offsets according to table
		Pool_RotateXY(g_poolPotOffsetData[i][0], g_poolPotOffsetData[i][1], g_poolTableData[poolid][E_ANGLE], hole_x, hole_y);

		// check if it is at the pocket
		if (Pool_IsObjectAtPos(objectid, g_poolTableData[poolid][E_X] + hole_x , g_poolTableData[poolid][E_Y] + hole_y, g_poolTableData[poolid][E_Z], POCKET_RADIUS)) {
			return i;
		}
	}
    return -1;
}

Pool_UpdateScoreboard(poolid, close = 0) {
	new first_player = Iter_First(poolplayers< poolid >);
	new second_player = Iter_Last(poolplayers< poolid >);

	foreach (new playerid : poolplayers< poolid >)
	{
		new
			is_playing = playerid == first_player ? first_player : (playerid == second_player ? second_player : -1);

		if (g_poolTableData[poolid][E_BALLS_SCORED] && is_playing != -1) {
			format(szBigString, sizeof(szBigString), "Suas_bolas_são_%s.~n~", g_poolTableData[poolid][E_PLAYER_BALL_TYPE][is_playing] == E_STRIPED ? ("listradas") : ("lisas"));
			AdjustTextDrawString(szBigString);
		} else {
			szBigString = "";
		}

		format(szBigString, sizeof(szBigString),
			"%sVez de %s.~n~~n~~r~~h~~h~%s Pontos:~w~ %d~n~~b~~h~~h~%s Pontos:~w~ %d",
			szBigString, pNome(g_poolTableData[poolid][E_NEXT_SHOOTER]),
			pNome(first_player), p_PoolScore[first_player],
			pNome(second_player), p_PoolScore[second_player]
		);
		ShowPlayerHelpDialog(playerid, close, szBigString);
	}

	UpdateDynamic3DTextLabelText(g_poolTableData[poolid][E_LABEL], -1, "");
}

Pool_EndGame(poolid) {
	// hide scoreboard in 5 seconds
    //HidePlayerHelpDialog(playerid);
	Pool_UpdateScoreboard(poolid);

	// unset pool variables
	foreach (new i : poolplayers< poolid >) {
		DestroyDynamicObject(p_PoolHoleGuide[i]);
		p_PoolHoleGuide[i] = -1;
		p_isPlayingPool{i} = false;
		p_PoolScore[i] = -1;
		p_PoolID[i] = -1;
		RestoreCamera(i);
	}

	Iter_Clear(poolplayers< poolid >);

	g_poolTableData[poolid][E_STARTED] = false;
	g_poolTableData[poolid][E_AIMER] = -1;
	g_poolTableData[poolid][E_SHOTS_LEFT] = 0;
	g_poolTableData[poolid][E_FOULS] = 0;
	g_poolTableData[poolid][E_EXTRA_SHOT] = false;
	g_poolTableData[poolid][E_READY] = false;
	g_poolTableData[poolid][E_CUE_POCKETED] = false;

	KillTimer(g_poolTableData[poolid][E_TIMER]);
    DestroyDynamicObject(g_poolTableData[poolid][E_AIMER_OBJECT]);
    g_poolTableData[poolid][E_AIMER_OBJECT] = -1;

	for (new i = 0; i < 16; i ++) if (PHY_IsHandleValid(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i])) {
		PHY_DeleteHandle(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i]);
		DestroyDynamicObject(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i]));
		g_poolBallData[poolid][E_BALL_PHY_HANDLE][i] = ITER_NONE;
	}

	UpdateDynamic3DTextLabelText(g_poolTableData[poolid][E_LABEL], COLOR_GREY, DEFAULT_POOL_STRING);
	return true;
}

AngleInRangeOfAngle(Float:a1, Float:a2, Float:range) {
	a1 -= a2;
	return (a1 < range) && (a1 > -range);
}

Pool_IsObjectAtPos(objectid, Float: x, Float: y, Float: z, Float: radius) {
    new
    	Float: object_x, Float: object_y, Float: object_z;

    GetDynamicObjectPos(objectid, object_x, object_y, object_z);

    new
    	Float: distance = GetDistanceBetweenPoints(object_x, object_y, object_z, x, y, z);

    return distance < radius;
}

public PlayPoolSound(poolid, soundid) {
	foreach (new playerid : poolplayers< poolid >) {
		PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);
	}
	return true;
}

public OnPoolUpdate(poolid) {
	if (!g_poolTableData[poolid][E_STARTED]) return true;
	

	if (!Iter_Count(poolplayers<poolid>)) {
		Pool_EndGame(poolid);
		return true;
	}

	new Float: Xa, Float: Ya, Float: Za;
	new Float: X, Float: Y, Float: Z;
	new KEY:keys, KEY:ud, KEY:lr;

	if (g_poolTableData[poolid][E_CUE_POCKETED]) {
		new playerid = g_poolTableData[poolid][E_NEXT_SHOOTER];
		new cueball_handle = g_poolBallData[poolid][E_BALL_PHY_HANDLE][0];

		if (PHY_IsHandleValid(cueball_handle)) {
			new cueball_object = PHY_GetHandleObject(cueball_handle);

			GetPlayerKeys(playerid, keys, ud, lr);
			GetDynamicObjectPos(cueball_object, X, Y, Z);

			if (ud == KEY_UP) Y += 0.01;
			else if (ud == KEY_DOWN) Y -= 0.01;

			if (lr == KEY_LEFT) X -= 0.01;
			else if (lr == KEY_RIGHT) X += 0.01;

			// set position only if it is within boundaries
			if (IsPointInDynamicArea(g_poolTableData[poolid][E_CUEBALL_AREA], X, Y, 0.0)) {
				SetDynamicObjectPos(cueball_object, X, Y, Z);
			}

			// click to set
			if (keys & KEY_FIRE)
			{
				// check if we are placing the pool ball near another pool ball
				for (new i = 1; i < MAX_POOL_BALLS; i ++) if (PHY_IsHandleValid(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i])) {
					GetDynamicObjectPos(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i]), Xa, Ya, Za);
					if (GetDistanceFromPointToPoint(X, Y, Xa, Ya) < 0.085) {
						return GameTextForPlayer(playerid, "~n~~n~~n~~r~~h~Bola muito perto de outra!", 500, 3);
					}
				}

				// check if ball is close to hole
				new
					Float: hole_x, Float: hole_y;

				for (new i = 0; i < sizeof(g_poolPotOffsetData); i ++)
				{
					// rotate offsets according to table
					Pool_RotateXY(g_poolPotOffsetData[i][0], g_poolPotOffsetData[i][1], g_poolTableData[poolid][E_ANGLE], hole_x, hole_y);

					// check if it is at the pocket
					if (Pool_IsObjectAtPos(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0]), g_poolTableData[poolid][E_X] + hole_x , g_poolTableData[poolid][E_Y] + hole_y, g_poolTableData[poolid][E_Z], POCKET_RADIUS)) {
						return GameTextForPlayer(playerid, "~n~~n~~n~~r~~h~Bola muito perto do buraco!", 500, 3);
					}
				}

				// reset state
				SetCameraBehindPlayer(playerid);
				TogglePlayerControllable(playerid, true);
				g_poolTableData[poolid][E_CUE_POCKETED] = false;
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, false, true, true, false, 0);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s colocou a bola branca no lugar.", pNome(playerid));
			}
		}
	}
	else if (g_poolTableData[poolid][E_AIMER] != -1)
	{
		new
			playerid = g_poolTableData[poolid][E_AIMER];

		GetPlayerKeys(playerid, keys, ud, lr);

		if (!(keys & KEY_FIRE))
		{
			if (lr)
			{
				new Float: x, Float: y, Float: newrot, Float: dist;

				GetPlayerPos(playerid, X, Y ,Z);
				GetDynamicObjectPos(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0]), Xa, Ya, Za);
				newrot = p_PoolAngle[playerid][0] + (lr > KEY:0 ? 0.9 : -0.9);
				dist = GetDistanceBetweenPoints(X, Y, 0.0, Xa, Ya, 0.0);

				// keep the head out of the point of view
				if (dist < 1.20) {
					dist = 1.20;
				}

				if (AngleInRangeOfAngle(p_PoolAngle[playerid][1], newrot, 30.0))
	            {
	                p_PoolAngle[playerid][0] = newrot;
	                Pool_UpdatePlayerCamera(playerid, poolid);

	                Pool_GetXYInFrontOfPos(Xa, Ya, newrot + 180, x, y, 0.085);
	                SetDynamicObjectPos(g_poolTableData[poolid][E_AIMER_OBJECT], x, y, Za);
	              	SetDynamicObjectRot(g_poolTableData[poolid][E_AIMER_OBJECT], 7.0, 0, p_PoolAngle[playerid][0] + 180);
	              	Pool_GetXYInFrontOfPos(Xa, Ya, newrot + 180 - 5.0, x, y, dist); // offset 5 degrees
	                SetPlayerPos(playerid, x, y, Z);
	                SetPlayerFacingAngle(playerid, newrot);
	           }
			}
		}
		else
		{
		    if (g_poolTableData[poolid][E_DIRECTION]) {
		        g_poolTableData[poolid][E_POWER] -= 2.0;
		   	} else {
			    g_poolTableData[poolid][E_POWER] += 2.0;
			}

			if (g_poolTableData[poolid][E_POWER] <= 0) {
			    g_poolTableData[poolid][E_DIRECTION] = 0;
			    g_poolTableData[poolid][E_POWER] = 2.0;
			}
			else if (g_poolTableData[poolid][E_POWER] > 100.0) {
			    g_poolTableData[poolid][E_DIRECTION] = 1;
			    g_poolTableData[poolid][E_POWER] = 99.0;
			}

			SetPlayerProgressBarMaxValue(playerid, g_PoolPowerBar[playerid], 67.0);
			SetPlayerProgressBarValue(playerid, g_PoolPowerBar[playerid], ((67.0 * g_poolTableData[poolid][E_POWER]) / 100.0));
			ShowPlayerProgressBar(playerid, g_PoolPowerBar[playerid]);
			TextDrawShowForPlayer(playerid, g_PoolTextdraw);
		}
	}

	new
		current_player = g_poolTableData[poolid][E_NEXT_SHOOTER];

	if ((!g_poolTableData[poolid][E_SHOTS_LEFT] || g_poolTableData[poolid][E_FOULS] || g_poolTableData[poolid][E_EXTRA_SHOT]) && Pool_AreBallsStopped(poolid)) {
		Pool_QueueNextPlayer(poolid, current_player);
		SetTimerEx("RestoreCamera", 800, false, "d", current_player);
	}
	return true;
}

public RestoreCamera(playerid) {
	TextDrawHideForPlayer(playerid, g_PoolTextdraw);
	HidePlayerProgressBar(playerid, g_PoolPowerBar[playerid]);
	TogglePlayerControllable(playerid, true);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, false, true, true, false, 0);
	return SetCameraBehindPlayer(playerid);
}

public deleteBall(poolid, ballid) {
	if (g_poolBallData[poolid][E_POCKETED][ballid] && PHY_IsHandleValid(g_poolBallData[poolid][E_BALL_PHY_HANDLE][ballid]))
	{
		PHY_DeleteHandle(g_poolBallData[poolid][E_BALL_PHY_HANDLE][ballid]);
		DestroyDynamicObject(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][ballid]));
		g_poolBallData[poolid][E_BALL_PHY_HANDLE][ballid] = ITER_NONE;
	}
	return true;
}

public RestoreWeapon(playerid) {
	RemovePlayerAttachedObject(playerid, 0);
	p_PoolChalking[playerid] = false;
	GivePlayerWeapon(playerid, WEAPON_POOLSTICK, 1);
	ClearAnimations(playerid);
	return true;
}

GetPoolBallIndexFromModel(modelid) {
	for (new i = 0; i < sizeof(g_poolBallOffsetData); i ++) if (g_poolBallOffsetData[i][E_MODEL_ID] == modelid) {
		return i;
	}
	return -1;
}

LoadPools() {
	new Float:X, Float:Y, Float:Z, Float:A, skin, interior, world;
	mysql_query(DBConn, "SELECT * FROM `pool_tables`;");
	for (new i = 0; i < cache_num_rows(); i ++) {
		if (!g_poolTableData[i][E_EXISTS]) {
			g_poolTableData[i][E_EXISTS] = true;
			cache_get_value_name_int(i, "ID", g_poolTableData[i][E_ID]);

			cache_get_value_name_float(i, "positionX", X);
			cache_get_value_name_float(i, "positionY", Y);
			cache_get_value_name_float(i, "positionZ", Z);
			cache_get_value_name_float(i, "positionA", A);

			cache_get_value_name_int(i, "virtual_world", world);
			cache_get_value_name_int(i, "interior", interior);

			cache_get_value_name_int(i, "skin", skin);

			CreatePoolTable(X, Y, Z, A, skin, interior, world);
  		}
	}
	return true;
}

/* ================================ PHYSICS CALLBACKS ================================ */
public PHY_OnObjectCollideWithObject(handleid_a, handleid_b) {
	foreach (new poolid : pooltables) if (g_poolTableData[poolid][E_STARTED])
	{
		for (new i = 0; i < 16; i ++)
		{
			new
				table_ball_handle = g_poolBallData[poolid][E_BALL_PHY_HANDLE][i];

			if (PHY_IsHandleValid(table_ball_handle) && PHY_GetHandleObject(handleid_a) == PHY_GetHandleObject(table_ball_handle))
			{
		        PlayPoolSound(poolid, 31800 + random(3));
		        return true;
			}
		}
	}
	return true;
}

public PHY_OnObjectCollideWithWall(handleid, wallid) {
	foreach (new poolid : pooltables) if (g_poolTableData[poolid][E_STARTED])
	{
		for (new i = 0; i < 16; i ++)
		{
			new
				table_ball_handle = g_poolBallData[poolid][E_BALL_PHY_HANDLE][i];

			if (PHY_IsHandleValid(table_ball_handle) && PHY_GetHandleObject(handleid) == PHY_GetHandleObject(table_ball_handle))
			{
		        PlayPoolSound(poolid, 31808);
		        return true;
			}
		}
	}
	return true;
}

public PHY_OnObjectUpdate(handleid) {
	new objectid = PHY_GetHandleObject(handleid);

	if (!IsValidDynamicObject(objectid)) {
		return true;
	}

	new poolball_index = GetPoolBallIndexFromModel(Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_MODEL_ID));

	if (poolball_index == -1) {
		return true;
	}

	foreach (new poolid : pooltables) if (g_poolTableData[poolid][E_STARTED])
	{
		new poolball_handle = g_poolBallData[poolid][E_BALL_PHY_HANDLE][poolball_index];

		if (!PHY_IsHandleValid(poolball_handle)) {
			return true;
		}

		if (objectid == PHY_GetHandleObject(poolball_handle) && ! g_poolBallData[poolid][E_POCKETED][poolball_index] && PHY_IsHandleMoving(g_poolBallData[poolid][E_BALL_PHY_HANDLE][poolball_index]))
		{
			new
				holeid = Pool_IsBallInHole(poolid, objectid);

			if (holeid != -1)
			{
				new first_player = Iter_First(poolplayers< poolid >);
				new second_player = Iter_Last(poolplayers< poolid >);
				new current_player = g_poolTableData[poolid][E_NEXT_SHOOTER];
				new opposite_player = current_player != first_player ? first_player : second_player;

				// printf ("first_player %d, second_player %d, current_player = %d", first_player, second_player, current_player);

				// check if first ball was pocketed to figure winner
				if (g_poolBallOffsetData[poolball_index][E_BALL_TYPE] == E_STRIPED || g_poolBallOffsetData[poolball_index][E_BALL_TYPE] == E_SOLID)
				{
					if (++ g_poolTableData[poolid][E_BALLS_SCORED] == 1)
					{
						// assign first player a type after first one is hit
						g_poolTableData[poolid][E_PLAYER_BALL_TYPE][current_player] = g_poolBallOffsetData[poolball_index][E_BALL_TYPE];

						// assign second player
						if (current_player == first_player) {
							g_poolTableData[poolid][E_PLAYER_BALL_TYPE][second_player] = g_poolTableData[poolid][E_PLAYER_BALL_TYPE][first_player] == E_STRIPED ? E_SOLID : E_STRIPED;
						} else if (current_player == second_player) {
							g_poolTableData[poolid][E_PLAYER_BALL_TYPE][first_player] = g_poolTableData[poolid][E_PLAYER_BALL_TYPE][second_player] == E_STRIPED ? E_SOLID : E_STRIPED;
						}

						SendNearbyMessage(first_player, 30.0, COLOR_PURPLE, "* %s está jogando com as bolas %s.", pNome(first_player), g_poolTableData[poolid][E_PLAYER_BALL_TYPE][first_player] == E_STRIPED ? ("listradas") : ("lisas"));
						SendNearbyMessage(second_player, 30.0, COLOR_PURPLE, "* %s está jogando com as bolas %s.", pNome(second_player), g_poolTableData[poolid][E_PLAYER_BALL_TYPE][second_player] == E_STRIPED ? ("listradas") : ("lisas"));
	    			}
				}

				new Float: hole_x, Float: hole_y;

				// check what was pocketed
				if (g_poolBallOffsetData[poolball_index][E_BALL_TYPE] == E_CUE)
				{
	    			GameTextForPlayer(current_player, "~n~~n~~n~~r~bola errada!", 3000, 3);
					SendNearbyMessage(current_player, 30.0, COLOR_PURPLE, "* %s encaçapou a bola branca e %s vai definir a posição dela.", pNome(current_player), pNome(opposite_player));

					// penalty for that
					g_poolTableData[poolid][E_FOULS] ++;
					g_poolTableData[poolid][E_SHOTS_LEFT] = 0;
					g_poolTableData[poolid][E_EXTRA_SHOT] = false;
					g_poolTableData[poolid][E_CUE_POCKETED] = true;
				}
				else if (g_poolBallOffsetData[poolball_index][E_BALL_TYPE] == E_8BALL)
				{
					g_poolTableData[poolid][E_BALLS_SCORED] ++;

					// restore player camera
					RestoreCamera(current_player);

					// check if valid shot
					if (p_PoolScore[current_player] < 7) {
						p_PoolScore[opposite_player] ++;

						SendNearbyMessage(current_player, 30.0, COLOR_PURPLE, "* %s encaçapou a bola oito acidentalmente e %s ganhou a rodada.", pNome(current_player), pNome(opposite_player));
						Pool_OnPlayerWin(opposite_player);
					} else if (g_poolTableData[poolid][E_PLAYER_8BALL_TARGET][current_player] != holeid) {
						p_PoolScore[opposite_player] ++;

						SendNearbyMessage(current_player, 30.0, COLOR_PURPLE, "* %s encaçapou a bola oito no lugar errado e %s ganhou a rodada.", pNome(current_player), pNome(opposite_player));
						Pool_OnPlayerWin(opposite_player);
					} else {
						p_PoolScore[current_player] ++;
						Pool_OnPlayerWin(current_player);
					}
					Pool_RemovePlayer(current_player);
					Pool_RemovePlayer(opposite_player);
					return Pool_EndGame(poolid);
				}
				else
				{
					// check if player pocketed their own ball type or btfo
					if (g_poolTableData[poolid][E_BALLS_SCORED] > 1 && g_poolTableData[poolid][E_PLAYER_BALL_TYPE][current_player] != g_poolBallOffsetData[poolball_index][E_BALL_TYPE])
					{
	    				p_PoolScore[opposite_player] += 1;
	    				GameTextForPlayer(current_player, "~n~~n~~n~~r~bola errada!", 3000, 3);
						SendNearbyMessage(current_player, 30.0, COLOR_PURPLE, "* %s encaçapou a bola %s %s, invés de %s.", pNome(current_player),g_poolBallOffsetData[poolball_index][E_BALL_TYPE] == E_STRIPED ? ("listrada") : ("lisa"), g_poolBallOffsetData[poolball_index][E_BALL_NAME], g_poolTableData[poolid][E_PLAYER_BALL_TYPE][current_player] == E_STRIPED ? ("listrada") : ("lisa"));

						// penalty for that
						g_poolTableData[poolid][E_FOULS] ++;
						g_poolTableData[poolid][E_SHOTS_LEFT] = 0;
						g_poolTableData[poolid][E_EXTRA_SHOT] = false;
					} else {
	    				p_PoolScore[current_player] ++;
	    				GameTextForPlayer(current_player, "~n~~n~~n~~g~+1 ponto", 3000, 3);

						SendNearbyMessage(current_player, 30.0, COLOR_PURPLE, "* %s encaçapou uma bola %s %s.", pNome(current_player), g_poolBallOffsetData[poolball_index][E_BALL_TYPE] == E_STRIPED ? ("listrada") : ("lisa"), g_poolBallOffsetData[poolball_index][E_BALL_NAME]);

						// extra shot for scoring one's own
						g_poolTableData[poolid][E_SHOTS_LEFT] = g_poolTableData[poolid][E_FOULS] > 0 ? 0 : 1;
						g_poolTableData[poolid][E_EXTRA_SHOT] = true;
					}

					// mark final target hole
					if ((p_PoolScore[first_player] == 7 && p_PoolHoleGuide[first_player] == -1) || (p_PoolScore[second_player] == 7 && p_PoolHoleGuide[second_player] == -1)) {
						foreach (new player_being_marked : poolplayers< poolid >) if (p_PoolScore[player_being_marked] == 7 && p_PoolHoleGuide[player_being_marked] == -1) {
							new opposite_holeid = g_poolHoleOpposite[holeid];

							Pool_RotateXY(g_poolPotOffsetData[opposite_holeid][0], g_poolPotOffsetData[opposite_holeid][1], g_poolTableData[poolid][E_ANGLE], hole_x, hole_y);
							p_PoolHoleGuide[player_being_marked] = CreateDynamicObject(18643, g_poolTableData[poolid][E_X] + hole_x, g_poolTableData[poolid][E_Y] + hole_y, g_poolTableData[poolid][E_Z] - 0.5, 0.0, -90.0, 0.0, .playerid = player_being_marked);
							g_poolTableData[poolid][E_PLAYER_8BALL_TARGET][player_being_marked] = opposite_holeid;
							SendPoolMessage(player_being_marked, "Agora você deve encaçapar a bola oito no lugar designado.");
							Streamer_Update(player_being_marked);
						}
					}
				}

				// rotate hole offsets according to table
				Pool_RotateXY(g_poolPotOffsetData[holeid][0], g_poolPotOffsetData[holeid][1], g_poolTableData[poolid][E_ANGLE], hole_x, hole_y);

				// move object into the pocket
				new move_speed = MoveDynamicObject(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][poolball_index]), g_poolTableData[poolid][E_X] + hole_x, g_poolTableData[poolid][E_Y] + hole_y, g_poolTableData[poolid][E_Z] - 0.5, 1.0);

				// mark ball as pocketed
				g_poolBallData[poolid][E_POCKETED][poolball_index] = true;

				// delete it anyway
				SetTimerEx("deleteBall", move_speed + 100, false, "dd", poolid, poolball_index);

				// update scoreboard
				Pool_UpdateScoreboard(poolid);
				PlayerPlaySound(current_player, 31803, 0.0, 0.0, 0.0);
			}
			return true;
		}
	}
	return true;
}

Pool_OnPlayerWin(winning_player) {
	if (!IsPlayerConnected(winning_player) && !IsPlayerNPC(winning_player))
		return false;

	// restore camera
	RestoreCamera(winning_player);
	// winning player
	SendNearbyMessage(winning_player, 30.0, COLOR_PURPLE, "* %s ganhou a partida de sinuca.", pNome(winning_player));
	format(logString, sizeof(logString), "%s (%s) ganhou uma partida de sinuca.", pNome(winning_player), GetPlayerUserEx(winning_player));
	logCreate(winning_player, logString, 12);
	return true;
}

Pool_QueueNextPlayer(poolid, current_player) {
	if (g_poolTableData[poolid][E_SHOTS_LEFT] && g_poolTableData[poolid][E_FOULS] < 1) {
		g_poolTableData[poolid][E_EXTRA_SHOT] = false;
		Pool_SendTableMessage(poolid, COLOR_GREEN, "SINUCA: %s tem uma tacada extra.", pNome(current_player));
	}
	else
	{
		new first_player = Iter_First(poolplayers< poolid >);
		new second_player = Iter_Last(poolplayers< poolid >);

		g_poolTableData[poolid][E_FOULS] = 0;
		g_poolTableData[poolid][E_SHOTS_LEFT] = 1;
		g_poolTableData[poolid][E_EXTRA_SHOT] = false;
	    g_poolTableData[poolid][E_NEXT_SHOOTER] = current_player == first_player ? second_player : first_player;

		// reset ball positions just incase
		Pool_SendTableMessage(poolid, COLOR_GREEN, "SINUCA: É a vez de %s.", pNome(g_poolTableData[poolid][E_NEXT_SHOOTER]));
	}

	// respawn the cue ball if it has been pocketed
	Pool_RespawnCueBall(poolid);

	// update turn
	Pool_UpdateScoreboard(poolid);
	Pool_ResetBallPositions(poolid);
}

Pool_SendTableMessage(poolid, colour, const format[], va_args<>) {
    static
		out[144];

    va_format(out, sizeof(out), format, va_start<3>);

	foreach (new i : poolplayers< poolid >) {
		SendClientMessage(i, colour, out);
	}
	return true;
}

Pool_RespawnCueBall(poolid) {
    if (g_poolBallData[poolid][E_POCKETED][0]) {
		new
			Float: x, Float: y;

		Pool_RotateXY(0.5, 0.0, g_poolTableData[poolid][E_ANGLE], x, y);

		// make sure object dont exist
		if (PHY_IsHandleValid(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0])) {
			PHY_DeleteHandle(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0]);
	        DestroyDynamicObject(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0]));
		}

        // recreate cueball
		new cueball_object = CreateDynamicObject(3003, g_poolTableData[poolid][E_X] + x, g_poolTableData[poolid][E_Y] + y, g_poolTableData[poolid][E_Z] - 0.045, 0.0, 0.0, 0.0, .worldid = g_poolTableData[poolid][E_WORLD], .priority = 999);
        Pool_InitBalls(poolid, cueball_object, 0);

		// set next player camera
		new next_shooter = g_poolTableData[poolid][E_NEXT_SHOOTER];
		SetPlayerCameraPos(next_shooter, g_poolTableData[poolid][E_X], g_poolTableData[poolid][E_Y], g_poolTableData[poolid][E_Z] + 2.0);
		SetPlayerCameraLookAt(next_shooter, g_poolTableData[poolid][E_X], g_poolTableData[poolid][E_Y], g_poolTableData[poolid][E_Z]);
		ApplyAnimation(next_shooter, "POOL", "POOL_Idle_Stance", 3.0, false, true, true, false, 0);
		TogglePlayerControllable(next_shooter, false);
	}
}

Pool_ResetBallPositions(poolid, begining_ball = 0, last_ball = MAX_POOL_BALLS) {
	static Float: last_x, Float: last_y, Float: last_z;
	static Float: last_rx, Float: last_ry, Float: last_rz;

	for (new i = begining_ball; i < last_ball; i ++) if (!g_poolBallData[poolid][E_POCKETED][i])
	{
		new
			ball_handle = g_poolBallData[poolid][E_BALL_PHY_HANDLE][i];

		if (!PHY_IsHandleValid(ball_handle))
			continue;

		new
			ball_object = PHY_GetHandleObject(ball_handle);

		if (!IsValidDynamicObject(ball_object))
			continue;

		new
			modelid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, ball_object, E_STREAMER_MODEL_ID);  //FIX

		// get current position
		GetDynamicObjectPos(ball_object, last_x, last_y, last_z);
		GetDynamicObjectRot(ball_object, last_rx, last_ry, last_rz);

		// destroy object
		if (PHY_IsHandleValid(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i])) {
			PHY_DeleteHandle(g_poolBallData[poolid][E_BALL_PHY_HANDLE][i]);
			DestroyDynamicObject(ball_object);
		}

		// create pool balls on table
		new object = CreateDynamicObject(modelid, last_x, last_y, last_z, last_rx, last_ry, last_rz, .worldid = g_poolTableData[poolid][E_WORLD], .priority = 999);

		// initialize physics on each ball
		Pool_InitBalls(poolid, object, i);
	}

	// show objects
	foreach (new playerid : poolplayers< poolid >) {
		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	}
}

hook OnPlayerShootDynObject(playerid, weaponid, objectid, Float: x, Float: y, Float: z) {
	// check if a player shot a pool ball and restore it
	new
		poolball_index = GetPoolBallIndexFromModel(Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_MODEL_ID));

	if (poolball_index != -1) {
		foreach (new poolid : pooltables) if (g_poolTableData[poolid][E_STARTED] && (g_poolBallData[poolid][E_POCKETED][poolball_index] || ! PHY_IsHandleMoving(g_poolBallData[poolid][E_BALL_PHY_HANDLE][poolball_index]))) {
			Pool_ResetBallPositions(poolid, poolball_index, poolball_index + 1);
			break;
		}
		return false; // desync the shot
	}
    return true;
}

Pool_UpdatePlayerCamera(playerid, poolid) {
	new
		Float: Xa, Float: Ya, Float: Za;

	GetDynamicObjectPos(PHY_GetHandleObject(g_poolBallData[poolid][E_BALL_PHY_HANDLE][0]), Xa, Ya, Za);

	if (!p_PoolCameraBirdsEye[playerid]) {
	    new
	    	Float: x = Xa, Float: y = Ya;

	    x += (0.675 * floatsin(-p_PoolAngle[playerid][0] + 180.0, degrees));
	    y += (0.675 * floatcos(-p_PoolAngle[playerid][0] + 180.0, degrees));

		SetPlayerCameraPos(playerid, x, y, g_poolTableData[poolid][E_Z] + DEFAULT_AIM);
		SetPlayerCameraLookAt(playerid, Xa, Ya, Za + 0.170);
	} else {
		SetPlayerCameraPos(playerid, g_poolTableData[poolid][E_X], g_poolTableData[poolid][E_Y], g_poolTableData[poolid][E_Z] + 2.0);
		SetPlayerCameraLookAt(playerid, g_poolTableData[poolid][E_X], g_poolTableData[poolid][E_Y], g_poolTableData[poolid][E_Z]);
	}
}

IsPlayerPlayingPool(playerid) {
	return p_isPlayingPool[playerid];
}

CMD:criarsinuca(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
	static
		type;
	
	if (sscanf(params, "d", type)) {
	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	    SendClientMessage(playerid, COLOR_BEGE, "USE: /criarsinuca [estilo]");
	    SendClientMessage(playerid, COLOR_BEGE, "TIPOS: 1: Padrão | 2: Roxa | 3: Verde | 4: Ouro | 5: Azul | 6: Verde claro");
	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		return true;
	}

	if (type < 1 || type > 6) return SendErrorMessage(playerid, "O estilo especificado é inválido. Os estilos vão de 1 até 6.");

	new Float: x, Float: y, Float: z, Float: a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	if (a != 0 || a != 90.0 || a != 180.0 || a != 270.0 || a != 360.0) {
		if (a > 0 && a < 45.0) a = 0.0;
		else if (a > 45.0 && a < 90.0) a = 90.0;
		else if (a > 90.0 && a < 135.0) a = 90.0;
		else if (a > 135.0 && a < 180.0) a = 180.0;
		else if (a > 180.0 && a < 225.0) a = 180.0;
		else if (a > 225.0 && a < 270.0) a = 270.0;
		else if (a > 270.0 && a < 315.0) a = 270.0;
		else if (a > 315.0) a = 360.0;
	}

	CreatePoolTable(x + 1.0, y + 1.0, z, a, type, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	SendServerMessage(playerid, "Você criou uma mesa de sinuca com sucesso.");
	
	mysql_format(DBConn, query, sizeof query, "INSERT INTO pool_tables (`positionX`, `positionY`, `positionZ`, `positionA`, `virtual_world`, `interior`, `skin`) VALUES ('%f', '%f', %f, '%f', '%d', '%d', '%d');", x + 1.0, y + 1.0, z, a, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), type);
    mysql_query(DBConn, query);

	format(logString, sizeof(logString), "%s (%s) criou uma mesa de sinuca em %f %f %f INTERIOR:%d VW:%d", pNome(playerid), GetPlayerUserEx(playerid), x + 1.0, y + 1.0, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:deletarsinuca(playerid, params[]){
	if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
	new poolid = Pool_GetClosestTable(playerid);
	if (poolid == -1) return SendErrorMessage(playerid, "Você deve estar perto de uma mesa de sinuca para utilizar este comando.");

	SendServerMessage(playerid, "Você deletou a mesa de sinuca %d (SQL: %d).", poolid, g_poolTableData[poolid][E_ID]);
	format(logString, sizeof(logString), "%s (%s) deletou a mesa de sinuca %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), poolid, g_poolTableData[poolid][E_ID]);
	logCreate(playerid, logString, 1);

	DeleteSnooker(poolid);
	return true;
}

CMD:retirarsinuca(playerid, params[]) {
	new
		userid;

	if (!pInfo[playerid][pLogged]) return true;
  	if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/retirarsinuca [playerid/nome]");
  	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	SendServerMessage(playerid, "Você retirou %s da partida de sinuca.", pNome(userid));
	SendServerMessage(userid, "O administrador %s retirou você da partida de sinuca.", GetPlayerUserEx(playerid));
	Pool_RemovePlayer(userid);

	format(logString, sizeof(logString), "%s (%s) retirou %s de uma partida de sinuca.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:encerrarsinuca(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 3) return SendPermissionMessage(playerid);
	new poolid = Pool_GetClosestTable(playerid);
	if (poolid == -1) return SendErrorMessage(playerid, "Você deve estar perto de uma mesa de sinuca para utilizar este comando.");

	SendServerMessage(playerid, "Você forçou o encerramento do jogo da mesa de sinuca ID %d.", poolid);
	Pool_EndGame(poolid);

	format(logString, sizeof(logString), "%s (%s) forçou o encerramento do jogo da mesa de sinuca ID %d", pNome(playerid), GetPlayerUserEx(playerid), poolid);
	logCreate(playerid, logString, 1);
	return true;
}

ShowPlayerHelpDialog(playerid, timeout, const format[], va_args<>) {
    static
		out[255];

	if (!IsPlayerConnected(playerid))
		return false;

    va_format(out, sizeof(out), format, va_start<3>);

    PlayerTextDrawSetString(playerid, p_HelpBoxTD[playerid], out);
    PlayerTextDrawShow(playerid, p_HelpBoxTD[playerid]);

    KillTimer(p_HideHelpDialogTimer[playerid]);
    p_HideHelpDialogTimer[playerid] = -1;

   	if (timeout != 0 ) {
   		p_HideHelpDialogTimer[playerid] = SetTimerEx("HidePlayerHelpDialog", timeout, false, "d", playerid);
   	}
	return true;
}

HidePlayerHelpDialog(playerid) {
	p_HideHelpDialogTimer[playerid] = -1;
	PlayerTextDrawHide(playerid, p_HelpBoxTD[playerid]);
}