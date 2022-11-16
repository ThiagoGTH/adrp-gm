#include <YSI_Coding\y_hooks>

//Comando para criar empresa
CMD:criarempresa(playerid, params[]) {
    new type, price, address[256], Float:pos[4];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "ds[256]", type ,price, address))
    {
        SendSyntaxMessage(playerid, "/criarempresa [tipo] [pre�o] [endere�o �nico]");
        SendSyntaxMessage(playerid, "[TIPOS] 1: 24/7 | 2: Ammunation | 3: Loja de roupas | 4: Fast Food | 5: Concession�ria | 6: Posto de gasolina | 7: Firma");
        return 1;
    }

    if (type < 1 || type > 7)
        return SendErrorMessage(playerid, "Tipo inv�lido. Tipos de 1 � 6.");

    if(price < 1000)
        return SendErrorMessage(playerid, "O pre�o da empresa deve ser maior do que $1000.");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `address` = '%e';", address);
    mysql_query(DBConn, query);

    if(cache_num_rows())
        return SendErrorMessage(playerid, "Este endere�o j� est� registrado em outra empresa!");

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `business` (`type`, `address`, `price`, `entry_x`, `entry_y`, `entry_z`, `entry_a`, `vw_entry`, `interior_entry`) \
        VALUES ('%s', %d, %f, %f, %f, %f, %d, %d);", type, address, price, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();

    mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `vw_exit` = %d WHERE `id` = %d;", id + 10000, id);
    mysql_query(DBConn, query);

    LoadBusiness(id);

    SendServerMessage(playerid, "Voc� criou a empresa de ID %d no endere�o: '%s'. ($%s)", id, address, FormatNumber(price));
    format(logString, sizeof(logString), "%s (%s) criou a empresa de ID %d no endere�o: '%s'. ($%s)", pNome(playerid), GetPlayerUserEx(playerid), id, address,  FormatNumber(price));
	logCreate(playerid, logString, 13);

    return 1;
}

//Comanda para deletar empresa
CMD:deletarempresa(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/deletarempreasa [id]");

    if(!IsValidBusiness(id))
        return SendErrorMessage(playerid, "Esse ID de empresa n�o existe.");

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);


    SendServerMessage(playerid, "Voc� deletou a empresa de ID %d.", id);

    format(logString, sizeof(logString), "%s (%s) deletou a empresa de ID %d. (%s)", pNome(playerid), GetPlayerUserEx(playerid), id, bInfo[id][bAddress]);
	logCreate(playerid, logString, 13);

    new dummyReset[E_BUSINESS_DATA];
    bInfo[id] = dummyReset;

    return 1;
}

//Editar empresa (bID) - (MySQL)
CMD:editarempresa(playerid, params[]) {
    new 
        id, 
        option[64], 
        value[64];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "ds[64]S()[64]", id, option, value)) {
        SendSyntaxMessage(playerid, "/editarempresa [id] [op��o]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: entrada, interior, preco, endereco, tipo, nome");
    }

    if(!IsValidBusiness(id))
        return SendErrorMessage(playerid, "Esse ID da empresa n�o existe.");

    // Editar a entrada (localiza��o)
    if(!strcmp(option, "entrada", true)) {
        new Float:pos[4];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);

        bInfo[id][bEntryPos][0] = pos[0];
        bInfo[id][bEntryPos][1] = pos[1];
        bInfo[id][bEntryPos][2] = pos[2];
        bInfo[id][bEntryPos][3] = pos[3];
        bInfo[id][vwEntry] = GetPlayerVirtualWorld(playerid);
        bInfo[id][interiorEntry] = GetPlayerInterior(playerid);
    
        SaveBusiness(id);

        SendServerMessage(playerid, "Voc� editou a entrada da empresa de ID %d.", id);

        format(logString, sizeof(logString), "%s (%s) editou a entrada da empresa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    // Editar o interior (lado de dentro) da empresa
    if(!strcmp(option, "interior", true)) {
        new Float:pos[4];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);

        bInfo[id][bExitPos][0] = pos[0];
        bInfo[id][bExitPos][1] = pos[1];
        bInfo[id][bExitPos][2] = pos[2];
        bInfo[id][bExitPos][3] = pos[3];
        bInfo[id][interiorExit] = GetPlayerInterior(playerid);
    
        SaveBusiness(id);

        SendServerMessage(playerid, "Voc� editou o interior da empresa de ID %d.", id);

        format(logString, sizeof(logString), "%s (%s) editou o interior da empresa de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
	    logCreate(playerid, logString, 13);
        return 1;
    } 

    // Editar o pre�o da empresa
    if(!strcmp(option, "preco", true) || !strcmp(option, "pre�o", true)) {
        new businessValue = strval(value);
        
        if(!businessValue || businessValue < 0)
            return SendErrorMessage(playerid, "Voc� precisa especificar um valor que seja maior do que zero para ser o pre�o da empresa.");

        bInfo[id][bPrice] = businessValue;
        SaveBusiness(id);

        SendServerMessage(playerid, "Voc� editou o pre�o da empresa de ID %d para $%s.", id, FormatNumber(businessValue));

        format(logString, sizeof(logString), "%s (%s) editou o pre�o da empresa de ID %d para $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(businessValue));
	    logCreate(playerid, logString, 13);
        return 1;
    }

    //Editar o endere�o da empresa
    if(!strcmp(option, "endereco", true) || !strcmp(option, "endere�o", true)) {
        if(!strlen(value))
            return SendErrorMessage(playerid, "Voc� precisa especificar um endere�o para setar.");

        format(bInfo[id][bAddress], 256, "%s", value);
        SaveBusiness(id);

        SendServerMessage(playerid, "Voc� setou o endere�o da empresa de ID %d como '%s'.", id, value);

        format(logString, sizeof(logString), "%s (%s) setou o endere�o da empresa de ID %d como '%s'.", pNome(playerid), GetPlayerUserEx(playerid), id, value);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    //Editar o tipo da empresa
    if(!strcmp(option, "tipo", true) || !strcmp(option, "tipo", true)) {
        new 
            businessType = strval(value),
            typeint = strval(value);
        
        if(businessType < 0 || businessType < 7)
            return SendErrorMessage(playerid, "[TIPOS] 1: 24/7 | 2: Ammunation | 3: Loja de roupas | 4: Fast Food | 5: Concession�ria | 6: Posto de gasolina | 7: Firma");

        bInfo[id][bType] = businessType;
        typeint = businessType;

        switch (typeint) {
            case 1: {
                bInfo[id][bExitPos][0] = -27.3074;
                bInfo[id][bExitPos][1] = -30.8741;
                bInfo[id][bExitPos][2] = 1003.5573;
                bInfo[id][bExitPos][3] = 0.0000;
                bInfo[id][interiorExit] = 4;
            }
            case 2: {
                bInfo[id][bExitPos][0] = 316.3963;
                bInfo[id][bExitPos][1] = -169.8375;
                bInfo[id][bExitPos][2] = 999.6010;
                bInfo[id][bExitPos][3] = 0.0000;
                bInfo[id][interiorExit] = 6;
            }
            case 3: {
                bInfo[id][bExitPos][0] = 161.4801;
                bInfo[id][bExitPos][1] = -96.5368;
                bInfo[id][bExitPos][2] = 1001.8047;
                bInfo[id][bExitPos][3] = 0.0000;
                bInfo[id][interiorExit] = 18;
            }
            case 4: {
                bInfo[id][bExitPos][0] = 363.3402;
                bInfo[id][bExitPos][1] = -74.6679;
                bInfo[id][bExitPos][2] = 1001.5078;
                bInfo[id][bExitPos][3] = 315.0000;
                bInfo[id][interiorExit] = 10;
            }
            case 5: {
                bInfo[id][bExitPos][0] = 1494.5612;
                bInfo[id][bExitPos][1] = 1304.2061;
                bInfo[id][bExitPos][2] = 1093.2891;
                bInfo[id][bExitPos][3] = 0.0000;
                bInfo[id][interiorExit] = 3;
            }
            case 6: {
                bInfo[id][bExitPos][0] = -27.3383;
                bInfo[id][bExitPos][1] = -57.6909;
                bInfo[id][bExitPos][2] = 1003.5469;
                bInfo[id][bExitPos][3] = 0.0000;
                bInfo[id][interiorExit] = 6;
            }
            case 7: {
                SendErrorMessage(playerid, "� necess�rio que voc� sete manualmente o interior (se for modificado) - (em breve mais interiores poder�o ser definidos).");
                SendErrorMessage(playerid, "Ultilize /editarempresa (no tipo interior).");
            }
        }

        SaveBusiness(id);
        SendServerMessage(playerid, "Voc� editou o pre�o da empresa de ID %d para $%s.", id, BusinessType(id));

        format(logString, sizeof(logString), "%s (%s) editou o tipo da empresa de ID %d para %s.", pNome(playerid), GetPlayerUserEx(playerid), id, BusinessType(id));
	    logCreate(playerid, logString, 13);
        return 1;
    }
    //Editar o nome da empresa
    if(!strcmp(option, "nome", true) || !strcmp(option, "nome", true)) {
        if(!strlen(value))
            return SendErrorMessage(playerid, "Voc� precisa especificar um nome para setar.");

        format(bInfo[id][bName], 256, "%s", value);
        SaveBusiness(id);

        SendServerMessage(playerid, "Voc� setou o nome da empresa de ID %d como '%s'.", id, value);

        format(logString, sizeof(logString), "%s (%s) setou o nome da empresa de ID %d como '%s'.", pNome(playerid), GetPlayerUserEx(playerid), id, value);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    SendSyntaxMessage(playerid, "/editarempresa [id] [op��o]");
    return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: entrada, interior, preco, endereco, tipo, nome");
}


//======================================================================================================================================================================
// Comandos relacionados ao dono da empresa (em produ��o - procurando forma de verificar se ele � o dono da empresa).
CMD:empresa(playerid, params[]) {
    new 
        businessID = GetNearestBusinessEntry(playerid),
        option[64], 
        value[64];
        

    if(!businessID)
        return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo � nenhuma empresa.");
    
    if(bInfo[businessID][bOwner] != pInfo[playerid][pID])
        return SendErrorMessage(playerid, "Essa empresa n�o � sua.");

	if(sscanf(params, "ds[64]S()[64]", option, value)) {
        SendSyntaxMessage(playerid, "/empresa [op��o]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: nome");
    }

    //Editar o nome da empresa
    if(!strcmp(option, "nome", true) || !strcmp(option, "nome", true)) {
        if(!strlen(value))
            return SendErrorMessage(playerid, "Voc� precisa especificar um nome para setar.");

        format(bInfo[businessID][bName], 256, "%s", value);
        SaveBusiness(businessID);

        SendServerMessage(playerid, "Voc� setou o nome da empresa de ID %d como '%s'.", businessID, value);

        format(logString, sizeof(logString), "%s (%s) setou o nome da empresa de ID %d como '%s'.", pNome(playerid), GetPlayerUserEx(playerid), businessID, value);
	    logCreate(playerid, logString, 13);
        return 1;
    }

    SendSyntaxMessage(playerid, "/empresa [id] [op��o]");
    return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: nome");
} 

/*CMD:cofre(playerid, params[])
{
     new 
        id = -1,
        option[64], 
        value[64];

	if(sscanf(params, "ds[64]S()[64]", id, option, value)) {
        SendSyntaxMessage(playerid, "/cofre [op��o]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: sacar, depositar");
    }

    //Sacar dinheiro do cofre da empresa.
    if(!strcmp(option, "sacar", true)) {

        return 1;
    }
    if(!strcmp(option, "depositar", true)) {

        return 1;
    }


    return 1;
} */