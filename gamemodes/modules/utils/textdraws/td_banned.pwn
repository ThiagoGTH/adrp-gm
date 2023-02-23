new Text:BannedTD[3];

forward ShowBannedTextdraws(playerid);
public ShowBannedTextdraws(playerid) {
    for(new i; i < 3; i++)
        TextDrawShowForPlayer(playerid, BannedTD[i]);

    InterpolateCameraPos(playerid, 2151.759033, -1955.770507, 14.705178, 1460.781860, -1955.596435, 14.657321, 30000);
    InterpolateCameraLookAt(playerid, 2146.779785, -1956.206420, 14.837976, 1455.782226, -1955.538818, 14.680758, 30000);
    return true;
}

HideBannedTextdraws(playerid) {
    for(new i; i < 3; i++)
        TextDrawHideForPlayer(playerid, BannedTD[i]);

    return true;
}

CreateBannedTextdraws() {
    BannedTD[0] = TextDrawCreate(-0.882323, -4.833319, "mdl-9000:filter_bgm");
    TextDrawTextSize(BannedTD[0], 643.000000, 453.000000);
    TextDrawAlignment(BannedTD[0], TEXT_DRAW_ALIGN:1);
    TextDrawColour(BannedTD[0], -1);
    TextDrawSetShadow(BannedTD[0], 0);
    TextDrawBackgroundColour(BannedTD[0], 255);
    TextDrawFont(BannedTD[0], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(BannedTD[0], false);

    BannedTD[1] = TextDrawCreate(285.999755, 32.299999, "mdl-9000:ban");
    TextDrawTextSize(BannedTD[1], 79.000000, 74.000000);
    TextDrawAlignment(BannedTD[1], TEXT_DRAW_ALIGN:1);
    TextDrawColour(BannedTD[1], -1);
    TextDrawSetShadow(BannedTD[1], 0);
    TextDrawBackgroundColour(BannedTD[1], 255);
    TextDrawFont(BannedTD[1], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(BannedTD[1], false);

    BannedTD[2] = TextDrawCreate(277.294189, 324.550537, "mdl-9000:logo");
    TextDrawTextSize(BannedTD[2], 91.000000, 41.000000);
    TextDrawAlignment(BannedTD[2], TEXT_DRAW_ALIGN:1);
    TextDrawColour(BannedTD[2], -1);
    TextDrawSetShadow(BannedTD[2], 0);
    TextDrawBackgroundColour(BannedTD[2], 255);
    TextDrawFont(BannedTD[2], TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawSetProportional(BannedTD[2], false);
    return true;
}

DestroyBannedTextdraws() {
    for(new i; i < 3; i++)
        TextDrawDestroy(BannedTD[i]);

    return true;
}