#include <YSI_Coding\y_hooks>

hook OnPlayerEnterCheckpoint(playerid, vehicleid, ispassenger) {
    DMV_EnterCheckpoint(playerid);
    return true;
}

hook OnPlayerExitVehicle(playerid, vehicleid) {
	if(IsPlayerNPC(playerid)) return true;		

	if(emExame[playerid] == true) {
		SendErrorMessage(playerid, "Você abandonou o carro e por isso reprovou no exame de direção.");
		FailedExam(playerid);
	}
	return true;
}

hook OnPlayerStateChange(playerid, newstate, oldstate) {
	DMV_StateChange(playerid, newstate, oldstate);
	return true;
}

StartTestingLicence(playerid) {
    if(DMVTestType[playerid] == 0){ //Carro
	    pInfo[playerid][pMoney] -= PRECO_EXAME_CAR;
	    SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, playerid+1);
	    SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	    SetPlayerFacingAngle(playerid, 270.8737);
	    SetCameraBehindPlayer(playerid);
	    carrodmv[playerid] = CreateVehicle(DMV_VEICULO_CAR, 1791.1338, -1933.0410, 13.0918, 1.000, 0, 0, -1);
	    SetVehicleVirtualWorld(carrodmv[playerid], playerid+1);
        SendServerMessage(playerid, "Você iniciou o teste de direção para a licença de Motorista de carros.");
	    SendServerMessage(playerid, "Entre no manana para continuar com o exame.");
	    emExame[playerid] = true;
        return true;
    }
	return true;
}

FinishTestingLicence(playerid) {
	new Float:lataria;
	GetVehicleHealth(carrodmv[playerid], lataria);
	if(lataria <= MAX_VEHICLE_HEALTH){
		SendErrorMessage(playerid, "O veículo está muito danificado e por isso você reprovou no exame.");
		FailedExam(playerid);
		return true;
	}

	SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	SetPlayerFacingAngle(playerid, 270.8737);
	SetCameraBehindPlayer(playerid);
	emExame[playerid] = false;
	DestroyVehicle(carrodmv[playerid]);
	DisablePlayerCheckpoint(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	CreateNewLicence(playerid);
	return true;
}

SetDMVRoute(playerid) {
	if(emExame[playerid]) SetPlayerCheckpoint(playerid, 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][0], 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][1], 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][2], 5.0);
	return true;
}

FailedExam(playerid) {
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	SetPlayerFacingAngle(playerid, 270.8737);
	SetCameraBehindPlayer(playerid);
	DestroyVehicle(carrodmv[playerid]);
	DisablePlayerCheckpoint(playerid);
	emExame[playerid] = false;
    DMVTestType[playerid] = -1;
	return true;
}

DMVUpdate(playerid) {
	if(!IsPlayerInRangeOfPoint(playerid, 5, 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][0], 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][1], 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][2]))
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
	else FinishTestingLicence(playerid);
	return true;
}

DMV_StateChange(playerid, newstate, oldstate) {
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) {
  		if(!emExame[playerid]) return true;
  		new engine, lights, alarm, doors, bonnet, boot, objective,
  			vehicleid = GetPlayerVehicleID(playerid);
  		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		if(!(vehicleid == carrodmv[playerid])) return va_SendClientMessage(playerid, COLOR_GREEN, "Você precisa entrar no veículo.");
		SendServerMessage(playerid, "Você iniciou o exame. Siga os checkpoints e não danifique o veículo.");
		SetVehicleParamsEx(carrodmv[playerid], true, lights, alarm, doors, bonnet, boot, objective);
		SetDMVRoute(playerid);
	}
	return true;
}

DMV_EnterCheckpoint(playerid) {
	if(emExame[playerid]) {
		new vehicleid = GetPlayerVehicleID(playerid);
		if(DMVTestType[playerid] == 0){ //Carro
			if (GetVehicleModel(vehicleid) != DMV_VEICULO_CAR) {
		    	SendErrorMessage(playerid,"Você não está dirigindo o veículo correto e por isso o teste foi cancelado.");
		    	FailedExam(playerid);
			}
		}
		DisablePlayerCheckpoint(playerid);
        DMVUpdate(playerid);
	}
	return true;
}