CMD:deletarcorpo(playerid, params[]) {
    static
		userid; 

  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/deletarcorpo [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

    DeleteDeadBody(userid);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s deletou o corpo de %s.", GetPlayerUserEx(playerid), pNome(userid));

	SendServerMessage(playerid, "Você deletou o corpo de %s.", pNome(userid));
	format(logString, sizeof(logString), "%s (%s) deletou o corpo de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
    return true;
}

