#include <YSI_Coding\y_hooks>

logCreate(playerid, log[], type){
	if(type <= 100)
		Discord_PublishLog(log, type);

    /*new logQuery[512];

    if(playerid == 99998){
        mysql_format(DBConn, logQuery, sizeof(logQuery), "INSERT INTO serverlogs (`character`, `user`, `ip`, `timestamp`, `log`, `type`) VALUES ('SYSTEM', 'SYSTEM', '%s', '%d', '%e', '%d')", 
            GetPlayerIP(playerid), gettime(), log, type);
        mysql_query(DBConn, logQuery, false);
    } else {
        mysql_format(DBConn, logQuery, sizeof(logQuery), "INSERT INTO serverlogs (`character`, `user`, `ip`, `timestamp`, `log`, `type`) VALUES ('%s', '%s', '%s', '%d', '%e', '%d')", 
            GetPlayerNameEx(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), gettime(), log, type);
        mysql_query(DBConn, logQuery, false);
    }
*/
	return -1;
}