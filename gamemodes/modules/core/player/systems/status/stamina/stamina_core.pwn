#include <YSI_Coding\y_hooks>

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

CMD:stamina(playerid, params[]) {
	static
	  	amount; 

	if (sscanf(params, "d", amount)) return SendSyntaxMessage(playerid, "/stamina [valor]");

	SetPlayerMaxStamina(playerid, amount);
	SetPlayerStamina(playerid, GetPlayerMaxStamina(playerid));
	SendServerMessage(playerid, "Você setou %s com %d de stamina.", pNome(playerid), amount);
	return true;
}