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
    return true;
}
    