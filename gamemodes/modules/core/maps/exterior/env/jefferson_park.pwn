#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 3563, 2184.976, -1359.789, 27.226, 0.250);
    RemoveBuildingForPlayer(playerid, 3562, 2202.578, -1359.132, 27.257, 0.250);
    RemoveBuildingForPlayer(playerid, 5584, 2218.890, -1342.554, 25.242, 0.250);
    RemoveBuildingForPlayer(playerid, 1527, 2233.953, -1367.617, 24.531, 0.250);
    RemoveBuildingForPlayer(playerid, 714, 2217.023, -1320.804, 22.507, 0.250);
    RemoveBuildingForPlayer(playerid, 3555, 2184.976, -1359.789, 27.226, 0.250);
    RemoveBuildingForPlayer(playerid, 3582, 2202.578, -1359.132, 27.257, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2226.875, -1371.210, 22.523, 0.250);
    RemoveBuildingForPlayer(playerid, 5635, 2182.289, -1324.750, 28.601, 0.250);
    RemoveBuildingForPlayer(playerid, 5426, 2218.890, -1342.554, 25.242, 0.250);
    RemoveBuildingForPlayer(playerid, 5654, 2263.523, -1312.625, 37.078, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadJeffersonParkModel();
    JeffersonParkMap();
    return true;
}

LoadJeffersonParkModel() {
    AddSimpleModelEx(1923, -1207, "maps/env/jefferson_park/JeffersonPark1.dff", "maps/env/jefferson_park/JeffersonPark1.txd");
    AddSimpleModelEx(1923, -1208, "maps/env/jefferson_park/JeffersonPark2.dff", "maps/env/jefferson_park/JeffersonPark2.txd");
    AddSimpleModelEx(19478, -1209, "maps/env/jefferson_park/JeffersonPark3.dff", "maps/env/jefferson_park/JeffersonPark3.txd");
    AddSimpleModelEx(19325, -1210, "maps/env/jefferson_park/JeffersonPark4.dff", "maps/env/jefferson_park/JeffersonPark4.txd");
    AddSimpleModelEx(5635, -1211, "maps/env/jefferson_park/JeffersonPark5.dff", "maps/env/jefferson_park/JeffersonPark5.txd");
    AddSimpleModelEx(5265, -1212, "maps/env/jefferson_park/JeffersonPark6.dff", "maps/env/jefferson_park/JeffersonPark6.txd");
}

JeffersonParkMap() {
    CreateModelObject(MODEL_TYPE_LANDMASSES, -1207, 2219.013427, -1342.268066, 23.001600, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_OBJECTS, -1208, 2219.118652, -1342.496093, 25.214599, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_VEGETATION, -1209, 2210.675292, -1318.487792, 23.976999, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_2DFX, -1210, 2210.675292, -1318.487792, 23.976999, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_VEGETATION, -1211, 2182.289062, -1324.750000, 28.601600, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_VEGETATION, -1212, 2263.520019, -1312.630004, 37.080001, 0.000000, 0.000000, 0.000000);
}