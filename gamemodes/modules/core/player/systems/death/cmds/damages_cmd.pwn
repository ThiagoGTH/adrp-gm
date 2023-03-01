CMD:ferimentos(playerid, params[]){
    static userid;
    if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/ferimentos [playerid/nome]");
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

    if (pInfo[playerid][pAdminDuty]) ShowPlayerDamages(userid, playerid, 1);
    else {
        if(!IsPlayerNearPlayer(playerid, userid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste jogador.");
        ShowPlayerDamages(userid, playerid, 0);
    }
    return true;
}

CMD:investida(playerid, params[]){
	if (!pInfo[playerid][pTackleMode]){
		SendServerMessage(playerid, "Você ativou o modo investida. A partir de agora se você socar alguém, haverá chances de derruba-lo.");
		SendServerMessage(playerid, "Se o jogador for derrubado e não interpretar corretamente, utilize o /report.");
		pInfo[playerid][pTackleMode] = true;
	}else{
		SendServerMessage(playerid, "Você desativou o modo investida.");
		pInfo[playerid][pTackleMode] = false;
		TextDrawHideForPlayer(playerid, TEXTDRAW_TACKLE);
	}
	return true;
}
alias:investida("derrubar", "tackle", "investir")

CMD:aceitarmorte(playerid, params[]){
	if (pInfo[playerid][pDead]) return SendErrorMessage(playerid, "Você já está morto.");
	if (!pInfo[playerid][pBrutallyWounded]) return SendErrorMessage(playerid, "Você não está brutalmente ferido.");
	if (pInfo[playerid][pDeadTime] > 180) return SendErrorMessage(playerid, "Você deve aguardar mais %d segundos para aceitar a morte.", pInfo[playerid][pDeadTime]-180);

	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "(( %s aceitou a morte ))", pNome(playerid));
	SendServerMessage(playerid, "Você desistiu e aceitou sua morte.");
	OnPlayerGetDeath(playerid, 999, 999);
	return true;
}

CMD:respawnar(playerid, params[]){
	if (pInfo[playerid][pBrutallyWounded]) return SendErrorMessage(playerid, "Você está brutalmente ferido, digite /aceitarmorte.");
	if (!pInfo[playerid][pDead]) return SendErrorMessage(playerid, "Você não está morto.");
	if (pInfo[playerid][pDeadTime] > 0) return SendErrorMessage(playerid, "Você deve aguardar mais %d segundos para respawnar.", pInfo[playerid][pDeadTime]-60);

	CreateDeadBody(playerid);
	OnPlayerRevive(playerid);
	SendPlayerHospital(playerid);
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "(( %s respawnou após sua morte ))", pNome(playerid));
	SendServerMessage(playerid, "Você respawnou e não poderá lembrar de nada que ocasionou sua última morte.");
	return true;
}