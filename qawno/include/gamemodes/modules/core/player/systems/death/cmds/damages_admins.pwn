CMD:ultimoatirador(playerid, params[]){
	if (!pInfo[playerid][pLogged]) return true;
  	if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
    static userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/ultimoatirador [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
	if (isnull(pInfo[userid][pLastShot])) return SendErrorMessage(playerid, "Este jogador não levou nenhum tiro desde que em logou no servidor.");

	SendServerMessage(playerid, "%s foi atingido pela última vez por %s (%s).", pNome(userid), pInfo[userid][pLastShot], GetDuration(gettime() - pInfo[userid][pShotTime]));
    
    format(logString, sizeof(logString), "%s (%s) checou o último atirador de %s [foi: %s (%s)].", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), pInfo[userid][pLastShot], GetDuration(gettime() - pInfo[userid][pShotTime]));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:reviver(playerid, params[]) {
	static
		userid; 

  	if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/reviver [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s reviveu %s.", GetPlayerUserEx(playerid), pNome(userid));

	ClearDamages(userid);
	pInfo[userid][pDead] = 0;
    pInfo[userid][pInjured] = 0;
    pInfo[userid][pDeadTime] = 0;
	pInfo[userid][pBrutallyWounded] = 0;
    pInfo[userid][pPassedOut] = false;
    pInfo[userid][pLimping] = false;
    pInfo[userid][pLimpingTime] = 0;
	pInfo[userid][pTotalDamages] = 0;
    SetCameraBehindPlayer(userid);
    TogglePlayerControllable(userid, true);
	ClearAnimations(userid);
	if (IsValidDynamic3DTextLabel(pInfo[userid][pBrutallyTag])) {
		DestroyDynamic3DTextLabel(pInfo[userid][pBrutallyTag]);
		pInfo[userid][pBrutallyTag] = Text3D:INVALID_3DTEXT_ID;
	}

	SendServerMessage(playerid, "Você reviveu %s.", pNome(userid));
	format(logString, sizeof(logString), "%s (%s) reviveu %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:reclife(playerid, params[]) {
	static
		userid; 

  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/reclife [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s recuperou a vida de %s.", GetPlayerUserEx(playerid), pNome(userid));

	SetPlayerHealthEx(userid, pInfo[userid][pHealthMax]);
	ClearDamages(userid);
	SendServerMessage(playerid, "Você recuperou a vida de %s.", pNome(userid));
	format(logString, sizeof(logString), "%s (%s) recuperou a vida de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:abrutal(playerid, params[]) {
	static
		userid; 

  	if(GetPlayerAdmin(playerid) < 3) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/abrutal [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s setou %s como brutalmente ferido.", GetPlayerUserEx(playerid), pNome(userid));

	OnPlayerGetBrutallyWounded(userid, 999, 999);
	SendServerMessage(playerid, "Você setou %s como brutalmente ferido.", pNome(userid));
	SendServerMessage(userid, "%s setou você como brutalmente ferido.", GetPlayerUserEx(playerid));
	format(logString, sizeof(logString), "%s (%s) setou %s como brutalmente ferido.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:amatar(playerid, params[]) {
	static
		userid; 

  	if(GetPlayerAdmin(playerid) < 3) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/amatar [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s setou %s como morto.", GetPlayerUserEx(playerid), pNome(userid));

	OnPlayerGetDeath(userid, 999, 999);
	SendServerMessage(playerid, "Você setou %s como morto.", pNome(userid));
	SendServerMessage(userid, "%s setou você como morto.", GetPlayerUserEx(playerid));
	format(logString, sizeof(logString), "%s (%s) setou %s como morto.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}