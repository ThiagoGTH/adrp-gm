/*
 
Esse módulo é dedicado integralmente a lidar com conexões e integrações com o MySQL. Mas isso não implica que outros módulos não possam extrair, salvar ou inserir informações no mesmo banco de dados de maneira segura, estando ordenadas e documentadas.

*/

#include <YSI_Coding\y_hooks>

#define DB_HOST         "localhost"
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
    CheckVehiclesWeaponsTable();
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
    `registration_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `registration_date` int NOT NULL DEFAULT '0',\
    `admin` int NOT NULL DEFAULT 0,\
    `charslots` int NOT NULL DEFAULT 5,\
    `dutytime` int NOT NULL DEFAULT 0,\
    `SOSAns` int NOT NULL DEFAULT 0,\
    `APPAns` int NOT NULL DEFAULT 0,\
    `namechanges` int NOT NULL DEFAULT 0,\
    `numberchanges` int NOT NULL DEFAULT 0,\
    `fightchanges` int NOT NULL DEFAULT 0,\
    `platechanges` int NOT NULL DEFAULT 0,\
    `premiumpoints` int NOT NULL DEFAULT 0,\
    `teams` varchar(24) NOT NULL DEFAULT 00000,\
    `headteams` varchar(24) NOT NULL DEFAULT 00000,\
    `redflag` int NOT NULL DEFAULT 0,\
    `newbie` int NOT NULL DEFAULT 0,\
    `jailtime` int NOT NULL DEFAULT -1,\
    PRIMARY KEY (ID));");

    print("[DATABASE] Tabela users checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela users checada com sucesso.");
    logCreate(99998, logString, 5);
}

void:CheckPlayerTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `players` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `user` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `registration_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `first_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `last_ip` varchar(16) NOT NULL DEFAULT 'Nenhum',\
    `first_login` int NOT NULL DEFAULT '0',\
    `last_login` int NOT NULL DEFAULT '0',\
    `donator` int NOT NULL DEFAULT '0',\
    `age` int NOT NULL DEFAULT '0',\
    `minutes` int NOT NULL DEFAULT '0',\
    `hours` int NOT NULL DEFAULT '0',\
    `gender` varchar(15) NOT NULL DEFAULT 'Masculino',\
    `background` varchar(50) NOT NULL DEFAULT 'Los Santos',\
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
    `Gun1` int NOT NULL DEFAULT '0',\
    `Ammo1` int NOT NULL DEFAULT '0',\
    `Gun2` int NOT NULL DEFAULT '0',\
    `Ammo2` int NOT NULL DEFAULT '0',\
    `Gun3` int NOT NULL DEFAULT '0',\
    `Ammo3` int NOT NULL DEFAULT '0',\
    `Gun4` int NOT NULL DEFAULT '0',\
    `Ammo4` int NOT NULL DEFAULT '0',\
    `Gun5` int NOT NULL DEFAULT '0',\
    `Ammo5` int NOT NULL DEFAULT '0',\
    `Gun6` int NOT NULL DEFAULT '0',\
    `Ammo6` int NOT NULL DEFAULT '0',\
    `Gun7` int NOT NULL DEFAULT '0',\
    `Ammo7` int NOT NULL DEFAULT '0',\
    `Gun8` int NOT NULL DEFAULT '0',\
    `Ammo8` int NOT NULL DEFAULT '0',\
    `Gun9` int NOT NULL DEFAULT '0',\
    `Ammo9` int NOT NULL DEFAULT '0',\
    `Gun10` int NOT NULL DEFAULT '0',\
    `Ammo10` int NOT NULL DEFAULT '0',\
    `Gun11` int NOT NULL DEFAULT '0',\
    `Ammo11` int NOT NULL DEFAULT '0',\
    `Gun12` int NOT NULL DEFAULT '0',\
    `Ammo12` int NOT NULL DEFAULT '0',\
    `Gun13` int NOT NULL DEFAULT '0',\
    `Ammo13` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela players checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela players checada com sucesso.");
    logCreate(99998, logString, 5);
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
    `carID` int NOT NULL AUTO_INCREMENT,\
    `carModel` int DEFAULT '0',\
    `carOwner` int DEFAULT '0',\
    `carPosX` float DEFAULT '0',\
    `carPosY` float DEFAULT '0',\
    `carPosZ` float DEFAULT '0',\
    `carPosR` float DEFAULT '0',\
    `carVW` int DEFAULT '0',\
    `carInterior` int DEFAULT '0',\
    `carColor1` int DEFAULT '0',\
    `carColor2` int DEFAULT '0',\
    `carLocked` int DEFAULT '0',\
    `carImpounded` int DEFAULT '0',\
    `carImpoundPrice` int DEFAULT '0',\
    `carFaction` int NOT NULL DEFAULT '-1',\
    `carBiz` int NOT NULL DEFAULT '-1',\
    `carJob` int NOT NULL DEFAULT '-1',\
    `carRentPrice` int NOT NULL DEFAULT '0',\
    `carRentPlayer` int NOT NULL DEFAULT '-1',\
    `carRentTime` int NOT NULL DEFAULT '0',\
    `carPaintjob` int DEFAULT -1,\
    `carMod1` int DEFAULT '0',\
    `carMod2` int DEFAULT '0',\
    `carMod3` int DEFAULT '0',\
    `carMod4` int DEFAULT '0',\
    `carMod5` int DEFAULT '0',\
    `carMod6` int DEFAULT '0',\
    `carMod7` int DEFAULT '0',\
    `carMod8` int DEFAULT '0',\
    `carMod9` int DEFAULT '0',\
    `carMod10` int DEFAULT '0',\
    `carMod11` int DEFAULT '0',\
    `carMod12` int DEFAULT '0',\
    `carMod13` int DEFAULT '0',\
    `carMod14` int DEFAULT '0',\
    `carNOSInstalled` int DEFAULT '0',\
    `carNOS` int DEFAULT '0',\
    `carBattery` float NOT NULL,\
    `carEngine` float NOT NULL,\
    `carMiles` float NOT NULL,\
    `carFuel` float NOT NULL,\
    `carHealth` float NOT NULL,\
    `carName` varchar(64) NOT NULL,\
    `carNamePer` int NOT NULL,\
    `carPlate` varchar(255) NOT NULL,\
    `carPlatePer` int NOT NULL,\
    `carEnergyResource` int NOT NULL,\
    `carAlarm` int NOT NULL,\
    `carLock` int NOT NULL,\
    `carImob` int NOT NULL,\
    `carInsurance` int NOT NULL,\
    `carXMRadio` int NOT NULL,\
    `carSunPass` int NOT NULL,\
    `carDoorsStatus` int NOT NULL,\
    `carPanelsStatus` int NOT NULL,\
    `carLightsStatus` int NOT NULL,\
    `carTiresStatus` int NOT NULL,\
    `carCarparts` int NOT NULL,\
    PRIMARY KEY (`carID`));");

    print("[DATABASE] Tabela vehicles checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela vehicles checada com sucesso.");
    logCreate(99998, logString, 5);
}

void:CheckVehiclesWeaponsTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `vehicles_weapons` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `carID` int DEFAULT '0',\
    `carWeapon1` int NOT NULL,\
    `carWeaponType1` int NOT NULL,\
    `carAmmo1` int NOT NULL,\
    `carWeapon2` int NOT NULL,\
    `carWeaponType2` int NOT NULL,\
    `carAmmo2` int NOT NULL,\
    `carWeapon3` int NOT NULL,\
    `carWeaponType3` int NOT NULL,\
    `carAmmo3` int NOT NULL,\
    `carWeapon4` int NOT NULL,\
    `carWeaponType4` int NOT NULL,\
    `carAmmo4` int NOT NULL,\
    `carWeapon5` int NOT NULL,\
    `carWeaponType5` int NOT NULL,\
    `carAmmo5` int NOT NULL,\
    `carWeapon6` int NOT NULL,\
    `carWeaponType6` int NOT NULL,\
    `carAmmo6` int NOT NULL,\
    `carWeapon7` int NOT NULL,\
    `carWeaponType7` int NOT NULL,\
    `carAmmo7` int NOT NULL,\
    `carWeapon8` int NOT NULL,\
    `carWeaponType8` int NOT NULL,\
    `carAmmo8` int NOT NULL,\
    `carWeapon9` int NOT NULL,\
    `carWeaponType9` int NOT NULL,\
    `carAmmo9` int NOT NULL,\
    `carWeapon10` int NOT NULL,\
    `carWeaponType10` int NOT NULL,\
    `carAmmo10` int NOT NULL,\
    `carWeapon11` int NOT NULL,\
    `carWeaponType11` int NOT NULL,\
    `carAmmo11` int NOT NULL,\
    `carWeapon12` int NOT NULL,\
    `carWeaponType12` int NOT NULL,\
    `carAmmo12` int NOT NULL,\
    `carWeapon13` int NOT NULL,\
    `carWeaponType13` int NOT NULL,\
    `carAmmo13` int NOT NULL,\
    `carWeapon14` int NOT NULL,\
    `carWeaponType14` int NOT NULL,\
    `carAmmo14` int NOT NULL,\
    `carWeapon15` int NOT NULL,\
    `carWeaponType15` int NOT NULL,\
    `carAmmo15` int NOT NULL,\
    `carWeapon16` int NOT NULL,\
    `carWeaponType16` int NOT NULL,\
    `carAmmo16` int NOT NULL,\
    `carWeapon17` int NOT NULL,\
    `carWeaponType17` int NOT NULL,\
    `carAmmo17` int NOT NULL,\
    `carWeapon18` int NOT NULL,\
    `carWeaponType18` int NOT NULL,\
    `carAmmo18` int NOT NULL,\
    `carWeapon19` int NOT NULL,\
    `carWeaponType19` int NOT NULL,\
    `carAmmo19` int NOT NULL,\
    `carWeapon20` int NOT NULL,\
    `carWeaponType20` int NOT NULL,\
    `carAmmo20` int NOT NULL,\
    `carWeapon21` int NOT NULL,\
    `carWeaponType21` int NOT NULL,\
    `carAmmo21` int NOT NULL,\
    `carWeapon22` int NOT NULL,\
    `carWeaponType22` int NOT NULL,\
    `carAmmo22` int NOT NULL,\
    `carWeapon23` int NOT NULL,\
    `carWeaponType23` int NOT NULL,\
    `carAmmo23` int NOT NULL,\
    `carWeapon24` int NOT NULL,\
    `carWeaponType24` int NOT NULL,\
    `carAmmo24` int NOT NULL,\
    `carWeapon25` int NOT NULL,\
    `carWeaponType25` int NOT NULL,\
    `carAmmo25` int NOT NULL,\
    `carWeapon26` int NOT NULL,\
    `carWeaponType26` int NOT NULL,\
    `carAmmo26` int NOT NULL,\
    `carWeapon27` int NOT NULL,\
    `carWeaponType27` int NOT NULL,\
    `carAmmo27` int NOT NULL,\
    `carWeapon28` int NOT NULL,\
    `carWeaponType28` int NOT NULL,\
    `carAmmo28` int NOT NULL,\
    `carWeapon29` int NOT NULL,\
    `carWeaponType29` int NOT NULL,\
    `carAmmo29` int NOT NULL,\
    `carWeapon30` int NOT NULL,\
    `carWeaponType30` int NOT NULL,\
    `carAmmo30` int NOT NULL,\
    `empty` int NOT NULL DEFAULT '0',\
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
    `bought_price` float NOT NULL DEFAULT '0.0',\
    `quantity` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela tradings_owners checada com sucesso.");
    format(logString, sizeof(logString), "SYSTEM: [DATABASE] Tabela tradings_owners checada com sucesso.");
    logCreate(99998, logString, 5);
}