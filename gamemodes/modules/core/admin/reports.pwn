#include <YSI_Coding\y_hooks>

#define MAX_SOS 100
#define MAX_REPORTS 100

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


// Sistema de SOS
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
                }
                else va_SendClientMessage(i, COLOR_LIGHTRED, "%s", string);
            }
        }
        SendServerMessage(playerid, "Sua dúvida foi enviada para todos os testers e administradores online.");
    } else SendErrorMessage(playerid, "A lista de dúvidas está cheia. Aguarde um momento.");
    return true;
}

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

CMD:listasos(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);

    new count,
        text[128];
    
    for (new i = 0; i!= MAX_SOS; i ++){
        if (sosdata[i][sosExists] && sosdata[i][sosType] == 1){
            strunpack(text, sosdata[i][sosText]);

            new string[255];
            format(string, sizeof(string), "[SOS ID %d] %s (%d): %s (%s)", i, pNome(sosdata[i][sosPlayer]), sosdata[sosPlayer], text, GetDuration(gettime() - sosdata[i][sosGettime]));
            if (strlen(string) > 95){
                va_SendClientMessage(playerid, -1, "%.95s", string);
                va_SendClientMessage(playerid, -1, "...%s", string[95]);
            }
            else{
                va_SendClientMessage(playerid, -1, "%s", string);
            }
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
    if (playerid == sosdata[sosid][sosPlayer]) return SendErrorMessage(playerid, "Você não pode responder a própria dúvida!");

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

    SOS_Remove(sosid);

    return true;
}

CMD:cs(playerid, params[]){
    printf("%d %d", pInfo[playerid][pQuestion], pInfo[playerid][pAnswer]);
    if (pInfo[playerid][pAnswer] < 0 && pInfo[playerid][pQuestion] < 0) return SendErrorMessage(playerid, "Você não está em um atendimento agora!");

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
        }
        else{
            format(pText, sizeof(pText), "(( [Suporte] %s %s: %s ))", AdminRankName(playerid), pInfo[playerid][pUser], params);
            va_SendClientMessage(userid, COLOR_LIGHTYELLOW, pText);
            va_SendClientMessage(playerid, COLOR_LIGHTYELLOW, pText);
        }
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
        }
        else{
            format(pText, sizeof(pText), "(( [Suporte] Jogador %s: %s ))", pNome(playerid), params);
            va_SendClientMessage(userid, COLOR_LIGHTYELLOW, pText);
            va_SendClientMessage(playerid, COLOR_LIGHTYELLOW, pText);
        }
        return true;
    }
    return true;
}

CMD:fs(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
    if (pInfo[playerid][pAnswer] == -1) return SendErrorMessage(playerid, "Você não está em um atendimento agora!");

    new userid = pInfo[playerid][pAnswer];
    SendServerMessage(userid, "%s %s encerrou seu atendimento.", AdminRankName(playerid), pInfo[playerid][pUser]);
    SendAdminAlert(COLOR_LIGHTRED, "AmdCmd: %s encerrou o atendimento de %s.", pInfo[playerid][pUser], pNome(userid));

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

    SOS_Remove(sosid);

    return true;
}


// Sistema de Reports

CMD:rep(playerid, params[]) return cmd_report(playerid, params);

CMD:report(playerid, params[]){
    static reportid = -1;

    if (isnull(params)) return SendSyntaxMessage(playerid, "/report [texto]");

    if (Report_GetCount(playerid) > 0) return SendErrorMessage(playerid, "Você já possui um report pendente.");

    if ((reportid = Report_Add(playerid, params)) != -1){
        new string[255];
        foreach (new i : Player){
            if (GetPlayerAdmin(i) > 0){
                format(string, sizeof(string), "[Report %d]:{FFFFFF} %s (%d): %s [/ar %d | /rr %d]", reportid, pNome(playerid), playerid, params, reportid, reportid);
                if (strlen(string) > 95){
                    va_SendClientMessage(i, COLOR_LIGHTRED, "%.95s", string);
                    va_SendClientMessage(i, -1, "...%s", string[95]);
                }
                else va_SendClientMessage(i, COLOR_LIGHTRED, "%s", string);
            }
        }
        SendServerMessage(playerid, "Seu report foi enviado para todos os administradores online.");
    } else SendErrorMessage(playerid, "A lista de reports está cheia. Aguarde um momento.");
    return true;
}

Report_GetCount(playerid, type = 1){
    new count;

    for (new i = 0; i != MAX_REPORTS; i ++){
        if (reportdata[i][reportExists] && reportdata[i][reportPlayer] == playerid && reportdata[i][reportType] == type){
            count++;
        }
    }return count;
}

Report_Clear(playerid){
    for (new i = 0; i != MAX_REPORTS; i ++){
        if (reportdata[i][reportExists] && reportdata[i][reportPlayer] == playerid){
            Report_Remove(i);
        }
    }return true;
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

CMD:listareports(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);

    new count,
        text[128];
    
    for (new i = 0; i!= MAX_REPORTS; i ++){
        if (reportdata[i][reportExists] && reportdata[i][reportType] == 1){
            strunpack(text, reportdata[i][reportText]);

            new string[255];
            format(string, sizeof(string), "[Report ID %d] %s (%d): %s (%s)", i, pNome(reportdata[i][reportPlayer]), reportdata[reportPlayer], text, GetDuration(gettime() - reportdata[i][reportGettime]));
            if (strlen(string) > 95){
                va_SendClientMessage(playerid, -1, "%.95s", string);
                va_SendClientMessage(playerid, -1, "...%s", string[95]);
            }
            else{
                va_SendClientMessage(playerid, -1, "%s", string);
            }
            count++;
        }
    }

    if (!count) return SendErrorMessage(playerid, "Não há nenhum report pendente.");
    else SendServerMessage(playerid, "Por favor, utilize /ar ID ou /rr ID para aceitar ou recusar um report.");
    return true;
}

CMD:ar(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
    static reportid;
    if (sscanf(params, "d", reportid)) return SendSyntaxMessage(playerid, "/ar [ID do SOS] (/listareports para ver a lista com reports ativos.)");
    if ((reportid < 0 || reportid >= MAX_REPORTS) || !reportdata[reportid][reportExists] || reportdata[reportid][reportType] != 1) return SendErrorMessage(playerid, "ID de report inválido. A lista de reports vai de 0 até %d.", MAX_REPORTS);
    if (playerid == reportdata[reportid][reportPlayer]) return SendErrorMessage(playerid, "Você não pode responder o próprio report!");

    new text[128];
    strunpack(text, reportdata[reportid][reportText]);

    SendServerMessage(reportdata[reportid][reportPlayer], "O %s %s está atendendo seu report.", AdminRankName(playerid), pNome(playerid));

    SendAdminAlert(COLOR_LIGHTRED, "AmdCmd: %s está atendendo o report de %s.", pInfo[playerid][pUser], pNome(reportdata[reportid][reportPlayer]));

    Report_Remove(reportid);

    return true;
}

CMD:rr(playerid, params[]){
    if (GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);

    static reportid;
    new answer[128];

    if (sscanf(params, "ds[128]", reportid, answer)) return SendSyntaxMessage(playerid, "/rr [ID do SOS] [Motivo da recusa]");

    if ((reportid < 0 || reportid >= MAX_REPORTS) || !reportdata[reportid][reportExists] || reportdata[reportid][reportType] != 1) return SendErrorMessage(playerid, "ID de report inválido. A lista de reports vai de 0 até %d.", MAX_REPORTS);

    new text[128];
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

    Report_Remove(reportid);

    return true;
}