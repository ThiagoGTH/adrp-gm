#include <YSI_Coding\y_hooks>

// ADMINS
CMD:criarfaccao(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 1)) return SendPermissionMessage(playerid);

	static
	    id = -1,
		type,
		name[32];

	if (sscanf(params, "ds[32]", type, name)) {
	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	    SendClientMessage(playerid, COLOR_BEGE, "USE: /criarfaccao [tipo] [nome]");
	    SendClientMessage(playerid, COLOR_BEGE, "TIPOS: 1: Policial | 2: Midiática | 3: Médica | 4: Prefeitura | 5: Governamental | 6: Civil | 7: Criminal");
	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		return true;
	}

	if (type < 1 || type > 7) return SendErrorMessage(playerid, "O tipo especificado é inválido. Os tipos vão de 1 até 7.");

	id = CreateFaction(name, type);
	if (id == -1) return SendErrorMessage(playerid, "O servidor chegou ao limite máximo de facções.");
	SendServerMessage(playerid, "Você criou a facção %s (%d).", name, id);

	format(logString, sizeof(logString), "%s (%s) criou a facção %s (%d)", pNome(playerid), GetPlayerUserEx(playerid), name, id);
	logCreate(playerid, logString, 1);

	return true;
}

CMD:deletarfaccao(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 1)) return SendPermissionMessage(playerid);

	static
	    id = 0;

	if (sscanf(params, "d", id)) return SendSyntaxMessage(playerid, "/deletarfaccao [ID da facção]");

	if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists]) return SendErrorMessage(playerid, "Você especificou um ID de facção inválido.");

	SendServerMessage(playerid, "Você deletou a facção %s (%d).", FactionData[id][factionName], id);
	format(logString, sizeof(logString), "%s (%s) deletou a facção %s (%d)", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id);
	logCreate(playerid, logString, 1);

	DeleteFaction(id);
	return true;
}

CMD:editarfaccao(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 1)) return SendPermissionMessage(playerid);

	static
	    id,
	    type[24],
	    string[128];

	if (sscanf(params, "ds[24]S()[128]", id, type, string)) {
 	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /editarfaccao [id] [opção]");
	    SendClientMessage(playerid, COLOR_BEGE, "[Opções]: nome, cor, tipo, armario, cargos, maxcargos, salário, status, skins");
	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		return true;
	} if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists]) return SendErrorMessage(playerid, "Você especificou um ID de facção inválido.");

	if (!strcmp(type, "nome", true)) {
	    new name[32];

	    if (sscanf(string, "s[32]", name)) return SendSyntaxMessage(playerid, "/editarfaccao [id] [nome] [novo nome]");

		SendServerMessage(playerid, "Você alterou o nome da facção %s (%d) para %s.", FactionData[id][factionName], id, name);

		format(logString, sizeof(logString), "%s (%s) alterou o nome da facção %s (%d) para %s", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, name);
		logCreate(playerid, logString, 1);

		format(FactionData[id][factionName], 32, name);
		SaveFaction(id);
	} else if (!strcmp(type, "cor", true)) {
	    new color;

	    if (sscanf(string, "h", color))
	        return SendSyntaxMessage(playerid, "/editarfaccao [id] [cor] [cor(em hex)]");

		SendServerMessage(playerid, "Você alterou a {%06x}cor{36A717} da facção %s (%d).", color >>> 8, FactionData[id][factionName], id);

		format(logString, sizeof(logString), "%s (%s) alterou a cor da facção %s (%d) para %d", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, color);
		logCreate(playerid, logString, 1);

		FactionData[id][factionColor] = color;
		SaveFaction(id);
		UpdateFaction(id);

	} else if (!strcmp(type, "tipo", true)) {
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		 	SendClientMessage(playerid, COLOR_BEGE, "USE: /editarfaccao [id] [tipo] [tipo da facção]");
            SendClientMessage(playerid, COLOR_BEGE, "TIPOS: 1: Policial | 2: Midiática | 3: Médica | 4: Prefeitura | 5: Governamental | 6: Civil | 7: Criminal");
            SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
            return 1;
		}
		if (typeint < 1 || typeint > 7) return SendErrorMessage(playerid, "O tipo especificado é inválido. Os tipos vão de 1 até 7.");

		SendServerMessage(playerid, "Você alterou o tipo da facção %s (%d) de %s para %s.", FactionData[id][factionName], id, GetFactionTypeID(FactionData[id][factionType]), GetFactionTypeID(typeint));

		format(logString, sizeof(logString), "%s (%s) alterou o tipo da facção %s (%d) de %s para %s", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, GetFactionTypeID(FactionData[id][factionType]), GetFactionTypeID(typeint));
		logCreate(playerid, logString, 1);

	    FactionData[id][factionType] = typeint;
		SaveFaction(id);

	} else if (!strcmp(type, "armario", true)) {
	    FactionConfigLocker(playerid, id);
	} else if (!strcmp(type, "cargos", true)) {
		FactionShowRanks(playerid, id);
	} else if (!strcmp(type, "maxcargos", true)) {
	    new ranks;

	    if (sscanf(string, "d", ranks))
	        return SendSyntaxMessage(playerid, "/editarfaccao [id] [maxcargos] [máximo de cargos]");

		if (ranks < 1 || ranks > 30)
		    return SendErrorMessage(playerid, "O máximo de cargos não pode ser menor que 1 ou maior que 30.");

		SendServerMessage(playerid, "Você alterou o máximo de cargos da facção %s (%d) de %d para %d.", FactionData[id][factionName], id, FactionData[id][factionRanks], ranks);

		format(logString, sizeof(logString), "%s (%s) alterou o máximo de cargos da facção %s (%d) de %d para %d", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, FactionData[id][factionRanks], ranks);
		logCreate(playerid, logString, 1);

		FactionData[id][factionRanks] = ranks;
		SaveFaction(id);
	} else if (!strcmp(type, "salario", true) || !strcmp(type, "salário", true)) {
		FactionPaycheck(playerid, id);
	} else if (!strcmp(type, "skins", true)) {
		FactionSetSkins(playerid, id);
	}


	else SendErrorMessage(playerid, "Você especificou um tipo inválido.");

	return true;
}

CMD:lider(playerid, params[]) {
	static
		userid,
		id;

   	if (GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 1)) return SendPermissionMessage(playerid);
	if (sscanf(params, "ud", userid, id)) return SendSyntaxMessage(playerid, "/lider [id/nome] [ID da facção] (Utilize -1 para remover um líder)");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if ((id < -1 || id >= MAX_FACTIONS) || (id != -1 && !FactionData[id][factionExists])) return SendErrorMessage(playerid, "Você especificou um ID de facção inválido.");

	if (id == -1) {
	    ResetFaction(userid);

		SendServerMessage(playerid, "Você removeu %s da liderança da facção.", pNome(userid));
		SendServerMessage(userid, "%s removeu você da liderença da facção.", GetPlayerUserEx(playerid));

		format(logString, sizeof(logString), "%s (%s) removeu a liderança da facção de %s (%s)", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), GetPlayerUserEx(userid));
	} else {
		SetFaction(userid, id);
		pInfo[userid][pFactionRank] = FactionData[id][factionRanks];

		SendServerMessage(playerid, "Você deu a liderança da facção %s para %s.", FactionData[id][factionName], pNome(userid));
		SendServerMessage(userid, "%s lhe deu a liderança da facção %s.", GetPlayerUserEx(playerid), FactionData[id][factionName]);

		format(logString, sizeof(logString), "%s (%s) deu a liderança da facção %s para %s (%s)", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], pNome(userid), GetPlayerUserEx(userid));
		logCreate(playerid, logString, 1);
	}
    return true;
}

CMD:listafaccoes(playerid, params[]) {
	new count = 0;
	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists]) {
	    va_SendClientMessage(playerid, COLOR_WHITE, "[ID: %d] {%06x}%s", i, FactionData[i][factionColor] >>> 8, FactionData[i][factionName]);
		count++;
	}

	if(count == 0) SendErrorMessage(playerid, "Não existe nenhuma facção criada no servidor.");
	return true;
}