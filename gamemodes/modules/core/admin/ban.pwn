/*

Este m�dulo � dedicado ao sistema de banimentos, os comandos est�o no topo e a estrutura��o de m�todos, etc., embora poucos, est�o no final.
O salvamento de tempo � feito por timestamp (segundos desde 1970), e formatado pelo m�dulo utils_time.pwn
Se um jogador tiver o `unbanned_time` como 0, o sistema considerar� que o banimento foi permanente.

*/

#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {

    CheckUserBan(playerid);

    return 1;
}

CMD:ban(playerid, params[]) {
    new id, reason[128]; 

    // Checar condi��es anormais

    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
    if(sscanf(params, "us[128]", id, reason)) return SendSyntaxMessage(playerid, "/ban [player] [motivo]");
    if(uInfo[playerid][uAdmin] < uInfo[playerid][uAdmin]) return SendErrorMessage(playerid, "Voc� n�o pode banir este jogador!");
    if(!IsPlayerConnected(id)) return SendNotConnectedMessage(playerid);

    // Inserir o banimento na database

    mysql_format(DBConn, query, sizeof query, "INSERT INTO ban (`banned_name`, `admin_name`, `reason`, \
        `ban_date`, `unban_date`) VALUES ('%s', '%s', '%s', %d, 0)", uInfo[id][uName], uInfo[playerid][uName], reason, _:Now());
    mysql_query(DBConn, query);

    // Printar
    
    va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s baniu %s (%s) permanentemente. Motivo: %s.", uInfo[playerid][uName], 
    GetPlayerNameEx(id), uInfo[id][uName], reason);
    va_SendClientMessage(playerid, COLOR_GREEN, "Voc� baniu o usu�rio %s com sucesso.", uInfo[id][uName]);
    SendServerMessage(playerid, "(( Voc� foi banido do servidor ))");

    format(logString, sizeof(logString), "%s (%s) baniu %s (%s) por %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(id), GetPlayerUserEx(id), reason);
	logCreate(playerid, logString, 1);

    Kick(id);
    return 1;
}

CMD:banoff(playerid, params[]) {
    new userName[24], reason[128], adminID;

    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
    if(sscanf(params, "s[24]s[128]", userName, reason)) return SendSyntaxMessage(playerid, "/banoff [usu�rio] [motivo]");
    
    // Checar se o usu�rio j� est� online em algum dos personagens ou selecionando eles.

    foreach(new i : Player) {
        if(!strcmp(uInfo[i][uName], userName)) { 
            va_SendClientMessage(playerid, COLOR_LIGHTRED, "Este usu�rio j� est� conectado no servidor. (Nick: %s, ID: %d)", GetPlayerNameEx(i), i);
            return SendSyntaxMessage(playerid, "/ban [player] [motivo]");
        }
    }

    // Checar se o usu�rio existe, n�vel de admin, etc.

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", userName);
    mysql_query(DBConn, query);

    if(!cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel encontrar um usu�rio com este nome no banco de dados.");
    
    cache_get_value_name_int(0, "admin", adminID);
    if(uInfo[playerid][uAdmin] < adminID) return SendErrorMessage(playerid, "Voc� n�o pode banir este jogador!");

    // Checar se o usu�rio j� est� banido.

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM ban WHERE `banned_name` = '%s' AND \
        `banned` = 1;", userName, _:Now());
    mysql_query(DBConn, query);

    if(cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel banir este jogador porque ele j� est� cumprindo um banimento.");

    // Banir, enfim.

    mysql_format(DBConn, query, sizeof query, "INSERT INTO ban (`banned_name`, `admin_name`, `reason`, \
        `ban_date`, `unban_date`) VALUES ('%s', '%s', '%s', %d, 0)", userName, uInfo[playerid][uName], reason, _:Now());
    mysql_query(DBConn, query);

    va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s baniu %s de modo offline e permanentemente. Motivo: %s.", uInfo[playerid][uName], userName, reason);
    va_SendClientMessage(playerid, COLOR_GREEN, "Voc� baniu (offline) o usu�rio %s com sucesso.", userName);

    format(logString, sizeof(logString), "%s (%s) baniu %s off-line por %s.", pNome(playerid), GetPlayerUserEx(playerid), userName, reason);
	logCreate(playerid, logString, 1);

    return 1;
}

CMD:bantemp(playerid, params[]) {
    new id, days, reason[128]; 

    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
    if(sscanf(params, "uds[128]", id, days, reason)) return SendSyntaxMessage(playerid, "/ban [player] [motivo]");
    if(uInfo[playerid][uAdmin] < uInfo[playerid][uAdmin]) return SendErrorMessage(playerid, "Voc� n�o pode banir este jogador!");
    if(!IsPlayerConnected(id)) return SendNotConnectedMessage(playerid);
    if(!days) return SendErrorMessage(playerid, "Um jogador s� pode ser banido temporariamente por, no m�nimo, 1 dia.");

    mysql_format(DBConn, query, sizeof query, "INSERT INTO ban (`banned_name`, `admin_name`, `reason`, \
        `ban_date`, `unban_date`) VALUES ('%s', '%s', '%s', %d, %d)", 
        uInfo[id][uName], uInfo[playerid][uName], reason, _:Now(), _:Now() + (86400 * days));
    mysql_query(DBConn, query);
    
    va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s baniu %s (%s) por %d dias. Motivo: %s.", uInfo[playerid][uName], GetPlayerNameEx(id), uInfo[id][uName], days, reason);
    va_SendClientMessage(playerid, COLOR_GREEN, "Voc� baniu o usu�rio %s com sucesso.", uInfo[id][uName]);
    SendServerMessage(playerid, "(( Voc� foi banido do servidor ))");
    
    format(logString, sizeof(logString), "%s (%s) baniu %s (%s) [%d dias] por %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(id), GetPlayerUserEx(id), days, reason);
	logCreate(playerid, logString, 1);

    Kick(id);

    return 1;
}

CMD:bantempoff(playerid, params[]) {
    new userName[24], reason[128], days, adminID;

    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
    if(sscanf(params, "s[24]ds[128]", userName, days, reason)) return SendSyntaxMessage(playerid, "/bantempoff [usu�rio] [dias] [motivo]");
    if(!days) return SendErrorMessage(playerid, "Um jogador s� pode ser banido temporariamente por, no m�nimo, 1 dia.");

    // Checar se o usu�rio j� est� online em algum dos personagens ou selecionando eles.

    foreach(new i : Player) {
        if(!strcmp(uInfo[i][uName], userName)) { 
            va_SendClientMessage(playerid, COLOR_LIGHTRED, "Este usu�rio j� est� conectado no servidor. (Nick: %s, ID: %d)", GetPlayerNameEx(i), i);
            return SendSyntaxMessage(playerid, "/bantemp [player] [dias] [motivo]");
        }
    }

    // Checar se o usu�rio existe, n�vel de admin, etc.

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", userName);
    mysql_query(DBConn, query);

    if(!cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel encontrar um usu�rio com este nome no banco de dados.");
    
    cache_get_value_name_int(0, "admin", adminID);
    if(uInfo[playerid][uAdmin] < adminID) return SendErrorMessage(playerid, "Voc� n�o pode banir este jogador!");

    // Checar se o usu�rio j� est� banido.

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM ban WHERE `banned_name` = '%s' AND \
        `banned` = 1;", userName, _:Now());
    mysql_query(DBConn, query);

    if(cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel banir este jogador porque ele j� est� cumprindo um banimento.");

    // Banir, enfim.

    mysql_format(DBConn, query, sizeof query, "INSERT INTO ban (`banned_name`, `admin_name`, `reason`, \
        `ban_date`, `unban_date`) VALUES ('%s', '%s', '%s', %d, %d)", 
        userName, uInfo[playerid][uName], reason, _:Now(), _:Now() + (86400 * days));
    mysql_query(DBConn, query);

    va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s baniu %s de modo offline por %d dias. Motivo: %s.", uInfo[playerid][uName], userName, days, reason);
    va_SendClientMessage(playerid, COLOR_GREEN, "Voc� baniu (offline) o usu�rio %s com sucesso.", userName);

    format(logString, sizeof(logString), "%s (%s) baniu %s [%d dias] por %s.", pNome(playerid), GetPlayerUserEx(playerid), userName, days, reason);
	logCreate(playerid, logString, 1);

    return 1;
}

CMD:desban(playerid, params[]) {
    new userName[24];

    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
    if(sscanf(params, "s[24]", userName)) return SendSyntaxMessage(playerid, "/desban [usuario]");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM ban WHERE `banned_name` = '%s' AND `banned` = 1;", userName);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) return SendErrorMessage(playerid, "N�o foi poss�vel encontrar nenhum usu�rio banido com este nome.");

    mysql_format(DBConn, query, sizeof query, "UPDATE ban SET `banned` = 0, `unban_date` = '%d', `admin_unban` = '%s' WHERE `banned_name` = '%s' AND `banned` = 1", _:Now(), uInfo[playerid][uName], userName);
    mysql_query(DBConn, query);

    va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s desbaniu %s.", uInfo[playerid][uName], userName);
    va_SendClientMessage(playerid, COLOR_GREEN, "Voc� desbaniu o usu�rio %s com sucesso.", userName);

    format(logString, sizeof(logString), "%s (%s) desbaniu %s.", pNome(playerid), GetPlayerUserEx(playerid), userName);
	logCreate(playerid, logString, 1);

    return 1;
}

CMD:checarbans(playerid, params[]) return cmd_checarban(playerid, params);

CMD:checarban(playerid, params[]) {
    new userName[24];

    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
    if(sscanf(params, "s[24]", userName)) return SendSyntaxMessage(playerid, "/checarban [usuario]");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM ban WHERE `banned_name` = '%s';", userName);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) return SendErrorMessage(playerid, "O usu�rio especificado n�o tem nenhum banimento registrado.");

    // Pegar informa��es dos banimentos em vari�veis e usar de um loop pra informar tudo

    new adminName[24], reason[128], ban_date, unban_date, unban_admin[24], banned;

    va_SendClientMessage(playerid, COLOR_GREEN, "Banimentos de %s:", userName);
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name(i, "admin_name", adminName);
        cache_get_value_name(i, "reason", reason);
        cache_get_value_name_int(i, "ban_date", ban_date);
        cache_get_value_name_int(i, "unban_date", unban_date);
        cache_get_value_name(i, "admin_unban", unban_admin);
        cache_get_value_name_int(i, "banned", banned);

        va_SendClientMessage(playerid, banned > 0 ? (COLOR_LIGHTRED) : (COLOR_GREY), " Banido por %s | Motivo: %s | Data do banimento: %s | \
            Data do desbanimento: %s | %s", adminName, reason, GetFullDate(ban_date), 
            unban_date > 0 ? (GetFullDate(unban_date)) : ("Permanente"), banned > 0 ? ("**Cumprindo**") : ("Desbanido por %s", unban_admin));
    }
    return 1;
}

CMD:limparhistoricoban(playerid, params[]) return cmd_limparhistoricobans(playerid, params);

CMD:limparhistoricobans(playerid, params[]) {
    new userName[24];

    if(uInfo[playerid][uAdmin] < 5) return SendPermissionMessage(playerid);
    if(sscanf(params, "s[24]", userName)) return SendSyntaxMessage(playerid, "/limparhistoricobans [usuario]");

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM ban WHERE `banned_name` = '%s';", userName);
    mysql_query(DBConn, query);
    if(!cache_num_rows()) return SendErrorMessage(playerid, "O usu�rio especificado n�o tem nenhum banimento registrado.");

    va_SendClientMessage(playerid, COLOR_GREEN, "Voc� apagou %d banimentos do usu�rio %s.", cache_num_rows(), userName);

    mysql_format(DBConn, query, sizeof query, "DELETE FROM ban WHERE `banned_name` = '%s';", userName);
    mysql_query(DBConn, query);  

    format(logString, sizeof(logString), "%s (%s) apagou %d banimentos do usu�rio %s.", pNome(playerid), GetPlayerUserEx(playerid), cache_num_rows(), userName);
	logCreate(playerid, logString, 1);  
    return 1;
}

// Checar se o usu�rio est� banido.

CheckUserBan(playerid) {
    new adminName[24], reason[128], ban_date, unban_date,
        bigString[512];

    UpdateUnbannedUsers();

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM ban WHERE `banned_name` = '%s' AND `banned` = 1;", uInfo[playerid][uName]);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 1;

    
    // Armazenar informa��es do banimento em vari�veis

    cache_get_value_name(0, "admin_name", adminName);
    cache_get_value_name(0, "reason", reason);
    cache_get_value_name_int(0, "ban_date", ban_date);
    cache_get_value_name_int(0, "unban_date", unban_date);

    // Formatar a string com as informa��es anteriores

    format(bigString, sizeof bigString, "Voc� foi banido %sdo servidor.\n \nUsu�rio: %s\nData de banimento: %s\nData de desbanimento: %s\n \
        Motivo: %s\n \nSe voc� acha que isso foi um engano, recorra a um apelo no f�rum.", 
        unban_date > 0 ? ("temporariamente ") : (""), uInfo[playerid][uName], GetFullDate(ban_date), 
        unban_date > 0 ? (GetFullDate(unban_date)) : ("Banimento permanente"), reason);

    ShowPlayerDialog(playerid, DIALOG_BAN, DIALOG_STYLE_MSGBOX, "Usu�rio Banido", bigString, "Entendi", "");

    Kick(playerid);
    return 1;
}

// Quando chamada, ir� setar 'banned' como false no MySQL para todas rows que tiverem o 'unban_date' menor do que o tempo atual.
// Essa condi��o n�o ir� passar se o unban_date for 0, ou seja, permanente.

void:UpdateUnbannedUsers() {
    mysql_format(DBConn, query, sizeof query, "UPDATE ban SET `banned` = 0 WHERE `banned` = 1 AND `unban_date` <> 0 AND `unban_date` <= %d;", 
        _:Now());
    mysql_query(DBConn, query);
}