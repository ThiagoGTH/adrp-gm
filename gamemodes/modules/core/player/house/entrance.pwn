#include <YSI_Coding\y_hooks>

#define MAX_ENTRANCES (500)

enum entranceData {
	entranceID,
	entranceExists,
	entranceName[32],
	entrancePass[32],
	entranceIcon,
	entranceLocked,
	Float:entrancePos[4],
	Float:entranceInt[4],
	entranceInterior,
	entranceExterior,
	entranceExteriorVW,
	entranceType,
	entranceCustom,
	entranceWorld,
	entranceForklift[7],
	entrancePickup,
	entranceMapIcon,
	Text3D:entranceText3D
};
new EntranceData[MAX_ENTRANCES][entranceData];

stock GetPlayerLocationEx(playerid, &Float:fX, &Float:fY, &Float:fZ)
{
	new
	    id = -1;

   /* if ((id = House_Inside(playerid)) != -1)
	{
		fX = HouseData[id][housePos][0];
		fY = HouseData[id][housePos][1];
		fZ = HouseData[id][housePos][2];
	}
	else if ((id = Business_Inside(playerid)) != -1)
	{
		fX = BusinessData[id][bizPos][0];
		fY = BusinessData[id][bizPos][1];
		fZ = BusinessData[id][bizPos][2];
	}*/
	if ((id = Entrance_Inside(playerid)) != -1)
	{
		fX = EntranceData[id][entrancePos][0];
		fY = EntranceData[id][entrancePos][1];
		fZ = EntranceData[id][entrancePos][2];
	}
	else GetPlayerPos(playerid, fX, fY, fZ);
	return 1;
}

stock GetPlayerLocation(playerid)
{
	new
	    Float:fX,
	    Float:fY,
		Float:fZ,
		string[32],
		id = -1;

	/*if ((id = House_Inside(playerid)) != -1)
	{
		fX = HouseData[id][housePos][0];
		fY = HouseData[id][housePos][1];
		fZ = HouseData[id][housePos][2];
	}
	else if ((id = Business_Inside(playerid)) != -1)
	{
		fX = BusinessData[id][bizPos][0];
		fY = BusinessData[id][bizPos][1];
		fZ = BusinessData[id][bizPos][2];
	}*/
	if ((id = Entrance_Inside(playerid)) != -1)
	{
		fX = EntranceData[id][entrancePos][0];
		fY = EntranceData[id][entrancePos][1];
		fZ = EntranceData[id][entrancePos][2];
	}
	else GetPlayerPos(playerid, fX, fY, fZ);

	format(string, 32, GetLocation(fX, fY, fZ));
	return string;
}


/*GetClosestEntrance(playerid, type)
{
	new
	    Float:fDistance[2] = {99999.0, 0.0},
	    iIndex = -1
	;
	for (new i = 0; i < MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && EntranceData[i][entranceType] == type && GetPlayerInterior(playerid) == EntranceData[i][entranceExterior] && GetPlayerVirtualWorld(playerid) == EntranceData[i][entranceExteriorVW])
	{
		fDistance[1] = GetPlayerDistanceFromPoint(playerid, EntranceData[i][entrancePos][0], EntranceData[i][entrancePos][1], EntranceData[i][entrancePos][2]);

		if (fDistance[1] < fDistance[0])
		{
		    fDistance[0] = fDistance[1];
		    iIndex = i;
		}
	}
	return iIndex;
}*/

forward Entrance_Load();
public Entrance_Load()
{
    static
	    rows; 
    cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_ENTRANCES)
	{
	    EntranceData[i][entranceExists] = true;
    	cache_get_value_name_int(i, "entranceID", EntranceData[i][entranceID]);

		cache_get_value_name(i, "entranceName", EntranceData[i][entranceName]);
		cache_get_value_name(i, "entrancePass", EntranceData[i][entrancePass]);

	    cache_get_value_name_int(i, "entranceIcon", EntranceData[i][entranceIcon]);
	    cache_get_value_name_int(i, "entranceLocked", EntranceData[i][entranceLocked]);
	    cache_get_value_name_float(i, "entrancePosX", EntranceData[i][entrancePos][0]);
	    cache_get_value_name_float(i, "entrancePosY", EntranceData[i][entrancePos][1]);
	    cache_get_value_name_float(i, "entrancePosZ", EntranceData[i][entrancePos][2]);
	    cache_get_value_name_float(i, "entrancePosA", EntranceData[i][entrancePos][3]);
	    cache_get_value_name_float(i, "entranceIntX",  EntranceData[i][entranceInt][0]);
	    cache_get_value_name_float(i, "entranceIntY",  EntranceData[i][entranceInt][1]);
	    cache_get_value_name_float(i, "entranceIntZ",  EntranceData[i][entranceInt][2]);
	    cache_get_value_name_float(i, "entranceIntA",  EntranceData[i][entranceInt][3]);
	    cache_get_value_name_int(i, "entranceInterior", EntranceData[i][entranceInterior]);
	    cache_get_value_name_int(i, "entranceExterior", EntranceData[i][entranceExterior]);
	    cache_get_value_name_int(i, "entranceExteriorVW", EntranceData[i][entranceExteriorVW]);
	    cache_get_value_name_int(i, "entranceType", EntranceData[i][entranceType]);
	    cache_get_value_name_int(i, "entranceCustom", EntranceData[i][entranceCustom]);
	    cache_get_value_name_int(i, "entranceWorld", EntranceData[i][entranceWorld]);

	    Entrance_Refresh(i);
	}
	printf("PROPERTY SYSTEM: %d entradas foram carregadas.", rows);
	return 1;
}

Entrance_Delete(entranceid)
{
	if (entranceid != -1 && EntranceData[entranceid][entranceExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `entrances` WHERE `entranceID` = '%d'", EntranceData[entranceid][entranceID]);
		mysql_tquery(DBConn, string);

        if (IsValidDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]))
		    DestroyDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]);

		if (IsValidDynamicPickup(EntranceData[entranceid][entrancePickup]))
		    DestroyDynamicPickup(EntranceData[entranceid][entrancePickup]);

		if (IsValidDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]))
		    DestroyDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]);

		/*if (EntranceData[entranceid][entranceType] == 3)
		    DestroyForklifts(entranceid);*/

	    EntranceData[entranceid][entranceExists] = false;
	    EntranceData[entranceid][entranceID] = 0;
	}
	return 1;
}

Entrance_Save(entranceid)
{
	mysql_format(DBConn, query, sizeof(query), "UPDATE `entrances` SET \
		`entranceName` = '%s', \
		`entrancePass` = '%s', \
		`entranceIcon` = '%d', \
		`entranceLocked` = '%d', \
		`entrancePosX` = '%.4f', \
		`entrancePosY` = '%.4f', \
		`entrancePosZ` = '%.4f', \
		`entrancePosA` = '%.4f', \
		`entranceIntX` = '%.4f', \
		`entranceIntY` = '%.4f', \
		`entranceIntZ` = '%.4f', \
		`entranceIntA` = '%.4f', \
		`entranceInterior` = '%d', \
		`entranceExterior` = '%d', \
		`entranceExteriorVW` = '%d', \
		`entranceType` = '%d', \
		`entranceCustom` = '%d', \
		`entranceWorld` = '%d' WHERE `entranceID` = '%d'",
		EntranceData[entranceid][entranceName],
		EntranceData[entranceid][entrancePass],
		EntranceData[entranceid][entranceIcon],
		EntranceData[entranceid][entranceLocked],
		EntranceData[entranceid][entrancePos][0],
		EntranceData[entranceid][entrancePos][1],
		EntranceData[entranceid][entrancePos][2],
		EntranceData[entranceid][entrancePos][3],
		EntranceData[entranceid][entranceInt][0],
		EntranceData[entranceid][entranceInt][1],
		EntranceData[entranceid][entranceInt][2],
		EntranceData[entranceid][entranceInt][3],
		EntranceData[entranceid][entranceInterior],
		EntranceData[entranceid][entranceExterior],
		EntranceData[entranceid][entranceExteriorVW],
		EntranceData[entranceid][entranceType],
		EntranceData[entranceid][entranceCustom],
		EntranceData[entranceid][entranceWorld],
		EntranceData[entranceid][entranceID]);
	mysql_tquery(DBConn, query);
}
/*
IsPlayerInCityHall(playerid)
{
	new
		id = -1;

	if ((id = Entrance_Inside(playerid)) != -1 && EntranceData[id][entranceType] == 4)
	    return 1;

	return 0;
}

IsPlayerInWarehouse(playerid)
{
	new
		id = -1;

	if ((id = Entrance_Inside(playerid)) != -1 && EntranceData[id][entranceType] == 3)
	    return 1;

	return 0;
}

IsPlayerInBank(playerid)
{
	new
		id = -1;

	if ((id = Entrance_Inside(playerid)) != -1 && EntranceData[id][entranceType] == 2)
	    return 1;

	return 0;
}
*/
Entrance_Inside(playerid)
{
	if (pInfo[playerid][pEntrance] != -1)
	{
	    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && EntranceData[i][entranceID] == pInfo[playerid][pEntrance] && GetPlayerInterior(playerid) == EntranceData[i][entranceInterior] && GetPlayerVirtualWorld(playerid) == EntranceData[i][entranceWorld])
	        return i;
	}
	return -1;
}

Entrance_GetLink(playerid)
{
	if (GetPlayerVirtualWorld(playerid) > 0)
	{
	    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && EntranceData[i][entranceID] == GetPlayerVirtualWorld(playerid) - 7000)
			return EntranceData[i][entranceID];
	}
	return -1;
}

Entrance_Nearest(playerid)
{
    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && IsPlayerInRangeOfPoint(playerid, 2.5, EntranceData[i][entrancePos][0], EntranceData[i][entrancePos][1], EntranceData[i][entrancePos][2]))
	{
		if (GetPlayerInterior(playerid) == EntranceData[i][entranceExterior] && GetPlayerVirtualWorld(playerid) == EntranceData[i][entranceExteriorVW])
			return i;
	}
	return -1;
}

Entrance_Refresh(entranceid)
{
	if (entranceid != -1 && EntranceData[entranceid][entranceExists])
	{
		if (IsValidDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]))
		    DestroyDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]);

		if (IsValidDynamicPickup(EntranceData[entranceid][entrancePickup]))
		    DestroyDynamicPickup(EntranceData[entranceid][entrancePickup]);

		if (IsValidDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]))
		    DestroyDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]);

		EntranceData[entranceid][entranceText3D] = CreateDynamic3DTextLabel(EntranceData[entranceid][entranceName], -1, EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);
        EntranceData[entranceid][entrancePickup] = CreateDynamicPickup(1239, 23, EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2], EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);

		if (EntranceData[entranceid][entranceIcon] != 0)
			EntranceData[entranceid][entranceMapIcon] = CreateDynamicMapIcon(EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2], EntranceData[entranceid][entranceIcon], 0, EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);
	}
	return 1;
}

Entrance_Create(playerid, name[])
{
	static
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;
    if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i != MAX_ENTRANCES; i ++) if (!EntranceData[i][entranceExists])
		{
			format(EntranceData[i][entranceName], 32, name);
    	    EntranceData[i][entranceExists] = true;
        	EntranceData[i][entranceIcon] = 0;
        	EntranceData[i][entranceType] = 0;
        	EntranceData[i][entranceCustom] = 0;
        	EntranceData[i][entranceLocked] = 0;

			//EntranceData[i][entranceName] = name;
			EntranceData[i][entrancePass][0] = 0;

    	    EntranceData[i][entrancePos][0] = x;
    	    EntranceData[i][entrancePos][1] = y;
    	    EntranceData[i][entrancePos][2] = z;
    	    EntranceData[i][entrancePos][3] = angle;

            EntranceData[i][entranceInt][0] = x;
            EntranceData[i][entranceInt][1] = y;
            EntranceData[i][entranceInt][2] = z + 10000;
            EntranceData[i][entranceInt][3] = 0.0000;

			EntranceData[i][entranceInterior] = 0;
			EntranceData[i][entranceExterior] = GetPlayerInterior(playerid);
			EntranceData[i][entranceExteriorVW] = GetPlayerVirtualWorld(playerid);

			Entrance_Refresh(i);
			mysql_format(DBConn, query, sizeof(query), "INSERT INTO `entrances` (`entranceName`)\
			VALUES ('%e')", name);
			mysql_tquery(DBConn, query, "OnEntranceCreated", "d", i);

			//mysql_tquery(DBConn, "INSERT INTO `entrances` (`entranceType`) VALUES(0)", "OnEntranceCreated", "d", i);
			return i;
		}
	}
	return -1;
}

stock GetEntranceByID(sqlid)
{
	for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && EntranceData[i][entranceID] == sqlid)
	    return i;

	return -1;
}

forward OnEntranceCreated(entranceid);
public OnEntranceCreated(entranceid)
{
	if (entranceid == -1 || !EntranceData[entranceid][entranceExists])
	    return 0;

	EntranceData[entranceid][entranceID] = cache_insert_id();
	EntranceData[entranceid][entranceWorld] = EntranceData[entranceid][entranceID] + 7000;

	mysql_format(DBConn, query, sizeof(query), "SELECT * FROM entrances WHERE entranceID='%i'", EntranceData[entranceid][entranceID]); // Seleciona todas as informações desse player AONDE o id dele é o id dele
	mysql_query(DBConn, query); 
	Entrance_Save(entranceid);

	return 1;
}

hook OnGameModeInit()
{
    mysql_tquery(DBConn, "SELECT * FROM `entrances`", "Entrance_Load", "");
    return 1;
}

Dialog:EntrancePass(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new id = (Entrance_Inside(playerid) == -1) ? (Entrance_Nearest(playerid)) : (Entrance_Inside(playerid));

		if (id == -1)
		    return SendErrorMessage(playerid, "Você não está perto de nenhuma entrada");

		if (strcmp(EntranceData[id][entrancePass], inputtext) != 0)
            return SendErrorMessage(playerid, "Senha inválida.");

	    if (!EntranceData[id][entranceLocked])
		{
			EntranceData[id][entranceLocked] = true;
			Entrance_Save(id);

            GameTextForPlayer(playerid,"Entrada ~r~trancada~w~ com sucesso!",3000,4);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		}
		else
		{
			EntranceData[id][entranceLocked] = false;
			Entrance_Save(id);
            GameTextForPlayer(playerid,"Entrada ~g~destrancada~w~ com sucesso!",3000,4);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

CMD:criarentrada(playerid, params[])
{
    if (uInfo[playerid][uPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(uInfo[playerid][uAdmin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (isnull(params) || strlen(params) > 32)
	    return SendUsageMessage(playerid, "/criarentrada [nome]");

	new id = Entrance_Create(playerid, params);

	if (id == -1)
	    return SendErrorMessage(playerid, "O servidor atingiu o limite de entradas.");

	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você criou com sucesso a entrada ID: %d.", id);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* criou a entrada ID: %d.", 
    ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
    discord(DC_AdminCMD, textdc);
    return 1;
}

CMD:editarentrada(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (uInfo[playerid][uPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(uInfo[playerid][uAdmin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendUsageMessage(playerid, "/editarentrada [id] [syntax]");
	    SendClientMessage(playerid, COLOR_YELLOW, "SYNTAXES:{FFFFFF} pos, interior, senha, nome, trancar, mapicon, tipo, personalizado, vw");
		return 1;
	}
	if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
	    return SendErrorMessage(playerid, "Você especificou o ID de uma entrada inválida.");

	if (!strcmp(type, "pos", true))
	{
	    GetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
		GetPlayerFacingAngle(playerid, EntranceData[id][entrancePos][3]);

		EntranceData[id][entranceExterior] = GetPlayerInterior(playerid);
		EntranceData[id][entranceExteriorVW] = GetPlayerVirtualWorld(playerid);

		Entrance_Refresh(id);
		Entrance_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "%s alterou a localização da entrada ID: %d.", pNome(playerid), id);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou o localizacao da entrada ID: %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
        discord(DC_AdminCMD, textdc);
    }
	else if (!strcmp(type, "interior", true))
	{
	    GetPlayerPos(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);
		GetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

		EntranceData[id][entranceInterior] = GetPlayerInterior(playerid);

		if (pInfo[playerid][pEntrance] == EntranceData[id][entranceID])
		{
			SetPlayerPos(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);
			SetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

			SetPlayerInterior(playerid, EntranceData[id][entranceInterior]);
			SetCameraBehindPlayer(playerid);
		}

		Entrance_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "%s alterou o interior da entrada ID: %d.", pNome(playerid), id);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou o interior da entrada ID: %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
        discord(DC_AdminCMD, textdc);
    }
	else if (!strcmp(type, "personalizado", true))
	{
	    new status;

	    if (sscanf(string, "d", status))
	        return SendUsageMessage(playerid, "/editarentrada [id] [personalizado] [0/1]");

		if (status < 0 || status > 1)
		    return SendErrorMessage(playerid, "Você deve escolher entre 0 ou 1.");

	    EntranceData[id][entranceCustom] = status;
	    Entrance_Save(id);

	    if (status) {
			SendAdminAlert(COLOR_LIGHTRED, "%s ativou o modo de interior personalizado para entrada ID: %d.", pNome(playerid), id);
		}
		else {
		    SendAdminAlert(COLOR_LIGHTRED, "%s desativou o modo de interior personalizado para entrada ID: %d.", pNome(playerid), id);
		}
	}
	else if (!strcmp(type, "vw", true))
	{
	    new worldid;

	    if (sscanf(string, "d", worldid))
	        return SendUsageMessage(playerid, "/editarentrada [id] [vw] [virtual world]");

	    EntranceData[id][entranceWorld] = worldid;

		foreach (new i : Player) if (Entrance_Inside(i) == id) {
			SetPlayerVirtualWorld(i, worldid);
		}
		Entrance_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "%s alterou o Virtual World da entrada ID: %d para %d.", pNome(playerid), id, worldid);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* editou o VW da entrada ID: %d para %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id, worldid);
        discord(DC_AdminCMD, textdc);
    }
	else if (!strcmp(type, "mapicon", true))
	{
	    new icon;

	    if (sscanf(string, "d", icon))
	        return SendUsageMessage(playerid, "/editarentrada [id] [mapicon] [map icon]");

		if (icon < 0 || icon > 63)
		    return SendErrorMessage(playerid, "Map icon inválido! Map icons válidos em: \"wiki.sa-mp.com/wiki/MapIcons\".");

	    EntranceData[id][entranceIcon] = icon;

	    Entrance_Refresh(id);
	    Entrance_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "%s editou o mapicon da entrada ID: %d para %d.", pNome(playerid), id, icon);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* editou o mapicon da entrada ID: %d para %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id, icon);
        discord(DC_AdminCMD, textdc);
    }
	else if (!strcmp(type, "senha", true))
	{
	    new password[32];

	    if (sscanf(string, "s[32]", password))
	        return SendUsageMessage(playerid, "/editarentrada [id] [senha] [senha da entrada] (use 'nenhuma' para desabilitar)");

		if (!strcmp(password, "nenhuma", true)) {
			EntranceData[id][entrancePass][0] = 0;
		}
		else {
		    format(EntranceData[id][entrancePass], 32, password);
		}
	    Entrance_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "%s alterou a senha da entrada ID: %d para \"%s\".", pNome(playerid), id, password);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou a senha da entrada ID: %d para \"%s\".", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id, password);
        discord(DC_AdminCMD, textdc);
    }
	else if (!strcmp(type, "trancar", true))
	{
	    new locked;

	    if (sscanf(string, "d", locked))
	        return SendUsageMessage(playerid, "/editarentrada [id] [trancar] [trancar 0/1]");

		if (locked < 0 || locked > 1)
		    return SendErrorMessage(playerid, "Valor inválido. Use 0 para destrancada e 1 para trancada.");

	    EntranceData[id][entranceLocked] = locked;
	    Entrance_Save(id);

	    if (locked) {
			SendAdminAlert(COLOR_LIGHTRED, "%s trancou a entrada ID: %d.", pNome(playerid), id);
            format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* trancou a entrada ID: %d.", 
            ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
            discord(DC_AdminCMD, textdc);
		} else {
		    SendAdminAlert(COLOR_LIGHTRED, "%s destrancou a entrada ID: %d.", pNome(playerid), id);
            format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* destrancou a entrada ID: %d.", 
            ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
            discord(DC_AdminCMD, textdc);
		}
	}
	else if (!strcmp(type, "nome", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendUsageMessage(playerid, "/editarentrada [id] [nome] [novo nome]");

	    format(EntranceData[id][entranceName], 32, name);

	    Entrance_Refresh(id);
	    Entrance_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "%s alterou o nome da entrada ID: %d para \"%s\".", pNome(playerid), id, name);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou o nome da entrada ID: %d para \"%s\".", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id, name);
        discord(DC_AdminCMD, textdc);
    }
	else if (!strcmp(type, "tipo", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	    {
	        SendUsageMessage(playerid, "/editarentrada [id] [tipo] [syntax]");
			SendClientMessage(playerid, -1, "SYNTAXES: 0: Nenhum | 1: DMV | 2: Banco | 3: Warehouse | 4: City Hall | 5: Estande de tiro");
			return 1;
		}
		if (typeint < 0 || typeint > 5)
			return SendErrorMessage(playerid, "O valor específicado deve estar entra 0 e 5.");

		/*if (EntranceData[id][entranceType] == 3 && typeint != 3) {
		    DestroyForklifts(id);
		}
		else if (EntranceData[id][entranceType] != 3 && typeint == 3) {
		    CreateForklifts(id);
		}*/
        EntranceData[id][entranceType] = typeint;

        switch (typeint) {
            case 1: {
            	EntranceData[id][entranceInt][0] = -2029.5531;
           		EntranceData[id][entranceInt][1] = -118.8003;
            	EntranceData[id][entranceInt][2] = 1035.1719;
            	EntranceData[id][entranceInt][3] = 0.0000;
				EntranceData[id][entranceInterior] = 3;
            }
			case 2: {
            	EntranceData[id][entranceInt][0] = 1456.1918;
           		EntranceData[id][entranceInt][1] = -987.9417;
            	EntranceData[id][entranceInt][2] = 996.1050;
            	EntranceData[id][entranceInt][3] = 90.0000;
				EntranceData[id][entranceInterior] = 6;
            }
            case 3: {
                EntranceData[id][entranceInt][0] = 1291.8246;
           		EntranceData[id][entranceInt][1] = 5.8714;
            	EntranceData[id][entranceInt][2] = 1001.0078;
            	EntranceData[id][entranceInt][3] = 180.0000;
				EntranceData[id][entranceInterior] = 18;
			}
			case 4: {
			    EntranceData[id][entranceInt][0] = 390.1687;
           		EntranceData[id][entranceInt][1] = 173.8072;
            	EntranceData[id][entranceInt][2] = 1008.3828;
            	EntranceData[id][entranceInt][3] = 90.0000;
				EntranceData[id][entranceInterior] = 3;
			}
			case 5: {
			    EntranceData[id][entranceInt][0] = 304.0165;
           		EntranceData[id][entranceInt][1] = -141.9894;
            	EntranceData[id][entranceInt][2] = 1004.0625;
            	EntranceData[id][entranceInt][3] = 90.0000;
				EntranceData[id][entranceInterior] = 7;
			}
		}

		if (pInfo[playerid][pEntrance] == EntranceData[id][entranceID])
		{
			SetPlayerPos(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);
			SetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

			SetPlayerInterior(playerid, EntranceData[id][entranceInterior]);
			SetCameraBehindPlayer(playerid);
		}

	    Entrance_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "%s alterou o tipo de entrada ID: %d para %d.", pNome(playerid), id, typeint);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou o tipo de entrada ID: %d para %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id, typeint);
        discord(DC_AdminCMD, textdc);
    
    }
	return 1;
}

CMD:destruirentrada(playerid, params[])
{
	static
	    id = 0;

    if (uInfo[playerid][uPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(uInfo[playerid][uAdmin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	

	if (sscanf(params, "d", id))
	    return SendUsageMessage(playerid, "/destruirentrada [ID]");

	if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
	    return SendErrorMessage(playerid, "Você específicou o ID de uma entrada inválida.");

	Entrance_Delete(id);
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você destruiu com sucesso a entrada ID: %d.", id);
	return 1;
}

CMD:entrar(playerid, params[])
{
    static
		id = -1;

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Você não pode utilizar esse comando agora!");

	if ((id = House_Nearest(playerid)) != -1)
	{
		if(InHouse[playerid] == INVALID_HOUSE_ID)
		{
			switch(HouseData[id][LockMode])
			{
				case LOCK_MODE_NOLOCK: SendToHouse(playerid, id);
				case LOCK_MODE_PASSWORD: ShowPlayerDialog(playerid, DIALOG_HOUSE_PASSWORD, DIALOG_STYLE_INPUT, "Senha da Casa", "Essa casa é protegida por senha.\n\nDigite a senha da casa:", "Ok", "Fechar");
				case LOCK_MODE_KEYS:
				{
					new gotkeys = Iter_Contains(HouseKeys[playerid], id);
					if(!gotkeys) if(!strcmp(HouseData[id][Owner], Player_GetName(playerid))) gotkeys = 1;

					if(gotkeys) {
						SendToHouse(playerid, id);
					}else{
						SendErrorMessage(playerid, "Você não possui as chaves dessa casa, então não pode entrar.");
					}
				}

				case LOCK_MODE_OWNER:
				{
					if(!strcmp(HouseData[id][Owner], Player_GetName(playerid))) {
						//SetPVarInt(playerid, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
						SendToHouse(playerid, id);
					}else{
						SendErrorMessage(playerid, "Apenas o dono da residência pode entrar.");
					}
				}
			}
		}
		return 1;
	}

    if ((id = Entrance_Nearest(playerid)) != -1)
	{
	    if (EntranceData[id][entranceLocked])
	        return SendErrorMessage(playerid, "Essa entrada está trancada no momento.");

		if (EntranceData[id][entranceCustom])
			SetPlayerPosEx(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);

	    else
		SetPlayerPos(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);

		SetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

		SetPlayerInterior(playerid, EntranceData[id][entranceInterior]);
		SetPlayerVirtualWorld(playerid, EntranceData[id][entranceWorld]);

		SetCameraBehindPlayer(playerid);
		pInfo[playerid][pEntrance] = EntranceData[id][entranceID];
		return 1;
	}
    return 1;
}

CMD:sair(playerid, params[])
{
	static
		id = -1;

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Você não pode utilizar esse comando agora!");

	if ((id = House_NearestInt(playerid)) != -1)
	{
		// SetPVarInt(playerid, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, HouseData[ InHouse[playerid] ][houseX], HouseData[ InHouse[playerid] ][houseY], HouseData[ InHouse[playerid] ][houseZ]);
		InHouse[playerid] = INVALID_HOUSE_ID;
		return 1;
	}

	if ((id = Entrance_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]))
	{
	    if (EntranceData[id][entranceCustom])
			SetPlayerPosEx(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);

		else
        SetPlayerPosEx(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);

        SetPlayerFacingAngle(playerid, EntranceData[id][entrancePos][3] - 180.0);

        SetPlayerInterior(playerid, EntranceData[id][entranceExterior]);
        SetPlayerVirtualWorld(playerid, EntranceData[id][entranceExteriorVW]);

        SetCameraBehindPlayer(playerid);
        pInfo[playerid][pEntrance] = Entrance_GetLink(playerid);
		return 1;
	}
	return 1;
}
