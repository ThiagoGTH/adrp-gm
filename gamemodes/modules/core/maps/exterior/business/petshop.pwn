#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 6036, 1003.890, -1598.040, 17.843, 0.250);
    RemoveBuildingForPlayer(playerid, 6073, 1003.890, -1598.040, 17.843, 0.250);
    RemoveBuildingForPlayer(playerid, 6054, 1036.410, -1689.180, 12.609, 0.250);
    RemoveBuildingForPlayer(playerid, 6177, 1036.410, -1689.180, 12.609, 0.250);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModel(-1, 703, -1061, "maps/business/petshop/PetShopVEG.dff", "maps/business/petshop/PetShopVEG.txd");
    AddSimpleModel(-1, 2740, -1062, "maps/business/petshop/PetShopLIGHT.dff", "maps/business/petshop/PetShopLIGHT.txd");
    AddSimpleModel(-1, 6054, -1063, "maps/business/petshop/PetShopStreet.dff", "maps/business/petshop/PetShopStreet.txd");
    AddSimpleModel(-1, 6489, -1064, "maps/business/petshop/PetShopGrid.dff", "maps/business/petshop/PetShopGrid.txd");
    AddSimpleModel(-1, 2262, -1065, "maps/business/petshop/PetShop.dff", "maps/business/petshop/PetShop.txd");

    CreateObject(-1065, 1003.890014, -1598.040039, 17.843799, 0.000000, 0.000000, 720.000000, 1000.00); 
    CreateDynamicObject(-1061, 1003.890014, -1598.040039, 17.843799, 0.000000, 0.000000, 720.000000, -1, -1, -1, 700.00, 700.00); 
    CreateDynamicObject(-1062, 1003.890014, -1598.040039, 17.843799, 0.000000, 0.000000, 720.000000, -1, -1, -1, 700.00, 700.00); 
    CreateObject(-1063, 1036.410034, -1689.180053, 12.609395, 0.000000, 0.000000, 0.000000, 1000.00); 
    CreateDynamicObject(-1064, 1003.890014, -1598.040039, 17.843799, 0.000000, 0.000000, 720.000000, -1, -1, -1, 700.00, 700.00); 
    return true;
}

