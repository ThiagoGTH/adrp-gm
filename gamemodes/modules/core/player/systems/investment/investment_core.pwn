#include <YSI_Coding\y_hooks>

/* ============================= FUNÇÕES ============================= */
InvestmentCreate(playerid, type, name[]) { // Criar um investimento
    new string[64];
    mysql_format(DBConn, query, sizeof query, "INSERT INTO tradings (`name`, `type`) VALUES ('%s', '%d');", name, type);
    new Cache:result = mysql_query(DBConn, query);
    new insertid = cache_insert_id();

    switch(type) {
        case 1: format(string, sizeof(string), "ação");
        case 2: format(string, sizeof(string), "cripto");
        case 3: format(string, sizeof(string), "commodity");
    }

    SendServerMessage(playerid, "Você criou com sucesso o investimento %s como uma %s [ID: %d].", name, string, insertid);

    format(logString, sizeof(logString), "%s (%s) criou o investimento %s [ID: %d] como uma %s.", pNome(playerid), GetPlayerUserEx(playerid), name, insertid, string);
	logCreate(playerid, logString, 1);

    cache_delete(result);
    return true;
}

InvestmentBuy(playerid, quantity) {
    mysql_format(DBConn, query, sizeof query, "UPDATE tradings SET `sold_slots` = `sold_slots` + '%d' WHERE `ID` = '%d'", quantity, pInfo[playerid][pInvestment]);
    new Cache:result = mysql_query(DBConn, query);
    cache_delete(result);

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `ID` = '%d'", pInfo[playerid][pInvestment]);
    new Cache:result2 = mysql_query(DBConn, query);
        
    if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx006 — Encaminhe esse erro para um desenvolvedor do servidor.");
            
    new trading_id, name[64], Float:bought_price;
    cache_get_value_name_int(0, "ID", trading_id);
    cache_get_value_name(0, "name", name);
    cache_get_value_name_float(0, "buy_value", bought_price);
    cache_delete(result2);

    new final_value = floatround(bought_price)*quantity;

    mysql_format(DBConn, query, sizeof query, "INSERT INTO tradings_owners (`trading_id`, `character_id`, `bought_price`, `quantity`) VALUES ('%d', '%d', '%d', '%d');", trading_id, GetPlayerSQLID(playerid), floatround(bought_price), quantity);
    new Cache:result3 = mysql_query(DBConn, query);
    GiveBankMoney(playerid, -final_value);

    SendServerMessage(playerid, "Você comprou %d ações de %s e pagou US$ %s.", quantity, name, FormatNumber(final_value));

    format(logString, sizeof(logString), "%s (%s) comprou %d investimentos de %s [ID: %d] e pagou US$ %s.", pNome(playerid), GetPlayerUserEx(playerid), quantity, name, trading_id, FormatNumber(final_value));
	logCreate(playerid, logString, 15);
    cache_delete(result3);
    pInfo[playerid][pInvestment] = 0;
    return true;
}

IsValidInvestment(id) { // Verificar se um investimento é válido
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `tradings` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return false;

    return true;
}

/* ============================= DIALOGS ============================= */
Dialog:tradingInit(playerid, response, listitem, inputtext[]){
    if(response){
        if(listitem == 0){ // Ações = 1
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `type` = 1");
            new Cache:result = mysql_query(DBConn, query);
            
            new string[2048], name[64], symbol[16], Float:capital, max_slots, sold_slots, Float:oldbuy_value, Float:buy_value;

            format(string, sizeof(string), "Nome\tAções disponíveis\tCapital ($)\tPreço ($)\n");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx001 — Encaminhe esse erro para um desenvolvedor do servidor.");

            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name(i, "name", name);
                cache_get_value_name(i, "symbol", symbol);
                cache_get_value_name_float(i, "capital", capital);
                cache_get_value_name_int(i, "max_slots", max_slots);
                cache_get_value_name_int(i, "sold_slots", sold_slots);
                cache_get_value_name_float(i, "oldbuy_value", oldbuy_value);
                cache_get_value_name_float(i, "buy_value", buy_value);

                new Float:price_change = ((oldbuy_value / buy_value) - 1.0) * 100.0;
                new result_slots = max_slots - sold_slots;
                new green[16], red[16];
                format(green, sizeof(green), "{36A717}");
                format(red, sizeof(red), "{FF0000}");
                format(string, sizeof(string), "%s%s\t%d\tUS$ %s\t%sUS$ %s (%s%%)\n", string, name, result_slots, FormatFloat(capital), price_change >= 0.0 ? green : red, FormatFloat(buy_value), FormatFloat(price_change));
            }
            cache_delete(result);

            Dialog_Show(playerid, showInfoStock, DIALOG_STYLE_TABLIST_HEADERS, "Mercado de Ações", string, "Selecionar", "Voltar");
            return true;
        }

        else if(listitem == 1){ // Cripto = 2

            return true;
        }

        else if(listitem == 2){ // Commodities = 3
            
            return true;
        }

        else if(listitem == 4){ // Gerenciar investimentos
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings_owners WHERE `character_id` = '%d';", GetPlayerSQLID(playerid));
            new Cache:result = mysql_query(DBConn, query);
            if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx007 — Encaminhe esse erro para um desenvolvedor do servidor.");

            new string[1024], name[64], symbol[16], type, sType[128], quantity, bought_price, Float:sell_value, trading_id, value[128];

            format(string, sizeof(string), "Nome\tTipo\tQuantidade\tPreço de venda\n");
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "quantity", quantity);
                cache_get_value_name_int(i, "bought_price", bought_price);
                cache_get_value_name_int(i, "trading_id", trading_id);

                mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `ID` = '%d';", trading_id);
                new Cache:result2 = mysql_query(DBConn, query);
                if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx008 — Encaminhe esse erro para um desenvolvedor do servidor.");
                
                cache_get_value_name(0, "name", name);
                cache_get_value_name(0, "symbol", symbol);
                cache_get_value_name_int(0, "type", type);
                cache_get_value_name_float(0, "sell_value", sell_value);
                cache_delete(result2);

                new Float:final_value = sell_value - bought_price;
                if (final_value <= bought_price) format(value, sizeof(value), "{36A717} %s", FormatFloat(sell_value));
                else format(value, sizeof(value), "{FF0000} US$ %s", FormatFloat(sell_value));

                switch(type) {
                    case 1: format(sType, sizeof(sType), "Ação");
                    case 2: format(sType, sizeof(sType), "Cripto");
                    case 3: format(sType, sizeof(sType), "Commodity");
                }

                format(string, sizeof(string), "%s%s (%s)\t%s\t%d\t%s\n", string, name, symbol, sType, quantity, value);
            }

            cache_delete(result);

            Dialog_Show(playerid, investManagement, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciar Investimentos", string, "Selecionar", "Voltar");
            return true;
        }
    }
    return true;
}

/* ============================= AÇÕES ============================= */
Dialog:showInfoStock(playerid, response, listitem, inputtext[]){
    if(response){
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `name` = '%s'", inputtext);
        new Cache:result = mysql_query(DBConn, query);
            
        if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx002 — Encaminhe esse erro para um desenvolvedor do servidor.");

        new string[1024], name[64], symbol[16], description[124], Float:capital, max_slots, sold_slots, Float:buy_value, Float:sell_value, SQLID;

        cache_get_value_name_int(0, "ID", SQLID);
        cache_get_value_name(0, "name", name);
        cache_get_value_name(0, "symbol", symbol);
        cache_get_value_name(0, "description", description);
        cache_get_value_name_float(0, "capital", capital);
        cache_get_value_name_int(0, "max_slots", max_slots);
        cache_get_value_name_int(0, "sold_slots", sold_slots);
        cache_get_value_name_float(0, "sell_value", sell_value);
        cache_get_value_name_float(0, "buy_value", buy_value);

        new real_slots = max_slots - sold_slots;
        if (real_slots > 0) {
            format(string, sizeof(string), 
                "{AFAFAF}Ação\t{FFFFFF}%s\n\
                {AFAFAF}Sigla\t{FFFFFF}%s\n\
                {AFAFAF}Preço de compra\t{FFFFFF}US$ %s\n\
                {AFAFAF}Preço de venda\t{FFFFFF}US$ %s\n\
                {AFAFAF}Cap. de mercado\t{FFFFFF}US$ %s\n\
                {AFAFAF}Ações disponíveis\t{FFFFFF}%d\n\
                {AFAFAF}Sobre\t{FFFFFF}%s\n\
                {AFAFAF}ID\t{FFFFFF}%d\n\t\n{36A717}Comprar ação", 
                name, 
                symbol, 
                FormatFloat(buy_value), 
                FormatFloat(sell_value),
                FormatFloat(capital), 
                real_slots,
                description,
                SQLID
            );
        } else {
            format(string, sizeof(string), 
                "{AFAFAF}Ação\t{FFFFFF}%s\n\
                {AFAFAF}Sigla\t{FFFFFF}%s\n\
                {AFAFAF}Preço de compra\t{FFFFFF}US$ %s\n\
                {AFAFAF}Preço de venda\t{FFFFFF}US$ %s\n\
                {AFAFAF}Cap. de mercado\t{FFFFFF}US$ %s\n\
                {AFAFAF}Ações disponíveis\t{FFFFFF}%d\n\
                {AFAFAF}Sobre\t{FFFFFF}%s\n\
                {AFAFAF}ID\t{FFFFFF}%d",
                name, 
                symbol, 
                FormatFloat(buy_value), 
                FormatFloat(sell_value),
                FormatFloat(capital), 
                real_slots,
                description,
                SQLID
            );
        }

        pInfo[playerid][pInvestment] = SQLID;
        cache_delete(result);

        Dialog_Show(playerid, showBuyStock, DIALOG_STYLE_TABLIST, "Mercado de Ações", string, "Selecionar", "Voltar");

    } else PC_EmulateCommand(playerid, "/investimentos");
    return true;
} 

Dialog:showBuyStock(playerid, response, listitem, inputtext[]){
    if(response){
        if(!strcmp(inputtext, "Comprar ação", true)) { // Comprar
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `ID` = '%d'", pInfo[playerid][pInvestment]);
            new Cache:result = mysql_query(DBConn, query);
        
            if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx003 — Encaminhe esse erro para um desenvolvedor do servidor.");

            new text[512], title[64], name[64], max_slots, sold_slots, Float:buy_value, trading_id;

            cache_get_value_name_int(0, "ID", trading_id);
            cache_get_value_name(0, "name", name);
            cache_get_value_name_int(0, "max_slots", max_slots);
            cache_get_value_name_int(0, "sold_slots", sold_slots);
            cache_get_value_name_float(0, "buy_value", buy_value);

            new real_slots = max_slots - sold_slots;
            cache_delete(result);

            mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings_owners WHERE `trading_id` = '%d' AND `character_id` = '%d'", trading_id, GetPlayerSQLID(playerid));
            new Cache:result2 = mysql_query(DBConn, query);
            if(cache_num_rows()) return SendErrorMessage(playerid, "Você já possui ações compradas desta empresa. Venda-as antes de comprar mais.");
            cache_delete(result2);

            format(title, sizeof(title), "Comprar ações de %s", name);
            format(text, sizeof(text), "Quantas ações você deseja comprar?\n\nValor: US$ %s\nAções disponíveis: %d", FormatFloat(buy_value), real_slots);

            Dialog_Show(playerid, buyStock, DIALOG_STYLE_INPUT, title, text, "Comprar", "Voltar");
            printf("showBuyStock");
        } else { 
            pInfo[playerid][pInvestment] = 0;
            PC_EmulateCommand(playerid, "/investimentos");
        }
        return true;
    }
    return true; 
}

Dialog:buyStock(playerid, response, listitem, inputtext[]){
    if(response){
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `ID` = '%d'", pInfo[playerid][pInvestment]);
        new Cache:result = mysql_query(DBConn, query);
        
        if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx004 — Encaminhe esse erro para um desenvolvedor do servidor.");
        
        new text[512], title[64], name[64], max_slots, sold_slots, Float:buy_value;

        cache_get_value_name(0, "name", name);
        cache_get_value_name_int(0, "max_slots", max_slots);
        cache_get_value_name_int(0, "sold_slots", sold_slots);
        cache_get_value_name_float(0, "buy_value", buy_value);

        new real_slots = max_slots - sold_slots;
        format(title, sizeof(title), "Comprar ações de %s", name);
        format(text, sizeof(text), "ERRO: Você especificou um número de ações inválido.\n\n\nQuantas ações você deseja comprar?\n\nValor: US$ %s\nAções disponíveis: %d", FormatFloat(buy_value), real_slots);
        cache_delete(result);

        if(strval(inputtext) < 0 || strval(inputtext) > real_slots) {
            return Dialog_Show(playerid, buyStock, DIALOG_STYLE_INPUT, title, 
            text, "Comprar", "Voltar");
        }
        printf("buyInvestment - Response");
        new quantity = strval(inputtext);
        new final_value = floatround(buy_value)*quantity;
        if(GetBankMoney(playerid) < final_value) return SendErrorMessage(playerid, "Você não possui US$ %s em sua conta bancária.", FormatNumber(final_value));
        InvestmentBuy(playerid, quantity);
        return true;
    } else {
        printf("buyInvestment2 - Else");
        PC_EmulateCommand(playerid, "/investimentos");
        pInfo[playerid][pInvestment] = 0;
    }
    return true;
}

/* ============================= INVESTMENT MANAGEMENT ============================= */

