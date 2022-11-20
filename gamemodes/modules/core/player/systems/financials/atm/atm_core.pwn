//Definição de máximo de "ATM" na cidade.
#define MAX_ATM          1000

//Valores do "data".
enum E_ATM_DATA {
    atmID,             // ID da empresa no MySQL
    atmObject = 2942,  // (Apenas uma varíavel não ultilizavel) - ID do Objeto da ATM (isto para futuras mudanças no quesito ATM - porém já ultilizo para)
    atmInterior,       // Interior da ATM
    atmWorld,          // Mundo da ATM
    bool:Status,       // Ativado/Desativado
    Float:Position[4], // Posições (X, Y, Z, A)
};

//Simplificação dos valores da "data"
new atmInfo[MAX_ATM][E_ATM_DATA];

hook OnGameModeInit() {
    LoadATMS();
    return 1;
}

hook OnGamemodeExit() {
    SaveATMS();
    return 1;
}

//Carrega todas ATMs (MySQL).
LoadATMS() {
    new     
        loadedATMS;

    mysql_query(DBConn, "SELECT * FROM `atm`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        
        atmInfo[id][atmID] = id;
        cache_get_value_name_int(i, "object", atmInfo[id][atmObject]);
        cache_get_value_name_float(i, "position_x", atmInfo[id][Position][0]);
        cache_get_value_name_float(i, "position_y", atmInfo[id][Position][1]);
        cache_get_value_name_float(i, "position_z", atmInfo[id][Position][2]);
        cache_get_value_name_float(i, "position_a", atmInfo[id][Position][3]);
        cache_get_value_name_int(i, "interior", atmInfo[id][atmInterior]);
        cache_get_value_name_int(i, "World", atmInfo[id][atmWorld]);

        loadedATMS++;
    }

    printf("[ATMs]: %d ATMs carregadas com sucesso.", loadedATMS);

    return 1;
}

//Carrega atm específica (MySQL).
LoadATM(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `atm` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    atmInfo[id][bID] = id;
    cache_get_value_name_int(i, "object", atmInfo[id][atmObject]);
    cache_get_value_name_float(i, "entry_x", atmInfo[id][Position][0]);
    cache_get_value_name_float(i, "entry_y", atmInfo[id][Position][1]);
    cache_get_value_name_float(i, "entry_z", atmInfo[id][Position][2]);
    cache_get_value_name_float(i, "entry_a", atmInfo[id][Position][3]);
    cache_get_value_name_int(i, "interior", atmInfo[id][atmInterior]);
    cache_get_value_name_int(i, "World", atmInfo[id][atmWorld]);
    return 1;
}

//Salva todas atms (MySQL).
SaveATMS() {
    new savedATMS;

    for(new i; i < MAX_ATM; i++) {
        if(!atmInfo[i][atmID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `atm` SET `id` = '%d', `pos_x` = '%f', `pos_y` = '%f', `pos_z` = '%f', `pos_a` = '%f', \
            `interior` = '%d', `world` = '%d', `object` = '%d', WHERE `id` = %d;", atmInfo[i][atmID], atmInfo[i][Position][0], atmInfo[i][Position][1], atmInfo[i][Position][2], atmInfo[i][Position][3], 
            atmInfo[i][atmInterior], atmInfo[i][atmWorld], atmInfo[i][atmObject], i);
        mysql_query(DBConn, query);

        //OnRefreshATM(i);
        savedATMS++;
    }

    printf("[ATMs]: %d ATMs salvas com sucesso.", savedATMS);

    return 1;
}

SaveATM(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `atm` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `atm` SET `id` = '%d', `pos_x` = '%f', `pos_y` = '%f', `pos_z` = '%f', `pos_a` = '%f', \
            `interior` = '%d', `world` = '%d', `object` = '%d', WHERE `id` = %d;", atmInfo[id][atmID], atmInfo[i][Position][0], atmInfo[i][Position][1], atmInfo[i][Position][2], atmInfo[i][Position][3], 
            atmInfo[i][atmInterior], atmInfo[i][atmWorld], atmInfo[i][atmObject], i);
    mysql_query(DBConn, query);

    return 1;
}

/* OnRefreshATM(atmID) {
    return 1;   
} */