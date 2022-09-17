#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 6309, 576.640, -1730.420, 11.881, 0.250);
    RemoveBuildingForPlayer(playerid, 6440, 576.640, -1730.420, 11.881, 0.250);
    RemoveBuildingForPlayer(playerid, 6122, 798.093, -1763.098, 12.694, 0.250);
    RemoveBuildingForPlayer(playerid, 6182, 798.093, -1763.098, 12.694, 0.250);
    RemoveBuildingForPlayer(playerid, 6118, 1050.078, -1864.310, 12.397, 0.250);
    RemoveBuildingForPlayer(playerid, 6179, 1050.078, -1864.310, 12.397, 0.250);

    RemoveBuildingForPlayer(playerid, 6046, 1305.468, -1619.739, 13.397, 0.250);
    RemoveBuildingForPlayer(playerid, 6253, 1305.468, -1619.739, 13.397, 0.250);
    RemoveBuildingForPlayer(playerid, 6127, 1306.520, -1630.359, 12.468, 0.250);
    RemoveBuildingForPlayer(playerid, 6172, 1306.520, -1630.359, 12.468, 0.250);
    RemoveBuildingForPlayer(playerid, 6310, 437.898, -1715.098, 8.593, 0.250);
    RemoveBuildingForPlayer(playerid, 6439, 437.898, -1715.098, 8.593, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadStreetsModels();
    StreetsExterior();
    return true;
}

LoadStreetsModels() {
    AddSimpleModelEx(0, -20021, "maps/env/streets/yolayrimi1.dff", "maps/env/streets/yolayrimi.txd");
    AddSimpleModelEx(0, -20022, "maps/env/streets/yolayrimi2.dff", "maps/env/streets/yolayrimi.txd");
    AddSimpleModelEx(0, -20023, "maps/env/streets/yolayrimi3.dff", "maps/env/streets/yolayrimi.txd");

    AddSimpleModelEx(0, -20024, "maps/env/streets/a2.dff", "maps/env/streets/a2.txd");
    AddSimpleModelEx(0, -20025, "maps/env/streets/b2.dff", "maps/env/streets/b2.txd");
}

StreetsExterior() {
    CreateModelObject(MODEL_TYPE_LANDMASSES, -20021, 1050.078125, -1864.312377, 12.398453, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_LANDMASSES, -20022, 798.093994, -1763.101440, 12.695322, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_LANDMASSES, -20023, 576.640991, -1730.421630, 11.882777, 0.000000, 0.000000, 0.000000);

    CreateModelObject(MODEL_TYPE_LANDMASSES, -20024, 1306.515625, -1630.359375, 12.468799, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_LANDMASSES, -20025, 437.898406, -1715.101562, 8.593799, 0.000000, 0.000000, 0.000000);
}