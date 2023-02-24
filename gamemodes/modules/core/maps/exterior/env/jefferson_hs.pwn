#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 1297, 2278.546, -1544.179, 29.093, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2278.546, -1512.960, 29.093, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2300.367, -1544.179, 29.093, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2300.367, -1512.960, 29.093, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadJeffersonHSModel();
    JeffersonHSMap();
    return true;
}

LoadJeffersonHSModel() {
    AddSimpleModelEx(17522, -2017, "maps/env/jefferson_hs/LSJeffersonHighSchoolExt1.dff", "maps/env/jefferson_hs/LSJeffersonHighSchoolExt1.txd");
    AddSimpleModelEx(760, -2018, "maps/env/jefferson_hs/LSJeffersonHighSchoolExt2.dff", "maps/env/jefferson_hs/LSJeffersonHighSchoolExt2.txd");
}

JeffersonHSMap() {
    CreateModelObject(MODEL_TYPE_LANDMASSES, -2017, 2297.819091, -1513.084960, 27.853000, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_VEGETATION, -2018, 2304.758056, -1510.734008, 26.239000, 0.000000, 0.000000, 0.000000);
}