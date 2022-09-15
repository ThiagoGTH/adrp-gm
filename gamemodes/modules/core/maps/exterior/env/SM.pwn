#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 6443, 301.937, -1657.810, 19.648, 0.250);
    RemoveBuildingForPlayer(playerid, 6445, 301.937, -1657.810, 19.648, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 233.602, -1625.900, 31.819, 0.250);
    RemoveBuildingForPlayer(playerid, 712, 245.093, -1636.650, 41.319, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 260.226, -1646.438, 31.881, 0.250);
    RemoveBuildingForPlayer(playerid, 621, 276.381, -1650.550, 31.288, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 276.992, -1653.560, 32.929, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 282.351, -1654.500, 32.967, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 287.539, -1656.109, 33.000, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 292.625, -1658.050, 33.014, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 297.867, -1659.229, 32.905, 0.250);
    RemoveBuildingForPlayer(playerid, 1215, 400.390, -2086.418, 7.375, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 303.303, -1659.650, 33.022, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 308.742, -1660.000, 33.039, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 314.209, -1660.468, 33.084, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 319.648, -1660.880, 33.139, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 325.078, -1661.229, 33.101, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 330.342, -1661.680, 33.187, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 335.781, -1662.098, 33.242, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 341.217, -1662.448, 33.194, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 346.648, -1662.800, 33.006, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 352.078, -1663.229, 32.671, 0.250);
    RemoveBuildingForPlayer(playerid, 1408, 357.506, -1663.578, 32.429, 0.250);
    RemoveBuildingForPlayer(playerid, 712, 354.756, -1659.338, 41.319, 0.250);
    RemoveBuildingForPlayer(playerid, 1368, 328.062, -1652.088, 32.967, 0.250);
    RemoveBuildingForPlayer(playerid, 621, 323.428, -1659.619, 31.288, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 339.953, -1662.239, 31.131, 0.250);
    RemoveBuildingForPlayer(playerid, 730, 311.570, -1657.160, 31.920, 0.250);
    RemoveBuildingForPlayer(playerid, 1291, 300.375, -1645.380, 32.756, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 295.928, -1659.098, 31.975, 0.250);
    RemoveBuildingForPlayer(playerid, 6444, 285.265, -1611.949, 34.335, 0.250);

    RemoveBuildingForPlayer(playerid, 3615, 553.351, -1875.000, 4.789, 0.250);
    RemoveBuildingForPlayer(playerid, 3778, 553.351, -1875.000, 4.789, 0.250);
    RemoveBuildingForPlayer(playerid, 6281, 570.742, -1868.338, 1.679, 0.250);
    RemoveBuildingForPlayer(playerid, 6442, 570.742, -1868.338, 1.679, 0.250);

    return true;
}

hook OnGameModeInit() {
    LoadSMModels();
    SMExterior();
    return true;
}

LoadSMModels() {
    AddSimpleModelEx(19379, -20020, "maps/env/SM/alooouctuk.dff", "maps/env/SM/alooouctuk.txd");
    AddSimpleModelEx(703, -20019, "maps/env/SM/cicekbocek.dff", "maps/env/SM/cicekbocek.txd");
    AddSimpleModelEx(19379, -20018, "maps/env/SM/beach.dff", "maps/env/SM/beach.txd");
}

SMExterior() {
    CreateModelObject(MODEL_TYPE_BUILDINGS, -20020, 301.937988, -1657.810058, 19.648399, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_VEGETATION, -20019, 333.711608, -1659.509033, 32.586444, 0.000000, 0.000000, 0.000000); 

    CreateModelObject(MODEL_TYPE_OBJECTS, 11706, 249.081771, -1648.803833, 32.245185, 0.000000, 0.000000, -58.899906); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1280, 253.318908, -1650.956420, 32.655174, 0.000000, 0.000000, 61.100006); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1280, 258.712829, -1653.938354, 32.655174, 0.000000, 0.000000, 61.100006); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 951, 264.120819, -1657.965820, 32.999980, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 11706, 280.922424, -1661.228759, 32.245185, -0.000006, 0.000003, -49.599811); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1280, 284.160766, -1660.622436, 32.655174, 0.000006, 0.000003, 89.400001); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1280, 293.964172, -1660.731689, 32.655174, 0.000006, 0.000003, 89.400001); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 951, 297.864013, -1661.431884, 32.999980, 0.000000, 0.000007, 28.300008); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 951, 316.605773, -1661.310424, 32.999980, 0.000000, 0.000007, -4.999982); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 951, 322.877197, -1661.298339, 32.999980, 0.000000, 0.000007, -4.999982); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1223, 241.910537, -1634.728515, 32.249961, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1223, 254.690383, -1641.979614, 32.249961, 0.000000, 0.000000, -142.799987); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1223, 270.030426, -1651.226440, 32.249961, 0.000000, 0.000000, -142.799987); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1223, 285.988525, -1657.718872, 32.249961, 0.000000, 0.000000, -90.400100); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1223, 298.054107, -1654.041015, 32.249961, 0.000000, 0.000000, -53.900012); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1223, 311.208190, -1655.832275, 32.249961, 0.000000, 0.000000, 58.799991); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1223, 328.787506, -1654.328735, 32.249961, 0.000000, 0.000000, -111.800018); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 1223, 335.851928, -1657.148925, 32.249961, 0.000000, 0.000000, 143.500076); 

    CreateModelObject(MODEL_TYPE_LANDMASSES, -20018, 570.742187, -1868.343750, 1.679700, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 621, 538.106994, -1877.442016, 4.695919, 0.000000, 0.000000, 143.500076); 
    CreateModelObject(MODEL_TYPE_OBJECTS, 647, 540.063415, -1879.286376, 5.132755, 0.000000, 0.000000, 143.500076); 
}