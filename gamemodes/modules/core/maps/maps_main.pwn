#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
	// Vending machine
	RemoveBuildingForPlayer(playerid, 1302, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1209, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 955, 0.0, 0.0, 0.0, 6000.00);
    RemoveBuildingForPlayer(playerid, 956, 0.0, 0.0, 0.0, 6000.00);
    RemoveBuildingForPlayer(playerid, 1775, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1776, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1977, 0.0, 0.0, 0.0, 6000.0);

    // Gas pump
    RemoveBuildingForPlayer(playerid, 1686, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 3465, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1676, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1244, 0.0, 0.0, 0.0, 6000.0);
    return true;
}