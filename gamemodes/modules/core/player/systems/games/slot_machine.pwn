// cherry   x   25
// grapes   x  100
// 69       x  250
// bells    x  500
// bar 1    x 1000
// bar 2    x 2000

#include <YSI_Coding\y_hooks>

#define WIN_MULTIPLIER_GLOBAL 	(1.0)

#define MIN_BET 				(5)
#define MAX_BET 				(200)

#define BET_SETP 				(5)

#define G_STATE_NOT_GAMBLING    (0)
#define G_STATE_READY           (1)
#define G_STATE_GAMBLING        (2)
#define G_STATE_DISPLAY         (3) // Currently displaying the message
#define G_STATE_PLAY_AGAIN      (4)

#define DISPLAY_TIME 750
#define GAMBLE_TIMER 75

static
	Timer: slot_Timer[MAX_PLAYERS],

	PlayerText: slot_Digit1[MAX_PLAYERS][6],
	PlayerText: slot_Digit2[MAX_PLAYERS][6],
	PlayerText: slot_Digit3[MAX_PLAYERS][6],
	PlayerText: slot_BetTD[MAX_PLAYERS][2],
	PlayerText: slot_Machine[MAX_PLAYERS];

static
	PlayerSlotID[MAX_PLAYERS][3],
	SlotCounter[MAX_PLAYERS],
	PlayerGamblingState[MAX_PLAYERS],
	PlayerBet[MAX_PLAYERS],
	PlayerBalance[MAX_PLAYERS];

enum E_SLOT_MACHINE_DATA {
	Float:E_SLOT_MACHINE_X,
	Float:E_SLOT_MACHINE_Y,
	Float:E_SLOT_MACHINE_Z,
	Float:E_SLOT_MACHINE_RX,
	Float:E_SLOT_MACHINE_RY,
	Float:E_SLOT_MACHINE_RZ,
	E_SLOT_MACHINE_INTERIOR,
	E_SLOT_MACHINE_WORLD
}


static const SlotMachinePositions[][E_SLOT_MACHINE_DATA] = {
	{1950.631835, -1770.526245, 11.776875, 270.000000, 0.000000, 180.000000, 0, 0}
};

static
	SlotMachineArea[sizeof(SlotMachinePositions)];

PlayerText:CreatePlayerGamblingSprite(playerid, Float:x, Float:y, const td_name[]) {

	new PlayerText:RetSprite = CreatePlayerTextDraw(playerid, x, y, td_name);
	PlayerTextDrawTextSize(playerid, RetSprite, 48.000000, 129.000000);
	PlayerTextDrawAlignment(playerid, RetSprite, TEXT_DRAW_ALIGN:1);
	PlayerTextDrawColour(playerid, RetSprite, 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, RetSprite, 0);
	PlayerTextDrawBackgroundColour(playerid, RetSprite, 255);
	PlayerTextDrawFont(playerid, RetSprite, TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, RetSprite, false);

	return RetSprite;
}

hook OnGameModeInit() {
	new
		Float:x,
		Float:y,
		Float:z,
		Float:rx,
		Float:ry,
		Float:rz,
		int, vw;

	for(new i = 0; i < sizeof(SlotMachinePositions); i++) {
		x = SlotMachinePositions[i][E_SLOT_MACHINE_X];
		y = SlotMachinePositions[i][E_SLOT_MACHINE_Y];
		z = SlotMachinePositions[i][E_SLOT_MACHINE_Z];
		rx = SlotMachinePositions[i][E_SLOT_MACHINE_RX];
		ry = SlotMachinePositions[i][E_SLOT_MACHINE_RY];
		rz = SlotMachinePositions[i][E_SLOT_MACHINE_RZ];
		int = SlotMachinePositions[i][E_SLOT_MACHINE_INTERIOR];
		vw = SlotMachinePositions[i][E_SLOT_MACHINE_WORLD];

		SlotMachineArea[i] = CreateDynamicSphere(x, y, z+1.5, 2.0);

		CreateDynamic3DTextLabel("Pressione ~k~~CONVERSATION_YES~ para jogar", COLOR_WHITE, x, y, z+1.5, 2.0, .testlos = false, .worldid = vw, .interiorid = int);
		
		CreateDynamicObject(-6002, x, y, z, rx, ry, rz, vw, int, -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD);
	}
	return true;
}

hook OnPlayerConnect(playerid) {
	PlayerGamblingState[playerid] = G_STATE_NOT_GAMBLING;
	new Float:Y = 183.016830, Float:X1 = 236.294204, Float:X2 = 295.587951, Float:X3 = 352.999359;

	// Cherries (x25)
	slot_Digit1[playerid][0] = CreatePlayerGamblingSprite(playerid, X1, Y, "LD_SLOT:cherry");
	slot_Digit2[playerid][0] = CreatePlayerGamblingSprite(playerid, X2, Y, "LD_SLOT:cherry");
	slot_Digit3[playerid][0] = CreatePlayerGamblingSprite(playerid, X3, Y, "LD_SLOT:cherry");

	// grapes (x100)
	slot_Digit1[playerid][1] = CreatePlayerGamblingSprite(playerid, X1, Y, "LD_SLOT:grapes");
	slot_Digit2[playerid][1] = CreatePlayerGamblingSprite(playerid, X2, Y, "LD_SLOT:grapes");
	slot_Digit3[playerid][1] = CreatePlayerGamblingSprite(playerid, X3, Y, "LD_SLOT:grapes");

	// 69's (x250)
	slot_Digit1[playerid][2] = CreatePlayerGamblingSprite(playerid, X1, Y, "LD_SLOT:r_69");
	slot_Digit2[playerid][2] = CreatePlayerGamblingSprite(playerid, X2, Y, "LD_SLOT:r_69");
	slot_Digit3[playerid][2] = CreatePlayerGamblingSprite(playerid, X3, Y, "LD_SLOT:r_69");

	// bells (x500)
	slot_Digit1[playerid][3] = CreatePlayerGamblingSprite(playerid, X1, Y, "LD_SLOT:bell");
	slot_Digit2[playerid][3] = CreatePlayerGamblingSprite(playerid, X2, Y, "LD_SLOT:bell");
	slot_Digit3[playerid][3] = CreatePlayerGamblingSprite(playerid, X3, Y, "LD_SLOT:bell");

	// Bars [1 bar] (x1000)
	slot_Digit1[playerid][4] = CreatePlayerGamblingSprite(playerid, X1, Y, "LD_SLOT:bar1_o");
	slot_Digit2[playerid][4] = CreatePlayerGamblingSprite(playerid, X2, Y, "LD_SLOT:bar1_o");
	slot_Digit3[playerid][4] = CreatePlayerGamblingSprite(playerid, X3, Y, "LD_SLOT:bar1_o");

	// Bars [2 bar] (x2000)
	slot_Digit1[playerid][5] = CreatePlayerGamblingSprite(playerid, X1, Y, "LD_SLOT:bar2_o");
	slot_Digit2[playerid][5] = CreatePlayerGamblingSprite(playerid, X2, Y, "LD_SLOT:bar2_o");
	slot_Digit3[playerid][5] = CreatePlayerGamblingSprite(playerid, X3, Y, "LD_SLOT:bar2_o");

	slot_Machine[playerid] = CreatePlayerTextDraw(playerid, 202.411804, 124.666641, "mdl-9003:machine");
	PlayerTextDrawTextSize(playerid, slot_Machine[playerid], 236.000000, 210.000000);
	PlayerTextDrawAlignment(playerid, slot_Machine[playerid], TEXT_DRAW_ALIGN:1);
	PlayerTextDrawColour(playerid, slot_Machine[playerid], -1);
	PlayerTextDrawSetShadow(playerid, slot_Machine[playerid], false);
	PlayerTextDrawBackgroundColour(playerid, slot_Machine[playerid], 255);
	PlayerTextDrawFont(playerid, slot_Machine[playerid], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, slot_Machine[playerid], false);

	slot_BetTD[playerid][0] = CreatePlayerTextDraw(playerid, 361.129486, 281.583404, "200");
	PlayerTextDrawLetterSize(playerid, slot_BetTD[playerid][0], 0.200000, 1.500000);
	PlayerTextDrawAlignment(playerid, slot_BetTD[playerid][0], TEXT_DRAW_ALIGN:2);
	PlayerTextDrawColour(playerid, slot_BetTD[playerid][0], -16776961);
	PlayerTextDrawSetShadow(playerid, slot_BetTD[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, slot_BetTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, slot_BetTD[playerid][0], TEXT_DRAW_FONT_2);
	PlayerTextDrawSetProportional(playerid, slot_BetTD[playerid][0], true);

	slot_BetTD[playerid][1] = CreatePlayerTextDraw(playerid, 307.426208, 281.583404, "US$ 1.000.000");
	PlayerTextDrawLetterSize(playerid, slot_BetTD[playerid][1], 0.200000, 1.500000);
	PlayerTextDrawAlignment(playerid, slot_BetTD[playerid][1], TEXT_DRAW_ALIGN:3);
	PlayerTextDrawColour(playerid, slot_BetTD[playerid][1], -16776961);
	PlayerTextDrawSetShadow(playerid, slot_BetTD[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, slot_BetTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, slot_BetTD[playerid][1], TEXT_DRAW_FONT_2);
	PlayerTextDrawSetProportional(playerid, slot_BetTD[playerid][1], true);
}

hook OnPlayerDisconnect(playerid, reason) {
    SlotMachine_Exit(playerid);
	SlotMachine_Hide(playerid);

	stop slot_Timer[playerid];
	return true;
}

SlotMachine_Show(playerid, slot1, slot2, slot3) {
	SlotMachine_Hide(playerid);

	PlayerTextDrawShow(playerid, slot_Digit1[playerid][clamp(slot1, 0, sizeof(slot_Digit1[]))]);
	PlayerTextDrawShow(playerid, slot_Digit2[playerid][clamp(slot2, 0, sizeof(slot_Digit2[]))]);
	PlayerTextDrawShow(playerid, slot_Digit3[playerid][clamp(slot3, 0, sizeof(slot_Digit3[]))]);
}

SlotMachine_Hide(playerid) {
    PlayerTextDrawHide(playerid, slot_Digit1[playerid][0]);
	PlayerTextDrawHide(playerid, slot_Digit2[playerid][0]);
	PlayerTextDrawHide(playerid, slot_Digit3[playerid][0]);

	PlayerTextDrawHide(playerid, slot_Digit1[playerid][1]);
	PlayerTextDrawHide(playerid, slot_Digit2[playerid][1]);
	PlayerTextDrawHide(playerid, slot_Digit3[playerid][1]);

	PlayerTextDrawHide(playerid, slot_Digit1[playerid][2]);
	PlayerTextDrawHide(playerid, slot_Digit2[playerid][2]);
	PlayerTextDrawHide(playerid, slot_Digit3[playerid][2]);

	PlayerTextDrawHide(playerid, slot_Digit1[playerid][3]);
	PlayerTextDrawHide(playerid, slot_Digit2[playerid][3]);
	PlayerTextDrawHide(playerid, slot_Digit3[playerid][3]);

	PlayerTextDrawHide(playerid, slot_Digit1[playerid][4]);
	PlayerTextDrawHide(playerid, slot_Digit2[playerid][4]);
	PlayerTextDrawHide(playerid, slot_Digit3[playerid][4]);

	PlayerTextDrawHide(playerid, slot_Digit1[playerid][5]);
	PlayerTextDrawHide(playerid, slot_Digit2[playerid][5]);
	PlayerTextDrawHide(playerid, slot_Digit3[playerid][5]);
}

SlotMachine_Use(playerid, firstBet = MIN_BET,  startBalance = 0) {
	if(PlayerGamblingState[playerid] != G_STATE_NOT_GAMBLING) {
		return false;
	}

	SendServerMessage(playerid, "Para ver os comandos do caça-níquel, digite: /ajuda cassino.");
	PlayerGamblingState[playerid] = G_STATE_READY;

	PlayerSlotID[playerid][0] = random(5);
	PlayerSlotID[playerid][1] = random(5);
	PlayerSlotID[playerid][2] = random(5);

	SlotMachine_Show(playerid, PlayerSlotID[playerid][0], PlayerSlotID[playerid][1], PlayerSlotID[playerid][2]);
	PlayerTextDrawShow(playerid, slot_Machine[playerid]);
	PlayerTextDrawShow(playerid, slot_BetTD[playerid][0]);
	PlayerTextDrawShow(playerid, slot_BetTD[playerid][1]);

	PlayerBet[playerid] = firstBet;
	GiveMoney(playerid, -startBalance);
	PlayerBalance[playerid] = startBalance;
	Updateslot_BetTD(playerid);

	TogglePlayerControllable(playerid, false);
	return true;
}

SlotMachine_Exit(playerid) {
	if(PlayerGamblingState[playerid] == G_STATE_NOT_GAMBLING) {
		return false;
	}

	SlotMachine_Hide(playerid);
	PlayerTextDrawHide(playerid, slot_Machine[playerid]);
	PlayerTextDrawHide(playerid, slot_BetTD[playerid][0]);
	PlayerTextDrawHide(playerid, slot_BetTD[playerid][1]);

	PlayerGamblingState[playerid] = G_STATE_NOT_GAMBLING;
	TogglePlayerControllable(playerid, true);

	new string[64];
	if(PlayerBalance[playerid] > 0) format(string, sizeof(string),"Sacou US$ %s", FormatNumber(PlayerBalance[playerid])), ShowPlayerFooter(playerid, string, 3), pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);
	else ShowPlayerFooter(playerid, "Você perdeu tudo!", 1), pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);
	
    GiveMoney(playerid, PlayerBalance[playerid]);
    return true;
}

timer PlayerPlaySlotAgain[DISPLAY_TIME](playerid) {
	PlayerGamblingState[playerid] = G_STATE_READY;

	new KEY:keys, KEY:lr, KEY:ud;
	GetPlayerKeys(playerid, keys, ud, lr);
	if(keys & KEY_SPRINT) {
		CallLocalFunction("OnPlayerKeyStateChange", "ii", KEY_SPRINT, 0);
	}
}

timer PlayerBeginGambling[GAMBLE_TIMER](playerid) {
	if(PlayerGamblingState[playerid] != G_STATE_GAMBLING) {
	    stop slot_Timer[playerid];
	    PlayerGamblingState[playerid] = G_STATE_NOT_GAMBLING;
	    return false;
	}

	SlotCounter[playerid] --;

	new
		slot = SlotCounter[playerid];

	if(slot < 10) {
	    PlayerSlotID[playerid][2] += random(3) + 1;
	}
	else if(slot < 20) {
	    PlayerSlotID[playerid][1] += random(3) + 1;
	    PlayerSlotID[playerid][2] += random(3) + 1;
	}
	else {
	    PlayerSlotID[playerid][0] += random(3) + 1;
	    PlayerSlotID[playerid][1] += random(3) + 1;
	    PlayerSlotID[playerid][2] += random(3) + 1;
	}

	if(PlayerSlotID[playerid][0] >= 6) {
		PlayerSlotID[playerid][0] = 0;
	}
	if(PlayerSlotID[playerid][1] >= 6) {
		PlayerSlotID[playerid][1] = 0;
	}
	if(PlayerSlotID[playerid][2] >= 6) {
		PlayerSlotID[playerid][2] = 0;
	}

    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);

	SlotMachine_Show(playerid, PlayerSlotID[playerid][0], PlayerSlotID[playerid][1], PlayerSlotID[playerid][2]);

	if(SlotCounter[playerid] == 0) {
	    stop slot_Timer[playerid];

		PlayerGamblingState[playerid] = G_STATE_DISPLAY;

	    if(PlayerSlotID[playerid][0] == PlayerSlotID[playerid][1] && PlayerSlotID[playerid][0] == PlayerSlotID[playerid][2]) {
	        new
				multiplier = 1;

	        switch(PlayerSlotID[playerid][0]) {
	            case 0: multiplier = 25;    // Cherries
	            case 1: multiplier = 100;   // Grapes
	            case 2: multiplier = 250;   // 69's
	            case 3: multiplier = 500;   // Bells
	            case 4: multiplier = 1000;  // Bar
	            case 5: multiplier = 2000;  // Double Bars
	        }

	        new
				money = floatround(PlayerBet[playerid] * multiplier * WIN_MULTIPLIER_GLOBAL);

			ShowPlayerFooter(playerid, "Ganhou!", 3);
			pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);

	        PlayerBalance[playerid] += money;
			SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s ganhou US$ %s no caça-níquel.", pNome(playerid), FormatNumber(money));

			format(logString, sizeof(logString), "%s (%s) ganhou US$ %s no caça-níquel.", pNome(playerid), GetPlayerUserEx(playerid), FormatNumber(money));
			logCreate(playerid, logString, 12);

	        Updateslot_BetTD(playerid);

			// Randomize the slots again
	        PlayerSlotID[playerid][0] = random(5);
			PlayerSlotID[playerid][1] = random(5);
			PlayerSlotID[playerid][2] = random(5);
	    } else {
	        if (PlayerSlotID[playerid][0] == PlayerSlotID[playerid][1] || PlayerSlotID[playerid][1] == PlayerSlotID[playerid][2] || PlayerSlotID[playerid][0] == PlayerSlotID[playerid][2]) {
				ShowPlayerFooter(playerid, "Quase lá!", 2);
				pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);
	        } else {
				ShowPlayerFooter(playerid, "Deu azar!", 1);
				pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);
			}
		}

	    defer PlayerPlaySlotAgain(playerid);
	    return true;
	}
	return false;
}

SlotMachine_NextValidBet(value) {
	return (value + BET_SETP > MAX_BET) ? (MIN_BET) : (value + BET_SETP);
}

Updateslot_BetTD(playerid) {
    new str[128];

	format(str, sizeof(str), "%s", FormatNumber(PlayerBet[playerid]));
	PlayerTextDrawSetString(playerid, slot_BetTD[playerid][0], str);

    format(str, sizeof(str), "US$ %s", FormatNumber(PlayerBalance[playerid]));
	PlayerTextDrawSetString(playerid, slot_BetTD[playerid][1], str);
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {
	if(PRESSED(KEY_YES)) {
		new
			bool:isNearSlot = false;

		for(new i = 0; i < sizeof(SlotMachinePositions); i++) {
			if(IsPlayerInDynamicArea(playerid, SlotMachineArea[i])) {
				isNearSlot = true;
			}
		}

		if(!isNearSlot) {
			return true;
		}

        Dialog_Show(playerid, DIALOG_SLOT_MACHINE, DIALOG_STYLE_INPUT, "Caça-Níquel", "Insira a quantidade que deseja apostar nesta máquina.", "Continuar", "Cancelar");
	}

	if(PRESSED(KEY_SPRINT)) {
	    // Randomize if in Slotmachine
	    if(PlayerGamblingState[playerid] == G_STATE_READY) {

	        if(PlayerBet[playerid] > GetMoney(playerid) + PlayerBalance[playerid]) {

				ShowPlayerFooter(playerid, "Sem dinheiro suficiente!", 1);
				pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);
	            return true;
	        }

	        if(PlayerBalance[playerid] - PlayerBet[playerid] < 0) {
				ShowPlayerFooter(playerid, "Sem dinheiro!", 1);
				pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);
	            return true;
	        }

	        SlotCounter[playerid] = 40 + random(18);
            PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
            slot_Timer[playerid] = repeat PlayerBeginGambling(playerid);
            PlayerGamblingState[playerid] = G_STATE_GAMBLING;
         	PlayerBalance[playerid] -= PlayerBet[playerid];
			Updateslot_BetTD(playerid);
	    }
	}

	if(PRESSED(KEY_SECONDARY_ATTACK)) {
	    if(PlayerGamblingState[playerid] == G_STATE_READY) {
	    	SlotMachine_Exit(playerid);
	    }
	}

	if(PRESSED(KEY_JUMP)) {
	    if(PlayerGamblingState[playerid] == G_STATE_READY) {
	    	PlayerBet[playerid] = SlotMachine_NextValidBet(PlayerBet[playerid]);
	    	Updateslot_BetTD(playerid);
	    }
	}
	return true;
}

Dialog:DIALOG_SLOT_MACHINE(playerid, response, listitem, inputtext[]) {
    if(!response) {
        return true;
    }

	new
		money = strval(inputtext);

	if (money < MIN_BET)
		return Dialog_Show(playerid, DIALOG_SLOT_MACHINE, DIALOG_STYLE_INPUT, "Caça-Níquel", "Insira a quantidade que deseja apostar nesta máquina.\n\nERRO: Você deve colocar mais dinheiro na máquina!", "Continuar", "Cancelar");

	if (money > GetMoney(playerid))
	    return Dialog_Show(playerid, DIALOG_SLOT_MACHINE, DIALOG_STYLE_INPUT, "Caça-Níquel", "Insira a quantidade que deseja apostar nesta máquina.\n\nERRO: Você não tem todo esse dinheiro!", "Continuar", "Cancelar");
		
	if (money < 0)
		return Dialog_Show(playerid, DIALOG_SLOT_MACHINE, DIALOG_STYLE_INPUT, "Caça-Níquel", "Insira a quantidade que deseja apostar nesta máquina.\n\nERRO: Você não pode apostar um valor menor que zero!", "Continuar", "Cancelar");

	SlotMachine_Use(playerid, _, money);
    return true;
}