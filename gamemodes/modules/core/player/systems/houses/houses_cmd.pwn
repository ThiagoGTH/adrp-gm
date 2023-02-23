#include <YSI_Coding\y_hooks>

CMD:criarcasa(playerid, params[]) {
<<<<<<< HEAD
    new price, address[256], Float:pos[4];
=======
    new price, address[256];
>>>>>>> development

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "ds[256]", price, address))
        return SendSyntaxMessage(playerid, "/criarcasa [preço] [endereço único]");
    
<<<<<<< HEAD
    if(price < 1000)
        return SendErrorMessage(playerid, "O preço da casa deve ser maior do que $1000.");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses` WHERE `address` = '%e';", address);
    mysql_query(DBConn, query);

    if(cache_num_rows())
        return SendErrorMessage(playerid, "Este endereço já está registrado em outra casa!");

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `houses` (`address`, `price`, `entry_x`, `entry_y`, `entry_z`, `entry_a`, `vw_entry`, `interior_entry`) \
        VALUES ('%s', %d, %f, %f, %f, %f, %d, %d);", address, price, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();

    mysql_format(DBConn, query, sizeof query, "UPDATE `houses` SET `vw_exit` = %d WHERE `id` = %d;", id + 10000, id);
    mysql_query(DBConn, query);

    LoadHouse(id);

    SendServerMessage(playerid, "Você criou a casa de ID %d no endereço: '%s'. ($%s)", id, address, FormatNumber(price));
    format(logString, sizeof(logString), "%s (%s) criou a casa de ID %d no endereço: '%s'. ($%s)", pNome(playerid), GetPlayerUserEx(playerid), id, address,  FormatNumber(price));
	logCreate(playerid, logString, 13);
=======
    CreateHouse(playerid, price, address);
>>>>>>> development

    return 1;
}

CMD:deletarcasa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarcasa [id]");

<<<<<<< HEAD
    if(!IsValidHouse(id))
        return SendErrorMessage(playerid, "Esse ID de casa não existe.");

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `houses` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);


    SendServerMessage(playerid, "Você deletou a casa de ID %d.", id);

    format(logString, sizeof(logString), "%s (%s) deletou a casa de ID %d. (%s)", pNome(playerid), GetPlayerUserEx(playerid), id, hInfo[id][hAddress]);
	logCreate(playerid, logString, 13);

    new dummyReset[E_HOUSE_DATA];
    hInfo[id] = dummyReset;
=======
    DeleteHouse(playerid, id);
>>>>>>> development

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
<<<<<<< HEAD
        new Float:pos[4];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);

        hInfo[id][hEntryPos][0] = pos[0];
        hInfo[id][hEntryPos][1] = pos[1];
        hInfo[id][hEntryPos][2] = pos[2];
        hInfo[id][hEntryPos][3] = pos[3];
        hInfo[id][vwEntry] = GetPlayerVirtualWorld(playerid);
        hInfo[id][interiorEntry] = GetPlayerInterior(playerid);
    
        SaveHouse(id);

        SendServerMessage(playerid, "Você editou a entrada da casa de ID %d.", id);

        format(logString, sizeof(logString), "%s (%s) editou a entrada da casa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
	    logCreate(playerid, logString, 13);
=======
        SetEntryHouse(playerid, id);
>>>>>>> development
        return 1;
    }

    // Editar o interior (lado de dentro)
    if(!strcmp(option, "interior", true)) {
<<<<<<< HEAD
        new Float:pos[4];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);

        hInfo[id][hExitPos][0] = pos[0];
        hInfo[id][hExitPos][1] = pos[1];
        hInfo[id][hExitPos][2] = pos[2];
        hInfo[id][hExitPos][3] = pos[3];
        hInfo[id][interiorExit] = GetPlayerInterior(playerid);
    
        SaveHouse(id);

        SendServerMessage(playerid, "Você editou o interior da casa de ID %d.", id);

        format(logString, sizeof(logString), "%s (%s) editou o interior da casa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
	    logCreate(playerid, logString, 13);
=======
        SetInteriorHouse(playerid, id);
>>>>>>> development
        return 1;
    }

    // Editar o preço
    if(!strcmp(option, "preco", true) || !strcmp(option, "preço", true)) {
        new houseValue = strval(value);
<<<<<<< HEAD
        
        if(!houseValue || houseValue < 0)
            return SendErrorMessage(playerid, "Você precisa especificar um valor que seja maior do que zero para ser o preço da casa.");

        hInfo[id][hPrice] = houseValue;
        SaveHouse(id);

        SendServerMessage(playerid, "Você editou o preço da casa de ID %d para $%s.", id, FormatNumber(houseValue));

        format(logString, sizeof(logString), "%s (%s) editou o preço da casa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(houseValue));
	    logCreate(playerid, logString, 13);
=======
        SetPriceHouse(playerid, id, houseValue);        
>>>>>>> development
        return 1;
    }

    //Editar o endereço
    if(!strcmp(option, "endereco", true) || !strcmp(option, "endereço", true)) {
<<<<<<< HEAD
        if(!strlen(value))
            return SendErrorMessage(playerid, "Você precisa especificar um endereço para setar.");

        format(hInfo[id][hAddress], 256, "%s", value);
        SaveHouse(id);

        SendServerMessage(playerid, "Você setou o endereço da casa de ID %d como '%s'.", id, value);

        format(logString, sizeof(logString), "%s (%s) setou o endereço da casa de ID %d como '%s'.", pNome(playerid), GetPlayerUserEx(playerid), id, value);
	    logCreate(playerid, logString, 13);
=======
        SetAddressHouse(playerid, id, value);
>>>>>>> development
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

<<<<<<< HEAD
    if(!hInfo[id][hID])
        return SendErrorMessage(playerid, "Esse ID de casa não existe.");

    SetPlayerVirtualWorld(playerid, hInfo[id][vwEntry]);
    SetPlayerInterior(playerid, hInfo[id][interiorEntry]);
    SetPlayerPos(playerid, hInfo[id][hEntryPos][0], hInfo[id][hEntryPos][1], hInfo[id][hEntryPos][2]);
    SetPlayerFacingAngle(playerid, hInfo[id][hEntryPos][3]);

    SendServerMessage(playerid, "Você teleportou até a casa de ID %d.", id);
=======
    TeleportHouse(playerid, id);
>>>>>>> development

    return 1;
}

CMD:criarcasaentrada(playerid, params[]) {
<<<<<<< HEAD
    new houseID, Float:pos[4];
=======
    new houseID;
>>>>>>> development

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "d", houseID))
        return SendSyntaxMessage(playerid, "/criarcasaentrada [id da casa]");

<<<<<<< HEAD
    if(!IsValidHouse(houseID))
        return SendErrorMessage(playerid, "Este ID de casa não existe.");

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `houses_other_entries` (`house_id`, `entry_x`, `entry_y`, `entry_z`, `entry_a`, `vw_entry`, `interior_entry`) \
        VALUES (%d, %f, %f, %f, %f, %d, %d);", houseID, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();

    mysql_format(DBConn, query, sizeof query, "UPDATE `houses_other_entries` SET `exit_x` = %f, `exit_y` = %f, `exit_z` = %f, `exit_a` = %f, `vw_exit` = %d, `interior_exit` = %d WHERE `id` = %d;",
        hInfo[houseID][hExitPos][0], hInfo[houseID][hExitPos][1], hInfo[houseID][hExitPos][2], hInfo[houseID][hExitPos][3], hInfo[houseID][vwExit], hInfo[houseID][interiorExit], id);
    mysql_query(DBConn, query);

    LoadEntry(id);

    SendServerMessage(playerid, "Você criou a entrada secundária de ID %d para a casa de ID %d.", id, houseID);

    format(logString, sizeof(logString), "%s (%s) criou a entrada secundária de ID %d para a casa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id, houseID);
	logCreate(playerid, logString, 14);
=======
    CreateHouseSecondEntry(playerid, houseID);
>>>>>>> development

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
<<<<<<< HEAD
        new Float:pos[4];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);

        sInfo[id][sEntryPos][0] = pos[0];
        sInfo[id][sEntryPos][1] = pos[1];
        sInfo[id][sEntryPos][2] = pos[2];
        sInfo[id][sEntryPos][3] = pos[3];
        sInfo[id][sEntryVW] = GetPlayerVirtualWorld(playerid);
        sInfo[id][sEntryVW] = GetPlayerInterior(playerid);
    
        SaveEntry(id);

        SendServerMessage(playerid, "Você editou a entrada secundária de ID %d da casa de ID %d.", id, sInfo[id][sHouseID]);

        format(logString, sizeof(logString), "%s (%s) editou a entrada secundária de ID %d da casa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id, sInfo[id][sHouseID]);
	    logCreate(playerid, logString, 14);
=======
        SetSecondEntry(playerid, id);
>>>>>>> development
        return 1;
    }

    // Editar o interior (lado de dentro)
    if(!strcmp(option, "interior", true)) {
<<<<<<< HEAD
        new Float:pos[4];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);

        sInfo[id][sExitPos][0] = pos[0];
        sInfo[id][sExitPos][1] = pos[1];
        sInfo[id][sExitPos][2] = pos[2];
        sInfo[id][sExitPos][3] = pos[3];
        sInfo[id][sExitInterior] = GetPlayerInterior(playerid);
    
        SaveEntry(id);

        SendServerMessage(playerid, "Você editou o interior da entrada secundária de ID %d (casa de ID %d).", id, sInfo[id][sHouseID]);

        format(logString, sizeof(logString), "%s (%s) editou o interior da entrada secundária de ID %d (casa de ID %d).", pNome(playerid), GetPlayerUserEx(playerid), id, sInfo[id][sHouseID]);
	    logCreate(playerid, logString, 14);
=======
        SetInteriorSecondEntry(playerid, id);
>>>>>>> development
        return 1;
    }

    // Edita a casa que é dona da entrada
    if(!strcmp(option, "casa", true)) {
        new houseID = strval(value);
        
        if(!houseID)
            return SendSyntaxMessage(playerid, "/editarentrada [id da entrada] [casa] [novo id da casa]");

<<<<<<< HEAD
        if(!IsValidHouse(houseID))
            return SendErrorMessage(playerid, "Este ID de casa não existe.");

        sInfo[id][sHouseID] = houseID;
        sInfo[id][sExitVW] = hInfo[houseID][vwExit];
        SaveEntry(id);

        SendServerMessage(playerid, "Você vinculou a entrada de ID %d à casa de ID %d.", id, houseID);

        format(logString, sizeof(logString), "%s (%s) vinculou a entrada de ID %d à casa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id, houseID);
	    logCreate(playerid, logString, 14);
=======
        SetEntryNewHouse(playerid, id, houseID);
>>>>>>> development
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
<<<<<<< HEAD

=======
>>>>>>> development
    return 1;
}

CMD:ircasaentrada(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/ircasaentrada [id]");

<<<<<<< HEAD
    if(!IsValidEntry(id))
        return SendErrorMessage(playerid, "Esse ID de entrada não existe.");

    SetPlayerVirtualWorld(playerid, sInfo[id][sEntryVW]);
    SetPlayerInterior(playerid, sInfo[id][sEntryInterior]);
    SetPlayerPos(playerid, sInfo[id][sEntryPos][0], sInfo[id][sEntryPos][1], sInfo[id][sEntryPos][2]);
    SetPlayerFacingAngle(playerid, sInfo[id][sEntryPos][3]);

    SendServerMessage(playerid, "Você teleportou até a entrada de ID %d.", id);
=======
    TeleportSecondEntry(playerid, id);
>>>>>>> development

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

CMD:comprar(playerid) {
    new houseID = GetNearestHouseEntry(playerid);

    if(!houseID)
        return SendErrorMessage(playerid, "Você não está próximmo à nenhuma casa.");

    if(HouseHasOwner(houseID))
        return SendErrorMessage(playerid, "Esta casa já possui um dono.");

    if(GetMoney(playerid) < hInfo[houseID][hPrice])
        return SendErrorMessage(playerid, "Você não possui fundos o suficiente para comprar esta casa.");

    GiveMoney(playerid, -hInfo[houseID][hPrice]);
    va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(houseID));
    BuyHouse(houseID, playerid);

    return 1;
}

CMD:alugavel(playerid) {
    new houseID = GetNearestHouseEntry(playerid);

    if(!houseID)
        return SendErrorMessage(playerid, "Você não está próximo à nenhuma casa.");
    
<<<<<<< HEAD
    if(hInfo[houseID][hOwner] != pInfo[playerid][pID])
        return SendErrorMessage(playerid, "Essa casa não é sua.");
    
    switch(hInfo[houseID][hRentable]) {
        case 0: {
            RentableHouse(houseID, playerid, 1);
            va_SendClientMessage(playerid, COLOR_YELLOW, "Sua casa agora está alugável.");
        }
        default: {
            RentableHouse(houseID, playerid, 0);
            va_SendClientMessage(playerid, COLOR_YELLOW, "Sua casa não está mais alugável.");
        }
    }

=======
    SetRentableHouse(playerid, houseID);
>>>>>>> development
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

<<<<<<< HEAD
=======
<<<<<<< HEAD:gamemodes/modules/core/player/systems/properties/houses/houses_cmd.pwn
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
=======
>>>>>>> development
CMD:entrar(playerid) {
    new houseID = GetNearestHouseEntry(playerid), entryID = GetNearestHouseSecondEntry(playerid);
    
    if(houseID) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa está trancada.");

        SetPlayerVirtualWorld(playerid, hInfo[houseID][vwExit]);
        SetPlayerInterior(playerid, hInfo[houseID][interiorExit]);
        SetPlayerPos(playerid, hInfo[houseID][hExitPos][0], hInfo[houseID][hExitPos][1], hInfo[houseID][hExitPos][2]);
        SetPlayerFacingAngle(playerid, hInfo[houseID][hExitPos][3]);
        
        return 1;
    }

    if(entryID) {
        if(sInfo[entryID][sLocked])
            return SendErrorMessage(playerid, "Esta entrada da casa está trancada.");

        SetPlayerVirtualWorld(playerid, sInfo[entryID][sExitVW]);
        SetPlayerInterior(playerid, sInfo[entryID][sExitInterior]);
        SetPlayerPos(playerid, sInfo[entryID][sExitPos][0], sInfo[entryID][sExitPos][1], sInfo[entryID][sExitPos][2]);
        SetPlayerFacingAngle(playerid, sInfo[entryID][sExitPos][3]);

        return 1;
    } 

    return 1;
}

CMD:sair(playerid) {
    new houseID = GetNearestHouseExit(playerid), entryID = GetNearestHouseSecondExit(playerid);
    
    if(houseID) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa está trancada.");

        SetPlayerVirtualWorld(playerid, hInfo[houseID][vwEntry]);
        SetPlayerInterior(playerid, hInfo[houseID][interiorEntry]);
        SetPlayerPos(playerid, hInfo[houseID][hEntryPos][0], hInfo[houseID][hEntryPos][1], hInfo[houseID][hEntryPos][2]);
        SetPlayerFacingAngle(playerid, hInfo[houseID][hEntryPos][3]);

        return 1;
    }

    if(entryID) {
        if(sInfo[entryID][sLocked])
            return SendErrorMessage(playerid, "Esta entrada está trancada.");

        SetPlayerVirtualWorld(playerid, sInfo[entryID][sEntryVW]);
        SetPlayerInterior(playerid, sInfo[entryID][sEntryInterior]);
        SetPlayerPos(playerid, sInfo[entryID][sEntryPos][0], sInfo[entryID][sEntryPos][1], sInfo[entryID][sEntryPos][2]);
        SetPlayerFacingAngle(playerid, sInfo[entryID][sEntryPos][3]);

        return 1;
    }

<<<<<<< HEAD
=======
>>>>>>> main:gamemodes/modules/core/player/systems/houses/houses_cmd.pwn
>>>>>>> development
    return 1;
}