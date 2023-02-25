#include <YSI_Coding\y_hooks>

CMD:gerenciar(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    if(GetPlayerAdmin(playerid) > 5) Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nInteriores\nConcessionária\nAdministradores", "Selecionar", "Fechar");
    else Dialog_Show(playerid, configSys, DIALOG_STYLE_LIST, "Gerenciamento do Servidor", "Mobílias\nItens\nConcessionária", "Selecionar", "Fechar");
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
            ItemsConfigMain(playerid);
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
            DealershipConfigMain(playerid);
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
        
        Dialog_Show(playerid, addInfoFurniture3, DIALOG_STYLE_INPUT, "Gerenciar > Mobílias > Adicionar mobília", "Digite o ID de um objeto para ser a mobília:\nOBSERVAÇÃO: Você pode achar o ID dos objetos nativos do Open.MP em: www.dev.prineside.com\n\nPor favor, digite o ID do objeto que deseja adicionar:", "Adicionar", "<<");

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
