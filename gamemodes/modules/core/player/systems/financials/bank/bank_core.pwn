#include <YSI_Coding\y_hooks>

hook OnGameModeInit(){

    for(new i; i < MAX_BANKERS; i++) {
        BankerData[i][bankerActorID] = -1;

        #if defined BANKER_USE_MAPICON
        BankerData[i][bankerIconID] = -1;
        #endif

        BankerData[i][bankerLabel] = Text3D: -1;
    }

    for(new i; i < MAX_ATMS; i++) {
        ATMData[i][atmObjID] = -1;

        ATMData[i][atmLabel] = Text3D: -1;
    }

    mysql_tquery(DBConn, "SELECT * FROM bankers", "LoadBankers");
	mysql_tquery(DBConn, "SELECT * FROM bank_atms", "LoadATMs");
    return true;
}

hook OnFilterScriptExit() {
	foreach(new i : Bankers) {
	    if(IsValidActor(BankerData[i][bankerActorID])) DestroyActor(BankerData[i][bankerActorID]);
	}
	return true;
}

hook OnPlayerConnect(playerid) {
	CurrentAccountID[playerid] = -1;
	LogListType[playerid] = TYPE_NONE;
	LogListPage[playerid] = 0;

	EditingATMID[playerid] = -1;
	return true;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
	    case DIALOG_BANK_MENU_NOLOGIN: {
	        if(!response) return true;
	        if(listitem == 0)  {
	            if(GetPVarInt(playerid, "usingATM")) {
                    SendErrorMessage(playerid, "Voc� n�o pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}

	            if(ACCOUNT_PRICE > GetMoney(playerid)) {
                    SendErrorMessage(playerid, "Voc� n�o possui dinheiro o suficiente para criar uma conta banc�ria.");
	                return Bank_ShowMenu(playerid);
	            }

				#if defined ACCOUNT_CLIMIT
				if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT) {
                    SendErrorMessage(playerid, "Voc� n�o pode criar mais contas banc�rias.");
	                return Bank_ShowMenu(playerid);
	            }
				#endif

				ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar contra", "Escolha uma senha para a sua nova conta banc�ria:", "Criar", "<<<");
	        }

	        if(listitem == 1) Bank_ListAccounts(playerid);
	        if(listitem == 2) ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_ID, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Entrar", "ID da conta:", "Continuar", "Cancelar");
	        return true;
	    }
     	case DIALOG_BANK_MENU: {
		    if(!response) return true;
		    if(listitem == 0) {
	            if(GetPVarInt(playerid, "usingATM")) {
				    SendErrorMessage(playerid, "Voc� n�o pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}

	            if(ACCOUNT_PRICE > GetMoney(playerid)) {
	                SendErrorMessage(playerid, "Voc� n�o possui dinheiro o suficiente para criar uma conta banc�ria.");
	                return Bank_ShowMenu(playerid);
	            }

				#if defined ACCOUNT_CLIMIT
				if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT) {
	                SendErrorMessage(playerid, "Voc� n�o pode criar mais contas banc�rias.");
	                return Bank_ShowMenu(playerid);
	            }
				#endif

				ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta banc�ria", "Escolha uma senha para a sua nova conta banc�ria:", "Criar", "<<<");
	        }

	        if(listitem == 1) Bank_ListAccounts(playerid);
	        if(listitem == 2) ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "Digite o valor que voc� deseja depositar:", "Depositar", "<<<");
            if(listitem == 3) ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "Digite o valor que voc� deseja sacar:", "Sacar", "<<<");
			if(listitem == 4) ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "Especifique o ID de uma conta banc�ria:", "Avan�ar", "<<<");
            if(listitem == 5) {
			    if(GetPVarInt(playerid, "usingATM")) {
				    SendErrorMessage(playerid, "Voc� n�o pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}
				Bank_ShowLogMenu(playerid);
			}

			if(listitem == 6) {
			    if(GetPVarInt(playerid, "usingATM")) {
				    SendErrorMessage(playerid, "Voc� n�o pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}

				if(strcmp(Bank_GetOwner(CurrentAccountID[playerid]), pNome(playerid))) {
                    SendErrorMessage(playerid, "Apenas o titular da conta pode realizar essa a��o.");
				    return Bank_ShowMenu(playerid);
				}

				ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Alterar senha", "Digite a nova senha:", "Alterar", "<<<");
			}

			if(listitem == 7) {
			    if(GetPVarInt(playerid, "usingATM")) {
				    SendErrorMessage(playerid, "Voc� n�o pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}

			    if(strcmp(Bank_GetOwner(CurrentAccountID[playerid]), pNome(playerid))) {
				    SendErrorMessage(playerid, "Apenas o titular da conta pode realizar essa a��o.");
				    return Bank_ShowMenu(playerid);
				}

				ShowPlayerDialog(playerid, DIALOG_BANK_REMOVE, DIALOG_STYLE_MSGBOX, "{F1C40F}Banco: {FFFFFF}Deletar conta", "{FFFFFF}Voc� tem certeza disso?\nEsta conta ser� deletada {E74C3C}permanentemente{FFFFFF}.", "Confirmar", "<<<");
			}

			if(listitem == 8) {
                SendServerMessage(playerid, "Voc� saiu de sua conta banc�ria.");

			    CurrentAccountID[playerid] = -1;
			    Bank_ShowMenu(playerid);
			}
		}
	    case DIALOG_BANK_CREATE_ACCOUNT: {
	        if(!response) return Bank_ShowMenu(playerid);
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta banc�ria", "{E74C3C}Voc� n�o pode deixar a senha em branco.\n\n{FFFFFF}Escolha uma senha para a sua conta banc�ria:", "Criar", "<<<");
			if(strlen(inputtext) > 16) return ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta banc�ria", "{E74C3C}A senha da conta n�o pode ter mais de 16 caracteres.\n\n{FFFFFF}Escolha uma senha para a sua conta banc�ria:", "Criar", "<<<");
			if(ACCOUNT_PRICE > GetMoney(playerid)) {
                SendErrorMessage(playerid, "Voc� n�o possui dinheiro o suficiente para criar uma conta banc�ria.");
                return Bank_ShowMenu(playerid);
            }

			#if defined ACCOUNT_CLIMIT
			if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT) {
                SendErrorMessage(playerid, "Voc� n�o pode criar mais contas banc�rias.");
                return Bank_ShowMenu(playerid);
            }
			#endif

			mysql_format(DBConn, query, sizeof(query), "INSERT INTO bank_accounts SET Character_ID='%d', Password=md5('%e'), CreatedOn=UNIX_TIMESTAMP()", GetPlayerSQLID(playerid), inputtext);
			mysql_tquery(DBConn, query, "OnBankAccountCreated", "is", playerid, inputtext);
	        return true;
	    }
	    case DIALOG_BANK_ACCOUNTS: {
            if(!response) return Bank_ShowMenu(playerid);

            SetPVarInt(playerid, "bankLoginAccount", strval(inputtext));
			ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "Senha da conta:", "Acessar", "Cancelar");
	        return true;
	    }
	    case DIALOG_BANK_LOGIN_ID: {
	        if(!response) return Bank_ShowMenu(playerid);
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_ID, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Entrar", "{E74C3C}Voc� deve digitar o ID de uma conta para prosseguir.\n\n{FFFFFF}ID da conta:", "Continuar", "Cancelar");

			SetPVarInt(playerid, "bankLoginAccount", strval(inputtext));
			ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "Senha da conta:", "Acessar", "Cancelar");
			return true;
	    }
	    case DIALOG_BANK_LOGIN_PASS: {
	        if(!response) return Bank_ShowMenu(playerid);
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "{E74C3C}Voc� deve digitar uma senha para prosseguir.\n\n{FFFFFF}Senha da conta:", "Acessar", "Cancelar");

			new id = GetPVarInt(playerid, "bankLoginAccount");
			mysql_format(DBConn, query, sizeof(query), "SELECT Character_ID, LastAccess, FROM_UNIXTIME(LastAccess, '%%d/%%m/%%Y %%H:%%i:%%s') AS Last FROM bank_accounts WHERE ID=%d && Password=md5('%e') && Disabled=0 LIMIT 1", id, inputtext);
			mysql_tquery(DBConn, query, "OnBankAccountLogin", "ii", playerid, id);
			return true;
	    }
	    case DIALOG_BANK_DEPOSIT: {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return 1;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Voc� n�o pode deixar esse valor em branco.\n\n{FFFFFF}Digite o valor que voc� deseja depositar:", "Depositar", "<<<");

			new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000 : 5000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Voc� n�o pode depositar menos que $1 ou mais que $5,000,000 por vez. ($5,000 por vez nos ATMs)\n\n{FFFFFF}Digite o valor que voc� deseja depositar:", "Depositar", "<<<");

			if(amount > GetMoney(playerid)) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Voc� n�o tem todo esse dinheiro em m�os.\n\n{FFFFFF}Digite o valor que voc� deseja depositar:", "Depositar", "<<<");
			if((amount + Bank_GetBalance(CurrentAccountID[playerid])) > ACCOUNT_LIMIT) {
                SendErrorMessage(playerid, "Voc� n�o pode depositar mais dinheiro a essa conta.");
			    return Bank_ShowMenu(playerid);
			}

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance+%d WHERE ID=%d && Disabled=0", amount, CurrentAccountID[playerid]);
			mysql_tquery(DBConn, query, "OnBankAccountDeposit", "ii", playerid, amount);
			return true;
		}
        case DIALOG_BANK_WITHDRAW: {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return 1;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "{E74C3C}Voc� n�o pode deixar esse valor em branco.\n\n{FFFFFF}Digite o valor que voc� deseja sacar:", "Sacar", "<<<");

			new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000 : 5000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "{E74C3C}Voc� n�o pode sacar menos que $1 ou mais que $5,000,000 por vez. ($5,000 por vez nos ATMs)\n\n{FFFFFF}Digite o valor que voc� deseja sacar:", "Sacar", "<<<");
			if(amount > Bank_GetBalance(CurrentAccountID[playerid])) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Withdraw", "{E74C3C}Essa conta n�o possui todo esse dinheiro.\n\n{FFFFFF}Digite o valor que voc� deseja sacar:", "Sacar", "<<<");

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance-%d WHERE ID=%d && Disabled=0", amount, CurrentAccountID[playerid]);
			mysql_tquery(DBConn, query, "OnBankAccountWithdraw", "ii", playerid, amount);
			return true;
		}
        case DIALOG_BANK_TRANSFER_1: {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return 1;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Voc� n�o pode deixar esse valor em branco.\n\n{FFFFFF}Especifique o ID de uma conta banc�ria:", "Avan�ar", "<<<");

            if(strval(inputtext) == CurrentAccountID[playerid]) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Voc� n�o pode transferir dinheiro para a sua pr�pria conta.\n\n{FFFFFF}Especifique o ID de uma conta banc�ria:", "Avan�ar", "<<<");
            SetPVarInt(playerid, "bankTransferAccount", strval(inputtext));
            ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{FFFFFF}Especifique o valor que deseja transferir:", "Transferir", "<<<");
            return true;
		}
        case DIALOG_BANK_TRANSFER_2: {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "Especifique o ID de uma conta banc�ria:", "Avan�ar", "<<<");
            if(CurrentAccountID[playerid] == -1) return 1;
			if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Voc� n�o pode deixar esse valor em branco.\n\n{FFFFFF}Especifique o valor que deseja transferir:", "Transferir", "<<<");

            new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000000 : 5000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Voc� n�o pode transferir menos que $1 ou mais que $5,000,000 por vez.\n\n{FFFFFF}Digite o valor que voc� deseja transferir:", "Transferir", "<<<");
            if(amount > Bank_GetBalance(CurrentAccountID[playerid])) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}A conta n�o possui todo esse dinheiro.\n\n{FFFFFF}Especifique o valor que deseja transferir:", "Transferir", "<<<");
			new id = GetPVarInt(playerid, "bankTransferAccount");
			if((amount + Bank_GetBalance(id)) > ACCOUNT_LIMIT) {
                SendErrorMessage(playerid, "Essa conta n�o pode receber mais dinheiro.");
				return Bank_ShowMenu(playerid);
			}

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance+%d WHERE ID=%d && Disabled=0", amount, id);
			mysql_tquery(DBConn, query, "OnBankAccountTransferir", "iii", playerid, id, amount);
            return true;
        }
        /* ---------------------------------------------------------------------- */
        case DIALOG_BANK_PASSWORD: {
        	if(!response) return Bank_ShowMenu(playerid);
        	if(CurrentAccountID[playerid] == -1) return true;
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Alterar senha", "{E74C3C}Voc� n�o pode deixar esse valor em branco.\n\n{FFFFFF}Digite uma nova senha:", "Alterar", "<<<");
			if(strlen(inputtext) > 16) return ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Alterar senha", "{E74C3C}Sua nova senha n�o pode possuir mais de 16 caracteres.\n\n{FFFFFF}Digite uma nova senha:", "Alterar", "<<<");

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Password=md5('%e') WHERE ID=%d && Disabled=0", inputtext, CurrentAccountID[playerid]);
			mysql_tquery(DBConn, query, "OnBankAccountPassChange", "is", playerid, inputtext);
	        return true;
	    }
        case DIALOG_BANK_REMOVE: {
            if(!response) return Bank_ShowMenu(playerid);
            if(CurrentAccountID[playerid] == -1) return 1;

            new amount = Bank_GetBalance(CurrentAccountID[playerid]);
			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Disabled=1 WHERE ID=%d", CurrentAccountID[playerid]);
			mysql_tquery(DBConn, query, "OnBankAccountDeleted", "iii", playerid, CurrentAccountID[playerid], amount);
            return true;
        }
        case DIALOG_BANK_LOGS: {
            if(!response) return Bank_ShowMenu(playerid);
            if(CurrentAccountID[playerid] == -1) return true;

            new typelist[6] = {TYPE_NONE, TYPE_DEPOSIT, TYPE_WITHDRAW, TYPE_TRANSFER, TYPE_LOGIN, TYPE_PASSCHANGE};
            LogListType[playerid] = typelist[listitem + 1];
            LogListPage[playerid] = 0;
            Bank_ShowLogs(playerid);
            return true;
   		}
        case DIALOG_BANK_LOG_PAGE: {
		    if(CurrentAccountID[playerid] == -1 || LogListType[playerid] == TYPE_NONE) return true;
			if(!response) {
			    LogListPage[playerid]--;
			    if(LogListPage[playerid] < 0) return Bank_ShowLogMenu(playerid);
			} else {
			    LogListPage[playerid]++;
			}

			Bank_ShowLogs(playerid);
		    return true;
		}
	}
	return false;
}