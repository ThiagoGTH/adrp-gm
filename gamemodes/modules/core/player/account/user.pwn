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

GetPlayerUserEx(playerid){
    new name[24];
    GetPlayerName(playerid, name, sizeof(name));
    format(name,sizeof(name),"%s", uInfo[playerid][uName]);
    return name;
}

GetPlayerSQLID(playerid){
    new SQLID;
    SQLID = uInfo[playerid][uID];
    return SQLID;
}

// Evento/gatilho de conex�o estabelecida pelo jogador

hook OnPlayerRequestClass(playerid, classid) {
    ShowLoginTextdraws(playerid);
    ClearPlayerChat(playerid);

    format(uInfo[playerid][uName], 24, "%s", GetPlayerNameEx(playerid));
    CheckCharactersName(playerid);

    TogglePlayerSpectating(playerid, true);
    CheckUserConditions(playerid);

    return true;
}

Dialog:DIALOG_REGISTER(playerid, response, listitem, inputtext[]) {
	if(!response) return Kick(playerid);
        
    if(strlen(inputtext) < 6 || strlen(inputtext) > 16) {
        SendErrorMessage(playerid, "ERRO: A senha a ser registrada deve ter entre 6 e 16 caracteres.");
        CheckUserConditions(playerid);
        return false;
    }

    bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordHashed", "d", playerid);
	return true;
}

Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[]) {
	if(!response) return Kick(playerid);

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s'", uInfo[playerid][uName]);
    mysql_query(DBConn, query);
    cache_get_value_name(0, "password", uInfo[playerid][uPass], 128);
    bcrypt_check(inputtext, uInfo[playerid][uPass], "OnPasswordChecked", "d", playerid);
	return true;
}

public OnPasswordHashed(playerid) {
	new hash[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(hash);

    CreateUser(playerid, uInfo[playerid][uName], hash);
    CheckUserConditions(playerid);
	return true;
}

public OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();
    if(match){
		ClearPlayerChat(playerid);
        SendServerMessage(playerid, "Voc� est� autenticado!");
        LoadUserInfo(playerid); 
        pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 1000, false, "dd", playerid, 2);
        ShowUsersCharacters(playerid);
	}
	else return NotifyWrongAttempt(playerid);
	return true;

}

// Simplesmente a fun��o de notificar a senha incorreta digitada pelo jogador, numa tentativa m�xima de tr�s vezes.

NotifyWrongAttempt(playerid) {
    loginAttempts[playerid]++;
    KillTimer(pInfo[playerid][pInterfaceTimer]);
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Senha incorreta, tente novamente. [%d/3]", loginAttempts[playerid]);
    pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 1000, false, "dd", playerid, 1);

    if(loginAttempts[playerid] >= 3) {
        SendServerMessage(playerid, "Voc� foi kickado por errar a senha muitas vezes.");
        Kick(playerid);
        return false;
    }

    CheckUserConditions(playerid);
    return true;
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
    KillTimer(pInfo[playerid][pInterfaceTimer]);
    ShowLoginTextdraws(playerid);
    if(IsUserRegistered(uInfo[playerid][uName])){
        ShowLoginTextdraws(playerid);
        //ClearPlayerChat(playerid);
        Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, " ", "SERVER: Voc� s� pode errar sua senha tr�s (3) vezes.\nINFO: Nosso UCP � o www.advanced-roleplay.com.br\nacesse-o para mais informa��es\nsobre sua conta\n\
        \n           Digite sua senha:", "Autenticar", "Cancelar");
    } else {
        ShowLoginTextdraws(playerid);
        Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registro", "Bem vindo!\n \nO usu�rio ainda n�o foi registrado.\
            \nPara continuar, digite uma senha de 6 a 16 caracteres abaixo", "Registrar", "Sair");
    }
}

// Caregar informa��es do usu�rio e adicion�-las �s vari�veis do enumerador. A vari�vel de nome j� � formatada ao logar.

LoadUserInfo(playerid) {

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s'", uInfo[playerid][uName]);
    mysql_query(DBConn, query);

    if(!cache_num_rows()) 
        return false;

    cache_get_value_name_int(0, "ID", uInfo[playerid][uID]);
    cache_get_value_name(0, "password", uInfo[playerid][uPass]);
    cache_get_value_name_int(0, "admin", uInfo[playerid][uAdmin]);
    cache_get_value_name_int(0, "charslots", uInfo[playerid][uCharSlots]);
    cache_get_value_name_int(0, "redflag", uInfo[playerid][uRedFlag]);
    cache_get_value_name_int(0, "newbie", uInfo[playerid][uNewbie]);
    cache_get_value_name_int(0, "SOSAns", uInfo[playerid][uSOSAns]);
    cache_get_value_name_int(0, "dutytime", uInfo[playerid][uDutyTime]);
    cache_get_value_name_int(0, "jailtime", uInfo[playerid][uJailed]);
    cache_get_value_name_int(0, "premiumpoints", uInfo[playerid][uPoints]);
    return true;
}

// Dar um UPDATE no MySQL com as novas informa��es do usu�rio.

SaveUserInfo(playerid) {

    /*mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `ID` = %d", uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return false;*/

    mysql_format(DBConn, query, sizeof query, "UPDATE users SET `admin` = %d, \
    `redflag`  = %d,            \
    `jailtime`  = %d,           \
    `premiumpoints` = %d WHERE `ID` = %d", 
        uInfo[playerid][uAdmin], 
        uInfo[playerid][uRedFlag],
        uInfo[playerid][uJailed],
        uInfo[playerid][uPoints],
        uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    printf("Usu�rio '%s' salvo com sucesso.", uInfo[playerid][uName]);
    return true;
}

// Fun��o pra formatar e mostrar os personagens do usu�rio numa Dialog

ShowUsersCharacters(playerid) {
    HideLoginTextdraws(playerid);
    SetPlayerInterface(playerid, 999);
    new characterName[24], string[128], majorString[2056],
        characterScore, lastLogin;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user` = '%s'", uInfo[playerid][uName]);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return Dialog_Show(playerid, CHARACTER_SELECT, DIALOG_STYLE_TABLIST_HEADERS, "Personagens", "Nome\tN�vel\t�ltimo login\nCriar personagem", "Confirmar", "Sair");

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

    return Dialog_Show(playerid, CHARACTER_SELECT, DIALOG_STYLE_TABLIST_HEADERS, "Personagens", majorString, "Confirmar", "Sair");
}

// Simplesmente resetar as vari�veis de usu�rio, j� que elas est�o armazenadas por ID e chamar o salvamento.
hook OnPlayerDisconnect(playerid, reason) {
    SaveUserInfo(playerid);
    ResetUserData(playerid);
    return true;
}

// Aqui, iremos checar se o player logou com o nick de um personagem j� existente e, se sim, redirecionar para o nome do usu�rio.
CheckCharactersName(playerid) {
    new realUserName[24];

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s'", GetPlayerNameEx(playerid));
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return true;

    cache_get_value_name(0, "user", realUserName);

    ClearPlayerChat(playerid);
    SendServerMessage(playerid, "Detectamos que o seu nome de usu�rio � o nome de um personagem existente.");
    SendServerMessage(playerid, "Por precau��o e seguran�a, n�o podemos deixar que voc� se autentique assim.");
    va_SendClientMessage(playerid, -1, "SERVER: Mas n�o se preocupe. Estamos redirecionando a sua conex�o ao usu�rio %s.", realUserName);
        
    format(uInfo[playerid][uName], 24, "%s", realUserName);
    SetPlayerName(playerid, realUserName);

    va_SendClientMessage(playerid, COLOR_GREEN, "Redirecionado como '%s' com sucesso.", uInfo[playerid][uName]);
    return true;
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

    return true;
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

    return true;
}