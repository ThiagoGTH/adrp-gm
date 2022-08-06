#include <YSI_Coding\y_hooks> 
// VARS
new PlayerText:LoginTD[MAX_PLAYERS][2];
new PlayerText:NewsTD[MAX_PLAYERS][11];
new PlayerText:CharTD[MAX_PLAYERS][38];

new Text:TEXTDRAW_INTERFACE_INCORRECT;
new Text:TEXTDRAW_INTERFACE_CONNECTED;

/***********************************************************************************************

    FUNÇÕES PRINCIPAIS

************************************************************************************************/

hook OnPlayerConnect(playerid) {
    CreateLoginTextdraws(playerid);
    CreateCharacterTextdraws(playerid);
    CreateNewsTextdraws(playerid);
    return true;
}

hook OnPlayerDisconnect(playerid, reason) {
    HideLoginTextdraws(playerid);
    HideCharacterTextdraws(playerid);
    HideNewsTextdraws(playerid);
    return true;
}

hook OnGameModeInit() {
    CreateGlobalTextdraws();
    return true;
}

// Função para definir a interface
forward SetPlayerInterface(playerid, level);
public SetPlayerInterface(playerid, level) {
    if(level == 1){ // SENHA INCORRETA
        KillTimer(pInfo[playerid][pInterfaceTimer]);
        NotifyWrongAttempt(playerid);
        pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 999);
        
        TextDrawShowForPlayer(playerid, TEXTDRAW_INTERFACE_INCORRECT);
        TextDrawHideForPlayer(playerid, TEXTDRAW_INTERFACE_CONNECTED);
    } else if(level == 2){ // AUTENTICADO
        KillTimer(pInfo[playerid][pInterfaceTimer]);
        ShowUsersCharacters(playerid);
        pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 999);

        TextDrawShowForPlayer(playerid, TEXTDRAW_INTERFACE_CONNECTED);
        TextDrawHideForPlayer(playerid, TEXTDRAW_INTERFACE_INCORRECT);
    } else if(level == 999){ // FECHAR TUDO
        KillTimer(pInfo[playerid][pInterfaceTimer]);

        TextDrawHideForPlayer(playerid, TEXTDRAW_INTERFACE_CONNECTED);
        TextDrawHideForPlayer(playerid, TEXTDRAW_INTERFACE_INCORRECT);
    }
    return true;
}

/***********************************************************************************************

    TELA DE LOGIN

************************************************************************************************/

// Função para mostrar os textdraws de login
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
    LoginTD[playerid][0] = CreatePlayerTextDraw(playerid, -0.411781, -0.166666, "mdl-9000:background");
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][0], 712.000000, 477.000000);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][0], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, LoginTD[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][0], false);

    LoginTD[playerid][1] = CreatePlayerTextDraw(playerid, 88.811767, 30.750164, "mdl-9000:logo");
    PlayerTextDrawTextSize(playerid, LoginTD[playerid][1], 464.000000, 407.000000);
    PlayerTextDrawAlignment(playerid, LoginTD[playerid][1], 1);
    PlayerTextDrawColor(playerid, LoginTD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, LoginTD[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, LoginTD[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, LoginTD[playerid][1], false);

    return true;
}

/***********************************************************************************************

    TELA DE ESCOLHA DE PERSONAGEM

************************************************************************************************/

// Função para mostrar os textdraws de seleção de personagens
forward ShowCharacterTextdraws(playerid);
public ShowCharacterTextdraws(playerid) {
    for(new i; i < 38; i++)
        PlayerTextDrawShow(playerid, CharTD[playerid][i]);

    return true;
}

// Função para esconder os textdraws de seleção de personagens
HideCharacterTextdraws(playerid) {
    for(new i; i < 38; i++)
        PlayerTextDrawHide(playerid, CharTD[playerid][i]);

    return true;
}

// Função para criar os textdraws de seleção de personagens
CreateCharacterTextdraws(playerid) {
    CharTD[playerid][0] = CreatePlayerTextDraw(playerid, 17.500000, 271.000000, "mdl-9001:menu3");
    PlayerTextDrawFont(playerid, CharTD[playerid][0], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][0], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][0], 130.500000, 160.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][0], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][0], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][0], false);

    CharTD[playerid][1] = CreatePlayerTextDraw(playerid, -2.000000, 204.000000, "mdl-9001:menu1");
    PlayerTextDrawFont(playerid, CharTD[playerid][1], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][1], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][1], 169.000000, 115.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][1], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][1], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][1], false);

    CharTD[playerid][2] = CreatePlayerTextDraw(playerid, -2.000000, 211.000000, "mdl-9001:menu2");
    PlayerTextDrawFont(playerid, CharTD[playerid][2], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][2], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][2], 171.000000, 102.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][2], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][2], false);

    CharTD[playerid][3] = CreatePlayerTextDraw(playerid, 26.000000, 394.000000, "mdl-9001:menu5test");
    PlayerTextDrawFont(playerid, CharTD[playerid][3], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][3], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][3], 25.500000, 30.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][3], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][3], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][3], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][3], true);

    CharTD[playerid][4] = CreatePlayerTextDraw(playerid, 112.000000, 394.000000, "mdl-9001:menu6test");
    PlayerTextDrawFont(playerid, CharTD[playerid][4], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][4], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][4], 25.500000, 30.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][4], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][4], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][4], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][4], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][4], true);

    CharTD[playerid][5] = CreatePlayerTextDraw(playerid, 53.000000, 392.000000, "mdl-9001:menu7test");
    PlayerTextDrawFont(playerid, CharTD[playerid][5], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][5], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][5], 57.500000, 32.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][5], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][5], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][5], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][5], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][5], true);

    CharTD[playerid][10] = CreatePlayerTextDraw(playerid, 225.000000, 303.000000, "mdl-9001:menu8");
    PlayerTextDrawFont(playerid, CharTD[playerid][10], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][10], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][10], 195.000000, 127.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][10], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][10], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][10], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][10], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][10], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][10], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][10], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][10], false);

    /*CharTD[playerid][7] = CreatePlayerTextDraw(playerid, 225.000000, 303.000000, "mdl-9001:menu10");
    PlayerTextDrawFont(playerid, CharTD[playerid][7], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][7], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][7], 195.000000, 127.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][7], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][7], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][7], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][7], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][7], false);*/

    CharTD[playerid][8] = CreatePlayerTextDraw(playerid, 225.000000, 299.000000, "mdl-9001:menu9");
    PlayerTextDrawFont(playerid, CharTD[playerid][8], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][8], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][8], 195.000000, 27.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][8], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][8], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][8], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][8], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][8], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][8], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][8], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][8], false);

    CharTD[playerid][9] = CreatePlayerTextDraw(playerid, 225.000000, 303.000000, "mdl-9001:menu10");
    PlayerTextDrawFont(playerid, CharTD[playerid][9], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][9], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][9], 195.000000, 127.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][9], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][9], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][9], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][9], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][9], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][9], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][9], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][9], false);

    CharTD[playerid][6] = CreatePlayerTextDraw(playerid, 219.000000, 256.000000, "mdl-9001:menu11");
    PlayerTextDrawFont(playerid, CharTD[playerid][6], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][6], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][6], 200.000000, 109.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][6], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][6], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][6], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][6], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][6], false);

    CharTD[playerid][11] = CreatePlayerTextDraw(playerid, 239.000000, 337.000000, "mdl-9001:menu12");
    PlayerTextDrawFont(playerid, CharTD[playerid][11], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][11], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][11], 40.000000, 50.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][11], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][11], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][11], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][11], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][11], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][11], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][11], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][11], false);

    CharTD[playerid][12] = CreatePlayerTextDraw(playerid, 248.000000, 394.000000, "mdl-9001:menu13");
    PlayerTextDrawFont(playerid, CharTD[playerid][12], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][12], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][12], 21.500000, 25.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][12], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][12], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][12], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][12], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][12], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][12], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][12], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][12], false);

    CharTD[playerid][13] = CreatePlayerTextDraw(playerid, 239.000000, 336.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, CharTD[playerid][13], 5);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][13], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][13], 38.000000, 48.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][13], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][13], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][13], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][13], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][13], 0);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][13], 255);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][13], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][13], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][13], false);
    PlayerTextDrawSetPreviewModel(playerid, CharTD[playerid][13], 141);
    PlayerTextDrawSetPreviewRot(playerid, CharTD[playerid][13], 0.000000, 0.000000, 0.000000, 0.860000);
    PlayerTextDrawSetPreviewVehCol(playerid, CharTD[playerid][13], 1, 1);

    CharTD[playerid][14] = CreatePlayerTextDraw(playerid, 287.000000, 375.000000, "NASC");
    PlayerTextDrawFont(playerid, CharTD[playerid][14], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][14], 0.233327, 0.999997);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][14], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][14], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][14], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][14], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][14], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][14], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][14], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][14], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][14], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][14], false);

    CharTD[playerid][15] = CreatePlayerTextDraw(playerid, 287.000000, 352.000000, "UN");
    PlayerTextDrawFont(playerid, CharTD[playerid][15], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][15], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][15], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][15], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][15], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][15], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][15], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][15], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][15], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][15], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][15], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][15], false);

    CharTD[playerid][16] = CreatePlayerTextDraw(playerid, 287.000000, 362.000000, "PN");
    PlayerTextDrawFont(playerid, CharTD[playerid][16], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][16], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][16], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][16], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][16], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][16], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][16], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][16], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][16], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][16], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][16], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][16], false);

    CharTD[playerid][17] = CreatePlayerTextDraw(playerid, 286.000000, 336.000000, "ID");
    PlayerTextDrawFont(playerid, CharTD[playerid][17], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][17], 0.262497, 1.099997);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][17], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][17], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][17], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][17], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][17], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][17], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][17], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][17], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][17], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][17], false);

    CharTD[playerid][18] = CreatePlayerTextDraw(playerid, 312.000000, 336.000000, "00000000");
    PlayerTextDrawFont(playerid, CharTD[playerid][18], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][18], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][18], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][18], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][18], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][18], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][18], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][18], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][18], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][18], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][18], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][18], false);

    CharTD[playerid][19] = CreatePlayerTextDraw(playerid, 312.000000, 352.000000, "DOE");
    PlayerTextDrawFont(playerid, CharTD[playerid][19], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][19], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][19], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][19], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][19], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][19], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][19], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][19], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][19], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][19], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][19], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][19], false);

    CharTD[playerid][20] = CreatePlayerTextDraw(playerid, 312.000000, 362.000000, "JOHN");
    PlayerTextDrawFont(playerid, CharTD[playerid][20], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][20], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][20], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][20], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][20], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][20], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][20], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][20], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][20], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][20], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][20], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][20], false);

    CharTD[playerid][21] = CreatePlayerTextDraw(playerid, 312.000000, 376.000000, "00/00/0000");
    PlayerTextDrawFont(playerid, CharTD[playerid][21], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][21], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][21], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][21], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][21], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][21], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][21], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][21], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][21], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][21], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][21], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][21], false);

    /*CharTD[playerid][22] = CreatePlayerTextDraw(playerid, 350.000000, 331.000000, "mdl-9001:game1");
    PlayerTextDrawFont(playerid, CharTD[playerid][22], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][22], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][22], 56.500000, 59.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][22], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][22], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][22], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][22], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][22], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][22], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][22], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][22], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][22], false);*/

    CharTD[playerid][23] = CreatePlayerTextDraw(playerid, 287.000000, 395.000000, "SEX");
    PlayerTextDrawFont(playerid, CharTD[playerid][23], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][23], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][23], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][23], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][23], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][23], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][23], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][23], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][23], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][23], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][23], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][23], false);

    CharTD[playerid][24] = CreatePlayerTextDraw(playerid, 287.000000, 410.000000, "ALT");
    PlayerTextDrawFont(playerid, CharTD[playerid][24], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][24], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][24], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][24], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][24], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][24], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][24], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][24], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][24], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][24], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][24], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][24], false);

    CharTD[playerid][25] = CreatePlayerTextDraw(playerid, 300.000000, 395.000000, "Masc");
    PlayerTextDrawFont(playerid, CharTD[playerid][25], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][25], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][25], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][25], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][25], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][25], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][25], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][25], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][25], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][25], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][25], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][25], false);

    CharTD[playerid][26] = CreatePlayerTextDraw(playerid, 300.000000, 410.000000, "6.7");
    PlayerTextDrawFont(playerid, CharTD[playerid][26], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][26], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][26], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][26], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][26], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][26], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][26], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][26], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][26], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][26], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][26], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][26], false);

    CharTD[playerid][27] = CreatePlayerTextDraw(playerid, 324.000000, 395.000000, "CBLO");
    PlayerTextDrawFont(playerid, CharTD[playerid][27], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][27], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][27], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][27], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][27], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][27], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][27], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][27], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][27], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][27], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][27], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][27], false);

    CharTD[playerid][28] = CreatePlayerTextDraw(playerid, 340.000000, 395.000000, "Castanho");
    PlayerTextDrawFont(playerid, CharTD[playerid][28], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][28], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][28], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][28], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][28], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][28], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][28], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][28], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][28], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][28], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][28], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][28], false);

    CharTD[playerid][29] = CreatePlayerTextDraw(playerid, 361.000000, 410.000000, "OLHO");
    PlayerTextDrawFont(playerid, CharTD[playerid][29], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][29], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][29], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][29], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][29], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][29], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][29], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][29], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][29], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][29], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][29], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][29], false);

    CharTD[playerid][30] = CreatePlayerTextDraw(playerid, 380.000000, 410.000000, "Castanho");
    PlayerTextDrawFont(playerid, CharTD[playerid][30], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][30], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][30], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][30], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][30], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][30], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][30], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][30], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][30], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][30], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][30], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][30], false);

    CharTD[playerid][31] = CreatePlayerTextDraw(playerid, 324.000000, 410.000000, "PESO");
    PlayerTextDrawFont(playerid, CharTD[playerid][31], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][31], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][31], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][31], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][31], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][31], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][31], 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][31], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][31], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][31], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][31], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][31], false);

    CharTD[playerid][32] = CreatePlayerTextDraw(playerid, 340.000000, 410.000000, "90");
    PlayerTextDrawFont(playerid, CharTD[playerid][32], 1);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][32], 0.183329, 0.899999);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][32], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][32], 0);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][32], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][32], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][32], 0x262626FF);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][32], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][32], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][32], false);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][32], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][32], false);

    /*CharTD[playerid][33] = CreatePlayerTextDraw(playerid, 27.000000, 300.000000, "mdl-9001:menu9");
    PlayerTextDrawFont(playerid, CharTD[playerid][33], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][33], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][33], 110.000000, 79.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][33], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][33], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][33], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][33], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][33], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][33], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][33], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][33], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][33], false);*/

    /*CharTD[playerid][34] = CreatePlayerTextDraw(playerid, 27.000000, 300.000000, "mdl-9001:game3");
    PlayerTextDrawFont(playerid, CharTD[playerid][34], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][34], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][34], 110.000000, 79.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][34], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][34], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][34], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][34], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][34], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][34], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][34], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][34], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][34], false);

    CharTD[playerid][35] = CreatePlayerTextDraw(playerid, -39.000000, 280.000000, "mdl-9001:game2");
    PlayerTextDrawFont(playerid, CharTD[playerid][35], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][35], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][35], 176.000000, 100.000000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][35], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][35], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][35], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][35], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][35], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][35], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][35], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][35], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][35], false);*/

    CharTD[playerid][36] = CreatePlayerTextDraw(playerid, 52.000000, 331.000000, "mdl-9001:menu17");
    PlayerTextDrawFont(playerid, CharTD[playerid][36], 4);
    PlayerTextDrawLetterSize(playerid, CharTD[playerid][36], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, CharTD[playerid][36], 57.500000, 32.500000);
    PlayerTextDrawSetOutline(playerid, CharTD[playerid][36], 1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][36], 0);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][36], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][36], -1);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][36], 255);
    PlayerTextDrawBoxColor(playerid, CharTD[playerid][36], 50);
    PlayerTextDrawUseBox(playerid, CharTD[playerid][36], true);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][36], true);
    PlayerTextDrawSetSelectable(playerid, CharTD[playerid][36], true);

    CharTD[playerid][37] = CreatePlayerTextDraw(playerid, 94.176452, 31.333498, "mdl-9000:logo");
    PlayerTextDrawTextSize(playerid, CharTD[playerid][37], 464.000000, 407.000000);
    PlayerTextDrawAlignment(playerid, CharTD[playerid][37], 1);
    PlayerTextDrawColor(playerid, CharTD[playerid][37], -1);
    PlayerTextDrawSetShadow(playerid, CharTD[playerid][37], 0);
    PlayerTextDrawBackgroundColor(playerid, CharTD[playerid][37], 255);
    PlayerTextDrawFont(playerid, CharTD[playerid][37], 4);
    PlayerTextDrawSetProportional(playerid, CharTD[playerid][37], false);
    return true;
}

CMD:zzz(playerid, params[]){
    ShowCharacterTextdraws(playerid);
    return true;
}

CMD:xxx(playerid, params[]){
    HideCharacterTextdraws(playerid);
    return true;
}

/***********************************************************************************************

    TELEVISÃO/NOTÍCIAS

************************************************************************************************/

// Função para mostrar os textdraws de notícias
forward ShowNewsTextdraws(playerid);
public ShowNewsTextdraws(playerid) {
    for(new i; i < 11; i++)
        PlayerTextDrawShow(playerid, NewsTD[playerid][i]);
    
    return true;
}

// Função para esconder os textdraws de notícias
HideNewsTextdraws(playerid) {
    for(new i; i < 11; i++)
        PlayerTextDrawHide(playerid, NewsTD[playerid][i]);

    return true;
}

// Função para criar os textdraws de notícias
CreateNewsTextdraws(playerid) {
    NewsTD[playerid][0] = CreatePlayerTextDraw(playerid, 78.176460, 303.018554, "mdl-9002:ABC7-Bottom");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][0], 481.000000, 139.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][0], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][0], false);

    NewsTD[playerid][1] = CreatePlayerTextDraw(playerid, 512.200561, 50.116756, "mdl-9002:ABC7-LIVE");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][1], 25.000000, 16.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][1], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][1], false);

    NewsTD[playerid][2] = CreatePlayerTextDraw(playerid, -0.411781, -0.166666, "mdl-9002:tv-screen");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][2], 712.000000, 477.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][2], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][2], false);

    NewsTD[playerid][3] = CreatePlayerTextDraw(playerid, 640.529296, -1.149999, "LD_PLAN:tvcorn");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][3], -142.000000, 158.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][3], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][3], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][3], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][3], false);

    NewsTD[playerid][4] = CreatePlayerTextDraw(playerid, 141.705871, -2.500007, "LD_PLAN:tvbase");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][4], 357.000000, 13.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][4], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][4], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][4], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][4], false);

    NewsTD[playerid][5] = CreatePlayerTextDraw(playerid, 640.058044, 448.600219, "LD_PLAN:tvcorn");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][5], -141.000000, -165.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][5], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][5], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][5], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][5], false);

    NewsTD[playerid][6] = CreatePlayerTextDraw(playerid, -1.823829, 449.583496, "LD_PLAN:tvcorn");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][6], 145.000000, -176.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][6], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][6], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][6], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][6], false);

    NewsTD[playerid][7] = CreatePlayerTextDraw(playerid, 142.647033, 436.749969, "LD_PLAN:tvbase");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][7], 357.000000, 13.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][7], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][7], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][7], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][7], false);

    NewsTD[playerid][8] = CreatePlayerTextDraw(playerid, -0.411824, 152.666641, "LD_PLAN:tvbase");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][8], 9.000000, 123.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][8], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][8], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][8], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][8], false);

    NewsTD[playerid][9] = CreatePlayerTextDraw(playerid, 629.705505, 154.999908, "LD_PLAN:tvbase");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][9], 13.000000, 133.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][9], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][9], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][9], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][9], false);

    NewsTD[playerid][10] = CreatePlayerTextDraw(playerid, -0.882364, -0.749989, "LD_PLAN:tvcorn");
    PlayerTextDrawTextSize(playerid, NewsTD[playerid][10], 143.000000, 154.000000);
    PlayerTextDrawAlignment(playerid, NewsTD[playerid][10], 1);
    PlayerTextDrawColor(playerid, NewsTD[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, NewsTD[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, NewsTD[playerid][10], 255);
    PlayerTextDrawFont(playerid, NewsTD[playerid][10], 4);
    PlayerTextDrawSetProportional(playerid, NewsTD[playerid][10], false);

    return true;
}

/***********************************************************************************************

    GLOBAIS

************************************************************************************************/

// Função para criar os textdraws globais
CreateGlobalTextdraws() {
    TEXTDRAW_INTERFACE_CONNECTED = TextDrawCreate(-0.411781, -0.166666, "mdl-9000:connected");
    TextDrawTextSize(TEXTDRAW_INTERFACE_CONNECTED, 639.000000, 451.000000);
    TextDrawAlignment(TEXTDRAW_INTERFACE_CONNECTED, 1);
    TextDrawColor(TEXTDRAW_INTERFACE_CONNECTED, -1);
    TextDrawSetShadow(TEXTDRAW_INTERFACE_CONNECTED, 0);
    TextDrawBackgroundColor(TEXTDRAW_INTERFACE_CONNECTED, 255);
    TextDrawFont(TEXTDRAW_INTERFACE_CONNECTED, 4);
    TextDrawSetProportional(TEXTDRAW_INTERFACE_CONNECTED, false);

    TEXTDRAW_INTERFACE_INCORRECT = TextDrawCreate(-0.411781, -0.166666, "mdl-9000:wrong-pass");
    TextDrawTextSize(TEXTDRAW_INTERFACE_INCORRECT, 639.000000, 451.000000);
    TextDrawAlignment(TEXTDRAW_INTERFACE_INCORRECT, 1);
    TextDrawColor(TEXTDRAW_INTERFACE_INCORRECT, -1);
    TextDrawSetShadow(TEXTDRAW_INTERFACE_INCORRECT, 0);
    TextDrawBackgroundColor(TEXTDRAW_INTERFACE_INCORRECT, 255);
    TextDrawFont(TEXTDRAW_INTERFACE_INCORRECT, 4);
    TextDrawSetProportional(TEXTDRAW_INTERFACE_INCORRECT, false);

    return true;
}