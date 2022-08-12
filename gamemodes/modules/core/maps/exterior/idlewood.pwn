#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    RemoveBuildingForPlayer(playerid, 5551, 2140.515, -1735.140, 15.890, 0.25);
	RemoveBuildingForPlayer(playerid, 5410, 2140.515, -1735.140, 15.890, 0.25);
    return true;
}

hook OnGameModeInit() {
    IdlewoodProject();
    return true;
}

IdlewoodProject() {
    AddSimpleModel(-1, 19379, -20077, "maps/env/idlewood/idle_project.dff", "maps/env/idlewood/idle_project.txd");

    CreateDynamicObject(-20077, 2173.719970, -1732.689941, 12.849205, 0.000000, 0.000000, 0.000000, -1, -1, -1, 450.00, 450.00);
}