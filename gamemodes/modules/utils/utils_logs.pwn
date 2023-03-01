#include <YSI_Coding\y_hooks>

logCreate(playerid, log[], type){
	if(type <= 100)
		Discord_PublishLog(log, type);

    /*if(playerid == 99998){
        mysql_format(DBConn, query, sizeof query, "INSERT INTO serverlogs (`character`, `user`, `ip`, `timestamp`, `log`, `type`) VALUES ('SYSTEM', 'SYSTEM', '%s', '%d', '%e', '%d')", 
            GetPlayerIP(playerid), gettime(), log, type);
        mysql_query(DBConn, query);
    } else {
        mysql_format(DBConn, query, sizeof query, "INSERT INTO serverlogs (`character`, `user`, `ip`, `timestamp`, `log`, `type`) VALUES ('%s', '%s', '%s', '%d', '%e', '%d')", 
            GetPlayerNameEx(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), gettime(), log, type);
        mysql_query(DBConn, query);
    }*/

    //printf("[LOG] %s [%d (SQL: %d)] - %s / %s | %s [TYPE: %d]", pNome(playerid), playerid, uInfo[playerid][uID], uInfo[playerid][uName], GetPlayerUserEx(playerid), log, type);

	return -1;
}