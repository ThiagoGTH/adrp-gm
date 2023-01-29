#include <YSI_Coding\y_hooks>

hook OnPlayerEnterCheckpoint(playerid, vehicleid, ispassenger) {
    DMV_EnterCheckpoint(playerid);
    return true;
}

hook OnPlayerExitVehicle(playerid, vehicleid) {
	if(IsPlayerNPC(playerid)) return true;		

	if(InDMV[playerid] == true) {
		SendErrorMessage(playerid, "Você abandonou o carro e por isso reprovou no exame de direção.");
		FailedExam(playerid);
	}
	return true;
}

hook OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate) {
	DMV_StateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate);
	return true;
}

StartTestingLicense(playerid) {
    if(DMVTestType[playerid] == 1){ //Carro
        GiveMoney(playerid, -DMV_VEHICLE_VALUE);
	    SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	    SetPlayerFacingAngle(playerid, 270.8737);
	    SetCameraBehindPlayer(playerid);

	    vehicleDMV[playerid] = CreateVehicle(DMV_VEHICLE, 1791.1338, -1933.0410, 13.0918, 1.000, random(127), random(127), -1);
	    SetVehicleVirtualWorld(vehicleDMV[playerid], false);

        new string[64];
        format(string, sizeof(string), "DMV #%3d", playerid);
        DMV3dTEXT[playerid] = Create3DTextLabel(string, COLOR_WHITE, 0.0, 0.0, -1000.0, 15.0, -1, false);
		Attach3DTextLabelToVehicle(DMV3dTEXT[playerid], vehicleDMV[playerid], -1.0, -1.0, 0.0);

        SetVehicleNumberPlate(vehicleDMV[playerid], "{FF0000}DMV");

        SendServerMessage(playerid, "Você iniciou o teste de direção para a licença de Motorista de carros.");
	    SendServerMessage(playerid, "Entre no Manana para continuar com o exame.");
	    InDMV[playerid] = true;
        return true;
    }
	return true;
}

FinishTestingLicense(playerid) {
	new Float:lataria;
	GetVehicleHealth(vehicleDMV[playerid], lataria);
	if(lataria <= DMV_MAX_VEHICLE_HEALTH) {
		SendErrorMessage(playerid, "O veículo está muito danificado e por isso você reprovou no exame.");
		FailedExam(playerid);
		return true;
	}

	SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	SetPlayerFacingAngle(playerid, 270.8737);
	SetCameraBehindPlayer(playerid);
	InDMV[playerid] = false;
	DestroyVehicle(vehicleDMV[playerid]);
    Delete3DTextLabel(DMV3dTEXT[playerid]);
	DisablePlayerCheckpoint(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	CreateNewLicense(playerid);
	return true;
}

SetDMVRoute(playerid) {
	if(InDMV[playerid]) {
        SetPlayerCheckpoint(playerid, 
        DMV_Checkpoint[DMVCheckpoint[playerid]][0], 
        DMV_Checkpoint[DMVCheckpoint[playerid]][1], 
        DMV_Checkpoint[DMVCheckpoint[playerid]][2], 
        5.0);
    }
	return true;
}

FailedExam(playerid) {
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	SetPlayerFacingAngle(playerid, 270.8737);
	SetCameraBehindPlayer(playerid);
	DestroyVehicle(vehicleDMV[playerid]);
    Delete3DTextLabel(DMV3dTEXT[playerid]);
	DisablePlayerCheckpoint(playerid);
	InDMV[playerid] = false;
    DMVTestType[playerid] = -1;
	return true;
}

DMVUpdate(playerid) {
	if(!IsPlayerInRangeOfPoint(playerid, 5, 
    DMV_Checkpoint[DMVCheckpoint[playerid]][0], 
    DMV_Checkpoint[DMVCheckpoint[playerid]][1], 
    DMV_Checkpoint[DMVCheckpoint[playerid]][2]))
		return SendErrorMessage(playerid, "Você não está no checkpoint correto.");

    new MaxCheckpoints;
	switch(DMVTestType[playerid]) {
		case 0: MaxCheckpoints = 8; //Carro
		case 1: MaxCheckpoints = 8; //Moto
		case 2: MaxCheckpoints = 1; //Caminhão
	}
	if(DMVCheckpoint[playerid] < MaxCheckpoints) {
		DisablePlayerCheckpoint(playerid);
		DMVCheckpoint[playerid]++;
		SetDMVRoute(playerid);
	} 
	else FinishTestingLicense(playerid);
	return true;
}

DMV_StateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate) {
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) {
  		if(!InDMV[playerid]) return true;
  		static 
			bool:engine, 
			bool:lights, 
			bool:alarm, 
			bool:doors, 
			bool:bonnet, 
			bool:boot, 
			bool:objective;
			
  		new vehicleid = GetPlayerVehicleID(playerid);
  		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		if(!(vehicleid == vehicleDMV[playerid])) return va_SendClientMessage(playerid, COLOR_GREEN, "Você precisa entrar no veículo.");
		SendServerMessage(playerid, "Você iniciou o exame. Siga os checkpoints e não danifique o veículo.");
		SetVehicleParamsEx(vehicleDMV[playerid], true, lights, alarm, doors, bonnet, boot, objective);
		SetDMVRoute(playerid);
	}
	return true;
}

DMV_EnterCheckpoint(playerid) {
	if(InDMV[playerid]) {
		new vehicleid = GetPlayerVehicleID(playerid);
		if(DMVTestType[playerid] == 0){ //Carro
			if (GetVehicleModel(vehicleid) != DMV_VEHICLE) {
		    	SendErrorMessage(playerid,"Você não está dirigindo o veículo correto e por isso o teste foi cancelado.");
		    	FailedExam(playerid);
			}
		}
		DisablePlayerCheckpoint(playerid);
        DMVUpdate(playerid);
	}
	return true;
}