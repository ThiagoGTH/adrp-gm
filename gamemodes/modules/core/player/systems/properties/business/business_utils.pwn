#include <YSI_Coding\y_hooks>

#define MAX_BUSINESS          (1000)

#define COP_ROBBERY           (4) //Mínimo de policiais online para roubar uma empresa

#define BUSINESS_HUD "mdl-9006:empresa"
#define BUSINESS_P_HUD "mdl-9006:empresap"

new Text:TEXTDRAW_LSREA_PROPERTY_SELL;
new Text:TEXTDRAW_BUSINESS;
new Text:TEXTDRAW_BUSINESS_P;

enum E_BUSINESS_DATA {
    bID,                 //ID da empresa no banco de dados
    bOwner,              //ID do personagem dono
    bName[256],          //Nome da empresa
    bAddress[256],       //Endereço da Empresa
    bool:bLocked,        //Boolean de destrancado/trancado
    bool:bOpen,          //Boolean de aberto/fechado
    bType,               //Tipo da empresa (24/7-concessionaria,etc)
    bProducts,           //Total de produtos na empresa
    bPrice,              //Valor da empresa
    bValue,              //Cofre da empresa
    bTax,                //Taxa da empresa imposta pelo governo
    Float:bEnter[6],     //Posições de entrada X-Y-Z-A e VW-Interior
    Float:bExit[6],      //Posições de saida X-Y-Z-A e VW-Interior
    Float:bRobbery[6],   //Posições para efetuar o roubo X-Y-Z-A e VW-Interior
    bAlarm,              //Levels do alarme da empresa
    bSecurity,           //Levels de segurança da emppresa
    bBlip,               //Icone para aparecer no mapa
    bPickup,             //Pickup visual da empresa (Icone na entrada)
    bDynamicPickup,      //Cria o item pickup
};

new BizData[MAX_BUSINESS][E_BUSINESS_DATA];

hook OnGameModeInit() {
    LoadAllBusiness();

    TEXTDRAW_BUSINESS = TextDrawCreate(508.000000, 170.000000, BUSINESS_HUD);
    TextDrawLetterSize(TEXTDRAW_BUSINESS, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_BUSINESS, 132.000000, 70.000000);
    TextDrawColour(TEXTDRAW_BUSINESS, -1);
    TextDrawFont(TEXTDRAW_BUSINESS, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawAlignment(TEXTDRAW_BUSINESS, TEXT_DRAW_ALIGN:1);
    TextDrawSetShadow(TEXTDRAW_BUSINESS, 0);
    TextDrawUseBox(TEXTDRAW_BUSINESS, true);
    TextDrawBoxColour(TEXTDRAW_BUSINESS, -1);
    TextDrawSetOutline(TEXTDRAW_BUSINESS, 0);
    TextDrawBackgroundColour(TEXTDRAW_BUSINESS, -1);
    TextDrawSetProportional(TEXTDRAW_BUSINESS, false);
    TextDrawSetShadow(TEXTDRAW_BUSINESS, 0);
    TextDrawSetSelectable(TEXTDRAW_BUSINESS, false);

    TEXTDRAW_BUSINESS_P = TextDrawCreate(508.000000, 170.000000, BUSINESS_P_HUD);
    TextDrawLetterSize(TEXTDRAW_BUSINESS_P, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_BUSINESS_P, 132.000000, 70.000000);
    TextDrawColour(TEXTDRAW_BUSINESS_P, -1);
    TextDrawFont(TEXTDRAW_BUSINESS_P, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawAlignment(TEXTDRAW_BUSINESS_P, TEXT_DRAW_ALIGN:1);
    TextDrawSetShadow(TEXTDRAW_BUSINESS_P, 0);
    TextDrawUseBox(TEXTDRAW_BUSINESS_P, true);
    TextDrawBoxColour(TEXTDRAW_BUSINESS_P, -1);
    TextDrawSetOutline(TEXTDRAW_BUSINESS_P, 0);
    TextDrawBackgroundColour(TEXTDRAW_BUSINESS_P, -1);
    TextDrawSetProportional(TEXTDRAW_BUSINESS_P, false);
    TextDrawSetShadow(TEXTDRAW_BUSINESS_P, 0);
    TextDrawSetSelectable(TEXTDRAW_BUSINESS_P, false);

    return true;
}

hook OnGamemodeExit() {
    SaveAllBusiness();
    return true;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        new bizid = NearestBusinessEnter(playerid);

        if(bizid != -1) {
            if(BizData[bizid][bDynamicPickup] == pickupid) {
                TogglePlayerBusinessInterface(playerid, bizid, false);
                return TogglePlayerBusinessInterface(playerid, bizid, true);
            }
        }

        /*for(new i; i < MAX_BUSINESS; i++) {
            if(BizData[i][bDynamicPickup] == pickupid)
            {
                TogglePlayerBusinessInterface(playerid, i, true);
            }
        }*/
    }

    return 1;
}