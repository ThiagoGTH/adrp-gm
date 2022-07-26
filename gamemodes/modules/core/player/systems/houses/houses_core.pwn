#include <YSI_Coding\y_hooks>

#define MAX_HOUSES          1000

enum E_HOUSE_DATA {
    hID,                // ID da casa no MySQL
    hOwner,             // ID do personagem dono da casa
    hAddress[256],      // Endereço
    bool:hLocked,       // Trancado 
    hPrice,             // Preço de venda (pelo servidor)
    hStorageMoney,      // Dinheiro guardado
    Float:hExitPos[4],  // Posições (X, Y, Z, A) do interior
    vwExit,             // VW do interior
    interiorExit,       // Interior do interior
    Float:hEntryPos[4], // Posições (X, Y, Z, A) do exterior
    vwEntry,            // VW do exterior
    interiorEntry,      // Interior do exterior
};

new hInfo[1000][E_HOUSE_DATA];

// ============================================================================================================================================

hook OnGameModeInit() {
    LoadHouses();

    return 1;
}

hook OnGamemodeExit() {
    SaveHouses();

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

        loadedHouses++;
    }

    printf("[CASAS]: %d casas carregadas com sucesso.", loadedHouses);

    return 1;
}

SaveHouses() {
    new savedHouses;

    for(new i; i < MAX_HOUSES; i++) {
        if(!hInfo[i][hID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `houses` SET `character_id` = %d, `address` = '%e', `locked` = %d, `storage_money` = %d, `price` = %d, \
            `entry_x` = %f, `entry_y` = %f, `entry_z` = %f, `entry_a` = %f, `vw_entry` = %d, `interior_entry` = %d, \
            `exit_x` = %f, `exit_y` = %f, `exit_z` = %f, `exit_a` = %f, `vw_exit` = %d, `interior_exit` = %d WHERE `id` = %d;", hInfo[i][hOwner], hInfo[i][hAddress], hInfo[i][hLocked], hInfo[i][hStorageMoney], hInfo[i][hPrice],
            hInfo[i][hEntryPos][0], hInfo[i][hEntryPos][1], hInfo[i][hEntryPos][2], hInfo[i][hEntryPos][3], hInfo[i][vwEntry], hInfo[i][interiorEntry],
            hInfo[i][hExitPos][0], hInfo[i][hExitPos][1], hInfo[i][hExitPos][2], hInfo[i][hExitPos][3], hInfo[i][vwExit], hInfo[i][interiorExit], i);
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

    mysql_format(DBConn, query, sizeof query, "UPDATE `houses` SET `character_id` = %d, `address` = '%e', `locked` = %d, `storage_money` = %d, `price` = %d, \
        `entry_x` = %f, `entry_y` = %f, `entry_z` = %f, `entry_a` = %f, `vw_entry` = %d, `interior_entry` = %d, \
        `exit_x` = %f, `exit_y` = %f, `exit_z` = %f, `exit_a` = %f, `vw_exit` = %d, `interior_exit` = %d WHERE `id` = %d;", hInfo[id][hOwner], hInfo[id][hAddress], hInfo[id][hLocked], hInfo[id][hStorageMoney], hInfo[id][hPrice],
        hInfo[id][hEntryPos][0], hInfo[id][hEntryPos][1], hInfo[id][hEntryPos][2], hInfo[id][hEntryPos][3], hInfo[id][vwEntry], hInfo[id][interiorEntry],
        hInfo[id][hExitPos][0], hInfo[id][hExitPos][1], hInfo[id][hExitPos][2], hInfo[id][hExitPos][3], hInfo[id][vwExit], hInfo[id][interiorExit], id);
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