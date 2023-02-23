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
    new businessInsideID = IsBusinessInside(playerid);
    new garageID = GetNearestGarageEntry(playerid);


    if(!houseID && !businessID && !businessInsideID && !garageID)
        return SendErrorMessage(playerid, "Você não está próximo de nenhuma propriedade ou dentro de uma empresa.");

    if(houseID != -1) {
        if(HouseHasOwner(houseID))
            return SendErrorMessage(playerid, "Esta propriedade já possui um dono.");
        if(GetMoney(playerid) < hInfo[houseID][hPrice])
            return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar esta propriedade.");
        
        propertyType = 1;

        GiveMoney(playerid, -hInfo[houseID][hPrice]);
        BuyProperty(playerid, houseID, propertyType);

        return 1;
    }

    if(businessID != -1) {
        if(BusinessHasOwner(businessID))
            return SendErrorMessage(playerid, "Esta propriedade já possui um dono.");
        if(GetMoney(playerid) < bInfo[businessID][bPrice])
            return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar esta propriedade.") ;
        
        propertyType = 2;

        GiveMoney(playerid, -bInfo[businessID][bPrice]);
        BuyProperty(playerid, businessID, propertyType);

        return 1;
    }

    if(garageID != -1) {
        if(GarageHasOwner(garageID))
            return SendErrorMessage(playerid, "Esta propriedade já possui um dono.");
        if(GetMoney(playerid) < gInfo[garageID][gPrice])
            return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar esta propriedade.");

        new gHouseid;
        propertyType = 3;

        gHouseid = gInfo[garageID][gHouse];

        if(gHouseid > 0)
            return SendErrorMessage(playerid, "Você não pode comprar essa garagem, pois ela pertence á casa ao lado, compre ela e terÃ¡ a garagem.");

        GiveMoney(playerid, -gInfo[garageID][gPrice]);
        BuyProperty(playerid, garageID, propertyType);

        return 1;
    }

    if(businessInsideID != -1) {
        BuyInTheBusiness(playerid);
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

//Comando para criar um interir
CMD:criarinterior(playerid, params[]) {
    new 
        type,
        name[256];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "ds[256]", type, name)) {
        SendSyntaxMessage(playerid, "/criarinterior [tipo] [nome único]");
        SendSyntaxMessage(playerid, "[TIPOS] 1: Casa | 2: Empresa | 3: Outros");
        return 1;
    }
    
    if (type < 1 || type > 3)
        return SendErrorMessage(playerid, "Tipo inválido. Tipos de 1 à 3.");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `interiors` WHERE `name` = '%e';", name);
    mysql_query(DBConn, query);

    if(cache_num_rows())
        return SendErrorMessage(playerid, "Este nome já está registrado em outro interior!");

    if(!CreateInterior(playerid, type, name))
    {
        SendErrorMessage(playerid, "Ix001 - Encaminhe este código para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao criar o interior (cod: Ix001)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }

    return 1;
}

//Comanda para deletar um interior.
CMD:deletarinterior(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarinterior [id]");

    if(!IsValidInterior(id))
        return SendErrorMessage(playerid, "Esse ID de interior não existe.");

    if(!DeleteInterior(playerid, id))
    {
        SendErrorMessage(playerid, "ix010 - Encaminhe este código para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao excluir a empresa (cod: ix010)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }
    return 1;
}

//Comando para verificar propiedade prÃ³xima
CMD:near(playerid, params[]) {
    NearbyProperty(playerid);
    return 1;
}