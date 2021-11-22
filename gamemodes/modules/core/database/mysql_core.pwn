/*

Esse módulo é dedicado integralmente a lidar com conexões e integrações com o MySQL. Mas isso não implica que outros módulos não possam
extrair, salvar ou inserir informações no mesmo banco de dados de maneira segura, estando ordenadas e documentadas.

*/

#include <YSI_Coding\y_hooks>

#define DB_HOST         "localhost"
#define DB_USER         "root"
#define DB_PASSWORD     ""
#define DB_NAME         "paradise-roleplay"

new MySQL:DBConn;

hook OnGameModeInit() {

    DBConn = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

    if(mysql_errno(DBConn)) {
        print("\n[DATABASE] Houve um erro na tentativa de conexão com o MySQL.");
        print("[DATABASE] Para obter mais detalhes, acesse a pasta de logging do plug-in.");
        print("[DATABASE] Desligando o servidor...\n");

        new string[256];
        new DCC_Embed:embed = DCC_CreateEmbed("FALHA NA CONEXAO COM O SERVIDOR");
        format(string, sizeof string, "%s", LASTEST_RELEASE);
        DCC_AddEmbedField(embed, "Ultima atualizacao em:", string, false);
        format(string, sizeof string, "%s", VERSIONING);
        DCC_AddEmbedField(embed, "Versao do servidor:", string, false);
        DCC_AddEmbedField(embed, "Erro:", "Falha na conexao com o MySQL", false);
        DCC_SetEmbedColor(embed, 15548997);
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352074907734037.png");
        DCC_SetEmbedFooter(embed, "Conexao com o servidor nao estabelecida.", "https://cdn.discordapp.com/emojis/894352160479932468.png");
        DCC_SendChannelEmbedMessage(DC_Status, embed);
        
        SendRconCommand("exit");
    } else {
        print("\n[DATABASE] A conexão com o MySQL foi feita com sucesso.");
        print("[DATABASE] Verificando criação de tabelas...");
        CheckTables();
    }

    return true;
}

void:CheckTables() {

    CheckUserTable();
    CheckPlayerTable();
    CheckFactionTable();
    CheckArrestTable();
    CheckBanTable();
    CheckCarsTable();
    CheckGraffitiTable();
    CheckImpoundLotsTable();
    CheckTicketsTable();
    CheckDealersTable();
    CheckEntrancesTable();
    print("[DATABASE] Todas tabelas foram carregadas com sucesso.");
    print("* Note que se alguma tabela faltar, funções não funcionarão de modo correto.\n");
}

void:CheckEntrancesTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `entrances` (\
        `entranceID` int(12) NOT NULL, \
        `entranceName` varchar(32) DEFAULT NULL, \
        `entranceIcon` int(12) DEFAULT 0, \
        `entrancePosX` float DEFAULT 0, \
        `entrancePosY` float DEFAULT 0, \
        `entrancePosZ` float DEFAULT 0, \
        `entrancePosA` float DEFAULT 0,\
        `entranceIntX` float DEFAULT 0,\
        `entranceIntY` float DEFAULT 0,\
        `entranceIntZ` float DEFAULT 0,\
        `entranceIntA` float DEFAULT 0,\
        `entranceInterior` int(12) DEFAULT 0,\
        `entranceExterior` int(12) DEFAULT 0,\
        `entranceExteriorVW` int(12) DEFAULT 0,\
        `entranceType` int(12) DEFAULT 0,\
        `entrancePass` varchar(32) DEFAULT NULL,\
        `entranceLocked` int(12) DEFAULT 0,\
        `entranceCustom` int(4) DEFAULT 0,\
        `entranceWorld` int(12) DEFAULT 0,\
        PRIMARY KEY (entranceID));");

    print("[DATABASE] Tabela 'entrances' checada com sucesso.");
}

void:CheckDealersTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `dealers` (\
        `ID` int(3) NOT NULL,\
        `dSkin` int(3) NOT NULL,\
        `dX` double NOT NULL,\
        `dY` double NOT NULL,\
        `dZ` double NOT NULL,\
        `dAngle` float NOT NULL,\
        `dWorld` int(3) NOT NULL DEFAULT 0,\
        `Weapon1` int(2) NOT NULL DEFAULT -1,\
        `Weapon2` int(2) NOT NULL DEFAULT -1,\
        `Weapon3` int(2) NOT NULL DEFAULT -1,\
        `Weapon4` int(2) NOT NULL DEFAULT -1,\
        `Weapon5` int(2) NOT NULL DEFAULT -1,\
        `Weapon6` int(2) NOT NULL DEFAULT -1,\
        `Weapon7` int(2) NOT NULL DEFAULT -1,\
        `Weapon8` int(2) NOT NULL DEFAULT -1,\
        `Weapon9` int(2) NOT NULL DEFAULT -1,\
        `Weapon10` int(2) NOT NULL DEFAULT -1,\
        `Cost1` int(10) NOT NULL DEFAULT 0,\
        `Cost2` int(10) NOT NULL DEFAULT 0,\
        `Cost3` int(10) NOT NULL DEFAULT 0,\
        `Cost4` int(10) NOT NULL DEFAULT 0,\
        `Cost5` int(10) NOT NULL DEFAULT 0,\
        `Cost6` int(10) NOT NULL DEFAULT 0,\
        `Cost7` int(10) NOT NULL DEFAULT 0,\
        `Cost8` int(10) NOT NULL DEFAULT 0,\
        `Cost9` int(10) NOT NULL DEFAULT 0,\
        `Cost10` int(10) NOT NULL DEFAULT 0,\
        `Ammo1` int(4) NOT NULL DEFAULT 0,\
        `Ammo2` int(4) NOT NULL DEFAULT 0,\
        `Ammo3` int(4) NOT NULL DEFAULT 0,\
        `Ammo4` int(4) NOT NULL DEFAULT 0,\
        `Ammo5` int(4) NOT NULL DEFAULT 0,\
        `Ammo6` int(4) NOT NULL DEFAULT 0,\
        `Ammo7` int(4) NOT NULL DEFAULT 0,\
        `Ammo8` int(4) NOT NULL DEFAULT 0,\
        `Ammo9` int(4) NOT NULL DEFAULT 0,\
        `Ammo10` int(4) NOT NULL DEFAULT 0,\
        PRIMARY KEY (ID));");

    print("[DATABASE] Tabela 'dealers' checada com sucesso.");

}

void:CheckTicketsTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `tickets` (\
        `ID` int(12) DEFAULT 0,\
        `ticketID` int(12) NOT NULL,\
        `ticketFee` int(12) DEFAULT 0,\
        `ticketBy` varchar(24) DEFAULT NULL,\
        `ticketDate` varchar(36) DEFAULT NULL,\
        `ticketReason` varchar(32) DEFAULT NULL,\
        PRIMARY KEY (ID));");

    print("[DATABASE] Tabela 'tickets' checada com sucesso.");
}

void:CheckImpoundLotsTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `impoundlots` (\
        `impoundID` int(12) NOT NULL,\
        `impoundLotX` float DEFAULT 0,\
        `impoundLotY` float DEFAULT 0,\
        `impoundLotZ` float DEFAULT 0,\
        `impoundReleaseX` float DEFAULT 0,\
        `impoundReleaseY` float DEFAULT 0,\
        `impoundReleaseZ` float DEFAULT 0,\
        `impoundReleaseInt` int(12) DEFAULT 0,\
        `impoundReleaseWorld` int(12) DEFAULT 0,\
        `impoundReleaseA` float DEFAULT 0,\
        PRIMARY KEY (impoundID));");

    print("[DATABASE] Tabela 'impoundlots' checada com sucesso.");
}

void:CheckGraffitiTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `graffiti` (\
        `graffitiID` int(12) NOT NULL,\
        `graffitiX` float DEFAULT 0,\
        `graffitiY` float DEFAULT 0,\
        `graffitiZ` float DEFAULT 0,\
        `graffitiAngle` float DEFAULT 0,\
        `graffitiColor` int(12) DEFAULT 0,\
        `graffitiText` varchar(64) DEFAULT NULL,\
        PRIMARY KEY (graffitiID));");

    print("[DATABASE] Tabela 'graffiti' checada com sucesso.");
}

void:CheckArrestTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `arrestpoints` (\
        `arrestID` int(11) NOT NULL,\
        `arrestX` float NOT NULL,\
        `arrestY` float NOT NULL,\
        `arrestZ` float NOT NULL,\
        `arrestInterior` int(11) NOT NULL,\
        `arrestWorld` int(11) NOT NULL,\
        PRIMARY KEY (arrestID));");

    print("[DATABASE] Tabela 'arrestpoints' checada com sucesso.");
}

void:CheckCarsTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `cars` (\
        `carID` int(12) NOT NULL,\
        `carModel` int(12) DEFAULT 0,\
        `carOwner` int(12) DEFAULT 0,\
        `carPosX` float DEFAULT 0,\
        `carPosY` float DEFAULT 0,\
        `carPosZ` float DEFAULT 0,\
        `carPosR` float DEFAULT 0,\
        `carColor1` int(12) DEFAULT 0,\
        `carColor2` int(12) DEFAULT 0,\
        `carPaintjob` int(12) DEFAULT -1,\
        `carLocked` int(4) DEFAULT 0,\
        `carMod1` int(12) DEFAULT 0,\
        `carMod2` int(12) DEFAULT 0,\
        `carMod3` int(12) DEFAULT 0,\
        `carMod4` int(12) DEFAULT 0,\
        `carMod5` int(12) DEFAULT 0,\
        `carMod6` int(12) DEFAULT 0,\
        `carMod7` int(12) DEFAULT 0,\
        `carMod8` int(12) DEFAULT 0,\
        `carMod9` int(12) DEFAULT 0,\
        `carMod10` int(12) DEFAULT 0,\
        `carMod11` int(12) DEFAULT 0,\
        `carMod12` int(12) DEFAULT 0,\
        `carMod13` int(12) DEFAULT 0,\
        `carMod14` int(12) DEFAULT 0,\
        `carImpounded` int(12) DEFAULT 0,\
        `carWeapon1` int(12) DEFAULT 0,\
        `carAmmo1` int(12) DEFAULT 0,\
        `carWeapon2` int(12) DEFAULT 0,\
        `carAmmo2` int(12) DEFAULT 0,\
        `carWeapon3` int(12) DEFAULT 0,\
        `carAmmo3` int(12) DEFAULT 0,\
        `carWeapon4` int(12) DEFAULT 0,\
        `carAmmo4` int(12) DEFAULT 0,\
        `carWeapon5` int(12) DEFAULT 0,\
        `carAmmo5` int(12) DEFAULT 0,\
        `carImpoundPrice` int(12) DEFAULT 0,\
        `carFaction` int(12) DEFAULT 0,\
        PRIMARY KEY (carID));");

    print("[DATABASE] Tabela 'cars' checada com sucesso.");
}

void:CheckUserTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `users` (\
        ID int NOT NULL AUTO_INCREMENT,\
        `username` varchar(24),\
        `senha` varchar(16),\
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
    `material` int NOT NULL DEFAULT '0',\
    `faction` int NOT NULL DEFAULT '0',\
    `faction_rank` int NOT NULL DEFAULT '0',\
    `house` int NOT NULL DEFAULT '0',\
    `entrance` int NOT NULL DEFAULT '0',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela 'players' checada com sucesso.");
}

void:CheckFactionTable(){
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `factions` (\
    `factionID` int(12) NOT NULL,\
    `factionName` varchar(32) DEFAULT NULL,\
    `factionColor` int(12) DEFAULT 0,\
    `factionType` int(12) DEFAULT 0,\
    `factionRanks` int(12) DEFAULT 0,\
    `factionLockerX` float DEFAULT 0,\
    `factionLockerY` float DEFAULT 0,\
    `factionLockerZ` float DEFAULT 0,\
    `factionLockerInt` int(12) DEFAULT 0,\
    `factionLockerWorld` int(12) DEFAULT 0,\
    `factionWeapon1` int(12) DEFAULT 0,\
    `factionAmmo1` int(12) DEFAULT 0,\
    `factionWeapon2` int(12) DEFAULT 0,\
    `factionAmmo2` int(12) DEFAULT 0,\
    `factionWeapon3` int(12) DEFAULT 0,\
    `factionAmmo3` int(12) DEFAULT 0,\
    `factionWeapon4` int(12) DEFAULT 0,\
    `factionAmmo4` int(12) DEFAULT 0,\
    `factionWeapon5` int(12) DEFAULT 0,\
    `factionAmmo5` int(12) DEFAULT 0,\
    `factionWeapon6` int(12) DEFAULT 0,\
    `factionAmmo6` int(12) DEFAULT 0,\
    `factionWeapon7` int(12) DEFAULT 0,\
    `factionAmmo7` int(12) DEFAULT 0,\
    `factionWeapon8` int(12) DEFAULT 0,\
    `factionAmmo8` int(12) DEFAULT 0,\
    `factionWeapon9` int(12) DEFAULT 0,\
    `factionAmmo9` int(12) DEFAULT 0,\
    `factionWeapon10` int(12) DEFAULT 0,\
    `factionAmmo10` int(12) DEFAULT 0,\
    `factionRank1` varchar(32) DEFAULT NULL,\
    `factionRank2` varchar(32) DEFAULT NULL,\
    `factionRank3` varchar(32) DEFAULT NULL,\
    `factionRank4` varchar(32) DEFAULT NULL,\
    `factionRank5` varchar(32) DEFAULT NULL,\
    `factionRank6` varchar(32) DEFAULT NULL,\
    `factionRank7` varchar(32) DEFAULT NULL,\
    `factionRank8` varchar(32) DEFAULT NULL,\
    `factionRank9` varchar(32) DEFAULT NULL,\
    `factionRank10` varchar(32) DEFAULT NULL,\
    `factionRank11` varchar(32) DEFAULT NULL,\
    `factionRank12` varchar(32) DEFAULT NULL,\
    `factionRank13` varchar(32) DEFAULT NULL,\
    `factionRank14` varchar(32) DEFAULT NULL,\
    `factionRank15` varchar(32) DEFAULT NULL,\
    `factionSkin1` int(12) DEFAULT 0,\
    `factionSkin2` int(12) DEFAULT 0,\
    `factionSkin3` int(12) DEFAULT 0,\
    `factionSkin4` int(12) DEFAULT 0,\
    `factionSkin5` int(12) DEFAULT 0,\
    `factionSkin6` int(12) DEFAULT 0,\
    `factionSkin7` int(12) DEFAULT 0,\
    `factionSkin8` int(12) DEFAULT 0,\
    `SpawnX` float NOT NULL,\
    `SpawnY` float NOT NULL,\
    `SpawnZ` float NOT NULL,\
    `SpawnInterior` int(11) NOT NULL,\
    `SpawnVW` int(1) NOT NULL,\
    PRIMARY KEY (`factionID`));");

    print("[DATABASE] Tabela 'factions' checada com sucesso.");
}
void:CheckBanTable() {
    mysql_query(DBConn, "CREATE TABLE IF NOT EXISTS `ban` (\
    `ID` int NOT NULL AUTO_INCREMENT,\
    `banned_name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `admin_name` varchar(24) NOT NULL DEFAULT 'Nenhum',\
    `reason` varchar(128) NOT NULL DEFAULT 'Nenhum',\
    `ban_date` int NOT NULL DEFAULT '0',\
    `unban_date` int NOT NULL DEFAULT '0',\
    `banned` boolean NOT NULL DEFAULT '1',\
    PRIMARY KEY (`ID`));");

    print("[DATABASE] Tabela 'ban' checada com sucesso.");
}