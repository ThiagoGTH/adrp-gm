#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 17869, 2510.476, -1543.273, 21.710, 0.25);
	RemoveBuildingForPlayer(playerid, 17870, 2520.726, -1530.250, 22.742, 0.25);
	RemoveBuildingForPlayer(playerid, 17865, 2510.476, -1543.273, 21.710, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 2542.171, -1554.046, 21.601, 0.25);
	RemoveBuildingForPlayer(playerid, 616, 2528.710, -1556.679, 21.468, 25.0);
	RemoveBuildingForPlayer(playerid, 17864, 2520.726, -1530.250, 22.742, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 2543.437, -1515.257, 22.695, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 2563.960, -1515.343, 22.296, 0.25);
	RemoveBuildingForPlayer(playerid, 17702, 2490.9063, -1504.3281, 22.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 17639, 2490.9063, -1504.3281, 22.9219, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2526.2188, -1581.6406, 20.9297, 70.25);
	RemoveBuildingForPlayer(playerid, 17863, 2467.4609, -1538.2500, 27.6016, 0.25);
	
    return true;
}

hook OnGameModeInit() {
    SanPedro();
    return true;
}

SanPedro() {
    AddSimpleModelEx(1923, -20073, "maps/env/sanpedro/-1071.dff", "maps/env/sanpedro/-1071.txd");
    AddSimpleModelEx(17863, -20074, "maps/env/sanpedro/-1072.dff", "maps/env/sanpedro/-1072.txd");
    AddSimpleModelEx(1923, -20075, "maps/env/sanpedro/-1073.dff", "maps/env/sanpedro/-1073.txd");
    AddSimpleModelEx(1923, -20076, "maps/env/sanpedro/-1074.dff", "maps/env/sanpedro/-1074.txd");

    CreateModelObject(MODEL_TYPE_LANDMASSES, -20073, 2490.906250, -1504.328125, 22.921899, 0.000000, 0.000000, 0.000000);
	CreateModelObject(MODEL_TYPE_VEGETATION, -20074, 2467.460937, -1538.250000, 27.601600, 0.000000, 0.000000, 0.000000);
	CreateModelObject(MODEL_TYPE_OBJECTS, -20075, 2510.477050, -1543.272949, 21.711000, 0.000000, 0.000000, 0.000000);
	CreateModelObject(MODEL_TYPE_LANDMASSES, -20076, 2510.477050, -1543.272949, 21.711000, 0.000000, 0.000000, 0.000000);

	CreateDynamicObject(673, 2519.460938, -1560.968994, 22.621000, 0.0, 0.0, 0.0);
	CreateDynamicObject(673, 2500.833008, -1575.083984, 22.643000, 0.0, 0.0, 0.0);
	CreateDynamicObject(673, 2532.801025, -1545.797974, 22.436001, 0.0, 0.0, 0.0);
	CreateDynamicObject(673, 2538.562012, -1534.280029, 22.496000, 0.0, 0.0, 0.0);
	CreateDynamicObject(673, 2528.840088, -1523.428955, 22.681000, 0.0, 0.0, 0.0);
	CreateDynamicObject(673, 2551.468018, -1553.899048, 22.556999, 0.0, 0.0, 0.0);
}


