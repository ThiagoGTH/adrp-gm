#include <YSI_Coding\y_hooks>
DEFINE_HOOK_REPLACEMENT(OnPlayer, OP_);
DEFINE_HOOK_REPLACEMENT(OnModel, OM_);
new g_TaxVault;

#define MAX_FACTIONS (15)
#define MAX_GRAFFITI_POINTS (20)

#define FACTION_POLICE (1)
#define FACTION_NEWS (2)
#define FACTION_MEDIC (3)
#define FACTION_GOV (4)
#define FACTION_GANG (5)

#define MODEL_SELECTION_SKINS (12)
#define MODEL_SELECTION_ADD_SKIN (13)
#define MODEL_SELECTION_FACTION_SKIN (14)

enum factionData {
	factionID,
	factionExists,
	factionName[32],
	factionColor,
	factionType,
	factionRanks,
	Float:factionLockerPos[3],
	factionLockerInt,
	factionLockerWorld,
	factionSkins[8],
	factionWeapons[10],
	factionAmmo[10],
	Text3D:factionText3D,
	factionPickup,
	Float:SpawnX,
	Float:SpawnY,
	Float:SpawnZ,
	SpawnInterior,
	SpawnVW
};
new FactionData[MAX_FACTIONS][factionData];
new FactionRanks[MAX_FACTIONS][15][32];

new Text3D:vehicle3Dtext[MAX_VEHICLES];

enum graffitiData {
	graffitiID,
	graffitiExists,
	Float:graffitiPos[4],
	graffitiIcon,
	graffitiObject,
	graffitiColor,
	graffitiText[64]
};
new GraffitiData[MAX_GRAFFITI_POINTS][graffitiData];

CMD:cor(playerid, params[])
{
	static
	    color;

	if (sscanf(params, "h", color)) {
	 	SendUsageMessage(playerid, "/cor [cor hex]");
	    SendClientMessage(playerid, COLOR_YELLOW, "EXEMPLO: 0xFFFFFFFF é branco, 0xFF0000FF é vermelho, etc.");
	}
	else {
	    va_SendClientMessage(playerid, color, "Essa é uma mensagem de teste, testando a cor 0x%06xFF.", color >>> 8);
	}
	return 1;
}

CMD:listafaccoes(playerid, params[])
{
	ViewFactions(playerid);
	return 1;
}

CMD:editarfac(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (uInfo[playerid][uFactionMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (uInfo[playerid][uAdmin] < 5)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendUsageMessage(playerid, "/editarfac [id] [syntax]");
	    SendClientMessage(playerid, -1, "SYNTAXES: nome, cor, tipo, skins, armario, ranks, maxranks");
		return 1;
	}
	if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists])
	    return SendErrorMessage(playerid, "Você especificou o ID de uma facção inválida.");

    if (!strcmp(type, "nome", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendUsageMessage(playerid, "/editarfac [id] [syxtax] [novo nome]");

	    format(FactionData[id][factionName], 32, name);

	    Faction_Save(id);
		SendFactionAlert(COLOR_LIGHTRED, "AdmCmd: %s alterou o nome da facção ID: %d para \"%s\".", pNome(playerid), id, name);
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou o nome da faccao ID: %d para %s.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id, name);
		DCC_SendChannelMessage(DC_AdminCMD, textdc);
	
	}
	else if (!strcmp(type, "maxranks", true))
	{
	    new ranks;

	    if (sscanf(string, "d", ranks))
	        return SendUsageMessage(playerid, "/editarfac [id] [maxranks] [máximo de ranks]");

		if (ranks < 1 || ranks > 15)
		    return SendErrorMessage(playerid, "A quantidade máxima de ranks não pode ser menor que 1 ou maior que 15.");

	    FactionData[id][factionRanks] = ranks;

	    Faction_Save(id);
		SendFactionAlert(COLOR_LIGHTRED, "AdmCmd: %s ajustou o máximo de ranks da facção ID: %d para %d.", pNome(playerid), id, ranks);
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* ajustou o maximo da ranks da faccao ID: %d para %d.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id, ranks);
		DCC_SendChannelMessage(DC_AdminCMD, textdc);
	}
	else if (!strcmp(type, "ranks", true))
	{
	    Faction_ShowRanks(playerid, id);
	}
	else if (!strcmp(type, "cor", true))
	{
	    new color;

	    if (sscanf(string, "h", color))
	        return SendUsageMessage(playerid, "/editarfac [id] [cor] [hex color]");

	    FactionData[id][factionColor] = color;
	    Faction_Update(id);

	    Faction_Save(id);
		SendFactionAlert(COLOR_LIGHTRED, "AdmCmd: %s ajustou a {%06x}cor{FF6347} da facção de ID: %d.", pNome(playerid), color >>> 8, id);
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* ajustou a cor da faccao ID: %d.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
		DCC_SendChannelMessage(DC_AdminCMD, textdc);
	}
	else if (!strcmp(type, "tipo", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
		 	SendUsageMessage(playerid, "/editarfac [id] [tipo] [tipo da facção]");
            SendClientMessage(playerid, COLOR_YELLOW, "TIPOS: 1: Policial | 2: Notícias | 3: Medica | 4: Governamental | 5: Ilegal");
            return 1;
		}
		if (typeint < 1 || typeint > 5)
		    return SendErrorMessage(playerid, "Tipo inválido. Os tipos variam de 1 a 5.");

	    FactionData[id][factionType] = typeint;

	    Faction_Save(id);
		SendFactionAlert(COLOR_LIGHTRED, "AdmCmd: %s alterou o tipo da facção ID: %d para %d.", pNome(playerid), id, typeint);
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou o tipo da faccao ID: %d para %s.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id, typeint);
		DCC_SendChannelMessage(DC_AdminCMD, textdc);
	}
	else if (!strcmp(type, "skins", true))
	{
	    static
	        skins[8];

		for (new i = 0; i < sizeof(skins); i ++)
		    skins[i] = (FactionData[id][factionSkins][i]) ? (FactionData[id][factionSkins][i]) : (19300);

	    pInfo[playerid][pFactionEdit] = id; 
		ShowModelSelectionMenu(playerid, "Skins da Facção", MODEL_SELECTION_SKINS, skins, sizeof(skins), -16.0, 0.0, -55.0);
	}
	else if (!strcmp(type, "armario", true))
	{
        pInfo[playerid][pFactionEdit] = id;
		Dialog_Show(playerid, FactionLocker, DIALOG_STYLE_LIST, "Armario da Facção", "Ajustar Localização\nArmário de Armas", "Selecionar", "Cancelar");
	}
	return 1;
}

CMD:fspawn(playerid, params[])
{
	new faction = pInfo[playerid][pFactionID];

	if (pInfo[playerid][pFaction] == -1)
	    return SendErrorMessage(playerid, "Você precisa ser o líder de uma facção.");

	if (pInfo[playerid][pFactionRank] < FactionData[pInfo[playerid][pFaction]][factionRanks] - 1)
	    return va_SendClientMessage(playerid, CINZA, "ERRO: Você precisa ser ao menos cargo %d.", FactionData[pInfo[playerid][pFaction]][factionRanks] - 1);
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	FactionData[faction][SpawnX] = X;
	FactionData[faction][SpawnY] = Y;
	FactionData[faction][SpawnZ] = Z;
	FactionData[faction][SpawnInterior] = GetPlayerInterior(playerid);
	FactionData[faction][SpawnVW] = GetPlayerVirtualWorld(playerid);
	Faction_Save(faction);
	return 1;
}

Faction_Save(factionid)
{
	mysql_format(DBConn, query, sizeof(query), "UPDATE `factions` SET \
		`factionName` = '%s', \
		`factionColor` = '%d', \
		`factionType` = '%d', \
		`factionRanks` = '%d', \
		`factionLockerX` = '%.4f', \
		`factionLockerY` = '%.4f', \
		`factionLockerZ` = '%.4f', \
		`factionLockerInt` = '%d', \
		`factionLockerWorld` = '%d', \
		`SpawnX` = '%f', \
		`SpawnY` = '%f', \
		`SpawnZ` = '%f', \
		`SpawnInterior` = '%d', \
		`SpawnVW` = '%d', \
		`factionSkin1` = '%d', \
		`factionSkin2` = '%d', \
		`factionSkin3` = '%d', \
		`factionSkin4` = '%d', \
		`factionSkin5` = '%d', \
		`factionSkin6` = '%d', \
		`factionSkin7` = '%d', \
		`factionSkin8` = '%d', \
		`factionWeapon1` = '%d', \
		`factionAmmo1` = '%d', \
		`factionWeapon2` = '%d', \
		`factionAmmo2` = '%d', \
		`factionWeapon3` = '%d', \
		`factionAmmo3` = '%d', \
		`factionWeapon4` = '%d', \
		`factionAmmo4` = '%d', \
		`factionWeapon5` = '%d', \
		`factionAmmo5` = '%d', \
		`factionWeapon6` = '%d', \
		`factionAmmo6` = '%d', \
		`factionWeapon7` = '%d', \
		`factionAmmo7` = '%d', \
		`factionWeapon8` = '%d', \
		`factionAmmo8` = '%d', \
		`factionWeapon9` = '%d', \
		`factionAmmo9` = '%d', \
		`factionWeapon10` = '%d', \
		`factionAmmo10` = '%d' WHERE `factionID` = '%d'",
		FactionData[factionid][factionName],
		FactionData[factionid][factionColor],
		FactionData[factionid][factionType],
		FactionData[factionid][factionRanks],
		FactionData[factionid][factionLockerPos][0],
		FactionData[factionid][factionLockerPos][1],
		FactionData[factionid][factionLockerPos][2],
		FactionData[factionid][factionLockerInt],
		FactionData[factionid][factionLockerWorld],
		// SPAWN
		FactionData[factionid][SpawnX],
		FactionData[factionid][SpawnY],
		FactionData[factionid][SpawnZ],
		FactionData[factionid][SpawnInterior],
		FactionData[factionid][SpawnVW],
		// SKINS
		FactionData[factionid][factionSkins][0],
		FactionData[factionid][factionSkins][1],
		FactionData[factionid][factionSkins][2],
		FactionData[factionid][factionSkins][3],
		FactionData[factionid][factionSkins][4],
		FactionData[factionid][factionSkins][5],
		FactionData[factionid][factionSkins][6],
		FactionData[factionid][factionSkins][7],
		// AMMO
		FactionData[factionid][factionWeapons][0],
		FactionData[factionid][factionAmmo][0],
		FactionData[factionid][factionWeapons][1],
		FactionData[factionid][factionAmmo][1],
		FactionData[factionid][factionWeapons][2],
		FactionData[factionid][factionAmmo][2],
		FactionData[factionid][factionWeapons][3],
		FactionData[factionid][factionAmmo][3],
		FactionData[factionid][factionWeapons][4],
		FactionData[factionid][factionAmmo][4],
		FactionData[factionid][factionWeapons][5],
		FactionData[factionid][factionAmmo][5],
		FactionData[factionid][factionWeapons][6],
		FactionData[factionid][factionAmmo][6],
		FactionData[factionid][factionWeapons][7],
		FactionData[factionid][factionAmmo][7],
		FactionData[factionid][factionWeapons][8],
		FactionData[factionid][factionAmmo][8],
		FactionData[factionid][factionWeapons][9],
		FactionData[factionid][factionAmmo][9],
		FactionData[factionid][factionID]);
	mysql_tquery(DBConn, query);
}

stock SendFactionAlert(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (uInfo[i][uAdmin] >= 1 || uInfo[i][uFactionMod] > 0) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (uInfo[i][uAdmin] >= 1 || uInfo[i][uFactionMod] > 0) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock Faction_SaveRanks(factionid)
{

	mysql_format(DBConn, query, sizeof(query), "UPDATE `factions` SET `factionRank1` = '%s', `factionRank2` = '%s', `factionRank3` = '%s', `factionRank4` = '%s', `factionRank5` = '%s', `factionRank6` = '%s', `factionRank7` = '%s', `factionRank8` = '%s', `factionRank9` = '%s', `factionRank10` = '%s', `factionRank11` = '%s', `factionRank12` = '%s', `factionRank13` = '%s', `factionRank14` = '%s', `factionRank15` = '%s' WHERE `factionID` = '%d'",
	    FactionRanks[factionid][0],
	    FactionRanks[factionid][1],
	    FactionRanks[factionid][2],
	    FactionRanks[factionid][3],
	    FactionRanks[factionid][4],
	    FactionRanks[factionid][5],
	    FactionRanks[factionid][6],
	    FactionRanks[factionid][7],
	    FactionRanks[factionid][8],
	    FactionRanks[factionid][9],
	    FactionRanks[factionid][10],
	    FactionRanks[factionid][11],
	    FactionRanks[factionid][12],
	    FactionRanks[factionid][13],
	    FactionRanks[factionid][14],
	    FactionData[factionid][factionID]);
	mysql_tquery(DBConn, query);
}

Faction_Delete(factionid)
{
	if (factionid != -1 && FactionData[factionid][factionExists])
	{
	    new
	        string[256];

		mysql_format(DBConn, string, sizeof(string), "DELETE FROM `factions` WHERE `factionID` = '%d'", FactionData[factionid][factionID]);
		mysql_tquery(DBConn, string);

		format(string, sizeof(string), "UPDATE `players` SET `Faction` = '-1' WHERE `Faction` = '%d'", FactionData[factionid][factionID]);
		mysql_tquery(DBConn, string);

		foreach (new i : Player)
		{
			if (pInfo[i][pFaction] == factionid) {
		    	pInfo[i][pFaction] = -1;
		    	pInfo[i][pFactionID] = -1;
		    	pInfo[i][pFactionRank] = -1;
			}
			if (pInfo[i][pFactionEdit] == factionid) {
			    pInfo[i][pFactionEdit] = -1;
			}
		}
		if (IsValidDynamicPickup(FactionData[factionid][factionPickup]))
  			DestroyDynamicPickup(FactionData[factionid][factionPickup]);

		if (IsValidDynamic3DTextLabel(FactionData[factionid][factionText3D]))
  			DestroyDynamic3DTextLabel(FactionData[factionid][factionText3D]);

	    FactionData[factionid][factionExists] = false;
	    FactionData[factionid][factionType] = 0;
	    FactionData[factionid][factionID] = 0;
	}
	return 1;
}

stock GetFactionType(playerid)
{
	if (pInfo[playerid][pFaction] == -1)
	    return 0;

	return (FactionData[pInfo[playerid][pFaction]][factionType]);
}

Faction_ShowRanks(playerid, factionid)
{
    if (factionid != -1 && FactionData[factionid][factionExists])
	{
		static
		    string[640];

		string[0] = 0;

		for (new i = 0; i < FactionData[factionid][factionRanks]; i ++)
		    format(string, sizeof(string), "%sRank %d: %s\n", string, i + 1, FactionRanks[factionid][i]);

		pInfo[playerid][pFactionEdit] = factionid;
		Dialog_Show(playerid, EditRanks, DIALOG_STYLE_LIST, FactionData[factionid][factionName], string, "Mudar", "Cancelar");
	}
	return 1;
}

Faction_Create(const name[], type)
{
	for (new i = 0; i != MAX_FACTIONS; i ++) if (!FactionData[i][factionExists])
	{
	    format(FactionData[i][factionName], 32, name);

        FactionData[i][factionExists] = true;
        FactionData[i][factionColor] = 0xFFFFFF00;
        FactionData[i][factionType] = type;
        FactionData[i][factionRanks] = 5;

        FactionData[i][factionLockerPos][0] = 0.0;
        FactionData[i][factionLockerPos][1] = 0.0;
        FactionData[i][factionLockerPos][2] = 0.0;
        FactionData[i][factionLockerInt] = 0;
        FactionData[i][factionLockerWorld] = 0;

        for (new j = 0; j < 8; j ++) {
            FactionData[i][factionSkins][j] = 0;
        }
        for (new j = 0; j < 10; j ++) {
            FactionData[i][factionWeapons][j] = 0;
            FactionData[i][factionAmmo][j] = 0;
	    }
	    for (new j = 0; j < 15; j ++) {
			format(FactionRanks[i][j], 32, "Rank %d", j + 1);
	    }
	    mysql_tquery(DBConn, "INSERT INTO `factions` (`factionType`) VALUES(0)", "OnFactionCreated", "d", i);
	    return i;
	}
	return -1;
}
hook OM_SelectionResponse(playerid, extraid, index, modelid, response)
{
	if ((response) && (extraid == MODEL_SELECTION_SKINS))
	{
	    Dialog_Show(playerid, FactionSkin, DIALOG_STYLE_LIST, "Editar Skin", "Adicionar por ID\nAdicionar por thumbnail\nLimpar Slot", "Selecionar", "Cancelar");
	    pInfo[playerid][pSelectedSlot] = index;
	}
	if ((response) && (extraid == MODEL_SELECTION_ADD_SKIN))
	{
	    FactionData[pInfo[playerid][pFactionEdit]][factionSkins][pInfo[playerid][pSelectedSlot]] = modelid;
		Faction_Save(pInfo[playerid][pFactionEdit]);

		va_SendClientMessage(playerid, -1, "SERVER: Você setou a skin do slot %d como a de ID %d.", pInfo[playerid][pSelectedSlot], modelid);
	}
	if ((response) && (extraid == MODEL_SELECTION_FACTION_SKIN))
	{
	    new factionid = pInfo[playerid][pFaction];

		if (factionid == -1 || !IsNearFactionLocker(playerid))
	    	return 0;

		if (modelid == 19300)
		    return SendErrorMessage(playerid, "Não existe uma skin nesse slot.");

  		SetPlayerSkin(playerid, modelid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s vestiu seu uniforme.", pNome(playerid));
	}
	return 1;
}

forward OnFactionCreated(factionid);
public OnFactionCreated(factionid)
{
	if (factionid == -1 || !FactionData[factionid][factionExists])
	    return 0;

	FactionData[factionid][factionID] = cache_insert_id();

	Faction_Save(factionid);
	Faction_SaveRanks(factionid);

	return 1;
}
stock ViewFactions(playerid)
{
	new string[1040];
	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists]) {
 		format(string, sizeof(string), "%s{FFFFFF}Facção ({FFBF00}%i{FFFFFF}) | %s\n", string, i, FactionData[i][factionName]);
	}
	Dialog_Show(playerid, FactionsList, DIALOG_STYLE_MSGBOX, "Lista de Facções", string, "Fechar", "");
	return 1;
}

Dialog:EditRanks(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!FactionData[pInfo[playerid][pFactionEdit]][factionExists])
			return 0;

		pInfo[playerid][pSelectedSlot] = listitem;
		Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Setar Rank", "Rank: %s (%d)\n\nPor favor, insira o novo rank da facção:", "Ok", "Voltar", FactionRanks[pInfo[playerid][pFactionEdit]][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot] + 1);
	}
	return 1;
}

Dialog:SetRankName(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Setar Rank", "Rank: %s (%d)\n\nPor favor, insira o novo rank da facção:", "Ok", "Voltar", FactionRanks[pInfo[playerid][pFactionEdit]][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot] + 1);

	    if (strlen(inputtext) > 32)
	        return Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Setar Rank", "ERRO: O rank não pode passar de 32 caracteres.\n\nRank: %s (%d)\n\nPor favor, insira o novo rank da facção:", "Ok", "Voltar", FactionRanks[pInfo[playerid][pFactionEdit]][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot] + 1);

		format(FactionRanks[pInfo[playerid][pFactionEdit]][pInfo[playerid][pSelectedSlot]], 32, inputtext);
		Faction_SaveRanks(pInfo[playerid][pFactionEdit]);

		Faction_ShowRanks(playerid, pInfo[playerid][pFactionEdit]);
		va_SendClientMessage(playerid, -1, "SERVER: Você setou o nome do rank %d para \"%s\".", pInfo[playerid][pSelectedSlot] + 1, inputtext);
	}
	else Faction_ShowRanks(playerid, pInfo[playerid][pFactionEdit]);
	return 1;
}

Dialog:Locker(playerid, response, listitem, inputtext[])
{
	new factionid = pInfo[playerid][pFaction];

	if (factionid == -1 || !IsNearFactionLocker(playerid))
		return 0;

	if (response)
	{
	    static
	        skins[8],
	        string[512];

		string[0] = 0;

	    if (FactionData[factionid][factionType] != FACTION_GANG)
	    {
	        switch (listitem)
	        {
	            case 0:
	            {
	                if (!pInfo[playerid][pOnDuty])
	                {
	                    pInfo[playerid][pOnDuty] = true;
	                    SetPlayerArmour(playerid, 100.0);

	                    SetFactionColor(playerid);
	                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s agora está em serviço.", pNome(playerid));
	                }
	                else
	                {
	                    pInfo[playerid][pOnDuty] = false;
	                    SetPlayerArmour(playerid, 0.0);

	                    SetPlayerColor(playerid, DEFAULT_COLOR);
	                    SetPlayerSkin(playerid, pInfo[playerid][pSkin]);

	                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s agora está fora de serviço.", pNome(playerid));
	                }
				}
				case 1:
				{
				    SetPlayerArmour(playerid, 100.0);
				    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s alcança o armário e veste um colete a prova de balas.", pNome(playerid));
				}
				case 2:
				{
					for (new i = 0; i < sizeof(skins); i ++)
					    skins[i] = (FactionData[factionid][factionSkins][i]) ? (FactionData[factionid][factionSkins][i]) : (19300);

					ShowModelSelectionMenu(playerid, "Escolher Skin", MODEL_SELECTION_FACTION_SKIN, skins, sizeof(skins), -16.0, 0.0, -55.0);
				}
				case 3:
				{
				    for (new i = 0; i < 10; i ++)
					{
				        if (FactionData[factionid][factionWeapons][i])
							format(string, sizeof(string), "%sArma %d: %s\n", string, i + 1, ReturnWeaponName(FactionData[factionid][factionWeapons][i]));

						else format(string, sizeof(string), "%sSlot vazio\n", string);
				    }
				    Dialog_Show(playerid, LockerWeapons, DIALOG_STYLE_LIST, "Armário de Armas", string, "Selecionar", "Cancelar");
				}
			}
	    }
	    else
	    {
	        switch (listitem)
	        {
				case 0:
				{
					for (new i = 0; i < sizeof(skins); i ++)
					    skins[i] = (FactionData[factionid][factionSkins][i]) ? (FactionData[factionid][factionSkins][i]) : (19300);

					ShowModelSelectionMenu(playerid, "Escolher Skin", MODEL_SELECTION_FACTION_SKIN, skins, sizeof(skins), -16.0, 0.0, -55.0);
				}
				case 1:
				{
				    for (new i = 0; i < 10; i ++)
					{
				        if (FactionData[factionid][factionWeapons][i] && GetFactionType(playerid) != FACTION_GANG)
							format(string, sizeof(string), "%sArma %d: %s\n", string, i + 1, ReturnWeaponName(FactionData[factionid][factionWeapons][i]));

						else if (FactionData[factionid][factionWeapons][i] && GetFactionType(playerid) == FACTION_GANG)
							format(string, sizeof(string), "%sArma %d: %s (%d munição)\n", string, i + 1, ReturnWeaponName(FactionData[factionid][factionWeapons][i]), FactionData[factionid][factionAmmo][i]);

						else format(string, sizeof(string), "%sSlot Vazio\n", string);
				    }
				    Dialog_Show(playerid, LockerWeapons, DIALOG_STYLE_LIST, "Armário de Armas", string, "Selecionar", "Cancelar");
				}
			}
	    }
	}
	return 1;
}

Dialog:LockerWeapons(playerid, response, listitem, inputtext[])
{
	new factionid = pInfo[playerid][pFaction];

	if (factionid == -1 || !IsNearFactionLocker(playerid))
		return 0;

	if (response)
	{
	    new
	        weaponid = FactionData[factionid][factionWeapons][listitem],
	        ammo = FactionData[factionid][factionAmmo][listitem];

	    if (weaponid)
		{
	        if (PlayerHasWeapon(playerid, weaponid))
	            return SendErrorMessage(playerid, "Você já está com essa arma equipada.");

	        GiveWeaponToPlayer(playerid, weaponid, ammo);
	        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s alcança o interior do armário e se equipa com um(a) %s.", pNome(playerid), ReturnWeaponName(weaponid));

			if (GetFactionType(playerid) == FACTION_GANG)
		    {
		        FactionData[factionid][factionWeapons][listitem] = 0;
		        FactionData[factionid][factionAmmo][listitem] = 0;

		        Faction_Save(factionid);
			}
		}
		else
		{
		    if (GetFactionType(playerid) == FACTION_GANG)
		    {
		        if ((weaponid = GetWeapon(playerid)) == 0)
		            return SendErrorMessage(playerid, "Você não está segurando uma arma.");

		        FactionData[factionid][factionWeapons][listitem] = weaponid;
		        FactionData[factionid][factionAmmo][listitem] = GetPlayerAmmo(playerid);

		        Faction_Save(factionid);

                ResetWeapon(playerid, weaponid);
		        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pega um(a) %s do armário.", pNome(playerid), ReturnWeaponName(weaponid));
			}
			else
			{
			    SendErrorMessage(playerid, "Esse slot está vazio.");
			}
	    }
	}
	else {
		Dialog_Show(playerid, Locker, DIALOG_STYLE_LIST, "Armário da Facção", "Armário de Skins\nArmário de Armas", "Selecionar", "Cancelar");
	}
	return 1;
}

Dialog:FactionLocker(playerid, response, listitem, inputtext[])
{
	if (pInfo[playerid][pFactionEdit] == -1)
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
			    static
			        Float:x,
			        Float:y,
			        Float:z;

				GetPlayerPos(playerid, x, y, z);

				FactionData[pInfo[playerid][pFactionEdit]][factionLockerPos][0] = x;
				FactionData[pInfo[playerid][pFactionEdit]][factionLockerPos][1] = y;
				FactionData[pInfo[playerid][pFactionEdit]][factionLockerPos][2] = z;

				FactionData[pInfo[playerid][pFactionEdit]][factionLockerInt] = GetPlayerInterior(playerid);
				FactionData[pInfo[playerid][pFactionEdit]][factionLockerWorld] = GetPlayerVirtualWorld(playerid);

				Faction_Refresh(pInfo[playerid][pFactionEdit]);
				Faction_Save(pInfo[playerid][pFactionEdit]);
				va_SendClientMessage(playerid, -1, "SERVER: Você ajustou a posição do armário da facção ID: %d.", pInfo[playerid][pFactionEdit]);
			}
			case 1:
			{
				static
				    string[512];

				string[0] = 0;

			    for (new i = 0; i < 10; i ++)
				{
			        if (FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][i])
						format(string, sizeof(string), "%sArma %d: %s\n", string, i + 1, ReturnWeaponName(FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][i]));

					else format(string, sizeof(string), "%sSlot vazio\n", string);
			    }
			    Dialog_Show(playerid, FactionWeapons, DIALOG_STYLE_LIST, "Armário de Armas", string, "Selecionar", "Cancelar");
			}
		}
	}
	return 1;
}

Dialog:FactionWeapons(playerid, response, listitem, inputtext[])
{
	if (pInfo[playerid][pFactionEdit] == -1)
	    return 0;

	if (response)
	{
	    pInfo[playerid][pSelectedSlot] = listitem;
	    Dialog_Show(playerid, FactionWeapon, DIALOG_STYLE_LIST, "Editar Arma", "Setar Arma (%d)\nSetar Munição (%d)\nLimpar Slot", "Selecionar", "Cancelar", FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]], FactionData[pInfo[playerid][pFactionEdit]][factionAmmo][pInfo[playerid][pSelectedSlot]]);
	}
	return 1;
}

Dialog:FactionWeapon(playerid, response, listitem, inputtext[])
{
	if (pInfo[playerid][pFactionEdit] == -1)
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        	Dialog_Show(playerid, FactionWeaponID, DIALOG_STYLE_INPUT, "Setar Arma", "Arma atual: %s (%d)\n\nInsira o novo ID da arma para o slot %d:", "Ok", "Cancelar", ReturnWeaponName(FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]]), FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot]);

			case 1:
	            Dialog_Show(playerid, FactionWeaponAmmo, DIALOG_STYLE_INPUT, "Setar Munição", "Munição atual: %d\n\nInsira a nova munição da arma no slot %d:", "Ok", "Cancelar", FactionData[pInfo[playerid][pFactionEdit]][factionAmmo][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot]);

			case 2:
			{
			    FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]] = 0;
				FactionData[pInfo[playerid][pFactionEdit]][factionAmmo][pInfo[playerid][pSelectedSlot]] = 0;

				Faction_Save(pInfo[playerid][pFactionEdit]);

				dialog_FactionLocker(playerid, 1, 1, "\1");
				va_SendClientMessage(playerid, -1, "SERVER: Você removeu a arma do slot %d.", pInfo[playerid][pSelectedSlot] + 1);
			}
	    }
	}
	else {
	    dialog_FactionLocker(playerid, 1, 1, "\1");
	}
	return 1;
}

Dialog:FactionWeaponID(playerid, response, listitem, inputtext[])
{
	if (pInfo[playerid][pFactionEdit] == -1)
	    return 0;

	if (response)
	{
	    new weaponid = strval(inputtext);

	    if (isnull(inputtext))
	        return Dialog_Show(playerid, FactionWeaponID, DIALOG_STYLE_INPUT, "Setar Arma", "Arma atual: %s (%d)\n\nInsira o novo ID da arma para o slot %d:", "Ok", "Cancelar", ReturnWeaponName(FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]]), FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot]);

		if (weaponid < 0 || weaponid > 46)
		    return Dialog_Show(playerid, FactionWeaponID, DIALOG_STYLE_INPUT, "Setar Arma", "ERRO: O ID da arma não pode ser menor que zero e maior que 46.\n\nArma atual: %s (%d)\n\nInsira o novo ID da arma para o slot %d:", "Ok", "Cancelar", ReturnWeaponName(FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]]), FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot]);

        FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]] = weaponid;
        Faction_Save(pInfo[playerid][pFactionEdit]);

		Dialog_Show(playerid, FactionWeapon, DIALOG_STYLE_LIST, "Editar Arma", "Setar Arma (%d)\nSetar Munição (%d)\nLimpar Slot", "Selecionar", "Cancelar", FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]], FactionData[pInfo[playerid][pFactionEdit]][factionAmmo][pInfo[playerid][pSelectedSlot]]);

	    if (weaponid) {
		    va_SendClientMessage(playerid, -1, "SERVER: Você setou a arma do slot %d como %s.", pInfo[playerid][pSelectedSlot] + 1, ReturnWeaponName(weaponid));
		}
		else {
		    va_SendClientMessage(playerid, -1, "SERVER: Você removeu a arma do slot %d.", pInfo[playerid][pSelectedSlot] + 1);
		}
	}
	return 1;
}

Dialog:FactionWeaponAmmo(playerid, response, listitem, inputtext[])
{
	if (pInfo[playerid][pFactionEdit] == -1)
	    return 0;

	if (response)
	{
	    new ammo = strval(inputtext);

	    if (isnull(inputtext))
	        return Dialog_Show(playerid, FactionWeaponAmmo, DIALOG_STYLE_INPUT, "Setar Munição", "Munição atual: %d\n\nInsira a nova munição da arma no slot %d:", "Ok", "Cancelar", FactionData[pInfo[playerid][pFactionEdit]][factionAmmo][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot]);

		if (ammo < 1 || ammo > 15000)
		    return Dialog_Show(playerid, FactionWeaponAmmo, DIALOG_STYLE_INPUT, "Setar Munição", "ERRO: A munição não pode ser menor que 0 e maior que 15,000.\n\nMunição atual: %d\n\nInsira a nova munição da arma no slot %d:", "Ok", "Cancelar", FactionData[pInfo[playerid][pFactionEdit]][factionAmmo][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot]);

        FactionData[pInfo[playerid][pFactionEdit]][factionAmmo][pInfo[playerid][pSelectedSlot]] = ammo;
        Faction_Save(pInfo[playerid][pFactionEdit]);

		Dialog_Show(playerid, FactionWeapon, DIALOG_STYLE_LIST, "Editar Arma", "Setar Arma (%d)\nSetar Munição (%d)\nLimpar Slot", "Selecionar", "Cancelar", FactionData[pInfo[playerid][pFactionEdit]][factionWeapons][pInfo[playerid][pSelectedSlot]], FactionData[pInfo[playerid][pFactionEdit]][factionAmmo][pInfo[playerid][pSelectedSlot]]);
		va_SendClientMessage(playerid, -1, "SERVER: Você setou a munição do slot %d como %d.", pInfo[playerid][pSelectedSlot] + 1, ammo);
	}
	return 1;
}

Dialog:FactionSkin(playerid, response, listitem, inputtext[])
{
	if (pInfo[playerid][pFactionEdit] == -1)
	    return 0;

	if (response)
	{
	    static
	        skins[299];

		switch (listitem)
		{
		    case 0:
		        Dialog_Show(playerid, FactionModel, DIALOG_STYLE_INPUT, "Adicionar skin por ID", "Insira um modelo de skin entre 0 e 299", "Adicionar", "Cancelar");

			case 1:
			{
			    for (new i = 0; i < sizeof(skins); i ++)
			        skins[i] = i + 1;

				ShowModelSelectionMenu(playerid, "Adicionar Skin", MODEL_SELECTION_ADD_SKIN, skins, sizeof(skins), -16.0, 0.0, -55.0);
			}
			case 2:
			{
			    FactionData[pInfo[playerid][pFactionEdit]][factionSkins][pInfo[playerid][pSelectedSlot]] = 0;

			    Faction_Save(pInfo[playerid][pFactionEdit]);
			    va_SendClientMessage(playerid, -1, "SERVER: Você removeu a skin do slot %d.", pInfo[playerid][pSelectedSlot] + 1);
			}
		}
	}
	return 1;
}

Dialog:FactionModel(playerid, response, listitem, inputtext[])
{
	if (pInfo[playerid][pFactionEdit] == -1)
	    return 0;

	if (response)
	{
	    new skin = strval(inputtext);

	    if (isnull(inputtext))
	        return Dialog_Show(playerid, FactionModel, DIALOG_STYLE_INPUT, "Adicionar skin por ID", "Insira um modelo de skin entre 0 e 299", "Adicionar", "Cancelar");

		if (skin < 0 || skin > 299)
		    return Dialog_Show(playerid, FactionModel, DIALOG_STYLE_INPUT, "Adicionar skin por ID", "ERRO: O ID da skin não pode ser menor que 0 ou maior que 299.\n\nInsira um modelo de skin entre 0 e 299", "Adicionar", "Cancelar");

        FactionData[pInfo[playerid][pFactionEdit]][factionSkins][pInfo[playerid][pSelectedSlot]] = skin;
		Faction_Save(pInfo[playerid][pFactionEdit]);

		if (skin) {
		    va_SendClientMessage(playerid, -1, "SERVER: Você setou a skin no slot %d como %d.", pInfo[playerid][pSelectedSlot] + 1, skin);
		}
		else {
		    va_SendClientMessage(playerid, -1, "SERVER: Você removeu a skin do slot %d.", pInfo[playerid][pSelectedSlot] + 1);
		}
	}
	return 1;
}
CMD:aceitar(playerid, params[])
{
	if (isnull(params))
 	{
	 	SendUsageMessage(playerid, "/aceitar [nome]");
		SendClientMessage(playerid, COLOR_YELLOW, "NOMES: facção");
		return 1;
	}
    if (!strcmp(params, "facção", true) && pInfo[playerid][pFactionOffer] != INVALID_PLAYER_ID)
	{
	    new
	        targetid = pInfo[playerid][pFactionOffer],
	        factionid = pInfo[playerid][pFactionOffered];

		if (!FactionData[factionid][factionExists] || pInfo[targetid][pFactionRank] < FactionData[pInfo[targetid][pFaction]][factionRanks] - 1)
	   	 	return SendErrorMessage(playerid, "O convite da facção não está mais disponível.");

		SetFaction(playerid, factionid);
		pInfo[playerid][pFactionRank] = 1;

		va_SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Você aceitou o convite de %s para entrar em \"%s\".", pNome(targetid), Faction_GetName(targetid));
		va_SendClientMessage(playerid, COLOR_YELLOW, "SERVER: %s aceitou seu convite para se juntar a \"%s\".", pNome(playerid), Faction_GetName(targetid));

        pInfo[playerid][pFactionOffer] = INVALID_PLAYER_ID;
        pInfo[playerid][pFactionOffered] = -1;
	}
    return 1;
}

CMD:criarfac(playerid, params[])
{
	static
	    id = -1,
		type,
		name[32];

    if (uInfo[playerid][uFactionMod] < 1)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (uInfo[playerid][uAdmin] < 5)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	
	if (sscanf(params, "ds[32]", type, name))
	{
	    SendUsageMessage(playerid, "/criarfac [tipo] [nome]");
	    SendClientMessage(playerid, COLOR_GRAD1, "TIPOS: 1: Policial | 2: Noticiaria | 3: Médica | 4: Governo | 5: Ilegal");
		return 1;
	}
	if (type < 1 || type > 5)
	    return SendErrorMessage(playerid, "Você específicou um tipo de facção inválido. Os tipos variam entre 1 e 5.");

	id = Faction_Create(name, type);

	if (id == -1)
	    return SendErrorMessage(playerid, "O servidor chegou no limite de facções.");

	va_SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Você criou a com sucesso a facção %s [ID: %d].", name, id);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* criou a faccao %s [ID: %d].", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], name, id);
	DCC_SendChannelMessage(DC_AdminCMD, textdc);
	return 1;
}

CMD:destruirfac(playerid, params[])
{
	static
	    id = 0;

    if (uInfo[playerid][uFactionMod] < 1)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (uInfo[playerid][uAdmin] < 5)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "d", id))
	    return SendUsageMessage(playerid, "/destruirfac [id da facção]");

	if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists])
	    return SendErrorMessage(playerid, "Você específicou um ID errado.");

	Faction_Delete(id);
	va_SendClientMessage(playerid, -1, "SERVER: Você destruiu a facção ID %d com sucesso!", id);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* destruiu a faccao ID: %d.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
	DCC_SendChannelMessage(DC_AdminCMD, textdc);
	return 1;
}

CMD:armario(playerid, params[])
{
	new factionid = pInfo[playerid][pFaction];

 	if (factionid == -1)
	    return SendErrorMessage(playerid, "Você deve participar de uma facção.");

	if (!IsNearFactionLocker(playerid))
	    return SendErrorMessage(playerid, "Você não está perto do armário de sua facção.");

 	if (FactionData[factionid][factionType] != FACTION_GANG)
		Dialog_Show(playerid, Locker, DIALOG_STYLE_LIST, "Armário da Facção", "Trabalho\nColete\nArmário de Roupas\nArmário de Armas", "Selecionar", "Cancelar");

	else Dialog_Show(playerid, Locker, DIALOG_STYLE_LIST, "Armário da Facção", "Armário de Roupas\nArmário de Armas", "Selecionar", "Cancelar");
	return 1;
}

CMD:setarlider(playerid, params[])
{
	static
		userid,
		id;

	if (uInfo[playerid][uFactionMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if (uInfo[playerid][uAdmin] < 4)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "ud", userid, id))
	    return SendUsageMessage(playerid, "/setarlider [playerid/nome] [id da facção] (Use -1 para remover de líder)");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

    if ((id < -1 || id >= MAX_FACTIONS) || (id != -1 && !FactionData[id][factionExists]))
	    return SendErrorMessage(playerid, "Você específicou o ID da facção errado.");

	if (id == -1)
	{
	    ResetFaction(userid);

	    va_SendClientMessage(playerid, COLOR_YELLOW, "Você removeu %s da liderança da facção.", pNome(userid));
    	va_SendClientMessage(userid, COLOR_YELLOW, "%s removeu você da liderança da facção.", pNome(playerid));
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* removeu %s da lideranca da faccao ID: %d.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid), id);
		DCC_SendChannelMessage(DC_AdminCMD, textdc);
	}
	else
	{
		SetFaction(userid, id);
		pInfo[userid][pFactionRank] = FactionData[id][factionRanks];

		va_SendClientMessage(playerid, COLOR_YELLOW, "Você setou %s como líder da facção \"%s\".", pNome(userid), FactionData[id][factionName]);
    	va_SendClientMessage(userid, COLOR_YELLOW, "%s setou você como líder da facção \"%s\".", pNome(playerid), FactionData[id][factionName]);
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* setou %s como lider da faccao ID: %d.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid), id);
		DCC_SendChannelMessage(DC_AdminCMD, textdc);
	}
    return 1;
}

CMD:setarfac(playerid, params[])
{
	static
		userid,
		id;

    if (uInfo[playerid][uFactionMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if (uInfo[playerid][uAdmin] < 4)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "ud", userid, id))
	    return SendUsageMessage(playerid, "/setarfac [playerid/nome] [id da facção] (Use -1 para remover)");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

    if ((id < -1 || id >= MAX_FACTIONS) || (id != -1 && !FactionData[id][factionExists]))
	    return SendErrorMessage(playerid, "Você específicou o ID da facção errado.");

	if (id == -1)
	{
	    ResetFaction(userid);

	    va_SendClientMessage(playerid, COLOR_YELLOW, "Você removeu %s da facção.", pNome(userid));
    	va_SendClientMessage(userid, COLOR_YELLOW, "Você foi removido da facção pelo administrador %s.", pNome(playerid));
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* removeu %s da faccao ID: %d.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid), id);
		DCC_SendChannelMessage(DC_AdminCMD, textdc);
	}
	else
	{
		SetFaction(userid, id);

		if (!pInfo[userid][pFactionRank])
	    	pInfo[userid][pFactionRank] = 1;

		va_SendClientMessage(playerid, COLOR_YELLOW, "Você setou %s na facção \"%s\".", pNome(userid), FactionData[id][factionName]);
    	va_SendClientMessage(userid, COLOR_YELLOW, "O administrador %s setou você na facção \"%s\".", pNome(playerid), FactionData[id][factionName]);
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* setou %s na faccao ID: %d.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid), id);
		DCC_SendChannelMessage(DC_AdminCMD, textdc);
	}
    return 1;
}

CMD:setarcargo(playerid, params[])
{
	static
		userid,
		rank,
		factionid;

    if (uInfo[playerid][uFactionMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if (uInfo[playerid][uAdmin] < 4)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "ud", userid, rank))
	    return SendUsageMessage(playerid, "/setarcargo [playerid/nome] [rank id]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	if ((factionid = pInfo[userid][pFaction]) == -1)
	    return SendErrorMessage(playerid, "Esse jogador não faz parte de nenhuma facção.");

    if (rank < 1 || rank > FactionData[factionid][factionRanks])
        return va_SendClientMessage(playerid, CINZA, " ERRO: Rank inválido. Os ranks desta facção devem variar de 1 a %d.", FactionData[factionid][factionRanks]);

	pInfo[userid][pFactionRank] = rank;

	va_SendClientMessage(playerid, COLOR_YELLOW, "Você setou %s como cargo %d na facção.", pNome(userid), rank);
    va_SendClientMessage(userid, COLOR_YELLOW, "O administrador %s setou você como cargo %d na facção.", pNome(playerid), rank);

	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* setou %s como cargo %d na faccao ID: %d.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid), rank, factionid);
	DCC_SendChannelMessage(DC_AdminCMD, textdc);
    
	return 1;
}

CMD:membros(playerid, params[])
{
	new factionid = pInfo[playerid][pFaction];

 	if (factionid == -1)
	    return SendErrorMessage(playerid, "Você precisa ser membro de uma facção.");

	SendClientMessage(playerid, COLOR_SERVER, "Membros online:");

	foreach (new i : Player) if (pInfo[i][pFaction] == factionid) {
		va_SendClientMessage(playerid, COLOR_WHITE, "[ID: %d] %s - %s (%d)", i, pNome(i), Faction_GetRank(i), pInfo[i][pFactionRank]);
	}
	return 1;
}

CMD:f(playerid, params[])
{
    new factionid = pInfo[playerid][pFaction];
	new string[256];
 	if (factionid == -1)
	    return SendErrorMessage(playerid, "Você precisa ser membro de uma facção.");

	if (isnull(params))
	    return SendUsageMessage(playerid, "/(f)ac [mensagem]");

    if (pInfo[playerid][pDisableFaction])
	    return SendErrorMessage(playerid, "Você precisa ativar o chat da facção primeiro.");

	SendFactionMessage(factionid, COLOR_FACTION, "(( (%d) %s %s: %s ))", pInfo[playerid][pFactionRank], Faction_GetRank(playerid), pNome(playerid), params);
	
 	format(string, sizeof string, " `LOG-FCHAT:` [%s] *(%s)* **%s**: %s", ReturnDate(), Faction_GetRank(playerid), pNome(playerid), params);
    DCC_SendChannelMessage(DC_LogFac, string);
	return 1;
}

CMD:sairfac(playerid, params[])
{
	if (pInfo[playerid][pFaction] == -1)
	    return SendErrorMessage(playerid, "Você precisa ser membro de uma facção.");

	if (GetFactionType(playerid) == FACTION_POLICE)
	{
	    SetPlayerArmour(playerid, 0);
	    ResetWeapons(playerid);
	}
	va_SendClientMessage(playerid, COLOR_YELLOW, "Você saiu da facção \"%s\" (cargo %d).", Faction_GetName(playerid), pInfo[playerid][pFactionRank]);
    ResetFaction(playerid);

    return 1;
}

CMD:convidar(playerid, params[])
{
	new
	    userid;

	if (pInfo[playerid][pFaction] == -1)
	    return SendErrorMessage(playerid, "Você precisa ser membro de uma facção.");

	if (pInfo[playerid][pFactionRank] < FactionData[pInfo[playerid][pFaction]][factionRanks] - 1)
	    return va_SendClientMessage(playerid, CINZA, "ERRO: Você precisa ser pelo menos cargo %d.", FactionData[pInfo[playerid][pFaction]][factionRanks] - 1);

	if (sscanf(params, "u", userid))
	    return SendUsageMessage(playerid, "/convidar [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Este jogador está desconectado.");

	if (pInfo[userid][pFaction] == pInfo[playerid][pFaction])
	    return SendErrorMessage(playerid, "Este jogador já faz parte de sua facção.");

    if (pInfo[userid][pFaction] != -1)
	    return SendErrorMessage(playerid, "Este jogador já faz parte de outra facção.");

	pInfo[userid][pFactionOffer] = playerid;
    pInfo[userid][pFactionOffered] = pInfo[playerid][pFaction];

    va_SendClientMessage(playerid, COLOR_YELLOW, "Você convidou %s para se juntar a \"%s\".", pNome(userid), Faction_GetName(playerid));
    va_SendClientMessage(userid, COLOR_YELLOW, "%s convidou você para se juntar a \"%s\" (digite \"/aceitar facção\").", pNome(playerid), Faction_GetName(playerid));

	return 1;
}

CMD:expulsar(playerid, params[])
{
    new
	    userid;

	if (pInfo[playerid][pFaction] == -1)
	    return SendErrorMessage(playerid, "Você precisa ser membro de uma facção.");

	if (pInfo[playerid][pFactionRank] < FactionData[pInfo[playerid][pFaction]][factionRanks] - 1)
	    return va_SendClientMessage(playerid, CINZA, "ERRO: Você precisa ser pelo menos cargo %d.", FactionData[pInfo[playerid][pFaction]][factionRanks] - 1);

	if (sscanf(params, "u", userid))
	    return SendUsageMessage(playerid, "/expulsar [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Este jogador está desconectado.");

	if (pInfo[userid][pFaction] != pInfo[playerid][pFaction])
	    return SendErrorMessage(playerid, "Este jogador não faz parte da sua facção.");

    va_SendClientMessage(playerid, COLOR_YELLOW, "Você removeu %s da facção \"%s\".", pNome(userid), Faction_GetName(playerid));
    va_SendClientMessage(userid, COLOR_YELLOW, "%s removeu você da facção \"%s\".", pNome(playerid), Faction_GetName(playerid));

    ResetFaction(userid);

	return 1;
}

CMD:promover(playerid, params[])
{
    new
	    userid,
		rankid;

	if (pInfo[playerid][pFaction] == -1)
	    return SendErrorMessage(playerid, "Você precisa ser membro de uma facção.");

	if (pInfo[playerid][pFactionRank] < FactionData[pInfo[playerid][pFaction]][factionRanks] - 1)
	    return va_SendClientMessage(playerid, CINZA, "ERRO: Você precisa ser pelo menos cargo %d", FactionData[pInfo[playerid][pFaction]][factionRanks] - 1);

	if (sscanf(params, "ud", userid, rankid))
	    return va_SendClientMessage(playerid, CINZA, "ERRO: /promover [playerid/nome] [cargo (1-%d)]", FactionData[pInfo[playerid][pFaction]][factionRanks]);

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Este jogador está desconectado.");

	if (userid == playerid)
	    return SendErrorMessage(playerid, "Você não pode setar seu próprio cargo.");

	if (pInfo[userid][pFaction] != pInfo[playerid][pFaction])
	    return SendErrorMessage(playerid, "Este jogador não faz parte da sua facção.");

	if (rankid < 0 || rankid > FactionData[pInfo[playerid][pFaction]][factionRanks])
	    return va_SendClientMessage(playerid, CINZA, "ERRO: Rank inváldio. Ranks devem variar entre 1 e %d.", FactionData[pInfo[playerid][pFaction]][factionRanks]);

	pInfo[userid][pFactionRank] = rankid;

    va_SendClientMessage(playerid, COLOR_YELLOW, "Você promoveu %s para %s (%d).", pNome(userid), Faction_GetRank(userid), rankid);
    va_SendClientMessage(userid, COLOR_YELLOW, "%s promoveu você %s (%d).", pNome(playerid), Faction_GetRank(userid), rankid);

	return 1;
}

ResetFaction(playerid)
{
    pInfo[playerid][pFaction] = -1;
    pInfo[playerid][pFactionID] = -1;
    pInfo[playerid][pFactionRank] = 0;
}

hook OnGameModeInit()
{
	mysql_tquery(DBConn, "SELECT * FROM `factions`", "Faction_Load", "");
	mysql_tquery(DBConn, "SELECT * FROM `graffiti`", "Graffiti_Load", "");
	Server_Load();
	return 1;
}

forward Faction_Load();
public Faction_Load()
{
	static
	    rows,
		str[32];
	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_FACTIONS)
	{
	    FactionData[i][factionExists] = true;

		cache_get_value_name_int(i, "factionID", FactionData[i][factionID]);
		cache_get_value_name(i, "factionName", FactionData[i][factionName]);

	    cache_get_value_name_int(i, "factionColor", FactionData[i][factionColor]);
	    cache_get_value_name_int(i, "factionType", FactionData[i][factionType]);
	    cache_get_value_name_int(i, "factionRanks", FactionData[i][factionRanks]);
	    cache_get_value_name_float(i, "factionLockerX", FactionData[i][factionLockerPos][0]);
	    cache_get_value_name_float(i, "factionLockerY", FactionData[i][factionLockerPos][1]);
	    cache_get_value_name_float(i, "factionLockerZ", FactionData[i][factionLockerPos][2]);
	    cache_get_value_name_int(i, "factionLockerInt", FactionData[i][factionLockerInt]);
	    cache_get_value_name_int(i, "factionLockerWorld", FactionData[i][factionLockerWorld]);

		//Spawning
		cache_get_value_name_float(i, "SpawnX", FactionData[i][SpawnX]);
	 	cache_get_value_name_float(i, "SpawnY", FactionData[i][SpawnY]);
   		cache_get_value_name_float(i, "SpawnZ", FactionData[i][SpawnZ]);
		cache_get_value_name_int(i, "SpawnInterior", FactionData[i][SpawnInterior]);
  		cache_get_value_name_int(i, "SpawnVW", FactionData[i][SpawnVW]);

	    for (new j = 0; j < 8; j ++) {
	        format(str, sizeof(str), "factionSkin%d", j + 1);
	        cache_get_value_name_int(i, str, FactionData[i][factionSkins][j]);
		}
        for (new j = 0; j < 10; j ++) {
	        format(str, sizeof(str), "factionWeapon%d", j + 1);

	        cache_get_value_name_int(i, str, FactionData[i][factionWeapons][j]);

	        format(str, sizeof(str), "factionAmmo%d", j + 1);

			cache_get_value_name_int(i, str, FactionData[i][factionAmmo][j]);
		}
		for (new j = 0; j < 15; j ++) {
		    format(str, sizeof(str), "factionRank%d", j + 1);

		    cache_get_value_name(i, str, FactionRanks[i][j], 32);
		}
		Faction_Refresh(i);
	}
	printf("FACTION SYSTEM: %d facções foram carregadas.", rows);
	return 1;
}

stock IsNearFactionLocker(playerid)
{
	new factionid = pInfo[playerid][pFaction];

	if (factionid == -1)
	    return 0;

	if (IsPlayerInRangeOfPoint(playerid, 3.0, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2]) && GetPlayerInterior(playerid) == FactionData[factionid][factionLockerInt] && GetPlayerVirtualWorld(playerid) == FactionData[factionid][factionLockerWorld])
	    return 1;

	return 0;
}

stock GetFactionByID(sqlid)
{
	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists] && FactionData[i][factionID] == sqlid)
	    return i;

	return -1;
}

SetFaction(playerid, id)
{
	if (id != -1 && FactionData[id][factionExists])
	{
		pInfo[playerid][pFaction] = id;
		pInfo[playerid][pFactionID] = FactionData[id][factionID];
	}
	return 1;
}

SetFactionColor(playerid)
{
	new factionid = pInfo[playerid][pFaction];

	if (factionid != -1)
		return SetPlayerColor(playerid, RemoveAlpha(FactionData[factionid][factionColor]));

	return 0;
}

Faction_Update(factionid)
{
	if (factionid != -1 || FactionData[factionid][factionExists])
	{
	    foreach (new i : Player) if (pInfo[i][pFaction] == factionid)
		{
 			if (GetFactionType(i) == FACTION_GANG || (GetFactionType(i) != FACTION_GANG && pInfo[i][pOnDuty]))
			 	SetFactionColor(i);
		}
	}
	return 1;
}

Faction_Refresh(factionid)
{
	if (factionid != -1 && FactionData[factionid][factionExists])
	{
	    if (FactionData[factionid][factionLockerPos][0] != 0.0 && FactionData[factionid][factionLockerPos][1] != 0.0 && FactionData[factionid][factionLockerPos][2] != 0.0)
	    {
		    static
		        string[128];

			if (IsValidDynamicPickup(FactionData[factionid][factionPickup]))
			    DestroyDynamicPickup(FactionData[factionid][factionPickup]);

			if (IsValidDynamic3DTextLabel(FactionData[factionid][factionText3D]))
			    DestroyDynamic3DTextLabel(FactionData[factionid][factionText3D]);

			FactionData[factionid][factionPickup] = CreateDynamicPickup(1239, 23, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], FactionData[factionid][factionLockerWorld], FactionData[factionid][factionLockerInt]);

			format(string, sizeof(string), "[Armário %d]\n{FFFFFF}/armario para acessar.", factionid);
	  		FactionData[factionid][factionText3D] = CreateDynamic3DTextLabel(string, COLOR_DARKBLUE, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], 15.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, FactionData[factionid][factionLockerWorld], FactionData[factionid][factionLockerInt]);
		}
	}
	return 1;
}

/*SetFactionMarker(playerid, type, color)
{
    foreach (new i : Player) if (GetFactionType(i) == type) {
    	SetPlayerMarkerForPlayer(i, playerid, color);
	}
	pInfo[playerid][pMarker] = 1;
	SetTimerEx("ExpireMarker", 300000, false, "d", playerid);
	return 1;
}*/

Faction_GetName(playerid)
{
    new
		factionid = pInfo[playerid][pFaction],
		name[32] = "N/A";

 	if (factionid == -1)
	    return name;

	format(name, 32, FactionData[factionid][factionName]);
	return name;
}

Faction_GetRank(playerid)
{
    new
		factionid = pInfo[playerid][pFaction],
		rank[32] = "N/A";

 	if (factionid == -1)
	    return rank;

	format(rank, 32, FactionRanks[factionid][pInfo[playerid][pFactionRank] - 1]);
	return rank;
}

stock SendFactionMessageEx(type, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (pInfo[i][pFaction] != -1 && GetFactionType(i) == type && !pInfo[i][pDisableFaction]) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (pInfo[i][pFaction] != -1 && GetFactionType(i) == type && !pInfo[i][pDisableFaction]) {
 		SendClientMessage(i, color, str);
	}
	return 1;
}

stock SendFactionMessage(factionid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (pInfo[i][pFaction] == factionid && !pInfo[i][pDisableFaction]) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (pInfo[i][pFaction] == factionid && !pInfo[i][pDisableFaction]) {
 		SendClientMessage(i, color, str);
	}
	return 1;
}

stock RemoveAlpha(color) {
    return (color & ~0xFF);
}

stock SQL_ReturnEscaped(const string[])
{
	new
	    entry[256];
	mysql_escape_string(string, entry);
	return entry;
}
// COMANDOS PLAYERS

CMD:dep(playerid, params[])
{
	new string[256];
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
	    return SendErrorMessage(playerid, "Você deve ser um funcionário público para poder utilizar esse comando.");

	if (isnull(params))
	    return SendUsageMessage(playerid, "/dep [rádio do departamento]");

	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionType] == FACTION_POLICE || FactionData[i][factionType] == FACTION_MEDIC || FactionData[i][factionType] == FACTION_GOV) {
		SendFactionMessage(i, COLOR_DEPARTMENT, "[%s] %s %s: %s", GetInitials(Faction_GetName(playerid)), Faction_GetRank(playerid), pNome(playerid), params);
	}
	format(string, sizeof string, " `LOG-DEP:` [%s] [%s] %s **%s**: %s", ReturnDate(), GetInitials(Faction_GetName(playerid)), Faction_GetRank(playerid), pNome(playerid), params);
    DCC_SendChannelMessage(DC_LogFac, string);
	return 1;
}

// COP
CMD:taser(playerid, params[])
{
	if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || !IsPlayerSpawned(playerid))
	    return SendErrorMessage(playerid, "Você não pode usar esse comando agora.");

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "Você precisa ser de uma facção policial para poder utilizar esse comando.");

	if (!pInfo[playerid][pTazer])
	{
	    pInfo[playerid][pTazer] = 1;
	    GetPlayerWeaponData(playerid, 2, pInfo[playerid][pGuns][2], pInfo[playerid][pAmmo][2]);

		GivePlayerWeapon(playerid, 23, 20000);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s retira um taser de seu coldre.", pNome(playerid));
	}
	else
	{
	    pInfo[playerid][pTazer] = 0;
		SetWeapons(playerid);

		SetPlayerArmedWeapon(playerid, pInfo[playerid][pGuns][2]);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s devolve o taser para o coldre.", pNome(playerid));
	}
	return 1;
}

CMD:beanbag(playerid, params[])
{
	if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || !IsPlayerSpawned(playerid))
	    return SendErrorMessage(playerid, "Você não pode usar esse comando agora.");

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "Você precisa ser de uma facção policial para poder utilizar esse comando.");

	if (!pInfo[playerid][pBeanBag])
	{
	    pInfo[playerid][pBeanBag] = 1;
	    GetPlayerWeaponData(playerid, 3, pInfo[playerid][pGuns][3], pInfo[playerid][pAmmo][3]);

		GivePlayerWeapon(playerid, 25, 20000);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pega uma espingarda de bala de borracha.", pNome(playerid));
	}
	else
	{
	    pInfo[playerid][pBeanBag] = 0;
		SetWeapons(playerid);

		SetPlayerArmedWeapon(playerid, pInfo[playerid][pGuns][3]);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s guarda uma espingarda de bala de borracha.", pNome(playerid));
	}
	return 1;
}

CMD:callsign(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
	new string[32];
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Você não está em um veículo.");
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV && GetFactionType(playerid) != FACTION_NEWS)
		return SendErrorMessage(playerid, "Você não faz parte de uma facção oficial.");
	if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 1)
	{
 		Delete3DTextLabel(vehicle3Dtext[vehicleid]);
	    vehiclecallsign[vehicleid] = 0;
	    SendClientMessage(playerid, -1, "Callsign remoida.");
	    return 1;
	}
	if(sscanf(params, "s[32]",string)) return SendErrorMessage(playerid, "Você precisa digitar uma callsign.");
	if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 0)
	{
		vehicle3Dtext[vehicleid] = Create3DTextLabel(string, COLOR_WHITE, 0.0, 0.0, 0.0, 10.0, 0, 1);
		Attach3DTextLabelToVehicle(vehicle3Dtext[vehicleid], vehicleid, 0.0, -2.8, 0.0);
		vehiclecallsign[vehicleid] = 1;
	}
	return 1;
}

CMD:aremovercallsign(playerid, params[])
{
	new vehicleid;
	if (uInfo[playerid][uAdmin] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	if(sscanf(params, "i", vehicleid)) return SendErrorMessage(playerid, "Insira o ID do veículo.");
    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "Você específicou um ID inválido.");
	Delete3DTextLabel(vehicle3Dtext[vehicleid]);
	return 1;
}

CMD:m(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
	    return SendErrorMessage(playerid, "Você não pode usar um megafone.");

	if (isnull(params))
	    return SendUsageMessage(playerid, "/(m)egafone [meensagem]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "[MEGAFONE] %s diz: %.64s", pNome(playerid), params);
	    SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "[MEGAFONE] %s diz: %s", pNome(playerid), params);
	}
	return 1;
}

CMD:sirene(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE)
	    return SendErrorMessage(playerid, "Você precisa ser de uma facção policial para poder utilizar esse comando.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if (!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você precisa estar dentro de um veículo.");

	switch (CoreVehicles[vehicleid][vehSirenOn])
	{
	    case 0:
	    {
			static
        		Float:fSize[3],
        		Float:fSeat[3];

		    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]); // need height (z)
    		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]); // need pos (x, y)

            CoreVehicles[vehicleid][vehSirenOn] = 1;
			CoreVehicles[vehicleid][vehSirenObject] = CreateDynamicObject(18646, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0);

		    AttachDynamicObjectToVehicle(CoreVehicles[vehicleid][vehSirenObject], vehicleid, -fSeat[0], fSeat[1], fSize[2] / 2.0, 0.0, 0.0, 0.0);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s conecta uma sirene portátil ao veículo.", pNome(playerid));
		}
		case 1:
		{
		    CoreVehicles[vehicleid][vehSirenOn] = 0;

			DestroyDynamicObject(CoreVehicles[vehicleid][vehSirenObject]);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s desconecta uma sirene portátil ao veículo.", pNome(playerid));
		}
	}
	return 1;
}

CMD:algemar(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "Você precisa ser de uma facção policial para poder utilizar esse comando.");

	if (sscanf(params, "u", userid))
	    return SendUsageMessage(playerid, "/algemar [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Este jogador está desconectado.");

    if (userid == playerid)
	    return SendErrorMessage(playerid, "Você não pode algemar você mesmo.");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Você precisa estar perto deste jogador.");

    if (pInfo[userid][pStunned] < 0 && GetPlayerSpecialAction(userid) != SPECIAL_ACTION_HANDSUP && !IsPlayerIdle(userid))
	   return SendErrorMessage(playerid, "O jogador precisa estar parado ou stunado.");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendErrorMessage(playerid, "O jogador precisa estar em pé antes de ser algemado.");

    if (pInfo[userid][pCuffed])
        return SendErrorMessage(playerid, "Este jogador já está algemado.");

	/*if (pInfo[userid][pHoldWeapon] > 0)
	{
	    HoldWeapon(userid, 0);
	}*/
    pInfo[userid][pCuffed] = 1;
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s aperta um par de algemas nos pulsos de %s.", pNome(playerid), pNome(userid));
    return 1;
}

CMD:desalgemar(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "Você precisa ser de uma facção policial para poder utilizar esse comando.");

	if (sscanf(params, "u", userid))
	    return SendUsageMessage(playerid, "/desalgemar [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Este jogador está desconectado.");

    if (userid == playerid)
	    return SendErrorMessage(playerid, "Você não pode desalgemar você mesmo.");

    if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Você precisa estar perto deste jogador.");

    if (!pInfo[userid][pCuffed])
        return SendErrorMessage(playerid, "Este jogador não está algemado.");

    pInfo[userid][pCuffed] = 0;
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s remove as algemas dos pulsos de %s.", pNome(playerid), pNome(userid));
    return 1;
}

CMD:deter(playerid, params[])
{
	new
		userid,
		vehicleid = GetNearestVehicle(playerid);

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "Você precisa ser de uma facção policial para poder utilizar esse comando.");

	if (sscanf(params, "u", userid))
	    return SendUsageMessage(playerid, "/deter [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

    if (userid == playerid)
	    return SendErrorMessage(playerid, "Você não pode deter você mesmo.");

    if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Você precisa estar perto do jogador.");

    if (!pInfo[userid][pCuffed])
        return SendErrorMessage(playerid, "Este jogador precisa estar algemado.");

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendErrorMessage(playerid, "Você não está perto de nenhum veículo.");

	if (GetVehicleMaxSeats(vehicleid) < 2)
  	    return SendErrorMessage(playerid, "Você não pode colocar um detento neste veículo.");

	if (IsPlayerInVehicle(userid, vehicleid))
	{
		TogglePlayerControllable(userid, 1);

		RemoveFromVehicle(userid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s abre a porta do veículo e remove %s de lá.", pNome(playerid), pNome(userid));
	}
	else
	{
		new seatid = GetAvailableSeat(vehicleid, 2);

		if (seatid == -1)
		    return SendErrorMessage(playerid, "Não há lugares disponíveis nesse veículo.");

		TogglePlayerControllable(userid, 0);

		StopDragging(userid);
		PutPlayerInVehicle(userid, vehicleid, seatid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s abre a porta do veículo e coloca %s lá dentro.", pNome(playerid), pNome(userid));
	}
	return 1;
}

CMD:arrastar(playerid, params[])
{
	new
	    userid;

    if (sscanf(params, "u", userid))
	    return SendUsageMessage(playerid, "/arrastar [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

    if (userid == playerid)
	    return SendErrorMessage(playerid, "Você não pode arrastar você mesmo.");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Você precisa estar perto deste jogador.");

    if (!pInfo[userid][pCuffed] && !pInfo[userid][pStunned])
        return SendErrorMessage(playerid, "Este jogador precisa estar algemado ou stunado.");

	if (pInfo[userid][pDragged])
	{
	    pInfo[userid][pDragged] = 0;
	    pInfo[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(pInfo[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s para de arrastar %s.", pNome(playerid), pNome(userid));
	}
	else
	{
	    pInfo[userid][pDragged] = 1;
	    pInfo[userid][pDraggedBy] = playerid;

	    pInfo[userid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, userid);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s segura %s e começa a arrastar.", pNome(playerid), pNome(userid));
	}
	return 1;
}
// GOV

CMD:cofresacar(playerid, params[])
{
	static
	    amount;

	if (GetFactionType(playerid) != FACTION_GOV)
	    return SendErrorMessage(playerid, "Você não é um oficial do governo.");

	if (sscanf(params, "d", amount))
		return va_SendClientMessage(playerid, CINZA, "USE: /cofresacar [quantidade] (%s disponível)", FormatNumber(g_TaxVault));

	/*if (!IsPlayerInCityHall(playerid))
	    return SendErrorMessage(playerid, "Você precisa estar dentro da City Hall para fazer isso.");*/

	if (amount < 1 || amount > g_TaxVault)
	    return SendErrorMessage(playerid, "Quantidade específicada inválida.");

    if (pInfo[playerid][pFactionRank] < FactionData[pInfo[playerid][pFaction]][factionRanks] - 1)
	    return va_SendClientMessage(playerid, CINZA, "ERRO: Você precisa ser pelo menos cargo %d", FactionData[pInfo[playerid][pFaction]][factionRanks] - 1);

	Tax_AddMoney(-amount);

	GiveMoney(playerid, amount);
	va_SendClientMessage(playerid, COLOR_YELLOW, "Você tirou %s do cofre do governo (%s disponível).", FormatNumber(amount), FormatNumber(g_TaxVault));
	new string[256];
	format(string, sizeof string, " `LOG-COGREGOV:` [%s] %s **retirou** %s do cofre do governo.", ReturnDate(), pNome(playerid), FormatNumber(amount));
    DCC_SendChannelMessage(DC_LogFac, string);
	return 1;
}

CMD:cofredepositar(playerid, params[])
{
	static
	    amount;

	if (GetFactionType(playerid) != FACTION_GOV)
	    return SendErrorMessage(playerid, "Você não é um oficial do governo.");

	if (sscanf(params, "d", amount))
		return va_SendClientMessage(playerid, CINZA, "ERRO: /cofredepositar [quantidade] (%s disponível)", FormatNumber(g_TaxVault));

    /*if (!IsPlayerInCityHall(playerid))
	    return SendErrorMessage(playerid, "Você precisa estar dentro da City Hall para fazer isso.");*/

	if (amount < 1 || amount > GetMoney(playerid))
	    return SendErrorMessage(playerid, "Quantidade específicada inválida.");

	if (pInfo[playerid][pFactionRank] < FactionData[pInfo[playerid][pFaction]][factionRanks] - 1)
	    return va_SendClientMessage(playerid, CINZA, "ERRO: Você precisa ser pelo menos cargo %d", FactionData[pInfo[playerid][pFaction]][factionRanks] - 1);

	Tax_AddMoney(amount);

	GiveMoney(playerid, -amount);
	va_SendClientMessage(playerid, COLOR_YELLOW, "Você depositou %s no cofre do governo (%s disponível).", FormatNumber(amount), FormatNumber(g_TaxVault));

	new string[256];
	format(string, sizeof string, " `LOG-COGREGOV:` [%s] %s **colocou** %s no cofre do governo.", ReturnDate(), pNome(playerid), FormatNumber(amount));
    DCC_SendChannelMessage(DC_LogFac, string);
	return 1;
}

stock Tax_Percent(price)
{
	return floatround((float(price) / 100) * 85);
}

stock Tax_AddMoney(amount)
{
	g_TaxVault = g_TaxVault + amount;

	Server_Save();
	return 0;
}

stock Tax_AddPercent(price)
{
	new money = (price - Tax_Percent(price));

	g_TaxVault = g_TaxVault + money;

	Server_Save();
	return 1;
}

Server_Save()
{
	new
	    File:file = fopen("server.ini", io_write),
	    str[128];

	format(str, sizeof(str), "TaxMoney = %d\n", g_TaxVault);
	return (fwrite(file, str), fclose(file));
}

Server_Load()
{
	new File:file = fopen("server.ini", io_read);

	if (file) {
		g_TaxVault = file_parse_int(file, "TaxMoney");

		fclose(file);
	}
	return 1;
}

stock file_parse_int(File:handle, const field[])
{
	new
	    str[16];

	return (file_parse(handle, field, str), strval(str));
}

stock file_parse(File:handle, const field[], dest[], size = sizeof(dest))
{
	if (!handle)
	    return 0;

	new
	    str[128],
		pos = strlen(field);

	fseek(handle, 0, seek_start);

	while (fread(handle, str)) if (strfind(str, field, true) == 0 && (str[pos] == '=' || str[pos] == ' '))
	{
	    strmid(dest, str, (str[pos] == '=') ? (pos + 1) : (pos + 3), strlen(str), size);

		if ((pos = strfind(dest, "\r")) != -1)
			dest[pos] = '\0';
   		else if ((pos = strfind(dest, "\n")) != -1)
     		dest[pos] = '\0';

		return 1;
	}
	return 0;
}

// GANG

CMD:pichar(playerid, params[])
{
	new id = Graffiti_Nearest(playerid);

	if (id == -1)
	    return SendErrorMessage(playerid, "Você não está perto de um ponto de pichação.");

	if (GetFactionType(playerid) != FACTION_GANG)
	    return SendErrorMessage(playerid, "Você não é membro de uma facção ilegal.");

	Dialog_Show(playerid, GraffitiColor, DIALOG_STYLE_LIST, "Selecionar Cor", "{FFFFFF}Branco\n{FF0000}Vermelho\n{FFFF00}Amarelo\n{33CC33}Verde\n{33CCFF}Azul Ciano\n{FFA500}Laranja\n{1394BF}Azul Escuro", "Selecionar", "Cancelar");
	return 1;
}

CMD:criarpichacao(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z,
		Float:angle;

	if (uInfo[playerid][uFactionMod] < 1)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	
    if (uInfo[playerid][uAdmin] < 3)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
 		return SendErrorMessage(playerid, "Você não pode criar pontos de pichação em interiores.");

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	id = Graffiti_Create(x, y, z, angle);

	if (id == -1)
	    return SendErrorMessage(playerid, "O servidor atingiu o limite de pichações.");

	EditDynamicObject(playerid, GraffitiData[id][graffitiObject]);

	pInfo[playerid][pEditGraffiti] = id;
	va_SendClientMessage(playerid, COLOR_YELLOW, "Você criou com sucesso o ponto de pichação ID: %d.", id);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* criou o ponto de pichacao ID: %d.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
	DCC_SendChannelMessage(DC_AdminCMD, textdc);
	Graffiti_Save(id);
	return 1;
}

CMD:destruirpichacao(playerid, params[])
{
	static
	    id = 0;

    if (uInfo[playerid][uFactionMod] < 1)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	
    if (uInfo[playerid][uAdmin] < 3)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "d", id))
	    return SendUsageMessage(playerid, "/destruirpichacao [pichação id]");

	if ((id < 0 || id >= MAX_GRAFFITI_POINTS) || !GraffitiData[id][graffitiExists])
	    return SendErrorMessage(playerid, "Você especificou uma pichação inválida.");

	Graffiti_Delete(id);
	va_SendClientMessage(playerid, COLOR_YELLOW, "Você destruiu com sucesso a pichação ID: %d.", id);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* destruiu o ponto de pichacao ID: %d.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
	DCC_SendChannelMessage(DC_AdminCMD, textdc);
	return 1;
}

stock Graffiti_Nearest(playerid)
{
	for (new i = 0; i < MAX_GRAFFITI_POINTS; i ++) if (GraffitiData[i][graffitiExists] && IsPlayerInRangeOfPoint(playerid, 5.0, GraffitiData[i][graffitiPos][0], GraffitiData[i][graffitiPos][1], GraffitiData[i][graffitiPos][2]))
	    return i;

	return -1;
}

stock Graffiti_Delete(id)
{
    if (id != -1 && GraffitiData[id][graffitiExists])
	{
		if (IsValidDynamicMapIcon(GraffitiData[id][graffitiIcon]))
		    DestroyDynamicMapIcon(GraffitiData[id][graffitiIcon]);

		if (IsValidDynamicObject(GraffitiData[id][graffitiObject]))
			DestroyDynamicObject(GraffitiData[id][graffitiObject]);

		mysql_format(DBConn, query, sizeof(query), "DELETE FROM `graffiti` WHERE `graffitiID` = '%d'", GraffitiData[id][graffitiID]);
		mysql_tquery(DBConn, query);

		GraffitiData[id][graffitiExists] = false;
		GraffitiData[id][graffitiText][0] = 0;
		GraffitiData[id][graffitiID] = 0;
	}
	return 1;
}

stock Graffiti_Save(id)
{

	mysql_format(DBConn, query, sizeof(query), "UPDATE  `graffiti` SET \
	`graffitiX` = '%.4f', \
	`graffitiY` = '%.4f', \
	`graffitiZ` = '%.4f', \
	`graffitiAngle` = '%.4f', \
	`graffitiColor` = '%d', \
	`graffitiText` = '%s' WHERE `graffitiID` = '%d'",
    GraffitiData[id][graffitiPos][0],
    GraffitiData[id][graffitiPos][1],
    GraffitiData[id][graffitiPos][2],
    GraffitiData[id][graffitiPos][3],
	GraffitiData[id][graffitiColor],
	GraffitiData[id][graffitiText],
	GraffitiData[id][graffitiID]);
	mysql_tquery(DBConn, query);
}

stock Graffiti_Create(Float:x, Float:y, Float:z, Float:angle)
{
	for (new i = 0; i < MAX_GRAFFITI_POINTS; i ++)
	{
	    if (!GraffitiData[i][graffitiExists])
	    {
			GraffitiData[i][graffitiExists] = 1;
			GraffitiData[i][graffitiPos][0] = x;
			GraffitiData[i][graffitiPos][1] = y;
			GraffitiData[i][graffitiPos][2] = z;
			GraffitiData[i][graffitiPos][3] = angle - 90.0;
			GraffitiData[i][graffitiColor] = 0xFFFFFFFF;

			format(GraffitiData[i][graffitiText], 32, "Graffiti");

			Graffiti_Refresh(i);
			mysql_format(DBConn, query, sizeof(query), "INSERT INTO `graffiti` (`graffitiColor`) VALUES(0)"); 
			mysql_tquery(DBConn, query, "OnGraffitiCreated", "d", i);

			return i;
		}
	}
	return -1;
}

stock Graffiti_Refresh(id)
{
	if (id != -1 && GraffitiData[id][graffitiExists])
	{
		if (IsValidDynamicMapIcon(GraffitiData[id][graffitiIcon]))
		    DestroyDynamicMapIcon(GraffitiData[id][graffitiIcon]);

		if (IsValidDynamicObject(GraffitiData[id][graffitiObject]))
			DestroyDynamicObject(GraffitiData[id][graffitiObject]);

        //GraffitiData[id][graffitiIcon] = CreateDynamicMapIcon(GraffitiData[id][graffitiPos][0], GraffitiData[id][graffitiPos][1], GraffitiData[id][graffitiPos][2], 23, 0, -1, -1, -1, 100.0, MAPICON_GLOBAL);
		GraffitiData[id][graffitiObject] = CreateDynamicObject(19482, GraffitiData[id][graffitiPos][0], GraffitiData[id][graffitiPos][1], GraffitiData[id][graffitiPos][2], 0.0, 0.0, GraffitiData[id][graffitiPos][3]);

		SetDynamicObjectMaterial(GraffitiData[id][graffitiObject], 0, 0, "none", "none", 0);
		SetDynamicObjectMaterialText(GraffitiData[id][graffitiObject], 0, GraffitiData[id][graffitiText], OBJECT_MATERIAL_SIZE_256x128, "Arial", 24, 1, GraffitiData[id][graffitiColor], 0, 0);
	}
	return 1;
}

stock IsSprayingInProgress(id)
{
	foreach (new i : Player)
	{
	    if (pInfo[i][pGraffiti] == id && IsPlayerInRangeOfPoint(i, 5.0, GraffitiData[id][graffitiPos][0], GraffitiData[id][graffitiPos][1], GraffitiData[id][graffitiPos][2]))
	        return 1;
	}
	return 0;
}

forward Graffiti_Load();
public Graffiti_Load()
{
	static
	    rows;

	cache_get_row_count(rows);
	for (new i = 0; i < rows; i ++) if (i < MAX_GRAFFITI_POINTS)
	{
	    cache_get_field_name(i, "graffitiText", GraffitiData[i][graffitiText]);

    	GraffitiData[i][graffitiExists] = 1;

		cache_get_value_name_int(i, "graffitiID",  GraffitiData[i][graffitiID]);
	    
	    cache_get_value_name_float(i, "graffitiX", GraffitiData[i][graffitiPos][0]);
	   	cache_get_value_name_float(i, "graffitiY",  GraffitiData[i][graffitiPos][1]);
	    cache_get_value_name_float(i, "graffitiZ", GraffitiData[i][graffitiPos][2]);
	    cache_get_value_name_float(i, "graffitiAngle", GraffitiData[i][graffitiPos][3]);
	    cache_get_value_name_int(i, "graffitiColor", GraffitiData[i][graffitiColor]);
		Graffiti_Refresh(i);
	}
	printf("GRAFFITI SYSTEM: %d pontos de pichação foram carregados.", rows);
	return 1;
}

forward OnGraffitiCreated(id);
public OnGraffitiCreated(id)
{
	GraffitiData[id][graffitiID] = cache_insert_id();
	Graffiti_Save(id);

	return 1;
}

Dialog:GraffitiText(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = Graffiti_Nearest(playerid);

		if (id == -1)
		    return 0;

	    if (isnull(inputtext))
	        return Dialog_Show(playerid, GraffitiText, DIALOG_STYLE_INPUT, "Texto da Pichação", "Digite o que você deseja pichar.\n\nINFO: Seu texto não pode passar de 64 caracteres.", "Enviar", "Cancelar");

		if (strlen(inputtext) > 64)
		    return Dialog_Show(playerid, GraffitiText, DIALOG_STYLE_INPUT, "Texto da Pichação", "ERRO: Seu texto passou de 64 caracteres\n\nDigite o que você deseja pichar.\nINFO: Seu texto não pode passar de 64 caracteres.", "Enviar", "Cancelar");

        if (IsSprayingInProgress(id))
	        return SendErrorMessage(playerid, "Existe um outro jogador pichando esse mesmo ponto.");

        pInfo[playerid][pGraffiti] = id;
        pInfo[playerid][pGraffitiTime] = 15;

		strpack(pInfo[playerid][pGraffitiText], inputtext, 64 char);
		ApplyAnimationEx(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 0, 0, 1);

		GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~b~Pichando...~w~ aguarde!", 15000, 3);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s tira uma lata de tinta spray e começa a pichar a parede.", pNome(playerid));
	}
	return 1;
}

Dialog:GraffitiColor(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = Graffiti_Nearest(playerid);

		if (id == -1)
		    return 0;

	    if (IsSprayingInProgress(id))
	        return SendErrorMessage(playerid, "Existe um outro jogador pichando esse mesmo ponto.");

	    switch (listitem)
	    {
	        case 0:
	            pInfo[playerid][pGraffitiColor] = 0xFFFFFFFF;

	        case 1:
	            pInfo[playerid][pGraffitiColor] = 0xFFFF0000;

	        case 2:
	            pInfo[playerid][pGraffitiColor] = 0xFFFFFF00;

	        case 3:
	            pInfo[playerid][pGraffitiColor] = 0xFF33CC33;

	        case 4:
	            pInfo[playerid][pGraffitiColor] = 0xFF33CCFF;

	        case 5:
	            pInfo[playerid][pGraffitiColor] = 0xFFFFA500;

	        case 6:
	            pInfo[playerid][pGraffitiColor] = 0xFF1394BF;
	    }
	    Dialog_Show(playerid, GraffitiText, DIALOG_STYLE_INPUT, "Texto da Pichação", "Digite o que você deseja pichar.\n\nINFO: Seu texto não pode passar de 64 caracteres.", "Enviar", "Cancelar");
	}
	return 1;
}

stock AnimationCheck(playerid)
{
	return (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && pInfo[playerid][pGraffiti] == -1 && );
}

stock IsPlayerIdle(playerid) {
	new
	    index = GetPlayerAnimationIndex(playerid);

	return ((index == 1275) || (1181 <= index <= 1192));
}

forward DragUpdate(playerid, targetid);
public DragUpdate(playerid, targetid)
{
	if (pInfo[targetid][pDragged] && pInfo[targetid][pDraggedBy] == playerid)
	{
	    static
	        Float:fX,
	        Float:fY,
	        Float:fZ,
			Float:fAngle;

		GetPlayerPos(playerid, fX, fY, fZ);
		GetPlayerFacingAngle(playerid, fAngle);

		fX -= 3.0 * floatsin(-fAngle, degrees);
		fY -= 3.0 * floatcos(-fAngle, degrees);

		SetPlayerPos(targetid, fX, fY, fZ);
		SetPlayerInterior(targetid, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
	}
	return 1;
}

StopDragging(playerid)
{
	if (pInfo[playerid][pDragged])
	{
	    pInfo[playerid][pDragged] = 0;
		pInfo[playerid][pDraggedBy] = INVALID_PLAYER_ID;
		KillTimer(pInfo[playerid][pDragTimer]);
	}
	return 1;
}

hook OP_EditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if (response == EDIT_RESPONSE_FINAL)
	{
	    if (pInfo[playerid][pEditGraffiti] != -1 && GraffitiData[pInfo[playerid][pEditGraffiti]][graffitiExists])
	    {
			GraffitiData[pInfo[playerid][pEditGraffiti]][graffitiPos][0] = x;
			GraffitiData[pInfo[playerid][pEditGraffiti]][graffitiPos][1] = y;
			GraffitiData[pInfo[playerid][pEditGraffiti]][graffitiPos][2] = z;
			GraffitiData[pInfo[playerid][pEditGraffiti]][graffitiPos][3] = rz;

			Graffiti_Refresh(pInfo[playerid][pEditGraffiti]);
			Graffiti_Save(pInfo[playerid][pEditGraffiti]);
		}
	}
	if (response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
	{
        if (pInfo[playerid][pEditGraffiti] != -1)
			Graffiti_Refresh(pInfo[playerid][pEditGraffiti]);

		pInfo[playerid][pEditGraffiti] = -1;
	}
	return 1;
}
