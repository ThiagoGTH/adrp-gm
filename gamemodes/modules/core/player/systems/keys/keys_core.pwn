#include <YSI_Coding\y_hooks>

enum E_KEY_DATA {
    kID,
    kOwner,
    kType,
    kProperty,
    kName[256],
    kModel,
}

new kInfo[MAX_PLAYERS][E_KEY_DATA];

SavePlayerKeys(playerId) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `players_keys` WHERE `character_id` = %d;", playerId);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `players_keys` SET `key_type` = %d, `property_id` = %d, `key_name` = %s, `key_model` = %d WHERE `character_id` = %d;",
        kInfo[playerId][kType], kInfo[playerId][kProperty], kInfo[playerId][kName], kInfo[playerId][kModel], playerId);
    mysql_query(DBConn, query);

    return 1;
}

LoadPlayerKeys(playerId) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `players_keys` WHERE `character_id` = %d;", playerId);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;
    
    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        kInfo[playerId][kID] = id;

        cache_get_value_name_int(i, "character_id", kInfo[playerId][kOwner]);
        cache_get_value_name_int(i, "key_type", kInfo[playerId][kType]);
        cache_get_value_name_int(i, "property_id", kInfo[playerId][kProperty]);
        cache_get_value_name(i, "key_name", kInfo[playerId][kName]);
        cache_get_value_name_int(i, "key_model", kInfo[playerId][kModel]);
    }

    return 1;
}

CreatePropertyKey(playerId, propertyId, propertyType, bool:renting){
    new keyModel, keyName[256];

    if(propertyType == 1){
        keyModel = 1147;
        format(keyName, sizeof(keyName), "Chave da casa em %s. ((ID: %d))", hInfo[propertyId][hAddress], hInfo[propertyId][hID]);
    } 
    if(propertyType == 2){
        keyModel = 1150;
        if(vInfo[propertyId][vLegal] == 0 && vInfo[propertyId][vNamePersonalized]){
            format(keyName, sizeof(keyName), "Chave do veiculo %s. ((%s - ID: %d))", 
                vInfo[propertyId][vName], 
                ReturnVehicleModelName(vInfo[propertyId][vModel]), 
                propertyId);
        }

        if(vInfo[propertyId][vLegal] == 0 && !vInfo[propertyId][vNamePersonalized]){
            format(keyName, sizeof(keyName), "Chave de um veiculo. ((%s - ID: %d))", 
                ReturnVehicleModelName(vInfo[propertyId][vModel]), 
                propertyId);        
        }
    }

    mysql_format(DBConn, query, sizeof query,
        "INSERT INTO players_keys (`character_id`, `property_id`, `key_type`, `key_name`, `key_model`) VALUES (%d, %d, %d, '%s', %d);",
            pInfo[playerId][pID], propertyId, propertyType, keyName, keyModel);
    mysql_query(DBConn, query);

    LoadPlayerKeys(playerId);

    new id = cache_insert_id();

    kInfo[playerId][kID] = id;
    kInfo[playerId][kOwner] = pInfo[playerId][pID];
    kInfo[playerId][kProperty] = propertyId;
    kInfo[playerId][kType] = propertyType;
    kInfo[playerId][kName] = keyName;
    kInfo[playerId][kModel] = keyModel;

    if(renting)
        format(logString, sizeof(logString), "%s recebeu uma cópia da chave ID #%d.", GetPlayerNameEx(playerId), pInfo[playerId][pKeySelected]);
	    logCreate(playerId, logString, 18);
    else
        format(logString, sizeof(logString), "%s criou uma chave ID #%d.", GetPlayerNameEx(playerId), pInfo[playerId][pKeySelected]);
        logCreate(playerId, logString, 18);

    SavePlayerKeys(playerId);

    switch(propertyType){
        case 1:{

            va_SendClientMessage(playerId, -1, "Você recebeu uma cópia da chave da casa no endereço %s. ((%d))", GetHouseAddress(propertyId), propertyId);

            return 1;
        }

        case 2:{
            if(vInfo[propertyId][vLegal] == 0 && vInfo[propertyId][vNamePersonalized]){
                va_SendClientMessage(playerId, -1, 
                    "Você fez uma cópia da chave do seu carro modelo %s. ((%s - ID: %d))", 
                    vInfo[propertyId][vName], 
                    ReturnVehicleModelName(vInfo[propertyId][vModel]), 
                    propertyId
                );
            }

            else if(vInfo[propertyId][vLegal] == 0 && !vInfo[propertyId][vNamePersonalized]){
                va_SendClientMessage(playerId, -1, 
                    "Você fez uma cópia da chave do seu carro. ((%s - ID: %d))", 
                    ReturnVehicleModelName(vInfo[propertyId][vModel]), 
                    propertyId
                );
            }
            
	        else if(vInfo[propertyId][vNamePersonalized]){
                va_SendClientMessage(playerId, -1, 
                    "Você fez uma cópia da chave do seu carro modelo %s, de placa %s. ((%s - ID: %d))", 
                    vInfo[propertyId][vName], 
                    vInfo[propertyId][vPlate], 
                    ReturnVehicleModelName(vInfo[propertyId][vModel]), 
                    propertyId
                );
            }
	        else va_SendClientMessage(playerId, -1, 
                    "Você fez uma cópia da chave do seu carro de placa %s. ((%s - ID: %d))", 
                    vInfo[propertyId][vPlate], 
                    ReturnVehicleModelName(vInfo[propertyId][vModel]), 
                    propertyId
                );

	        return 1;
        }
    }

    return 1;
}

SetPlayerKey(playerId, keyid){
	mysql_format(DBConn, query, sizeof query, "UPDATE `players_keys` SET `character_id` = %d WHERE `property_id` = %d", pInfo[playerId][pID], keyid);
	mysql_query(DBConn, query);

	return 1;
}

DestroyPlayerKey(playerId, keyid){
	mysql_format(DBConn, query, sizeof query, "DELETE FROM `players_keys` WHERE `character_id` = %d AND `ID` = %d", pInfo[playerId][pID], keyid);
	mysql_query(DBConn, query);

	return 1;
}

Dialog:Player_Keys(playerId, response, listitem, inputtext[]){
    if(response){
        
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_keys WHERE `character_id` = %d", pInfo[playerId][pID]);
        new Cache:result = mysql_query(DBConn, query);

        new count = 0;

        for(new i = 0; i < cache_num_rows(); i++){
            if(count == listitem){

                cache_get_value_name_int(i, "ID", pInfo[playerId][pKeySelected]);

                new title[256];
                format(title, 256, "Chave [ID: %d]", pInfo[playerId][pKeySelected]);

                Dialog_Show(playerId, Key_Options, DIALOG_STYLE_LIST, title, "Dar\nApagar", "Selecionar", "Fechar");

                break;
            }
            else{
                count++;
            }
        }

        cache_delete(result);
    }
    return 1;
}

Dialog:Key_Options(playerId, response, listitem, inputtext[]){
	if(response)
	{
		switch(listitem)
		{
			case 0:{
				new string[256];
				format(string, sizeof(string), "Digite o nome ou ID do jogador:");
				Dialog_Show(playerId, Character_Give_Key, DIALOG_STYLE_INPUT, "Dar chave", string, "Confirmar", "Fechar");
			}
			case 1:{
				format(logString, sizeof(logString), "%s deletou a chave ID #%d.", GetPlayerNameEx(playerId), pInfo[playerId][pKeySelected]);
				logCreate(playerId, logString, 18);

				SendServerMessage(playerId, "A chave #%d foi deletada com sucesso.", pInfo[playerId][pKeySelected]);
				DestroyPlayerKey(playerId, pInfo[playerId][pKeySelected]);

				pInfo[playerId][pKeySelected] = 0;
			}
		}
	}
	return 1;
}

Dialog:Character_Give_Key(playerId, response, listitem, inputtext[]) {
	if(response){
 		new userid;

		if (sscanf(inputtext, "u", userid))
		    return Dialog_Show(playerId, Character_Give_Key, DIALOG_STYLE_INPUT, "Dar chave", "Digite o nome ou ID do jogador:", "Confirmar", "Voltar");

		if (userid == INVALID_PLAYER_ID)
		    return Dialog_Show(playerId, Character_Give_Key, DIALOG_STYLE_INPUT, "Dar chave", "ERRO: O jogador especificado é inválido.\n\nDigite o nome ou ID do jogador abaixo:", "Continuar", "Voltar");

		if (userid == playerId)
		    return Dialog_Show(playerId, Character_Give_Key, DIALOG_STYLE_INPUT, "Dar chave", "ERRO: Você não pode dar a chave para sí mesmo.\nDigite o nome ou ID do jogador abaixo:", "Continuar", "Voltar");

        if (!IsPlayerNearPlayer(playerId, userid, 5.0))
	    	return SendErrorMessage(playerId, "Você deve estar próximo a este jogador.");

		SendServerMessage(playerId, "Você deu uma chave para %s.", GetPlayerNameEx(userid));
		SendServerMessage(userid, "%s lhe deu uma chave.", GetPlayerNameEx(playerId));

		SetPlayerKey(userid, pInfo[playerId][pKeySelected]);
		DestroyPlayerKey(playerId, pInfo[playerId][pKeySelected]);

		new log[200];
		format(log, sizeof(log), "%s deu a chave ID #%d para %s.", GetPlayerNameEx(playerId), pInfo[playerId][pKeySelected], GetPlayerNameEx(userid));
		logCreate(playerId, log, 15);

		pInfo[playerId][pKeySelected] = 0;
	}

	return 1;
}