#include <YSI_Coding\y_hooks>

CMD:criarempresa(playerid, params[]) {
    new 
        type,
        price,
        name[256];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "dds[256]", type, price, name))
    {
        SendSyntaxMessage(playerid, "/criarempresa [tipo] [pre�o] [nome]");
        SendSyntaxMessage(playerid, "[TIPOS] 1: 24/7 | 2: Ammunation | 3: Loja de Roupas | 4: Restaurante | 5: Concession�ria | 6: Posto de Gasolina | 7: Bar");
        SendSyntaxMessage(playerid, "[TIPOS] 8: Boate | 9: Mec�nica | 10: Pawn Shop | 11: Escrit�rio | 12: Cassino");
        return 1;
    }
    
    if (type < 1 || type > 12)
        return SendErrorMessage(playerid, "Tipo inv�lido. Tipos de 1 � 12.");

    if(price < 1000)
        return SendErrorMessage(playerid, "O pre�o da empresa deve ser maior do que $1000.");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `name` = '%e';", name);
    mysql_query(DBConn, query);

    if(cache_num_rows())
        return SendErrorMessage(playerid, "Este nome j� est� registrado em outra empresa!");

    if(!CreateBusiness(playerid, type, price, name))
    {
        SendErrorMessage(playerid, "Bx001 - Encaminhe este c�digo para um desenvolvedor.");
        format(logString, sizeof(logString), "%s (%s) teve um erro no MySQL ao criar a empresa (cod: Bx001)", pNome(playerid), GetPlayerUserEx(playerid));
	    logCreate(playerid, logString, 13);
    }

    return 1;
}

CMD:deletarempresa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarempreasa [id]");

    if(!HasBusiness(id))
        return SendErrorMessage(playerid, "Voc� espec�ficou um ID de empresa inv�lido.");

    if(!DeleteBusiness(playerid, id))
    {
        SendErrorMessage(playerid, "Bx010 - Encaminhe este c�digo para um desenvolvedor.");
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
        SendSyntaxMessage(playerid, "/editarempresa [id] [op��o]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: nome, endere�o, entrada, saida, roubo, pre�o, tipo, alarme, seguran�a, produtos, taxa, blip");
    }
    
    if(!HasBusiness(businessID))
        return SendErrorMessage(playerid, "Esse ID de empresa n�o existe.");
    
    if(!strcmp(option, "nome", true)) {
        new newName = strval(value);
        
        if(!newName)
            return SendErrorMessage(playerid, "Voc� precisa especificar um nome. (/editarempresa [id] [nome] [novo nome])");

        UpdateBusinessName(businessID, newName);

        SendServerMessage(playerid, "Voc� editou o nome da empresa de ID %d para $%s.", businessID, newName);
        format(logString, sizeof(logString), "%s (%s) editou o nome da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newName);
	    logCreate(playerid, logString, 13);
        return 1;
    }      

    if(!strcmp(option, "entrada", true)) {
        UpdateBusinessEnter(playerid, businessID);

        SendServerMessage(playerid, "Voc� editou a entrada da empresa de ID %d.", businessID);
        format(logString, sizeof(logString), "%s (%s) editou a entrada da empresa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), businessID);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    if(!strcmp(option, "saida", true) || !strcmp(option, "sa�da", true)) {
        UpdateBusinessExit(playerid, businessID);

        SendServerMessage(playerid, "Voc� editou a sa�da da empresa de ID %d.", businessID);
        format(logString, sizeof(logString), "%s (%s) editou a sa�da da empresa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), businessID);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    if(!strcmp(option, "roubo", true) || !strcmp(option, "roubos", true)) {
        UpdateBusinessRobbery(playerid, businessID);

        SendServerMessage(playerid, "Voc� editou o ponto de roubo da empresa de ID %d.", businessID);
        format(logString, sizeof(logString), "%s (%s) editou o ponto de roubo da empresa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), businessID);
	    logCreate(playerid, logString, 13);
        return 1;
    } 

    if(!strcmp(option, "pre�o", true) || !strcmp(option, "preco", true)) {
        new newPrice = strval(value);

        if(newPrice < 1000)
            return SendErrorMessage(playerid, "O pre�o da empresa deve ser maior do que $1000.");

        UpdateBusinessPrice(businessID, newPrice);

        SendServerMessage(playerid, "Voc� editou o pre�o da empresa de ID %d para $%s.", businessID, newPrice);
        format(logString, sizeof(logString), "%s (%s) editou o pre�o da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newPrice);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    if(!strcmp(option, "tipo", true)) {
        new newType = strval(value);

        if (newType < 1 || newType > 12) {
            SendErrorMessage(playerid, "Voc� espec�ficiou um tipo inv�lido. (/editarempresa [id] [tipo] [id do tipo]).");
            SendSyntaxMessage(playerid, "[TIPOS] 1: 24/7 | 2: Ammunation | 3: Loja de Roupas | 4: Restaurante | 5: Concession�ria | 6: Posto de Gasolina | 7: Bar");
            SendSyntaxMessage(playerid, "[TIPOS] 8: Boate | 9: Mec�nica | 10: Pawn Shop | 11: Escrit�rio | 12: Cassino");
            return 1;
        }

        UpdateBusinessType(businessID, newType);

        SendServerMessage(playerid, "Voc� editou o tipo da empresa de ID %d para $%s.", businessID, newType);
        format(logString, sizeof(logString), "%s (%s) editou o tipo da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newType);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    if(!strcmp(option, "alarme", true)) {
        new newAlarm = strval(value);

        if(newAlarm < 0 || newAlarm > 3)
            return SendErrorMessage(playerid, "O tipo do alarme n�o pode ser menos que 0 ou maior que 3.");

        UpdateBusinessAlarm(businessID, newAlarm);

        SendServerMessage(playerid, "Voc� editou o alarme da empresa de ID %d para $%s.", businessID, newAlarm);
        format(logString, sizeof(logString), "%s (%s) editou o alarme da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newAlarm);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    if(!strcmp(option, "seguran�a", true) || !strcmp(option, "seguranca", true)) {
        new newSecurity = strval(value);

        if(newSecurity < 0 || newSecurity > 3)
            return SendErrorMessage(playerid, "O tipo de seguran�a n�o pode ser menos que 0 ou maior que 3.");

        UpdateBusinessSecurity(businessID, newSecurity);

        SendServerMessage(playerid, "Voc� editou a seguran�a da empresa de ID %d para $%s.", businessID, newSecurity);
        format(logString, sizeof(logString), "%s (%s) editou a seguran�a da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newSecurity);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    if(!strcmp(option, "blip", true) || !strcmp(option, "blips", true)) {
        new newBlip = strval(value);

        if(newBlip < 0 || newBlip > 63)
            return SendErrorMessage(playerid, "Voc� deve especificar um blip maior que 0 e menor que 63.");

        UpdateBusinessBlip(businessID, newBlip);

        SendServerMessage(playerid, "Voc� editou o blip/icon da empresa de ID %d para $%s.", businessID, newBlip);
        format(logString, sizeof(logString), "%s (%s) editou o blip/icon da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newBlip);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    if(!strcmp(option, "produtos", true) || !strcmp(option, "produto", true)) {
        new newProducts = strval(value);

        if(newProducts < 0 || newProducts > 500)
            return SendErrorMessage(playerid, "Voc� deve especificar um valor maior que 0 e menor que 500.");

        UpdateBusinessProducts(businessID, newProducts);

        SendServerMessage(playerid, "Voc� editou os produtos da empresa de ID %d para $%s.", businessID, newProducts);
        format(logString, sizeof(logString), "%s (%s) editou os produtos da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newProducts);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    if(!strcmp(option, "taxa", true) || !strcmp(option, "taxas", true)) {
        new newTax = strval(value);

        if(newTax < 30 || newTax > 500)
            return SendErrorMessage(playerid, "Voc� deve especificar um valor maior que 30 e menor que 500.");

        UpdateBusinessProducts(businessID, newTax);

        SendServerMessage(playerid, "Voc� editou o valor da taxa da empresa de ID %d para $%s.", businessID, newTax);
        format(logString, sizeof(logString), "%s (%s) editou o valor da taxa da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), businessID, newTax);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    return 1;
}

// ============================================================================================================================================
// ============================================================================================================================================
// ============================================================================================================================================

CMD:irempresa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2))
        return SendPermissionMessage(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/irempresa [id]");

    TeleportToBusiness(playerid, id);

    return 1;
}