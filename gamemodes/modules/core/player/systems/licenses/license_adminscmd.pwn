CMD:darlicenca(playerid, params[]){
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
    static
	    userid,
	    type[24];

    if (sscanf(params, "us[24]", userid, type)) {
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /darlicenca [playerid/nome] [opção]");
	    SendClientMessage(playerid, COLOR_BEGE, "[Opções]: motorista, voo, médica, armas");
		return true;
	}
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if (!strcmp(type, "motorista", true) || !strcmp(type, "veículo", true) || !strcmp(type, "veiculo", true)) {
        pLicenses[userid][license_vehicle] = 1;
        CreateNewLicense(userid);

        SendServerMessage(playerid, "Você deu uma licença de motorista para %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador lhe deu uma licença de motorista.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) deu uma licença de motorista para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	} else if (!strcmp(type, "voo", true)) {
        pLicenses[playerid][license_plane] = 1;
        CreateNewLicense(userid);

        SendServerMessage(playerid, "Você deu uma licença de voo para %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador lhe deu uma licença de voo.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) deu uma licença de voo para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	} else if (!strcmp(type, "médica", true) || !strcmp(type, "medica", true)) {
        pLicenses[playerid][license_medical] = 1;
        CreateNewLicense(userid);

        SendServerMessage(playerid, "Você deu uma licença médica para %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador lhe deu uma licença médica.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) deu uma licença médica para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	} else if (!strcmp(type, "armas", true) || !strcmp(type, "arma", true)) {
        pLicenses[playerid][license_gun] = 1;
        CreateNewLicense(userid);

        SendServerMessage(playerid, "Você deu uma licença de armas para %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador lhe deu uma licença de armas.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) deu uma licença de armas para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	} else return SendErrorMessage(playerid, "Você especificou uma opção inválida.");
    return true;
}