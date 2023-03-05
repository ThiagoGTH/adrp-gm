#include <YSI_Coding\y_hooks>

#define BUSINESS_HUD "mdl-9006:empresa"
#define BUSINESS_P_HUD "mdl-9006:empresap"
#define LSREA_PROPERTY_SELL_HUD "mdl-9006:avenda"

new Text:TEXTDRAW_LSREA_PROPERTY_SELL;
new Text:TEXTDRAW_BUSINESS;
new Text:TEXTDRAW_BUSINESS_P;

hook OnGameModeInit() {
    SetTimer("PropertyHUD", 600, true);//0,5s

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

    TEXTDRAW_LSREA_PROPERTY_SELL = TextDrawCreate(508.000000, 77.000000, LSREA_PROPERTY_SELL_HUD);
    TextDrawLetterSize(TEXTDRAW_LSREA_PROPERTY_SELL, 0.401600, 0.526132);
    TextDrawTextSize(TEXTDRAW_LSREA_PROPERTY_SELL, 132.000000, 152.000000);
    TextDrawColour(TEXTDRAW_LSREA_PROPERTY_SELL, -1);
    TextDrawFont(TEXTDRAW_LSREA_PROPERTY_SELL, TEXT_DRAW_FONT_SPRITE_DRAW);
    TextDrawAlignment(TEXTDRAW_LSREA_PROPERTY_SELL, TEXT_DRAW_ALIGN:1);
    TextDrawSetShadow(TEXTDRAW_LSREA_PROPERTY_SELL, 0);
    TextDrawUseBox(TEXTDRAW_LSREA_PROPERTY_SELL, true);
    TextDrawBoxColour(TEXTDRAW_LSREA_PROPERTY_SELL, -1);
    TextDrawSetOutline(TEXTDRAW_LSREA_PROPERTY_SELL, 0);
    TextDrawBackgroundColour(TEXTDRAW_LSREA_PROPERTY_SELL, -1);
    TextDrawSetProportional(TEXTDRAW_LSREA_PROPERTY_SELL, false);
    TextDrawSetShadow(TEXTDRAW_LSREA_PROPERTY_SELL, 0);
    TextDrawSetSelectable(TEXTDRAW_LSREA_PROPERTY_SELL, false);
    return true;
}

TogglePlayerBusinessInterface(playerid, bizid, bool:toggle) {
    if(toggle && bizid != -1)//Exibir
    {
        new string[128];

        if(BizData[bizid][bOwner] == 0) {
            TextDrawShowForPlayer(playerid, TEXTDRAW_LSREA_PROPERTY_SELL);

            format(string, 128, "%s", FormatNumber(BizData[bizid][bPrice]));

            pInfo[playerid][pTextdraws][10] = CreatePlayerTextDraw(playerid,636.000000, 150.000000, string);
            PlayerTextDrawAlignment(playerid,pInfo[playerid][pTextdraws][10], TEXT_DRAW_ALIGN:3);
            PlayerTextDrawBackgroundColour(playerid,pInfo[playerid][pTextdraws][10], 85);
            PlayerTextDrawFont(playerid,pInfo[playerid][pTextdraws][10], TEXT_DRAW_FONT_1);
            PlayerTextDrawLetterSize(playerid,pInfo[playerid][pTextdraws][10], 0.35, 1.40);

            if(GetMoney(playerid) >= BizData[bizid][bPrice])
                PlayerTextDrawColour(playerid,pInfo[playerid][pTextdraws][10], 0x238C00FF);
            else
                PlayerTextDrawColour(playerid,pInfo[playerid][pTextdraws][10], 0xB20000FF);

            PlayerTextDrawSetOutline(playerid,pInfo[playerid][pTextdraws][10], 1);
            PlayerTextDrawSetProportional(playerid,pInfo[playerid][pTextdraws][10], true);
            PlayerTextDrawUseBox(playerid,pInfo[playerid][pTextdraws][10], false);
            PlayerTextDrawBoxColour(playerid,pInfo[playerid][pTextdraws][10], -256);
            PlayerTextDrawTextSize(playerid,pInfo[playerid][pTextdraws][10], 640.000000, 70.000000);
            PlayerTextDrawSetSelectable(playerid,pInfo[playerid][pTextdraws][10], false);

            PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][10]);
        }

        if (BizData[bizid][bOwner] > 0 && BizData[bizid][bOwner] != 0)
        {
            TextDrawShowForPlayer(playerid, TEXTDRAW_BUSINESS_P);

            format(string, 128, "%s", FormatNumber(BizData[bizid][bTax]));

            pInfo[playerid][pTextdraws][10] = CreatePlayerTextDraw(playerid,554.000000, 229.000000, string);
            PlayerTextDrawAlignment(playerid,pInfo[playerid][pTextdraws][10], TEXT_DRAW_ALIGN:3);
            PlayerTextDrawBackgroundColour(playerid,pInfo[playerid][pTextdraws][10], 85);
            PlayerTextDrawFont(playerid,pInfo[playerid][pTextdraws][10], TEXT_DRAW_FONT_1);
            PlayerTextDrawLetterSize(playerid,pInfo[playerid][pTextdraws][10], 0.15, 0.6);
            
            if(GetMoney(playerid) >= BizData[bizid][bTax])
                PlayerTextDrawColour(playerid,pInfo[playerid][pTextdraws][10], 0x238C00FF);
            else
                PlayerTextDrawColour(playerid,pInfo[playerid][pTextdraws][10], 0xB20000FF);

            PlayerTextDrawSetOutline(playerid,pInfo[playerid][pTextdraws][10], 1);
            PlayerTextDrawSetProportional(playerid,pInfo[playerid][pTextdraws][10], true);
            PlayerTextDrawUseBox(playerid,pInfo[playerid][pTextdraws][10], false);
            PlayerTextDrawBoxColour(playerid,pInfo[playerid][pTextdraws][10], -256);
            PlayerTextDrawTextSize(playerid,pInfo[playerid][pTextdraws][10], 640.000000, 70.000000);
            PlayerTextDrawSetSelectable(playerid,pInfo[playerid][pTextdraws][10], false);

            PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][10]);
        }
        else
            TextDrawShowForPlayer(playerid, TEXTDRAW_BUSINESS);

        format(string, 128, "%s", BizData[bizid][bName]);
        AdjustTextDrawString(string);

        pInfo[playerid][pTextdraws][11] = CreatePlayerTextDraw(playerid,523.000000, 197.000000, string);
        PlayerTextDrawBackgroundColour(playerid,pInfo[playerid][pTextdraws][11], 85);
        PlayerTextDrawFont(playerid,pInfo[playerid][pTextdraws][11], TEXT_DRAW_FONT_1);
        PlayerTextDrawLetterSize(playerid,pInfo[playerid][pTextdraws][11], 0.230000, 0.699998);
        PlayerTextDrawColour(playerid,pInfo[playerid][pTextdraws][11], -1);
        PlayerTextDrawSetOutline(playerid,pInfo[playerid][pTextdraws][11], 1);
        PlayerTextDrawSetProportional(playerid,pInfo[playerid][pTextdraws][11], true);
        PlayerTextDrawUseBox(playerid,pInfo[playerid][pTextdraws][11], true);
        PlayerTextDrawBoxColour(playerid,pInfo[playerid][pTextdraws][11], 0xFFFFFF00);
        PlayerTextDrawTextSize(playerid,pInfo[playerid][pTextdraws][11], 640.000000, 70.000000);
        PlayerTextDrawSetSelectable(playerid,pInfo[playerid][pTextdraws][11], false);

        format(string, 128, "");

        if(!BizData[bizid][bLocked])
            format(string, 128, "/entrar");
        else
            format(string, 128, "");

        pInfo[playerid][pTextdraws][12] = CreatePlayerTextDraw(playerid,560.000000, 228.000000, string);
        PlayerTextDrawBackgroundColour(playerid,pInfo[playerid][pTextdraws][12], 85);
        PlayerTextDrawFont(playerid,pInfo[playerid][pTextdraws][12], TEXT_DRAW_FONT_1);
        PlayerTextDrawLetterSize(playerid,pInfo[playerid][pTextdraws][12], 0.230000, 0.699998);
        PlayerTextDrawColour(playerid,pInfo[playerid][pTextdraws][12], -1);
        PlayerTextDrawSetOutline(playerid,pInfo[playerid][pTextdraws][12], 1);
        PlayerTextDrawSetProportional(playerid,pInfo[playerid][pTextdraws][12], true);
        PlayerTextDrawUseBox(playerid,pInfo[playerid][pTextdraws][12], true);
        PlayerTextDrawBoxColour(playerid,pInfo[playerid][pTextdraws][12], 0xFFFFFF00);
        PlayerTextDrawTextSize(playerid,pInfo[playerid][pTextdraws][12], 640.000000, 70.000000);
        PlayerTextDrawSetSelectable(playerid,pInfo[playerid][pTextdraws][12], false);

        format(string, 128, "%d", bizid);

        pInfo[playerid][pTextdraws][13] = CreatePlayerTextDraw(playerid,638.000000, 215.000000, string);
        PlayerTextDrawAlignment(playerid,pInfo[playerid][pTextdraws][13], TEXT_DRAW_ALIGN:3);
        PlayerTextDrawBackgroundColour(playerid,pInfo[playerid][pTextdraws][13], 85);
        PlayerTextDrawFont(playerid,pInfo[playerid][pTextdraws][13], TEXT_DRAW_FONT_1);
        PlayerTextDrawLetterSize(playerid,pInfo[playerid][pTextdraws][13], 0.149999, 0.699999);
        PlayerTextDrawColour(playerid,pInfo[playerid][pTextdraws][13], -1);
        PlayerTextDrawSetOutline(playerid,pInfo[playerid][pTextdraws][13], 1);
        PlayerTextDrawSetProportional(playerid,pInfo[playerid][pTextdraws][13], true);
        PlayerTextDrawUseBox(playerid,pInfo[playerid][pTextdraws][13], false);
        PlayerTextDrawBoxColour(playerid,pInfo[playerid][pTextdraws][13], -256);
        PlayerTextDrawTextSize(playerid,pInfo[playerid][pTextdraws][13], 640.000000, 70.000000);
        PlayerTextDrawSetSelectable(playerid,pInfo[playerid][pTextdraws][13], false);

        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][11]);
        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][12]);
        PlayerTextDrawShow(playerid, pInfo[playerid][pTextdraws][13]);
    }
    else if(!toggle) {
        RemovePlayerPropertyInterface(playerid);
    }
    return true;
}

stock RemovePlayerPropertyInterface(playerid) {
    TextDrawHideForPlayer(playerid, TEXTDRAW_BUSINESS);
    TextDrawHideForPlayer(playerid, TEXTDRAW_BUSINESS_P);
    TextDrawHideForPlayer(playerid, TEXTDRAW_LSREA_PROPERTY_SELL);
    
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][10]);
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][11]);
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][12]);
    PlayerTextDrawHide(playerid, pInfo[playerid][pTextdraws][13]);

    PlayerTextDrawDestroy(playerid, pInfo[playerid][pTextdraws][10]);
    PlayerTextDrawDestroy(playerid, pInfo[playerid][pTextdraws][11]);
    PlayerTextDrawDestroy(playerid, pInfo[playerid][pTextdraws][12]);
    PlayerTextDrawDestroy(playerid, pInfo[playerid][pTextdraws][13]);
    return true;
}

forward PropertyHUD();
public PropertyHUD() {
	foreach(new i : Player) {
	    OnPlayerInterface(i); //HUD de propriedades
	}
	return true;
}

forward OnPlayerInterface(playerid);
public OnPlayerInterface(playerid) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
        /*new houseid = House_Nearest(playerid, 2.0);

        if(houseid != -1) {
            TogglePlayerHouseInterface(playerid, houseid, false);
            return TogglePlayerHouseInterface(playerid, houseid, true);
        }*/
    
        new bizid = NearestBusinessEnter(playerid);

        if(bizid != -1) {
            TogglePlayerBusinessInterface(playerid, bizid, false);
            return TogglePlayerBusinessInterface(playerid, bizid, true);
        }

        /*new entranceid = Entrance_Nearest(playerid);

        if(entranceid != -1) {
            TogglePlayerEntranceInterface(playerid, entranceid, false);
            return TogglePlayerEntranceInterface(playerid, entranceid, true);
        }

        new atmid = ATM_Nearest(playerid);

        if(atmid != -1) {
            TogglePlayerATMInterface(playerid, atmid, false);
            return TogglePlayerATMInterface(playerid, atmid, true);
        }

        new prisonid = Prison_Nearest(playerid);

        if(prisonid != -1) {
            TogglePlayerPrisonInterface(playerid, false);
            return TogglePlayerPrisonInterface(playerid, true);
        }

        if(houseid == -1 && pInfo[playerid][pHUDShowing] == 1)
            TogglePlayerHouseInterface(playerid, houseid, false);*/
        
        if(bizid == -1 && pInfo[playerid][pHUDShowing] == 2)
            TogglePlayerBusinessInterface(playerid, bizid, false);

        /*if(entranceid == -1 && pInfo[playerid][pHUDShowing] == 4)
            TogglePlayerEntranceInterface(playerid, entranceid, false);

        if(atmid != -1 && pInfo[playerid][pHUDShowing] == 5)
            TogglePlayerATMInterface(playerid, atmid, false);

        if(prisonid != -1 && pInfo[playerid][pHUDShowing] == 6)
            TogglePlayerPrisonInterface(playerid, false);*/

        //if(houseid == -1 && bizid == -1 && entranceid == -1 && atmid == -1 && prisonid == -1)
        if(bizid == -1)
            RemovePlayerPropertyInterface(playerid);
    }
    
    /*if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT || GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
    {
        new garageid = Garages_Nearest(playerid);

        if(garageid != -1)
        {
            TogglePlayerGarageInterface(playerid, garageid, false);
            return TogglePlayerGarageInterface(playerid, garageid, true);
        }

        //Não ta próximo de uma garagem, remove a HUD da tela:
        if(garageid == -1 && pInfo[playerid][pHUDShowing] == 3)
            TogglePlayerGarageInterface(playerid, garageid, false);

        if(garageid == -1)
            RemovePlayerPropertyInterface(playerid);
    }*/

    return true;
}