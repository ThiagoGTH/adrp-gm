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
	    SendClientMessage(playerid, COLOR_BEGE, "TIPOS: 1: Policial | 2: Midi�tica | 3: M�dica | 4: Prefeitura | 5: Governamental | 6: Civil | 7: Criminal");
	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		return true;
	}

	if (type < 1 || type > 7) return SendErrorMessage(playerid, "O tipo especificado � inv�lido. Os tipos v�o de 1 at� 7.");

	id = CreateFaction(name, type);
	if (id == -1) return SendErrorMessage(playerid, "O servidor chegou ao limite m�ximo de fac��es.");
	SendServerMessage(playerid, "Voc� criou a fac��o %s (%d).", name, id);

	format(logString, sizeof(logString), "%s (%s) criou a fac��o %s (%d)", pNome(playerid), GetPlayerUserEx(playerid), name, id);
	logCreate(playerid, logString, 1);

	return true;
}

CMD:deletarfaccao(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 1)) return SendPermissionMessage(playerid);

	static
	    id = 0;

	if (sscanf(params, "d", id)) return SendSyntaxMessage(playerid, "/deletarfaccao [ID da fac��o]");

	if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists]) return SendErrorMessage(playerid, "Voc� especificou um ID de fac��o inv�lido.");

	SendServerMessage(playerid, "Voc� deletou a fac��o %s (%d).", FactionData[id][factionName], id);
	format(logString, sizeof(logString), "%s (%s) deletou a fac��o %s (%d)", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id);
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
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /editarfaccao [id] [op��o]");
	    SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: nome, cor, tipo, armario, cargos, maxcargos, status, salario");
	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		return true;
	} if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists]) return SendErrorMessage(playerid, "Voc� especificou um ID de fac��o inv�lido.");

	if (!strcmp(type, "nome", true)) {
	    new name[32];

	    if (sscanf(string, "s[32]", name)) return SendSyntaxMessage(playerid, "/editarfaccao [id] [nome] [novo nome]");

		SendServerMessage(playerid, "Voc� alterou o nome da fac��o %s (%d) para %s.", FactionData[id][factionName], id, name);

		format(logString, sizeof(logString), "%s (%s) alterou o nome da fac��o %s (%d) para %s", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, name);
		logCreate(playerid, logString, 1);

		format(FactionData[id][factionName], 32, name);
		SaveFaction(id);
	} else if (!strcmp(type, "cor", true)) {
	    new color;

	    if (sscanf(string, "h", color))
	        return SendSyntaxMessage(playerid, "/editarfaccao [id] [color] [cor(em hex)]");

		SendServerMessage(playerid, "Voc� alterou a {%06x}cor{36A717} da fac��o %s (%d).", color >>> 8, FactionData[id][factionName], id);

		format(logString, sizeof(logString), "%s (%s) alterou a cor da fac��o %s (%d) para %d", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, color);
		logCreate(playerid, logString, 1);

		FactionData[id][factionColor] = color;
		SaveFaction(id);
		UpdateFaction(id);

	} else if (!strcmp(type, "tipo", true)) {
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		 	SendClientMessage(playerid, COLOR_BEGE, "USE: /editarfaccao [id] [tipo] [tipo da fac��o]");
            SendClientMessage(playerid, COLOR_BEGE, "TIPOS: 1: Policial | 2: Midi�tica | 3: M�dica | 4: Prefeitura | 5: Governamental | 6: Civil | 7: Criminal");
            SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
            return 1;
		}
		if (typeint < 1 || typeint > 7) return SendErrorMessage(playerid, "O tipo especificado � inv�lido. Os tipos v�o de 1 at� 7.");

		SendServerMessage(playerid, "Voc� alterou o tipo da fac��o %s (%d) de %s para %s.", FactionData[id][factionName], id, GetFactionTypeID(FactionData[id][factionType]), GetFactionTypeID(typeint));

		format(logString, sizeof(logString), "%s (%s) alterou o tipo da fac��o %s (%d) de %s para %s", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, GetFactionTypeID(FactionData[id][factionType]), GetFactionTypeID(typeint));
		logCreate(playerid, logString, 1);

	    FactionData[id][factionType] = typeint;
		SaveFaction(id);

	} else if (!strcmp(type, "maxcargos", true)) {
	    new ranks;

	    if (sscanf(string, "d", ranks))
	        return SendSyntaxMessage(playerid, "/editarfaccao [id] [maxcargos] [m�ximo de carogs]");

		if (ranks < 1 || ranks > 30)
		    return SendErrorMessage(playerid, "O m�ximo de cargos n�o pode ser menor que 1 ou maior que 30.");

		SendServerMessage(playerid, "Voc� alterou o m�ximo de cargos da fac��o %s (%d) de %d para %d.", FactionData[id][factionName], id, FactionData[id][factionMaxRanks], ranks);

		format(logString, sizeof(logString), "%s (%s) alterou o m�ximo de cargos da fac��o %s (%d) de %d para %d", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, FactionData[id][factionMaxRanks], ranks);
		logCreate(playerid, logString, 1);

		FactionData[id][factionMaxRanks] = ranks;
		SaveFaction(id);
	} else if (!strcmp(type, "armario", true)) {
	    if(FactionData[id][factionType] == FACTION_CRIMINAL) return SendErrorMessage(playerid, "Voc� n�o pode editar arm�rio de fac��es criminosas.");

		new title[128];
		format(title, 128, "Arm�rio da Fac��o %s (%d)", FactionData[id][factionName], id);
        pInfo[playerid][pFactionEdit] = id;
		Dialog_Show(playerid, FactionLocker, DIALOG_STYLE_LIST, title, "Alterar Local\nArmas", "Selecionar", "Cancelar");
	}

	return true;
}

CMD:listafaccoes(playerid, params[]) {
	new count = 0;
	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists]) {
	    va_SendClientMessage(playerid, COLOR_WHITE, "[ID: %d] {%06x}%s", i, FactionData[i][factionColor] >>> 8, FactionData[i][factionName]);
		count++;
	}

	if(count == 0) SendErrorMessage(playerid, "N�o existe nenhuma fac��o criada no servidor.");
	return true;
}