new Text:TD_PhoneCover[9];
new PlayerText:TD_PhoneCoverModel[MAX_PLAYERS];

// Phone
new PlayerText:TDPhone_Model[MAX_PLAYERS][14];
new PlayerText:TDPhone_TFButton[MAX_PLAYERS];
new PlayerText:TDPhone_TSButton[MAX_PLAYERS];
new PlayerText:TDPhone_BigText[MAX_PLAYERS];
new PlayerText:TDPhone_ScreenText[MAX_PLAYERS];
new PlayerText:TDPhone_Signal[MAX_PLAYERS];
new PlayerText:TDPhone_Picture[MAX_PLAYERS];
new PlayerText:TDPhone_NotifyText[MAX_PLAYERS];
new PlayerText:TDPhone_Choice[MAX_PLAYERS][4];

new bool:PhoneOpen[MAX_PLAYERS char];

new ph_menuid[MAX_PLAYERS];
new ph_sub_menuid[MAX_PLAYERS];
new ph_selected[MAX_PLAYERS]; // GUI select id   0 - 3
new ph_select_data[MAX_PLAYERS];
new ph_call_string[MAX_PLAYERS][64];
new ph_data[MAX_PLAYERS][4];
new ph_page[MAX_PLAYERS]; // data of rows
new ph_airmode[MAX_PLAYERS];
new ph_silentmode[MAX_PLAYERS];
new bool:ph_speaker[MAX_PLAYERS char];
new ph_TextTone[MAX_PLAYERS];
new ph_CallTone[MAX_PLAYERS];

hook OnPlayerConnect(playerid) {
	CreatePlayerPhoneTextDraws(playerid);
	return 1;
}

hook OnGameModeInit() {
	CreatePhoneTextDraws();
	return 1;
}

CreatePhoneTextDraws() {
	TD_PhoneCover[0] = TextDrawCreate(333.600036, 121.804512, "SELECT COLOR");
	TextDrawLetterSize(TD_PhoneCover[0], 0.279599, 1.465599);
	TextDrawTextSize(TD_PhoneCover[0], -0.149999, 139.000000);
	TextDrawAlignment(TD_PhoneCover[0], 2);
	TextDrawColor(TD_PhoneCover[0], -1);
	TextDrawUseBox(TD_PhoneCover[0], 1);
	TextDrawBoxColor(TD_PhoneCover[0], 80);
	TextDrawSetShadow(TD_PhoneCover[0], 0);
	TextDrawSetOutline(TD_PhoneCover[0], 0);
	TextDrawBackgroundColor(TD_PhoneCover[0], 255);
	TextDrawFont(TD_PhoneCover[0], 2);
	TextDrawSetProportional(TD_PhoneCover[0], 1);
	TextDrawSetShadow(TD_PhoneCover[0], 0);

	TD_PhoneCover[1] = TextDrawCreate(269.399841, 146.537796, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[1], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[1], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[1], 1);
	TextDrawColor(TD_PhoneCover[1], 286331391);
	TextDrawSetShadow(TD_PhoneCover[1], 0);
	TextDrawSetOutline(TD_PhoneCover[1], 0);
	TextDrawBackgroundColor(TD_PhoneCover[1], 255);
	TextDrawFont(TD_PhoneCover[1], 4);
	TextDrawSetProportional(TD_PhoneCover[1], 0);
	TextDrawSetShadow(TD_PhoneCover[1], 0);
	TextDrawSetSelectable(TD_PhoneCover[1], true);

	TD_PhoneCover[2] = TextDrawCreate(302.999847, 146.537841, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[2], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[2], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[2], 1);
	TextDrawColor(TD_PhoneCover[2], 1628113919);
	TextDrawSetShadow(TD_PhoneCover[2], 0);
	TextDrawSetOutline(TD_PhoneCover[2], 0);
	TextDrawBackgroundColor(TD_PhoneCover[2], 255);
	TextDrawFont(TD_PhoneCover[2], 4);
	TextDrawSetProportional(TD_PhoneCover[2], 0);
	TextDrawSetShadow(TD_PhoneCover[2], 0);
	TextDrawSetSelectable(TD_PhoneCover[2], true);

	TD_PhoneCover[3] = TextDrawCreate(268.999877, 181.880020, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[3], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[3], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[3], 1);
	TextDrawColor(TD_PhoneCover[3], 2104099071);
	TextDrawSetShadow(TD_PhoneCover[3], 0);
	TextDrawSetOutline(TD_PhoneCover[3], 0);
	TextDrawBackgroundColor(TD_PhoneCover[3], 255);
	TextDrawFont(TD_PhoneCover[3], 4);
	TextDrawSetProportional(TD_PhoneCover[3], 0);
	TextDrawSetShadow(TD_PhoneCover[3], 0);
	TextDrawSetSelectable(TD_PhoneCover[3], true);

	TD_PhoneCover[4] = TextDrawCreate(302.599945, 181.880142, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[4], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[4], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[4], 1);
	TextDrawColor(TD_PhoneCover[4], 405561855);
	TextDrawSetShadow(TD_PhoneCover[4], 0);
	TextDrawSetOutline(TD_PhoneCover[4], 0);
	TextDrawBackgroundColor(TD_PhoneCover[4], 255);
	TextDrawFont(TD_PhoneCover[4], 4);
	TextDrawSetProportional(TD_PhoneCover[4], 0);
	TextDrawSetShadow(TD_PhoneCover[4], 0);
	TextDrawSetSelectable(TD_PhoneCover[4], true);

	TD_PhoneCover[5] = TextDrawCreate(269.399963, 217.222259, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[5], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[5], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[5], 1);
	TextDrawColor(TD_PhoneCover[5], 388831231);
	TextDrawSetShadow(TD_PhoneCover[5], 0);
	TextDrawSetOutline(TD_PhoneCover[5], 0);
	TextDrawBackgroundColor(TD_PhoneCover[5], 255);
	TextDrawFont(TD_PhoneCover[5], 4);
	TextDrawSetProportional(TD_PhoneCover[5], 0);
	TextDrawSetShadow(TD_PhoneCover[5], 0);
	TextDrawSetSelectable(TD_PhoneCover[5], true);

	TD_PhoneCover[6] = TextDrawCreate(303.000061, 216.724502, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[6], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[6], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[6], 1);
	TextDrawColor(TD_PhoneCover[6], 0xce9100ff);
	TextDrawSetShadow(TD_PhoneCover[6], 0);
	TextDrawSetOutline(TD_PhoneCover[6], 0);
	TextDrawBackgroundColor(TD_PhoneCover[6], 255);
	TextDrawFont(TD_PhoneCover[6], 4);
	TextDrawSetProportional(TD_PhoneCover[6], 0);
	TextDrawSetShadow(TD_PhoneCover[6], 0);
	TextDrawSetSelectable(TD_PhoneCover[6], true);

	TD_PhoneCover[7] = TextDrawCreate(269.400024, 253.560089, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[7], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[7], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[7], 1);
	TextDrawColor(TD_PhoneCover[7], -2063576577);
	TextDrawSetShadow(TD_PhoneCover[7], 0);
	TextDrawSetOutline(TD_PhoneCover[7], 0);
	TextDrawBackgroundColor(TD_PhoneCover[7], 255);
	TextDrawFont(TD_PhoneCover[7], 4);
	TextDrawSetProportional(TD_PhoneCover[7], 0);
	TextDrawSetShadow(TD_PhoneCover[7], 0);
	TextDrawSetSelectable(TD_PhoneCover[7], true);

	TD_PhoneCover[8] = TextDrawCreate(364.400238, 262.177764, "Purchase");
	TextDrawLetterSize(TD_PhoneCover[8], 0.279599, 1.465599);
	TextDrawTextSize(TD_PhoneCover[8], 10.0, 77.000000);
	TextDrawAlignment(TD_PhoneCover[8], 2);
	TextDrawColor(TD_PhoneCover[8], -1);
	TextDrawUseBox(TD_PhoneCover[8], 1);
	TextDrawBoxColor(TD_PhoneCover[8], 80);
	TextDrawSetShadow(TD_PhoneCover[8], 0);
	TextDrawSetOutline(TD_PhoneCover[8], 0);
	TextDrawBackgroundColor(TD_PhoneCover[8], 255);
	TextDrawFont(TD_PhoneCover[8], 2);
	TextDrawSetProportional(TD_PhoneCover[8], 1);
	TextDrawSetShadow(TD_PhoneCover[8], 0);
	TextDrawSetSelectable(TD_PhoneCover[8], true);
}

CreatePlayerPhoneTextDraws(playerid) {
	TD_PhoneCoverModel[playerid] = CreatePlayerTextDraw(playerid, 325.400177, 140.0, "");
	PlayerTextDrawLetterSize(playerid, TD_PhoneCoverModel[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_PhoneCoverModel[playerid], 90.000000, 119.000000);
	PlayerTextDrawAlignment(playerid, TD_PhoneCoverModel[playerid], 1);
	PlayerTextDrawColor(playerid, TD_PhoneCoverModel[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawFont(playerid, TD_PhoneCoverModel[playerid], 5);
	PlayerTextDrawSetProportional(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawSetShadow(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18868);
	PlayerTextDrawSetPreviewRot(playerid, TD_PhoneCoverModel[playerid], 80.000000, -30.000000, 0.000000, 0.600000);

	// NEW PHONE SYSTEM
	/*TDPhone_Model[playerid][0] = CreatePlayerTextDraw(playerid, 499.499816, 317.032318, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][0], 0.407599, 14.487455);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][0], 597.000000, 0.119998);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TDPhone_Model[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 286331391);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][0], 1);*/

	TDPhone_Model[playerid][0] = CreatePlayerTextDraw(playerid, 601.666931, 323.555450, "box");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][0], 0.000000, 15.181289);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][0], 498.333343, 0.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, TDPhone_Model[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 269619711);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][0], 0);

	TDPhone_Model[playerid][1] = CreatePlayerTextDraw(playerid, 496.199707, 314.288909, "ld_spac:tvcorn");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][1], 55.000000, 135.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -858993409);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][1], 4);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][1], 0);

	TDPhone_Model[playerid][2] = CreatePlayerTextDraw(playerid, 601.802307, 314.288909, "ld_spac:tvcorn");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][2], -55.000000, 135.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][2], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -858993409);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][2], 0);

	TDPhone_Model[playerid][3] = CreatePlayerTextDraw(playerid, 572.000122, 323.970397, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][3], 9.000018, 9.540739);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][3], true);

	TDPhone_Model[playerid][4] = CreatePlayerTextDraw(playerid, 579.667358, 319.822174, "ld_beat:circle");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][4], 15.999990, 15.762954);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][4], true);

	TDPhone_Model[playerid][5] = CreatePlayerTextDraw(playerid, 550.333374, 329.377868, "LS Telefonica");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][5], 0.199333, 0.865777);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][5], 0.000000, 2016.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][5], 2);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][5], -522133249);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][5], 1);

	TDPhone_Model[playerid][6] = CreatePlayerTextDraw(playerid, 592.000427, 349.944366, "box");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][6], 0.000000, 5.982919);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][6], 506.999633, 0.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][6], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][6], 0);
	PlayerTextDrawUseBox(playerid, TDPhone_Model[playerid][6], true);
	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][6], -572662273);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][6], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][6], 0);

	TDPhone_Model[playerid][7] = CreatePlayerTextDraw(playerid, 507.333282, 407.763031, "ld_dual:white"); // Left Button
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][7], 22.333309, 7.881487);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][7], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][7], -1717986817);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][7], 0);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][7], 4);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][7], true);

    ////
	TDPhone_Model[playerid][8] = CreatePlayerTextDraw(playerid, 544.666809, 409.422149, "ld_beat:up");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][8], 12.000005, 12.444459);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][8], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][8], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][8], true);

	TDPhone_Model[playerid][9] = CreatePlayerTextDraw(playerid, 544.666809, 425.600006, "ld_beat:down");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][9], 11.666647, 12.029617);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][9], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][9], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][9], true);

	TDPhone_Model[playerid][10] = CreatePlayerTextDraw(playerid, 534.666931, 417.718536, "ld_beat:left");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][10], 12.000015, 12.029621);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][10], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][10], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][10], true);

	TDPhone_Model[playerid][11] = CreatePlayerTextDraw(playerid, 554.333679, 417.718414, "ld_beat:right");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][11], 12.333327, 12.029634);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][11], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][11], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][11], true);
	////

	TDPhone_Model[playerid][12] = CreatePlayerTextDraw(playerid, 596.699890, 423.302307, "ld_dual:white"); // Selfie
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][12], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][12], 5.000000, 18.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][12], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][12], 1145324799);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][12], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][12], 4);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][12], true);

	TDPhone_Model[playerid][13] = CreatePlayerTextDraw(playerid, 569.333496, 407.762969, "LD_SPAC:white"); // Right button
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][13], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][13], 22.333290, 7.881502);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][13], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][13], -1717986817);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][13], 0);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][13], 4);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][13], true);

	TDPhone_TFButton[playerid] = CreatePlayerTextDraw(playerid, 509.666534, 394.918609, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_TFButton[playerid], 0.197000, 0.778666);
	PlayerTextDrawTextSize(playerid, TDPhone_TFButton[playerid], 518.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_TFButton[playerid], 1);
	PlayerTextDrawColor(playerid, TDPhone_TFButton[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_TFButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_TFButton[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_TFButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_TFButton[playerid], 1);

	TDPhone_TSButton[playerid] = CreatePlayerTextDraw(playerid, 589.333190, 394.918701, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_TSButton[playerid], 0.197000, 0.778666);
	PlayerTextDrawTextSize(playerid, TDPhone_TSButton[playerid], 518.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_TSButton[playerid], 3);
	PlayerTextDrawColor(playerid, TDPhone_TSButton[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_TSButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_TSButton[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_TSButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_TSButton[playerid], 1);

	TDPhone_BigText[playerid] = CreatePlayerTextDraw(playerid, 549.666748, 354.681549, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_BigText[playerid], 0.298332, 1.114665);
	PlayerTextDrawAlignment(playerid, TDPhone_BigText[playerid], 2);
	PlayerTextDrawColor(playerid, TDPhone_BigText[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_BigText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_BigText[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_BigText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_BigText[playerid], 1);

	TDPhone_ScreenText[playerid] = CreatePlayerTextDraw(playerid, 549.666870, 365.051666, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_ScreenText[playerid], 0.200332, 0.757924);
	PlayerTextDrawTextSize(playerid, TDPhone_ScreenText[playerid], 0.000000, 2181.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_ScreenText[playerid], 2);
	PlayerTextDrawColor(playerid, TDPhone_ScreenText[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_ScreenText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_ScreenText[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_ScreenText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_ScreenText[playerid], 1);

	TDPhone_Signal[playerid] = CreatePlayerTextDraw(playerid, 589.666809, 348.874023, "IIIII");
	PlayerTextDrawLetterSize(playerid, TDPhone_Signal[playerid], 0.141333, 0.683259);
	PlayerTextDrawAlignment(playerid, TDPhone_Signal[playerid], 3);
	PlayerTextDrawColor(playerid, TDPhone_Signal[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_Signal[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Signal[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_Signal[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_Signal[playerid], 1);

	TDPhone_Picture[playerid] = CreatePlayerTextDraw(playerid, 488.199890, 296.000000, "_"); // Emo
	PlayerTextDrawLetterSize(playerid, TDPhone_Picture[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Picture[playerid], -50.000000, 50.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Picture[playerid], 1);
	PlayerTextDrawColor(playerid, TDPhone_Picture[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Picture[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Picture[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Picture[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_Picture[playerid], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Picture[playerid], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Picture[playerid], 0);

	TDPhone_NotifyText[playerid] = CreatePlayerTextDraw(playerid, 578.799987, 351.280090, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_NotifyText[playerid], 0.139199, 0.659200);
	PlayerTextDrawTextSize(playerid, TDPhone_NotifyText[playerid], 598.799987, 15.0);
	PlayerTextDrawAlignment(playerid, TDPhone_NotifyText[playerid], 3);
	PlayerTextDrawColor(playerid, TDPhone_NotifyText[playerid], -16776961);
	PlayerTextDrawSetShadow(playerid, TDPhone_NotifyText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_NotifyText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_NotifyText[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_NotifyText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_NotifyText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TDPhone_NotifyText[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_NotifyText[playerid], true);

    for(new i = 0, Float:y = 352.607360; i < 4; ++i)
	{
		TDPhone_Choice[playerid][i] = CreatePlayerTextDraw(playerid, 511.666717, y, "_");
		PlayerTextDrawLetterSize(playerid, TDPhone_Choice[playerid][i], 0.199666, 0.820148);
		PlayerTextDrawTextSize(playerid, TDPhone_Choice[playerid][i], 587.000000, 7.000000);
		PlayerTextDrawAlignment(playerid, TDPhone_Choice[playerid][i], 1);
		PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, TDPhone_Choice[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][i], 255);
		PlayerTextDrawSetShadow(playerid, TDPhone_Choice[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, TDPhone_Choice[playerid][i], 255);
		PlayerTextDrawFont(playerid, TDPhone_Choice[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TDPhone_Choice[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TDPhone_Choice[playerid][i], true);

		y += 13.274079;
	}
}