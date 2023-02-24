#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 5575, 1919.522, -1400.897, 16.170, 0.250);
    RemoveBuildingForPlayer(playerid, 1525, 1974.084, -1351.163, 24.562, 0.250);
    RemoveBuildingForPlayer(playerid, 708, 1966.709, -1360.093, 17.584, 0.250);
    RemoveBuildingForPlayer(playerid, 5390, 1919.522, -1400.897, 16.170, 0.250);
    RemoveBuildingForPlayer(playerid, 5415, 1916.937, -1400.890, 19.562, 0.250);
    RemoveBuildingForPlayer(playerid, 5663, 1919.444, -1400.881, 19.523, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 1958.881, -1395.194, 13.328, 0.250);
    RemoveBuildingForPlayer(playerid, 5400, 1913.131, -1370.500, 17.773, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 1933.241, -1376.171, 13.328, 0.250);
    RemoveBuildingForPlayer(playerid, 5660, 1916.053, -1426.241, 16.031, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 1971.819, -1411.875, 14.250, 0.250);
    RemoveBuildingForPlayer(playerid, 1266, 1978.148, -1371.148, 31.953, 0.250);
    RemoveBuildingForPlayer(playerid, 1260, 1978.148, -1371.148, 31.953, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadSkateParkModel();
    SkateParkMap();
    return true;
}

LoadSkateParkModel() {
    AddSimpleModelEx(5390, -2019, "maps/env/skatepark/SkatePark1.dff", "maps/env/skatepark/SkatePark.txd");
    AddSimpleModelEx(5415, -2020, "maps/env/skatepark/SkatePark2.dff", "maps/env/skatepark/SkatePark.txd");
    AddSimpleModelEx(5663, -2021, "maps/env/skatepark/SkatePark3.dff", "maps/env/skatepark/SkatePark.txd");
}

SkateParkMap() {
    CreateModelObject(MODEL_TYPE_LANDMASSES, -2019, 1919.523437, -1400.898437, 16.171899, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_LANDMASSES, -2020, 1916.937500, -1400.890625, 19.562500, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -2021, 1919.445312, -1400.882812, 19.523399, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 673, 1946.400390, -1366.500000, 15.800000, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 673, 1924.900024, -1419.699951, 12.300000, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1880.901367, -1425.971801, 14.100000, 0.000000, 0.000000, -22.499965); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1891.622802, -1426.369628, 14.100000, 0.000000, 0.000000, -128.699981); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1878.300048, -1407.300048, 14.100000, 0.000000, 0.000000, -69.500053); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1935.699951, -1446.400024, 12.800000, 0.000000, 0.000000, 270.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1891.913696, -1407.070190, 14.100000, 0.000000, 0.000000, -57.200031); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1878.010742, -1391.439575, 14.100000, 0.000000, 0.000000, -119.000007); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1891.400024, -1391.500000, 14.100000, 0.000000, 0.000000, -105.399978); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1869.450439, -1368.545288, 14.100000, 0.000000, 0.000000, -70.300048); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1891.800048, -1368.400024, 14.100000, 0.000000, 0.000000, 270.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1923.800048, -1372.099975, 15.000000, 0.000000, 0.000000, 270.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 620, 1951.199951, -1367.400024, 17.399999, 0.000000, 0.000000, 270.000000); 
}