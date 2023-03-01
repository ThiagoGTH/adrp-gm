#include <YSI_Coding\y_hooks>

static
    Float:gPlayerHits[MAX_PLAYERS] = 0.0,
    Float:gPlayerMissed[MAX_PLAYERS] = 0.0,
    Float:gPlayerTotalShots[MAX_PLAYERS] = 0.0;

Float:Player_GetTotalShots(playerid)
    return gPlayerTotalShots[playerid];


Float:Player_GetHits(playerid)
    return gPlayerHits[playerid];


Float:Player_GetMissed(playerid)
    return gPlayerMissed[playerid];


Float:Player_GetAccuracy(playerid)
    return gPlayerHits[playerid]/gPlayerTotalShots[playerid];

CMD:acuracia(playerid, params[]) {
	static
		userid; 

  	if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/acuracia [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if (Player_GetTotalShots(userid) == 0.0) return SendErrorMessage(playerid, "Este jogador ainda não fez nenhum disparo nesta sessão.");

    va_SendClientMessage(playerid, COLOR_GREEN, "|________[ EXIBINDO ACURÁCIA ]________|");
	va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Nome: {FFFFFF}%s (%s)", pNome(userid), GetPlayerUserEx(userid));
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Acertos: {FFFFFF}%.1f", Player_GetHits(userid));
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Erros: {FFFFFF}%.1f", Player_GetMissed(userid));
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Total: {FFFFFF}%.1f", Player_GetTotalShots(userid));
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Acurácia: {FFFFFF}%.1f", Player_GetAccuracy(userid));
    va_SendClientMessage(playerid, COLOR_GREEN, "* Os dados exibidos são apenas dessa sessão do jogador.");


	format(logString, sizeof(logString), "%s (%s) checou a acuracia de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

hook OnPlayerWeaponShot(playerid, weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ) {
    if(hittype == BULLET_HIT_TYPE_NONE) gPlayerMissed[playerid]++;
    else if(hittype == BULLET_HIT_TYPE_PLAYER && hitid != INVALID_PLAYER_ID) gPlayerHits[playerid]++;

    gPlayerTotalShots[playerid]++;
    return true;
}

hook OnPlayerDisconnect(playerid){
    gPlayerHits[playerid] =
    gPlayerMissed[playerid] =
    gPlayerTotalShots[playerid] = 0.0;
    return true;
}