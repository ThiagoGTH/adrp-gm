GivePlayerCamera(playerid){
   	pInfo[playerid][pRecording] = true;
	ClearAnimations(playerid);
	SetPlayerSpecialAction(playerid , SPECIAL_ACTION_USECELLPHONE);
	SetPlayerAttachedObject(playerid, 0, -6001, 6, 0.066999, -0.029999, -0.119999, -29.200008, 44.899986, 8.600002, 1.000000, 1.000000, 1.000000);
	return true;
}

RemovePlayerCamera(playerid){
    pInfo[playerid][pRecording] = false;
	ClearAnimations(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 0);
	return true;
}

StartPlayerWatchingCamera(playerid, cameraman){
	if(!pInfo[cameraman][pRecording] || !IsPlayerConnected(cameraman)) return false;
	if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING){ // Salvar informações do jogador antes de setar a visão
		GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
		GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
		pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
		pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
	}

	pInfo[playerid][pWatching] = true;
	pInfo[playerid][pWatchingPlayer] = cameraman;
    ShowNewsTextdraws(playerid);
	SetPlayerInterior(playerid, GetPlayerInterior(cameraman));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(cameraman));
	TogglePlayerSpectating(playerid, true);
	PlayerSpectatePlayer(playerid, cameraman, SPECTATE_MODE_SIDE);
	pInfo[playerid][pCameraTimer] = SetTimerEx("OnPlayerCameraUpdate", 5, true, "ii", playerid, cameraman);
	return true;
}

StopPlayerWatchingCamera(playerid){
	pInfo[playerid][pWatching] = false;
	pInfo[playerid][pWatchingPlayer] = INVALID_PLAYER_ID;
	KillTimer(pInfo[playerid][pCameraTimer]);

    HideNewsTextdraws(playerid);
	
	PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
	PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);
	SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
	SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
	SetSpawnInfo(playerid, false, pInfo[playerid][pSkin], 
        pInfo[playerid][pPositionX], 
        pInfo[playerid][pPositionY], 
        pInfo[playerid][pPositionZ],
        pInfo[playerid][pPositionA],
        WEAPON_FIST, 0, 
        WEAPON_FIST, 0, 
        WEAPON_FIST, 0);
	TogglePlayerSpectating(playerid, false);
	SetCameraBehindPlayer(playerid);
	SetWeapons(playerid);

	va_SendClientMessage(playerid, COLOR_GREEN, "Você deixou de assistir a transmissão ao vivo.");
	return true;
}

forward OnPlayerCameraUpdate(playerid, cameraman);
public OnPlayerCameraUpdate(playerid, cameraman){
    if(pInfo[playerid][pWatching]){
        if(pInfo[cameraman][pRecording]) {
        	new Float:x, Float:y, Float:z;
        	GetPlayerPos(cameraman, x, y, z);
    		GetXYInFrontOfPlayer(cameraman, x, y, 0.6);
        	SetPlayerCameraPos(playerid, x, y, z+0.8);
        	GetPlayerPos(cameraman, x, y, z);
        	GetXYInFrontOfPlayer(cameraman, x, y, 10.0);
        	SetPlayerCameraLookAt(playerid, x, y, z+0.8);
        } else StopPlayerWatchingCamera(playerid);
    }
    return true;
}

