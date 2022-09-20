#include <YSI_Coding\y_hooks>

#define MAX_HOUSES          1000
#define MAX_SECOND_ENTRIES  5000

enum E_HOUSE_DATA {
    hID,                // ID da casa no MySQL
    hOwner,             // ID do personagem dono da casa
    hAddress[256],      // Endereço
    bool:hLocked,       // Trancado 
    hRentable,          // Alugavel
    hRent,              // Preço do aluguel
    hPrice,             // Preço de venda (pelo servidor)
    hStorageMoney,      // Dinheiro guardado
    Float:hExitPos[4],  // Posições (X, Y, Z, A) do interior
    vwExit,             // VW do interior
    interiorExit,       // Interior do interior
    Float:hEntryPos[4], // Posições (X, Y, Z, A) do exterior
    vwEntry,            // VW do exterior
    interiorEntry,      // Interior do exterior
};

new hInfo[MAX_HOUSES][E_HOUSE_DATA];

enum E_SECOND_ENTRIES_DATA {
    sID,                // ID da entrada no MySQL
    sHouseID,           // ID da casa que essa entrada pertence
    bool:sLocked,       // Trancado 
    Float:sExitPos[4],  // Posições (X, Y, Z, A) do interior
    sExitVW,            // VW do interior
    sExitInterior,      // Interior do interior
    Float:sEntryPos[4], // Posições (X, Y, Z, A) do exterior
    sEntryVW,           // VW do exterior
    sEntryInterior,     // Interior do exterior
};

new sInfo[MAX_SECOND_ENTRIES][E_SECOND_ENTRIES_DATA];

// ============================================================================================================================================

hook OnGameModeInit() {
    LoadHouses();
    LoadEntries();
    return 1;
}

hook OnGamemodeExit() {
    SaveHouses();
    SaveEntries();
    return 1;
}

// ============================================================================================================================================
LoadHouses() {
    new loadedHouses;

    mysql_query(DBConn, "SELECT * FROM `houses`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        hInfo[id][hID] = id;

        cache_get_value_name_int(i, "character_id", hInfo[id][hOwner]);
        cache_get_value_name(i, "address", hInfo[id][hAddress]);
        cache_get_value_name_int(i, "locked", hInfo[id][hLocked]);
        cache_get_value_name_int(i, "price", hInfo[id][hPrice]);
        cache_get_value_name_int(i, "storage_money", hInfo[id][hStorageMoney]);
        cache_get_value_name_float(i, "entry_x", hInfo[id][hEntryPos][0]);
        cache_get_value_name_float(i, "entry_y", hInfo[id][hEntryPos][1]);
        cache_get_value_name_float(i, "entry_z", hInfo[id][hEntryPos][2]);
        cache_get_value_name_float(i, "entry_a", hInfo[id][hEntryPos][3]);
        cache_get_value_name_int(i, "vw_entry", hInfo[id][vwEntry]);
        cache_get_value_name_int(i, "interior_entry", hInfo[id][interiorEntry]);
        cache_get_value_name_float(i, "exit_x", hInfo[id][hExitPos][0]);
        cache_get_value_name_float(i, "exit_y", hInfo[id][hExitPos][1]);
        cache_get_value_name_float(i, "exit_z", hInfo[id][hExitPos][2]);
        cache_get_value_name_float(i, "exit_a", hInfo[id][hExitPos][3]);
        cache_get_value_name_int(i, "vw_exit", hInfo[id][vwExit]);
        cache_get_value_name_int(i, "interior_exit", hInfo[id][interiorExit]);
        cache_get_value_name_int(i, "rentable", hInfo[id][hRentable]);
        cache_get_value_name_int(i, "rent_price", hInfo[id][hRent]);

        loadedHouses++;
    }

    printf("[CASAS]: %d casas carregadas com sucesso.", loadedHouses);

    return 1;
}

LoadHouse(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    hInfo[id][hID] = id;
    cache_get_value_name_int(0, "character_id", hInfo[id][hOwner]);
    cache_get_value_name(0, "address", hInfo[id][hAddress]);
    cache_get_value_name_int(0, "locked", hInfo[id][hLocked]);
    cache_get_value_name_int(0, "price", hInfo[id][hPrice]);
    cache_get_value_name_int(0, "storage_money", hInfo[id][hStorageMoney]);
    cache_get_value_name_float(0, "entry_x", hInfo[id][hEntryPos][0]);
    cache_get_value_name_float(0, "entry_y", hInfo[id][hEntryPos][1]);
    cache_get_value_name_float(0, "entry_z", hInfo[id][hEntryPos][2]);
    cache_get_value_name_float(0, "entry_a", hInfo[id][hEntryPos][3]);
    cache_get_value_name_int(0, "vw_entry", hInfo[id][vwEntry]);
    cache_get_value_name_int(0, "interior_entry", hInfo[id][interiorEntry]);
    cache_get_value_name_float(0, "exit_x", hInfo[id][hExitPos][0]);
    cache_get_value_name_float(0, "exit_y", hInfo[id][hExitPos][1]);
    cache_get_value_name_float(0, "exit_z", hInfo[id][hExitPos][2]);
    cache_get_value_name_float(0, "exit_a", hInfo[id][hExitPos][3]);
    cache_get_value_name_int(0, "vw_exit", hInfo[id][vwExit]);
    cache_get_value_name_int(0, "interior_exit", hInfo[id][interiorExit]);
    cache_get_value_name_int(0, "rentable", hInfo[id][hRentable]);
    cache_get_value_name_int(0, "rent_price", hInfo[id][hRent]);

    return 1;
}

SaveHouses() {
    new savedHouses;

    for(new i; i < MAX_HOUSES; i++) {
        if(!hInfo[i][hID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `houses` SET `character_id` = '%d', `address` = '%e', `locked` = '%d', `storage_money` = '%d', `price` = '%d', \
            `entry_x` = '%f', `entry_y` = '%f', `entry_z` = '%f', `entry_a` = '%f', `vw_entry` = '%d', `interior_entry` = '%d', \
            `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `vw_exit` = '%d', `interior_exit` = %d, `rentable` = %d, `rent_price` = %d WHERE `id` = %d;", hInfo[i][hOwner], hInfo[i][hAddress], hInfo[i][hLocked], hInfo[i][hStorageMoney], hInfo[i][hPrice],
            hInfo[i][hEntryPos][0], hInfo[i][hEntryPos][1], hInfo[i][hEntryPos][2], hInfo[i][hEntryPos][3], hInfo[i][vwEntry], hInfo[i][interiorEntry],
            hInfo[i][hExitPos][0], hInfo[i][hExitPos][1], hInfo[i][hExitPos][2], hInfo[i][hExitPos][3], hInfo[i][vwExit], hInfo[i][interiorExit], hInfo[i][hRentable], hInfo[i][hRent], i);
        mysql_query(DBConn, query);

        savedHouses++;
    }

    printf("[CASAS]: %d casas salvas com sucesso.", savedHouses);

    return 1;
}

SaveHouse(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `houses` SET `character_id` = '%d', `address` = '%e', `locked` = '%d', `storage_money` = '%d', `price` = '%d', \
        `entry_x` = '%f', `entry_y` = '%f', `entry_z` = '%f', `entry_a` = '%f', `vw_entry` = '%d', `interior_entry` = '%d', \
        `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `vw_exit` = '%d', `interior_exit` = %d, `rentable` = %d, `rent_price` = %d WHERE `id` = %d;", hInfo[id][hOwner], hInfo[id][hAddress], hInfo[id][hLocked], hInfo[id][hStorageMoney], hInfo[id][hPrice],
        hInfo[id][hEntryPos][0], hInfo[id][hEntryPos][1], hInfo[id][hEntryPos][2], hInfo[id][hEntryPos][3], hInfo[id][vwEntry], hInfo[id][interiorEntry],
        hInfo[id][hExitPos][0], hInfo[id][hExitPos][1], hInfo[id][hExitPos][2], hInfo[id][hExitPos][3], hInfo[id][vwExit], hInfo[id][interiorExit], hInfo[id][hRentable], hInfo[id][hRent], id);
    mysql_query(DBConn, query);

    return 1;
}

IsValidHouse(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

HouseHasOwner(id) {
    return IsValidHouse(id) && (hInfo[id][hOwner]);
}

// Procura por alguma entrada de casa
GetNearestHouseEntry(playerid, Float:distance = 1.0) {
    for(new i; i < MAX_HOUSES; i++) {
        if(!hInfo[i][hID])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, hInfo[i][hEntryPos][0], hInfo[i][hEntryPos][1], hInfo[i][hEntryPos][2]))
            continue;

        if(GetPlayerVirtualWorld(playerid) != hInfo[i][vwEntry] || GetPlayerInterior(playerid) != hInfo[i][interiorEntry])
            continue;

        return i;
    }

    return 0;
}

// Procura por alguma saída de casa
GetNearestHouseExit(playerid, Float:distance = 1.0) {
    for(new i; i < MAX_HOUSES; i++) {
        if(!hInfo[i][hID])
            continue;
        
        if(GetPlayerVirtualWorld(playerid) != hInfo[i][vwExit] || GetPlayerInterior(playerid) != hInfo[i][interiorExit])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, hInfo[i][hExitPos][0], hInfo[i][hExitPos][1], hInfo[i][hExitPos][2]))
            continue;

        return i;
    }

    return 0;
}

// ============================================================================================================================================
LoadEntries() {
    new loadedEntries;

    mysql_query(DBConn, "SELECT * FROM `houses_other_entries`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        sInfo[id][sID] = id;

        cache_get_value_name_int(i, "house_id", sInfo[id][sHouseID]);
        cache_get_value_name_int(i, "locked", sInfo[id][sLocked]);
        cache_get_value_name_float(i, "entry_x", sInfo[id][sEntryPos][0]);
        cache_get_value_name_float(i, "entry_y", sInfo[id][sEntryPos][1]);
        cache_get_value_name_float(i, "entry_z", sInfo[id][sEntryPos][2]);
        cache_get_value_name_float(i, "entry_a", sInfo[id][sEntryPos][3]);
        cache_get_value_name_int(i, "vw_entry", sInfo[id][sEntryVW]);
        cache_get_value_name_int(i, "interior_entry", sInfo[id][sEntryInterior]);
        cache_get_value_name_float(i, "exit_x", sInfo[id][sExitPos][0]);
        cache_get_value_name_float(i, "exit_y", sInfo[id][sExitPos][1]);
        cache_get_value_name_float(i, "exit_z", sInfo[id][sExitPos][2]);
        cache_get_value_name_float(i, "exit_a", sInfo[id][sExitPos][3]);
        cache_get_value_name_int(i, "vw_exit", sInfo[id][sExitVW]);
        cache_get_value_name_int(i, "interior_exit", sInfo[id][sExitInterior]);

        loadedEntries++;
    }

    printf("[CASAS]: %d entradas secundárias carregadas com sucesso.", loadedEntries);

    return 1;
}

LoadEntry(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses_other_entries` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    sInfo[id][sID] = id;

    cache_get_value_name_int(0, "house_id", sInfo[id][sHouseID]);
    cache_get_value_name_int(0, "locked", sInfo[id][sLocked]);
    cache_get_value_name_float(0, "entry_x", sInfo[id][sEntryPos][0]);
    cache_get_value_name_float(0, "entry_y", sInfo[id][sEntryPos][1]);
    cache_get_value_name_float(0, "entry_z", sInfo[id][sEntryPos][2]);
    cache_get_value_name_float(0, "entry_a", sInfo[id][sEntryPos][3]);
    cache_get_value_name_int(0, "vw_entry", sInfo[id][sEntryVW]);
    cache_get_value_name_int(0, "interior_entry", sInfo[id][sEntryInterior]);
    cache_get_value_name_float(0, "exit_x", sInfo[id][sExitPos][0]);
    cache_get_value_name_float(0, "exit_y", sInfo[id][sExitPos][1]);
    cache_get_value_name_float(0, "exit_z", sInfo[id][sExitPos][2]);
    cache_get_value_name_float(0, "exit_a", sInfo[id][sExitPos][3]);
    cache_get_value_name_int(0, "vw_exit", sInfo[id][sExitVW]);
    cache_get_value_name_int(0, "interior_exit", sInfo[id][sExitInterior]);

    return 1;
}

SaveEntries() {
    new savedEntries;

    for(new i; i < MAX_SECOND_ENTRIES; i++) {
        if(!hInfo[i][hID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `houses_other_entries` SET `house_id` = '%d', `locked` = '%d', \
            `entry_x` = '%f', `entry_y` = '%f', `entry_z` = '%f', `entry_a` = '%f', `vw_entry` = '%d', `interior_entry` = '%d', \
            `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `vw_exit` = '%d', `interior_exit` = %d WHERE `id` = %d;", sInfo[i][sHouseID], sInfo[i][sLocked],
            sInfo[i][sEntryPos][0], sInfo[i][sEntryPos][1], sInfo[i][sEntryPos][2], sInfo[i][sEntryPos][3], sInfo[i][sEntryVW], sInfo[i][sEntryInterior],
            sInfo[i][sExitPos][0], sInfo[i][sExitPos][1], sInfo[i][sExitPos][2], sInfo[i][sExitPos][3], sInfo[i][sExitVW], sInfo[i][sExitInterior], i);
        mysql_query(DBConn, query);

        savedEntries++;
    }

    printf("[CASAS]: %d entradas secundárias salvas com sucesso.", savedEntries);

    return 1;
}

SaveEntry(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses_other_entries` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `houses_other_entries` SET `house_id` = '%d', `locked` = '%d', \
        `entry_x` = '%f', `entry_y` = '%f', `entry_z` = '%f', `entry_a` = '%f', `vw_entry` = '%d', `interior_entry` = '%d', \
        `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `vw_exit` = '%d', `interior_exit` = %d WHERE `id` = %d;", sInfo[id][sHouseID], sInfo[id][sLocked],
        sInfo[id][sEntryPos][0], sInfo[id][sEntryPos][1], sInfo[id][sEntryPos][2], sInfo[id][sEntryPos][3], sInfo[id][sEntryVW], sInfo[id][sEntryInterior],
        sInfo[id][sExitPos][0], sInfo[id][sExitPos][1], sInfo[id][sExitPos][2], sInfo[id][sExitPos][3], sInfo[id][sExitVW], sInfo[id][sExitInterior], id);
    mysql_query(DBConn, query);

    return 1;
}

IsValidEntry(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `houses_other_entries` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

// Procura por alguma entrada secundária de casa
GetNearestHouseSecondEntry(playerid, Float:distance = 1.0) {
    for(new i; i < MAX_SECOND_ENTRIES; i++) {
        if(!sInfo[i][sHouseID])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, sInfo[i][sEntryPos][0], sInfo[i][sEntryPos][1], sInfo[i][sEntryPos][2]))
            continue;

        if(GetPlayerVirtualWorld(playerid) != sInfo[i][sEntryVW] || GetPlayerInterior(playerid) != sInfo[i][sEntryInterior])
            continue;

        return i;
    }

    return 0;
}

// Procura por alguma saída secundária de casa
GetNearestHouseSecondExit(playerid, Float:distance = 1.0) {
    for(new i; i < MAX_SECOND_ENTRIES; i++) {
        if(!sInfo[i][sHouseID])
            continue;
        
        if(GetPlayerVirtualWorld(playerid) != sInfo[i][sExitVW] || GetPlayerInterior(playerid) != sInfo[i][sExitInterior])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, sInfo[i][sExitPos][0], sInfo[i][sExitPos][1], sInfo[i][sExitPos][2]))
            continue;

        return i;
    }

    return 0;
}

GetHouseAddress(id) {
    IsValidHouse(id);

    new address[256];
    format(address, sizeof(address), "%s", hInfo[id][hAddress]);

    return address;
}

BuyHouse(id, playerid) {
    hInfo[id][hOwner] = pInfo[playerid][pID];
    SaveHouse(id);

    format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(hInfo[id][hPrice]));
	logCreate(playerid, logString, 13);

    return 1;
}

RentableHouse(id, playerid, rentable) {
    if(rentable != 1)
        rentable = 0;

    hInfo[id][hRentable] = rentable;
    hInfo[id][hRent] = 1;
    SaveHouse(id);

    format(logString, sizeof(logString), "%s (%s) deixou a casa ID %d %s.", pNome(playerid), GetPlayerUserEx(playerid), id, (rentable ? "alugável" : "não alugável"));
	logCreate(playerid, logString, 13);

    return 1;
}

SetRentPrice(id, playerid, value) {
    hInfo[id][hRent] = value;
    SaveHouse(id);

    format(logString, sizeof(logString), "%s (%s) alterou o preço de aluguel da sua casa ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(value));
	logCreate(playerid, logString, 13);

    return 1;
}

RentHouse(id, playerid) {
    pInfo[playerid][pRenting] = hInfo[id][hID];
    SaveCharacterInfo(playerid);

    CreatePropertyKey(playerid, id, 1, true);

    format(logString, sizeof(logString), "%s (%s) alugou um quarto na casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(hInfo[id][hRent]));
	logCreate(playerid, logString, 13);

    return 1;
}

UnrentHouse(id, playerid) {
    pInfo[playerid][pRenting] = INVALID_HOUSE_ID;
    SaveCharacterInfo(playerid);

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `players_keys` WHERE `character_id` = %d AND `property_id` = %d", pInfo[playerid][pID], id);
    mysql_query(DBConn, query);

    SavePlayerKeys(playerid);

    format(logString, sizeof(logString), "%s (%s) desalugou um quarto na casa ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
	logCreate(playerid, logString, 13);

    return 1;
}

EvictFromRent(id, playerid, evictedplayerid) {
    PlayerInfo[evictedplayerid][pRenting] = INVALID_HOUSE_ID;

    format(string, sizeof(string), "%s despejou você da casa dele no endereço %s.", GetPlayerNameEx(playerid), hInfo[id][hAddress]);
    SendClientMessageEx(evictedplayerid, COLOR_WHITE, string);

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `players_keys` WHERE `character_id` = %d AND `property_id` = %d", pInfo[evictedplayerid][pID], id);
    mysql_query(DBConn, query);

    format(string, sizeof(string), "Você despejou %s da sua casa.", GetPlayerNameEx(evictedplayerid));
    SendClientMessageEx(playerid, COLOR_WHITE, string);

    return 1;
}