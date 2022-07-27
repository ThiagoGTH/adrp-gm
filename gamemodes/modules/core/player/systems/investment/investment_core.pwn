#include <YSI_Coding\y_hooks>

CMD:investimentos(playerid, params[]) return Dialog_Show(playerid, tradingInit, DIALOG_STYLE_LIST, "Central de Investimentos", "Ações\nCripto\nCommodities", "Selecinar", "Fechar");

Dialog:tradingInit(playerid, response, listitem, inputtext[]){
    if(response){
        if(listitem == 0){ // Ações = 1
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `type` = 1");
            new Cache:result = mysql_query(DBConn, query);
            
            new string[1024], name[64], symbol[4], capital, slots_avaibles, Float:oldbuy_value, Float:buy_value;

            format(string, sizeof(string), "Nome\tAções disponíveis\tCapital ($)\tPreço ($)\n");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Tx001 — Encaminhe esse erro para um desenvolvedor do servidor.");

            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name(i, "name", name);
                cache_get_value_name(i, "symbol", symbol);
                cache_get_value_name_int(i, "capital", capital);
                cache_get_value_name_int(i, "slots_avaibles", slots_avaibles);
                cache_get_value_name_float(i, "oldbuy_value", oldbuy_value);
                cache_get_value_name_float(i, "buy_value", buy_value);

                
                new Float:price_change = ((oldbuy_value / buy_value) - 1.0) * 100.0;
                new green[16], red[16];
                format(green, sizeof(green), "{36A717}");
                format(red, sizeof(red), "{FF0000}");
                format(string, sizeof(string), "%s%s (%s)\t%d\tUS$ %s\t%sUS$ %s (%s%%)\n", string, name, symbol, slots_avaibles, FormatFloat(capital), price_change >= 0.0 ? green : red, FormatFloat(buy_value), FormatFloat(price_change));
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
    }
    return true;
}

CMD:criarinvestimento(playerid, params[]){
    if(GetPlayerAdmin(playerid) < 1337) return SendPermissionMessage(playerid);
	
    static
	    type,
	    name[64];

	if (sscanf(params, "ds[64]", type, name)) return SendSyntaxMessage(playerid, "/criarinvestimento [tipo] [nome]");
    if(type < 1 || type > 3) return SendErrorMessage(playerid, "O tipo deve veriar entre um e três.");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM tradings WHERE `name` = '%s';", name);
    new Cache:result = mysql_query(DBConn, query);
    if(cache_num_rows()) return SendErrorMessage(playerid, "Já existe um investimento com esse nome.");
    cache_delete(result);

	InvestmentCreate(playerid, type, name);
	return true;
}


InvestmentCreate(playerid, type, name[]){
    new string[64];
    mysql_format(DBConn, query, sizeof query, "INSERT INTO tradings (`name`, `type`) VALUES ('%s', '%d');", name, type);
    new Cache:result = mysql_query(DBConn, query);
    new insertid = cache_insert_id();

    switch(type){
        case 1: format(string, sizeof(string), "ação");
        case 2: format(string, sizeof(string), "cripto");
        case 3: format(string, sizeof(string), "commodity");
    }

    SendServerMessage(playerid, "Você criou com sucesso o investimento %s como uma %s [ID: %d].", name, string, insertid);

    format(logString, sizeof(logString), "%s (%s) criou o investimento %s [ID: %d] como uma %s.", pNome(playerid), GetPlayerUserEx(playerid), name, insertid, string);
	logCreate(playerid, logString, 15);

    cache_delete(result);
    return true;
}
