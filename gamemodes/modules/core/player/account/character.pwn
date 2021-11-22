/*

Como o modulo user.pwn trabalha com users, esse vai ser um tipo de extens�o pra gerenciar de personagens (carregar, criar, etc.), ou...
... a mesma metodologia de trabalho do user.pwn, mas agora estamos lidando diretamente com os personagens especificos daquele usu�rio.

*/

#include <YSI_Coding\y_hooks>

#define USER_CHARACTERS_LIMIT 1
#define USER_CHARACTERS_LIMIT_VIP 3

enum Player_Data {
    pID,
    pName[24],
    pUser[24],
    pFirstIP[15],
    pLastIP[15],
    pAdmin,

    pAge,
    pGender[15],
    pBackground[50],

    Float:pHealth,
    Float:pArmour,

    pMoney,
    pBank,

    pSkin,
    pScore,

    Float:pPositionX,
    Float:pPositionY,
    Float:pPositionZ,
    Float:pPositionA,
    pVirtualWorld,
    pInterior,

    pEditandoBareira,
    pLicence,

	pFaction,
	pFactionID,
	pFactionRank,
	pFactionEdit,
	pSelectedSlot,
	pOnDuty,
	pFactionOffer,
	pFactionOffered,
	pDisableFaction,
    pMaterial,

    pGuns[13],
	pAmmo[13],

    pTazer,
    pBeanBag,
    pStunned,
    pCuffed,
    pDragged,
	pDraggedBy,
	pDragTimer,

    CurrentDealer,
	CurrentItem[10],
	CurrentAmmo[10],
	CurrentCost[10],

    pGraffiti,
	pGraffitiTime,
	pGraffitiColor,
	pGraffitiText[64 char],
	pEditGraffiti,
    
    pCarSeller,
	pCarOffered,
	pCarValue,

    pFreeze,
	pFreezeTimer,

    pHouse,
	pEntrance,

    pLoopAnim,
    // Temp variables
    bool:pLogged,
    characterDelete[24]
};

new pInfo[MAX_PLAYERS][Player_Data];
new AdminTrabalhando[MAX_PLAYERS];
new const g_aWeaponSlots[] = {
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11
};

// Pode ficar um pouco confuso de agora em diante. Visto que n�o tem uma maneira t�o eficiente de inserir multiplas informa��es em um s�
// dialog, a inser��o aconter� por quatro diferente deles. Voc� pode indentifica-los a come�arem com 'DIALOG_CHARACTER_CREATE'

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

    if(dialogid == DIALOG_CHARACTER_SELECT) {
        
        if(!response || !strcmp(inputtext, " "))
            return ShowUsersCharacters(playerid);

        else if(!strcmp(inputtext, "Criar personagem")) {
            mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user` = '%s';", uInfo[playerid][uName]);
            mysql_query(DBConn, query);

            if(cache_num_rows() >= USER_CHARACTERS_LIMIT && !uInfo[playerid][uVip]) {
                SendErrorMessage(playerid, "Voc� atingiu o limite de personagens. Adquira VIP e consiga mais slots.");
                return ShowUsersCharacters(playerid);
            } else if(cache_num_rows() >= USER_CHARACTERS_LIMIT_VIP) {
                SendErrorMessage(playerid, "Voc� atingiu o limite de personagens! Compre mais com um administrador, se desejar.");
                return ShowUsersCharacters(playerid);
            } else ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
                "Para come�ar a registrar um personagem, voc� dever� colocar o nome dele(a) abaixo.\nDigite com o padr�o: 'Nome_Sobrenome'", 
                "Continuar", "Voltar");

        } else if(!strcmp(inputtext, "Deletar personagem")) {

            if(!uInfo[playerid][uVip]) {
                SendErrorMessage(playerid, "Somente unsu�rios VIP podem deletar personagens.");
                return ShowUsersCharacters(playerid);
            }
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem \
                    que voc� gostaria de deletar.", "Continuar", "Voltar");

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

    // Enfim, os dialogs de cri��o de personagem. Pode ficar um pouco extenso.

    if(dialogid == DIALOG_CHARACTER_CREATE_NAME) {
        
        if(!response)
            return ShowUsersCharacters(playerid), pInfo[playerid][pName][0] = EOS;

        if(strlen(inputtext) < 1) {
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
                "Para come�ar a registrar um personagem, voc� dever� colocar o nome dele(a) abaixo.\n \nDigite com o padr�o: Nome_Sobrenome",
                "Continuar", "Voltar");
        }

        // Checking if that specified name already exists either as a character's name or as an username
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players a, users b WHERE a.name = '%s'\
        OR b.username = '%s';", inputtext, inputtext);
        mysql_query(DBConn, query);

        if(cache_num_rows()) {
            SendClientMessage(playerid, VERMELHO, "J� existe outro usu�rio ou um personagem com este nome.");
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
                "Para come�ar a registrar um personagem, voc� dever� colocar o nome dele(a) abaixo.\n \nDigite com o padr�o: Nome_Sobrenome",
                "Continuar", "Voltar");
        }
        
        format(pInfo[playerid][pName], 24, "%s", inputtext);
        va_SendClientMessage(playerid, -1, "O seu novo personagem ser� chamado de %s", pInfo[playerid][pName]);

        ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_AGE, DIALOG_STYLE_INPUT, "Criar Personagem - Idade", 
            "Agora, prossiga com a idade do seu personagem.\n \nA idade deve ser entre 13 e 99", "Continuar", "Voltar");

    }

    if(dialogid == DIALOG_CHARACTER_CREATE_AGE) {

        if(!response) {
            pInfo[playerid][pAge] = 0;
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_NAME, DIALOG_STYLE_INPUT, "Criar Personagem - Nome", 
                "Para come�ar a registrar um personagem, voc� dever� colocar o nome dele(a) abaixo.\n \nDigite com o padr�o: Nome_Sobrenome",
                "Continuar", "Voltar");    
        }

        if(strval(inputtext) < 13 || strval(inputtext) > 99) {
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_AGE, DIALOG_STYLE_INPUT, "Criar Personagem - Idade", 
            "Agora, prossiga com a idade do seu personagem.\n \nA idade deve ser entre 13 e 99", "Continuar", "Voltar");
        }
        
        pInfo[playerid][pAge] = strval(inputtext);
        va_SendClientMessage(playerid, -1, "Seu personagem ter� %d anos", pInfo[playerid][pAge]);

        ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_GENDER, DIALOG_STYLE_LIST, "Criar Personagem - G�nero", 
            "Masculino\nFeminino", "Continuar", "Voltar");

    }

    if(dialogid == DIALOG_CHARACTER_CREATE_GENDER) {
        
        if(!response) {
            pInfo[playerid][pGender][0] = EOS;
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_AGE, DIALOG_STYLE_INPUT, "Criar Personagem - Idade", 
                "Agora, prossiga com a idade do seu personagem.\n \nA idade deve ser entre 13 e 99", "Continuar", "Voltar");
        }

        format(pInfo[playerid][pGender], 15, "%s", inputtext);
        va_SendClientMessage(playerid, -1, "Seu personagem � do sexo '%s'", pInfo[playerid][pGender]);
        
        ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_BG, DIALOG_STYLE_INPUT, "Criar Personagem - ORIGEM",
            "Insira o local de origem do personagem (at� 50 caracteres)", "Continuar", "Voltar");
    }

    if(dialogid == DIALOG_CHARACTER_CREATE_BG) {
        if(!response) {
            pInfo[playerid][pBackground][0] = EOS;
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_GENDER, DIALOG_STYLE_LIST, "Criar Personagem - G�nero", 
            "Masculino\nFeminino", "Continuar", "Voltar");
        }

        if(strlen(inputtext) < 1 || strlen(inputtext) > 50) {
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_CREATE_BG, DIALOG_STYLE_INPUT, "Criar Personagem - ORIGEM",
            "Insira o local de origem do personagem (at� 50 caracteres)", "Continuar", "Voltar");
        }

        format(pInfo[playerid][pBackground], 50, "%s", inputtext);
        va_SendClientMessage(playerid, -1, "A origem do seu personagem � de %s", pInfo[playerid][pBackground]);

        CreateCharacter(playerid, pInfo[playerid][pName], pInfo[playerid][pAge], pInfo[playerid][pGender], pInfo[playerid][pBackground]);

        SendClientMessage(playerid, -1, " ");
        SendServerMessage(playerid, "O personagem foi criado com sucesso e voc� j� pode v�-lo na lista de personagens.");

        ShowUsersCharacters(playerid);
    }

    // Deletar personagens (Fun��o VIP)

    if(dialogid == DIALOG_CHARACTER_DELETE) {
        new string[256];

        if(!response)
            return ShowUsersCharacters(playerid);

        if(!strlen(inputtext) || strlen(inputtext) > 24) {
            SendErrorMessage(playerid, "Voc� deve digitar o nome v�lido de um personagem.");
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem \
                    que voc� gostaria de deletar.", "Continuar", "Voltar");
        }

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s' AND `user` = '%s';",
            inputtext, uInfo[playerid][uName]);
        mysql_query(DBConn, query);
        if(!cache_num_rows()) {
            SendErrorMessage(playerid, "Esse personagem n�o existe ou n�o � desse usu�rio.");
            return ShowPlayerDialog(playerid, DIALOG_CHARACTER_DELETE, DIALOG_STYLE_INPUT, "Deletar Personagem", "Digite o nome do personagem \
                    que voc� gostaria de deletar.", "Continuar", "Voltar");
        }

        format(pInfo[playerid][characterDelete], 24, "%s", inputtext);
        format(string, 256, "Voc� realmente deseja deletar o personagem %s?\n \nEssa a��o � irrevers�vel.", pInfo[playerid][characterDelete]);
        ShowPlayerDialog(playerid, DIALOG_CHARACTER_DELETE_CONFIRM, DIALOG_STYLE_MSGBOX, "Deletar Personagem - Confirmar", string, "Deletar", "Cancelar");
    }

    if(dialogid == DIALOG_CHARACTER_DELETE_CONFIRM) {
        
        if(!response)
            return ShowUsersCharacters(playerid), pInfo[playerid][characterDelete][0] = EOS;

        mysql_format(DBConn, query, sizeof query, "DELETE FROM players WHERE `name` = '%s' AND `user` = '%s';",
            pInfo[playerid][characterDelete], uInfo[playerid][uName]);
        mysql_query(DBConn, query);

        va_SendClientMessage(playerid, -1, "SERVER: Voc� deletou o personagem %s com sucesso. A a��o � irrevers�vel.", pInfo[playerid][characterDelete]);
        pInfo[playerid][characterDelete][0] = EOS;
        ShowUsersCharacters(playerid);

    }

    return 1;
}


// Nada muito especial. Vamos inserir o personagem criado com as informa��es dos inputtexts das dialogs anteriores e, at�, reseta-las.

CreateCharacter(playerid, characterName[], characterAge, characterGender[], characterBackground[]) {

    mysql_format(DBConn, query, sizeof query,
        "INSERT INTO players (`name`, `user`, `age`, `gender`, `background`, `first_ip`) VALUES ('%s', '%s', %d, '%s', '%s', '%s');",
            characterName, GetPlayerNameEx(playerid), characterAge, characterGender, characterBackground, PlayerIP(playerid));
    mysql_query(DBConn, query);

    pInfo[playerid][pName][0] = pInfo[playerid][pGender][0] = pInfo[playerid][pBackground][0] = EOS;
    pInfo[playerid][pAge] = 0;

    printf("[DATABASE] %s (User: %s) foi inserido na database.", characterName, GetPlayerNameEx(playerid));

}

// J� que as fun��es anteriores estavam relacionadas a cria��o de um personagem, agora as pr�ximas fun��es seer�o destinadas a carregar, salvar,
// sair, logar, etc. com o personagem.

LoadCharacterInfo(playerid, playerName[]) {
    new first_login;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s'", playerName);
    mysql_query(DBConn, query);

    cache_get_value_name_int(0, "ID", pInfo[playerid][pID]);

    cache_get_value_name(0, "user", pInfo[playerid][pUser]);
    cache_get_value_name(0, "name", pInfo[playerid][pName]);
    format(pInfo[playerid][pLastIP], 20, "%s", PlayerIP(playerid));

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

    cache_get_value_name_int(0, "material", pInfo[playerid][pMaterial]);
    cache_get_value_name_int(0, "faction", pInfo[playerid][pFaction]);
    cache_get_value_name_int(0, "faction_rank", pInfo[playerid][pFactionRank]);

    cache_get_value_name_int(0, "house", pInfo[playerid][pHouse]);
	cache_get_value_name_int(0, "entrance", pInfo[playerid][pEntrance]);

    cache_get_value_name_int(0, "first_login", first_login);

    if(!first_login) {
        mysql_format(DBConn, query, sizeof query, "UPDATE players SET `first_login` = %d WHERE `name` = '%s';", _:Now(), pInfo[playerid][pName]);
        mysql_query(DBConn, query);
    }

    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `last_login` = %d WHERE `name` = '%s';", _:Now(), pInfo[playerid][pName]);
    mysql_query(DBConn, query);

    printf("[DATABASE] %s foi carregado com sucesso do banco de dados.", playerName);
    
    LoadLicencesData(playerid);

}

// Em complemento as informa��es de personagem carregadas anteriormente, abaixo est� a fun��o de spawn.

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

    SetSpawnInfo(playerid, NO_TEAM, pInfo[playerid][pSkin], 
        pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ], pInfo[playerid][pPositionA],
        0, 0, 0, 0, 0, 0);

    SetPlayerSkin(playerid, GetPlayerSkin(playerid) > 0 ? (pInfo[playerid][pSkin]) : (23));
    SpawnPlayer(playerid);

    pInfo[playerid][pLogged] = true;
    SetPlayerColor(playerid, 0xFFFFFFFF);

    ClearPlayerChat(playerid);
    new string[128];
    format(string, sizeof string, "`CONNECT:` [%s] **%s** *(%s)* efetuou o login no personagem **%s**.", ReturnDate(), pInfo[playerid][pUser], PlayerIP(playerid), pInfo[playerid][pName]);
    DCC_SendChannelMessage(DC_EntrouSaiu, string);

    va_SendClientMessage(playerid, -1, "SERVER: Voc� est� jogando com o personagem %s.", pNome(playerid));
    return 1;
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
    `last_login` = %d, \
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
    `material` = %d, \
    `faction` = %d, \
    `faction_rank` = %d, \
    `house` = %d, \
    `entrance` = %d WHERE ID = %d;", 
    pInfo[playerid][pName], 
    pInfo[playerid][pLastIP], 
    pInfo[playerid][pAdmin], 
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

    pInfo[playerid][pMaterial],
    pInfo[playerid][pFaction],
    pInfo[playerid][pFactionRank],

    pInfo[playerid][pHouse],
	pInfo[playerid][pEntrance],

    pInfo[playerid][pID]);
    mysql_query(DBConn, query);

    pInfo[playerid][pLogged] = false;
    printf("[DATABASE] %s desconectado do servidor e salvo na database.", GetPlayerNameEx(playerid));

    return 1;
}

void:ResetCharacterData(playerid) {
    pInfo[playerid][pID] = 0;
    pInfo[playerid][pName][0] =
    pInfo[playerid][pUser][0] =
    pInfo[playerid][pFirstIP][0] =
    pInfo[playerid][pLastIP][0] = 
    pInfo[playerid][pGender][0] =
    pInfo[playerid][pBackground][0] = EOS;

    pInfo[playerid][pHealth] = 0;
    pInfo[playerid][pArmour] = 0;
    pInfo[playerid][pMoney] = 0;
    pInfo[playerid][pBank] = 0;
    pInfo[playerid][pSkin] = 0;
    pInfo[playerid][pScore] = 0;
    pInfo[playerid][pPositionX] = 0;
    pInfo[playerid][pPositionY] = 0;
    pInfo[playerid][pPositionZ] = 0;
    pInfo[playerid][pPositionA] = 0;
    pInfo[playerid][pVirtualWorld] = 0; 
    pInfo[playerid][pInterior] = 0; 
    pInfo[playerid][pEditandoBareira] = 0;
    pInfo[playerid][pLicence] = 0;

    pInfo[playerid][pFaction] = 0;
	pInfo[playerid][pFactionID] = 0;
	pInfo[playerid][pFactionRank] = 0;
	pInfo[playerid][pFactionEdit] = 0;
	pInfo[playerid][pSelectedSlot] = 0;
	pInfo[playerid][pOnDuty] = 0;
	pInfo[playerid][pFactionOffer] = 0;
	pInfo[playerid][pFactionOffered] = 0;
	pInfo[playerid][pDisableFaction] = 0;
    pInfo[playerid][pMaterial] = 0;

    pInfo[playerid][CurrentDealer] = 0;
	pInfo[playerid][CurrentItem] = 0;
	pInfo[playerid][CurrentAmmo] = 0;
	pInfo[playerid][CurrentCost] = 0;

    pInfo[playerid][pTazer] = 0;
    pInfo[playerid][pBeanBag] = 0;
    pInfo[playerid][pStunned] = 0;
    pInfo[playerid][pCuffed] = 0;
    pInfo[playerid][pDragged] = 0;
	pInfo[playerid][pDraggedBy] = 0;
	pInfo[playerid][pDragTimer] = 0;

    pInfo[playerid][pGraffiti] = -1;
	pInfo[playerid][pGraffitiTime] = 0;
	pInfo[playerid][pGraffitiColor] = 0;
	pInfo[playerid][pGraffitiText] = 0;
	pInfo[playerid][pEditGraffiti] = 0;
    
    pInfo[playerid][pCarSeller] = INVALID_PLAYER_ID;
	pInfo[playerid][pCarOffered] = -1;
	pInfo[playerid][pCarValue] = 0;

    pInfo[playerid][pHouse] = -1;
	pInfo[playerid][pEntrance] = -1;

    pInfo[playerid][pFreeze] = 0;
    AdminTrabalhando[playerid] = 0;
    pInfo[playerid][pLoopAnim] = 0;

    foreach (new i : Player) if (pInfo[i][pDraggedBy] == playerid) {
	    StopDragging(i);
	}
	if (pInfo[playerid][pDragged]) {
	    StopDragging(playerid);
	}
	for (new i = 0; i < 12; i ++) {
		pInfo[playerid][pGuns][i] = 0;
		pInfo[playerid][pAmmo][i] = 0;
	}

}

hook OnPlayerDisconnect(playerid, reason) {
    SaveCharacterInfo(playerid);
    ResetCharacterData(playerid);
    return 1;
}