new PlayerText:NotifyTD[MAX_PLAYERS][3];

CreateNotifyTextdraws(playerid) {
    NotifyTD[playerid][0] = CreatePlayerTextDraw(playerid, 236.764846, 369.083251, "mdl-9001:notify_bg");
    PlayerTextDrawTextSize(playerid, NotifyTD[playerid][0], 156.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, NotifyTD[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NotifyTD[playerid][0], 842150600);
    PlayerTextDrawSetShadow(playerid, NotifyTD[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, NotifyTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, NotifyTD[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NotifyTD[playerid][0], false);

    NotifyTD[playerid][1] = CreatePlayerTextDraw(playerid, 236.969787, 370.250061, "mdl-9001:notify_error");
    PlayerTextDrawTextSize(playerid, NotifyTD[playerid][1], 16.000000, 16.000000);
    PlayerTextDrawAlignment(playerid, NotifyTD[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NotifyTD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, NotifyTD[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, NotifyTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, NotifyTD[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NotifyTD[playerid][1], false);

    NotifyTD[playerid][2] = CreatePlayerTextDraw(playerid, 316.659057, 370.750000, "TEXTO_FOOTER");
    PlayerTextDrawLetterSize(playerid, NotifyTD[playerid][2], 0.400000, 1.500000);
    PlayerTextDrawAlignment(playerid, NotifyTD[playerid][2], TEXT_DRAW_ALIGN:2);
    PlayerTextDrawColour(playerid, NotifyTD[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, NotifyTD[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, NotifyTD[playerid][2], 255);
    PlayerTextDrawFont(playerid, NotifyTD[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, NotifyTD[playerid][2], true);
    return true;
}

ShowPlayerFooter(playerid, const string[], type = 2) {
    new adjust[256];
    switch(type) {
        case 1: format(adjust, sizeof(adjust), "mdl-9001:notify_error");
        case 2: format(adjust, sizeof(adjust), "mdl-9001:notify_info");
        case 3: format(adjust, sizeof(adjust), "mdl-9001:notify_success");
    }
    PlayerTextDrawSetString(playerid, NotifyTD[playerid][1], adjust);

    format(adjust, sizeof(adjust), "%s", string);
	AdjustTextDrawString(adjust);
    PlayerTextDrawSetString(playerid, NotifyTD[playerid][2], adjust);

    for(new i; i < 3; i++)
        PlayerTextDrawShow(playerid, NotifyTD[playerid][i]);
}

forward HidePlayerFooter(playerid);
public HidePlayerFooter(playerid) {
    for(new i; i < 3; i++)
        PlayerTextDrawHide(playerid, NotifyTD[playerid][i]);
	return true;
}