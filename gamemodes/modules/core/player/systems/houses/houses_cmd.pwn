#include <YSI_Coding\y_hooks>

CMD:criarcasa(playerid, params[]) {
    new price, address[256], Float:pos[4];

    if(GetPlayerAdmin(playerid) < 4) 
        return SendPermissionMessage(playerid);

	if (sscanf(params, "ds[256]", price, address))
        return SendSyntaxMessage(playerid, "/criarcasa [preço] [endereço único]");
    
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

    SendServerMessage(playerid, "Você criou a casa de ID %d no endereço: '%s'. ($%s)", id, address, FormatNumber(price));

    format(logString, sizeof(logString), "%s (%s) criou a casa de ID %d no endereço: '%s'. ($%s)", pNome(playerid), GetPlayerUserEx(playerid), id, address,  FormatNumber(price));
	logCreate(playerid, logString, 13);

    return 1;
}

CMD:deletarcasa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 4) 
        return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarcasa [id]");

    if(!IsValidHouse(id))
        return SendErrorMessage(playerid, "Esse ID de casa não existe.");

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `houses` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);


    SendServerMessage(playerid, "Você deletou a casa de ID %d.", id);

    format(logString, sizeof(logString), "%s (%s) deletou a casa de ID %d. (%s)", pNome(playerid), GetPlayerUserEx(playerid), id, hInfo[id][hAddress]);
	logCreate(playerid, logString, 13);

    new dummyReset[E_HOUSE_DATA];
    hInfo[id] = dummyReset;

    return 1;
}

CMD:editarcasa(playerid, params[]) {
    new id, option[64], value[64];

    if(GetPlayerAdmin(playerid) < 4) 
        return SendPermissionMessage(playerid);

	if(sscanf(params, "ds[64]S()[64]", id, option, value)) {
        SendSyntaxMessage(playerid, "/editarcasa [id] [opção]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: entrada, interior, preco, endereco");
    }

    if(!IsValidHouse(id))
        return SendErrorMessage(playerid, "Esse ID de casa não existe.");

    // Editar a entrada (localização)
    if(!strcmp(option, "entrada", true)) {
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
        return 1;
    }

    // Editar o interior (lado de dentro)
    if(!strcmp(option, "interior", true)) {
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
        return 1;
    }

    // Editar o preço
    if(!strcmp(option, "preco", true) || !strcmp(option, "preço", true)) {
        new houseValue = strval(value);
        
        if(!houseValue || houseValue < 0)
            return SendErrorMessage(playerid, "Você precisa especificar um valor que seja maior do que zero para ser o preço da casa.");

        hInfo[id][hPrice] = houseValue;
        SaveHouse(id);

        SendServerMessage(playerid, "Você editou o preço da casa de ID %d para $%s.", id, FormatNumber(houseValue));

        format(logString, sizeof(logString), "%s (%s) editou o preço da casa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(houseValue));
	    logCreate(playerid, logString, 13);
        return 1;
    }

    //Editar o endereço
    if(!strcmp(option, "endereco", true) || !strcmp(option, "endereço", true)) {
        if(!strlen(value))
            return SendErrorMessage(playerid, "Você precisa especificar um endereço para setar.");

        format(hInfo[id][hAddress], 256, "%s", value);
        SaveHouse(id);

        SendServerMessage(playerid, "Você setou o endereço da casa de ID %d como '%s'.", id, value);

        format(logString, sizeof(logString), "%s (%s) setou o endereço da casa de ID %d como '%s'.", pNome(playerid), GetPlayerUserEx(playerid), id, value);
	    logCreate(playerid, logString, 13);
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

    if(!hInfo[id][hID])
        return SendErrorMessage(playerid, "Esse ID de casa não existe.");

    SetPlayerVirtualWorld(playerid, hInfo[id][vwEntry]);
    SetPlayerInterior(playerid, hInfo[id][interiorEntry]);
    SetPlayerPos(playerid, hInfo[id][hEntryPos][0], hInfo[id][hEntryPos][1], hInfo[id][hEntryPos][2]);
    SetPlayerFacingAngle(playerid, hInfo[id][hEntryPos][3]);

    SendServerMessage(playerid, "Você teleportou até a casa de ID %d.", id);

    return 1;
}

CMD:atrancar(playerid, params[]) {
    new houseID = GetNearestHouseEntry(playerid);
    
    if(GetPlayerAdmin(playerid) < 2)
        return SendPermissionMessage(playerid);

    if(!houseID) {
        houseID = GetNearestHouseExit(playerid);

        if(!houseID)
            return 1;
    }

    hInfo[houseID][hLocked] = !hInfo[houseID][hLocked];
    PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

    return 1;
}

CMD:entrar(playerid) {
    new houseID = GetNearestHouseEntry(playerid);
    
    if(!houseID)
        return 1;

    if(hInfo[houseID][hLocked])
        return SendErrorMessage(playerid, "Esta casa está trancada.");

    SetPlayerVirtualWorld(playerid, hInfo[houseID][vwExit]);
    SetPlayerInterior(playerid, hInfo[houseID][interiorExit]);
    SetPlayerPos(playerid, hInfo[houseID][hExitPos][0], hInfo[houseID][hExitPos][1], hInfo[houseID][hExitPos][2]);
    SetPlayerFacingAngle(playerid, hInfo[houseID][hExitPos][3]);

    return 1;
}

CMD:sair(playerid) {
    new houseID = GetNearestHouseExit(playerid);
    
    if(!houseID)
        return 1;

    if(hInfo[houseID][hLocked])
        return SendErrorMessage(playerid, "Esta casa está trancada.");

    SetPlayerVirtualWorld(playerid, hInfo[houseID][vwEntry]);
    SetPlayerInterior(playerid, hInfo[houseID][interiorEntry]);
    SetPlayerPos(playerid, hInfo[houseID][hEntryPos][0], hInfo[houseID][hEntryPos][1], hInfo[houseID][hEntryPos][2]);
    SetPlayerFacingAngle(playerid, hInfo[houseID][hEntryPos][3]);

    return 1;
}