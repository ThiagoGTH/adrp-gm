#include <YSI_Coding\y_hooks>

VehicleCreate(ownerid, modelid, Float:x, Float:y, Float:z, Float:a, color1, color2, plate[], insurance = 0, sunpass = 0, alarm = 0, faction = 0, business = 0, job = 0) {
    new Cache:result;
    for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) {
        if (!vInfo[i][vExists]) {
            if (color1 == -1)
   		        color1 = random(127);

			if (color2 == -1)
			    color2 = random(127);

            vInfo[i][vExists] = true;
            vInfo[i][vOwner] = ownerid;
            vInfo[i][vModel] = modelid;

            vInfo[i][vColor1] = color1;
            vInfo[i][vColor2] = color2;

            vInfo[i][vPos][0] = x;
            vInfo[i][vPos][1] = y;
            vInfo[i][vPos][2] = z;
            vInfo[i][vPos][3] = a;

            vInfo[i][vInsurance] = insurance;
            vInfo[i][vSunpass] = sunpass;
            vInfo[i][vAlarm] = alarm;
            vInfo[i][vFuel] = 50.00;

            vInfo[i][vFaction] = faction;
            vInfo[i][vBusiness] = business;
            vInfo[i][vJob] = job;
            
            if(!strcmp(plate, "Invalid", true)){
                vInfo[i][vLegal] = 0;
                new platestring[128];
                format(platestring, 128, " ");
                SetVehicleNumberPlate(vInfo[i][vVehicle], platestring);
            } else {
                vInfo[i][vLegal] = 1;
                format(vInfo[i][vPlate], 128, "%s", plate);
                SetVehicleNumberPlate(vInfo[i][vVehicle], vInfo[i][vPlate]);
            }
            
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles (`character_id`) VALUES ('%d');", ownerid);
            result = mysql_query(DBConn, query);
            new id = cache_insert_id();
            cache_delete(result);
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_stats (`vehicle_id`) VALUES ('%d');", id);
            result = mysql_query(DBConn, query);
            cache_delete(result);
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_objects (`vehicle_id`) VALUES ('%d');", id);
            result = mysql_query(DBConn, query);
            cache_delete(result);
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_tunings (`vehicle_id`) VALUES ('%d');", id);
            result = mysql_query(DBConn, query);
            cache_delete(result);
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_weapons (`vehicle_id`) VALUES ('%d');", id);
            result = mysql_query(DBConn, query);
            cache_delete(result);

            vInfo[i][vID] = id;

            /*vInfo[i][vVehicle] =  CreateVehicle(vInfo[i][vModel], 
            vInfo[i][vPos][0], vInfo[i][vPos][1], vInfo[i][vPos][2], vInfo[i][vPos][3], 
            vInfo[i][vColor1], vInfo[i][vColor2], -1, false);*/

            LinkVehicleToInterior(vInfo[i][vVehicle], vInfo[i][vInterior]);
            SetVehicleVirtualWorld(vInfo[i][vVehicle], vInfo[i][vVW]);
            SetVehicleNumberPlate(vInfo[i][vVehicle], vInfo[i][vPlate]);

            SaveVehicle(i);
            LoadVehicle(vInfo[i][vID]);
            return i;
        }
    }
    return -1;
}

SaveVehicle(vehicleid) {
    new Cache:result;
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles` WHERE `id` = '%d';", vInfo[vehicleid][vID]);
    result = mysql_query(DBConn, query);

    printf("SELECT * FROM `vehicles` WHERE `id` = '%d';", vInfo[vehicleid][vID]);

    if(!cache_num_rows())return false;

        
    mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles` SET \
    `model` = '%d',                 \
    `character_id` = '%d',          \
    `faction` = '%d',               \
    `business` = '%d',              \
    `job` = '%d',                   \
    `name` = '%s',                  \
    `personalized_name` = '%d',     \
    `legalized` = '%d',             \
    `plate` = '%s',                 \
    `personalized_plate` = '%d',    \
    `locked` = '%d',                \
    `color1` = '%d',                \
    `color2` = '%d',                \
    `paintjob` = '%d',              \
    `position_X` = '%f',            \
    `position_Y` = '%f',            \
    `position_Z` = '%f',            \
    `position_A` = '%f',            \
    `virtual_world` = '%d',         \
    `interior` = '%d',              \
    `impounded` = '%d',             \
    `impounded_price` = '%d',       \
    `impounded_reason` = '%s'       \
    WHERE `id` = '%d';", 
    vInfo[vehicleid][vModel],
    vInfo[vehicleid][vOwner],
    vInfo[vehicleid][vFaction],
    vInfo[vehicleid][vBusiness],
    vInfo[vehicleid][vJob],
    vInfo[vehicleid][vName],
    vInfo[vehicleid][vNamePersonalized],
    vInfo[vehicleid][vLegal],
    vInfo[vehicleid][vPlate],
    vInfo[vehicleid][vPlatePersonalized],
    vInfo[vehicleid][vLocked],
    vInfo[vehicleid][vColor1],
    vInfo[vehicleid][vColor2],
    vInfo[vehicleid][vPaintjob],
    vInfo[vehicleid][vPos][0],
    vInfo[vehicleid][vPos][1],
    vInfo[vehicleid][vPos][2],
    vInfo[vehicleid][vPos][3],
    vInfo[vehicleid][vVW],
    vInfo[vehicleid][vInterior],
    vInfo[vehicleid][vImpounded],
    vInfo[vehicleid][vImpoundedPrice],
    vInfo[vehicleid][vImpoundedReason],
    vInfo[vehicleid][vID]);
    result = mysql_query(DBConn, query);
    cache_delete(result);

    mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_stats` SET \
    `insurance` = '%d',                 \
    `sunpass` = '%d',                   \
    `alarm` = '%d',                     \
    `fuel` = '%f',                      \
    `health` = '%f',                    \
    `battery` = '%f',                   \
    `engine` = '%f',                    \
    `miles` = '%f'                      \
    WHERE `vehicle_id` = '%d';",
    vInfo[vehicleid][vInsurance],
    vInfo[vehicleid][vSunpass],
    vInfo[vehicleid][vAlarm],
    vInfo[vehicleid][vFuel],
    vInfo[vehicleid][vHealth],
    vInfo[vehicleid][vBattery],
	vInfo[vehicleid][vEngine],
    vInfo[vehicleid][vMiles],
    vInfo[vehicleid][vID]);
    result = mysql_query(DBConn, query);
    cache_delete(result);

    for (new o = 0; o < 5; o++) {
        mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_objects` SET \
        `object_%d` = '%d', \
        `ofX_%d` = '%f', \
        `ofY_%d` = '%f', \
        `ofZ_%d` = '%f', \
        `rX_%d` = '%f', \
        `rY_%d` = '%f', \
        `rZ_%d` = '%f' \
        WHERE `vehicle_id` = '%d'",
        o + 1, vInfo[vehicleid][vObject][o],
        o + 1, vInfo[vehicleid][vObjectPosX][o],
        o + 1, vInfo[vehicleid][vObjectPosY][o],
        o + 1, vInfo[vehicleid][vObjectPosZ][o],
        o + 1, vInfo[vehicleid][vObjectRotX][o],
        o + 1, vInfo[vehicleid][vObjectRotY][o],
        o + 1, vInfo[vehicleid][vObjectRotZ][o],
        vInfo[vehicleid][vID]);
        result = mysql_query(DBConn, query);
        printf("o + 1, vInfo[vehicleid][vObject][o] = %d", vInfo[vehicleid][vObject][o]);
    }
    cache_delete(result);

    for (new m = 0; m < 17; m ++) {
        mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_tunings` SET `mod%d` = '%d' WHERE `vehicle_id` = '%d'", m + 1, vInfo[vehicleid][vMods][m], vInfo[vehicleid][vID]);
        result = mysql_query(DBConn, query);
	}
    cache_delete(result);

    for (new w = 0; w < 30; w ++) {
        mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_weapons` SET \
        `weapon%d` = '%d', \
        `ammo%d` = '%d', \
        `weapon_type%d` = '%d' \
        WHERE `vehicle_id` = '%d'", 
        w + 1, vInfo[vehicleid][vWeapons][w], 
        w + 1, vInfo[vehicleid][vAmmo][w], 
        w + 1, vInfo[vehicleid][vWeaponsType][w], vInfo[vehicleid][vID]);
        result = mysql_query(DBConn, query);
	}
    cache_delete(result);
    return true;
}

SpawnVehicle(vehicleid) {
    if (vehicleid != -1 && vInfo[vehicleid][vExists]){
        new string[128];
        if (IsValidVehicle(vInfo[vehicleid][vVehicle]))
		    DestroyVehicle(vInfo[vehicleid][vVehicle]);

        ResetVehicleObjects(vehicleid);

        if (vInfo[vehicleid][vColor1] == -1)
		    vInfo[vehicleid][vColor1] = random(127);

		if (vInfo[vehicleid][vColor2] == -1)
		    vInfo[vehicleid][vColor2] = random(127);

        vInfo[vehicleid][vVehicle] =  CreateVehicle(vInfo[vehicleid][vModel], 
        vInfo[vehicleid][vPos][0], vInfo[vehicleid][vPos][1], vInfo[vehicleid][vPos][2], vInfo[vehicleid][vPos][3], 
        vInfo[vehicleid][vColor1], vInfo[vehicleid][vColor2], -1, false);

        LinkVehicleToInterior(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vInterior]);
        SetVehicleVirtualWorld(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vVW]);
        if(!strcmp(vInfo[vehicleid][vPlate], "Invalid", true)) format(string, sizeof(string), " ");
        else format(string, sizeof(string), "%s", vInfo[vehicleid][vPlate]);

        SetVehicleNumberPlate(vInfo[vehicleid][vVehicle], string);
        SetVehicleParamsEx(vInfo[vehicleid][vVehicle], false, false, false, vInfo[vehicleid][vLocked], false, false, false);
    }
}

LoadVehicles() {
    new loadedVehicles;
    mysql_query(DBConn, "SELECT * FROM `vehicles` WHERE (`faction` != '0' OR `business` != '0' OR `job` != '0') AND `model` > '0';");

    for (new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "ID", id);

        if (vInfo[id][vExists]) return false;

        vInfo[id][vID] = id;
        vInfo[id][vExists] = true;
        cache_get_value_name_int(i, "model", vInfo[id][vModel]);
        cache_get_value_name_int(i, "character_id", vInfo[id][vOwner]);

        cache_get_value_name_int(i, "faction", vInfo[id][vFaction]);
        cache_get_value_name_int(i, "business", vInfo[id][vBusiness]);
        cache_get_value_name_int(i, "job", vInfo[id][vJob]);

        cache_get_value_name(i, "name", vInfo[id][vName]);
        cache_get_value_name_int(i, "personalized_name", vInfo[id][vNamePersonalized]);

        cache_get_value_name_int(i, "legalized", vInfo[id][vLegal]);

        cache_get_value_name(i, "plate", vInfo[id][vPlate]);
        cache_get_value_name_int(i, "personalized_plate", vInfo[id][vPlatePersonalized]);

        cache_get_value_name_int(i, "locked", vInfo[id][vLocked]);

        cache_get_value_name_int(i, "color1", vInfo[id][vColor1]);
        cache_get_value_name_int(i, "color2", vInfo[id][vColor2]);
        cache_get_value_name_int(i, "paintjob", vInfo[id][vPaintjob]);

        cache_get_value_name_float(i, "position_X", vInfo[id][vPos][0]);
        cache_get_value_name_float(i, "position_Y", vInfo[id][vPos][1]);
        cache_get_value_name_float(i, "position_Z", vInfo[id][vPos][2]);
        cache_get_value_name_float(i, "position_A", vInfo[id][vPos][3]);

        cache_get_value_name_int(i, "virtual_world", vInfo[id][vVW]);
        cache_get_value_name_int(i, "interior", vInfo[id][vInterior]);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_stats` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleStats", "d", id);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_objects` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleObjects", "d", id);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_tunings` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleTuning", "d", id);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleWeapons", "d", id);

        SpawnVehicle(id);
        //SetVehicleObject(id);
        //ModVehicle(id);
        loadedVehicles++;
    }
    printf("[VEÍCULOS]: %d veículos carregados com sucesso.", loadedVehicles);
    return true;
}

LoadVehicle(vehicleid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles` WHERE `ID` = '%d';", vehicleid);
    mysql_query(DBConn, query);
    if (vInfo[vehicleid][vExists]) return false;

    vInfo[vehicleid][vExists] = true;
    cache_get_value_name_int(0, "ID", vInfo[vehicleid][vID]);
    cache_get_value_name_int(0, "model", vInfo[vehicleid][vModel]);
    cache_get_value_name_int(0, "character_id", vInfo[vehicleid][vOwner]);

    cache_get_value_name_int(0, "faction", vInfo[vehicleid][vFaction]);
    cache_get_value_name_int(0, "business", vInfo[vehicleid][vBusiness]);
    cache_get_value_name_int(0, "job", vInfo[vehicleid][vJob]);

    cache_get_value_name(0, "name", vInfo[vehicleid][vName]);
    cache_get_value_name_int(0, "personalized_name", vInfo[vehicleid][vNamePersonalized]);

    cache_get_value_name_int(0, "legalized", vInfo[vehicleid][vLegal]);

    cache_get_value_name(0, "plate", vInfo[vehicleid][vPlate]);
    cache_get_value_name_int(0, "personalized_plate", vInfo[vehicleid][vPlatePersonalized]);

    cache_get_value_name_int(0, "locked", vInfo[vehicleid][vLocked]);

    cache_get_value_name_int(0, "color1", vInfo[vehicleid][vColor1]);
    cache_get_value_name_int(0, "color2", vInfo[vehicleid][vColor2]);
    cache_get_value_name_int(0, "paintjob", vInfo[vehicleid][vPaintjob]);

    cache_get_value_name_float(0, "position_X", vInfo[vehicleid][vPos][0]);
    cache_get_value_name_float(0, "position_Y", vInfo[vehicleid][vPos][1]);
    cache_get_value_name_float(0, "position_Z", vInfo[vehicleid][vPos][2]);
    cache_get_value_name_float(0, "position_A", vInfo[vehicleid][vPos][3]);

    cache_get_value_name_int(0, "virtual_world", vInfo[vehicleid][vVW]);
    cache_get_value_name_int(0, "interior", vInfo[vehicleid][vInterior]);

    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_stats` WHERE `vehicle_id` = '%d'", vehicleid);
	mysql_tquery(DBConn, query, "LoadVehicleStats", "d", vehicleid);

    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_objects` WHERE `vehicle_id` = '%d'", vehicleid);
	mysql_tquery(DBConn, query, "LoadVehicleObjects", "d", vehicleid);

    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_tunings` WHERE `vehicle_id` = '%d'", vehicleid);
	mysql_tquery(DBConn, query, "LoadVehicleTuning", "d", vehicleid);

    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `vehicle_id` = '%d'", vehicleid);
	mysql_tquery(DBConn, query, "LoadVehicleWeapons", "d", vehicleid);

    

    SpawnVehicle(vehicleid);
    //SetVehicleObject(vehicleid);
    return true;
}

DeleteVehicle(vehicleid) {
    if (vehicleid != -1 && vInfo[vehicleid][vExists]) {
	    new Cache:result;
        printf("DELETE FROM `vehicles` WHERE `ID` = '%d';", vehicleid);
        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles` WHERE `ID` = '%d';", vehicleid);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_stats` WHERE `vehicle_id` = '%d';", vehicleid);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_objects` WHERE `vehicle_id` = '%d';", vehicleid);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_tunings` WHERE `vehicle_id` = '%d';", vehicleid);
        result = mysql_query(DBConn, query);
    
        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_weapons` WHERE `vehicle_id` = '%d';", vehicleid);
        result = mysql_query(DBConn, query);

        cache_delete(result);

		if (IsValidVehicle(vInfo[vehicleid][vVehicle]))
		    DestroyVehicle(vInfo[vehicleid][vVehicle]);

        vInfo[vehicleid][vExists] = false;
        vInfo[vehicleid][vOwner] = 0; 
        vInfo[vehicleid][vModel] = 0;
    }
	return true;
}

ResetVehicle(vehicleid) {
	if (vehicleid != -1 && vInfo[vehicleid][vExists]) {
		if (IsValidVehicle(vInfo[vehicleid][vVehicle])){
			DestroyVehicle(vInfo[vehicleid][vVehicle]);
            ResetVehicleObjects(vehicleid);
        }
	}
	return false;
}

ResetVehicleObjects(vehicleid){
    printf("ResetVehicleObjects(vehicleid) %d && vInfo[vehicleid][vVehicle] %d\n", vehicleid, vInfo[vehicleid][vVehicle]);
    for (new i = 0; i < 5; i++){  
        if (IsValidDynamicObject(vInfo[vehicleid][vObjectSlot][i])){
            DestroyDynamicObject(vInfo[vehicleid][vObjectSlot][i]);
            vInfo[vehicleid][vObject][i] = 0;
            vInfo[vehicleid][vObjectSlot][i] = -1;
            vInfo[vehicleid][vObjectPosX][i] = -1;
            vInfo[vehicleid][vObjectPosY][i] = -1;
            vInfo[vehicleid][vObjectPosZ][i] = -1;
            vInfo[vehicleid][vObjectRotX][i] = -1;
            vInfo[vehicleid][vObjectRotY][i] = -1;
            vInfo[vehicleid][vObjectRotZ][i] = -1;
        }
    }
    return true;
}

ParkPlayerVehicle(playerid) {
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = VehicleGetID(vehicleid);

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Você deve ser o motorista do veículo para usar esse comando.");

    if(!VehicleIsOwner(playerid, id)) return SendErrorMessage(playerid, "Você deve ser o dono do veículo para usar esse comando.");

    if(IsVehicleImpounded(vehicleid)) return SendErrorMessage(playerid, "Este veículo está apreendido, portanto você não pode utilizá-lo.");

    if(IsPlayerInRangeOfPoint(playerid, 5.0, vInfo[id][vPos][0], vInfo[id][vPos][1], vInfo[id][vPos][2]) && vInfo[id][vVW] == GetPlayerVirtualWorld(playerid) && vInfo[id][vInterior] == GetPlayerInterior(playerid)) {
        RemovePlayerFromVehicle(playerid);
		for(new i = 0; i < MAX_PLAYERS; i++) {
	    	if(GetPlayerState(i) == PLAYER_STATE_PASSENGER && GetPlayerVehicleID(i) == vInfo[vehicleid][vVehicle])  
                RemovePlayerFromVehicle(i); 
	    }

        if(vInfo[id][vNamePersonalized]) SendServerMessage(playerid, "Seu veículo %s (( %s )) foi estacionado na vaga.", vInfo[id][vName], ReturnVehicleModelName(vInfo[id][vModel]));
		else SendServerMessage(playerid, "Seu veículo %s foi estacionado na vaga.", ReturnVehicleModelName(vInfo[id][vModel]));

        format(logString, sizeof(logString), "%s (%s) estacionou seu %s (SQL %d) na vaga", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(vInfo[id][vModel]), id);
	    logCreate(playerid, logString, 16);

        SaveVehicle(id);
        ResetVehicleObjects(id);
        ResetVehicle(id);
        vInfo[id][vVehicle] = 0;
        vInfo[id][vExists] = 0;

    } else {
        SendErrorMessage(playerid, "Você não está perto da sua vaga.");
        if(vInfo[id][vVW] == 0) {
            va_SendClientMessage(playerid, 0xFF00FFFF, "INFO: Você pode usar a marca vermelha no mapa para achar a vaga do seu veículo.");
			SetPlayerCheckpoint(playerid, vInfo[id][vPos][0], vInfo[id][vPos][1], vInfo[id][vPos][2], 3.0);
        }
    } 
    return true;
}

ChangeParkPlayerVehicle(playerid) {
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = VehicleGetID(vehicleid);

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Você deve ser o motorista do veículo para usar esse comando.");
    if(!VehicleIsOwner(playerid, id)) return SendErrorMessage(playerid, "Você ser o dono do veículo para usar esse comando.");
    if(IsVehicleImpounded(id)) return SendErrorMessage(playerid, "Este veículo está apreendido, portanto você não pode utilizá-lo.");

    GetVehiclePos(GetPlayerVehicleID(playerid), vInfo[id][vPos][0], vInfo[id][vPos][1], vInfo[id][vPos][2]);
	GetVehicleZAngle(GetPlayerVehicleID(playerid), vInfo[id][vPos][3]);
    vInfo[vehicleid][vVW] = GetPlayerVirtualWorld(playerid);
    vInfo[vehicleid][vInterior] = GetPlayerInterior(playerid);
    

    if(vInfo[id][vNamePersonalized]) SendServerMessage(playerid, "Você atualizou a vaga do seu veículo %s (( %s )).", vInfo[id][vName], ReturnVehicleModelName(vInfo[id][vModel]));
	else SendServerMessage(playerid, "Você atualizou a vaga do seu veículo %s.", ReturnVehicleModelName(vInfo[id][vModel]));

    format(logString, sizeof(logString), "%s (%s) atualizou a vaga do seu seu %s (SQL %d)", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(vInfo[id][vModel]), id);
	logCreate(playerid, logString, 16);

    SaveVehicle(id); SpawnVehicle(id);
    return true;
}

forward LoadVehicleStats(vehicleid);
public LoadVehicleStats(vehicleid) {

    cache_get_value_name_int(0, "insurance", vInfo[vehicleid][vInsurance]);
    cache_get_value_name_int(0, "sunpass", vInfo[vehicleid][vSunpass]);
    cache_get_value_name_int(0, "alarm", vInfo[vehicleid][vAlarm]);

    cache_get_value_name_float(0, "fuel", vInfo[vehicleid][vFuel]);
    printf("LoadVehicleStats %f", vInfo[vehicleid][vFuel]);
    cache_get_value_name_float(0, "health", vInfo[vehicleid][vHealth]);
    cache_get_value_name_float(0, "battery", vInfo[vehicleid][vBattery]);
	cache_get_value_name_float(0, "engine", vInfo[vehicleid][vEngine]);
    cache_get_value_name_float(0, "miles", vInfo[vehicleid][vMiles]);
    
    return true;
}

forward LoadVehicleObjects(vehicleid);
public LoadVehicleObjects(vehicleid) {
    for (new o = 0; o < 5; o ++) {
        format(query, sizeof(query), "object_%d", o + 1);
        cache_get_value_name_int(0, query, vInfo[vehicleid][vObject][o]);
        format(query, sizeof(query), "ofX_%d", o + 1);
        cache_get_value_name_float(0, query, vInfo[vehicleid][vObjectPosX][o]);
        format(query, sizeof(query), "ofY_%d", o + 1);
        cache_get_value_name_float(0, query, vInfo[vehicleid][vObjectPosY][o]);
        format(query, sizeof(query), "ofZ_%d", o + 1);
        cache_get_value_name_float(0, query, vInfo[vehicleid][vObjectPosZ][o]);
        format(query, sizeof(query), "rX_%d", o + 1);
        cache_get_value_name_float(0, query, vInfo[vehicleid][vObjectRotX][o]);
        format(query, sizeof(query), "rY_%d", o + 1);
        cache_get_value_name_float(0, query, vInfo[vehicleid][vObjectRotY][o]);
        format(query, sizeof(query), "rZ_%d", o + 1);
        cache_get_value_name_float(0, query, vInfo[vehicleid][vObjectRotZ][o]);
    }
    for(new i = 0; i < 5; i++) {
        printf("CreateA: vInfo[vehicleid][vObject][i] %d", vInfo[vehicleid][vObject][i]);
		if(vInfo[vehicleid][vObject][i] != 0) {
            printf("CreateD: vInfo[vehicleid][vObject][i] %d", vInfo[vehicleid][vObject][i]);
            if(IsValidDynamicObject(vInfo[vehicleid][vObjectSlot][i])){
                DestroyDynamicObject(vInfo[vehicleid][vObjectSlot][i]);
                vInfo[vehicleid][vObjectSlot][i] = -1;
            }

            vInfo[vehicleid][vObjectSlot][i] = CreateDynamicObject(vInfo[vehicleid][vObject][i], 0, 0, 0, 0, 0, 0);
            AttachDynamicObjectToVehicle(vInfo[vehicleid][vObjectSlot][i], 
            vInfo[vehicleid][vVehicle], 
            vInfo[vehicleid][vObjectPosX][i],
            vInfo[vehicleid][vObjectPosY][i],
            vInfo[vehicleid][vObjectPosZ][i],
            vInfo[vehicleid][vObjectRotX][i],
            vInfo[vehicleid][vObjectRotY][i],
            vInfo[vehicleid][vObjectRotZ][i]);
		}
	}
    return true;
}

forward LoadVehicleTuning(vehicleid);
public LoadVehicleTuning(vehicleid) {
    for (new m = 0; m < 17; m ++) {
        format(query, sizeof(query), "mod%d", m + 1);
        cache_get_value_name_int(0, query, vInfo[vehicleid][vMods][m]);
    }
    return true;
}

forward LoadVehicleWeapons(vehicleid);
public LoadVehicleWeapons(vehicleid) {
    for (new w = 0; w < 30; w ++) {
        format(query, sizeof(query), "weapon%d", w + 1);
        cache_get_value_name_int(0, query, vInfo[vehicleid][vWeapons][w]);
        format(query, sizeof(query), "ammo%d", w + 1);
        cache_get_value_name_int(0, query, vInfo[vehicleid][vAmmo][w]);
        format(query, sizeof(query), "weapon_type%d", w + 1);
        cache_get_value_name_int(0, query, vInfo[vehicleid][vWeaponsType][w]);
    }
    return true;
}

SetVehicleObject(vehicleid) {
    VehicleGetID(vehicleid);
	for(new i = 0; i < 5; i++) {
		if(vInfo[vInfo[vehicleid][vVehicle]][vObject][i] != 0) {
            printf("Create: vInfo[vehicleid][vObject][i] %d", vInfo[vehicleid][vObject][i]);

            vInfo[vehicleid][vObject][i] = CreateDynamicObject(vInfo[vehicleid][vObject][i], 0, 0, 0, 0, 0, 0);
			AttachDynamicObjectToVehicle(vInfo[vehicleid][vObject][i], 
            vInfo[vehicleid][vVehicle], 
            vInfo[vehicleid][vObjectPosX][i],
            vInfo[vehicleid][vObjectPosY][i],
            vInfo[vehicleid][vObjectPosZ][i],
            vInfo[vehicleid][vObjectRotX][i],
            vInfo[vehicleid][vObjectRotY][i],
            vInfo[vehicleid][vObjectRotZ][i]);
		}
	}
    return true;
}

ModVehicle(vehicleid) {
	for(new i = 0; i < 17; i++) {
		if(vInfo[vehicleid][vMods][i] != 0) {
			AddVehicleComponent(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vMods][i]);
		}
	}
    return true;
}

hook OnPlayerEnterCheckpoint(playerid) {
    DisablePlayerCheckpoint(playerid);
    return true;
}

hook OnVehicleDeath(vehicleid, killerid){

    SaveVehicle(vehicleid);
}

ShowPlayerVehicles(playerid) {
	mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `character_id` = '%d'", GetPlayerSQLID(playerid));
    new Cache:result = mysql_query(DBConn, query);
            
    new string[2048], veh_id, veh_model, veh_color1, veh_color2, veh_pname, veh_name[64], veh_impounded;

    if(!cache_num_rows()) return SendErrorMessage(playerid, "Você não possui nenhum veículo");

    for(new i; i < cache_num_rows(); i++){
        cache_get_value_name_int(i, "ID", veh_id);
		cache_get_value_name_int(i, "model", veh_model);
		cache_get_value_name_int(i, "color1", veh_color1);
		cache_get_value_name_int(i, "color2", veh_color2);
		cache_get_value_name_int(i, "personalized_name", veh_pname);
		cache_get_value_name(i, "name", veh_name);
        cache_get_value_name_int(i, "impounded", veh_impounded);
        
		if(!vInfo[veh_id][vVehicle] && veh_pname != 0 && veh_impounded != 0) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~ID Registro~n~~w~%d\n", string, veh_model, veh_color1, veh_color2, veh_name, veh_id);
		else if(vInfo[veh_id][vVehicle] && veh_pname != 0) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~ID Real~n~~w~%d\n", string, veh_model, veh_color1, veh_color2, veh_name, vInfo[veh_id][vVehicle]);
		else if(!vInfo[veh_id][vVehicle] && veh_pname != 0) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~w~%s~n~~n~~n~~n~ID Registro~n~~w~%d\n", string, veh_model, veh_color1, veh_color2, veh_name, veh_id);
		else if(vInfo[veh_id][vVehicle]) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~ID Real~n~~w~%d\n", string, veh_model, veh_color1, veh_color2, ReturnVehicleModelName(veh_model), vInfo[veh_id][vVehicle]);
		else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~w~%s~n~~n~~n~~n~ID Registro~n~~w~%d\n", string, veh_model, veh_color1, veh_color2, ReturnVehicleModelName(veh_model), veh_id);
    }
    cache_delete(result);

	new title[128];
	format(title, 128, "Veículos_de_%s", pNome(playerid));
	AdjustTextDrawString(title);

    Dialog_Show(playerid, ShowVehicles, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Spawnar", "Fechar");
	return true;
}

Dialog:ShowVehicles(playerid, response, listitem, inputtext[]) {
    if(response){
		new count = 0, veh_id, veh_model, veh_pname, veh_name[64], veh_impounded;

		mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `character_id` = '%d'", GetPlayerSQLID(playerid));
    	new Cache:result = mysql_query(DBConn, query);

		for(new i; i < cache_num_rows(); i++) {
        	cache_get_value_name_int(i, "ID", veh_id);
			cache_get_value_name_int(i, "model", veh_model);
			cache_get_value_name_int(i, "personalized_name", veh_pname);
			cache_get_value_name(i, "name", veh_name);
            cache_get_value_name_int(i, "impounded", veh_impounded);

			if(count == listitem) {
				if(vInfo[veh_id][vVehicle]) {
					SendErrorMessage(playerid, "Este veículo já está spawnado.");
					break;
				}
                if(veh_impounded) {
                    SendErrorMessage(playerid, "Este veículo está apreendido e não pode ser spawnado.");
                    break;
                }

				LoadVehicle(veh_id);
				if(veh_pname != 0) SendServerMessage(playerid, "Seu veículo %s foi spawnado.", veh_name);
				else SendServerMessage(playerid, "Seu veículo %s foi spawnado.", ReturnVehicleModelName(veh_model));

				if(vInfo[i][vVW] == 0) {
					va_SendClientMessage(playerid, 0xFF00FFFF, "INFO: Você pode usar a marca vermelha no mapa para achar seu veiculo.");
					SetPlayerCheckpoint(playerid, vInfo[veh_id][vPos][0], vInfo[veh_id][vPos][1], vInfo[veh_id][vPos][2], 3.0);
				}
			} else count ++;
		}
		cache_delete(result);
	}
    return true;
}

// DEBUG
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
    printf("\n\nOnPlayerEnterVehicle (vehicleid):\n\
    vInfo[vehicleid][vModel] = %d\n\
    vInfo[vehicleid][vOwner] = %d\n\
    vInfo[vehicleid][vFaction] = %d\n\
    vInfo[vehicleid][vBusiness] = %d\n\
    vInfo[vehicleid][vJob] = %d\n\
    vInfo[vehicleid][vID] = %d\n\
    vInfo[vehicleid][vVehicle] = %d\n", vInfo[vehicleid][vModel], 
    vInfo[vehicleid][vOwner],
    vInfo[vehicleid][vFaction],
    vInfo[vehicleid][vBusiness],
    vInfo[vehicleid][vJob],
    vInfo[vehicleid][vID],
    vInfo[vehicleid][vVehicle]);
    for(new i = 0; i < 5; i++) {
		if(vInfo[vehicleid][vObject][i] != 0) {
            printf("vInfo[vehicleid][vObject][i] = %d\n", vInfo[vehicleid][vObject][i]);
		}
	}

    new id = VehicleGetID(vehicleid);
    printf("\n\nOnPlayerEnterVehicle (id):\n\
    vInfo[id][vModel] = %d\n\
    vInfo[id][vOwner] = %d\n\
    vInfo[id][vFaction] = %d\n\
    vInfo[id][vBusiness] = %d\n\
    vInfo[id][vJob] = %d\n\
    vInfo[id][vID] = %d\n\
    vInfo[id][vVehicle] = %d\n", vInfo[id][vModel], 
    vInfo[id][vOwner],
    vInfo[id][vFaction],
    vInfo[id][vBusiness],
    vInfo[id][vJob],
    vInfo[id][vID],
    vInfo[id][vVehicle]);

    for(new i = 0; i < 5; i++) {
		if(vInfo[id][vObject][i] != 0) {
            printf("vInfo[id][vObject][i] = %d\n", vInfo[id][vObject][i]);
		}
	}

    return 1;
}