#include <YSI_Coding\y_hooks>

#define BODY_PART_CHEST	        (3)
#define BODY_PART_GROIN         (4)
#define BODY_PART_LEFT_ARM      (5)
#define BODY_PART_RIGHT_ARM     (6)
#define BODY_PART_LEFT_LEG      (7)
#define BODY_PART_RIGHT_LEG     (8)
#define BODY_PART_HEAD          (9)

#define MAX_PLAYER_DAMAGES      (100)

enum WeaponDamageInfo
{
	WeaponID,
	Float:WepDamage,
};

enum damageInfo
{
	eDamageTaken,
	eDamageTime,

	eDamageWeapon,

	eDamageBodypart,
	eDamageArmor,

	eDamageBy,
};

new DamageInfo[MAX_PLAYERS][MAX_PLAYER_DAMAGES][damageInfo];

new WeaponDamage[][WeaponDamageInfo] =
{
	// WeaponID		WeaponDamage
	{0,				3.0},	//Unarmed
	{1,				15.0},	//Brass Knuckles
	{2,				15.0},	//Golf Club
	{3,				20.0},	//Nite Stick
	{4,				30.0},	//Knife
	{5,				10.0},	//Baseball Bat
	{6,				15.0},	//Shovel
	{7,				10.0},	//Pool Cue
	{8,				35.0},	//Katana
	{9,				0.0},	//Chainsaw
	{10,			1.0},	//Purple Dildo
	{12,			1.0},	//Large White Vibrator
	{11,			1.0},	//Small White Vibrator
	{13,			1.0},	//Silver Vibrator
	{14,			0.0},	//Flowers
	{15,			7.0},	//Cane
	{16,			0.0},	//Grenade
	{17,			0.0},	//Tear Gas
	{18,			10.0},	//Molotov Coctail
	{19,			0.0},	//Invalid Weapon
	{20,			0.0},	//Invalid Weapon
	{11,			0.0},	//Invalid Weapon
	{22,			20.0},	//Colt 9mm
	{23,			19.0},	//Silenced Colt 9mm
	{24,			45.0},	//Desert Eagle
	{25,			40.0},	//Shotgun
	{26,			65.0},	//Sawn-off Shotgun
	{27,			50.0},	//Combat Shotgun
	{28,			15.0},	//Micro SMG
	{29,			14.0},	//MP5
	{30,			28.0},	//AK-47
	{31,			25.0},	//M4
	{32,			15.0},	//Tec9
	{33,			85.0},	//Country Rifle
	{34,			500.0},	//Sniper Rifle
	{35,			0.0},	//Rocket Launcher
	{36,			0.0},	//HS Rocket Launcher
	{37,			0.0},	//Flamethrower
	{38,			0.0},	//Minigun
	{39,			0.0},	//Satchel Charge
	{40,			2.0},	//Satchel Detonator
	{41,			0.0},	//Spraycan
	{42,			0.0},	//Fire Extinguisher
	{43,			0.0},	//Camera
	{44,			0.0},	//Nightvision Goggles
	{45,			0.0},	//Thermal Goggles
	{46,			0.0},	//Thermal Goggles
	{47,			0.0},	//Fake Pistol
	{48,			0.0},	//Invalid Weapon
	{49,			15.0},	//Vehicle
	{50,			0.0},	//Heli-Blades
	{51,			100.0},	//Explosion 
	{52,			0.0},	//Invalid Weapon
	{53,			5.0},	//Drowned
	{54,			0.0}	//Splat
};

hook OnGameModeInit(){
    SetTimer("DeathTimer", 1000, true);
    return true;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart){
	if(pInfo[damagedid][pDead]) return false;
    new Float:health, Float:armour;
    amount = WeaponDamage[weaponid][WepDamage];
    health = pInfo[damagedid][pHealth];
    armour = pInfo[damagedid][pArmour];
	
    format(pInfo[damagedid][pLastShot], 64, "%s", pNome(playerid));
	pInfo[damagedid][pShotTime] = gettime();

	new bool:armourhit = false; 
	switch(bodypart)
	{
		case BODY_PART_CHEST, BODY_PART_GROIN: armourhit = true;

		case BODY_PART_LEFT_ARM, BODY_PART_RIGHT_ARM:
		{
			amount = amount / 2;
			new chance = random(3);
			if(chance == 1) armourhit = true;
		}

		case BODY_PART_LEFT_LEG, BODY_PART_RIGHT_LEG:
		{
			amount = amount / 3;

			new chance = random(2);

			if(chance){
				pInfo[damagedid][pLimping] = true;
                pInfo[damagedid][pLimpingTime] = 320;
                SendClientMessage(damagedid, COLOR_LIGHTRED, "-> Você foi atingido na perna, agora você sofrerá para correr ou pular.");
			}
		}

		case BODY_PART_HEAD:
		{
			if(pInfo[damagedid][pSwat]) amount = amount/4;
		}
	}
	if(armour > 0.0 && armourhit){
        armour -= amount;
        if(armour < 0.0){
         	SetPlayerArmour(damagedid, 0.0);
            pInfo[damagedid][pArmour] = 0.0;
            health += armour;
        } else SetPlayerArmour(damagedid, armour);
    } else health -= amount;
	SetPlayerHealthEx(damagedid, health);
	CallbackDamages(damagedid, playerid, bodypart, weaponid, amount);
	if(health > 10 && health < 30){
		if(!pInfo[damagedid][pBrutallyWounded] && !pInfo[damagedid][pDead]){
			SetPlayerWeaponSkill(damagedid, MEDIUM_SKILL);
		}
    }
    if(health < 10){
		if(!pInfo[damagedid][pBrutallyWounded] && !pInfo[damagedid][pDead]){
			SetPlayerWeaponSkill(damagedid, MINIMUM_SKILL);
		}
    }
	if(health < 1){
		if(!pInfo[damagedid][pBrutallyWounded] && !pInfo[damagedid][pDead]){ // BRUTALMENTE FERIDO 
			pInfo[damagedid][pBrutallyWounded] = true;
			pInfo[damagedid][pDeadTime] = 120;
			pInfo[damagedid][pInterior] = GetPlayerInterior(damagedid);
			pInfo[damagedid][pVirtualWorld] = GetPlayerVirtualWorld(damagedid);
			GetPlayerPos(damagedid, pInfo[damagedid][pPositionX], pInfo[damagedid][pPositionY], pInfo[damagedid][pPositionZ]);
			GetPlayerFacingAngle(damagedid, pInfo[damagedid][pPositionA]);
        
			SetSpawnInfo(damagedid, NO_TEAM, pInfo[damagedid][pSkin], 
				pInfo[damagedid][pPositionX], 
				pInfo[damagedid][pPositionY], 
				pInfo[damagedid][pPositionZ], 
				pInfo[damagedid][pPositionA],
				WEAPON_FIST, 0, 
				WEAPON_FIST, 0, 
				WEAPON_FIST, 0);

			SetPlayerSkin(damagedid, GetPlayerSkin(damagedid) > 0 ? (pInfo[damagedid][pSkin]) : (23));
			SpawnPlayer(damagedid);

			SetPlayerHealthEx(damagedid, 25.0);
			pInfo[damagedid][pHealth] = 25.0;

			SendClientMessage(damagedid, COLOR_LIGHTRED, "Você está brutalmente ferido, agora se um médico ou alguém não lhe ajudar, você irá morrer.");
			SendClientMessage(damagedid, COLOR_LIGHTRED, "Para aceitar a morte digite /aceitarmorte.");

			new textstring[512];
			if (!IsValidDynamic3DTextLabel(pInfo[damagedid][pBrutallyTag])) {
				if(pInfo[damagedid][pTotalDamages] == 1)
					format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vez,\n /ferimentos %d para mais informações ))", pInfo[damagedid][pTotalDamages], damagedid);
				else
					format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vezes,\n /ferimentos %d para mais informações ))", pInfo[damagedid][pTotalDamages], damagedid);

				pInfo[damagedid][pBrutallyTag] = CreateDynamic3DTextLabel(textstring, COLOR_LIGHTRED, 0.0, 0.0, 0.4, 8.0, damagedid, INVALID_VEHICLE_ID, 0, -1, -1);
			} else {
				if(pInfo[damagedid][pTotalDamages] == 1)
					format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vez,\n /ferimentos %d para mais informações ))", pInfo[damagedid][pTotalDamages], damagedid);
				else
					format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vezes,\n /ferimentos %d para mais informações ))", pInfo[damagedid][pTotalDamages], damagedid);

				UpdateDynamic3DTextLabelText(pInfo[damagedid][pBrutallyTag], COLOR_LIGHTRED, textstring);
			}
			TogglePlayerControllable(damagedid, false);
			if(IsPlayerInAnyVehicle(damagedid)){
				TogglePlayerControllable(damagedid, false);
				ApplyAnimation(damagedid, "ped", "CAR_dead_LHS", 4.0, false, true, true, true, 0);
			} else {
				TogglePlayerControllable(damagedid, true);
				ApplyAnimation(damagedid, "WUZI", "CS_Dead_Guy", 4.1, false, true, true, true, 0);
			}
			
			format(logString, sizeof(logString), "%s (%s) [%s] deixou %s brutalmente ferido com um(a) %s.", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), pNome(damagedid), ReturnWeaponName(weaponid));
			logCreate(damagedid, logString, 6);
		} else if(pInfo[damagedid][pBrutallyWounded]) { // MORTO 
			pInfo[damagedid][pBrutallyWounded] = false;
			pInfo[damagedid][pDead] = true;
			pInfo[damagedid][pDeadTime] = 60;
			pInfo[damagedid][pInterior] = GetPlayerInterior(damagedid);
			pInfo[damagedid][pVirtualWorld] = GetPlayerVirtualWorld(damagedid);
			GetPlayerPos(damagedid, pInfo[damagedid][pPositionX], pInfo[damagedid][pPositionY], pInfo[damagedid][pPositionZ]);
			GetPlayerFacingAngle(damagedid, pInfo[damagedid][pPositionA]);

			SetPlayerHealthEx(damagedid, 25.0);
			pInfo[damagedid][pHealth] = 25.0;

			TogglePlayerControllable(damagedid, false);

			SendClientMessage(damagedid, COLOR_YELLOW, "-> Você está morto agora. Você precisa esperar 60 segundos para utilizar o comando /respawnar.");

			new countwep = 0;
            for (new i = 0; i < 12; i ++) if (pInfo[damagedid][pGuns][i] != 0) {
                if(pInfo[damagedid][pAmmo][i] > 0)
                    countwep++;
            }
            if(countwep > 0) {
                va_SendClientMessage(damagedid, -1, "SERVER: Por segurança, estas eram as armas de %s antes de morrer.", pNome(damagedid));
                va_SendClientMessage(damagedid, COLOR_LIGHTRED, "Armas:");
                for (new i = 0; i < 12; i ++) if (pInfo[damagedid][pGuns][i] && pInfo[damagedid][pAmmo][i] > 0) {
                    va_SendClientMessage(damagedid, -1, "%s (%d)", ReturnWeaponName(pInfo[damagedid][pGuns][i]), pInfo[damagedid][pAmmo][i]);
                }
                ResetWeapons(damagedid);	
            } else va_SendClientMessage(damagedid, -1, "SERVER: Você não possuia nenhuma arma quando morreu.");
			
			new textstring[512];
			if (!IsValidDynamic3DTextLabel(pInfo[damagedid][pBrutallyTag])) {
				format(textstring, sizeof(textstring), "(( ESTE JOGADOR ESTÁ MORTO ))");
				pInfo[damagedid][pBrutallyTag] = CreateDynamic3DTextLabel(textstring, COLOR_LIGHTRED, 0.0, 0.0, 0.4, 8.0, damagedid, INVALID_VEHICLE_ID, 0, -1, -1);
			} else {
				format(textstring, sizeof(textstring), "(( ESTE JOGADOR ESTÁ MORTO ))");
				UpdateDynamic3DTextLabelText(pInfo[damagedid][pBrutallyTag], COLOR_LIGHTRED, textstring);
			}

			if(IsPlayerInAnyVehicle(damagedid)) ApplyAnimation(damagedid, "PED", "CAR_dead_LHS", 4.1, false, true, true, true, 0);
			else ApplyAnimation(damagedid, "PED", "FLOOR_hit_f", 25.0, false, true, true, true, 0);
			
			format(logString, sizeof(logString), "%s (%s) [%s] deixou %s com o status de morto com um(a) %s.", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), pNome(damagedid), ReturnWeaponName(weaponid));
			logCreate(damagedid, logString, 6);
		}
		return true;
	}

    return true;
}

/*
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart){
    if(pInfo[playerid][pDead]) return false;
	printf("Entrou!");
    new Float:health, Float:armour;
    amount = WeaponDamage[weaponid][WepDamage];
    health = pInfo[playerid][pHealth];
    armour = pInfo[playerid][pArmour];
	
    format(pInfo[playerid][pLastShot], 64, "%s", pNome(issuerid));
	pInfo[playerid][pShotTime] = gettime();

	new bool:armourhit = false; 
	switch(bodypart)
	{
		case BODY_PART_CHEST, BODY_PART_GROIN: armourhit = true;

		case BODY_PART_LEFT_ARM, BODY_PART_RIGHT_ARM:
		{
			amount = amount / 2;
			new chance = random(3);
			if(chance == 1) armourhit = true;
		}

		case BODY_PART_LEFT_LEG, BODY_PART_RIGHT_LEG:
		{
			amount = amount / 3;

			new chance = random(2);

			if(chance){
				pInfo[playerid][pLimping] = true;
                pInfo[playerid][pLimpingTime] = 320;
                SendClientMessage(playerid, COLOR_LIGHTRED, "-> Você foi atingido na perna, agora você sofrerá para correr ou pular.");
			}
		}

		case BODY_PART_HEAD:
		{
			if(pInfo[playerid][pSwat]) amount = amount/4;
		}
	}
	if(armour > 0.0 && armourhit){
        armour -= amount;
        if(armour < 0.0){
         	SetPlayerArmour(playerid, 0.0);
            pInfo[playerid][pArmour] = 0.0;
            health += armour;
        } else SetPlayerArmour(playerid, armour);
    } else health -= amount;
	CallbackDamages(playerid, issuerid, bodypart, weaponid, amount);

	SetPlayerHealthEx(playerid, health);
	if(health > 10 && health < 30){
		if(!pInfo[playerid][pBrutallyWounded] && !pInfo[playerid][pDead]){
			SetPlayerWeaponSkill(playerid, MEDIUM_SKILL);
			SendClientMessage(playerid, COLOR_LIGHTRED, "-> Vida baixa, suas skills de tiros estão no médio.");
		}
    }
    if(health < 10){
		if(!pInfo[playerid][pBrutallyWounded] && !pInfo[playerid][pDead]){
			SetPlayerWeaponSkill(playerid, MINIMUM_SKILL);
			SendClientMessage(playerid, COLOR_LIGHTRED, "-> Vida crítica, suas skills de tiros estão no mínimo.");
		}
    }
	if(health < 1){
		if(!pInfo[playerid][pBrutallyWounded] && !pInfo[playerid][pDead]){ // BRUTALMENTE FERIDO 
			pInfo[playerid][pBrutallyWounded] = true;
			pInfo[playerid][pDeadTime] = 120;
			pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
			pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
			GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
        
			SetSpawnInfo(playerid, NO_TEAM, pInfo[playerid][pSkin], 
			pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ], pInfo[playerid][pPositionA],
			0, 0, 0, 0, 0, 0);

			SetPlayerSkin(playerid, GetPlayerSkin(playerid) > 0 ? (pInfo[playerid][pSkin]) : (23));
			SpawnPlayer(playerid);

			SetPlayerHealthEx(playerid, 25.0);
			pInfo[playerid][pHealth] = 25.0;

			SendClientMessage(playerid, COLOR_LIGHTRED, "Você está brutalmente ferido, agora se um médico ou alguém não lhe ajudar, você irá morrer.");
			SendClientMessage(playerid, COLOR_LIGHTRED, "Para aceitar a morte digite /aceitarmorte.");

			new textstring[512];
			if (!IsValidDynamic3DTextLabel(pInfo[playerid][pBrutallyTag])) {
				if(pInfo[playerid][pTotalDamages] == 1)
					format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vez,\n /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);
				else
					format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vezes,\n /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);

				pInfo[playerid][pBrutallyTag] = CreateDynamic3DTextLabel(textstring, COLOR_LIGHTRED, 0.0, 0.0, 0.4, 8.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1);
			} else {
				if(pInfo[playerid][pTotalDamages] == 1)
					format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vez,\n /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);
				else
					format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vezes,\n /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);

				UpdateDynamic3DTextLabelText(pInfo[playerid][pBrutallyTag], COLOR_LIGHTRED, textstring);
			}
			TogglePlayerControllable(playerid, false);
			if(IsPlayerInAnyVehicle(playerid)){
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, false, true, true, true, 0);
			} else {
				TogglePlayerControllable(playerid, true);
				ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, false, true, true, true, 0);
			}
			
			format(logString, sizeof(logString), "%s (%s) [%s] deixou %s brutalmente ferido com um(a) %s.", pNome(issuerid), GetPlayerUserEx(issuerid), GetPlayerIP(issuerid), pNome(playerid), ReturnWeaponName(weaponid));
			logCreate(playerid, logString, 6);
		} else if(pInfo[playerid][pBrutallyWounded]) { // MORTO 
			pInfo[playerid][pBrutallyWounded] = false;
			pInfo[playerid][pDead] = true;
			pInfo[playerid][pDeadTime] = 60;
			pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
			pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
			GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);

			SetPlayerHealthEx(playerid, 25.0);
			pInfo[playerid][pHealth] = 25.0;

			TogglePlayerControllable(playerid, false);

			SendClientMessage(playerid, COLOR_YELLOW, "-> Você está morto agora. Você precisa esperar 60 segundos para utilizar o comando /respawnar.");

			new countwep = 0;
            for (new i = 0; i < 12; i ++) if (pInfo[playerid][pGuns][i] != 0) {
                if(pInfo[playerid][pAmmo][i] > 0)
                    countwep++;
            }
            if(countwep > 0) {
                SendServerMessage(playerid, "Por segurança, estas eram as armas de %s antes de morrer.", pNome(playerid));
                va_SendClientMessage(playerid, COLOR_LIGHTRED, "Armas:");
                for (new i = 0; i < 12; i ++) if (pInfo[playerid][pGuns][i] && pInfo[playerid][pAmmo][i] > 0) {
                    va_SendClientMessage(playerid, -1, "%s (%d)", ReturnWeaponName(pInfo[playerid][pGuns][i]), pInfo[playerid][pAmmo][i]);
                }
                ResetWeapons(playerid);	
            } else SendServerMessage(playerid, "Você não possuia nenhuma arma quando morreu.");
			
			new textstring[512];
			if (!IsValidDynamic3DTextLabel(pInfo[playerid][pBrutallyTag])) {
				format(textstring, sizeof(textstring), "(( ESTE JOGADOR ESTÁ MORTO ))");
				pInfo[playerid][pBrutallyTag] = CreateDynamic3DTextLabel(textstring, COLOR_LIGHTRED, 0.0, 0.0, 0.4, 8.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1);
			} else {
				format(textstring, sizeof(textstring), "(( ESTE JOGADOR ESTÁ MORTO ))");
				UpdateDynamic3DTextLabelText(pInfo[playerid][pBrutallyTag], COLOR_LIGHTRED, textstring);
			}

			if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "PED", "CAR_dead_LHS", 4.1, false, true, true, true, 0);
			else ApplyAnimation(playerid, "PED", "FLOOR_hit_f", 25.0, false, true, true, true, 0);
			
			format(logString, sizeof(logString), "%s (%s) [%s] deixou %s com o status de morto com um(a) %s.", pNome(issuerid), GetPlayerUserEx(issuerid), GetPlayerIP(issuerid), pNome(playerid), ReturnWeaponName(weaponid));
			logCreate(playerid, logString, 6);
		}
		return true;
	}

    return true;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart){
    if(weaponid == 0){
        if(pInfo[playerid][pTackleMode]){
            if(pInfo[playerid][pTackleTimer] < gettime()){
                new chance = random(2);
                switch(chance){
                    case 0: // falha
                    {
                        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s falhou em tentar derrubar %s.", pNome(playerid), pNome(damagedid));

                        ApplyAnimation(playerid,"ped","EV_dive", 4.0, false, true, true, false, 0);
                        pInfo[playerid][pTackleTimer] = gettime() + 10;

                        format(logString, sizeof(logString), "%s (%s) falhou em derrubar %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(damagedid));
	                    logCreate(playerid, logString, 7);
                    }
                    case 1: // sucesso
                    {
                        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s derrubou %s no chão.", pNome(playerid), pNome(damagedid));
                        
                        ApplyAnimation(playerid, "PED", "FLOOR_hit_f", 4.0, false, true, true, true, 0);
                        ApplyAnimation(damagedid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 0);
                        ApplyAnimation(damagedid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 0);

                        pInfo[playerid][pTackleTimer] = gettime() + 10;

                        format(logString, sizeof(logString), "%s (%s) derrubou %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(damagedid));
	                    logCreate(playerid, logString, 7);
                    }
                }
            }
        }
    }
	if(playerid != INVALID_PLAYER_ID && damagedid != INVALID_PLAYER_ID){
        OnPlayerTakeDamage(damagedid, playerid, amount, weaponid, bodypart);
    }
    return true;
}*/

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    if(pInfo[playerid][pDead]) return false;

    if(pInfo[playerid][pLimping] && pInfo[playerid][pLimping] < gettime()){
	    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
			if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP)){
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, false, true, true, true, 0);
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, false, true, true, true, 0);
			}
		}
	 	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
			if(newkeys & KEY_SPRINT && !(oldkeys & KEY_SPRINT)){
				ApplyAnimation(playerid, "ped", "FALL_collapse", 4.1, false, true, true, true, 0);
				ApplyAnimation(playerid, "ped", "FALL_collapse", 4.1, false, true, true, true, 0);
			}
		}
	}
    return true;
}

forward DeathTimer(); public DeathTimer(){
    foreach (new i : Player){
        if(pInfo[i][pDeadTime] > 0){
            if(pInfo[i][pPassedOut] == true) if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
            else {
                if(!pInfo[i][pDead] && pInfo[i][pInjured]){
                    if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
                
                    if(pInfo[i][pDeadTime] <= 0 && pInfo[i][pInjured] == 1){
                        pInfo[i][pPassedOut] = false;
                        TogglePlayerControllable(i, false);

                        va_SendClientMessage(i, COLOR_YELLOW, "-> Você está morto agora. Será necessário esperar 60 segundos até poder utilizar o comando /respawnar.");

                        SetPlayerChatBubble(i, "(( ESTE JOGADOR ESTÁ MORTO ))", COLOR_LIGHTRED, 15.0, 60*1000);
                        SendClientMessageToAll(-1, "[11] MORTO TIMER");

                        pInfo[i][pDead] = 1;
                        pInfo[i][pDeadTime] = 60;

                        if(IsPlayerInAnyVehicle(i)) ApplyAnimation(i, "ped", "CAR_dead_LHS", 4.0, false, true, true, true, 0);
                        else ApplyAnimation(i, "WUZI", "CS_Dead_Guy", 4.1, false, true, true, true, 0);
                    }
                    else if(pInfo[i][pDead]){
                        if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
                        if(pInfo[i][pDeadTime] <= 0 && pInfo[i][pInjured]){
                            va_SendClientMessage(i, COLOR_YELLOW, "-> Você já pode usar /respawnar agora.");
                            SendClientMessageToAll(-1, "[12] MORTO TIMER -> Allow respawn");
                        }
                    }
                }
            }
        }
    }
    return true;
}

CallbackDamages(playerid, issuerid, bodypart, weaponid, Float:amount){
    new id,
        Float: armour;

    pInfo[playerid][pTotalDamages] ++;

    for(new i = 0; i < 100; i++){
		if(!DamageInfo[playerid][i][eDamageTaken]){
			id = i;
			break;
		}
	}
    GetPlayerArmour(playerid, armour);

    if(armour > 1 && bodypart == BODY_PART_CHEST)
		DamageInfo[playerid][id][eDamageArmor] = 1;

	else DamageInfo[playerid][id][eDamageArmor] = 0;

    DamageInfo[playerid][id][eDamageTaken] = floatround(amount, floatround_round);
	DamageInfo[playerid][id][eDamageWeapon] = weaponid;

	DamageInfo[playerid][id][eDamageBodypart] = bodypart;
	DamageInfo[playerid][id][eDamageTime] = gettime();

	DamageInfo[playerid][id][eDamageBy] = pInfo[issuerid][pID];
    return true;
}

ShowPlayerDamages(damageid, playerid, view){
    new caption[33],
        str[1024];
        //longstr[1200];

    format(caption, sizeof(caption), "%s — %d ferimentos", pNome(damageid), pInfo[damageid][pTotalDamages]);

    if (pInfo[damageid][pTotalDamages] < 1)
		return Dialog_Show(playerid, damagesDialog, DIALOG_STYLE_LIST, caption, "Não existe nenhum dano para mostrar.", "Fechar", "");
    
    switch(view){
        case 0:
        {
			format(str, sizeof(str), "Parte do corpo\tArma\tTempo\tDano\n");
            for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;

				format(str, sizeof(str), "%s%s\t%s\t%ds\t(%d)\n", str,
				ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), 
				ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), 
				gettime() - DamageInfo[damageid][i][eDamageTime],
				DamageInfo[damageid][i][eDamageTaken]);
				//strcat(longstr, str);
            }
			Dialog_Show(playerid, damagesDialog, DIALOG_STYLE_TABLIST_HEADERS, caption, str, "Fechar", "");
        }
        case 1:
        {
			format(str, sizeof(str), "Parte do corpo\tArma\tTempo\tDano\n");
            for(new i = 0; i < 100; i ++)
			{
                if(!DamageInfo[damageid][i][eDamageTaken])
                    continue;

				format(str, sizeof(str), "%s%s\t%s\t%ds\t(%d)\n", str,
				ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), 
				ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), 
				pNome(DamageInfo[damageid][i][eDamageBy]),
				gettime() - DamageInfo[damageid][i][eDamageTime],
				DamageInfo[damageid][i][eDamageTaken]);
				//strcat(longstr, str);
            }
            Dialog_Show(playerid, damagesDialog, DIALOG_STYLE_TABLIST_HEADERS, caption, str, "Fechar", "");
        } 
    }
    return true;
}

ClearDamages(playerid){
    SetPlayerChatBubble(playerid, " ", COLOR_WHITE, 10.0, 100);

    pInfo[playerid][pLimping] = false;
    pInfo[playerid][pLimpingTime] = 0;

	for(new i = 0; i < 100; i++){
		DamageInfo[playerid][i][eDamageTaken] = 0;
		DamageInfo[playerid][i][eDamageBy] = 0;

		DamageInfo[playerid][i][eDamageArmor] = 0;
		DamageInfo[playerid][i][eDamageBodypart] = 0;

		DamageInfo[playerid][i][eDamageTime] = 0;
		DamageInfo[playerid][i][eDamageWeapon] = 0;
	}
	return true;
}

ReturnBodypartName(bodypart){
	new bodyname[20];
	switch(bodypart){
		case BODY_PART_CHEST:bodyname = "PEITO";
		case BODY_PART_GROIN:bodyname = "VIRILHA";
		case BODY_PART_LEFT_ARM:bodyname = "BRAÇO ESQUERDO";
		case BODY_PART_RIGHT_ARM:bodyname = "BRAÇO DIREITO";
		case BODY_PART_LEFT_LEG:bodyname = "PERNA ESQUERDA";
		case BODY_PART_RIGHT_LEG:bodyname = "PERNA DIREITA";
		case BODY_PART_HEAD:bodyname = "CABEÇA";
	}
	return bodyname;
}

/*
new actorsito[MAX_PLAYERS];
  
hook OnPlayerDeath(playerid, killerid, reason)
{
    new Float: x_, Float: y_, Float: z_, Float: r_;
    actorsito[playerid] = playerid;
    GetPlayerPos(playerid, x_, y_, z_);
    GetPlayerFacingAngle(playerid, r_);
    actorsito[playerid] = CreateActor(GetPlayerSkin(playerid), x_, y_, z_, r_);
    SetActorVirtualWorld(actorsito[playerid], GetPlayerVirtualWorld(playerid));
    ApplyActorAnimation(actorsito[playerid], "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1); //
    SetTimerEx("borrar_a", 15000, false, "i", playerid); // 15000 = 15seg
    return true;
}
 
forward borrar_a(playerid); public borrar_a(playerid)
{
    if (actorsito[playerid] != -1){
        DestroyActor(actorsito[playerid]);
        actorsito[playerid] = -1;
    }
    return true;
}
 
hook OnPlayerConnect(playerid)
{
    actorsito[playerid] = -1;
}
 
// Opcional.
CMD:deletecorpse(playerid, params[])
{
    new id;
    if (!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "* Not authorized.");
    if (sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "CMD: /deletecorpse [id jugador]");
    if (actorsito[id] == -1) return SendClientMessage(playerid, -1, "* Player is not corpse.");
    DestroyActor(actorsito[id]);
    actorsito[id] = -1;
    return 1;
}*/

CMD:investida(playerid, params[]){
	if (!pInfo[playerid][pTackleMode]){
		SendServerMessage(playerid, "Você ativou o modo investida. A partir de agora se você socar alguém, haverá chances de derruba-lo.");
		SendServerMessage(playerid, "Se o jogador for derrubado e não interpretar corretamente, utilize o /report.");
		pInfo[playerid][pTackleMode] = true;
	}else{
		SendServerMessage(playerid, "Você desativou o modo de investida.");
		pInfo[playerid][pTackleMode] = false;
	}
	return true;
}
alias:investida("derrubar", "tackle", "investir")

CMD:ferimentos(playerid, params[]){
    if (!pInfo[playerid][pLogged]) return true;
    static userid;
    if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/ferimentos [playerid/nome]");
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

    if (pInfo[playerid][pAdminDuty]) ShowPlayerDamages(userid, playerid, 1);
    else{
        if(!IsPlayerNearPlayer(playerid, userid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste jogador.");
        ShowPlayerDamages(userid, playerid, 0);
    }
    return true;
}

CMD:ultimoatirador(playerid, params[]){
	if (!pInfo[playerid][pLogged]) return true;
  	if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
    static userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/ultimoatirador [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
	if (isnull(pInfo[userid][pLastShot])) return SendErrorMessage(playerid, "Este jogador não levou nenhum tiro desde que em logou no servidor.");

	SendServerMessage(playerid, "%s foi atingido pela última vez por %s (%s).", pNome(userid), pInfo[userid][pLastShot], GetDuration(gettime() - pInfo[userid][pShotTime]));
    
    format(logString, sizeof(logString), "%s (%s) checou o último atirador de %s [foi: %s (%s)].", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), pInfo[userid][pLastShot], GetDuration(gettime() - pInfo[userid][pShotTime]));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:debug(playerid, params[]){
	ClearDamages(playerid);
	pInfo[playerid][pDead] = 0;
    pInfo[playerid][pInjured] = 0;
    pInfo[playerid][pDeadTime] = 0;
	pInfo[playerid][pBrutallyWounded] = 0;
    pInfo[playerid][pPassedOut] = false;
    pInfo[playerid][pLimping] = false;
    pInfo[playerid][pLimpingTime] = 0;
	pInfo[playerid][pTotalDamages] = 0;
	SetPlayerHealthEx(playerid, pInfo[playerid][pHealthMax]);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, false, false, false, false, 0, true);
	if (IsValidDynamic3DTextLabel(pInfo[playerid][pBrutallyTag]))
	{
		DestroyDynamic3DTextLabel(pInfo[playerid][pBrutallyTag]);
		pInfo[playerid][pBrutallyTag] = Text3D:INVALID_3DTEXT_ID;
	}
	return true;
}

CMD:checkvars(playerid, params[]){
	SendAdminAlert(COLOR_YELLOW, "pInfo[playerid][pDead] = %d, \
    pInfo[playerid][pInjured] = %d, \
    pInfo[playerid][pDeadTime] = %d, \
	pInfo[playerid][pBrutallyWounded] = %d", pInfo[playerid][pDead], pInfo[playerid][pInjured], pInfo[playerid][pDeadTime], pInfo[playerid][pBrutallyWounded]);

	return true;
}