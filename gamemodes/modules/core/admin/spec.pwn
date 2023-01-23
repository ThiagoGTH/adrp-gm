#include <YSI_Coding\y_hooks>

static
    bool:gPlayerIsSpectating[MAX_PLAYERS],
    gSpectatingPlayer[MAX_PLAYERS],
    bool:gIsPlayerBeingSpectated[MAX_PLAYERS]
;

hook OnPlayerConnect(playerid) {
    gPlayerIsSpectating[playerid] = false;
    gSpectatingPlayer[playerid] = INVALID_PLAYER_ID;
    gIsPlayerBeingSpectated[playerid] = false;
    return true;
}

hook OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
    if(gIsPlayerBeingSpectated[playerid]) {
        foreach(new i : Player) {
            if(gPlayerIsSpectating[i] && gSpectatingPlayer[i] == playerid) {
                PlayerSpectatePlayer(i, playerid);
                SyncSpectate(playerid, i);
            }
        }
    }
    return true;
}

SyncSpectate(playerid, forplayerid) {
	SetPlayerVirtualWorld(forplayerid, GetPlayerVirtualWorld(playerid));
	SetPlayerInterior(forplayerid, GetPlayerInterior(playerid));
}

hook OnPlayerSpawn(playerid) {
    if(gPlayerIsSpectating[playerid]) {
        gPlayerIsSpectating[playerid] = false;

        SetPlayerHealth(playerid, pInfo[playerid][pHealth]);
        SetPlayerArmour(playerid, pInfo[playerid][pArmour]);
        
        SetPlayerPos(playerid,  pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
        SetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
        SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
        SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
    }
    return true;
}

CMD:spec(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);

    if (!isnull(params) && !strcmp(params, "off", true)) {
	    new spectators;
        if(!gPlayerIsSpectating[playerid]) return SendErrorMessage(playerid, "Você não está observando nenhum jogador.");

        pInfo[playerid][pSpectating] = INVALID_PLAYER_ID;
		format(logString, sizeof(logString), "%s (%s) parou de espiar %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(gSpectatingPlayer[playerid]));
		logCreate(playerid, logString, 1);

        foreach(new i : Player) {
            if(i == playerid) continue;
            if(gPlayerIsSpectating[i] && gSpectatingPlayer[i] == gSpectatingPlayer[playerid]) {
                spectators++;
            }
        }
        if(spectators == 0) {
            gIsPlayerBeingSpectated[gSpectatingPlayer[playerid]] = false;
        }

        pInfo[playerid][pSpectating] = INVALID_PLAYER_ID;
        TogglePlayerSpectating(playerid, false);
        SpawnPlayer(playerid);
        SetWeapons(playerid);
	    
	  	return SendServerMessage(playerid, "SERVER: Você não está mais no modo espectador.");
	}
    
    new target;
    if (sscanf(params, "u", target)) return SendSyntaxMessage(playerid, "/spec [playerid/nome]");
    if (!IsPlayerConnected(target)) return SendNotConnectedMessage(playerid);
    if (IsPlayerWatchingCamera(target)) return SendErrorMessage(playerid, "O jogador está assistindo uma transmissão, então não é possível espectar ele.");
	if (GetPlayerState(target) == PLAYER_STATE_SPECTATING) return SendErrorMessage(playerid, "O administrador está de spec em alguém, então não é possível espectar ele.");

    if(!gPlayerIsSpectating[playerid]) {
        GetPlayerHealth(playerid, pInfo[playerid][pHealth]);
        GetPlayerArmour(playerid, pInfo[playerid][pArmour]);
        GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
        GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
        pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
        pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
    }

    TogglePlayerSpectating(playerid, true);
    gPlayerIsSpectating[playerid] = true;
    gIsPlayerBeingSpectated[target] = true;
    gSpectatingPlayer[playerid] = target;
    if(IsPlayerInAnyVehicle(target)) {
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(target));
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(target));
        SetPlayerInterior(playerid, GetPlayerInterior(target));
    } else PlayerSpectatePlayer(playerid, target);
    
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "Você agora está observando %s (ID: %d). Use '/spec off' para sair do spec.", pNome(target), target);
	pInfo[playerid][pSpectating] = target;

	format(logString, sizeof(logString), "%s (%s) está observando %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(target));
	logCreate(playerid, logString, 1);

    return true;
}

CMD:checarspecs(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    new spectating = 0;
    foreach(new i : Player) {
        if(gPlayerIsSpectating[i]) {
            if(!spectating) SendServerMessage(playerid, "Administradores espiando:");
            va_SendClientMessage(playerid, COLOR_GREY, "%s está espiando %s (%s).", GetPlayerUserEx(i), pNome(gSpectatingPlayer[i]), GetPlayerUserEx(gSpectatingPlayer[i]));
            spectating++;
        }
    }

    if(!spectating) return SendErrorMessage(playerid, "Não tem nenhum administrador espiando no momento.");
    format(logString, sizeof(logString), "%s (%s) checou os administradores em spec.", pNome(playerid), GetPlayerUserEx(playerid));
	logCreate(playerid, logString, 1);
    return true;
}

hook OnPlayerStateChange(playerid, newstate, oldstate) {
    if(gIsPlayerBeingSpectated[playerid]) {
        if(oldstate == 4 && newstate == 5) {
            foreach(new i : Player) {
                if(gPlayerIsSpectating[i] && gSpectatingPlayer[i] == playerid) {
                    PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
                    SyncSpectate(playerid, i);
                }
            }
        } else if(oldstate == 5 && newstate == 4) {
            foreach(new i : Player)  {
                if(gPlayerIsSpectating[i] && gSpectatingPlayer[i] == playerid) {
                    PlayerSpectatePlayer(i, playerid);
                    SyncSpectate(playerid, i);
                }
            }
        }
    }
    return true;
}

hook OnPlayerDisconnect(playerid, reason) {
    if(gIsPlayerBeingSpectated[playerid]) {
        foreach(new i : Player) {
            if(gPlayerIsSpectating[i] && gSpectatingPlayer[i] == playerid) {
                SendServerMessage(i, "%s (%s) saiu do servidor enquanto você espiava.");
                format(logString, sizeof(logString), "%s (%s) parou de espiar %s (quitou do servidor).", pNome(i), GetPlayerUserEx(i), pNome(playerid));
	            logCreate(i, logString, 1);
                TogglePlayerSpectating(i, false);
                SpawnPlayer(i);
                SetWeapons(i);
            }
        }
    }
    return true;
}