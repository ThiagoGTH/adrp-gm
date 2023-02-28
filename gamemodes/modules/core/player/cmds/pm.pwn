#include <YSI_Coding\y_hooks>

static
    BitArray:PlayerPMDisabled<MAX_PLAYERS>,
    PlayerLastPM[MAX_PLAYERS];

hook OnPlayerConnect(playerid) {
    Bit_Set(PlayerPMDisabled, playerid, false);
    return true;
}

CMD:blockpm(playerid, params[]) {
    if (!Bit_Get(PlayerPMDisabled, playerid)) {
        SendServerMessage(playerid, "Você bloqueou suas mensagens privadas.");
        Bit_Let(PlayerPMDisabled, playerid);
    } else {
        SendServerMessage(playerid, "Você desbloqueou suas mensagens privadas.");
        Bit_Vet (PlayerPMDisabled, playerid);
    }
    return true;
}

hook OnPlayerDisconnect(playerid, reason) {
    new target = PlayerLastPM[PlayerLastPM[playerid]];
    if(IsPlayerConnected(target))
    target = -1;
    return true;
}

CMD:pm(playerid, params[]) {
    new
        targetid, text[128];

    if (sscanf(params, "us[128]", targetid, text)) return SendSyntaxMessage(playerid, "/pm [playerid/nome] [mensagem]");
	if (!IsPlayerConnected(targetid)) return SendNotConnectedMessage(playerid);
    if (targetid == playerid) return SendErrorMessage(playerid, "Você não pode enviar uma mensagem privada para si próprio.");
    if (Bit_Get(PlayerPMDisabled, targetid)) return SendErrorMessage(playerid, "Este jogador está com as mensagens privadas desabilitadas.");
    if (Bit_Get(PlayerPMDisabled, playerid)) return SendErrorMessage(playerid, "Você está com as suas mensagens privadas desabilitadas.");
    
    if (strlen(text) > 64) {
        va_SendClientMessage(playerid, COLOR_YELLOW, "(( PM para %s (ID: %d): %.64s", pNome(targetid), targetid, text);
        va_SendClientMessage(playerid, COLOR_YELLOW, "...%s ))", text[64]);

        va_SendClientMessage(targetid, COLOR_YELLOW, "(( PM de %s (ID: %d): %.64s", pNome(playerid), playerid, text);
        va_SendClientMessage(targetid, COLOR_YELLOW, "...%s ))", text[64]);
    } else {
        va_SendClientMessage(playerid, COLOR_YELLOW, "(( PM para %s (ID: %d): %s ))", pNome(targetid), targetid, text);

        va_SendClientMessage(targetid, COLOR_YELLOW, "(( PM de %s (ID: %d): %s ))", pNome(playerid), playerid, text);
    }

    PlayerLastPM[targetid] = playerid;
    return true;
}

CMD:rpm(playerid, params[]) {
    new 
        text[128], targetid = PlayerLastPM[playerid];

    if (sscanf(params, "s[128]", text)) return SendSyntaxMessage(playerid, "/rpm [mensagem]");
    if (targetid == -1) SendErrorMessage(playerid, "Você não tem nenhum jogador para responder.");
    if (!IsPlayerConnected(targetid)) SendNotConnectedMessage(playerid);
    if (Bit_Get(PlayerPMDisabled, targetid)) return SendErrorMessage(playerid, "Este jogador está com as mensagens privadas desabilitadas.");
    if (Bit_Get(PlayerPMDisabled, playerid)) return SendErrorMessage(playerid, "Você está com as suas mensagens privadas desabilitadas.");

    if (strlen(text) > 64) {
        va_SendClientMessage(playerid, COLOR_YELLOW, "(( PM para %s (ID: %d): %.64s", pNome(targetid), targetid, text);
        va_SendClientMessage(playerid, COLOR_YELLOW, "...%s ))", text[64]);

        va_SendClientMessage(targetid, COLOR_YELLOW, "(( PM de %s (ID: %d): %.64s", pNome(playerid), playerid, text);
        va_SendClientMessage(targetid, COLOR_YELLOW, "...%s ))", text[64]);
    } else {
        va_SendClientMessage(playerid, COLOR_YELLOW, "(( PM para %s (ID: %d): %s ))", pNome(targetid), targetid, text);

        va_SendClientMessage(targetid, COLOR_YELLOW, "(( PM de %s (ID: %d): %s ))", pNome(playerid), playerid, text);
    }

    PlayerLastPM[targetid] = playerid;
    return true;
}