#include <YSI_Coding\y_hooks>

#define MAX_BUSINESS          (1000)

#define COP_ROBBERY           (4) //M�nimo de policiais online para roubar uma empresa

enum E_BUSINESS_DATA {
    bID,                 //ID da empresa no banco de dados
    bOwner,              //ID do personagem dono
    bName[256],          //Nome da empresa
    bAddress[256],       //Endere�o da Empresa
    bool:bLocked,        //Boolean de destrancado/trancado
    bool:bOpen,          //Boolean de aberto/fechado
    bType,               //Tipo da empresa (24/7-concessionaria,etc)
    bProducts,           //Total de produtos na empresa
    bPrice,              //Valor da empresa
    bValue,              //Cofre da empresa
    bTax,                //Taxa da empresa imposta pelo governo
    Float:bEnter[6],     //Posi��es de entrada X-Y-Z-A e VW-Interior
    Float:bExit[6],      //Posi��es de saida X-Y-Z-A e VW-Interior
    Float:bRobbery[6],   //Posi��es para efetuar o roubo X-Y-Z-A e VW-Interior
    bAlarm,              //Levels do alarme da empresa
    bSecurity,           //Levels de seguran�a da emppresa
    bBlip,               //Icone para aparecer no mapa
    bPickup,             //Pickup visual da empresa (Icone na entrada)
    bDynamicPickup,      //Cria o item pickup
};

new BizData[MAX_BUSINESS][E_BUSINESS_DATA];

hook OnGameModeInit() {
    LoadAllBusiness();
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