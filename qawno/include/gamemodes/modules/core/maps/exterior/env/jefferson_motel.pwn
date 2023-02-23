#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 5611, 2223.264, -1202.187, 27.648, 0.250);
    RemoveBuildingForPlayer(playerid, 5612, 2222.991, -1162.600, 30.038, 0.250);
    RemoveBuildingForPlayer(playerid, 5632, 2161.077, -1131.678, 31.117, 0.250);
    RemoveBuildingForPlayer(playerid, 5638, 2184.500, -1179.328, 36.405, 0.250);
    RemoveBuildingForPlayer(playerid, 5406, 2223.264, -1202.187, 27.648, 0.250);
    RemoveBuildingForPlayer(playerid, 5413, 2222.991, -1162.600, 30.038, 0.250);
    RemoveBuildingForPlayer(playerid, 1493, 2233.718, -1160.550, 24.867, 0.250);
    RemoveBuildingForPlayer(playerid, 700, 2255.510, -1170.448, 25.131, 0.250);
    RemoveBuildingForPlayer(playerid, 700, 2252.300, -1178.280, 25.131, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2256.378, -1178.198, 24.733, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2189.610, -1197.020, 27.327, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2209.310, -1197.550, 28.584, 0.250);
    RemoveBuildingForPlayer(playerid, 1493, 2192.330, -1150.838, 32.780, 0.250);
    RemoveBuildingForPlayer(playerid, 1687, 2197.030, -1161.380, 33.264, 0.250);
    RemoveBuildingForPlayer(playerid, 1687, 2190.030, -1169.438, 33.264, 0.250);
    RemoveBuildingForPlayer(playerid, 1687, 2190.030, -1180.650, 33.264, 0.250);
    RemoveBuildingForPlayer(playerid, 1687, 2200.428, -1189.979, 33.264, 0.250);
    RemoveBuildingForPlayer(playerid, 1687, 2208.729, -1183.958, 33.272, 0.250);
    RemoveBuildingForPlayer(playerid, 1687, 2218.870, -1190.130, 33.312, 0.250);
    RemoveBuildingForPlayer(playerid, 1687, 2226.520, -1183.968, 33.289, 0.250);
    RemoveBuildingForPlayer(playerid, 1689, 2243.050, -1190.078, 33.694, 0.250);
    return true;
}

hook OnGameModeInit() {
    LoadJeffersonMotelModel();
    JeffersonMotelMap();
    return true;
}

LoadJeffersonMotelModel() {
    AddSimpleModelEx(1923, -1105, "maps/env/jefferson_motel/JeffersonMotel1.dff", "maps/env/jefferson_motel/JeffersonMotel1.txd");
    AddSimpleModelEx(8674, -1106, "maps/env/jefferson_motel/JeffersonMotel2.dff", "maps/env/jefferson_motel/JeffersonMotel2.txd");
}

JeffersonMotelMap() {
    CreateModelObject(MODEL_TYPE_BUILDINGS, -1105, 2222.992187, -1162.601440, 30.039100, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_VEGETATION, -1106, 2184.500000, -1179.328125, 36.406200, 0.000000, 0.000000, 0.000000); 

    new tmpobjid;
    tmpobjid = CreateDynamicObject(1569,2225.6147460,-1190.5831290,28.4519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2225.0942380,-1190.3629150,24.8519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2228.3713370,-1186.2618400,24.8519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2227.9565420,-1186.2220450,28.4519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2215.7321770,-1190.3629150,24.8519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2214.5725090,-1190.5831290,28.4519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2215.0097650,-1186.2618400,24.8519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2205.0483390,-1190.3629150,24.8519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2204.0703120,-1190.5831290,28.4519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2205.8291010,-1186.2618400,24.8519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2203.3095700,-1186.2220450,28.4519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2195.6667480,-1175.8426510,24.8519000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2195.2263180,-1175.3420410,28.4319000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2191.1467280,-1175.2003170,28.4319000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2191.1877440,-1174.6822500,24.8519000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2195.6667480,-1167.1621090,24.8519000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2195.2263180,-1166.6407470,28.4319000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2191.1877440,-1167.8811030,24.8519000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2191.1467280,-1164.5399160,28.4319000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2195.6667480,-1157.1815180,24.8519000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2195.2263180,-1155.9602050,28.4319000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2191.1877440,-1155.8404540,24.8519000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2191.1467280,-1155.8398430,28.4319000,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1569,2214.2014160,-1186.2220450,28.4519000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(tmpobjid, 0, 14666, "genintintsex", "backdoor_128", 0x00000000);
    tmpobjid = CreateDynamicObject(994,2239.4426260,-1144.4880370,24.9552000,0.0000000,0.0000000,-15.6000090);
    tmpobjid = CreateDynamicObject(994,2228.4497070,-1141.4387200,24.9333000,0.0000000,0.0000000,-16.3000330);
    tmpobjid = CreateDynamicObject(994,2204.9228510,-1134.1376950,24.8575000,0.0000000,0.0000000,-17.9000220);
    tmpobjid = CreateDynamicObject(1226,2193.2519530,-1200.4501950,27.7498810,0.0000000,0.0000000,450.0000000);
    tmpobjid = CreateDynamicObject(1226,2209.3525390,-1200.7348630,28.6399020,0.0000000,0.0000000,450.0000000);
    tmpobjid = CreateDynamicObject(1687,2197.0300290,-1162.7012930,34.6765250,0.0000000,0.0000070,0.0000000);
    tmpobjid = CreateDynamicObject(1687,2190.0300290,-1170.7612300,34.6765250,0.0000000,0.0000070,0.0000000);
    tmpobjid = CreateDynamicObject(1687,2190.0300290,-1181.9713130,34.6765250,0.0000000,0.0000070,0.0000000);
    tmpobjid = CreateDynamicObject(1687,2200.4299310,-1191.3012690,34.6765250,-0.0000070,0.0000000,-89.9999690);
    tmpobjid = CreateDynamicObject(1687,2208.7299800,-1185.2812500,34.6843260,-0.0000070,0.0000000,-89.9999690);
    tmpobjid = CreateDynamicObject(1687,2218.8701170,-1191.4512930,34.7234260,-0.0000070,0.0000000,-89.9999690);
    tmpobjid = CreateDynamicObject(1687,2226.5200190,-1185.2912590,34.7000270,-0.0000070,0.0000000,-89.9999690);
    tmpobjid = CreateDynamicObject(1689,2243.0500480,-1191.4012450,35.1062270,0.0000000,0.0000070,0.0000000);
    tmpobjid = CreateDynamicObject(1493,2233.6918940,-1158.7779540,24.8574140,0.0000000,0.0000000,161.5000000);
}