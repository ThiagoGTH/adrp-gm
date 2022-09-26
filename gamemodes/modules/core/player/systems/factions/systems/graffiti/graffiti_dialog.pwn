Dialog:GraffitiChooseColor(playerid, response, listitem, inputtext[]) {
    if (!response) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        return SendErrorMessage(playerid, "Você cancelou a criação do grafite.");
    }

    SetPVarInt(playerid, "Graffiti:Color", listitem);
    SendServerMessage(playerid, "Você definiu a cor do grafite como %s.", GraffitiColors[listitem]);
    return _Graffiti_Size(playerid);
}

Dialog:GraffitiChooseSize(playerid, response, listitem, inputtext[]) {
    if (!response) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        return SendErrorMessage(playerid, "Você cancelou a criação do grafite.");
    }

    if (strlen(inputtext) == 0) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        SendErrorMessage(playerid, "Você não especificou o tamanho da fonte (de 5 a 50).");
        return _Graffiti_Size(playerid);
    }

    new size = strval(inputtext);

    if (size != size || size < 5 || size > 50) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        SendErrorMessage(playerid, "Você especificou um tamanho de fonte inválido (de 5 a 50).");
        return _Graffiti_Size(playerid);
    }

    SendServerMessage(playerid, "Você definiu a fonte do grafite em %d.", size);
    SetPVarInt(playerid, "Graffiti:Size", size);
    return _Graffiti_Bold(playerid);
}

Dialog:GraffitiChooseBold(playerid, response, listitem, inputtext[]) {
    if (response) {
        SendServerMessage(playerid, "Você definiu a fonte como negrito.");
        SetPVarInt(playerid, "Graffiti:Bold", 1);
    } else {
        SendServerMessage(playerid, "Você definiu a fonte como regular.");
        SetPVarInt(playerid, "Graffiti:Bold", 0);
    }

    return _Graffiti_Font(playerid);
}

Dialog:GraffitiChooseFont(playerid, response, listitem, inputtext[]) {
    if (!response) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        return SendErrorMessage(playerid, "Você cancelou a criação do grafite.");
    }

    if(listitem == 0){
        SendServerMessage(playerid, "Você definiu a fonte como Arial.");
        SetPVarString(playerid, "Graffiti:Font", "Arial");
    }
    else if(listitem == 1){
        SendServerMessage(playerid, "Você definiu a fonte como Comic Sans.");
        SetPVarString(playerid, "Graffiti:Font", "Comic Sans MS");
    }
	else if(listitem == 2){
        SendServerMessage(playerid, "Você definiu a fonte como Diploma.");
        SetPVarString(playerid, "Graffiti:Font", "Diploma");
    }
	else if(listitem == 3){
        SendServerMessage(playerid, "Você definiu a fonte como Dripping.");
        SetPVarString(playerid, "Graffiti:Font", "a dripping marker");
    }
	else if(listitem == 4){
        SendServerMessage(playerid, "Você definiu a fonte como Levi Brush.");
        SetPVarString(playerid, "Graffiti:Font", "LeviBrush");
    }
	else if(listitem == 5){
        SendServerMessage(playerid, "Você definiu a fonte como Gang Bang Crime.");
        SetPVarString(playerid, "Graffiti:Font", "Gang Bang Crime");
    }

    return _Graffiti_Text(playerid);
}

Dialog:GraffitiChooseText(playerid, response, listitem, inputtext[]) {
    if (!response) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        return SendErrorMessage(playerid, "Você cancelou a criação do grafite.");
    }

    if (strlen(inputtext) < 3 || strlen(inputtext) > 30) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        SendErrorMessage(playerid, "O texto deve conter não menos que três caracteres e não mais que trinta.");
        return _Graffiti_Text(playerid);
    }

    new string[128];
    format(string, sizeof(string), "{%06x}%s", GraffitiColorARGB[GetPVarInt(playerid, "Graffiti:Color")] & 0xFFFFFF, inputtext);

    SetPVarString(playerid, "Graffiti:Text", string);

    new body[512], string2[32];
    GetPVarString(playerid, "Graffiti:Font", string2, 32);
    format(body, sizeof(body), "{FFFFFF}Antes de finalizar o grafite, verifique\nse as informações estão corretas:\n\n\
    {A7A7A7}Cor:{FFFFFF} %s\n\
    {A7A7A7}Tamanho:{FFFFFF} %d\n\
    {A7A7A7}Fonte:{FFFFFF} %s\n\
    {A7A7A7}Texto:{FFFFFF} %s", 
        GraffitiColors[GetPVarInt(playerid, "Graffiti:Color")],
        GetPVarInt(playerid, "Graffiti:Size"),
        string2,
        inputtext
    );

    return Dialog_Show(playerid, GraffitiConfirm, DIALOG_STYLE_MSGBOX, "Informações do Grafite", body, "Confirmar", "Cancelar");
}

Dialog:GraffitiConfirm(playerid, response, listitem, inputtext[]) {
    if (!response) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        return SendErrorMessage(playerid, "Você cancelou a criação do grafite.");
    }

    new id = -1;

    for (new i = 0; i < MAX_GRAFFITI; i++) {
        if (!Graffiti[i][gExists]) {
        id = i;
        break;
        }
    }

    if (id == -1) {
        SetPVarInt(playerid, "Graffiti:Creating", 0);
        return SendErrorMessage(playerid, "Não foi possível criar o grafite, limite do servidor atingido.");
    }

    SetPVarInt(playerid, "Graffiti:Id", id);

    new Float: x, Float: y, Float: z, Float: ang;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, ang);

    GetPVarString(playerid, "Graffiti:Font", Graffiti[id][gFont], 128);
    GetPVarString(playerid, "Graffiti:Text", Graffiti[id][gText], 128);

    Graffiti[id][gExists] = true;
    Graffiti[id][gID] = 100000 + random(899999);
    Graffiti[id][gObject] = CreateDynamicObject(19477, x, y , z, 0.0, 0.0, 270.0 + ang);
    Graffiti[id][gColor] = GraffitiColorARGB[GetPVarInt(playerid, "Graffiti:Color")];
    Graffiti[id][gSize] = GetPVarInt(playerid, "Graffiti:Size");
    Graffiti[id][gBold] = GetPVarInt(playerid, "Graffiti:Bold");
    Graffiti[id][gAuthor] = pInfo[playerid][pID];

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
        2 // center
    );

    EditDynamicObject(playerid, Graffiti[id][gObject]);

    SendServerMessage(playerid, "Defina a posição do grafite.");
    SetPVarInt(playerid, "Graffiti:Creating", 2);
    return true;
}

_Graffiti_Size(playerid) {
    return Dialog_Show(playerid, GraffitiChooseSize, DIALOG_STYLE_INPUT, "Grafite — Fonte",
        "{FFFFFF}Especifique o tamanho da fonte:\n\n{A7A7A7}De 5 a 50.\n",
        ">>>", "Cancelar");
}

_Graffiti_Bold(playerid) {
    return Dialog_Show(playerid, GraffitiChooseBold, DIALOG_STYLE_MSGBOX, "Grafite — Negrito",
        "{FFFFFF}Você deseja deixar a fonte do grafite em negrito?",
        "Sim", "Não");
}

_Graffiti_Font(playerid) {
    return Dialog_Show(playerid, GraffitiChooseFont, DIALOG_STYLE_LIST, "Grafite — Fonte",
        "Arial\nComic Sans\nDiploma\nDripping\nLevi Brush\nGang Bang Crime",
    ">>>", "Cancelar");
}

_Graffiti_Text(playerid) {
    return Dialog_Show(playerid, GraffitiChooseText, DIALOG_STYLE_INPUT, "Grafite — Texto",
        "{FFFFFF}Digite o texto para grafitar:\n\n{A7A7A7}O texto deve estar entre 3 e 30 caracteres.\n",
        ">>>", "Cancelar");
}
