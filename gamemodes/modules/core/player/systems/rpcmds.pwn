#include <YSI_Coding\y_hooks>

// IC:
CMD:ame(playerid, params[]){
	if (isnull(params)) return SendSyntaxMessage(playerid, "/ame [a��o a ser realizada]");
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
	if (isnull(params)) return SendSyntaxMessage(playerid, "/ado [descri��o]");
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

// OOC:
CMD:b(playerid, params[]){
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