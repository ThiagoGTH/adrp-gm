#include <YSI_Coding\y_hooks>

// IC:
CMD:ame(playerid, params[]){
	if (IsPlayerWatchingCamera(playerid)) return SendErrorMessage(playerid, "Você não pode usar esse comando enquanto assiste uma transmissão ao vivo.");

	if (isnull(params)) return SendSyntaxMessage(playerid, "/ame [ação a ser realizada]");
    static string[128];

	new Float:range;
	if(GetPlayerInterior(playerid) > 0) range = 5.0;
    else if(GetPlayerVirtualWorld(playerid) > 0) range = 5.0;
    else range = 40.0;

	format(string, sizeof(string), "* %s %s", pNome(playerid), params);
 	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, range, 15000);
 	va_SendClientMessage(playerid, COLOR_PURPLE, "> %s %s", pNome(playerid), params);
	return true;
}

CMD:ado(playerid, params[]){
	if (IsPlayerWatchingCamera(playerid)) return SendErrorMessage(playerid, "Você não pode usar esse comando enquanto assiste uma transmissão ao vivo.");

	if (isnull(params)) return SendSyntaxMessage(playerid, "/ado [descrição]");
    static string[128];

	new Float:range;
	if(GetPlayerInterior(playerid) > 0) range = 5.0;
    else if(GetPlayerVirtualWorld(playerid) > 0) range = 5.0;
    else range = 40.0;

	format(string, sizeof(string), "* %s (( %s ))", params, pNome(playerid));
 	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, range, 10000);
 	va_SendClientMessage(playerid, COLOR_PURPLE, "> %s (( %s ))", params, pNome(playerid));
	return true;
}

CMD:me(playerid, params[]){
	if (IsPlayerWatchingCamera(playerid)) return SendErrorMessage(playerid, "Você não pode usar esse comando enquanto assiste uma transmissão ao vivo.");

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/me [ação a ser realizada]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 25.0, COLOR_PURPLE, "* %s %.64s", pNome(playerid), params);
	    SendNearbyMessage(playerid, 25.0, COLOR_PURPLE, "...%s", params[64]);
	} else SendNearbyMessage(playerid, 25.0, COLOR_PURPLE, "* %s %s", pNome(playerid), params);
	return true;
}

CMD:do(playerid, params[]){
	if (IsPlayerWatchingCamera(playerid)) return SendErrorMessage(playerid, "Você não pode usar esse comando enquanto assiste uma transmissão ao vivo.");
	
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/do [descrição]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 25.0, COLOR_PURPLE, "* %.64s", params);
	    SendNearbyMessage(playerid, 25.0, COLOR_PURPLE, "...%s (( %s ))", params[64], pNome(playerid));
	} else SendNearbyMessage(playerid, 25.0, COLOR_PURPLE, "* %s (( %s ))", params, pNome(playerid));
	return true;
}

CMD:gritar(playerid,params[])
{
    new string[128];
    if(isnull(params)) return va_SendClientMessage(playerid, COLOR_YELLOW,"{FF4A4A}USE:{FFFFFF} /gritar [texto].");
    format(string, sizeof(string), "%s grita: %s!", pNome(playerid), params);
    ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
    return 1;
} 
alias:gritar("g")

CMD:s(playerid, params[])
{
    if(pInfo[playerid][pInjured])
        return va_SendClientMessage(playerid, COLOR_GRAD1, "Você não pode sussurrar no momento.");

	new userid, text[128];

    if(sscanf(params, "us[128]", userid, text))
	    return va_SendClientMessage(playerid, COLOR_GRAD2, "USAGE: (/s)ussurrar [ID/Parte do nome] [texto do sussurro.]");

	if(userid == playerid)
	    return va_SendClientMessage(playerid, COLOR_YELLOW, "Esse é o seu ID.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Você não está perto desse jogador.");

    if(strlen(text) > 80) {
	    va_SendClientMessage(userid, COLOR_YELLOW, "%s sussurrou: %.80s", pNome(playerid, 0), text);
	    va_SendClientMessage(userid, COLOR_YELLOW, "... %s **", text[80]);

	    va_SendClientMessage(playerid, COLOR_YELLOW, "%s sussurrou: %s", pNome(playerid, 0), text);
	}
	else {
	    va_SendClientMessage(userid, COLOR_YELLOW, "%s sussurrou: %s", pNome(playerid, 0), text);
		va_SendClientMessage(playerid, COLOR_YELLOW, "%s sussurrou: %s", pNome(playerid, 0), text);
	}

	format(text, sizeof(text), "* %s sussurra alguma coisa.", pNome(playerid, 0));
	_SetPlayerChatBubble(playerid, text, COLOR_PURPLE, 20.0, 3000);
	return 1;
		
}
alias:sussurrar("s")

CMD:mebaixo(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/mebaixo [texto]");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %.80s ...", pNome(playerid, 0), params);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* ... %s (( %s ))", params[80], pNome(playerid, 0));
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %s", pNome(playerid, 0), params);

	return true;
	
	>
	alias:mebaixo("meb")

}

CMD:dobaixo(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/dobaixo [texto]");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %.80s ... (( %s ))", params, pNome(playerid, 0));
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s (( %s ))", params[80], pNome(playerid, 0));
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s (( %s ))", params, pNome(playerid, 0));

	return true;

}
alias:("dob")


// OOC:
CMD:b(playerid, params[]){
	if (IsPlayerWatchingCamera(playerid)) return SendErrorMessage(playerid, "Você não pode usar esse comando enquanto assiste uma transmissão ao vivo.");

	if (isnull(params)) return SendSyntaxMessage(playerid, "/b [OOC]");
	
	if (strlen(params) > 64){
	    if(pInfo[playerid][pAdminDuty] == 1){
			if(GetPlayerAdmin(playerid) == 1){
				SendNearbyMessage(playerid, 7.0, COLOR_GREY, "(( [%d] {660000}%s{AFAFAF}: %.64s", playerid, pNome(playerid), params);
				SendNearbyMessage(playerid, 7.0, COLOR_GREY, "...%s ))", params[64]);
				return true;
			}
			else if(GetPlayerAdmin(playerid) > 1){
				SendNearbyMessage(playerid, 7.0, COLOR_GREY, "(( [%d] {408080}%s{AFAFAF}: %.64s", playerid, pNome(playerid), params);
				SendNearbyMessage(playerid, 7.0, COLOR_GREY, "...%s ))", params[64]);
				return true;
			}
	        return true;
		}
	    SendNearbyMessage(playerid, 7.0, COLOR_GREY, "(( [%d] %s: %.64s", playerid, pNome(playerid), params);
	    SendNearbyMessage(playerid, 7.0, COLOR_GREY, "...%s ))", params[64]);
	}else{
		if(pInfo[playerid][pAdminDuty] == 1){
			if(GetPlayerAdmin(playerid) == 1) return SendNearbyMessage(playerid, 7.0, COLOR_GREY, "(( [%d] {660000}%s{AFAFAF}: %s ))", playerid, pNome(playerid), params);
			else if(GetPlayerAdmin(playerid) > 1) return SendNearbyMessage(playerid, 7.0, COLOR_GREY, "(( [%d] {408080}%s{AFAFAF}: %s ))", playerid, pNome(playerid), params);
	        return true;
		}
	    SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: %s ))", playerid, pNome(playerid), params);
	}
	return true;
}

CMD:pm(playerid, params[])
{
    new str[128], text[128], targetid;
    if(sscanf(params, "us[128]", targetid, text)) return va_SendClientMessage(playerid, COLOR_YELLOW, "{FF4A4A}USE:{FFFFFF} /pm [texto].");
    if(!IsPlayerConnected(targetid)) return va_SendClientMessage(playerid, COLOR_YELLOW, "{018217}SERVER:{FFFFFF} O ID informado não é de nenhum usuário conectado.");
    format(str, sizeof(str), "PM para %s (%d): %s", pNome(targetid), targetid, text);
    va_SendClientMessage(playerid, 0xE0E800FF, str);
    format(str, sizeof(str), "PM de %s (%d): %s", pNome(playerid), playerid, text);
    va_SendClientMessage(targetid, 0xE8C900FF, str);
    return 1;
} 



