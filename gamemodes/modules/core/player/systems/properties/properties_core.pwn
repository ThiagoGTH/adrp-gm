EnterGarage(playerid, gExitVw, gExitInterior, Float:gExitPos0, Float:gExitPos1, Float:gExitPos2, Float:gExitPos3) {
    SetPlayerVirtualWorld(playerid, gExitVw);
    SetPlayerInterior(playerid, gExitInterior);

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
        SetVehiclePos(GetPlayerVehicleID(playerid), gExitPos0, gExitPos1, gExitPos2);
        SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), gExitVw);
        LinkVehicleToInterior(GetPlayerVehicleID(playerid), gExitInterior);

        foreach(new passenger : Player) {
            if(passenger != playerid) {
                if(IsPlayerInVehicle(passenger, GetPlayerVehicleID(playerid))) {
                    SetPlayerInterior(passenger, gExitInterior);
                    pInfo[passenger][pInterior] = gExitInterior;
                    pInfo[passenger][pVirtualWorld] = gExitVw;
                    SetPlayerVirtualWorld(passenger, gExitInterior);
                }
            }
        }
    } else {
        SetPlayerPos(playerid, gExitPos0, gExitPos1, gExitPos2);
        SetPlayerFacingAngle(playerid, gExitPos3);
        SetCameraBehindPlayer(playerid);
    }

    return 1;
}

EnterProperty(playerid, vwExitProperty, interiorExitProperty, Float:exitPos0, Float:exitPos1, Float:exitPos2, Float:exitPos3) {

    SetPlayerVirtualWorld(playerid, vwExitProperty);
    SetPlayerInterior(playerid, interiorExitProperty);
    SetPlayerPos(playerid, exitPos0, exitPos1, exitPos2);
    SetPlayerFacingAngle(playerid, exitPos3);

    return 1;
}

ExitProperty(playerid, vwEntryProperty, interiorEntryProperty, Float:entryPos0, Float:entryPos1, Float:entryPos2, Float:entryPos3) {

    SetPlayerVirtualWorld(playerid, vwEntryProperty);
    SetPlayerInterior(playerid, interiorEntryProperty);
    SetPlayerPos(playerid, entryPos0, entryPos1, entryPos2);
    SetPlayerFacingAngle(playerid, entryPos3);
    
    return 1;
}

BuyProperty(playerid, propertyId, propertyType) {

    if(propertyType == 1) {
        hInfo[propertyId][hOwner] = pInfo[playerid][pID];
        SaveHouse(propertyId);
        format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
    
        return 1;
    }

    if(propertyType == 2) {
        bInfo[propertyId][bOwner] = pInfo[playerid][pID];
        SaveBusiness(propertyId);

        format(logString, sizeof(logString), "%s (%s) comprou a empresa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 13);

        return 1;
    }

	logCreate(playerid, logString, 13);

    return 1;
}

LockProperty(playerid, propertyId, propertyType) {

    if(propertyType == 1) {
        hInfo[propertyId][hLocked] = !hInfo[propertyId][hLocked];
        SaveHouse(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, hInfo[propertyId][hLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    if(propertyType == 2) {
        bInfo[propertyId][bLocked] = !bInfo[propertyId][bLocked];
        SaveBusiness(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, bInfo[propertyId][bLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    return 1;
}
