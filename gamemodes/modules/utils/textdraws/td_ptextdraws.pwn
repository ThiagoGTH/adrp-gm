CreatePlayerTextdraws(playerid) {
    pInfo[playerid][pTextdraws][0] = CreatePlayerTextDraw(playerid, 520.000000, 135.000000, ""); // Speed
	PlayerTextDrawBackgroundColour(playerid, pInfo[playerid][pTextdraws][0], 0x000000ff);
	PlayerTextDrawFont(playerid, pInfo[playerid][pTextdraws][0], TEXT_DRAW_FONT_3);
	PlayerTextDrawLetterSize(playerid, pInfo[playerid][pTextdraws][0], 0.40, 1.0);
	PlayerTextDrawColour(playerid, pInfo[playerid][pTextdraws][0], 0xffffffff);
	PlayerTextDrawSetShadow(playerid, pInfo[playerid][pTextdraws][0], TEXT_DRAW_ALIGN:1);

	pInfo[playerid][pTextdraws][1] = CreatePlayerTextDraw(playerid, 520.000000, 144.000000, ""); // Combustivel
	PlayerTextDrawBackgroundColour(playerid, pInfo[playerid][pTextdraws][1], 0x000000ff);
	PlayerTextDrawFont(playerid, pInfo[playerid][pTextdraws][1], TEXT_DRAW_FONT_3);
	PlayerTextDrawLetterSize(playerid, pInfo[playerid][pTextdraws][1], 0.40, 1.0);
	PlayerTextDrawColour(playerid, pInfo[playerid][pTextdraws][1], 0xffffffff);
	PlayerTextDrawSetShadow(playerid, pInfo[playerid][pTextdraws][1], TEXT_DRAW_ALIGN:1);

    pInfo[playerid][pTextdraws][2] = CreatePlayerTextDraw(playerid, 595.000000, 425.000000, "0~n~mph"); // Speed
    PlayerTextDrawBackgroundColour(playerid, pInfo[playerid][pTextdraws][2], 0x000000ff);
    PlayerTextDrawFont(playerid, pInfo[playerid][pTextdraws][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, pInfo[playerid][pTextdraws][2], 0.2, 0.8);
    PlayerTextDrawColour(playerid, pInfo[playerid][pTextdraws][2], 0xffffffff);
    PlayerTextDrawSetShadow(playerid, pInfo[playerid][pTextdraws][2], 1);
    PlayerTextDrawAlignment(playerid, pInfo[playerid][pTextdraws][2], TEXT_DRAW_ALIGN:2);

	// HUD
    pInfo[playerid][pTextdraws][3] = CreatePlayerTextDraw(playerid, 623.0, 292.5-5.0, "100");
    PlayerTextDrawBackgroundColour(playerid, pInfo[playerid][pTextdraws][3], 255);
    PlayerTextDrawFont(playerid, pInfo[playerid][pTextdraws][3], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, pInfo[playerid][pTextdraws][3], 0.20000, 0.8);
    PlayerTextDrawColour(playerid, pInfo[playerid][pTextdraws][3], -1);
    PlayerTextDrawSetOutline(playerid, pInfo[playerid][pTextdraws][3], true);
    PlayerTextDrawSetShadow(playerid, pInfo[playerid][pTextdraws][3], false);
    PlayerTextDrawSetProportional(playerid, pInfo[playerid][pTextdraws][3], true);
    PlayerTextDrawSetSelectable(playerid, pInfo[playerid][pTextdraws][3], false);
    PlayerTextDrawAlignment(playerid, pInfo[playerid][pTextdraws][3], TEXT_DRAW_ALIGN:2);

    pInfo[playerid][pTextdraws][4] = CreatePlayerTextDraw(playerid, 623.0, 317.5-5.0, "100");
    PlayerTextDrawBackgroundColour(playerid, pInfo[playerid][pTextdraws][4], 255);
    PlayerTextDrawFont(playerid, pInfo[playerid][pTextdraws][4], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, pInfo[playerid][pTextdraws][4], 0.20000, 0.8);
    PlayerTextDrawColour(playerid, pInfo[playerid][pTextdraws][4], -1);
    PlayerTextDrawSetOutline(playerid, pInfo[playerid][pTextdraws][4], true);
    PlayerTextDrawSetShadow(playerid, pInfo[playerid][pTextdraws][4], false);
    PlayerTextDrawSetProportional(playerid, pInfo[playerid][pTextdraws][4], true);
    PlayerTextDrawSetSelectable(playerid, pInfo[playerid][pTextdraws][4], false);
    PlayerTextDrawAlignment(playerid, pInfo[playerid][pTextdraws][4], TEXT_DRAW_ALIGN:2);

	pInfo[playerid][pTextdraws][5] = CreatePlayerTextDraw(playerid, 623.0, 290.5+50.0, "100");
    PlayerTextDrawBackgroundColour(playerid, pInfo[playerid][pTextdraws][5], 255);
    PlayerTextDrawFont(playerid, pInfo[playerid][pTextdraws][5], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, pInfo[playerid][pTextdraws][5], 0.20000, 0.8);
    PlayerTextDrawColour(playerid, pInfo[playerid][pTextdraws][5], -1);
    PlayerTextDrawSetOutline(playerid, pInfo[playerid][pTextdraws][5], true);
    PlayerTextDrawSetShadow(playerid, pInfo[playerid][pTextdraws][5], false);
    PlayerTextDrawSetProportional(playerid, pInfo[playerid][pTextdraws][5], true);
    PlayerTextDrawSetSelectable(playerid, pInfo[playerid][pTextdraws][5], false);
    PlayerTextDrawAlignment(playerid, pInfo[playerid][pTextdraws][5], TEXT_DRAW_ALIGN:2);
    return true;
}
    