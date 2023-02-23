stock CountLicenseWarnings(playerid) {
	new count;
	if(strlen(pLicenses[playerid][warning_one]) > 1) count++;
	if(strlen(pLicenses[playerid][warning_two]) > 1) count++;
	if(strlen(pLicenses[playerid][warning_three]) > 1) count++;
	return count;
}

stock ResetLicenseWarnings(playerid) {
	format(pLicenses[playerid][warning_one], MAX_DRIVERLICENCE_WAR, "");
	format(pLicenses[playerid][warning_two], MAX_DRIVERLICENCE_WAR, "");
	format(pLicenses[playerid][warning_three], MAX_DRIVERLICENCE_WAR, "");
}

CreateNewLicense(playerid) {
	if(pLicenses[playerid][license_number] == 0) {
		pLicenses[playerid][license_status] = 1; //1 ATIVA, 2 SUSPENSA, 3 REVOGADA
		pLicenses[playerid][license_warnings] = 0;
		pLicenses[playerid][license_number] = SetLicenseFree(playerid);
		format(pLicenses[playerid][warning_one], MAX_DRIVERLICENCE_WAR, "");
		format(pLicenses[playerid][warning_two], MAX_DRIVERLICENCE_WAR, "");
		format(pLicenses[playerid][warning_three], MAX_DRIVERLICENCE_WAR, "");
	}

	if (DMVTestType[playerid] == 1) { //Carro
		pLicenses[playerid][license_vehicle] = 1;   
		va_SendClientMessage(playerid, COLOR_GREEN, "DMV:{FFFFFF} Você terminou o teste com sucesso e recebeu sua licença para veículos.");
	}

	SavePlayerLicenses(playerid);
	DMVTestType[playerid] = 0;
	return true;
}

SetLicenseFree(playerid) {
	new licensenumber = random(9000000) + 1000000;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_license WHERE `license_number` = '%d'", licensenumber);
    new Cache:result = mysql_query(DBConn, query);
	if(cache_num_rows() > 0)
		return SetLicenseFree(playerid);

	cache_delete(result);
	return licensenumber;
}