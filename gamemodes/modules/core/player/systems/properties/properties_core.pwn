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

ExitGarage(playerid, gEntryVw, gEntryInterior, Float:gEntryPos0, Float:gEntryPos1, Float:gEntryPos2, Float:gEntryPos3) {
    SetPlayerVirtualWorld(playerid, gEntryVw);
    SetPlayerInterior(playerid, gEntryInterior);

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
        SetVehiclePos(GetPlayerVehicleID(playerid), gEntryPos0, gEntryPos1, gEntryPos2);
        SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), gEntryVw);
        LinkVehicleToInterior(GetPlayerVehicleID(playerid), gEntryInterior);

        foreach(new passenger : Player) {
            if(passenger != playerid) {
                if(IsPlayerInVehicle(passenger, GetPlayerVehicleID(playerid))) {
                    SetPlayerInterior(passenger, gEntryInterior);
                    pInfo[passenger][pInterior] = gEntryInterior;
                    pInfo[passenger][pVirtualWorld] = gEntryVw;
                    SetPlayerVirtualWorld(passenger, gEntryInterior);
                }
            }
        }
    } else {
        SetPlayerPos(playerid, gEntryPos0, gEntryPos1, gEntryPos2);
        SetPlayerFacingAngle(playerid, gEntryPos3);
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
        new garageId;

        hInfo[propertyId][hOwner] = pInfo[playerid][pID];
        garageId = hInfo[propertyId][hGarage]

        if(garageId) {
            if(GarageHasOwner(garageId))
                va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetBusinessAddress(propertyId));
                continue;

            gInfo[garageId][gOwner] = pInfo[playerid][pID];
            SaveGarage(garageId);

            format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d e atrelado à ela, a garagem ID %d.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, garageId);
            logCreate(playerid, logString, 25);
            logCreate(playerid, logString, 13);

            va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(propertyId));
            va_SendClientMessage(playerid, COLOR_YELLOW, "Junto da sua casa nova, no mesmo endereço, você também adquiriu a garagem dela.");

            return 1;
        }

        SaveHouse(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(propertyId));

        format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
        logCreate(playerid, logString, 13);

        return 1;
    }

    if(propertyType == 2) {
        bInfo[propertyId][bOwner] = pInfo[playerid][pID];
        SaveBusiness(propertyId);

        format(logString, sizeof(logString), "%s (%s) comprou a empresa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 24);

        return 1;
    }

    if(propertyType == 3) {
        gInfo[propertyId][gOwner] = pInfo[playerid][pID];
        SaveGarage(propertyId);

        format(logString, sizeof(logString), "%s (%s) comprou a empresa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 25);

        return 1;
    }

    return 1;
}

LockProperty(playerid, propertyId, propertyType) {

    // house
    if(propertyType == 1) {
        hInfo[propertyId][hLocked] = !hInfo[propertyId][hLocked];
        SaveHouse(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, hInfo[propertyId][hLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    // business
    if(propertyType == 2) {
        bInfo[propertyId][bLocked] = !bInfo[propertyId][bLocked];
        SaveBusiness(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, bInfo[propertyId][bLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    // garage
    if(propertyType == 3) {
        gInfo[propertyId][gLocked] = !gInfo[propertyId][gLocked];
        SaveBusiness(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, gInfo[propertyId][gLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    return 1;
}
