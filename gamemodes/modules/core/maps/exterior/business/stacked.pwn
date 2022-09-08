#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
    RemoveBuildingForPlayer(playerid, 1522, 2105.919, -1807.250, 12.515, 0.250);
    RemoveBuildingForPlayer(playerid, 5418, 2112.939, -1797.089, 19.335, 0.250);
    RemoveBuildingForPlayer(playerid, 5530, 2112.939, -1797.089, 19.335, 0.250);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModel(-1, 12849, -2005, "maps/business/stacked/twsp.dff", "maps/business/stacked/twsp.txd");

    CreateObject(-2005, 2112.939941, -1797.086425, 19.342802, 0.000000, 0.000000, 0.000000, 2500.00); 
    return true;
}

