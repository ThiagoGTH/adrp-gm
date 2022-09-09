#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    LoadFactions();
    return true;
}

LoadFactions() {
    new loadedfactions;
    mysql_query(DBConn, "SELECT * FROM `factions` WHERE (`ID` != '0');");

    for (new i; i < cache_num_rows(); i++) if (i < MAX_FACTIONS) {
        cache_get_value_name_int(i, "ID", FactionData[i][factionID]);
        FactionData[i][factionExists] = true;
        FactionData[i][factionTogF] = false;

        cache_get_value_name(i, "name", FactionData[i][factionName]);
        cache_get_value_name_int(i, "type", FactionData[i][factionType]);
        cache_get_value_name_int(i, "color", FactionData[i][factionColor]);
        cache_get_value_name_int(i, "vault", FactionData[i][factionVault]);
        cache_get_value_name_int(i, "status", FactionData[i][factionStatus]);

        cache_get_value_name_int(i, "maxranks", FactionData[i][factionMaxRanks]);
        cache_get_value_name_int(i, "locker", FactionData[i][factionHasLocker]);
        
        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `factions_skins` WHERE `faction_id` = '%d'", FactionData[i][factionID]);
        mysql_tquery(DBConn, query, "LoadFactionSkins", "d", i); //

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `factions_ranks` WHERE `faction_id` = '%d'", FactionData[i][factionID]);
        mysql_tquery(DBConn, query, "LoadFactionRanks", "d", i);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `factions_weapons` WHERE `faction_id` = '%d'", FactionData[i][factionID]);
        mysql_tquery(DBConn, query, "LoadFactionWeapons", "d", i);

        if(FactionData[i][factionHasLocker] != 0) {
            mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `factions_locker` WHERE `faction_id` = '%d'", FactionData[i][factionID]);
            mysql_tquery(DBConn, query, "LoadFactionLocker", "d", i);
        }
        loadedfactions++;
    }
    printf("[FACÇÕES]: %d facções carregadas.", loadedfactions);
    return true;
}

forward LoadFactionLocker(i);
public LoadFactionLocker(i) {
    cache_get_value_name_float(0, "x", FactionData[i][factionLockerPos][0]);
    cache_get_value_name_float(0, "y", FactionData[i][factionLockerPos][1]);
    cache_get_value_name_float(0, "z", FactionData[i][factionLockerPos][2]);
    cache_get_value_name_int(0, "int", FactionData[i][factionLockerInt]);
    cache_get_value_name_int(0, "world", FactionData[i][factionLockerWorld]);
    return true;
}

forward LoadFactionWeapons(i);
public LoadFactionWeapons(i) {
    for (new ix = 0; ix < 15; ix ++) {
        format(query, sizeof(query), "weapon%d", ix + 1);
        cache_get_value_name_int(0, query, FactionData[i][factionWeapons][ix]);
        format(query, sizeof(query), "ammo%d", ix + 1);
        cache_get_value_name_int(0, query, FactionData[i][factionAmmo][ix]);
    }
    return true;
}

forward LoadFactionRanks(i);
public LoadFactionRanks(i) {
    for (new ix = 0; ix < 30; ix ++) {
        format(query, sizeof(query), "rank%d", ix + 1);
        cache_get_value_name(0, query, FactionRanks[i][ix]);
        format(query, sizeof(query), "paycheck%d", ix + 1);
        cache_get_value_name_int(0, query, FactionData[i][factionPaycheck][ix]);
    }
    return true;
}

forward LoadFactionSkins(i);
public LoadFactionSkins(i) {
    for (new ix = 0; ix < 50; ix ++) {
        format(query, sizeof(query), "skin%d", ix + 1);
        cache_get_value_name_int(0, query, FactionData[i][factionSkins][ix]);
    }
    return true;
}

CreateFaction(const name[], type){
    for (new i = 0; i != MAX_FACTIONS; i ++) if (!FactionData[i][factionExists]) {
        new Cache:result;
        format(FactionData[i][factionName], 32, name);

        FactionData[i][factionExists] = true;
        FactionData[i][factionColor] = 0xFFFFFF00;
        FactionData[i][factionType] = type;

        FactionData[i][factionHasLocker] = 0;
        FactionData[i][factionVault] = 0;
        FactionData[i][factionMaxRanks] = 5;

        for (new j = 0; j < 50; j ++) {
            FactionData[i][factionSkins][j] = 0;
        }
        for (new j = 0; j < 15; j ++) {
            FactionData[i][factionWeapons][j] = 0;
            FactionData[i][factionAmmo][j] = 0;
	    }
	    for (new j = 0; j < 30; j ++) {
			format(FactionRanks[i][j], 32, "Rank %d", j + 1);
	    }

        mysql_format(DBConn, query, sizeof query, "INSERT INTO factions (`name`, `type`) VALUES ('%s', '%d');", name, type);
        result = mysql_query(DBConn, query);
        new id = cache_insert_id();
        cache_delete(result);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO factions_locker (`faction_id`) VALUES ('%d');", id);
        result = mysql_query(DBConn, query);
        cache_delete(result);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO factions_skins (`faction_id`) VALUES ('%d');", id);
        result = mysql_query(DBConn, query);
        cache_delete(result);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO factions_ranks (`faction_id`) VALUES ('%d');", id);
        result = mysql_query(DBConn, query);
        cache_delete(result);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO factions_weapons (`faction_id`) VALUES ('%d');", id);
        result = mysql_query(DBConn, query);
        cache_delete(result);
        return true;
    }
    return -1;
}

DeleteFaction(factionid) {
    if(factionid != -1 && FactionData[factionid][factionExists]){
        new Cache:result;
        mysql_format(DBConn, query, sizeof query, "DELETE FROM `factions` WHERE `ID` = '%d';", FactionData[factionid][factionID]);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `factions_locker` WHERE `faction_id` = '%d';", FactionData[factionid][factionID]);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `factions_skins` WHERE `faction_id` = '%d';", FactionData[factionid][factionID]);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `factions_ranks` WHERE `faction_id` = '%d';", FactionData[factionid][factionID]);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "DELETE FROM `factions_weapons` WHERE `faction_id` = '%d';", FactionData[factionid][factionID]);
        result = mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "UPDATE `players_faction` SET `faction_id` = '-1', `faction_rank` = '-1' WHERE `faction_id` = '%d';", FactionData[factionid][factionID]);
        result = mysql_query(DBConn, query);

        foreach (new i : Player) {
			if (pInfo[i][pFaction] == factionid) {
		    	pInfo[i][pFaction] = -1;
		    	pInfo[i][pFactionRank] = -1;
			}
		}
        cache_delete(result);
        FactionData[factionid][factionExists] = false;
	    FactionData[factionid][factionType] = 0;
	    FactionData[factionid][factionID] = 0;
    }
    return true;
}