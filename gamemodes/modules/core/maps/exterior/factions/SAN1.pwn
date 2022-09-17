#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 713, 1807.520, -1625.880, 12.703, 0.250);
    RemoveBuildingForPlayer(playerid, 700, 1792.800, -1640.947, 14.312, 0.250);
    RemoveBuildingForPlayer(playerid, 700, 1777.848, -1677.197, 14.312, 0.250);
    RemoveBuildingForPlayer(playerid, 700, 1761.458, -1651.739, 14.312, 0.250);
    RemoveBuildingForPlayer(playerid, 1294, 1753.770, -1632.060, 17.250, 0.250);
    RemoveBuildingForPlayer(playerid, 1531, 1767.208, -1617.540, 15.038, 0.250);
    return true;
}

hook OnGameModeInit(){
    LoadSANExterior();
}

LoadSANExterior(){
    AddSimpleModelEx(19325, -5775, "maps/factions/SAN/sannews1.dff", "maps/factions/SAN/sannews.txd");
    AddSimpleModelEx(19325, -5776, "maps/factions/SAN/sannews2.dff", "maps/factions/SAN/sannews.txd");
    AddSimpleModelEx(19325, -5777, "maps/factions/SAN/sannews3.dff", "maps/factions/SAN/sannews.txd");

    CreateModelObject(MODEL_TYPE_VEGETATION, -5775, 1807.809326, -1649.766357, 13.509900, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_OBJECTS, -5776, 1802.567626, -1654.242431, 15.901800, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_2DFX, -5777, 1805.248657, -1668.268554, 33.769001, 0.000000, 0.000000, 125.099655); 
    CreateModelObject(MODEL_TYPE_2DFX, -5777, 1793.262939, -1676.615600, 33.769001, 0.000000, 0.000000, -54.499912); 
    CreateModelObject(MODEL_TYPE_2DFX, -5777, 1784.179687, -1629.296752, 33.769001, 0.000000, 0.000000, -144.465454); 

    CreateDynamicObject(700, 1807.405761, -1625.510131, 13.231738, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    CreateDynamicObject(700, 1792.515380, -1640.878295, 14.398771, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    CreateDynamicObject(700, 1761.285888, -1651.709472, 14.398771, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    CreateDynamicObject(700, 1777.687500, -1676.169311, 14.398771, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
}
