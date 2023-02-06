#if !defined STAMINA_DEFAULT_RECOVERYTIME
	#define STAMINA_DEFAULT_RECOVERYTIME    (2000)
#endif

forward OnPlayerStaminaOver(playerid);

stock IsPlayerRunning(playerid) {
    if(!IsPlayerConnected(playerid) || IsPlayerInAnyVehicle(playerid) || IsPlayerExhausted(playerid)) return false;

    new KEY:keys, KEY:updown, KEY:leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if(keys & KEY_SPRINT && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USEJETPACK) return true;
    else return false;
}


stock IsPlayerExhausted(playerid) {
	if(GetPVarInt(playerid, "Exhausted") == 1) return true;
	else return false;
}

forward SetPlayerExhausted(playerid, bool:Exhausted);
public SetPlayerExhausted(playerid, bool:Exhausted) { 
	if(Exhausted) {
		TogglePlayerControllable(playerid, false);
		TogglePlayerControllable(playerid, true);

		ApplyAnimation(playerid, "FAT", "IDLE_tired", 4.1, false, true, true, false, STAMINA_DEFAULT_RECOVERYTIME);

		SetPVarInt(playerid, "Exhausted", 1);
		SetTimerEx("SetPlayerExhausted", STAMINA_DEFAULT_RECOVERYTIME, false, "ib", playerid, false);
	}
	else SetPVarInt(playerid, "Exhausted", 0), ClearAnimations(playerid);
	return true;
}


stock GetPlayerStamina(playerid) {
	if(!IsPlayerConnected(playerid) || GetPVarType(playerid, "MAX_Stamina") == PLAYER_VARTYPE_NONE) return -1;
	new stamina = GetPVarInt(playerid, "Stamina");
	return stamina;
}


stock GetPlayerMaxStamina(playerid) {
	if(!IsPlayerConnected(playerid) || GetPVarType(playerid, "MAX_Stamina") == PLAYER_VARTYPE_NONE) return -1;
	new maxstamina = GetPVarInt(playerid, "MAX_Stamina");
	return maxstamina;
}


stock GivePlayerStamina(playerid, value) {
	new stamina = GetPVarInt(playerid, "Stamina");

	if(stamina == -1) return true;
	if(stamina + value == 0) return CallLocalFunction("OnPlayerStaminaOver", "i", playerid);
	if(stamina + value <= GetPVarInt(playerid, "MAX_Stamina")) 
	{
		stamina = stamina+value;
		SetPVarInt(playerid, "Stamina", stamina);
		return true;
	}
	else return false;
}


stock GivePlayerMaxStamina(playerid, value) {
	new maxstamina = GetPVarInt(playerid, "MAX_Stamina"), stamina = GetPVarInt(playerid, "Stamina");

	maxstamina = maxstamina + value;
	SetPVarInt(playerid, "MAX_Stamina", maxstamina);

	if(stamina > maxstamina)stamina = maxstamina, SetPVarInt(playerid, "Stamina", stamina);

	return true;
}


stock SetPlayerStamina(playerid, value) {
	if(value > GetPVarInt(playerid, "MAX_Stamina")) return SetPVarInt(playerid, "Stamina", GetPVarInt(playerid, "MAX_Stamina")); //if the current stamina exceeds the MAX_STAMINA, set the player's MAX_STAMINA directly to avoid bugs
	else if(value == 0) OnPlayerStaminaOver(playerid);
	SetPVarInt(playerid, "Stamina", value);
	return true;
}


stock SetPlayerMaxStamina(playerid, value) {
	new stamina = GetPlayerStamina(playerid), max_stamina = value;

	if(stamina > max_stamina) stamina = max_stamina, SetPVarInt(playerid, "Stamina", stamina);
	SetPVarInt(playerid, "MAX_Stamina", max_stamina);
	return true;
}

stock GivePlayerSprintVelocity(playerid, Float:value) {
	new Float:x, Float:y, Float:z;
	if(value == 0.0) return true;
	else if(value > 0.0) {
		GetPlayerVelocity(playerid, x, y, z);
		SetPlayerVelocity(playerid, x*value, y*value, z*value);
	}
	else if(value < 0.0) {
		GetPlayerVelocity(playerid, x, y, z);
		SetPlayerVelocity(playerid, x/value, y/value, z/value);
	}
	SetPVarFloat(playerid, "Sprint_Velocity", value);
	return true;
}

stock GetPlayerSprintVelocity(playerid) {
	if(!IsPlayerConnected(playerid)) return -1;
	new Float:velocity = GetPVarFloat(playerid, "Sprint_Velocity");
	return Float:velocity;
}