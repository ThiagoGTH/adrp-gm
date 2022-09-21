#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
    RemoveBuildingForPlayer(playerid, 1522, 2105.919, -1807.250, 12.515, 0.250);
    RemoveBuildingForPlayer(playerid, 5418, 2112.939, -1797.089, 19.335, 0.250);
    RemoveBuildingForPlayer(playerid, 5530, 2112.939, -1797.089, 19.335, 0.250);
    return true;
}

hook OnGameModeInit() {
    AddSimpleModelEx(19478, -2005, "maps/business/stacked/stacked_arc.dff", "maps/business/stacked/stacked_arc.txd");
    AddSimpleModelEx(19475, -2006, "maps/business/stacked/stacked_furn_01.dff", "maps/business/stacked/stacked_furn_01.txd");
    CreateModelObject(MODEL_TYPE_BUILDINGS, -2005, 2112.939941, -1797.086425, 19.342802, 0.000000, 0.000000, 0.000000);
    CreateModelObject(MODEL_TYPE_OBJECTS, -2006, 2108.476318, -1806.634887, 13.372796, 0.000000, 0.000000, 0.000000);

    new tmpobjid;
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2416, 2119.879150, -1802.047119, 12.551550, 0.000000, 0.000000, 270.000000); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19962, "samproadsigns", "materialtext1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 19962, "samproadsigns", "materialtext1", 0x00000000);
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2426, 2119.860351, -1804.421630, 13.501561, 0.000000, 0.000000, 270.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2453, 2115.688964, -1808.087646, 13.861563, 0.000000, 0.000000, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2771, 2115.890136, -1810.585815, 13.691555, 0.000000, 0.000000, 270.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2771, 2115.890136, -1809.024414, 13.691555, 0.000000, 0.000000, 270.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2771, 2115.890136, -1807.253051, 13.691555, 0.000000, 0.000000, 270.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2814, 2115.533447, -1805.007934, 13.511561, 0.000000, 0.000000, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2814, 2115.842041, -1805.187744, 13.566091, 0.000000, 5.500000, -24.100004); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2418, 2119.879150, -1803.927368, 12.551550, 0.000000, 0.000000, 270.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2451, 2119.879150, -1805.797973, 12.551550, 0.000000, 0.000000, 270.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2453, 2115.688964, -1809.788452, 13.861563, 0.000000, 0.000000, 0.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2425, 2115.565673, -1802.548095, 13.471551, 0.000000, 0.000000, 270.000000); 
    tmpobjid = CreateModelObject(MODEL_TYPE_OBJECTS, 2429, 2115.045166, -1801.607177, 14.241560, 0.000000, 0.000000, 0.000000); 
    return true;
}

