/*

Este módulo é dedicado ao /gerenciar, que será integrado ao MySQL e poderá adicionar tudo dinamicamente.
 
*/

#include <YSI_Coding\y_hooks>

CMD:gerenciar(playerid, params[]){
    
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    if(GetPlayerAdmin(playerid) > 5) Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nInteriores\nConcessionária\nAdministradores", "Selecionar", "Fechar");
    else Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nInteriores\nConcessionária", "Selecionar", "Fechar");
    return true;
}

Dialog:configSys(playerid, response, listitem, inputtext[]){
    if(response){
        if(listitem == 0){ // MOBÍLIAS [OK]
            if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid); 

            mysql_format(DBConn, query, sizeof query, "SELECT * FROM furniture_info WHERE `ID` >= 0");
            new Cache:result = mysql_query(DBConn, query);

            new string[1024], furName[64], furModel, furCategory[64];
            format(string, sizeof(string), "Mobília\tID do Objeto\tCategoria\n");
            format(string, sizeof(string), "%s{BBBBBB}Adicionar mobília\n", string);
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name(i, "name", furName);
                cache_get_value_name_int(i, "model", furModel);
                cache_get_value_name(i, "category", furCategory);

                format(string, sizeof(string), "%s%s\t%d\t%s\n", string, furName, furModel, furCategory);
            }
            cache_delete(result);

            Dialog_Show(playerid, showInfoFurniture, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Mobílias", string, "Selecionar", "<<");
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

        else if(listitem == 3){ // Concessionária
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
            format(title, 128, "Gerenciar_Concessionária");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipConfig, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }

        else if(listitem == 4){ // ADMINISTRADORES [OK]
            if(GetPlayerAdmin(playerid) < 1335) return SendPermissionMessage(playerid);

            mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `admin` > 0 ORDER BY `admin` ASC");
            new Cache:result = mysql_query(DBConn, query);

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Não foi possível encontrar nenhum administrador na database. [E#01]");

            new string[1024], userValue[24], adminLevel;
            format(string, sizeof(string), "Usuário\tRanking\n");
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
        if(!strcmp(inputtext, "Adicionar mobília", true)){ // Adicionar
            Dialog_Show(playerid, addInfoFurniture1, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "Digite o nome da mobília que deseja criar no servidor:\nOBSERVAÇÃO: Esse será o nome que aparecerá para o usuário na lista de mobílias do servidor.", "Adicionar", "<<");
        } else { // Remover
            format(pInfo[playerid][tempChar], 64, "%s", inputtext);
            format(string, 256, "Você realmente deseja deletar a mobília %s? Essa ação é irreversível.", inputtext);

            Dialog_Show(playerid, confirmInfoFur, DIALOG_STYLE_MSGBOX, "Gerenciar > Mobílias > Deletar mobília > Confirmar", string, "Deletar", "Cancelar");
        }
    } else { // Voltar
        if(GetPlayerAdmin(playerid) > 5) Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nInteriores\nConcessionária\nAdministradores", "Selecionar", "Fechar");
        else Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nInteriores\nConcessionária", "Selecionar", "Fechar");
    }
    return true;
}

Dialog:confirmInfoFur(playerid, response, listitem, inputtext[]){
    if(response){ // Confirmar
        mysql_format(DBConn, query, sizeof query, "DELETE FROM furniture_info WHERE `name` = '%s';", pInfo[playerid][tempChar]);
        new Cache:result = mysql_query(DBConn, query);

        SendServerMessage(playerid, "Você deletou a mobília %s com sucesso. A ação é irreversível.", pInfo[playerid][tempChar]);
        
        format(logString, sizeof(logString), "%s (%s) deletou a mobília %s.", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][tempChar]);
		logCreate(playerid, logString, 8);

        pInfo[playerid][tempChar][0] = EOS;
        cache_delete(result);
    } else { // Cancelar
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
        pInfo[playerid][tempChar][0] = EOS;

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM furniture_info WHERE `ID` >= 0");
        new Cache:result = mysql_query(DBConn, query);

        new string[1024], furName[64], furModel, furCategory[64];
        format(string, sizeof(string), "Mobília\tID do Objeto\nCategoria\n");
        format(string, sizeof(string), "%s{BBBBBB}Adicionar mobília\n", string);
        for(new i; i < cache_num_rows(); i++){
            cache_get_value_name(i, "name", furName);
            cache_get_value_name_int(i, "model", furModel);
            cache_get_value_name(i, "category", furCategory);

            format(string, sizeof(string), "%s%s\t%d\t%s\n", string, furName, furModel, furCategory);
        }
        cache_delete(result);

        Dialog_Show(playerid, showInfoFurniture, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Mobílias", string, "Selecionar", "<<");
    }
    return true;
}

Dialog:addInfoFurniture1(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, addInfoFurniture1, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "ERRO: Você não especificou um nome.\nDigite o nome da mobília que deseja criar no servidor:", "Adicionar", "<<");

        if(strlen(inputtext) > 64) return Dialog_Show(playerid, addInfoFurniture1, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "ERRO: Você especificou um nome grande demais, o máximo é de 64 caracteres.\nDigite o nome da mobília que deseja criar no servidor:", "Adicionar", "<<");

        format(pInfo[playerid][tempChar], 64, "%s", inputtext);
        
        Dialog_Show(playerid, addInfoFurniture2, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "Digite o nome da categoria para a mobília criada:", "Adicionar", "<<");

    } else {
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
        pInfo[playerid][tempChar][0] = EOS;
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM furniture_info WHERE `ID` >= 0");
        new Cache:result = mysql_query(DBConn, query);

        new string[1024], furName[64], furModel, furCategory[64];
        format(string, sizeof(string), "Mobília\tID do Objeto\nCategoria\n");
        format(string, sizeof(string), "%s{BBBBBB}Adicionar mobília\n", string);
        for(new i; i < cache_num_rows(); i++){
            cache_get_value_name(i, "name", furName);
            cache_get_value_name_int(i, "model", furModel);
            cache_get_value_name(i, "category", furCategory);

            format(string, sizeof(string), "%s%s\t%d\t%s\n", string, furName, furModel, furCategory);
        }
        cache_delete(result);

        Dialog_Show(playerid, showInfoFurniture, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar > Mobílias", string, "Selecionar", "<<");
    }
    return true;
}

Dialog:addInfoFurniture2(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, addInfoFurniture2, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "ERRO: Você não especificou um nome de categoria correto.\nDigite o nome da categoria em que a mobília deverá ser criada:", "Adicionar", "<<");

        if(strlen(inputtext) > 64) return Dialog_Show(playerid, addInfoFurniture2, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "ERRO: Você especificou um nome grande demais, o máximo é de 64 caracteres.\nDigite o nome da categoria que deseja colocar a mobília:", "Adicionar", "<<");

        format(pInfo[playerid][tempChar2], 64, "%s", inputtext);
        
        Dialog_Show(playerid, addInfoFurniture3, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "Digite o ID de um objeto para ser a mobília:\nOBSERVAÇÃO: Você pode achar o ID dos objetos nativos do SA-MP em: www.dev.prineside.com\n\nPor favor, digite o ID do objeto que deseja adicionar:", "Adicionar", "<<");

    } else {
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
        pInfo[playerid][tempChar][0] = 
        pInfo[playerid][tempChar2][0] = EOS;

        Dialog_Show(playerid, addInfoFurniture1, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "Digite o nome da mobília que deseja criar no servidor:\nOBSERVAÇÃO: Esse será o nome que aparecerá para o usuário na lista de mobílias do servidor.", "Adicionar", "<<");
    }
    return true;
}

Dialog:addInfoFurniture3(playerid, response, listitem, inputtext[]){
    if(response){
        new modelid = strval(inputtext);
        
	    if (isnull(inputtext)) return Dialog_Show(playerid, addInfoFurniture3, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "ERRO: Você não especificou um ID.\nDigite o ID de um objeto para ser a mobília:", "Adicionar", "<<");

        if (modelid > 19999) return Dialog_Show(playerid, addInfoFurniture3, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "ERRO: O ID não pode ser maior que 19999.\nVocê pode achar o ID dos objetos em: www.dev.prineside.com\nDigite o ID de um objeto para ser a mobília:", "Adicionar", "<<");

        mysql_format(DBConn, query, sizeof query, "INSERT INTO furniture_info (`name`, `model`, `category`) VALUES ('%s', '%d', '%s');", pInfo[playerid][tempChar], modelid, pInfo[playerid][tempChar2]);
        new Cache:result = mysql_query(DBConn, query);

        format(logString, sizeof(logString), "%s (%s) criou a mobília %s (%d) com a categoria %s.", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][tempChar], modelid, pInfo[playerid][tempChar2]);
		logCreate(playerid, logString, 8);
        SendServerMessage(playerid, "Você criou a mobília %s (%d) com a categoria %s com sucesso.", pInfo[playerid][tempChar], modelid, pInfo[playerid][tempChar2]);
        pInfo[playerid][tempChar][0] = 
        pInfo[playerid][tempChar2][0] = EOS;
        cache_delete(result);
    } else {
        if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
        pInfo[playerid][tempChar][0] = 
        pInfo[playerid][tempChar2][0] = EOS;

        Dialog_Show(playerid, addInfoFurniture2, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "Digite o nome da categoria para a mobília criada:", "Adicionar", "<<");
    }
    return true;
}

// INTERIORES
Dialog:showInfoInt(playerid, response, listitem, inputtext[]){
    if(response){
        new string[256];
        if(!strcmp(inputtext, "Adicionar interior", true)){ // Adicionar
            Dialog_Show(playerid, addInfoInt, DIALOG_STYLE_INPUT, "Gerenciar > Interiores > Adicionar", "Digite o nome do interior a ser criado:\nOBSERVAÇÃO: Esse será o nome que aparecerá para o usuário no '/ir interior'.\nAs coordenadas, o virtual world e o interior serão setados de acordo com a posição do seu personagem.", "Adicionar", "<<");
        } else { // Remover
            format(pInfo[playerid][tempChar], 64, "%s", inputtext);
            format(string, 256, "Você realmente deseja deletar o interior '%s'? Essa ação é irreversível.", inputtext);

            Dialog_Show(playerid, confirmInfoInt, DIALOG_STYLE_MSGBOX, "Gerenciar > Interiores > Remover", string, "Deletar", "Cancelar");
        }
    } else {  // Voltar
        if(GetPlayerAdmin(playerid) > 5) Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nInteriores\nConcessionária\nAdministradores", "Selecionar", "Fechar");
        else Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nInteriores\nConcessionária", "Selecionar", "Fechar");
    }
    return true;
} 

Dialog:addInfoInt(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, addInfoInt, DIALOG_STYLE_INPUT, "Gerenciar > Interiores > Adicionar", "ERRO: Você não especificou um nome.\nDigite o nome do interior a ser criado:", "Adicionar", "<<");

        if(strlen(inputtext) > 64) return Dialog_Show(playerid, addInfoInt, DIALOG_STYLE_INPUT, "Gerenciar > Interiores > Adicionar", "ERRO: Você especificou um nome grande demais, o máximo é de 64 caracteres.\nDigite o nome do interior a ser criado:", "Adicionar", "<<");

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

        SendServerMessage(playerid, "Você criou o interior %s de acordo com as suas coordenadas.", pInfo[playerid][tempChar]);
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

        SendServerMessage(playerid, "Você deletou o interior '%s' com sucesso. A ação é irreversível.", pInfo[playerid][tempChar]);
        
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

// CONCESSIONÁRIA
Dialog:DealershipConfig(playerid, response, listitem, inputtext[]){
    if(response) {
        new title[128], string[1024];
        new model_id = strval(inputtext), price, premium, sqlid, category;
        if(model_id == 19132){
            Dialog_Show(playerid, DealershipAdd, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar veículo à concessionária", "Digite o ID do veículo a ser adicionado:", "Adicionar", "<<");
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
                {FF0000}Deletar veículo", DealershipCategory(category), PremiumType(premium),FormatNumber(price)
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

        if (isnull(inputtext)) return Dialog_Show(playerid, DealershipAdd, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar veículo à concessionária", "Você não especificou nenhum modelo.\nDigite o ID do veículo a ser adicionado:", "Adicionar", "<<");

        if ((model[0] = GetVehicleModelByName(model)) == 0) return Dialog_Show(playerid, DealershipAdd, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar veículo à concessionária", "O modelo especificado é inválido.\nDigite o ID do veículo a ser adicionado:", "Adicionar", "<<");

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles_dealer` WHERE `model_id` = '%d';", model[0]);
        new Cache:result = mysql_query(DBConn, query);
        if(cache_num_rows()) return SendErrorMessage(playerid, "Já existe um veículo com este modelo.");
        cache_delete(result);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO `vehicles_dealer` (`model_id`, `category`, `price`) VALUES ('%d', '1', '999999999');", model[0]);
        result = mysql_query(DBConn, query);
        cache_delete(result);

        SendServerMessage(playerid, "Você adicionou o veículo %s na concessionária. Agora edite-o no painel.", ReturnVehicleModelName(model[0]));

        format(logString, sizeof(logString), "%s (%s) adicionou o veículo %s na concessionária.", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(model[0]));
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
        format(title, 128, "Gerenciar_Concessionária");
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
        format(title, 128, "Gerenciar_Concessionária");
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
                    case 1: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 2: format(string, sizeof(string), "Aviões\n{BBBBBB}>>> {FFFFFF}Barcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 3: format(string, sizeof(string), "Aviões\nBarcos\n{BBBBBB}>>> {FFFFFF}Bicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 4: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\n{BBBBBB}>>> {FFFFFF}Motos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 5: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\n{BBBBBB}>>> {FFFFFF}Sedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 6: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\n{BBBBBB}>>> {FFFFFF}SUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 7: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\n{BBBBBB}>>> {FFFFFF}Lowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 8: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\n{BBBBBB}>>> {FFFFFF}Esportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 9: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\n{BBBBBB}>>> {FFFFFF}Industriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                    case 10: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\n{BBBBBB}>>> {FFFFFF}Caminhonetes\nÚnicos\nTrailers industriais");
                    case 11: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n{BBBBBB}>>> {FFFFFF}Únicos\nTrailers industriais");
                    case 12: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\n{BBBBBB}>>> {FFFFFF}Trailers industriais");
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
                format(string, sizeof(string), "Digite o novo valor do veículo:\n\nValor anterior: US$ %s", FormatNumber(pInfo[playerid][dEditingPrice]));
                Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_INPUT, title, string, "Editar", "<<");
            }
            case 4: {
                mysql_format(DBConn, query, sizeof query, "DELETE FROM `vehicles_dealer` WHERE `ID` = '%d';", pInfo[playerid][dEditingSQL]);
                new Cache:result = mysql_query(DBConn, query);

                SendServerMessage(playerid, "Você deletou o veículo %s (SQL: %d) da concessionária com sucesso. Essa ação é irreversível.", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL]);
                cache_delete(result);

                format(logString, sizeof(logString), "%s (%s) deletou o veículo %s (SQL: %d) da concessionária", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL]);
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
        format(title, 128, "Gerenciar_Concessionária");
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
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 1: format(string, sizeof(string), "Aviões\n{BBBBBB}>>> {FFFFFF}Barcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 2: format(string, sizeof(string), "Aviões\nBarcos\n{BBBBBB}>>> {FFFFFF}Bicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 3: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\n{BBBBBB}>>> {FFFFFF}Motos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 4: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\n{BBBBBB}>>> {FFFFFF}Sedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 5: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\n{BBBBBB}>>> {FFFFFF}SUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 6: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\n{BBBBBB}>>> {FFFFFF}Lowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 7: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\n{BBBBBB}>>> {FFFFFF}Esportivos\nIndustriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 8: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\n{BBBBBB}>>> {FFFFFF}Industriais\nCaminhonetes\nÚnicos\nTrailers industriais");
                case 9: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\n{BBBBBB}>>> {FFFFFF}Caminhonetes\nÚnicos\nTrailers industriais");
                case 10: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\n{BBBBBB}>>> {FFFFFF}Únicos\nTrailers industriais");
                case 11: format(string, sizeof(string), "Aviões\nBarcos\nBicicletas\nMotos\nSedans\nSUVs & Wagons\nLowriders\nEsportivos\nIndustriais\nCaminhonetes\nÚnicos\n{BBBBBB}>>> {FFFFFF}Trailers industriais");
            }
            mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_dealer` SET `category` = '%d' WHERE `ID` = '%d';", listitem+1, pInfo[playerid][dEditingSQL]);
            mysql_query(DBConn, query);

            SendServerMessage(playerid, "Você alterou a categoria do veículo %s de %s para %s.", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), DealershipCategory(pInfo[playerid][dEditingCategory]), DealershipCategory(listitem+1));

            format(logString, sizeof(logString), "%s (%s) alterou a categoria do veículo %s (%d) de %s para %s", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL], DealershipCategory(pInfo[playerid][dEditingCategory]), DealershipCategory(listitem+1));
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

            SendServerMessage(playerid, "Você alterou o premium do veículo %s de %s para %s.", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), PremiumType(pInfo[playerid][dEditingPremium]), PremiumType(listitem));

            format(logString, sizeof(logString), "%s (%s) alterou o premium do veículo %s (%d) de %s para %s", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL], PremiumType(pInfo[playerid][dEditingPremium]), PremiumType(listitem));
	        logCreate(playerid, logString, 1);

            pInfo[playerid][dEditingPremium] = listitem;
            Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            cache_delete(result);
        }
        else if(pInfo[playerid][dEditingMenu] == 3){
            new price = strval(inputtext);
        
            format(string, sizeof(string), "Você não especificou nenhum valor.\nDigite o novo valor do veículo:\n\nValor anterior: US$ %s", FormatNumber(pInfo[playerid][dEditingPrice]));
            if (isnull(inputtext)) return Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_INPUT, title, string, "Alterar", "<<");

            format(string, sizeof(string), "O valor não pode ser igual ou menor a zero.\nDigite o novo valor do veículo:\n\nValor anterior: US$ %s", FormatNumber(pInfo[playerid][dEditingPrice]));
            if (price < 1) return Dialog_Show(playerid, DealershipEditOptions, DIALOG_STYLE_INPUT, title, string, "Alterar", "<<");

            mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles_dealer` SET `price` = '%d' WHERE `ID` = '%d';", price, pInfo[playerid][dEditingSQL]);
            mysql_query(DBConn, query);

            SendServerMessage(playerid, "Você alterou o valor do veículo %s de US$ %s para US$ %s.", ReturnVehicleModelName(pInfo[playerid][dEditingModel]), FormatNumber(pInfo[playerid][dEditingPrice]), FormatNumber(price));

            format(logString, sizeof(logString), "%s (%s) alterou o valor do veículo %s (%d) de US$ %s para US$ %s", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dEditingModel]), pInfo[playerid][dEditingSQL], FormatNumber(pInfo[playerid][dEditingPrice]), FormatNumber(price));
	        logCreate(playerid, logString, 1);

            pInfo[playerid][dEditingPrice] = price;

            cache_delete(result);
            
            format(string, sizeof(string), 
                "{AFAFAF}Categoria\t{FFFFFF}%s\n\
                {AFAFAF}Premium\t{FFFFFF}%s\n\
                {AFAFAF}Valor\t{FFFFFF}US$ %s\n\t\n{FF0000}Deletar veículo", DealershipCategory(pInfo[playerid][dEditingCategory]), PremiumType(pInfo[playerid][dEditingPremium]),FormatNumber(pInfo[playerid][dEditingPrice])
            );
            Dialog_Show(playerid, DealershipEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
        }
    } else {
        format(string, sizeof(string), 
            "{AFAFAF}Categoria\t{FFFFFF}%s\n\
            {AFAFAF}Premium\t{FFFFFF}%s\n\
            {AFAFAF}Valor\t{FFFFFF}US$ %s\n\t\n{FF0000}Deletar veículo", DealershipCategory(pInfo[playerid][dEditingCategory]), PremiumType(pInfo[playerid][dEditingPremium]),FormatNumber(pInfo[playerid][dEditingPrice])
        );

        Dialog_Show(playerid, DealershipEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
    }
    return true;
}

// ADMINS
Dialog:showAdmins(playerid, response, listitem, inputtext[]){
    if(response){
        if(!strcmp(inputtext, "Adicionar administrador", true)){ // Adicionar
            Dialog_Show(playerid,  addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "Digite o nome de usuário que deseja adicionar a equipe:", "Adicionar", "<<");            
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

            if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_GREY, "Esse administrador não possuía nenhum personagem. Não foi possível verificar a conexão deste. [E#02]");
            new characterValue[24];
            for(new i; i < cache_num_rows(); i++) {
                cache_get_value_name(i, "name", characterValue);

                if(GetPlayerByName(characterValue) == -1){
                    SendServerMessage(playerid, "Você removeu %s da equipe administrativa do servidor.", inputtext);
                    cache_delete(result3);
                    return true;
                } else {
                    new userid = GetPlayerByName(characterValue);
                    uInfo[userid][uAdmin] = 0;
                    va_SendClientMessage(userid, COLOR_YELLOW,"%s removeu você do quadro administrativo.", pNome(playerid));
                    SendServerMessage(playerid, "Você removeu %s da equipe administrativa do servidor.", inputtext);
                    SaveUserInfo(userid);
                    cache_delete(result3);  
                    return true;
                }
            }
            format(logString, sizeof(logString), "%s (%s) removeu %s do quadro administrativo.", pNome(playerid), GetPlayerUserEx(playerid), inputtext);
		    logCreate(playerid, logString, 8);
        }
    } else return Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nInteriores\nConcessionária\nAdministradores", "Selecionar", "Fechar");
    return true;
}

Dialog:addAdmin1(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: Você não especificou um nome.\nDigite o nome de usuário do administrador que deseja adicionar:", "Adicionar", "<<");

        if(strlen(inputtext) > 24) return Dialog_Show(playerid, addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: Você especificou um nome grande demais, o máximo é de 24 caracteres.\nDigite o nome de usuário do administrador que deseja adicionar:", "Adicionar", "<<");

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", inputtext);
        new Cache:result = mysql_query(DBConn, query);
        if(!cache_num_rows()){ 
            Dialog_Show(playerid, addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: Você especificou um usuário inexistente.\nDigite o nome de usuário do administrador que deseja adicionar:", "Adicionar", "<<");
            cache_delete(result);
        }

        format(pInfo[playerid][tempChar], 24, "%s", inputtext);
        
        Dialog_Show(playerid, addAdmin2, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "Digite o nível do cargo do administrador:", "Adicionar", "<<");
        cache_delete(result);
    } else {
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `admin` > 0");
        new Cache:result = mysql_query(DBConn, query);

        if(!cache_num_rows()) return SendErrorMessage(playerid, "Não foi possível encontrar nenhum administrador na database. [E#01]");

        new string[1024], userValue[24], adminLevel;
        format(string, sizeof(string), "Usuário\tRanking\n");
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
        
	    if (isnull(inputtext)) return Dialog_Show(playerid, addAdmin2, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: Você não especificou um nível.\nDigite o nível de administração:", "Adicionar", "<<");

        if (level > 1337) return Dialog_Show(playerid, addAdmin2, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "ERRO: O level não pode ser maior que 1337.\nDigite o nível de administração:", "Adicionar", "<<");

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
            default: format(rank, sizeof(rank), "Inválido");
	    }
        cache_delete(result);

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s'", inputtext);
        new Cache:result2 = mysql_query(DBConn, query);
        new userID;
        cache_get_value_name_int(0, "ID", userID);
        cache_delete(result2);
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d';", userID);
        new Cache:result3 = mysql_query(DBConn, query);

        if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_GREY, "Esse administrador não possui nenhum personagem. Não foi possível verificar a conexão deste. [E#03]");

        new characterValue[24];
        for(new i; i < cache_num_rows(); i++) {
            cache_get_value_name(i, "name", characterValue);

            if(GetPlayerByName(characterValue) == -1){
                cache_delete(result3);
                SendServerMessage(playerid, "Você setou %s como %s.", pInfo[playerid][tempChar], rank);
                cache_delete(result3);
                return true;
            } else {
                new userid = GetPlayerByName(characterValue);
                uInfo[userid][uAdmin] = level;
                SendServerMessage(playerid, "Você setou %s como %s.", pInfo[playerid][tempChar], rank);
                va_SendClientMessage(userid, COLOR_YELLOW,"%s setou você como %s.", pNome(playerid), rank);
                SaveUserInfo(userid);
                cache_delete(result3);  
                return true;
            }
        }
        format(logString, sizeof(logString), "%s (%s) setou %s como %s.", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][tempChar], rank);
		logCreate(playerid, logString, 8);

        pInfo[playerid][tempChar][0] = EOS;
    } else {
        Dialog_Show(playerid,  addAdmin1, DIALOG_STYLE_INPUT, "Gerenciar > Administradores > Adicionar", "Digite o nome de usuário que deseja adicionar a equipe:", "Adicionar", "<<");   
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