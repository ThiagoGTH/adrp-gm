/*
 
Esse módulo é dedicado integralmente a lidar com conexões e integrações com o MySQL. Mas isso não implica que outros módulos não possam extrair, salvar ou inserir informações no mesmo banco de dados de maneira segura, estando ordenadas e documentadas.
*/

#include <YSI_Coding\y_hooks>
#include "modules\core\database\mysql_functions.pwn"

hook OnGameModeInit() {
    new DB_HOST[128];
    if(Env_Has("MYSQL_HOST")) {
        Env_Get("MYSQL_HOST", DB_HOST, sizeof(DB_HOST));
    }

    new DB_USER[128];
    if(Env_Has("MYSQL_USER")) {
        Env_Get("MYSQL_USER", DB_USER, sizeof(DB_USER));
    }

    new DB_PASSWORD[128];
    if(Env_Has("MYSQL_PASSWORD")) {
        Env_Get("MYSQL_PASSWORD", DB_PASSWORD, sizeof(DB_PASSWORD));
    }

    new DB_NAME[128];
    if(Env_Has("MYSQL_DATABASE")) {
        Env_Get("MYSQL_DATABASE", DB_NAME, sizeof(DB_NAME));
    }

    DBConn = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
    mysql_log(ERROR);
    new MySQLOpt: options = mysql_init_options();
    mysql_set_option(options, AUTO_RECONNECT, true);
    mysql_set_option(options, MULTI_STATEMENTS, true);
    mysql_set_option(options, POOL_SIZE, 2);

    if(mysql_errno(DBConn)) {
        print("\n[DATABASE] Houve um erro na tentativa de conexão com o MySQL.");
        print("[DATABASE] Para obter mais detalhes, acesse a pasta de logging do plug-in.");
        print("[DATABASE] Desligando o servidor...\n");

        format(logString, sizeof(logString), "SYSTEM: Houve um erro na tentativa de conexão com o MySQL. Para obter mais detalhes, acesse a pasta de logging do plug-in. O servidor será desligado.");
        logCreate(99998, logString, 5);
        
        SendRconCommand("exit");
    } else {
        print("[DATABASE] A conexão com o MySQL foi feita com sucesso");
        print("[DATABASE] Verificando criação de tabelas...");
        mysql_set_charset("latin1");
        CheckTables();
    }
    return true;
}

void:CheckTables() {
    CheckLogsTable();
    CheckUserTable();
    CheckUCPTable();
    CheckPlayerTable();
    CheckItemsTable();
    CheckBanTable();
    CheckFurnitureInfoTable();
    CheckAdsTable();
    CheckVehiclesTable();
    CheckPoolTable();
    CheckHousesTable();
    CheckBusinesssTable();
    CheckInteriorsTable();
    CheckPHONESTable();
    CheckTradingTable();
    CheckFactionsTable();
    CheckGraffitisTable();
    CheckBankTable();
    CheckStorageBusinessTable();
    CheckGaragesTable();
    //CheckSignalTower();
    CheckPhoneSms();
    CheckPhoneContacts();
    print("[DATABASE] Todas tabelas foram carregadas com sucesso");
    print("* Note que se alguma tabela faltar, funções não funcionarão de modo correto.\n");
}

void:CheckUserTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `users` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `username` varchar(24),\
    `password` varchar(128),\
    `email` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `discord_tag` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `discord_id` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `forum_username` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `registration_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `registration_ip2` varchar(200) NOT NULL DEFAULT 'Nenhum',\
    `registration_fingerprint` varchar(200) NOT NULL DEFAULT 'Nenhum',\
    `registration_date` int NOT NULL DEFAULT '0',\
    `last_login` int NOT NULL DEFAULT '0',\
    `admin` int NOT NULL DEFAULT 0,\
    `hours` int NOT NULL DEFAULT 0,\
    `dutytime` int NOT NULL DEFAULT 0,\
    `SOSAns` int NOT NULL DEFAULT 0,\
    `APPAns` int NOT NULL DEFAULT 0,\
    `redflag` int NOT NULL DEFAULT 0,\
    `newbie` int NOT NULL DEFAULT 0,\
    `jailtime` int NOT NULL DEFAULT -1,\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela users checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela users checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `users_premium` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT '0',\
    `points` int NOT NULL DEFAULT '0',\
    `name_changes` int NOT NULL DEFAULT '0',\
    `number_changes` int NOT NULL DEFAULT '0',\
    `fight_changes` int NOT NULL DEFAULT '0',\
    `plate_changes` int NOT NULL DEFAULT '0',\
    `chars_slots` int NOT NULL DEFAULT '5',\
    `custom_walks` int NOT NULL DEFAULT '0',\
    `vehicle_namechanges` int NOT NULL DEFAULT '0',\
    `custom_skins` int NOT NULL DEFAULT '0',\
    `pets` int NOT NULL DEFAULT '0',\
    `character_permanent_slots` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));"); 

    print("[DATABASE] Tabela users_premium checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela users_premium checada com sucesso");
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
    `announcement_team` int NOT NULL DEFAULT 0,\
    `post_team` int NOT NULL DEFAULT 0,\
    `ad_points` int NOT NULL DEFAULT 0,\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela users_teams checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela users_teams checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckPlayerTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `user_id` int NOT NULL DEFAULT '0',\
    `registration_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `registration_date` int NOT NULL DEFAULT '0',\
    `first_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `last_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `first_login` int NOT NULL DEFAULT '0',\
    `last_login` int NOT NULL DEFAULT '0',\
    `donator` int NOT NULL DEFAULT '0',\
    `donator_time` int NOT NULL DEFAULT '0',\
    `dateofbirth` varchar(16) NOT NULL DEFAULT '10800',\
    `minutes` int NOT NULL DEFAULT '0',\
    `hours` int NOT NULL DEFAULT '0',\
    `origin` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `money` int NOT NULL DEFAULT '0',\
    `payment` int NOT NULL DEFAULT '0',\
    `taxes` int NOT NULL DEFAULT '0',\
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

    print("[DATABASE] Tabela players checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players checada com sucesso");
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

    print("[DATABASE] Tabela players_apparence checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_apparence checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS players_license (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `license_number` int NOT NULL DEFAULT 0,\
    `license_status` int NOT NULL DEFAULT 0,\
    `license_warnings` int NOT NULL DEFAULT 0,\
	`license_vehicle` int NOT NULL DEFAULT 0,\
    `license_plane` int NOT NULL DEFAULT 0,\
	`license_medical` int NOT NULL DEFAULT 0,\
	`license_gun` int NOT NULL DEFAULT 0,\
	`warning_one` varchar(128) NOT NULL DEFAULT 'Vazio',\
	`warning_two` varchar(128) NOT NULL DEFAULT 'Vazio',\
	`warning_three` varchar(128) NOT NULL DEFAULT 'Vazio',\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela players_license checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_license checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_faction` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `faction_id` int NOT NULL DEFAULT '-1',\
    `faction_rank` int NOT NULL DEFAULT '-1',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_faction checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_faction checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_radio` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `pRadioNvl` int NOT NULL,\
    `rRadioState` int NOT NULL,\
    `rRadioSlot1` int NOT NULL,\
    `rRadioSlot2` int NOT NULL,\
    `rRadioSlot3` int NOT NULL,\
    `rRadioSlot4` int NOT NULL,\
    `rRadioSlot5` int NOT NULL,\
    `rRadioSlot6` int NOT NULL,\
    `rRadioSlot7` int NOT NULL,\
    `rRadioName1` varchar(32) NOT NULL DEFAULT '0',\
    `rRadioName2` varchar(32) NOT NULL DEFAULT '0',\
    `rRadioName3` varchar(32) NOT NULL DEFAULT '0',\
    `rRadioName4` varchar(32) NOT NULL DEFAULT '0',\
    `rRadioName5` varchar(32) NOT NULL DEFAULT '0',\
    `rRadioName6` varchar(32) NOT NULL DEFAULT '0',\
    `rRadioName7` varchar(32) NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_radio checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_radio checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_premium` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `donator` int NOT NULL DEFAULT '0',\
    `donator_time` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_premium checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_premium checada com sucesso");
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

    print("[DATABASE] Tabela players_weapons checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_weapons checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_inv` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL DEFAULT '0',\
    `item1` int NOT NULL DEFAULT '0',\
    `amount1` int NOT NULL DEFAULT '0',\
    `item2` int NOT NULL DEFAULT '0',\
    `amount2` int NOT NULL DEFAULT '0',\
    `item3` int NOT NULL DEFAULT '0',\
    `amount3` int NOT NULL DEFAULT '0',\
    `item4` int NOT NULL DEFAULT '0',\
    `amount4` int NOT NULL DEFAULT '0',\
    `item5` int NOT NULL DEFAULT '0',\
    `amount5` int NOT NULL DEFAULT '0',\
    `item6` int NOT NULL DEFAULT '0',\
    `amount6` int NOT NULL DEFAULT '0',\
    `item7` int NOT NULL DEFAULT '0',\
    `amount7` int NOT NULL DEFAULT '0',\
    `item8` int NOT NULL DEFAULT '0',\
    `amount8` int NOT NULL DEFAULT '0',\
    `item9` int NOT NULL DEFAULT '0',\
    `amount9` int NOT NULL DEFAULT '0',\
    `item10` int NOT NULL DEFAULT '0',\
    `amount10` int NOT NULL DEFAULT '0',\
    `item11` int NOT NULL DEFAULT '0',\
    `amount11` int NOT NULL DEFAULT '0',\
    `item12` int NOT NULL DEFAULT '0',\
    `amount12` int NOT NULL DEFAULT '0',\
    `item13` int NOT NULL DEFAULT '0',\
    `amount13` int NOT NULL DEFAULT '0',\
    `item14` int NOT NULL DEFAULT '0',\
    `amount14` int NOT NULL DEFAULT '0',\
    `item15` int NOT NULL DEFAULT '0',\
    `amount15` int NOT NULL DEFAULT '0',\
    `item16` int NOT NULL DEFAULT '0',\
    `amount16` int NOT NULL DEFAULT '0',\
    `item17` int NOT NULL DEFAULT '0',\
    `amount17` int NOT NULL DEFAULT '0',\
    `item18` int NOT NULL DEFAULT '0',\
    `amount18` int NOT NULL DEFAULT '0',\
    `item19` int NOT NULL DEFAULT '0',\
    `amount19` int NOT NULL DEFAULT '0',\
    `item20` int NOT NULL DEFAULT '0',\
    `amount20` int NOT NULL DEFAULT '0',\
    `item21` int NOT NULL DEFAULT '0',\
    `amount21` int NOT NULL DEFAULT '0',\
    `item22` int NOT NULL DEFAULT '0',\
    `amount22` int NOT NULL DEFAULT '0',\
    `item23` int NOT NULL DEFAULT '0',\
    `amount23` int NOT NULL DEFAULT '0',\
    `item24` int NOT NULL DEFAULT '0',\
    `amount24` int NOT NULL DEFAULT '0',\
    `item25` int NOT NULL DEFAULT '0',\
    `amount25` int NOT NULL DEFAULT '0',\
    `item26` int NOT NULL DEFAULT '0',\
    `amount26` int NOT NULL DEFAULT '0',\
    `item27` int NOT NULL DEFAULT '0',\
    `amount27` int NOT NULL DEFAULT '0',\
    `item28` int NOT NULL DEFAULT '0',\
    `amount28` int NOT NULL DEFAULT '0',\
    `item29` int NOT NULL DEFAULT '0',\
    `amount29` int NOT NULL DEFAULT '0',\
    `item30` int NOT NULL DEFAULT '0',\
    `amount30` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_inv checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_inv checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_pet` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `pet_model` int NOT NULL DEFAULT '0',\
    `pet_name` varchar(128) NOT NULL DEFAULT 'Jack',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_pet checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_pet checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_config` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `newbie_chat` int NOT NULL DEFAULT '0',\
    `faction_chat` int NOT NULL DEFAULT '0',\
    `admin_chat` int NOT NULL DEFAULT '0',\
    `nametag` int NOT NULL DEFAULT '0',\
    `objects` int NOT NULL DEFAULT '0',\
    `speedo` int NOT NULL DEFAULT '1',\
    `hud` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_config checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_config checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players_status` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character_id` int NOT NULL,\
    `hunger` int NOT NULL DEFAULT '100',\
    `thirst` int NOT NULL DEFAULT '100',\
    `stamina` int NOT NULL DEFAULT '1500',\
    `max_stamina` int NOT NULL DEFAULT '1500',\
    `addiction` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players_config checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_config checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_tquery(DBConn, "CREATE TABLE IF NOT EXISTS `players_taxes` (\
	  	`ID` int(11) NOT NULL auto_increment,\
	  	`character_id` int(11) NOT NULL,\
	  	`type` smallint(1) NOT NULL,\
	  	`amount` int(11) NOT NULL,\
	  	`date` int(11) NOT NULL,\
	    PRIMARY KEY  (`ID`)\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

    print("[DATABASE] Tabela players_taxes checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players_taxes checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckItemsTable() { 
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `items` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `item_name` varchar(64) NOT NULL DEFAULT 'Nenhum',\
    `item_desc` varchar(256) NOT NULL DEFAULT 'Nenhum',\
    `item_useful` int NOT NULL DEFAULT '0',\
    `item_legality` int NOT NULL DEFAULT '0',\
    `item_model` int NOT NULL DEFAULT '0',\
    `item_category` int NOT NULL DEFAULT '0',\
    `item_price` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela items checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela items checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `items_dropped` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `item_id` int NOT NULL DEFAULT '0',\
    `item_player` int NOT NULL DEFAULT '0',\
    `item_model` int NOT NULL DEFAULT '0',\
    `item_quantity` int NOT NULL DEFAULT '0',\
    `item_weapon` int NOT NULL DEFAULT '0',\
    `item_ammo` int NOT NULL DEFAULT '0',\
    `item_int` int NOT NULL DEFAULT '0',\
    `item_world` int NOT NULL DEFAULT '0',\
    `item_object` int NOT NULL DEFAULT '0',\
    `item_positionX` float NOT NULL DEFAULT '0.0',\
    `item_positionY` float NOT NULL DEFAULT '0.0',\
    `item_positionZ` float NOT NULL DEFAULT '0.0',\
    `item_positionA` float NOT NULL DEFAULT '0.0',\
    `item_positionRX` float NOT NULL DEFAULT '0.0',\
    `item_positionRY` float NOT NULL DEFAULT '0.0',\
    `item_positionRZ` float NOT NULL DEFAULT '0.0',\
    `item_positionRA` float NOT NULL DEFAULT '0.0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela items checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela items checada com sucesso");
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

    print("[DATABASE] Tabela ban checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ban checada com sucesso");
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

    print("[DATABASE] Tabela serverlogs checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela serverlogs checada com sucesso");
    logCreate(99998, logString, 5);
} 

void:CheckFurnitureInfoTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `furniture_info` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(64) NOT NULL DEFAULT 'Nenhum',\
    `model` int NOT NULL DEFAULT '0',\
    `category` varchar(64) NOT NULL DEFAULT 'Nenhum',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela furniture_info checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela furniture_info checada com sucesso");
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

    print("[DATABASE] Tabela advertisement checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela advertisement checada com sucesso");
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
    `plate` varchar(128) NOT NULL DEFAULT 'Invalid',\
    `personalized_plate` int NOT NULL DEFAULT '0',\
    `caravan` int NOT NULL DEFAULT '0',\
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
    print("[DATABASE] Tabela vehicles checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles_caravan` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `vehicle_id` int NOT NULL DEFAULT '0',\
    `caravan_model_id` int NOT NULL DEFAULT '0',\
    `caravan_model_name` varchar(64) NOT NULL DEFAULT 'Default',\
    `caravan_type` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela vehicles_caravan checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_caravan checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles_dealer` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `category` int NOT NULL DEFAULT '0',\
    `model_id` int NOT NULL DEFAULT '0',\
    `price` int NOT NULL DEFAULT '0',\
    `premium` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela vehicles_dealer checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_dealer checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles_damages` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `vehicle_id` int NOT NULL DEFAULT '0',\
    `panels_status` int NOT NULL DEFAULT '0',\
    `doors_status` int NOT NULL DEFAULT '0',\
    `lights_status` int NOT NULL DEFAULT '0',\
    `tires_status` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela vehicles_damages checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_damages checada com sucesso");
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

    print("[DATABASE] Tabela vehicles_stats checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_stats checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles_objects` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `vehicle_id` int NOT NULL DEFAULT '0',\
    `object_1` int NOT NULL DEFAULT '0',\
    `ofX_1` float NOT NULL DEFAULT '0.0',\
    `ofY_1` float NOT NULL DEFAULT '0.0',\
    `ofZ_1` float NOT NULL DEFAULT '0.0',\
    `rX_1` float NOT NULL DEFAULT '0.0',\
    `rY_1` float NOT NULL DEFAULT '0.0',\
    `rZ_1` float NOT NULL DEFAULT '0.0',\
    `object_2` int NOT NULL DEFAULT '0',\
    `ofX_2` float NOT NULL DEFAULT '0.0',\
    `ofY_2` float NOT NULL DEFAULT '0.0',\
    `ofZ_2` float NOT NULL DEFAULT '0.0',\
    `rX_2` float NOT NULL DEFAULT '0.0',\
    `rY_2` float NOT NULL DEFAULT '0.0',\
    `rZ_2` float NOT NULL DEFAULT '0.0',\
    `object_3` int NOT NULL DEFAULT '0',\
    `ofX_3` float NOT NULL DEFAULT '0.0',\
    `ofY_3` float NOT NULL DEFAULT '0.0',\
    `ofZ_3` float NOT NULL DEFAULT '0.0',\
    `rX_3` float NOT NULL DEFAULT '0.0',\
    `rY_3` float NOT NULL DEFAULT '0.0',\
    `rZ_3` float NOT NULL DEFAULT '0.0',\
    `object_4` int NOT NULL DEFAULT '0',\
    `ofX_4` float NOT NULL DEFAULT '0.0',\
    `ofY_4` float NOT NULL DEFAULT '0.0',\
    `ofZ_4` float NOT NULL DEFAULT '0.0',\
    `rX_4` float NOT NULL DEFAULT '0.0',\
    `rY_4` float NOT NULL DEFAULT '0.0',\
    `rZ_4` float NOT NULL DEFAULT '0.0',\
    `object_5` int NOT NULL DEFAULT '0',\
    `ofX_5` float NOT NULL DEFAULT '0.0',\
    `ofY_5` float NOT NULL DEFAULT '0.0',\
    `ofZ_5` float NOT NULL DEFAULT '0.0',\
    `rX_5` float NOT NULL DEFAULT '0.0',\
    `rY_5` float NOT NULL DEFAULT '0.0',\
    `rZ_5` float NOT NULL DEFAULT '0.0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela vehicles_objects checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_objects checada com sucesso");
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

    print("[DATABASE] Tabela vehicles_tunings checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_tunings checada com sucesso");
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

    print("[DATABASE] Tabela vehicles_weapons checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles_weapons checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckPoolTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `pool_tables` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `positionX` float NOT NULL DEFAULT '0',\
    `positionY` float NOT NULL DEFAULT '0',\
    `positionZ` float NOT NULL DEFAULT '0',\
    `positionA` float NOT NULL DEFAULT '0',\
    `virtual_world` int NOT NULL DEFAULT '0',\
    `interior` int NOT NULL DEFAULT '0',\
    `skin` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela pool_tables checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela pool_tables checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckHousesTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `houses` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `character_id` int DEFAULT '0',\
    `address` varchar(256) DEFAULT 'Endereço desconhecido',\
    `garage_id` int DEFAULT '0',\
    `locked` int DEFAULT '0',\
    `price` int DEFAULT '0',\
    `rentable` int DEFAULT '0',\
    `rent` int DEFAULT '0',\
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
    
    print("[DATABASE] Tabela houses checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela houses checada com sucesso");
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

    print("[DATABASE] Tabela houses_other_entries checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela houses_other_entries checada com sucesso");
}

void:CheckBusinesssTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `business` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `character_id` int DEFAULT '0',\
    `address` varchar(256) DEFAULT 'Endereço desconhecido',\
    `locked` int DEFAULT '0',\
    `name` varchar(256) DEFAULT 'Empresa desconhecida',\
    `type` int DEFAULT '0',\
    `inventory` int DEFAULT '0',\
    `storage_money` int DEFAULT '0',\
    `price` int DEFAULT '0',\
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
    
    print("[DATABASE] Tabela business checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela business checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckInteriorsTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `interiors` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(256) DEFAULT 'Indefinido',\
    `status` int DEFAULT '0',\
    `type` int DEFAULT '0',\
    `interior` int DEFAULT '0',\
    `world` int DEFAULT '0',\
    `int_x` float DEFAULT '0',\
    `int_y` float DEFAULT '0',\
    `int_z` float DEFAULT '0',\
    `int_a` float DEFAULT '0',\
    PRIMARY KEY (`id`));");
    
    print("[DATABASE] Tabela interiors checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela interiors checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckPHONESTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `payphone` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `object` int,\
    `position_x` float DEFAULT '0',\
    `position_y` float DEFAULT '0',\
    `position_z` float DEFAULT '0',\
    `position_a` float DEFAULT '0',\
    `interior` int DEFAULT '0',\
    `world` int DEFAULT '0',\
    `status` int DEFAULT '0',\
    PRIMARY KEY (`id`));");
    
    print("[DATABASE] Tabela payphone checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela payphone checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckTradingTable() {
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

    print("[DATABASE] Tabela tradings checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela tradings checada com sucesso");
    logCreate(99998, logString, 5);
 
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `tradings_owners` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `trading_id` int NOT NULL DEFAULT '0',\
    `character_id` int NOT NULL DEFAULT '0',\
    `bought_price` int NOT NULL DEFAULT '0',\
    `quantity` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela tradings_owners checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela tradings_owners checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckUCPTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_apps` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL,\
    `fullname` varchar(128) NOT NULL,\
    `origin` varchar(128) NOT NULL,\
    `birthdate` int NOT NULL DEFAULT '0',\
    `gender` int NOT NULL DEFAULT '0',\
    `ethnicity` int NOT NULL DEFAULT '0',\
    `build` int NOT NULL DEFAULT '0',\
    `color_eyes` int NOT NULL DEFAULT '0',\
    `color_hair` int NOT NULL DEFAULT '0',\
    `height` int NOT NULL DEFAULT '0',\
    `weigth` float NOT NULL DEFAULT '0',\
    `default_skin` int NOT NULL DEFAULT '2',\
    `description_apparence` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `history` text,\
    `question1` text,\
    `question2` text,\
    `answer1` text,\
    `answer2` text,\
    `ip` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `send_date` int NOT NULL DEFAULT '0',\
    `status` varchar(128) NOT NULL DEFAULT '0',\
    `admin` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `correction_admin` int NOT NULL DEFAULT '0',\
    `reason` text,\
    `valuation_date` int(11) NOT NULL DEFAULT '0',\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela ucp_apps checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_apps checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_posts` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `user_id` int DEFAULT '0',\
    `post_title` text NOT NULL,\
    `post_desc` text NOT NULL,\
    `post_img` text NOT NULL,\
    `post_send_date` int NOT NULL DEFAULT '0',\
    `post_target_img` text NOT NULL,\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela ucp_posts checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_posts checada com sucesso");
    logCreate(99998, logString, 5);
 
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_choices` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `question_number` int NOT NULL,\
    `is_correct` tinyint(1) NOT NULL DEFAULT 0,\
    `text` text,\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela ucp_choices checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_choices checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_notifications` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL, \
    `notification_title` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `notification_body` text,\
    `notification_author` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `notification_send_date` int NOT NULL DEFAULT '0',\
    `notification_read` tinyint(1) NOT NULL DEFAULT '0',\
    `notification_read_date` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela ucp_notifications checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_notifications checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_questions` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `question_number` int NOT NULL,\
    `text` text,\
    `target` text,\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela ucp_questions checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_questions checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_announcements` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT '0',\
    `title` text,\
    `body` text,\
    `type` int NOT NULL DEFAULT '0',\
    `target` int NOT NULL DEFAULT '0',\
    `showing` int NOT NULL DEFAULT '0',\
    `send_date` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela ucp_announcements checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_announcements checada com sucesso");
    logCreate(99998, logString, 5);    

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_apps_customskins` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT '0',\
    `character_id` int NOT NULL DEFAULT '0',\
    `default_ped_id` int NOT NULL DEFAULT '0',\
    `custom_ped_id` int NOT NULL DEFAULT '0',\
    `dff_archive` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `txd_archive` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `img_preview_skin` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `ip_send` varchar(120) NOT NULL DEFAULT 'Nenhum',\
    `send_date` int(11) NOT NULL DEFAULT '0',\
    `status` int(11) NOT NULL DEFAULT '0',\
    `admin` varchar(120) NOT NULL DEFAULT 'Nenhum',\
    `reason` text,\
    `valuation_date` int(11) NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela ucp_apps_customskins checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_apps_customskins checada com sucesso");
    logCreate(99998, logString, 5);    

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_events` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT '0',\
    `event_title` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `event_desc` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `event_img` text,\
    `event_postat` int NOT NULL DEFAULT '0',\
    `event_startat` int NOT NULL DEFAULT '0',\
    `event_endat` int NOT NULL DEFAULT '0',\
    `event_location` text,\
    `event_status` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela ucp_events checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_events checada com sucesso");
    logCreate(99998, logString, 5);     

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_logs` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `character` varchar(255) NOT NULL DEFAULT 'Nenhum',\
    `user` varchar(255) NOT NULL DEFAULT 'Nenhum',\
    `ip` varchar(255) NOT NULL DEFAULT 'Nenhum',\
    `timestamp` int NOT NULL DEFAULT '0',\
    `log` text,\
    `type` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela ucp_logs checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_logs checada com sucesso");
    logCreate(99998, logString, 5);       

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_transactions` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT '0',\
    `email` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `product` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `price` int NOT NULL DEFAULT '0',\
    `external_reference` bigint NOT NULL DEFAULT '0',\
    `payment_id` int NOT NULL DEFAULT '0',\
    `purchase_date` int NOT NULL DEFAULT '0',\
    `update_date` int NOT NULL DEFAULT '0',\
    `status` int NOT NULL DEFAULT '0',\
    `payment_type` varchar(255) NOT NULL DEFAULT 'Nenhum',\
    PRIMARY KEY (`id`));");

    print("[DATABASE] Tabela ucp_transactions checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_transactions checada com sucesso");
    logCreate(99998, logString, 5);     

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `users_teams_permissions` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT '0',\
    `team` text,\
    `head_team` int NOT NULL DEFAULT '0',\
    `allow_create` int NOT NULL DEFAULT '0',\
    `allow_edit` int NOT NULL DEFAULT '0',\
    `allow_delete` int NOT NULL DEFAULT '0',\
    `allow_manage` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela users_teams_permissions checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela users_teams_permissions checada com sucesso");
    logCreate(99998, logString, 5);
    
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ucp_request_premium` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT '0',\
    `old_ucp` varchar(255) NOT NULL DEFAULT 'Nenhum',\
    `old_character` varchar(255) NOT NULL DEFAULT 'Nenhum',\
    `old_premium` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `evidences` text,\
    `ip` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `status` int NOT NULL DEFAULT '0',\
    `admin` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `reason` text,\
    `sendat` int NOT NULL DEFAULT '0',\
    `updatedat` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`id`));"); 

    print("[DATABASE] Tabela ucp_request_premium checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela ucp_request_premium checada com sucesso");
    logCreate(99998, logString, 5); 

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `custom_skins` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `user_id` int NOT NULL DEFAULT '0',\
    `character_id` int NOT NULL DEFAULT '0',\
    `skin_id` int NOT NULL DEFAULT '0',\
    `skin_time` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));"); 

    print("[DATABASE] Tabela custom_skins checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela custom_skins checada com sucesso");
    logCreate(99998, logString, 5); 
}

void:CheckFactionsTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS factions (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(32) NOT NULL DEFAULT 'Nenhum',\
    `type` int NOT NULL DEFAULT '0',\
    `color` int NOT NULL DEFAULT '0',\
    `maxranks` int NOT NULL DEFAULT '0',\
    `locker` int NOT NULL DEFAULT '0',\
    `vault` int NOT NULL DEFAULT '0',\
    `status` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela factions checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela factions checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS factions_locker (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `faction_id` int NOT NULL DEFAULT '0',\
    `x` float NOT NULL DEFAULT '0.0',\
    `y` float NOT NULL DEFAULT '0.0',\
    `z` float NOT NULL DEFAULT '0.0',\
    `int` int NOT NULL DEFAULT '0',\
    `world` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela factions_lockers checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela factions_lockers checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS factions_skins (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `faction_id` int NOT NULL DEFAULT '0',\
    `skin1` int NOT NULL,\
    `skin2` int NOT NULL,\
    `skin3` int NOT NULL,\
    `skin4` int NOT NULL,\
    `skin5` int NOT NULL,\
    `skin6` int NOT NULL,\
    `skin7` int NOT NULL,\
    `skin8` int NOT NULL,\
    `skin9` int NOT NULL,\
    `skin10` int NOT NULL,\
    `skin11` int NOT NULL,\
    `skin12` int NOT NULL,\
    `skin13` int NOT NULL,\
    `skin14` int NOT NULL,\
    `skin15` int NOT NULL,\
    `skin16` int NOT NULL,\
    `skin17` int NOT NULL,\
    `skin18` int NOT NULL,\
    `skin19` int NOT NULL,\
    `skin20` int NOT NULL,\
    `skin21` int NOT NULL,\
    `skin22` int NOT NULL,\
    `skin23` int NOT NULL,\
    `skin24` int NOT NULL,\
    `skin25` int NOT NULL,\
    `skin26` int NOT NULL,\
    `skin27` int NOT NULL,\
    `skin28` int NOT NULL,\
    `skin29` int NOT NULL,\
    `skin30` int NOT NULL,\
    `skin31` int NOT NULL,\
    `skin32` int NOT NULL,\
    `skin33` int NOT NULL,\
    `skin34` int NOT NULL,\
    `skin35` int NOT NULL,\
    `skin36` int NOT NULL,\
    `skin37` int NOT NULL,\
    `skin38` int NOT NULL,\
    `skin39` int NOT NULL,\
    `skin40` int NOT NULL,\
    `skin41` int NOT NULL,\
    `skin42` int NOT NULL,\
    `skin43` int NOT NULL,\
    `skin44` int NOT NULL,\
    `skin45` int NOT NULL,\
    `skin46` int NOT NULL,\
    `skin47` int NOT NULL,\
    `skin48` int NOT NULL,\
    `skin49` int NOT NULL,\
    `skin50` int NOT NULL,\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela factions_skins checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela factions_skins checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS factions_ranks (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `faction_id` int NOT NULL DEFAULT '0',\
    `rank1` varchar(256) DEFAULT 'Vazio',\
    `paycheck1` int NOT NULL,\
    `rank2` varchar(256) DEFAULT 'Vazio',\
    `paycheck2` int NOT NULL,\
    `rank3` varchar(256) DEFAULT 'Vazio',\
    `paycheck3` int NOT NULL,\
    `rank4` varchar(256) DEFAULT 'Vazio',\
    `paycheck4` int NOT NULL,\
    `rank5` varchar(256) DEFAULT 'Vazio',\
    `paycheck5` int NOT NULL,\
    `rank6` varchar(256) DEFAULT 'Vazio',\
    `paycheck6` int NOT NULL,\
    `rank7` varchar(256) DEFAULT 'Vazio',\
    `paycheck7` int NOT NULL,\
    `rank8` varchar(256) DEFAULT 'Vazio',\
    `paycheck8` int NOT NULL,\
    `rank9` varchar(256) DEFAULT 'Vazio',\
    `paycheck9` int NOT NULL,\
    `rank10` varchar(256) DEFAULT 'Vazio',\
    `paycheck10` int NOT NULL,\
    `rank11` varchar(256) DEFAULT 'Vazio',\
    `paycheck11` int NOT NULL,\
    `rank12` varchar(256) DEFAULT 'Vazio',\
    `paycheck12` int NOT NULL,\
    `rank13` varchar(256) DEFAULT 'Vazio',\
    `paycheck13` int NOT NULL,\
    `rank14` varchar(256) DEFAULT 'Vazio',\
    `paycheck14` int NOT NULL,\
    `rank15` varchar(256) DEFAULT 'Vazio',\
    `paycheck15` int NOT NULL,\
    `rank16` varchar(256) DEFAULT 'Vazio',\
    `paycheck16` int NOT NULL,\
    `rank17` varchar(256) DEFAULT 'Vazio',\
    `paycheck17` int NOT NULL,\
    `rank18` varchar(256) DEFAULT 'Vazio',\
    `paycheck18` int NOT NULL,\
    `rank19` varchar(256) DEFAULT 'Vazio',\
    `paycheck19` int NOT NULL,\
    `rank20` varchar(256) DEFAULT 'Vazio',\
    `paycheck20` int NOT NULL,\
    `rank21` varchar(256) DEFAULT 'Vazio',\
    `paycheck21` int NOT NULL,\
    `rank22` varchar(256) DEFAULT 'Vazio',\
    `paycheck22` int NOT NULL,\
    `rank23` varchar(256) DEFAULT 'Vazio',\
    `paycheck23` int NOT NULL,\
    `rank24` varchar(256) DEFAULT 'Vazio',\
    `paycheck24` int NOT NULL,\
    `rank25` varchar(256) DEFAULT 'Vazio',\
    `paycheck25` int NOT NULL,\
    `rank26` varchar(256) DEFAULT 'Vazio',\
    `paycheck26` int NOT NULL,\
    `rank27` varchar(256) DEFAULT 'Vazio',\
    `paycheck27` int NOT NULL,\
    `rank28` varchar(256) DEFAULT 'Vazio',\
    `paycheck28` int NOT NULL,\
    `rank29` varchar(256) DEFAULT 'Vazio',\
    `paycheck29` int NOT NULL,\
    `rank30` varchar(256) DEFAULT 'Vazio',\
    `paycheck30` int NOT NULL,\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela factions_skins checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela factions_skins checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS factions_weapons (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `faction_id` int NOT NULL DEFAULT '0',\
    `weapon1` int NOT NULL DEFAULT '0',\
    `ammo1` int NOT NULL DEFAULT '0',\
    `weapon2` int NOT NULL DEFAULT '0',\
    `ammo2` int NOT NULL DEFAULT '0',\
    `weapon3` int NOT NULL DEFAULT '0',\
    `ammo3` int NOT NULL DEFAULT '0',\
    `weapon4` int NOT NULL DEFAULT '0',\
    `ammo4` int NOT NULL DEFAULT '0',\
    `weapon5` int NOT NULL DEFAULT '0',\
    `ammo5` int NOT NULL DEFAULT '0',\
    `weapon6` int NOT NULL DEFAULT '0',\
    `ammo6` int NOT NULL DEFAULT '0',\
    `weapon7` int NOT NULL DEFAULT '0',\
    `ammo7` int NOT NULL DEFAULT '0',\
    `weapon8` int NOT NULL DEFAULT '0',\
    `ammo8` int NOT NULL DEFAULT '0',\
    `weapon9` int NOT NULL DEFAULT '0',\
    `ammo9` int NOT NULL DEFAULT '0',\
    `weapon10` int NOT NULL DEFAULT '0',\
    `ammo10` int NOT NULL DEFAULT '0',\
    `weapon11` int NOT NULL DEFAULT '0',\
    `ammo11` int NOT NULL DEFAULT '0',\
    `weapon12` int NOT NULL DEFAULT '0',\
    `ammo12` int NOT NULL DEFAULT '0',\
    `weapon13` int NOT NULL DEFAULT '0',\
    `ammo13` int NOT NULL DEFAULT '0',\
    `weapon14` int NOT NULL DEFAULT '0',\
    `ammo14` int NOT NULL DEFAULT '0',\
    `weapon15` int NOT NULL DEFAULT '0',\
    `ammo15` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela factions_weapons checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela factions_weapons checada com sucesso");
    logCreate(99998, logString, 5);

    return true;
}

void:CheckGraffitisTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS graffiti (\
    `gID` int NOT NULL AUTO_INCREMENT,\
    `gX` float NOT NULL DEFAULT '0.0',\
    `gY` float NOT NULL DEFAULT '0.0',\
    `gZ` float NOT NULL DEFAULT '0.0',\
    `gRX` float NOT NULL DEFAULT '0.0',\
    `gRY` float NOT NULL DEFAULT '0.0',\
    `gRZ` float NOT NULL DEFAULT '0.0',\
    `gText` varchar(64) NOT NULL DEFAULT 'Nenhum',\
    `gFont` varchar(32) NOT NULL DEFAULT 'N/A',\
    `gSize` int NOT NULL DEFAULT '5',\
    `gColor` int NOT NULL DEFAULT '0',\
    `gBold` int NOT NULL DEFAULT '0',\
    `gAuthor` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (gID));");

    print("[DATABASE] Tabela graffits checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela graffits checada com sucesso");
    logCreate(99998, logString, 5);

}

void:CheckGaragesTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `garages` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `character_id` int DEFAULT '0',\
    `house_id` int DEFAULT '0',\
    `address` varchar(256) DEFAULT 'Endereço desconhecido',\
    `locked` int DEFAULT '0',\
    `garage_inv` int DEFAULT '0',\
    `price` int DEFAULT '0',\
    `storage_money` int DEFAULT '0',\
    `storage_item1` int DEFAULT '0',\
    `storage_amount1` int DEFAULT '0',\
    `storage_item2` int DEFAULT '0',\
    `storage_amount2` int DEFAULT '0',\
    `storage_item3` int DEFAULT '0',\
    `storage_amount3` int DEFAULT '0',\
    `storage_item4` int DEFAULT '0',\
    `storage_amount4` int DEFAULT '0',\
    `storage_item5` int DEFAULT '0',\
    `storage_amount5` int DEFAULT '0',\
    `storage_item6` int DEFAULT '0',\
    `storage_amount6` int DEFAULT '0',\
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
    
    print("[DATABASE] Tabela garages checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela garages checada com sucesso");
    logCreate(99998, logString, 5);

}

void:CheckBankTable() {
	mysql_tquery(DBConn, "CREATE TABLE IF NOT EXISTS `bankers` (\
	  `ID` int(11) NOT NULL,\
	  `Skin` smallint(3) NOT NULL,\
	  `PosX` float NOT NULL,\
	  `PosY` float NOT NULL,\
	  `PosZ` float NOT NULL,\
	  `PosA` float NOT NULL,\
      `Interior` int(11) NOT NULL,\
      `VirtualWorld` int(11) NOT NULL,\
	  PRIMARY KEY  (`ID`)\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

    print("[DATABASE] Tabela bankers checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela bankers checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_tquery(DBConn, "CREATE TABLE IF NOT EXISTS `bank_atms` (\
	  `ID` int(11) NOT NULL,\
	  `PosX` float NOT NULL,\
	  `PosY` float NOT NULL,\
	  `PosZ` float NOT NULL,\
	  `RotX` float NOT NULL,\
	  `RotY` float NOT NULL,\
	  `RotZ` float NOT NULL,\
	  PRIMARY KEY  (`ID`)\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

    print("[DATABASE] Tabela bank_atms checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela bank_atms checada com sucesso");
    logCreate(99998, logString, 5);

	mysql_tquery(DBConn, "CREATE TABLE IF NOT EXISTS `bank_accounts` (\
	  `ID` int(11) NOT NULL auto_increment,\
	  `Character_ID` int(11) NOT NULL,\
	  `Password` varchar(32) NOT NULL,\
	  `Balance` int(11) NOT NULL,\
	  `CreatedOn` int(11) NOT NULL,\
	  `LastAccess` int(11) NOT NULL,\
	  PRIMARY KEY  (`ID`)\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

    print("[DATABASE] Tabela bank_accounts checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela bank_accounts checada com sucesso");
    logCreate(99998, logString, 5);

    mysql_tquery(DBConn, "CREATE TABLE IF NOT EXISTS `bank_logs` (\
	  	`ID` int(11) NOT NULL auto_increment,\
	  	`AccountID` int(11) NOT NULL,\
	  	`ToAccountID` int(11) NOT NULL default '-1',\
	  	`Type` smallint(1) NOT NULL,\
	  	`Player` varchar(24) NOT NULL,\
	  	`Amount` int(11) NOT NULL,\
	  	`Date` int(11) NOT NULL,\
	    PRIMARY KEY  (`ID`)\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

    print("[DATABASE] Tabela bank_logs checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela bank_logs checada com sucesso");
    logCreate(99998, logString, 5);
}

void:CheckStorageBusinessTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `business_storage` (\
    `id` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(64) DEFAULT 'Produto sem nome.' ,\
    `model` int DEFAULT '0',\
    `price` int DEFAULT '120',\
    `owner` int DEFAULT '0',\
    `quantity` int DEFAULT '0',\
    `category` int DEFAULT '0',\
    `status` int DEFAULT '0',\
    PRIMARY KEY (`id`));");
    
    print("[DATABASE] Tabela business_storage checada com sucesso");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela business_storage checada com sucesso");
    logCreate(99998, logString, 5);
}

/*void:CheckSignalTower() {
   mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `signal_tower` (\
  `id` int NOT NULL AUTO_INCREMENT,\
  `object` int DEFAULT '0',\
  `position_x` DEFAULT '0',\
  `position_y` DEFAULT '0',\
  `position_z` DEFAULT '0',\
  `position_a` DEFAULT '0',\
  `radius` DEFAULT '0',\
  `name` varchar(64) NOT NULL,\
  `interior` int DEFAULT '0',\
  `world` int DEFAULT '0',\
   PRIMARY KEY (`id`));");

   print("[DATABASE] Tabela signal_tower checada com sucesso");
   format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela signal_tower checada com sucesso");
   logCreate(99998, logString, 5);
}*/

void:CheckPhoneSms() {
   mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `phone_sms` (\
  `id` int NOT NULL AUTO_INCREMENT,\
  `PhoneOwner` int(11) NOT NULL,\
  `PhoneReceive` int(11) NOT NULL,\
  `PhoneSMS` varchar(128) NOT NULL,\
  `ReadSMS` int(11) NOT NULL DEFAULT 0,\
  `Archive` int(11) NOT NULL DEFAULT 0,\
  `Date` varchar(36) NOT NULL,\
   PRIMARY KEY (`id`));");

   print("[DATABASE] Tabela phone_sms checada com sucesso");
   format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela phone_sms checada com sucesso");
   logCreate(99998, logString, 5);
}

void:CheckPhoneContacts() {
  mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `phone_contacts` (\
  `id` int NOT NULL AUTO_INCREMENT,\
  `contactID` int(11) NOT NULL,\
  `contactAdded` int(11) NOT NULL,\
  `contactAddee` int(11) NOT NULL,\
  `contactName` varchar(24) NOT NULL,\
  PRIMARY KEY (`id`));"); 

  print("[DATABASE] Tabela phone_contacts checada com sucesso");
  format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela phone_contacts checada com sucesso");
  logCreate(99998, logString, 5);
}