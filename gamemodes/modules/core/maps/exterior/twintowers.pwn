#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 3999, 1785.976, -1564.859, 25.250, 0.250);
    RemoveBuildingForPlayer(playerid, 4080, 1787.132, -1565.679, 11.968, 0.250);
    RemoveBuildingForPlayer(playerid, 4099, 1770.046, -1549.414, 10.468, 0.250);
    RemoveBuildingForPlayer(playerid, 4079, 1785.976, -1564.859, 25.250, 0.250);
    RemoveBuildingForPlayer(playerid, 4189, 1794.617, -1576.734, 17.757, 0.250);
    RemoveBuildingForPlayer(playerid, 4000, 1787.132, -1565.679, 11.968, 0.250);
    RemoveBuildingForPlayer(playerid, 4081, 1734.304, -1560.710, 18.882, 0.250);
    RemoveBuildingForPlayer(playerid, 3998, 1734.304, -1560.710, 18.882, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadTwinTowersModel();
    TwinTowersMap();
    return true;
}

LoadTwinTowersModel() {
    AddSimpleModelEx(19478, -27523, "maps/twintowers/TwinTowerExtCF1.dff", "maps/twintowers/TwinTowerExtCF1.txd");
    AddSimpleModelEx(19379, -27524, "maps/twintowers/TwinTowerExtCF2.dff", "maps/twintowers/TwinTowerExtCF2.txd");
    AddSimpleModelEx(19379, -27525, "maps/twintowers/TwinTowerExtCF3.dff", "maps/twintowers/TwinTowerExtCF3.txd");
    AddSimpleModelEx(11680, -27526, "maps/twintowers/TwinTowerExtCF4.dff", "maps/twintowers/TwinTowerExtCF4.txd");
}

TwinTowersMap() {
    new tmpobjid;
    tmpobjid = CreateObject(2949, 1815.108154, -1556.800659, 12.351396, 0.000000, 0.000000, 162.500305, 300.00); 
    SetObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateObject(6400, 1813.867431, -1560.537475, 14.676898, 0.000000, 0.000000, -18.000011, 300.00); 
    SetObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateObject(19379, 1814.530639, -1558.266845, 12.366870, 0.000000, 90.000000, -17.500000, 300.00); 
    SetObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
    tmpobjid = CreateObject(19303, 1781.261962, -1538.923950, 10.141797, 0.000000, 0.000000, -82.800079, 300.00); 
    tmpobjid = CreateObject(19795, 1824.372436, -1534.698852, 14.276894, -0.000003, 0.000014, -15.900507, 300.00); 
    tmpobjid = CreateObject(19795, 1822.591918, -1540.949462, 14.276894, 0.000003, -0.000014, 164.099319, 300.00); 
    tmpobjid = CreateObject(19303, 1760.930053, -1561.650146, 9.863517, 0.000000, 0.000000, 719.900024, 300.00); 
    tmpobjid = CreateObject(988, 1781.072875, -1533.904663, 8.783114, 0.000000, 0.000000, 88.200019, 300.00); 

    CreateModelObject(MODEL_TYPE_LANDMASSES, -27524, 1787.133056, -1565.680053, 11.968997, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -27525, 1743.070190, -1563.600585, 9.459500, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_2DFX, -27526, 1740.268188, -1562.018432, 8.450696, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_BUILDINGS, -27523, 1733.418701, -1564.965942, 20.466400, 0.000000, 0.000000, 0.000000); 

}