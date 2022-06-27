/*
 
Esse m�dulo � dedicado integralmente a lidar com conex�es e integra��es com o MySQL. Mas isso n�o implica que outros m�dulos n�o possam
extrair, salvar ou inserir informa��es no mesmo banco de dados de maneira segura, estando ordenadas e documentadas.

*/

#include <YSI_Coding\y_hooks>

#define DB_HOST         "localhost"
#define DB_USER         "root"
#define DB_PASSWORD     ""
#define DB_NAME         "adrp"

hook OnGameModeInit() {
    DBConn = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

    if(mysql_errno(DBConn)) {
        print("\n[DATABASE] Houve um erro na tentativa de conex�o com o MySQL.");
        print("[DATABASE] Para obter mais detalhes, acesse a pasta de logging do plug-in.");
        print("[DATABASE] Desligando o servidor...\n");

        format(logString, sizeof(logString), "SYSTEM: Houve um erro na tentativa de conex�o com o MySQL. Para obter mais detalhes, acesse a pasta de logging do plug-in. O servidor ser� desligado.");
        logCreate(99998, logString, 5);
        
        SendRconCommand("exit");
    } else {
        print("\n[DATABASE] A conex�o com o MySQL foi feita com sucesso.");
        print("[DATABASE] Verificando cria��o de tabelas...");
        CheckTables();
    }

    return true;
}

void:CheckTables() {
    CheckUserTable();
    CheckPlayerTable();
    CheckBanTable();
    CheckLogsTable();
    print("[DATABASE] Todas tabelas foram carregadas com sucesso.");
    print("* Note que se alguma tabela faltar, fun��es n�o funcionar�o de modo correto.\n");
}

void:CheckUserTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `users` (\
        ID int NOT NULL AUTO_INCREMENT,\
        `username` varchar(24),\
        `password` varchar(128),\
        `admin` int NOT NULL DEFAULT 0,\
        `vip` int NOT NULL DEFAULT 0,\
        `ft` int NOT NULL DEFAULT 0,\
        `pt` int NOT NULL DEFAULT 0,\
        PRIMARY KEY (ID));");

    print("[DATABASE] Tabela 'users' checada com sucesso.");
}

void:CheckPlayerTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `user` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `first_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `last_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `first_login` int NOT NULL DEFAULT '0',\
    `last_login` int NOT NULL DEFAULT '0',\
    `age` int NOT NULL DEFAULT '0',\
    `gender` varchar(15) NOT NULL DEFAULT 'Masculino',\
    `background` varchar(50) NOT NULL DEFAULT 'Los Santos',\
    `money` int NOT NULL DEFAULT '0',\
    `bank` int NOT NULL DEFAULT '0',\
    `skin` int NOT NULL DEFAULT '23',\
    `health` float NOT NULL DEFAULT '100',\
    `armour` float NOT NULL DEFAULT '0',\
    `score` int NOT NULL DEFAULT '1',\
    `virtual_world` int NOT NULL DEFAULT '0',\
    `interior` int NOT NULL DEFAULT '0',\
    `positionX` float NOT NULL DEFAULT '1642.1957',\
    `positionY` float NOT NULL DEFAULT '-2334.4849',\
    `positionZ` float NOT NULL DEFAULT '13.5469',\
    `positionA` float NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela 'players' checada com sucesso.");
}

void:CheckBanTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ban` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `banned_name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `admin_name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `reason` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `ban_date` int NOT NULL DEFAULT '0',\
    `unban_date` int NOT NULL DEFAULT '0',\
    `unban_admin` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `banned` boolean NOT NULL DEFAULT '1',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela 'ban' checada com sucesso.");
}

void:CheckLogsTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `serverlogs` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `user` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `timestamp` int NOT NULL DEFAULT '0',\
    `log` varchar(255) NOT NULL DEFAULT 'N/A',\
    `type` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela 'serverlogs' checada com sucesso.");
} 