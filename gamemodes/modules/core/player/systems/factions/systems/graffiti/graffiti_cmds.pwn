CMD:grafitar(playerid, params[]) {
    if (GetFactionType(playerid) != FACTION_CRIMINAL) return SendPermissionMessage(playerid);

    if (GetPVarInt(playerid, "Graffiti:Creating") > 0)
        return SendErrorMessage(playerid, "Você já está criando um grafite.");
    if (GetPlayerWeapon(playerid) != WEAPON_SPRAYCAN)
        return SendErrorMessage(playerid, "Você não está com um spray can em mãos.");
    if (GetPlayerInterior(playerid) != 0)
        return SendErrorMessage(playerid, "Você não pode criar um grafite em um interior.");
    if (GetPlayerVirtualWorld(playerid) != 0)
        return SendErrorMessage(playerid, "Você não pode criar um grafite em um interior.");
    if (IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "Você não pode criar um grafite de dentro de um veículo.");

    format(graffiti_text, sizeof(graffiti_text),  
    "{FFFFCC}FFFFCC\n{FFFF99}FFFF99\n{FFFF66}FFFF66\n{FFFF33}FFFF33\n{FFFF00}FFFF00\n{CCCC00}CCCC00\n\
    {FF9900}FF9900\n{FF9933}FF9933\n{CC9966}CC9966\n{CC6600}CC6600\n{996633}996633\n{663300}663300\n\
    {FF6633}FF6633\n{CC3300}CC3300\n{FF3300}FF3300\n{FF0000}FF0000\n{CC0000}CC0000\n{990000}990000\n\
    {FFCCCC}FFCCCC\n{FF9999}FF9999\n{FF6666}FF6666\n{FF3333}FF3333\n{FF0033}FF0033\n{CC0033}CC0033\n\
    {FF6699}FF6699\n{FF3366}FF3366\n{FF0066}FF0066\n{CC3366}CC3366\n{996666}996666\n{663333}663333\n\
    {FF99CC}FF99CC\n{FF3399}FF3399\n{FF0099}FF0099\n{CC0066}CC0066\n{993366}993366\n{660033}660033\n\
    {CC99FF}CC99FF\n{9933CC}9933CC\n{9933FF}9933FF\n{9900FF}9900FF\n{660099}660099\n{663366}663366\n\
    {9966CC}9966CC\n{9966FF}9966FF\n{6600CC}6600CC\n{6633CC}6633CC\n{663399}663399\n{330033}330033\n\
    {CCCCFF}CCCCFF\n{9999FF}9999FF\n{6633FF}6633FF\n{6600FF}6600FF\n{330099}330099\n{330066}330066\n\
    {6699FF}6699FF\n{3366FF}3366FF\n{0000FF}0000FF\n{0000CC}0000CC\n{0033CC}0033CC\n{000033}000033\n\
    {0066FF}0066FF\n{0066CC}0066CC\n{3366CC}3366CC\n{0033FF}0033FF\n{003399}003399\n{003366}003366\n\
    {99CCFF}99CCFF\n{3399FF}3399FF\n{0099FF}0099FF\n{6699CC}6699CC\n{336699}336699\n{006699}006699\n\
    {99CCCC}99CCCC\n{66CCCC}66CCCC\n{339999}339999\n{669999}669999\n{006666}006666\n{336666}336666\n\
    {99FFCC}99FFCC\n{66FFCC}66FFCC\n{33FFCC}33FFCC\n{00FFCC}00FFCC\n{33CCCC}33CCCC\n{009999}009999\n\
    {CCFFCC}CCFFCC\n{99CC99}99CC99\n{66CC66}66CC66\n{669966}669966\n{336633}336633\n{003300}003300\n\
    {33FF33}33FF33\n{00FF33}00FF33\n{00FF00}00FF00\n{00CC00}00CC00\n{33CC33}33CC33\n{00CC33}00CC33\n\
    {66FF00}66FF00\n{66FF33}66FF33\n{33FF00}33FF00\n{33CC00}33CC00\n{339900}339900\n{009900}009900\n\
    {CCFF99}CCFF99\n{99FF66}99FF66\n{66CC00}66CC00\n{66CC33}66CC33\n{669933}669933\n{336600}336600\n\
    {99FF00}99FF00\n{99FF33}99FF33\n{99CC66}99CC66\n{99CC00}99CC00\n{99CC33}99CC33\n{669900}669900\n\
    {FFFFFF}FFFFFF\n{CCCCCC}CCCCCC\n{999999}999999\n{666666}666666\n{333333}333333\n{000000}000000");

    Dialog_Show(playerid, GraffitiChooseColor, DIALOG_STYLE_LIST,
        "Grafite — Cor", graffiti_text, ">>>", "Cancelar");
    SetPVarInt(playerid, "Graffiti:Creating", 1);
    return true;
}

CMD:deletargrafite(playerid, params[]) {
    static id;
    if (sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/deletargrafite [id]");
    for (new i = 0; i < sizeof(Graffiti); i++) {
        if (Graffiti[i][gID] == id) {
            if (Graffiti[i][gAuthor] != pInfo[playerid][pID]) {
                if (!GetUserTeam(playerid, 1)) {
                    return SendErrorMessage(playerid, "Esse grafite não foi criado por você!");
                }
            }

            Graffiti[i][gExists] = false;
            DestroyDynamicObject(Graffiti[i][gObject]);

            mysql_format(DBConn, query, sizeof(query), "DELETE FROM `graffiti` WHERE `gID` = '%d'", id);
            return mysql_tquery(DBConn, query, "OnGraffitiDelete", "id", playerid, id);
        }
    }

    SendErrorMessage(playerid, "Você especificou um grafite inexistente.");
    return true;
}