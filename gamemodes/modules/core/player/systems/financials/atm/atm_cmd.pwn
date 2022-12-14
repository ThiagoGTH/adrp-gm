//Cria a ATM
CMD:criaratm(playerid, params[]) {  
    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if(!CreateATM(playerid))
    {
        SendErrorMessage(playerid, "Ox010 - Encaminhe este c�digo para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao criar a ATM (cod: Ox010)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }
    return 1;
}

//Excluir ATM
CMD:deletaratm(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    new id;

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletaratm [id]");

    if(!IsValidAtm(id))
        return SendErrorMessage(playerid, "Esse ID de ATM n�o existe.");

    if(!DeleteAtm(playerid, id))
    {
        SendErrorMessage(playerid, "Ox011 - Encaminhe este c�digo para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao excluir a ATM (cod: Ox011)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }
    return 1;
}

//Editar ATM
CMD:editaratm(playerid, params[]) {
    new id, option[64];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "ds[64]", id, option)) {
        SendSyntaxMessage(playerid, "/editaratm [id] [op��o]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: posicao, status.");
    }

    if(!IsValidAtm(id))
        return SendErrorMessage(playerid, "Esse ID de ATM n�o existe.");

    // Editar o pre�o
    if(!strcmp(option, "posicao", true) || !strcmp(option, "posicao", true)) {
        EditDynamicObject(playerid, atmInfo[id][atmVariable]);
        return 1;
    }

    //Editar o Status (ativo/desativada)
    if(!strcmp(option, "status", true) || !strcmp(option, "status", true)) {
        SendErrorMessage(playerid, "Fun��o desativada no momento.");
        return 1;
    }

    SendSyntaxMessage(playerid, "/editaratm [id] [op��o]");
    return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: posicao, status.");
}

// ============================================================================================================================================
//Comando para abrir �s fun��es da ATM
CMD:atm(playerid, params[]) {
    new 
        id = GetNearestAtm(playerid);

    if(!GetNearestAtm(playerid))
        return SendErrorMessage(playerid, "N�o est� perto de uma ATM.");

    if(atmInfo[id][atmStatus]) 
        return SendErrorMessage(playerid, "Est� desativada ou em manuten��o est� ATM.");

    ShowDialogATM(playerid);
    return 1;
}