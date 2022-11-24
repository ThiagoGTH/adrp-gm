enum E_PLAYER_BANKACCOUNT {
    aID,                // ID da conta no MySQL
    aOwner,             // ID do jogador dono da conta
    aSubOwner,          // ID do segundo jogador dono da cont caso Conta Compartilhada
    aNumber[16],        // Numero de Identificaçao da Conta para Acesso Ingame
    aPassword[16]       // Senha de Identificaçao da Conta para Acesso Ingame
    bool:aBlocked,      // Conta Bloqueada
    aAmount,            // Valor total disponível na conta
    aSavings,           // Valor total da conta em savings
    bool:aShared,       // Conta compartilhada
};

new aInfo[MAX_PLAYERS][E_PLAYER_BANKACCOUNT];

enum {
    ACCOUNT_OWNER,
    ACCOUNT_SUBOWNER
};

stock CreateBankAccount(char_id, number[], password[])
{
    static query[256];
    mysql_format(DBConn, query, sizeof(query), "SELECT NULL FROM player_bankaccounts WHERE account_number = '%e';", number);
    new Cache:result = mysql_query(DBConn, query);

    if (cache_num_rows()) {
        cache_delete(result);
        return 0;
    } 
    
    cache_delete(result);

    mysql_format(DBConn, query, sizeof(query), "INSERT INTO player_bankaccounts (character_id, account_number, account_pass) VALUES(%i, '%e', '%e');", char_id, number, password);
    mysql_tquery(DBConn, query);
    return 1;
}

stock bool:AccountBank_Exists(number[]) {
    static query[90];
    mysql_format(DBConn, query, sizeof(query), "SELECT NULL FROM player_bankaccounts WHERE account_number = '%e';", number);
    new Cache:result = mysql_query(DBConn, query);

    if (!cache_num_rows()) {
        cache_delete(result);
        return false;
    }

    cache_delete(result);
    return true;
}

stock bool:CheckAccountPermission(characterid) {
    static query[128];
    mysql_format(DBConn, query, sizeof(query), "SELECT NULL FROM player_bankaccounts WHERE character_id = %i OR sec_character_id = %i;", characterid, characterid);
    new Cache:result = mysql_query(DBConn, query);

    if (!cache_num_rows()) {
        cache_delete(result);
        return false;
    }

    cache_delete(result);
    return true;
}

stock GetPlayerBankAccounts(playerid)
{
    static query[256];
    mysql_format(DBConn, query, sizeof(query), "SELECT id, account_number, blocked WHERE character_id = %i OR sec_character_id = %i;", pInfo[playerid][pID], pInfo[playerid][pID]);
    new Cache:result = mysql_query(SQL, query);

    if (!cache_num_rows()) {
        cache_delete(result);
        return 0;
    }

    new string[512] = "ID\tNúmero\nTipo\n", count = 0;
    
    for (new i; i < cache_num_rows(); i ++) {
        format(string, sizeof(string), "%i\t%s\t%s", 
            cache_get_value_name_int(i, "id"),
            cache_get_value_name_int(i, "account_number"),
            (cache_get_value_name_int(i, "shared") ? ("Compartilhada") : ("Particular"))
        );
        pInfo[playerid][pAccountList][count++] = cache_get_value_name_int(i, "id");
    }

    new title[60];
    format(title, sizeof(title), "Contas de %s (%i contas encontradas)", pNome(playerid), cache_num_rows());

    Dialog_Show(playerid, Player_BankAccounts, DIALOG_STYLE_TABLIST_HEADERS, title, string, "Selecionar", "Fechar");
    cache_delete(result);
    return 1;
}

Dialog:Player_BankAccounts(playerid, response, listitem, inputtext[])
{
    if (!response)
        return 0;

    new acc_id = pInfo[playerid][pAccountList][listitem], query[128];

    if (!acc_id) return 0;

    if (!CheckAccountPermission(pInfo[playerid][pID])) Dialog_Show(playerid, BankAccount_Password, DIALOG_STYLE_INPUT, "Digite a senha dessa conta.");
    else Dialog_Show(playerid, BankAccount_Interact, DIALOG_STYLE_LIST, "Interagir com sua conta", "Saldo da Conta\nTransferir\nDepositar\nSavings\nExtrato\nCompartilhar conta", "Prosseguir", "Cancelar");
    return 1;
}
