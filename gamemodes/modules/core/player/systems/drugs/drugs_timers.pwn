forward RegenHealth(playerid, amount);
public RegenHealth(playerid, amount) {
	amount--;
	
	new Float: health = GetPlayerHealthEx(playerid);
	
	if(health + 2.5 < 95.0) SetPlayerHealthEx(playerid, health + 2.5);
	if(amount > 0) {
	    SetPlayerDrunkLevel(playerid, 4999);
		
		RegenTimer[playerid] = SetTimerEx("RegenHealth", 500, false, "ii", playerid, amount);
	} else {
	    SetPlayerDrunkLevel(playerid, 0);
		
	    if(RegenTimer[playerid] != -1) {
		    KillTimer(RegenTimer[playerid]);
		    RegenTimer[playerid] = -1;
		}
	}
	
	return true;
}

forward RemoveEffects(playerid);
public RemoveEffects(playerid) {
	SetPlayerDrunkLevel(playerid, 0);
	SetPlayerWeather(playerid, 14);
	
	if(EffectTimer[playerid] != -1) {
	    KillTimer(EffectTimer[playerid]);
	    EffectTimer[playerid] = -1;
	}
	
	return true;
}