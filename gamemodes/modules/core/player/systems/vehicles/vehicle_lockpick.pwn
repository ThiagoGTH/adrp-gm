#include <YSI_Coding\y_hooks>

new PlayerText:LockText[12], bool:LockUse[MAX_PLAYERS], Float:LockProgress = 207.0, Float:LockLocation[MAX_PLAYERS], Float:LockSize[MAX_PLAYERS], LockCount[MAX_PLAYERS], LockTimer[MAX_PLAYERS], Correct[MAX_PLAYERS], VehicleLockedID[MAX_PLAYERS];
new Engine[MAX_PLAYERS], Lights[MAX_PLAYERS], Alarm[MAX_PLAYERS], DoorsLockPick[MAX_PLAYERS], Bonnet[MAX_PLAYERS], Boot[MAX_PLAYERS], Objective[MAX_PLAYERS];

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
	GetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]), LockUse[playerid] = true, LockCount[playerid] = 0, CreateLocPick(playerid);
	for(new i; i < 12; i++) { PlayerTextDrawShow(playerid, LockText[i]); }
	return 1;
}
hook OnPlayerConnect(playerid)
{
	LockText[0] = CreatePlayerTextDraw(playerid, 320.0, 360.0, "_"), PlayerTextDrawUseBox(playerid, LockText[0], 1);
	PlayerTextDrawLetterSize(playerid, LockText[0], 0.5, 5.599999), PlayerTextDrawTextSize(playerid, LockText[0], 20.0, 240.0);
	PlayerTextDrawFont(playerid, LockText[0], 1), PlayerTextDrawSetProportional(playerid, LockText[0], 1), PlayerTextDrawAlignment(playerid, LockText[0], 2);
	PlayerTextDrawBackgroundColor(playerid, LockText[0], -65281), PlayerTextDrawBoxColor(playerid, LockText[0], 150);

	new text[128];
	format(text, 128, "QUANTIDADE_NECESSÁRIA:_5");
	AdjustTextDrawString(text);
	LockText[1] = CreatePlayerTextDraw(playerid, 205.0, 365.0, text);
	PlayerTextDrawSetShadow(playerid, LockText[1], 0);
	PlayerTextDrawBackgroundColor(playerid, LockText[1], 255);
	PlayerTextDrawLetterSize(playerid, LockText[1], 0.2, 1.2);
	PlayerTextDrawFont(playerid, LockText[1], 2);
	PlayerTextDrawSetProportional(playerid, LockText[1], 1);

	LockText[2] = CreatePlayerTextDraw(playerid, 361.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[2], 1);
	PlayerTextDrawFont(playerid, LockText[2], 4), PlayerTextDrawSetProportional(playerid, LockText[2], 1);
	PlayerTextDrawLetterSize(playerid, LockText[2], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[2], 15.0, 15.0);

	LockText[3] = CreatePlayerTextDraw(playerid, 375.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[3], 1);
	PlayerTextDrawFont(playerid, LockText[3], 4), PlayerTextDrawSetProportional(playerid, LockText[3], 1);
	PlayerTextDrawLetterSize(playerid, LockText[3], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[3], 15.0, 15.0);

	LockText[4] = CreatePlayerTextDraw(playerid, 389.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[4], 1);
	PlayerTextDrawFont(playerid, LockText[4], 4), PlayerTextDrawSetProportional(playerid, LockText[4], 1);
	PlayerTextDrawLetterSize(playerid, LockText[4], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[4], 15.0, 15.0);

	LockText[5] = CreatePlayerTextDraw(playerid, 403.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[5], 1);
	PlayerTextDrawFont(playerid, LockText[5], 4), PlayerTextDrawSetProportional(playerid, LockText[5], 1);
	PlayerTextDrawLetterSize(playerid, LockText[5], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[5], 15.0, 15.0);

	LockText[6] = CreatePlayerTextDraw(playerid, 417.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[6], 1);
	PlayerTextDrawFont(playerid, LockText[6], 4), PlayerTextDrawSetProportional(playerid, LockText[6], 1);
	PlayerTextDrawLetterSize(playerid, LockText[6], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[6], 15.0, 15.0);

	LockText[7] = CreatePlayerTextDraw(playerid, 318.0, 385.0, "_"), PlayerTextDrawUseBox(playerid, LockText[7], 1);
	PlayerTextDrawLetterSize(playerid, LockText[7], 0.5, 1.4), PlayerTextDrawTextSize(playerid, LockText[7], 0.0, -229.0);
	PlayerTextDrawFont(playerid, LockText[7], 1), PlayerTextDrawSetProportional(playerid, LockText[7], 1), PlayerTextDrawAlignment(playerid, LockText[7], 2);
	PlayerTextDrawBackgroundColor(playerid, LockText[7], 255), PlayerTextDrawBoxColor(playerid, LockText[7], 1768516095);

	LockText[11] = CreatePlayerTextDraw(playerid, 320.0, 414.0, "_"), PlayerTextDrawUseBox(playerid, LockText[11], 1);
	PlayerTextDrawLetterSize(playerid, LockText[11], 0.5, -0.1), PlayerTextDrawTextSize(playerid, LockText[11], 20.0, 240.0);
	PlayerTextDrawFont(playerid, LockText[11], 1), PlayerTextDrawSetProportional(playerid, LockText[11], 1), PlayerTextDrawAlignment(playerid, LockText[11], 2);
	PlayerTextDrawBackgroundColor(playerid, LockText[11], -65281), PlayerTextDrawBoxColor(playerid, LockText[11], -5963521);
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_SPRINT)
    {
        if(LockUse[playerid] == true)
        {
            if(LockProgress < LockLocation[playerid]-(LockSize[playerid]+1) || LockProgress > LockLocation[playerid]+(LockSize[playerid]+2))
			{
			    PlayerTextDrawColor(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA);
				if(LockCount[playerid] < 4) {
					DestroyLockPick(playerid);
					KillTimer(LockTimer[playerid]);
					LockCount[playerid]++;
					LockProgress = 207.0;
					CreateLocPick(playerid);
					return true;
				}
                if(LockCount[playerid] == 4)
				{
					PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]);
					SetTimerEx("DestroyLockPick", 2000, false, "i", playerid);
					KillTimer(LockTimer[playerid]);

					if(Correct[playerid] != 5){
						if(Lights[playerid] == 1){
							SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], false, true, DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]);
							SendServerMessage(playerid, "Você não conseguiu destravar o veículo e o alarme foi acionado.");

						} else {
							SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], true, true, DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]);
							SendServerMessage(playerid, "Você não conseguiu destravar o veículo e o alarme foi acionado.");
						}

						SetTimerEx("TurnAlarmOff", 10000, false, "d", VehicleLockedID[playerid]);
						return true;
					}
					if(DoorsLockPick[playerid] == 0) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 1, Bonnet[playerid], Boot[playerid], Objective[playerid]), SendClientMessage(playerid, -1, "O veiculo foi trancado!");
					SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 0, Bonnet[playerid], Boot[playerid], Objective[playerid]), SendClientMessage(playerid, -1, "O veiculo foi aberto!");
				}
			}
			else
			{
				PlayerTextDrawColor(playerid, LockText[LockCount[playerid]+2], 0x00FF00AA), Correct[playerid]++;
                if(LockCount[playerid] < 4) return DestroyLockPick(playerid), KillTimer(LockTimer[playerid]), LockCount[playerid]++, LockProgress = 207.0, CreateLocPick(playerid);
                if(LockCount[playerid] == 4)
				{
					PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]), SetTimerEx("DestroyLockPick", 2000, false, "i", playerid), KillTimer(LockTimer[playerid]);
					if(Correct[playerid] != 5) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], 1, DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]), SendClientMessage(playerid, -1, "Você não conseguiu acertar a lockpick e acionou o alarme!");
					if(DoorsLockPick[playerid] == 0) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 1, Bonnet[playerid], Boot[playerid], Objective[playerid]), SendClientMessage(playerid, -1, "O veiculo foi trancado!");
					SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 0, Bonnet[playerid], Boot[playerid], Objective[playerid]), SendClientMessage(playerid, -1, "O veiculo foi aberto!");
				}
			}
		}
	}
	return 1;
}
CreateLocPick(playerid)
{
	ApplyAnimation(playerid, "INT_HOUSE", "WASH_UP", 4.1, 1, 0, 0, 0, 2000, 1), LockLocation[playerid] = randomEx(243, 423), LockSize[playerid] = randomEx(2, 10), LockTimer[playerid] = SetTimerEx("LockpickTimer", 30, true, "i", playerid);
	LockText[8] = CreatePlayerTextDraw(playerid, LockLocation[playerid], 385.0, "_"), PlayerTextDrawUseBox(playerid, LockText[8], 1);
	PlayerTextDrawLetterSize(playerid, LockText[8], 0.5, 1.4), PlayerTextDrawTextSize(playerid, LockText[8], LockLocation[playerid]+LockSize[playerid], 71.0);
	PlayerTextDrawFont(playerid, LockText[8], 1), PlayerTextDrawSetProportional(playerid, LockText[8], 1);
	PlayerTextDrawBackgroundColor(playerid, LockText[8], 255), PlayerTextDrawBoxColor(playerid, LockText[8], -1094795521);
	
	LockText[9] = CreatePlayerTextDraw(playerid, 207.0, 385.0, "_"), PlayerTextDrawUseBox(playerid, LockText[9], 1);
	PlayerTextDrawLetterSize(playerid, LockText[9], 0.5, 1.4), PlayerTextDrawTextSize(playerid, LockText[9], 207.0, 71.0);
	PlayerTextDrawFont(playerid, LockText[9], 1), PlayerTextDrawSetProportional(playerid, LockText[9], 1);
	PlayerTextDrawBackgroundColor(playerid, LockText[9], 255), PlayerTextDrawBoxColor(playerid, LockText[9], -5963521);

	new text[128];
	format(text, 128, "PRECIONE O ESPAÇO NO MOMENTO PARA PROSSEGUIR");
	AdjustTextDrawString(text);
	LockText[10] = CreatePlayerTextDraw(playerid, 315.0, 386.0, text);
	PlayerTextDrawSetShadow(playerid, LockText[10], 0);
	PlayerTextDrawBackgroundColor(playerid, LockText[10], 255);
	PlayerTextDrawLetterSize(playerid, LockText[10], 0.18, 1.0);
	PlayerTextDrawFont(playerid, LockText[10], 2);
	PlayerTextDrawSetProportional(playerid, LockText[10], 1);
	PlayerTextDrawAlignment(playerid, LockText[10], 2);
	PlayerTextDrawSetShadow(playerid, LockText[10], 0);
	PlayerTextDrawColor(playerid, LockText[10], -56);
	return 1;
}
forward LockpickTimer(playerid); public LockpickTimer(playerid)
{
	LockProgress = LockProgress+4, PlayerTextDrawTextSize(playerid, LockText[9], LockProgress, 71.0);
	for(new i; i < 12; i++) { PlayerTextDrawShow(playerid, LockText[i]); }
	if(LockCount[playerid] < 4 && LockProgress > 428.9) return PlayerTextDrawColor(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA), DestroyLockPick(playerid), KillTimer(LockTimer[playerid]), LockCount[playerid]++, LockProgress = 207.0, CreateLocPick(playerid);
	if(LockCount[playerid] == 4 && LockProgress > 428.9)
	{
		PlayerTextDrawColor(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA), PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]), SetTimerEx("DestroyLockPick", 2000, false, "i", playerid), KillTimer(LockTimer[playerid]);
    	if(Correct[playerid] != 5) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], 1, DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]), SendClientMessage(playerid, -1, "Você não conseguiu acertar a lockpick e acionou o alarme!");

		if(DoorsLockPick[playerid] == 0) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 1, Bonnet[playerid], Boot[playerid], Objective[playerid]), SendClientMessage(playerid, -1, "O veiculo foi trancado!"), Correct[playerid] = 0;
		
		SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 0, Bonnet[playerid], Boot[playerid], Objective[playerid]), SendClientMessage(playerid, -1, "O veiculo foi aberto!"), Correct[playerid] = 0;
	}
	return 1;
}

forward DestroyLockPick(playerid); public DestroyLockPick(playerid) {
    PlayerTextDrawDestroy(playerid, LockText[8]), PlayerTextDrawDestroy(playerid, LockText[9]), PlayerTextDrawDestroy(playerid, LockText[10]);
    if(LockCount[playerid] == 4)
    {
		PlayerTextDrawColor(playerid, LockText[2], 1768516095), PlayerTextDrawColor(playerid, LockText[3], 1768516095), PlayerTextDrawColor(playerid, LockText[4], 1768516095), PlayerTextDrawColor(playerid, LockText[5], 1768516095), PlayerTextDrawColor(playerid, LockText[6], 1768516095);
		LockUse[playerid] = false, LockProgress = 207.0, Correct[playerid] = 0, LockCount[playerid] = 0;
		for(new i; i < 12; i++) { PlayerTextDrawHide(playerid, LockText[i]); }
	}
	return 0;
}

forward TurnAlarmOff(vehicleid);
public TurnAlarmOff(vehicleid)
{
	if(vehicleid != INVALID_VEHICLE_ID)
	{
	    static
			engine2, lights2, alarm2, doors2, bonnet2, boot2, objective2;

		GetVehicleParamsEx(vehicleid, engine2, lights2, alarm2, doors2, bonnet2, boot2, objective2);
		SetVehicleParamsEx(vehicleid, engine2, false, false, doors2, bonnet2, boot2, objective2);
	}
	return 1;
}