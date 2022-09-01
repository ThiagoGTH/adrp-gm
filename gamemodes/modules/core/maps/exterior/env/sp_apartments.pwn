#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 17729, 2540.8281, -1350.5859, 40.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 17679, 2540.8281, -1350.5859, 40.8984, 0.25);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModel (-1,1923, -948, "maps/env/sanpedro/apartments/SanPedroHouse1.dff", "maps/env/sanpedro/apartments/SanPedroHouse1.txd");
    AddSimpleModel (-1,1923, -949, "maps/env/sanpedro/apartments/SanPedroHouse2.dff", "maps/env/sanpedro/apartments/SanPedroHouse2.txd");
    AddSimpleModel (-1,1923, -950, "maps/env/sanpedro/apartments/SanPedroHouse3.dff", "maps/env/sanpedro/apartments/SanPedroHouse3.txd");
    AddSimpleModel (-1,1923, -951, "maps/env/sanpedro/apartments/SanPedroHouse4.dff", "maps/env/sanpedro/apartments/SanPedroHouse4.txd");
    AddSimpleModel (-1,1923, -952, "maps/env/sanpedro/apartments/SanPedroHouse5.dff", "maps/env/sanpedro/apartments/SanPedroHouse5.txd");
    AddSimpleModel (-1,1923, -953, "maps/env/sanpedro/apartments/SanPedroHouse6.dff", "maps/env/sanpedro/apartments/SanPedroHouse6.txd");
    AddSimpleModel (-1,1923, -954, "maps/env/sanpedro/apartments/SanPedroHouse7.dff", "maps/env/sanpedro/apartments/SanPedroHouse7.txd");
    AddSimpleModel (-1,1923, -955, "maps/env/sanpedro/apartments/SanPedroHouse8.dff", "maps/env/sanpedro/apartments/SanPedroHouse8.txd");
    AddSimpleModel (-1,19325, -956, "maps/env/sanpedro/apartments/SanPedroHouse9.dff", "maps/env/sanpedro/apartments/SanPedroHouse9.txd");
    AddSimpleModel (-1,19478, -957, "maps/env/sanpedro/apartments/SanPedroHouse10.dff", "maps/env/sanpedro/apartments/SanPedroHouse10.txd");
    AddSimpleModel (-1,1923, -958, "maps/env/sanpedro/apartments/SanPedroHouse11.dff", "maps/env/sanpedro/apartments/SanPedroHouse11.txd");
    AddSimpleModel (-1,1923, -959, "maps/env/sanpedro/apartments/SanPedroHouse12.dff", "maps/env/sanpedro/apartments/SanPedroHouse12.txd");
    AddSimpleModel (-1,1923, -960, "maps/env/sanpedro/apartments/SanPedroHouse13.dff", "maps/env/sanpedro/apartments/SanPedroHouse13.txd");

    CreateObject(-960, 2540.828125, -1350.585937, 40.898399, 0.000000, 0.000000, 0.000000, 1000.00); 
    CreateDynamicObject(-958, 2548.557128, -1413.703247, 37.638198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-956, 2561.032470, -1409.773803, 33.696601, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-959, 2549.499511, -1411.012573, 34.498401, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-957, 2563.012695, -1416.336303, 37.196098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-953, 2548.223388, -1410.570312, 33.542900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-955, 2556.252197, -1407.351928, 33.976100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-951, 2547.687500, -1411.230224, 40.615898, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-954, 2545.518066, -1401.558715, 34.402400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-948, 2539.524902, -1425.283447, 40.388401, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-949, 2557.215087, -1423.345092, 40.885799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-952, 2548.300781, -1411.657714, 37.163299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 
    CreateDynamicObject(-950, 2555.042236, -1407.225830, 41.112400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00); 


    return true;
}

