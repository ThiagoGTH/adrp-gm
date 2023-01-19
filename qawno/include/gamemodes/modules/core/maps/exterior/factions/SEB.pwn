#include <YSI_Coding\y_hooks>

hook OnGameModeInit(){
    LoadSEBExterior();
}

LoadSEBExterior() {
    AddSimpleModelEx(5076, -20013, "maps/factions/LSSD/SEB/sebmap1obje1.dff", "maps/factions/LSSD/SEB/sebmap1.txd");
    AddSimpleModelEx(1923, -20014, "maps/factions/LSSD/SEB/sebmap1obje2.dff", "maps/factions/LSSD/SEB/sebmap1.txd");
    AddSimpleModelEx(16335, -20015, "maps/factions/LSSD/SEB/sebmap2obje1.dff", "maps/factions/LSSD/SEB/sebmap2.txd");
    AddSimpleModelEx(16335, -20016, "maps/factions/LSSD/SEB/sebmap3obje1.dff", "maps/factions/LSSD/SEB/sebmap3.txd");


    CreateModelObject(MODEL_TYPE_LANDMASSES, -20013, 1258.679687, -2577.980224, 12.940196, -0.000014, 0.000014, 0.000014);
    CreateModelObject(MODEL_TYPE_BUILDINGS, -20014, 1258.679199, -2577.932617, 12.986080, -0.000014, 0.000014, 0.000014);
    CreateModelObject(MODEL_TYPE_OBJECTS, -20015, 1258.870849, -2578.257568, 12.890298, -0.000014, 0.000014, 0.000014);
    CreateModelObject(MODEL_TYPE_OBJECTS, -20016, 1258.690307, -2577.994628, 12.940208, 0.000000, 0.000000, 0.000000);

    new tmpobjid;
    tmpobjid = CreateDynamicObject(19552, 1337.432861, -2623.998046, 12.552095, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14634, "blindinglite", "ws_volumetriclight", 0x00FFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19552, 1271.371337, -2623.998046, 12.552095, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14634, "blindinglite", "ws_volumetriclight", 0x00FFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19552, 1337.432861, -2571.958496, 12.552095, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14634, "blindinglite", "ws_volumetriclight", 0x00FFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19552, 1271.354492, -2571.958496, 12.552095, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14634, "blindinglite", "ws_volumetriclight", 0x00FFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFFFFFFFF);
}
