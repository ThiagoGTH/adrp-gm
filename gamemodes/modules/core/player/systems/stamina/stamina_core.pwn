#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
    SetPlayerMaxStamina(playerid, 2000);
    //SetPlayerSetamina(playerid, GetPlayerMaxStamina(playerid));
}

hook OnPlayerSpawn(playerid) {
    SetPlayerStamina(playerid, GetPlayerMaxStamina(playerid));
}


hook OnPlayerUpdate(playerid) {
	if(IsPlayerRunning(playerid)) GivePlayerStamina(playerid, -1);
	else if(GetPlayerStamina(playerid) < GetPlayerMaxStamina(playerid)) GivePlayerStamina(playerid, 1);
	return true;
}

public OnPlayerStaminaOver(playerid) {
	SetPlayerExhausted(playerid, true);
	return true;
}

CMD:sprint(playerid, params[]) {
	static
	  	Float:amount; 

	if (sscanf(params, "f", amount)) return SendSyntaxMessage(playerid, "/sprint [quantidade]");

	GivePlayerSprintVelocity(playerid, amount);
	SendServerMessage(playerid, "Você setou %s com %.2f de sprint.", pNome(playerid), amount);
	return true;
}

CMD:stamina(playerid, params[]) {
	static
	  	amount; 

	if (sscanf(params, "d", amount)) return SendSyntaxMessage(playerid, "/stamina [valor]");

	SetPlayerMaxStamina(playerid, amount);
	SetPlayerStamina(playerid, GetPlayerMaxStamina(playerid));
	SendServerMessage(playerid, "Você setou %s com %d de stamina.", pNome(playerid), amount);
	return true;
}

CMD:get(playerid, params[]){
	va_SendClientMessage(playerid, -1, "GetPlayerStamina %d", GetPlayerStamina(playerid));
	va_SendClientMessage(playerid, -1, "GetPlayerMaxStamina %d", GetPlayerMaxStamina(playerid));
	va_SendClientMessage(playerid, -1, "GetPlayerSprintVelocity %f", GetPlayerSprintVelocity(playerid));
	return true;
}
