#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    LoadNewtonModels();
    NewtonInterior();
    return true;
}

LoadNewtonModels() {
    AddSimpleModelEx(2262, -3000, "maps/factions/LSPD/NewtonStation/NewtonINT.dff", "maps/factions/LSPD/NewtonStation/NewtonINT.txd");
    AddSimpleModelEx(2262, -3001, "maps/factions/LSPD/NewtonStation/NewtonBriefing.dff", "maps/factions/LSPD/NewtonStation/NewtonBriefing.txd");
    AddSimpleModelEx(2262, -3002, "maps/factions/LSPD/NewtonStation/NewtonRecep.dff", "maps/factions/LSPD/NewtonStation/NewtonRecep.txd");
    AddSimpleModelEx(2262, -3003, "maps/factions/LSPD/NewtonStation/NewtonOffice.dff", "maps/factions/LSPD/NewtonStation/NewtonOffice.txd");
    AddSimpleModelEx(5865, -3004, "maps/factions/LSPD/NewtonStation/NewtonWallP.dff", "maps/factions/LSPD/NewtonStation/NewtonWallP.txd");
    AddSimpleModelEx(2262, -3005, "maps/factions/LSPD/NewtonStation/NewtonLocker.dff", "maps/factions/LSPD/NewtonStation/NewtonLocker.txd");
    AddSimpleModelEx(2262, -3006, "maps/factions/LSPD/NewtonStation/NewtonGym.dff", "maps/factions/LSPD/NewtonStation/NewtonGym.txd");
    AddSimpleModelEx(2262, -3007, "maps/factions/LSPD/NewtonStation/NewtonCell.dff", "maps/factions/LSPD/NewtonStation/NewtonCell.txd");
    AddSimpleModelEx(2262, -3008, "maps/factions/LSPD/NewtonStation/NewtonCO.dff", "maps/factions/LSPD/NewtonStation/NewtonCO.txd");
    AddSimpleModelEx(19466, -3009, "maps/factions/LSPD/NewtonStation/NewtonGlass.dff", "maps/factions/LSPD/NewtonStation/NewtonGlass.txd");

    AddSimpleModelEx(2262, -3019, "maps/factions/LSPD/NewtonStation/NewtonINT2.dff", "maps/factions/LSPD/NewtonStation/NewtonINT.txd");
    AddSimpleModelEx(2262, -3020, "maps/factions/LSPD/NewtonStation/NewtonOffice2.dff", "maps/factions/LSPD/NewtonStation/NewtonOffice.txd");
    AddSimpleModelEx(2262, -3021, "maps/factions/LSPD/NewtonStation/NewtonArmory.dff", "maps/factions/LSPD/NewtonStation/NewtonArmory.txd");

    AddSimpleModelEx(1495, -3010, "maps/factions/LSPD/NewtonStation/NewtonDoor1.dff", "maps/factions/LSPD/NewtonStation/NewtonDoor1.txd");
    AddSimpleModelEx(1495, -3011, "maps/factions/LSPD/NewtonStation/NewtonDoor2.dff", "maps/factions/LSPD/NewtonStation/NewtonDoor1.txd");
    AddSimpleModelEx(1495, -3012, "maps/factions/LSPD/NewtonStation/NewtonDoor3.dff", "maps/factions/LSPD/NewtonStation/NewtonDoor1.txd");
    AddSimpleModelEx(2740, -3013, "maps/factions/LSPD/NewtonStation/NewtonLights.dff", "maps/factions/LSPD/NewtonStation/NewtonINT.txd");
    AddSimpleModelEx(2740, -3014, "maps/factions/LSPD/NewtonStation/NewtonLights2.dff", "maps/factions/LSPD/NewtonStation/NewtonINT.txd");
    AddSimpleModelEx(2740, -3015, "maps/factions/LSPD/NewtonStation/NewtonLights3.dff", "maps/factions/LSPD/NewtonStation/NewtonINT.txd");
    AddSimpleModelEx(1495, -3016, "maps/factions/LSPD/NewtonStation/NewtonDoor4.dff", "maps/factions/LSPD/NewtonStation/NewtonDoor1.txd");
    AddSimpleModelEx(1495, -3017, "maps/factions/LSPD/NewtonStation/NewtonDoor5.dff", "maps/factions/LSPD/NewtonStation/NewtonDoor1.txd");
    AddSimpleModelEx(1495, -3018, "maps/factions/LSPD/NewtonStation/NewtonDoor6.dff", "maps/factions/LSPD/NewtonStation/NewtonDoor1.txd");
}

NewtonInterior() {
    CreateModelObject(MODEL_TYPE_INTERIORS, -3000, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3001, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3002, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 270.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3003, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 360.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3004, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 180.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3005, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 180.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3006, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 360.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3007, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 810.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3008, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 900.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3009, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 900.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3010, 1384.179687, -6.823225, 1001.152954, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3010, 1384.179687, -8.723237, 1001.152954, 0.000000, 0.000000, 270.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3012, 1382.929565, -2.173237, 1001.152954, 0.000000, 0.000000, 360.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3010, 1384.179687, 1.174777, 1001.152954, 0.000007, 0.000000, 89.999977); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3010, 1384.179687, -0.725233, 1001.152954, -0.000007, 0.000000, -89.999977); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3010, 1382.827026, 20.819793, 1001.152954, 0.000014, -0.000007, 179.999877); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3010, 1384.726928, 20.819793, 1001.152954, -0.000014, 0.000007, 0.000014); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1379.926025, 20.819793, 1001.152954, -0.000014, 0.000007, 0.000014); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3012, 1385.611572, 5.806767, 1001.152954, 0.000000, 0.000000, 360.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3012, 1388.203247, 5.806767, 1001.152954, 0.000000, 0.000000, 540.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3012, 1385.490722, -26.423278, 1001.152954, 0.000000, 0.000000, 540.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1387.691284, -23.803276, 1001.152954, 0.000000, 0.000000, 540.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1390.772216, -23.803276, 1001.152954, 0.000000, 0.000000, 720.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1387.635864, 0.809795, 1001.152954, -0.000014, 0.000007, 90.000015); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1387.635864, -8.370219, 1001.152954, -0.000014, 0.000007, 270.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1387.781372, -26.983266, 1001.152954, 0.000000, 0.000000, 810.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1387.781372, -42.823207, 1001.152954, 0.000000, 0.000000, 990.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3013, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3014, 1389.584472, 20.727960, 999.952087, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3012, 1385.611694, 11.406765, 1001.152954, 0.000000, 0.000000, 360.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3012, 1388.211669, 11.406765, 1001.152954, 0.000000, 0.000000, 540.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3019, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3020, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 360.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3021, 1389.584472, -14.272039, 999.952087, 0.000000, 0.000000, 360.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3012, 1382.629394, 15.402251, 1009.991516, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3016, 1377.417358, 8.462230, 1009.991516, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1382.629394, 11.212240, 1009.991516, 0.000000, 0.000000, 0.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1378.836303, 13.812232, 1009.991516, 0.000000, 0.000000, 270.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1378.836303, 16.992261, 1009.991516, 0.000000, 0.000000, 450.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3010, 1378.378295, -26.413270, 1001.152954, 0.000000, 0.000000, 180.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3010, 1380.279174, -26.413270, 1001.152954, 0.000000, 0.000000, 360.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3011, 1379.737670, 1.613229, 1009.991516, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3015, 1389.584472, 5.727960, 1009.952087, 0.000000, 0.000000, 90.000000); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3018, 1385.214599, 28.232646, 1001.193054, 0.000000, 0.000000, -0.000136); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3017, 1386.205322, 28.162578, 1001.193054, 0.000000, 0.000000, 179.999862); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3018, 1381.214599, 28.232646, 1001.193054, 0.000000, 0.000000, -0.000136); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3017, 1382.205322, 28.162578, 1001.193054, 0.000000, 0.000000, 179.999862); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3018, 1377.634643, 28.232646, 1001.193054, 0.000000, 0.000000, -0.000136); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3017, 1378.625366, 28.162578, 1001.193054, 0.000000, 0.000000, 179.999862); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3018, 1389.412841, 28.232646, 1001.193054, 0.000000, 0.000000, -0.000136); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3017, 1390.403564, 28.162578, 1001.193054, 0.000000, 0.000000, 179.999862); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3018, 1390.403564, 25.032577, 1001.193054, 0.000000, 0.000007, 179.999801); 
    CreateModelObject(MODEL_TYPE_INTERIORS, -3017, 1389.412841, 25.102645, 1001.193054, 0.000000, -0.000007, -0.000151); 
}