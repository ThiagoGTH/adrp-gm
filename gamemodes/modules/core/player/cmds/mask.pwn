#include <YSI_Coding\y_hooks>

new PlayerText:MaskTD[MAX_PLAYERS];

createMaskTextdraw(playerid) {
    MaskTD[playerid] = CreatePlayerTextDraw(playerid, 528.666198, 1.933331, "");
    PlayerTextDrawTextSize(playerid, MaskTD[playerid], 52.000000, 52.000000);
    PlayerTextDrawAlignment(playerid, MaskTD[playerid], 1);
    PlayerTextDrawColor(playerid, MaskTD[playerid], -1);
    PlayerTextDrawSetShadow(playerid, MaskTD[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MaskTD[playerid], 0);
    PlayerTextDrawFont(playerid, MaskTD[playerid], 5);
    PlayerTextDrawSetProportional(playerid, MaskTD[playerid], 0);
    PlayerTextDrawSetPreviewModel(playerid, MaskTD[playerid], 19036);
    PlayerTextDrawSetPreviewRot(playerid, MaskTD[playerid], 0.000000, 0.000000, 90.000000, 1.000000);
}

ShowMaskTextdraw(playerid)
{
    PlayerTextDrawShow(playerid, MaskTD[playerid]);
    return true;
}

HideMaskTextdraw(playerid)
{
    PlayerTextDrawHide(playerid, MaskTD[playerid]);
    return true;
}

RefreshMaskStatus(playerid, togglefor)
{
    if(pInfo[playerid][pMasked] == 1)
    {
        ShowPlayerNameTagForPlayer(togglefor, playerid, false);
    }
    else
    {
        ShowPlayerNameTagForPlayer(togglefor, playerid, true);
    }

    ShowPlayerNameTagForPlayer(togglefor, playerid, true);
}

CMD:mascara(playerid, params[])
{
    if(pInfo[playerid][pJailed])
        return SendErrorMessage(playerid, "Você não pode utilizar máscaras na prisão.");

    if(!pInfo[playerid][pHasMask] && pInfo[playerid][pAdmin] < 1 && pInfo[playerid][pDonator] < 1)
        return va_SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem uma máscara.");

    if(pInfo[playerid][pMasked] == 0)
    {
        GameTextForPlayer(playerid, "~p~VOCÊ COLOCOU A MÝSCARA", 3000, 3);

        format(pInfo[playerid][pMask_Name], MAX_PLAYER_NAME, "%i_%i", pInfo[playerid][pMaskID][0], pInfo[playerid][pMaskID][1]);

        pInfo[playerid][pMasked] = 1;

        if(pInfo[playerid][pDonator] > 1) ShowMaskTextdraw(playerid);

        foreach (new i : Player)
        {
            if(i != playerid)
            {
                RefreshMaskStatus(playerid, i);
            }
           }

    }
    else
    {
        GameTextForPlayer(playerid, "~p~VOCÊ RETIROU A MÝSCARA", 3000, 3);

        pInfo[playerid][pMasked] = 0;

        foreach (new i : Player)
          {
            if(i != playerid)
            {
                RefreshMaskStatus(playerid, i);
            }
        }

        HideMaskTextdraw(playerid);

        pInfo[playerid][pMask_Name][0] = EOS;
    }
    return true;
}