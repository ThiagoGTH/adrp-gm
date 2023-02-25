CMD:recuperar(playerid, params[]){
    if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
    static userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/recuperar [playerid/nome]");
  	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

    pInfo[userid][pHungerTime] = 0;
    pInfo[userid][pThirstTime] = 0;
    pInfo[userid][pHunger] = 100;
    pInfo[userid][pThirst] = 100;
    SetPlayerStamina(userid, GetPlayerMaxStamina(userid));

    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s recuperou %s.", GetPlayerUserEx(playerid), pNome(userid));
	format(logString, sizeof(logString), "%s (%s) recuperou %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
    return true;
}