#include <YSI_Coding\y_hooks>

CMD:logs(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 5)) return SendPermissionMessage(playerid);
    ShowLogsInit(playerid);
    return true;    
}

ShowLogsInit(playerid) {
    new Cache:type[26], rows[26], string[2048];

    for (new i = 0; i < sizeof(type); i++) {
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM serverlogs WHERE `type` = '%d';", i + 1);
        type[i] = mysql_query(DBConn, query);
        rows[i] = cache_num_rows();
        cache_delete(type[i]);
    }

	format(string, sizeof(string),
	"ID\tTipo\tQuantidade\n\
    {BBBBBB}Pesquisar{FFFFFF}\n\
    1\tAdministrativo\t%d\n\
	2\tLogin/Logout\t%d\n\
    3\tComandos\t%d\n\
    4\tDeletar personagem\t%d\n\
    5\tSistema\t%d\n\
    6\tMortes\t%d\n\
    7\tInvestida\t%d\n\
    8\tGerenciamento\t%d\n\
    9\tSupport Chat\t%d\n\
    10\tAnúncios\t%d\n\
    11\tPunições\t%d\n\
    12\tGames\t%d\n\
    13\tCasas\t%d\n\
    14\tEntradas\t%d\n\
    15\tInvestimentos\t%d\n\
    16\tVeículos\t%d\n\
    17\tLockpick\t%d\n\
    18\tDrop de itens\t%d\n\
    19\tPets\t%d\n\
    20\tDinheiro\t%d\n\
    21\tAnticheat\t%d\n\
    22\tFacções\t%d\n\
    23\tGrafites\t%d\n\
    24\tEmpresas\t%d\n\
    25\tGaragens\t%d\n\
    26\tBanco\t%d\n",
    rows[0], rows[1], rows[2], rows[3], rows[4], rows[5], rows[6], rows[7], rows[8], rows[9], rows[10], rows[11], rows[12], rows[13], rows[14], rows[15], rows[16], rows[17], rows[18], rows[19], rows[20], rows[21], rows[22], rows[23], rows[24], rows[25]
	);

    Dialog_Show(playerid, dialogLogs, DIALOG_STYLE_TABLIST_HEADERS, "Central de Logs", string, "Selecionar", "Fechar");
    return true;
}

Dialog:dialogLogs(playerid, response, listitem, inputtext[]) {
    if(response){
        if(!strcmp(inputtext, "Pesquisar", true)){
            Dialog_Show(playerid, dialogSearchLog, DIALOG_STYLE_INPUT, "Central de Logs > Pesquisar", "Digite o texto a ser pesquisado:", "Pesquisar", "Voltar");
        } else {
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM serverlogs WHERE `type` = '%d' ORDER BY `timestamp` DESC LIMIT 15;", strval(inputtext));
            new Cache:result = mysql_query(DBConn, query);

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Não foi possível encontrar nenhum log do tipo selecionado.");

            new string[2056], timestamp, log[255];
            format(string, sizeof(string), "{FF6347}ATENÇÃO: Os logs são exibidos de acordo com o horário e apenas os últimos quinze são contabilizados.\nPara informações mais detalhadas, busque auxilio de um membro da Log Team.\n\n");

            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "timestamp", timestamp);
                cache_get_value_name(i, "log", log);

                format(string, sizeof(string), "%s{AFAFAF}[%s] {36A717}%s\n", string, GetFullDate(timestamp), log);
            }
            cache_delete(result);

            Dialog_Show(playerid, showLog, DIALOG_STYLE_MSGBOX, "Central de Logs", string, "Fechar", "");

            format(logString, sizeof(logString), "%s (%s) acessou o log ID %d", pNome(playerid), GetPlayerUserEx(playerid), strval(inputtext));
	        logCreate(playerid, logString, 1);
        }
    }
    return true;
}

Dialog:dialogSearchLog(playerid, response, listitem, inputtext[]) {
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, dialogSearchLog, DIALOG_STYLE_INPUT, "Central de Logs > Pesquisar", "ERRO: Você não especificou o que deve ser buscado.\nDigite o texto a ser pesquisado:", "Pesquisar", "Voltar");

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM serverlogs WHERE `log` LIKE '%%%s%%' ORDER BY `timestamp` DESC LIMIT 15;", inputtext);
        new Cache:result = mysql_query(DBConn, query);

        if(!cache_num_rows()) return SendErrorMessage(playerid, "Não foi possível encontrar nenhum log contendo '%s'.", inputtext);

        new string[2056], timestamp, log[255];
        format(string, sizeof(string), "{FF6347}ATENÇÃO: Os logs são exibidos de acordo com o horário e apenas os últimos quinze são contabilizados.\nPara informações mais detalhadas, busque auxilio de um membro da Log Team.\n\n");

        for(new i; i < cache_num_rows(); i++){
            cache_get_value_name_int(i, "timestamp", timestamp);
            cache_get_value_name(i, "log", log);

            format(string, sizeof(string), "%s{AFAFAF}[%s] {36A717}%s\n", string, GetFullDate(timestamp), log);
        }
        cache_delete(result);

        Dialog_Show(playerid, showLog, DIALOG_STYLE_MSGBOX, "Central de Logs", string, "Fechar", "");

        format(logString, sizeof(logString), "%s (%s) pesquisou por %s nos logs", pNome(playerid), GetPlayerUserEx(playerid), inputtext);
	    logCreate(playerid, logString, 1);
    }
    return true;
}