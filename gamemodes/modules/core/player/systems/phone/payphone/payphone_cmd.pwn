//Cria o telefone (pago/publico)
CMD:criartelefone(playerid, params[]) {  
    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if(!CreatePayPhone(playerid))
    {
        SendErrorMessage(playerid, "Px010 - Encaminhe este código para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao criar o telefone publico (cod: Px010)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }
    return 1;
}

//Excluir telefone (pago/publico)
CMD:deletartelefone(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    new id;

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletartelefone [id]");

    if(!IsValidPhone(id))
        return SendErrorMessage(playerid, "Esse ID de telefone publico não existe.");

    if(!DeletePayPhone(playerid, id))
    {
        SendErrorMessage(playerid, "Px011 - Encaminhe este código para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao excluir um telefone publico (cod: Px011)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }
    return 1;
}

//Editar telefone (publico - pago)
CMD:editartelefone(playerid, params[]) {
    new id, option[64];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "ds[64]", id, option)) {
        SendSyntaxMessage(playerid, "/editartelefone [id] [opção]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: posicao, status.");
    }

    if(!IsValidPhone(id))
        return SendErrorMessage(playerid, "Esse ID de telefone (publico - pago) não existe.");

    // Editar o preço
    if(!strcmp(option, "posicao", true) || !strcmp(option, "posicao", true)) {
        EditDynamicObject(playerid, phoneInfo[id][phoneVariable]);
        return 1;
    }

    //Editar o Status (ativo/desativada)
    if(!strcmp(option, "status", true) || !strcmp(option, "status", true)) {
        SendErrorMessage(playerid, "Função desativada no momento.");
        return 1;
    }

    SendSyntaxMessage(playerid, "/editartelefone [id] [opção]");
    return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: posicao, status.");
}

// ============================================================================================================================================
//Comando para abrir ás funções do telefone (publico - pago)
CMD:telefonepago(playerid, params[]) {
    new 
        id = GetNearestPhone(playerid);

    if(!GetNearestPhone(playerid))
        return SendErrorMessage(playerid, "Não está perto de um telefone publico.");

    if(phoneInfo[id][phoneStatus]) 
        return SendErrorMessage(playerid, "Está desativado ou em manutenção este telefone publico.");

    ShowDialogPhone(playerid);
    return 1;
}