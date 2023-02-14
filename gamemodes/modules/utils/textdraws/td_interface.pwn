forward SetPlayerInterface(playerid, level);
public SetPlayerInterface(playerid, level) {
    if(level == 1) { // SENHA INCORRETA
        KillTimer(pInfo[playerid][pInterfaceTimer]);
        NotifyWrongAttempt(playerid);
        HidePlayerFooter(playerid);
        ShowPlayerFooter(playerid, "SENHA_INVÁLIDA", 1);
        pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);
        
    } else if(level == 2) { // AUTENTICADO
        KillTimer(pInfo[playerid][pInterfaceTimer]);
        ShowCharactersTD(playerid);
        HidePlayerFooter(playerid);
        ShowPlayerFooter(playerid, "AUTENTICADO", 3);
        pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);

    } else if(level == 888) { // FECHAR NOTIFICAÇÕES
        KillTimer(pInfo[playerid][pInterfaceTimer]);
        HidePlayerFooter(playerid);
    } else if(level == 999) { // FECHAR TUDO
        KillTimer(pInfo[playerid][pInterfaceTimer]);
        HideLoginTextdraws(playerid);
        HideCharacterTextdraws(playerid);
        HideBannedTextdraws(playerid);
        HideNewsTextdraws(playerid);
        HidePlayerFooter(playerid);
    }
    return true;
}