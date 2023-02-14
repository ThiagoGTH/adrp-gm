new PlayerText:NewsTD[MAX_PLAYERS][11];

forward ShowNewsTextdraws(playerid);
public ShowNewsTextdraws(playerid) {
    for(new i; i < 11; i++)
        PlayerTextDrawShow(playerid, NewsTD[playerid][i]);
    
    return true;
}

HideNewsTextdraws(playerid) {
    for(new i; i < 11; i++)
        PlayerTextDrawHide(playerid, NewsTD[playerid][i]);

    return true;
}

CreateNewsTextdraws(playerid) {
    NewsTD[playerid][0] = CreatePlayerTextDraw(playerid, 78.176460, 303.018554, "mdl-9002:ABC7-Bottom");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][0], 481.000000, 139.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][0], false);

    NewsTD[playerid][1] = CreatePlayerTextDraw(playerid, 512.200561, 50.116756, "mdl-9002:ABC7-LIVE");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][1], 25.000000, 16.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][1], false);

    NewsTD[playerid][2] = CreatePlayerTextDraw(playerid, -0.411781, -0.166666, "mdl-9002:tv-screen");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][2], 712.000000, 477.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][2], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][2], false);

    NewsTD[playerid][3] = CreatePlayerTextDraw(playerid, 640.529296, -1.149999, "LD_PLAN:tvcorn");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][3], -142.000000, 158.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][3], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][3], false);

    NewsTD[playerid][4] = CreatePlayerTextDraw(playerid, 141.705871, -2.500007, "LD_PLAN:tvbase");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][4], 357.000000, 13.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][4], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][4], false);

    NewsTD[playerid][5] = CreatePlayerTextDraw(playerid, 640.058044, 448.600219, "LD_PLAN:tvcorn");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][5], -141.000000, -165.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][5], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][5], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][5], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][5], false);

    NewsTD[playerid][6] = CreatePlayerTextDraw(playerid, -1.823829, 449.583496, "LD_PLAN:tvcorn");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][6], 145.000000, -176.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][6], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][6], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][6], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][6], false);

    NewsTD[playerid][7] = CreatePlayerTextDraw(playerid, 142.647033, 436.749969, "LD_PLAN:tvbase");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][7], 357.000000, 13.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][7], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][7], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][7], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][7], false);

    NewsTD[playerid][8] = CreatePlayerTextDraw(playerid, -0.411824, 152.666641, "LD_PLAN:tvbase");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][8], 9.000000, 123.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][8], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][8], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][8], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][8], false);

    NewsTD[playerid][9] = CreatePlayerTextDraw(playerid, 629.705505, 154.999908, "LD_PLAN:tvbase");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][9], 13.000000, 133.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][9], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][9], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][9], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][9], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][9], false);

    NewsTD[playerid][10] = CreatePlayerTextDraw(playerid, -0.882364, -0.749989, "LD_PLAN:tvcorn");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][10], 143.000000, 154.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][10], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, NewsTD[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][10], 0);
    PlayerTextDrawBackgroundColour(playerid, NewsTD[playerid][10], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][10], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][10], false);
    return true;
}