#include <YSI_Coding\y_hooks>

VehicleCreate(ownerid, modelid, Float:x, Float:y, Float:z, Float:a, color1, color2, plate[], insurance = 0, sunpass = 0, alarm = 0, faction = 0, business = 0, job = 0, caravan = 0, caravantype = 0) {
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
            vInfo[i][vHealth] = 1000.00;
            vInfo[i][vHealthRepair] = 1000.00;
            vInfo[i][vMaxHealth] = 1000.00;
            vInfo[i][vBattery] = 100.00;
            vInfo[i][vEngine] = 100.00;
            vInfo[i][vMiles] = 0.00;
            vInfo[i][vMilesCon] = 0.00;
            
            vInfo[i][vFaction] = faction;
            vInfo[i][vBusiness] = business;
            vInfo[i][vJob] = job;

            SetCarAttributes(modelid, i);
            new count;
		    for (new ix = 0; ix < sizeof(arrBatteryEngine); ix ++) {
			    if(vInfo[i][vModel] == arrBatteryEngine[ix][VehModel]) {
		    	    vInfo[i][vMaxFuel] = arrBatteryEngine[ix][VehMaxFuel];
		        	vInfo[i][vFuel] = arrBatteryEngine[ix][VehMaxFuel];
		        	count++;
			        break;
			    }
			} if(!count) {
			    vInfo[i][vMaxFuel] = 70.0;
      			vInfo[i][vFuel] = 70.0;
    	  		count = 0;
			}

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
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_damages (`vehicle_id`) VALUES ('%d');", id);
            result = mysql_query(DBConn, query);
            cache_delete(result);
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_caravan (`vehicle_id`) VALUES ('%d');", id);
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

            if (caravan != 0){
                vInfo[i][vCaravan] = 1;
                vInfo[i][vCaravanType] = caravantype;
                switch (caravantype){
                    case 1: {
                        vInfo[i][vModel] = 607;
                        vInfo[i][vCaravanModelID] = -1000;
                        format(vInfo[i][vCaravanModelName], 64, "Caravan xTreme");
                        vInfo[i][vNamePersonalized] = 1;
                        format(vInfo[i][vName], 64, "Caravan xTreme");
                        vInfo[i][vInterior] = vInfo[i][vInterior] + 1;
                        
                        vInfo[i][vObject][0] = -1000;
                        vInfo[i][vObjectPosX][0] = 0.052874;
                        vInfo[i][vObjectPosY][0] = -2.19067;
                        vInfo[i][vObjectPosZ][0] = -0.870006;
                        vInfo[i][vObjectRotX][0] = 0;
                        vInfo[i][vObjectRotY][0] = 0;
                        vInfo[i][vObjectRotZ][0] = -180.171;
                    }
                }
            }
            vInfo[i][vID] = id;

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

    if(!cache_num_rows()) return false;
 
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
    `caravan` = '%d',               \
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
    vInfo[vehicleid][vCaravan],
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

    GetVehicleHealth(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vHealth]);
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

    GetVehicleDamageStatus(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vPanelsStatus], vInfo[vehicleid][vDoorsStatus], vInfo[vehicleid][vLightsStatus], vInfo[vehicleid][vTiresStatus]);

    mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_damages` SET \
    `panels_status` = '%d',                 \
    `doors_status` = '%d',                  \
    `lights_status` = '%d',                 \
    `tires_status` = '%d'                   \
    WHERE `vehicle_id` = '%d';",
    vInfo[vehicleid][vPanelsStatus],
    vInfo[vehicleid][vDoorsStatus],
    vInfo[vehicleid][vLightsStatus],
    vInfo[vehicleid][vTiresStatus],
    vInfo[vehicleid][vID]);
    result = mysql_query(DBConn, query);
    cache_delete(result);

    mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_caravan` SET \
    `caravan_model_id` = '%d',          \
    `caravan_model_name` = '%s',        \
    `caravan_type` = '%d'               \
    WHERE `vehicle_id` = '%d';",
    vInfo[vehicleid][vCaravanModelID],
    vInfo[vehicleid][vCaravanModelName],
    vInfo[vehicleid][vCaravanType],    
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

        vInfo[vehicleid][vWindowsDown] = false;
        vInfo[vehicleid][vVehicle] =  CreateVehicle(vInfo[vehicleid][vModel], 
        vInfo[vehicleid][vPos][0], vInfo[vehicleid][vPos][1], vInfo[vehicleid][vPos][2], vInfo[vehicleid][vPos][3], 
        vInfo[vehicleid][vColor1], vInfo[vehicleid][vColor2], -1, false);

        //if(vInfo[vehicleid][vCaravan] != 0) vInfo[vehicleid][vInterior] = vInfo[vehicleid][vInterior] + 1;
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

        cache_get_value_name_int(i, "caravan", vInfo[id][vCaravan]);

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

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_damages` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleDamages", "d", id);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_caravan` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleCaravan", "d", id);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_objects` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleObjects", "d", id);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_tunings` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleTuning", "d", id);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `vehicle_id` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleWeapons", "d", id);

        SpawnVehicle(id);
        loadedVehicles++;
    }
    printf("[VEÍCULOS]: %d veículos carregados com sucesso.", loadedVehicles);
    return true;
}
/*
Vehicle_LoadByID(vehicleid) {

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles` WHERE `ID` = '%d';", vehicleid);
    mysql_tquery(DBConn, query, "LoadVehicle", "d", vehicleid);
    mysql_query(DBConn, query);

	new query[128];
	format(query, sizeof(query), "SELECT * FROM `cars` WHERE `carID` = '%d'", carid);
	mysql_function_query(g_iHandle, query, true, "Car_Load2", "");
	return true;
}*/

/*IsVehicleInData(vehicleid) {
	for(new i = 0; i < MAX_DYNAMIC_CARS; i++) {
		if(vInfo[i][vExists] && vInfo[i][vID] == vehicleid)
			return i;
	}
	return -1;
}*/

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

    cache_get_value_name_int(0, "caravan", vInfo[vehicleid][vCaravan]);

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

    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_damages` WHERE `vehicle_id` = '%d'", vehicleid);
	mysql_tquery(DBConn, query, "LoadVehicleDamages", "d", vehicleid);

    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_caravan` WHERE `vehicle_id` = '%d'", vehicleid);
	mysql_tquery(DBConn, query, "LoadVehicleCaravan", "d", vehicleid);

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
        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles` WHERE `ID` = '%d';", vehicleid);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_stats` WHERE `vehicle_id` = '%d';", vehicleid);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_damages` WHERE `vehicle_id` = '%d';", vehicleid);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_caravan` WHERE `vehicle_id` = '%d';", vehicleid);
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

        ResetVehicleObjects(vehicleid);

        vInfo[vehicleid][vExists] = false;
        vInfo[vehicleid][vOwner] = 0; 
        vInfo[vehicleid][vModel] = 0;
    }
	return true;
}

ResetVehicle(vehicleid) {
	if (vehicleid != -1 && vInfo[vehicleid][vExists]) {
		if (IsValidVehicle(vInfo[vehicleid][vVehicle])) {
			DestroyVehicle(vInfo[vehicleid][vVehicle]);

            ResetVehicleObjects(vehicleid);

            vInfo[vehicleid][vID] =
            vInfo[vehicleid][vModel] =
            vInfo[vehicleid][vOwner] =
            vInfo[vehicleid][vFaction] =
            vInfo[vehicleid][vBusiness] =
            vInfo[vehicleid][vJob] =
            vInfo[vehicleid][vNamePersonalized] =
            vInfo[vehicleid][vLegal] =
            vInfo[vehicleid][vPlatePersonalized] =
            vInfo[vehicleid][vCaravan] =
            vInfo[vehicleid][vColor1] =
            vInfo[vehicleid][vColor2] =
            vInfo[vehicleid][vPaintjob] =
            vInfo[vehicleid][vVW] =
            vInfo[vehicleid][vInterior] =
            vInfo[vehicleid][vImpounded] =
            vInfo[vehicleid][vImpoundedPrice] =
            vInfo[vehicleid][vInsurance] =
            vInfo[vehicleid][vSunpass] =
            vInfo[vehicleid][vAlarm] =
            vInfo[vehicleid][vEnergyResource] = 0;

            vInfo[vehicleid][vWindowsDown] =
            vInfo[vehicleid][vLocked] = false;

            vInfo[vehicleid][vFuel] =
            vInfo[vehicleid][vMaxFuel] =
            vInfo[vehicleid][vHealth] =
            vInfo[vehicleid][vHealthRepair] =
            vInfo[vehicleid][vMaxHealth] =
            vInfo[vehicleid][vBattery] =
            vInfo[vehicleid][vEngine] =
            vInfo[vehicleid][vMiles] =
            vInfo[vehicleid][vMilesCon] = 0.0;
            
            vInfo[vehicleid][vName][0] =
            vInfo[vehicleid][vPlate][0] =
            vInfo[vehicleid][vImpoundedReason][0] = EOS;

            for (new i = 0; i < 4; i++) {
                vInfo[vehicleid][vPos][i] = 0;
            }
            for (new ix = 0; ix < 3; ix++) {
                vInfo[vehicleid][MilesPos][ix] = 0;
            }

            vInfo[vehicleid][vExists] = false;
        }
	}
	return false;
}

ResetVehicleObjects(vehicleid) {
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

    format(logString, sizeof(logString), "%s (%s) atualizou a vaga do seu %s (SQL %d)", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(vInfo[id][vModel]), id);
	logCreate(playerid, logString, 16);
    
    SaveVehicle(id); SpawnVehicle(id);
    return true;
}

CheckVehicleStats(playerid) {
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = VehicleGetID(vehicleid);

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Você deve ser o motorista do veículo para usar esse comando.");
    if(!VehicleIsOwner(playerid, id)) return SendErrorMessage(playerid, "Você ser o dono do veículo para usar esse comando.");

    new sunpassstatus[128];
	if(vInfo[id][vSunpass] == 1) {
		if(pInfo[playerid][pDonator] != 0)  format(sunpassstatus, 128, "Instalado");
		else format(sunpassstatus, 128, "Desabilitado");
	} else format(sunpassstatus, 128, "Não instalado");

	if(vInfo[id][vModel] == 481 || vInfo[id][vModel] == 509 || vInfo[id][vModel] == 510) {
		if(vInfo[id][vNamePersonalized]) va_SendClientMessage(playerid, COLOR_WHITECYAN, "%s ((%s)):", vInfo[id][vName], ReturnVehicleModelName(vInfo[id][vModel]));
		else va_SendClientMessage(playerid, COLOR_WHITECYAN, "%s:", ReturnVehicleModelName(vInfo[id][vModel]));

		va_SendClientMessage(playerid, COLOR_WHITECYAN, "Trava[%d], Alarme[%d], Seguro[%d], Placa[%s], Sun Pass[%s]", vInfo[id][vLocked], vInfo[id][vAlarm], vInfo[id][vInsurance], vInfo[id][vPlate], sunpassstatus);
		va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Engrenagem[%.2f], Milhas Rodadas[%.1f]", vInfo[id][vEngine], vInfo[id][vMiles]);
	} else {
		if(vInfo[id][vNamePersonalized]) va_SendClientMessage(playerid, COLOR_WHITECYAN, "%s ((%s)):", vInfo[id][vName], ReturnVehicleModelName(vInfo[id][vModel]));
		else va_SendClientMessage(playerid, COLOR_WHITECYAN, "%s:", ReturnVehicleModelName(vInfo[id][vModel]));

		va_SendClientMessage(playerid, COLOR_WHITECYAN, "Trava[%d], Alarme[%d], Seguro[%d], Placa[%s], Sun Pass[%s]", vInfo[id][vLocked], vInfo[id][vAlarm], vInfo[id][vInsurance], vInfo[id][vPlate], sunpassstatus);
		va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Motor[%.2f], Bateria[%.2f], Milhas Rodadas[%.1f]", vInfo[id][vEngine], vInfo[id][vBattery], vInfo[id][vMiles]);
	}
    return true;
}

SetVehicleLock(playerid) {
 	static id = -1, Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

	if ((id = VehicleInside(playerid)) != -1 || (id = VehicleNearestToLock(playerid)) != -1) {
        GetDoorsStatus(id);
	    if (VehicleIsOwner(playerid, id)) {
			if (!vInfo[id][vLocked]) {
				vInfo[id][vLocked] = true;
				SaveVehicle(id);

				GameTextForPlayer(playerid, "~r~Trancado", 2400, 4);
                PlaySoundForPlayersInRange(1145, 2.0, x, y, z);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				SetDoorsStatus(vInfo[id][vVehicle], true);
			} else {
				vInfo[id][vLocked] = false;
				SaveVehicle(id);

				GameTextForPlayer(playerid, "~g~Destrancado", 2400, 4);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				SetDoorsStatus(vInfo[id][vVehicle], false);
			}
		} else {
            if(vInfo[id][vNamePersonalized])  SendErrorMessage(playerid, "Você não possui as chaves para destrancar o veículo %s (( %s )).",vInfo[id][vName], ReturnVehicleModelName(vInfo[id][vModel]));
            else SendErrorMessage(playerid, "Você não possui as chaves para destrancar o veículo %s.", ReturnVehicleModelName(vInfo[id][vModel]));
        }
	} else SendErrorMessage(playerid, "Você não está próximo do seu veiculo.");
	return true;
}

forward LoadVehicleStats(vehicleid);
public LoadVehicleStats(vehicleid) {
    cache_get_value_name_int(0, "insurance", vInfo[vehicleid][vInsurance]);
    cache_get_value_name_int(0, "sunpass", vInfo[vehicleid][vSunpass]);
    cache_get_value_name_int(0, "alarm", vInfo[vehicleid][vAlarm]);

    cache_get_value_name_float(0, "fuel", vInfo[vehicleid][vFuel]);
    cache_get_value_name_float(0, "health", vInfo[vehicleid][vHealth]);
    cache_get_value_name_float(0, "battery", vInfo[vehicleid][vBattery]);
	cache_get_value_name_float(0, "engine", vInfo[vehicleid][vEngine]);
    cache_get_value_name_float(0, "miles", vInfo[vehicleid][vMiles]);

    SetVehicleHealth(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vHealth]);
    return true;
}

forward LoadVehicleDamages(vehicleid);
public LoadVehicleDamages(vehicleid) {
    cache_get_value_name_int(0, "panels_status", vInfo[vehicleid][vPanelsStatus]);
    cache_get_value_name_int(0, "doors_status", vInfo[vehicleid][vDoorsStatus]);
    cache_get_value_name_int(0, "lights_status", vInfo[vehicleid][vLightsStatus]);
    cache_get_value_name_int(0, "tires_status", vInfo[vehicleid][vTiresStatus]);

    UpdateVehicleDamageStatus(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vPanelsStatus], vInfo[vehicleid][vDoorsStatus], vInfo[vehicleid][vLightsStatus], vInfo[vehicleid][vTiresStatus]);
    return true;
}

forward LoadVehicleCaravan(vehicleid);
public LoadVehicleCaravan(vehicleid) {
    cache_get_value_name_int(0, "caravan_model_id", vInfo[vehicleid][vCaravanModelID]);
    cache_get_value_name(0, "caravan_model_name", vInfo[vehicleid][vCaravanModelName]);
    cache_get_value_name_int(0, "caravan_type", vInfo[vehicleid][vCaravanType]);
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
		if(vInfo[vehicleid][vObject][i] != 0) {
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
    for(new i = 0; i < 17; i++) {
		if(vInfo[vehicleid][vMods][i] != 0) {
			AddVehicleComponent(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vMods][i]);
		}
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

hook OnPlayerEnterCheckpoint(playerid) {
    if(!InDMV[playerid]) {
        DisablePlayerCheckpoint(playerid);
    }
    return true;
}

/*RespawnVehicle(vehicleid) {
	new id = VehicleGetID(vehicleid);

	if (id != -1)
	    SpawnVehicle(id);
	else SetVehicleToRespawn(vehicleid);
    ResetVehicleObjects(vehicleid);
	ResetVehicle(vehicleid);
	return true;
}*/

hook OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate) {
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) {
        new vehicleid = GetPlayerVehicleID(playerid);
        new id = VehicleGetID(vehicleid);
        if (id == -1) return false;
        if (VehicleIsOwner(playerid, id)) {
            if(vInfo[id][vNamePersonalized]) va_SendClientMessage(playerid, COLOR_WHITECYAN, "Bem-vindo(a) ao seu veículo %s.", vInfo[id][vName]);
			else va_SendClientMessage(playerid, COLOR_WHITECYAN, "Bem-vindo(a) ao seu veículo %s.", ReturnVehicleModelName(vInfo[id][vModel]));
        }
        //SaveVehicle(id);
    }
    return true;
}

public OnVehicleDeath(vehicleid, killerid) {
    static id;
    id = VehicleGetID(vehicleid);

    if(id != -1) {
        if (vInfo[id][vFaction] != 0 || vInfo[id][vBusiness] != 0 || vInfo[id][vJob] != 0){
            RepairVehicle(vInfo[id][vVehicle]);
            SaveVehicle(id);
            ResetVehicleObjects(id);
            ResetVehicle(id);
            LoadVehicle(id);
            return true;
        }

        if(vInfo[id][vInsurance] < 3) {
            vInfo[id][vHealth] = 300.00;
            vInfo[id][vHealthRepair] = 300.00;

            for (new i = 0; i < 17; i ++) {
                if (vInfo[id][vMods][i] > 0) 
                    RemoveVehicleComponent(vehicleid, vInfo[id][vMods][i]);
            }
        }

        //GetVehiclePos(vInfo[id][vVehicle], vInfo[id][vPos][0], vInfo[id][vPos][1], vInfo[id][vPos][2]);

        SaveVehicle(id);
        ResetVehicleObjects(id);
        ResetVehicle(id);
        vInfo[id][vVehicle] = 0;
        vInfo[id][vExists] = 0;
    }

    ResetVehicleObjects(vehicleid);
    return true;
}

Vehicle_GetCount(playerid) {
    new count = 0;
	mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `character_id` = '%d'", GetPlayerSQLID(playerid));
    new Cache:result = mysql_query(DBConn, query);
    count = cache_num_rows();
    cache_delete(result);
	return count;
}

hook OnGameModeInit(){
    LoadVehicles();
    return true;
}