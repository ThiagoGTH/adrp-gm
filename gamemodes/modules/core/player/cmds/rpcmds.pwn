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

CMD:gritar(playerid,params[]) {
    new string[128];
    if(isnull(params)) return SendSyntaxMessage(playerid, "/gritar [texto].");
    format(string, sizeof(string), "%s grita: %s!", pNome(playerid), params);
    ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
    return true;
} 
alias:gritar("g")

CMD:baixo(playerid, params[]) {
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/baixo [texto]");

	if (strlen(params) > 64) {
	    if (IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(GetPlayerVehicleID(playerid)) && !vInfo[GetPlayerVehicleID(playerid)][vWindowsDown]) {
		    SendVehicleMessage(GetPlayerVehicleID(playerid), COLOR_WHITE, "[baixo] %s diz: %.64s", pNome(playerid), params);
	    	SendVehicleMessage(GetPlayerVehicleID(playerid), COLOR_WHITE, "...%s", params[64]);
		} else {
			SendNearbyMessage(playerid, 5.0, COLOR_FADE2, "[baixo] %s diz: %.64s", pNome(playerid), params);
	    	SendNearbyMessage(playerid, 5.0, COLOR_FADE2, "...%s", params[64]);
		}
	} else {
	    if (IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(GetPlayerVehicleID(playerid)) && !vInfo[GetPlayerVehicleID(playerid)][vWindowsDown])
		    SendVehicleMessage(GetPlayerVehicleID(playerid), COLOR_WHITE, "[baixo] %s diz: %s", pNome(playerid), params);
		else
			SendNearbyMessage(playerid, 5.0, COLOR_FADE2, "[baixo] %s diz: %s", pNome(playerid), params);
	}
	return true;
}

CMD:s(playerid, params[]) {
    if(pInfo[playerid][pInjured])
        return va_SendClientMessage(playerid, COLOR_WHITE, "Você não pode sussurrar no momento.");

	new userid, text[128];

    if(sscanf(params, "us[128]", userid, text))
	    return va_SendClientMessage(playerid, COLOR_WHITE, "USAGE: (/s)ussurrar [ID/Parte do nome] [texto do sussurro.]");

	if(userid == playerid)
	    return va_SendClientMessage(playerid, COLOR_YELLOW, "Esse é o seu ID.");

	if(!IsPlayerNearPlayer(playerid, userid, 2.0))
	    return SendErrorMessage(playerid, "Você não está perto desse jogador.");

    if(strlen(text) > 80) {
	    va_SendClientMessage(userid, COLOR_YELLOW, "%s sussurrou: %.80s", pNome(playerid), text);
	    va_SendClientMessage(userid, COLOR_YELLOW, "... %s **", text[80]);

	    va_SendClientMessage(playerid, COLOR_YELLOW, "%s sussurrou: %s", pNome(playerid), text);
	}
	else {
	    va_SendClientMessage(userid, COLOR_YELLOW, "%s sussurrou: %s", pNome(playerid), text);
		va_SendClientMessage(playerid, COLOR_YELLOW, "%s sussurrou: %s", pNome(playerid), text);
	}

	format(text, sizeof(text), "* %s sussurra alguma coisa.", pNome(playerid));
	SetPlayerChatBubble(playerid, text, COLOR_PURPLE, 20.0, 3000);
	return true;
		
}
alias:sussurrar("s")

CMD:mebaixo(playerid, params[]) {
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/mebaixo [texto]");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %.80s ...", pNome(playerid), params);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* ... %s (( %s ))", params[80], pNome(playerid));
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %s", pNome(playerid), params);

	return true;	
}
alias:mebaixo("meb")


CMD:dobaixo(playerid, params[]) {
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/dobaixo [texto]");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %.80s ... (( %s ))", params, pNome(playerid));
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s (( %s ))", params[80], pNome(playerid));
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s (( %s ))", params, pNome(playerid));

	return true;

}
alias:dobaixo("dob")

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