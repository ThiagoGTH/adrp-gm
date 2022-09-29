CMD:darlicenca(playerid, params[]){
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
    static
	    userid,
	    type[24];

    if (sscanf(params, "us[24]", userid, type)) {
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /darlicenca [playerid/nome] [op��o]");
	    SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: motorista, voo, m�dica, armas");
		return true;
	}
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if (!strcmp(type, "motorista", true) || !strcmp(type, "ve�culo", true) || !strcmp(type, "veiculo", true)) {
        pLicences[userid][licence_vehicle] = 1;
        CreateNewLicence(userid);

        SendServerMessage(playerid, "Voc� deu uma licen�a de motorista para %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador lhe deu uma licen�a de motorista.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) deu uma licen�a de motorista para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	} else if (!strcmp(type, "voo", true)) {
        pLicences[playerid][licence_plane] = 1;
        CreateNewLicence(userid);

        SendServerMessage(playerid, "Voc� deu uma licen�a de voo para %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador lhe deu uma licen�a de voo.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) deu uma licen�a de voo para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	} else if (!strcmp(type, "m�dica", true) || !strcmp(type, "medica", true)) {
        pLicences[playerid][licence_medical] = 1;
        CreateNewLicence(userid);

        SendServerMessage(playerid, "Voc� deu uma licen�a m�dica para %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador lhe deu uma licen�a m�dica.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) deu uma licen�a m�dica para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	} else if (!strcmp(type, "armas", true) || !strcmp(type, "arma", true)) {
        pLicences[playerid][licence_gun] = 1;
        CreateNewLicence(userid);

        SendServerMessage(playerid, "Voc� deu uma licen�a de armas para %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador lhe deu uma licen�a de armas.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) deu uma licen�a de armas para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	} else return SendErrorMessage(playerid, "Voc� especificou uma op��o inv�lida.");
    return true;
}