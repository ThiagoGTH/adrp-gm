#include <YSI_Coding\y_hooks>

static
    gPlayerHits[MAX_PLAYERS],
    gPlayerMissed[MAX_PLAYERS],
    gPlayerTotalShots[MAX_PLAYERS];

CMD:acuracia(playerid, params[]) {
	static
		userid; 

  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/acuracia [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

    va_SendClientMessage(playerid, COLOR_GREEN, "|________[ EXIBINDO ACURÁCIA ]________|");
	va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Nome: {FFFFFF}%s (%s)", pNome(userid), GetPlayerUserEx(userid));
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Acertos: {FFFFFF}%d", Player_GetHits(userid));
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Erros: {FFFFFF}%d", Player_GetMissed(userid));
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Total: {FFFFFF}%d", Player_GetTotalShots(userid));
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Acurácia: {FFFFFF}%d", Player_GetAccuracy(userid));
    va_SendClientMessage(playerid, COLOR_GREEN, "* Os dados exibidos são apenas dessa sessão do jogador.");


	format(logString, sizeof(logString), "%s (%s) checou a acuracia de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}


Player_GetTotalShots(playerid)
    return gPlayerTotalShots[playerid];


Player_GetHits(playerid)
    return gPlayerHits[playerid];


Player_GetMissed(playerid)
    return gPlayerMissed[playerid];


Player_GetAccuracy(playerid)
    return floatround(gPlayerHits[playerid] / gPlayerTotalShots[playerid]);


hook OnPlayerWeaponShot(playerid, weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ) {
    if(hittype == BULLET_HIT_TYPE_NONE) gPlayerMissed[playerid]++;
    else if(hittype == BULLET_HIT_TYPE_PLAYER && hitid != INVALID_PLAYER_ID) gPlayerHits[playerid]++;

    gPlayerTotalShots[playerid]++;
    return true;
}