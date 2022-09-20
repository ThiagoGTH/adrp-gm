#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 6036, 1003.890, -1598.040, 17.843, 0.250);
    RemoveBuildingForPlayer(playerid, 6073, 1003.890, -1598.040, 17.843, 0.250);
    RemoveBuildingForPlayer(playerid, 6054, 1036.410, -1689.180, 12.609, 0.250);
    RemoveBuildingForPlayer(playerid, 6177, 1036.410, -1689.180, 12.609, 0.250);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModelEx(703, -2000, "maps/business/petshop/PetShopVEG.dff", "maps/business/petshop/PetShopVEG.txd");
    AddSimpleModelEx(2740, -2001, "maps/business/petshop/PetShopLIGHT.dff", "maps/business/petshop/PetShopLIGHT.txd");
    AddSimpleModelEx(6054, -2002, "maps/business/petshop/PetShopStreet.dff", "maps/business/petshop/PetShopStreet.txd");
    AddSimpleModelEx(6489, -2003, "maps/business/petshop/PetShopGrid.dff", "maps/business/petshop/PetShopGrid.txd");
    AddSimpleModelEx(2262, -2004, "maps/business/petshop/PetShop.dff", "maps/business/petshop/PetShop.txd");

    CreateModelObject(MODEL_TYPE_VEGETATION, -2000, 1003.890014, -1598.040039, 17.843799, 0.000000, 0.000000, 720.000000);
    CreateModelObject(MODEL_TYPE_2DFX, -2001, 1003.890014, -1598.040039, 17.843799, 0.000000, 0.000000, 720.000000);
    CreateModelObject(MODEL_TYPE_LANDMASSES, -2002, 1036.410034, -1689.180053, 12.609395, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_OBJECTS, -2003, 1003.890014, -1598.040039, 17.843799, 0.000000, 0.000000, 720.000000);
    CreateModelObject(MODEL_TYPE_BUILDINGS, -2004, 1003.890014, -1598.040039, 17.843799, 0.000000, 0.000000, 720.000000);
    return true;
}

