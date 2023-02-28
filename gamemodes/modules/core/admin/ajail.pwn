#include <YSI_Coding\y_hooks>

hook OnGameModeInit(){
	SetTimer("aJailMinuteCheck", 60000, true); //1min
	return true;
}

CMD:libertar(playerid, params[]) {
	static
		userid;

  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/libertar [id/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
	if (uInfo[userid][uJailed] < 1) return SendErrorMessage(playerid, "Este jogador não está preso.");

    freeAjail(userid);

	SendServerMessage(playerid, "Você libertou %s da prisão administrativa.", pNome(userid));
	SendServerMessage(userid, "O administrador %s lhe libertou da prisão administrativa.", GetPlayerUserEx(playerid));

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s libertou %s da prisão administrativa.", GetPlayerUserEx(playerid), pNome(userid));

    format(logString, sizeof(logString), "%s (%s) libertou %s da prisão administrativa", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(userid, logString, 1);

    format(logString, sizeof(logString), "%s (%s) foi liberado da prisão administrativa por %s", pNome(userid), GetPlayerUserEx(userid), GetPlayerUserEx(playerid));
	logCreate(userid, logString, 11);
	return true;
}

CMD:ajail(playerid, params[]) {
	static
		userid,
		minutes,
		reason[128];

	
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "uds[128]", userid, minutes, reason)) return SendSyntaxMessage(playerid, "/ajail [id/nome] [minutos] [motivo]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
	if (minutes < 1) return SendErrorMessage(playerid, "Você não pode prender um jogador por um valor menor que um.");

	ClearAnimations(userid);
    SetPlayerPos(userid, 197.6346, 175.3765, 1003.0234);
    SetPlayerInterior(userid, 3);
	SetPlayerVirtualWorld(userid, (userid + 100));
 	SetPlayerFacingAngle(userid, 0.0);
	SetCameraBehindPlayer(userid);
	ResetWeapons(userid);

    uInfo[userid][uJailed] = minutes;
	
	SaveUserInfo(userid);
    SaveCharacterInfo(userid);
    
	va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s prendeu %s na prisão administrativa por %d minutos pelo motivo: %s.", GetPlayerUserEx(playerid), pNome(userid), minutes, reason);
    SendServerMessage(playerid, "Você prendeu %s por %d minutos (%s).", pNome(userid), minutes, reason);
	SendServerMessage(userid, "O administrador %s lhe prendeu por %d minutos (%s).", GetPlayerUserEx(playerid), minutes, reason);

    format(logString, sizeof(logString), "%s (%s) prendeu %s (%d minutos, motivo: %s)", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), minutes, reason);
	logCreate(userid, logString, 1);

    format(logString, sizeof(logString), "%s (%s) preso por %s (%d minutos, motivo: %s)", pNome(userid), GetPlayerUserEx(userid), GetPlayerUserEx(playerid), minutes, reason);
	logCreate(userid, logString, 11);

	return true;
}

CMD:ajailoff(playerid, params[]) {
    new userName[24], reason[128], minutes;
 
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
    if(sscanf(params, "s[24]ds[128]", userName, minutes, reason)) return SendSyntaxMessage(playerid, "/ajailoff [usuário] [dias] [motivo]");
    if (minutes < 1) return SendErrorMessage(playerid, "Você não pode prender um jogador por um valor menor que um.");

    // Checar se o usuário já está online em algum dos personagens ou selecionando eles.
    foreach(new i : Player) {
        if(!strcmp(uInfo[i][uName], userName)) { 
            va_SendClientMessage(playerid, COLOR_LIGHTRED, "Este usuário já está conectado no servidor. (Nick: %s, ID: %d)", GetPlayerNameEx(i), i);
            return SendSyntaxMessage(playerid, "/ajail [id/nome] [minutos] [motivo]");
        }
    }

    // Checar se o usuário existe
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", userName);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) return SendErrorMessage(playerid, "Não foi possível encontrar um usuário com este nome no banco de dados.");
    
    // Checar se o usuário já está preso.
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s' AND \
        `jailtime` > 0;", userName);
    mysql_query(DBConn, query);

    if(cache_num_rows()) return SendErrorMessage(playerid, "Não foi possível prender este jogador porque ele já está cumprindo uma prisão.");

    // Prender, enfim.
    mysql_format(DBConn, query, sizeof query, "UPDATE users SET `jailtime`  = %d WHERE `username` = %s", minutes, userName);
    mysql_query(DBConn, query);

    va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s baniu %s de modo offline por %d dias. Motivo: %s.", uInfo[playerid][uName], userName, minutes, reason);
    va_SendClientMessage(playerid, COLOR_GREEN, "Você baniu (offline) o usuário %s com sucesso.", userName);

    va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s prendeu %s na prisão administrativa por %d minutos pelo motivo: %s.", GetPlayerUserEx(playerid), userName, minutes, reason);
    SendServerMessage(playerid, "Você prendeu %s com sucesso.", userName);

    format(logString, sizeof(logString), "%s (%s) prendeu [off-line] %s (%d minutos, motivo: %s)", pNome(playerid), GetPlayerUserEx(playerid), userName, minutes, reason);
	logCreate(playerid, logString, 1);

    new string[512];
    format(string, sizeof(string), "%s preso off-line por %s (%d minutos, motivo: %s)", userName, GetPlayerUserEx(playerid), minutes, reason);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO serverlogs (`user`, `timestamp`, `log`, `type`) VALUES ('%s', '%d', '%s', '%d')", 
        userName, gettime(), string, 11);
    mysql_query(DBConn, query);

    new ls[512];
    format(ls, 512, "```[%s] %s```", GetFullDate(gettime()), string);
    utf8encode(ls, ls);
    DCC_SendChannelMessage(logChannels[10], ls);
    return true;
}

forward aJailMinuteCheck();
public aJailMinuteCheck() {
    foreach (new i : Player){
        if (!pInfo[i][pLogged]) return true;
        if (pInfo[i][pAFKCount] < 31 && uInfo[i][uJailed] > 0) {
            uInfo[i][uJailed] --;
            SetPlayerHealthEx(i, pInfo[i][pHealthMax]);
        } 
        if (uInfo[i][uJailed] == 0) freeAjail(i);
    } return true;
}

freeAjail(i) {
    uInfo[i][uJailed] = -1;

    ClearAnimations(i);   
    SetPlayerPos(i, 1742.9723,-1863.4432,13.5751);
	SetPlayerFacingAngle(i, 360.0);
	SetPlayerInterior(i, 0);
	SetPlayerVirtualWorld(i, 0);
	TogglePlayerControllable(i, true);
	SetCameraBehindPlayer(i);
		
	SendServerMessage(i, "Você cumpriu sua pena administrativa.");

    SaveUserInfo(i);
    SaveCharacterInfo(i);
    return true;
}