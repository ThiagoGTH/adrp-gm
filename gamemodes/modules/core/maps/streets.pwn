#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 6118, 1050.079, -1864.310, 12.398, 0.250);
    RemoveBuildingForPlayer(playerid, 6122, 798.093, -1763.099, 12.695, 0.250);
    RemoveBuildingForPlayer(playerid, 6309, 576.640, -1730.420, 11.882, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadStreetsModels();
    StreetsExterior();
    return true;
}

LoadStreetsModels() {
    AddSimpleModel(-1, 19379, -20021, "maps/Env/streets/yolayrimi1.dff", "maps/Env/streets/yolayrimi.txd");
    AddSimpleModel(-1, 19379, -20022, "maps/Env/streets/yolayrimi2.dff", "maps/Env/streets/yolayrimi.txd");
    AddSimpleModel(-1, 19379, -20023, "maps/Env/streets/yolayrimi3.dff", "maps/Env/streets/yolayrimi.txd");
}

StreetsExterior() {
    CreateObject(-20021, 1050.078125, -1864.312377, 12.398453, 0.000000, 0.000000, 0.000000, 1000.00);
    CreateObject(-20022, 798.093994, -1763.101440, 12.695322, 0.000000, 0.000000, 0.000000, 1000.00);
    CreateObject(-20023, 576.640991, -1730.421630, 11.882777, 0.000000, 0.000000, 0.000000, 1000.00);
}