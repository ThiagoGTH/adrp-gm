LoadPlayerLicences(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_licence WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);

	cache_get_value_name_int(0, "licence_number", pLicences[playerid][licence_number]);
	cache_get_value_name_int(0, "licence_status", pLicences[playerid][licence_status]);
	cache_get_value_name_int(0, "licence_warnings", pLicences[playerid][licence_warnings]);

	cache_get_value_name_int(0, "licence_vehicle", pLicences[playerid][licence_vehicle]);
	cache_get_value_name_int(0, "licence_plane", pLicences[playerid][licence_plane]);
	cache_get_value_name_int(0, "licence_medical", pLicences[playerid][licence_medical]);
	cache_get_value_name_int(0, "licence_gun", pLicences[playerid][licence_gun]);

    cache_get_value(0, "warning_one", pLicences[playerid][warning_one], MAX_DRIVERLICENCE_WAR);
	cache_get_value(0, "warning_two", pLicences[playerid][warning_two], MAX_DRIVERLICENCE_WAR);
	cache_get_value(0, "warning_three", pLicences[playerid][warning_three], MAX_DRIVERLICENCE_WAR);

    cache_delete(result);
    return true;
}

SavePlayerLicences(playerid) {
    mysql_format(DBConn, query, sizeof(query), "UPDATE `players_licence` SET \
        `licence_number` = '%i', \
        `licence_status` = '%i', \
        `licence_warnings` = '%i', \
		`warning_one` = '%s', \
        `warning_two` = '%s', \
        `warning_three` = '%s', \
		`licence_vehicle` = '%i', \
        `licence_medical` = '%i', \
        `licence_plane` = '%i', \
        `licence_gun` = '%i' \
        WHERE `character_id`= '%i';",
		pLicences[playerid][licence_number],
		pLicences[playerid][licence_status],
		pLicences[playerid][licence_warnings],
		pLicences[playerid][warning_one],
		pLicences[playerid][warning_two],
		pLicences[playerid][warning_three],
		pLicences[playerid][licence_vehicle],
		pLicences[playerid][licence_medical],
		pLicences[playerid][licence_plane],
		pLicences[playerid][licence_gun],
		pInfo[playerid][pID]
	);
    mysql_query(DBConn, query);
    return true;
}