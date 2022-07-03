/*

Este módulo é dedicado ao sistema de reports e sos, que será integrado ao MySQL e poderá adicionar tudo dinamicamente.

*/

#include <YSI_Coding\y_hooks>

// DEFINES
#define MAX_SOS         (100)
#define MAX_REPORTS     (100)

// VARIABLES
enum sosData{
    sosExists,
    sosType,
    sosPlayer,
    sosText[128],
    sosGettime
};

enum reportData{
    reportExists,
    reportType,
    reportPlayer,
    reportText[128],
    reportGettime
};

new sosdata[MAX_SOS][sosData];
new reportdata[MAX_REPORTS][reportData];


// SOS SYSTEM -> FUNCTIONS
SOS_GetCount(playerid, type = 1){
    new count;

    for (new i = 0; i != MAX_SOS; i ++){
        if (sosdata[i][sosExists] && sosdata[i][sosPlayer] == playerid && sosdata[i][sosType] == type){
            count++;
        }
    }return count;
}

SOS_Clear(playerid){
    for (new i = 0; i != MAX_SOS; i ++){
        if (sosdata[i][sosExists] && sosdata[i][sosPlayer] == playerid){
            SOS_Remove(i);
        }
    }return true;
}

SOS_Add(playerid, const text[], type = 1){
    for (new i = 0; i != MAX_SOS; i ++){
        if (!sosdata[i][sosExists]){
            sosdata[i][sosExists] = true;
            sosdata[i][sosType] = type;
            sosdata[i][sosPlayer] = playerid;
            sosdata[i][sosGettime] = gettime();

            strpack(sosdata[i][sosText], text, 128);
            return i;
        }
    } return -1;
}

SOS_Remove(sosid){
    if (sosid != -1 && sosdata[sosid][sosExists]){
        sosdata[sosid][sosExists] = false;
        sosdata[sosid][sosPlayer] = INVALID_PLAYER_ID;
        sosdata[sosid][sosGettime] = 0;
    } return true;
}

// SOS SYSTEM -> COMMANDS
CMD:sos(playerid, params[]){
    static sosid = -1;
    if (isnull(params)) return SendSyntaxMessage(playerid, "/sos [texto]");
    if (SOS_GetCount(playerid) > 0) return SendErrorMessage(playerid, "Você já possui uma dúvida pendente.");

    if ((sosid = SOS_Add(playerid, params)) != -1){
        new string[255];
        foreach (new i : Player){
            if (GetPlayerAdmin(i) > 0){
                format(string, sizeof(string), "[SOS %d]:{FFFFFF} %s (%d): %s [/aj %d | /rj %d | /tj %d]", sosid, pNome(playerid), playerid, params, sosid, sosid, sosid);
                if (strlen(string) > 95){
                    va_SendClientMessage(i, COLOR_LIGHTRED, "%.95s", string);
                    va_SendClientMessage(i, -1, "...%s", string[95]);
                } else va_SendClientMessage(i, COLOR_LIGHTRED, "%s", string);
            }
        }
        new str[250], dest[250];
        format(str, sizeof(str), "**[SOS %d]:** %s (%d): %s", sosid, pNome(playerid), playerid, params);
        utf8encode(dest, str);
        DCC_SendChannelMessage(DCC_FindChannelById("989343959933407332"), dest);
        SendServerMessage(playerid, "Sua dúvida foi enviada para todos os testers e administradores online.");
    } else SendErrorMessage(playerid, "A lista de dúvidas está cheia. Aguarde um momento.");
    return true;
}

// SOS SYSTEM -> ADMIN COMMANDS
CMD:listasos(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);

    new count, text[128], string[255];
    for (new i = 0; i!= MAX_SOS; i ++){
        if (sosdata[i][sosExists] && sosdata[i][sosType] == 1){
            strunpack(text, sosdata[i][sosText]);
            format(string, sizeof(string), "[SOS ID %d] %s (%d): %s (%s)", i, pNome(sosdata[i][sosPlayer]), sosdata[sosPlayer], text, GetDuration(gettime() - sosdata[i][sosGettime]));
            if (strlen(string) > 95){
                va_SendClientMessage(playerid, -1, "%.95s", string);
                va_SendClientMessage(playerid, -1, "...%s", string[95]);
            } else va_SendClientMessage(playerid, -1, "%s", string);
            count++;
        }
    }
    if (!count) return SendErrorMessage(playerid, "Não há nenhuma dúvida pendente.");
    else SendServerMessage(playerid, "Por favor, utilize /aj ID, /rj ID, ou /tj ID, para aceitar, recusar ou transferir uma dúvida para sos.");
    return true;
}

CMD:aj(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
    static sosid;
    if (sscanf(params, "d", sosid)) return SendSyntaxMessage(playerid, "/aj [ID do SOS] (/listasos para ver a lista com dúvidas ativas.)");
    if ((sosid < 0 || sosid >= MAX_SOS) || !sosdata[sosid][sosExists] || sosdata[sosid][sosType] != 1) return SendErrorMessage(playerid, "ID de SOS inválido. A lista de dúvidas vai de 0 até %d.", MAX_SOS);
    if (playerid == sosdata[sosid][sosPlayer]) return SendErrorMessage(playerid, "Você não pode responder a própria dúvida.");

    new text[128];
    strunpack(text, sosdata[sosid][sosText]);
    SendServerMessage(sosdata[sosid][sosPlayer], "O %s %s está respondendo sua dúvida.", AdminRankName(playerid), pNome(playerid));
    SendServerMessage(sosdata[sosid][sosPlayer], "Utilize /cs para usar o canal de suporte.");
    SendAdminAlert(COLOR_LIGHTRED, "AmdCmd: %s está respondendo a dúvida de %s.", pInfo[playerid][pUser], pNome(sosdata[sosid][sosPlayer]));

    if(strlen(text) > 64){
        va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_LIGHTRED, "Sua pergunta: {AFAFAF}%.64s", text);
        va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_GREY, "...%s", text[64]);
    } else va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_LIGHTRED, "Sua pergunta: {AFAFAF}%s", text);
    
    pInfo[playerid][pAnswer] = sosdata[sosid][sosPlayer];
    pInfo[sosdata[sosid][sosPlayer]][pQuestion] = playerid;

    format(logString, sizeof(logString), "[SUPORTE] %s (%s) começou a atender %s (%s).", pNome(playerid), GetPlayerUserEx(playerid), pNome(sosdata[sosid][sosPlayer]), text);
	logCreate(playerid, logString, 9);

    new str[1024], dest[1024];
	format(str, sizeof(str), "\n**AdmCmd: %s aceitou o SOS de %s.**\n**Conteúdo do pedido de ajuda:** %s\n", pInfo[playerid][pUser], pNome(sosdata[sosid][sosPlayer]), text);
	utf8encode(dest, str);
	DCC_SendChannelMessage(DCC_FindChannelById("989343959933407332"), dest);

    SOS_Remove(sosid);
    return true;
}

CMD:rj(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);

    static sosid;
    new answer[128];
    if (sscanf(params, "ds[128]", sosid, answer)) return SendSyntaxMessage(playerid, "/rj [ID do SOS] [Motivo da recusa]");
    if ((sosid < 0 || sosid >= MAX_SOS) || !sosdata[sosid][sosExists] || sosdata[sosid][sosType] != 1) return SendErrorMessage(playerid, "ID de SOS inválido. A lista de dúvidas vai de 0 até %d.", MAX_SOS);

    new text[128];
    strunpack(text, sosdata[sosid][sosText]);
    SendServerMessage(sosdata[sosid][sosPlayer], "O %s %s recusou sua dúvida.", AdminRankName(playerid), pNome(playerid));
    SendAdminAlert(COLOR_LIGHTRED, "AmdCmd: %s recusou a dúvida de %s.", pInfo[playerid][pUser], pNome(sosdata[sosid][sosPlayer]));

    if(strlen(text) > 64){
        va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_LIGHTRED, "Sua pergunta: {AFAFAF}%.64s", text);
        va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_GREY, "...%s", text[64]);
    } else va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_LIGHTRED, "Sua pergunta: {AFAFAF}%s", text);

    if(strlen(answer) > 64){
        va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_LIGHTRED, "Motivo: {AFAFAF}%.64s", answer);
        va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_GREY, "...%s", answer[64]);
    } else va_SendClientMessage(sosdata[sosid][sosPlayer], COLOR_LIGHTRED, "Motivo: {AFAFAF}%s", answer);

    new str[1024], dest[1024];
	format(str, sizeof(str), "\n**AdmCmd: %s recusou o SOS de %s.**\n**Conteúdo do pedido de ajuda:** %s\n**Motivo da recusa:** %s", pInfo[playerid][pUser], pNome(sosdata[sosid][sosPlayer]), text, answer);
	utf8encode(dest, str);
	DCC_SendChannelMessage(DCC_FindChannelById("989343959933407332"), dest);

    SOS_Remove(sosid);
    return true;
}

CMD:cs(playerid, params[]){
    if (pInfo[playerid][pAnswer] < 0 && pInfo[playerid][pQuestion] < 0) return SendErrorMessage(playerid, "Você não está em um atendimento agora.");
    if (isnull(params)) return SendSyntaxMessage(playerid, "/cs [Mensagem]");

    if (pInfo[playerid][pAnswer] >= 0){
        new userid = pInfo[playerid][pAnswer];
        new pText[256], pText2[256];
        if(strlen(params) > 64){
            format(pText, sizeof(pText), "(( [Suporte] %s %s: %.64s", AdminRankName(playerid), pInfo[playerid][pUser], params);
            va_SendClientMessage(userid, COLOR_LIGHTYELLOW, pText);
            va_SendClientMessage(playerid, COLOR_LIGHTYELLOW, pText);
            format(pText2, sizeof(pText2), "...%s ))", params[64]);
            va_SendClientMessage(userid, COLOR_LIGHTYELLOW, pText2);
            va_SendClientMessage(playerid, COLOR_LIGHTYELLOW, pText2);
        }else{
            format(pText, sizeof(pText), "(( [Suporte] %s %s: %s ))", AdminRankName(playerid), pInfo[playerid][pUser], params);
            va_SendClientMessage(userid, COLOR_LIGHTYELLOW, pText);
            va_SendClientMessage(playerid, COLOR_LIGHTYELLOW, pText);
        }
        format(logString, sizeof(logString), "[SUPORTE] %s (%s) para %s: %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), params);
	    logCreate(playerid, logString, 9);
        return true;
    }

    if (pInfo[playerid][pQuestion] >= 0){
        new userid = pInfo[playerid][pQuestion];
        new pText[256], pText2[256];
        if(strlen(params) > 64){
            format(pText, sizeof(pText), "(( [Suporte] Jogador %s: %.64s", pNome(playerid), params);
            va_SendClientMessage(userid, COLOR_LIGHTYELLOW, pText);
            va_SendClientMessage(playerid, COLOR_LIGHTYELLOW, pText);
            format(pText2, sizeof(pText2), "...%s ))", params[64]);
            va_SendClientMessage(userid, COLOR_LIGHTYELLOW, pText2);
            va_SendClientMessage(playerid, COLOR_LIGHTYELLOW, pText2);
        }else{
            format(pText, sizeof(pText), "(( [Suporte] Jogador %s: %s ))", pNome(playerid), params);
            va_SendClientMessage(userid, COLOR_LIGHTYELLOW, pText);
            va_SendClientMessage(playerid, COLOR_LIGHTYELLOW, pText);
        }
        format(logString, sizeof(logString), "[SUPORTE] %s (%s) para %s: %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), params);
	    logCreate(playerid, logString, 9);
        return true;
    }
    return true;
}

CMD:fs(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
    if (pInfo[playerid][pAnswer] == -1) return SendErrorMessage(playerid, "Você não está em um atendimento agora.");

    new userid = pInfo[playerid][pAnswer];
    SendServerMessage(userid, "%s %s encerrou seu atendimento.", AdminRankName(playerid), pInfo[playerid][pUser]);
    SendAdminAlert(COLOR_LIGHTRED, "AmdCmd: %s encerrou o atendimento de %s.", pInfo[playerid][pUser], pNome(userid));
    format(logString, sizeof(logString), "%s (%s) encerrou o atendimento de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 9);

    pInfo[playerid][pAnswer] = -1;
    pInfo[userid][pQuestion] = -1;
    return true;
}

CMD:tj(playerid, params[]){
    static sosid, reportid;
    if (sscanf(params, "d", sosid)) return SendSyntaxMessage(playerid, "/tj [ID do SOS] (/listasos para ver a lista com dúvidas ativas.)");
    if ((sosid < 0 || sosid >= MAX_SOS) || !sosdata[sosid][sosExists] || sosdata[sosid][sosType] != 1) return SendErrorMessage(playerid, "ID de SOS inválido. A lista de dúvidas vai de 0 até %d.", MAX_SOS);

    new text[128];
    strunpack(text, sosdata[sosid][sosText]);
    SendAdminAlert(COLOR_LIGHTRED, "AmdCmd: %s converteu a dúvida de %s em um report.", pInfo[playerid][pUser], pNome(sosdata[sosid][sosPlayer]));
    
    if ((reportid = Report_Add(sosdata[sosid][sosPlayer], text)) != -1){
        new string[255];
        foreach (new i : Player){
            if (GetPlayerAdmin(i) > 0){
                format(string, sizeof(string), "[Report %d]:{FFFFFF} %s (%d): %s [/ar %d | /rr %d]", reportid, pNome(sosdata[sosid][sosPlayer]), sosdata[sosid][sosPlayer], text, reportid, reportid);
                if (strlen(string) > 95){
                    va_SendClientMessage(i, COLOR_LIGHTRED, "%.95s", string);
                    va_SendClientMessage(i, -1, "...%s", string[95]);
                }
                else va_SendClientMessage(i, COLOR_LIGHTRED, "%s", string);
            }
        }
        SendServerMessage(sosdata[sosid][sosPlayer], "Sua dúvida foi convertida em um report pelo %s %s.", AdminRankName(playerid), pNome(playerid));
    } else return SendErrorMessage(playerid, "A lista de reports está cheia. Aguarde um momento.");    

    new str[1024], dest[1024];
	format(str, sizeof(str), "\n**AdmCmd: %s converteu o SOS de %s em um report.**\n**Conteúdo do pedido de ajuda:** %s", pInfo[playerid][pUser], pNome(sosdata[sosid][sosPlayer]), text);
	utf8encode(dest, str);
	DCC_SendChannelMessage(DCC_FindChannelById("989343959933407332"), dest);

    SOS_Remove(sosid);
    return true;
}

// REPORT SYSTEM -> FUNCTIONS
Report_GetCount(playerid, type = 1){
    new count;
    for (new i = 0; i != MAX_REPORTS; i ++){
        if (reportdata[i][reportExists] && reportdata[i][reportPlayer] == playerid && reportdata[i][reportType] == type){
            count++;
        }
    } return count;
}

Report_Clear(playerid){
    for (new i = 0; i != MAX_REPORTS; i ++){
        if (reportdata[i][reportExists] && reportdata[i][reportPlayer] == playerid){
            Report_Remove(i);
        }
    } return true;
}

Report_Add(playerid, const text[], type = 1){
    for (new i = 0; i != MAX_REPORTS; i ++){
        if (!reportdata[i][reportExists]){
            reportdata[i][reportExists] = true;
            reportdata[i][reportType] = type;
            reportdata[i][reportPlayer] = playerid;
            reportdata[i][reportGettime] = gettime();
            strpack(reportdata[i][reportText], text, 128);
            return i;
        }
    } return -1;
}

Report_Remove(reportid){
    if (reportid != -1 && reportdata[reportid][reportExists]){
        reportdata[reportid][reportExists] = false;
        reportdata[reportid][reportPlayer] = INVALID_PLAYER_ID;
        reportdata[reportid][reportGettime] = 0;
    } return true;
}

// REPORT SYSTEM -> COMMANDS
CMD:rep(playerid, params[]) return cmd_report(playerid, params);
CMD:report(playerid, params[]){
    if (isnull(params)) return SendSyntaxMessage(playerid, "/report [texto]");
    if (Report_GetCount(playerid) > 0) return SendErrorMessage(playerid, "Você já possui um report pendente.");
    static reportid = -1;
    if ((reportid = Report_Add(playerid, params)) != -1){
        new string[255];
        foreach (new i : Player){
            if (GetPlayerAdmin(i) > 0){
                format(string, sizeof(string), "[Report %d]:{FFFFFF} %s (%d): %s [/ar %d | /rr %d]", reportid, pNome(playerid), playerid, params, reportid, reportid);
                if (strlen(string) > 95){
                    va_SendClientMessage(i, COLOR_LIGHTRED, "%.95s", string);
                    va_SendClientMessage(i, -1, "...%s", string[95]);
                } else va_SendClientMessage(i, COLOR_LIGHTRED, "%s", string);
            }
        }
        new str[250], dest[250];
        format(str, sizeof(str), "**[REPORT %d]:** %s (%d): %s", reportid, pNome(playerid), playerid, params);
        utf8encode(dest, str);
        DCC_SendChannelMessage(DCC_FindChannelById("989343959933407332"), dest);

        SendServerMessage(playerid, "Seu report foi enviado para todos os administradores online.");
    } else SendErrorMessage(playerid, "A lista de reports está cheia. Aguarde um momento.");
    return true;
}

// REPORT SYSTEM -> ADMIN COMMANDS
CMD:listareports(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);

    new count, text[128], string[255];
    
    for (new i = 0; i!= MAX_REPORTS; i ++){
        if (reportdata[i][reportExists] && reportdata[i][reportType] == 1){
            strunpack(text, reportdata[i][reportText]);
            format(string, sizeof(string), "[Report ID %d] %s (%d): %s (%s)", i, pNome(reportdata[i][reportPlayer]), reportdata[reportPlayer], text, GetDuration(gettime() - reportdata[i][reportGettime]));
            if (strlen(string) > 95){
                va_SendClientMessage(playerid, -1, "%.95s", string);
                va_SendClientMessage(playerid, -1, "...%s", string[95]);
            } else va_SendClientMessage(playerid, -1, "%s", string);
            count++;
        }
    }

    if (!count) return SendErrorMessage(playerid, "Não há nenhum report pendente.");
    else SendServerMessage(playerid, "Por favor, utilize /ar ID ou /rr ID para aceitar ou recusar um report.");
    return true;
}

CMD:ar(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
    static reportid;
    if (sscanf(params, "d", reportid)) return SendSyntaxMessage(playerid, "/ar [ID do SOS] (/listareports para ver a lista com reports ativos.)");
    if ((reportid < 0 || reportid >= MAX_REPORTS) || !reportdata[reportid][reportExists] || reportdata[reportid][reportType] != 1) return SendErrorMessage(playerid, "ID de report inválido. A lista de reports vai de 0 até %d.", MAX_REPORTS);
    if (playerid == reportdata[reportid][reportPlayer]) return SendErrorMessage(playerid, "Você não pode responder o próprio report.");

    new text[128];
    strunpack(text, reportdata[reportid][reportText]);
    SendServerMessage(reportdata[reportid][reportPlayer], "O %s %s está atendendo seu report.", AdminRankName(playerid), pNome(playerid));
    SendAdminAlert(COLOR_LIGHTRED, "AmdCmd: %s está atendendo o report de %s.", pInfo[playerid][pUser], pNome(reportdata[reportid][reportPlayer]));
    new str[1024], dest[1024];
	format(str, sizeof(str), "\n**AdmCmd: %s aceitou o report de %s.**\n**Conteúdo do pedido de ajuda:** %s", pInfo[playerid][pUser], pNome(reportdata[reportid][reportPlayer]), text);
	utf8encode(dest, str);
	DCC_SendChannelMessage(DCC_FindChannelById("989343959933407332"), dest);
    Report_Remove(reportid);
    return true;
}

CMD:rr(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);

    static reportid;
    new answer[128], text[128];
    if (sscanf(params, "ds[128]", reportid, answer)) return SendSyntaxMessage(playerid, "/rr [ID do SOS] [Motivo da recusa]");
    if ((reportid < 0 || reportid >= MAX_REPORTS) || !reportdata[reportid][reportExists] || reportdata[reportid][reportType] != 1) return SendErrorMessage(playerid, "ID de report inválido. A lista de reports vai de 0 até %d.", MAX_REPORTS);
    strunpack(text, reportdata[reportid][reportText]);
    SendServerMessage(reportdata[reportid][reportPlayer], "O %s %s recusou seu report.", AdminRankName(playerid), pNome(playerid));
    SendAdminAlert(COLOR_LIGHTRED, "AmdCmd: %s recusou o report de %s.", pInfo[playerid][pUser], pNome(reportdata[reportid][reportPlayer]));
    if(strlen(text) > 64){
        va_SendClientMessage(reportdata[reportid][reportPlayer], COLOR_LIGHTRED, "Seu report: {AFAFAF}%.64s", text);
        va_SendClientMessage(reportdata[reportid][reportPlayer], COLOR_GREY, "...%s", text[64]);
    } else va_SendClientMessage(reportdata[reportid][reportPlayer], COLOR_LIGHTRED, "Seu report: {AFAFAF}%s", text);
    if(strlen(answer) > 64){
        va_SendClientMessage(reportdata[reportid][reportPlayer], COLOR_LIGHTRED, "Motivo: {AFAFAF}%.64s", answer);
        va_SendClientMessage(reportdata[reportid][reportPlayer], COLOR_GREY, "...%s", answer[64]);
    } else va_SendClientMessage(reportdata[reportid][reportPlayer], COLOR_LIGHTRED, "Motivo: {AFAFAF}%s", answer);
    new str[1024], dest[1024];
	format(str, sizeof(str), "\n**AdmCmd: %s recusou o report de %s.**\n**Conteúdo do pedido de ajuda:** %s\n**Motivo da recusa:** %s", pInfo[playerid][pUser], pNome(reportdata[reportid][reportPlayer]), text, answer);
	utf8encode(dest, str);
	DCC_SendChannelMessage(DCC_FindChannelById("989343959933407332"), dest);
    Report_Remove(reportid);
    return true;
}