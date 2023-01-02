CMD:entrar(playerid) {
    new vw, interior, Float:exitPos0, Float:exitPos1, Float:exitPos2, Float:exitPos3;

    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);
    
    if(houseID != -1) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa está trancada.");
        
        vw = hInfo[houseID][vwExit];
        interior = hInfo[houseID][interiorExit];
        exitPos0 = hInfo[houseID][hExitPos][0];
        exitPos1 = hInfo[houseID][hExitPos][1];
        exitPos2 = hInfo[houseID][hExitPos][2];
        exitPos3 = hInfo[houseID][hExitPos][3];
        EntryProperty(playerid, vw, interior, exitPos0, exitPos1, exitPos2, exitPos3);

        return 1;
    }

    if (businessID != -1) {
        if(bInfo[businessID][bLocked])
            return SendErrorMessage(playerid, "Está empresa está trancada.");
        
        vw = bInfo[businessID][vwExit];
        interior = bInfo[businessID][interiorExit];
        exitPos0 = bInfo[businessID][bExitPos][0];
        exitPos1 = bInfo[businessID][bExitPos][1];
        exitPos2 = bInfo[businessID][bExitPos][2];
        exitPos3 = bInfo[businessID][bExitPos][3];
        EntryProperty(playerid, vw, interior, exitPos0, exitPos1, exitPos2, exitPos3);

        return 1;
    }

    return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");

}

CMD:sair(playerid) {
    new vw, interior, Float:entryPos0, Float:entryPos1, Float:entryPos2, Float:entryPos3;

    new houseID = GetNearestHouseExit(playerid);
    new businessID = GetNearestBusinessExit(playerid);
    
    if(houseID != -1) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa está trancada.");
        
        vw = hInfo[houseID][vwEntry];
        interior = hInfo[houseID][interiorEntry];
        entryPos0 = hInfo[houseID][hEntryPos][0];
        entryPos1 = hInfo[houseID][hEntryPos][1];
        entryPos2 = hInfo[houseID][hEntryPos][2];
        entryPos3 = hInfo[houseID][hEntryPos][3];
        ExitProperty(playerid, vw, interior, entryPos0, entryPos1, entryPos2, entryPos3);

        return 1;
    }

    if (businessID != -1) {
        if(bInfo[businessID][bLocked])
            return SendErrorMessage(playerid, "Está empresa está trancada.");
        
        vw = bInfo[businessID][vwEntry];
        interior = bInfo[businessID][interiorEntry];
        entryPos0 = bInfo[businessID][bEntryPos][0];
        entryPos1 = bInfo[businessID][bEntryPos][1];
        entryPos2 = bInfo[businessID][bEntryPos][2];
        entryPos3 = bInfo[businessID][bEntryPos][3];
        ExitProperty(playerid, vw, interior, entryPos0, entryPos1, entryPos2, entryPos3);

        return 1;
    }

    return SendErrorMessage(playerid, "Você não está próximo de nenhuma saída");

}

CMD:comprar(playerid) {
    new propertyType;
    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);
    new businessInsideID = IsBusinessInside(playerid);

    if(!houseID && !businessID && !businessInsideID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade ou dentro de uma empresa.");

    if(businessID)
        return BuyInTheBusiness(playerid);

    if(HouseHasOwner(houseID) || BusinessHasOwner(businessID))
        return SendErrorMessage(playerid, "Esta propriedade já possui um dono.");

    if(GetMoney(playerid) < hInfo[houseID][hPrice] || GetMoney(playerid) < bInfo[businessID][bPrice])
        return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar esta propriedade.");

    if(houseID != -1) {
        propertyType = 1;

        GiveMoney(playerid, -hInfo[houseID][hPrice]);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(houseID));
        BuyProperty(playerid, houseID, propertyType);

        return 1;
    }

    if(businessID != -1) {
        propertyType = 2;

        GiveMoney(playerid, -bInfo[businessID][bPrice]);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetBusinessAddress(businessID));
        BuyProperty(playerid, businessID, propertyType);

        return 1;
    }

    return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade");
}

CMD:trancar(playerid, params[]) {
    new propertyType;
    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if(!houseID)
        houseID = GetNearestHouseExit(playerid);

    if(!businessID)
        businessID = GetNearestBusinessExit(playerid);

    if(!houseID && !businessID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");
    


    if(houseID != -1) {
        if(hInfo[houseID][hOwner] != pInfo[playerid][pID])
            return SendErrorMessage(playerid, "Essa propriedade não é sua.");
        
        propertyType = 1;
        LockProperty(playerid, houseID, propertyType);

        return 1;
    }

    if(businessID != -1) {
        if(bInfo[businessID][bOwner] != pInfo[playerid][pID])
            return SendErrorMessage(playerid, "Essa propriedade não é sua.");
        
        propertyType = 2;
        LockProperty(playerid, businessID, propertyType);

        return 1;
    }

    return 1;
}