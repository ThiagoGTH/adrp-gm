#define DMV_VEHICLE 410
#define DMV_VEHICLE_VALUE 50
#define DMV_MAX_VEHICLE_HEALTH 850.0
#define MAX_DRIVERLICENCE_WAR 128

new Float:DMV_Checkpoint[9][3] = {
    {1808.2336,-1890.0858,13.1137},
    {1707.3950,-1810.0660,13.0689},
    {1425.1021,-1870.0938,13.0882},
    {1391.6542,-1745.7252,13.0866},
    {1442.9921,-1594.8103,13.0880},
    {1747.2328,-1710.5015,13.0883},
    {1805.9856,-1734.9451,13.0954},
    {1818.3652,-1820.2645,13.1177},
    {1791.8119,-1931.6996,13.0915}
};

new DMVCheckpoint[MAX_PLAYERS],
    bool:InDMV[MAX_PLAYERS],
    vehicleDMV[MAX_PLAYERS],
    Text3D:DMV3dTEXT[MAX_PLAYERS],
    DMVTestType[MAX_PLAYERS] = 0;

enum E_LICENCES_DATA {
	license_number,
	license_status,

	license_vehicle,
	license_medical,
	license_plane,
	license_gun,

	license_warnings,
	warning_one[MAX_DRIVERLICENCE_WAR],
	warning_two[MAX_DRIVERLICENCE_WAR],
	warning_three[MAX_DRIVERLICENCE_WAR]
};

new pLicenses[MAX_PLAYERS][E_LICENCES_DATA];