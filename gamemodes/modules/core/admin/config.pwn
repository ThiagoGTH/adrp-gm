/*

Este m�dulo � dedicado ao /gerenciar, que ser� integrado ao MySQL e poder� adicionar tudo dinamicamente.
 
*/

#include <YSI_Coding\y_hooks>

CMD:gerenciar(playerid, params[]){
    
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    if(GetPlayerAdmin(playerid) > 5) Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mob�lias\nItens\nInteriores\nConcession�ria\nAdministradores", "Selecionar", "Fechar");
    else Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mob�lias\nItens\nInteriores\nConcession�ria", "Selecionar", "Fechar");
    return true;
}

Dialog:configSys(playerid, response, listitem, inputtext[]){
    if(response){
        if(listitem == 0){ // MOB�LIAS [OK]
            if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid); 

            mysql_format(DBConn, query, sizeof query, "SELECT * FROM furniture_info WHERE `ID` >= 0");
            new Cache:result = mysql_query(DBConn, query);

            new string[1024], furName[64], furModel, furCategory[64];
            format(string, sizeof(string), "Mob�lia\tID do Objeto\tCategoria\n");
            format(string, sizeof(string), "%s{BBBBBB}Adicionar mob�lia\n", string);
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name(i, "name", furName);
                cache_get_value_name_int(i, "model", furModel);
                cache_get_value_name(i, "category", furCategory);

                format(string, sizeof(string), "%s%s\t%d\t%s\n", string, furName, furModel, furCategory);
            }
            cache_delete(result);

            Dialog_Show(playerid, showInfoFurniture, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Mob�lias", string, "Selecionar", "<<");
            return true;
        }

        else if(listitem == 1){ // ITENS

            return true;
        }

        else if(listitem == 2){ // INTERIORES [OK]
            if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

            mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors_info WHERE `ID` >= 0");
            new Cache:result = mysql_query(DBConn, query);

            new string[1024], intName[64], intID;
            format(string, sizeof(string), "Nome\tID\n");
            format(string, sizeof(string), "%s{BBBBBB}Adicionar interior\n", string);
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "ID", intID);
                cache_get_value_name(i, "name", intName);

                format(string, sizeof(string), "%s%s\t%d\n", string, intName, intID);
            }
            cache_delete(result);

            Dialog_Show(playerid, showInfoInt, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Interiores", string, "Selecionar", "<<");
            return true;
        }

        else if(listitem == 3){ // Concession�ria
            if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid); 
            ResetDealershipMenuVars(playerid);
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles_dealer WHERE `ID` > 0 ORDER BY `ID` DESC");
            new Cache:result = mysql_query(DBConn, query);

            new string[2048], model_id, id;
            format(string, sizeof(string), "19132(0.0, 0.0, -80.0, 1.0)\t~g~Adicionar\n");
            for(new i; i < cache_num_rows(); i++) {
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "ID", id);

                format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, 1, 1)\t~w~%s (%d)~n~~n~~n~~n~~g~EDITAR\n", string, model_id, ReturnVehicleModelName(model_id), id);
            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Gerenciar_Concession�ria");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipConfig, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }

        else if(listitem == 4){ // ADMINISTRADORES [OK]
            if(GetPlayerAdmin(playerid) < 1335) return SendPermissionMessage(playerid);

            mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `admin` > 0 ORDER BY `admin` ASC");
            new Cache:result = mysql_query(DBConn, query);

            if(!cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel encontrar nenhum administrador na database. [E#01]");

            new string[1024], userValue[24], adminLevel;
            format(string, sizeof(string), "Usu�rio\tRanking\n");
            format(string, sizeof(string), "%s{BBBBBB}Adicionar administrador\n", string);
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name(i, "username", userValue);
                cache_get_value_name_int(i, "admin", adminLevel);

                format(string, sizeof(string), "%s%s\t%d\n", string, userValue, adminLevel);
            }
            cache_delete(result);

            Dialog_Show(playerid, showAdmins, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Administradores", string, "Remover", "<<");
            return true;
        }
    }
    return true;
}
// FURNITURE
Dialog:showInfoFurniture(playerid, response, listitem, inputtext[]){
    if(response){
        new string[256];
        if(!strcmp(inputtext, "Adicionar mob�lia", true)){ // Adicionar
            Dialog_Show(playerid, addInfoFurniture1, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "Digite o nome da mob�lia que deseja criar no servidor:\nOBSERVA��O: Esse ser� o nome que aparecer� para o usu�rio na lista de mob�lias do servidor.", "Adicionar", "<<");
        } else { // Remover
            format(pInfo[playerid][tempChar], 64, "%s", inputtext);
            format(string, 256, "Voc� realmente deseja deletar a mob�lia %s? Essa a��o � irrevers�vel.", inputtext);

            Dialog_Show(playerid, confirmInfoFur, DIALOG_STYLE_MSGBOX, "Gerenciar > Mob�lias > Deletar mob�lia > Confirmar", string, "Deletar", "Cancelar");
        }
    } else { // Voltar
        if(GetPlayerAdmin(playerid) > 5) Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mob�lias\nItens\nInteriores\nConcession�ria\nAdministradores", "Selecionar", "Fechar");
        else Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mob�lias\nItens\nInteriores\nConcession�ria", "Selecionar", "Fechar");
    }
    return true;
}

Dialog:confirmInfoFur(playerid, response, listitem, inputtext[]){
    if(response){ // Confirmar
        mysql_format(DBConn, query, sizeof query, "DELETE FROM furniture_info WHERE `name` = '%s';", pInfo[playerid][tempChar]);
        new Cache:result = mysql_query(DBConn, query);

        SendServerMessage(playerid, "Voc� deletou a mob�lia %s com sucesso. A a��o � irrevers�vel.", pInfo[playerid][tempChar]);
        
        format(logString, sizeof(logString), "%s (%s) deletou a mob�lia %s.", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][tempChar]);
		logCreate(playerid, logString, 8);

        pInfo[playerid][tempChar][0] = EOS;
        cache_delete(result);
    } else { // Cancelar
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
        pInfo[playerid][tempChar][0] = EOS;

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM furniture_info WHERE `ID` >= 0");
        new Cache:result = mysql_query(DBConn, query);

        new string[1024], furName[64], furModel, furCategory[64];
        format(string, sizeof(string), "Mob�lia\tID do Objeto\nCategoria\n");
        format(string, sizeof(string), "%s{BBBBBB}Adicionar mob�lia\n", string);
        for(new i; i < cache_num_rows(); i++){
            cache_get_value_name(i, "name", furName);
            cache_get_value_name_int(i, "model", furModel);
            cache_get_value_name(i, "category", furCategory);

            format(string, sizeof(string), "%s%s\t%d\t%s\n", string, furName, furModel, furCategory);
        }
        cache_delete(result);

        Dialog_Show(playerid, showInfoFurniture, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Mob�lias", string, "Selecionar", "<<");
    }
    return true;
}

Dialog:addInfoFurniture1(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, addInfoFurniture1, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "ERRO: Voc� n�o especificou um nome.\nDigite o nome da mob�lia que deseja criar no servidor:", "Adicionar", "<<");

        if(strlen(inputtext) > 64) return Dialog_Show(playerid, addInfoFurniture1, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "ERRO: Voc� especificou um nome grande demais, o m�ximo � de 64 caracteres.\nDigite o nome da mob�lia que deseja criar no servidor:", "Adicionar", "<<");

        format(pInfo[playerid][tempChar], 64, "%s", inputtext);
        
        Dialog_Show(playerid, addInfoFurniture2, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "Digite o nome da categoria para a mob�lia criada:", "Adicionar", "<<");

    } else {
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
        pInfo[playerid][tempChar][0] = EOS;
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM furniture_info WHERE `ID` >= 0");
        new Cache:result = mysql_query(DBConn, query);

        new string[1024], furName[64], furModel, furCategory[64];
        format(string, sizeof(string), "Mob�lia\tID do Objeto\nCategoria\n");
        format(string, sizeof(string), "%s{BBBBBB}Adicionar mob�lia\n", string);
        for(new i; i < cache_num_rows(); i++){
            cache_get_value_name(i, "name", furName);
            cache_get_value_name_int(i, "model", furModel);
            cache_get_value_name(i, "category", furCategory);

            format(string, sizeof(string), "%s%s\t%d\t%s\n", string, furName, furModel, furCategory);
        }
        cache_delete(result);

        Dialog_Show(playerid, showInfoFurniture, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Mob�lias", string, "Selecionar", "<<");
    }
    return true;
}

Dialog:addInfoFurniture2(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, addInfoFurniture2, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "ERRO: Voc� n�o especificou um nome de categoria correto.\nDigite o nome da categoria em que a mob�lia dever� ser criada:", "Adicionar", "<<");

        if(strlen(inputtext) > 64) return Dialog_Show(playerid, addInfoFurniture2, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "ERRO: Voc� especificou um nome grande demais, o m�ximo � de 64 caracteres.\nDigite o nome da categoria que deseja colocar a mob�lia:", "Adicionar", "<<");

        format(pInfo[playerid][tempChar2], 64, "%s", inputtext);
        
        Dialog_Show(playerid, addInfoFurniture3, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "Digite o ID de um objeto para ser a mob�lia:\nOBSERVA��O: Voc� pode achar o ID dos objetos nativos do SA-MP em: www.dev.prineside.com\n\nPor favor, digite o ID do objeto que deseja adicionar:", "Adicionar", "<<");

    } else {
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
        pInfo[playerid][tempChar][0] = 
        pInfo[playerid][tempChar2][0] = EOS;

        Dialog_Show(playerid, addInfoFurniture1, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "Digite o nome da mob�lia que deseja criar no servidor:\nOBSERVA��O: Esse ser� o nome que aparecer� para o usu�rio na lista de mob�lias do servidor.", "Adicionar", "<<");
    }
    return true;
}

Dialog:addInfoFurniture3(playerid, response, listitem, inputtext[]){
    if(response){
        new modelid = strval(inputtext);
        
	    if (isnull(inputtext)) return Dialog_Show(playerid, addInfoFurniture3, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "ERRO: Voc� n�o especificou um ID.\nDigite o ID de um objeto para ser a mob�lia:", "Adicionar", "<<");

        if (modelid > 19999) return Dialog_Show(playerid, addInfoFurniture3, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "ERRO: O ID n�o pode ser maior que 19999.\nVoc� pode achar o ID dos objetos em: www.dev.prineside.com\nDigite o ID de um objeto para ser a mob�lia:", "Adicionar", "<<");

        mysql_format(DBConn, query, sizeof query, "INSERT INTO furniture_info (`name`, `model`, `category`) VALUES ('%s', '%d', '%s');", pInfo[playerid][tempChar], modelid, pInfo[playerid][tempChar2]);
        new Cache:result = mysql_query(DBConn, query);

        format(logString, sizeof(logString), "%s (%s) criou a mob�lia %s (%d) com a categoria %s.", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][tempChar], modelid, pInfo[playerid][tempChar2]);
		logCreate(playerid, logString, 8);
        SendServerMessage(playerid, "Voc� criou a mob�lia %s (%d) com a categoria %s com sucesso.", pInfo[playerid][tempChar], modelid, pInfo[playerid][tempChar2]);
        pInfo[playerid][tempChar][0] = 
        pInfo[playerid][tempChar2][0] = EOS;
        cache_delete(result);
    } else {
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
        pInfo[playerid][tempChar][0] = 
        pInfo[playerid][tempChar2][0] = EOS;

        Dialog_Show(playerid, addInfoFurniture2, DIALOG_STYLE_INPUT, "Gerenciar > Mob�lias > Adicionar mob�lia", "Digite o nome da categoria para a mob�lia criada:", "Adicionar", "<<");
    }
    return true;
}

// INTERIORES
Dialog:showInfoInt(playerid, response, listitem, inputtext[]){
    if(response){
        new string[256];
        if(!strcmp(inputtext, "Adicionar interior", true)){ // Adicionar
            Dialog_Show(playerid, addInfoInt, DIALOG_STYLE_INPUT, "Gerenciar > Interiores > Adicionar", "Digite o nome do interior a ser criado:\nOBSERVA��O: Esse ser� o nome que aparecer� para o usu�rio no '/ir interior'.\nAs coordenadas, o virtual world e o interior ser�o setados de acordo com a posi��o do seu personagem.", "Adicionar", "<<");
        } else { // Remover
            format(pInfo[playerid][tempChar], 64, "%s", inputtext);
            format(string, 256, "Voc� realmente deseja deletar o interior '%s'? Essa a��o � irrevers�vel.", inputtext);

            Dialog_Show(playerid, confirmInfoInt, DIALOG_STYLE_MSGBOX, "Gerenciar > Interiores > Remover", string, "Deletar", "Cancelar");
        }
    } else {  // Voltar
        if(GetPlayerAdmin(playerid) > 5) Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mob�lias\nItens\nInteriores\nConcession�ria\nAdministradores", "Selecionar", "Fechar");
        else Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mob�lias\nItens\nInteriores\nConcession�ria", "Selecionar", "Fechar");
    }
    return true;
} 

Dialog:addInfoInt(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, addInfoInt, DIALOG_STYLE_INPUT, "Gerenciar > Interiores > Adicionar", "ERRO: Voc� n�o especificou um nome.\nDigite o nome do interior a ser criado:", "Adicionar", "<<");

        if(strlen(inputtext) > 64) return Dialog_Show(playerid, addInfoInt, DIALOG_STYLE_INPUT, "Gerenciar > Interiores > Adicionar", "ERRO: Voc� especificou um nome grande demais, o m�ximo � de 64 caracteres.\nDigite o nome do interior a ser criado:", "Adicionar", "<<");

        new Float:pos[4], vw, int;
        format(pInfo[playerid][tempChar], 64, "%s", inputtext);

        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);
        int = GetPlayerInterior(playerid);
        vw = GetPlayerVirtualWorld(playerid);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO interiors_info (`name`, `virtual_world`, `interior`, `positionX`, `positionY`, `positionZ`, `positionA`) VALUES ('%s', '%d', '%d', '%f', '%f', '%f', '%f');", pInfo[playerid][tempChar], vw, int, pos[0], pos[1], pos[2], pos[3]);
        new Cache:result = mysql_query(DBConn, query);

        format(logString, sizeof(logString), "%s (%s) criou o interior %s (%f, %f, %f, %f - VW: %d INT: %d).", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][tempChar], pos[0], pos[1], pos[2], pos[3], vw, int);
		logCreate(playerid, logString, 8);

        SendServerMessage(playerid, "Voc� criou o interior %s de acordo com as suas coordenadas.", pInfo[playerid][tempChar]);
        pInfo[playerid][tempChar][0] =  EOS;
        cache_delete(result);
    } else {
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors_info WHERE `ID` >= 0");
        new Cache:result = mysql_query(DBConn, query);

        new string[1024], intName[64], intID;
        format(string, sizeof(string), "Nome\tID\n");
        format(string, sizeof(string), "%s{BBBBBB}Adicionar interior\n", string);
        for(new i; i < cache_num_rows(); i++){
            cache_get_value_name_int(i, "ID", intID);
            cache_get_value_name(i, "name", intName);

            format(string, sizeof(string), "%s%s\t%d\n", string, intName, intID);
        }
        cache_delete(result);

        Dialog_Show(playerid, showInfoInt, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Interiores", string, "Selecionar", "<<");
    }
    return true;
}

Dialog:confirmInfoInt(playerid, response, listitem, inputtext[]){
    if(response){ // Confirmar
        mysql_format(DBConn, query, sizeof query, "DELETE FROM interiors_info WHERE `name` = '%s';", pInfo[playerid][tempChar]);
        new Cache:result = mysql_query(DBConn, query);

        format(logString, sizeof(logString), "%s (%s) deletou o interior %s.", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][tempChar]);
		logCreate(playerid, logString, 8);

        SendServerMessage(playerid, "Voc� deletou o interior '%s' com sucesso. A a��o � irrevers�vel.", pInfo[playerid][tempChar]);
        
        pInfo[playerid][tempChar][0] = EOS;
        cache_delete(result);
    } else { // Cancelar
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors_info WHERE `ID` >= 0");
        new Cache:result = mysql_query(DBConn, query);

        new string[1024], intName[64], intID;
        format(string, sizeof(string), "Nome\tID\n");
        format(string, sizeof(string), "%s{BBBBBB}Adicionar interior\n", string);
        for(new i; i < cache_num_rows(); i++){
            cache_get_value_name_int(i, "ID", intID);
            cache_get_value_name(i, "name", intName);

            format(string, sizeof(string), "%s%s\t%d\n", string, intName, intID);
        }
        cache_delete(result);

        Dialog_Show(playerid, showInfoInt, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Interiores", string, "Selecionar", "<<");
    }
    return true;
}

// CONCESSION�RIA
Dialog:DealershipConfig(playerid, response, listitem, inputtext[]){
    if(response) {
        new title[128], string[1024];
        new model_id = strval(inputtext), price, premium, sqlid, category;
        if(model_id == 19132){
            Dialog_Show(playerid, DealershipAdd, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar ve�culo � concession�ria", "Digite o ID do ve�culo a ser adicionado:", "Adicionar", "<<");
        } else {
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles_dealer` WHERE `model_id` = '%d'", model_id);
            new Cache:result = mysql_query(DBConn, query);
            if(!cache_num_rows()) return SendErrorMessage(playerid, "DCx001 - Ocorreu um erro, reporte a um desenvolvedor.");
            cache_get_value_name_int(0, "ID", sqlid);
            cache_get_value_name_int(0, "category", category);
            cache_get_value_name_int(0, "price", price);
            cache_get_value_name_int(0, "premium", premium);
            cache_delete(result);

            format(title, sizeof(title), "{FFFFFF}Gerenciar %s {AFAFAF}(SQL: %d)", ReturnVehicleModelName(model_id), sqlid);

            format(string, sizeof(string), 
                "{AFAFAF}Categoria\t{FFFFFF}%s\n\
                {AFAFAF}Premium\t{FFFFFF}%s\n\
                {AFAFAF}Valor\t{FFFFFF}US$ %s\n\t\n\
                {FF0000}Deletar ve�culo", DealershipCategory(category), PremiumType(premium),FormatNumber(price)
            );

            pInfo[playerid][dEditingSQL] = sqlid;
            pInfo[playerid][dEditingModel] = model_id;
            pInfo[playerid][dEditingPremium] = premium;
            pInfo[playerid][dEditingCategory] = category;
            pInfo[playerid][dEditingPrice] = price;
            Dialog_Show(playerid, DealershipEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
        }
    } else {
        ResetDealershipMenuVars(playerid);
    }
    return true;
}

Dialog:DealershipAdd(playerid, response, listitem, inputtext[]){
    if(response){
        static model[32];
        format(model, 32, "%s", inputtext);

        if (isnull(inputtext)) return Dialog_Show(playerid, DealershipAdd, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar ve�culo � concession�ria", "Voc� n�o especificou nenhum modelo.\nDigite o ID do ve�culo a ser adicionado:", "Adicionar", "<<");

        if ((model[0] = GetVehicleModelByName(model)) == 0) return Dialog_Show(playerid, DealershipAdd, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar ve�culo � concession�ria", "O modelo especificado � inv�lido.\nDigite o ID do ve�culo a ser adicionado:", "Adicionar", "<<");

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles_dealer` WHERE `model_id` = '%d';", model[0]);
        new Cache:result = mysql_query(DBConn, query);
        if(cache_num_rows()) return SendErrorMessage(playerid, "J� existe um ve�culo com este modelo.");
        cache_delete(result);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO `vehicles_dealer` (`model_id`, `category`, `price`) VALUES ('%d', '1', '999999999');", model[0]);
        result = mysql_query(DBConn, query);
        cache_delete(result);

        SendServerMessage(playerid, "Voc� adicionou o ve�culo %s na concession�ria. Agora edite-o no painel.", ReturnVehicleModelName(model[0]));

        format(logString, sizeof(logString), "%s (%s) adicionou o ve�culo %s na concession�ria.", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(model[0]));
	    logCreate(playerid, logString, 1);
        // VOLTANDO AO MENU
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid); 
        ResetDealershipMenuVars(playerid);
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles_dealer WHERE `ID` > 0 ORDER BY `ID` DESC");
        result = mysql_query(DBConn, query);

        new string[2048], model_id, id;
        format(string, sizeof(string), "19132(0.0, 0.0, -80.0, 1.0)\t~g~Adicionar\n");
        for(new i; i < cache_num_rows(); i++) {
            cache_get_value_name_int(i, "model_id", model_id);
            cache_get_value_name_int(i, "ID", id);

            format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, 1, 1)\t~w~%s (%d)~n~~n~~n~~n~~g~EDITAR\n", string, model_id, ReturnVehicleModelName(model_id), id);
        }
        cache_delete(result);
        new title[128];
        format(title, 128, "Gerenciar_Concession�ria");
        AdjustTextDrawString(title);

        Dialog_Show(playerid, DealershipConfig, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
    } else {
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid); 
        ResetDealershipMenuVars(playerid);
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles_dealer WHERE `ID` > 0 ORDER BY `ID` DESC");
        new Cache:result = mysql_query(DBConn, query);

        new string[2048], model_id, id;
        format(string, sizeof(string), "19132(0.0, 0.0, -80.0, 1.0)\t~g~Adicionar\n");
        for(new i; i < cache_num_rows(); i++) {
            cache_get_value_name_int(i, "model_id", model_id);
            cache_get_value_name_int(i, "ID", id);

            format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, 1, 1)\t~w~%s (%d)~n~~n~~n~~n~~g~EDITAR\n", string, model_id, ReturnVehicleModelName(model_id), id);
        }
        cache_delete(result);
        new title[128];
        format(title, 128, "Gerenciar_Concession�ria");
        AdjustTextDrawString(title);

        Dialog_Show(playerid, DealershipConfig, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
    }
    return true;
}

Dialog:DealershipEdit(playerid, response, listitem, inputtext[]){
    if(response) {
        new string[512], title[128];
        format(title, sizeof(title), "{FFFFFF}Gerenciar %s {AFAFAF}(SQL: %d)", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL]);
        switch(listitem) {
            case 0: {
                switch(pInfo[playerid][dEditingCategory]){
                    case 1: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 2: format(string, sizeof(string), "Avi�es\n{BBBBBB}>>> {FFFFFF}Barcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 3: format(string, sizeof(string), "Avi�es\nBarcos\n{BBBBBB}>>> {FFFFFF}Bicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 4: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\n{BBBBBB}>>> {FFFFFF}Motos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 5: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\n{BBBBBB}>>> {FFFFFF}Sedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 6: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\n{BBBBBB}>>> {FFFFFF}SUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 7: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\n{BBBBBB}>>> {FFFFFF}Lowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 8: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\n{BBBBBB}>>> {FFFFFF}Esportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 9: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\n{BBBBBB}>>> {FFFFFF}Industriais\nCaminhonetes\n�nicos\nTrailers industriais");
                    case 10: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\n{BBBBBB}>>> {FFFFFF}Caminhonetes\n�nicos\nTrailers industriais");
                    case 11: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n{BBBBBB}>>> {FFFFFF}�nicos\nTrailers industriais");
                    case 12: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\n{BBBBBB}>>> {FFFFFF}Trailers industriais");
                }
                pInfo[playerid][dEditingMenu] = 1;
                Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 1: {
                switch(pInfo[playerid][dEditingPremium]){
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Comum\nPremium Bronze\nPremium Prata\nPremium Ouro");
                    case 1: format(string, sizeof(string), "Comum\n{BBBBBB}>>> {FFFFFF}Premium Bronze\nPremium Prata\nPremium Ouro");
                    case 2: format(string, sizeof(string), "Comum\nPremium Bronze\n{BBBBBB}>>> {FFFFFF}Premium Prata\nPremium Ouro");
                    case 3: format(string, sizeof(string), "Comum\nPremium Bronze\nPremium Prata\n{BBBBBB}>>> {FFFFFF}Premium Ouro");

                }
                pInfo[playerid][dEditingMenu] = 2;
                Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 2: {
                pInfo[playerid][dEditingMenu] = 3;
                format(string, sizeof(string), "Digite o novo valor do ve�culo:\n\nValor anterior: US$ %s", FormatNumber(pInfo[playerid][dEditingPrice]));
                Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_INPUT, title, string, "Editar", "<<");
            }
            case 4: {
                mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_dealer` WHERE `ID` = '%d';", pInfo[playerid][dEditingSQL]);
                new Cache:result = mysql_query(DBConn, query);

                SendServerMessage(playerid, "Voc� deletou o ve�culo %s (SQL: %d) da concession�ria com sucesso. Essa a��o � irrevers�vel.", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL]);
                cache_delete(result);

                format(logString, sizeof(logString), "%s (%s) deletou o ve�culo %s (SQL: %d) da concession�ria", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL]);
	            logCreate(playerid, logString, 1);
                ResetDealershipMenuVars(playerid);
            }
        }
    } else{
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid); 
        ResetDealershipMenuVars(playerid);
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles_dealer WHERE `ID` > 0 ORDER BY `ID` ASC");
        new Cache:result = mysql_query(DBConn, query);

        new string[2048], model_id, id;
        format(string, sizeof(string), "19132(0.0, 0.0, -80.0, 1.0)\t~g~Adicionar\n");
        for(new i; i < cache_num_rows(); i++) {
            cache_get_value_name_int(i, "model_id", model_id);
            cache_get_value_name_int(i, "ID", id);

            format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, 1, 1)\t~w~%s (%d)~n~~n~~n~~n~~g~EDITAR\n", string, model_id, ReturnVehicleModelName(model_id), id);
        }
        cache_delete(result);
        new title[128];
        format(title, 128, "Gerenciar_Concession�ria");
        AdjustTextDrawString(title);

        Dialog_Show(playerid, DealershipConfig, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
    }
    return true;
}

Dialog:DealershipEditOptions(playerid, response, listitem, inputtext[]) {
    new string[512], title[128], Cache:result;
    format(title, sizeof(title), "{FFFFFF}Gerenciar %s {AFAFAF}(SQL: %d)", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL]);
    if(response) {
        if(pInfo[playerid][dEditingMenu] == 1){
            switch(listitem) {
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 1: format(string, sizeof(string), "Avi�es\n{BBBBBB}>>> {FFFFFF}Barcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 2: format(string, sizeof(string), "Avi�es\nBarcos\n{BBBBBB}>>> {FFFFFF}Bicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 3: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\n{BBBBBB}>>> {FFFFFF}Motos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 4: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\n{BBBBBB}>>> {FFFFFF}Sedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 5: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\n{BBBBBB}>>> {FFFFFF}SUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 6: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\n{BBBBBB}>>> {FFFFFF}Lowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 7: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\n{BBBBBB}>>> {FFFFFF}Esportivos\nIndustriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 8: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\n{BBBBBB}>>> {FFFFFF}Industriais\nCaminhonetes\n�nicos\nTrailers industriais");
                case 9: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\n{BBBBBB}>>> {FFFFFF}Caminhonetes\n�nicos\nTrailers industriais");
                case 10: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n{BBBBBB}>>> {FFFFFF}�nicos\nTrailers industriais");
                case 11: format(string, sizeof(string), "Avi�es\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n�nicos\n{BBBBBB}>>> {FFFFFF}Trailers industriais");
            }
            mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_dealer` SET `category` = '%d' WHERE `ID` = '%d';", listitem+1, pInfo[playerid][dEditingSQL]);
            mysql_query(DBConn, query);

            SendServerMessage(playerid, "Voc� alterou a categoria do ve�culo %s de %s para %s.", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), DealershipCategory(pInfo[playerid][dEditingCategory]), DealershipCategory(listitem+1));

            format(logString, sizeof(logString), "%s (%s) alterou a categoria do ve�culo %s (%d) de %s para %s", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL], DealershipCategory(pInfo[playerid][dEditingCategory]), DealershipCategory(listitem+1));
	        logCreate(playerid, logString, 1);

            pInfo[playerid][dEditingCategory] = listitem+1;
            Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            cache_delete(result);
        }
        else if(pInfo[playerid][dEditingMenu] == 2){
            switch(listitem) {
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Comum\nPremium Bronze\nPremium Prata\nPremium Ouro");
                case 1: format(string, sizeof(string), "Comum\n{BBBBBB}>>> {FFFFFF}Premium Bronze\nPremium Prata\nPremium Ouro");
                case 2: format(string, sizeof(string), "Comum\nPremium Bronze\n{BBBBBB}>>> {FFFFFF}Premium Prata\nPremium Ouro");
                case 3: format(string, sizeof(string), "Comum\nPremium Bronze\nPremium Prata\n{BBBBBB}>>> {FFFFFF}Premium Ouro");
            }
            mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_dealer` SET `premium` = '%d' WHERE `ID` = '%d';", listitem, pInfo[playerid][dEditingSQL]);
            mysql_query(DBConn, query);

            SendServerMessage(playerid, "Voc� alterou o premium do ve�culo %s de %s para %s.", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), PremiumType(pInfo[playerid][dEditingPremium]), PremiumType(listitem));

            format(logString, sizeof(logString), "%s (%s) alterou o premium do ve�culo %s (%d) de %s para %s", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL], PremiumType(pInfo[playerid][dEditingPremium]), PremiumType(listitem));
	        logCreate(playerid, logString, 1);

            pInfo[playerid][dEditingPremium] = listitem;
            Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            cache_delete(result);
        }
        else if(pInfo[playerid][dEditingMenu] == 3){
            new price = strval(inputtext);
        
            format(string, sizeof(string), "Voc� n�o especificou nenhum valor.\nDigite o novo valor do ve�culo:\n\nValor anterior: US$ %s", FormatNumber(pInfo[playerid][dEditingPrice]));
            if (isnull(inputtext)) return Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_INPUT, title, string, "Alterar", "<<");

            format(string, sizeof(string), "O valor n�o pode ser igual ou menor a zero.\nDigite o novo valor do ve�culo:\n\nValor anterior: US$ %s", FormatNumber(pInfo[playerid][dEditingPrice]));
            if (price < 1) return Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_INPUT, title, string, "Alterar", "<<");

            mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_dealer` SET `price` = '%d' WHERE `ID` = '%d';", price, pInfo[playerid][dEditingSQL]);
            mysql_query(DBConn, query);

            SendServerMessage(playerid, "Voc� alterou o valor do ve�culo %s de US$ %s para US$ %s.", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), FormatNumber(pInfo[playerid][dEditingPrice]), FormatNumber(price));

            format(logString, sizeof(logString), "%s (%s) alterou o valor do ve�culo %s (%d) de US$ %s para US$ %s", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL], FormatNumber(pInfo[playerid][dEditingPrice]), FormatNumber(price));
	        logCreate(playerid, logString, 1);

            pInfo[playerid][dEditingPrice] = price;

            cache_delete(result);
            
            format(string, sizeof(string), 
                "{AFAFAF}Categoria\t{FFFFFF}%s\n\
                {AFAFAF}Premium\t{FFFFFF}%s\n\
                {AFAFAF}Valor\t{FFFFFF}US$ %s\n\t\n{FF0000}Deletar ve�culo", DealershipCategory(pInfo[playerid][dEditingCategory]), PremiumType(pInfo[playerid][dEditingPremium]),FormatNumber(pInfo[playerid][dEditingPrice])
            );
            Dialog_Show(playerid, DealershipEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
        }
    } else {
        format(string, sizeof(string), 
            "{AFAFAF}Categoria\t{FFFFFF}%s\n\
            {AFAFAF}Premium\t{FFFFFF}%s\n\
            {AFAFAF}Valor\t{FFFFFF}US$ %s\n\t\n{FF0000}Deletar ve�culo", DealershipCategory(pInfo[playerid][dEditingCategory]), PremiumType(pInfo[playerid][dEditingPremium]),FormatNumber(pInfo[playerid][dEditingPrice])
        );

        Dialog_Show(playerid, DealershipEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
    }
    return true;
}

// ADMINS
Dialog:showAdmins(playerid, response, listitem, inputtext[]){
    if(response){
        if(!strcmp(inputtext, "Adicionar administrador", true)){ // Adicionar
            Dialog_Show(playerid,  addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "Digite o nome de usu�rio que deseja adicionar a equipe:", "Adicionar", "<<");            
        } else {
            mysql_format(DBConn, query, sizeof query, "UPDATE users SET `admin` = '0' WHERE `username` = '%s'", inputtext);
            new Cache:result = mysql_query(DBConn, query);
            cache_delete(result);

            mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s'", inputtext);
            new Cache:result2 = mysql_query(DBConn, query);
            new userID;
            cache_get_value_name_int(0, "ID", userID);
            cache_delete(result2);
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d';", userID);
            new Cache:result3 = mysql_query(DBConn, query);

            if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_GREY, "Esse administrador n�o possu�a nenhum personagem. N�o foi poss�vel verificar a conex�o deste. [E#02]");
            new characterValue[24];
            for(new i; i < cache_num_rows(); i++) {
                cache_get_value_name(i, "name", characterValue);

                if(GetPlayerByName(characterValue) == -1){
                    SendServerMessage(playerid, "Voc� removeu %s da equipe administrativa do servidor.", inputtext);
                    cache_delete(result3);
                    return true;
                } else {
                    new userid = GetPlayerByName(characterValue);
                    uInfo[userid][uAdmin] = 0;
                    va_SendClientMessage(userid, COLOR_YELLOW,"%s removeu voc� do quadro administrativo.", pNome(playerid));
                    SendServerMessage(playerid, "Voc� removeu %s da equipe administrativa do servidor.", inputtext);
                    SaveUserInfo(userid);
                    cache_delete(result3);  
                    return true;
                }
            }
            format(logString, sizeof(logString), "%s (%s) removeu %s do quadro administrativo.", pNome(playerid), GetPlayerUserEx(playerid), inputtext);
		    logCreate(playerid, logString, 8);
        }
    } else return Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mob�lias\nItens\nInteriores\nConcession�ria\nAdministradores", "Selecionar", "Fechar");
    return true;
}

Dialog:addAdmin1(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: Voc� n�o especificou um nome.\nDigite o nome de usu�rio do administrador que deseja adicionar:", "Adicionar", "<<");

        if(strlen(inputtext) > 24) return Dialog_Show(playerid, addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: Voc� especificou um nome grande demais, o m�ximo � de 24 caracteres.\nDigite o nome de usu�rio do administrador que deseja adicionar:", "Adicionar", "<<");

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", inputtext);
        new Cache:result = mysql_query(DBConn, query);
        if(!cache_num_rows()){ 
            Dialog_Show(playerid, addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: Voc� especificou um usu�rio inexistente.\nDigite o nome de usu�rio do administrador que deseja adicionar:", "Adicionar", "<<");
            cache_delete(result);
        }

        format(pInfo[playerid][tempChar], 24, "%s", inputtext);
        
        Dialog_Show(playerid, addAdmin2, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "Digite o n�vel do cargo do administrador:", "Adicionar", "<<");
        cache_delete(result);
    } else {
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `admin` > 0");
        new Cache:result = mysql_query(DBConn, query);

        if(!cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel encontrar nenhum administrador na database. [E#01]");

        new string[1024], userValue[24], adminLevel;
        format(string, sizeof(string), "Usu�rio\tRanking\n");
        format(string, sizeof(string), "%s{BBBBBB}Adicionar administrador\n", string);
        for(new i; i < cache_num_rows(); i++){
            cache_get_value_name(i, "username", userValue);
            cache_get_value_name_int(i, "admin", adminLevel);

            format(string, sizeof(string), "%s%s\t%d\n", string, userValue, adminLevel);
        }
        cache_delete(result);

        Dialog_Show(playerid, showAdmins, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Administradores", string, "Remover", "<<");
    }
    return true;
}

Dialog:addAdmin2(playerid, response, listitem, inputtext[]){
    if(response){
        new level = strval(inputtext);
        
	    if (isnull(inputtext)) return Dialog_Show(playerid, addAdmin2, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: Voc� n�o especificou um n�vel.\nDigite o n�vel de administra��o:", "Adicionar", "<<");

        if (level > 1337) return Dialog_Show(playerid, addAdmin2, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: O level n�o pode ser maior que 1337.\nDigite o n�vel de administra��o:", "Adicionar", "<<");

        mysql_format(DBConn, query, sizeof query, "UPDATE users SET `admin` = '%d' WHERE `username` = '%s';", level, pInfo[playerid][tempChar]);
        new Cache:result = mysql_query(DBConn, query);

        new rank[32];
        switch(level) {
            case 1: format(rank, sizeof(rank), "Tester");
            case 2: format(rank, sizeof(rank), "Game Admin 1");
            case 3: format(rank, sizeof(rank), "Game Admin 2");
            case 4: format(rank, sizeof(rank), "Game Admin 3");
            case 5: format(rank, sizeof(rank), "Lead Admin");
            case 1337: format(rank, sizeof(rank), "Management");
            default: format(rank, sizeof(rank), "Inv�lido");
	    }
        cache_delete(result);

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s'", inputtext);
        new Cache:result2 = mysql_query(DBConn, query);
        new userID;
        cache_get_value_name_int(0, "ID", userID);
        cache_delete(result2);
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d';", userID);
        new Cache:result3 = mysql_query(DBConn, query);

        if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_GREY, "Esse administrador n�o possui nenhum personagem. N�o foi poss�vel verificar a conex�o deste. [E#03]");

        new characterValue[24];
        for(new i; i < cache_num_rows(); i++) {
            cache_get_value_name(i, "name", characterValue);

            if(GetPlayerByName(characterValue) == -1){
                cache_delete(result3);
                SendServerMessage(playerid, "Voc� setou %s como %s.", pInfo[playerid][tempChar], rank);
                cache_delete(result3);
                return true;
            } else {
                new userid = GetPlayerByName(characterValue);
                uInfo[userid][uAdmin] = level;
                SendServerMessage(playerid, "Voc� setou %s como %s.", pInfo[playerid][tempChar], rank);
                va_SendClientMessage(userid, COLOR_YELLOW,"%s setou voc� como %s.", pNome(playerid), rank);
                SaveUserInfo(userid);
                cache_delete(result3);  
                return true;
            }
        }
        format(logString, sizeof(logString), "%s (%s) setou %s como %s.", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][tempChar], rank);
		logCreate(playerid, logString, 8);

        pInfo[playerid][tempChar][0] = EOS;
    } else {
        Dialog_Show(playerid,  addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "Digite o nome de usu�rio que deseja adicionar a equipe:", "Adicionar", "<<");   
        pInfo[playerid][tempChar][0] = EOS;
    }
    return true;
}

ResetDealershipMenuVars(playerid) {
    pInfo[playerid][dEditingSQL] =
    pInfo[playerid][dEditingModel] =
    pInfo[playerid][dEditingPremium] =
    pInfo[playerid][dEditingCategory] =
    pInfo[playerid][dEditingPrice] =
    pInfo[playerid][dEditingMenu] = 0;
    return true;
}