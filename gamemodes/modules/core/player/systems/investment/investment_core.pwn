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

        else if(listitem == 5){ // Gerenciar investimentos
            
            return true;
        }
    }
    return true;
}

Dialog:showInfoStock(playerid, response, listitem, inputtext[]){
    if(response){
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `name` = '%s'", inputtext);
        new Cache:result = mysql_query(DBConn, query);
            
        if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx002 — Encaminhe esse erro para um desenvolvedor do servidor.");

        new string[1024], name[64], symbol[16], description[124], Float:capital, max_slots, sold_slots, Float:buy_value, Float:sell_value;

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
                {AFAFAF}Sobre\t{FFFFFF}%s\n\n{36A717}Comprar ação", 
                name, 
                symbol, 
                FormatFloat(buy_value), 
                FormatFloat(sell_value),
                FormatFloat(capital), 
                real_slots,
                description
            );

        } else {
            format(string, sizeof(string), 
                "{AFAFAF}Ação\t{FFFFFF}%s\n\
                {AFAFAF}Sigla\t{FFFFFF}%s\n\
                {AFAFAF}Preço de compra\t{FFFFFF}US$ %s\n\
                {AFAFAF}Preço de venda\t{FFFFFF}US$ %s\n\
                {AFAFAF}Cap. de mercado\t{FFFFFF}US$ %s\n\
                {AFAFAF}Ações disponíveis\t{FFFFFF}%d\n\
                {AFAFAF}Sobre\t{FFFFFF}%s\n",
                name, 
                symbol, 
                FormatFloat(buy_value), 
                FormatFloat(sell_value),
                FormatFloat(capital), 
                real_slots,
                description
            );
        }

        cache_delete(result);

        Dialog_Show(playerid, showInfoStock, DIALOG_STYLE_TABLIST, "Mercado de Ações", string, "Selecionar", "Voltar");

    } else PC_EmulateCommand(playerid, "/investimentos");
    return true;
} 