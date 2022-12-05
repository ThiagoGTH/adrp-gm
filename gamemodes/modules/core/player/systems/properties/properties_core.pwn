EnterProperty(playerid, vwExitProperty, interiorExitProperty, Float:exitPos0, Float:exitPos1, Float:exitPos2, Float:exitPos3, bool:isGarage) {
    if(IsPlayerInAnyVehicle(playerid) && isGarage) {
        new vehicleid = GetPlayerVehicleID(playerid);

        SetVehiclePos(vehicleid, exitPos0, exitPos1, exitPos2 - 1);
        SetVehicleZAngle(vehicleid, exitPos3);
        LinkVehicleToInterior(vehicleid, interiorExitProperty);
        SetVehicleVirtualWorld(vehicleid, vwExitProperty);

        foreach(new passenger : Player) {
            if(passenger != playerid) {
                if(IsPlayerInVehicle(passenger, vehicleid)) {
                    SetPlayerVirtualWorld(passenger, vwExitProperty);
                    SetPlayerInterior(passenger, interiorExitProperty);
                }
            }
        }
    } else {
        SetPlayerPos(playerid, exitPos0, exitPos1, exitPos2);
        SetPlayerFacingAngle(playerid, exitPos0);
    }

    SetPlayerVirtualWorld(playerid, vwExitProperty);
    SetPlayerInterior(playerid, interiorExitProperty);
    SetCameraBehindPlayer(playerid);

    return 1;
}

ExitProperty(playerid, vwEntryProperty, interiorEntryProperty, Float:entryPos0, Float:entryPos1, Float:entryPos2, Float:entryPos3, bool:isGarage) {
    if(IsPlayerInAnyVehicle(playerid) && isGarage) {
        new vehicleid = GetPlayerVehicleID(playerid);

        SetVehiclePos(vehicleid, entryPos0, entryPos1, entryPos2 + 5);
        SetVehicleZAngle(vehicleid, entryPos3);
        LinkVehicleToInterior(vehicleid, interiorEntryProperty);
        SetVehicleVirtualWorld(vehicleid, vwEntryProperty);

        foreach(new passenger : Player) {
            if(passenger != playerid) {
                if(IsPlayerInVehicle(passenger, vehicleid)) {
                    SetPlayerVirtualWorld(passenger, vwEntryProperty);
                    SetPlayerInterior(passenger, interiorEntryProperty);
                }
            }
        }
    } else {
        SetPlayerPos(playerid, entryPos0, entryPos1, entryPos2);
        SetPlayerFacingAngle(playerid, entryPos2);
    }

    SetPlayerVirtualWorld(playerid, vwEntryProperty);
    SetPlayerInterior(playerid, interiorEntryProperty);
    SetCameraBehindPlayer(playerid);

    return 1;
}

BuyProperty(playerid, propertyId, propertyType) {

    if(propertyType == 1) {
        new garageId;

        garageId = hInfo[propertyId][hGarage];

        if(garageId > 0) {
            if(GarageHasOwner(garageId)){
                hInfo[propertyId][hOwner] = pInfo[playerid][pID];
                va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(propertyId));
                SaveHouse(propertyId);

                format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
                logCreate(playerid, logString, 13);

                return 1;
            }
            hInfo[propertyId][hOwner] = pInfo[playerid][pID];
            SaveHouse(propertyId);

            printf("Antigo dono da garagem ID %d é o ID %d.", garageId, gInfo[garageId][gOwner]);
            gInfo[garageId][gOwner] = hInfo[propertyId][hOwner];
            SaveGarage(garageId);
            printf("Novo dono da garagem ID %d é o ID %d.", garageId, gInfo[garageId][gOwner]);

            format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s e junto dela, a garagem ID %d.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]), garageId);
            logCreate(playerid, logString, 13);
            logCreate(playerid, logString, 25);

            va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(propertyId));
            va_SendClientMessage(playerid, COLOR_YELLOW, "Junto da sua casa nova, no mesmo endereço, você também adquiriu a garagem dela.");

            return 1;
        } else {
            hInfo[propertyId][hOwner] = pInfo[playerid][pID];
            SaveHouse(propertyId);
            va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(propertyId));

            format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
            logCreate(playerid, logString, 13);

            return 1;

        }
    }

    if(propertyType == 2) {
        bInfo[propertyId][bOwner] = pInfo[playerid][pID];
        SaveBusiness(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a empresa no endereço %s.", GetBusinessAddress(propertyId));

        format(logString, sizeof(logString), "%s (%s) comprou a empresa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 24);

        return 1;
    }

    if(propertyType == 3) {
        gInfo[propertyId][gOwner] = pInfo[playerid][pID];
        SaveGarage(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a garagem no endereço %s.", GetGarageAddress(propertyId));


        format(logString, sizeof(logString), "%s (%s) comprou a gargem ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 25);

        return 1;
    }

    return 1;
}


AdminSellProperty(playerid, propertyId, propertyType) {

    if(propertyType == 1) {
        new garageId;

        garageId = hInfo[propertyId][hGarage];

        if(hInfo[propertyId][hOwner] == 0)
            return SendErrorMessage(playerid, "Essa propriedade já está à venda. (/propinfo)");

        if(garageId > 0) {
            if(GarageHasOwner(garageId)){
                hInfo[propertyId][hOwner] = 0;
                va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a casa no endereço %s a venda.", GetHouseAddress(propertyId));
                SaveHouse(propertyId);

                format(logString, sizeof(logString), "%s (%s) colocou a casa ID %d a venda por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
                logCreate(playerid, logString, 13);

                return 1;
            }
            hInfo[propertyId][hOwner] = 0;
            SaveHouse(propertyId);

            // debug 
            printf("Antigo dono da garagem ID %d é o ID %d.", garageId, gInfo[garageId][gOwner]);

            gInfo[garageId][gOwner] = 0;
            SaveGarage(garageId);

            //debug
            printf("Novo dono da garagem ID %d é o ID %d.", garageId, gInfo[garageId][gOwner]);

            format(logString, sizeof(logString), "%s (%s) colocou a casa ID %d a venda por $%s e junto dela, a garagem ID %d.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]), garageId);
            logCreate(playerid, logString, 13);
            logCreate(playerid, logString, 25);

            va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a casa e garagem no endereço %s a venda.", GetHouseAddress(propertyId));

            return 1;
        } else {
            hInfo[propertyId][hOwner] = 0;
            SaveHouse(propertyId);
            va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a casa no endereço %s a venda.", GetHouseAddress(propertyId));

            format(logString, sizeof(logString), "%s (%s) colocou a casa ID %d a venda por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
            logCreate(playerid, logString, 13);

            return 1;

        }
    }

    if(propertyType == 2) {
        if(bInfo[propertyId][bOwner] == 0)
            return SendErrorMessage(playerid, "Essa propriedade já está à venda. (/propinfo)");

        bInfo[propertyId][bOwner] = 0;
        SaveBusiness(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a empresa no endereço %s a venda.", GetBusinessAddress(propertyId));

        format(logString, sizeof(logString), "%s (%s) colocou a empresa ID %d a venda por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 24);

        return 1;
    }

    if(propertyType == 3) {
        if(gInfo[propertyId][gOwner] == 0)
            return SendErrorMessage(playerid, "Essa propriedade já está à venda. (/propinfo)");
            
        gInfo[propertyId][gOwner] = 0;
        SaveGarage(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a garagem no endereço %s a venda.", GetGarageAddress(propertyId));

        format(logString, sizeof(logString), "%s (%s) colocou a garagem ID %d a venda por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
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
