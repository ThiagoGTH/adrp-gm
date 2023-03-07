ItemsConfigMain(playerid) {
    ResetItemsMenuVars(playerid);

    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM items WHERE `ID` > 0 ORDER BY `ID` DESC");
    new Cache:result = mysql_query(DBConn, query);

    new string[2048], model_id, id, name[64];
    format(string, sizeof(string), "19132(0.0, 0.0, -80.0, 1.0)\t~g~Adicionar\n");
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name_int(i, "item_model", model_id);
        cache_get_value_name(i, "item_name", name);
        cache_get_value_name_int(i, "ID", id);

        format(string, sizeof(string), "%s%d\t~w~%s (%d)~n~~n~~n~~n~~g~EDITAR\n", string, model_id, name, id);
    }

    cache_delete(result);
    new title[128];
    format(title, 128, "Gerenciar_Itens_Dinâmicos");
    AdjustTextDrawString(title);
    AdjustTextDrawString(string);

    Dialog_Show(playerid, ItemsConfig, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
    return true;
}

Dialog:ItemsConfig(playerid, response, listitem, inputtext[]){
    if(response) {
        new title[128], string[1024];
        new model_id = strval(inputtext), name[64], desc[256], useful, sqlid, legality, category;
        if(model_id == 19132){
            Dialog_Show(playerid, ItemsAdd, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar item dinâmico", "Digite o ID do objeto a ser adicionado:", "Adicionar", "<<");
        } else {
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM `items` WHERE `item_model` = '%d'", model_id);
            new Cache:result = mysql_query(DBConn, query);

            if(!cache_num_rows()) return SendErrorMessage(playerid, "DIx001 - Ocorreu um erro, reporte a um desenvolvedor.");

            cache_get_value_name_int(0, "ID", sqlid);
            cache_get_value_name_int(0, "item_category", category);
            cache_get_value_name_int(0, "item_useful", useful);
            cache_get_value_name_int(0, "item_legality", legality);
            cache_get_value_name(0, "item_name", name);
            cache_get_value_name(0, "item_desc", desc);
            cache_delete(result);

            format(title, sizeof(title), "{FFFFFF}Gerenciar %s {AFAFAF}(SQL: %d)", name, sqlid);

            format(string, sizeof(string), 
                "{AFAFAF}Categoria\t{FFFFFF}%s\n\
                {AFAFAF}Usável\t{FFFFFF}%s\n\
                {AFAFAF}Legalizado\t{FFFFFF}%s\n\
                {AFAFAF}Nome\t{FFFFFF}%s\n\
                {AFAFAF}Descrição\t{FFFFFF}%s\n\t\n\
                {FF0000}Deletar item", ItemCategory(category), useful > 0 ? ("Sim") : ("Não"), legality > 0 ? ("Sim") : ("Não"), name, desc
            );

            pInfo[playerid][iEditingSQL] = sqlid;
            pInfo[playerid][iEditingModel] = model_id;
            pInfo[playerid][iEditingUseful] = useful;
            pInfo[playerid][iEditingLegality] = legality;
            pInfo[playerid][iEditingCategory] = category;
            format(pInfo[playerid][iEditingName], 64, "%s", name);
            format(pInfo[playerid][iEditingDesc], 256, "%s", desc);

            Dialog_Show(playerid, ItemsEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
        }
    } else ResetItemsMenuVars(playerid);
    
    return true;
}

Dialog:ItemsAdd(playerid, response, listitem, inputtext[]) {
    if(response) {
        if (isnull(inputtext)) return Dialog_Show(playerid, ItemsAdd, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar item dinâmico", "Você não especificou nenhum modelo.\nDigite o ID de objeto do item a ser criado:", "Próximo", "<<");
        pInfo[playerid][iEditingModel] = strval(inputtext);
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM `items` WHERE `item_model` = '%d';", pInfo[playerid][iEditingModel]);
        
        new Cache:result = mysql_query(DBConn, query);
        if(cache_num_rows()) return SendErrorMessage(playerid, "Já existe um item com este objeto."), cache_delete(result);

        ItemCreate(pInfo[playerid][iEditingModel]);
    } else { return ItemsConfigMain(playerid); }
    return true;
}

ItemsAdd1(playerid, model, price){
    new id = ItemCreate(model);
    if(id == -1) return SendErrorMessage(playerid, "O servidor atingiu o limite de itens dinâmicos. O item não foi criado."), ItemsConfigMain(playerid);

    SendServerMessage(playerid, "Você adicionou o objeto %d como item dinâmico. Agora edite-o no painel.", model);
    format(logString, sizeof(logString), "%s (%s) criou um item dinâmico com o objeto %d.", pNome(playerid), GetPlayerUserEx(playerid), model);
    logCreate(playerid, logString, 1);

    ItemsConfigMain(playerid);
    pInfo[playerid][iEditingModel] = 0;
    return true;
} 

Dialog:ItemsEdit(playerid, response, listitem, inputtext[]){
    if(response) {
        new string[512], title[128];
        format(title, sizeof(title), "{FFFFFF}Gerenciar %s {AFAFAF}(SQL: %d)", pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL]);
        switch(listitem) {
            case 0: {
                switch(pInfo[playerid][iEditingCategory]){
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                    case 1: format(string, sizeof(string), "Inválido\n{BBBBBB}>>> {FFFFFF}Itens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                    case 2: format(string, sizeof(string), "Inválido\nItens gerais\n{BBBBBB}>>> {FFFFFF}Itens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                    case 3: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\n{BBBBBB}>>> {FFFFFF}Itens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                    case 4: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\n{BBBBBB}>>> {FFFFFF}Itens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                    case 5: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\n{BBBBBB}>>> {FFFFFF}Itens de facções\nColetes\nDrogas\nArmas");
                    case 6: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\n{BBBBBB}>>> {FFFFFF}Coletes\nDrogas\nArmas");
                    case 7: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\n{BBBBBB}>>> {FFFFFF}Drogas\nArmas");
                    case 8: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\n{BBBBBB}>>> {FFFFFF}Armas");
                }
                pInfo[playerid][iEditingMenu] = 1;
                Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 1: {
                switch(pInfo[playerid][iEditingUseful]){
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Não utilizável\nUtilizável");
                    case 1: format(string, sizeof(string), "Não utilizável\n{BBBBBB}>>> {FFFFFF}Utilizável");
                }
                pInfo[playerid][iEditingMenu] = 2;
                Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 2: {
                switch(pInfo[playerid][iEditingLegality]){
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Ilegal\nLegal");
                    case 1: format(string, sizeof(string), "Ilegal\n{BBBBBB}>>> {FFFFFF}Legal");
                }
                pInfo[playerid][iEditingMenu] = 3;
                Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 3: {
                pInfo[playerid][iEditingMenu] = 4;
                format(string, sizeof(string), "Digite o novo nome do item:\n\nNome atual:\n%s", pInfo[playerid][iEditingName]);
                Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_INPUT, title, string, "Editar", "<<");
            }
            case 4: {
                pInfo[playerid][iEditingMenu] = 5;
                format(string, sizeof(string), "Digite a nova descrição do item:\n\nDescrição atual:\n%s", pInfo[playerid][iEditingDesc]);
                Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_INPUT, title, string, "Editar", "<<");
            }
            case 6: {
                mysql_format(DBConn, query, sizeof query, "DELETE FROM `items` WHERE `ID` = '%d';", pInfo[playerid][iEditingSQL]);
                new Cache:result = mysql_query(DBConn, query);

                SendServerMessage(playerid, "Você deletou o item dinâmico %s (SQL: %d) do servidor. Essa ação é irreversível.", pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL]);
                cache_delete(result);

                format(logString, sizeof(logString), "%s (%s) deletou o item dinâmico %s (SQL: %d) do servidor", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL]);
	            logCreate(playerid, logString, 1);
                ItemsConfigMain(playerid);
            }
        }
    } else ItemsConfigMain(playerid);
    return true;
}

Dialog:ItemsEditOptions(playerid, response, listitem, inputtext[]) {
    new string[1024], title[128], Cache:result;
    format(title, sizeof(title), "{FFFFFF}Gerenciar %s {AFAFAF}(SQL: %d)", pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL]);
    if(response) {
        if(pInfo[playerid][iEditingMenu] == 1) {
            switch(listitem) {
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                case 1: format(string, sizeof(string), "Inválido\n{BBBBBB}>>> {FFFFFF}Itens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                case 2: format(string, sizeof(string), "Inválido\nItens gerais\n{BBBBBB}>>> {FFFFFF}Itens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                case 3: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\n{BBBBBB}>>> {FFFFFF}Itens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                case 4: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\n{BBBBBB}>>> {FFFFFF}Itens de evento\nItens de facções\nColetes\nDrogas\nArmas");
                case 5: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\n{BBBBBB}>>> {FFFFFF}Itens de facções\nColetes\nDrogas\nArmas");
                case 6: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\n{BBBBBB}>>> {FFFFFF}Coletes\nDrogas\nArmas");
                case 7: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\n{BBBBBB}>>> {FFFFFF}Drogas\nArmas");
                case 8: format(string, sizeof(string), "Inválido\nItens gerais\nItens comestíveis\nItens bebíveis\nItens de evento\nItens de facções\nColetes\nDrogas\n{BBBBBB}>>> {FFFFFF}Armas");
            }
            mysql_format(DBConn, query, sizeof query, "UPDATE `items` SET `item_category` = '%d' WHERE `ID` = '%d';", listitem, pInfo[playerid][iEditingSQL]);
            result = mysql_query(DBConn, query);

            for(new i = 0; i < MAX_DYNAMIC_ITEMS; i++){
                if(diInfo[i][diID] == pInfo[playerid][iEditingSQL]){
                    diInfo[i][diCategory] = listitem;
                }
            }

            SendServerMessage(playerid, "Você alterou a categoria do item %s de %s para %s.", pInfo[playerid][iEditingName], ItemCategory(pInfo[playerid][iEditingCategory]), ItemCategory(listitem));

            format(logString, sizeof(logString), "%s (%s) alterou a categoria do item %s (%d) de %s para %s", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL], ItemCategory(pInfo[playerid][iEditingCategory]), ItemCategory(listitem));
	        logCreate(playerid, logString, 1);

            pInfo[playerid][iEditingCategory] = listitem;
            Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            cache_delete(result);
        }
        else if(pInfo[playerid][iEditingMenu] == 2) {
            switch(listitem) {
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Não utilizável\nUtilizável");
                case 1: format(string, sizeof(string), "Não utilizável\n{BBBBBB}>>> {FFFFFF}Utilizável");
            }
            mysql_format(DBConn, query, sizeof query, "UPDATE `items` SET `item_useful` = '%d' WHERE `ID` = '%d';", listitem, pInfo[playerid][iEditingSQL]);
            result = mysql_query(DBConn, query);

            for(new i = 0; i < MAX_DYNAMIC_ITEMS; i++){
                if(diInfo[i][diID] == pInfo[playerid][iEditingSQL]){
                    switch(listitem){
                        case 0: diInfo[i][diUseful] = false;
                        case 1: diInfo[i][diUseful] = true;
                    }
                }
            }

            SendServerMessage(playerid, "Você definiu o item %s como %s.", pInfo[playerid][iEditingName], listitem > 0 ? ("utilizável") : ("inutilizável"));

            format(logString, sizeof(logString), "%s (%s) alterou a categoria do item %s (%d) como %s", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL], listitem > 0 ? ("utilizável") : ("inutilizável"));
	        logCreate(playerid, logString, 1);

            pInfo[playerid][iEditingCategory] = listitem;
            Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            cache_delete(result);
        }
        else if(pInfo[playerid][iEditingMenu] == 3) {
            switch(listitem){
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Ilegal\nLegal");
                case 1: format(string, sizeof(string), "Ilegal\n{BBBBBB}>>> {FFFFFF}Legal");
            }
            mysql_format(DBConn, query, sizeof query, "UPDATE `items` SET `item_legality` = '%d' WHERE `ID` = '%d';", listitem, pInfo[playerid][iEditingSQL]);
            result = mysql_query(DBConn, query);

            for(new i = 0; i < MAX_DYNAMIC_ITEMS; i++){
                if(diInfo[i][diID] == pInfo[playerid][iEditingSQL]) {
                    switch(listitem){
                        case 0: diInfo[i][diLegality] = false;
                        case 1: diInfo[i][diLegality] = true;
                    }
                }
            }

            SendServerMessage(playerid, "Você definiu o item %s como %s.", pInfo[playerid][iEditingName], listitem > 0 ? ("legal") : ("ilegal"));

            format(logString, sizeof(logString), "%s (%s) alterou a categoria do item %s (%d) como %s", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL], listitem > 0 ? ("legal") : ("ilegal"));
	        logCreate(playerid, logString, 1);

            pInfo[playerid][iEditingCategory] = listitem;
            Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            cache_delete(result);
        }
        else if(pInfo[playerid][iEditingMenu] == 4) {
            format(string, sizeof(string), "Você não especificou nenhum nome.\n\nDigite o novo nome do item:\n\nNome atual:\n%s", pInfo[playerid][iEditingName]);
            if (isnull(inputtext)) return Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_INPUT, title, string, "Alterar", "<<");

            format(string, sizeof(string), "Você não especificou um nome grande demais.\nO limite é de 64 caracteres.\n\nDigite o novo nome do item:\n\nNome atual:\n%s", pInfo[playerid][iEditingName]);
            if(strlen(inputtext) > 64) return Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_INPUT, title, string, "Alterar", "<<");

            mysql_format(DBConn, query, sizeof query, "UPDATE `items` SET `item_name` = '%s' WHERE `ID` = '%d';", inputtext, pInfo[playerid][iEditingSQL]);
            result = mysql_query(DBConn, query);

            SendServerMessage(playerid, "Você alterou o nome do item %s para %s.", pInfo[playerid][iEditingName], inputtext);

            format(logString, sizeof(logString), "%s (%s) alterou o nome do item %s (%d) de para %s", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL], inputtext);
	        logCreate(playerid, logString, 1);

            for(new i = 0; i < MAX_DYNAMIC_ITEMS; i++){
                if(diInfo[i][diID] == pInfo[playerid][iEditingSQL]){
                    format(diInfo[i][diName], 64, "%s", inputtext);
                    printf("oiii!");
                }
            }

            format(pInfo[playerid][iEditingName], 64, "%s", inputtext);
            cache_delete(result);
            
            format(string, sizeof(string), 
                "{AFAFAF}Categoria\t{FFFFFF}%s\n\
                {AFAFAF}Usável\t{FFFFFF}%s\n\
                {AFAFAF}Legalizado\t{FFFFFF}%s\n\
                {AFAFAF}Nome\t{FFFFFF}%s\n\
                {AFAFAF}Descrição\t{FFFFFF}%s\n\t\n\
                {FF0000}Deletar item", ItemCategory(pInfo[playerid][iEditingCategory]), pInfo[playerid][iEditingUseful] > 0 ? ("Sim") : ("Não"), pInfo[playerid][iEditingLegality] > 0 ? ("Sim") : ("Não"), pInfo[playerid][iEditingName], pInfo[playerid][iEditingDesc]
            );

            Dialog_Show(playerid, ItemsEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
        }
        else if(pInfo[playerid][iEditingMenu] == 5) {    
            format(string, sizeof(string), "Você não especificou nenhum texto.\n\nDigite a nova descrição do item:\n\nDescrição atual:\n%s", pInfo[playerid][iEditingDesc]);
            if (isnull(inputtext)) return Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_INPUT, title, string, "Alterar", "<<");

            format(string, sizeof(string), "Você não especificou um nome grande demais.\nO limite é de 256 caracteres.\n\nDigite a nova descrição do item:\n\nDescrição atual:\n%s", pInfo[playerid][iEditingDesc]);
            if(strlen(inputtext) > 256) return Dialog_Show(playerid, ItemsEditOptions, DIALOG_STYLE_INPUT, title, string, "Alterar", "<<");

            mysql_format(DBConn, query, sizeof query, "UPDATE `items` SET `item_desc` = '%s' WHERE `ID` = '%d';", inputtext, pInfo[playerid][iEditingSQL]);
            result = mysql_query(DBConn, query);

            for(new i = 0; i < MAX_DYNAMIC_ITEMS; i++){
                if(diInfo[i][diID] == pInfo[playerid][iEditingSQL]){
                    format(diInfo[i][diDescription], 256, "%s", inputtext);
                }
            }

            SendServerMessage(playerid, "Você alterou a descrição do item %s.", pInfo[playerid][iEditingName]);

            format(logString, sizeof(logString), "%s (%s) alterou a descrição do item %s (%d) para %s", pNome(playerid), GetPlayerUserEx(playerid), pInfo[playerid][iEditingName], pInfo[playerid][iEditingSQL], inputtext);
	        logCreate(playerid, logString, 1);

            format(pInfo[playerid][iEditingDesc], 256, "%s", inputtext);
            cache_delete(result);

            format(string, sizeof(string), 
                "{AFAFAF}Categoria\t{FFFFFF}%s\n\
                {AFAFAF}Usável\t{FFFFFF}%s\n\
                {AFAFAF}Legalizado\t{FFFFFF}%s\n\
                {AFAFAF}Nome\t{FFFFFF}%s\n\
                {AFAFAF}Descrição\t{FFFFFF}%s\n\t\n\
                {FF0000}Deletar item", ItemCategory(pInfo[playerid][iEditingCategory]), pInfo[playerid][iEditingUseful] > 0 ? ("Sim") : ("Não"), pInfo[playerid][iEditingLegality] > 0 ? ("Sim") : ("Não"), pInfo[playerid][iEditingName], pInfo[playerid][iEditingDesc]
            );

            Dialog_Show(playerid, ItemsEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
        }
    } else {
        format(string, sizeof(string), 
            "{AFAFAF}Categoria\t{FFFFFF}%s\n\
            {AFAFAF}Usável\t{FFFFFF}%s\n\
            {AFAFAF}Legalizado\t{FFFFFF}%s\n\
            {AFAFAF}Nome\t{FFFFFF}%s\n\
            {AFAFAF}Descrição\t{FFFFFF}%s\n\t\n\
            {FF0000}Deletar item", ItemCategory(pInfo[playerid][iEditingCategory]), pInfo[playerid][iEditingUseful] > 0 ? ("Sim") : ("Não"), pInfo[playerid][iEditingLegality] > 0 ? ("Sim") : ("Não"), pInfo[playerid][iEditingName], pInfo[playerid][iEditingDesc]
        );

        Dialog_Show(playerid, ItemsEdit, DIALOG_STYLE_TABLIST, title, string, "Selecionar", "<<");
    }
    return true;
}

ResetItemsMenuVars(playerid) {
    pInfo[playerid][iEditingSQL] =
    pInfo[playerid][iEditingModel] =
    pInfo[playerid][iEditingUseful] =
    pInfo[playerid][iEditingLegality] =
    pInfo[playerid][iEditingCategory] =
    pInfo[playerid][iEditingMenu] = 0;
    pInfo[playerid][iEditingDesc][0] =
    pInfo[playerid][iEditingName][0] = EOS;
    return true;
}