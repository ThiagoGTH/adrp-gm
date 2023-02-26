#include <YSI_Coding\y_hooks>
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

CMD:editarempresa(playerid, params[]) {
    new 
        businessID,
        option[64],
        value[64]; 

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "ds[64]S()[64]", businessID, option, value)) {
        SendSyntaxMessage(playerid, "/editarempresa [id] [opção]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: nome, entrada, interior, preço, tipo");
    }
    
    if(!IsValidBusiness(businessID))
        return SendErrorMessage(playerid, "Esse ID de empresa não existe.");
    
    // Editar o nome da empresa
    if(!strcmp(option, "nome", true) || !strcmp(option, "nome", true)) {
        new newName = strval(value);
        
        if(!newName)
            return SendErrorMessage(playerid, "Você precisa especificar um nome. (/editarempresa [id] [opção] [novo nome])");

        //Função para editar o nome da empresa.
        EditNameBusiness(businessID, newName);

        SendServerMessage(playerid, "Você editou o nome da empresa de ID %d para $%s.", businessID, newName);
        format(logString, sizeof(logString), "%s (%s) editou o nome da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newName);
	    logCreate(playerid, logString, 13);
        return 1;
    }      

    //Edita a entrada da empresa
    if(!strcmp(option, "entrada", true) || !strcmp(option, "entrada", true)) {
        //Função para editar o nome da empresa.
        EditEntryBusiness(playerid, businessID);

        SendServerMessage(playerid, "Você editou a entrada da empresa de ID %d.", businessID);
        format(logString, sizeof(logString), "%s (%s) editou a entrada da empresa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), businessID);
	    logCreate(playerid, logString, 13);
        return 1;
    }   
    //Edita a entrada da empresa
    if(!strcmp(option, "interior", true) || !strcmp(option, "interior", true)) {
        //Função para editar o nome da empresa.
        EditExitBusiness(playerid, businessID);

        SendServerMessage(playerid, "Você editou o interior da empresa de ID %d.", businessID);
        format(logString, sizeof(logString), "%s (%s) editou o interior da empresa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), businessID);
	    logCreate(playerid, logString, 13);
        return 1;
    }   
     // Editar o preço da empresa
    if(!strcmp(option, "preço", true) || !strcmp(option, "preço", true)) {
        new newPrice = strval(value);

        if(newPrice < 1000)
            return SendErrorMessage(playerid, "O preço da empresa deve ser maior do que $1000.");
        //Função para editar o preço da empresa.
        EditPriceBusiness(businessID, newPrice);

        SendServerMessage(playerid, "Você editou o preço da empresa de ID %d para $%s.", businessID, newPrice);
        format(logString, sizeof(logString), "%s (%s) editou o preço da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newPrice);
	    logCreate(playerid, logString, 13);
        return 1;
    }  

     // Editar o tipo da empresa
    if(!strcmp(option, "tipo", true) || !strcmp(option, "tipo", true)) {
        new newType = strval(value);

        if (newType < 1 || newType > 7) {
            SendErrorMessage(playerid, "Tipo inválido. Tipos de 1 á 7. (/editarempresa [id] [opção] [tipo]).");
            SendErrorMessage(playerid, "[TIPOS] 1: 24/7 | 2: Ammunation | 3: Loja de roupas | 4: Fast Food | 5: Concessionária | 6: Posto de gasolina | 7: Firma");
            return 1;
        }
        //Função para editar o tipo da empresa.
        EditTypeBusiness(businessID, newType);

        SendServerMessage(playerid, "Você editou o tipo da empresa de ID %d para $%s.", businessID, newType);
        format(logString, sizeof(logString), "%s (%s) editou o tipo da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newType);
	    logCreate(playerid, logString, 13);
        return 1;
    }
    return 1;
}
// ============================================================================================================================================

CMD:empresa(playerid, params[]) {
    if(!ManagerBusiness(playerid))
        return SendErrorMessage(playerid, "Você não está dentro de uma empresa.");

    return 1;
}

CMD:irempresa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2)
        return SendPermissionMessage(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/irempresa [id]");

    TeleportBusiness(playerid, id);

    return 1;
}

CMD:mundo(playerid, params[]) {
    new worldID = GetPlayerVirtualWorld(playerid);
    SendClientMessage(playerid, COLOR_RED, "Mundo atual %d.", worldID);
}
// ============================================================================================================================================