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


CMD:listafaccoes(playerid, params[]) {
	new count = 0;
	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists]) {
	    va_SendClientMessage(playerid, COLOR_WHITE, "[ID: %d] {%06x}%s", i, FactionData[i][factionColor] >>> 8, FactionData[i][factionName]);
		count++;
	}

	if(count == 0) SendErrorMessage(playerid, "Não existe nenhuma facção criada no servidor.");
	return true;
}