CMD:entrar(playerid) {
    new bool:isGarage, vw, interior, Float:exitPos0, Float:exitPos1, Float:exitPos2, Float:exitPos3;

    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);
    new garageID = GetNearestGarageEntry(playerid);

    if(!houseID && !businessID && !garageID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");
    
    if(houseID > 0) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Essa casa está trancada.");
        
        vw = hInfo[houseID][vwExit];
        interior = hInfo[houseID][interiorExit];
        exitPos0 = hInfo[houseID][hExitPos][0];
        exitPos1 = hInfo[houseID][hExitPos][1];
        exitPos2 = hInfo[houseID][hExitPos][2];
        exitPos3 = hInfo[houseID][hExitPos][3];

        isGarage = false;

        EnterProperty(playerid, vw, interior, exitPos0, exitPos1, exitPos2, exitPos3, isGarage);

        return 1;
    }

    if (businessID > 0) {
        if(bInfo[businessID][bLocked])
            return SendErrorMessage(playerid, "Essa empresa está trancada.");
        
        vw = bInfo[businessID][vwExit];
        interior = bInfo[businessID][interiorExit];
        exitPos0 = bInfo[businessID][bExitPos][0];
        exitPos1 = bInfo[businessID][bExitPos][1];
        exitPos2 = bInfo[businessID][bExitPos][2];
        exitPos3 = bInfo[businessID][bExitPos][3];

        isGarage = false;

        EnterProperty(playerid, vw, interior, exitPos0, exitPos1, exitPos2, exitPos3, isGarage);

        return 1;
    }

    if (garageID > 0) {
        if(gInfo[garageID][gLocked])
            return SendErrorMessage(playerid, "Essa garagem está trancada.");

        isGarage = true;

        EnterProperty(playerid, gInfo[garageID][gVwExit], gInfo[garageID][gInteriorExit], gInfo[garageID][gExitPos][0], gInfo[garageID][gExitPos][1], gInfo[garageID][gExitPos][2], gInfo[garageID][gExitPos][3], isGarage);
    }

    return 1;

}

CMD:sair(playerid) {
    new bool:isGarage, vw, interior, Float:entryPos0, Float:entryPos1, Float:entryPos2, Float:entryPos3;

    new houseID = GetNearestHouseExit(playerid);
    new businessID = GetNearestBusinessExit(playerid);
    new garageID = GetNearestGarageExit(playerid);

    if(!houseID && !businessID && !garageID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");
    
    if(houseID > 0) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Essa casa está trancada.");
        
        vw = hInfo[houseID][vwEntry];
        interior = hInfo[houseID][interiorEntry];
        entryPos0 = hInfo[houseID][hEntryPos][0];
        entryPos1 = hInfo[houseID][hEntryPos][1];
        entryPos2 = hInfo[houseID][hEntryPos][2];
        entryPos3 = hInfo[houseID][hEntryPos][3];
        
        isGarage = false;

        ExitProperty(playerid, vw, interior, entryPos0, entryPos1, entryPos2, entryPos3, isGarage);

        return 1;
    }

    if (businessID > 0) {
        if(bInfo[businessID][bLocked])
            return SendErrorMessage(playerid, "Essa empresa está trancada.");
        
        vw = bInfo[businessID][vwEntry];
        interior = bInfo[businessID][interiorEntry];
        entryPos0 = bInfo[businessID][bEntryPos][0];
        entryPos1 = bInfo[businessID][bEntryPos][1];
        entryPos2 = bInfo[businessID][bEntryPos][2];
        entryPos3 = bInfo[businessID][bEntryPos][3];
        
        isGarage = false;

        ExitProperty(playerid, vw, interior, entryPos0, entryPos1, entryPos2, entryPos3, isGarage);

        return 1;
    }

    if (garageID > 0) {
        if(gInfo[garageID][gLocked])
            return SendErrorMessage(playerid, "Essa garage está trancada.");

        isGarage = true;

        ExitProperty(playerid, gInfo[garageID][gVwEntry], gInfo[garageID][gInteriorEntry], gInfo[garageID][gEntryPos][0], gInfo[garageID][gEntryPos][1], gInfo[garageID][gEntryPos][2], gInfo[garageID][gEntryPos][3], isGarage);

        return 1;
    }

    return 1;

}

CMD:comprar(playerid) {
    new propertyType;

    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);
    new garageID = GetNearestGarageEntry(playerid);

    if(!houseID && !businessID && !garageID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");

    if(HouseHasOwner(houseID) || BusinessHasOwner(businessID) || GarageHasOwner(garageID))
        return SendErrorMessage(playerid, "Esta propriedade já possui um dono.");

    if(GetMoney(playerid) < hInfo[houseID][hPrice] || GetMoney(playerid) < bInfo[businessID][bPrice] || GetMoney(playerid) < gInfo[garageID][gPrice])
        return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar esta propriedade.");

    if(houseID != -1) {
        propertyType = 1;

        GiveMoney(playerid, -hInfo[houseID][hPrice]);
        BuyProperty(playerid, houseID, propertyType);

        return 1;
    }

    if(businessID != -1) {
        propertyType = 2;

        GiveMoney(playerid, -bInfo[businessID][bPrice]);
        BuyProperty(playerid, businessID, propertyType);

        return 1;
    }

    if(garageID != -1) {
        new gHouseid;
        propertyType = 3;

        gHouseid = gInfo[garageID][gHouse];

        if(gHouseid > 0)
            return SendErrorMessage(playerid, "Você não pode comprar essa garagem, pois ela pertence à casa ao lado, compre ela e terá a garagem.");

        GiveMoney(playerid, -gInfo[garageID][gPrice]);
        BuyProperty(playerid, garageID, propertyType);

        return 1;
    }

    return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade");
}

CMD:avender(playerid) {
    new propertyType;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);
    new garageID = GetNearestGarageEntry(playerid);

    if(!houseID && !businessID && !garageID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade.");

    if(houseID != -1) {
        propertyType = 1;

        AdminSellProperty(playerid, houseID, propertyType);

        return 1;
    }

    if(businessID != -1) {
        propertyType = 2;

        AdminSellProperty(playerid, businessID, propertyType);

        return 1;
    }

    if(garageID != -1) {
        propertyType = 3;

        AdminSellProperty(playerid, garageID, propertyType);

        return 1;
    }

    return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade");
}

CMD:trancar(playerid, params[]) {
    new propertyType;
    new houseID = GetNearestHouseEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);
    new garageID = GetNearestGarageEntry(playerid);

    if(!houseID)
        houseID = GetNearestHouseExit(playerid);

    if(!businessID)
        businessID = GetNearestBusinessExit(playerid);

    if(!garageID)
        garageID = GetNearestGarageExit(playerid);

    if(!houseID && !businessID && !garageID)
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

    if(garageID != -1) {
        if(gInfo[garageID][gOwner] != pInfo[playerid][pID])
            return SendErrorMessage(playerid, "Essa propriedade não é sua.");
        
        propertyType = 3;
        LockProperty(playerid, garageID, propertyType);

        return 1;
    }

    return 1;
}