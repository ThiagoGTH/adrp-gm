new PlayerText:LoginTD[MAX_PLAYERS][2];

new PlayerText:CharTD[MAX_PLAYERS][2];
new PlayerText:CharTD_1[MAX_PLAYERS][5];
new PlayerText:CharTD_2[MAX_PLAYERS][5];
new PlayerText:CharTD_3[MAX_PLAYERS][5];
new PlayerText:CharTD_4[MAX_PLAYERS][5];
new PlayerText:CharTD_5[MAX_PLAYERS][5];
new PlayerText:CharTD_6[MAX_PLAYERS][5];
new PlayerText:CharTD_7[MAX_PLAYERS][5];
new PlayerText:CharTD_8[MAX_PLAYERS][5];
new PlayerText:CharTD_9[MAX_PLAYERS][5];
new PlayerText:CharTD_10[MAX_PLAYERS][5];
new PlayerText:CharTD_BUTTON[MAX_PLAYERS][3];

forward ShowLoginTextdraws(playerid);
public ShowLoginTextdraws(playerid) {
    for(new i; i < 2; i++)
        PlayerTextDrawShow(playerid, LoginTD[playerid][i]);

    InterpolateCameraPos(playerid, 1307.082153, -1441.499755, 221.137145, 1764.986206, -1501.460083, 238.376602, 12000);
    InterpolateCameraLookAt(playerid, 1311.717285, -1439.645874, 220.856262, 1761.035888, -1498.431884, 237.901809, 12000);
    return true;
}

// Função para esconder os textdraws de login
HideLoginTextdraws(playerid) {
    for(new i; i < 2; i++)
        PlayerTextDrawHide(playerid, LoginTD[playerid][i]);

    return true;
}

// Função para criar os textdraws de login
CreateLoginTextdraws(playerid) {
    LoginTD[playerid][0] = CreatePlayerTextDraw(playerid, -2.564767, -2.616678, "mdl-9000:filter_bgm");
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][0], 645.000000, 463.000000);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, LoginTD[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, LoginTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, LoginTD[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][0], false);

    LoginTD[playerid][1] = CreatePlayerTextDraw(playerid, 265.000000, 32.299999, "mdl-9000:logo");
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][1], 115.000000, 52.000000);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, LoginTD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, LoginTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, LoginTD[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][1], false);

    return true;
}

forward ShowCharacterTextdraws(playerid, type);
public ShowCharacterTextdraws(playerid, type) {
    for(new i; i < 2; i++)
        PlayerTextDrawShow(playerid, CharTD[playerid][i]);

    if(type == 1){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_1[playerid][i]);
    } else if(type == 2){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_2[playerid][i]);
    } else if(type == 3){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_3[playerid][i]);
    } else if(type == 4){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_4[playerid][i]);
    } else if(type == 5){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_5[playerid][i]);
    } else if(type == 6){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_6[playerid][i]);
    } else if(type == 7){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_7[playerid][i]);
    } else if(type == 8){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_8[playerid][i]);
    } else if(type == 9){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_9[playerid][i]);
    } else if(type == 10){
        for(new i; i < 5; i++)
            PlayerTextDrawShow(playerid, CharTD_10[playerid][i]);
    }
    return true;
}

forward ShowCharacterButtonTextdraws(playerid);
public ShowCharacterButtonTextdraws(playerid) {
    for(new i; i < 3; i++)
        PlayerTextDrawShow(playerid, CharTD_BUTTON[playerid][i]);

    return true;
}

HideCharacterTextdraws(playerid) {
    for(new i; i < 2; i++)
        PlayerTextDrawHide(playerid, CharTD[playerid][i]);

    for(new i; i < 5; i++) {
        PlayerTextDrawHide(playerid, CharTD_1[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_2[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_3[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_4[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_5[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_6[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_7[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_8[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_9[playerid][i]);
        PlayerTextDrawHide(playerid, CharTD_10[playerid][i]);
    }

    for(new i; i < 3; i++)
        PlayerTextDrawHide(playerid, CharTD_BUTTON[playerid][i]);
    
    return true;
}

CreateCharacterTextdraws(playerid) {
    CharTD[playerid][0] = CreatePlayerTextDraw(playerid, 653.705017, -1.333356, "mdl-9000:filter_bg_side");
    PlayerTextDrawTextSize(playerid, CharTD[playerid][0], -747.000000, 456.000000);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][0], false);

    CharTD[playerid][1] = CreatePlayerTextDraw(playerid, 489.681152, 59.816619, "mdl-9000:title_characters");
    PlayerTextDrawTextSize(playerid, CharTD[playerid][1], 175.000000, 14.000000);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][1], false);

    CreateCharacterTextdraws1(playerid);
    CreateCharacterTextdraws2(playerid);
    CreateCharacterTextdraws3(playerid);
    CreateCharacterTextdraws4(playerid);
    CreateCharacterTextdraws5(playerid);
    CreateCharacterTextdraws6(playerid);
    CreateCharacterTextdraws7(playerid);
    CreateCharacterTextdraws8(playerid);
    CreateCharacterTextdraws9(playerid);
    CreateCharacterTextdraws10(playerid);

    CharTD_BUTTON[playerid][0] = CreatePlayerTextDraw(playerid, 134.176513, 349.833282, "mdl-9000:button");
    PlayerTextDrawTextSize(playerid, CharTD_BUTTON[playerid][0], 91.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, CharTD_BUTTON[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_BUTTON[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_BUTTON[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_BUTTON[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_BUTTON[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_BUTTON[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_BUTTON[playerid][0], true);

    CharTD_BUTTON[playerid][1] = CreatePlayerTextDraw(playerid, 134.176513, 349.833282, "mdl-9000:button_effect");
    PlayerTextDrawTextSize(playerid, CharTD_BUTTON[playerid][1], 91.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, CharTD_BUTTON[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_BUTTON[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_BUTTON[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_BUTTON[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_BUTTON[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_BUTTON[playerid][1], false);

    CharTD_BUTTON[playerid][2] = CreatePlayerTextDraw(playerid, 177.499969, 352.349975, "JOGAR");
    PlayerTextDrawLetterSize(playerid, CharTD_BUTTON[playerid][2], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, CharTD_BUTTON[playerid][2], TEXT_DRAW_ALIGN:2);
    PlayerTextDrawColour(playerid, CharTD_BUTTON[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_BUTTON[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_BUTTON[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_BUTTON[playerid][2], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, CharTD_BUTTON[playerid][2], true);
    return true;
}

CreateCharacterTextdraws1(playerid){
    CharTD_1[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 75.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_1[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_1[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_1[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_1[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_1[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_1[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_1[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_1[playerid][0], true);

    CharTD_1[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 78.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_1[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_1[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_1[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_1[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_1[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_1[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_1[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_1[playerid][1], true);

    CharTD_1[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 88.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_1[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_1[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_1[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_1[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_1[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_1[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_1[playerid][2], true);

    CharTD_1[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 80.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_1[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_1[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_1[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_1[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_1[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_1[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_1[playerid][3], false);

    CharTD_1[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 83.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_1[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_1[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_1[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_1[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_1[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_1[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_1[playerid][4], false);
    return true;
}

CreateCharacterTextdraws2(playerid){
    CharTD_2[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 105.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_2[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_2[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_2[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_2[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_2[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_2[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_2[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_2[playerid][0], true);

    CharTD_2[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 108.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_2[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_2[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_2[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_2[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_2[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_2[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_2[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_2[playerid][1], true);

    CharTD_2[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 118.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_2[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_2[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_2[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_2[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_2[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_2[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_2[playerid][2], true);

    CharTD_2[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 110.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_2[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_2[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_2[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_2[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_2[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_2[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_2[playerid][3], false);

    CharTD_2[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 113.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_2[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_2[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_2[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_2[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_2[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_2[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_2[playerid][4], false);
    return true;
}

CreateCharacterTextdraws3(playerid){
    CharTD_3[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 135.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_3[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_3[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_3[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_3[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_3[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_3[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_3[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_3[playerid][0], true);

    CharTD_3[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 138.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_3[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_3[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_3[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_3[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_3[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_3[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_3[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_3[playerid][1], true);

    CharTD_3[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 148.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_3[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_3[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_3[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_3[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_3[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_3[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_3[playerid][2], true);

    CharTD_3[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 140.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_3[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_3[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_3[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_3[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_3[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_3[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_3[playerid][3], false);

    CharTD_3[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 143.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_3[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_3[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_3[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_3[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_3[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_3[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_3[playerid][4], false);
    return true;
}

CreateCharacterTextdraws4(playerid){
    CharTD_4[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 165.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_4[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_4[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_4[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_4[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_4[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_4[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_4[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_4[playerid][0], true);

    CharTD_4[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 168.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_4[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_4[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_4[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_4[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_4[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_4[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_4[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_4[playerid][1], true);

    CharTD_4[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 178.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_4[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_4[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_4[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_4[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_4[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_4[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_4[playerid][2], true);

    CharTD_4[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 170.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_4[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_4[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_4[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_4[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_4[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_4[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_4[playerid][3], false);

    CharTD_4[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 173.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_4[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_4[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_4[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_4[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_4[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_4[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_4[playerid][4], false);
    return true;
}

CreateCharacterTextdraws5(playerid){
    CharTD_5[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 195.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_5[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_5[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_5[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_5[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_5[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_5[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_5[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_5[playerid][0], true);

    CharTD_5[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 198.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_5[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_5[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_5[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_5[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_5[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_5[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_5[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_5[playerid][1], true);

    CharTD_5[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 208.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_5[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_5[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_5[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_5[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_5[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_5[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_5[playerid][2], true);

    CharTD_5[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 200.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_5[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_5[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_5[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_5[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_5[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_5[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_5[playerid][3], false);

    CharTD_5[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 203.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_5[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_5[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_5[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_5[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_5[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_5[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_5[playerid][4], false);
    return true;
}

CreateCharacterTextdraws6(playerid){
    CharTD_6[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 225.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_6[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_6[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_6[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_6[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_6[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_6[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_6[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_6[playerid][0], true);

    CharTD_6[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 228.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_6[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_6[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_6[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_6[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_6[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_6[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_6[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_6[playerid][1], true);

    CharTD_6[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 238.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_6[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_6[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_6[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_6[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_6[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_6[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_6[playerid][2], true);

    CharTD_6[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 230.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_6[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_6[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_6[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_6[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_6[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_6[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_6[playerid][3], false);

    CharTD_6[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 233.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_6[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_6[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_6[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_6[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_6[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_6[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_6[playerid][4], false);
    return true;
}

CreateCharacterTextdraws7(playerid){
    CharTD_7[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 285.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_7[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_7[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_7[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_7[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_7[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_7[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_7[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_7[playerid][0], true);

    CharTD_7[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 288.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_7[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_7[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_7[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_7[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_7[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_7[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_7[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_7[playerid][1], true);

    CharTD_7[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 298.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_7[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_7[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_7[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_7[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_7[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_7[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_7[playerid][2], true);

    CharTD_7[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 290.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_7[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_7[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_7[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_7[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_7[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_7[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_7[playerid][3], false);

    CharTD_7[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 293.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_7[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_7[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_7[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_7[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_7[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_7[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_7[playerid][4], false);
    return true;
}

CreateCharacterTextdraws8(playerid){
    CharTD_8[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 315.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_8[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_8[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_8[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_8[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_8[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_8[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_8[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_8[playerid][0], true);

    CharTD_8[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 318.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_8[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_8[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_8[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_8[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_8[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_8[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_8[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_8[playerid][1], true);

    CharTD_8[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 328.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_8[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_8[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_8[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_8[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_8[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_8[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_8[playerid][2], true);

    CharTD_8[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 320.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_8[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_8[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_8[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_8[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_8[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_8[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_8[playerid][3], false);

    CharTD_8[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 323.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_8[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_8[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_8[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_8[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_8[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_8[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_8[playerid][4], false);
    return true;
}

CreateCharacterTextdraws9(playerid){
    CharTD_9[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 345.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_9[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_9[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_9[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_9[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_9[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_9[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_9[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_9[playerid][0], true);

    CharTD_9[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 348.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_9[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_9[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_9[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_9[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_9[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_9[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_9[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_9[playerid][1], true);

    CharTD_9[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 358.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_9[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_9[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_9[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_9[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_9[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_9[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_9[playerid][2], true);

    CharTD_9[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 350.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_9[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_9[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_9[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_9[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_9[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_9[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_9[playerid][3], false);

    CharTD_9[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 353.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_9[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_9[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_9[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_9[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_9[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_9[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_9[playerid][4], false);
    return true;
}

CreateCharacterTextdraws10(playerid){
    CharTD_10[playerid][0] = CreatePlayerTextDraw(playerid, 488.529418, 305.083351, "mdl-9000:bg_select_character");
    PlayerTextDrawTextSize(playerid, CharTD_10[playerid][0], 105.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, CharTD_10[playerid][0], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_10[playerid][0], 50529124);
    PlayerTextDrawSetShadow(playerid, CharTD_10[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_10[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharTD_10[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_10[playerid][0], false);
    PlayerTextDrawSetSelectable(playerid, CharTD_10[playerid][0], true);

    CharTD_10[playerid][1] = CreatePlayerTextDraw(playerid, 491.882537, 308.000022, "John_Doe");
    PlayerTextDrawLetterSize(playerid, CharTD_10[playerid][1], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, CharTD_10[playerid][1], 277.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, CharTD_10[playerid][1], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_10[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_10[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_10[playerid][1], 255);
    PlayerTextDrawFont(playerid, CharTD_10[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_10[playerid][1], true);

    CharTD_10[playerid][2] = CreatePlayerTextDraw(playerid, 491.711791, 318.833305, "#1");
    PlayerTextDrawLetterSize(playerid, CharTD_10[playerid][2], 0.200000, 0.800000);
    PlayerTextDrawAlignment(playerid, CharTD_10[playerid][2], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_10[playerid][2], -1061109505);
    PlayerTextDrawSetShadow(playerid, CharTD_10[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_10[playerid][2], 255);
    PlayerTextDrawFont(playerid, CharTD_10[playerid][2], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, CharTD_10[playerid][2], true);

    CharTD_10[playerid][3] = CreatePlayerTextDraw(playerid, 575.117309, 310.116683, "mdl-9000:circle_character_hover");
    PlayerTextDrawTextSize(playerid, CharTD_10[playerid][3], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, CharTD_10[playerid][3], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_10[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_10[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_10[playerid][3], 255);
    PlayerTextDrawFont(playerid, CharTD_10[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_10[playerid][3], false);

    CharTD_10[playerid][4] = CreatePlayerTextDraw(playerid, 577.416748, 313.216636, "mdl-9000:icon_user");
    PlayerTextDrawTextSize(playerid, CharTD_10[playerid][4], 10.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, CharTD_10[playerid][4], TEXT_DRAW_ALIGN:1);
    PlayerTextDrawColour(playerid, CharTD_10[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, CharTD_10[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, CharTD_10[playerid][4], 255);
    PlayerTextDrawFont(playerid, CharTD_10[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, CharTD_10[playerid][4], false);
    return true;
}

ShowCharactersTD(playerid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d'", uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    if(!cache_num_rows()){
        SendServerMessage(playerid, "Você não possui nenhum personagem em sua conta. Se acha que isso é um erro, reporte a um desenvolvedor.");
        SendServerMessage(playerid, "Você será kickado do servidor agora.");
        Kick(playerid);
        return false;
    }
    
    new characterName[24], string[128],
        characterID, count = 0;

    ClearPlayerChat(playerid);
    SetPlayerInterface(playerid, 999);
    SetPlayerVirtualWorld(playerid, playerid+1000);
    TogglePlayerSpectating(playerid, true);
    ShowCharacterTextdraws(playerid, 1);
    SelectTextDraw(playerid, 0x5964F4FF);
    pInfo[playerid][pChoosingCharacter] = 1;

    SetPlayerVirtualWorld(playerid, playerid+1000);
    SetPlayerInterior(playerid, 0);
    InterpolateCameraPos(playerid, 398.892791, -2044.198242, 9.665472, 398.892791, -2044.198242, 9.665472, 1000);
    InterpolateCameraLookAt(playerid, 396.500122, -2040.112792, 11.273117, 396.500122, -2040.112792, 11.273117, 1000);

    for(new i; i < cache_num_rows(); i++) {
        count ++;
        cache_get_value_name(i, "name", characterName);
        cache_get_value_name_int(i, "ID", characterID);

        if (count == 1){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_1[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_1[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 2){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_2[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_2[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 3){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_3[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_3[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 4){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_4[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_4[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 5){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_5[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_5[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 6){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_6[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_6[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 7){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_7[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_7[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 8){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_8[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_8[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 9){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_9[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_9[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        } else if (count == 10){
            AdjustTextDrawString(characterName);
            PlayerTextDrawSetString(playerid, CharTD_10[playerid][1], characterName);

            format(string, sizeof(string), "#%d", characterID);
            PlayerTextDrawSetString(playerid, CharTD_10[playerid][2], string);

            ShowCharacterTextdraws(playerid, count);
        }
    }
    return true;
}