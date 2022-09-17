#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 5461, 2011.468, -1300.900, 28.694, 0.250);
    RemoveBuildingForPlayer(playerid, 5597, 2011.468, -1300.900, 28.694, 0.250);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModelEx(19379, -20017, "maps/env/bahamas/bahamas.dff", "maps/env/bahamas/bahamas.txd");
    CreateModelObject(MODEL_TYPE_BUILDINGS, -20017, 2011.468994, -1300.900024, 28.694999, 0.000000, 0.000000, 0.000000); 
    return true;
}