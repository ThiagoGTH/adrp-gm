/*

O Gamemode do Advanced Roleplay trabalha com usu�rios. Isso significa que se voc� tentar registrar diretamente um personagem, n�o vai funcionar.
Isso tudo porque essa intera��o e hierarquia entre usu�rio-personagem permite que um s� usu�rio contenha diversos outros personagens.

Esse m�dulo � dedicado a coisas relacionadas ao sistema de gerenciamento de usu�rios. Se, por acaso, o seu interesse for consultar o acesso de
personagens, talvez seja interessante voc� dar uma olhada no m�dulo 'character.pwn' que lida com isso esse tipo de informa��es.

*/

#include <YSI_Coding\y_hooks>

#define BCRYPT_COST 12

forward OnPasswordHashed(playerid);
forward OnPasswordChecked(playerid);

enum User_Data {
    uID,
    uName[24],
    uPass[16],
    uAdmin,
    uVip,
    uFactionMod,
	uPropertyMod,
};

new uInfo[MAX_PLAYERS][User_Data];

new loginAttempts[MAX_PLAYERS];

// Evento/gatilho de conex�o estabelecida pelo jogador

hook OnPlayerConnect(playerid) {
    
    ClearPlayerChat(playerid, 50);

    format(uInfo[playerid][uName], 24, "%s", GetPlayerNameEx(playerid));
    CheckCharactersName(playerid);

    TogglePlayerSpectating(playerid, true);
    CheckUserConditions(playerid);

    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

    // Intera��o com o dialog de registro

    if(dialogid == DIALOG_REGISTER) {  
        if(!response)
            return Kick(playerid);
        
        if(strlen(inputtext) < 6 || strlen(inputtext) > 16) {
            SendErrorMessage(playerid, "ERRO: A senha a ser registrada deve ter entre 6 e 16 caracteres.");
            CheckUserConditions(playerid);
            return 0;
        }
        bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordHashed", "d", playerid);
    }

    // Intera��o com o dialog de login

    if(dialogid == DIALOG_LOGIN) {
        if(!response)
            return Kick(playerid);
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s'", uInfo[playerid][uName]);
        mysql_query(DBConn, query);
        cache_get_value_name(0, "password", uInfo[playerid][uPass], 128);
        /*new hash[256];
        format(hash, sizeof(hash), "%s", uInfo[playerid][uPass]);*/
        bcrypt_check(inputtext, uInfo[playerid][uPass], "OnPasswordChecked", "d", playerid);
    }
    return 1;
}

public OnPasswordHashed(playerid)
{
	new hash[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(hash);

    CreateUser(playerid, uInfo[playerid][uName], hash);
    CheckUserConditions(playerid);
	return 1;
}

public OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();
    if(match){
		ClearPlayerChat(playerid);
        SendServerMessage(playerid, "Voc� est� autenticado!");
        LoadUserInfo(playerid);
        ShowUsersCharacters(playerid);
	}
	else return NotifyWrongAttempt(playerid);
	return 1;

}

// Simplesmente a fun��o de notificar a senha incorreta digitada pelo jogador, numa tentativa m�xima de tr�s vezes.

NotifyWrongAttempt(playerid) {
    loginAttempts[playerid]++;

    va_SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Senha incorreta, tente novamente. [%d/3]", loginAttempts[playerid]);

    if(loginAttempts[playerid] >= 3) {
        SendServerMessage(playerid, "Voc� foi kickado por errar a senha muitas vezes.");
        Kick(playerid);
        return 0;
    }

    CheckUserConditions(playerid);
    return 1;
}

// Fun��o booleana pra checar se o usu�rio j� est� registrado

bool:IsUserRegistered(userName[]) {
    new bool: resultState;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", userName);
    mysql_query(DBConn, query);

    if(cache_num_rows())
        resultState = true;

    return resultState;
}


// Gerar o usu�rio e inserir na database sob as condi��es de checagem da fun��o booleana acima.

void:CreateUser(playerid, userName[], password[]) {

    if(IsUserRegistered(userName))
        return;

    mysql_format(DBConn, query, sizeof query, "INSERT INTO users (`username`, `password`) VALUES ('%s', '%s');", userName, password);
    mysql_query(DBConn, query);

    uInfo[playerid][uID] = cache_insert_id();
}


// Nada demais, s� vai avaliar se o usu�rio est� registrado (ou n�o) e mostrar as devidas dialogs

void:CheckUserConditions(playerid) {

    if(IsUserRegistered(uInfo[playerid][uName]))
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo!\n \nO usu�rio j� est� registrado.\
            \nDigite a senha registrada para se conectar", "Conectar", "Sair");
    else
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registro", "Bem vindo!\n \nO usu�rio ainda n�o foi registrado.\
            \nPara continuar, digite uma senha de 6 a 16 caracteres abaixo", "Registrar", "Sair");

}

// Caregar informa��es do usu�rio e adicion�-las �s vari�veis do enumerador. A vari�vel de nome j� � formatada ao logar.

LoadUserInfo(playerid) {

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s'", uInfo[playerid][uName]);
    mysql_query(DBConn, query);

    if(!cache_num_rows()) 
        return 0;

    cache_get_value_name_int(0, "ID", uInfo[playerid][uID]);
    cache_get_value_name(0, "password", uInfo[playerid][uPass]);
    cache_get_value_name_int(0, "admin", uInfo[playerid][uAdmin]);
    cache_get_value_name_int(0, "vip", uInfo[playerid][uVip]);
    cache_get_value_name_int(0, "ft", uInfo[playerid][uFactionMod]);
    cache_get_value_name_int(0, "pt", uInfo[playerid][uPropertyMod]);
    return 1;
}

// Dar um UPDATE no MySQL com as novas informa��es do usu�rio.

SaveUserInfo(playerid) {

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `ID` = %d", uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE users SET `admin` = %d, \
    `vip` = %d,            \
    `ft`  = %d,            \
    `pt`  = %d WHERE `ID` = %d", 
        uInfo[playerid][uAdmin], 
        uInfo[playerid][uVip], 
        uInfo[playerid][uFactionMod],
        uInfo[playerid][uPropertyMod],
        uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    printf("Usu�rio '%s' salvo com sucesso.", uInfo[playerid][uName]);
    return 1;
}

// Fun��o pra formatar e mostrar os personagens do usu�rio numa Dialog

ShowUsersCharacters(playerid) {
    new characterName[24], string[128], majorString[2056],
        characterScore, lastLogin;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user` = '%s'", uInfo[playerid][uName]);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return ShowPlayerDialog(playerid, DIALOG_CHARACTER_SELECT, DIALOG_STYLE_TABLIST_HEADERS, "Personagens",
            "Nome\tN�vel\t�ltimo login\nCriar personagem", "Confirmar", "Sair");

    majorString[0] = EOS;
    strcat(majorString, "Nome\tN�vel\t�ltimo login\n");
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name(i, "name", characterName);
        cache_get_value_name_int(i, "score", characterScore);
        cache_get_value_name_int(i, "last_login", lastLogin);
        
        format(string, sizeof(string), "%s\t%d\t%s\n", characterName, characterScore, GetFullDate(lastLogin));
        strcat(majorString, string);
    }
    strcat(majorString, "\n \nCriar personagem\n{FF5447}Deletar personagem");

    return ShowPlayerDialog(playerid, DIALOG_CHARACTER_SELECT, DIALOG_STYLE_TABLIST_HEADERS, "Personagens", majorString, "Confirmar", "Sair");
}

// Simplesmente resetar as vari�veis de usu�rio, j� que elas est�o armazenadas por ID e chamar o salvamento.

hook OnPlayerDisconnect(playerid, reason) {
    
    SaveUserInfo(playerid);

    loginAttempts[playerid]               = 
    uInfo        [playerid][uAdmin]       = 
    uInfo        [playerid][uID]          = 
    uInfo        [playerid][uVip]         = 
    uInfo        [playerid][uFactionMod]  = 
    uInfo        [playerid][uPropertyMod] = 0;

    uInfo[playerid][uName][0] = EOS;

    return 1;
}
 
// Aqui, iremos checar se o player logou com o nick de um personagem j� existente e, se sim, redirecionar para o nome do usu�rio.

CheckCharactersName(playerid) {
    new realUserName[24];

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s'", GetPlayerNameEx(playerid));
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 1;

    cache_get_value_name(0, "user", realUserName);

    ClearPlayerChat(playerid);
    SendServerMessage(playerid, "Detectamos que o seu nome de usu�rio � o nome de um personagem existente.");
    SendServerMessage(playerid, "Por precau��o e seguran�a, n�o podemos deixar que voc� se autentique assim.");
    va_SendClientMessage(playerid, -1, "SERVER: Mas n�o se preocupe. Estamos redirecionando a sua conex�o ao usu�rio %s.", realUserName);
        
    format(uInfo[playerid][uName], 24, "%s", realUserName);
    SetPlayerName(playerid, realUserName);

    va_SendClientMessage(playerid, COLOR_GREEN, "Redirecionado como '%s' com sucesso.", uInfo[playerid][uName]);
    return 1;
}

// Comando de checar usu�rio e personagens de um jogador. Aberto pra todos.

CMD:usuario(playerid, params[]) {
    if(uInfo[playerid][uAdmin] < 1) return SendPermissionMessage(playerid);
    new characterName[24], userValue[24];

    if(sscanf(params, "s[24]", characterName)) return SendSyntaxMessage(playerid, "/usuario [personagem]");

    // Consultar a tabela players com o nome digitado e informar se o nome n�o existe ou, se sim, o seu usu�rio.

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s';", characterName);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel encontrar um personagem com o nome digitado.");

    cache_get_value_name(0, "user", userValue);
    va_SendClientMessage(playerid, COLOR_GREEN, "O usu�rio de %s �: %s.", characterName, userValue);

    return 1;
}

CMD:personagens(playerid, params[]) {
    if(uInfo[playerid][uAdmin] < 1) return SendPermissionMessage(playerid);
    new userName[24], characterValue[24], lastLogin;

    if(sscanf(params, "s[24]", userName)) return SendSyntaxMessage(playerid, "/personagens [usuario]");

    // Checar se existe um usu�rio no servidor com o nome digitado

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", userName);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel encontrar um usu�rio com o nome digitado.");

    // Pegar os personagens que pertencem �quele usu�rio

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user` = '%s';", userName);
    mysql_query(DBConn, query);

    va_SendClientMessage(playerid, COLOR_GREY, "Personagens de %s:", userName);
    if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_GREY, " Este usu�rio n�o tem nenhum personagem ainda.");

    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name(i, "name", characterValue);
        cache_get_value_name_int(i, "last_login", lastLogin);

        va_SendClientMessage(playerid, GetPlayerByName(characterValue) == -1 ? (COLOR_GREY) : COLOR_GREEN,
            " %s (%s) %s", characterValue, GetFullDate(lastLogin, 1), 
            GetPlayerByName(characterValue) == -1 ? ("") : ("**ONLINE**"));
    }

    return 1;
}