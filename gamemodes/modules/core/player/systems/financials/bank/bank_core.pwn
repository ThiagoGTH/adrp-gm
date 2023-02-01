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

    mysql_tquery(DBConn, "SELECT * FROM bankers WHERE (`ID` != '0');", "LoadBankers");
	mysql_tquery(DBConn, "SELECT * FROM bank_atms WHERE (`ID` != '0');", "LoadATMs");
    return true;
}

hook OnGameModeExit() {
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
                    SendErrorMessage(playerid, "Você não pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}

	            if(ACCOUNT_PRICE > GetMoney(playerid)) {
                    SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para criar uma conta bancária.");
	                return Bank_ShowMenu(playerid);
	            }

				#if defined ACCOUNT_CLIMIT
				if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT) {
                    SendErrorMessage(playerid, "Você não pode criar mais contas bancárias.");
	                return Bank_ShowMenu(playerid);
	            }
				#endif

				ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta", "{FFFFFF}Escolha uma senha para a sua nova conta bancária:", "Criar", "<<<");
	        }

	        if(listitem == 1) Bank_ListAccounts(playerid);
	        if(listitem == 2) ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_ID, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Entrar", "{FFFFFF}ID da conta:", "Continuar", "Cancelar");
	        return true;
	    }
     	case DIALOG_BANK_MENU: {
		    if(!response) return true;
		    if(listitem == 0) {
	            if(GetPVarInt(playerid, "usingATM")) {
				    SendErrorMessage(playerid, "Você não pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}

	            if(ACCOUNT_PRICE > GetMoney(playerid)) {
	                SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para criar uma conta bancária.");
	                return Bank_ShowMenu(playerid);
	            }

				#if defined ACCOUNT_CLIMIT
				if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT) {
	                SendErrorMessage(playerid, "Você não pode criar mais contas bancárias.");
	                return Bank_ShowMenu(playerid);
	            }
				#endif

				ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta bancária", "{FFFFFF}Escolha uma senha para a sua nova conta bancária:", "Criar", "<<<");
	        }

	        if(listitem == 1) Bank_ListAccounts(playerid);
	        if(listitem == 2) ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{FFFFFF}Digite o valor que você deseja depositar:", "Depositar", "<<<");
            if(listitem == 3) ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "{FFFFFF}Digite o valor que você deseja sacar:", "Sacar", "<<<");
			if(listitem == 4) ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{FFFFFF}Especifique o ID de uma conta bancária:", "Avançar", "<<<");
            if(listitem == 5) {
			    if(GetPVarInt(playerid, "usingATM")) {
				    SendErrorMessage(playerid, "Você não pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}
				Bank_ShowLogMenu(playerid);
			}

			if(listitem == 6) {
			    if(GetPVarInt(playerid, "usingATM")) {
				    SendErrorMessage(playerid, "Você não pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}

				if(Bank_GetOwner(CurrentAccountID[playerid]) != pInfo[playerid][pID]) {
                    SendErrorMessage(playerid, "Apenas o titular da conta pode realizar essa ação.");
				    return Bank_ShowMenu(playerid);
				}

				ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Alterar senha", "{FFFFFF}Digite a nova senha:", "Alterar", "<<<");
			}

			if(listitem == 7) {
			    if(GetPVarInt(playerid, "usingATM")) {
				    SendErrorMessage(playerid, "Você não pode fazer isso utilizando um ATM, visite um banco.");
					return Bank_ShowMenu(playerid);
				}

				if(Bank_GetOwner(CurrentAccountID[playerid]) != pInfo[playerid][pID]) {
				    SendErrorMessage(playerid, "Apenas o titular da conta pode realizar essa ação.");
				    return Bank_ShowMenu(playerid);
				}

				ShowPlayerDialog(playerid, DIALOG_BANK_REMOVE, DIALOG_STYLE_MSGBOX, "{F1C40F}Banco: {FFFFFF}Deletar conta", "{FFFFFF}Você tem certeza disso?\nEsta conta será deletada {E74C3C}permanentemente{FFFFFF}.", "Confirmar", "<<<");
			}

			if(listitem == 8) {
                SendServerMessage(playerid, "Você saiu de sua conta bancária.");

			    CurrentAccountID[playerid] = -1;
			    Bank_ShowMenu(playerid);
			}
		}
	    case DIALOG_BANK_CREATE_ACCOUNT: {
	        if(!response) return Bank_ShowMenu(playerid);
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta bancária", "{E74C3C}Você não pode deixar a senha em branco.\n\n{FFFFFF}Escolha uma senha para a sua conta bancária:", "Criar", "<<<");
			if(strlen(inputtext) > 16) return ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta bancária", "{E74C3C}A senha da conta não pode ter mais de 16 caracteres.\n\n{FFFFFF}Escolha uma senha para a sua conta bancária:", "Criar", "<<<");
			if(ACCOUNT_PRICE > GetMoney(playerid)) {
                SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para criar uma conta bancária.");
                return Bank_ShowMenu(playerid);
            }

			#if defined ACCOUNT_CLIMIT
			if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT) {
                SendErrorMessage(playerid, "Você não pode criar mais contas bancárias.");
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
			if(Bank_GetOwner(strval(inputtext)) != pInfo[playerid][pID]) {
				ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "{FFFFFF}Senha da conta:", "Acessar", "Cancelar");
			} else {
				new id = GetPVarInt(playerid, "bankLoginAccount");
				mysql_format(DBConn, query, sizeof(query), "SELECT Character_ID, LastAccess, FROM_UNIXTIME(LastAccess, '%%d/%%m/%%Y %%H:%%i:%%s') AS Last FROM bank_accounts WHERE ID=%d LIMIT 1", id);

				mysql_tquery(DBConn, query, "OnBankAccountLogin", "ii", playerid, id);
			}
	        return true;
	    }
	    case DIALOG_BANK_LOGIN_ID: {
	        if(!response) return Bank_ShowMenu(playerid);
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_ID, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Entrar", "{E74C3C}Você deve digitar o ID de uma conta para prosseguir.\n\n{FFFFFF}ID da conta:", "Continuar", "Cancelar");

			SetPVarInt(playerid, "bankLoginAccount", strval(inputtext));
			if(Bank_GetOwner(strval(inputtext)) != pInfo[playerid][pID]) {
				ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "{FFFFFF}Senha da conta:", "Acessar", "Cancelar");
			} else {
				new id = GetPVarInt(playerid, "bankLoginAccount");
				mysql_format(DBConn, query, sizeof(query), "SELECT Character_ID, LastAccess, FROM_UNIXTIME(LastAccess, '%%d/%%m/%%Y %%H:%%i:%%s') AS Last FROM bank_accounts WHERE ID=%d LIMIT 1", id);

				mysql_tquery(DBConn, query, "OnBankAccountLogin", "ii", playerid, id);
			}
			return true;
	    }
	    case DIALOG_BANK_LOGIN_PASS: {
	        if(!response) return Bank_ShowMenu(playerid);

	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "{E74C3C}Você deve digitar uma senha para prosseguir.\n\n{FFFFFF}Senha da conta:", "Acessar", "Cancelar");

			new id = GetPVarInt(playerid, "bankLoginAccount");
			mysql_format(DBConn, query, sizeof(query), "SELECT Character_ID, LastAccess, FROM_UNIXTIME(LastAccess, '%%d/%%m/%%Y %%H:%%i:%%s') AS Last FROM bank_accounts WHERE ID=%d && Password=md5('%e') LIMIT 1", id, inputtext);
			mysql_tquery(DBConn, query, "OnBankAccountLogin", "ii", playerid, id);
			return true;
	    }
	    case DIALOG_BANK_DEPOSIT: {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return true;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Você não pode deixar esse valor em branco.\n\n{FFFFFF}Digite o valor que você deseja depositar:", "Depositar", "<<<");

			new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000 : 5000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Você não pode depositar menos que $1 ou mais que $5,000,000 por vez. ($5,000 por vez nos ATMs)\n\n{FFFFFF}Digite o valor que você deseja depositar:", "Depositar", "<<<");

			if(amount > GetMoney(playerid)) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Você não tem todo esse dinheiro em mãos.\n\n{FFFFFF}Digite o valor que você deseja depositar:", "Depositar", "<<<");
			if((amount + Bank_GetBalance(CurrentAccountID[playerid])) > ACCOUNT_LIMIT) {
                SendErrorMessage(playerid, "Você não pode depositar mais dinheiro a essa conta.");
			    return Bank_ShowMenu(playerid);
			}

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance+%d WHERE ID=%d", amount, CurrentAccountID[playerid]);
			mysql_tquery(DBConn, query, "OnBankAccountDeposit", "ii", playerid, amount);
			return true;
		}
        case DIALOG_BANK_WITHDRAW: {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return true;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "{E74C3C}Você não pode deixar esse valor em branco.\n\n{FFFFFF}Digite o valor que você deseja sacar:", "Sacar", "<<<");

			new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000 : 5000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "{E74C3C}Você não pode sacar menos que $1 ou mais que $5,000,000 por vez. ($5,000 por vez nos ATMs)\n\n{FFFFFF}Digite o valor que você deseja sacar:", "Sacar", "<<<");
			if(amount > Bank_GetBalance(CurrentAccountID[playerid])) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Withdraw", "{E74C3C}Essa conta não possui todo esse dinheiro.\n\n{FFFFFF}Digite o valor que você deseja sacar:", "Sacar", "<<<");

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance-%d WHERE ID=%d", amount, CurrentAccountID[playerid]);
			mysql_tquery(DBConn, query, "OnBankAccountWithdraw", "ii", playerid, amount);
			return true;
		}
        case DIALOG_BANK_TRANSFER_1: {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return true;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Você não pode deixar esse valor em branco.\n\n{FFFFFF}Especifique o ID de uma conta bancária:", "Avançar", "<<<");

            if(strval(inputtext) == CurrentAccountID[playerid]) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Você não pode transferir dinheiro para a sua própria conta.\n\n{FFFFFF}Especifique o ID de uma conta bancária:", "Avançar", "<<<");
            SetPVarInt(playerid, "bankTransferAccount", strval(inputtext));
            ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{FFFFFF}Especifique o valor que deseja transferir:", "Transferir", "<<<");
            return true;
		}
        case DIALOG_BANK_TRANSFER_2: {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "Especifique o ID de uma conta bancária:", "Avançar", "<<<");
            if(CurrentAccountID[playerid] == -1) return true;
			if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Você não pode deixar esse valor em branco.\n\n{FFFFFF}Especifique o valor que deseja transferir:", "Transferir", "<<<");

            new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000000 : 5000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Você não pode transferir menos que $1 ou mais que $5,000,000 por vez.\n\n{FFFFFF}Digite o valor que você deseja transferir:", "Transferir", "<<<");
            if(amount > Bank_GetBalance(CurrentAccountID[playerid])) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}A conta não possui todo esse dinheiro.\n\n{FFFFFF}Especifique o valor que deseja transferir:", "Transferir", "<<<");
			new id = GetPVarInt(playerid, "bankTransferAccount");
			if((amount + Bank_GetBalance(id)) > ACCOUNT_LIMIT) {
                SendErrorMessage(playerid, "Essa conta não pode receber mais dinheiro.");
				return Bank_ShowMenu(playerid);
			}

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance+%d WHERE ID=%d", amount, id);
			mysql_tquery(DBConn, query, "OnBankAccountTransferir", "iii", playerid, id, amount);
            return true;
        }
        case DIALOG_BANK_PASSWORD: {
        	if(!response) return Bank_ShowMenu(playerid);

        	if(CurrentAccountID[playerid] == -1) return true;
			
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Alterar senha", "{E74C3C}Você não pode deixar esse valor em branco.\n\n{FFFFFF}Digite uma nova senha:", "Alterar", "<<<");
			if(strlen(inputtext) > 16) return ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Alterar senha", "{E74C3C}Sua nova senha não pode possuir mais de 16 caracteres.\n\n{FFFFFF}Digite uma nova senha:", "Alterar", "<<<");
			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_accounts SET Password=md5('%e') WHERE ID=%d", inputtext, CurrentAccountID[playerid]);
			mysql_tquery(DBConn, query, "OnBankAccountPassChange", "is", playerid, inputtext);
	        return true;
	    }
        case DIALOG_BANK_REMOVE: {
            if(!response) return Bank_ShowMenu(playerid);
            if(CurrentAccountID[playerid] == -1) return true;

            new amount = Bank_GetBalance(CurrentAccountID[playerid]);
			
			new Cache:result;
			mysql_format(DBConn, query, sizeof query, "DELETE FROM `bank_accounts` WHERE `ID` = '%d';", CurrentAccountID[playerid]);
			result = mysql_query(DBConn, query);

			mysql_tquery(DBConn, query, "OnBankAccountDeleted", "iii", playerid, CurrentAccountID[playerid], amount);

			cache_delete(result);
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

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	if(Iter_Contains(ATMs, EditingATMID[playerid])) {
	    if(response == 1) {
	        new id = EditingATMID[playerid];
	        ATMData[id][atmX] = x;
	        ATMData[id][atmY] = y;
	        ATMData[id][atmZ] = z;
	        ATMData[id][atmRX] = rx;
	        ATMData[id][atmRY] = ry;
	        ATMData[id][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	        SetDynamicObjectRot(objectid, ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
            
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_X, ATMData[id][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_Y, ATMData[id][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_Z, ATMData[id][atmZ] + 0.85);

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_atms SET PosX='%f', PosY='%f', PosZ='%f', RotX='%f', RotY='%f', RotZ='%f' WHERE ID=%d", x, y, z, rx, ry, rz, id);
			mysql_tquery(DBConn, query);

	        EditingATMID[playerid] = -1;
	    }

	    if(response == 0) {
	        new id = EditingATMID[playerid];
	        SetDynamicObjectPos(objectid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	        SetDynamicObjectRot(objectid, ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
	        EditingATMID[playerid] = -1;
	    }
	}

	return true;
}