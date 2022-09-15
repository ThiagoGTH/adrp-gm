#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 17722, 2411.164, -1402.882, 28.015, 0.250);
    RemoveBuildingForPlayer(playerid, 3593, 2407.312, -1418.359, 23.687, 0.250);
    RemoveBuildingForPlayer(playerid, 17636, 2411.164, -1402.882, 28.015, 0.250);
    RemoveBuildingForPlayer(playerid, 3593, 2413.328, -1399.609, 23.687, 0.250);
    RemoveBuildingForPlayer(playerid, 700, 2413.578, -1409.859, 22.546, 0.250);
    RemoveBuildingForPlayer(playerid, 17527, 2414.398, -1362.203, 32.601, 0.250);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModel (-1, 8674, -1066, "maps/env/eastls_church/EastLSChurch1.dff", "maps/env/eastls_church/EastLSChurch1.txd");
    AddSimpleModel (-1, 1923, -1067, "maps/env/eastls_church/EastLSChurch2.dff", "maps/env/eastls_church/EastLSChurch2.txd");
    AddSimpleModel (-1, 1923, -1068, "maps/env/eastls_church/EastLSChurch3.dff", "maps/env/eastls_church/EastLSChurch3.txd");

    CreateModelObject(MODEL_TYPE_VEGETATION, -1066, 2414.398437, -1362.203125, 32.601600, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_LANDMASSES, -1067, 2411.164062, -1402.883056, 28.016000, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_BUILDINGS, -1068, 2422.093017, -1426.369018, 28.738000, 0.000000, 0.000000, 0.000000); 
    return true;
}
