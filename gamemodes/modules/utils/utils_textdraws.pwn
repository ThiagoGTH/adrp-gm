#include <YSI_Coding\y_hooks>

new PlayerText:LoginTD[MAX_PLAYERS][23];

// Função para mostrar os textdraws de login
forward ShowLoginTextdraws(playerid);
public ShowLoginTextdraws(playerid) {

  for(new i; i < 23; i++)
    PlayerTextDrawShow(playerid, LoginTD[playerid][i]);

  SelectTextDraw(playerid, 0x9c9e9cFF);

  InterpolateCameraPos(playerid, 1307.082153, -1441.499755, 221.137145, 1764.986206, -1501.460083, 238.376602, 12000);
  InterpolateCameraLookAt(playerid, 1311.717285, -1439.645874, 220.856262, 1761.035888, -1498.431884, 237.901809, 12000);

  return 1;
}

// Função responsável por esconder os textdraws de login
HideLoginTextdraws(playerid) {

  for(new i; i < 23; i++)
    PlayerTextDrawHide(playerid, LoginTD[playerid][i]);

  return 1;
}

CreateLoginTextdraws(playerid){
    LoginTD[playerid][0] = CreatePlayerTextDraw(playerid, 1.000000, 1.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][0], 0.600000, 50.250000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][0], 639.500000, 97.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][0], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][0], 114);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][0], 0);

    LoginTD[playerid][1] = CreatePlayerTextDraw(playerid, 25.500000, 70.000000, "S T R E E T    M I N I G A M E S    --    B E T A");
    PlayerTextDrawFont(playerid, LoginTD[playerid][1], 2);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][1], 0.287499, 1.299998);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][1], 625.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][1], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][1], 160);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][1], 0);

    LoginTD[playerid][2] = CreatePlayerTextDraw(playerid, 25.000000, 85.000000, "loadsc5:loadsc5");
    PlayerTextDrawFont(playerid, LoginTD[playerid][2], 4);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][2], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][2], 386.500000, 200.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][2], 0);

    LoginTD[playerid][3] = CreatePlayerTextDraw(playerid, 31.000000, 96.000000, "HUD:radar_light");
    PlayerTextDrawFont(playerid, LoginTD[playerid][3], 4);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][3], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][3], 11.500000, 11.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][3], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][3], 0);

    LoginTD[playerid][4] = CreatePlayerTextDraw(playerid, 26.500000, 86.500000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][4], 1);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][4], 0.662499, 21.849996);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][4], 410.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][4], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][4], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][4], 0);

    LoginTD[playerid][5] = CreatePlayerTextDraw(playerid, 46.500000, 96.500000, "O maior servidor de minigames do Brasil");
    PlayerTextDrawFont(playerid, LoginTD[playerid][5], 2);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][5], 0.195831, 0.899999);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][5], 625.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][5], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][5], -56);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][5], 0);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][5], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][5], 0);

    LoginTD[playerid][6] = CreatePlayerTextDraw(playerid, 83.500000, 297.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][6], 3);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][6], 0.600000, 12.900012);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][6], 166.000000, 114.500000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][6], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][6], 75);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][6], 0);

    LoginTD[playerid][7] = CreatePlayerTextDraw(playerid, 58.500000, 310.000000, "HUD:radar_mafiacasino");
    PlayerTextDrawFont(playerid, LoginTD[playerid][7], 4);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][7], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][7], 47.500000, 49.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][7], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][7], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][7], 0);

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", ReturnName(playerid));
    mysql_query(DBConn, query);

    LoginTD[playerid][8] = CreatePlayerTextDraw(playerid, 83.000000, 377.000000, cache_num_rows() ? "ENTRAR" : "REGISTRAR");
    PlayerTextDrawFont(playerid, LoginTD[playerid][8], 2);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][8], 0.425000, 2.000000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][8], 18.500000, 96.500000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][8], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][8], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][8], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][8], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][8], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][8], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][8], 1);

    LoginTD[playerid][9] = CreatePlayerTextDraw(playerid, 219.500000, 297.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][9], 3);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][9], 0.600000, 12.900012);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][9], 166.000000, 114.500000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][9], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][9], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][9], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][9], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][9], 75);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][9], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][9], 0);

    LoginTD[playerid][10] = CreatePlayerTextDraw(playerid, 200.500000, 313.000000, "HUD:radar_police");
    PlayerTextDrawFont(playerid, LoginTD[playerid][10], 4);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][10], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][10], 38.500000, 40.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][10], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][10], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][10], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][10], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][10], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][10], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][10], 0);

    LoginTD[playerid][11] = CreatePlayerTextDraw(playerid, 220.000000, 377.000000, "DISCORD");
    PlayerTextDrawFont(playerid, LoginTD[playerid][11], 2);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][11], 0.425000, 2.000000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][11], 18.500000, 58.500000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][11], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][11], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][11], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][11], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][11], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][11], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][11], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][11], 1);

    LoginTD[playerid][12] = CreatePlayerTextDraw(playerid, 333.500000, 311.000000, "HUD:radar_girlfriend");
    PlayerTextDrawFont(playerid, LoginTD[playerid][12], 4);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][12], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][12], 38.500000, 40.500000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][12], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][12], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][12], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][12], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][12], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][12], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][12], 0);

    LoginTD[playerid][13] = CreatePlayerTextDraw(playerid, 353.500000, 297.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][13], 3);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][13], 0.600000, 12.900012);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][13], 166.000000, 114.500000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][13], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][13], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][13], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][13], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][13], 75);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][13], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][13], 0);

    LoginTD[playerid][14] = CreatePlayerTextDraw(playerid, 354.000000, 377.000000, "vip");
    PlayerTextDrawFont(playerid, LoginTD[playerid][14], 2);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][14], 0.425000, 2.000000);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][14], 16.500000, 29.500000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][14], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][14], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][14], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][14], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][14], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][14], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][14], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][14], 1);

    LoginTD[playerid][15] = CreatePlayerTextDraw(playerid, 453.500000, 91.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][15], 3);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][15], 0.600000, -0.299988);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][15], 156.000000, 53.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][15], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][15], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][15], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][15], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][15], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][15], -1);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][15], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][15], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][15], 0);

    LoginTD[playerid][16] = CreatePlayerTextDraw(playerid, 525.500000, 83.000000, "N O T I C I A S");
    PlayerTextDrawFont(playerid, LoginTD[playerid][16], 2);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][16], 0.287499, 1.299998);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][16], 625.000000, 202.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][16], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][16], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][16], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][16], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][16], 160);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][16], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][16], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][16], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][16], 0);

    LoginTD[playerid][17] = CreatePlayerTextDraw(playerid, 597.500000, 91.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][17], 3);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][17], 0.600000, -0.299988);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][17], 156.000000, 53.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][17], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][17], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][17], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][17], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][17], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][17], -1);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][17], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][17], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][17], 0);

    LoginTD[playerid][18] = CreatePlayerTextDraw(playerid, 453.500000, 411.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][18], 3);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][18], 0.600000, -0.299988);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][18], 156.000000, 53.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][18], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][18], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][18], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][18], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][18], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][18], -1);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][18], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][18], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][18], 0);

    LoginTD[playerid][19] = CreatePlayerTextDraw(playerid, 525.500000, 403.000000, "N O T I C I A S");
    PlayerTextDrawFont(playerid, LoginTD[playerid][19], 2);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][19], 0.287499, 1.299998);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][19], 625.000000, 202.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][19], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][19], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][19], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][19], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][19], 160);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][19], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][19], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][19], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][19], 0);

    LoginTD[playerid][20] = CreatePlayerTextDraw(playerid, 598.500000, 411.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][20], 3);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][20], 0.600000, -0.299988);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][20], 156.000000, 53.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][20], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][20], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][20], 2);
    PlayerTextDrawColor(playerid, LoginTD[playerid][20], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][20], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][20], -1);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][20], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][20], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][20], 0);

    LoginTD[playerid][21] = CreatePlayerTextDraw(playerid, 430.000000, 100.000000, "_");
    PlayerTextDrawFont(playerid, LoginTD[playerid][21], 1);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][21], 0.600000, 33.300003);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][21], 619.500000, 75.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][21], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][21], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][21], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][21], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][21], 255);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][21], 63);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][21], 1);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][21], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][21], 0);

    LoginTD[playerid][22] = CreatePlayerTextDraw(playerid, 436.500000, 102.000000, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc scelerisque rutrum sodales. Aenean tincidunt lacinia velit a dapibus. Morbi efficitur justo quis quam molestie, vel luctus orci tristique. Ut lobortis viverra auctor.");
    PlayerTextDrawFont(playerid, LoginTD[playerid][22], 2);
    PlayerTextDrawLetterSize(playerid, LoginTD[playerid][22], 0.229, 1.249);
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][22], 615.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, LoginTD[playerid][22], 1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][22], 0);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][22], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][22], -1);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][22], 160);
    PlayerTextDrawBoxColor(playerid, LoginTD[playerid][22], 50);
    PlayerTextDrawUseBox(playerid, LoginTD[playerid][22], 0);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][22], 1);
    PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][22], 0);
    return true;
}

hook OnPlayerConnect(playerid){
    CreateLoginTextdraws(playerid);
}