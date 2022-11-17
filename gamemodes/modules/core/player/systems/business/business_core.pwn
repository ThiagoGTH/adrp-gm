#include <YSI_Coding\y_hooks>

#define MAX_BUSINESS          1000

enum E_BUSINESS_DATA {
    bID,                // ID da empresa no MySQL
    bOwner,             // ID do personagem dono da empresa
    bAddress[256],      // Endereço
    bool:bLocked,       // Trancado
    bName[256],              // Nome da empresa
    bType,              // Tipo da empresa (lojas (eletronicos, mercado, entre outros), concecionaria, "firma")
    bInventory,         // Estoque da empresa
    bStorageMoney,      // Dinheiro guardado/cofre da empresa
    bPrice,             // Preço da empresa
    Float:bExitPos[4],  // Posições (X, Y, Z, A) do interior
    vwExit,             // VW do interior
    interiorExit,       // Interior do interior
    Float:bEntryPos[4], // Posições (X, Y, Z, A) do exterior
    vwEntry,            // VW do exterior
    interiorEntry,      // Interior do exterior
};

new bInfo[MAX_BUSINESS][E_BUSINESS_DATA];

// ============================================================================================================================================
// Lembre-se em colocar este código em mysql_core.pwn e também chamar a função CheckBusinesssTable(); (em CheckTables).

/* void:CheckBusinesssTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `business` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `character_id` int DEFAULT '0',\
    `address` varchar(256) DEFAULT 'Endereço desconhecido',\
    `locked` int DEFAULT '0',\
    `name` varchar(256) DEFAULT 'Empresa desconhecida',\
    `type` int DEFAULT '0',\
    `inventory` int DEFAULT '0',\
    `storage_money` int DEFAULT '0',\
    `price` int DEFAULT '0',\
    `entry_x` float DEFAULT '0',\
    `entry_y` float DEFAULT '0',\
    `entry_z` float DEFAULT '0',\
    `entry_a` float DEFAULT '0',\
    `vw_entry` int DEFAULT '0',\
    `interior_entry` int DEFAULT '0',\
    `exit_x` float DEFAULT '0',\
    `exit_y` float DEFAULT '0',\
    `exit_z` float DEFAULT '0',\
    `exit_a` float DEFAULT '0',\
    `vw_exit` int DEFAULT '0',\
    `interior_exit` int DEFAULT '0',\
    PRIMARY KEY (`id`));");
    
    print("[DATABASE] Tabela business checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela business checada com sucesso");
    logCreate(99998, logString, 5);
} */

// ============================================================================================================================================

hook OnGameModeInit() {
    LoadBusinesss();
    return 1;
}

hook OnGamemodeExit() {
    SaveBusinesss();
    return 1;
}

// ============================================================================================================================================

//Carrega todas empresas (MySQL).
LoadBusinesss() {
    new     
        loadedBusiness;

    mysql_query(DBConn, "SELECT * FROM `business`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        bInfo[id][bID] = id;

        cache_get_value_name_int(i, "character_id", bInfo[id][bOwner]);
        cache_get_value_name(i, "address", bInfo[id][bAddress]);
        cache_get_value_name_int(i, "locked", bInfo[id][bLocked]);
        cache_get_value_name(i, "name", bInfo[id][bName]);
        cache_get_value_name_int(i, "type", bInfo[id][bType]);
        cache_get_value_name_int(i, "inventory", bInfo[id][bInventory]);
        cache_get_value_name_int(i, "storage_money", bInfo[id][bStorageMoney]);
        cache_get_value_name_int(i, "price", bInfo[id][bPrice]);
        cache_get_value_name_float(i, "entry_x", bInfo[id][bEntryPos][0]);
        cache_get_value_name_float(i, "entry_y", bInfo[id][bEntryPos][1]);
        cache_get_value_name_float(i, "entry_z", bInfo[id][bEntryPos][2]);
        cache_get_value_name_float(i, "entry_a", bInfo[id][bEntryPos][3]);
        cache_get_value_name_int(i, "vw_entry", bInfo[id][vwEntry]);
        cache_get_value_name_int(i, "interior_entry", bInfo[id][interiorEntry]);
        cache_get_value_name_float(i, "exit_x", bInfo[id][bExitPos][0]);
        cache_get_value_name_float(i, "exit_y", bInfo[id][bExitPos][1]);
        cache_get_value_name_float(i, "exit_z", bInfo[id][bExitPos][2]);
        cache_get_value_name_float(i, "exit_a", bInfo[id][bExitPos][3]);
        cache_get_value_name_int(i, "vw_exit", bInfo[id][vwExit]);
        cache_get_value_name_int(i, "interior_exit", bInfo[id][interiorExit]);

        loadedBusiness++;
    }

    printf("[EMPRESAS]: %d empresas carregadas com sucesso.", loadedBusiness);

    return 1;
}

//Carrega empresa específica (MySQL).
LoadBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    bInfo[id][bID] = id;
    cache_get_value_name_int(0, "character_id", bInfo[id][bOwner]);
    cache_get_value_name(0, "address", bInfo[id][bAddress]);
    cache_get_value_name_int(0, "locked", bInfo[id][bLocked]);
    cache_get_value_name(0, "name", bInfo[id][bName]);
    cache_get_value_name_int(0, "type", bInfo[id][bType]);
    cache_get_value_name_int(0, "inventory", bInfo[id][bInventory]);
    cache_get_value_name_int(0, "storage_money", bInfo[id][bStorageMoney]);
    cache_get_value_name_int(0, "price", bInfo[id][bPrice]);
    cache_get_value_name_float(0, "entry_x", bInfo[id][bEntryPos][0]);
    cache_get_value_name_float(0, "entry_y", bInfo[id][bEntryPos][1]);
    cache_get_value_name_float(0, "entry_z", bInfo[id][bEntryPos][2]);
    cache_get_value_name_float(0, "entry_a", bInfo[id][bEntryPos][3]);
    cache_get_value_name_int(0, "vw_entry", bInfo[id][vwEntry]);
    cache_get_value_name_int(0, "interior_entry", bInfo[id][interiorEntry]);
    cache_get_value_name_float(0, "exit_x", bInfo[id][bExitPos][0]);
    cache_get_value_name_float(0, "exit_y", bInfo[id][bExitPos][1]);
    cache_get_value_name_float(0, "exit_z", bInfo[id][bExitPos][2]);
    cache_get_value_name_float(0, "exit_a", bInfo[id][bExitPos][3]);
    cache_get_value_name_int(0, "vw_exit", bInfo[id][vwExit]);
    cache_get_value_name_int(0, "interior_exit", bInfo[id][interiorExit]);
    return 1;
}

//Salva todas empresas (MySQL).
SaveBusinesss() {
    new savedBusinesss;

    for(new i; i < MAX_BUSINESS; i++) {
        if(!bInfo[i][bID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `character_id` = '%d', `address` = '%e', `locked` = '%d', `name` = '%e', `type` = '%d', `inventory` = '%d', `storage_money` = '%d', \
            `price` = '%d', `entry_x` = '%f', `entry_y` = '%f', `entry_z` = '%f', `entry_a` = '%f', `vw_entry` = '%d', `interior_entry` = '%d', \
            `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `vw_exit` = '%d', \
            `interior_exit` = %d WHERE `id` = %d;", bInfo[i][bOwner], bInfo[i][bAddress], bInfo[i][bLocked], bInfo[i][bName], bInfo[i][bType], bInfo[i][bInventory], bInfo[i][bStorageMoney], 
            bInfo[i][bPrice], bInfo[i][bEntryPos][0], bInfo[i][bEntryPos][1], bInfo[i][bEntryPos][2], bInfo[i][bEntryPos][3], bInfo[i][vwEntry], bInfo[i][interiorEntry],
            bInfo[i][bExitPos][0], bInfo[i][bExitPos][1], bInfo[i][bExitPos][2], bInfo[i][bExitPos][3], bInfo[i][vwExit], 
            bInfo[i][interiorExit], i);
        mysql_query(DBConn, query);

        savedBusinesss++;
    }

    printf("[EMPRESAS]: %d empresas salvas com sucesso.", savedBusinesss);

    return 1;
}

//Salva empresa específica (MySQL).
SaveBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `character_id` = '%d', `address` = '%e', `locked` = '%d', `name` = '%e', `type` = '%d', `inventory` = '%d', `storage_money` = '%d', \
            `price` = '%d', `entry_x` = '%f', `entry_y` = '%f', `entry_z` = '%f', `entry_a` = '%f', `vw_entry` = '%d', `interior_entry` = '%d', \
            `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `vw_exit` = '%d', \
            `interior_exit` = %d WHERE `id` = %d;", bInfo[id][bOwner], bInfo[id][bAddress], bInfo[id][bLocked], bInfo[id][bName], bInfo[id][bType], bInfo[id][bInventory], bInfo[id][bStorageMoney], 
            bInfo[id][bPrice], bInfo[id][bEntryPos][0], bInfo[id][bEntryPos][1], bInfo[id][bEntryPos][2], bInfo[id][bEntryPos][3], bInfo[id][vwEntry], bInfo[id][interiorEntry],
            bInfo[id][bExitPos][0], bInfo[id][bExitPos][1], bInfo[id][bExitPos][2], bInfo[id][bExitPos][3], bInfo[id][vwExit], 
            bInfo[id][interiorExit], id);
    mysql_query(DBConn, query);

    return 1;
}

// Criar empresa (MySQL)
CreateBusiness(playerid, type, price, address[256]) {
    new
       Float:pos[4];

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `business` (`address`, `type`, `price`, `entry_x`, `entry_y`, `entry_z`, `entry_a`, `vw_entry`, `interior_entry`) \
        VALUES ('%s', %d, %d, %f, %f, %f, %f, %d, %d);", address, type, price, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();

    mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `vw_exit` = %d WHERE `id` = %d;", id + 10000, id);
    mysql_query(DBConn, query);

    LoadBusiness(id);

    SendServerMessage(playerid, "Você criou a empresa de ID %d no endereço: '%s' ($%s) (Tipo: %s)", id, bInfo[id][bAddress], FormatNumber(price), BusinessType(id));
    format(logString, sizeof(logString), "%s (%s) criou a empresa de ID %d no endereço: '%s'. ($%s) (tipo: %s)", pNome(playerid), GetPlayerUserEx(playerid), id, address,  FormatNumber(price), BusinessType(id));
	logCreate(playerid, logString, 13);
    return 1;
}

//Deletar/excluir empresa (MySQL)
DeleteBusiness(playerid, id) 
{
    mysql_format(DBConn, query, sizeof query, "DELETE FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    SendServerMessage(playerid, "Você deletou a empresa de ID %d.", id);

    format(logString, sizeof(logString), "%s (%s) deletou a empresa de ID %d. (%s)", pNome(playerid), GetPlayerUserEx(playerid), id, bInfo[id][bAddress]);
	logCreate(playerid, logString, 13);

    new dummyReset[E_BUSINESS_DATA];
    bInfo[id] = dummyReset;
    return 1;
} 

// ============================================================================================================================================
//Verifica se o ID existe empresa (MySQL) - ele retorna false (se o ID não existir).
IsValidBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

// Efetua a validação e/ou verifca o dono.
BusinessHasOwner(id) {
    return IsValidBusiness(id) && (bInfo[id][bOwner]);
}

// Procura por alguma entrada da empresa
GetNearestBusinessEntry(playerid, Float:distance = 1.0) {
    for(new i; i < MAX_BUSINESS; i++) {
        if(!bInfo[i][bID])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, bInfo[i][bEntryPos][0], bInfo[i][bEntryPos][1], bInfo[i][bEntryPos][2]))
            continue;

        if(GetPlayerVirtualWorld(playerid) != bInfo[i][vwEntry] || GetPlayerInterior(playerid) != bInfo[i][interiorEntry])
            continue;

        return i;
    }

    return 0;
}

// Procura por alguma saída da empresa
GetNearestBusinessExit(playerid, Float:distance = 1.0) {
    for(new i; i < MAX_BUSINESS; i++) {
        if(!bInfo[i][bID])
            continue;
        
        if(GetPlayerVirtualWorld(playerid) != bInfo[i][vwExit] || GetPlayerInterior(playerid) != bInfo[i][interiorExit])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, bInfo[i][bExitPos][0], bInfo[i][bExitPos][1], bInfo[i][bExitPos][2]))
            continue;

        return i;
    }

    return 0;
}

//Verifica o endereço da empresa
GetBusinessAddress(id) {
    IsValidBusiness(id);

    new address[256];
    format(address, sizeof(address), "%s", bInfo[id][bAddress]);

    return address;
}

//Tipos de empresa
BusinessType(id) {
	new btype[128];
	switch(bInfo[id][bType]) {
        case 1: format(btype, sizeof(btype), "24/7");
		case 2: format(btype, sizeof(btype), "Ammunation");
		case 3: format(btype, sizeof(btype), "Lojas de roupas");
		case 4: format(btype, sizeof(btype), "Fast Food");
		case 5: format(btype, sizeof(btype), "Concessionária");
		case 6: format(btype, sizeof(btype), "Posto de gasolina");
        case 7: format(btype, sizeof(btype), "Firma");
		default: format(btype, sizeof(btype), "Inválido");
	}
	return btype;
}

// ============================================================================================================================================

//Comprar empresa
BuyBusiness(id, playerid) {
    bInfo[id][bOwner] = pInfo[playerid][pID];
    SaveBusiness(id);

    format(logString, sizeof(logString), "%s (%s) comprou a empresa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(bInfo[id][bPrice]));
	logCreate(playerid, logString, 13);

    return 1;
}

// ============================================================================================================================================