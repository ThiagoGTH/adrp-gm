#include <YSI_Coding\y_hooks>

/* =============================== PLAYERS =============================== */
CMD:placa(playerid, params[]) {
	new vehicleid = VehicleNearest(playerid);
	if(vehicleid == -1) return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo de nenhum veiculo.");
	
	SendClientMessage(playerid, COLOR_GREEN, "|_________ San Andreas Plate _________|");
	if(!strcmp(vInfo[vehicleid][vPlate], "Invalid", true) && vInfo[vehicleid][vNamePersonalized]) va_SendClientMessage(playerid, -1, "Ve�culo n�o emplacado (( %s (%s) ))", vInfo[vehicleid][vName], ReturnVehicleModelName(vInfo[vehicleid][vModel]));
	else if(!strcmp(vInfo[vehicleid][vPlate], "Invalid", true) && vInfo[vehicleid][vNamePersonalized]) va_SendClientMessage(playerid, -1, "Ve�culo n�o emplacado (( %s ))", ReturnVehicleModelName(vInfo[vehicleid][vModel]));
	else if(vInfo[vehicleid][vNamePersonalized]) va_SendClientMessage(playerid, -1, "Placa: %s (( %s (%s) ))", vInfo[vehicleid][vPlate], vInfo[vehicleid][vName], ReturnVehicleModelName(vInfo[vehicleid][vModel]));
	else va_SendClientMessage(playerid, -1, "Placa: %s (( %s ))", vInfo[vehicleid][vPlate], ReturnVehicleModelName(vInfo[vehicleid][vModel]));
	return true;
}

CMD:veiculos(playerid, params[]) {
	ShowPlayerVehicles(playerid);
	return true;
}

CMD:v(playerid, params[]) {
	new type[128];
	if (sscanf(params, "s[128]", type)) {
 	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /v [a��o]");
		SendClientMessage(playerid, COLOR_BEGE, "[A��es]: lista, estacionar, mudarvaga, venderconce, stats");
		SendClientMessage(playerid, COLOR_BEGE, "[A��es]: trancar, portamalas, upgrade, placa, removerplaca");
		SendClientMessage(playerid, COLOR_BEGE, "[Deletar]: deletar (n�o recebe nada)");
		SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		return true;
	}
	if (!strcmp(type, "lista", true)) return ShowPlayerVehicles(playerid);
	else if (!strcmp(type, "estacionar", true)) return ParkPlayerVehicle(playerid);
	else if (!strcmp(type, "mudarvaga", true)) return ChangeParkPlayerVehicle(playerid);

	return true;
}

/* =============================== ADMINS =============================== */
CMD:criarveiculo(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);

	static model[32], type, color1, color2, id = -1, value = 0;

	if (sscanf(params, "s[32]dddd", model, type, color1, color2, value)){
		SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /criarveiculo [modelo id/nome] [tipo] [cor 1] [cor 2] [id do tipo]");
	 	SendClientMessage(playerid, COLOR_BEGE, "[Tipos]: 1. Fac��o | 2. Empresa | 3. Emprego");
	 	SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	 	return true;
	}
	if ((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "O modelo especificado � inv�lido.");

	if (type < 1 || type > 3) return SendErrorMessage(playerid, "O tipo especificado � inv�lido. Os tipos variam entre 1 e 3.");

	if (color1 < 0 || color1 > 255) return SendErrorMessage(playerid, "As cores devem estar entre 0 e 255.");

	if (color2 < 0 || color2 > 255) return SendErrorMessage(playerid, "As cores devem estar entre 0 e 255.");

	if (value < 0) return SendErrorMessage(playerid, "O ID do tipo � referente ao ID da categoria. Esse valor n�o pode ser menor que 0.");

	static Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	SetPlateFree(playerid);

	if(type == 1) id = VehicleCreate(0, model[0], x, y + 2, z + 1, a, color1, color2, pInfo[playerid][pBuyingPlate], 0, 0, 0, value, 0, 0);
	else if(type == 2) id = VehicleCreate(0, model[0], x, y + 2, z + 1, a, color1, color2, pInfo[playerid][pBuyingPlate], 0, 0, 0, 0, value, 0);
	else if(type == 3) id = VehicleCreate(0, model[0], x, y + 2, z + 1, a, color1, color2, pInfo[playerid][pBuyingPlate], 0, 0, 0, 0, 0, value);

	pInfo[playerid][pBuyingPlate][0] = EOS;

	if (id == -1) return SendErrorMessage(playerid, "O servidor chegou ao limite m�ximo de ve�culos din�micos.");

	new style[32];
	switch(type){
		case 1: format(style, 32, "a fac��o");
		case 2: format(style, 32, "a empresa");
		case 3: format(style, 32, "o emprego");
	}

	SendServerMessage(playerid, "Voc� criou um %s para %s ID %d.", ReturnVehicleModelName(model[0]), style, value);

	format(logString, sizeof(logString), "%s (%s) criou um %s para %s ID %d", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(model[0]), style, value);
	logCreate(playerid, logString, 1);
	return true;
}

CMD:darveiculo(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

	static userid, model[32], legal;
	if (sscanf(params, "us[32]d", userid, model, legal)) return SendSyntaxMessage(playerid, "/darveiculo [id/nome] [id do modelo/nome] [legalizado? (1 sim, 2 n�o)]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if ((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "O modelo especificado � inv�lido.");

	static Float:x, Float:y, Float:z, Float:a, id = -1;
    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, a);
	if(legal == 1) SetPlateFree(playerid);
	else if(legal == 2) format(pInfo[playerid][pBuyingPlate], 120, "Invalid");

    id = VehicleCreate(pInfo[userid][pID], model[0], x, y + 2, z + 1, a, random(127), random(127), pInfo[playerid][pBuyingPlate]);

	pInfo[playerid][pBuyingPlate][0] = EOS;

	if (id == -1) return SendErrorMessage(playerid, "O servidor chegou ao limite m�ximo de ve�culos din�micos.");

	SendServerMessage(playerid, "Voc� criou um %s para %s.", ReturnVehicleModelName(model[0]), pNome(userid));

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
		SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: dono, localiza��o, fac��o, empresa, cor, modelo, nome");
		SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: seguro, sunpass, alarme, combustivel, bateria, motor, milhas");
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

		format(logString, sizeof(logString), "%s (%s) alterou de %s para %s como novo dono do %s (ID: %d/SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), pNome(vInfo[id][vOwner]), pNome(userid), ReturnVehicleModelName(vInfo[id][vModel]), vInfo[id][vVehicle], vInfo[id][vID]);
		logCreate(playerid, logString, 1);

		vInfo[id][vOwner] = pInfo[userid][pID];
		SaveVehicle(id);
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

		format(logString, sizeof(logString), "%s (%s) ajustou a localiza��o do ve�culo ID %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID]);
		logCreate(playerid, logString, 1);
	}
	else if (!strcmp(type, "faccao", true) || !strcmp(type, "fac��o", true)){
		new factionid;
		if (sscanf(string, "d", factionid)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [fac��o] [id fac��o] (0 remove de fac��o)");

		if(factionid == 0){
			SendServerMessage(playerid, "Voc� removeu o status faccional do ve�culo ID %d.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) removeu o status faccional do ve�culo %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID]);
			logCreate(playerid, logString, 1);
		} else {
			SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d na fac��o ID %d.", vInfo[id][vVehicle], factionid);

			format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)na fac��o ID %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], factionid);
			logCreate(playerid, logString, 1);
		}

		vInfo[id][vFaction] = factionid;
		SaveVehicle(id);
	}
	else if (!strcmp(type, "empresa", true)){
		new bizid;
		if (sscanf(string, "d", bizid)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [empresa] [id empresa] (0 remove de empresa)");

		if(bizid == 0){
			SendServerMessage(playerid, "Voc� removeu o status empresarial do ve�culo ID %d.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) removeu o status empresarial do ve�culo %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID]);
			logCreate(playerid, logString, 1);
		} else {
			SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d na empresa ID %d.", vInfo[id][vVehicle], bizid);

			format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)na empresa ID %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], bizid);
			logCreate(playerid, logString, 1);
		}

		vInfo[id][vBusiness] = bizid;
		SaveVehicle(id);
	}
	else if (!strcmp(type, "cor", true)){
		new color1, color2;
		if (sscanf(string, "dd", color1, color2)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [cor] [cor 1] [cor 2]");

		if (color1 < 0 || color1 > 255)
			return SendErrorMessage(playerid, "As cores devem estar entre 0 e 255.");

		if (color2 < 0 || color2 > 255)
			return SendErrorMessage(playerid, "As cores devem estar entre 0 e 255.");

		//vInfo[id][vColor1] = color1;
		//vInfo[id][vColor2] = color2;
		SetVehicleColor(id, color1, color2);
		//SaveVehicle(id);
		SendServerMessage(playerid, "Voc� definiu as cores do ve�culo %d como %d e %d.", vInfo[id][vVehicle], color1, color2);

		format(logString, sizeof(logString), "%s (%s) definiu as cores do ve�culo ID %d (SQL: %d) como %d e %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], color1, color2);
		logCreate(playerid, logString, 1);
	}
	else if (!strcmp(type, "modelo", true)){
		new model[32];
		if (sscanf(string, "s[32]", model)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [modelo] [novo modelo]");
		if ((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "O modelo especificado � inv�lido.");

		
		SendServerMessage(playerid, "Voc� alterou o modelo do ve�culo %d de %d para %d.", vInfo[id][vVehicle], vInfo[id][vModel], model);

		format(logString, sizeof(logString), "%s (%s) alterou o modelo do ve�culo %d (SQLID: %d) de %d para %d.", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], vInfo[id][vModel], model);
		logCreate(playerid, logString, 1);

		vInfo[id][vModel] = model[0];
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "nome", true)){
		new name[64];
		if (sscanf(string, "s[64]", name)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [nome] [nome do ve�culo] ('nenhum' para retirar)");

		if(strlen(name) > 32) return SendErrorMessage(playerid, "O nome do ve�culo n�o pode passar de 32 caracteres.");

		if(!strcmp(params, "nenhum", true)){
			vInfo[id][vNamePersonalized] = 0;
			format(vInfo[id][vName], 64, " ");
			SaveVehicle(id);
			SendServerMessage(playerid, "Voc� removeu o nome do ve�culo ID %d.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) removeu o nome do ve�culo ID %d (SQLID: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID]);
			logCreate(playerid, logString, 1);
			return true;
		} else {
			vInfo[id][vNamePersonalized] = 1;
			format(vInfo[id][vName], 64, name);
			SaveVehicle(id);
			SendServerMessage(playerid, "Voc� definiu o nome do ve�culo ID %d como %s.", vInfo[id][vVehicle], name);

			format(logString, sizeof(logString), "%s (%s) definiu o nome do ve�culo ID %d (SQLID: %d) como %s.", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], name);
			logCreate(playerid, logString, 1);
			return true;
		}
	}
	else if (!strcmp(type, "seguro", true)){
		new insurance;
		if (sscanf(string, "d", insurance)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [seguro] [n�vel do seguro]");

		if(insurance < 0 || insurance > 3) return SendErrorMessage(playerid, "Voc� especificou um n�vel de seguro inv�lido.");

		SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d com seguro n�vel %d.", vInfo[id][vVehicle], insurance);

		format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)com seguro n�vel %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], insurance);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vInsurance] = insurance;
		SaveVehicle(id);
	}
	else if (!strcmp(type, "sunpass", true)){
		new sunpass;
		if (sscanf(string, "d", sunpass)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [sunpass] [(1 ativa e 0 desativa)]");

		if(sunpass == 0){
			SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d como sem sunpass.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d) como sem sunpass", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID]);
			logCreate(playerid, logString, 1);

			vInfo[id][vSunpass] = sunpass;
			SaveVehicle(id);
			return true;
		} else if(sunpass == 1) {
			SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d com sunpass.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d) com sunpass", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID]);
			logCreate(playerid, logString, 1);
			vInfo[id][vSunpass] = sunpass;
			SaveVehicle(id);
			return true;
		} else return SendErrorMessage(playerid, "Voc� definiu um valor inv�lido.");
	}
	else if (!strcmp(type, "alarme", true)){
		new alarm;
		if (sscanf(string, "d", alarm)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [seguro] [n�vel do alarme]");

		if(alarm < 0 || alarm > 3) return SendErrorMessage(playerid, "Voc� especificou um n�vel de alarme inv�lido.");

		SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d com alarme n�vel %d.", vInfo[id][vVehicle], alarm);

		format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)com alarme n�vel %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], alarm);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vAlarm] = alarm;
		SaveVehicle(id);
	} 
	else if (!strcmp(type, "combust�vel", true) || !strcmp(type, "combustivel", true)){
		new Float:fuel;
		if (sscanf(string, "f", fuel)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [combust�vel] [n�vel do combust�vel]");

		if(fuel < 1.0 || fuel > 100.0) return SendErrorMessage(playerid, "Voc� deve informar uma quantidade entre 1.0 e 100.0.");

		SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d com combust�vel em %.2f%%.", vInfo[id][vVehicle], fuel);

		format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)com combust�vel em %.2f%%", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], fuel);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vFuel] = fuel;
		SaveVehicle(id);
	} 
	else if (!strcmp(type, "bateria", true)){
		new Float:battery;
		if (sscanf(string, "f", battery)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [bateria] [n�vel da bateria]");

		if(battery < 1.0 || battery > 100.0) return SendErrorMessage(playerid, "Voc� deve informar uma quantidade entre 1.0 e 100.0.");

		SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d com bateria em %.2f%%.", vInfo[id][vVehicle], battery);

		format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)com bateria em %.2f%%", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], battery);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vBattery] = battery;
		SaveVehicle(id);
	} 
	else if (!strcmp(type, "motor", true)){
		new Float:engine;
		if (sscanf(string, "f", engine)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [seguro] [n�vel do enginee]");

		if(engine < 1.0 || engine > 100.0) return SendErrorMessage(playerid, "Voc� deve informar uma quantidade entre 1.0 e 100.0.");

		SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d com motor em %.2f%%.", vInfo[id][vVehicle], engine);

		format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)com motor em %.2f%%", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], engine);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vEngine] = engine;
		SaveVehicle(id);
	} 
	else if (!strcmp(type, "milhas", true)){
		new Float:miles;
		if (sscanf(string, "f", miles)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [milhas] [quantidade de milhas]");

		if(miles < 0.0) return SendErrorMessage(playerid, "Voc� n�o pode definir um valor menor que 0.00.");

		SendServerMessage(playerid, "Voc� definiu o ve�culo ID %d com milhas em %.2f.", vInfo[id][vVehicle], miles);

		format(logString, sizeof(logString), "%s (%s) definiu o ve�culo ID %d (SQL: %d)com milhas em %.2f", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vID], miles);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vMiles] = miles;
		SaveVehicle(id);
	} else return SendErrorMessage(playerid, "Voc� espec�ficou um par�metro inv�lido.");
	return true;
}

CMD:deletarveiculo(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);

	static 
		id = 0;

	if (sscanf(params, "d", id)) {
		if (IsPlayerInAnyVehicle(playerid)) id = GetPlayerVehicleID(playerid);
		else return SendSyntaxMessage(playerid, "/deletarveiculo [id]");
	}
	
	if (!IsValidVehicle(id) || VehicleGetID(id) == -1) return SendErrorMessage(playerid, "Voc� especificou um ve�culo inv�lido.");

	new owner = vInfo[VehicleGetID(id)][vOwner];

	for(new i = 0; i < MAX_PLAYERS; i++) if(pInfo[i][pID] == owner) va_SendClientMessage(i, COLOR_LIGHTRED, "Seu ve�culo %s [%d] foi deletado por um administrador.", ReturnVehicleModelName(vInfo[VehicleGetID(id)][vModel]), id);

	SendServerMessage(playerid, "Voc� destruiu o ve�culo ID: %d.", id);
	format(logString, sizeof(logString), "%s (%s) destruiu o ve�culo %s [%d/SQL: %d]", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(vInfo[VehicleGetID(id)][vModel]), id, VehicleGetID(id));
	logCreate(playerid, logString, 1);
	
	ResetVehicleObjects(id);
	ResetVehicle(VehicleGetID(id));
	DeleteVehicle(VehicleGetID(id));
	return true;
}

CMD:amotor(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 3) return SendPermissionMessage(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Voc� deve ser o motorista do ve�culo para usar esse comando.");

	new string[64];
	new vehicleid = GetPlayerVehicleID(playerid);
	new id = VehicleGetID(vehicleid);

	if(vInfo[id][vFuel] < 1.0) return SendErrorMessage(playerid, "O tanque de combust�vel est� vazio.");

	if(ReturnVehicleHealth(vehicleid) <= 300) return SendErrorMessage(playerid, "Este ve�culo est� danificado e n�o pode ser ligado.");

	switch (GetEngineStatus(vehicleid)) {
	    case false: {
	        SetEngineStatus(vehicleid, true);
			SetLightStatus(vehicleid, true);
			format(string, sizeof(string), "~g~MOTOR LIGADO");
			GameTextForPlayer(playerid, string, 2400, 4);
			if(vInfo[VehicleGetID(vehicleid)][vNamePersonalized]) SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s liga o ve�culo %s.", pNome(playerid), vInfo[VehicleGetID(vehicleid)][vName]);
			else SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s liga o ve�culo.", pNome(playerid));
		} case true: {
		    SetEngineStatus(vehicleid, false);
   			SetLightStatus(vehicleid, false);
   			format(string, sizeof(string), "~r~MOTOR DESLIGADO");
			GameTextForPlayer(playerid, string, 2400, 4);
			if(vInfo[VehicleGetID(vehicleid)][vNamePersonalized]) SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s desliga o ve�culo %s.", pNome(playerid), vInfo[VehicleGetID(vehicleid)][vName]);
			else SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s desliga o ve�culo.", pNome(playerid));
		}
	}
	return true;
}

CMD:irveiculo(playerid, params[]) {
	new vehicleid;

	if(GetPlayerAdmin(playerid) < 3) return SendPermissionMessage(playerid);
	if (sscanf(params, "d", vehicleid)) return SendSyntaxMessage(playerid, "/irveiculo [ve�culo]");
	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid)) return SendErrorMessage(playerid, "Voc� especificou o ID de ve�culo inv�lido.");

	static
	    Float:x,
		Float:y,
		Float:z;

	GetVehiclePos(vehicleid, x, y, z);
	SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(vehicleid));
	SetPlayerInterior(playerid, Vehicle_Interior[vehicleid]);
	SetPlayerPos(playerid, x, y - 2, z + 2);
	return 1;
}