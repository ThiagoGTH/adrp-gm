CMD:entrar(playerid) {
    new vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3;

    new houseID = GetNearestHouseEntry(playerid), entryID = GetNearestHouseSecondEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);
    
    if(houseID !== -1) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa está trancada.");
        
        vwExit = hInfo[houseID][vwExit];
        interiorExit = hInfo[houseID][interiorExit];
        exitPos0 = hInfo[houseID][exitPos][0]
        exitPos1 = hInfo[houseID][exitPos][1]
        exitPos2 = hInfo[houseID][exitPos][2]
        exitPos3 = hInfo[houseID][exitPos][3]
        EntryProperty(playerid, vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3);

        return 1;
    }

    if (businessID !== -1) {
        if(bInfo[businessID][bLocked])
            return SendErrorMessage(playerid, "Está empresa está trancada.");
        
        vwExit = bInfo[businessID][vwExit];
        interiorExit = bInfo[businessID][interiorExit];
        exitPos0 = bInfo[businessID][exitPos][0]
        exitPos1 = bInfo[businessID][exitPos][1]
        exitPos2 = bInfo[businessID][exitPos][2]
        exitPos3 = bInfo[businessID][exitPos][3]
        EntryProperty(playerid, vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3);

        return 1;
    }

    return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");

}

CMD:sair(playerid) {
    new vwEntry, interiorEntry, entryPos0, entryPos1, entryPos2, entryPos3;

    new houseID = GetNearestHouseExit(playerid), entryID = GetNearestHouseSecondExit(playerid);
    new businessID = GetNearestBusinessExit(playerid);
    
    if(houseID !== -1) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa está trancada.");
        
        vwEntry = hInfo[houseID][vwEntry];
        interiorEntry = hInfo[houseID][interiorEntry];
        entryPos0 = hInfo[houseID][entryPos][0]
        entryPos1 = hInfo[houseID][entryPos][1]
        entryPos2 = hInfo[houseID][entryPos][2]
        entryPos3 = hInfo[houseID][entryPos][3]
        EntryProperty(playerid, vwEntry, interiorEntry, entryPos0, entryPos1, entryPos2, entryPos3);

        return 1;
    }

    if (businessID !== -1) {
        if(bInfo[businessID][bLocked])
            return SendErrorMessage(playerid, "Está empresa está trancada.");
        
        vwEntry = bInfo[businessID][vwEntry];
        interiorEntry = bInfo[businessID][interiorEntry];
        entryPos0 = bInfo[businessID][entryPos][0]
        entryPos1 = bInfo[businessID][entryPos][1]
        entryPos2 = bInfo[businessID][entryPos][2]
        entryPos3 = bInfo[businessID][entryPos][3]
        EntryProperty(playerid, vwEntry, interiorEntry, entryPos0, entryPos1, entryPos2, entryPos3);

        return 1;
    }

    return SendErrorMessage(playerid, "Você não está próximo de nenhuma saída");

}

CMD:comprar(playerid) {
    new propertyType;
    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);

    if(!houseID && !businessID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");

    if(HouseHasOwner(houseID) || BusinessHasOwner(businessID))
        return SendErrorMessage(playerid, "Esta propriedade já possui um dono.");

    if(GetMoney(playerid) < hInfo[houseID][hPrice] || GetMoney(playerid) < bInfo[businessID][bPrice])
        return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar esta propriedade.");

    if(houseID !== -1) {
        propertyType = 1;

        GiveMoney(playerid, -hInfo[houseID][hPrice]);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(houseID));
        BuyProperty(playerid, houseID, propertyType);

        return 1;
    }

    if(businessID !== -1) {
        propertyType = 2;

        GiveMoney(playerid, -bInfo[businessID][bPrice]);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetBusinessAddress(businessID));
        BuyProperty(playerid, businessID, propertyType);

        return 1;
    }

    return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade");
}

CMD:trancarempresa(playerid, params[]) {
    new propertyType;
    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if(!houseID)
        houseID = GetNearestHouseExit(playerid);

    if(!businessID)
        businessID = GetNearestBusinessExit(playerid)

    if(!houseID && !businessID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");
    
    if(hInfo[houseID][hOwner] != pInfo[playerid][pID] || bInfo[businessID][bOwner] != pInfo[playerid][pID])
        return SendErrorMessage(playerid, "Essa propriedade não é sua.");

    if(houseID !== -1) {
        propertyType = 1;
        LockProperty(playerid, houseID, propertyType);

        return 1;
    }

    if(businessID !== -1) {
        propertyType = 2;
        LockProperty(playerid, businessID, propertyType);

        return 1;
    }

    return 1;
}