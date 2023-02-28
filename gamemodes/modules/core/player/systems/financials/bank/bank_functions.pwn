formatInt(intVariable, iThousandSeparator = ',', iCurrencyChar = '$') {
	static
		s_szReturn[ 32 ],
		s_szThousandSeparator[ 2 ] = { ' ', EOS },
		s_szCurrencyChar[ 2 ] = { ' ', EOS },
		s_iVariableLen,
		s_iChar,
		s_iSepPos,
		bool:s_isNegative
	;

	format( s_szReturn, sizeof( s_szReturn ), "%d", intVariable );

	if(s_szReturn[0] == '-')
		s_isNegative = true;
	else
		s_isNegative = false;

	s_iVariableLen = strlen( s_szReturn );

	if ( s_iVariableLen >= 4 && iThousandSeparator)
	{
		s_szThousandSeparator[ 0 ] = iThousandSeparator;

		s_iChar = s_iVariableLen;
		s_iSepPos = 0;

		while ( --s_iChar > _:s_isNegative )
		{
			if ( ++s_iSepPos == 3 )
			{
				strins( s_szReturn, s_szThousandSeparator, s_iChar );

				s_iSepPos = 0;
			}
		}
	}
	if(iCurrencyChar) {
		s_szCurrencyChar[ 0 ] = iCurrencyChar;
		strins( s_szReturn, s_szCurrencyChar, _:s_isNegative );
	}
	return s_szReturn;
}

IsPlayerNearBanker(playerid) {
	foreach(new i : Bankers) {
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, BankerData[i][bankerX], BankerData[i][bankerY], BankerData[i][bankerZ])) return true;
	}
	return false;
}

GetClosestATM(playerid, Float: range = 3.0) {
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : ATMs) {
	    tempdist = GetPlayerDistanceFromPoint(playerid, ATMData[i][atmX], ATMData[i][atmY], ATMData[i][atmZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist) {
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

Bank_SaveLog(playerid, type, accid, toaccid, amount) {
	if(type == TYPE_NONE) return true;

	switch(type) {
	    case TYPE_LOGIN, TYPE_PASSCHANGE: mysql_format(DBConn, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, Type=%d, Player='%e', Date=UNIX_TIMESTAMP()", accid, type, pNome(playerid));
	    case TYPE_DEPOSIT, TYPE_WITHDRAW: mysql_format(DBConn, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, Type=%d, Player='%e', Amount=%d, Date=UNIX_TIMESTAMP()", accid, type, pNome(playerid), amount);
		case TYPE_TRANSFER: mysql_format(DBConn, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, ToAccountID=%d, Type=%d, Player='%e', Amount=%d, Date=UNIX_TIMESTAMP()", accid, toaccid, type, pNome(playerid), amount);
	}

	mysql_tquery(DBConn, query);
	return true;
}

Bank_ShowMenu(playerid) {
	new string[256], using_atm = GetPVarInt(playerid, "usingATM");
	if(CurrentAccountID[playerid] == -1) {
		format(string, sizeof(string), "{%06x}Criar conta bancária\t{2ECC71}%s\nMinhas contas\t{F1C40F}%d\nAcessar conta", (using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8), (using_atm ? ("") : formatInt(ACCOUNT_PRICE)), Bank_AccountCount(playerid));
		Dialog_Show(playerid, DIALOG_BANK_MENU_NOLOGIN, DIALOG_STYLE_TABLIST, "{F1C40F}Banco: {FFFFFF}Menu", string, "Selecionar", "Fechar");
	}else{
	    new balance = Bank_GetBalance(CurrentAccountID[playerid]), menu_title[64];
		format(menu_title, sizeof(menu_title), "{F1C40F}Banco: {FFFFFF}Menu (ID: {F1C40F}%d{FFFFFF})", CurrentAccountID[playerid]);

	    format(
			string,
			sizeof(string),
			"{%06x}Criar conta bancária\t{2ECC71}%s\nMinhas contas\t{F1C40F}%d\nDepositar\t{2ECC71}%s\nSacar\t{2ECC71}%s\nTransferir\t{2ECC71}%s\n{%06x}Extrato\n{%06x}Alterar senha\n{%06x}Deletar conta\nSair",
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? ("") : formatInt(ACCOUNT_PRICE)),
			Bank_AccountCount(playerid),
			formatInt(GetPlayerMoney(playerid)),
			formatInt(balance),
			formatInt(balance),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8)
		);

		Dialog_Show(playerid, DIALOG_BANK_MENU, DIALOG_STYLE_TABLIST, menu_title, string, "Selecionar", "Fechar");
	}

	DeletePVar(playerid, "bankLoginAccount");
	DeletePVar(playerid, "bankTransferAccount");
	return true;
}

Bank_ShowLogMenu(playerid) {
	LogListType[playerid] = TYPE_NONE;
	LogListPage[playerid] = 0;
	Dialog_Show(playerid, DIALOG_BANK_LOGS, DIALOG_STYLE_LIST, "{F1C40F}Banco: {FFFFFF}Extrato", "Dinheiro depositado\nDinheiro sacado\nTransferências\nAcessos\nMudanças de senha", "Visualizar", "Voltar");
	return true;
}

Bank_AccountCount(playerid) {
	new Cache: find_accounts;
	mysql_format(DBConn, query, sizeof(query), "SELECT null FROM bank_accounts WHERE Character_ID='%d'", GetPlayerSQLID(playerid));
	find_accounts = mysql_query(DBConn, query);

	new count = cache_num_rows();
	cache_delete(find_accounts);
	return count;
}

Bank_GetBalance(accountid) {
	new Cache: get_balance;
	mysql_format(DBConn, query, sizeof(query), "SELECT Balance FROM bank_accounts WHERE ID=%d", accountid);
	get_balance = mysql_query(DBConn, query);

	new balance;
	cache_get_value_name_int(0, "Balance", balance);
	cache_delete(get_balance);
	return balance;
}

Bank_GetOwner(accountid) {
	new characterID, Cache: get_owner;

	mysql_format(DBConn, query, sizeof(query), "SELECT Character_ID FROM bank_accounts WHERE ID=%d", accountid);
	get_owner = mysql_query(DBConn, query);

	cache_get_value_name_int(0, "Character_ID", characterID);
	cache_delete(get_owner);
	printf("Character_ID: %d/accontid %d", characterID, accountid);
	return characterID;
}

Bank_ListAccounts(playerid) {
    new Cache: get_accounts;
    mysql_format(DBConn, query, sizeof(query), "SELECT ID, Balance, LastAccess, FROM_UNIXTIME(CreatedOn, '%%d/%%m/%%Y %%H:%%i:%%s') AS Created, FROM_UNIXTIME(LastAccess, '%%d/%%m/%%Y %%H:%%i:%%s') AS Last FROM bank_accounts WHERE Character_ID='%d' ORDER BY CreatedOn DESC", GetPlayerSQLID(playerid));
	get_accounts = mysql_query(DBConn, query);
    new rows = cache_num_rows();

	if(rows) {
	    new string[1024], acc_id, balance, last_access, cdate[24], ldate[24];
    	format(string, sizeof(string), "ID\tSaldo\tData de criação\tÚltimo acesso\n");
	    for(new i; i < rows; ++i) {
	        cache_get_value_name_int(i, "ID", acc_id);
	        cache_get_value_name_int(i, "Balance", balance);
	        cache_get_value_name_int(i, "LastAccess", last_access);
        	cache_get_value_name(i, "Created", cdate);
        	cache_get_value_name(i, "Last", ldate);
        	
	        format(string, sizeof(string), "%s{FFFFFF}%d\t{2ECC71}%s\t{FFFFFF}%s\t%s\n", string, acc_id, formatInt(balance), cdate, (last_access == 0) ? ("Nunca") : ldate);
	    }

		Dialog_Show(playerid, DIALOG_BANK_ACCOUNTS, DIALOG_STYLE_TABLIST_HEADERS, "{F1C40F}Banco: {FFFFFF}Minhas contas", string, "Entrar", "Sair");
	}else{
		SendErrorMessage(playerid, "Você não possui nenhuma conta bancária.");
		Bank_ShowMenu(playerid);
	}

    cache_delete(get_accounts);
	return true;
}

Bank_ShowLogs(playerid) {
	new type = LogListType[playerid], Cache: bank_logs;
	mysql_format(DBConn, query, sizeof(query), "SELECT *, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i:%%s') as ActionDate FROM bank_logs WHERE AccountID=%d && Type=%d ORDER BY Date DESC LIMIT %d, 15", CurrentAccountID[playerid], type, LogListPage[playerid] * 15);
	bank_logs = mysql_query(DBConn, query);

	new rows = cache_num_rows();
	if(rows) {
		new list[1512], title[96], name[MAX_PLAYER_NAME], date[24];
		switch(type) {
		    case TYPE_LOGIN: {
				format(list, sizeof(list), "Por\tData\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de acessos (página %d)", LogListPage[playerid] + 1);
			}

			case TYPE_DEPOSIT: {
				format(list, sizeof(list), "Por\tValor\tData\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de depósitos (página %d)", LogListPage[playerid] + 1);
			}

			case TYPE_WITHDRAW: {
				format(list, sizeof(list), "Por\tValor\tData\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de saques (página %d)", LogListPage[playerid] + 1);
			}

			case TYPE_TRANSFER: {
				format(list, sizeof(list), "Por\tDestino\tQuantidade\tData\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de transferências (página %d)", LogListPage[playerid] + 1);
			}

			case TYPE_PASSCHANGE: {
				format(list, sizeof(list), "Por\tData\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de mudanças de senha (página %d)", LogListPage[playerid] + 1);
			}
		}

		new amount, to_acc_id;
	    for(new i; i < rows; ++i) {
	        cache_get_value_name(i, "Player", name);
        	cache_get_value_name(i, "ActionDate", date);

            switch(type) {
			    case TYPE_LOGIN: {
					format(list, sizeof(list), "%s%s\t%s\n", list, name, date);
				}

				case TYPE_DEPOSIT: {
				    cache_get_value_name_int(i, "Amount", amount);
					format(list, sizeof(list), "%s%s\t{2ECC71}%s\t%s\n", list, name, formatInt(amount), date);
				}

				case TYPE_WITHDRAW: {
				    cache_get_value_name_int(i, "Amount", amount);
					format(list, sizeof(list), "%s%s\t{2ECC71}%s\t%s\n", list, name, formatInt(amount), date);
				}

				case TYPE_TRANSFER: {
				    cache_get_value_name_int(i, "ToAccountID", to_acc_id);
				    cache_get_value_name_int(i, "Amount", amount);
				    
					format(list, sizeof(list), "%s%s\t%d\t{2ECC71}%s\t%s\n", list, name, to_acc_id, formatInt(amount), date);
				}

				case TYPE_PASSCHANGE: {
					format(list, sizeof(list), "%s%s\t%s\n", list, name, date);
				}
			}
	    }

		Dialog_Show(playerid, DIALOG_BANK_LOG_PAGE, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Próximo", "Anterior");
	} else {
		SendErrorMessage(playerid, "Não foi possível encontrar mais dados.");
		Bank_ShowLogMenu(playerid);
	}

	cache_delete(bank_logs);
	return true;
}