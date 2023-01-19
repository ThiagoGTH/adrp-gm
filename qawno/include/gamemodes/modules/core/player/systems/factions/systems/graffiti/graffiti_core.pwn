#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    mysql_tquery(DBConn, "SELECT * FROM `graffiti` WHERE (`gID` != '0')", "OnGraffitiLoad");
    return true;
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
    graffitiEdit(playerid, objectid, response, x, y, z, rx, ry, rz);
    return true;
}

graffitiEdit(playerid, objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz) {
    if (GetPVarInt(playerid, "Graffiti:Creating") != 2) {
        return true;
    }

    new id = GetPVarInt(playerid, "Graffiti:Id");

    if (response == 0) {
        Graffiti[id][gExists] = false;
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        DestroyDynamicObject(objectid);
        return SendErrorMessage(playerid, "Você cancelou a criação do grafite.");
    }

    if (response == 2) {
        return true;
    }

    new Float: px, Float: py, Float: pz;
    GetPlayerPos(playerid, px, py, pz);

    new Float: dist = floatsqroot(
        floatpower(x - px, 2.0) +
        floatpower(y - py, 2.0) +
        floatpower(z - pz, 2.0)
    );

    if (dist > 30.0) {
        Graffiti[id][gExists] = false;
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        DestroyDynamicObject(objectid);
        return SendErrorMessage(playerid, "Você está muito longe do grafite.");
    }

    Graffiti[id][gX] = x;
    Graffiti[id][gY] = y;
    Graffiti[id][gZ] = z;
    Graffiti[id][gRX] = rx;
    Graffiti[id][gRY] = ry;
    Graffiti[id][gRZ] = rz;

    if (IsValidDynamicObject(Graffiti[id][gObject]))
        DestroyDynamicObject(Graffiti[id][gObject]);

    Graffiti[id][gObject] = CreateDynamicObject(
        19477,
        Graffiti[id][gX], Graffiti[id][gY], Graffiti[id][gZ],
        Graffiti[id][gRX], Graffiti[id][gRY], Graffiti[id][gRZ]
    );

    SetDynamicObjectMaterialText(
        Graffiti[id][gObject],
        0,
        Graffiti[id][gText],
        OBJECT_MATERIAL_SIZE_512x256,
        Graffiti[id][gFont],
        Graffiti[id][gSize] * 5,
        Graffiti[id][gBold], // bold
        Graffiti[id][gColor],
        0, // backcolor
        2  // center
    );

    new font[128], text[128];
    mysql_escape_string(Graffiti[id][gText], text);
    mysql_escape_string(Graffiti[id][gFont], font);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `graffiti` (`gX`, `gY`, `gZ`, `gRX`, `gRY`, `gRZ`,\
        `gText`, `gFont`, `gSize`, `gColor`, `gBold`, `gAuthor`) VALUES (\
        %d, %f, %f, %f, %f, %f, %f, '%s', '%s', %d, %d, %d, %d)",
        Graffiti[id][gX], Graffiti[id][gY], Graffiti[id][gZ],
        Graffiti[id][gRX], Graffiti[id][gRY], Graffiti[id][gRZ],
        text, font, Graffiti[id][gSize], Graffiti[id][gColor], Graffiti[id][gBold],
        Graffiti[id][gAuthor]
    );

    SetPVarInt(playerid, "Graffiti:Id", cache_insert_id());
    mysql_tquery(DBConn, query, "OnGraffitiCreated", "i", playerid);

    return SendServerMessage(playerid, "Grafitando...");
}


hook OnPlayerDisconnect(playerid, reason) {
    if (GetPVarInt(playerid, "Graffiti:Creating") == 1) {
        new id = GetPVarInt(playerid, "Graffiti:Id");
        Graffiti[id][gExists] = false;
        DestroyDynamicObject(Graffiti[id][gObject]);
    }
    return true;
}

forward OnGraffitiLoad();
public OnGraffitiLoad() {
    for (new i = 0; i < cache_num_rows(); i++) {
        Graffiti[i][gExists] = true;

        cache_get_value_int(i, "gID", Graffiti[i][gID]);
        cache_get_value_float(i, "gX", Graffiti[i][gX]);
        cache_get_value_float(i, "gY", Graffiti[i][gY]);
        cache_get_value_float(i, "gZ", Graffiti[i][gZ]);
        cache_get_value_float(i, "gRX", Graffiti[i][gRX]);
        cache_get_value_float(i, "gRY", Graffiti[i][gRY]);
        cache_get_value_float(i, "gRZ", Graffiti[i][gRZ]);
        cache_get_value(i, "gText", Graffiti[i][gText], 40);
        cache_get_value(i, "gFont", Graffiti[i][gFont], 32);
        cache_get_value_int(i, "gSize", Graffiti[i][gSize]);
        cache_get_value_int(i, "gColor", Graffiti[i][gColor]);
        cache_get_value_int(i, "gBold", Graffiti[i][gBold]);
        cache_get_value_int(i, "gAuthor", Graffiti[i][gAuthor]);

        Graffiti[i][gObject] = CreateDynamicObject(
            19477,
            Graffiti[i][gX], Graffiti[i][gY], Graffiti[i][gZ],
            Graffiti[i][gRX], Graffiti[i][gRY], Graffiti[i][gRZ]
        );

        SetDynamicObjectMaterialText(
            Graffiti[i][gObject],
            0,
            Graffiti[i][gText],
            OBJECT_MATERIAL_SIZE_512x256,
            Graffiti[i][gFont],
            Graffiti[i][gSize] * 5,
            Graffiti[i][gBold], // bold
            Graffiti[i][gColor],
            0, // backcolor
            2 // center
        );
    }
    printf("[GRAFITES] %d grafites carregados.", cache_num_rows());
    return true;
}

forward OnGraffitiCreated(playerid);
public OnGraffitiCreated(playerid) {
    SetPVarInt(playerid, "Graffiti:Creating", 0);

    //SendServerMessage(playerid, "Grafite criado com sucesso. %d", Graffiti[GetPVarInt(playerid, "Graffiti:Id")][gID]);
    new string[128];
    new factionid = pInfo[playerid][pFaction];
    GetPVarString(playerid, "Graffiti:Text", string, 128);

    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%d) criou o grafite %s [%d].", pNome(playerid), playerid, string, Graffiti[GetPVarInt(playerid, "Graffiti:Id")][gID]);

    SendFactionMessage(factionid, COLOR_FACTION, "[Facção]: %s %s criou um grafite em %s.", Faction_GetRank(playerid), 
    pNome(playerid), GetPlayerLocation(playerid));

	format(logString, sizeof(logString), "[%s] %s (%s) criou o grafite %d em %s, escrito: %s", FactionData[factionid][factionName], pNome(playerid), GetPlayerUserEx(playerid), Graffiti[GetPVarInt(playerid, "Graffiti:Id")][gID], GetPlayerLocation(playerid), string);
	logCreate(playerid, logString, 22);
    return true;
}

forward OnGraffitiDelete(playerid, id);
public OnGraffitiDelete(playerid, id) {
    for (new i = 0; i < MAX_GRAFFITI; i++)  if (id == Graffiti[id][gID]) {
    	if (IsValidDynamicObject(Graffiti[id][gObject]))
            DestroyDynamicObject(Graffiti[id][gObject]);
	}

    SendServerMessage(playerid, "Grafite removido com sucesso.");
    format(logString, sizeof(logString), "%s (%s) deletou o grafite %d", pNome(playerid), GetPlayerUserEx(playerid), id);
	logCreate(playerid, logString, 22);
    return true;
}

GetClosestGraffiti(playerid, &Float: dis = 5.00) {
	new graffiti = -1;
	for (new i = 0; i < MAX_GRAFFITI; i++) {
    	new
    		Float: dis2 = GetPlayerDistanceFromPoint(playerid, Graffiti[i][gX], Graffiti[i][gY], Graffiti[i][gZ]);

    	if (dis2 < dis && dis2 != -1.00) {
    	    dis = dis2;
    	    graffiti = i;
		}
	}
	return graffiti;
}