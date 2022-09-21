CMD:grafitar(playerid, params[]) {
    if (GetPVarInt(playerid, "Graffiti:Creating") > 0) 
        return SendErrorMessage(playerid, "Voc� j� est� criando um grafite.");
    if (GetPlayerInterior(playerid) != 0) 
        return SendErrorMessage(playerid, "Voc� n�o pode criar um grafite em um interior.");
    if (GetPlayerVirtualWorld(playerid) != 0) 
        return SendErrorMessage(playerid, "Voc� n�o pode criar um grafite em um interior.");
    
    SetPVarString(playerid, "Graffiti:Font", "Arial");
    SetPVarInt(playerid, "Graffiti:Creating", 1);
    Dialog_Show(playerid, "GraffitiChooseColor", DIALOG_STYLE_LIST,
        "Grafite � Cor", graffiti_text, ">>>", "Cancelar");
    return true;
}

CMD:deletargrafite(playerid, params[]) {
    static id;
    if (sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/deletargrafite [id]");
    for (new i = 0; i < sizeof(Graffiti); i++) {
        if (Graffiti[i][gID] == id) {
            if (Graffiti[i][gAuthor] != pInfo[playerid][pID]) {
                if (!GetUserTeam(playerid, 1)) {
                    return SendErrorMessage(playerid, "Esse grafite n�o foi criado por voc�!");
                }
            }

            Graffiti[i][gExists] = false;

            DestroyDynamicObject(Graffiti[i][gObject]);
            DestroyDynamic3DTextLabel(Graffiti[i][gText3D]);

            mysql_format(DBConn, query, sizeof(query), "DELETE FROM `graffiti` WHERE `gID` = '%d'", id);
            return mysql_tquery(DBConn, query, "OnGraffitiDelete", "id", playerid, id);
        }
    }

    SendErrorMessage(playerid, "Voc� especificou um grafite inexistente.");
    return true;
}