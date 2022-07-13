/*

Como o modulo user.pwn trabalha com users, esse vai ser um tipo de extensão pra gerenciar de personagens (carregar, criar, etc.), ou...
... a mesma metodologia de trabalho do user.pwn, mas agora estamos lidando diretamente com os personagens especificos daquele usuário.

*/

#include <YSI_Coding\y_hooks>

// Pode ficar um pouco confuso de agora em diante. Visto que não tem uma maneira tão eficiente de inserir multiplas informações em um só
// dialog, a inserção aconterá por quatro diferente deles. Você pode indentifica-los a começarem com 'DIALOG_CHARACTER_CREATE'

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

    if(dialogid == DIALOG_CHARACTER_SELECT) {
        
        if(!response || !strcmp(inputtext, " "))
            return ShowUsersCharacters(playerid);

        else if(!strcmp(inputtext, "Criar personagem")) {
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user` = '%s';", uInfo[playerid][uName]);
            mysql_query(DBConn, query);

            if(cache_num_rows() >= USER_CHARACTERS_LIMIT && !uInfo[playerid][uVip]) {
                SendErrorMessage(playerid, "Você atingiu o limite de personagens. Adquira VIP e consiga mais slots.");
                return ShowUsersCharacters(playerid);
            } else if(cache_num_rows() >= USER_CHARACTERS_LIMIT_VIP) {
                SendErrorMessage(playerid, "Você atingiu o limite de personagens! Compre mais com um administrador, se desejar.");
                return ShowUsersCharacters(playerid);
            } else ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
                "Para começar a registrar um personagem, você deverá colocar o nome dele(a) abaixo.\nDigite com o padrão: 'Nome_Sobrenome'", 
                "Continuar", "Voltar");

        } else if(!strcmp(inputtext, "Deletar personagem")) {

            if(!uInfo[playerid][uVip]) {
                SendErrorMessage(playerid, "Somente usuários VIP podem deletar personagens.");
                return ShowUsersCharacters(playerid);
            }
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem \
                    que você gostaria de deletar.", "Continuar", "Voltar");

        } else {
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s';", inputtext);
            mysql_query(DBConn, query);
            if(!cache_num_rows())
                return ShowUsersCharacters(playerid);
                
            ResetCharacterData(playerid);
            LoadCharacterInfo(playerid, inputtext);
            SpawnSelectedCharacter(playerid);
        }
    } 

    // Enfim, os dialogs de crição de personagem. Pode ficar um pouco extenso.

    if(dialogid == DIALOG_CHARACTER_CREATE_NAME) {
        
        if(!response)
            return ShowUsersCharacters(playerid), pInfo[playerid][pName][0] = EOS;

        if(strlen(inputtext) < 1) {
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
                "Para começar a registrar um personagem, você deverá colocar o nome dele(a) abaixo.\n \nDigite com o padrão: Nome_Sobrenome",
                "Continuar", "Voltar");
        }

        // Checking if that specified name already exists either as a character's name or as an username
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players a, users b WHERE a.name = '%s'\
        OR b.username = '%s';", inputtext, inputtext);
        mysql_query(DBConn, query);

        if(cache_num_rows()) {
            SendClientMessage(playerid, COLOR_LIGHTRED, "Já existe outro usuário ou um personagem com este nome.");
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
                "Para começar a registrar um personagem, você deverá colocar o nome dele(a) abaixo.\n \nDigite com o padrão: Nome_Sobrenome",
                "Continuar", "Voltar");
        }
        
        format(pInfo[playerid][pName], 24, "%s", inputtext);
        va_SendClientMessage(playerid, -1, "O seu novo personagem será chamado de %s", pInfo[playerid][pName]);

        ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_AGE, DIALOG_STYLE_INPUT, "Criar Personagem - Idade", 
            "Agora, prossiga com a idade do seu personagem.\n \nA idade deve ser entre 13 e 99", "Continuar", "Voltar");

    }

    if(dialogid == DIALOG_CHARACTER_CREATE_AGE) {

        if(!response) {
            pInfo[playerid][pAge] = 0;
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
                "Para começar a registrar um personagem, você deverá colocar o nome dele(a) abaixo.\n \nDigite com o padrão: Nome_Sobrenome",
                "Continuar", "Voltar");    
        }

        if(strval(inputtext) < 13 || strval(inputtext) > 99) {
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_AGE, DIALOG_STYLE_INPUT, "Criar Personagem - Idade", 
            "Agora, prossiga com a idade do seu personagem.\n \nA idade deve ser entre 13 e 99", "Continuar", "Voltar");
        }
        
        pInfo[playerid][pAge] = strval(inputtext);
        va_SendClientMessage(playerid, -1, "Seu personagem terá %d anos", pInfo[playerid][pAge]);

        ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_GENDER, DIALOG_STYLE_LIST, "Criar Personagem - Gênero", 
            "Masculino\nFeminino", "Continuar", "Voltar");

    }

    if(dialogid == DIALOG_CHARACTER_CREATE_GENDER) {
        
        if(!response) {
            pInfo[playerid][pGender][0] = EOS;
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_AGE, DIALOG_STYLE_INPUT, "Criar Personagem - Idade", 
                "Agora, prossiga com a idade do seu personagem.\n \nA idade deve ser entre 13 e 99", "Continuar", "Voltar");
        }

        format(pInfo[playerid][pGender], 15, "%s", inputtext);
        va_SendClientMessage(playerid, -1, "Seu personagem é do sexo '%s'", pInfo[playerid][pGender]);
        
        ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_BG, DIALOG_STYLE_INPUT, "Criar Personagem - ORIGEM",
            "Insira o local de origem do personagem (até 50 caracteres)", "Continuar", "Voltar");
    }

    if(dialogid == DIALOG_CHARACTER_CREATE_BG) {
        if(!response) {
            pInfo[playerid][pBackground][0] = EOS;
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_GENDER, DIALOG_STYLE_LIST, "Criar Personagem - Gênero", 
            "Masculino\nFeminino", "Continuar", "Voltar");
        }

        if(strlen(inputtext) < 1 || strlen(inputtext) > 50) {
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_BG, DIALOG_STYLE_INPUT, "Criar Personagem - ORIGEM",
            "Insira o local de origem do personagem (até 50 caracteres)", "Continuar", "Voltar");
        }

        format(pInfo[playerid][pBackground], 50, "%s", inputtext);
        va_SendClientMessage(playerid, -1, "A origem do seu personagem é de %s", pInfo[playerid][pBackground]);

        CreateCharacter(playerid, pInfo[playerid][pName], pInfo[playerid][pAge], pInfo[playerid][pGender], pInfo[playerid][pBackground]);

        SendClientMessage(playerid, -1, " ");
        SendServerMessage(playerid, "O personagem foi criado com sucesso e você já pode vê-lo na lista de personagens.");

        ShowUsersCharacters(playerid);
    }

    // Deletar personagens (Função VIP)

    if(dialogid == DIALOG_CHARACTER_DELETE) {
        new string[256];

        if(!response)
            return ShowUsersCharacters(playerid);

        if(!strlen(inputtext) || strlen(inputtext) > 24) {
            SendErrorMessage(playerid, "Você deve digitar o nome válido de um personagem.");
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem \
                    que você gostaria de deletar.", "Continuar", "Voltar");
        }

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s' AND `user` = '%s';",
            inputtext, uInfo[playerid][uName]);
        mysql_query(DBConn, query);
        if(!cache_num_rows()) {
            SendErrorMessage(playerid, "Esse personagem não existe ou não é desse usuário.");
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem \
                    que você gostaria de deletar.", "Continuar", "Voltar");
        }

        format(pInfo[playerid][characterDelete], 24, "%s", inputtext);
        format(string, 256, "Você realmente deseja deletar o personagem %s?\n \nEssa ação é irreversível.", pInfo[playerid][characterDelete]);
        ShowPlayerDialog(playerid, DIALOG_CHARACTER_DELETE_CONFIRM, DIALOG_STYLE_MSGBOX, "Deletar Personagem - Confirmar", string, "Deletar", "Cancelar");
    }

    if(dialogid == DIALOG_CHARACTER_DELETE_CONFIRM) {
        
        if(!response)
            return ShowUsersCharacters(playerid), pInfo[playerid][characterDelete][0] = EOS;

        mysql_format(DBConn, query, sizeof query, "DELETE FROM players WHERE `name` = '%s' AND `user` = '%s';",
            pInfo[playerid][characterDelete], uInfo[playerid][uName]);
        mysql_query(DBConn, query);

        va_SendClientMessage(playerid, -1, "SERVER: Você deletou o personagem %s com sucesso. A ação é irreversível.", pInfo[playerid][characterDelete]);
        format(logString, sizeof(logString), "%s deletou o personagem %s.", uInfo[playerid][uName], pInfo[playerid][characterDelete]);
	    logCreate(playerid, logString, 4);
        pInfo[playerid][characterDelete][0] = EOS;
        ShowUsersCharacters(playerid);
    }

    return 1;
}


// Nada muito especial. Vamos inserir o personagem criado com as informações dos inputtexts das dialogs anteriores e, até, reseta-las.

CreateCharacter(playerid, characterName[], characterAge, characterGender[], characterBackground[]) {

    mysql_format(DBConn, query, sizeof query,
        "INSERT INTO players (`name`, `user`, `age`, `gender`, `background`, `first_ip`) VALUES ('%s', '%s', %d, '%s', '%s', '%s');",
            characterName, GetPlayerNameEx(playerid), characterAge, characterGender, characterBackground, GetPlayerIP(playerid));
    mysql_query(DBConn, query);

    pInfo[playerid][pName][0] = pInfo[playerid][pGender][0] = pInfo[playerid][pBackground][0] = EOS;
    pInfo[playerid][pAge] = 0;

    printf("[DATABASE] %s (User: %s) foi inserido na database.", characterName, GetPlayerNameEx(playerid));

}

// Já que as funções anteriores estavam relacionadas a criação de um personagem, agora as próximas funções seerão destinadas a carregar, salvar,
// sair, logar, etc. com o personagem.

LoadCharacterInfo(playerid, playerName[]) {
    new first_login;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s'", playerName);
    mysql_query(DBConn, query);

    cache_get_value_name_int(0, "ID", pInfo[playerid][pID]);

    cache_get_value_name(0, "user", pInfo[playerid][pUser]);
    cache_get_value_name(0, "name", pInfo[playerid][pName]);
    format(pInfo[playerid][pLastIP], 20, "%s", GetPlayerIP(playerid));

    cache_get_value_name_int(0, "age", pInfo[playerid][pAge]);
    cache_get_value_name(0, "gender", pInfo[playerid][pGender]);
    cache_get_value_name(0, "background", pInfo[playerid][pBackground]);

    cache_get_value_name_int(0, "money", pInfo[playerid][pMoney]);
    cache_get_value_name_int(0, "bank", pInfo[playerid][pBank]);

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

    for (new i = 0; i < 13; i ++) {
	    format(query, sizeof(query), "Gun%d", i + 1);
	    cache_get_value_name_int(0, query, pInfo[playerid][pGuns][i]);
	    format(query, sizeof(query), "Ammo%d", i + 1);
	    cache_get_value_name_int(0, query, pInfo[playerid][pAmmo][i]);
	}
    
    if(!first_login) {
        mysql_format(DBConn, query, sizeof query, "UPDATE players SET `first_login` = %d WHERE `name` = '%s';", _:Now(), pInfo[playerid][pName]);
        mysql_query(DBConn, query);
    }

    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `last_login` = %d WHERE `name` = '%s';", _:Now(), pInfo[playerid][pName]);
    mysql_query(DBConn, query);

    printf("[DATABASE] %s foi carregado com sucesso do banco de dados.", playerName);
    LoadLicencesData(playerid);

}

// Em complemento as informações de personagem carregadas anteriormente, abaixo está a função de spawn.

SpawnSelectedCharacter(playerid) {
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
    SpawnPlayer(playerid);
    SetWeapons(playerid);
    pInfo[playerid][pHealthMax] = 150.0;
    pInfo[playerid][pLogged] = true;
    SetPlayerColor(playerid, 0xFFFFFFFF);
    ClearPlayerChat(playerid);
    va_SendClientMessage(playerid, -1, "SERVER: Você está jogando com o personagem %s. ", pNome(playerid));

    format(logString, sizeof(logString), "%s (%s) logou no servidor como %s. ARMAS: ([%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d])", GetPlayerUserEx(playerid), GetPlayerIP(playerid), pNome(playerid), pInfo[playerid][pGuns][0], pInfo[playerid][pAmmo][0], pInfo[playerid][pGuns][1], pInfo[playerid][pAmmo][1], pInfo[playerid][pGuns][2], pInfo[playerid][pAmmo][2], pInfo[playerid][pGuns][3], pInfo[playerid][pAmmo][3], pInfo[playerid][pGuns][4], pInfo[playerid][pAmmo][4], pInfo[playerid][pGuns][5], pInfo[playerid][pAmmo][5], pInfo[playerid][pGuns][6], pInfo[playerid][pAmmo][6], pInfo[playerid][pGuns][7], pInfo[playerid][pAmmo][7], pInfo[playerid][pGuns][8], pInfo[playerid][pAmmo][8], pInfo[playerid][pGuns][9], pInfo[playerid][pAmmo][9],
	pInfo[playerid][pGuns][10], pInfo[playerid][pAmmo][10], pInfo[playerid][pGuns][11], pInfo[playerid][pAmmo][11], pInfo[playerid][pGuns][12], pInfo[playerid][pAmmo][12]);
	logCreate(playerid, logString, 2);
    
    if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0) return true;

    TogglePlayerSpectating(playerid, true);
    InterpolateCameraPos(playerid,  pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]+500, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]+300, 5000);
    InterpolateCameraLookAt(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]+495, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]+295, 5000);
    SetTimerEx("SpawnPlayerPosCamera", 5000, false, "i", playerid, 0);
    
    return true;
}

forward SpawnPlayerPosCamera(playerid);
public SpawnPlayerPosCamera(playerid)
{
    TogglePlayerSpectating(playerid, false);
    SetCameraBehindPlayer(playerid);
    SetWeapons(playerid);
    return true;
}

SaveCharacterInfo(playerid) {
    new Float:pos[4];

    if(!pInfo[playerid][pLogged]) return 1;

    pInfo[playerid][pMoney] = GetPlayerMoney(playerid);
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

    mysql_format(DBConn, query, sizeof query, "UPDATE players SET \
    `name` = '%s', \
    `last_ip` = '%s',\
    `money` = %d, \
    `bank` = %d, \
    `skin` = %d, \
    `health` = %f, \
    `armour` = %f,\
    `score` = %d, \
    `virtual_world` = %d, \
    `interior` = %d, \
    `positionX` = %f, \
    `positionY` = %f, \
    `positionZ` = %f,\
    `positionA` = %f, \
    `phone_number` = %d, \
    `phone_type` = %d, \
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
    WHERE ID = %d;", 
    pInfo[playerid][pName], 
    pInfo[playerid][pLastIP], 
    pInfo[playerid][pMoney], 
    pInfo[playerid][pBank],
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

    pInfo[playerid][pLogged] = false;
    format(logString, sizeof(logString), "%s desconectou-se do servidor. ARMAS: ([%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d] [%d %d])", pNome(playerid), pInfo[playerid][pGuns][0], pInfo[playerid][pAmmo][0], pInfo[playerid][pGuns][1], pInfo[playerid][pAmmo][1], pInfo[playerid][pGuns][2], pInfo[playerid][pAmmo][2], pInfo[playerid][pGuns][3], pInfo[playerid][pAmmo][3], pInfo[playerid][pGuns][4], pInfo[playerid][pAmmo][4], pInfo[playerid][pGuns][5], pInfo[playerid][pAmmo][5], pInfo[playerid][pGuns][6], pInfo[playerid][pAmmo][6], pInfo[playerid][pGuns][7], pInfo[playerid][pAmmo][7], pInfo[playerid][pGuns][8], pInfo[playerid][pAmmo][8], pInfo[playerid][pGuns][9], pInfo[playerid][pAmmo][9], pInfo[playerid][pGuns][10], pInfo[playerid][pAmmo][10], pInfo[playerid][pGuns][11], pInfo[playerid][pAmmo][11], pInfo[playerid][pGuns][12], pInfo[playerid][pAmmo][12]);
	logCreate(playerid, logString, 2);
    printf("[DATABASE] %s desconectado do servidor e salvo na database.", GetPlayerNameEx(playerid));    
    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {
    SaveCharacterInfo(playerid);
    ResetCharacterData(playerid);
    SOS_Clear(playerid);
    Report_Clear(playerid);
    new string[256];
    switch(reason)
	{
	    case 0: format(string,sizeof(string),"(( %s (Problema de Conexão/Crash) ))", pNome(playerid));
	    case 1: format(string,sizeof(string),"(( %s (Desconectou-se) ))", pNome(playerid));
	    case 2: format(string,sizeof(string),"(( %s (Kickado/Banido) ))", pNome(playerid));
	}
	SendNearbyMessage(playerid, 30.0, COLOR_WHITE, string);
    return 1;
}