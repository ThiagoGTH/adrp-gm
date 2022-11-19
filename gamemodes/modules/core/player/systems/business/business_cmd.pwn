#include <YSI_Coding\y_hooks>

// ============================================================================================================================================

//Comando para criar empresa.
CMD:criarempresa(playerid, params[]) {
    new 
        type,
        price,
        address[256];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "dds[256]", type, price, address))
    {
        SendSyntaxMessage(playerid, "/criarempresa [tipo] [preço] [endereço único]");
        SendSyntaxMessage(playerid, "[TIPOS] 1: 24/7 | 2: Ammunation | 3: Loja de roupas | 4: Fast Food | 5: Concessionária | 6: Posto de gasolina | 7: Firma");
        return 1;
    }
    
    if (type < 1 || type > 7)
        return SendErrorMessage(playerid, "Tipo inválido. Tipos de 1 á 7.");

    if(price < 1000)
        return SendErrorMessage(playerid, "O preço da empresa deve ser maior do que $1000.");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `address` = '%e';", address);
    mysql_query(DBConn, query);

    if(cache_num_rows())
        return SendErrorMessage(playerid, "Este endereço já está registrado em outra empresa!");

    if(!CreateBusiness(playerid, type, price, address))
    {
        SendErrorMessage(playerid, "Bx001 - Encaminhe este código para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao criar a empresa (cod: Bx001)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }

    return 1;
}

//Comanda para deletar empresa.
CMD:deletarempresa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarempreasa [id]");

    if(!IsValidBusiness(id))
        return SendErrorMessage(playerid, "Esse ID de empresa não existe.");

    if(!DeleteBusiness(playerid, id))
    {
        SendErrorMessage(playerid, "Bx010 - Encaminhe este código para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao excluir a empresa (cod: Bx010)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }
    return 1;
} 

// ============================================================================================================================================

//Para entrar na empresa (comando temporário)
CMD:entrarempresa(playerid) {
    EntryBusiness(playerid);
    return 1;
}

//Para sair da empresa (comando temporário)
CMD:sairempresa(playerid) {
    ExitBusiness(playerid);
    return 1;
}

//Comanda para comprar empresa
CMD:comprarempresa(playerid) {
    new businessID = GetNearestBusinessEntry(playerid);

    if(!businessID)
        return SendErrorMessage(playerid, "Você não está próximo à nenhuma empresa.");

    if(BusinessHasOwner(businessID))
        return SendErrorMessage(playerid, "Esta empresa já possui um dono.");

    if(GetMoney(playerid) < bInfo[businessID][bPrice])
        return SendErrorMessage(playerid, "Você não possui fundos o suficiente para comprar esta casa.");

    GiveMoney(playerid, -bInfo[businessID][bPrice]);
    va_SendClientMessage(playerid, COLOR_YELLOW, "Você comprou a empresa no endereço %s.", GetBusinessAddress(businessID));
    
    if(!BuyBusiness(businessID, playerid))
    {
        SendErrorMessage(playerid, "Bx020 - Encaminhe este código para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao excluir a empresa (cod: Bx020)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }
    return 1;
}

//Comando de trancar/destrancar empresa (temporário)
CMD:trancarempresa(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    LockedBusiness(playerid);
    return 1;
}