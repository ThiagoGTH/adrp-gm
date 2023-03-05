#include <YSI_Coding\y_hooks>

enum ferris {
	fseatobject,
	fposition
};

new FerrisWheelData[10][ferris];

enum ferriswheel {
	Float:f_PosX,
	Float:f_PosY,
	Float:f_PosZ
};

static const FerrisWheel[][ferriswheel] = {
	{389.87500, -2028.51563, 8.78125},	
	{389.87500, -2035.39844, 10.94531},
	{389.87500, -2039.64063, 16.84375},
	{389.87500, -2039.65625, 24.10938},
	{389.87500, -2035.38281, 29.95313},
	{389.87500, -2028.50000, 32.22656},
	{389.87500, -2021.64063, 29.92969},
	{389.87500, -2017.45313, 24.03125},
	{389.87500, -2017.42969, 16.85156},
	{389.87500, -2021.63281, 10.98438}
};

hook OnPlayerConnect(playerid) {
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2028.5000, 32.2266, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2021.6406, 29.9297, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2017.4531, 24.0313, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2017.4297, 16.8516, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2021.6328, 10.9844, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2028.5156, 8.7813, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2035.3984, 10.9453, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2039.6406, 16.8438, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2039.6563, 24.1094, 0.250);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2035.3828, 29.9531, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2039.6406, 16.8438, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2039.6563, 24.1094, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2028.5000, 32.2266, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2021.6406, 29.9297, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2017.4531, 24.0313, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2017.4297, 16.8516, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2021.6328, 10.9844, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2028.5156, 8.7813, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2035.3984, 10.9453, 0.250);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2035.3828, 29.9531, 0.250);
    return true;
}

hook OnGameModeInit() {
    CreateFerrisWheel();
    SetTimer("FerrisWheelCheck", 15000, true);
    return true;
}

CreateFerrisWheel() {
	for(new i = 0; i < 10; i++) {
		FerrisWheelData[i][fseatobject] = CreateObject(18879, FerrisWheel[i][f_PosX], FerrisWheel[i][f_PosY], FerrisWheel[i][f_PosZ]+1.5, 360.0, 0.0000, 90.0);
		FerrisWheelData[i][fposition] = i;
	}
	return true;
}

forward FerrisWheelCheck();
public FerrisWheelCheck() {
    for(new i = 0; i < 10; i++) {
		if(IsValidObject(FerrisWheelData[i][fseatobject])) {
			if(FerrisWheelData[i][fposition] == 9)
				FerrisWheelData[i][fposition] = 0;
			else
				FerrisWheelData[i][fposition] += 1;

			new seat_position = FerrisWheelData[i][fposition];

			MoveObject(FerrisWheelData[i][fseatobject], FerrisWheel[seat_position][f_PosX], FerrisWheel[seat_position][f_PosY], FerrisWheel[seat_position][f_PosZ]+1.5, 2.5, 356.8584, 0.0000, 90.0);
		}
	}
	return true;
}

