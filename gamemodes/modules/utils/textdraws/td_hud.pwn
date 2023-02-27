new Text:TEXTDRAW_FOOD, Text:TEXTDRAW_THIRST, Text:TEXTDRAW_TACKLE, Text:TEXTDRAW_BREATH;

#define FOOD    "mdl-9005:hunger"
#define THIRST  "mdl-9005:thirst"
#define TACKLE    "mdl-9005:tackle"
#define BREATH    "mdl-9005:breath"

CreateHUDTextdraws() {
    TEXTDRAW_FOOD = TextDrawCreate(565.0, 270.0, FOOD);
    TextDrawLetterSize(TEXTDRAW_FOOD, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FOOD, 120.000000, 120.000000);
    TextDrawColour(TEXTDRAW_FOOD, -1);
    TextDrawFont(TEXTDRAW_FOOD, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FOOD, true);
    TextDrawSetOutline(TEXTDRAW_FOOD, 0);
    TextDrawBackgroundColour(TEXTDRAW_FOOD, -1);
    TextDrawSetProportional(TEXTDRAW_FOOD, false);
    TextDrawSetShadow(TEXTDRAW_FOOD, 0);
    TextDrawSetSelectable(TEXTDRAW_FOOD, false);

    TEXTDRAW_THIRST = TextDrawCreate(565.0, 295.0, THIRST);
    TextDrawLetterSize(TEXTDRAW_THIRST, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_THIRST, 120.000000, 120.000000);
    TextDrawColour(TEXTDRAW_THIRST, -1);
    TextDrawFont(TEXTDRAW_THIRST, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_THIRST, true);
    TextDrawSetOutline(TEXTDRAW_THIRST, 0);
    TextDrawBackgroundColour(TEXTDRAW_THIRST, -1);
    TextDrawSetProportional(TEXTDRAW_THIRST, false);
    TextDrawSetShadow(TEXTDRAW_THIRST, 0);
    TextDrawSetSelectable(TEXTDRAW_THIRST, false);

    TEXTDRAW_BREATH = TextDrawCreate(565.0, 273.0+50.0, BREATH);
    TextDrawLetterSize(TEXTDRAW_BREATH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_BREATH, 120.000000, 120.000000);
    TextDrawColour(TEXTDRAW_BREATH, -1);
    TextDrawFont(TEXTDRAW_BREATH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_BREATH, true);
    TextDrawSetOutline(TEXTDRAW_BREATH, 0);
    TextDrawBackgroundColour(TEXTDRAW_BREATH, -1);
    TextDrawSetProportional(TEXTDRAW_BREATH, false);
    TextDrawSetShadow(TEXTDRAW_BREATH, 0);
    TextDrawSetSelectable(TEXTDRAW_BREATH, false);
}

ClosePlayerHUD(playerid) {
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][3]);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FOOD);
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][4]);
    TextDrawHideForPlayer(playerid, TEXTDRAW_THIRST);
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][5]);
    TextDrawHideForPlayer(playerid, TEXTDRAW_BREATH);
    return true;
}

HungerThristHUD(playerid) {
    if(pInfo[playerid][pHudStyle] == 0) {
        new string[128];
        // FOME
        format(string, sizeof(string), "%d", pInfo[playerid][pHunger]);
        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][3]);
        PlayerTextDrawSetString(playerid, pInfo[playerid][pTextdraws][3], string);
        TextDrawShowForPlayer(playerid, TEXTDRAW_FOOD);
        // SEDE
        format(string, sizeof(string), "%d", pInfo[playerid][pThirst]);
        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][4]);
        PlayerTextDrawSetString(playerid, pInfo[playerid][pTextdraws][4], string);
        TextDrawShowForPlayer(playerid, TEXTDRAW_THIRST);
        // ESTAMINA
        new stamina = (GetPlayerStamina(playerid) * 100) / GetPlayerMaxStamina(playerid);
        format(string, sizeof(string), "%d%%", stamina);
        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][5]);
        PlayerTextDrawSetString(playerid, pInfo[playerid][pTextdraws][5], string);
        TextDrawShowForPlayer(playerid, TEXTDRAW_BREATH);
        // TACKLE
        /*if(pInfo[playerid][pTackleMode]) {
            
        }*/
    } else ClosePlayerHUD(playerid);

    return true;
}

forward HUDCheck();
public HUDCheck() {	
    foreach (new i : Player) {
        if(pInfo[i][pLogged]) HungerThristHUD(i);
        else ClosePlayerHUD(i);
    }
}