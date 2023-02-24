#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 17738, 2459.359, -1486.125, 34.164, 0.250);
    RemoveBuildingForPlayer(playerid, 17855, 2490.906, -1474.343, 27.343, 0.250);
    RemoveBuildingForPlayer(playerid, 17856, 2492.320, -1484.804, 28.265, 0.250);
    RemoveBuildingForPlayer(playerid, 17852, 2490.906, -1474.343, 27.343, 0.250);
    RemoveBuildingForPlayer(playerid, 17853, 2492.320, -1484.804, 28.265, 0.250);
    RemoveBuildingForPlayer(playerid, 17537, 2459.359, -1486.125, 34.164, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadEastLSCWModel();
    EastLSCWMap();
    return true;
}

LoadEastLSCWModel() {
    AddSimpleModelEx(1923, -1010, "maps/env/eastls_carwash/Carwash1.dff", "maps/env/eastls_carwash/Carwash1.txd");
    AddSimpleModelEx(1923, -1011, "maps/env/eastls_carwash/Carwash2.dff", "maps/env/eastls_carwash/Carwash2.txd");
    AddSimpleModelEx(1923, -1012, "maps/env/eastls_carwash/Carwash3.dff", "maps/env/eastls_carwash/Carwash3.txd");
    AddSimpleModelEx(1923, -1013, "maps/env/eastls_carwash/Carwash4.dff", "maps/env/eastls_carwash/Carwash4.txd");
    AddSimpleModelEx(1923, -1014, "maps/env/eastls_carwash/Carwash5.dff", "maps/env/eastls_carwash/Carwash5.txd");
    AddSimpleModelEx(1923, -1015, "maps/env/eastls_carwash/Carwash6.dff", "maps/env/eastls_carwash/Carwash6.txd");
    AddSimpleModelEx(19478, -1016, "maps/env/eastls_carwash/Carwash7.dff", "maps/env/eastls_carwash/Carwash7.txd");

}

EastLSCWMap() {
    CreateModelObject(MODEL_TYPE_OBJECTS, -1012, 2487.681884, -1472.978027, 24.920999, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_BUILDINGS, -1014, 2459.358886, -1486.125000, 34.164001, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_LANDMASSES, -1015, 2490.906005, -1474.343994, 27.343999, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_BUILDINGS, -1013, 2492.320068, -1484.805053, 28.266000, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -1010, 2491.595947, -1483.687011, 29.267000, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -1011, 2487.531982, -1472.692016, 24.971000, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_2DFX, -1016, 2487.148925, -1471.589965, 25.089000, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1492, 2486.143066, -1488.586914, 28.021600, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1492, 2486.925781, -1482.743774, 28.011600, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1492, 2495.704345, -1482.743774, 28.011600, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 17951, 2487.983154, -1465.188720, 27.263986, 0.000000, 0.000000, 450.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 17951, 2482.233154, -1465.188720, 24.787927, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1492, 2492.720214, -1479.775146, 28.021600, 0.000000, 0.000000, 180.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1492, 2497.184082, -1488.579345, 28.021600, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1492, 2506.552001, -1471.892700, 23.028583, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1492, 2494.858642, -1465.361328, 23.027584, 0.000000, 0.000000, 180.000000); 
}