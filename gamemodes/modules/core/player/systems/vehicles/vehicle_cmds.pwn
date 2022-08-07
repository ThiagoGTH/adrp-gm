#include <YSI_Coding\y_hooks>

/* =============================== PLAYERS =============================== */
CMD:veiculos(playerid, params[]) {
	ShowPlayerVehicles(playerid);
	return true;
}

/* =============================== ADMINS =============================== */
CMD:criarveiculo(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);

	static model[32], type, color1, color2, id = -1, value = 0;

	if (sscanf(params, "s[32]dddd", model, type, color1, color2, value)){
		SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /criarveiculo [modelo id/nome] [tipo] [cor 1] [cor 2] [id do tipo]");
	 	SendClientMessage(playerid, COLOR_BEGE, "[Tipos]: 1. Facção | 2. Empresa | 3. Emprego");
	 	SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	 	return true;
	}
	if ((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "O modelo especificado é inválido.");

	if (type < 1 || type > 3) return SendErrorMessage(playerid, "O tipo especificado é inválido. Os tipos variam entre 1 e 3.");

	if (color1 < 0 || color1 > 255) return SendErrorMessage(playerid, "As cores devem estar entre 0 e 255.");

	if (color2 < 0 || color2 > 255) return SendErrorMessage(playerid, "As cores devem estar entre 0 e 255.");

	if (value < 0) return SendErrorMessage(playerid, "O ID do tipo é referente ao ID da categoria. Esse valor não pode ser menor que 0.");

	static Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	SetPlateFree(playerid);

	if(type == 1) id = VehicleCreate(0, model[0], x, y + 2, z + 1, a, color1, color2, pInfo[playerid][pBuyingPlate], 0, 0, 0, value, 0, 0);
	else if(type == 2) id = VehicleCreate(0, model[0], x, y + 2, z + 1, a, color1, color2, pInfo[playerid][pBuyingPlate], 0, 0, 0, 0, value, 0);
	else if(type == 3) id = VehicleCreate(0, model[0], x, y + 2, z + 1, a, color1, color2, pInfo[playerid][pBuyingPlate], 0, 0, 0, 0, 0, value);

	pInfo[playerid][pBuyingPlate][0] = EOS;

	if (id == -1) return SendErrorMessage(playerid, "O servidor chegou ao limite máximo de veículos dinâmicos.");

	new style[32];
	switch(type){
		case 1: format(style, 32, "a facção");
		case 2: format(style, 32, "a empresa");
		case 3: format(style, 32, "o emprego");
	}

	SendServerMessage(playerid, "Você criou um %s para %s ID %d.", ReturnVehicleModelName(model[0]), style, value);

	format(logString, sizeof(logString), "%s (%s) criou um %s para %s ID %d", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(model[0]), style, value);
	logCreate(playerid, logString, 1);
	return true;
}

CMD:darveiculo(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

	static userid, model[32];
	if (sscanf(params, "us[32]", userid, model)) return SendSyntaxMessage(playerid, "/darveiculo [id/nome] [id do modelo/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if ((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "O modelo especificado é inválido.");

	static Float:x, Float:y, Float:z, Float:a, id = -1;
    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, a);
	SetPlateFree(playerid);

    id = VehicleCreate(pInfo[userid][pID], model[0], x, y + 2, z + 1, a, random(127), random(127), pInfo[playerid][pBuyingPlate]);

	pInfo[playerid][pBuyingPlate][0] = EOS;

	if (id == -1) return SendErrorMessage(playerid, "O servidor chegou ao limite máximo de veículos dinâmicos.");

	SendServerMessage(playerid, "Você criou um %s para %s.", ReturnVehicleModelName(model[0]), pNome(userid));

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
		SendClientMessage(playerid, COLOR_BEGE, "USE: /editarveiculo [id] [opção]");
		SendClientMessage(playerid, COLOR_BEGE, "[Opções]: dono, localização, facção, empresa, cor, modelo, nome");
		SendClientMessage(playerid, COLOR_BEGE, "[Opções]: seguro, sunpass, alarme, combustivel, bateria, motor, milhas");
		SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		return true;
	}

	if (!IsValidVehicle(id) || VehicleGetID(id) == -1) return SendErrorMessage(playerid, "Você especificou um veículo inválido.");

	id = VehicleGetID(id);
	
	if (!strcmp(type, "dono", true) || !strcmp(type, "proprietario", true)){
		new userid;
		if (sscanf(string, "u", userid)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [dono] [novo dono]");

		SendServerMessage(playerid, "Você alterou de %s para %s como novo dono do %s (ID: %d).", pNome(vInfo[id][vOwner]), pNome(userid), ReturnVehicleModelName(vInfo[id][vModel]), vInfo[id][vVehicle]);

		SendServerMessage(userid, "%s setou você como dono do veículo %s (%d).", GetPlayerUserEx(playerid), ReturnVehicleModelName(vInfo[id][vModel]), vInfo[id][vVehicle]);

		format(logString, sizeof(logString), "%s (%s) alterou de %s para %s como novo dono do %s (ID: %d/SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), pNome(vInfo[id][vOwner]), pNome(userid), ReturnVehicleModelName(vInfo[id][vModel]), vInfo[id][vVehicle], vInfo[id][vSQLID]);
		logCreate(playerid, logString, 1);

		vInfo[id][vOwner] = pInfo[userid][pID];
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "localizacao", true) || !strcmp(type, "localização", true)){
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

		SendServerMessage(playerid, "Você ajustou a localização do veículo ID %d.", vInfo[id][vVehicle]);

		format(logString, sizeof(logString), "%s (%s) ajustou a localização do veículo ID %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
		logCreate(playerid, logString, 1);
	}
	else if (!strcmp(type, "faccao", true) || !strcmp(type, "facção", true)){
		new factionid;
		if (sscanf(string, "d", factionid)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [facção] [id facção] (0 remove de facção)");

		if(factionid == 0){
			SendServerMessage(playerid, "Você removeu o status faccional do veículo ID %d.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) removeu o status faccional do veículo %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
			logCreate(playerid, logString, 1);
		} else {
			SendServerMessage(playerid, "Você definiu o veículo ID %d na facção ID %d.", vInfo[id][vVehicle], factionid);

			format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d)na facção ID %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], factionid);
			logCreate(playerid, logString, 1);
		}

		vInfo[id][vFaction] = factionid;
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "empresa", true)){
		new bizid;
		if (sscanf(string, "d", bizid)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [empresa] [id empresa] (0 remove de empresa)");

		if(bizid == 0){
			SendServerMessage(playerid, "Você removeu o status empresarial do veículo ID %d.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) removeu o status empresarial do veículo %d (SQL: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
			logCreate(playerid, logString, 1);
		} else {
			SendServerMessage(playerid, "Você definiu o veículo ID %d na empresa ID %d.", vInfo[id][vVehicle], bizid);

			format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d)na empresa ID %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], bizid);
			logCreate(playerid, logString, 1);
		}

		vInfo[id][vBusiness] = bizid;
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "cor", true)){
		new color1, color2;
		if (sscanf(string, "dd", color1, color2)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [cor] [cor 1] [cor 2]");

		if (color1 < 0 || color1 > 255)
			return SendErrorMessage(playerid, "As cores devem estar entre 0 e 255.");

		if (color2 < 0 || color2 > 255)
			return SendErrorMessage(playerid, "As cores devem estar entre 0 e 255.");

		vInfo[id][vColor1] = color1;
		vInfo[id][vColor2] = color2;
		SaveVehicle(id); SpawnVehicle(id);
		SendServerMessage(playerid, "Você definiu as cores do veículo %d como %d e %d.", vInfo[id][vVehicle], color1, color2);

		format(logString, sizeof(logString), "%s (%s) definiu as cores do veículo ID %d (SQL: %d) como %d e %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], color1, color2);
		logCreate(playerid, logString, 1);
	}
	else if (!strcmp(type, "modelo", true)){
		new model[32];
		if (sscanf(string, "s[32]", model)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [modelo] [novo modelo]");
		if ((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "O modelo especificado é inválido.");

		
		SendServerMessage(playerid, "Você alterou o modelo do veículo %d de %d para %d.", vInfo[id][vVehicle], vInfo[id][vModel], model);

		format(logString, sizeof(logString), "%s (%s) alterou o modelo do veículo %d (SQLID: %d) de %d para %d.", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], vInfo[id][vModel], model);
		logCreate(playerid, logString, 1);

		vInfo[id][vModel] = model[0];
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "nome", true)){
		new name[64];
		if (sscanf(string, "s[64]", name)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [nome] [nome do veículo] ('nenhum' para retirar)");

		if(strlen(name) > 32) return SendErrorMessage(playerid, "O nome do veículo não pode passar de 32 caracteres.");

		if(!strcmp(params, "nenhum", true)){
			vInfo[id][vNamePersonalized] = 0;
			format(vInfo[id][vName], 64, " ");
			SaveVehicle(id); SpawnVehicle(id);
			SendServerMessage(playerid, "Você removeu o nome do veículo ID %d.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) removeu o nome do veículo ID %d (SQLID: %d)", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
			logCreate(playerid, logString, 1);
			return true;
		} else {
			vInfo[id][vNamePersonalized] = 1;
			format(vInfo[id][vName], 64, name);
			SaveVehicle(id); SpawnVehicle(id);
			SendServerMessage(playerid, "Você definiu o nome do veículo ID %d como %s.", vInfo[id][vVehicle], name);

			format(logString, sizeof(logString), "%s (%s) definiu o nome do veículo ID %d (SQLID: %d) como %s.", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], name);
			logCreate(playerid, logString, 1);
			return true;
		}
	}
	else if (!strcmp(type, "seguro", true)){
		new insurance;
		if (sscanf(string, "d", insurance)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [seguro] [nível do seguro]");

		if(insurance < 0 || insurance > 3) return SendErrorMessage(playerid, "Você especificou um nível de seguro inválido.");

		SendServerMessage(playerid, "Você definiu o veículo ID %d com seguro nível %d.", vInfo[id][vVehicle], insurance);

		format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d)com seguro nível %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], insurance);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vInsurance] = insurance;
		SaveVehicle(id); SpawnVehicle(id);
	}
	else if (!strcmp(type, "sunpass", true)){
		new sunpass;
		if (sscanf(string, "d", sunpass)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [sunpass] [(1 ativa e 0 desativa)]");

		if(sunpass == 0){
			SendServerMessage(playerid, "Você definiu o veículo ID %d como sem sunpass.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d) como sem sunpass", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
			logCreate(playerid, logString, 1);

			vInfo[id][vSunpass] = sunpass;
			SaveVehicle(id); SpawnVehicle(id);
			return true;
		} else if(sunpass == 1) {
			SendServerMessage(playerid, "Você definiu o veículo ID %d com sunpass.", vInfo[id][vVehicle]);

			format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d) com sunpass", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID]);
			logCreate(playerid, logString, 1);
			vInfo[id][vSunpass] = sunpass;
			SaveVehicle(id); SpawnVehicle(id);
			return true;
		} else return SendErrorMessage(playerid, "Você definiu um valor inválido.");
	}
	else if (!strcmp(type, "alarme", true)){
		new alarm;
		if (sscanf(string, "d", alarm)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [seguro] [nível do alarme]");

		if(alarm < 0 || alarm > 3) return SendErrorMessage(playerid, "Você especificou um nível de alarme inválido.");

		SendServerMessage(playerid, "Você definiu o veículo ID %d com alarme nível %d.", vInfo[id][vVehicle], alarm);

		format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d)com alarme nível %d", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], alarm);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vAlarm] = alarm;
		SaveVehicle(id); SpawnVehicle(id);
	} 
	else if (!strcmp(type, "combustível", true) || !strcmp(type, "combustivel", true)){
		new Float:fuel;
		if (sscanf(string, "f", fuel)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [combustível] [nível do combustível]");

		if(fuel < 1.0 || fuel > 100.0) return SendErrorMessage(playerid, "Você deve informar uma quantidade entre 1.0 e 100.0.");

		SendServerMessage(playerid, "Você definiu o veículo ID %d com combustível em %.2f%%.", vInfo[id][vVehicle], fuel);

		format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d)com combustível em %.2f%%", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], fuel);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vFuel] = fuel;
		SaveVehicle(id); SpawnVehicle(id);
	} 
	else if (!strcmp(type, "bateria", true)){
		new Float:battery;
		if (sscanf(string, "f", battery)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [bateria] [nível da bateria]");

		if(battery < 1.0 || battery > 100.0) return SendErrorMessage(playerid, "Você deve informar uma quantidade entre 1.0 e 100.0.");

		SendServerMessage(playerid, "Você definiu o veículo ID %d com bateria em %.2f%%.", vInfo[id][vVehicle], battery);

		format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d)com bateria em %.2f%%", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], battery);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vBattery] = battery;
		SaveVehicle(id); SpawnVehicle(id);
	} 
	else if (!strcmp(type, "motor", true)){
		new Float:engine;
		if (sscanf(string, "f", engine)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [seguro] [nível do enginee]");

		if(engine < 1.0 || engine > 100.0) return SendErrorMessage(playerid, "Você deve informar uma quantidade entre 1.0 e 100.0.");

		SendServerMessage(playerid, "Você definiu o veículo ID %d com motor em %.2f%%.", vInfo[id][vVehicle], engine);

		format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d)com motor em %.2f%%", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], engine);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vEngine] = engine;
		SaveVehicle(id); SpawnVehicle(id);
	} 
	else if (!strcmp(type, "milhas", true)){
		new Float:miles;
		if (sscanf(string, "f", miles)) return SendSyntaxMessage(playerid, "/editarveiculo [id] [milhas] [quantidade de milhas]");

		if(miles < 0.0) return SendErrorMessage(playerid, "Você não pode definir um valor menor que 0.00.");

		SendServerMessage(playerid, "Você definiu o veículo ID %d com milhas em %.2f.", vInfo[id][vVehicle], miles);

		format(logString, sizeof(logString), "%s (%s) definiu o veículo ID %d (SQL: %d)com milhas em %.2f", pNome(playerid), GetPlayerUserEx(playerid), vInfo[id][vVehicle], vInfo[id][vSQLID], miles);
		logCreate(playerid, logString, 1);
		
		vInfo[id][vMiles] = miles;
		SaveVehicle(id); SpawnVehicle(id);
	} else return SendErrorMessage(playerid, "Você específicou um parâmetro inválido.");
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
	
	if (!IsValidVehicle(id) || VehicleGetID(id) == -1) return SendErrorMessage(playerid, "Você especificou um veículo inválido.");

	new owner = vInfo[VehicleGetID(id)][vOwner];

	for(new i = 0; i < MAX_PLAYERS; i++) if(pInfo[i][pID] == owner) va_SendClientMessage(i, COLOR_LIGHTRED, "Seu veículo %s [%d] foi deletado por um administrador.", ReturnVehicleModelName(vInfo[VehicleGetID(id)][vModel]), id);

	SendServerMessage(playerid, "Você destruiu o veículo ID: %d.", id);
	format(logString, sizeof(logString), "%s (%s) destruiu o veículo %s [%d/SQL: %d]", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(vInfo[VehicleGetID(id)][vModel]), id, VehicleGetID(id));
	logCreate(playerid, logString, 1);

	DeleteVehicle(VehicleGetID(id));
	return true;
}