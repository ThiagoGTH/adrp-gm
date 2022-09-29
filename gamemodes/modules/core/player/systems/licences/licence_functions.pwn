CountLicenceWarnings(playerid) {
	new count;
	if(strlen(pLicences[playerid][warning_one]) > 1) count++;
	if(strlen(pLicences[playerid][warning_two]) > 1) count++;
	if(strlen(pLicences[playerid][warning_three]) > 1) count++;
	return count;
}

ResetLicenceWarnings(playerid) {
	format(pLicences[playerid][warning_one], MAX_DRIVERLICENCE_WAR, "");
	format(pLicences[playerid][warning_two], MAX_DRIVERLICENCE_WAR, "");
	format(pLicences[playerid][warning_three], MAX_DRIVERLICENCE_WAR, "");
}

CreateNewLicence(playerid) {
	if(pLicences[playerid][licence_number] == 0) {
		pLicences[playerid][licence_status] = 1; //1 ATIVA, 2 SUSPENSA, 3 REVOGADA
		pLicences[playerid][licence_warnings] = 0;
		pLicences[playerid][licence_number] = SetLicenceFree(playerid);
		format(pLicences[playerid][warning_one], MAX_DRIVERLICENCE_WAR, "");
		format(pLicences[playerid][warning_two], MAX_DRIVERLICENCE_WAR, "");
		format(pLicences[playerid][warning_three], MAX_DRIVERLICENCE_WAR, "");
	}

	if (DMVTestType[playerid] == 1) { //Carro
		pLicences[playerid][licence_vehicle] = 1;   
		va_SendClientMessage(playerid, COLOR_GREEN, "DMV:{FFFFFF} Você terminou o teste com sucesso e recebeu sua licença para veículos.");
	}

	SavePlayerLicences(playerid);
	DMVTestType[playerid] = 0;
	return true;
}

SetLicenceFree(playerid) {
	new licencenumber = random(9000000) + 1000000;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_licence WHERE `licence_number` = '%d'", licencenumber);
    new Cache:result = mysql_query(DBConn, query);
	if(cache_num_rows() > 0)
		return SetLicenceFree(playerid);

	cache_delete(result);
	return licencenumber;
}