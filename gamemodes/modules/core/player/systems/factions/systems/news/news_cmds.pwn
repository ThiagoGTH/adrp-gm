CMD:transmissao(playerid, params[]){
	if (GetFactionType(playerid) != FACTION_NEWS) return SendPermissionMessage(playerid);
    if (IsPlayerWatchingCamera(playerid) == true) return SendErrorMessage(playerid, "Você não pode iniciar uma transmissão enquanto assiste outra.");
    if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Você não pode iniciar uma transmissão ao vivo de dentro de um veículo.");
    
    new factionid = pInfo[playerid][pFaction];
    if (!pInfo[playerid][pRecording]){
        GivePlayerCamera(playerid);
        va_SendClientMessageToAll(COLOR_YELLOW, "%s iniciou uma transmissão ao vivo, para assistir digite /assistir %d.", FactionGetName(pInfo[playerid][pFaction]), playerid);
        SendFactionMessage(factionid, COLOR_FACTION, "[Facção]: %s %s iniciou uma transmissão ao vivo.", Faction_GetRank(playerid), pNome(playerid));
        format(logString, sizeof(logString), "[%s] %s (%s) iniciou uma transmissão ao vivo em %s", FactionData[factionid][factionName], pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid));
	    logCreate(playerid, logString, 22);
    } else {
        RemovePlayerCamera(playerid);
        va_SendClientMessageToAll(COLOR_YELLOW, "%s encerrou a transmissão ao vivo.", FactionGetName(pInfo[playerid][pFaction]));
        SendFactionMessage(factionid, COLOR_FACTION, "[Facção]: %s %s encerrou uma transmissão ao vivo.", Faction_GetRank(playerid), pNome(playerid));
        format(logString, sizeof(logString), "[%s] %s (%s) encerrou uma transmissão ao vivo em %s", FactionData[factionid][factionName], pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid));
	    logCreate(playerid, logString, 22);
    }
    return true;
}

CMD:assistir(playerid, params[]){
    if (pInfo[playerid][pWatching]) return StopPlayerWatchingCamera(playerid);

    static userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/assistir [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if (IsPlayerRecording(playerid) == true) return SendErrorMessage(playerid, "Você não pode assistir sua própria transmissão.");
    if (pInfo[userid][pRecording] == false) return SendErrorMessage(playerid, "Esse jogador não está com uma transmissão aberta.");

    if (!pInfo[playerid][pWatching]){
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s começa a assistir a transmissão ao vivo.", pNome(playerid));
        va_SendClientMessage(playerid, COLOR_GREEN, "Você agora está assistindo uma transmissão ao vivo, para parar basta digitar /assistir.");
        StartPlayerWatchingCamera(playerid, userid);	
    }
	return true;
}