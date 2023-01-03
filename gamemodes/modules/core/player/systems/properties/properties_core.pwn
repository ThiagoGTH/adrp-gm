#define MAX_INTERIORS          1000

enum E_INTERIORS_DATA {
    iID,                  // ID do interior no MySQL
    iName[256],           // Nome do interior
    bool:iStatus,         // Se está ativo ou desativado (tal interior) - true/false
    iType,                // Tipo do interior (casa [1], empresa [2] e outros [3]))
    iInterior,         // Numero do interior do interior
    iWorld,
    Float:iPosition[4],    // Posições (X, Y, Z, A) do interior.
};

new intInfo[MAX_INTERIORS][E_INTERIORS_DATA];

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
        cache_get_value_name_int(i, "interior", intInfo[id][iInterior]);
        cache_get_value_name_int(i, "world", intInfo[id][iWorld]);
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
    cache_get_value_name_int(0, "interior", intInfo[id][iInterior]);
    cache_get_value_name_int(0, "world", intInfo[id][iWorld]);
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
                `interior` = '%d', `world` = '%d', `int_x` = '%f', `int_y` = '%f', `int_z` = '%f', `int_a` = '%f' WHERE `id` = %d;",  intInfo[i][iName], intInfo[i][iType], intInfo[i][iStatus], 
                intInfo[i][iInterior], intInfo[i][iWorld], intInfo[i][iPosition][0], intInfo[i][iPosition][1], intInfo[i][iPosition][2], intInfo[i][iPosition][3], i);
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
            `interior` = '%d', `world` = '%d', `int_x` = '%f', `int_y` = '%f', `int_z` = '%f', `int_a` = '%f' WHERE `id` = %d;",  intInfo[id][iName], intInfo[id][iType], intInfo[id][iStatus], 
            intInfo[id][iInterior], intInfo[id][iWorld], intInfo[id][iPosition][0], intInfo[id][iPosition][1], intInfo[id][iPosition][2], intInfo[id][iPosition][3], id);
    mysql_query(DBConn, query);

    return 1;
} */

//Criar interior (MySQL)
CreateInterior(playerid, type, name[256]) {
    new
       Float:pos[4];

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `interiors` (`name`, `type`, `int_x`, `int_y`, `int_z`, `int_a`, `interior`, `world`) \
        VALUES ('%s', %d, %f, %f, %f, %f, %d, %d);", name, type, pos[0], pos[1], pos[2], pos[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
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
//Função (mostra a dialog de inteiores "custom").
ShowInteriors(playerid) {
    Dialog_Show(playerid, InteriorsType, DIALOG_STYLE_LIST, "Interiores", "Casa\nEmpresa\nOutros", "Selecionar", "Voltar");
    return 1;
}

//Resposta do dialog da função ShowInteriors.
Dialog:InteriorsType(playerid, response, listitem, inputtext[]){
	if(response){
		if(listitem == 0){
		    ShowInteriorsHouse(playerid);
		}
        else if(listitem == 1){
		    ShowInteriorsBussines(playerid);
		}
        else if(listitem == 2){
		    ShowInteriorsOthers(playerid);
		}
	} 
	return true;
}

//Função de interiores (house)
ShowInteriorsHouse(playerid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors WHERE `type` = 1");
    new Cache:result = mysql_query(DBConn, query);

    new string[1024], int_id, int_name[24];
    format(string, sizeof(string), "ID\tNome\n");
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name_int(i, "id", int_id);
        cache_get_value_name(i, "name", int_name);

        format(string, sizeof(string), "%s%d\t%s\n", string, int_id, int_name);
    }
    cache_delete(result);

    Dialog_Show(playerid, TeleportCustom, DIALOG_STYLE_TABLIST_HEADERS, "Ir > Interiores Personlizados > Casa", string, "Selecionar", "<<");
    return true;
}

//Função de interiores (Bussines)
ShowInteriorsBussines(playerid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors WHERE `type` = 2");
    new Cache:result = mysql_query(DBConn, query);

    new string[1024], int_id, int_name[24];
    format(string, sizeof(string), "ID\tNome\n");
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name_int(i, "id", int_id);
        cache_get_value_name(i, "name", int_name);

        format(string, sizeof(string), "%s%d\t%s\n", string, int_id, int_name);
    }
    cache_delete(result);

    Dialog_Show(playerid, TeleportCustom, DIALOG_STYLE_TABLIST_HEADERS, "Ir > Interiores Personlizados > Empresa", string, "Selecionar", "<<");
    return true;
}

//Função de interiores (Others)
ShowInteriorsOthers(playerid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors WHERE `type` = 3");
    new Cache:result = mysql_query(DBConn, query);

    new string[1024], int_id, int_name[24];
    format(string, sizeof(string), "ID\tNome\n");
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name_int(i, "id", int_id);
        cache_get_value_name(i, "name", int_name);

        format(string, sizeof(string), "%s%d\t%s\n", string, int_id, int_name);
    }
    cache_delete(result);

    Dialog_Show(playerid, TeleportCustom, DIALOG_STYLE_TABLIST_HEADERS, "Ir > Interiores Personlizados > Outros", string, "Selecionar", "<<");
    return true;
}

//Função para se telesportar (a um interior personalizado).   
Dialog:TeleportCustom(playerid, response, listitem, inputtext[]){
    if(response) {
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors WHERE `id` = '%s'", inputtext);
        new Cache:result = mysql_query(DBConn, query);

        new Float:pos[4], vw, int;
        cache_get_value_name_float(0, "int_x", pos[0]);
		cache_get_value_name_float(0, "int_y", pos[1]);
		cache_get_value_name_float(0, "int_z", pos[2]);
		cache_get_value_name_float(0, "int_a", pos[3]);
		cache_get_value_name_int(0, "interior", int);
    	cache_get_value_name_int(0, "world", vw);
        cache_delete(result);

		SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		SetPlayerFacingAngle(playerid, pos[3]);
		SetPlayerInterior(playerid, int);
		SetPlayerVirtualWorld(playerid, vw);

        SendServerMessage(playerid, "Você se teleportou para o interior ID: '%s'.", inputtext);
    }
    if(!response) {
        ShowInteriors(playerid);
    }
    return 1;
} 
// ============================================================================================================================================
EnterProperty(playerid, vwExitProperty, interiorExitProperty, Float:exitPos0, Float:exitPos1, Float:exitPos2, Float:exitPos3, bool:isGarage) {
    if(IsPlayerInAnyVehicle(playerid) && isGarage) {
        new vehicleid = GetPlayerVehicleID(playerid);

        SetVehiclePos(vehicleid, exitPos0, exitPos1, exitPos2 - 1);
        SetVehicleZAngle(vehicleid, exitPos3);
        LinkVehicleToInterior(vehicleid, interiorExitProperty);
        SetVehicleVirtualWorld(vehicleid, vwExitProperty);

        foreach(new passenger : Player) {
            if(passenger != playerid) {
                if(IsPlayerInVehicle(passenger, vehicleid)) {
                    SetPlayerVirtualWorld(passenger, vwExitProperty);
                    SetPlayerInterior(passenger, interiorExitProperty);
                }
            }
        }
    } else {
        SetPlayerPos(playerid, exitPos0, exitPos1, exitPos2);
        SetPlayerFacingAngle(playerid, exitPos0);
    }
    
    SetPlayerVirtualWorld(playerid, vwExitProperty);
    SetPlayerInterior(playerid, interiorExitProperty);
    SetCameraBehindPlayer(playerid);

    return 1;
}

ExitProperty(playerid, vwEntryProperty, interiorEntryProperty, Float:entryPos0, Float:entryPos1, Float:entryPos2, Float:entryPos3, bool:isGarage) {
    if(IsPlayerInAnyVehicle(playerid) && isGarage) {
        new vehicleid = GetPlayerVehicleID(playerid);

        SetVehiclePos(vehicleid, entryPos0, entryPos1, entryPos2 + 5);
        SetVehicleZAngle(vehicleid, entryPos3);
        LinkVehicleToInterior(vehicleid, interiorEntryProperty);
        SetVehicleVirtualWorld(vehicleid, vwEntryProperty);

        foreach(new passenger : Player) {
            if(passenger != playerid) {
                if(IsPlayerInVehicle(passenger, vehicleid)) {
                    SetPlayerVirtualWorld(passenger, vwEntryProperty);
                    SetPlayerInterior(passenger, interiorEntryProperty);
                }
            }
        }
    } else {
        SetPlayerPos(playerid, entryPos0, entryPos1, entryPos2);
        SetPlayerFacingAngle(playerid, entryPos2);
    }

    SetPlayerVirtualWorld(playerid, vwEntryProperty);
    SetPlayerInterior(playerid, interiorEntryProperty);
    SetCameraBehindPlayer(playerid);

    return 1;
}

BuyProperty(playerid, propertyId, propertyType) {

    if(propertyType == 1) {
        new garageId;

        garageId = hInfo[propertyId][hGarage];

        if(garageId > 0) {
            if(GarageHasOwner(garageId)){
                hInfo[propertyId][hOwner] = pInfo[playerid][pID];
                va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(propertyId));
                SaveHouse(propertyId);

                format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
                logCreate(playerid, logString, 13);

                return 1;
            }
            hInfo[propertyId][hOwner] = pInfo[playerid][pID];
            SaveHouse(propertyId);

            printf("Antigo dono da garagem ID %d é o ID %d.", garageId, gInfo[garageId][gOwner]);
            gInfo[garageId][gOwner] = hInfo[propertyId][hOwner];
            SaveGarage(garageId);
            printf("Novo dono da garagem ID %d é o ID %d.", garageId, gInfo[garageId][gOwner]);

            format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s e junto dela, a garagem ID %d.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]), garageId);
            logCreate(playerid, logString, 13);
            logCreate(playerid, logString, 25);

            va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(propertyId));
            va_SendClientMessage(playerid, COLOR_YELLOW, "Junto da sua casa nova, no mesmo endereço, você também adquiriu a garagem dela.");

            return 1;
        } else {
            hInfo[propertyId][hOwner] = pInfo[playerid][pID];
            SaveHouse(propertyId);
            va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a casa no endereço %s.", GetHouseAddress(propertyId));

            format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
            logCreate(playerid, logString, 13);

            return 1;

        }
    }

    if(propertyType == 2) {
        bInfo[propertyId][bOwner] = pInfo[playerid][pID];
        SaveBusiness(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a empresa no endereço %s.", GetBusinessAddress(propertyId));

        format(logString, sizeof(logString), "%s (%s) comprou a empresa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 24);

        return 1;
    }

    if(propertyType == 3) {
        gInfo[propertyId][gOwner] = pInfo[playerid][pID];
        SaveGarage(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a garagem no endereço %s.", GetGarageAddress(propertyId));


        format(logString, sizeof(logString), "%s (%s) comprou a gargem ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 25);

        return 1;
    }

    return 1;
}


AdminSellProperty(playerid, propertyId, propertyType) {

    if(propertyType == 1) {
        new garageId;

        garageId = hInfo[propertyId][hGarage];

        if(hInfo[propertyId][hOwner] == 0)
            return SendErrorMessage(playerid, "Essa propriedade já está à venda. (/propinfo)");

        if(garageId > 0) {
            if(GarageHasOwner(garageId)){
                hInfo[propertyId][hOwner] = 0;
                va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a casa no endereço %s a venda.", GetHouseAddress(propertyId));
                SaveHouse(propertyId);

                format(logString, sizeof(logString), "%s (%s) colocou a casa ID %d a venda por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
                logCreate(playerid, logString, 13);

                return 1;
            }
            hInfo[propertyId][hOwner] = 0;
            SaveHouse(propertyId);

            // debug 
            printf("Antigo dono da garagem ID %d é o ID %d.", garageId, gInfo[garageId][gOwner]);

            gInfo[garageId][gOwner] = 0;
            SaveGarage(garageId);

            //debug
            printf("Novo dono da garagem ID %d é o ID %d.", garageId, gInfo[garageId][gOwner]);

            format(logString, sizeof(logString), "%s (%s) colocou a casa ID %d a venda por $%s e junto dela, a garagem ID %d.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]), garageId);
            logCreate(playerid, logString, 13);
            logCreate(playerid, logString, 25);

            va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a casa e garagem no endereço %s a venda.", GetHouseAddress(propertyId));

            return 1;
        } else {
            hInfo[propertyId][hOwner] = 0;
            SaveHouse(propertyId);
            va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a casa no endereço %s a venda.", GetHouseAddress(propertyId));

            format(logString, sizeof(logString), "%s (%s) colocou a casa ID %d a venda por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(hInfo[propertyId][hPrice]));
            logCreate(playerid, logString, 13);

            return 1;

        }
    }

    if(propertyType == 2) {
        if(bInfo[propertyId][bOwner] == 0)
            return SendErrorMessage(playerid, "Essa propriedade já está à venda. (/propinfo)");

        bInfo[propertyId][bOwner] = 0;
        SaveBusiness(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a empresa no endereço %s a venda.", GetBusinessAddress(propertyId));

        format(logString, sizeof(logString), "%s (%s) colocou a empresa ID %d a venda por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 24);

        return 1;
    }

    if(propertyType == 3) {
        if(gInfo[propertyId][gOwner] == 0)
            return SendErrorMessage(playerid, "Essa propriedade já está à venda. (/propinfo)");
            
        gInfo[propertyId][gOwner] = 0;
        SaveGarage(propertyId);
        va_SendClientMessage(playerid, COLOR_YELLOW, "Você colocou a garagem no endereço %s a venda.", GetGarageAddress(propertyId));

        format(logString, sizeof(logString), "%s (%s) colocou a garagem ID %d a venda por $%s.", pNome(playerid), GetPlayerUserEx(playerid), propertyId, FormatNumber(bInfo[propertyId][bPrice]));
        logCreate(playerid, logString, 25);

        return 1;
    }

    return 1;
}

LockProperty(playerid, propertyId, propertyType) {

    // house
    if(propertyType == 1) {
        hInfo[propertyId][hLocked] = !hInfo[propertyId][hLocked];
        SaveHouse(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, hInfo[propertyId][hLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    // business
    if(propertyType == 2) {
        bInfo[propertyId][bLocked] = !bInfo[propertyId][bLocked];
        SaveBusiness(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, bInfo[propertyId][bLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    // garage
    if(propertyType == 3) {
        gInfo[propertyId][gLocked] = !gInfo[propertyId][gLocked];
        SaveBusiness(propertyId);

        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, gInfo[propertyId][gLocked] ? "~r~PROPRIEDADE TRANCADA" : "~g~~h~PROPRIEDADE DESTRANCADA", 2500, 4);
    
        return 1;
    }

    return 1;
}

NearbyProperty(playerid) {
    static 
        id = -1;

    if ((id = GetNearestHouseEntry(playerid)) != -1)
        return SendServerMessage(playerid, "[House Near] a mais próxima é ID: %d.", id);
    if ((id = GetNearestBusinessEntry(playerid)) != -1)
        return SendServerMessage(playerid, "[Business Near] a mais próxima é ID: %d.", id);
    if ((id = GetNearestGarageEntry(playerid)) != -1)
        return SendServerMessage(playerid, "[Garage Near] a mais próxima é ID: %d.", id);
    return 1;
}