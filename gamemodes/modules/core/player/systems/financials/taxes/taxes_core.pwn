Taxes_SaveLog(playerid, type, amount) {
	if(type == TYPE_EMPTY) return true;

    mysql_format(DBConn, query, sizeof(query), "INSERT INTO players_taxes SET character_id=%d, \
    type=%d, \
    amount=%d, \
    Date=UNIX_TIMESTAMP()", 
    GetPlayerSQLID(playerid), type, amount);

	mysql_tquery(DBConn, query);
	return true;
}

Taxes_ShowLogMenu(playerid) {
	LogListType[playerid] = TYPE_EMPTY;
	LogListPage[playerid] = 0;

    new string[256];
    if(pInfo[playerid][pTaxes] > 0) format(string, sizeof(string), "Taxas veiculares\nTaxas residenciais\nTaxas empresariais\n \n{2ECC71}Pagar taxas\t%s", formatInt(pInfo[playerid][pTaxes]));
    else format(string, sizeof(string), "Taxas veiculares\nTaxas residenciais\nTaxas empresariais");

    Dialog_Show(playerid, showTaxesLogs, DIALOG_STYLE_TABLIST, "Taxas pendentes", string, "Selecionar", "Fechar");
	return true;
}

Taxes_ShowLogs(playerid) {
	new type = LogListType[playerid], Cache: taxes_logs;
	mysql_format(DBConn, query, sizeof(query), "SELECT *, FROM_UNIXTIME(date, '%%d/%%m/%%Y %%H:%%i:%%s') as ActionDate FROM players_taxes WHERE character_id=%d && type=%d ORDER BY date DESC LIMIT %d, 15", GetPlayerSQLID(playerid), type, LogListPage[playerid] * 15);
	taxes_logs = mysql_query(DBConn, query);

	new rows = cache_num_rows();
	if(rows) {
		new list[1512], title[96], date[24], amount;
		switch(type) {
		    case TYPE_VEHICLE: {
				format(list, sizeof(list), "Data\tValor\n");
				format(title, sizeof(title), "{FFFFFF}Taxas veículares {F1C40F}(página %d)", LogListPage[playerid] + 1);
			}

			case TYPE_RESIDENTIAL: {
				format(list, sizeof(list), "Data\tValor\n");
				format(title, sizeof(title), "{FFFFFF}Taxas residenciais {F1C40F}(página %d)", LogListPage[playerid] + 1);
			}

			case TYPE_BUSINESS: {
				format(list, sizeof(list), "Data\tValor\n");
				format(title, sizeof(title), "{FFFFFF}Taxas empresariais {F1C40F}(página %d)", LogListPage[playerid] + 1);
			}
		}

	    for(new i; i < rows; ++i) {
            cache_get_value_name_int(i, "amount", amount);
			cache_get_value_name(i, "ActionDate", date);
            switch(type) {
			    case TYPE_VEHICLE: {
					format(list, sizeof(list), "%s%s\t%s\n", list, date, formatInt(amount));
				}

				case TYPE_RESIDENTIAL: {
				    format(list, sizeof(list), "%s%s\t%s\n", list, date, formatInt(amount));
				}

				case TYPE_BUSINESS: {
				    format(list, sizeof(list), "%s%s\t%s\n", list, date, formatInt(amount));
				}
			}
	    }

        Dialog_Show(playerid, showTaxesLogs, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Próximo", "Anterior");

	} else {
		SendErrorMessage(playerid, "Não foi possível encontrar mais informações.");
		Taxes_ShowLogMenu(playerid);
	}

	cache_delete(taxes_logs);
	return true;
}

Dialog:showTaxesLogs(playerid, response, listitem, inputtext[]) {
    if(response){
        if(!strcmp(inputtext, "Pagar taxas", true)) {
            new string[512];
            format(string, sizeof(string), "{FFFFFF}Você possui {2ECC71}%s{FFFFFF} em taxas pendentes.\nDeseja pagá-las agora?", formatInt(pInfo[playerid][pTaxes]));

            Dialog_Show(playerid, payTaxes, DIALOG_STYLE_MSGBOX, "{FFFFFF}Pagar taxas", string, "Pagar", "Voltar");
			return true;
        } else {
            new typelist[4] = {TYPE_EMPTY, TYPE_VEHICLE, TYPE_RESIDENTIAL, TYPE_BUSINESS};
            LogListType[playerid] = typelist[listitem + 1];
            LogListPage[playerid] = 0;
            Taxes_ShowLogs(playerid);
        }
    }
    return true;
}

Dialog:showTaxesLogPage(playerid, response, listitem, inputtext[]) {
	if(LogListType[playerid] == TYPE_EMPTY) return true;
	if(!response) {
		LogListPage[playerid]--;
        if(LogListPage[playerid] < 0) return Taxes_ShowLogMenu(playerid);
    } else LogListPage[playerid]++;
	
	Taxes_ShowLogs(playerid);
	return true;
}

Dialog:payTaxes(playerid, response, listitem, inputtext[]) {
	if(response) {
		if(GetMoney(playerid) < pInfo[playerid][pTaxes]) return SendErrorMessage(playerid, "Você não possui dinheiro em mãos o suficiente para pagar suas taxas.");

		mysql_format(DBConn, query, sizeof(query), "DELETE FROM players_taxes WHERE character_id=%d", GetPlayerSQLID(playerid));
        mysql_tquery(DBConn, query, "OnTaxesPay", "i", playerid);
    } else {
        SendServerMessage(playerid, "Você não pagou suas taxas.");
    }

	return true;
}

forward OnTaxesPay(playerid);
public OnTaxesPay(playerid) {
    if(cache_affected_rows() > 0) {
		SendServerMessage(playerid, "Suas taxas foram pagas.");
        GiveMoney(playerid, -pInfo[playerid][pTaxes]);
		pInfo[playerid][pTaxes] = 0;
	} else {
		SendErrorMessage(playerid, "Suas taxas não foram pagas — Algum erro ocorreu.");
	}

	return true;
}