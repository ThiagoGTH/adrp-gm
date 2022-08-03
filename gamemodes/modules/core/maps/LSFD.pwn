#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 4594, 1825.000, -1413.930, 12.554, 0.250);
    RemoveBuildingForPlayer(playerid, 4606, 1825.000, -1413.930, 12.554, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadLSFDModels();
    LSFDExterior();
    return true;
}

LoadLSFDModels() {
	AddSimpleModel (-1, 19379, -1001, "maps/Factions/LSFD/1.dff", "maps/Factions/LSFD/1.txd");
	AddSimpleModel (-1, 19379, -1002, "maps/Factions/LSFD/2.dff", "maps/Factions/LSFD/2.txd");
	AddSimpleModel (-1, 19379, -1003, "maps/Factions/LSFD/3.dff", "maps/Factions/LSFD/3.txd");
	AddSimpleModel (-1, 19379, -1004, "maps/Factions/LSFD/4.dff", "maps/Factions/LSFD/4.txd");
	AddSimpleModel (-1, 19379, -1005, "maps/Factions/LSFD/5.dff", "maps/Factions/LSFD/5.txd");
	AddSimpleModel (-1, 19379, -1006, "maps/Factions/LSFD/6.dff", "maps/Factions/LSFD/6.txd");
	AddSimpleModel (-1, 19379, -1007, "maps/Factions/LSFD/7.dff", "maps/Factions/LSFD/7.txd");
	AddSimpleModel (-1, 19379, -1008, "maps/Factions/LSFD/8.dff", "maps/Factions/LSFD/8.txd");
	AddSimpleModel (-1, 19379, -1009, "maps/Factions/LSFD/9.dff", "maps/Factions/LSFD/9.txd");
	AddSimpleModel (-1, 19379, -1010, "maps/Factions/LSFD/10.dff", "maps/Factions/LSFD/10.txd");
	AddSimpleModel (-1, 19379, -1011, "maps/Factions/LSFD/11.dff", "maps/Factions/LSFD/11.txd");
	AddSimpleModel (-1, 19379, -1012, "maps/Factions/LSFD/12.dff", "maps/Factions/LSFD/12.txd");
	AddSimpleModel (-1, 19379, -1013, "maps/Factions/LSFD/13.dff", "maps/Factions/LSFD/13.txd");
	AddSimpleModel (-1, 19379, -1013, "maps/Factions/LSFD/13.dff", "maps/Factions/LSFD/13.txd");
	AddSimpleModel (-1, 19379, -1014, "maps/Factions/LSFD/14.dff", "maps/Factions/LSFD/14.txd");
	AddSimpleModel (-1, 19379, -1015, "maps/Factions/LSFD/15.dff", "maps/Factions/LSFD/15.txd");
}

LSFDExterior() {
    new tmpobjid;
    tmpobjid = CreateDynamicObject(-1012, 1825.311035, -1436.289428, 28.371561, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(-1014, 1823.653564, -1436.594116, 18.061338, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1500, 1827.157592, -1442.668334, 12.541872, 0.000000, 0.000000, 163.799758, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1814, 1817.889892, -1435.567016, 18.370243, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1708, 1817.936767, -1433.448974, 18.398643, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14653, "ab_trukstpb", "met_supp", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 1714, "cj_office", "est_chair", 0x00000000);
    tmpobjid = CreateDynamicObject(1708, 1818.927734, -1436.712158, 18.398643, 0.000000, -0.000014, 179.999908, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14653, "ab_trukstpb", "met_supp", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 1714, "cj_office", "est_chair", 0x00000000);
    tmpobjid = CreateDynamicObject(2206, 1817.115478, -1434.128295, 18.378643, -0.000014, 0.000000, -89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1964, 1816.958862, -1434.785034, 19.468666, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 6, 19480, "signsurf", "sign", 0x00000000);
    tmpobjid = CreateDynamicObject(2190, 1817.365478, -1434.464477, 19.308664, -0.000014, 0.000000, -89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19808, 1816.765747, -1434.335937, 19.328664, -0.000014, 0.000000, -86.500000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2247, 1818.288574, -1434.961181, 19.298664, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19999, 1815.614013, -1435.064086, 18.398643, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "est_chair", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2690, 1832.453125, -1439.510986, 12.911767, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2690, 1832.233642, -1439.291503, 12.911767, 0.000000, 0.000000, 540.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(930, 1833.130371, -1439.242919, 13.041769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 5397, "barrio1_lae", "cargo7_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, 5397, "barrio1_lae", "cargo7_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 3, 11391, "hubprops2_sfse", "CJ_fire", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2161, 1813.808959, -1436.828247, 18.388643, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1998, 1824.577148, -1444.591430, 12.566490, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 3, 1714, "cj_office", "CJ_FILE", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2356, 1824.474731, -1445.796752, 12.596006, 0.000000, 0.000000, -34.900112, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "est_chair", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11713, 1823.306640, -1446.200683, 14.125845, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2611, 1824.552978, -1446.144653, 14.075909, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
    tmpobjid = CreateDynamicObject(2001, 1823.239135, -1445.931640, 12.555958, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "CJ_DESK", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19825, 1822.890625, -1445.536254, 14.365262, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11709, 1816.384033, -1440.510864, 13.236843, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "chromepipe2_32hv", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2001, 1814.187255, -1440.379272, 12.555958, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "CJ_DESK", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1771, 1819.523437, -1429.589843, 18.998657, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(1771, 1819.523437, -1429.589843, 20.028680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(1771, 1816.042114, -1429.589843, 18.998657, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(1771, 1816.042602, -1429.589843, 20.038681, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2197, 1818.137207, -1429.612060, 18.398643, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "CJ_FILE", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2197, 1817.446533, -1429.612060, 18.398643, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "CJ_FILE", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(16378, 1816.115356, -1424.720458, 19.138660, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "CJ_FILE", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "CJ_FILE", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 5, 1714, "cj_office", "white32", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 6, 1714, "cj_office", "white32", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 1714, "cj_office", "CJ_FILE", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1771, 1819.523437, -1424.227783, 18.998657, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(1771, 1819.523437, -1424.228637, 20.028680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2001, 1821.710327, -1423.619018, 18.376007, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "CJ_DESK", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19825, 1817.573608, -1422.942993, 19.985332, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2001, 1816.258789, -1423.168579, 18.376007, 0.000000, 0.000000, 33.200038, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "CJ_DESK", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(15036, 1828.540405, -1449.218627, 19.368665, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14651, "ab_trukstpd", "Bow_bar_metal_cabinet", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14535, "ab_wooziec", "wall4", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14651, "ab_trukstpd", "Bow_bar_metal_cabinet", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14535, "ab_wooziec", "wall4", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14535, "ab_wooziec", "wall4", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14535, "ab_wooziec", "wall4", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14535, "ab_wooziec", "wall4", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14535, "ab_wooziec", "wall4", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14535, "ab_wooziec", "wall4", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14535, "ab_wooziec", "wall4", 0x00000000);
    tmpobjid = CreateDynamicObject(1968, 1835.179687, -1448.001953, 18.908653, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "est_chair", 0x00000000);
    tmpobjid = CreateDynamicObject(1968, 1833.209228, -1448.001953, 18.908653, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "est_chair", 0x00000000);
    tmpobjid = CreateDynamicObject(2001, 1831.272827, -1450.141601, 18.376007, 0.000000, 0.000000, 33.200038, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "chromepipe2_32hv", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11631, 1829.317993, -1440.390625, 19.628671, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2356, 1829.089111, -1441.462646, 18.396068, 0.000000, 0.000000, -37.300151, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "est_chair", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2608, 1829.276977, -1439.951660, 20.278671, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2001, 1827.896606, -1440.142700, 18.376007, 0.000000, 0.000000, 33.200038, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "chromepipe2_32hv", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(14493, 1835.087280, -1440.971557, 20.698694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "est_chair", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "est_chair", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 1714, "cj_office", "est_chair", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 1714, "cj_office", "est_chair", 0x00000000);
    tmpobjid = CreateDynamicObject(2091, 1836.317749, -1443.282836, 17.758628, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2627, 1835.288085, -1428.015380, 18.398643, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2627, 1835.288085, -1429.556640, 18.398643, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2628, 1834.894531, -1425.084228, 18.398643, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2628, 1833.086669, -1425.061279, 18.398643, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11730, 1828.026733, -1423.159301, 18.398643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2630, 1829.738891, -1424.066772, 18.398643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2630, 1831.120239, -1424.066772, 18.398643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11730, 1827.366088, -1423.159301, 18.398643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2197, 1826.666992, -1423.840454, 18.398643, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "CJ_FILE", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2197, 1828.688964, -1423.830444, 18.398643, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "CJ_FILE", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2631, 1828.534545, -1429.109741, 18.398643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2632, 1828.524536, -1431.553710, 18.392313, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3071, 1827.516113, -1430.340942, 18.598648, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "weight1", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 2627, "genintint_gym", "weight1", 0x00000000);
    tmpobjid = CreateDynamicObject(3071, 1827.826416, -1430.340942, 18.598648, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "weight1", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 2627, "genintint_gym", "weight1", 0x00000000);
    tmpobjid = CreateDynamicObject(11745, 1829.025390, -1430.327392, 18.545984, 0.000000, 0.000000, 84.500022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(14493, 1831.378417, -1436.430541, 20.698694, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "est_chair", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "est_chair", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 1714, "cj_office", "est_chair", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 1714, "cj_office", "est_chair", 0x00000000);
    tmpobjid = CreateDynamicObject(2296, 1829.298339, -1439.291137, 18.398643, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 3, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 4, 1714, "cj_office", "white32", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2186, 1836.054077, -1437.405761, 18.398643, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2186, 1830.781616, -1440.226440, 18.398643, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2637, 1828.289916, -1436.167358, 18.788652, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14653, "ab_trukstpb", "met_supp", 0x00000000);
    tmpobjid = CreateDynamicObject(2001, 1826.654785, -1438.980834, 18.376007, 0.000000, 0.000000, 33.200038, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "chromepipe2_32hv", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2001, 1830.064819, -1439.019409, 18.376007, 0.000000, 0.000000, 33.200038, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "chromepipe2_32hv", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2221, 1828.387573, -1435.865600, 19.288663, 0.000000, 0.000000, 31.799989, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2858, 1828.250732, -1436.566894, 19.218658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2867, 1833.155029, -1447.972167, 19.168659, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2637, 1834.062133, -1444.027221, 18.788652, 0.000014, -0.000007, 179.999877, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14653, "ab_trukstpb", "met_supp", 0x00000000);
    tmpobjid = CreateDynamicObject(2221, 1833.760375, -1443.929565, 19.288663, 0.000014, 0.000007, 121.799934, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2858, 1834.461669, -1444.066406, 19.218658, 0.000007, 0.000014, 89.999946, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2608, 1836.310058, -1437.969726, 20.568677, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3089, 1822.132812, -1427.643554, 19.726032, 0.000000, 0.000000, 158.700332, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
    tmpobjid = CreateDynamicObject(3089, 1826.266235, -1427.657836, 19.726032, 0.000000, 0.000000, 7.500000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
    tmpobjid = CreateDynamicObject(3089, 1826.266235, -1443.899169, 19.726032, 0.000000, 0.000000, -26.800022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
    tmpobjid = CreateDynamicObject(2167, 1821.514892, -1431.129516, 18.381361, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "CJ_FILE", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2186, 1820.877685, -1438.700927, 18.398643, -0.000007, 0.000000, 179.999893, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2608, 1820.313720, -1438.956909, 20.568677, -0.000007, 0.000000, 179.999893, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2613, 1821.807006, -1437.857788, 18.388643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1808, 1820.764404, -1431.311157, 18.398643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2613, 1820.645874, -1430.405761, 18.388643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2163, 1813.821166, -1435.495849, 18.388643, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "CJ_FILE", 0x00000000);
    tmpobjid = CreateDynamicObject(2161, 1813.808959, -1433.725219, 18.388643, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2001, 1814.136352, -1437.690429, 18.376007, 0.000000, 0.000000, 33.200038, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "chromepipe2_32hv", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2001, 1814.139892, -1432.485717, 18.376007, 0.000000, 0.000000, 33.200038, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "chromepipe2_32hv", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1964, 1814.376342, -1435.665893, 19.458667, 0.000007, 0.000000, 269.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 3, 19480, "signsurf", "sign", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 19480, "signsurf", "sign", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 19480, "signsurf", "sign", 0x00000000);
    tmpobjid = CreateDynamicObject(2737, 1817.114990, -1439.114746, 20.038681, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 2567, "ab", "chipboard_256", 0x00000000);
    tmpobjid = CreateDynamicObject(2611, 1815.322143, -1439.124389, 20.165935, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
    tmpobjid = CreateDynamicObject(2280, 1817.832641, -1438.655639, 19.858669, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19165, "gtamap", "gtasamapbit4", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 19480, "signsurf", "sign", 0x00000000);
    tmpobjid = CreateDynamicObject(19787, 1817.266967, -1431.080322, 20.288686, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 2811, "gb_ornaments01", "GB_photo02", 0x00000000);
    tmpobjid = CreateDynamicObject(2162, 1816.861328, -1431.118530, 18.388643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(-1001, 1824.991333, -1432.688598, 18.072029, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1002, 1822.325805, -1447.005981, 17.189918, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1003, 1828.043579, -1435.414428, 20.265829, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1005, 1823.650512, -1436.598632, 18.039613, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1006, 1820.255615, -1430.212280, 13.684119, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1007, 1833.808349, -1439.496337, 15.940453, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1007, 1815.298095, -1439.496337, 15.940453, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1008, 1831.817749, -1431.300292, 15.933935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1008, 1823.647583, -1431.300292, 15.933935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1825.432128, -1422.980834, 13.759667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1823.912475, -1422.980834, 13.759667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1823.131835, -1422.980834, 13.759667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1820.080078, -1422.980834, 13.759667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1818.560668, -1422.980834, 13.759667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1817.799926, -1422.980834, 13.759667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1817.029174, -1422.980834, 13.759667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1813.991333, -1445.273559, 13.769665, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1009, 1813.991333, -1448.143310, 13.769665, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1010, 1824.152221, -1429.402343, 24.597908, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1011, 1825.313964, -1436.305297, 28.370359, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1013, 1828.005371, -1435.345092, 20.163671, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1015, 1836.828369, -1436.211425, 20.581331, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19330, 1831.604370, -1439.369873, 14.771830, -3.399991, -90.699981, 56.400093, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19330, 1831.126953, -1439.437011, 14.776515, -3.399991, -90.699981, 56.400093, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19331, 1830.545898, -1439.503417, 14.784294, -4.600017, 270.000000, -38.799999, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11738, 1829.565673, -1439.444458, 14.714138, 0.000000, 0.000000, 155.599990, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11736, 1828.929931, -1439.453979, 14.693058, 0.000000, 0.000000, 24.899993, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11736, 1828.554077, -1439.431884, 14.693058, 0.000000, 0.000000, 76.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2114, 1827.821899, -1438.265502, 24.308223, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(946, 1815.019042, -1441.900878, 26.315401, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(946, 1835.326660, -1441.900878, 26.315401, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(-1004, 1819.751953, -1428.036621, 36.033473, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(955, 1826.569458, -1441.327758, 12.946596, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2629, 1834.877685, -1431.641723, 18.398643, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2629, 1834.877685, -1433.692871, 18.398643, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3785, 1825.104248, -1432.815063, 27.402139, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3785, 1817.805419, -1433.405883, 27.402139, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3785, 1827.275146, -1447.224487, 16.792165, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3785, 1827.275146, -1441.421020, 16.792165, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3785, 1828.866699, -1440.590209, 16.792165, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3785, 1833.601196, -1440.590209, 16.792165, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 

}