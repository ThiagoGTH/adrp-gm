#include <YSI_Coding\y_hooks>

logCreate(playerid, log[], type){
	if(type <= 100)
		Discord_PublishLog(playerid, log, type);

    if(playerid == 99998){
        mysql_format(DBConn, query, sizeof query, "INSERT INTO serverlogs (`character`, `user`, `ip`, `timestamp`, `log`, `type`) VALUES ('SYSTEM', 'SYSTEM', '%s', '%d', '%s', '%d')", 
            GetPlayerIP(playerid), gettime(), log, type);
        mysql_query(DBConn, query);
    }else{
        mysql_format(DBConn, query, sizeof query, "INSERT INTO serverlogs (`character`, `user`, `ip`, `timestamp`, `log`, `type`) VALUES ('%s', '%s', '%s', '%d', '%s', '%d')", 
            GetPlayerNameEx(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), gettime(), log, type);
        mysql_query(DBConn, query);
    }

	return -1;
}