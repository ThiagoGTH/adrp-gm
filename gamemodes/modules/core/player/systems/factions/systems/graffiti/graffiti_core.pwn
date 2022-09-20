#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    mysql_tquery(DBConn, "SELECT * FROM `graffiti", "OnGraffitiLoad");
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
        return SendErrorMessage(playerid, "Voc� cancelou a cria��o do grafite.");
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
        return SendErrorMessage(playerid, "Voc� est� muito longe do grafite.");
    }

    Graffiti[id][gX] = x;
    Graffiti[id][gY] = y;
    Graffiti[id][gZ] = z;
    Graffiti[id][gRX] = rx;
    Graffiti[id][gRY] = ry;
    Graffiti[id][gRZ] = rz;

    new string[256];
    format(string, sizeof(string), "Grafite #%d", Graffiti[id][gID]);

    Graffiti[id][gText3D] = CreateDynamic3DTextLabel(
        string, 0xFFFFFF33,
        Graffiti[id][gX], Graffiti[id][gY], Graffiti[id][gZ], 2.0
    );

    new font[64], text[64];

    mysql_escape_string(Graffiti[id][gText], text);
    mysql_escape_string(Graffiti[id][gFont], font);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `graffiti` (`gID`, `gX`,    `gY`, `gZ`, `gRX`, `gRY`, `gRZ`,\
        `gText`, `gFont`, `gSize`, `gColor`, `gBold`, `gAuthor`) VALUES (\
        %d, %f, %f, %f, %f, %f, %f, '%s', '%s', %d, %d, %d, %d)", Graffiti[id][gID],
        Graffiti[id][gX], Graffiti[id][gY], Graffiti[id][gZ],
        Graffiti[id][gRX], Graffiti[id][gRY], Graffiti[id][gRZ],
        text, font, Graffiti[id][gSize], Graffiti[id][gColor], Graffiti[id][gBold],
        Graffiti[id][gAuthor]
    );
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
    new start = GetTickCount();
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

        new string[256];
        format(string, sizeof(string), "Grafite #%d", Graffiti[i][gID]);

        Graffiti[i][gText3D] = CreateDynamic3DTextLabel(
            string, 0xFFFFFF33,
            Graffiti[i][gX], Graffiti[i][gY], Graffiti[i][gZ], 2.0
        );
    }

    new end = GetTickCount();
    printf("[GRAFFITI SYSTEM] %d grafites carregados em %ds.", cache_num_rows(), end - start);
}

forward OnGraffitiCreated(playerid);
public OnGraffitiCreated(playerid) {
    SetPVarInt(playerid, "Graffiti:Creating", 0);

    SendServerMessage(playerid, "Grafite criado com sucesso. %d", Graffiti[GetPVarInt(playerid, "Graffiti:Id")][gID]);
    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%d) criou o grafite %d.", pNome(playerid), playerid, Graffiti[GetPVarInt(playerid, "Graffiti:Id")][gID]);
	format(logString, sizeof(logString), "%s (%s) criou o grafite %d", pNome(playerid), GetPlayerUserEx(playerid), Graffiti[GetPVarInt(playerid, "Graffiti:Id")][gID]);
	logCreate(playerid, logString, 22);
    return true;
}

forward OnGraffitiDelete(playerid, id);
public OnGraffitiDelete(playerid, id) {
    SendServerMessage(playerid, "Grafite removido com sucesso.");
    format(logString, sizeof(logString), "%s (%s) deletou o grafite %d", pNome(playerid), GetPlayerUserEx(playerid), id);
	logCreate(playerid, logString, 22);
    return true;
}