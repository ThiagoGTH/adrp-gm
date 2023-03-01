LoadPlayerLicenses(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_license WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);

	cache_get_value_name_int(0, "license_number", pLicenses[playerid][license_number]);
	cache_get_value_name_int(0, "license_status", pLicenses[playerid][license_status]);
	cache_get_value_name_int(0, "license_warnings", pLicenses[playerid][license_warnings]);

	cache_get_value_name_int(0, "license_vehicle", pLicenses[playerid][license_vehicle]);
	cache_get_value_name_int(0, "license_plane", pLicenses[playerid][license_plane]);
	cache_get_value_name_int(0, "license_medical", pLicenses[playerid][license_medical]);
	cache_get_value_name_int(0, "license_gun", pLicenses[playerid][license_gun]);

    cache_get_value(0, "warning_one", pLicenses[playerid][warning_one], MAX_DRIVERLICENCE_WAR);
	cache_get_value(0, "warning_two", pLicenses[playerid][warning_two], MAX_DRIVERLICENCE_WAR);
	cache_get_value(0, "warning_three", pLicenses[playerid][warning_three], MAX_DRIVERLICENCE_WAR);

    cache_delete(result);
    return true;
}

SavePlayerLicenses(playerid) {
    mysql_format(DBConn, query, sizeof(query), "UPDATE `players_license` SET \
        `license_number` = '%d', \
        `license_status` = '%d', \
        `license_warnings` = '%d', \
		`warning_one` = '%s', \
        `warning_two` = '%s', \
        `warning_three` = '%s', \
		`license_vehicle` = '%d', \
        `license_medical` = '%d', \
        `license_plane` = '%d', \
        `license_gun` = '%d' \
        WHERE `character_id`= '%d';",
		pLicenses[playerid][license_number],
		pLicenses[playerid][license_status],
		pLicenses[playerid][license_warnings],
		pLicenses[playerid][warning_one],
		pLicenses[playerid][warning_two],
		pLicenses[playerid][warning_three],
		pLicenses[playerid][license_vehicle],
		pLicenses[playerid][license_medical],
		pLicenses[playerid][license_plane],
		pLicenses[playerid][license_gun],
		pInfo[playerid][pID]
	);
    mysql_query(DBConn, query);
    return true;
}