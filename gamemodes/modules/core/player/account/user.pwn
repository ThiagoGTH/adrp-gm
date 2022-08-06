/*

O Gamemode do Advanced Roleplay trabalha com usuários. Isso significa que se você tentar registrar diretamente um personagem, não vai funcionar.
Isso tudo porque essa interação e hierarquia entre usuário-personagem permite que um só usuário contenha diversos outros personagens.

Esse módulo é dedicado a coisas relacionadas ao sistema de gerenciamento de usuários. Se, por acaso, o seu interesse for consultar o acesso de
personagens, talvez seja interessante você dar uma olhada no módulo 'character.pwn' que lida com isso esse tipo de informações.

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
    SQLID = pInfo[playerid][pID];
    return SQLID;
}

GetUserSQLID(playerid){
    new SQLID;
    SQLID = uInfo[playerid][uID];
    return SQLID;
}

// Evento/gatilho de conexão estabelecida pelo jogador
hook OnPlayerConnect(playerid) {
    TogglePlayerControllable(playerid, false);
    for (new i = 0; i < 70; i ++) {
		SendClientMessage(playerid, -1, "");
	}
    
    return true;
}
hook OnPlayerRequestClass(playerid, classid) {
    TogglePlayerSpectating(playerid, true);
    TogglePlayerControllable(playerid, false);

    ShowLoginTextdraws(playerid);
    ClearPlayerChat(playerid);

    format(uInfo[playerid][uName], 24, "%s", GetPlayerNameEx(playerid));
    CheckCharactersName(playerid);
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
        SendServerMessage(playerid, "Você está autenticado!");
        LoadUserInfo(playerid); 
        CheckUserBan(playerid);
        pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 500, false, "dd", playerid, 2);
	}
	else return pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 500, false, "dd", playerid, 1);
	return true;

}

// Simplesmente a função de notificar a senha incorreta digitada pelo jogador, numa tentativa máxima de três vezes.

NotifyWrongAttempt(playerid) {
    loginAttempts[playerid]++;
    KillTimer(pInfo[playerid][pInterfaceTimer]);
    va_SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Senha incorreta, tente novamente. [%d/3]", loginAttempts[playerid]);
    
    if(loginAttempts[playerid] >= 3) {
        SendServerMessage(playerid, "Você foi kickado por errar a senha muitas vezes.");
        Kick(playerid);
        return false;
    }

    CheckUserConditions(playerid);
    return true;
}

// Função booleana pra checar se o usuário já está registrado

bool:IsUserRegistered(userName[]) {
    new bool: resultState;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", userName);
    mysql_query(DBConn, query);

    if(cache_num_rows())
        resultState = true;

    return resultState;
}


// Gerar o usuário e inserir na database sob as condições de checagem da função booleana acima.

void:CreateUser(playerid, userName[], password[]) {

    if(IsUserRegistered(userName))
        return;

    mysql_format(DBConn, query, sizeof query, "INSERT INTO users (`username`, `password`) VALUES ('%s', '%s');", userName, password);
    mysql_query(DBConn, query);

    uInfo[playerid][uID] = cache_insert_id();

    mysql_format(DBConn, query, sizeof query, "INSERT INTO users_teams (`user_id`) VALUES ('%d');", uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO users_premium (`user_id`) VALUES ('%d');", uInfo[playerid][uID]);
    mysql_query(DBConn, query);
}


// Nada demais, só vai avaliar se o usuário está registrado (ou não) e mostrar as devidas dialogs

void:CheckUserConditions(playerid) {
    KillTimer(pInfo[playerid][pInterfaceTimer]);
    ShowLoginTextdraws(playerid);
    if(IsUserRegistered(uInfo[playerid][uName])){
        ShowLoginTextdraws(playerid);
        //ClearPlayerChat(playerid);
        Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, " ", "SERVER: Você só pode errar sua senha três (3) vezes.\nINFO: Nosso UCP é o www.advanced-roleplay.com.br\nacesse-o para mais informações\nsobre sua conta\n\
        \n           Digite sua senha:", "Autenticar", "Cancelar");
    } else {
        ShowLoginTextdraws(playerid);
        Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registro", "Bem vindo!\n \nO usuário ainda não foi registrado.\
            \nPara continuar, digite uma senha de 6 a 16 caracteres abaixo", "Registrar", "Sair");
    }
}

// Caregar informações do usuário e adicioná-las às variáveis do enumerador. A variável de nome já é formatada ao logar.

LoadUserInfo(playerid) {

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s'", uInfo[playerid][uName]);
    mysql_query(DBConn, query);

    if(!cache_num_rows()) 
        return false;

    cache_get_value_name_int(0, "ID", uInfo[playerid][uID]);
    cache_get_value_name(0, "password", uInfo[playerid][uPass]);
    cache_get_value_name_int(0, "admin", uInfo[playerid][uAdmin]);
    
    cache_get_value_name_int(0, "redflag", uInfo[playerid][uRedFlag]);
    cache_get_value_name_int(0, "newbie", uInfo[playerid][uNewbie]);
    cache_get_value_name_int(0, "SOSAns", uInfo[playerid][uSOSAns]);
    cache_get_value_name_int(0, "dutytime", uInfo[playerid][uDutyTime]);
    cache_get_value_name_int(0, "jailtime", uInfo[playerid][uJailed]);

    LoadUserPremium(playerid);
    LoadUserTeams(playerid);
    return true;
}

LoadUserPremium(playerid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users_premium WHERE `user_id` = '%d'", uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    if(!cache_num_rows()) 
        return false;

    cache_get_value_name_int(0, "points", uInfo[playerid][uPoints]);
    cache_get_value_name_int(0, "name_changes", uInfo[playerid][uNameChanges]); 
    cache_get_value_name_int(0, "number_changes", uInfo[playerid][uNumberChanges]); 
    cache_get_value_name_int(0, "fight_changes", uInfo[playerid][uFightChanges]); 
    cache_get_value_name_int(0, "plate_changes", uInfo[playerid][uPlateChanges]); 
    cache_get_value_name_int(0, "chars_slots", uInfo[playerid][uCharSlots]);
    return true;
}

LoadUserTeams(playerid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users_teams WHERE `user_id` = '%d'", uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    if(!cache_num_rows()) 
        return false;

    cache_get_value_name_int(0, "head_faction_team", uInfo[playerid][uHeadFTeam]);
    cache_get_value_name_int(0, "head_property_team", uInfo[playerid][uHeadPTeam]);
    cache_get_value_name_int(0, "head_event_team", uInfo[playerid][uHeadETeam]);
    cache_get_value_name_int(0, "head_ck_team", uInfo[playerid][uHeadCTeam]);
    cache_get_value_name_int(0, "faction_team", uInfo[playerid][uFactionTeam]);
    cache_get_value_name_int(0, "property_team", uInfo[playerid][uPropertyTeam]);
    cache_get_value_name_int(0, "event_team", uInfo[playerid][uEventTeam]);
    cache_get_value_name_int(0, "ck_team", uInfo[playerid][uCKTeam]);
    cache_get_value_name_int(0, "log_team", uInfo[playerid][uLogTeam]);
    return true;
}

// Dar um UPDATE no MySQL com as novas informações do usuário.

SaveUserInfo(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE users SET \
    `admin`     =   %d,           \
    `redflag`   =   %d,           \
    `jailtime`  =   %d,           \
    `dutytime`  =   %d,           \
    `SOSAns`    =   %d,           \
    `newbie`    =   %d             \
    WHERE `ID`  =   %d", 
        uInfo[playerid][uAdmin], 
        uInfo[playerid][uRedFlag],
        uInfo[playerid][uJailed],
        uInfo[playerid][uDutyTime],
        uInfo[playerid][uSOSAns],
        uInfo[playerid][uNewbie],
        uInfo[playerid][uID]);
    mysql_query(DBConn, query);
    SaveUserPremium(playerid);
    SaveUserTeams(playerid);
    printf("Usuário '%s' salvo com sucesso.", uInfo[playerid][uName]);
    return true;
}

SaveUserPremium(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE users_premium SET \
    `points`            =   %d,           \
    `name_changes`      =   %d,           \
    `number_changes`    =   %d,           \
    `fight_changes`     =   %d,           \
    `plate_changes`     =   %d,           \
    `chars_slots`       =   %d            \
    WHERE `ID`          =   %d", 
        uInfo[playerid][uPoints], 
        uInfo[playerid][uNameChanges],
        uInfo[playerid][uNumberChanges],
        uInfo[playerid][uFightChanges],
        uInfo[playerid][uPlateChanges],
        uInfo[playerid][uCharSlots],
        uInfo[playerid][uID]);
    mysql_query(DBConn, query);
    return true;
}

SaveUserTeams(playerid) {
    mysql_format(DBConn, query, sizeof query, "UPDATE users_teams SET \
    `head_faction_team`     =   %d,           \
    `head_property_team`    =   %d,           \
    `head_event_team`       =   %d,           \
    `head_ck_team`          =   %d,           \
    `faction_team`          =   %d,           \
    `property_team`         =   %d,           \
    `event_team`            =   %d,           \
    `ck_team`               =   %d,           \
    `log_team`              =   %d            \
    WHERE `ID`              =   %d", 
        uInfo[playerid][uHeadFTeam], 
        uInfo[playerid][uHeadPTeam],
        uInfo[playerid][uHeadETeam],
        uInfo[playerid][uHeadCTeam],
        uInfo[playerid][uFactionTeam],
        uInfo[playerid][uPropertyTeam],
        uInfo[playerid][uEventTeam],
        uInfo[playerid][uCKTeam],
        uInfo[playerid][uLogTeam],
        uInfo[playerid][uID]);
    mysql_query(DBConn, query);
    return true;
}

// Função pra formatar e mostrar os personagens do usuário numa Dialog
ShowUsersCharacters(playerid) {
    HideLoginTextdraws(playerid);
    SetPlayerInterface(playerid, 999);
    new characterName[24], string[128], majorString[2056],
        characterScore, lastLogin;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d'", uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return Dialog_Show(playerid, CHARACTER_SELECT, DIALOG_STYLE_TABLIST_HEADERS, "Personagens", "Nome\tNível\tÚltimo login\nCriar personagem", "Confirmar", "Sair");

    majorString[0] = EOS;
    strcat(majorString, "Nome\tNível\tÚltimo login\n");
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

// Simplesmente resetar as variáveis de usuário, já que elas estão armazenadas por ID e chamar o salvamento.
hook OnPlayerDisconnect(playerid, reason) {
    SaveUserInfo(playerid);
    ResetUserData(playerid);
    return true;
}

// Aqui, iremos checar se o player logou com o nick de um personagem já existente e, se sim, redirecionar para o nome do usuário.
CheckCharactersName(playerid) {
    new realUserName[24], userID;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s'", GetPlayerNameEx(playerid));
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return true;

    cache_get_value_name_int(0, "user_id", userID);
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `ID` = '%d'",  userID);
    mysql_query(DBConn, query);
    cache_get_value_name(0, "username", realUserName);

    ClearPlayerChat(playerid);
    SendServerMessage(playerid, "Detectamos que o seu nome de usuário é o nome de um personagem existente.");
    SendServerMessage(playerid, "Por precaução e segurança, não podemos deixar que você se autentique assim.");
    va_SendClientMessage(playerid, -1, "SERVER: Mas não se preocupe. Estamos redirecionando a sua conexão ao usuário %s.", realUserName);
        
    format(uInfo[playerid][uName], 24, "%s", realUserName);
    SetPlayerName(playerid, realUserName);

    va_SendClientMessage(playerid, COLOR_GREEN, "Redirecionado como '%s' com sucesso.", uInfo[playerid][uName]);
    return true;
}

// Comando de checar usuário e personagens de um jogador. Aberto pra todos.
CMD:usuario(playerid, params[]) {
    if(uInfo[playerid][uAdmin] < 1) return SendPermissionMessage(playerid);
    new characterName[24], userValue[24], userID;

    if(sscanf(params, "s[24]", characterName)) return SendSyntaxMessage(playerid, "/usuario [personagem]");

    // Consultar a tabela players com o nome digitado e informar se o nome não existe ou, se sim, o seu usuário.
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s';", characterName);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) return SendErrorMessage(playerid, "Não foi possível encontrar um personagem com o nome digitado.");
    cache_get_value_name_int(0, "user_id", userID);
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `ID` = '%d';", userID);
    mysql_query(DBConn, query);
    cache_get_value_name(0, "username", userValue);

    va_SendClientMessage(playerid, COLOR_GREEN, "O usuário de %s é: %s.", characterName, userValue);

    return true;
}

CMD:personagens(playerid, params[]) {
    if(uInfo[playerid][uAdmin] < 1) return SendPermissionMessage(playerid);
    new userName[24], characterValue[24], lastLogin, user_id;

    if(sscanf(params, "s[24]", userName)) return SendSyntaxMessage(playerid, "/personagens [usuario]");

    // Checar se existe um usuário no servidor com o nome digitado
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", userName);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) return SendErrorMessage(playerid, "Não foi possível encontrar um usuário com o nome digitado.");

    cache_get_value_name_int(0, "ID", user_id);
    // Pegar os personagens que pertencem àquele usuário
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d';", user_id);
    mysql_query(DBConn, query);

    va_SendClientMessage(playerid, COLOR_GREY, "Personagens de %s:", userName);
    if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_GREY, " Este usuário não tem nenhum personagem ainda.");

    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name(i, "name", characterValue);
        cache_get_value_name_int(i, "last_login", lastLogin);

        va_SendClientMessage(playerid, GetPlayerByName(characterValue) == -1 ? (COLOR_GREY) : COLOR_GREEN,
            " %s (%s) %s", characterValue, GetFullDate(lastLogin, 1), 
            GetPlayerByName(characterValue) == -1 ? ("") : ("**ONLINE**"));
    }

    return true;
}