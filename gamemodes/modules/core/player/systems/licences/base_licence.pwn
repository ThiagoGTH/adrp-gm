/*

Modulo destinado a compor todo o sistema de Licenças.

Legenda:
STATUS da Licença

NENHUM - O
ATIVA - 1
SUSPENSA - 2
REVOGADA - 3


Observação de Funcionamento: As licenças não vão resetar, apenas mudar de STATUS conforme disposto acima.
A licença será gerada quando o jogador escolher qual teste irá fazer primeiro (Moto, Carro, Caminhão) e
irá sofrer um "UPGRADE" sempre que o jogador for tirar a próxima.

*/
#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
	CreateDMVIcon();
    return true;
}

CMD:criarlicenca(playerid, params[]){
	CreateNewLicence(playerid);
	return true;
}

CMD:mostrarlicenca(playerid, params[]) {
	if(pInfo[playerid][pLicence] == 0) return SendErrorMessage(playerid,"Você não tem uma licença de motorista.");
	
	for(new i; i < MAX_DRIVERLICENCE; i++) if(pLicences[i][licence_owner] == pInfo[playerid][pID]) {
		new status[20],
			status_car[20],
			status_medical[20],
			status_plane[20],
			status_gun[20];

		switch(pLicences[i][licence_status]){
			case 0: status = "NENHUM";
			case 1: status = "ATIVA";
			case 2: status = "SUSPENSA";
			case 3: status = "REVOGADA";
		}
		switch(pLicences[i][licence_vehicle]){
			case 0: status_car = "Não";
			case 1: status_car = "Sim";
		}
		switch(pLicences[i][licence_medical]){
			case 0: status_medical = "Não";
			case 1: status_medical = "Sim";
		}
		switch(pLicences[i][licence_plane]){
			case 0: status_plane = "Não";
			case 1: status_plane = "Sim";
		}
		switch(pLicences[i][licence_gun]){
			case 0: status_gun = "Não";
			case 1: status_gun = "Sim";
		}
		new avisos = CountLicenceWarnings(i);

		new targetid;
		if(sscanf(params, "u", targetid)){
			va_SendClientMessage(playerid, COLOR_GREEN,"|_______________Licenças_____________|");
			va_SendClientMessage(playerid, COLOR_GREY, "Nome: %s", GetPlayerNameEx(playerid));
			va_SendClientMessage(playerid, COLOR_GREY, "Número: %d", pLicences[i][licence_number]);
			va_SendClientMessage(playerid, COLOR_GREY, "Status: %s", status);
			va_SendClientMessage(playerid, COLOR_GREY, "Tipos: (Veículos: %s) | (Aviões: %s) | (Médica: %s) | (Armas: %s)", status_car, status_plane, status_medical, status_gun);
			va_SendClientMessage(playerid, COLOR_GREY, "Advertências: (%d/3)", avisos);
			va_SendClientMessage(playerid, COLOR_GREEN,"(Licença Motorista):{FFFFFF} Você pode mostrar sua licença para outro jogador. Use '/licencamotorista playerID'.");
		}else{
			if(!pInfo[targetid][pLogged]) return SendErrorMessage(playerid, "Este jogador não está logado.");
			if (!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste player.");
			if (playerid == targetid) return SendErrorMessage(playerid, "Você não pode mostrar sua licença para você mesmo.");

			va_SendClientMessage(targetid, COLOR_GREY,"|_______________Licenças_____________|");
			va_SendClientMessage(targetid, COLOR_GREY, "Nome: %s", GetPlayerNameEx(playerid));
			va_SendClientMessage(targetid, COLOR_GREY, "Número: %d", pLicences[i][licence_number]);
			va_SendClientMessage(targetid, COLOR_GREY, "Status: %s", status);
			va_SendClientMessage(playerid, COLOR_GREY, "Tipos: (Veículos: %s) | (Aviões: %s) | (Médica: %s) | (Armas: %s)", status_car, status_plane, status_medical, status_gun);
			va_SendClientMessage(targetid, COLOR_GREY, "Advertências: (%d/3)", avisos);
		}
	}
	return true;
}

//Lembrar de Adicionar a função de apenas fac policial poder usar
CMD:removeravisoslicenca(playerid, params[]) {
    new targetid; 

    if(sscanf(params, "u", targetid)) return SendSyntaxMessage(playerid, "/removeravisoslicenca [playerID/Nome]");
	
	if(!pInfo[targetid][pLogged]) return SendErrorMessage(playerid, "Este jogador não está logado.");
	if (!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste player.");
	if (playerid == targetid) return SendErrorMessage(playerid, "Você não pode remover os avisos da sua licença.");
  
    va_SendClientMessage(playerid, COLOR_GREEN, "(Licença):{FFFFFF} Você limpou os avisos da licença de %s.", GetPlayerNameEx(targetid));
	va_SendClientMessage(targetid, COLOR_GREEN, "(Licença):{FFFFFF} O oficial %s limpou os avisos na sua licença.", GetPlayerNameEx(playerid));
    ResetLicenceWarnings(targetid);
	return true;
}


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

StartTestingLicence(playerid){
    if(DMVTestType[playerid] == 0){ //Carro
	    pInfo[playerid][pMoney] -= PRECO_EXAME_CAR;
	    SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, playerid+1);
	    SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	    SetPlayerFacingAngle(playerid, 270.8737);
	    SetCameraBehindPlayer(playerid);
	    carrodmv[playerid] = CreateVehicle(DMV_VEICULO_CAR, 1791.1338, -1933.0410, 13.0918, 1.000, 0, 0, -1);
	    SetVehicleVirtualWorld(carrodmv[playerid], playerid+1);
        va_SendClientMessage(playerid, COLOR_GREEN, "DMV:{FFFFFF} Você iniciou o teste de direção para a licença de Motorista de carros.");
	    va_SendClientMessage(playerid, COLOR_GREEN, "DMV:{FFFFFF} Entre no manana para continuar com o exame.");
	    emExame[playerid] = true;
        return true;
    }
	return true;
}

FinishTestingLicence(playerid){

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

SetDMVRoute(playerid)
{
	if(emExame[playerid]) SetPlayerCheckpoint(playerid, 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][0], 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][1], 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][2], 5.0);
	return true;
}

FailedExam(playerid)
{
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

DMVUpdate(playerid)
{
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

CreateDMVIcon(){
	new string[24];
	CreatePickup(1239, 1, 1490.3473, 1306.2144, 1093.2964, 0);
	format(string, sizeof(string), "/iniciarteste");
	Create3DTextLabel(string, COLOR_WHITE, 1490.3473, 1306.2144, 1093.2964, 20.0, 0);
}

DMV_StateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) {
  		if(!emExame[playerid]) return true;
  		new engine, lights, alarm, doors, bonnet, boot, objective,
  			vehicleid = GetPlayerVehicleID(playerid);
  		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		if(!(vehicleid == carrodmv[playerid])) return va_SendClientMessage(playerid, COLOR_GREEN, "Você precisa entrar no veículo.");
		va_SendClientMessage(playerid, COLOR_GREEN, "DMV:{FFFFFF} Você iniciou o exame. Siga os checkpoints e não danifique o veículo.");
		SetVehicleParamsEx(carrodmv[playerid], true, lights, alarm, doors, bonnet, boot, objective);
		SetDMVRoute(playerid);
	}
	return true;
}


DMV_EnterCheckpoint(playerid)
{
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

CMD:iniciarteste(playerid, params[]){
	
	new string [512];
	
	//if(!IsPlayerInRangeOfPoint(playerid, 2.0, 1490.3473,1306.2144,1093.2964))
		//return SendErrorMessage(playerid,"Você não está prÃ³ximo de uma DMV.");
		
	format(string, sizeof(string), "ID\tTipo do Teste\tValor\n \
		1\tLicença Veícular\t%d", 
		PRECO_EXAME_CAR
	);
	
	Dialog_Show(playerid, DIALOG_DMV_ROUTE, DIALOG_STYLE_TABLIST_HEADERS, "Licenças", string, "Selecionar", "Cancelar");
	return true;
}

Dialog:DIALOG_DMV_ROUTE(playerid, response, listitem, inputtext[]) {
	if(!response) return true;
	DMVTestType[playerid] = listitem;
	for(new i; i < MAX_DRIVERLICENCE; i++) {
		if(pLicences[i][licence_owner] == pInfo[playerid][pID]) {
			if(DMVTestType[playerid] == 0){
				if(pLicences[i][licence_vehicle] == 1){
					if(pInfo[playerid][pMoney] < PRECO_EXAME_CAR) return SendErrorMessage(playerid, "Você não tem dinheiro suficiente.");
					SendErrorMessage(playerid, "DMV:{FFFFFF} Você já possui uma carteira para carros válida.");
				}
			}
		}
	}
	StartTestingLicence(playerid);
	return true;
}