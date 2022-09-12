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