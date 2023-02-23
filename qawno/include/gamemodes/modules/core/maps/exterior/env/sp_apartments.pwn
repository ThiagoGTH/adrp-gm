#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
    RemoveBuildingForPlayer(playerid, 17729, 2540.8281, -1350.5859, 40.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 17954, 2577.2344, -1350.3984, 56.5391, 0.25);
    RemoveBuildingForPlayer(playerid, 17679, 2540.8281, -1350.5859, 40.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 17591, 2606.3828, -1341.8438, 47.5469, 0.25);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModelEx(1923, -20080, "maps/env/sanpedro/apartments/SanPedroHouse1.dff", "maps/env/sanpedro/apartments/SanPedroHouse1.txd");
    AddSimpleModelEx(1923, -20081, "maps/env/sanpedro/apartments/SanPedroHouse2.dff", "maps/env/sanpedro/apartments/SanPedroHouse2.txd");
    AddSimpleModelEx(1923, -20082, "maps/env/sanpedro/apartments/SanPedroHouse3.dff", "maps/env/sanpedro/apartments/SanPedroHouse3.txd");
    AddSimpleModelEx(1923, -20083, "maps/env/sanpedro/apartments/SanPedroHouse4.dff", "maps/env/sanpedro/apartments/SanPedroHouse4.txd");
    AddSimpleModelEx(1923, -20084, "maps/env/sanpedro/apartments/SanPedroHouse5.dff", "maps/env/sanpedro/apartments/SanPedroHouse5.txd");
    AddSimpleModelEx(1923, -20085, "maps/env/sanpedro/apartments/SanPedroHouse6.dff", "maps/env/sanpedro/apartments/SanPedroHouse6.txd");
    AddSimpleModelEx(1923, -20086, "maps/env/sanpedro/apartments/SanPedroHouse7.dff", "maps/env/sanpedro/apartments/SanPedroHouse7.txd");
    AddSimpleModelEx(1923, -20087, "maps/env/sanpedro/apartments/SanPedroHouse8.dff", "maps/env/sanpedro/apartments/SanPedroHouse8.txd");
    AddSimpleModelEx(19325, -20088, "maps/env/sanpedro/apartments/SanPedroHouse9.dff", "maps/env/sanpedro/apartments/SanPedroHouse9.txd");
    AddSimpleModelEx(19478, -20089, "maps/env/sanpedro/apartments/SanPedroHouse10.dff", "maps/env/sanpedro/apartments/SanPedroHouse10.txd");
    AddSimpleModelEx(1923, -20090, "maps/env/sanpedro/apartments/SanPedroHouse11.dff", "maps/env/sanpedro/apartments/SanPedroHouse11.txd");
    AddSimpleModelEx(1923, -20091, "maps/env/sanpedro/apartments/SanPedroHouse12.dff", "maps/env/sanpedro/apartments/SanPedroHouse12.txd");
    AddSimpleModelEx(1923, -20092, "maps/env/sanpedro/apartments/SanPedroHouse13.dff", "maps/env/sanpedro/apartments/SanPedroHouse13.txd");

    CreateModelObject(MODEL_TYPE_BUILDINGS, -20092, 2540.828125, -1350.585937, 40.898399, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20090, 2548.557128, -1413.703247, 37.638198, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20088, 2561.032470, -1409.773803, 33.696601, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20091, 2549.499511, -1411.012573, 34.498401, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20089, 2563.012695, -1416.336303, 37.196098, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20085, 2548.223388, -1410.570312, 33.542900, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20087, 2556.252197, -1407.351928, 33.976100, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20083, 2547.687500, -1411.230224, 40.615898, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20086, 2545.518066, -1401.558715, 34.402400, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20080, 2539.524902, -1425.283447, 40.388401, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20081, 2557.215087, -1423.345092, 40.885799, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20084, 2548.300781, -1411.657714, 37.163299, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -20082, 2555.042236, -1407.225830, 41.112400, 0.000000, 0.000000, 0.000000); 
    return true;
}

