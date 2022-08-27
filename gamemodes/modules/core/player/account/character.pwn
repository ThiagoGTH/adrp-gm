#include <YSI_Coding\y_hooks>

/*Dialog:CHARACTER_SELECT(playerid, response, listitem, inputtext[]) {
	if(!response || !strcmp(inputtext, " ")) return ShowUsersCharacters(playerid);

    else if(!strcmp(inputtext, "Criar personagem")) {
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d';", uInfo[playerid][uID]);
        mysql_query(DBConn, query);

        if(cache_num_rows() > uInfo[playerid][uCharSlots]) {
            SendErrorMessage(playerid, "Voc� atingiu o limite de personagens. Adquira mais slots no UCP.");
            return ShowUsersCharacters(playerid);
        } else Dialog_Show(playerid, CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
            "Para come�ar a registrar um personagem, voc� dever� colocar o nome dele(a) abaixo.\nDigite com o padr�o: 'Nome_Sobrenome'", 
            "Continuar", "Voltar");

    } else if(!strcmp(inputtext, "Deletar personagem")) {

        return Dialog_Show(playerid, CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem \
                que voc� gostaria de deletar.", "Continuar", "Voltar");

    }
	return true;
}*/

/*Dialog:CHARACTER_CREATE_NAME(playerid, response, listitem, inputtext[]) {
    if(!response) return ShowUsersCharacters(playerid), pInfo[playerid][pName][0] = EOS;

    if(strlen(inputtext) < 1) {
        return Dialog_Show(playerid, CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
            "Para come�ar a registrar um personagem, voc� dever� colocar o nome dele(a) abaixo.\n \nDigite com o padr�o: Nome_Sobrenome",
            "Continuar", "Voltar");
    }

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players a, users b WHERE a.name = '%s'\
        OR b.username = '%s';", inputtext, inputtext);
    mysql_query(DBConn, query);

    if(cache_num_rows()) {
        SendClientMessage(playerid, COLOR_LIGHTRED, "J� existe outro usu�rio ou um personagem com este nome.");
        return Dialog_Show(playerid, CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
            "Para come�ar a registrar um personagem, voc� dever� colocar o nome dele(a) abaixo.\n \nDigite com o padr�o: Nome_Sobrenome",
            "Continuar", "Voltar");
    }
        
    format(pInfo[playerid][pName], 24, "%s", inputtext);

    CreateCharacter(playerid, pInfo[playerid][pName]);

    va_SendClientMessage(playerid, -1, "O seu novo personagem ser� chamado de %s.", inputtext);
    SendServerMessage(playerid, "O personagem foi criado com sucesso e voc� j� pode v�-lo na lista de personagens.");

    ShowUsersCharacters(playerid);
	return true;
}

Dialog:CHARACTER_DELETE(playerid, response, listitem, inputtext[]) {
    new string[256];
    if(!response) return ShowUsersCharacters(playerid);

    if(!strlen(inputtext) || strlen(inputtext) > 24) {
        SendErrorMessage(playerid, "Voc� deve digitar o nome v�lido de um personagem.");
        return Dialog_Show(playerid, CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem que voc� gostaria de deletar.", "Continuar", "Voltar");
    }

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s' AND `user_id` = '%d';", inputtext, uInfo[playerid][uID]);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) {
        SendErrorMessage(playerid, "Esse personagem n�o existe ou n�o � desse usu�rio.");
        return Dialog_Show(playerid, CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem que voc� gostaria de deletar.", "Continuar", "Voltar");
    }

    format(pInfo[playerid][characterDelete], 24, "%s", inputtext);
    format(string, 256, "Voc� realmente deseja deletar o personagem %s?\n \nEssa a��o � irrevers�vel.", pInfo[playerid][characterDelete]);
    Dialog_Show(playerid, CHARACTER_DELETE_CONFIRM, DIALOG_STYLE_MSGBOX, "Deletar Personagem - Confirmar", string, "Deletar","Cancelar");
	return true;
}

Dialog:CHARACTER_DELETE_CONFIRM(playerid, response, listitem, inputtext[]) {
    if(!response) return ShowUsersCharacters(playerid), pInfo[playerid][characterDelete][0] = EOS;

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `players` WHERE `name` = '%s' AND `user_id` = '%d';", pInfo[playerid][characterDelete], uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    va_SendClientMessage(playerid, -1, "SERVER: Voc� deletou o personagem %s com sucesso. A a��o � irrevers�vel.", pInfo[playerid][characterDelete]);
    format(logString, sizeof(logString), "%s deletou o personagem %s.", uInfo[playerid][uName], pInfo[playerid][characterDelete]);
	logCreate(playerid, logString, 4);
    pInfo[playerid][characterDelete][0] = EOS;
    ShowUsersCharacters(playerid);
	return true;
}

CreateCharacter(playerid, characterName[]) {

    mysql_format(DBConn, query, sizeof query,
        "INSERT INTO players (`name`, `user_id`, `first_ip`) VALUES ('%s', '%d', '%s');",
            characterName, uInfo[playerid][uID], GetPlayerIP(playerid));
    mysql_query(DBConn, query);

    pInfo[playerid][pName][0] = EOS;

    printf("[DATABASE] %s (User: %s) foi inserido na database.", characterName, GetPlayerNameEx(playerid));

}*/

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
    cache_get_value_name_int(0, "bank", pInfo[playerid][pBank]);
    cache_get_value_name_int(0, "savings", pInfo[playerid][pSavings]);

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

    if(first_login == 0) {
        mysql_format(DBConn, query, sizeof query, "UPDATE players SET `first_login` = '%d' WHERE `name` = '%s';", _:Now(), pInfo[playerid][pName]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_apparence (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_weapons (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_inv (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO players_premium (`character_id`) VALUES ('%d');", pInfo[playerid][pID]);
        mysql_query(DBConn, query);
    }

    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `last_login` = %d WHERE `name` = '%s';", _:Now(), pInfo[playerid][pName]);
    mysql_query(DBConn, query);

    printf("[DATABASE] %s foi carregado com sucesso do banco de dados.", pInfo[playerid][pName]);
    LoadLicencesData(playerid);
    LoadPlayerWeapons(playerid);
    LoadPlayerApparence(playerid);
    LoadPlayerPremium(playerid);
    LoadPlayerRadio(playerid);
    LoadPlayerInventory(playerid);

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
    // PLAYER APPARENCE
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

SpawnSelectedCharacter(playerid) {
    pInfo[playerid][pLogged] = false;
    TogglePlayerSpectating(playerid, false);
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, pInfo[playerid][pMoney]);
    SetPlayerHealth(playerid, pInfo[playerid][pHealth]);
    SetPlayerArmour(playerid, pInfo[playerid][pArmour]);
    
    SetPlayerScore(playerid, pInfo[playerid][pScore]);

    SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
    SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);

    SetPlayerName(playerid, pInfo[playerid][pName]);

    SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 
        pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ], pInfo[playerid][pPositionA],
        0, 0, 0, 0, 0, 0);

    if (GetPlayerSkin(playerid) < 1){
        SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
    }

    switch(pInfo[playerid][pDonator]){
	    case 0: pInfo[playerid][pSpawnVehicle] = 2;
	    case 1: pInfo[playerid][pSpawnVehicle] = 3;
	    case 2: pInfo[playerid][pSpawnVehicle] = 4;
	    case 3: pInfo[playerid][pSpawnVehicle] = 5;
        default: pInfo[playerid][pSpawnVehicle] = 2;
	}

    SpawnPlayer(playerid);
    SetWeapons(playerid);
    pInfo[playerid][pHealthMax] = 150.0;
    SetPlayerColor(playerid, 0xFFFFFFFF);
    ClearPlayerChat(playerid);
    va_SendClientMessage(playerid, -1, "SERVER: Voc� est� jogando com o personagem %s.", pNome(playerid));
    if(uInfo[playerid][uJailed] > 0){
        SetPlayerPos(playerid, 197.6346, 175.3765, 1003.0234);
        SetPlayerHealth(playerid, pInfo[playerid][pHealthMax]);
        SetPlayerInterior(playerid, 3);
        SetPlayerVirtualWorld(playerid, (playerid + 100));
        SetPlayerFacingAngle(playerid, 0.0);
        SetCameraBehindPlayer(playerid);
        ResetWeapons(playerid);
        SendServerMessage(playerid, "Voc� logou com uma pris�o administrativa pendente. Restam %d minutos.", uInfo[playerid][uJailed]/60);
    }
    if (uInfo[playerid][uAdmin] > 0) va_SendClientMessage(playerid, -1, "SERVER: Voc� logou com o n�vel administrativo %d.", uInfo[playerid][uAdmin]);

    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `online` = '1' WHERE `ID` = '%d';", pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    format(logString, sizeof(logString), "%s (%s) logou como %s. ([%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d])", GetPlayerUserEx(playerid), GetPlayerIP(playerid), pNome(playerid), pInfo[playerid][pGuns][0], pInfo[playerid][pAmmo][0], pInfo[playerid][pGuns][1], pInfo[playerid][pAmmo][1], pInfo[playerid][pGuns][2], pInfo[playerid][pAmmo][2], pInfo[playerid][pGuns][3], pInfo[playerid][pAmmo][3], pInfo[playerid][pGuns][4], pInfo[playerid][pAmmo][4], pInfo[playerid][pGuns][5], pInfo[playerid][pAmmo][5], pInfo[playerid][pGuns][6], pInfo[playerid][pAmmo][6], pInfo[playerid][pGuns][7], pInfo[playerid][pAmmo][7], pInfo[playerid][pGuns][8], pInfo[playerid][pAmmo][8], pInfo[playerid][pGuns][9], pInfo[playerid][pAmmo][9],
	pInfo[playerid][pGuns][10], pInfo[playerid][pAmmo][10], pInfo[playerid][pGuns][11], pInfo[playerid][pAmmo][11], pInfo[playerid][pGuns][12], pInfo[playerid][pAmmo][12]);
	logCreate(playerid, logString, 2);
    
    if(pInfo[playerid][pInterior] != 0 || pInfo[playerid][pVirtualWorld] != 0) {
        TogglePlayerSpectating(playerid, false);
        SetCameraBehindPlayer(playerid);
        SetWeapons(playerid);
        SetPlayerArmedWeapon(playerid, 0);
        pInfo[playerid][pLogged] = true;
        return false;
    }

    TogglePlayerSpectating(playerid, true);
    InterpolateCameraPos(playerid,  pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]+500, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]+300, 5000);
    InterpolateCameraLookAt(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]+495, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]+295, 5000);
    SetTimerEx("SpawnPlayerPosCamera", 5000, false, "i", playerid, 0);
    return true;
}

forward SpawnPlayerPosCamera(playerid);
public SpawnPlayerPosCamera(playerid) {
    pInfo[playerid][pLogged] = true;
    TogglePlayerSpectating(playerid, false);
    SetCameraBehindPlayer(playerid);
    SetWeapons(playerid);
    SetPlayerArmedWeapon(playerid, 0);
    return true;
}

SaveCharacterInfo(playerid) {
    new Float:pos[4];

    pInfo[playerid][pMoney] = GetMoney(playerid);
    pInfo[playerid][pSkin] = GetPlayerSkin(playerid);
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
    `bank` = '%d', \
    `savings` = '%d', \
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
    WHERE ID = '%d';", 
    pInfo[playerid][pName], 
    pInfo[playerid][pLastIP], 
    pInfo[playerid][pPlayingMinutes],
    pInfo[playerid][pPlayingHours],
    pInfo[playerid][pMoney], 
    pInfo[playerid][pBank],
    pInfo[playerid][pSavings],
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

    SavePlayerWeapons(playerid);
    SavePlayerApparence(playerid);
    SavePlayerPremium(playerid);
    SavePlayerRadio(playerid);
    SavePlayerInventory(playerid);
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
    `rRadioState`='%i', \
    `rRadioSlot1`='%i', \
    `rRadioSlot2`='%i', \
    `rRadioSlot3`='%i', \
    `rRadioSlot4`='%i', \
    `rRadioSlot5`='%i', \
    `rRadioSlot6`='%i', \
    `rRadioSlot7`='%i', \
    `rRadioName1`='%s', \
    `rRadioName2`='%s', \
    `rRadioName3`='%s', \
    `rRadioName4`='%s', \
    `rRadioName5`='%s', \
    `rRadioName6`='%s', \
    `rRadioName7`='%s', \
    `pRadioNvl`='%i' WHERE `character_id` = '%d'", 
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

hook OnPlayerDisconnect(playerid, reason) {
    if(pInfo[playerid][pLogged] == false) return false;
    
    new string[256];
    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `online` = '0' WHERE `ID` = '%d';", pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    switch(reason){
	    case 0: format(string,sizeof(string),"(( %s (Problema de Conex�o/Crash) ))", pNome(playerid));
	    case 1: format(string,sizeof(string),"(( %s (Desconectou-se) ))", pNome(playerid));
	    case 2: format(string,sizeof(string),"(( %s (Kickado/Banido) ))", pNome(playerid));
	}
	SendNearbyMessage(playerid, 30.0, COLOR_WHITE, string);

    pInfo[playerid][pLogged] = false;
    format(logString, sizeof(logString), "%s desconectou-se do servidor. ARMAS: ([%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d])", pNome(playerid), pInfo[playerid][pGuns][0], pInfo[playerid][pAmmo][0], pInfo[playerid][pGuns][1], pInfo[playerid][pAmmo][1], pInfo[playerid][pGuns][2], pInfo[playerid][pAmmo][2], pInfo[playerid][pGuns][3], pInfo[playerid][pAmmo][3], pInfo[playerid][pGuns][4], pInfo[playerid][pAmmo][4], pInfo[playerid][pGuns][5], pInfo[playerid][pAmmo][5], pInfo[playerid][pGuns][6], pInfo[playerid][pAmmo][6], pInfo[playerid][pGuns][7], pInfo[playerid][pAmmo][7], pInfo[playerid][pGuns][8], pInfo[playerid][pAmmo][8], pInfo[playerid][pGuns][9], pInfo[playerid][pAmmo][9], pInfo[playerid][pGuns][10], pInfo[playerid][pAmmo][10], pInfo[playerid][pGuns][11], pInfo[playerid][pAmmo][11], pInfo[playerid][pGuns][12], pInfo[playerid][pAmmo][12]);
	logCreate(playerid, logString, 2);
    printf("[DATABASE] %s desconectado do servidor e salvo na database.", GetPlayerNameEx(playerid));

    SaveCharacterInfo(playerid);
    ResetCharacterData(playerid);
    ResetCharacterSelection(playerid);
    SOS_Clear(playerid);
    Report_Clear(playerid);
    return true;
}