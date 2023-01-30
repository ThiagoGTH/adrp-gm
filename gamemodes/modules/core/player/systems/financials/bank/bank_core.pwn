formatInt(intVariable, iThousandSeparator = ',', iCurrencyChar = 'US$') {
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
	new query[256];

	switch(type) {
	    case TYPE_LOGIN, TYPE_PASSCHANGE: mysql_format(DBConn, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, Type=%d, Player='%e', Date=UNIX_TIMESTAMP()", accid, type, Player_GetName(playerid));
	    case TYPE_DEPOSIT, TYPE_WITHDRAW: mysql_format(DBConn, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, Type=%d, Player='%e', Amount=%d, Date=UNIX_TIMESTAMP()", accid, type, Player_GetName(playerid), amount);
		case TYPE_TRANSFER: mysql_format(DBConn, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, ToAccountID=%d, Type=%d, Player='%e', Amount=%d, Date=UNIX_TIMESTAMP()", accid, toaccid, type, Player_GetName(playerid), amount);
	}

	mysql_tquery(DBConn, query);
	return true;
}

Bank_ShowMenu(playerid) {
	new string[256], using_atm = GetPVarInt(playerid, "usingATM");
	if(CurrentAccountID[playerid] == -1) {
		format(string, sizeof(string), "{%06x}Criar conta bancária\t{2ECC71}%s\nMinhas contas\t{F1C40F}%d\nAcessar conta", (using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8), (using_atm ? ("") : formatInt(ACCOUNT_PRICE)), Bank_AccountCount(playerid));
		ShowPlayerDialog(playerid, DIALOG_BANK_MENU_NOLOGIN, DIALOG_STYLE_TABLIST, "{F1C40F}Banco: {FFFFFF}Menu", string, "Selecionar", "Fechar");
	}else{
	    new balance = Bank_GetBalance(CurrentAccountID[playerid]), menu_title[64];
		format(menu_title, sizeof(menu_title), "{F1C40F}Banco: {FFFFFF}Menu (CONTA ID: {F1C40F}%d{FFFFFF})", CurrentAccountID[playerid]);

	    format(
			string,
			sizeof(string),
			"{%06x}Criar conta bancária\t{2ECC71}%s\nMinhas contas\t{F1C40F}%d\nDepositar\t{2ECC71}%s\nSacar\t{2ECC71}%s\nTransferir\t{2ECC71}%s\n{%06x}Extrato\n{%06x}Mudar senha\n{%06x}Deletar conta\nSair",
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

		ShowPlayerDialog(playerid, DIALOG_BANK_MENU, DIALOG_STYLE_TABLIST, menu_title, string, "Selecionar", "Fechar");
	}

	DeletePVar(playerid, "bankLoginAccount");
	DeletePVar(playerid, "bankTransferAccount");
	return true;
}