#include <YSI_Coding\y_hooks>

CreateCharacter(characterName[], userName) {
    mysql_format(DBConn, query, sizeof query,
        "INSERT INTO players (`name`, `user_id`) VALUES ('%s', '%d');",
            characterName, userName);
    mysql_query(DBConn, query);
}

LoadCharacterInfoID(playerid, id) {
    new first_login;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `ID` = '%d'", id);
    new Cache:result = mysql_query(DBConn, query);

    cache_get_value_name_int(0, "ID", pInfo[playerid][pID]);

    cache_get_value_name_int(0, "user_id", pInfo[playerid][pUser]);
    cache_get_value_name(0, "name", pInfo[playerid][pName]);
    format(pInfo[playerid][pLastIP], 20, "%s", GetPlayerIP(playerid));

    cache_get_value_name(0, "dateofbirth", pInfo[playerid][pDateOfBirth]);
    cache_get_value_name(0, "origin", pInfo[playerid][pBackground]);

    cache_get_value_name_int(0, "minutes", pInfo[playerid][pPlayingMinutes]);
    cache_get_value_name_int(0, "hours", pInfo[playerid][pPlayingHours]);

    cache_get_value_name_int(0, "money", pInfo[playerid][pMoney]);
    cache_get_value_name_int(0, "payment", pInfo[playerid][pPayment]);
    cache_get_value_name_int(0, "taxes", pInfo[playerid][pTaxes]);

    cache_get_value_name_int(0, "skin", pInfo[playerid][pSkin]);
    cache_get_value_name_int(0, "score", pInfo[playerid][pScore]);

    cache_get_value_name_float(0, "health", pInfo[playerid][pHealth]);
    cache_get_value_name_float(0, "armour", pInfo[playerid][pArmour]);

    cache_get_value_name_float(0, "positionX", pInfo[playerid][pPositionX]);
    cache_get_value_name_float(0, "positionY", pInfo[playerid][pPositionY]);
    cache_get_value_name_float(0, "positionZ", pInfo[playerid][pPositionZ]);
    cache_get_value_name_float(0, "positionA", pInfo[playerid][pPositionA]);

    cache_get_value_name_int(0, "interior", pInfo[playerid][pInterior]);
    cache_get_value_name_int(0, "virtual_world", pInfo[playerid][pVirtualWorld]);

    cache_get_value_name_int(0, "first_login", first_login);
    cache_delete(result);

    /*if(first_login == 0) {
        mysql_format(DBConn, query, sizeof query, "UPDATE players SET `first_login` = '%d' WHERE `name` = '%s';", _:Now(), pInfo[playerid][pName]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_apparence (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_license (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_weapons (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_inv (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_premium (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_radio (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_pet (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_config (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_status (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_faction (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);
    }*/

    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `last_login` = %d WHERE `name` = '%s';", _:Now(), pInfo[playerid][pName]);
    mysql_query(DBConn, query);

    printf("[DATABASE] %s foi carregado com sucesso do banco de dados.", pInfo[playerid][pName]);
    LoadPlayerLicenses(playerid);
    LoadPlayerWeapons(playerid);
    LoadPlayerApparence(playerid);
    LoadPlayerPremium(playerid);
    LoadPlayerRadio(playerid);
    LoadPlayerInventory(playerid);
    LoadPlayerPet(playerid);
    LoadPlayerConfig(playerid);
    LoadPlayerStatus(playerid);
    LoadPlayerFaction(playerid);
    
    SpawnSelectedCharacter(playerid);
}

LoadPlayerWeapons(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_weapons WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);

    for (new i = 0; i < 13; i ++) {
	    format(query, sizeof(query), "gun%d", i + 1);
	    cache_get_value_name_int(0, query, pInfo[playerid][pGuns][i]);
	    format(query, sizeof(query), "ammo%d", i + 1);
	    cache_get_value_name_int(0, query, pInfo[playerid][pAmmo][i]);
	}
    cache_delete(result);

    return true;
}

LoadPlayerInventory(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_inv WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);

    for (new i = 0; i < 30; i ++) {
	    format(query, sizeof(query), "item%d", i + 1);
	    cache_get_value_name_int(0, query, pInfo[playerid][iItem][i]);
	    format(query, sizeof(query), "amount%d", i + 1);
	    cache_get_value_name_int(0, query, pInfo[playerid][iAmount][i]);
	}
    cache_delete(result);

    return true;
}

LoadPlayerApparence(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_apparence WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);
    cache_get_value_name_int(0, "gender", pInfo[playerid][pGender]);
    cache_get_value_name_int(0, "ethnicity", pInfo[playerid][pEthnicity]);
    cache_get_value_name_int(0, "color_eyes", pInfo[playerid][pColorEyes]);
    cache_get_value_name_int(0, "color_hair", pInfo[playerid][pColorHair]);
    cache_get_value_name_int(0, "height", pInfo[playerid][pHeight]);
    cache_get_value_name_float(0, "weight", pInfo[playerid][pWeight]);
    cache_get_value_name_int(0, "build", pInfo[playerid][pBuild]);
    cache_get_value_name(0, "description", pInfo[playerid][pDescription]);
    cache_delete(result);
    return true;
}

LoadPlayerRadio(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_radio WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);
    cache_get_value_int(0, "rRadioState", pInfo[playerid][rRadioState]);
    cache_get_value_int(0, "rRadioSlot1", pInfo[playerid][rRadioSlot][0]);
    cache_get_value_int(0, "rRadioSlot2", pInfo[playerid][rRadioSlot][1]);
    cache_get_value_int(0, "rRadioSlot3", pInfo[playerid][rRadioSlot][2]);
    cache_get_value_int(0, "rRadioSlot4", pInfo[playerid][rRadioSlot][3]);
    cache_get_value_int(0, "rRadioSlot5", pInfo[playerid][rRadioSlot][4]);
    cache_get_value_int(0, "rRadioSlot6", pInfo[playerid][rRadioSlot][5]);
    cache_get_value_int(0, "rRadioSlot7", pInfo[playerid][rRadioSlot][6]);
    cache_get_value_name(0, "rRadioName1", pInfo[playerid][rRadioName1]); 
    cache_get_value_name(0, "rRadioName2", pInfo[playerid][rRadioName2]);
    cache_get_value_name(0, "rRadioName3", pInfo[playerid][rRadioName3]);
    cache_get_value_name(0, "rRadioName4", pInfo[playerid][rRadioName4]);
    cache_get_value_name(0, "rRadioName5", pInfo[playerid][rRadioName5]);
    cache_get_value_name(0, "rRadioName6", pInfo[playerid][rRadioName6]);
    cache_get_value_name(0, "rRadioName7", pInfo[playerid][rRadioName7]);
    cache_get_value_int(0, "pRadioNvl", pInfo[playerid][pRadioNvl]);
    cache_delete(result);
    return true;
}

LoadPlayerPremium(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_premium WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);
    cache_get_value_name_int(0, "donator", pInfo[playerid][pDonator]);
    cache_get_value_name_int(0, "donator_time", pInfo[playerid][pDonatorTime]);
    cache_delete(result);
    return true;
}

LoadPlayerPet(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_pet WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);
    cache_get_value_name_int(0, "pet_model", PetData[playerid][petModelID]);
    cache_get_value_name(0, "pet_name", PetData[playerid][petName]);
    cache_delete(result);
    return true;
}

LoadPlayerConfig(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_config WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);
    cache_get_value_name_int(0, "newbie_chat", pInfo[playerid][pTogNewbie]);
    cache_get_value_name_int(0, "faction_chat", pInfo[playerid][pTogFaction]);
    cache_get_value_name_int(0, "admin_chat", pInfo[playerid][pTogAdmin]);
    cache_get_value_name_int(0, "nametag", pInfo[playerid][pNametagType]);
    cache_get_value_name_int(0, "objects", pInfo[playerid][pRenderObjects]);
    cache_get_value_name_int(0, "speedo", pInfo[playerid][pHudSpeedo]);
    cache_get_value_name_int(0, "hud", pInfo[playerid][pHudStyle]);
    
    cache_delete(result);
    return true;
}

LoadPlayerStatus(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_status WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);
    cache_get_value_name_int(0, "hunger", pInfo[playerid][pHunger]);
    cache_get_value_name_int(0, "thirst", pInfo[playerid][pThirst]);
    cache_get_value_name_int(0, "stamina", pInfo[playerid][pStamina]);
    cache_get_value_name_int(0, "max_stamina", pInfo[playerid][pMaxStamina]);
    cache_get_value_name_int(0, "addiction", pInfo[playerid][pAddiction]);

    SetPlayerMaxStamina(playerid, pInfo[playerid][pMaxStamina]);
    SetPlayerStamina(playerid, GetPlayerMaxStamina(playerid));
    cache_delete(result);
}

LoadPlayerFaction(playerid){
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players_faction WHERE `character_id` = '%d'", pInfo[playerid][pID]);
    new Cache:result = mysql_query(DBConn, query);
    cache_get_value_name_int(0, "faction_id", pInfo[playerid][pFactionID]);
    cache_get_value_name_int(0, "faction_rank", pInfo[playerid][pFactionRank]);
    cache_delete(result);
    return true;
}

//Congela (por determinado tempo) - dando chance do interior carregar.
PlayerLoadObjects(playerid) {
    TogglePlayerControllable(playerid, false);
    pInfo[playerid][LoadTemp] = SetTimerEx("PlayerLoadedObjects", 6000, false, "i", playerid);
}

//Responde o player Load
hook PlayerLoadedObjects(playerid) {
    DesbugInteriorAndWorld(playerid);
    TogglePlayerControllable(playerid, true);
    KillTimer(pInfo[playerid][LoadTemp]);
    printf("Playerid: %d - Interior: %d", playerid, pInfo[playerid][pInterior]);
} 

//Seta no interior (desbuga - sem if se não dá erro.)
DesbugInteriorAndWorld(playerid) {
    SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
    SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
    return 1;
}

SpawnSelectedCharacter(playerid) {
    pInfo[playerid][pLogged] = false;
    TogglePlayerSpectating(playerid, false);
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, pInfo[playerid][pMoney]);
    SetPlayerHealth(playerid, pInfo[playerid][pHealth]);
    SetPlayerArmour(playerid, pInfo[playerid][pArmour]);
    SetPlayerScore(playerid, pInfo[playerid][pScore]);

    SetPlayerName(playerid, pInfo[playerid][pName]);
    //Setar o mundo, interior do player aqui (não funciona) - ele buga.
    SetSpawnInfo(playerid, false, pInfo[playerid][pSkin], 
        pInfo[playerid][pPositionX], 
        pInfo[playerid][pPositionY], 
        pInfo[playerid][pPositionZ],
        pInfo[playerid][pPositionA],
        WEAPON_FIST, 0, 
        WEAPON_FIST, 0, 
        WEAPON_FIST, 0);

    SpawnPlayer(playerid);

    SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
    PreloadAnimations(playerid);
    PlayerLoadObjects(playerid);
    SetWeapons(playerid);
    pInfo[playerid][pHealthMax] = 150.0;
    pInfo[playerid][pSpectating] = INVALID_PLAYER_ID;
    SetPlayerColor(playerid, 0xFFFFFFFF);
    ClearPlayerChat(playerid);
    SendServerMessage(playerid, "Você está jogando com o personagem %s.", pNome(playerid));
    if(uInfo[playerid][uJailed] > 0){
        SetPlayerPos(playerid, 197.6346, 175.3765, 1003.0234);
        SetPlayerHealth(playerid, pInfo[playerid][pHealthMax]);
        SetPlayerInterior(playerid, 3);
        SetPlayerVirtualWorld(playerid, (playerid + 100));
        SetPlayerFacingAngle(playerid, 0.0);
        SetCameraBehindPlayer(playerid);
        ResetWeapons(playerid);
        SendServerMessage(playerid, "Você logou com uma prisão administrativa pendente. Restam %d minutos.", uInfo[playerid][uJailed]/60);
    }
    if (uInfo[playerid][uAdmin] > 0) SendServerMessage(playerid, "Você logou com o nível administrativo %d.", uInfo[playerid][uAdmin]);

    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `online` = '1' WHERE `ID` = '%d';", pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, RenderingObjectsValue(playerid), playerid);
    Streamer_SetRadiusMultiplier(STREAMER_TYPE_OBJECT, RenderingObjectsRadius(playerid), playerid);
    Streamer_Update(playerid);

    format(logString, sizeof(logString), "%s (%s) logou como %s. ([%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d])", GetPlayerUserEx(playerid), GetPlayerIP(playerid), pNome(playerid), pInfo[playerid][pGuns][0], pInfo[playerid][pAmmo][0], pInfo[playerid][pGuns][1], pInfo[playerid][pAmmo][1], pInfo[playerid][pGuns][2], pInfo[playerid][pAmmo][2], pInfo[playerid][pGuns][3], pInfo[playerid][pAmmo][3], pInfo[playerid][pGuns][4], pInfo[playerid][pAmmo][4], pInfo[playerid][pGuns][5], pInfo[playerid][pAmmo][5], pInfo[playerid][pGuns][6], pInfo[playerid][pAmmo][6], pInfo[playerid][pGuns][7], pInfo[playerid][pAmmo][7], pInfo[playerid][pGuns][8], pInfo[playerid][pAmmo][8], pInfo[playerid][pGuns][9], pInfo[playerid][pAmmo][9],
	pInfo[playerid][pGuns][10], pInfo[playerid][pAmmo][10], pInfo[playerid][pGuns][11], pInfo[playerid][pAmmo][11], pInfo[playerid][pGuns][12], pInfo[playerid][pAmmo][12]);
	logCreate(playerid, logString, 2);

    if (pInfo[playerid][pFactionID] != -1) {
	    pInfo[playerid][pFaction] = GetFactionByID(pInfo[playerid][pFactionID]);

	    if (pInfo[playerid][pFaction] == -1)
	        ResetFaction(playerid);
	}

    pInfo[playerid][pLogged] = true;
    TogglePlayerSpectating(playerid, false);
    SetCameraBehindPlayer(playerid);
    SetWeapons(playerid);
    SetPlayerArmedWeapon(playerid, WEAPON:0);
    return true;
}

SaveCharacterInfo(playerid) {
    new Float:pos[4];

    pInfo[playerid][pMoney] = GetMoney(playerid);
    pInfo[playerid][pHealth] = GetPlayerHealthEx(playerid);
    pInfo[playerid][pArmour] = GetPlayerArmourEx(playerid);
    pInfo[playerid][pScore] = GetPlayerScore(playerid);
    pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
    pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);
    pInfo[playerid][pPositionX] = pos[0];
    pInfo[playerid][pPositionY] = pos[1];
    pInfo[playerid][pPositionZ] = pos[2];
    pInfo[playerid][pPositionA] = pos[3];

    // SAVE MAIN INFO
    mysql_format(DBConn, query, sizeof query, "UPDATE players SET \
    `name` = '%s', \
    `last_ip` = '%s',\
    `minutes` = '%d',\
    `hours` = '%d', \
    `money` = '%d', \
    `payment` = '%d', \
    `taxes` = '%d', \
    `skin` = '%d', \
    `health` = '%f', \
    `armour` = '%f',\
    `score` = '%d', \
    `virtual_world` = '%d', \
    `interior` = '%d', \
    `positionX` = '%f', \
    `positionY` = '%f', \
    `positionZ` = '%f',\
    `positionA` = '%f', \
    `phone_number` = '%d', \
    `phone_type` = '%d' \
    WHERE ID = '%d'", 
    pInfo[playerid][pName], 
    pInfo[playerid][pLastIP], 
    pInfo[playerid][pPlayingMinutes],
    pInfo[playerid][pPlayingHours],
    pInfo[playerid][pMoney], 
    pInfo[playerid][pPayment],
    pInfo[playerid][pTaxes],
    pInfo[playerid][pSkin], 
    pInfo[playerid][pHealth], 
    pInfo[playerid][pArmour], 
    pInfo[playerid][pScore], 
    pInfo[playerid][pVirtualWorld],
    pInfo[playerid][pInterior],
    pInfo[playerid][pPositionX], 
    pInfo[playerid][pPositionY], 
    pInfo[playerid][pPositionZ],
    pInfo[playerid][pPositionA],
    pInfo[playerid][pPhoneType],
    pInfo[playerid][pPhoneNumber],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    SavePlayerLicenses(playerid);
    SavePlayerWeapons(playerid);
    SavePlayerApparence(playerid);
    SavePlayerPremium(playerid);
    SavePlayerRadio(playerid);
    SavePlayerInventory(playerid);
    SavePlayerPet(playerid);
    SavePlayerConfig(playerid);
    SavePlayerStatus(playerid);
    SavePlayerFaction(playerid);
    return true;
}

SavePlayerWeapons(playerid) {
    // SAVE PLAYER WEAPONS
    mysql_format(DBConn, query, sizeof query, "UPDATE players_weapons SET \
    `Gun1` = '%d', \
    `Ammo1` = '%d', \
    `Gun2` = '%d', \
    `Ammo2` = '%d', \
    `Gun3` = '%d', \
    `Ammo3` = '%d', \
    `Gun4` = '%d', \
    `Ammo4` = '%d', \
    `Gun5` = '%d', \
    `Ammo5` = '%d', \
    `Gun6` = '%d', \
    `Ammo6` = '%d', \
    `Gun7` = '%d', \
    `Ammo7` = '%d', \
    `Gun8` = '%d', \
    `Ammo8` = '%d', \
    `Gun9` = '%d', \
    `Ammo9` = '%d', \
    `Gun10` = '%d', \
    `Ammo10` = '%d', \
    `Gun11` = '%d', \
    `Ammo11` = '%d', \
    `Gun12` = '%d', \
    `Ammo12` = '%d', \
    `Gun13` = '%d', \
    `Ammo13` = '%d' \
    WHERE character_id = '%d';", 
    pInfo[playerid][pGuns][0], 
	pInfo[playerid][pAmmo][0],
	pInfo[playerid][pGuns][1], 
	pInfo[playerid][pAmmo][1],
	pInfo[playerid][pGuns][2], 
	pInfo[playerid][pAmmo][2],
	pInfo[playerid][pGuns][3], 
	pInfo[playerid][pAmmo][3],
	pInfo[playerid][pGuns][4], 
	pInfo[playerid][pAmmo][4],
	pInfo[playerid][pGuns][5], 
	pInfo[playerid][pAmmo][5],
	pInfo[playerid][pGuns][6], 
	pInfo[playerid][pAmmo][6],
	pInfo[playerid][pGuns][7], 
	pInfo[playerid][pAmmo][7],
	pInfo[playerid][pGuns][8], 
	pInfo[playerid][pAmmo][8],
	pInfo[playerid][pGuns][9], 
	pInfo[playerid][pAmmo][9],
	pInfo[playerid][pGuns][10], 
	pInfo[playerid][pAmmo][10],
	pInfo[playerid][pGuns][11], 
	pInfo[playerid][pAmmo][11],
	pInfo[playerid][pGuns][12], 
	pInfo[playerid][pAmmo][12],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    return true;
}

SavePlayerInventory(playerid) {
    new Cache:result;
    for (new i = 0; i < 30; i ++) {
        mysql_format(DBConn, query, sizeof query, "UPDATE `players_inv` SET \
        `item%d` = '%d', \
        `amount%d` = '%d' \
        WHERE `character_id` = '%d'", 
        i + 1, pInfo[playerid][iItem][i], 
        i + 1, pInfo[playerid][iAmount][i], pInfo[playerid][pID]);
        result = mysql_query(DBConn, query);
	}
    cache_delete(result);
    return true;
}

SavePlayerApparence(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE players_apparence SET \
    `ethnicity` = '%d', \
    `color_eyes` = '%d', \
    `color_hair` = '%d', \
    `height` = '%d', \
    `weight` = '%f', \
    `build` = '%d', \
    `description` = '%s' \
    WHERE character_id = '%d';", 
    pInfo[playerid][pEthnicity],
    pInfo[playerid][pColorEyes],
    pInfo[playerid][pColorHair],
    pInfo[playerid][pHeight],
    pInfo[playerid][pWeight],
    pInfo[playerid][pBuild],
    pInfo[playerid][pDescription],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    return true;
}

SavePlayerPremium(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE players_premium SET \
    `donator` = '%d',        \
    `donator_time` = '%d'    \
    WHERE character_id = '%d';", 
    pInfo[playerid][pDonator],
    pInfo[playerid][pDonatorTime],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    return true;
}

SavePlayerRadio(playerid) {
    mysql_format(DBConn, query, sizeof(query), "UPDATE `players_radio` SET \
    `rRadioState`='%d', \
    `rRadioSlot1`='%d', \
    `rRadioSlot2`='%d', \
    `rRadioSlot3`='%d', \
    `rRadioSlot4`='%d', \
    `rRadioSlot5`='%d', \
    `rRadioSlot6`='%d', \
    `rRadioSlot7`='%d', \
    `rRadioName1`='%s', \
    `rRadioName2`='%s', \
    `rRadioName3`='%s', \
    `rRadioName4`='%s', \
    `rRadioName5`='%s', \
    `rRadioName6`='%s', \
    `rRadioName7`='%s', \
    `pRadioNvl`='%d' WHERE `character_id` = '%d'", 
    pInfo[playerid][rRadioState],
    pInfo[playerid][rRadioSlot][0],
    pInfo[playerid][rRadioSlot][1],
    pInfo[playerid][rRadioSlot][2],
    pInfo[playerid][rRadioSlot][3],
    pInfo[playerid][rRadioSlot][4],
    pInfo[playerid][rRadioSlot][5],
    pInfo[playerid][rRadioSlot][6],
    pInfo[playerid][rRadioName1],
    pInfo[playerid][rRadioName2],
    pInfo[playerid][rRadioName3],
    pInfo[playerid][rRadioName4],
    pInfo[playerid][rRadioName5],
    pInfo[playerid][rRadioName6],
    pInfo[playerid][rRadioName7],
    pInfo[playerid][pRadioNvl],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);
    return true;
}

SavePlayerPet(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE players_pet SET \
    `pet_model` = '%d',        \
    `pet_name` = '%s'    \
    WHERE character_id = '%d';", 
    PetData[playerid][petModelID],
    PetData[playerid][petName],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    return true;
}

SavePlayerConfig(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE players_config SET \
    `newbie_chat` = '%d', \
    `faction_chat` = '%d', \
    `admin_chat` = '%d', \
    `nametag` = '%d', \
    `objects` = '%d',    \
    `speedo` = '%d',       \
    `hud` = '%d' \
    WHERE character_id = '%d';", 
    pInfo[playerid][pTogNewbie],
    pInfo[playerid][pTogFaction],
    pInfo[playerid][pTogAdmin],
    pInfo[playerid][pNametagType],
    pInfo[playerid][pRenderObjects],
    pInfo[playerid][pHudSpeedo],
    pInfo[playerid][pHudStyle],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);
    return true;
}

SavePlayerStatus(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE players_status SET \
    `hunger` = '%d', \
    `thirst` = '%d', \
    `stamina` = '%d', \
    `max_stamina` = '%d', \
    `addiction` = '%d'    \
    WHERE character_id = '%d';", 
    pInfo[playerid][pHunger],
    pInfo[playerid][pThirst],
    pInfo[playerid][pStamina],
    pInfo[playerid][pMaxStamina],
    pInfo[playerid][pAddiction],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);
    return true;
}

SavePlayerFaction(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE players_faction SET \
    `faction_id` = '%d',        \
    `faction_rank` = '%d'    \
    WHERE character_id = '%d';", 
    pInfo[playerid][pFactionID],
    pInfo[playerid][pFactionRank],
    pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    return true;
}

public OnPlayerDisconnect(playerid, reason) {
    if(pInfo[playerid][pLogged] == false) return false;
    
    new string[256];
    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `online` = '0' WHERE `ID` = '%d';", pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    switch(reason){
	    case 0: format(string,sizeof(string),"(( %s (Problema de Conexão/Crash) ))", pNome(playerid));
	    case 1: format(string,sizeof(string),"(( %s (Desconectou-se) ))", pNome(playerid));
	    case 2: format(string,sizeof(string),"(( %s (Kickado/Banido) ))", pNome(playerid));
	}
	SendNearbyMessage(playerid, 30.0, COLOR_WHITE, string);

    pInfo[playerid][pLogged] = false;
    format(logString, sizeof(logString), "%s desconectou-se do servidor. ARMAS: ([%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d])", pNome(playerid), pInfo[playerid][pGuns][0], pInfo[playerid][pAmmo][0], pInfo[playerid][pGuns][1], pInfo[playerid][pAmmo][1], pInfo[playerid][pGuns][2], pInfo[playerid][pAmmo][2], pInfo[playerid][pGuns][3], pInfo[playerid][pAmmo][3], pInfo[playerid][pGuns][4], pInfo[playerid][pAmmo][4], pInfo[playerid][pGuns][5], pInfo[playerid][pAmmo][5], pInfo[playerid][pGuns][6], pInfo[playerid][pAmmo][6], pInfo[playerid][pGuns][7], pInfo[playerid][pAmmo][7], pInfo[playerid][pGuns][8], pInfo[playerid][pAmmo][8], pInfo[playerid][pGuns][9], pInfo[playerid][pAmmo][9], pInfo[playerid][pGuns][10], pInfo[playerid][pAmmo][10], pInfo[playerid][pGuns][11], pInfo[playerid][pAmmo][11], pInfo[playerid][pGuns][12], pInfo[playerid][pAmmo][12]);
	logCreate(playerid, logString, 2);

    printf("[DATABASE] %s [%d] (%s [%d]) desconectado do servidor e salvo na database.", GetPlayerNameEx(playerid), GetPlayerSQLID(playerid), GetPlayerUserEx(playerid), uInfo[playerid][uID]);

    SaveUserInfo(playerid);
    SaveCharacterInfo(playerid);
    PetDespawn(playerid);

    ResetUserData(playerid);
    ResetCharacterData(playerid);
    ResetCharacterSelection(playerid);

    SOS_Clear(playerid);
    Report_Clear(playerid);
    return true;
}