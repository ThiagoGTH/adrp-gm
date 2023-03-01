ShowPlayerVehicles(playerid) {
	mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `character_id` = '%d'", GetPlayerSQLID(playerid));
    new Cache:result = mysql_query(DBConn, query);
            
    new string[2048], veh_id, veh_model, veh_color1, veh_color2, veh_pname, veh_name[64], veh_impounded;

    new caravan, caravan_model, caravan_model_name[64];

    if(!cache_num_rows()) return SendErrorMessage(playerid, "Você não possui nenhum veículo.");

    for(new i; i < cache_num_rows(); i++){
        cache_get_value_name_int(i, "ID", veh_id);
		cache_get_value_name_int(i, "model", veh_model);
		cache_get_value_name_int(i, "color1", veh_color1);
		cache_get_value_name_int(i, "color2", veh_color2);
		cache_get_value_name_int(i, "personalized_name", veh_pname);
		cache_get_value_name(i, "name", veh_name);
        cache_get_value_name_int(i, "impounded", veh_impounded);
        cache_get_value_name_int(i, "caravan", caravan);

        if(caravan != 0){
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles_caravan WHERE `vehicle_id` = '%d'", veh_id);
            new Cache:result2 = mysql_query(DBConn, query);
            cache_get_value_name_int(0, "caravan_model_id", caravan_model);
            cache_get_value_name(0, "caravan_model_name", caravan_model_name);
            cache_delete(result2);
        }
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `character_id` = '%d'", GetPlayerSQLID(playerid));
        result = mysql_query(DBConn, query);
        
        if(!vInfo[veh_id][vVehicle] && caravan != 0) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, 0, 0)\t~w~%s~n~~n~~n~~n~ID Registro~n~~w~%d\n", string, caravan_model, caravan_model_name, veh_id);
        else if(vInfo[veh_id][vVehicle] && caravan != 0) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, 0, 0)\t~g~%s~n~~n~~n~~n~ID Real~n~~w~%d\n", string, caravan_model, caravan_model_name, vInfo[veh_id][vVehicle]);
        else if(!vInfo[veh_id][vVehicle] && veh_pname != 0 && veh_impounded != 0) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~ID Registro~n~~w~%d\n", string, veh_model, veh_color1, veh_color2, veh_name, veh_id);
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

				if(veh_pname != 0) SendServerMessage(playerid, "Seu veículo %s foi spawnado.", veh_name);
				else SendServerMessage(playerid, "Seu veículo %s foi spawnado.", ReturnVehicleModelName(veh_model));

                LoadVehicle(veh_id);
				if(vInfo[veh_id][vVW] == 0) {
					va_SendClientMessage(playerid, 0xFF00FFFF, "INFO: Você pode usar a marca vermelha no mapa para achar seu veiculo.");
					SetPlayerCheckpoint(playerid, vInfo[veh_id][vPos][0], vInfo[veh_id][vPos][1], vInfo[veh_id][vPos][2], 3.0);
				}
			} else count ++;
		}
		cache_delete(result);
	}
    return true;
}