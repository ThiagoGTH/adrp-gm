/*
 
Esse módulo é dedicado integralmente a lidar com conexões e integrações com o MySQL. Mas isso não implica que outros módulos não possam extrair, salvar ou inserir informações no mesmo banco de dados de maneira segura, estando ordenadas e documentadas.

*/

#include <YSI_Coding\y_hooks>

#define DB_HOST         "127.0.0.1"
#define DB_USER         "root"
#define DB_PASSWORD     ""
#define DB_NAME         "adrp"

hook OnGameModeInit() {
    DBConn = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

    if(mysql_errno(DBConn)) {
        print("\n[DATABASE] Houve um erro na tentativa de conexão com o MySQL.");
        print("[DATABASE] Para obter mais detalhes, acesse a pasta de logging do plug-in.");
        print("[DATABASE] Desligando o servidor...\n");

        format(logString, sizeof(logString), "SYSTEM: Houve um erro na tentativa de conexão com o MySQL. Para obter mais detalhes, acesse a pasta de logging do plug-in. O servidor será desligado.");
        logCreate(99998, logString, 5);
        
        SendRconCommand("exit");
    } else {
        print("\n[DATABASE] A conexão com o MySQL foi feita com sucesso.");
        print("[DATABASE] Verificando criação de tabelas...");
        mysql_set_charset("latin1");
        CheckTables();
    }

    return true;
}

void:CheckTables() {
    CheckUserTable();
    CheckPlayerTable();
    CheckBanTable();
    CheckLogsTable();
    CheckFurnitureInfoTable();
    CheckInteriorsInfoTable();
    CheckAdsTable();
    CheckVehiclesTable();
    CheckPoolTable();
    CheckHousesTable();
    CheckTradingTable();
    print("[DATABASE] Todas tabelas foram carregadas com sucesso.");
    print("* Note que se alguma tabela faltar, funções não funcionarão de modo correto.\n");
}

void:CheckUserTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `users` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `username` varchar(24),\
    `password` varchar(128),\
    `email` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `discord_tag` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `forum_username` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `registration_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `registration_date` int NOT NULL DEFAULT '0',\
    `last_login` int NOT NULL DEFAULT '0',\
    `admin` int NOT NULL DEFAULT 0,\
    `dutytime` int NOT NULL DEFAULT 0,\
    `SOSAns` int NOT NULL DEFAULT 0,\
    `APPAns` int NOT NULL DEFAULT 0,\
    `redflag` int NOT NULL DEFAULT 0,\
    `newbie` int NOT NULL DEFAULT 0,\
    `jailtime` int NOT NULL DEFAULT -1,\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela users checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela users checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `users_premium` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT 0,\
    `points` int NOT NULL DEFAULT 0,\
    `name_changes` int NOT NULL DEFAULT 0,\
    `number_changes` int NOT NULL DEFAULT 0,\
    `fight_changes` int NOT NULL DEFAULT 0,\
    `plate_changes` int NOT NULL DEFAULT 0,\
    `chars_slots` int NOT NULL DEFAULT 5,\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela users_premium checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela users_premium checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `users_teams` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT 0,\
    `head_faction_team` int NOT NULL DEFAULT 0,\
    `head_property_team` int NOT NULL DEFAULT 0,\
    `head_event_team` int NOT NULL DEFAULT 0,\
    `head_ck_team` int NOT NULL DEFAULT 0,\
    `faction_team` int NOT NULL DEFAULT 0,\
    `property_team` int NOT NULL DEFAULT 0,\
    `event_team` int NOT NULL DEFAULT 0,\
    `ck_team` int NOT NULL DEFAULT 0,\
    `log_team` int NOT NULL DEFAULT 0,\
    `ucp_admin_announcements` int NOT NULL DEFAULT 0,\
    `ucp_posts` int NOT NULL DEFAULT 0,\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela users_teams checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela users_teams checada com sucesso.");
    logCreate(99998, logString, 5);
}

void:CheckPlayerTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `user_id` int NOT NULL DEFAULT '0',\
    `registration_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `first_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `last_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `first_login` int NOT NULL DEFAULT '0',\
    `last_login` int NOT NULL DEFAULT '0',\
    `dateofbirth` varchar(16) NOT NULL DEFAULT '01/01/1970',\
    `minutes` int NOT NULL DEFAULT '0',\
    `hours` int NOT NULL DEFAULT '0',\
    `origin` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `money` int NOT NULL DEFAULT '0',\
    `bank` int NOT NULL DEFAULT '0',\
    `savings` int NOT NULL DEFAULT '0',\
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
    `phone_number` int NOT NULL DEFAULT '0',\
    `phone_type` int NOT NULL DEFAULT '0',\
    `online` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_apparence` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `gender` int NOT NULL DEFAULT '0',\
    `ethnicity` int NOT NULL DEFAULT '0',\
    `color_eyes` int NOT NULL DEFAULT '0',\
    `color_hair` int NOT NULL DEFAULT '0',\
    `height` int NOT NULL DEFAULT '0',\
    `weight` float NOT NULL DEFAULT 0.0,\
    `build` int NOT NULL DEFAULT 0,\
    `description` varchar(128) NOT NULL DEFAULT 'N/A',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_apparence checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_apparence checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_premium` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `donator` int NOT NULL DEFAULT '0',\
    `donator_time` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_premium checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_premium checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_weapons` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `gun1` int NOT NULL DEFAULT '0',\
    `ammo1` int NOT NULL DEFAULT '0',\
    `gun2` int NOT NULL DEFAULT '0',\
    `ammo2` int NOT NULL DEFAULT '0',\
    `gun3` int NOT NULL DEFAULT '0',\
    `ammo3` int NOT NULL DEFAULT '0',\
    `gun4` int NOT NULL DEFAULT '0',\
    `ammo4` int NOT NULL DEFAULT '0',\
    `gun5` int NOT NULL DEFAULT '0',\
    `ammo5` int NOT NULL DEFAULT '0',\
    `gun6` int NOT NULL DEFAULT '0',\
    `ammo6` int NOT NULL DEFAULT '0',\
    `gun7` int NOT NULL DEFAULT '0',\
    `ammo7` int NOT NULL DEFAULT '0',\
    `gun8` int NOT NULL DEFAULT '0',\
    `ammo8` int NOT NULL DEFAULT '0',\
    `gun9` int NOT NULL DEFAULT '0',\
    `ammo9` int NOT NULL DEFAULT '0',\
    `gun10` int NOT NULL DEFAULT '0',\
    `ammo10` int NOT NULL DEFAULT '0',\
    `gun11` int NOT NULL DEFAULT '0',\
    `ammo11` int NOT NULL DEFAULT '0',\
    `gun12` int NOT NULL DEFAULT '0',\
    `ammo12` int NOT NULL DEFAULT '0',\
    `gun13` int NOT NULL DEFAULT '0',\
    `ammo13` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_weapons checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_weapons checada com sucesso.");
    logCreate(99998, logString, 5);
}

void:CheckBanTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ban` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `banned_id` int NOT NULL DEFAULT '0',\
    `admin_name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `reason` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `ban_date` int NOT NULL DEFAULT '0',\
    `unban_date` int NOT NULL DEFAULT '0',\
    `unban_admin` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `banned` boolean NOT NULL DEFAULT '1',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela ban checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ban checada com sucesso.");
    logCreate(99998, logString, 5);
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

    print("[DATABASE] Tabela serverlogs checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela serverlogs checada com sucesso.");
    logCreate(99998, logString, 5);
} 

void:CheckFurnitureInfoTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `furniture_info` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(64) NOT NULL DEFAULT 'Nenhum',\
    `model` int NOT NULL DEFAULT '0',\
    `category` varchar(64) NOT NULL DEFAULT 'Nenhum',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela furniture_info checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela furniture_info checada com sucesso.");
    logCreate(99998, logString, 5);
}

void:CheckInteriorsInfoTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `interiors_info` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(64) NOT NULL DEFAULT 'Nenhum',\
    `virtual_world` int NOT NULL DEFAULT '0',\
    `interior` int NOT NULL DEFAULT '0',\
    `positionX` float NOT NULL DEFAULT '0',\
    `positionY` float NOT NULL DEFAULT '0',\
    `positionZ` float NOT NULL DEFAULT '0',\
    `positionA` float NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela interiors checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela interiors checada com sucesso.");
    logCreate(99998, logString, 5);
}

void:CheckAdsTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `advertisement` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `player` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `text` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `time` int NOT NULL DEFAULT '0',\
    `number` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela advertisement checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela advertisement checada com sucesso.");
    logCreate(99998, logString, 5);
}
       
void:CheckVehiclesTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL DEFAULT '0',\
    `model` int NOT NULL DEFAULT '0',\
    `faction` int NOT NULL DEFAULT '0',\
    `business` int NOT NULL DEFAULT '0',\
    `job` int NOT NULL DEFAULT '0',\
    `personalized_name` int NOT NULL DEFAULT '0',\
    `name` varchar(64) NOT NULL DEFAULT 'Default',\
    `legalized` int NOT NULL  DEFAULT '0',\
    `plate` varchar(128) NOT NULL DEFAULT ' ',\
    `personalized_plate` int NOT NULL DEFAULT '0',\
    `locked` int NOT NULL DEFAULT '0',\
    `impounded` int NOT NULL DEFAULT '0',\
    `impounded_price` int NOT NULL DEFAULT '0',\
    `impounded_reason` varchar(64) NOT NULL DEFAULT 'Default',\
    `color1` int NOT NULL DEFAULT '0',\
    `color2` int NOT NULL DEFAULT '0',\
    `paintjob` int NOT NULL DEFAULT '0',\
    `position_X` float NOT NULL DEFAULT '0',\
    `position_Y` float NOT NULL DEFAULT '0',\
    `position_Z` float NOT NULL DEFAULT '0',\
    `position_A` float NOT NULL DEFAULT '0',\
    `virtual_world` int NOT NULL DEFAULT '0',\
    `interior` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");
    print("[DATABASE] Tabela vehicles checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles_stats` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `vehicle_id` int NOT NULL DEFAULT '0',\
    `insurance` int NOT NULL DEFAULT '0',\
    `sunpass` int NOT NULL DEFAULT '0',\
    `alarm` int NOT NULL DEFAULT '0',\
    `fuel` float NOT NULL DEFAULT '0.0',\
    `health` float NOT NULL DEFAULT '0.0',\
    `battery` float NOT NULL DEFAULT '0.0',\
    `engine` float NOT NULL DEFAULT '0.0',\
    `miles` float NOT NULL DEFAULT '0.0',\
    PRIMARY KEY (`ID`));");
    print("[DATABASE] Tabela vehicles_stats checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_stats checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles_tunings` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `vehicle_id` int NOT NULL DEFAULT '0',\
    `mod1` int NOT NULL DEFAULT '0',\
    `mod2` int NOT NULL DEFAULT '0',\
    `mod3` int NOT NULL DEFAULT '0',\
    `mod4` int NOT NULL DEFAULT '0',\
    `mod5` int NOT NULL DEFAULT '0',\
    `mod6` int NOT NULL DEFAULT '0',\
    `mod7` int NOT NULL DEFAULT '0',\
    `mod8` int NOT NULL DEFAULT '0',\
    `mod9` int NOT NULL DEFAULT '0',\
    `mod10` int NOT NULL DEFAULT '0',\
    `mod11` int NOT NULL DEFAULT '0',\
    `mod12` int NOT NULL DEFAULT '0',\
    `mod13` int NOT NULL DEFAULT '0',\
    `mod14` int NOT NULL DEFAULT '0',\
    `mod15` int NOT NULL DEFAULT '0',\
    `mod16` int NOT NULL DEFAULT '0',\
    `mod17` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");
    print("[DATABASE] Tabela vehicles_tunings checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_tunings checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles_weapons` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `vehicle_id` int NOT NULL DEFAULT '0',\
    `weapon1` int NOT NULL DEFAULT '0',\
    `ammo1` int NOT NULL DEFAULT '0',\
    `weapon_type1` int NOT NULL DEFAULT '0',\
    `weapon2` int NOT NULL DEFAULT '0',\
    `ammo2` int NOT NULL DEFAULT '0',\
    `weapon_type2` int NOT NULL DEFAULT '0',\
    `weapon3` int NOT NULL DEFAULT '0',\
    `ammo3` int NOT NULL DEFAULT '0',\
    `weapon_type3` int NOT NULL DEFAULT '0',\
    `weapon4` int NOT NULL DEFAULT '0',\
    `ammo4` int NOT NULL DEFAULT '0',\
    `weapon_type4` int NOT NULL DEFAULT '0',\
    `weapon5` int NOT NULL DEFAULT '0',\
    `ammo5` int NOT NULL DEFAULT '0',\
    `weapon_type5` int NOT NULL DEFAULT '0',\
    `weapon6` int NOT NULL DEFAULT '0',\
    `ammo6` int NOT NULL DEFAULT '0',\
    `weapon_type6` int NOT NULL DEFAULT '0',\
    `weapon7` int NOT NULL DEFAULT '0',\
    `ammo7` int NOT NULL DEFAULT '0',\
    `weapon_type7` int NOT NULL DEFAULT '0',\
    `weapon8` int NOT NULL DEFAULT '0',\
    `ammo8` int NOT NULL DEFAULT '0',\
    `weapon_type8` int NOT NULL DEFAULT '0',\
    `weapon9` int NOT NULL DEFAULT '0',\
    `ammo9` int NOT NULL DEFAULT '0',\
    `weapon_type9` int NOT NULL DEFAULT '0',\
    `weapon10` int NOT NULL DEFAULT '0',\
    `ammo10` int NOT NULL DEFAULT '0',\
    `weapon_type10` int NOT NULL DEFAULT '0',\
    `weapon11` int NOT NULL DEFAULT '0',\
    `ammo11` int NOT NULL DEFAULT '0',\
    `weapon_type11` int NOT NULL DEFAULT '0',\
    `weapon12` int NOT NULL DEFAULT '0',\
    `ammo12` int NOT NULL DEFAULT '0',\
    `weapon_type12` int NOT NULL DEFAULT '0',\
    `weapon13` int NOT NULL DEFAULT '0',\
    `ammo13` int NOT NULL DEFAULT '0',\
    `weapon_type13` int NOT NULL DEFAULT '0',\
    `weapon14` int NOT NULL DEFAULT '0',\
    `ammo14` int NOT NULL DEFAULT '0',\
    `weapon_type14` int NOT NULL DEFAULT '0',\
    `weapon15` int NOT NULL DEFAULT '0',\
    `ammo15` int NOT NULL DEFAULT '0',\
    `weapon_type15` int NOT NULL DEFAULT '0',\
    `weapon16` int NOT NULL DEFAULT '0',\
    `ammo16` int NOT NULL DEFAULT '0',\
    `weapon_type16` int NOT NULL DEFAULT '0',\
    `weapon17` int NOT NULL DEFAULT '0',\
    `ammo17` int NOT NULL DEFAULT '0',\
    `weapon_type17` int NOT NULL DEFAULT '0',\
    `weapon18` int NOT NULL DEFAULT '0',\
    `ammo18` int NOT NULL DEFAULT '0',\
    `weapon_type18` int NOT NULL DEFAULT '0',\
    `weapon19` int NOT NULL DEFAULT '0',\
    `ammo19` int NOT NULL DEFAULT '0',\
    `weapon_type19` int NOT NULL DEFAULT '0',\
    `weapon20` int NOT NULL DEFAULT '0',\
    `ammo20` int NOT NULL DEFAULT '0',\
    `weapon_type20` int NOT NULL DEFAULT '0',\
    `weapon21` int NOT NULL DEFAULT '0',\
    `ammo21` int NOT NULL DEFAULT '0',\
    `weapon_type21` int NOT NULL DEFAULT '0',\
    `weapon22` int NOT NULL DEFAULT '0',\
    `ammo22` int NOT NULL DEFAULT '0',\
    `weapon_type22` int NOT NULL DEFAULT '0',\
    `weapon23` int NOT NULL DEFAULT '0',\
    `ammo23` int NOT NULL DEFAULT '0',\
    `weapon_type23` int NOT NULL DEFAULT '0',\
    `weapon24` int NOT NULL DEFAULT '0',\
    `ammo24` int NOT NULL DEFAULT '0',\
    `weapon_type24` int NOT NULL DEFAULT '0',\
    `weapon25` int NOT NULL DEFAULT '0',\
    `ammo25` int NOT NULL DEFAULT '0',\
    `weapon_type25` int NOT NULL DEFAULT '0',\
    `weapon26` int NOT NULL DEFAULT '0',\
    `ammo26` int NOT NULL DEFAULT '0',\
    `weapon_type26` int NOT NULL DEFAULT '0',\
    `weapon27` int NOT NULL DEFAULT '0',\
    `ammo27` int NOT NULL DEFAULT '0',\
    `weapon_type27` int NOT NULL DEFAULT '0',\
    `weapon28` int NOT NULL DEFAULT '0',\
    `ammo28` int NOT NULL DEFAULT '0',\
    `weapon_type28` int NOT NULL DEFAULT '0',\
    `weapon29` int NOT NULL DEFAULT '0',\
    `ammo29` int NOT NULL DEFAULT '0',\
    `weapon_type29` int NOT NULL DEFAULT '0',\
    `weapon30` int NOT NULL DEFAULT '0',\
    `ammo30` int NOT NULL DEFAULT '0',\
    `weapon_type30` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");
    print("[DATABASE] Tabela vehicles_weapons checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_weapons checada com sucesso.");
    logCreate(99998, logString, 5);
}

void:CheckPoolTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `pool_tables` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `positionX` float NOT NULL DEFAULT '0',\
    `positionY` float NOT NULL DEFAULT '0',\
    `positionZ` float NOT NULL DEFAULT '0',\
    `positionA` float NOT NULL DEFAULT '0',\
    `virtual_world` int NOT NULL DEFAULT '0',\
    `interior` int NOT NULL DEFAULT '0',\
    `skin` varchar(64) NOT NULL DEFAULT 'POOL_SKIN_DEFAULT',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela pool_tables checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela pool_tables checada com sucesso.");
    logCreate(99998, logString, 5);
}

void:CheckHousesTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `houses` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `character_id` int DEFAULT '0',\
    `address` varchar(256) DEFAULT 'Endereço desconhecido',\
    `locked` int DEFAULT '0',\
    `price` int DEFAULT '0',\
    `storage_money` int DEFAULT '0',\
    `entry_x` float DEFAULT '0',\
    `entry_y` float DEFAULT '0',\
    `entry_z` float DEFAULT '0',\
    `entry_a` float DEFAULT '0',\
    `vw_entry` int DEFAULT '0',\
    `interior_entry` int DEFAULT '0',\
    `exit_x` float DEFAULT '0',\
    `exit_y` float DEFAULT '0',\
    `exit_z` float DEFAULT '0',\
    `exit_a` float DEFAULT '0',\
    `vw_exit` int DEFAULT '0',\
    `interior_exit` int DEFAULT '0',\
    PRIMARY KEY (`id`));");
    
    print("[DATABASE] Tabela houses checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela houses checada com sucesso.");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `houses_other_entries` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `house_id` int DEFAULT '0',\
    `locked` int DEFAULT '0',\
    `entry_x` float DEFAULT '0',\
    `entry_y` float DEFAULT '0',\
    `entry_z` float DEFAULT '0',\
    `entry_a` float DEFAULT '0',\
    `vw_entry` int DEFAULT '0',\
    `interior_entry` int DEFAULT '0',\
    `exit_x` float DEFAULT '0',\
    `exit_y` float DEFAULT '0',\
    `exit_z` float DEFAULT '0',\
    `exit_a` float DEFAULT '0',\
    `vw_exit` int DEFAULT '0',\
    `interior_exit` int DEFAULT '0',\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela houses_other_entries checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela houses_other_entries checada com sucesso.");
}

void:CheckTradingTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `tradings` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(64) NOT NULL DEFAULT 'Nenhum',\
    `symbol` varchar(16) NOT NULL DEFAULT 'N/A',\
    `description` varchar(124) NOT NULL DEFAULT 'N/A',\
    `type` int NOT NULL DEFAULT '0',\
    `capital` float NOT NULL DEFAULT '0.0',\
    `oldbuy_value` float NOT NULL DEFAULT '0.0',\
    `buy_value` float NOT NULL DEFAULT '0.0',\
    `sell_value` float NOT NULL DEFAULT '0.0',\
    `max_value` float NOT NULL DEFAULT '0.0',\
    `min_value` float NOT NULL DEFAULT '0.0',\
    `max_slots` int NOT NULL DEFAULT '0',\
    `sold_slots` int NOT NULL DEFAULT '0',\
    `variation` float NOT NULL DEFAULT '0.0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela tradings checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela tradings checada com sucesso.");
    logCreate(99998, logString, 5);
 
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `tradings_owners` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `trading_id` int NOT NULL DEFAULT '0',\
    `character_id` int NOT NULL DEFAULT '0',\
    `bought_price` int NOT NULL DEFAULT '0',\
    `quantity` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela tradings_owners checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela tradings_owners checada com sucesso.");
    logCreate(99998, logString, 5);
}