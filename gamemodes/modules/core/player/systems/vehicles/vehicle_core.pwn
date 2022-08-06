#include <YSI_Coding\y_hooks>

VehicleCreate(ownerid, modelid, Float:x, Float:y, Float:z, Float:a, color1, color2, plate[]) {
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

            vInfo[i][vPos][0] = x;
            vInfo[i][vPos][1] = y;
            vInfo[i][vPos][2] = z;
            vInfo[i][vPos][3] = a;

            vInfo[i][vVehicle] =  CreateVehicle(vInfo[i][vModel], 
            vInfo[i][vPos][0], vInfo[i][vPos][1], vInfo[i][vPos][2], vInfo[i][vPos][3], 
            vInfo[i][vColor1], vInfo[i][vColor2], -1, false);

            format(vInfo[i][vPlate], 128, "%s", plate);
            LinkVehicleToInterior(vInfo[i][vVehicle], vInfo[i][vInterior]);
            SetVehicleVirtualWorld(vInfo[i][vVehicle], vInfo[i][vVW]);
            SetVehicleNumberPlate(vInfo[i][vVehicle], vInfo[i][vPlate]);

            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles (`character_id`) VALUES ('%d');", ownerid);
            result = mysql_query(DBConn, query);
            new id = cache_insert_id();
            cache_delete(result);
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_tunings (`vehicle_id`) VALUES ('%d');", id);
            result = mysql_query(DBConn, query);
            cache_delete(result);
            mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_weapons (`vehicle_id`) VALUES ('%d');", id);
            result = mysql_query(DBConn, query);
            cache_delete(result);

            vInfo[i][vSQLID] = id;
            SaveVehicle(i);
            return i;
        }
    }
    return -1;
}

SaveVehicle(vehicleid) {
    new Cache:result;
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles` WHERE `id` = '%d';", vInfo[vehicleid][vSQLID]);
    result = mysql_query(DBConn, query);

    if(!cache_num_rows())
        return false;

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
    `interior` = '%d'               \
    WHERE `id` = %d;", 
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
    vInfo[vehicleid][vSQLID]);
    result = mysql_query(DBConn, query);
    cache_delete(result);

    for (new m = 0; m < 17; m ++) {
        mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_tunings` SET `mod%d` = '%d' WHERE `vehicle_id` = '%d'", m + 1, vInfo[vehicleid][vMods][m], vInfo[vehicleid][vSQLID]);
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
        w + 1, vInfo[vehicleid][vWeaponsType][w], vInfo[vehicleid][vSQLID]);
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

        if (vInfo[vehicleid][vColor1] == -1)
		    vInfo[vehicleid][vColor1] = random(127);

		if (vInfo[vehicleid][vColor2] == -1)
		    vInfo[vehicleid][vColor2] = random(127);

        vInfo[vehicleid][vVehicle] =  CreateVehicle(vInfo[vehicleid][vModel], 
        vInfo[vehicleid][vPos][0], vInfo[vehicleid][vPos][1], vInfo[vehicleid][vPos][2], vInfo[vehicleid][vPos][3], 
        vInfo[vehicleid][vColor1], vInfo[vehicleid][vColor2], -1, false);

        LinkVehicleToInterior(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vInterior]);
        SetVehicleVirtualWorld(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vVW]);
        format(string, sizeof(string), "%s", vInfo[vehicleid][vPlate]);

        SetVehicleNumberPlate(vInfo[vehicleid][vVehicle], string);
        SetVehicleParamsEx(vInfo[vehicleid][vVehicle], false, false, false, vInfo[vehicleid][vLocked], false, false, false);

        ModVehicle(vehicleid);
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
        vInfo[id][vSQLID] = id;
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

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_tunings` WHERE `ID` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleTuning", "d", id);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `ID` = '%d'", id);
		mysql_tquery(DBConn, query, "LoadVehicleWeapons", "d", id);

        SpawnVehicle(id);
        loadedVehicles++;
    }
    printf("[VEÍCULOS]: %d veículos carregados com sucesso.", loadedVehicles);
    return true;
}

LoadVehicle(vehicleid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles` WHERE `ID` = %d;", vehicleid);
    mysql_query(DBConn, query);

    if (vInfo[vehicleid][vExists]) return false;

    vInfo[vehicleid][vExists] = true;
    cache_get_value_name_int(0, "model", vInfo[vehicleid][vModel]);
    cache_get_value_name_int(0, "character_vehicleid", vInfo[vehicleid][vOwner]);

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

    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_tuning` WHERE `vehicleid` = '%d'", vehicleid);
	mysql_tquery(DBConn, query, "LoadVehicleTuning", "d", vehicleid);

    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `vehicleid` = '%d'", vehicleid);
	mysql_tquery(DBConn, query, "LoadVehicleWeapons", "d", vehicleid);

    SpawnVehicle(vehicleid);
    return true;
}

forward LoadVehicleTuning(vehicleid);
public LoadVehicleTuning(vehicleid){
    for (new m = 0; m < 17; m ++) {
        format(query, sizeof(query), "mod%d", m + 1);
        cache_get_value_name_int(0, query, vInfo[vehicleid][vMods][m]);
    }
    return true;
}

forward LoadVehicleWeapons(vehicleid);
public LoadVehicleWeapons(vehicleid){
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

ModVehicle(vehicleid) {
	if(vInfo[vehicleid][vVehicle] <= 0 || vInfo[vehicleid][vVehicle] >= MAX_VEHICLES) return;
	for(new i = 0; i < 17; ++i) {
		if(vInfo[vehicleid][vMods][i] != 0) {
			AddVehicleComponent(vInfo[vehicleid][vVehicle], vInfo[vehicleid][vMods][i]);
		}
	}
}

hook OnPlayerEnterCheckpoint(playerid) {
    DisablePlayerCheckpoint(playerid);
    return true;
}