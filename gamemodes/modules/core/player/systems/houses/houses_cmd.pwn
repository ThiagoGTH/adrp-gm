#include <YSI_Coding\y_hooks>

CMD:criarcasa(playerid, params[]) {
    new price, address[256];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "ds[256]", price, address))
        return SendSyntaxMessage(playerid, "/criarcasa [pre�o] [endere�o �nico]");
    
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
        SendSyntaxMessage(playerid, "/editarcasa [id] [op��o]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: entrada, interior, preco, endereco");
    }

    if(!IsValidHouse(id))
        return SendErrorMessage(playerid, "Esse ID de casa n�o existe.");

    // Editar a entrada (localiza��o)
    if(!strcmp(option, "entrada", true)) {
        SetEntryHouse(playerid, id);
        return 1;
    }

    // Editar o interior (lado de dentro)
    if(!strcmp(option, "interior", true)) {
        SetInteriorHouse(playerid, id);
        return 1;
    }

    // Editar o pre�o
    if(!strcmp(option, "preco", true) || !strcmp(option, "pre�o", true)) {
        new houseValue = strval(value);
        SetPriceHouse(playerid, id, houseValue);        
        return 1;
    }

    //Editar o endere�o
    if(!strcmp(option, "endereco", true) || !strcmp(option, "endere�o", true)) {
        SetAddressHouse(playerid, id, value);
        return 1;
    }

    SendSyntaxMessage(playerid, "/editarcasa [id] [op��o]");
    return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: entrada, interior, preco, endereco");
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
        SendSyntaxMessage(playerid, "/editarcasaentrada [id] [op��o]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: entrada, interior, casa");
    }

    if(!IsValidEntry(id))
        return SendErrorMessage(playerid, "Esse ID de entrada n�o existe.");

    // Editar a entrada (localiza��o)
    if(!strcmp(option, "entrada", true)) {
        SetSecondEntry(playerid, id);
        return 1;
    }

    // Editar o interior (lado de dentro)
    if(!strcmp(option, "interior", true)) {
        SetInteriorSecondEntry(playerid, id);
        return 1;
    }

    // Edita a casa que � dona da entrada
    if(!strcmp(option, "casa", true)) {
        new houseID = strval(value);
        
        if(!houseID)
            return SendSyntaxMessage(playerid, "/editarentrada [id da entrada] [casa] [novo id da casa]");

        SetEntryNewHouse(playerid, id, houseID);
        return 1;
    }

    SendSyntaxMessage(playerid, "/editarentrada [id] [op��o]");
    return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: entrada, interior, casa");
}

CMD:deletarcasaentrada(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarcasaentrada [id]");

    if(!IsValidEntry(id))
        return SendErrorMessage(playerid, "Esse ID de entrada n�o existe.");

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `houses_other_entries` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    SendServerMessage(playerid, "Voc� deletou a entrada de ID %d, pertecente � casa de ID %d.", id, sInfo[id][sHouseID]);

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
        return SendErrorMessage(playerid, "Este ID de casa n�o existe.");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses_other_entries` WHERE `house_id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return SendErrorMessage(playerid, "Esta casa ainda n�o possui nenhuma entrada vinculada a ela.");

    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");

    for(new i; i < MAX_SECOND_ENTRIES; i++) {
        if(sInfo[i][sHouseID] != id)
            continue;

        va_SendClientMessage(playerid, COLOR_BEGE, "A Entrada (ID %d) est� vinculada � casa de ID %d.", i, id);
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
        return SendErrorMessage(playerid, "Voc� n�o est� pr�ximmo � nenhuma casa.");

    if(HouseHasOwner(houseID))
        return SendErrorMessage(playerid, "Esta casa j� possui um dono.");

    if(GetMoney(playerid) < hInfo[houseID][hPrice])
        return SendErrorMessage(playerid, "Voc� n�o possui fundos o suficiente para comprar esta casa.");

    GiveMoney(playerid, -hInfo[houseID][hPrice]);
    va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� comprou a casa no endere�o %s.", GetHouseAddress(houseID));
    BuyHouse(houseID, playerid);

    return 1;
}

CMD:alugavel(playerid) {
    new houseID = GetNearestHouseEntry(playerid);

    if(!houseID)
        return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo � nenhuma casa.");
    
    SetRentableHouse(playerid, houseID);
    return 1;
}

CMD:precoaluguel(playerid, params[]) {
    new price;
    new houseID = GetNearestHouseEntry(playerid);

    if(!houseID)
        return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo � nenhuma casa.");
    
    if(hInfo[houseID][hOwner] != pInfo[playerid][pID])
        return SendErrorMessage(playerid, "Essa casa n�o � sua.");

    if(sscanf(params, "i", price))
        return SendSyntaxMessage(playerid, "/precoaluguel [pre�o]");
    
    if(!hInfo[houseID][hRentable])
        return SendErrorMessage(playerid, "Sua casa n�o est� alug�vel. (/alugavel)");
    
    if(price < 1 || price > 500)
        return SendErrorMessage(playerid, "O pre�o do aluguel n�o pode ser menor que $1 ou maior que $500.");
    
    SetRentPrice(houseID, playerid, price);
    va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� alterou o pre�o do aluguel da sua casa para $%s", FormatNumber(price));

    return 1;
}

<<<<<<< HEAD:gamemodes/modules/core/player/systems/properties/houses/houses_cmd.pwn
//Comando de campainha
CMD:campainha(playerid, params[]) {
    new 
        houseID = GetNearestHouseEntry(playerid);

	if(!houseID)
        return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo � nenhuma casa.");
    
    foreach (new i : Player) if (IsHouseInside(i) == houseID) {
            SendClientMessage(i, COLOR_PURPLE, "** Voc� pode ouvir a campainha tocar.");
            PlayerPlaySound(i, 20801, 0, 0, 0);
    }
	PlayerPlaySound(playerid, 20801, 0, 0, 0);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s toca a campainha da casa.", pNome(playerid));
=======
CMD:entrar(playerid) {
    new houseID = GetNearestHouseEntry(playerid), entryID = GetNearestHouseSecondEntry(playerid);
    
    if(houseID) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa est� trancada.");

        SetPlayerVirtualWorld(playerid, hInfo[houseID][vwExit]);
        SetPlayerInterior(playerid, hInfo[houseID][interiorExit]);
        SetPlayerPos(playerid, hInfo[houseID][hExitPos][0], hInfo[houseID][hExitPos][1], hInfo[houseID][hExitPos][2]);
        SetPlayerFacingAngle(playerid, hInfo[houseID][hExitPos][3]);
        
        return 1;
    }

    if(entryID) {
        if(sInfo[entryID][sLocked])
            return SendErrorMessage(playerid, "Esta entrada da casa est� trancada.");

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
            return SendErrorMessage(playerid, "Esta casa est� trancada.");

        SetPlayerVirtualWorld(playerid, hInfo[houseID][vwEntry]);
        SetPlayerInterior(playerid, hInfo[houseID][interiorEntry]);
        SetPlayerPos(playerid, hInfo[houseID][hEntryPos][0], hInfo[houseID][hEntryPos][1], hInfo[houseID][hEntryPos][2]);
        SetPlayerFacingAngle(playerid, hInfo[houseID][hEntryPos][3]);

        return 1;
    }

    if(entryID) {
        if(sInfo[entryID][sLocked])
            return SendErrorMessage(playerid, "Esta entrada est� trancada.");

        SetPlayerVirtualWorld(playerid, sInfo[entryID][sEntryVW]);
        SetPlayerInterior(playerid, sInfo[entryID][sEntryInterior]);
        SetPlayerPos(playerid, sInfo[entryID][sEntryPos][0], sInfo[entryID][sEntryPos][1], sInfo[entryID][sEntryPos][2]);
        SetPlayerFacingAngle(playerid, sInfo[entryID][sEntryPos][3]);

        return 1;
    }

>>>>>>> main:gamemodes/modules/core/player/systems/houses/houses_cmd.pwn
    return 1;
}