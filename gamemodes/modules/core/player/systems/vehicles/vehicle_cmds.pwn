#include <YSI_Coding\y_hooks>

CMD:darveiculo(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

	static userid, model[32];
	if (sscanf(params, "us[32]", userid, model)) return SendSyntaxMessage(playerid, "/darveiculo [id/nome] [id do modelo/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if ((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "O modelo especificado � inv�lido.");

	static Float:x, Float:y, Float:z, Float:a, id = -1;
    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, a);
	SetPlateFree(playerid);

    id = VehicleCreate(pInfo[userid][pID], model[0], x, y + 2, z + 1, a, random(127), random(127), pInfo[playerid][pBuyingPlate]);

	pInfo[playerid][pBuyingPlate][0] = EOS;

	if (id == -1) 
        return SendErrorMessage(playerid, "O servidor chegou ao limite m�ximo de ve�culos din�micos.");

	SendServerMessage(playerid, "Voc� criou um %s (ID REAL: %d) para %s.", ReturnVehicleModelName(model[0]), vInfo[id][vVehicle], pNome(userid));

	format(logString, sizeof(logString), "%s (%s) criou um %s para %s", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(model[0]), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:editarveiculo(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);

	static 
		id, 
		type[24], 
		string[128];

	if (sscanf(params, "ds[24]S()[128]", id, type, string)){
	 	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		 	SendClientMessage(playerid, COLOR_BEGE, "USE: /editarveiculo [id] [op��o]");
		    SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: dono, localiza��o, fac��o, empresa, cor, modelo");
			SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: bateria, motor, milhas, seguro, trava, alarme");
		    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
			return true;
		}

	if (!IsValidVehicle(id) || VehicleGetID(id) == -1) return SendErrorMessage(playerid, "Voc� especificou um ve�culo inv�lido.");

	id = VehicleGetID(id);
	
	if (!strcmp(type, "dono", true) || !strcmp(type, "proprietario", true)){
		new userid;
		if (sscanf(string, "u", userid)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [dono] [novo dono]");

		SendServerMessage(playerid, "Voc� alterou de %s para %s como novo dono do %s (ID: %d).", pNome(vInfo[id][vOwner]), pNome(userid), ReturnVehicleModelName(vInfo[id][vModel]), vInfo[id][vVehicle]);

		SendServerMessage(userid, "%s setou voc� como dono do ve�culo %s (%d).", GetPlayerUserEx(playerid), ReturnVehicleModelName(vInfo[id][vModel]), vInfo[id][vVehicle]);

		format(logString, sizeof(logString), "%s (%s) alterou de %s para %s como novo dono do %s (ID: %d/SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), pNome(vInfo[id][vOwner]), pNome(userid), ReturnVehicleModelName(vInfo[id][vModel]), vInfo[id][vVehicle], vInfo[id][vSQLID]);
		logCreate(playerid, logString, 1);

		vInfo[id][vOwner] = pInfo[userid][pID];
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "localizacao", true) || !strcmp(type, "localiza��o", true)){
		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
			GetVehiclePos(GetPlayerVehicleID(playerid), vInfo[id][vPos][0], vInfo[id][vPos][1], vInfo[id][vPos][2]);
			GetVehicleZAngle(GetPlayerVehicleID(playerid), vInfo[id][vPos][3]);
		} else {
	 		GetPlayerPos(playerid, vInfo[id][vPos][0], vInfo[id][vPos][1], vInfo[id][vPos][2]);
			GetPlayerFacingAngle(playerid, vInfo[id][vPos][3]);
		}

		vInfo[id][vVW] = GetPlayerVirtualWorld(playerid);
		vInfo[id][vInterior] = GetPlayerInterior(playerid);

		SaveVehicle(id); SpawnVehicle(id);

		SetPlayerPos(playerid, vInfo[id][vPos][0], vInfo[id][vPos][1], vInfo[id][vPos][2] + 2.0);

		SendServerMessage(playerid, "Voc� ajustou a localiza��o do ve�culo ID %d.", vInfo[id][vVehicle]);

		format(logString, sizeof(logString), "%s (%s) ajustou a localiza��o do ve�culo ID %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
		logCreate(playerid, logString, 1);
	}
	else if (!strcmp(type, "faccao", true) || !strcmp(type, "fac��o", true)){
		new factionid;
		if (sscanf(string, "d", factionid)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [fac��o] [id fac��o] (-1 remove de fac��o)");

		if(factionid == -1){
			SendServerMessage(playerid, "Voc� removeu o status faccional do ve�culo ID %d.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) removeu o status faccional do ve�culo %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
			logCreate(playerid, logString, 1);
		} else {
			SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d na fac��o ID %d.", vInfo[id][vVehicle], factionid);

			format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)na fac��o ID %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], factionid);
			logCreate(playerid, logString, 1);
		}

		vInfo[id][vFaction] = factionid;
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "empresa", true)){
		new bizid;
		if (sscanf(string, "d", bizid)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [empresa] [id empresa] (-1 remove de empresa)");

		if(bizid == -1){
			SendServerMessage(playerid, "Voc� removeu o status empresarial do ve�culo ID %d.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) removeu o status empresarial do ve�culo %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
			logCreate(playerid, logString, 1);
		} else {
			SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d na empresa ID %d.", vInfo[id][vVehicle], bizid);

			format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)na empresa ID %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], bizid);
			logCreate(playerid, logString, 1);
		}

		vInfo[id][vBusiness] = bizid;
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "cor", true)){
		new color1, color2;
		if (sscanf(string, "dd", color1, color2)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [cor] [cor 1] [cor 2]");

		vInfo[id][vColor1] = color1;
		vInfo[id][vColor2] = color2;
		SaveVehicle(id); SpawnVehicle(id);
		SendServerMessage(playerid, "Voc� definiu as cores do ve�culo %d como %d e %d.", vInfo[id][vVehicle], color1, color2);

		format(logString, sizeof(logString), "%s (%s) definiu as cores do ve�culo ID %d (SQL: %d) como %d e %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], color1, color2);
		logCreate(playerid, logString, 1);
	}
	return true;
}

CMD:veiculos(playerid, params[]) {
	mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `character_id` = '%d'", GetPlayerSQLID(playerid));
    new Cache:result = mysql_query(DBConn, query);
            
    new string[2048], veh_id, veh_model, veh_color1, veh_color2;

    if(!cache_num_rows()) return SendErrorMessage(playerid, "Voc� n�o possui nenhum ve�culo");

    for(new i; i < cache_num_rows(); i++){
        cache_get_value_name_int(i, "ID", veh_id);
		cache_get_value_name_int(i, "model", veh_model);
		cache_get_value_name_int(i, "color1", veh_color1);
		cache_get_value_name_int(i, "color2", veh_color2);
        
		if(vInfo[veh_id][vVehicle]) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~ID Real~n~~w~%d\n", string, veh_model, veh_color1, veh_color2, ReturnVehicleModelName(veh_model), vInfo[veh_id][vVehicle]);
		else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~w~%s~n~~n~~n~~n~ID Registro~n~~w~%d\n", string, veh_model, veh_color1, veh_color2, ReturnVehicleModelName(veh_model), veh_id);
    }
    cache_delete(result);

	new title[128];
	format(title, 128, "_______________Ve�culos_de_%s", pNome(playerid));
	AdjustTextDrawString(title);

    Dialog_Show(playerid, showVehicles, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Spawnar", "Fechar");
	return true;
}

Dialog:showVehicles(playerid, response, listitem, inputtext[]){
    if(response){
		new count = 0, veh_id;

		mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `character_id` = '%d'", GetPlayerSQLID(playerid));
    	new Cache:result = mysql_query(DBConn, query);

		for(new i; i < cache_num_rows(); i++) {
        	cache_get_value_name_int(i, "ID", veh_id);
			if(count == listitem) {
				if(vInfo[veh_id][vVehicle]) {
					SendErrorMessage(playerid, "Este ve�culo j� est� spawnado.");
					break;
				}

				LoadVehicle(veh_id);
				SendServerMessage(playerid, "Seu ve�culo %s foi spawnado.", ReturnVehicleModelName(listitem));
				if(vInfo[i][vVW] == 0) {
					va_SendClientMessage(playerid, 0xFF00FFFF, "INFO: Voc� pode usar a marca vermelha no mapa para achar seu veiculo.");
					SetPlayerCheckpoint(playerid, vInfo[veh_id][vPos][0], vInfo[veh_id][vPos][1], vInfo[veh_id][vPos][2], 3.0);
				}
				printf("veh_id: %d", veh_id);
			} else count ++;
		}
		cache_delete(result);

		printf("listitem %d", listitem);
		printf("inputtext[] %s %d", inputtext, inputtext);
	}
    return true;
}