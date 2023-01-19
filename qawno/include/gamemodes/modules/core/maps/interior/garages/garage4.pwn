/* 
GARAGE INTERIOR
    by Sahin
*/

#include <YSI_Coding\y_hooks>

hook OnGameModeInit(){
    new fso_map;
    fso_map = CreateDynamicObject(18753, 957.847900, 2143.056396, 1003.161682, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0);
    fso_map = CreateDynamicObject(19859, 957.912903, 2148.443604, 1004.918091, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18029, "genintintsmallrest", "GB_restaursmll12", 0xFFFFFFFF);
    CreateDynamicObject(11711, 958.679871, 2148.460205, 1006.505371, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(630, 961.045837, 2146.939941, 1004.695251, 0.000000, 0.000000, 92.700005, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    fso_map = CreateDynamicObject(19354, 961.515503, 2147.374756, 1005.166504, 0.000000, 0.000010, 45.000011, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 961.713684, 2147.582275, 1003.596008, -0.000010, 90.000008, 135.000015, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19377, 957.366760, 2145.325684, 1003.594055, 0.000000, 90.000015, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
    fso_map = CreateDynamicObject(19445, 955.551758, 2148.537842, 1005.168518, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(2167, 955.166870, 2148.623291, 1003.679565, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 19595, "lsappartments1", "carpet4-256x256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 4829, "airport_las", "liftdoorsac256", 0);
    CreateDynamicObject(1650, 955.048401, 2147.771484, 1003.998596, 0.000000, 0.000000, -135.100006, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(1650, 954.716064, 2147.792969, 1003.998596, 0.000000, 0.000000, -135.100006, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(2654, 954.707642, 2148.282959, 1005.421814, 0.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19354, 961.527588, 2147.368896, 1007.846497, 0.000000, 0.000010, 45.000011, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 957.073181, 2149.596191, 1008.559265, 18.999958, 0.000008, 0.000093, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19445, 955.551758, 2148.567871, 1007.829102, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(2167, 954.266907, 2148.623291, 1003.679565, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 19595, "lsappartments1", "carpet4-256x256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 4829, "airport_las", "liftdoorsac256", 0);
    fso_map = CreateDynamicObject(18066, 955.520996, 2147.976563, 1008.169006, -199.100006, -90.000000, 180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    CreateDynamicObject(19280, 962.006409, 2144.525879, 1003.760132, 39.599972, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19377, 955.546875, 2151.953857, 1003.598022, 0.000000, 90.000031, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(3078, 962.568542, 2144.519287, 1003.849976, 0.000000, -89.999985, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    CreateDynamicObject(18634, 953.450012, 2148.434570, 1005.336487, 90.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(2855, 953.379761, 2147.993652, 1004.569214, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(18634, 953.199890, 2148.434570, 1005.336487, 90.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(2509, 953.044006, 2148.453125, 1005.613342, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19595, "lsappartments1", "carpet4-256x256", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(8659, 961.761108, 2147.971436, 1009.791443, -89.999992, -35.264381, 99.735611, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18901, "matclothes", "bowler", 0xFFDCDCDC);
    SetDynamicObjectMaterial(fso_map, 1, 19527, "cauldron1", "cauldron1", 0xFFC8C8C8);
    CreateDynamicObject(19627, 952.848389, 2148.425049, 1005.530334, 0.000007, 90.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(19627, 952.708313, 2148.425049, 1005.530334, 0.000007, 90.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(11707, 952.631042, 2147.587891, 1004.539001, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(18635, 952.615295, 2148.391602, 1005.292847, 0.000000, 90.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(19627, 952.568298, 2148.425049, 1005.530334, 0.000007, 90.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(1587, 952.384949, 2148.233643, 1003.981323, 37.899990, 180.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 2772, "airp_prop", "cj_chromepipe", 0);
    fso_map = CreateDynamicObject(1587, 952.384949, 2148.533936, 1003.671021, -90.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 2772, "airp_prop", "cj_chromepipe", 0);
    fso_map = CreateDynamicObject(19929, 952.357910, 2148.081299, 1003.662231, -0.000007, 0.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 19595, "lsappartments1", "carpet4-256x256", 0);
    SetDynamicObjectMaterial(fso_map, 1, 19480, "signsurf", "sign", 0);
    fso_map = CreateDynamicObject(3078, 964.248657, 2144.519287, 1003.699829, 0.000000, 0.000015, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    fso_map = CreateDynamicObject(19354, 959.144531, 2141.388916, 1003.602905, 0.000000, 90.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    CreateDynamicObject(1716, 951.957825, 2147.242920, 1003.671143, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(1301, 956.914917, 2141.416992, 1003.694885, 0.000000, 180.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFFFFFFFF);
    CreateDynamicObject(18633, 951.809937, 2148.434570, 1005.266113, 0.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(18633, 951.809937, 2148.434570, 1005.516296, 0.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(19627, 951.758301, 2148.425049, 1004.930176, 0.000000, 90.000000, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(18066, 961.961914, 2141.879150, 1005.227600, 18.799999, 90.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    CreateDynamicObject(18633, 951.809937, 2148.434570, 1005.766479, 0.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(11745, 951.668335, 2148.033691, 1004.707153, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(19627, 951.618225, 2148.425049, 1004.930176, 0.000000, 90.000000, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(2509, 951.663940, 2148.453125, 1005.613342, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19595, "lsappartments1", "carpet4-256x256", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(19354, 963.633667, 2142.860352, 1005.412659, 18.999937, 0.000000, -89.999817, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19445, 952.344177, 2148.153809, 1008.052063, 0.000000, -18.999987, 89.999939, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    CreateDynamicObject(19627, 951.478210, 2148.425049, 1004.930176, 0.000000, 90.000000, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(18066, 952.310608, 2147.976563, 1008.169006, -199.100006, -90.000000, 180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    CreateDynamicObject(19621, 951.174194, 2148.052246, 1004.679016, 0.000000, 0.000000, -36.200001, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(18635, 951.165222, 2148.401611, 1004.902954, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19356, 962.204407, 2141.308838, 1004.919006, 0.000000, -18.999943, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(19354, 963.642639, 2142.842285, 1007.677979, -19.000048, 0.000000, -89.999817, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19445, 962.671936, 2141.359863, 1005.168518, 0.000000, 0.000030, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(18066, 961.961914, 2140.678955, 1005.227600, 18.799999, 90.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(2167, 950.476929, 2148.623291, 1003.679565, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 19595, "lsappartments1", "carpet4-256x256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 4829, "airport_las", "liftdoorsac256", 0);
    fso_map = CreateDynamicObject(19353, 962.201782, 2141.308838, 1008.166870, 0.000000, -19.000065, 179.999634, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19445, 962.688049, 2141.357910, 1007.848572, 0.000000, 0.000030, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 963.643127, 2139.789063, 1005.415894, 18.999937, 0.000000, -89.999817, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    CreateDynamicObject(366, 948.924011, 2148.326904, 1004.654602, -1.799999, 40.400005, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19377, 966.146973, 2141.363525, 1003.598022, 0.000000, 90.000031, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 963.642639, 2139.791016, 1007.677979, -19.000048, 0.000000, -89.999817, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(13647, 950.080933, 2148.947266, 1009.925537, 90.000000, 173.199936, -180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19527, "cauldron1", "cauldron1", 0);
    fso_map = CreateDynamicObject(18066, 949.180847, 2147.976563, 1008.169006, -199.100006, -90.000000, 180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    CreateDynamicObject(19280, 962.006409, 2138.135986, 1003.760132, 39.599964, 0.000000, -89.999931, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(3078, 962.568542, 2138.129395, 1003.849976, 0.000000, -89.999977, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    fso_map = CreateDynamicObject(19128, 953.593933, 2140.141846, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 953.954773, 2139.780762, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 953.605774, 2139.804199, 1009.935852, 180.000000, 0.000000, 135.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19597, "lsbeachside", "carpet19-128x128", 0);
    fso_map = CreateDynamicObject(14826, 947.679138, 2147.562744, 1004.359314, 0.000000, 0.000000, -87.900063, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 3
    SetDynamicObjectMaterial(fso_map, 0, 19480, "signsurf", "sign", 0);
    SetDynamicObjectMaterial(fso_map, 1, 19480, "signsurf", "sign", 0);
    SetDynamicObjectMaterial(fso_map, 2, 19480, "signsurf", "sign", 0);
    fso_map = CreateDynamicObject(19128, 953.784851, 2139.610840, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(3078, 964.248657, 2138.129395, 1003.699829, 0.000000, 0.000022, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    CreateDynamicObject(1074, 947.254150, 2148.296631, 1004.161682, 0.000007, 0.000000, 269.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19354, 947.602966, 2149.596191, 1008.559265, 18.999958, 0.000008, 0.000093, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    CreateDynamicObject(19917, 946.768005, 2146.625488, 1004.685547, 0.000000, 0.000000, -61.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19377, 946.876770, 2145.325684, 1003.594055, 0.000000, 90.000008, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
    fso_map = CreateDynamicObject(1319, 946.565674, 2146.953369, 1005.522095, 0.000000, 90.000000, -66.200005, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4726, "libhelipad_lan2", "helipad_basepanel", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(18783, 953.391663, 2140.130615, 1012.504700, 0.000000, 180.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-20-percent", 0x64FFFFFF);
    fso_map = CreateDynamicObject(19377, 966.146973, 2138.145996, 1003.604065, 0.000000, 90.000031, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(2629, 946.294067, 2147.668945, 1004.278992, -90.000000, 0.000000, -154.799973, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 4726, "libhelipad_lan2", "helipad_basepanel", 0);
    fso_map = CreateDynamicObject(19377, 957.366760, 2135.706543, 1003.594055, 0.000000, 90.000015, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
    CreateDynamicObject(1074, 946.264099, 2148.296631, 1004.161682, 0.000007, 0.000000, 269.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19354, 963.633667, 2136.468262, 1005.412659, 18.999952, 0.000000, -89.999863, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(2388, 946.020752, 2147.586182, 1004.260193, 0.000000, 0.000000, 116.600006, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4726, "libhelipad_lan2", "helipad_basepanel", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(19445, 945.931641, 2148.537842, 1005.168518, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 963.642639, 2136.450195, 1007.677979, -19.000034, 0.000000, -89.999863, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(18066, 961.961914, 2135.447754, 1005.227600, 18.799992, 90.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19354, 959.146545, 2134.936768, 1003.602905, 0.000000, 90.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19445, 945.931641, 2148.557861, 1007.828796, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(1301, 956.914917, 2134.976807, 1003.694885, 0.000000, 180.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(19377, 945.926941, 2151.953857, 1003.598022, 0.000000, 90.000031, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19356, 962.204407, 2134.916748, 1004.919006, 0.000000, -18.999958, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(8659, 945.814087, 2148.502686, 1009.779358, -89.999992, -89.999992, 90.000023, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18901, "matclothes", "bowler", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 19527, "cauldron1", "cauldron1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(19353, 962.201782, 2134.916748, 1008.166870, 0.000000, -19.000050, 179.999725, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(18066, 961.961914, 2134.247559, 1005.227600, 18.799992, 90.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19128, 950.821960, 2137.369141, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 950.799866, 2136.989258, 1009.935852, 0.000000, -179.999985, -44.999996, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19597, "lsbeachside", "carpet19-128x128", 0);
    fso_map = CreateDynamicObject(19128, 950.468079, 2137.015137, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19354, 963.643127, 2133.396973, 1005.415894, 18.999952, 0.000000, -89.999863, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19128, 953.862427, 2134.227051, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 953.571899, 2134.216309, 1009.935852, 0.000000, -179.999985, -44.999996, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19597, "lsbeachside", "carpet19-128x128", 0);
    fso_map = CreateDynamicObject(630, 961.902466, 2132.664551, 1004.695251, 0.000000, 0.000000, 126.199989, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    fso_map = CreateDynamicObject(19354, 963.642639, 2133.398926, 1007.677979, -19.000034, 0.000000, -89.999863, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(630, 942.094177, 2147.918457, 1004.695251, 0.000000, 0.000000, 59.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    fso_map = CreateDynamicObject(19445, 962.671936, 2131.728271, 1005.168518, 0.000000, 0.000022, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19445, 962.688049, 2131.726318, 1007.848572, 0.000000, 0.000022, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19128, 951.935547, 2133.264404, 1009.955872, 0.000000, 360.000000, -90.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 951.584961, 2133.414551, 1009.935852, 0.000000, 179.999985, -90.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19597, "lsbeachside", "carpet19-128x128", 0);
    fso_map = CreateDynamicObject(19377, 946.876770, 2135.706543, 1003.594055, 0.000000, 90.000008, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
    fso_map = CreateDynamicObject(19354, 941.605103, 2147.136963, 1005.166504, -0.000010, 0.000010, -179.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(1723, 961.987671, 2131.127686, 1003.645447, 0.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 1, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19128, 951.415405, 2133.264404, 1009.955872, 0.000000, 360.000000, -90.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(18066, 942.197876, 2143.978027, 1008.002502, -19.100002, -90.000000, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19354, 941.595093, 2147.136963, 1007.966309, -0.000010, 0.000010, -179.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(1723, 953.707581, 2130.867676, 1003.645447, 0.000000, 0.000000, 180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 1, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(8659, 963.230408, 2131.385498, 1009.747131, -89.999992, 0.000011, 89.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18901, "matclothes", "bowler", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 19527, "cauldron1", "cauldron1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(19445, 942.004822, 2140.733398, 1004.954895, 0.000000, 19.000025, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4586, "skyscrap3_lan2", "sl_dthotelwin1", 0);
    fso_map = CreateDynamicObject(19354, 940.567810, 2145.471191, 1005.445129, 18.999979, -0.000008, 90.000099, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(18659, 962.576965, 2130.105469, 1005.500671, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    fso_map = CreateDynamicObject(18066, 942.197876, 2140.707764, 1008.002502, -19.100002, -90.000000, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19483, 962.566650, 2130.057617, 1005.089355, 0.000000, -0.000007, 179.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterialText(fso_map, 0, "Devais", 130, "Tahoma", 55, 1, 0xFFFFFFFF, 0, 1);
    fso_map = CreateDynamicObject(3053, 962.830017, 2130.080566, 1005.507935, -0.000015, 90.000000, 0.000045, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 19332, "balloon_texts", "balloon03", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 18800, "mroadhelix1", "road1-3", 0xFFA9A9A9);
    CreateDynamicObject(19527, 963.320801, 2130.111084, 1005.675720, 5.000000, -91.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19445, 941.998352, 2140.737793, 1008.200317, 0.000000, -19.099987, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19866, 954.060486, 2130.145996, 1002.816467, 67.300041, -0.000019, -89.999947, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19866, 957.312622, 2130.161621, 1009.581055, 0.000007, 0.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19354, 940.558228, 2145.467285, 1007.715820, 18.999962, -0.000008, -89.999855, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19866, 953.963623, 2130.162842, 1002.816467, 67.300079, 0.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19866, 954.221863, 2130.146973, 1007.480591, 71.199951, 180.000015, 89.999886, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19866, 953.802185, 2130.161621, 1007.480591, 71.199944, 179.999985, -89.999962, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19866, 952.832214, 2130.161621, 1003.050537, 0.000007, 0.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19604, 952.777344, 2130.097656, 1004.617126, -90.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18864, "fakesnow1", "snow2", 0);
    fso_map = CreateDynamicObject(19457, 941.144897, 2140.733398, 1002.427124, 0.000000, 19.000025, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(13647, 963.870667, 2130.185547, 1009.895813, 90.000000, 90.000000, 180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19527, "cauldron1", "cauldron1", 0);
    fso_map = CreateDynamicObject(19866, 951.539612, 2130.145996, 1002.816467, 67.300034, -0.000019, -89.999924, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19866, 951.442749, 2130.162842, 1002.816467, 67.300087, 0.000000, 89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19866, 951.700989, 2130.146973, 1007.480591, 71.199951, 180.000015, 89.999863, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19866, 951.279297, 2130.157715, 1007.480591, 71.199928, 179.999985, -89.999939, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19866, 952.391602, 2130.161621, 1009.581055, 0.000015, 0.000000, 89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(630, 950.056946, 2130.191406, 1004.695251, 0.000000, 0.000000, 126.199989, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    fso_map = CreateDynamicObject(18066, 942.197876, 2137.537109, 1008.002502, -19.100002, -90.000000, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(1723, 951.697754, 2129.457031, 1003.645447, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 1, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(8659, 963.234436, 2129.199463, 1009.779358, -89.999992, 0.000011, 89.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18901, "matclothes", "bowler", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 19527, "cauldron1", "cauldron1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(630, 961.972656, 2127.524902, 1004.695251, 0.000000, 0.000000, 126.199989, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    fso_map = CreateDynamicObject(19377, 937.997070, 2147.141846, 1003.596008, -0.000007, 90.000023, -179.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19377, 966.146973, 2128.516357, 1003.604065, 0.000000, 90.000031, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(630, 941.320984, 2135.446533, 1004.695251, 0.000000, 0.000000, 129.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    fso_map = CreateDynamicObject(19866, 947.381287, 2130.161621, 1009.581055, 0.000015, 0.000000, 89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19354, 963.633667, 2126.836670, 1005.412659, 18.999945, 0.000000, -89.999840, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 940.567810, 2135.999512, 1005.445129, 18.999979, -0.000008, 90.000099, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 963.642639, 2126.818604, 1007.677979, -19.000040, 0.000000, -89.999840, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 940.558228, 2136.005371, 1007.715820, 18.999962, -0.000008, -89.999855, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19377, 957.366760, 2126.074463, 1003.594055, 0.000000, 90.000023, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
    fso_map = CreateDynamicObject(18066, 961.961914, 2125.887207, 1005.227600, 18.800007, 90.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19866, 946.063171, 2130.164551, 1009.582031, 0.000015, 0.000000, 89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 951.935547, 2127.113281, 1009.955872, 0.000000, 360.000000, -90.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(8659, 940.770386, 2135.221680, 1009.751160, -89.999992, 134.999985, 44.999992, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18901, "matclothes", "bowler", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 19527, "cauldron1", "cauldron1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(19354, 959.146545, 2125.306641, 1003.602905, 0.000000, 90.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19128, 951.475281, 2127.113281, 1009.955872, 0.000000, 360.000000, -90.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(1301, 956.914917, 2125.315674, 1003.694885, 0.000000, 180.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(19128, 951.635437, 2126.943115, 1009.935852, 0.000000, 179.999985, -90.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19597, "lsbeachside", "carpet19-128x128", 0);
    fso_map = CreateDynamicObject(19128, 951.475281, 2126.943115, 1009.955872, 0.000000, 360.000000, -90.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(1433, 940.362305, 2134.252197, 1005.217468, 90.000000, 90.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 2254, "picture_frame_clip", "CJ_PAINTING24", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(19356, 962.204407, 2125.285156, 1004.919006, 0.000000, -18.999950, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(19128, 953.880005, 2126.121826, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 953.607483, 2126.122070, 1009.935852, 0.000000, -179.999985, -44.999996, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19597, "lsbeachside", "carpet19-128x128", 0);
    fso_map = CreateDynamicObject(19377, 937.997070, 2137.521973, 1003.604065, -0.000007, 90.000023, -179.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19353, 962.201782, 2125.285156, 1008.166870, 0.000000, -19.000057, 179.999680, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(18066, 961.961914, 2124.687012, 1005.227600, 18.800007, 90.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19866, 943.172546, 2130.161621, 1002.960510, 0.000007, 0.000000, 179.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 16322, "a51_stores", "metpat64chev_128", 0);
    fso_map = CreateDynamicObject(19445, 940.747009, 2131.098877, 1005.438660, -0.000015, 0.000000, 0.000045, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19866, 943.168640, 2128.837402, 1002.957581, 0.000007, 0.000000, 179.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 16322, "a51_stores", "metpat64chev_128", 0);
    fso_map = CreateDynamicObject(19354, 963.643127, 2123.765381, 1005.415894, 18.999945, 0.000000, -89.999840, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 963.642639, 2123.767334, 1007.677979, -19.000040, 0.000000, -89.999840, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19445, 940.726990, 2131.098877, 1008.108643, -0.000015, 0.000000, 0.000045, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19377, 946.876770, 2126.074463, 1003.594055, 0.000000, 90.000015, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
    fso_map = CreateDynamicObject(1508, 940.874390, 2129.499023, 1005.324402, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 9524, "blokmodb", "sf_tmpobjiddr1", 0);
    fso_map = CreateDynamicObject(13647, 940.750244, 2130.185547, 1009.905518, 90.000000, 180.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19527, "cauldron1", "cauldron1", 0);
    CreateDynamicObject(19280, 962.006409, 2122.094971, 1003.760132, 39.599983, 0.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(3078, 962.568542, 2122.088379, 1003.849976, 0.000000, -89.999992, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    fso_map = CreateDynamicObject(19128, 950.814209, 2123.327148, 1009.935852, 0.000000, -179.999985, -44.999996, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19597, "lsbeachside", "carpet19-128x128", 0);
    fso_map = CreateDynamicObject(19128, 950.541931, 2123.336914, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(3078, 964.248657, 2122.088379, 1003.699829, 0.000000, 0.000007, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    fso_map = CreateDynamicObject(19128, 950.874573, 2123.004150, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19445, 940.730896, 2127.896973, 1005.438660, -0.000015, 0.000000, 0.000045, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19445, 940.720947, 2127.896973, 1008.109070, -0.000015, 0.000000, 0.000045, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 963.633667, 2120.444580, 1005.412659, 18.999962, 0.000000, -89.999886, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 963.642639, 2120.426514, 1007.677979, -19.000027, 0.000000, -89.999886, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19128, 953.773865, 2120.711182, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 953.936646, 2120.548340, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(19128, 953.614258, 2120.527100, 1009.935852, 0.000000, -179.999985, -44.999996, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19597, "lsbeachside", "carpet19-128x128", 0);
    fso_map = CreateDynamicObject(19128, 953.632324, 2120.243896, 1009.955872, 0.000000, 360.000000, -45.000008, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-93-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-95-percent", 0);
    fso_map = CreateDynamicObject(18066, 961.961914, 2119.455811, 1005.227600, 18.799999, 90.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(8659, 940.762329, 2126.054443, 1009.743103, -89.999992, 134.999985, 44.999992, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18901, "matclothes", "bowler", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 19527, "cauldron1", "cauldron1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(19377, 937.997070, 2127.901367, 1003.604065, -0.000007, 90.000023, -179.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 959.146545, 2118.886475, 1003.602905, 0.000000, 90.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(1301, 956.914917, 2118.915527, 1003.694885, 0.000000, 180.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(19356, 962.204407, 2118.893066, 1004.919006, 0.000000, -18.999966, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(19445, 962.671936, 2118.886719, 1005.168518, 0.000000, 0.000015, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(18783, 953.391663, 2120.130127, 1012.502686, 0.000000, 180.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-20-percent", 0x64FFFFFF);
    fso_map = CreateDynamicObject(19353, 962.201782, 2118.893066, 1008.166870, 0.000000, -19.000040, 179.999771, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19445, 962.688049, 2118.884766, 1007.848572, 0.000000, 0.000015, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(1433, 940.362305, 2124.621826, 1005.217468, 90.000000, 90.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 2254, "picture_frame_clip", "CJ_PAINTING26", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(630, 941.394653, 2123.729248, 1004.695251, 0.000000, 0.000000, 141.099991, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    fso_map = CreateDynamicObject(18066, 961.961914, 2118.255615, 1005.227600, 18.799999, 90.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19377, 966.146973, 2118.885986, 1003.604065, 0.000000, 90.000031, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 940.567810, 2123.023926, 1005.445129, 18.999971, -0.000008, -269.999878, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 940.558228, 2123.020020, 1007.715820, 18.999971, -0.000008, -89.999878, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 963.643127, 2117.373291, 1005.415894, 18.999962, 0.000000, -89.999886, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 963.642639, 2117.375244, 1007.677979, -19.000027, 0.000000, -89.999886, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(18066, 942.197876, 2121.566895, 1008.002502, -19.099995, -90.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19377, 957.366760, 2116.455322, 1003.594055, 0.000000, 90.000023, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
    CreateDynamicObject(19280, 962.006409, 2115.705078, 1003.760132, 39.599972, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(3078, 962.568542, 2115.698486, 1003.849976, 0.000000, -89.999985, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    fso_map = CreateDynamicObject(3078, 964.248657, 2115.698486, 1003.699829, 0.000000, 0.000015, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    fso_map = CreateDynamicObject(14651, 957.938599, 2114.374512, 1005.790344, 0.000000, 0.000000, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 1, 19480, "signsurf", "sign", 0);
    fso_map = CreateDynamicObject(19377, 946.876770, 2116.455322, 1003.594055, 0.000000, 90.000015, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
    fso_map = CreateDynamicObject(19445, 942.004822, 2118.286133, 1004.954895, 0.000000, 19.000017, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4586, "skyscrap3_lan2", "sl_dthotelwin1", 0);
    fso_map = CreateDynamicObject(2350, 953.476990, 2114.292236, 1003.963806, 0.000000, 0.000007, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 2772, "airp_prop", "cj_chromepipe", 0);
    fso_map = CreateDynamicObject(18066, 942.197876, 2118.296631, 1008.002502, -19.099995, -90.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19445, 941.998352, 2118.290527, 1008.200317, 0.000000, -19.099995, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(2350, 952.146851, 2114.292236, 1003.963806, 0.000000, 0.000007, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 2772, "airp_prop", "cj_chromepipe", 0);
    fso_map = CreateDynamicObject(19457, 941.144897, 2118.286133, 1002.427124, 0.000000, 19.000017, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(630, 961.210571, 2113.414795, 1004.695251, 0.000000, 0.000000, 95.900002, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    CreateDynamicObject(19819, 953.721924, 2113.419189, 1004.669067, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19929, 952.878296, 2113.440430, 1003.472168, -0.000007, 0.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0);
    SetDynamicObjectMaterial(fso_map, 1, 19480, "signsurf", "sign", 0);
    CreateDynamicObject(19819, 953.842041, 2113.269043, 1004.669067, 0.000000, 0.000000, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19929, 952.668152, 2113.440430, 1003.662231, -0.000007, 0.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0);
    SetDynamicObjectMaterial(fso_map, 1, 19800, "lsacarpark1", "dt_officewall1", 0);
    fso_map = CreateDynamicObject(19354, 961.515625, 2112.893799, 1005.166504, -0.000010, 0.000010, -44.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19846, 953.840271, 2113.043213, 1006.352051, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(921, 953.751038, 2113.048584, 1006.244141, 90.000000, 0.000000, -180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 10765, "airportgnd_sfse", "white", 0);
    SetDynamicObjectMaterial(fso_map, 1, 1560, "7_11_door", "CJ_CHROME2", 0);
    fso_map = CreateDynamicObject(19354, 961.515625, 2112.882080, 1007.847229, -0.000010, 0.000010, -44.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19925, 950.808167, 2113.440430, 1003.662231, -0.000007, 0.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0);
    SetDynamicObjectMaterial(fso_map, 1, 19800, "lsacarpark1", "dt_officewall1", 0);
    CreateDynamicObject(19824, 950.945068, 2113.387451, 1004.577026, 0.000000, 0.000007, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(921, 952.850708, 2113.048584, 1006.244141, 90.000000, 0.000000, -180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 10765, "airportgnd_sfse", "white", 0);
    SetDynamicObjectMaterial(fso_map, 1, 1560, "7_11_door", "CJ_CHROME2", 0);
    fso_map = CreateDynamicObject(19846, 952.840088, 2113.043213, 1006.352051, 0.000015, 0.000000, 89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(19354, 961.855286, 2112.553955, 1003.596008, -0.000010, 90.000008, -44.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    CreateDynamicObject(19824, 951.045166, 2113.207275, 1004.577026, 0.000000, 0.000007, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    CreateDynamicObject(19824, 950.905090, 2113.207275, 1004.577026, 0.000000, 0.000007, 0.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19846, 951.840149, 2113.043213, 1006.352051, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(921, 951.740540, 2113.048584, 1006.244141, 90.000000, 0.000000, -180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 10765, "airportgnd_sfse", "white", 0);
    SetDynamicObjectMaterial(fso_map, 1, 1560, "7_11_door", "CJ_CHROME2", 0);
    fso_map = CreateDynamicObject(921, 950.950195, 2113.048584, 1006.244141, 90.000000, 0.000000, -180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 10765, "airportgnd_sfse", "white", 0);
    SetDynamicObjectMaterial(fso_map, 1, 1560, "7_11_door", "CJ_CHROME2", 0);
    fso_map = CreateDynamicObject(19846, 950.840271, 2113.043213, 1006.352051, 0.000015, 0.000000, 89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(18066, 955.555237, 2112.288574, 1008.169006, 19.100008, -270.000000, 179.999924, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(8659, 961.916870, 2112.459717, 1009.785400, -89.999992, 35.264381, 80.264374, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18901, "matclothes", "bowler", 0xFFDCDCDC);
    SetDynamicObjectMaterial(fso_map, 1, 19527, "cauldron1", "cauldron1", 0xFFC8C8C8);
    CreateDynamicObject(1074, 955.594238, 2111.945557, 1005.211975, 0.000007, 0.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(19377, 937.997070, 2118.273193, 1003.604065, -0.000007, 90.000023, -179.999969, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(2691, 955.605469, 2111.877686, 1005.217346, 0.000000, 0.000000, 180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0);
    fso_map = CreateDynamicObject(19445, 955.551758, 2111.735596, 1005.168518, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(18066, 952.425354, 2112.288574, 1008.169006, 19.100008, -270.000000, 179.999924, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(2661, 953.209045, 2111.881836, 1005.059387, 0.000000, -0.000015, 179.999908, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 12844, "cos_liquorstore", "cos_liqbots", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(2661, 953.209045, 2111.881836, 1005.593323, 0.000000, -0.000007, 179.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 14582, "casmafbar", "bottlestacked256", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(19445, 955.551758, 2111.715576, 1007.848572, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19445, 952.331909, 2112.114258, 1008.052063, -0.000015, -18.999994, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19939, 953.170837, 2111.787354, 1004.782166, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0);
    fso_map = CreateDynamicObject(19939, 953.170837, 2111.787354, 1005.352356, -0.000007, 0.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0);
    fso_map = CreateDynamicObject(18659, 952.305725, 2111.853516, 1005.640930, 0.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterialText(fso_map, 0, "?", 140, "Webdings", 150, 0, 0xAA00FF00, 0, 1);
    fso_map = CreateDynamicObject(18659, 952.305725, 2111.853516, 1006.091125, 0.000000, 0.000000, -90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterialText(fso_map, 0, "BAR", 140, "Tahoma", 120, 1, 0xAA00FF00, 0, 1);
    fso_map = CreateDynamicObject(19848, 952.332520, 2111.800049, 1006.764954, 0.000000, 90.000000, 90.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 2772, "airp_prop", "cj_chromepipe", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(2661, 951.428894, 2111.881836, 1005.041260, 0.000000, -0.000015, 179.999908, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 12844, "cos_liquorstore", "cos_liqbots", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(2661, 951.428894, 2111.881836, 1005.593323, 0.000000, -0.000007, 179.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 14582, "casmafbar", "bottlestacked256", 0xFFFFFFFF);
    fso_map = CreateDynamicObject(18066, 942.197876, 2115.125977, 1008.002502, -19.099995, -90.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    fso_map = CreateDynamicObject(19939, 951.420532, 2111.787354, 1004.782166, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0);
    fso_map = CreateDynamicObject(19939, 951.420532, 2111.787354, 1005.352356, -0.000007, 0.000000, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 4829, "airport_las", "liftdoorsac256", 0);
    fso_map = CreateDynamicObject(18066, 949.215149, 2112.288574, 1008.169006, 19.100008, -270.000000, 179.999924, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18646, "matcolours", "grey-80-percent", 0);
    SetDynamicObjectMaterial(fso_map, 1, 18646, "matcolours", "grey-10-percent", 0);
    CreateDynamicObject(1073, 949.204224, 2111.945557, 1005.211975, 0.000007, 0.000000, 89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 0
    fso_map = CreateDynamicObject(2691, 949.195129, 2111.857666, 1005.217346, 0.000000, 0.000000, 180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0);
    fso_map = CreateDynamicObject(19354, 957.073120, 2110.671631, 1008.559265, 18.999971, -0.000008, -179.999863, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(13647, 954.316040, 2110.838623, 1009.885498, 90.000000, 173.199936, -360.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19527, "cauldron1", "cauldron1", 0);
    fso_map = CreateDynamicObject(2681, 945.934814, 2112.344238, 1003.682983, 0.000000, 0.000000, 180.000000, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 3
    SetDynamicObjectMaterial(fso_map, 0, 2821, "gb_foodwrap01", "GB_foodwrap03", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 14859, "gf1", "mp_apt1_pos4", 0);
    SetDynamicObjectMaterial(fso_map, 3, 15040, "cuntcuts", "cszerocupboard", 0);
    fso_map = CreateDynamicObject(19445, 945.911743, 2111.735596, 1005.168518, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19445, 945.911743, 2111.725586, 1007.908325, -0.000015, 0.000000, -89.999954, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(8659, 946.163757, 2111.824707, 1009.743103, -89.999992, 89.999992, 89.999992, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 18901, "matclothes", "bowler", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2922, "kmb_keypadx", "keypad_glass", 0xFFC8C8C8);
    fso_map = CreateDynamicObject(19354, 940.567810, 2113.552246, 1005.445129, 18.999971, -0.000008, -269.999878, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 940.558228, 2113.558105, 1007.715820, 18.999971, -0.000008, -89.999878, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(19354, 947.602783, 2110.671631, 1008.559265, 18.999971, -0.000008, -179.999863, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0xFF969696);
    fso_map = CreateDynamicObject(630, 942.231018, 2112.424805, 1004.695251, 0.000000, 0.000000, 129.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 2
    SetDynamicObjectMaterial(fso_map, 0, 17958, "burnsalpha", "plantb256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(fso_map, 1, 2176, "casino_props", "marblebox", 0);
    fso_map = CreateDynamicObject(19377, 955.536682, 2108.203857, 1003.604065, -0.000007, 90.000023, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 941.605103, 2111.887695, 1005.166504, -0.000010, 0.000010, -179.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19354, 941.595093, 2111.887695, 1007.816772, -0.000010, 0.000010, -179.999985, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(19377, 945.916931, 2108.203857, 1003.604065, -0.000007, 90.000023, -89.999977, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0);
    fso_map = CreateDynamicObject(11752, 903.534851, 2140.996582, 1003.706055, 89.999992, 180.000031, -89.999962, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    fso_map = CreateDynamicObject(11752, 903.534851, 2118.976074, 1003.706055, 89.999992, 180.000031, -89.999962, -1, 10, -1, STREAMER_OBJECT_SD, 300.0); // 1
    SetDynamicObjectMaterial(fso_map, 0, 19063, "xmasorbs", "sphere", 0);
    return true;
}