CMD:id(playerid, params[])
{
    if (isnull(params))
        return SendSyntaxMessage(playerid, "/id [id/nome]");

    if(IsNumeric(params)){
        new userid = strval(params);

        if(userid < 0 || userid >= MAX_PLAYERS)
            return SendErrorMessage(playerid, "Escolha um playerid válido.");
        if(userid == INVALID_PLAYER_ID || !pInfo[userid][pLogged])
            return SendErrorMessage(playerid, "Este jogador não está conectado.");
        va_SendClientMessage(playerid, COLOR_GREY, "%s [%d] (level %d)", pNome(userid), userid, pInfo[userid][pScore]);
    } else {
        new count;

        foreach (new i : Player) {
            if (strfind(pNome(i), params, true) != -1) {
                va_SendClientMessage(playerid, COLOR_GREY, "%s [%d] (level %d)", pNome(i), i, pInfo[i][pScore]);
                count++;
            }
        }
        if (!count)
            return SendErrorMessage(playerid, "Nenhum resultado foi encontrado com os critérios: \"%s\".", params);
    }

    return true;
}