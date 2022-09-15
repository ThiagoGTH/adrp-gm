#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 3562, 2232.398, -1464.796, 25.648, 0.250);
    RemoveBuildingForPlayer(playerid, 3562, 2247.531, -1464.796, 25.546, 0.250);
    RemoveBuildingForPlayer(playerid, 3562, 2263.718, -1464.796, 25.437, 0.250);
    RemoveBuildingForPlayer(playerid, 3562, 2243.710, -1401.781, 25.640, 0.250);
    RemoveBuildingForPlayer(playerid, 3562, 2230.609, -1401.781, 25.640, 0.250);
    RemoveBuildingForPlayer(playerid, 3562, 2256.664, -1401.781, 25.640, 0.250);
    RemoveBuildingForPlayer(playerid, 5649, 2252.000, -1434.140, 23.257, 0.250);
    RemoveBuildingForPlayer(playerid, 713, 2275.390, -1438.664, 22.554, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2229.023, -1411.640, 22.960, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2265.617, -1410.335, 21.773, 0.250);
    RemoveBuildingForPlayer(playerid, 3582, 2230.609, -1401.781, 25.640, 0.250);
    RemoveBuildingForPlayer(playerid, 3582, 2243.710, -1401.781, 25.640, 0.250);
    RemoveBuildingForPlayer(playerid, 3582, 2256.664, -1401.781, 25.640, 0.250);
    RemoveBuildingForPlayer(playerid, 3582, 2232.398, -1464.796, 25.648, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2241.890, -1458.929, 22.960, 0.250);
    RemoveBuildingForPlayer(playerid, 3582, 2247.531, -1464.796, 25.546, 0.250);
    RemoveBuildingForPlayer(playerid, 3582, 2263.718, -1464.796, 25.437, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2227.203, -1444.500, 22.960, 0.250);
    RemoveBuildingForPlayer(playerid, 5428, 2252.000, -1434.140, 23.257, 0.250);
    RemoveBuildingForPlayer(playerid, 5682, 2241.429, -1433.671, 31.281, 0.250);
    RemoveBuildingForPlayer(playerid, 700, 2226.515, -1426.765, 23.117, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2243.570, -1423.609, 22.960, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2256.406, -1444.507, 23.101, 0.250);
    RemoveBuildingForPlayer(playerid, 3593, 2261.773, -1441.101, 23.500, 0.250);
    RemoveBuildingForPlayer(playerid, 3593, 2265.078, -1424.476, 23.500, 0.250);
    RemoveBuildingForPlayer(playerid, 645, 2239.570, -1468.800, 22.687, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2267.469, -1470.199, 21.718, 0.250);
    RemoveBuildingForPlayer(playerid, 1307, 2272.679, -1459.189, 22.054, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2273.639, -1434.150, 26.390, 0.250);
    RemoveBuildingForPlayer(playerid, 1307, 2225.419, -1456.390, 23.117, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2274.580, -1398.489, 22.507, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2280.469, -1395.760, 23.054, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2223.090, -1410.119, 23.312, 0.250);
    RemoveBuildingForPlayer(playerid, 1230, 2223.879, -1396.800, 23.304, 0.250);
    RemoveBuildingForPlayer(playerid, 1221, 2223.469, -1396.089, 23.375, 0.250);
    RemoveBuildingForPlayer(playerid, 1220, 2222.879, -1396.130, 23.304, 0.250);
    RemoveBuildingForPlayer(playerid, 1224, 2225.979, -1396.680, 23.531, 0.250);
    RemoveBuildingForPlayer(playerid, 1221, 2227.949, -1396.849, 23.375, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2252.590, -1394.410, 23.054, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2227.870, -1394.410, 23.054, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2224.419, -1473.040, 22.804, 0.250);
    RemoveBuildingForPlayer(playerid, 1220, 2222.959, -1469.739, 23.195, 0.250);
    RemoveBuildingForPlayer(playerid, 1221, 2226.850, -1404.739, 23.632, 0.250);
    RemoveBuildingForPlayer(playerid, 1221, 2253.219, -1409.890, 23.632, 0.250);
    RemoveBuildingForPlayer(playerid, 1230, 2255.979, -1457.910, 22.859, 0.250);
    RemoveBuildingForPlayer(playerid, 1220, 2256.659, -1456.900, 22.859, 0.250);
    RemoveBuildingForPlayer(playerid, 1221, 2251.290, -1461.829, 23.632, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2258.629, -1473.040, 22.804, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadCreenshawModel();
    CreenshawMap();
    return true;
}

LoadCreenshawModel() {
    AddSimpleModelEx(1923, -1120, "maps/env/creenshaw/Crenshaw1.dff", "maps/env/creenshaw/Crenshaw1.txd");
    AddSimpleModelEx(8674, -1121, "maps/env/creenshaw/Crenshaw2.dff", "maps/env/creenshaw/Crenshaw2.txd");
    AddSimpleModelEx(1923, -1122, "maps/env/creenshaw/Crenshaw3.dff", "maps/env/creenshaw/Crenshaw3.txd");
    AddSimpleModelEx(1923, -1123, "maps/env/creenshaw/Crenshaw4.dff", "maps/env/creenshaw/Crenshaw4.txd");
    AddSimpleModelEx(1923, -1124, "maps/env/creenshaw/Crenshaw5.dff", "maps/env/creenshaw/Crenshaw5.txd");
    AddSimpleModelEx(1923, -1125, "maps/env/creenshaw/Crenshaw6.dff", "maps/env/creenshaw/Crenshaw6.txd");
}

CreenshawMap() {
    CreateModelObject(MODEL_TYPE_BUILDINGS, -1120, 2229.474121, -1434.008056, 24.916900, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_VEGETATION, -1121, 2241.429931, -1433.671752, 31.281000, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_LANDMASSES, -1122, 2249.512939, -1433.354858, 22.931900, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_BUILDINGS, -1123, 2224.858886, -1431.989013, 24.332000, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_OBJECTS, -1124, 2235.562988, -1429.510742, 26.239000, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_OBJECTS, -1125, 2257.110595, -1436.774536, 23.354000, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_OBJECTS, -1125, 2263.039306, -1400.562622, 27.234800, 0.000000, 0.000000, 0.000000);
}