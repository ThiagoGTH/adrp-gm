#include <YSI_Coding\y_hooks>

new PlayerText:LockText[12], bool:LockUse[MAX_PLAYERS], Float:LockProgress = 207.0, Float:LockLocation[MAX_PLAYERS], Float:LockSize[MAX_PLAYERS], LockCount[MAX_PLAYERS], LockTimer[MAX_PLAYERS], Correct[MAX_PLAYERS], VehicleLockedID[MAX_PLAYERS];
new bool:EngineLP[MAX_PLAYERS], bool:LightsLP[MAX_PLAYERS], bool:AlarmLP[MAX_PLAYERS], bool:DoorsLockPick[MAX_PLAYERS], bool:BonnetLP[MAX_PLAYERS], bool:BootLP[MAX_PLAYERS], bool:ObjectiveLP[MAX_PLAYERS];

CMD:quebrartrava(playerid) {
    new Float:VehX, Float:VehY, Float:VehZ, Count;
	if(LockUse[playerid] == true) return SendErrorMessage(playerid, "Você já está tentando quebrar a trava deste veículo.");
    for(new i; i < MAX_VEHICLES; i++) {
        GetVehiclePos(i, VehX, VehY, VehZ);
    	if(IsPlayerInRangeOfPoint(playerid, 2.0, VehX, VehY, VehZ)) {
    	    Count++, VehicleLockedID[playerid] = i;
    	    if(Count == 1) break;
		}
	}
	if(Count == 0) return SendErrorMessage(playerid, "Não há nenhum veículo por perto.");
	GetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], AlarmLP[playerid], DoorsLockPick[playerid], BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]);
	LockUse[playerid] = true;
	LockCount[playerid] = 0;
	CreateLocPick(playerid);
	PC_EmulateCommand(playerid, "/ame pega um lockpick e tenta arrombar o veículo.");
	for(new i; i < 12; i++) { PlayerTextDrawShow(playerid, LockText[i]); }
	return true;
}

hook OnPlayerConnect(playerid) {
	LockText[0] = CreatePlayerTextDraw(playerid, 320.0, 360.0, "_");
	PlayerTextDrawUseBox(playerid, LockText[0], true);
	PlayerTextDrawLetterSize(playerid, LockText[0], 0.5, 5.599999);
	PlayerTextDrawTextSize(playerid, LockText[0], 20.0, 240.0);
	PlayerTextDrawFont(playerid, LockText[0], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, LockText[0], true);
	PlayerTextDrawAlignment(playerid, LockText[0], TEXT_DRAW_ALIGN:2);
	PlayerTextDrawBackgroundColour(playerid, LockText[0], -65281);
	PlayerTextDrawBoxColour(playerid, LockText[0], 150);

	new text[128];
	format(text, 128, "QUANTIDADE_NECESSÁRIA:_5");
	AdjustTextDrawString(text);
	LockText[1] = CreatePlayerTextDraw(playerid, 205.0, 365.0, text);
	PlayerTextDrawSetShadow(playerid, LockText[1], 0);
	PlayerTextDrawBackgroundColour(playerid, LockText[1], 255);
	PlayerTextDrawLetterSize(playerid, LockText[1], 0.2, 1.2);
	PlayerTextDrawFont(playerid, LockText[1], TEXT_DRAW_FONT_2);
	PlayerTextDrawSetProportional(playerid, LockText[1], true);

	LockText[2] = CreatePlayerTextDraw(playerid, 361.0, 364.0, "LD_BEAT:CHIT");
	PlayerTextDrawUseBox(playerid, LockText[2], true);
	PlayerTextDrawFont(playerid, LockText[2], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, LockText[2], true);
	PlayerTextDrawLetterSize(playerid, LockText[2], 0.4, -2.0);
	PlayerTextDrawTextSize(playerid, LockText[2], 15.0, 15.0);

	LockText[3] = CreatePlayerTextDraw(playerid, 375.0, 364.0, "LD_BEAT:CHIT");
	PlayerTextDrawUseBox(playerid, LockText[3], true);
	PlayerTextDrawFont(playerid, LockText[3], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, LockText[3], true);
	PlayerTextDrawLetterSize(playerid, LockText[3], 0.4, -2.0);
	PlayerTextDrawTextSize(playerid, LockText[3], 15.0, 15.0);

	LockText[4] = CreatePlayerTextDraw(playerid, 389.0, 364.0, "LD_BEAT:CHIT");
	PlayerTextDrawUseBox(playerid, LockText[4], true);
	PlayerTextDrawFont(playerid, LockText[4], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, LockText[4], true);
	PlayerTextDrawLetterSize(playerid, LockText[4], 0.4, -2.0);
	PlayerTextDrawTextSize(playerid, LockText[4], 15.0, 15.0);

	LockText[5] = CreatePlayerTextDraw(playerid, 403.0, 364.0, "LD_BEAT:CHIT");
	PlayerTextDrawUseBox(playerid, LockText[5], true);
	PlayerTextDrawFont(playerid, LockText[5], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, LockText[5], true);
	PlayerTextDrawLetterSize(playerid, LockText[5], 0.4, -2.0);
	PlayerTextDrawTextSize(playerid, LockText[5], 15.0, 15.0);

	LockText[6] = CreatePlayerTextDraw(playerid, 417.0, 364.0, "LD_BEAT:CHIT");
	PlayerTextDrawUseBox(playerid, LockText[6], true);
	PlayerTextDrawFont(playerid, LockText[6], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, LockText[6], true);
	PlayerTextDrawLetterSize(playerid, LockText[6], 0.4, -2.0);
	PlayerTextDrawTextSize(playerid, LockText[6], 15.0, 15.0);

	LockText[7] = CreatePlayerTextDraw(playerid, 318.0, 385.0, "_");
	PlayerTextDrawUseBox(playerid, LockText[7], true);
	PlayerTextDrawLetterSize(playerid, LockText[7], 0.5, 1.4);
	PlayerTextDrawTextSize(playerid, LockText[7], 0.0, -229.0);
	PlayerTextDrawFont(playerid, LockText[7], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, LockText[7], true);
	PlayerTextDrawAlignment(playerid, LockText[7], TEXT_DRAW_ALIGN:2);
	PlayerTextDrawBackgroundColour(playerid, LockText[7], 255);
	PlayerTextDrawBoxColour(playerid, LockText[7], 1768516095);

	LockText[11] = CreatePlayerTextDraw(playerid, 320.0, 414.0, "_");
	PlayerTextDrawUseBox(playerid, LockText[11], true);
	PlayerTextDrawLetterSize(playerid, LockText[11], 0.5, -0.1);
	PlayerTextDrawTextSize(playerid, LockText[11], 20.0, 240.0);
	PlayerTextDrawFont(playerid, LockText[11], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, LockText[11], true);
	PlayerTextDrawAlignment(playerid, LockText[11], TEXT_DRAW_ALIGN:2);
	PlayerTextDrawBackgroundColour(playerid, LockText[11], -65281);
	PlayerTextDrawBoxColour(playerid, LockText[11], -5963521);
	return true;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {
    if(newkeys == KEY_SPRINT)
    {
        if(LockUse[playerid] == true)
        {
            if(LockProgress < LockLocation[playerid]-(LockSize[playerid]+1) || LockProgress > LockLocation[playerid]+(LockSize[playerid]+2))
			{
			    PlayerTextDrawColour(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA);
				if(LockCount[playerid] < 4) return DestroyLockPick(playerid), KillTimer(LockTimer[playerid]), LockCount[playerid]++, LockProgress = 207.0, CreateLocPick(playerid);
                if(LockCount[playerid] == 4) {
					PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]), SetTimerEx("DestroyLockPick", 2000, false, "i", playerid), KillTimer(LockTimer[playerid]);
					if(Correct[playerid] != 5) return SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], true, DoorsLockPick[playerid], BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]), SendServerMessage(playerid, "Você não conseguiu destravar o veículo e o alarme foi acionado."), format(logString, sizeof(logString), "%s (%s) falhou em usar o lockpick no veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);
					if(DoorsLockPick[playerid] == false) return SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], AlarmLP[playerid], true, BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]), SendServerMessage(playerid, "Você trancou o veículo."), format(logString, sizeof(logString), "%s (%s) usou o lockpick e trancou o veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);
					SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], AlarmLP[playerid], false, BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]), SendServerMessage(playerid, "Você destrancou o veículo."), format(logString, sizeof(logString), "%s (%s) usou o lockpick e destrancou o veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);
				}
			} else {
				PlayerTextDrawColour(playerid, LockText[LockCount[playerid]+2], 0x00FF00AA), Correct[playerid]++;
                if(LockCount[playerid] < 4) return DestroyLockPick(playerid), KillTimer(LockTimer[playerid]), LockCount[playerid]++, LockProgress = 207.0, CreateLocPick(playerid);
                if(LockCount[playerid] == 4)
				{
					PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]), SetTimerEx("DestroyLockPick", 2000, false, "i", playerid), KillTimer(LockTimer[playerid]);

					if(Correct[playerid] != 5) return SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], true, DoorsLockPick[playerid], BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]), SendServerMessage(playerid, "Você não conseguiu destravar o veículo e o alarme foi acionado."), format(logString, sizeof(logString), "%s (%s) falhou em usar o lockpick no veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);

					if(DoorsLockPick[playerid] == false) return SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], AlarmLP[playerid], true, BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]), SendServerMessage(playerid, "Você trancou o veículo."), format(logString, sizeof(logString), "%s (%s) usou o lockpick e trancou o veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);
        
					SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], AlarmLP[playerid], false, BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]), SendServerMessage(playerid, "Você destrancou o veículo."), format(logString, sizeof(logString), "%s (%s) usou o lockpick e destrancou o veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);
				}
			}
		}
	}
	return true;
}

CreateLocPick(playerid) {
	ApplyAnimation(playerid, "INT_HOUSE", "WASH_UP", 4.1, true, false, false, false, 2000, t_FORCE_SYNC:1);
	LockLocation[playerid] = randomEx(243, 423);
	LockSize[playerid] = randomEx(2, 10);
	LockTimer[playerid] = SetTimerEx("LockpickTimer", 30, true, "i", playerid);

	LockText[8] = CreatePlayerTextDraw(playerid, LockLocation[playerid], 385.0, "_");
	PlayerTextDrawUseBox(playerid, LockText[8], true);
	PlayerTextDrawLetterSize(playerid, LockText[8], 0.5, 1.4);
	PlayerTextDrawTextSize(playerid, LockText[8], LockLocation[playerid]+LockSize[playerid], 71.0);
	PlayerTextDrawFont(playerid, LockText[8], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, LockText[8], true);
	PlayerTextDrawBackgroundColour(playerid, LockText[8], 255);
	PlayerTextDrawBoxColour(playerid, LockText[8], -1094795521);
	
	LockText[9] = CreatePlayerTextDraw(playerid, 207.0, 385.0, "_");
	PlayerTextDrawUseBox(playerid, LockText[9], true);
	PlayerTextDrawLetterSize(playerid, LockText[9], 0.5, 1.4);
	PlayerTextDrawTextSize(playerid, LockText[9], 207.0, 71.0);
	PlayerTextDrawFont(playerid, LockText[9], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, LockText[9], true);
	PlayerTextDrawBackgroundColour(playerid, LockText[9], 255);
	PlayerTextDrawBoxColour(playerid, LockText[9], -5963521);

	new text[128];
	format(text, 128, "PRESSIONE O ESPAÇO NO MOMENTO PARA PROSSEGUIR");
	AdjustTextDrawString(text);
	LockText[10] = CreatePlayerTextDraw(playerid, 315.0, 386.0, text);
	PlayerTextDrawSetShadow(playerid, LockText[10], 0);
	PlayerTextDrawBackgroundColour(playerid, LockText[10], 255);
	PlayerTextDrawLetterSize(playerid, LockText[10], 0.18, 1.0);
	PlayerTextDrawFont(playerid, LockText[10], TEXT_DRAW_FONT_2);
	PlayerTextDrawSetProportional(playerid, LockText[10], true);
	PlayerTextDrawAlignment(playerid, LockText[10], TEXT_DRAW_ALIGN:2);
	PlayerTextDrawSetShadow(playerid, LockText[10], 0);
	PlayerTextDrawColour(playerid, LockText[10], -56);
	return true;
}

forward LockpickTimer(playerid); public LockpickTimer(playerid) {
	LockProgress = LockProgress+4;
	PlayerTextDrawTextSize(playerid, LockText[9], LockProgress, 71.0);
	for(new i; i < 12; i++) { PlayerTextDrawShow(playerid, LockText[i]); }
	if(LockCount[playerid] < 4 && LockProgress > 428.9) {
		PlayerTextDrawColour(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA);
		DestroyLockPick(playerid);
		KillTimer(LockTimer[playerid]);
		LockCount[playerid]++;
		LockProgress = 207.0;
		CreateLocPick(playerid);
		return true;
	}
	if(LockCount[playerid] == 4 && LockProgress > 428.9) {
		PlayerTextDrawColour(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA);
		PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]);
		SetTimerEx("DestroyLockPick", 2000, false, "i", playerid);
		KillTimer(LockTimer[playerid]);
    	if(Correct[playerid] != 5) {
			SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], true, DoorsLockPick[playerid], BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]);
			SendServerMessage(playerid, "Você não conseguiu destravar o veículo e o alarme foi acionado."), format(logString, sizeof(logString), "%s (%s) falhou em usar o lockpick no veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);
			return true;
		}
		if(DoorsLockPick[playerid] == false) {
			SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], AlarmLP[playerid], true, BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]);
			SendServerMessage(playerid, "Você usou o lockpick e o veículo foi trancado."), format(logString, sizeof(logString), "%s (%s) usou o lockpick e trancou o veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);
			Correct[playerid] = 0;
			return true;
		}
		SetVehicleParamsEx(VehicleLockedID[playerid], EngineLP[playerid], LightsLP[playerid], AlarmLP[playerid], false, BonnetLP[playerid], BootLP[playerid], ObjectiveLP[playerid]);
		SendServerMessage(playerid, "Você usou o lockpick e o veículo foi aberto."), format(logString, sizeof(logString), "%s (%s) usou o lockpick e trancou o veículo %d/%d", pNome(playerid), GetPlayerUserEx(playerid), VehicleLockedID[playerid], vInfo[VehicleLockedID[playerid]][vID]), logCreate(playerid, logString, 17);
		Correct[playerid] = 0;
	}
	return true;
}

forward DestroyLockPick(playerid); public DestroyLockPick(playerid) {
    PlayerTextDrawDestroy(playerid, LockText[8]), PlayerTextDrawDestroy(playerid, LockText[9]), PlayerTextDrawDestroy(playerid, LockText[10]);
    if(LockCount[playerid] == 4) {
		PlayerTextDrawColour(playerid, LockText[2], 1768516095);
		PlayerTextDrawColour(playerid, LockText[3], 1768516095);
		PlayerTextDrawColour(playerid, LockText[4], 1768516095);
		PlayerTextDrawColour(playerid, LockText[5], 1768516095);
		PlayerTextDrawColour(playerid, LockText[6], 1768516095);
		LockUse[playerid] = false;
		LockProgress = 207.0;
		Correct[playerid] = 0;
		LockCount[playerid] = 0;
		for(new i; i < 12; i++) { PlayerTextDrawHide(playerid, LockText[i]); }
	}
	return false;
}

forward TurnAlarmOff(vehicleid);
public TurnAlarmOff(vehicleid) {
	if(vehicleid != INVALID_VEHICLE_ID) {
	    static bool:engine2, bool:lights2, bool:alarm2, bool:doors2, bool:bonnet2, bool:boot2, bool:objective2;

		GetVehicleParamsEx(vehicleid, engine2, lights2, alarm2, doors2, bonnet2, boot2, objective2);
		SetVehicleParamsEx(vehicleid, engine2, false, false, doors2, bonnet2, boot2, objective2);
	}
	return true;
}