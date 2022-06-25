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
irá sofrer um "UPGRADE" sempre que o jogador for tirar a prÃ³xima.

*/
#include <YSI_Coding\y_hooks>

#define DMV_VEICULO_CAR 410
#define DMV_VEICULO_BIKE 462
#define DMV_VEICULO_TRUCK 456

#define PRECO_EXAME_CAR 500
#define PRECO_EXAME_BIKE 800
#define PRECO_EXAME_TRUCK 1000
#define MAX_VEHICLE_HEALTH 850.0


#define MAX_DRIVERLICENCE MAX_PLAYERS
#define MAX_DRIVERLICENCE_WAR 128

//============================================ Geral

new Float:DMV_Checkpoint[3][9][3] = {
	{ //Carros
        {1808.2336,-1890.0858,13.1137},
        {1707.3950,-1810.0660,13.0689},
        {1425.1021,-1870.0938,13.0882},
        {1391.6542,-1745.7252,13.0866},
        {1442.9921,-1594.8103,13.0880},
        {1747.2328,-1710.5015,13.0883},
        {1805.9856,-1734.9451,13.0954},
        {1818.3652,-1820.2645,13.1177},
        {1791.8119,-1931.6996,13.0915}
	},
	{ //Motos
        {1808.2336,-1890.0858,13.1137},
        {1707.3950,-1810.0660,13.0689},
        {1425.1021,-1870.0938,13.0882},
        {1391.6542,-1745.7252,13.0866},
        {1442.9921,-1594.8103,13.0880},
        {1747.2328,-1710.5015,13.0883},
        {1805.9856,-1734.9451,13.0954},
        {1818.3652,-1820.2645,13.1177},
        {1791.8119,-1931.6996,13.0915}
	},
	{ //Caminhão
        {2233.8418,-2214.8030,13.7208},
        {-69.7697,-1120.3506,1.0781},
		{},
        {},
        {},
        {},
        {},
        {},
        {}
	}
};

new DMVCheckpoint[MAX_PLAYERS],
    bool:emExame[MAX_PLAYERS],
    carrodmv[MAX_PLAYERS],
    DMVTestType[MAX_PLAYERS];

enum licencesdata {
	licence_id,
	licence_owner,
	licence_number,
	licence_status,

	licence_car,
	licence_bike,
	licence_truck,
	licence_gun,

	licence_warnings,
	warning_one[MAX_DRIVERLICENCE_WAR],
	warning_two[MAX_DRIVERLICENCE_WAR],
	warning_three[MAX_DRIVERLICENCE_WAR]
};
new LicencesData[MAX_DRIVERLICENCE][licencesdata];

hook OnGameModeInit() {
	CheckLicenceTable();
	CreateDMVIcon();
    return 1;
}

// Checa a tabela e cria, se não existir.
CheckLicenceTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS character_licences_driver (\
        ID int NOT NULL AUTO_INCREMENT,\
        `character_id` int NOT NULL DEFAULT 0,\
        `licence_number` int NOT NULL DEFAULT 0,\
        `licence_status` int NOT NULL DEFAULT 0,\
        `licence_warnings` int NOT NULL DEFAULT 0,\
		`licence_car` int NOT NULL DEFAULT 0,\
		`licence_bike` int NOT NULL DEFAULT 0,\
		`licence_truck` int NOT NULL DEFAULT 0,\
		`licence_gun` int NOT NULL DEFAULT 0,\
		`warning_one` varchar(128) NOT NULL DEFAULT 'Vazio',\
		`warning_two` varchar(128) NOT NULL DEFAULT 'Vazio',\
		`warning_three` varchar(128) NOT NULL DEFAULT 'Vazio',\
        PRIMARY KEY (ID));");

    return 1;
}
CreateNewLicence(playerid) {

	new slot = GetFreeLicenceSlot();
	if(slot == -1) 
		return SendErrorMessage(playerid, "(Licença): #ERRO_1: Tire um screenshot desse erro e o encaminhe a um administrador.");

	//===========================================================================================================
	if(pInfo[playerid][pLicence] == 0){
		
		LicencesData[slot][licence_owner] = pInfo[playerid][pID];
		LicencesData[slot][licence_status] = 1; //1 ATIVA, 2 SUSPENSA, 3 REVOGADA
		LicencesData[slot][licence_warnings] = 0;
		LicencesData[slot][licence_number] = random(9000000) + 1000000;
		format(LicencesData[slot][warning_one], MAX_DRIVERLICENCE_WAR, "");
		format(LicencesData[slot][warning_two], MAX_DRIVERLICENCE_WAR, "");
		format(LicencesData[slot][warning_three], MAX_DRIVERLICENCE_WAR, "");

		va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Você terminou o teste com sucesso. Licença número %d.", LicencesData[slot][licence_number]);
		mysql_format(DBConn, query, sizeof(query), "INSERT INTO `character_licences_driver` \
			( `character_id`, `licence_number`, `licence_status`, `licence_warnings`, `warning_one`, `warning_two`, `warning_three` \
			, `licence_car`, `licence_bike`, `licence_truck`) \
			VALUES ('%d', '%d', '%d', '%d', '%s', '%s', '%s')", 
			LicencesData[slot][licence_owner],
			LicencesData[slot][licence_number],
			LicencesData[slot][licence_status],
			LicencesData[slot][licence_warnings],
			LicencesData[slot][warning_one],
			LicencesData[slot][warning_two],
			LicencesData[slot][warning_three],
			LicencesData[slot][licence_car],
			LicencesData[slot][licence_bike],
			LicencesData[slot][licence_truck]
		);
		new Cache:result = mysql_query(DBConn, query);
		LicencesData[slot][licence_id] = cache_insert_id();
		cache_delete(result);
	}
	//===========================================================================================================


	if (DMVTestType[playerid] == 0) { //Carro
		LicencesData[slot][licence_car] = 1;   
		va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Você terminou o teste com sucesso e recebeu sua licença para veículos.");
	}

	if (DMVTestType[playerid] == 1) { //Moto
		LicencesData[slot][licence_bike] = 1;  
		va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Você terminou o teste com sucesso e recebeu sua licença para motos.");
	}

	if (DMVTestType[playerid] == 2) { //Caminhão
		LicencesData[slot][licence_truck] = 1;
		va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Você terminou o teste com sucesso e recebeu sua licença para caminhões.");
	}

	pInfo[playerid][pLicence] = slot;
	SaveLicencesData(slot);
	DMVTestType[playerid] = -1;
	return 1;
}

GetFreeLicenceSlot() {
	for(new i = 1; i < MAX_DRIVERLICENCE; i++) {
		if(LicencesData[i][licence_id] == 0) return i;
	}
	return -1;
}

CountLicenceWarnings(licendeid) {
	new count;
	if(strlen(LicencesData[licendeid][warning_one]) > 1) count++;
	if(strlen(LicencesData[licendeid][warning_two]) > 1) count++;
	if(strlen(LicencesData[licendeid][warning_three]) > 1) count++;
	return count;
}

ResetLicenceWarnings(licendeid){
	format(LicencesData[licendeid][warning_one], MAX_DRIVERLICENCE_WAR, "");
	format(LicencesData[licendeid][warning_two], MAX_DRIVERLICENCE_WAR, "");
	format(LicencesData[licendeid][warning_three], MAX_DRIVERLICENCE_WAR, "");
}
LoadLicencesData(playerid) {
	new rows;
	mysql_format(DBConn, query, sizeof query, "SELECT * FROM character_licences_driver WHERE `character_id` = '%d'", pInfo[playerid][pID]);
	mysql_query(DBConn, query);

	cache_get_row_count(rows);

	if(rows > 0) {
		for(new i; i < rows; i++) if(i < MAX_DRIVERLICENCE) {
			cache_get_value_name_int(i, "ID", LicencesData[i][licence_id]);
			cache_get_value_name_int(i, "character_id", LicencesData[i][licence_owner]);

			cache_get_value_name_int(i, "licence_number", LicencesData[i][licence_number]);
			cache_get_value_name_int(i, "licence_status", LicencesData[i][licence_status]);
			cache_get_value_name_int(i, "licence_warnings", LicencesData[i][licence_warnings]);

			cache_get_value_name_int(i, "licence_car", LicencesData[i][licence_car]);
			cache_get_value_name_int(i, "licence_bike", LicencesData[i][licence_bike]);
			cache_get_value_name_int(i, "licence_truck", LicencesData[i][licence_truck]);
			cache_get_value_name_int(i, "licence_gun", LicencesData[i][licence_gun]);

			cache_get_value(i, "warning_one", LicencesData[i][warning_one], MAX_DRIVERLICENCE_WAR);
			cache_get_value(i, "warning_two", LicencesData[i][warning_two], MAX_DRIVERLICENCE_WAR);
			cache_get_value(i, "warning_three", LicencesData[i][warning_three], MAX_DRIVERLICENCE_WAR);


			pInfo[playerid][pLicence] = LicencesData[i][licence_owner];

			printf("[Licenca] Licença carregada com sucesso. (Nome %s | SQL ID %d | Numero Lic %d)", GetPlayerNameEx(playerid), LicencesData[i][licence_id], LicencesData[i][licence_number]);

		}
	}	
	return 1;
}

SaveLicencesData(driver_id) {
	mysql_format(DBConn, query, sizeof(query), "UPDATE `character_licences_driver` SET \
		`character_id`='%i', `licence_number`='%i', `licence_status`='%i', `licence_warnings`='%i', \
		`warning_one`='%s', `warning_two`='%s', `warning_three`='%s', \
		`licence_car`='%i', `licence_bike`='%i', `licence_truck`='%i', `licence_gun`='%i', WHERE `ID`='%i'",
		LicencesData[driver_id][licence_owner],
		LicencesData[driver_id][licence_number],
		LicencesData[driver_id][licence_status],
		LicencesData[driver_id][licence_warnings],
		LicencesData[driver_id][warning_one],
		LicencesData[driver_id][warning_two],
		LicencesData[driver_id][warning_three],
		LicencesData[driver_id][licence_car],
		LicencesData[driver_id][licence_bike],
		LicencesData[driver_id][licence_truck],
		LicencesData[driver_id][licence_gun],
		LicencesData[driver_id][licence_id]
	);
	mysql_query(DBConn, query, false);
	return 1;
}

CMD:criarlicenca(playerid, params[]){
	CreateNewLicence(playerid);
	return 1;
}

CMD:mostrarlicenca(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;

	if(pInfo[playerid][pLicence] == 0) return SendErrorMessage(playerid,"Você não tem uma licença de motorista.");
	
	for(new i; i < MAX_DRIVERLICENCE; i++) {
	if(LicencesData[i][licence_owner] == pInfo[playerid][pID]) {
		new status[20],
			status_car[20],
			status_bike[20],
			status_truck[20],
			status_gun[20];

		switch(LicencesData[i][licence_status]){
			case 0: status = "NENHUM";
			case 1: status = "ATIVA";
			case 2: status = "SUSPENSA";
			case 3: status = "REVOGADA";
		}
		switch(LicencesData[i][licence_car]){
			case 0: status_car = "Não";
			case 1: status_car = "Sim";
		}
		switch(LicencesData[i][licence_bike]){
			case 0: status_bike = "Não";
			case 1: status_bike = "Sim";
		}
		switch(LicencesData[i][licence_truck]){
			case 0: status_truck = "Não";
			case 1: status_truck = "Sim";
		}
		switch(LicencesData[i][licence_gun]){
			case 0: status_gun = "Não";
			case 1: status_gun = "Sim";
		}
		new avisos = CountLicenceWarnings(i);

		new targetid;
		if(sscanf(params, "u", targetid)){
			va_SendClientMessage(playerid, VERDE,"|_______________Licenças_____________|");
			va_SendClientMessage(playerid, CINZA, "Nome: %s", GetPlayerNameEx(playerid));
			va_SendClientMessage(playerid, CINZA, "Número: %d", LicencesData[i][licence_number]);
			va_SendClientMessage(playerid, CINZA, "Status: %s", status);
			va_SendClientMessage(playerid, CINZA, "Tipos: (Veículos: %s) | (Motos: %s) | (Caminhões: %s) | (Armas: %s)", status_car, status_bike, status_truck, status_gun);
			va_SendClientMessage(playerid, CINZA, "Advertências: (%d/3)", avisos);
			va_SendClientMessage(playerid, VERDE,"(Licença Motorista):{FFFFFF} Você pode mostrar sua licença para outro jogador. Use '/licencamotorista playerID'.");
		}
	
		else{
			if(!pInfo[targetid][pLogged]) return SendErrorMessage(playerid, "Este jogador não está logado.");
			if (!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste player.");
			if (playerid == targetid) return SendErrorMessage(playerid, "Você não pode mostrar sua licença para você mesmo.");

			va_SendClientMessage(targetid, CINZA,"|_______________Licenças_____________|");
			va_SendClientMessage(targetid, CINZA, "Nome: %s", GetPlayerNameEx(playerid));
			va_SendClientMessage(targetid, CINZA, "Número: %d", LicencesData[i][licence_number]);
			va_SendClientMessage(targetid, CINZA, "Status: %s", status);
			va_SendClientMessage(playerid, CINZA, "Tipos: (Veículos: %s) | (Motos: %s) | (Caminhões: %s) | (Armas: %s)", status_car, status_bike, status_truck, status_gun);
			va_SendClientMessage(targetid, CINZA, "Advertências: (%d/3)", avisos);
		}

	}
	}
	return 1;
}

//Lembrar de Adicionar a função de apenas fac policial poder usar
CMD:removeravisoslicenca(playerid, params[]) {
    new targetid; 

    if(sscanf(params, "u", targetid)) return SendSyntaxMessage(playerid, "/removeravisoslicenca [playerID/Nome]");
	
	if(!pInfo[targetid][pLogged]) return SendErrorMessage(playerid, "Este jogador não está logado.");
	if (!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste player.");
	if (playerid == targetid) return SendErrorMessage(playerid, "Você não pode remover os avisos da sua licença.");
  
    va_SendClientMessage(playerid, VERDE, "(Licença):{FFFFFF} Você limpou os avisos da licença de %s.", GetPlayerNameEx(targetid));
	va_SendClientMessage(targetid, VERDE, "(Licença):{FFFFFF} O oficial %s limpou os avisos na sua licença.", GetPlayerNameEx(playerid));
    ResetLicenceWarnings(targetid);
	return 1;
}


/*

ROTAS

*/
hook OnPlayerEnterCheckpoint(playerid, vehicleid, ispassenger) {
    DMV_EnterCheckpoint(playerid);
    return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid) {

	if(IsPlayerNPC(playerid)) return 1;		

	if(emExame[playerid] == true) {
		SendErrorMessage(playerid, "Você abandonou o carro e por isso reprovou no exame de direção.");
		FailedExam(playerid);
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate) {
	
	DMV_StateChange(playerid, newstate, oldstate);
	return 1;
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
        va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Você iniciou o teste de direção para a licença de Motorista de carros.");
	    va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Entre no manana para continuar com o exame.");
	    emExame[playerid] = true;
        return 1;
    }
    if(DMVTestType[playerid] == 1){ //Motos
	    pInfo[playerid][pMoney] -= PRECO_EXAME_BIKE;
	    SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, playerid+1);
	    SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	    SetPlayerFacingAngle(playerid, 270.8737);
	    SetCameraBehindPlayer(playerid);
	    carrodmv[playerid] = CreateVehicle(DMV_VEICULO_BIKE, 1791.1338, -1933.0410, 13.0918, 1.000, 0, 0, -1);
	    SetVehicleVirtualWorld(carrodmv[playerid], playerid+1);
        va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Você iniciou o teste de direção para a licença de Motorista de carros.");
	    va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Entre na moto para continuar com o exame.");
	    emExame[playerid] = true;
        return 1;
    }
    if(DMVTestType[playerid] == 2){ //Caminhão
	    pInfo[playerid][pMoney] -= PRECO_EXAME_TRUCK;
	    SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, playerid+1);
	    SetPlayerPos(playerid, 2179.1262,-2262.4590,14.7734);
	    SetPlayerFacingAngle(playerid, 133.8323);
	    SetCameraBehindPlayer(playerid);
	    carrodmv[playerid] = CreateVehicle(DMV_VEICULO_TRUCK, 2174.4653, -2267.1816, 13.3833, 225.5650, 0, 0, -1);
	    SetVehicleVirtualWorld(carrodmv[playerid], playerid+1);
        va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Você iniciou o teste de direção para a licença de Motorista de caminhão.");
	    va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Entre no caminhão para continuar com o exame.");
	    emExame[playerid] = true;
        return 1;
    }
	return 1;
}

FinishTestingLicence(playerid){

	new Float:lataria;
	GetVehicleHealth(carrodmv[playerid], lataria);
	if(lataria <= MAX_VEHICLE_HEALTH){
		SendErrorMessage(playerid, "O veículo está muito danificado e por isso você reprovou no exame.");
		FailedExam(playerid);
		return 1;
	}
	SetPlayerPos(playerid, 1778.2292, -1934.1807, 13.3856);
	SetPlayerFacingAngle(playerid, 270.8737);
	SetCameraBehindPlayer(playerid);
	emExame[playerid] = false;
	DestroyVehicle(carrodmv[playerid]);
	DisablePlayerCheckpoint(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	CreateNewLicence(playerid);
	return 1;
}

SetDMVRoute(playerid)
{
	if(emExame[playerid]) SetPlayerCheckpoint(playerid, 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][0], 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][1], 
    DMV_Checkpoint[DMVTestType[playerid]][DMVCheckpoint[playerid]][2], 5.0);
	return 1;
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
	return 1;
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
	return 1;
}

CreateDMVIcon(){
	new string[24];
	CreatePickup(1239, 1, 1490.3473, 1306.2144, 1093.2964, 0);
	format(string, sizeof(string), "/iniciarteste");
	Create3DTextLabel(string, BRANCO, 1490.3473, 1306.2144, 1093.2964, 20.0, 0);
}

DMV_StateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) {
  		if(!emExame[playerid]) return 1;
  		new engine, lights, alarm, doors, bonnet, boot, objective,
  			vehicleid = GetPlayerVehicleID(playerid);
  		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		if(!(vehicleid == carrodmv[playerid])) return va_SendClientMessage(playerid, VERDE, "Você precisa entrar no veículo.");
		va_SendClientMessage(playerid, VERDE, "DMV:{FFFFFF} Você iniciou o exame. Siga os checkpoints e não danifique o veículo.");
		SetVehicleParamsEx(carrodmv[playerid], true, lights, alarm, doors, bonnet, boot, objective);
		SetDMVRoute(playerid);
	}
	return 1;
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
		if(DMVTestType[playerid] == 1){ //Moto
			if (GetVehicleModel(vehicleid) != DMV_VEICULO_BIKE) {
		    	SendErrorMessage(playerid,"Você não está dirigindo o veículo correto e por isso o teste foi cancelado.");
		    	FailedExam(playerid);
			}
		}
		if(DMVTestType[playerid] == 3){ //Caminhão
			if (GetVehicleModel(vehicleid) != DMV_VEICULO_TRUCK) {
		    	SendErrorMessage(playerid,"Você não está dirigindo o veículo correto e por isso o teste foi cancelado.");
		    	FailedExam(playerid);
			}
		}

		DisablePlayerCheckpoint(playerid);
        DMVUpdate(playerid);
	}
	return 1;
}

CMD:iniciarteste(playerid, params[]){
	if(!pInfo[playerid][pLogged]) return 1;
	new string [512];
	
	//if(!IsPlayerInRangeOfPoint(playerid, 2.0, 1490.3473,1306.2144,1093.2964))
		//return SendErrorMessage(playerid,"Você não está prÃ³ximo de uma DMV.");
		
	format(string, sizeof(string), "ID\tTipo do Teste\tValor\n \
		1\tCarteira de Carro\t%d\n \
		2\tCarteira de Moto\t%d\n \
		3\tCarteira de Caminhão\t%d", 
		PRECO_EXAME_CAR,
		PRECO_EXAME_BIKE,
		PRECO_EXAME_TRUCK
	);
	
	Dialog_Show(playerid, DIALOG_DMV_ROUTE, DIALOG_STYLE_TABLIST_HEADERS, "Licenças", string, "Selecionar", "Cancelar");
	return 1;
}
Dialog:DIALOG_DMV_ROUTE(playerid, response, listitem, inputtext[]) {
	if(!response) return 1;
	DMVTestType[playerid] = listitem;

//============================================================================
// Checar qual licença ele já tem e se tem grana suficiente.

	for(new i; i < MAX_DRIVERLICENCE; i++) {
		if(LicencesData[i][licence_owner] == pInfo[playerid][pID]) {
			if(DMVTestType[playerid] == 0){
				if(LicencesData[i][licence_car] == 1){
					if(pInfo[playerid][pMoney] < PRECO_EXAME_CAR) return SendErrorMessage(playerid, "Você não tem dinheiro suficiente.");
					SendErrorMessage(playerid, "DMV:{FFFFFF} Você já possui uma carteira para carros válida.");
				}
			}
			if(DMVTestType[playerid] == 1){
				if(LicencesData[i][licence_bike] == 1){
					if(pInfo[playerid][pMoney] < PRECO_EXAME_BIKE) return SendErrorMessage(playerid, "Você não tem dinheiro suficiente.");
					SendErrorMessage(playerid, "DMV:{FFFFFF} Você já possui uma carteira para motos válida.");
				}
			}
			if(DMVTestType[playerid] == 2){
				if(LicencesData[i][licence_truck] == 1){
					if(pInfo[playerid][pMoney] < PRECO_EXAME_TRUCK) return SendErrorMessage(playerid, "Você não tem dinheiro suficiente.");
					SendErrorMessage(playerid, "DMV:{FFFFFF} Você já possui uma carteira para caminhões válida.");
				}
			}
		}
	}
//============================================================================

	StartTestingLicence(playerid);
	return 1;
}