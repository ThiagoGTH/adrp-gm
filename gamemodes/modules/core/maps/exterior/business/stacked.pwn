#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
    RemoveBuildingForPlayer(playerid, 1522, 2105.919, -1807.250, 12.515, 0.250);
    RemoveBuildingForPlayer(playerid, 5418, 2112.939, -1797.089, 19.335, 0.250);
    RemoveBuildingForPlayer(playerid, 5530, 2112.939, -1797.089, 19.335, 0.250);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModelEx(2981, -2005, "maps/business/stacked/stacked_arc.dff", "maps/business/stacked/stacked_arc.txd");
    AddSimpleModelEx(2982, -2006, "maps/business/stacked/stacked_furn_01.dff", "maps/business/stacked/stacked_furn_01.txd");
    AddSimpleModelEx(19325, -2007, "maps/business/stacked/stacked_window.dff", "maps/business/stacked/stacked_window.txd");
    AddSimpleModelEx(2985, -2008, "maps/business/stacked/stacked_sign.dff", "maps/business/stacked/stacked_sign.txd");

    new tmpobjid;
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2416, 2119.973876, -1807.681396, 12.543940, -0.000014, 0.000000, -89.799949); 
    SetObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    SetObjectMaterial(tmpobjid, 1, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    SetObjectMaterial(tmpobjid, 2, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
    SetObjectMaterial(tmpobjid, 3, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
    SetObjectMaterial(tmpobjid, 4, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
    SetObjectMaterial(tmpobjid, 5, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
    SetObjectMaterial(tmpobjid, 6, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
    SetObjectMaterial(tmpobjid, 7, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
    SetObjectMaterial(tmpobjid, 8, 5712, "cemetint_law", "pizzabox", 0x00000000);
    SetObjectMaterial(tmpobjid, 9, 5712, "cemetint_law", "pizzabox", 0x00000000);
    SetObjectMaterial(tmpobjid, 10, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    SetObjectMaterial(tmpobjid, 11, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    SetObjectMaterial(tmpobjid, 12, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    SetObjectMaterial(tmpobjid, 13, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    SetObjectMaterial(tmpobjid, 14, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    SetObjectMaterial(tmpobjid, 15, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 11737, 2106.586425, -1806.634399, 12.561551, -0.000014, 0.000000, -88.799980); 
    SetObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "pizza_wellstacked", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateModelObject(MODEL_TYPE_BUILDINGS, -2005, 2112.939208, -1797.074707, 19.342802, 0.000000, 0.000014, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2753, 2115.914062, -1803.828491, 13.708462, -0.000014, 0.000000, -90.099952); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2682, 2115.619873, -1805.757934, 13.709242, 0.000000, 0.000014, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2453, 2115.727783, -1805.023193, 13.889199, 0.000000, 0.000014, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2427, 2115.737304, -1801.696655, 13.485816, 0.000000, 0.000014, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2753, 2115.911132, -1806.599365, 13.708462, -0.000014, 0.000000, -90.099952); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2753, 2115.907714, -1808.539428, 13.708462, -0.000014, 0.000000, -90.099952); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2682, 2115.619873, -1809.178833, 13.709242, 0.000000, 0.000014, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2451, 2119.870117, -1804.045532, 12.566541, -0.000014, 0.000000, -89.899909); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2451, 2119.868652, -1802.184448, 12.566541, -0.000014, 0.000000, -89.899909); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, -2006, 2108.461914, -1806.629272, 13.411523, 0.000000, 0.000014, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 937, 2120.045410, -1806.263183, 13.036811, -0.000014, 0.000000, -90.399963); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 19924, 2120.260986, -1804.518066, 16.250301, -0.000014, 0.000000, -87.899948); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, -2007, 2106.826660, -1806.782226, 14.449682, 0.000000, 0.000014, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, -2008, 2105.086425, -1806.573364, 15.691573, 0.000000, 0.000014, 0.000000);
    return true;
}

