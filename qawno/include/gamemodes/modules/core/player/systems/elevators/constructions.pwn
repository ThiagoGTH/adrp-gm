#include <YSI_Coding\y_hooks>

// Specify the maximum number of elevators and floor levels here.
#define MAX_ELEVATORS (3)
#define MAX_LEVELS (36)

// You might want to change this ID if it is used in another script.
#define ELEVATOR_FLOOR_SELECTION_DIALOG_ID (1808)

// Internal definitions
#define ELEVATOR_DOORS_CLOSE (0)
#define ELEVATOR_DOORS_OPEN (1)

#define ELEVATOR_LIGHTS_CONSTANT (0)
#define ELEVATOR_LIGHTS_FLASHING (1)

#define ELEVATOR_TYPE_ENCLOSED (0)
#define ELEVATOR_TYPE_PLATFORM (1)

#define MAX_ADDON_OBJECTS (70)

//------------------------------------------------------------------------------
// 1.) elevatorTypes
//
// These definitions specify the type of elevator that will be used. If
// ELEVATOR_TYPE_ENCLOSED is specified, then a single enclosed elevator with
// opening and closing doors will be created. If ELEVATOR_TYPE_PLATFORM is
// specified, then a large platform elevator will be created instead.
//------------------------------------------------------------------------------

new elevatorTypes[MAX_ELEVATORS] =
{
	ELEVATOR_TYPE_ENCLOSED,
	ELEVATOR_TYPE_ENCLOSED,
	ELEVATOR_TYPE_PLATFORM
};

// To replace the platform elevator at the mega construction site with two
// enclosed elevators, replace the above array with this one:
//
//	new elevatorTypes[MAX_ELEVATORS] =
//	{
//		ELEVATOR_TYPE_ENCLOSED,
//		ELEVATOR_TYPE_ENCLOSED,
//		ELEVATOR_TYPE_ENCLOSED,
//		ELEVATOR_TYPE_ENCLOSED
//	};
//
// Also, change MAX_ELEVATORS from 3 to 4.
//
// The arrays below contain commented out entries that you can use for the
// enclosed elevators at the mega construction site.

//------------------------------------------------------------------------------
// 2.) elevatorAttachableObjects
//
// These boolean values specify whether to attach lights and/or a support
// object to each elevator. There are two values in each row. The first value
// corresponds to the light objects, and the second value corresponds to the
// support object. Specifying true will attach the object(s), and specifying
// false will not attach the object(s). Each elevator is in a separate column.
// Note that after a certain height, the support object begins to run out of
// length, so it's only really feasible to attach it to an elevator that doesn't
// go very high.
//------------------------------------------------------------------------------

new bool:elevatorAttachableObjects[MAX_ELEVATORS][2] =
{
	{ true, true },
	{ true, true },
	{ true, false }

	// Enclosed elevators at the mega construction site:
	// { true, false },
	// { true, false }
};

//------------------------------------------------------------------------------
// 3.) elevatorCoordinates
//
// These numbers specify where the elevators will be placed. There are two
// numbers separated by commas in each row. The first number is the X
// coordinate, and the second number is the Y coordinate. The first Z coordinate
// from elevatorLevels will be used when the objects are created. Each elevator
// is in a separate column.
//------------------------------------------------------------------------------

new Float:elevatorCoordinates[MAX_ELEVATORS][2] =
{
	{ 1880.027710, -1315.910156 },
	{ 1883.477173, -1315.910156 },
	{ 4.033685, 1536.450073 }

	// Enclosed elevators at the mega construction site:
	// { 2.310921, 1537.146240 },
	// { 5.760921, 1537.146240 }
};

//------------------------------------------------------------------------------
// 4.) elevatorLevels
//
// These numbers specify where the elevator will stop at each level. There are
// numbers separated by commas in each row (the amount is determined by
// MAX_LEVELS). These numbers are the Z coordinates the elevator will use when
// moving to a new level. Each elevator is in a separate column. Insert
// 0.0 if you don't want a level to be used.
//------------------------------------------------------------------------------

new Float:elevatorLevels[MAX_ELEVATORS][MAX_LEVELS] =
{
	{ 14.840647, 19.715614, 24.715595, 29.715588, 34.715614, 39.715675, 44.715675, 49.640686, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
	{ 14.840647, 19.715614, 24.715595, 29.715588, 34.715614, 39.715675, 44.715675, 49.640686, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
	{ 11.865028, 16.790025, 21.790025, 26.790025, 31.790021, 36.790021, 41.790037, 46.715078, 51.740079, 56.740079, 61.74011, 66.740095, 71.740079, 76.74011, 81.665151, 86.690153, 91.690168, 96.690183, 101.690198, 106.690183, 111.690198, 116.615179, 121.64018, 126.640195, 131.640142, 136.640142, 141.640081, 146.64002, 151.564916, 156.589788, 161.589788, 166.589605, 171.589544, 176.589422, 181.5893, 186.514196 }
	
	// Enclosed elevators at the mega construction site:
	// { 13.090273, 18.015270, 23.015270, 28.015270, 33.015266, 38.015266, 43.015282, 47.940323, 52.965324, 57.965324, 62.965355, 67.965340, 72.965324, 77.965355, 82.890396, 87.915398, 92.915413, 97.915428, 102.915443, 107.915428, 112.915443, 117.840424, 122.865425, 127.865440, 132.865387, 137.865387, 142.865326, 147.865265, 152.790161, 157.815033, 162.815033, 167.814850, 172.814789, 177.814667, 182.814545, 187.739441 },
	// { 13.090273, 18.015270, 23.015270, 28.015270, 33.015266, 38.015266, 43.015282, 47.940323, 52.965324, 57.965324, 62.965355, 67.965340, 72.965324, 77.965355, 82.890396, 87.915398, 92.915413, 97.915428, 102.915443, 107.915428, 112.915443, 117.840424, 122.865425, 127.865440, 132.865387, 137.865387, 142.865326, 147.865265, 152.790161, 157.815033, 162.815033, 167.814850, 172.814789, 177.814667, 182.814545, 187.739441 }
};

//------------------------------------------------------------------------------
// 5.) elevatorMoveSpeeds
//
// These numbers specify how fast the elevators will move from one set of
// coordinates to another. There are four numbers separated by commas in each
// row. The first number is door open speed, the second number is the door close
// speed, the third number is the lift up speed, and the fourth number is the
// lift down speed. Each elevator is in a separate column. Note that since
// platform elevators do not have doors, it is not necessary to input a door
// open or close speed.
//------------------------------------------------------------------------------

new Float:elevatorMoveSpeeds[MAX_ELEVATORS][4] =
{
	{ 1.0, 1.0, 5.0, 5.0 },
	{ 1.0, 1.0, 5.0, 5.0 },
	{ 0.0, 0.0, 7.5, 7.5 }
	
	// Enclosed elevators at the mega construction site:
	// { 1.0, 1.0, 7.5, 7.5 },
	// { 1.0, 1.0, 7.5, 7.5 }
};

//------------------------------------------------------------------------------
// 6.) floorNames
//
// These strings specify the names of the floors. There are strings separated by
// commas in each row (the amount is determined by MAX_LEVELS). These strings
// will be found in the dialog that is opened when a player walks into an
// elevator. They will also be shown next to the elevator switches on every
// floor as 3D text labels. Each elevator is in a separate column. Insert "" in
// the string name if you don't want the floor to be used.
//------------------------------------------------------------------------------

new floorNames[MAX_ELEVATORS][MAX_LEVELS][32] =
{
	{ "Lobby", "Storage Room", "Security", "Drug Store", "Tools Store", "Ammu-Nation", "Viewing Room", "Roof", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" },
	{ "Lobby", "Storage Room", "Security", "Drug Store", "Tools Store", "Ammu-Nation", "Viewing Room", "Roof", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" },
	{ "Floor 1", "Floor 2", "Floor 3", "Floor 4", "Floor 5", "Floor 6", "Floor 7", "Floor 8", "Floor 9", "Floor 10", "Floor 11", "Floor 12", "Floor 13", "Floor 14", "Floor 15", "Floor 16", "Floor 17", "Floor 18", "Floor 19", "Floor 20", "Floor 21", "Floor 22", "Floor 23", "Floor 24", "Floor 25", "Floor 26", "Floor 27", "Floor 28", "Floor 29", "Floor 30", "Floor 31", "Floor 32", "Floor 33", "Floor 34", "Floor 35", "Floor 36" }

	// Enclosed elevators at the mega construction site:
	// { "Floor 1", "Floor 2", "Floor 3", "Floor 4", "Floor 5", "Floor 6", "Floor 7", "Floor 8", "Floor 9", "Floor 10", "Floor 11", "Floor 12", "Floor 13", "Floor 14", "Floor 15", "Floor 16", "Floor 17", "Floor 18", "Floor 19", "Floor 20", "Floor 21", "Floor 22", "Floor 23", "Floor 24", "Floor 25", "Floor 26", "Floor 27", "Floor 28", "Floor 29", "Floor 30", "Floor 31", "Floor 32", "Floor 33", "Floor 34", "Floor 35", "Floor 36" },
	// { "Floor 1", "Floor 2", "Floor 3", "Floor 4", "Floor 5", "Floor 6", "Floor 7", "Floor 8", "Floor 9", "Floor 10", "Floor 11", "Floor 12", "Floor 13", "Floor 14", "Floor 15", "Floor 16", "Floor 17", "Floor 18", "Floor 19", "Floor 20", "Floor 21", "Floor 22", "Floor 23", "Floor 24", "Floor 25", "Floor 26", "Floor 27", "Floor 28", "Floor 29", "Floor 30", "Floor 31", "Floor 32", "Floor 33", "Floor 34", "Floor 35", "Floor 36" }
};

//------------------------------------------------------------------------------
// 7.) switchCoordinates
//
// These numbers specify where the elevator switches will be placed. There are
// three numbers separated by commas in each row. The first number is the X
// coordinate, and the second number is the Y coordinate. The Z coordinate from
// elevatorLevels will be used with an offset when the keypad objects, areas,
// and 3D text labels associated with the switch are created. Each elevator is
// in a separate column.
//------------------------------------------------------------------------------

new Float:switchCoordinates[MAX_ELEVATORS][2] =
{
	{ 1877.985445, -1319.736963 },
	{ 1885.586479, -1319.736963 },
	{ 7.845226, 1533.331458 }

	// Enclosed elevators at the mega construction site:
	// { 0.243653, 1533.331458 },
	// { 7.845226, 1533.331458 }
};

enum E_AREA
{
	E_AREA_FRONT,
	E_AREA_INSIDE,
	E_AREA_SWITCH
}

enum E_ELEVATOR
{
	bool:E_ELEVATOR_CONTROLLABLE,
	E_ELEVATOR_CURRENT_LEVEL,
	Float:E_ELEVATOR_CURRENT_LIFT_SPEED,
	bool:E_ELEVATOR_DOORS_OPEN,
	bool:E_ELEVATOR_MOVING,
	bool:E_ELEVATOR_MOVING_REQUESTED,
	E_ELEVATOR_NEARBY_AREA,
	E_ELEVATOR_NEW_LEVEL,
}

enum E_MOVING_OBJECT
{
	E_MOVING_OBJECT_DOOR_1,
	E_MOVING_OBJECT_DOOR_2,
	E_MOVING_OBJECT_ELEVATOR,
	E_MOVING_OBJECT_GUARD_RAIL_1,
	E_MOVING_OBJECT_GUARD_RAIL_2,
	E_MOVING_OBJECT_GUARD_RAIL_3,
	E_MOVING_OBJECT_LIGHT_1,
	E_MOVING_OBJECT_LIGHT_2,
	E_MOVING_OBJECT_LIGHT_3,
	E_MOVING_OBJECT_LIGHT_4,
	E_MOVING_OBJECT_SUPPORT
}

enum E_SWITCH
{
	E_SWITCH_OBJECT,
	Text3D:E_SWITCH_TEXT_LABEL
}

new addOnObjects[MAX_ADDON_OBJECTS];
new areaData[MAX_ELEVATORS][MAX_LEVELS][E_AREA];
new elevatorData[MAX_ELEVATORS][E_ELEVATOR];
new movingObjectData[MAX_ELEVATORS][E_MOVING_OBJECT];
new switchData[MAX_ELEVATORS][MAX_LEVELS][E_SWITCH];

forward Elevator_CheckForNearbyPlayers();
forward Elevator_SetControllableStatus(elevatorid);
forward Elevator_SetLevel(elevatorid, level);
forward Elevator_ShowMenuForPlayer(elevatorid, playerid);

hook OnGameModeInit()
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		elevatorData[e][E_ELEVATOR_CONTROLLABLE] = true;
		elevatorData[e][E_ELEVATOR_CURRENT_LEVEL] = 1;
		elevatorData[e][E_ELEVATOR_NEW_LEVEL] = 1;
		switch (elevatorTypes[e])
		{
			case ELEVATOR_TYPE_ENCLOSED:
			{
				movingObjectData[e][E_MOVING_OBJECT_ELEVATOR] = CreateDynamicObject(2669, elevatorCoordinates[e][0], elevatorCoordinates[e][1], elevatorLevels[e][0], 0.0, 0.0, 0.0);
				movingObjectData[e][E_MOVING_OBJECT_DOOR_1] = CreateDynamicObject(2678, elevatorCoordinates[e][0] - 0.759617, elevatorCoordinates[e][1] - 2.648524, elevatorLevels[e][0] - 0.133423, 0.0, 0.0, 0.0);
				movingObjectData[e][E_MOVING_OBJECT_DOOR_2] = CreateDynamicObject(2679, elevatorCoordinates[e][0] + 0.761887, elevatorCoordinates[e][1] - 2.648524, elevatorLevels[e][0] - 0.133423, 0.0, 0.0, 0.0);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_ELEVATOR], 0, 17555, "eastbeach3c_lae2", "metpull_law", 0xFF303030);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_ELEVATOR], 2, 17555, "eastbeach3c_lae2", "metpull_law", 0xFF303030);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_ELEVATOR], 3, 17555, "eastbeach3c_lae2", "metpull_law", 0xFF303030);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_DOOR_1], 0, 1560, "7_11_door", "cj_sheetmetal2", 0xFFC4C4C4);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_DOOR_1], 1, 1560, "7_11_door", "cj_sheetmetal2", 0xFFC4C4C4);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_DOOR_1], 2, 17555, "eastbeach3c_lae2", "metpull_law", 0xFF303030);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_DOOR_1], 3, 1560, "7_11_door", "cj_sheetmetal2", 0xFFC4C4C4);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_DOOR_2], 0, 1560, "7_11_door", "cj_sheetmetal2", 0xFFC4C4C4);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_DOOR_2], 1, 1560, "7_11_door", "cj_sheetmetal2", 0xFFC4C4C4);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_DOOR_2], 2, 17555, "eastbeach3c_lae2", "metpull_law", 0xFF303030);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_DOOR_2], 3, 1560, "7_11_door", "cj_sheetmetal2", 0xFFC4C4C4);
				if (elevatorAttachableObjects[e][0])
				{
					movingObjectData[e][E_MOVING_OBJECT_LIGHT_1] = CreateDynamicObject(19121, elevatorCoordinates[e][0], elevatorCoordinates[e][1], elevatorLevels[e][0] + 1.863229, 0.0, 0.0, 0.0);
				}
				if (elevatorAttachableObjects[e][1])
				{
					movingObjectData[e][E_MOVING_OBJECT_SUPPORT] = CreateDynamicObject(1383, elevatorCoordinates[e][0], elevatorCoordinates[e][1], elevatorLevels[e][0] - 33.785002, 0.0, 0.0, 0.0);
				}
			}
			case ELEVATOR_TYPE_PLATFORM:
			{
				movingObjectData[e][E_MOVING_OBJECT_ELEVATOR] = CreateDynamicObject(19325, elevatorCoordinates[e][0], elevatorCoordinates[e][1], elevatorLevels[e][0], 0.0, -90.0, -90.0);
				movingObjectData[e][E_MOVING_OBJECT_GUARD_RAIL_1] = CreateDynamicObject(994, elevatorCoordinates[e][0] - 3.138048, elevatorCoordinates[e][1] + 1.901557, elevatorLevels[e][0] + 0.094972, 0.0, 0.0, 0.0);
				movingObjectData[e][E_MOVING_OBJECT_GUARD_RAIL_2] = CreateDynamicObject(997, elevatorCoordinates[e][0] - 3.200950, elevatorCoordinates[e][1] + 1.640503, elevatorLevels[e][0] + 0.094972, 0.0, 0.0, -90.0);
				movingObjectData[e][E_MOVING_OBJECT_GUARD_RAIL_3] = CreateDynamicObject(997, elevatorCoordinates[e][0] + 3.200950, elevatorCoordinates[e][1] + 1.640503, elevatorLevels[e][0] + 0.094972, 0.0, 0.0, -90.0);
				SetDynamicObjectMaterial(movingObjectData[e][E_MOVING_OBJECT_ELEVATOR], 0, 16640, "a51", "sl_metalwalk");
				if (elevatorAttachableObjects[e][0])
				{
					movingObjectData[e][E_MOVING_OBJECT_LIGHT_1] = CreateDynamicObject(19121, elevatorCoordinates[e][0] + 3.060504, elevatorCoordinates[e][1] - 1.684815, elevatorLevels[e][0] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[e][E_MOVING_OBJECT_LIGHT_2] = CreateDynamicObject(19121, elevatorCoordinates[e][0] + 3.060504, elevatorCoordinates[e][1] + 1.684815, elevatorLevels[e][0] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[e][E_MOVING_OBJECT_LIGHT_3] = CreateDynamicObject(19121, elevatorCoordinates[e][0] - 3.060504, elevatorCoordinates[e][1] + 1.684815, elevatorLevels[e][0] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[e][E_MOVING_OBJECT_LIGHT_4] = CreateDynamicObject(19121, elevatorCoordinates[e][0] - 3.060504, elevatorCoordinates[e][1] - 1.684815, elevatorLevels[e][0] + 0.561335, 0.0, 0.0, 0.0);
				}
				if (elevatorAttachableObjects[e][1])
				{
					movingObjectData[e][E_MOVING_OBJECT_SUPPORT] = CreateDynamicObject(1383, elevatorCoordinates[e][0], elevatorCoordinates[e][1], elevatorLevels[e][0] - 32.555002, 0.0, 0.0, 0.0);
				}
			}
		}
		for (new l; l < MAX_LEVELS; l++)
		{
			if (elevatorLevels[e][l] == 0.0)
			{
				break;
			}
			// Some slight adjustments are needed to conform with the geometry of the construction site.
			new Float:yOffset, Float:zOffset, text[128];
			format(text, sizeof(text), "{CCCCCC}[%s]\n{CCCCCC}Press '{FFFFFF}~k~~CONVERSATION_YES~{CCCCCC}' to call", floorNames[e][l]);
			if (l % 7)
			{
				// If the floor number is not a multiple of 8, then a Y offset is needed.
				yOffset = 0.4125;
			}
			else
			{
				// Even though the top floor is a multiple of 8, a Y offset is still needed.
				if ((l + 1) != MAX_LEVELS)
				{
					if (elevatorLevels[e][l + 1] == 0.0)
					{
						yOffset = 0.4125;
					}
				}
				else
				{
					yOffset = 0.4125;
				}
			}
			// The platform elevator needs a Z offset as well.
			if (elevatorTypes[e] == ELEVATOR_TYPE_PLATFORM)
			{
				zOffset = 1.225;
			}
			switch (elevatorTypes[e])
			{
				case ELEVATOR_TYPE_ENCLOSED:
				{
					areaData[e][l][E_AREA_FRONT] = CreateDynamicCube(elevatorCoordinates[e][0] - 2.0, elevatorCoordinates[e][1] - 6.0, elevatorLevels[e][l] - 2.0, elevatorCoordinates[e][0] + 2.0, elevatorCoordinates[e][1] + 6.0, elevatorLevels[e][l] + 2.0);
					areaData[e][l][E_AREA_INSIDE] = CreateDynamicCube(elevatorCoordinates[e][0] - 1.75, elevatorCoordinates[e][1] - 3.0, elevatorLevels[e][l] - 1.0, elevatorCoordinates[e][0] + 1.75, elevatorCoordinates[e][1] + 3.0, elevatorLevels[e][l] + 1.0);
				}
				case ELEVATOR_TYPE_PLATFORM:
				{
					areaData[e][l][E_AREA_INSIDE] = CreateDynamicCube(elevatorCoordinates[e][0] - 3.0, elevatorCoordinates[e][1] - 2.0, elevatorLevels[e][l] - 1.0 + zOffset, elevatorCoordinates[e][0] + 3.0, elevatorCoordinates[e][1] + 2.0, elevatorLevels[e][l] + 1.0 + zOffset);
				}
			}
			areaData[e][l][E_AREA_SWITCH] = CreateDynamicSphere(switchCoordinates[e][0], switchCoordinates[e][1] + yOffset, elevatorLevels[e][l] + zOffset, 2.0);
			switchData[e][l][E_SWITCH_OBJECT] = CreateDynamicObject(19273, switchCoordinates[e][0], switchCoordinates[e][1] + yOffset, elevatorLevels[e][l] + zOffset, 0, 0, 0);
			switchData[e][l][E_SWITCH_TEXT_LABEL] = CreateDynamic3DTextLabel(text, 0xCCCCCCAA, switchCoordinates[e][0], switchCoordinates[e][1] - 0.1 + yOffset, elevatorLevels[e][l] + 0.5 + zOffset, 6.5, .testlos = 1);
		}
		elevatorData[e][E_ELEVATOR_NEARBY_AREA] = CreateDynamicRectangle(elevatorCoordinates[e][0] - 120.0, elevatorCoordinates[e][1] - 20.0, elevatorCoordinates[e][0] + 20.0, elevatorCoordinates[e][1] + 20.0);
	}
	SetTimer("Elevator_CheckForNearbyPlayers", 500, 1);
	//------------------------------------------------------------------------------
	// These objects are just a few boxes and crates that I put in the default
	// construction site in LS. I also added a few shops there, like Ammu-Nation.
	//------------------------------------------------------------------------------
	addOnObjects[0] = CreateDynamicObject(925, 1893.239380, -1307.167847, 24.554092, 0, 0, 135);
	addOnObjects[1] = CreateDynamicObject(944, 1889.454956, -1316.659790, 24.381258, 0, 0, 112.5);
	addOnObjects[2] = CreateDynamicObject(1431, 1889.238159, -1316.682129, 25.489967, 0, 0, 292.5);
	addOnObjects[3] = CreateDynamicObject(2567, 1871.561401, -1314.821899, 25.419788, 0, 0, 90);
	addOnObjects[4] = CreateDynamicObject(3576, 1872.445190, -1323.734131, 24.984859, 0, 0, 123.75);
	addOnObjects[5] = CreateDynamicObject(3577, 1875.468384, -1309.620483, 24.274694, 0, 0, 157.5003);
	addOnObjects[6] = CreateDynamicObject(3630, 1874.490845, -1307.927002, 34.984810, 0, 0, 180);
	addOnObjects[7] = CreateDynamicObject(3761, 1883.674561, -1306.768066, 25.491169, 0, 0, 90.0001);
	addOnObjects[8] = CreateDynamicObject(5260, 1873.828247, -1312.886597, 20.202702, 0, 0, 270.0001);
	addOnObjects[9] = CreateDynamicObject(18257, 1889.628052, -1318.157227, 33.498913, 0, 0, 270);
	addOnObjects[10] = CreateDynamicObject(12930, 1873.506348, -1323.981934, 34.347416, 0, 0, 0);
	addOnObjects[11] = CreateDynamicObject(5269, 1888.052002, -1324.039063, 30.801235, 0, 0, 90);
	addOnObjects[12] = CreateDynamicObject(3761, 1884.764648, -1307.738037, 35.491169, 0, 0, 90);
	addOnObjects[13] = CreateDynamicObject(1431, 1891.231934, -1323.811523, 35.485687, 0, 0, 45);
	addOnObjects[14] = CreateDynamicObject(944, 1891.334473, -1323.899292, 34.376976, 0, 0, 45);
	addOnObjects[15] = CreateDynamicObject(2009, 1890.469848, -1324.340332, 23.442186, 0, 0, 0.25);
	addOnObjects[16] = CreateDynamicObject(1714, 1891.350097, -1324.313232, 23.482158, 0, 0, -90.0);
	addOnObjects[17] = CreateDynamicObject(14532, 1893.743286, -1320.982055, 24.460880, 0, 0, 90.0);
	addOnObjects[18] = CreateDynamicObject(2971, 1881.838257, -1324.487305, 23.487110, 0, 0, 337.5);
	addOnObjects[19] = CreateDynamicObject(2973, 1892.539551, -1308.899292, 28.491177, 0, 0, 236.2501);
	addOnObjects[20] = CreateDynamicObject(2991, 1893.015991, -1324.423950, 19.119923, 0, 0, 45);
	addOnObjects[21] = CreateDynamicObject(3630, 1888.627441, -1307.819946, 19.984810, 0, 0, 180);
	addOnObjects[22] = CreateDynamicObject(3761, 1870.401367, -1324.235474, 20.491169, 0, 0, 213.7502);
	addOnObjects[23] = CreateDynamicObject(3630, 1871.423706, -1320.258179, 29.984810, 0, 0, 270);
	addOnObjects[24] = CreateDynamicObject(925, 1879.793945, -1307.404907, 29.554092, 0, 0, 0);
	addOnObjects[25] = CreateDynamicObject(2567, 1891.997437, -1317.129517, 30.425295, 0, 0, 90);
	addOnObjects[26] = CreateDynamicObject(18257, 1873.338989, -1316.051147, 28.492188, 0, 0, 270);
	addOnObjects[27] = CreateDynamicObject(2991, 1871.407227, -1309.098022, 39.119923, 0, 0, 270);
	addOnObjects[28] = CreateDynamicObject(944, 1877.510620, -1323.393433, 29.376974, 0, 0, 146.2501);
	addOnObjects[29] = CreateDynamicObject(1431, 1877.624268, -1323.242188, 30.485683, 0, 0, 326.25);
	addOnObjects[30] = CreateDynamicObject(925, 1880.400635, -1307.401978, 19.554092, 0, 0, 0);
	addOnObjects[31] = CreateDynamicObject(2567, 1878.785156, -1307.287354, 40.419788, 0, 0, 0);
	addOnObjects[32] = CreateDynamicObject(3577, 1889.582397, -1310.724609, 39.274696, 0, 0, 123.7499);
	addOnObjects[33] = CreateDynamicObject(5269, 1892.900757, -1320.260986, 40.793556, 0, 0, 0);
	addOnObjects[34] = CreateDynamicObject(18257, 1872.281250, -1321.796021, 38.492188, 0, 0, 270);
	addOnObjects[35] = CreateDynamicObject(2971, 1875.913696, -1311.025757, 38.487110, 0, 0, 236.2501);
	addOnObjects[36] = CreateDynamicObject(2973, 1885.352905, -1307.910522, 38.485668, 0, 0, 22.5);
	addOnObjects[37] = CreateDynamicObject(2974, 1891.812256, -1314.129272, 38.483978, 0, 0, 326.25);
	addOnObjects[38] = CreateDynamicObject(18092, 1881.917846, -1325.100342, 38.991608, 0, 0, 0.0002);
	addOnObjects[39] = CreateDynamicObject(18092, 1876.892212, -1325.117798, 33.991608, 0, 0, 0);
	addOnObjects[40] = CreateDynamicObject(2061, 1880.879638, -1324.727173, 39.784058, 0, 0, 0);
	addOnObjects[41] = CreateDynamicObject(2060, 1883.799560, -1324.026367, 38.648846, 0, 0, 0);
	addOnObjects[42] = CreateDynamicObject(2060, 1883.799560, -1324.026367, 38.964298, 0, 0, 0);
	addOnObjects[43] = CreateDynamicObject(2228, 1879.429810, -1325.143311, 34.048134, 0, 0, 270);
	addOnObjects[44] = CreateDynamicObject(2690, 1874.962524, -1324.929321, 34.851543, 0, 0, 180);
	addOnObjects[45] = CreateDynamicObject(2045, 1877.953735, -1324.899658, 34.535122, 2.5783, 0, 112.5001);
	addOnObjects[46] = CreateDynamicObject(3123, 1874.872070, -1326.393677, 35.516396, 355.1547, 170.9238, 356.5026);
	addOnObjects[47] = CreateDynamicObject(2358, 1879.909423, -1324.736450, 39.608662, 0, 0, 180);
	addOnObjects[48] = CreateDynamicObject(2358, 1879.909423, -1324.736450, 39.852974, 0, 0, 180);
	addOnObjects[49] = CreateDynamicObject(3124, 1883.412109, -1324.374023, 39.696362, 313.5904, 55.8633, 216.4056);
	addOnObjects[50] = CreateDynamicObject(12930, 1890.447754, -1309.073975, 19.300476, 0, 0, 180);
	addOnObjects[51] = CreateDynamicObject(2709, 1886.847412, -1307.184082, 29.631788, 0, 0, 0);
	addOnObjects[52] = CreateDynamicObject(1580, 1888.907715, -1306.980957, 29.480543, 0, 0, 315);
	addOnObjects[53] = CreateDynamicObject(1241, 1884.999268, -1307.025146, 29.564024, 89.3814, 359.1406, 168.75);
	addOnObjects[54] = CreateDynamicObject(18092, 1886.918457, -1306.878174, 28.991610, 0, 0, 180);
	addOnObjects[55] = CreateDynamicObject(2709, 1887.206177, -1307.376953, 29.581789, 0, 91.1003, 307.952);
	addOnObjects[56] = CreateDynamicObject(1242, 1881.966796, -1324.759399, 39.644573, 0, 0, 0);
	addOnObjects[57] = CreateDynamicObject(3044, 1885.801636, -1307.086426, 29.531784, 0, 0, 45);
	addOnObjects[58] = CreateDynamicObject(1348, 1886.682373, -1326.149780, 34.192199, 0, 0, 0);
	//------------------------------------------------------------------------------
	// These objects form the mega construction site just south of Area 69. They're
	// stacked on top of each other, making a grand total of 36 floors.
	//------------------------------------------------------------------------------
	addOnObjects[59] = CreateDynamicObject(5463, 4.078737, 1537.529541, 36.244511, 0, 0, 0);
	addOnObjects[60] = CreateDynamicObject(5463, 4.078537, 1537.527541, 71.194527, 0, 0, 0);
	addOnObjects[61] = CreateDynamicObject(5463, 4.078737, 1537.529541, 106.144478, 0, 0, 0);
	addOnObjects[62] = CreateDynamicObject(5463, 4.078537, 1537.527541, 141.094681, 0, 0, 0);
	addOnObjects[63] = CreateDynamicObject(5463, 4.078737, 1537.529541, 176.044632, 0, 0, 0);
	addOnObjects[64] = CreateDynamicObject(5644, 4.078737, 1537.149536, 29.319490, 0, 0, 0);
	addOnObjects[65] = CreateDynamicObject(5644, 4.078737, 1537.149536, 54.619492, 0, 0, 0);
	addOnObjects[66] = CreateDynamicObject(5644, 4.078737, 1537.149536, 79.919479, 0, 0, 0);
	addOnObjects[67] = CreateDynamicObject(5644, 4.078737, 1537.149536, 105.219467, 0, 0, 0);
	addOnObjects[68] = CreateDynamicObject(5644, 4.078737, 1537.149536, 130.519638, 0, 0, 0);
	addOnObjects[69] = CreateDynamicObject(5644, 4.078737, 1537.149536, 155.819687, 0, 0, 0);
	return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES)
	{
		for (new e; e < MAX_ELEVATORS; e++)
		{
			if (IsPlayerInDynamicArea(playerid, elevatorData[e][E_ELEVATOR_NEARBY_AREA]))
			{
				for (new l; l < MAX_LEVELS; l++)
				{
					if (IsPlayerInDynamicArea(playerid, areaData[e][l][E_AREA_SWITCH]))
					{
						PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
						if (!elevatorData[e][E_ELEVATOR_CONTROLLABLE] || elevatorData[e][E_ELEVATOR_MOVING] || elevatorData[e][E_ELEVATOR_MOVING_REQUESTED])
						{
							SendClientMessage(playerid, 0xFF0000AA, "The elevator is already in motion.");
						}
						else if ((l + 1) == elevatorData[e][E_ELEVATOR_CURRENT_LEVEL])
						{
							SendClientMessage(playerid, 0xFF0000AA, "The elevator is already on this floor.");
						}
						else
						{
							if (elevatorTypes[e] == ELEVATOR_TYPE_ENCLOSED)
							{
								Elevator_AdjustDoors(e, ELEVATOR_DOORS_CLOSE);
							}
							SendClientMessage(playerid, 0xFFFF00AA, "The elevator has been called to this floor.");
							SetTimerEx("Elevator_SetLevel", 1000, 0, "dd", e, l + 1);
							elevatorData[e][E_ELEVATOR_CONTROLLABLE] = false;
							elevatorData[e][E_ELEVATOR_MOVING_REQUESTED] = true;
						}
						return true;
					}
				}
			}
		}		
	}
	return true;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if (dialogid == ELEVATOR_FLOOR_SELECTION_DIALOG_ID && response)
	{
		for (new e; e < MAX_ELEVATORS; e++)
		{
			if (IsPlayerInDynamicArea(playerid, areaData[e][elevatorData[e][E_ELEVATOR_CURRENT_LEVEL] - 1][E_AREA_INSIDE]))
			{
				if (!elevatorData[e][E_ELEVATOR_CONTROLLABLE] || elevatorData[e][E_ELEVATOR_MOVING] || elevatorData[e][E_ELEVATOR_MOVING_REQUESTED])
				{
					SendClientMessage(playerid, 0xFF0000AA, "The elevator is already in motion.");
				}
				else if ((listitem + 1) == elevatorData[e][E_ELEVATOR_CURRENT_LEVEL])
				{
					SendClientMessage(playerid, 0xFF0000AA, "The elevator is already on this floor.");
				}
				else
				{
					if (elevatorTypes[e] == ELEVATOR_TYPE_ENCLOSED)
					{
						Elevator_AdjustDoors(e, ELEVATOR_DOORS_CLOSE);
					}
					SendClientMessage(playerid, 0xFFFF00AA, "The elevator will move to the selected floor.");
					SetTimerEx("Elevator_SetLevel", 1000, 0, "dd", e, listitem + 1);
					elevatorData[e][E_ELEVATOR_CONTROLLABLE] = false;
					elevatorData[e][E_ELEVATOR_MOVING_REQUESTED] = true;
					foreach(Player : i)
					{
						if (i != playerid)
						{
							if (IsPlayerInDynamicArea(i, areaData[e][elevatorData[e][E_ELEVATOR_CURRENT_LEVEL] - 1][E_AREA_INSIDE]))
							{
								SendClientMessage(i, 0xFFFF00AA, "The elevator will move to the floor someone else has selected.");
								ShowPlayerDialog(i, -1, DIALOG_STYLE_MSGBOX, " ", " ", "", "");
							}
						}
					}
				}
				return true;
			}
		}
		return 0;
	}
	return 0;
}

hook OnDynamicObjectMoved(objectid)
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		if (objectid == movingObjectData[e][E_MOVING_OBJECT_ELEVATOR])
		{
			SetTimerEx("Elevator_SetControllableStatus", 250, 0, "d", e);
			elevatorData[e][E_ELEVATOR_CURRENT_LEVEL] = elevatorData[e][E_ELEVATOR_NEW_LEVEL];
			elevatorData[e][E_ELEVATOR_MOVING] = false;
			if (elevatorAttachableObjects[e][0])
			{
				Elevator_SwapLights(e, ELEVATOR_LIGHTS_CONSTANT);
			}
			break;
		}
	}
	return true;
}

hook OnPlayerEnterDynamicArea(playerid, areaid)
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		if (areaid == areaData[e][elevatorData[e][E_ELEVATOR_CURRENT_LEVEL] - 1][E_AREA_INSIDE])
		{
			if (elevatorData[e][E_ELEVATOR_CONTROLLABLE] && !elevatorData[e][E_ELEVATOR_MOVING])
			{
				SetTimerEx("Elevator_ShowMenuForPlayer", 500, 0, "dd", e, playerid);
				return true;
			}
		}
	}
	return true;
}

hook OnPlayerLeaveDynamicArea(playerid, areaid)
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		if (areaid == elevatorData[e][E_ELEVATOR_NEARBY_AREA])
		{
			if (!elevatorData[e][E_ELEVATOR_CONTROLLABLE] && elevatorData[e][E_ELEVATOR_MOVING])
			{
				PlayerPlaySound(playerid, 1019, elevatorCoordinates[e][0], elevatorCoordinates[e][1], elevatorLevels[e][elevatorData[e][E_ELEVATOR_CURRENT_LEVEL] - 1]);
				PlayerPlaySound(playerid, 1022, elevatorCoordinates[e][0], elevatorCoordinates[e][1], elevatorLevels[e][elevatorData[e][E_ELEVATOR_CURRENT_LEVEL] - 1]);
				return true;
			}
		}
	}
	return true;
}

Elevator_AdjustDoors(elevatorid, operation)
{
	switch (operation)
	{
		case ELEVATOR_DOORS_CLOSE:
		{
			if (elevatorData[elevatorid][E_ELEVATOR_DOORS_OPEN])
			{
				foreach(Player, i)
				{
					if (IsPlayerInDynamicArea(i, elevatorData[elevatorid][E_ELEVATOR_NEARBY_AREA]))
					{
						PlayerPlaySound(i, 1019, elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1]);
						PlayerPlaySound(i, 1021, elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1]);
					}
				}
				MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_DOOR_1], elevatorCoordinates[elevatorid][0] - 0.759617, elevatorCoordinates[elevatorid][1] - 2.648524, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] - 0.133423, elevatorMoveSpeeds[elevatorid][1]);
				MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_DOOR_2], elevatorCoordinates[elevatorid][0] + 0.761887, elevatorCoordinates[elevatorid][1] - 2.648524, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] - 0.133423, elevatorMoveSpeeds[elevatorid][1]);
				elevatorData[elevatorid][E_ELEVATOR_DOORS_OPEN] = false;
			}
		}
		case ELEVATOR_DOORS_OPEN:
		{
			if (!elevatorData[elevatorid][E_ELEVATOR_DOORS_OPEN])
			{
				foreach(Player, i)
				{
					if (IsPlayerInDynamicArea(i, elevatorData[elevatorid][E_ELEVATOR_NEARBY_AREA]))
					{
						PlayerPlaySound(i, 1019, elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1]);
						PlayerPlaySound(i, 1021, elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1]);
					}
				}
				MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_DOOR_1], elevatorCoordinates[elevatorid][0] - 1.493775, elevatorCoordinates[elevatorid][1] - 2.648524, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] - 0.133423, elevatorMoveSpeeds[elevatorid][0]);
				MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_DOOR_2], elevatorCoordinates[elevatorid][0] + 1.491865, elevatorCoordinates[elevatorid][1] - 2.648524, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] - 0.133423, elevatorMoveSpeeds[elevatorid][0]);
				elevatorData[elevatorid][E_ELEVATOR_DOORS_OPEN] = true;
			}
		}
	}
	return true;
}

public Elevator_CheckForNearbyPlayers()
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		if (elevatorTypes[e] == ELEVATOR_TYPE_ENCLOSED && elevatorData[e][E_ELEVATOR_CONTROLLABLE] && !elevatorData[e][E_ELEVATOR_MOVING] && !elevatorData[e][E_ELEVATOR_MOVING_REQUESTED])
		{
			new bool:playerNearby = false;
			foreach(Player, i)
			{
				if (!playerNearby)
				{
					if (IsPlayerInDynamicArea(i, areaData[e][elevatorData[e][E_ELEVATOR_CURRENT_LEVEL] - 1][E_AREA_FRONT]))
					{
						playerNearby = true;
						break;
					}
				}
			}
			if (!playerNearby)
			{
				Elevator_AdjustDoors(e, ELEVATOR_DOORS_CLOSE);
			}
			else
			{
				Elevator_AdjustDoors(e, ELEVATOR_DOORS_OPEN);
			}
		}
		if (elevatorData[e][E_ELEVATOR_MOVING])
		{
			foreach(Player, i)
			{
				if (IsPlayerInDynamicArea(i, elevatorData[e][E_ELEVATOR_NEARBY_AREA]))
				{
					PlayerPlaySound(i, 1019, 0.0, 0.0, 0.0);
					PlayerPlaySound(i, 1020, 0.0, 0.0, 0.0);
					Streamer_Update(i);
				}
			}
		}
	}
	return true;
}

public Elevator_SetControllableStatus(elevatorid)
{
	elevatorData[elevatorid][E_ELEVATOR_CONTROLLABLE] = true;
	foreach(Player, i)
	{
		if (IsPlayerInDynamicArea(i, elevatorData[elevatorid][E_ELEVATOR_NEARBY_AREA]))
		{
			PlayerPlaySound(i, 1019, elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1]);
			PlayerPlaySound(i, 1022, elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1]);
			Streamer_Update(i);
		}
	}
}

public Elevator_SetLevel(elevatorid, level)
{
	elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] = level;
	if (elevatorAttachableObjects[elevatorid][0])
	{
		Elevator_SwapLights(elevatorid, ELEVATOR_LIGHTS_FLASHING);
	}
	if (elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] > elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL])
	{
		elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED] = elevatorMoveSpeeds[elevatorid][2];
	}
	else
	{
		elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED] = elevatorMoveSpeeds[elevatorid][3];
	}
	MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_ELEVATOR], elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1], elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
	switch (elevatorTypes[elevatorid])
	{
		case ELEVATOR_TYPE_ENCLOSED:
		{
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_DOOR_1], elevatorCoordinates[elevatorid][0] - 0.759617, elevatorCoordinates[elevatorid][1] - 2.648524, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] - 0.133423, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_DOOR_2], elevatorCoordinates[elevatorid][0] + 0.761887, elevatorCoordinates[elevatorid][1] - 2.648524, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] - 0.133423, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
		}
		case ELEVATOR_TYPE_PLATFORM:
		{
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_GUARD_RAIL_1], elevatorCoordinates[elevatorid][0] - 3.138048, elevatorCoordinates[elevatorid][1] + 1.901557, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] + 0.094972, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_GUARD_RAIL_2], elevatorCoordinates[elevatorid][0] - 3.200950, elevatorCoordinates[elevatorid][1] + 1.640503, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] + 0.094972, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_GUARD_RAIL_3], elevatorCoordinates[elevatorid][0] + 3.200950, elevatorCoordinates[elevatorid][1] + 1.640503, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] + 0.094972, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
		}
	}
	switch (elevatorTypes[elevatorid])
	{
		case ELEVATOR_TYPE_ENCLOSED:
		{
			if (elevatorAttachableObjects[elevatorid][0])
			{
				MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_1], elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] + 1.863229, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			}
			if (elevatorAttachableObjects[elevatorid][1])
			{
				MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_SUPPORT], elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] - 33.785002, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			}
		}
		case ELEVATOR_TYPE_PLATFORM:
		{
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_1], elevatorCoordinates[elevatorid][0] + 3.060504, elevatorCoordinates[elevatorid][1] - 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] + 0.561335, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_2], elevatorCoordinates[elevatorid][0] + 3.060504, elevatorCoordinates[elevatorid][1] + 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] + 0.561335, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_3], elevatorCoordinates[elevatorid][0] - 3.060504, elevatorCoordinates[elevatorid][1] + 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] + 0.561335, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_4], elevatorCoordinates[elevatorid][0] - 3.060504, elevatorCoordinates[elevatorid][1] - 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] + 0.561335, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			if (elevatorAttachableObjects[elevatorid][1])
			{
				MoveDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_SUPPORT], elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_NEW_LEVEL] - 1] - 32.555002, elevatorData[elevatorid][E_ELEVATOR_CURRENT_LIFT_SPEED]);
			}
		}
	}
	foreach(Player, i)
	{
		if (IsPlayerInDynamicArea(i, elevatorData[elevatorid][E_ELEVATOR_NEARBY_AREA]))
		{
			PlayerPlaySound(i, 1019, 0.0, 0.0, 0.0);
			PlayerPlaySound(i, 1020, 0.0, 0.0, 0.0);
			Streamer_Update(i);
		}
	}
	elevatorData[elevatorid][E_ELEVATOR_MOVING] = true;
	elevatorData[elevatorid][E_ELEVATOR_MOVING_REQUESTED] = false;
	return true;
}

public Elevator_ShowMenuForPlayer(elevatorid, playerid)
{
	new floorNameString[1024];
	for (new l; l < MAX_LEVELS; l++)
	{
		if (!floorNames[elevatorid][l][0])
		{
			continue;
		}
		strcat(floorNameString, floorNames[elevatorid][l]);
		strcat(floorNameString, "\n");
	}
	ShowPlayerDialog(playerid, ELEVATOR_FLOOR_SELECTION_DIALOG_ID, DIALOG_STYLE_LIST, "Elevator", floorNameString, "Accept", "Cancel");
}

Elevator_SwapLights(elevatorid, type)
{
	switch (elevatorTypes[elevatorid])
	{
		case ELEVATOR_TYPE_ENCLOSED:
		{
			DestroyDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_1]);
			switch (type)
			{
				case ELEVATOR_LIGHTS_CONSTANT:
				{
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_1] = CreateDynamicObject(19121, elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 1.863229, 0.0, 0.0, 0.0);
				}
				case ELEVATOR_LIGHTS_FLASHING:
				{
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_1] = CreateDynamicObject(3666, elevatorCoordinates[elevatorid][0], elevatorCoordinates[elevatorid][1], elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 1.863229, 0.0, 0.0, 0.0);
				}
			}
		}
		case ELEVATOR_TYPE_PLATFORM:
		{
			DestroyDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_1]);
			DestroyDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_2]);
			DestroyDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_3]);
			DestroyDynamicObject(movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_4]);
			switch (type)
			{
				case ELEVATOR_LIGHTS_CONSTANT:
				{
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_1] = CreateDynamicObject(19121, elevatorCoordinates[elevatorid][0] + 3.060504, elevatorCoordinates[elevatorid][1] - 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_2] = CreateDynamicObject(19121, elevatorCoordinates[elevatorid][0] + 3.060504, elevatorCoordinates[elevatorid][1] + 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_3] = CreateDynamicObject(19121, elevatorCoordinates[elevatorid][0] - 3.060504, elevatorCoordinates[elevatorid][1] + 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_4] = CreateDynamicObject(19121, elevatorCoordinates[elevatorid][0] - 3.060504, elevatorCoordinates[elevatorid][1] - 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 0.561335, 0.0, 0.0, 0.0);
				}
				case ELEVATOR_LIGHTS_FLASHING:
				{
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_1] = CreateDynamicObject(3666, elevatorCoordinates[elevatorid][0] + 3.060504, elevatorCoordinates[elevatorid][1] - 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_2] = CreateDynamicObject(3666, elevatorCoordinates[elevatorid][0] + 3.060504, elevatorCoordinates[elevatorid][1] + 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_3] = CreateDynamicObject(3666, elevatorCoordinates[elevatorid][0] - 3.060504, elevatorCoordinates[elevatorid][1] + 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 0.561335, 0.0, 0.0, 0.0);
					movingObjectData[elevatorid][E_MOVING_OBJECT_LIGHT_4] = CreateDynamicObject(3666, elevatorCoordinates[elevatorid][0] - 3.060504, elevatorCoordinates[elevatorid][1] - 1.684815, elevatorLevels[elevatorid][elevatorData[elevatorid][E_ELEVATOR_CURRENT_LEVEL] - 1] + 0.561335, 0.0, 0.0, 0.0);
				}
			}
		}
	}
	return true;
}