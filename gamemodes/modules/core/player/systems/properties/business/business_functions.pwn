#include <YSI_Coding\y_hooks>

//=============================================================================================================================================================
//===================================================================[INICIO FUNÇÕES COM SQL]===================================================================
//=============================================================================================================================================================
LoadAllBusiness() { //Carrega todas as empresas do banco de dados
    new     
        loadedBusiness;

    mysql_query(DBConn, "SELECT * FROM `business`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;

        cache_get_value_name_int(i, "id", id);

        BizData[id][bID] = id;

        cache_get_value_name_int(i, "owner_id", BizData[id][bOwner]);
        cache_get_value_name(i, "name", BizData[id][bName]);
        cache_get_value_name(i, "address", BizData[id][bAddress]);
        cache_get_value_name_int(i, "locked", BizData[id][bLocked]);
        cache_get_value_name_int(i, "open", BizData[id][bOpen]);
        cache_get_value_name_int(i, "type", BizData[id][bType]);
        cache_get_value_name_int(i, "products", BizData[id][bProducts]);
        cache_get_value_name_int(i, "price", BizData[id][bPrice]);
        cache_get_value_name_int(i, "value", BizData[id][bValue]);
        cache_get_value_name_int(i, "tax", BizData[id][bTax]);
        cache_get_value_name_int(i, "alarm", BizData[id][bAlarm]);
        cache_get_value_name_int(i, "security", BizData[id][bSecurity]);
        cache_get_value_name_int(i, "blip", BizData[id][bBlip]);
        cache_get_value_name_int(i, "pickup", BizData[id][bPickup]);

        cache_get_value_name_float(i, "enter_x", BizData[id][bEnter][0]);
        cache_get_value_name_float(i, "enter_y", BizData[id][bEnter][1]);
        cache_get_value_name_float(i, "enter_z", BizData[id][bEnter][2]);
        cache_get_value_name_float(i, "enter_a", BizData[id][bEnter][3]);
        cache_get_value_name_float(i, "enter_vw", BizData[id][bEnter][4]);
        cache_get_value_name_float(i, "enter_int", BizData[id][bEnter][5]);

        cache_get_value_name_float(i, "exit_x", BizData[id][bExit][0]);
        cache_get_value_name_float(i, "exit_y", BizData[id][bExit][1]);
        cache_get_value_name_float(i, "exit_z", BizData[id][bExit][2]);
        cache_get_value_name_float(i, "exit_a", BizData[id][bExit][3]);
        cache_get_value_name_float(i, "exit_vw", BizData[id][bExit][4]);
        cache_get_value_name_float(i, "exit_int", BizData[id][bExit][5]);

        cache_get_value_name_float(i, "robbery_x", BizData[id][bRobbery][0]);
        cache_get_value_name_float(i, "robbery_y", BizData[id][bRobbery][1]);
        cache_get_value_name_float(i, "robbery_z", BizData[id][bRobbery][2]);
        cache_get_value_name_float(i, "robbery_a", BizData[id][bRobbery][3]);
        cache_get_value_name_float(i, "robbery_vw", BizData[id][bRobbery][4]);
        cache_get_value_name_float(i, "robbery_int", BizData[id][bRobbery][5]);

        CreateBusinessPickup(id);

        loadedBusiness++;
    }

    printf("[EMPRESAS]: %d empresas carregadas com sucesso.", loadedBusiness);

    return 1;
}

//Carrega uma empresa específica (MySQL).
LoadBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    BizData[id][bID] = id;

    cache_get_value_name_int(0, "owner_id", BizData[id][bOwner]);
    cache_get_value_name(0, "name", BizData[id][bName]);
    cache_get_value_name(0, "address", BizData[id][bAddress]);
    cache_get_value_name_int(0, "locked", BizData[id][bLocked]);
    cache_get_value_name_int(0, "open", BizData[id][bOpen]);
    cache_get_value_name_int(0, "type", BizData[id][bType]);
    cache_get_value_name_int(0, "products", BizData[id][bProducts]);
    cache_get_value_name_int(0, "price", BizData[id][bPrice]);
    cache_get_value_name_int(0, "value", BizData[id][bValue]);
    cache_get_value_name_int(0, "tax", BizData[id][bTax]);
    cache_get_value_name_int(0, "alarm", BizData[id][bAlarm]);
    cache_get_value_name_int(0, "security", BizData[id][bSecurity]);
    cache_get_value_name_int(0, "blip", BizData[id][bBlip]);
    cache_get_value_name_int(0, "pickup", BizData[id][bPickup]);

    cache_get_value_name_float(0, "enter_x", BizData[id][bEnter][0]);
    cache_get_value_name_float(0, "enter_y", BizData[id][bEnter][1]);
    cache_get_value_name_float(0, "enter_z", BizData[id][bEnter][2]);
    cache_get_value_name_float(0, "enter_a", BizData[id][bEnter][3]);
    cache_get_value_name_float(0, "enter_vw", BizData[id][bEnter][4]);
    cache_get_value_name_float(0, "enter_int", BizData[id][bEnter][5]);

    cache_get_value_name_float(0, "exit_x", BizData[id][bExit][0]);
    cache_get_value_name_float(0, "exit_y", BizData[id][bExit][1]);
    cache_get_value_name_float(0, "exit_z", BizData[id][bExit][2]);
    cache_get_value_name_float(0, "exit_a", BizData[id][bExit][3]);
    cache_get_value_name_float(0, "exit_vw", BizData[id][bExit][4]);
    cache_get_value_name_float(0, "exit_int", BizData[id][bExit][5]);

    cache_get_value_name_float(0, "robbery_x", BizData[id][bRobbery][0]);
    cache_get_value_name_float(0, "robbery_y", BizData[id][bRobbery][1]);
    cache_get_value_name_float(0, "robbery_z", BizData[id][bRobbery][2]);
    cache_get_value_name_float(0, "robbery_a", BizData[id][bRobbery][3]);
    cache_get_value_name_float(0, "robbery_vw", BizData[id][bRobbery][4]);
    cache_get_value_name_float(0, "robbery_int", BizData[id][bRobbery][5]);

    CreateBusinessPickup(id);

    return 1;
}

//Salva todas as empresas (MySQL).
SaveAllBusiness() {
    new savedBusinesss;

    for(new i; i < MAX_BUSINESS; i++) {
        if(!BizData[i][bID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `owner_id` = '%d', `name` = '%e', `address` = '%e', `locked` = '%d', `open` = '%d',  `type` = '%d', `products` = '%d', `price` = '%d', \
            `value` = '%d', `tax` = '%d', `alarm` = '%d', `security` = '%d', `blip` = '%d', `pickup` = '%d', \
            `enter_x` = '%f', `enter_y` = '%f', `enter_z` = '%f', `enter_a` = '%f', `enter_vw` = '%f', `enter_int` = '%f', \
            `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `exit_vw` = '%f', `exit_int` = '%f', \
            `robbery_x` = '%f', `robbery_y` = '%f', `robbery_z` = '%f', `robbery_a` = '%f', `robbery_vw` = '%f', \
            `robbery_int` = %f WHERE `id` = %d;", BizData[i][bOwner], BizData[i][bName], BizData[i][bAddress], BizData[i][bLocked], BizData[i][bOpen], BizData[i][bType], BizData[i][bProducts], BizData[i][bPrice],
            BizData[i][bValue], BizData[i][bTax], BizData[i][bAlarm], BizData[i][bSecurity], BizData[i][bBlip], BizData[i][bPickup],
            BizData[i][bEnter][0], BizData[i][bEnter][1], BizData[i][bEnter][2], BizData[i][bEnter][3], BizData[i][bEnter][4], BizData[i][bEnter][5],
            BizData[i][bExit][0], BizData[i][bExit][1], BizData[i][bExit][2], BizData[i][bExit][3], BizData[i][bExit][4], BizData[i][bExit][5],
            BizData[i][bRobbery][0], BizData[i][bRobbery][1], BizData[i][bRobbery][2], BizData[i][bRobbery][3], BizData[i][bRobbery][4],
            BizData[i][bRobbery][5], i);
        mysql_query(DBConn, query);

        savedBusinesss++;
    }

    printf("[EMPRESAS]: %d empresas salvas com sucesso.", savedBusinesss);

    return 1;
}

//Salva a empresa específica (MySQL).
SaveBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `owner_id` = '%d', `name` = '%e', `address` = '%e', `locked` = '%d', `open` = '%d', `type` = '%d', `products` = '%d', `price` = '%d', \
        `value` = '%d', `tax` = '%d', `alarm` = '%d', `security` = '%d', `blip` = '%d', `pickup` = '%d', \
        `enter_x` = '%f', `enter_y` = '%f', `enter_z` = '%f', `enter_a` = '%f', `enter_vw` = '%f', `enter_int` = '%f', \
        `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `exit_vw` = '%f', `exit_int` = '%f', \
        `robbery_x` = '%f', `robbery_y` = '%f', `robbery_z` = '%f', `robbery_a` = '%f', `robbery_vw` = '%f', \
        `robbery_int` = '%f' WHERE `id` = %d;", BizData[id][bOwner], BizData[id][bName], BizData[id][bAddress], BizData[id][bLocked], BizData[id][bOpen], BizData[id][bType], BizData[id][bProducts], BizData[id][bPrice],
        BizData[id][bValue], BizData[id][bTax], BizData[id][bAlarm], BizData[id][bSecurity], BizData[id][bBlip], BizData[id][bPickup],
        BizData[id][bEnter][0], BizData[id][bEnter][1], BizData[id][bEnter][2], BizData[id][bEnter][3], BizData[id][bEnter][4], BizData[id][bEnter][5],
        BizData[id][bExit][0], BizData[id][bExit][1], BizData[id][bExit][2], BizData[id][bExit][3], BizData[id][bExit][4], BizData[id][bExit][5],
        BizData[id][bRobbery][0], BizData[id][bRobbery][1], BizData[id][bRobbery][2], BizData[id][bRobbery][3], BizData[id][bRobbery][4],
        BizData[id][bRobbery][5], id);
    mysql_query(DBConn, query);
    RefreshBusinessPickup(id);
    return 1;
}

// Cria a empresa (MySQL)
CreateBusiness(playerid, type, price, name[256]) {
    new
       Float:pos[4];

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `business` (`name`, `type`, `price`, `enter_x`, `enter_y`, `enter_z`, `enter_a`, `enter_vw`, `enter_int`) \
        VALUES ('%s', %d, %d, %f, %f, %f, %f, %d, %d);", name, type, price, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();

    new vw_id = 20000 + id;

    mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `exit_vw` = '%d' WHERE `id` = %d;", vw_id, id);
    mysql_query(DBConn, query);

    SetBusinessInterior(id);
    LoadBusiness(id);

    SendServerMessage(playerid, "Você criou a empresa: '%s' ($%s) (Tipo: %s) (ID: %d)", BizData[id][bName], FormatNumber(price), GetBusinessType(id), id);
    format(logString, sizeof(logString), "%s (%s) criou a empresa: '%s'. ($%s) (tipo: %s) (id: %d)", pNome(playerid), GetPlayerUserEx(playerid), name,  FormatNumber(price), GetBusinessType(id), id);
	logCreate(playerid, logString, 13);
    return 1;
}

//Deleta/exclui uma empresa por ID (MySQL)
DeleteBusiness(playerid, id)  {
    mysql_format(DBConn, query, sizeof query, "DELETE FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    SendServerMessage(playerid, "Você deletou a empresa de ID %d.", id);

    format(logString, sizeof(logString), "%s (%s) deletou a empresa de ID %d. (%s)", pNome(playerid), GetPlayerUserEx(playerid), id, BizData[id][bName]);
	logCreate(playerid, logString, 13);

    new dummyReset[E_BUSINESS_DATA];
    BizData[id] = dummyReset;
    return 1;
}

CreateBusinessPickup(id)  {
    BizData[id][bPickup] = CreateDynamicPickup(1239, 2, BizData[id][bEnter][0], BizData[id][bEnter][1], BizData[id][bEnter][2], floatround(BizData[id][bEnter][4], floatround_round), floatround(BizData[id][bEnter][5], floatround_round), -1, 20.0);

    return 1;
}

RefreshBusinessPickup(id) {
	if (HasBusiness(id))
	{
		if (IsValidObject(BizData[id][bPickup]))
		    DestroyDynamicPickup(BizData[id][bPickup]);

        CreateBusinessPickup(id);
	}
	return 1;
}
//=============================================================================================================================================================
//===================================================================[FINAL FUNÇÕES COM SQL]===================================================================
//=============================================================================================================================================================
//=============================================================================================================================================================
//===================================================================[CHECAGEM GERAL DAS EMPRESAS]===================================================================
//=============================================================================================================================================================
HasBusiness(id) { //Verifica se a empresa existe
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

HasBusinessOwner(id) { //Verifica se a empresa possui dono
    return HasBusiness(id) && (BizData[id][bOwner]);
}

NearestBusinessEnter(playerid, Float:distance = 1.5) { //Verifica se existe alguma entrada de empresa próxima
    for(new i; i < MAX_BUSINESS; i++) {
        if(!BizData[i][bID])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, BizData[i][bEnter][0], BizData[i][bEnter][1], BizData[i][bEnter][2]))
            continue;

        if(GetPlayerVirtualWorld(playerid) != floatround(BizData[i][bEnter][4], floatround_round) || GetPlayerInterior(playerid) != floatround(BizData[i][bEnter][5], floatround_round))
            continue;

        return i;
    }

    return -1;
}

NearestBusinessExit(playerid, Float:distance = 1.5) { //Verifica se existe alguma saída de empresa próxima
    for(new i; i < MAX_BUSINESS; i++) {
        if(!BizData[i][bID])
            continue;
        
        if(GetPlayerVirtualWorld(playerid) != BizData[i][bExit][4] || GetPlayerInterior(playerid) != BizData[i][bExit][5])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, BizData[i][bExit][0], BizData[i][bExit][1], BizData[i][bExit][2]))
            continue;

        return i;
    }

    return 0;
}

NearestBusinessRobbery(playerid, Float:distance = 1.5) { //Verifica se existe algum ponto de roubo de empresa próxima
    for(new i; i < MAX_BUSINESS; i++) {
        if(!BizData[i][bID])
            continue;
        
        if(GetPlayerVirtualWorld(playerid) != BizData[i][bRobbery][4] || GetPlayerInterior(playerid) != BizData[i][bRobbery][5])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, BizData[i][bRobbery][0], BizData[i][bRobbery][1], BizData[i][bRobbery][2]))
            continue;

        return i;
    }

    return 0;
}

GetBusinessName(id) { //Verifica o nome da empresa
    HasBusiness(id);

    new name[256];
    format(name, sizeof(name), "%s", BizData[id][bName]);

    return name;
}

GetBusinessType(id) {
	new btype[128];
	switch(BizData[id][bType]) {
        case 1: format(btype, sizeof(btype), "24/7");
		case 2: format(btype, sizeof(btype), "Ammunation");
		case 3: format(btype, sizeof(btype), "Loja de Roupas");
		case 4: format(btype, sizeof(btype), "Restaurante");
		case 5: format(btype, sizeof(btype), "Concessionária");
		case 6: format(btype, sizeof(btype), "Posto de Gasolina");
        case 7: format(btype, sizeof(btype), "Bar");
        case 8: format(btype, sizeof(btype), "Boate");
        case 9: format(btype, sizeof(btype), "Mecânica");
        case 10: format(btype, sizeof(btype), "Pawn Shop");
        case 11: format(btype, sizeof(btype), "Escritório");
        case 12: format(btype, sizeof(btype), "Cassino");
		default: format(btype, sizeof(btype), "Nenhum");
	}
	return btype;
}

SetBusinessInterior(businessID) {
    new bint[128];
	switch(BizData[businessID][bType]) {
        case 1: {
        	BizData[businessID][bExit][0] = -25.8473;
        	BizData[businessID][bExit][1] = -188.2483;
        	BizData[businessID][bExit][2] = 1003.5469;
        	BizData[businessID][bExit][3] = 1.1815;
			BizData[businessID][bExit][5] = 17;
        }
        case 2: {
        	BizData[businessID][bExit][0] = 316.3786;
        	BizData[businessID][bExit][1] = -169.8772;
        	BizData[businessID][bExit][2] = 999.6010;
        	BizData[businessID][bExit][3] = 2.0192;
			BizData[businessID][bExit][5] = 6;
        }
        case 3: {
        	BizData[businessID][bExit][0] = 207.6094;
        	BizData[businessID][bExit][1] = -110.7774;
        	BizData[businessID][bExit][2] = 1005.1328;
        	BizData[businessID][bExit][3] = 2.5442;
			BizData[businessID][bExit][5] = 15;
        }
        case 4: {
        	BizData[businessID][bExit][0] = 364.8856;
        	BizData[businessID][bExit][1] = -11.0100;
        	BizData[businessID][bExit][2] = 1001.8516;
        	BizData[businessID][bExit][3] = 1.7608;
			BizData[businessID][bExit][5] = 9;
        }
        case 5: {
        	BizData[businessID][bExit][0] = -2029.8627;
        	BizData[businessID][bExit][1] = -119.2560;
        	BizData[businessID][bExit][2] = 1035.1719;
        	BizData[businessID][bExit][3] = 1.2674;
			BizData[businessID][bExit][5] = 3;
        }
        case 6: {
        	BizData[businessID][bExit][0] = -2029.8627;
        	BizData[businessID][bExit][1] = -119.2560;
        	BizData[businessID][bExit][2] = 1035.1719;
        	BizData[businessID][bExit][3] = 1.2674;
			BizData[businessID][bExit][5] = 3;
        }
        case 7: {
        	BizData[businessID][bExit][0] = -2029.8627;
        	BizData[businessID][bExit][1] = -119.2560;
        	BizData[businessID][bExit][2] = 1035.1719;
        	BizData[businessID][bExit][3] = 1.2674;
			BizData[businessID][bExit][5] = 3;
        }
        case 8: {
        	BizData[businessID][bExit][0] = -2029.8627;
        	BizData[businessID][bExit][1] = -119.2560;
        	BizData[businessID][bExit][2] = 1035.1719;
        	BizData[businessID][bExit][3] = 1.2674;
			BizData[businessID][bExit][5] = 3;
        }
        case 9: {
        	BizData[businessID][bExit][0] = -2029.8627;
        	BizData[businessID][bExit][1] = -119.2560;
        	BizData[businessID][bExit][2] = 1035.1719;
        	BizData[businessID][bExit][3] = 1.2674;
			BizData[businessID][bExit][5] = 3;
        }
        case 10: {
        	BizData[businessID][bExit][0] = -2029.8627;
        	BizData[businessID][bExit][1] = -119.2560;
        	BizData[businessID][bExit][2] = 1035.1719;
        	BizData[businessID][bExit][3] = 1.2674;
			BizData[businessID][bExit][5] = 3;
        }
        case 11: {
        	BizData[businessID][bExit][0] = -2029.8627;
        	BizData[businessID][bExit][1] = -119.2560;
        	BizData[businessID][bExit][2] = 1035.1719;
        	BizData[businessID][bExit][3] = 1.2674;
			BizData[businessID][bExit][5] = 3;
        }
		default: {
            format(bint, sizeof(bint), "Inválido");
        }
	}
	return bint;
}

TeleportToBusiness(playerid, id) {
    if(!BizData[id][bID])
        return SendErrorMessage(playerid, "Não existe nenhuma empresa com este ID.");

    SetPlayerVirtualWorld(playerid, floatround(BizData[id][bEnter][4], floatround_round));
    SetPlayerInterior(playerid, floatround(BizData[id][bEnter][5], floatround_round));
    SetPlayerPos(playerid, BizData[id][bEnter][0], BizData[id][bEnter][1], BizData[id][bEnter][2]);
    SetPlayerFacingAngle(playerid, BizData[id][bEnter][3]);

    SendServerMessage(playerid, "Você teleportou até a empresa de ID %d.", id);
    return 1;
}

IsBusinessInside(playerid) {
    for (new i = 0; i != MAX_BUSINESS; i ++) if (GetPlayerInterior(playerid) == BizData[i][bExit][5] && GetPlayerVirtualWorld(playerid) == BizData[i][bExit][4]) {
	        return i;
	} 
    return -1;
}
//=============================================================================================================================================================
//===================================================================[FINAL CHECAGEM DAS EMPRESAS]===================================================================
//=============================================================================================================================================================
//=============================================================================================================================================================
//===================================================================[INICIO UPDATES ADMIN]===================================================================
//=============================================================================================================================================================
UpdateBusinessEnter(playerid, businessID) { //Altera a posição de entrada da empresa
    GetPlayerPos(playerid, BizData[businessID][bEnter][0], BizData[businessID][bEnter][1], BizData[businessID][bEnter][2]);
    GetPlayerFacingAngle(playerid, BizData[businessID][bEnter][3]);
    BizData[businessID][bEnter][4] = GetPlayerVirtualWorld(playerid);
    BizData[businessID][bEnter][5] = GetPlayerInterior(playerid);
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessExit(playerid, businessID) { //Altera a posição de saida da empresa
    GetPlayerPos(playerid, BizData[businessID][bExit][0], BizData[businessID][bExit][1], BizData[businessID][bExit][2]);
    GetPlayerFacingAngle(playerid, BizData[businessID][bExit][3]);
    BizData[businessID][bExit][5] = GetPlayerInterior(playerid);
    TeleportToBusiness(playerid, businessID);
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessRobbery(playerid, businessID) { //Altera a posição do ponto de roubo da empresa
    GetPlayerPos(playerid, BizData[businessID][bRobbery][0], BizData[businessID][bRobbery][1], BizData[businessID][bRobbery][2]);
    GetPlayerFacingAngle(playerid, BizData[businessID][bRobbery][3]);
    BizData[businessID][bRobbery][5] = GetPlayerInterior(playerid);
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessName(businessID, newName) {
    BizData[businessID][bName] = newName;
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessAddress(businessID, newAddress) {
    BizData[businessID][bAddress] = newAddress;
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessPrice(businessID, newPrice) {
    BizData[businessID][bPrice] = newPrice;
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessType(businessID, newType) {
    BizData[businessID][bType] = newType;
    SetBusinessInterior(businessID); // Seta o interior da empresa + salva os dados.
    return 1;
}

UpdateBusinessAlarm(businessID, newAlarm) {
    BizData[businessID][bAlarm] = newAlarm;
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessSecurity(businessID, newSecurity) {
    BizData[businessID][bSecurity] = newSecurity;
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessBlip(businessID, newBlip) {
    BizData[businessID][bBlip] = newBlip;
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessProducts(businessID, newProducts) {
    BizData[businessID][bProducts] = newProducts;
    SaveBusiness(businessID);
    return 1;
}

UpdateBusinessTax(businessID, newTax) {
    BizData[businessID][bTax] = newTax;
    SaveBusiness(businessID);
    return 1;
}
//=============================================================================================================================================================
//===================================================================[FINAL UPDATES ADMIN]===================================================================
//=============================================================================================================================================================
//=============================================================================================================================================================
//===================================================================[INICIO FUNÇÕES COMPLEMENTARES]===================================================================
//=============================================================================================================================================================
