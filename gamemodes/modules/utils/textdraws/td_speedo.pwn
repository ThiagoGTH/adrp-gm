#include <YSI_Coding\y_hooks>

new Text:TEXTDRAW_VELOCIMETER_1_0_MPH, Text:TEXTDRAW_VELOCIMETER_1_10_MPH, Text:TEXTDRAW_VELOCIMETER_1_20_MPH, Text:TEXTDRAW_VELOCIMETER_1_30_MPH, Text:TEXTDRAW_VELOCIMETER_1_40_MPH;
new Text:TEXTDRAW_VELOCIMETER_1_50_MPH, Text:TEXTDRAW_VELOCIMETER_1_60_MPH, Text:TEXTDRAW_VELOCIMETER_1_70_MPH, Text:TEXTDRAW_VELOCIMETER_1_80_MPH, Text:TEXTDRAW_VELOCIMETER_1_90_MPH;
new Text:TEXTDRAW_VELOCIMETER_1_100_MPH, Text:TEXTDRAW_VELOCIMETER_1_110_MPH, Text:TEXTDRAW_VELOCIMETER_1_120_MPH;

new Text:TEXTDRAW_FUEL_0, Text:TEXTDRAW_FUEL_1, Text:TEXTDRAW_FUEL_2, Text:TEXTDRAW_FUEL_3, Text:TEXTDRAW_FUEL_4, Text:TEXTDRAW_FUEL_5;
new Text:TEXTDRAW_FUEL_6, Text:TEXTDRAW_FUEL_7, Text:TEXTDRAW_FUEL_8, Text:TEXTDRAW_FUEL_9, Text:TEXTDRAW_FUEL_10;

new Text:TEXTDRAW_NOS_0, Text:TEXTDRAW_NOS_1, Text:TEXTDRAW_NOS_2, Text:TEXTDRAW_NOS_3, Text:TEXTDRAW_NOS_4, Text:TEXTDRAW_NOS_5;
new Text:TEXTDRAW_NOS_6, Text:TEXTDRAW_NOS_7, Text:TEXTDRAW_NOS_8;

new Text:TEXTDRAW_LIGHT_ICON;
new Text:TEXTDRAW_ENGINE_ICON;
new Text:TEXTDRAW_BATTERY_ICON;
new Text:TEXTDRAW_LOCKED_ICON;
new Text:TEXTDRAW_UNLOCKED_ICON;

#define VELOCIMETER_0 "mdl-9004:velocimeter-0mph"
#define VELOCIMETER_10 "mdl-9004:velocimeter-10mph"
#define VELOCIMETER_20 "mdl-9004:velocimeter-20mph"
#define VELOCIMETER_30 "mdl-9004:velocimeter-30mph"
#define VELOCIMETER_40 "mdl-9004:velocimeter-40mph"
#define VELOCIMETER_50 "mdl-9004:velocimeter-50mph"
#define VELOCIMETER_60 "mdl-9004:velocimeter-60mph"
#define VELOCIMETER_70 "mdl-9004:velocimeter-70mph"
#define VELOCIMETER_80 "mdl-9004:velocimeter-80mph"
#define VELOCIMETER_90 "mdl-9004:velocimeter-90mph"
#define VELOCIMETER_100 "mdl-9004:velocimeter-100mph"
#define VELOCIMETER_110 "mdl-9004:velocimeter-110mph"
#define VELOCIMETER_120 "mdl-9004:velocimeter-120mph"

#define FUEL_0 "mdl-9004:fuel-0"
#define FUEL_1 "mdl-9004:fuel-1"
#define FUEL_2 "mdl-9004:fuel-2"
#define FUEL_3 "mdl-9004:fuel-3"
#define FUEL_4 "mdl-9004:fuel-4"
#define FUEL_5 "mdl-9004:fuel-5"
#define FUEL_6 "mdl-9004:fuel-6"
#define FUEL_7 "mdl-9004:fuel-7"
#define FUEL_8 "mdl-9004:fuel-8"
#define FUEL_9 "mdl-9004:fuel-9"
#define FUEL_10 "mdl-9004:fuel-10"

#define NOS_0 "mdl-9004:nos-0"
#define NOS_1 "mdl-9004:nos-1"
#define NOS_2 "mdl-9004:nos-2"
#define NOS_3 "mdl-9004:nos-3"
#define NOS_4 "mdl-9004:nos-4"
#define NOS_5 "mdl-9004:nos-5"
#define NOS_6 "mdl-9004:nos-6"
#define NOS_7 "mdl-9004:nos-7"
#define NOS_8 "mdl-9004:nos-8"

#define LIGHT_ICON "mdl-9004:lights"
#define ENGINE_ICON "mdl-9004:engine"
#define BATTERY_ICON "mdl-9004:battery"
#define LOCKED_ICON "mdl-9004:locked"
#define UNLOCKED_ICON "mdl-9004:unlocked"

CreateSpeedometerTextdraws() {
    TEXTDRAW_VELOCIMETER_1_0_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_0);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_0_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_0_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_0_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_0_MPH , true);

    TEXTDRAW_VELOCIMETER_1_10_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_10);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_10_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_10_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_10_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_10_MPH , true);

    TEXTDRAW_VELOCIMETER_1_20_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_20);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_20_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_20_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_20_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_20_MPH , true);

    TEXTDRAW_VELOCIMETER_1_30_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_30);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_30_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_30_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_30_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_30_MPH , true);

    TEXTDRAW_VELOCIMETER_1_40_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_40);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_40_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_40_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_40_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_40_MPH , true);

    TEXTDRAW_VELOCIMETER_1_50_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_50);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_50_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_50_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_50_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_50_MPH , true);

    TEXTDRAW_VELOCIMETER_1_60_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_60);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_60_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_60_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_60_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_60_MPH , true);

    TEXTDRAW_VELOCIMETER_1_70_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_70);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_70_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_70_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_70_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_70_MPH , true);

    TEXTDRAW_VELOCIMETER_1_80_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_80);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_80_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_80_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_80_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_80_MPH , true);

    TEXTDRAW_VELOCIMETER_1_90_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_90);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_90_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_90_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_90_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_90_MPH , true);

    TEXTDRAW_VELOCIMETER_1_100_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_100);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_100_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_100_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_100_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_100_MPH , true);

    TEXTDRAW_VELOCIMETER_1_110_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_110);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_110_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_110_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_110_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_110_MPH , true);

    TEXTDRAW_VELOCIMETER_1_120_MPH = TextDrawCreate(555.5, 368.5, VELOCIMETER_120);
    TextDrawLetterSize(TEXTDRAW_VELOCIMETER_1_120_MPH, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_VELOCIMETER_1_120_MPH, 80.000000, 80.000000);
    TextDrawFont(TEXTDRAW_VELOCIMETER_1_120_MPH, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_VELOCIMETER_1_120_MPH , true);
    // ===============================================================
    // ========================= Combustível ========================= 
    TEXTDRAW_FUEL_0 = TextDrawCreate(564.5, 315.5, FUEL_0);
    TextDrawLetterSize(TEXTDRAW_FUEL_0, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_0, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_0, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_0 , true);

    TEXTDRAW_FUEL_1 = TextDrawCreate(564.5, 315.5, FUEL_1);
    TextDrawLetterSize(TEXTDRAW_FUEL_1, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_1, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_1, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_1 , true);

    TEXTDRAW_FUEL_2 = TextDrawCreate(564.5, 315.5, FUEL_2);
    TextDrawLetterSize(TEXTDRAW_FUEL_2, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_2, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_2, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_2 , true);

    TEXTDRAW_FUEL_3 = TextDrawCreate(564.5, 315.5, FUEL_3);
    TextDrawLetterSize(TEXTDRAW_FUEL_3, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_3, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_3, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_3 , true);

    TEXTDRAW_FUEL_4 = TextDrawCreate(564.5, 315.5, FUEL_4);
    TextDrawLetterSize(TEXTDRAW_FUEL_4, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_4, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_4, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_4 , true);

    TEXTDRAW_FUEL_5 = TextDrawCreate(564.5, 315.5, FUEL_5);
    TextDrawLetterSize(TEXTDRAW_FUEL_5, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_5, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_5, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_5 , true);

    TEXTDRAW_FUEL_6 = TextDrawCreate(564.5, 315.5, FUEL_6);
    TextDrawLetterSize(TEXTDRAW_FUEL_6, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_6, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_6, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_6 , true);

    TEXTDRAW_FUEL_7 = TextDrawCreate(564.5, 315.5, FUEL_7);
    TextDrawLetterSize(TEXTDRAW_FUEL_7, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_7, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_7, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_7 , true);

    TEXTDRAW_FUEL_8 = TextDrawCreate(564.5, 315.5, FUEL_8);
    TextDrawLetterSize(TEXTDRAW_FUEL_8, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_8, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_8, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_8 , true);

    TEXTDRAW_FUEL_9 = TextDrawCreate(564.5, 315.5, FUEL_9);
    TextDrawLetterSize(TEXTDRAW_FUEL_9, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_9, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_9, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_9 , true);

    TEXTDRAW_FUEL_10 = TextDrawCreate(564.5, 315.5, FUEL_10);
    TextDrawLetterSize(TEXTDRAW_FUEL_10, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_FUEL_10, 115.000000, 115.000000);
    TextDrawFont(TEXTDRAW_FUEL_10, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_FUEL_10 , true);

    // ===============================================================
    // ========================= Nitro (NOS) =========================

    TEXTDRAW_NOS_0 = TextDrawCreate(543.0, 368.5, NOS_0);
    TextDrawLetterSize(TEXTDRAW_NOS_0, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_0, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_0, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_0, true);

    TEXTDRAW_NOS_1 = TextDrawCreate(543.0, 368.5, NOS_1);
    TextDrawLetterSize(TEXTDRAW_NOS_1, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_1, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_1, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_1, true);

    TEXTDRAW_NOS_2 = TextDrawCreate(543.0, 368.5, NOS_2);
    TextDrawLetterSize(TEXTDRAW_NOS_2, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_2, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_2, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_2, true);

    TEXTDRAW_NOS_3 = TextDrawCreate(543.0, 368.5, NOS_3);
    TextDrawLetterSize(TEXTDRAW_NOS_3, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_3, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_3, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_3, true);

    TEXTDRAW_NOS_4 = TextDrawCreate(543.0, 368.5, NOS_4);
    TextDrawLetterSize(TEXTDRAW_NOS_4, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_4, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_4, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_4, true);

    TEXTDRAW_NOS_5 = TextDrawCreate(543.0, 368.5, NOS_5);
    TextDrawLetterSize(TEXTDRAW_NOS_5, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_5, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_5, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_5, true);

    TEXTDRAW_NOS_6 = TextDrawCreate(543.0, 368.5, NOS_6);
    TextDrawLetterSize(TEXTDRAW_NOS_6, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_6, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_6, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_6, true);

    TEXTDRAW_NOS_7 = TextDrawCreate(543.0, 368.5, NOS_7);
    TextDrawLetterSize(TEXTDRAW_NOS_7, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_7, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_7, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_7, true);

    TEXTDRAW_NOS_8 = TextDrawCreate(543.0, 368.5, NOS_8);
    TextDrawLetterSize(TEXTDRAW_NOS_8, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_NOS_8, 70.000000, 78.000000);
    TextDrawFont(TEXTDRAW_NOS_8, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_NOS_8, true);

    // ===============================================================

    // =========================== Ícones ============================

    TEXTDRAW_LOCKED_ICON = TextDrawCreate(535.0-15.0, 426.5, LOCKED_ICON);
    TextDrawLetterSize(TEXTDRAW_LOCKED_ICON, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_LOCKED_ICON, 64.000000, 64.000000);
    TextDrawFont(TEXTDRAW_LOCKED_ICON, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_LOCKED_ICON , true);

    TEXTDRAW_UNLOCKED_ICON = TextDrawCreate(535.0-15.0, 426.5, UNLOCKED_ICON);
    TextDrawLetterSize(TEXTDRAW_UNLOCKED_ICON, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_UNLOCKED_ICON, 64.000000, 64.000000);
    TextDrawFont(TEXTDRAW_UNLOCKED_ICON, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_UNLOCKED_ICON , true);

    TEXTDRAW_LIGHT_ICON = TextDrawCreate(530.0-15.0, 405.5, LIGHT_ICON);
    TextDrawLetterSize(TEXTDRAW_LIGHT_ICON, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_LIGHT_ICON, 64.000000, 64.000000);
    TextDrawFont(TEXTDRAW_LIGHT_ICON, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_LIGHT_ICON , true);

    TEXTDRAW_BATTERY_ICON = TextDrawCreate(532.5-15.0, 385.5, BATTERY_ICON);
    TextDrawLetterSize(TEXTDRAW_BATTERY_ICON, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_BATTERY_ICON, 64.000000, 64.000000);
    TextDrawFont(TEXTDRAW_BATTERY_ICON, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_BATTERY_ICON , true);

    TEXTDRAW_ENGINE_ICON = TextDrawCreate(544.5-15.0, 368.0, ENGINE_ICON);
    TextDrawLetterSize(TEXTDRAW_ENGINE_ICON, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_ENGINE_ICON, 64.000000, 64.000000);
    TextDrawFont(TEXTDRAW_ENGINE_ICON, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawUseBox(TEXTDRAW_ENGINE_ICON , true);
    return true;
}

DestroySpeedoTextdraws() {
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_0_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_10_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_20_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_30_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_40_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_50_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_60_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_70_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_80_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_90_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_100_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_110_MPH);
    TextDrawDestroy(TEXTDRAW_VELOCIMETER_1_120_MPH);

    TextDrawDestroy(TEXTDRAW_FUEL_0);
    TextDrawDestroy(TEXTDRAW_FUEL_1);
    TextDrawDestroy(TEXTDRAW_FUEL_2);
    TextDrawDestroy(TEXTDRAW_FUEL_3);
    TextDrawDestroy(TEXTDRAW_FUEL_4);
    TextDrawDestroy(TEXTDRAW_FUEL_5);
    TextDrawDestroy(TEXTDRAW_FUEL_6);
    TextDrawDestroy(TEXTDRAW_FUEL_7);
    TextDrawDestroy(TEXTDRAW_FUEL_8);
    TextDrawDestroy(TEXTDRAW_FUEL_9);
    TextDrawDestroy(TEXTDRAW_FUEL_10);

    TextDrawDestroy(TEXTDRAW_NOS_0);
    TextDrawDestroy(TEXTDRAW_NOS_1);
    TextDrawDestroy(TEXTDRAW_NOS_2);
    TextDrawDestroy(TEXTDRAW_NOS_3);
    TextDrawDestroy(TEXTDRAW_NOS_4);
    TextDrawDestroy(TEXTDRAW_NOS_5);
    TextDrawDestroy(TEXTDRAW_NOS_6);
    TextDrawDestroy(TEXTDRAW_NOS_7);
    TextDrawDestroy(TEXTDRAW_NOS_8);

    TextDrawDestroy(TEXTDRAW_LIGHT_ICON);
    TextDrawDestroy(TEXTDRAW_ENGINE_ICON);
    TextDrawDestroy(TEXTDRAW_BATTERY_ICON);
    TextDrawDestroy(TEXTDRAW_LOCKED_ICON);
    return true;
}

ClosePlayerSpeedo(playerid) {
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_0_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_10_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_20_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_30_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_40_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_50_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_60_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_70_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_80_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_90_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_100_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_110_MPH);
    TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_120_MPH);

    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_0);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_1);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_2);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_3);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_4);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_5);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_6);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_7);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_8);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_9);
    TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_10);

    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_0);
    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_1);
    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_2);
    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_3);
    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_4);
    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_5);
    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_6);
    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_7);
    TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_8);

    TextDrawHideForPlayer(playerid, TEXTDRAW_BATTERY_ICON);
    TextDrawHideForPlayer(playerid, TEXTDRAW_ENGINE_ICON);
    TextDrawHideForPlayer(playerid, TEXTDRAW_LIGHT_ICON);
    TextDrawHideForPlayer(playerid, TEXTDRAW_UNLOCKED_ICON);
    TextDrawHideForPlayer(playerid, TEXTDRAW_LOCKED_ICON);

    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][0]);
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][1]);
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][2]);
    return true;
}

UpdatePlayerSpeedo(playerid) {
    if (pInfo[playerid][pWatching]) return ClosePlayerSpeedo(playerid);

    if (pInfo[playerid][pHudSpeedo] == 1) {
        new 
            vehicleid = GetPlayerVehicleID(playerid),
            carid = VehicleGetID(vehicleid),
            model = GetVehicleModel(vehicleid),
            str[128];

        static
            Float:fSpeed;

        fSpeed = GetVehicleSpeed(vehicleid);
        new toconvert = floatround(fSpeed);
        new Float:mph = toconvert*0.6;
        
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_0_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_10_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_20_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_30_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_40_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_50_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_60_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_70_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_80_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_90_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_100_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_110_MPH);
        TextDrawHideForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_120_MPH);

        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][2]); // Velocimetro digital
        format(str, sizeof(str), "%0.0f~n~mph", mph); // Velocimetro digital
        PlayerTextDrawSetString(playerid, pInfo[playerid][pTextdraws][2], str);

        if(mph == 0.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_0_MPH);
        else if(mph > 0.0 && mph < 11.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_10_MPH);
        else if(mph > 10.0 && mph < 21.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_20_MPH);
        else if(mph > 20.0 && mph < 31.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_30_MPH);
        else if(mph > 30.0 && mph < 41.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_40_MPH);
        else if(mph > 40.0 && mph < 51.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_50_MPH);
        else if(mph > 50.0 && mph < 61.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_60_MPH);
        else if(mph > 60.0 && mph < 71.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_70_MPH);
        else if(mph > 70.0 && mph < 81.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_80_MPH);
        else if(mph > 80.0 && mph < 91.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_90_MPH);
        else if(mph > 90.0 && mph < 101.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_100_MPH);
        else if(mph > 100.0 && mph < 111.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_110_MPH);
        else if(mph > 110.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_VELOCIMETER_1_120_MPH);
        
        if(vInfo[carid][vFuel] < 0)
            vInfo[carid][vFuel] = 0;

        new Float:fuel = vInfo[carid][vFuel];
        new Float:maxfuel = 0.0;

        GetVehicleMaxFuel(model, maxfuel);

        new Float:divider = maxfuel/10;

        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_0);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_1);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_2);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_3);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_4);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_5);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_6);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_7);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_8);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_9);
        TextDrawHideForPlayer(playerid, TEXTDRAW_FUEL_10);

        if(fuel <= 1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_0);
        else if(fuel > 1.0 && fuel < divider+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_1);
        else if(fuel > divider && fuel < (divider*2)+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_2);
        else if(fuel > (divider*2) && fuel < (divider*3)+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_3);
        else if(fuel > (divider*3) && fuel < (divider*4)+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_4);
        else if(fuel > (divider*4) && fuel < (divider*5)+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_5);
        else if(fuel > (divider*5) && fuel < (divider*6)+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_6);
        else if(fuel > (divider*6) && fuel < (divider*7)+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_7);
        else if(fuel > (divider*7) && fuel < (divider*8)+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_8);
        else if(fuel > (divider*8) && fuel < (divider*9)+1.0)
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_9);
        else if(fuel > (divider*9))
            TextDrawShowForPlayer(playerid, TEXTDRAW_FUEL_10);

        if(carid != -1)
        {
            if(vInfo[carid][vBattery] < 5.01)
                TextDrawShowForPlayer(playerid, TEXTDRAW_BATTERY_ICON);
            else
                TextDrawHideForPlayer(playerid, TEXTDRAW_BATTERY_ICON);

            if(vInfo[carid][vEngine] < 5.01)
                TextDrawShowForPlayer(playerid, TEXTDRAW_ENGINE_ICON);
            else
                TextDrawHideForPlayer(playerid, TEXTDRAW_ENGINE_ICON);

            if(vInfo[carid][vLocked])  {
                TextDrawHideForPlayer(playerid, TEXTDRAW_UNLOCKED_ICON);
                TextDrawShowForPlayer(playerid, TEXTDRAW_LOCKED_ICON);
            } else {
                TextDrawShowForPlayer(playerid, TEXTDRAW_UNLOCKED_ICON);
                TextDrawHideForPlayer(playerid, TEXTDRAW_LOCKED_ICON);
            }
        }
   
        if(GetLightStatus(vehicleid))
            TextDrawShowForPlayer(playerid, TEXTDRAW_LIGHT_ICON);
        else
            TextDrawHideForPlayer(playerid, TEXTDRAW_LIGHT_ICON);

        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_0);
        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_1);
        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_2);
        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_3);
        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_4);
        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_5);
        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_6);
        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_7);
        TextDrawHideForPlayer(playerid, TEXTDRAW_NOS_8);

        /*if(carid != -1) {
            if(CarData[carid][carNOSInstalled])
            {
                if(CarData[carid][carNOS] == 0)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_0);
                else if(CarData[carid][carNOS] == 1)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_1);
                else if(CarData[carid][carNOS] == 2)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_2);
                else if(CarData[carid][carNOS] == 3)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_3);
                else if(CarData[carid][carNOS] == 4)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_4);
                else if(CarData[carid][carNOS] == 5)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_5);
                else if(CarData[carid][carNOS] == 6)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_6);
                else if(CarData[carid][carNOS] == 7)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_7);
                else if(CarData[carid][carNOS] == 8)
                    TextDrawShowForPlayer(playerid, TEXTDRAW_NOS_8);
            } 
        }*/             
    } else if (pInfo[playerid][pHudSpeedo] == 2) {
        new 
            vehicleid = GetPlayerVehicleID(playerid),
            carid = VehicleGetID(vehicleid),
            str[128];

        static
            Float:fSpeed;

        fSpeed = GetVehicleSpeed(vehicleid);
        new toconvert = floatround(fSpeed);
        new Float:mph = toconvert*0.6;

        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][0]);
        format(str, sizeof(str), "~h~~g~%0.0f ~b~MPH", mph);
        PlayerTextDrawSetString(playerid, pInfo[playerid][pTextdraws][0], str);

        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][1]);
        if(vInfo[carid][vFuel] > 5.0) {
            format(str, sizeof(str), "~h~~g~%.0f ~b~%%", vInfo[carid][vFuel]);
            PlayerTextDrawSetString(playerid, pInfo[playerid][pTextdraws][1], str);
        } else {
            format(str, sizeof(str), "~h~~r~%.0f ~b~%%", vInfo[carid][vFuel]);
            PlayerTextDrawSetString(playerid, pInfo[playerid][pTextdraws][1], str);
        }
    } else ClosePlayerSpeedo(playerid);
    return true;
}

forward SpeedoCheck();
public SpeedoCheck() {	
    foreach (new i : Player) {
        if (GetPlayerState(i) == PLAYER_STATE_DRIVER) {
            new vehicleid = GetPlayerVehicleID(i);
			new model = GetVehicleModel(vehicleid);
		    if(model == 481 || model == 509 || model == 510) {
                if(!GetEngineStatus(vehicleid)) SetEngineStatus(vehicleid, true);

		    }
            if (IsSpeedoVehicle(vehicleid)) UpdatePlayerSpeedo(i);
        } else ClosePlayerSpeedo(i);
    }
}

IsSpeedoVehicle(vehicleid) {
	if (GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 481 || !IsEngineVehicle(vehicleid)) {
	    return false;
	}
	return true;
}

GetVehicleSpeed(vehicleid) {
    new Float:xPos[3];
    GetVehicleVelocity(vehicleid, xPos[0], xPos[1], xPos[2]);
    return floatround(floatsqroot(xPos[0] * xPos[0] + xPos[1] * xPos[1] + xPos[2] * xPos[2]) * 170.00);
}

hook OnPlayerExitVehicle(playerid, vehicleid) {
	if(IsPlayerNPC(playerid)) return true;		

	ClosePlayerSpeedo(playerid);
	return true;
}