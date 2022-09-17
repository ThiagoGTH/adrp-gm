#include <YSI_Coding\y_hooks>

Dialog:Character_Keys(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        static 
			rows, 
			fields;
        
		mysql_format(DBConn, query, sizeof query, "SELECT * FROM character_keys WHERE `keyOwner` = '%d'", pInfo[playerid][pID]);
        new Cache:result = mysql_query(DBConn, query);
		
		new count=0;

		for(new i = 0; i < rows; i++)
		{
			if(count == listitem)	
			{
				pInfo[playerid][pKeySelected] = cache_get_value_name_int(i, "keyID");

				new title[256];
				format(title, 256, "Chave [ID: %d]", pInfo[playerid][pKeySelected]);
				Dialog_Show(playerid, Character_Keys_Options, DIALOG_STYLE_LIST, title, "Dar\nApagar", "Selecionar", "Fechar");
				break;
			}
			else
				count++;
		}

		cache_delete(result);
	}
	return 1;
}

Dialog:Character_Keys_Options(playerid, response, listitem, inputtext[]){
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				new string[256];
				format(string, sizeof(string), "Digite o nome ou ID do jogador:");
				Dialog_Show(playerid, Character_Give_Key, DIALOG_STYLE_INPUT, "Dar chave", string, "Confirmar", "Fechar");
			}
			case 1:
			{
				new log[128];
				format(log, sizeof(log), "%s deletou a chave ID #%d.", ReturnName(playerid, 0), pInfo[playerid][pKeySelected]);
				LogSQL_Create(playerid, log, 28);
				SendServerMessage(playerid, "A chave #%d foi deletada com sucesso.", pInfo[playerid][pKeySelected]);
				DestroyPlayerKey(playerid, pInfo[playerid][pKeySelected]);
				pInfo[playerid][pKeySelected] = 0;
			}
		}
	}
	return 1;
}

Dialog:Character_Give_Key(playerid, response, listitem, inputtext[]) {
	if(response)
	{
 		static
 			userid;

		if (sscanf(inputtext, "u", userid))
		    return Dialog_Show(playerid, Character_Give_Key, DIALOG_STYLE_INPUT, "Dar chave", "Digite o nome ou ID do jogador:", "Confirmar", "Voltar");

		if (userid == INVALID_PLAYER_ID || !SQL_IsLogged(userid))
		    return Dialog_Show(playerid, Character_Give_Key, DIALOG_STYLE_INPUT, "Dar chave", "ERRO: O jogador especificado é inválido.\n\nDigite o nome ou ID do jogador abaixo:", "Continuar", "Voltar");

		if (userid == playerid)
		    return Dialog_Show(playerid, Character_Give_Key, DIALOG_STYLE_INPUT, "Dar chave", "ERRO: Você não pode dar a chave para sí mesmo.\nDigite o nome ou ID do jogador abaixo:", "Continuar", "Voltar");

        if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    	return SendErrorMessage(playerid, "Você deve estar próximo a este jogador.");

		SendServerMessage(playerid, "Você deu uma chave para %s.", ReturnName(userid, 0));
		SendServerMessage(userid, "%s lhe deu uma chave.", ReturnName(playerid, 0));
		SetPlayerKey(userid, pInfo[playerid][pKeySelected]);
		DestroyPlayerKey(playerid, pInfo[playerid][pKeySelected]);
		new log[128];
		format(log, sizeof(log), "%s deu a chave ID #%d para %s.", ReturnName(playerid, 0), pInfo[playerid][pKeySelected], ReturnName(userid, 0));
		LogSQL_Create(playerid, log, 28);

		pInfo[playerid][pKeySelected] = 0;
	}
	return 1;
}

//Check if the player have specific key
GetPlayerThisKey(playerid, type, propertyid)
{
	new query[300];
	format(query, sizeof(query), "SELECT * FROM `character_keys` WHERE `keyOwner` = '%d' AND `keyType` = '%d' AND `keyPropertyID` = '%d'", pInfo[playerid][pID], type, propertyid);

	new Cache:result = mysql_query(g_iHandle, query),
		rows = cache_num_rows();

	//cache_delete(result);

	if(rows > 0){
		cache_delete(result);
		return 1;
	}
	else{
		cache_delete(result);
		return 0;
	}
}

//Set some character key to specific player. This function is used to transfer the key ownership between players
SetPlayerKey(playerid, keyid)
{
	new query[256];
	format(query, sizeof(query), "UPDATE `character_keys` SET `keyOwner` = '%d' WHERE `keyID` = '%d'", pInfo[playerid][pID], keyid);
	mysql_function_query(g_iHandle, query, false, "", "");
	return 1;
}

//Destroy a character key
DestroyPlayerKey(playerid, keyid)
{
	new query[256];
	format(query, sizeof(query), "DELETE FROM `character_keys` WHERE `keyOwner` = '%d' AND `keyID` = '%d'", pInfo[playerid][pID], keyid);
	mysql_function_query(g_iHandle, query, false, "", "");
	return 1;
}

//Create a character key
CreatePlayerKey(playerid, type, propertyid)
{
	new query[512];
	format(query, sizeof(query), "INSERT INTO `character_keys` (`keyOwner`, `keyType`, `keyPropertyID`) VALUES('%d', '%d', '%d')", pInfo[playerid][pID], type, propertyid);
	mysql_function_query(g_iHandle, query, false, "", "");
	return 1;
}

//Reset all keys with the ID
ResetPlayerKey(keyid){

	static 
		rows, 
		fields;

	new query[512];
	format(query, sizeof(query), "SELECT * FROM `character_keys`");
	cache_get_data(rows, fields, g_iHandle);

	for (new i = 0; i < rows; i ++) 
	{
		format(query, sizeof(query), "DELETE FROM `character_keys` WHERE `keyPropertyID` = '%d'", keyid);
		mysql_function_query(g_iHandle, query, false, "", "");
	}
	return 1;
}