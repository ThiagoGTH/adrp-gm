forward OnBankAccountCreated(playerid, pass[]);
public OnBankAccountCreated(playerid, pass[]) {
	GiveMoney(playerid, -ACCOUNT_PRICE);

	new id = cache_insert_id();

    va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Você criou sua conta com sucesso!");
    va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}O ID da sua nova conta bancária é: %d.", id);
    va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}E sua senha é: %s.", pass);

    format(logString, sizeof(logString), "%s (%s) criou uma nova conta bancária com o ID %d", pNome(playerid), GetPlayerUserEx(playerid), id);
	logCreate(playerid, logString, 26);
	return true;
}

forward OnBankAccountLogin(playerid, id);
public OnBankAccountLogin(playerid, id) {
	if(cache_num_rows() > 0) {
	    new characterID, characterName[32], Cache: get_owner, last_access, ldate[24];

        cache_get_value_name_int(0, "LastAccess", last_access);
	    cache_get_value_name(0, "Last", ldate);

        mysql_format(DBConn, query, sizeof(query), "SELECT Character_ID FROM bank_accounts WHERE ID='%d'", id);
        get_owner = mysql_query(DBConn, query);
        cache_get_value_int(0, "Character_ID", characterID);
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `ID` = '%d';", characterID);
        get_owner = mysql_query(DBConn, query);
        cache_get_value_name(0, "name", characterName);

		for (new i = 0, len = strlen(characterName); i < len; i ++){
			if(characterName[i] == '_') characterName[i] = ' ';
		}

        va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Olá, %s.", characterName);
        va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Seu último acesso a conta foi em: %s.", (last_access == 0) ? ("nunca") : ldate);

	    CurrentAccountID[playerid] = id;
	    Bank_ShowMenu(playerid);

	    mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET LastAccess=UNIX_TIMESTAMP() WHERE ID=%d", id);
	    mysql_tquery(DBConn, query);

        format(logString, sizeof(logString), "%s (%s) acessou a conta bancária de %s com ID %d", pNome(playerid), GetPlayerUserEx(playerid), characterName, id);
	    logCreate(playerid, logString, 26);

	    Bank_SaveLog(playerid, TYPE_LOGIN, id, -1, 0);
        cache_delete(get_owner);
	} else {
        SendErrorMessage(playerid, "Credenciais inválidas.");
	    Bank_ShowMenu(playerid);
	}
	return true;
}

forward OnBankAccountDeposit(playerid, amount);
public OnBankAccountDeposit(playerid, amount) {
	if(cache_affected_rows() > 0) {
        va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Você depositou %s na conta ID %d.", formatInt(amount), CurrentAccountID[playerid]);

        format(logString, sizeof(logString), "%s (%s) depositou %s na conta bancária %d", pNome(playerid), GetPlayerUserEx(playerid), formatInt(amount), CurrentAccountID[playerid]);
	    logCreate(playerid, logString, 26);

	    GiveMoney(playerid, -amount);
	    Bank_SaveLog(playerid, TYPE_DEPOSIT, CurrentAccountID[playerid], -1, amount);
	} else SendErrorMessage(playerid, "A sua transação bancária falhou.");
	
	Bank_ShowMenu(playerid);
	return true;
}

forward OnBankAccountWithdraw(playerid, amount);
public OnBankAccountWithdraw(playerid, amount) {
	if(cache_affected_rows() > 0) {
	    va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Você sacou %s da conta ID %d.", formatInt(amount), CurrentAccountID[playerid]);

        format(logString, sizeof(logString), "%s (%s) sacou %s da conta bancária %d", pNome(playerid), GetPlayerUserEx(playerid), formatInt(amount), CurrentAccountID[playerid]);
	    logCreate(playerid, logString, 26);

	    GiveMoney(playerid, amount);
	    Bank_SaveLog(playerid, TYPE_WITHDRAW, CurrentAccountID[playerid], -1, amount);
	}else SendErrorMessage(playerid, "A sua transação bancária falhou.");
	

    Bank_ShowMenu(playerid);
	return true;
}

forward OnBankAccountTransfer(playerid, id, amount);
public OnBankAccountTransfer(playerid, id, amount) {
	if(cache_affected_rows() > 0) {
		mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance-%d WHERE ID=%d", amount, CurrentAccountID[playerid]);
		mysql_tquery(DBConn, query, "OnBankAccountTransferDone", "iii", playerid, id, amount);
	} else {
	    SendErrorMessage(playerid, "A sua transação bancária falhou.");
	    Bank_ShowMenu(playerid);
	}

	return true;
}

forward OnBankAccountTransferDone(playerid, id, amount);
public OnBankAccountTransferDone(playerid, id, amount) {
	if(cache_affected_rows() > 0) {
        va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Você transferiu %s da conta ID %d para a conta ID %d.", formatInt(amount), CurrentAccountID[playerid], id);

        format(logString, sizeof(logString), "%s (%s) transferiu %s da conta bancária %d para %d", pNome(playerid), GetPlayerUserEx(playerid), formatInt(amount), CurrentAccountID[playerid], id);
	    logCreate(playerid, logString, 26);

		Bank_SaveLog(playerid, TYPE_TRANSFER, CurrentAccountID[playerid], id, amount);
	} else SendErrorMessage(playerid, "A sua transação bancária falhou.");
	
    Bank_ShowMenu(playerid);
	return true;
}

forward OnBankAccountPassChange(playerid, newpass[]);
public OnBankAccountPassChange(playerid, newpass[]) {
	if(cache_affected_rows() > 0) {
	    va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Você alterou a senha da conta para %s.", newpass);

        format(logString, sizeof(logString), "%s (%s) alterou a senha da conta bancária %d ", pNome(playerid), GetPlayerUserEx(playerid), CurrentAccountID[playerid]);
	    logCreate(playerid, logString, 26);
        Bank_SaveLog(playerid, TYPE_PASSCHANGE, CurrentAccountID[playerid], -1, 0);
	} else SendErrorMessage(playerid, "A sua alteração de senha falhou.");

    Bank_ShowMenu(playerid);
	return true;
}

forward OnBankAccountDeleted(playerid, id, amount);
public OnBankAccountDeleted(playerid, id, amount) {
    if(cache_affected_rows() > 0) {
        GiveMoney(playerid, amount);

        foreach(new i : Player) {
            if(i == playerid) continue;
            if(CurrentAccountID[i] == id) CurrentAccountID[i] = -1;
        }

        if(amount > 0) {
            va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Você cancelou sua conta bancária de ID %d e recebeu %s que tinha nela.", id, formatInt(amount));

            format(logString, sizeof(logString), "%s (%s) cancelou a conta bancária de ID %d e recebeu %s restante na conta", pNome(playerid), GetPlayerUserEx(playerid), id, formatInt(amount));
	        logCreate(playerid, logString, 26);
        } else {
            va_SendClientMessage(playerid, COLOR_YELLOW, "BANCO: {FFFFFF}Você cancelou sua conta bancária de ID %d.", id);

            format(logString, sizeof(logString), "%s (%s) cancelou a conta bancária de ID %d", pNome(playerid), GetPlayerUserEx(playerid), id);
	        logCreate(playerid, logString, 26);
        }
	} else SendErrorMessage(playerid, "O cancelamento da sua conta falhou.");	

	CurrentAccountID[playerid] = -1;
    Bank_ShowMenu(playerid);
	return true;
}

forward OnBankAccountAdminEdit(playerid);
public OnBankAccountAdminEdit(playerid) {
    if(cache_affected_rows() > 0) SendServerMessage(playerid, "Conta bancária editada com sucesso.");
    else SendServerMessage(playerid, "Conta bancária não foi editada, um erro ocorreu.");
	return true;
}