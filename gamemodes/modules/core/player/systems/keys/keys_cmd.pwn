CMD:copiarchave(playerid, params[]) {
    new type[16];

    if(sscanf(params, "s[16]", type)) {
        SendClientMessage(playerid, COLOR_BEGE, "_______________________________________________________________________");
        SendClientMessage(playerid, COLOR_BEGE, "USE: /copiarchave [opção]");
        SendClientMessage(playerid, COLOR_BEGE, "[Opções] casa, veiculo");
        SendClientMessage(playerid, COLOR_BEGE, "[Casa] Faz uma cópia da chave de uma de suas casas.");
        SendClientMessage(playerid, COLOR_BEGE, "[Veiculo] Faz uma cópia da chave de um dos seus veículos.");
        SendClientMessage(playerid, COLOR_BEGE, "_______________________________________________________________________");
        return 1;
    } 

    if(!strcmp(type, "casa", true)) {
        new houseID = GetNearestHouseEntry(playerid);

        if(!houseID || hInfo[houseID][hOwner] != pInfo[playerid][pID])
            return SendErrorMessage(playerid, "Você não está próximo de nenhuma casa sua.");
        
        CreatePropertyKey(playerid, houseID, 1);

        return 1;
    }

    if(!strcmp(type, "veiculo", true)) {
        new vehicleID = GetPlayerVehicleID(playerid);

        if(!vehicleID)
            return SendErrorMessage(playerid, "Você não está dentro de nenhum veículo.");

        if(vInfo[vehicleID][vOwner] != pInfo[playerid][pID])
            return SendErrorMessage(playerid, "Você não está em nenhum de seus veículos.");
        
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 
            return SendErrorMessage(playerid, "Você deve ser o motorista do veículo para usar esse comando.");

        CreatePropertyKey(playerid, vehicleID, 2);

        return 1;
    }


    return 1;
}


CMD:chaves(playerid, params[]) {

	mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `players_keys` WHERE `character_id` = %d", pInfo[playerid][pID]);
	new Cache:result = mysql_query(DBConn, query);
	
	new count = 0;
    new rows = cache_num_rows();
	new string[1536];
	string[0] = '\0';
	new keyType, keyPropertyID, keyName[64];

	for(new i = 0; i < rows; i++){
        cache_get_value_name_int(i, "key_type", keyType);
        cache_get_value_name_int(i, "property_id", keyPropertyID);
        cache_get_value_name(i, "key_name", keyName);

        new cacheValue = cache_num_rows();

        printf("cache_num_rows: %d", cacheValue);
        printf("VALOR DE i: %d", i);
        printf("PRIMEIRO VALOR STRING:");
        printf(string);

        // Casa
		if(keyType == 1){
            new houseId = hInfo[keyPropertyID][hID];
            
            if(houseId != -1) {
                if(IsValidHouse(keyPropertyID)){
                    new newKeyName[64];

                    if(strlen(keyName) > 64)
                        format(newKeyName, sizeof(newKeyName), "%.64s...", keyName);

                    else if(strlen(keyName) < 64)
                        format(newKeyName, sizeof(newKeyName), "%s", keyName);

                    strcat(string, newKeyName);
                    strcat(string, "\n");
                }
            }
		}

        //Carro 
        else if(keyType == 2){
		    new vehicleId = vInfo[keyPropertyID][vID];

			if(vehicleId != -1) {
				if(vInfo[vehicleId][vExists]){
                    new newKeyName[64];

                    if(strlen(keyName) > 64)
                        format(newKeyName, sizeof(newKeyName), "%.64s...", keyName);

                    else if(strlen(keyName) < 64)
                        format(newKeyName, sizeof(newKeyName), "%s", keyName);

                    strcat(string, newKeyName);
                    strcat(string, "\n");
                }
            }
		}

        printf("ULTIMO VALOR STRING:");
        printf(string);

		count++;
	}
	
	cache_delete(result);

	new title[250];

	if(count == 0)
		return SendErrorMessage(playerid, "Você não possui nenhuma chave.");
	else if(count == 1)
		format(title, sizeof title, "Chaves de %s (1 chave encontrada)", GetPlayerNameEx(playerid));
	else
		format(title, sizeof title, "Chaves de %s (%d chaves encontradas)", GetPlayerNameEx(playerid), count);
	
	Dialog_Show(playerid, Player_Keys, DIALOG_STYLE_LIST, title, string, "Selecionar", "Fechar");
	return 1;
}