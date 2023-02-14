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

#define VELOCIMETER_0 "mdl-5002:velocimeter-0mph"
#define VELOCIMETER_10 "mdl-5002:velocimeter-10mph"
#define VELOCIMETER_20 "mdl-5002:velocimeter-20mph"
#define VELOCIMETER_30 "mdl-5002:velocimeter-30mph"
#define VELOCIMETER_40 "mdl-5002:velocimeter-40mph"
#define VELOCIMETER_50 "mdl-5002:velocimeter-50mph"
#define VELOCIMETER_60 "mdl-5002:velocimeter-60mph"
#define VELOCIMETER_70 "mdl-5002:velocimeter-70mph"
#define VELOCIMETER_80 "mdl-5002:velocimeter-80mph"
#define VELOCIMETER_90 "mdl-5002:velocimeter-90mph"
#define VELOCIMETER_100 "mdl-5002:velocimeter-100mph"
#define VELOCIMETER_110 "mdl-5002:velocimeter-110mph"
#define VELOCIMETER_120 "mdl-5002:velocimeter-120mph"

#define FUEL_0 "mdl-5002:fuel-0"
#define FUEL_1 "mdl-5002:fuel-1"
#define FUEL_2 "mdl-5002:fuel-2"
#define FUEL_3 "mdl-5002:fuel-3"
#define FUEL_4 "mdl-5002:fuel-4"
#define FUEL_5 "mdl-5002:fuel-5"
#define FUEL_6 "mdl-5002:fuel-6"
#define FUEL_7 "mdl-5002:fuel-7"
#define FUEL_8 "mdl-5002:fuel-8"
#define FUEL_9 "mdl-5002:fuel-9"
#define FUEL_10 "mdl-5002:fuel-10"

#define NOS_0 "mdl-5002:nos-0"
#define NOS_1 "mdl-5002:nos-1"
#define NOS_2 "mdl-5002:nos-2"
#define NOS_3 "mdl-5002:nos-3"
#define NOS_4 "mdl-5002:nos-4"
#define NOS_5 "mdl-5002:nos-5"
#define NOS_6 "mdl-5002:nos-6"
#define NOS_7 "mdl-5002:nos-7"
#define NOS_8 "mdl-5002:nos-8"

#define LIGHT_ICON "mdl-5002:lights"
#define ENGINE_ICON "mdl-5002:engine"
#define BATTERY_ICON "mdl-5002:battery"
#define LOCKED_ICON "mdl-5002:locked"
#define UNLOCKED_ICON "mdl-5002:unlocked"

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
    // ========================= Combust�vel ========================= 
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

    // =========================== �cones ============================

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
