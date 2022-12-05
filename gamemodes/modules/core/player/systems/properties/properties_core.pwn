#define MAX_INTERIORS          1000

enum E_INTERIORS_DATA {
    iID,                  // ID do interior no MySQL
    iName[256],           // Nome do interior
    bool:iStatus,         // Se está ativo ou desativado (tal interior) - true/false
    iType,                // Tipo do interior (casa [1], empresa [2] e outros [3]))
    iNumber,         // Numero do interior do interior
    Float:iPosition[4],    // Posições (X, Y, Z, A) do interior.
};

new intInfo[MAX_INTERIORS][E_INTERIORS_DATA];

/* (Não esqueça de adicionar isto em mysql_core.pwn)
void:CheckInteriorsTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `interiors` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(256) DEFAULT 'Indefinido',\
    `status` int DEFAULT '0',\
    `type` int DEFAULT '0',\
    `interior` int DEFAULT '0',\
    `int_x` float DEFAULT '0',\
    `int_y` float DEFAULT '0',\
    `int_z` float DEFAULT '0',\
    `int_a` float DEFAULT '0',\
    PRIMARY KEY (`id`));");
    
    print("[DATABASE] Tabela interiors checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela interiors checada com sucesso");
    logCreate(99998, logString, 5);
}
*/

// ============================================================================================================================================
hook OnGameModeInit() {
    LoadInteriors(); //Carrega todos interiores.
    return 1;
}

hook OnGamemodeExit() {
    SaveInteriors(); //Salva todos interiores.
    return 1;
}

// ============================================================================================================================================

//Carrega todas interiores (MySQL).
LoadInteriors() {
    new     
        loadedInteriors;

    mysql_query(DBConn, "SELECT * FROM `interiors`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        intInfo[id][iID] = id;

        cache_get_value_name(i, "name", intInfo[id][iName]);
        cache_get_value_name_int(i, "status", intInfo[id][iStatus]);
        cache_get_value_name_int(i, "type", intInfo[id][iType]);
        cache_get_value_name_int(i, "interior", intInfo[id][iNumber]);
        cache_get_value_name_float(i, "int_x", intInfo[id][iPosition][0]);
        cache_get_value_name_float(i, "int_y", intInfo[id][iPosition][1]);
        cache_get_value_name_float(i, "int_z", intInfo[id][iPosition][2]);
        cache_get_value_name_float(i, "int_a", intInfo[id][iPosition][3]);
        loadedInteriors++;
    }

    printf("[INTERIORES]: %d interiores carregados com sucesso.", loadedInteriors);

    return 1;
}

//Carrega empresa específica (MySQL).
LoadInterior(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `interiors` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    intInfo[id][iID] = id;
    cache_get_value_name(0, "name", intInfo[id][iName]);
    cache_get_value_name_int(0, "status", intInfo[id][iStatus]);
    cache_get_value_name_int(0, "type", intInfo[id][iType]);
    cache_get_value_name_int(0, "interior", intInfo[id][iNumber]);
    cache_get_value_name_float(0, "int_x", intInfo[id][iPosition][0]);
    cache_get_value_name_float(0, "int_y", intInfo[id][iPosition][1]);
    cache_get_value_name_float(0, "int_z", intInfo[id][iPosition][2]);
    cache_get_value_name_float(0, "int_a", intInfo[id][iPosition][3]);
    return 1;
}

//Salva todos interiores (MySQL).
SaveInteriors() {
    new savedInteriors;

    for(new i; i < MAX_INTERIORS; i++) {
        if(!intInfo[i][iID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `name` = '%e', `type` = '%d', `status` = '%d', \
                `interior` = '%d', `int_x` = '%f', `int_y` = '%f', `int_z` = '%f', `int_a` = '%f' WHERE `id` = %d;",  intInfo[i][iName], intInfo[i][iType], intInfo[i][iStatus], 
                intInfo[i][iNumber], intInfo[i][iPosition][0], intInfo[i][iPosition][1], intInfo[i][iPosition][2], intInfo[i][iPosition][3], i);
        mysql_query(DBConn, query);

        savedInteriors++;
    }

    printf("[INTERIORES]: %d interiores salvos com sucesso.", savedInteriors);

    return 1;
}

//Salva interior específica (MySQL).
/*SaveInterior(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `interiors` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `name` = '%e', `type` = '%d', `status` = '%d', \
            `interior` = '%d', `int_x` = '%f', `int_y` = '%f', `int_z` = '%f', `int_a` = '%f' WHERE `id` = %d;",  intInfo[id][iName], intInfo[id][iType], intInfo[id][iStatus], 
            intInfo[id][iNumber], intInfo[id][iPosition][0], intInfo[id][iPosition][1], intInfo[id][iPosition][2], intInfo[id][iPosition][3], id);
    mysql_query(DBConn, query);

    return 1;
} */

//Criar interior (MySQL)
CreateInterior(playerid, type, name[256]) {
    new
       Float:pos[4];

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `interiors` (`name`, `type`, `int_x`, `int_y`, `int_z`, `int_a`, `interior`) \
        VALUES ('%s', %d, %f, %f, %f, %f, %d);", name, type, pos[0], pos[1], pos[2], pos[3], GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();

    LoadInterior(id);

    SendServerMessage(playerid, "Você criou o interior de ID %d de nome: '%s' (Tipo: %s)", id, intInfo[id][iName], InteriorType(id));
    format(logString, sizeof(logString), "%s (%s) criou o interior de ID %d no nome: '%s'. (tipo: %s)", pNome(playerid), GetPlayerUserEx(playerid), id, name, InteriorType(id));
	logCreate(playerid, logString, 13);
    return 1;
}
//Deletar/excluir inteior (MySQL)
DeleteInterior(playerid, id)  {
    mysql_format(DBConn, query, sizeof query, "DELETE FROM `interiors` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    SendServerMessage(playerid, "Você deletou o interior de ID %d.", id);

    format(logString, sizeof(logString), "%s (%s) deletou o interior de ID %d. (%s)", pNome(playerid), GetPlayerUserEx(playerid), id, intInfo[id][iName]);
	logCreate(playerid, logString, 13);

    new dummyReset[E_INTERIORS_DATA];
    intInfo[id] = dummyReset;
    return 1;
} 

//Tipos de interiores
InteriorType(id) {
	new itype[128];
	switch(intInfo[id][iType]) {
        case 1: format(itype, sizeof(itype), "Casa");
		case 2: format(itype, sizeof(itype), "Empresa");
		case 3: format(itype, sizeof(itype), "Outros");
		default: format(itype, sizeof(itype), "Inválido");
	}
	return itype;
}

//Verifica se o ID existe o interior (MySQL) - ele retorna false (se o ID não existir).
IsValidInterior(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `interiors` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

// ============================================================================================================================================

EntryProperty(playerid, vwExitProperty, interiorExitProperty, Float:exitPos0, Float:exitPos1, Float:exitPos2, Float:exitPos3) {

    SetPlayerVirtualWorld(playerid, vwExitProperty);
    SetPlayerInterior(playerid, interiorExitProperty);
    SetPlayerPos(playerid, exitPos0, exitPos1, exitPos2);
    SetPlayerFacingAngle(playerid, exitPos3);

    return 1;
}

ExitProperty(playerid, vwEntryProperty, interiorEntryProperty, Float:entryPos0, Float:entryPos1, Float:entryPos2, Float:entryPos3) {

    SetPlayerVirtualWorld(playerid, vwEntryProperty);
    SetPlayerInterior(playerid, interiorEntryProperty);
    SetPlayerPos(playerid, entryPos0, entryPos1, entryPos2);
    SetPlayerFacingAngle(playerid, entryPos3);
    
    return 1;
}

BuyProperty(playerid, propertyId, propertyType) {

    if(propertyType == 1) {
        hInfo[propertyId][hOwner] = pInfo[playerid][pID];
        SaveHouse(propertyId);
        format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
    
        return 1;
    }

    if(propertyType == 2) {
        bInfo[propertyId][bOwner] = pInfo[playerid][pID];
        SaveBusiness(propertyId);

        format(logString, sizeof(logString), "%s (%s) comprou a empresa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 13);

        return 1;
    }

	logCreate(playerid, logString, 13);

    return 1;
}

LockProperty(playerid, propertyId, propertyType) {

    if(propertyType == 1) {
        hInfo[propertyId][hLocked] = !hInfo[propertyId][hLocked];
        SaveHouse(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, hInfo[propertyId][hLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    if(propertyType == 2) {
        bInfo[propertyId][bLocked] = !bInfo[propertyId][bLocked];
        SaveBusiness(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, bInfo[propertyId][bLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    return 1;
}
