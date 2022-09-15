#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 5207, 2167.039, -1925.203, 15.828, 0.250);
    RemoveBuildingForPlayer(playerid, 5208, 2115.000, -1921.523, 15.390, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2159.828, -1930.632, 15.078, 0.250);
    RemoveBuildingForPlayer(playerid, 3567, 2142.914, -1947.421, 13.265, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2114.554, -1928.187, 5.031, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2113.398, -1925.039, 10.804, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2115.671, -1922.765, 10.804, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2123.359, -1928.070, 6.843, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 2159.828, -1930.632, 15.078, 0.250);
    RemoveBuildingForPlayer(playerid, 5181, 2167.039, -1925.203, 15.828, 0.250);
    RemoveBuildingForPlayer(playerid, 5182, 2115.000, -1921.523, 15.390, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2122.656, -1916.789, 10.804, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2116.929, -1916.078, 10.804, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2121.507, -1909.531, 10.804, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2110.273, -1906.585, 5.031, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2118.289, -1939.398, 16.390, 0.250);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModelEx(1923, -1223, "maps/env/westmont/Westmont1.dff", "maps/env/westmont/Westmont1.txd");
    AddSimpleModelEx(1923, -1224, "maps/env/westmont/Westmont2.dff", "maps/env/westmont/Westmont2.txd");
    AddSimpleModelEx(19478, -1225, "maps/env/westmont/Westmont3.dff", "maps/env/westmont/Westmont3.txd");

    CreateModelObject(MODEL_TYPE_BUILDINGS, -1223, 2167.039062, -1925.203125, 15.828100, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_BUILDINGS, -1224, 2115.000000, -1921.523437, 15.390000, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_VEGETATION, -1225, 2115.000000, -1921.523437, 15.390600, 0.000000, 0.000000, 0.000000);

    new tmpobjid;
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 19772, 2133.663574, -1947.373657, 13.035597, 0.000000, 0.000000, 360.000000); 
    SetObjectMaterial(tmpobjid, 0, 1220, "boxes", "cardboxes_128", 0xFFFFFFFF);
    CreateModelObject(MODEL_TYPE_OBJECTS, 946, 2143.109619, -1941.089355, 14.704661, 0.000000, 0.000000, 270.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 2114, 2147.359375, -1940.924072, 12.684659, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 946, 2156.798339, -1941.160156, 14.707798, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1308, 2092.035156, -1904.749389, 12.807279, -5.299998, 0.000000, 35.800010); 
    return true;
}

