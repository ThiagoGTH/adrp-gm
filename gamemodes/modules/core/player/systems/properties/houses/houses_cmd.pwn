#include <YSI_Coding\y_hooks>

CMD:criarcasa(playerid, params[]) {
    new price, address[256];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "ds[256]", price, address))
        return SendSyntaxMessage(playerid, "/criarcasa [preço] [endereço único]");
    
    CreateHouse(playerid, price, address);

    return 1;
}

CMD:deletarcasa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarcasa [id]");

    DeleteHouse(playerid, id);

    return 1;
}

CMD:editarcasa(playerid, params[]) {
    new id, option[64], value[64];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "ds[64]S()[64]", id, option, value)) {
        SendSyntaxMessage(playerid, "/editarcasa [id] [opção]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: entrada, interior, preco, endereco");
    }

    if(!IsValidHouse(id))
        return SendErrorMessage(playerid, "Esse ID de casa não existe.");

    // Editar a entrada (localização)
    if(!strcmp(option, "entrada", true)) {
        SetEntryHouse(playerid, id);
        return 1;
    }

    // Editar o interior (lado de dentro)
    if(!strcmp(option, "interior", true)) {
        SetInteriorHouse(playerid, id);
        return 1;
    }

    // Editar o preço
    if(!strcmp(option, "preco", true) || !strcmp(option, "preço", true)) {
        new houseValue = strval(value);
        SetPriceHouse(playerid, id, houseValue);        
        return 1;
    }

    //Editar o endereço
    if(!strcmp(option, "endereco", true) || !strcmp(option, "endereço", true)) {
        SetAddressHouse(playerid, id, value);
        return 1;
    }

    SendSyntaxMessage(playerid, "/editarcasa [id] [opção]");
    return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: entrada, interior, preco, endereco");
}

CMD:ircasa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2)
        return SendPermissionMessage(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/ircasa [id]");

    TeleportHouse(playerid, id);

    return 1;
}

CMD:criarcasaentrada(playerid, params[]) {
    new houseID;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "d", houseID))
        return SendSyntaxMessage(playerid, "/criarcasaentrada [id da casa]");

    CreateHouseSecondEntry(playerid, houseID);

    return 1;
}

CMD:editarcasaentrada(playerid, params[]) {
    new id, option[64], value[64];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "ds[64]S()[64]", id, option, value)) {
        SendSyntaxMessage(playerid, "/editarcasaentrada [id] [opção]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: entrada, interior, casa");
    }

    if(!IsValidEntry(id))
        return SendErrorMessage(playerid, "Esse ID de entrada não existe.");

    // Editar a entrada (localização)
    if(!strcmp(option, "entrada", true)) {
        SetSecondEntry(playerid, id);
        return 1;
    }

    // Editar o interior (lado de dentro)
    if(!strcmp(option, "interior", true)) {
        SetInteriorSecondEntry(playerid, id);
        return 1;
    }

    // Edita a casa que é dona da entrada
    if(!strcmp(option, "casa", true)) {
        new houseID = strval(value);
        
        if(!houseID)
            return SendSyntaxMessage(playerid, "/editarentrada [id da entrada] [casa] [novo id da casa]");

        SetEntryNewHouse(playerid, id, houseID);
        return 1;
    }

    SendSyntaxMessage(playerid, "/editarentrada [id] [opção]");
    return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: entrada, interior, casa");
}

CMD:deletarcasaentrada(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarcasaentrada [id]");

    if(!IsValidEntry(id))
        return SendErrorMessage(playerid, "Esse ID de entrada não existe.");

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `houses_other_entries` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    SendServerMessage(playerid, "Você deletou a entrada de ID %d, pertecente à casa de ID %d.", id, sInfo[id][sHouseID]);

    format(logString, sizeof(logString), "%s (%s) deletou a entrada de ID %d. (Casa %d)", pNome(playerid), GetPlayerUserEx(playerid), id, sInfo[id][sHouseID]);
	logCreate(playerid, logString, 14);

    new dummyReset[E_SECOND_ENTRIES_DATA];
    sInfo[id] = dummyReset;
    return 1;
}

CMD:ircasaentrada(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/ircasaentrada [id]");

    TeleportSecondEntry(playerid, id);

    return 1;
}

CMD:listacasaentradas(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/listacasaentradas [id da casa]");

    if(!IsValidHouse(id))
        return SendErrorMessage(playerid, "Este ID de casa não existe.");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses_other_entries` WHERE `house_id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return SendErrorMessage(playerid, "Esta casa ainda não possui nenhuma entrada vinculada a ela.");

    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");

    for(new i; i < MAX_SECOND_ENTRIES; i++) {
        if(sInfo[i][sHouseID] != id)
            continue;

        va_SendClientMessage(playerid, COLOR_BEGE, "A Entrada (ID %d) está vinculada à casa de ID %d.", i, id);
    }

    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");

    return 1;
}

CMD:atrancar(playerid, params[]) {
    new houseID = GetNearestHouseEntry(playerid), entryID = GetNearestHouseSecondEntry(playerid);
    
    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if(!houseID) {
        houseID = GetNearestHouseExit(playerid);
    }

    if(houseID) {
        hInfo[houseID][hLocked] = !hInfo[houseID][hLocked];
        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, hInfo[houseID][hLocked] ? "~r~CASA TRANCADA" : "~g~~h~CASA DESTRANCADA", 2500, 4);
    
        return 1;
    }

    if(!entryID) {
        entryID = GetNearestHouseSecondExit(playerid);
    }

    if(entryID) {
        sInfo[entryID][sLocked] = !sInfo[entryID][sLocked];
        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
    
        GameTextForPlayer(playerid, sInfo[entryID][sLocked] ? "~r~ENTRADA TRANCADA" : "~g~~h~ENTRADA DESTRANCADA", 2500, 4);
        return 1;
    }

    return 1;
}

CMD:alugavel(playerid) {
    new houseID = GetNearestHouseEntry(playerid);

    if(!houseID)
        return SendErrorMessage(playerid, "Você não está próximo à nenhuma casa.");
    
    SetRentableHouse(playerid, houseID);
    return 1;
}

CMD:precoaluguel(playerid, params[]) {
    new price;
    new houseID = GetNearestHouseEntry(playerid);

    if(!houseID)
        return SendErrorMessage(playerid, "Você não está próximo à nenhuma casa.");
    
    if(hInfo[houseID][hOwner] != pInfo[playerid][pID])
        return SendErrorMessage(playerid, "Essa casa não é sua.");

    if(sscanf(params, "i", price))
        return SendSyntaxMessage(playerid, "/precoaluguel [preço]");
    
    if(!hInfo[houseID][hRentable])
        return SendErrorMessage(playerid, "Sua casa não está alugável. (/alugavel)");
    
    if(price < 1 || price > 500)
        return SendErrorMessage(playerid, "O preço do aluguel não pode ser menor que $1 ou maior que $500.");
    
    SetRentPrice(houseID, playerid, price);
    va_SendClientMessage(playerid, COLOR_YELLOW, "Você alterou o preço do aluguel da sua casa para $%s", FormatNumber(price));

    return 1;
}

//Comando de campainha
CMD:campainha(playerid, params[]) {
    new 
        houseID = GetNearestHouseEntry(playerid);

	if(!houseID)
        return SendErrorMessage(playerid, "Você não está próximo à nenhuma casa.");
    
    foreach (new i : Player) if (IsHouseInside(i) == houseID) {
            SendClientMessage(i, COLOR_PURPLE, "** Você pode ouvir a campainha tocar.");
            PlayerPlaySound(i, 20801, 0, 0, 0);
    }
	PlayerPlaySound(playerid, 20801, 0, 0, 0);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s toca a campainha da casa.", pNome(playerid));
    return 1;
}