#define MAX_GARAGES          2000

enum E_GARAGE_DATA {
	gID,                    // ID da garagem no MySQL
	gOwner,                 // ID do personagem dono da garagem
    gHouse,                 // ID da casa atrelada (caso haja)
	gAddress[24],           // Endereço da Garagem, podendo ser o mesmo da casa
	bool:gLocked,           // Garagem trancada
    gInv,                   // ID do inventário da Garagem
    gPrice,                 // Preço de venda (pelo servidor)
    gStorageMoney,          // Dinheiro guardado
    Float:gStorageItem[6]   // Itens no Armazenamento da Garagem
    Float:gStorageAmount[6] // Quantidade do Item no Armazenamento da Garagem
    Float:gEntryPos[4],     // Posições (X, Y, Z, A) do exterior
    gVwEntry,               // VW do exterior
    gInteriorEntry,         // Interior do exterior
    Float:gExitPos[4],      // Posições (X, Y, Z, A) do interior
    gVwExit,                // VW do interior
    gInteriorExit,          // Interior do interior
};

new gInfo[MAX_GARAGES][E_GARAGE_DATA];


// ============================================================================================================================================

hook OnGameModeInit() {
    LoadGarages();
    LoadEntries();
    return 1;
}

hook OnGamemodeExit() {
    SaveGarages();
    SaveEntries();
    return 1;
}

// ============================================================================================================================================
LoadGarages() {
    new loadedGarages;

    mysql_query(DBConn, "SELECT * FROM `garages`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        gInfo[id][hID] = id;

        cache_get_value_name_int(i, "character_id", gInfo[id][gOwner]);
        cache_get_value_name(i, "address", gInfo[id][hAddress]);
        cache_get_value_name_int(i, "locked", gInfo[id][gLocked]);
        cache_get_value_name_int(i, "price", gInfo[id][gPrice]);
        cache_get_value_name_int(i, "storage_money", gInfo[id][gStorageMoney]);
        cache_get_value_name_int(i, "storage_item1", gInfo[id][gStorageItem][0]);
        cache_get_value_name_int(i, "storage_item2", gInfo[id][gStorageItem][1]);
        cache_get_value_name_int(i, "storage_item3", gInfo[id][gStorageItem][2]);
        cache_get_value_name_int(i, "storage_item4", gInfo[id][gStorageItem][3]);
        cache_get_value_name_int(i, "storage_item5", gInfo[id][gStorageItem][4]);
        cache_get_value_name_int(i, "storage_item6", gInfo[id][gStorageItem][5]);
        cache_get_value_name_int(i, "storage_amount1", gInfo[id][gStorageAmount][0]);
        cache_get_value_name_int(i, "storage_amount2", gInfo[id][gStorageAmount][1]);
        cache_get_value_name_int(i, "storage_amount3", gInfo[id][gStorageAmount][2]);
        cache_get_value_name_int(i, "storage_amount4", gInfo[id][gStorageAmount][3]);
        cache_get_value_name_int(i, "storage_amount5", gInfo[id][gStorageAmount][4]);
        cache_get_value_name_int(i, "storage_amount6", gInfo[id][gStorageAmount][5]);
        cache_get_value_name_float(i, "entry_x", gInfo[id][gEntryPos][0]);
        cache_get_value_name_float(i, "entry_y", gInfo[id][gEntryPos][1]);
        cache_get_value_name_float(i, "entry_z", gInfo[id][gEntryPos][2]);
        cache_get_value_name_float(i, "entry_a", gInfo[id][gEntryPos][3]);
        cache_get_value_name_int(i, "vw_entry", gInfo[id][gVwEntry]);
        cache_get_value_name_int(i, "interior_entry", gInfo[id][gInteriorEntry]);
        cache_get_value_name_float(i, "exit_x", gInfo[id][gExitPos][0]);
        cache_get_value_name_float(i, "exit_y", gInfo[id][gExitPos][1]);
        cache_get_value_name_float(i, "exit_z", gInfo[id][gExitPos][2]);
        cache_get_value_name_float(i, "exit_a", gInfo[id][gExitPos][3]);
        cache_get_value_name_int(i, "vw_exit", gInfo[id][gVwExit]);
        cache_get_value_name_int(i, "interior_exit", gInfo[id][gInteriorExit]);

        loadedGarages++;
    }

    printf("[CASAS]: %d casas carregadas com sucesso.", loadedGarages);

    return 1;
}

LoadGarage(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `garages` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    gInfo[id][hID] = id;
    cache_get_value_name_int(i, "character_id", gInfo[id][gOwner]);
    cache_get_value_name(i, "address", gInfo[id][hAddress]);
    cache_get_value_name_int(i, "locked", gInfo[id][gLocked]);
    cache_get_value_name_int(i, "price", gInfo[id][gPrice]);
    cache_get_value_name_int(i, "storage_money", gInfo[id][gStorageMoney]);
    cache_get_value_name_int(i, "storage_item1", gInfo[id][gStorageItem][0]);
    cache_get_value_name_int(i, "storage_item2", gInfo[id][gStorageItem][1]);
    cache_get_value_name_int(i, "storage_item3", gInfo[id][gStorageItem][2]);
    cache_get_value_name_int(i, "storage_item4", gInfo[id][gStorageItem][3]);
    cache_get_value_name_int(i, "storage_item5", gInfo[id][gStorageItem][4]);
    cache_get_value_name_int(i, "storage_item6", gInfo[id][gStorageItem][5]);
    cache_get_value_name_int(i, "storage_amount1", gInfo[id][gStorageAmount][0]);
    cache_get_value_name_int(i, "storage_amount2", gInfo[id][gStorageAmount][1]);
    cache_get_value_name_int(i, "storage_amount3", gInfo[id][gStorageAmount][2]);
    cache_get_value_name_int(i, "storage_amount4", gInfo[id][gStorageAmount][3]);
    cache_get_value_name_int(i, "storage_amount5", gInfo[id][gStorageAmount][4]);
    cache_get_value_name_int(i, "storage_amount6", gInfo[id][gStorageAmount][5]);
    cache_get_value_name_float(i, "entry_x", gInfo[id][gEntryPos][0]);
    cache_get_value_name_float(i, "entry_y", gInfo[id][gEntryPos][1]);
    cache_get_value_name_float(i, "entry_z", gInfo[id][gEntryPos][2]);
    cache_get_value_name_float(i, "entry_a", gInfo[id][gEntryPos][3]);
    cache_get_value_name_int(i, "vw_entry", gInfo[id][gVwEntry]);
    cache_get_value_name_int(i, "interior_entry", gInfo[id][gInteriorEntry]);
    cache_get_value_name_float(i, "exit_x", gInfo[id][gExitPos][0]);
    cache_get_value_name_float(i, "exit_y", gInfo[id][gExitPos][1]);
    cache_get_value_name_float(i, "exit_z", gInfo[id][gExitPos][2]);
    cache_get_value_name_float(i, "exit_a", gInfo[id][gExitPos][3]);
    cache_get_value_name_int(i, "vw_exit", gInfo[id][gVwExit]);
    cache_get_value_name_int(i, "interior_exit", gInfo[id][gInteriorExit]);

    return 1;
}

SaveGarages() {
    new savedGarages;

    for(new i; i < MAX_HOUSES; i++) {
        if(!gInfo[i][hID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `garages` SET `character_id` = '%d', \
            `address` = '%e', \
            `locked` = '%d', \
            `storage_money` = '%d', \
            `price` = '%d', \
            `storage_money` = '%d',\
            `storage_item1` = '%d',\
            `storage_amount1` = '%d',\
            `storage_item2` = '%d',\
            `storage_amount2` = '%d',\
            `storage_item3` = '%d',\
            `storage_amount3` = '%d',\
            `storage_item4` = '%d',\
            `storage_amount4` = '%d',\
            `storage_item5` = '%d',\
            `storage_amount5` = '%d',\
            `storage_item6` = '%d',\
            `storage_amount6` = '%d',\
            `entry_x` = '%f', \
            `entry_y` = '%f', \
            `entry_z` = '%f', \
            `entry_a` = '%f', \
            `vw_entry` = '%d', \
            `interior_entry` = '%d', \
            `exit_x` = '%f', \
            `exit_y` = '%f', \
            `exit_z` = '%f', \
            `exit_a` = '%f', \
            `vw_exit` = '%d', \
            `interior_exit` = %d WHERE `id` = %d;", 
            gInfo[i][gOwner], gInfo[i][gAddress], gInfo[i][gLocked], gInfo[i][gStorageMoney], 
            gInfo[i][gStorageItem][0], gInfo[i][gStorageItem][1], gInfo[i][gStorageItem][2], 
            gInfo[i][gStorageItem][3], gInfo[i][gStorageItem][4], gInfo[i][gStorageItem][5], 
            gInfo[i][gStorageAmount][0], gInfo[i][gStorageAmount][1], gInfo[i][gStorageAmount][2], 
            gInfo[i][gStorageAmount][3], gInfo[i][gStorageAmount][4], gInfo[i][gStorageAmount][5], 
            gInfo[i][gPrice], gInfo[i][gEntryPos][0], gInfo[i][gEntryPos][1], gInfo[i][gEntryPos][2], 
            gInfo[i][gEntryPos][3], gInfo[i][gVwEntry], gInfo[i][gInteriorEntry],gInfo[i][gExitPos][0], 
            gInfo[i][gExitPos][1], gInfo[i][gExitPos][2], gInfo[i][gExitPos][3], gInfo[i][gVwExit], 
            gInfo[i][gInteriorExit], i);
        mysql_query(DBConn, query);

        savedGarages++;
    }

    printf("[CASAS]: %d casas salvas com sucesso.", savedGarages);

    return 1;
}

SaveGarage(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `garages` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `garages` SET `character_id` = '%d', \
        `address` = '%e', \
        `locked` = '%d', \
        `storage_money` = '%d', \
        `price` = '%d', \
        `storage_money` = '%d',\
        `storage_item1` = '%d',\
        `storage_amount1` = '%d',\
        `storage_item2` = '%d',\
        `storage_amount2` = '%d',\
        `storage_item3` = '%d',\
        `storage_amount3` = '%d',\
        `storage_item4` = '%d',\
        `storage_amount4` = '%d',\
        `storage_item5` = '%d',\
        `storage_amount5` = '%d',\
        `storage_item6` = '%d',\
        `storage_amount6` = '%d',\
        `entry_x` = '%f', \
        `entry_y` = '%f', \
        `entry_z` = '%f', \
        `entry_a` = '%f', \
        `vw_entry` = '%d', \
        `interior_entry` = '%d', \
        `exit_x` = '%f', \
        `exit_y` = '%f', \
        `exit_z` = '%f', \
        `exit_a` = '%f', \
        `vw_exit` = '%d', \
        `interior_exit` = %d WHERE `id` = %d;", 
        gInfo[i][gOwner], gInfo[i][gAddress], gInfo[i][gLocked], gInfo[i][gStorageMoney], 
        gInfo[i][gStorageItem][0], gInfo[i][gStorageItem][1], gInfo[i][gStorageItem][2], 
        gInfo[i][gStorageItem][3], gInfo[i][gStorageItem][4], gInfo[i][gStorageItem][5], 
        gInfo[i][gStorageAmount][0], gInfo[i][gStorageAmount][1], gInfo[i][gStorageAmount][2], 
        gInfo[i][gStorageAmount][3], gInfo[i][gStorageAmount][4], gInfo[i][gStorageAmount][5], 
        gInfo[i][gPrice], gInfo[i][gEntryPos][0], gInfo[i][gEntryPos][1], gInfo[i][gEntryPos][2], 
        gInfo[i][gEntryPos][3], gInfo[i][gVwEntry], gInfo[i][gInteriorEntry],gInfo[i][gExitPos][0], 
        gInfo[i][gExitPos][1], gInfo[i][gExitPos][2], gInfo[i][gExitPos][3], gInfo[i][gVwExit], 
        gInfo[i][gInteriorExit], i);
    mysql_query(DBConn, query);

    return 1;
}

IsValidGarage(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `garages` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

GarageHasOwner(id) {
    return IsValidGarage(id) && (gInfo[id][gOwner]);
}

CreateGarage(price, address[256], Float:pos[4]){

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `garages` WHERE `address` = '%e';", address);
    mysql_query(DBConn, query);

    if(cache_num_rows())
        return SendErrorMessage(playerid, "Este endereço já está registrado em outra garagem!");

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `garages` (`address`, `price`, `entry_x`, `entry_y`, `entry_z`, `entry_a`, `vw_entry`, `interior_entry`) \
        VALUES ('%s', %d, %f, %f, %f, %f, %d, %d);", address, price, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();

    mysql_format(DBConn, query, sizeof query, "UPDATE `garages` SET `vw_exit` = %d WHERE `id` = %d;", id + 10000, id);
    mysql_query(DBConn, query);

    LoadGarage(id);

    SendServerMessage(playerid, "Você criou a garagem de ID %d no endereço: '%s'. ($%s)", id, address, FormatNumber(price));
    format(logString, sizeof(logString), "%s (%s) criou a garagem de ID %d no endereço: '%s'. ($%s)", pNome(playerid), GetPlayerUserEx(playerid), id, address,  FormatNumber(price));
	logCreate(playerid, logString, 13);

    return 1;
}