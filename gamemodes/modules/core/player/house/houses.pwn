/*

Este módulo é dedicado à estruturação e 'coração' do sistema de houses, com métodos, funções, criações de tabelas, etc.
É interessante entender que toda função daqui retornará false se não existir uma casa com aquele ID, poupando bastante tempo em outros eventos. 

*/

#include <YSI_Coding\y_hooks>

#define MAX_HOUSES 300

enum House_Data {
    hID,
    hOwner[24],
    hAddress[128],
    
    hMoneyPrice,
    hDefaultMoneyPrice,
    hCashPrice,
    hDefaultCashPrice,
    bool:hSelling,


    Float:hEntryX,
    Float:hEntryY,
    Float:hEntryZ,
    Float:hEntryA,

    Float:hExitX,
    Float:hExitY,
    Float:hExitZ,
    Float:hExitA,

    hVirtualWorld,
    hInterior,

    bool:hLocked,
    
    hPickupID,
    Text3D:h3DTextID
};

new hInfo[MAX_HOUSES][House_Data];


hook OnGameModeInit() {
    new loadedHouses;

    CheckHouseTable();
    for(new i = 1; i < MAX_HOUSES; i++)
        if(LoadHouse(i))
            loadedHouses++;

    printf("[HOUSE] %d casas foram carregadas da database.", loadedHouses);

    return 1;
}

hook OnGameModeExit() {
    new savedHouses;

    for(new i = 1; i < MAX_HOUSES; i++)
        if(SaveHouse(i))
            savedHouses++;

    printf("[HOUSE] %d casas foram salvas na database.", savedHouses);
    return 1;
}

// Checa a tabela e cria, se não existir.

CheckHouseTable() {

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS houses (\
        ID int NOT NULL AUTO_INCREMENT,\
        `owner` varchar(24) NOT NULL DEFAULT 'Nenhum',\
        `address` varchar(128) NOT NULL DEFAULT 'Nenhum',\
        `money_price` int NOT NULL DEFAULT 0,\
        `money_price_default` int NOT NULL DEFAULT 0,\
        `cash_price` int NOT NULL DEFAULT 0,\
        `cash_price_default` int NOT NULL DEFAULT 0,\
        `selling` tinyint(1) NOT NULL DEFAULT 0,\
        `entry_x` float NOT NULL DEFAULT 0,\
        `entry_y` float NOT NULL DEFAULT 0,\
        `entry_z` float NOT NULL DEFAULT 0,\
        `entry_a` float NOT NULL DEFAULT 0,\
        `exit_x` float NOT NULL DEFAULT 0,\
        `exit_y` float NOT NULL DEFAULT 0,\
        `exit_z` float NOT NULL DEFAULT 0,\
        `exit_a` float NOT NULL DEFAULT 0,\
        `virtual_world` int NOT NULL DEFAULT 0,\
        `interior` int NOT NULL DEFAULT 0,\
        `locked` tinyint(1) NOT NULL DEFAULT 0,\
        PRIMARY KEY (ID));");

    return 1;
}

// Carrega a casa por ID e cria os seus 'objetos', ou, PickUP e Text3D

LoadHouse(id) {
    new string[256];

    if(!IsValidHouse(id))
        return 0;

    hInfo[id][hID] = id;
    cache_get_value_name(0, "owner", hInfo[id][hOwner]);
    cache_get_value_name(0, "address", hInfo[id][hAddress]);
    cache_get_value_name_int(0, "money_price", hInfo[id][hMoneyPrice]);
    cache_get_value_name_int(0, "money_price_default", hInfo[id][hDefaultMoneyPrice]);
    cache_get_value_name_int(0, "cash_price", hInfo[id][hCashPrice]);
    cache_get_value_name_int(0, "cash_price_default", hInfo[id][hDefaultCashPrice]);
    cache_get_value_name_bool(0, "selling", hInfo[id][hSelling]);

    cache_get_value_name_float(0, "entry_x", hInfo[id][hEntryX]);
    cache_get_value_name_float(0, "entry_y", hInfo[id][hEntryY]);
    cache_get_value_name_float(0, "entry_z", hInfo[id][hEntryZ]);
    cache_get_value_name_float(0, "entry_a", hInfo[id][hEntryA]);
    cache_get_value_name_float(0, "exit_x", hInfo[id][hExitX]);
    cache_get_value_name_float(0, "exit_y", hInfo[id][hExitY]);
    cache_get_value_name_float(0, "exit_z", hInfo[id][hExitZ]);
    cache_get_value_name_float(0, "exit_a", hInfo[id][hExitA]);

    cache_get_value_name_int(0, "interior", hInfo[id][hInterior]);
    hInfo[id][hVirtualWorld] = id + 50000; // O Virtual World da casa sempre será o ID da casa + 50000

    cache_get_value_name_bool(0, "locked", hInfo[id][hLocked]);

    hInfo[id][hPickupID] = CreateDynamicPickup(1239, 1, hInfo[id][hEntryX], hInfo[id][hEntryY], hInfo[id][hEntryZ], 0, 0);
    format(string, 256, "{34A216}Casa {FFFFFF}(ID: %d)\n{34A216}Dono: {FFFFFF}%s\n{34A216}Disponível: {FFFFFF}%s", 
        id, hInfo[id][hOwner], hInfo[id][hSelling] == true ? ("Sim") : ("Não"));
    hInfo[id][h3DTextID] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, hInfo[id][hEntryX], hInfo[id][hEntryY], hInfo[id][hEntryZ], 10.0);
    
    return 1;
}

// Salva as informações da casa no MySQL.

SaveHouse(id) {
    if(!IsValidHouse(id))
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE houses SET `owner` = '%s', `address` = '%s', \
        `money_price` = %d, `money_price_default` = %d, `cash_price` = %d, `cash_price_default` = %d, `selling` = %d, \
        `entry_x` = %f, `entry_y` = %f, `entry_z` = %f, `entry_a` = %f, `exit_x` = %f, `exit_y` = %f, `exit_z` = %f, `exit_a` = %f, \
        `interior` = %d, `virtual_world` = %d, `locked` = %d WHERE ID = %d;",
        hInfo[id][hOwner], hInfo[id][hAddress], 
        hInfo[id][hMoneyPrice], hInfo[id][hDefaultMoneyPrice], hInfo[id][hCashPrice], hInfo[id][hDefaultCashPrice], hInfo[id][hSelling],
        hInfo[id][hEntryX], hInfo[id][hEntryY], hInfo[id][hEntryZ], hInfo[id][hEntryA], hInfo[id][hExitX], hInfo[id][hExitY], hInfo[id][hExitZ], hInfo[id][hExitA],
        hInfo[id][hInterior], hInfo[id][hVirtualWorld], hInfo[id][hLocked], id);
    mysql_query(DBConn, query);

    return 1;
}

// Recarrega a pickup e Text3D após deletá-las.

ReloadHouse(id) {
    if(!IsValidHouse(id))
        return 0;

    DestroyDynamicPickup(hInfo[id][hPickupID]);
    DestroyDynamic3DTextLabel(hInfo[id][h3DTextID]);

    SaveHouse(id);
    
    return LoadHouse(id);
}

DeleteHouse(id) {
    if(!IsValidHouse(id))
        return 0;

    mysql_format(DBConn, query, sizeof query, "DELETE FROM houses WHERE ID = %d;", id);
    mysql_query(DBConn, query);
    DestroyDynamicPickup(hInfo[id][hPickupID]);
    DestroyDynamic3DTextLabel(hInfo[id][h3DTextID]);
    
    return 1;
}

IsValidHouse(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM houses WHERE ID = '%d';", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}