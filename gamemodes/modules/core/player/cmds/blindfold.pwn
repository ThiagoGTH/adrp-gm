#include <YSI_Coding\y_hooks>

new PlayerText:blindfold[MAX_PLAYERS];
//new bool:Blindfold[MAX_PLAYERS char];

createBlindfoldTextdraw(playerid) {
    blindfold[playerid] = CreatePlayerTextDraw(playerid, 0.000000, 0.000000, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, blindfold[playerid], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, blindfold[playerid], 640.000000, 448.000000);
    PlayerTextDrawAlignment(playerid, blindfold[playerid], 2);
    PlayerTextDrawColor(playerid, blindfold[playerid], 255);
    PlayerTextDrawSetShadow(playerid, blindfold[playerid], 1);
    PlayerTextDrawSetOutline(playerid, blindfold[playerid], 0);
    PlayerTextDrawFont(playerid, blindfold[playerid], 4);
}

CMD:blindfold(playerid, params[])
{
    if(pInfo[playerid][pBlindfolded] == 0)
     {
        pInfo[playerid][pBlindfolded] = 1;

        PlayerTextDrawShow(playerid, blindfold[playerid]);
    }
    else
    {
        pInfo[playerid][pBlindfolded] = 0;

        PlayerTextDrawHide(playerid, blindfold[playerid]);
    }
    return true;
}