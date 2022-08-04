#include <YSI_Coding\y_hooks>

new g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

enum vehicleattributes {
	VehModel,
	Float:VehBattery,
	Float:VehEngine,
	VehFuelType,
	Float:VehMaxVelocity,
	Float:VehMass,
	Float:VehConsumation,
	Float:VehMaxFuel
};

stock const arrBatteryEngine[141][vehicleattributes] = {
    //Fuel Types:
    //0 - Sem motor
    //1 - Normal Fuel
    //2 - Diesel
    //3 - Eletric
    //4 - Turbo
    //Sem motor
    {509, 100.0, 100.0, 0, 120.0, 100.0, 0.0, 0.0}, //Lowriderbike
    {510, 100.0, 100.0, 0, 140.0, 100.0, 0.0, 0.0}, //Moutainbike
    {481, 100.0, 100.0, 0, 120.0, 100.0, 0.0, 0.0}, //BMX
    //Normal Fuel
    {522, 100.000, 100.000, 1, 190.0, 400.0, 4.0, 7.0}, //Nrg
    {256, 100.000, 100.000, 1, 230.0, 1400.0, 4.0, 17.0}, //SuperGT
    {477, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 17.0}, //ZR325
    {480, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 17.0}, //Comet
    {580, 100.000, 100.000, 1, 165.0, 2200.0, 4.0, 19.0}, //Stafford
    {409, 100.000, 100.000, 1, 180.0, 2200.0, 4.0, 22.0}, //Stretch
    {545, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 18.0}, //Hustler
    {429, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 16.0}, //Banshee
    {541, 100.000, 100.000, 1, 230.0, 1200.0, 5.0, 14.0}, //Bullet
    {415, 100.000, 100.000, 1, 230.0, 1200.0, 5.0, 16.0}, //Chettah
    {411, 100.000, 100.000, 1, 240.0, 1400.0, 7.0, 14.0}, //Infernus
    {423, 100.000, 100.000, 1, 180.0, 2200.0, 4.0, 21.0}, //Mr. Whooper
    {560, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 19.0}, //Sultan
    {451, 100.000, 100.000, 1, 240.0, 1400.0, 5.0, 17.0}, //Turismo
    {521, 100.000, 100.000, 1, 190.0, 500.0, 7.0, 10.0}, //FCR
    {461, 100.000, 100.000, 1, 190.0, 500.0, 6.0, 10.0}, //PCJ
    {581, 100.000, 100.000, 1, 190.0, 500.0, 6.0, 10.0}, //BF-400
    {468, 100.000, 100.000, 1, 190.0, 500.0, 6.0, 10.0}, //Sanchez
    {562, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 19.0}, //Elegy
    {558, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 22.0}, //Uranus
    {559, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 23.0}, //Jester
    {565, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 19.0}, //Flash
    {603, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 18.0}, //Phoenix
    {402, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 19.0}, // Buffalo
    {555, 100.000, 100.000, 1, 180.0, 1500.0, 5.0, 20.0}, // Windsor
    {575, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 20.0}, // Broadway
    {535, 100.000, 100.000, 1, 160.0, 1950.0, 5.0, 23.0}, //Slamvan
    {567, 100.000, 100.000, 1, 160.0, 1500.0, 5.0, 21.0}, //Savanna
    {551, 100.000, 100.000, 1, 165.0, 1800.0, 5.0, 22.0}, //Merit
    {491, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 20.0}, //Virgo
    {587, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 19.0}, //Euros
    {445, 100.000, 100.000, 1, 165.0, 1650.0, 5.0, 22.0}, //Admiral
    {401, 100.000, 100.000, 1, 165.0, 1650.0, 5.0, 17.0}, //Bravura
    {405, 100.000, 100.000, 1, 165.0, 1600.0, 5.0, 21.0}, //Sentinel
    {426, 100.000, 100.000, 1, 200.0, 1600.0, 5.0, 20.0}, //Premier
    {561, 100.000, 100.000, 1, 200.0, 1800.0, 5.0, 21.0}, //Stratum
    {439, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 20.0}, //Stallion
    {602, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 17.0}, //Alpha
    {589, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 16.0}, //Club
    {550, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 19.0}, //Sunrise
    {517, 100.000, 100.000, 1, 165.0, 1400.0, 5.0, 19.0}, //Majestic
    {516, 100.000, 100.000, 1, 165.0, 1400.0, 5.0, 19.0}, //Nebula
    {507, 100.000, 100.000, 1, 165.0, 2200.0, 4.0, 19.0}, //Elegant
    {496, 100.000, 100.000, 1, 200.0, 1000.0, 5.0, 19.0}, //Blista
    {475, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 19.0}, //Sabre
    {474, 100.000, 100.000, 1, 160.0, 1950.0, 4.0, 19.0}, //Hermes
    {424, 100.000, 100.000, 1, 170.0, 1200.0, 5.0, 15.0}, //BFInjection
    {421, 100.000, 100.000, 1, 180.0, 1850.0, 4.0, 21.0}, //Washington
    {533, 100.000, 100.000, 1, 200.0, 1600.0, 5.0, 22.0}, //Feltzer
    {600, 100.000, 100.000, 1, 165.0, 1600.0, 5.0, 20.0}, //Picador
    {586, 100.000, 100.000, 1, 190.0, 800.0, 5.0, 10.0}, //Wayfarer
    {463, 100.000, 100.000, 1, 190.0, 800.0, 5.0, 10.0}, //Freeway
    {534, 100.000, 100.000, 1, 160.0, 1800.0, 4.0, 20.0}, //Remington
    {536, 100.000, 100.000, 1, 160.0, 1500.0, 4.0, 20.0}, //Blade
    {529, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 20.0}, //Willard
    {526, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 20.0}, //Fortune
    {518, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 20.0}, //Buccaner
    {492, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 20.0}, //Greenwood
    {467, 100.000, 100.000, 1, 160.0, 1900.0, 4.0, 20.0}, //Oceanic
    {466, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 20.0}, //Glandale
    {419, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 20.0}, //Esperanto
    {412, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 20.0}, //Voodoo
    {499, 100.000, 100.000, 1, 140.0, 3500.0, 4.0, 20.0}, //Benson
    {540, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 20.0}, //Vincent
    {609, 100.000, 100.000, 1, 140.0, 5500.0, 4.0, 25.0}, //Boxburg
    {524, 100.000, 100.000, 1, 110.0, 5500.0, 4.0, 25.0}, //Cement Truck
    {413, 100.000, 100.000, 1, 160.0, 2600.0, 4.0, 28.0}, //Pony
    {440, 100.000, 100.000, 1, 160.0, 2000.0, 4.0, 27.0}, //Rumpo
    {459, 100.000, 100.000, 1, 160.0, 1900.0, 5.0, 26.0}, //Topfun
    {552, 100.000, 100.000, 1, 160.0, 2600.0, 4.0, 29.0}, //Utily Van
    {478, 100.000, 100.000, 1, 150.0, 1850.0, 5.0, 24.0}, //Walton
    {572, 100.000, 100.000, 1, 60.0, 800.0, 6.0, 24.0}, //Mower
    {530, 100.000, 100.000, 1, 60.0, 1000.0, 5.0, 10.0}, //Forkflit
    {438, 100.000, 100.000, 1, 160.0, 1750.0, 5.0, 22.0}, //Cabbie
    {420, 100.000, 100.000, 1, 180.0, 1450.0, 5.0, 22.0}, //Taxi
    {525, 100.000, 100.000, 1, 160.0, 5500.0, 4.0, 24.0}, //Towtruck
    {588, 100.000, 100.000, 1, 140.0, 5500.0, 4.0, 19.0}, //Hotdogcar
    {462, 100.000, 100.000, 1, 190.0, 500.0, 6.0, 8.0}, //Faggio
    {604, 100.000, 100.000, 1, 110.0, 1600.0, 5.0, 20.0}, //Glendale Wreck
    {605, 100.000, 100.000, 1, 105.0, 1700.0, 5.0, 20.0}, //Sadler Wreck
    {466, 100.000, 100.000, 1, 110.0, 1600.0, 5.0, 20.0}, //Glendale
    {605, 100.000, 100.000, 1, 105.0, 1700.0, 5.0, 20.0}, //Sadler Wreck
    {585, 100.000, 100.000, 1, 165.0, 1800.0, 5.0, 22.0}, //Emperor
    {566, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 22.0}, //Tahoma
    {576, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 22.0}, //Tornado
    {549, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 22.0}, //Tampa
    {547, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 22.0}, //Primo
    {546, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 22.0}, //Intruder
    {543, 100.000, 100.000, 1, 165.0, 1700.0, 5.0, 19.0}, //Sadler
    {542, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 20.0}, //Clover
    {527, 100.000, 100.000, 1, 160.0, 1200.0, 5.0, 21.0}, //Cadrona
    {508, 100.000, 100.000, 1, 140.0, 3500.0, 4.0, 24.0}, //Journey
    {483, 100.000, 100.000, 1, 120.0, 1900.0, 5.0, 23.0}, //Camper
    {482, 100.000, 100.000, 1, 150.0, 1900.0, 5.0, 27.0}, //Burrito
    {479, 100.000, 100.000, 1, 165.0, 1500.0, 5.0, 22.0}, //Regina
    {458, 100.000, 100.000, 1, 165.0, 2000.0, 4.0, 22.0}, //Solair
    {436, 100.000, 100.000, 1, 160.0, 1400.0, 5.0, 22.0}, //Previon
    {418, 100.000, 100.000, 1, 150.0, 2000.0, 4.0, 25.0}, //Moonbeam
    {410, 100.000, 100.000, 1, 160.0, 1000.0, 5.0, 17.0}, //Manana
    {404, 100.000, 100.000, 1, 150.0, 1200.0, 5.0, 19.0}, //Perenniel
    {457, 100.000, 100.000, 1, 60.0, 400.0, 6.0, 10.0}, //Caddy
    {471, 100.000, 100.000, 1, 160.0, 400.0, 6.0, 7.0}, //Quad
    {514, 100.000, 100.000, 1, 120.0, 3800.0, 6.0, 100.0}, //Petrol Tanker
    //Diesel
    {431, 100.000, 100.000, 2, 130.0, 5500.0, 7.0, 30.0}, //Bus
    {437, 100.000, 100.000, 2, 130.0, 5500.0, 7.0, 30.0}, //Coach
    {531, 100.000, 100.000, 2, 70.0, 2000.0, 6.0, 25.0}, //Tractor
    {408, 100.000, 100.000, 2, 110.0, 5500.0, 7.0, 30.0}, //Tashmaster
    {515, 100.000, 100.000, 2, 120.0, 3800.0, 6.0, 30.0}, //Roadtraion
    {578, 100.000, 100.000, 2, 110.0, 5500.0, 6.0, 30.0}, //DFT
    {455, 100.000, 100.000, 2, 140.0, 8500.0, 7.0, 30.0}, //Flatbet
    {403, 100.000, 100.000, 2, 120.0, 3500.0, 6.0, 30.0}, //Linerunner
    {414, 100.000, 100.000, 2, 140.0, 3500.0, 6.0, 30.0}, //Mule
    {443, 100.000, 100.000, 2, 150.0, 8000.0, 7.0, 30.0}, //Packer
    {498, 100.000, 100.000, 2, 140.0, 5500.0, 7.0, 30.0}, //Boxville
    {422, 100.000, 100.000, 2, 165.0, 1700.0, 6.0, 25.0}, //Bobcat
    {489, 100.000, 100.000, 2, 170.0, 1700.0, 6.0, 25.0}, //Rancher
    {554, 100.000, 100.000, 2, 170.0, 1700.0, 6.0, 25.0}, //Yosemite
    {400, 100.000, 100.000, 2, 160.0, 1700.0, 6.0, 25.0}, //Landstalker
    {579, 100.000, 100.000, 2, 160.0, 2500.0, 6.0, 25.0}, //Huntley
    {500, 100.000, 100.000, 2, 160.0, 1300.0, 6.0, 25.0}, //Mesa
    {434, 100.000, 100.000, 2, 200.0, 2500.0, 6.0, 25.0}, //Hotkine
    {470, 100.000, 100.000, 2, 170.0, 2500.0, 6.0, 30.0},//Patriot
    {456, 100.000, 100.000, 2, 160.0, 4500.0, 7.0, 30.0}, //Yankee
    {406, 100.000, 100.000, 2, 110.0, 10500.0, 7.0, 50.0}, //Dumper
    {434, 100.000, 100.000, 2, 170.0, 2300.0, 7.0, 30.0},//Hotknife
    //Turbo
    {593, 100.000, 100.000, 4, 200.0, 10000.0, 10.0, 250.0}, //Dodo
    {563, 100.000, 100.000, 4, 200.0, 10000.0, 10.0, 250.0}, //Raindance
    {519, 100.000, 100.000, 4, 200.0, 15000.0, 10.0, 250.0}, //Shamal
    {469, 100.000, 100.000, 4, 200.0, 2500.0, 10.0, 250.0}, //Sparrow
    {446, 100.000, 100.000, 4, 200.0, 2500.0, 10.0, 250.0}, //Squalo
    {453, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Reefer
    {454, 100.000, 100.000, 4, 200.0, 2200.0, 10.0, 250.0}, //Tropic
    {473, 100.000, 100.000, 4, 200.0, 800.0, 10.0, 250.0}, //Dinghy
    {484, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Marquis
    {487, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Maverick
    {511, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Beagle
    {417, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Levetian
    {520, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0} //Hydra
};

ReturnVehicleModelName(model) {
	new
	    name[32] = "Nenhum";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

ReturnVehicleName(vehicleid) {
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "Nenhum";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

GetVehicleModelByName(const name[]) {
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return false;
}
/*
GetVehicleDriver(vehicleid) {
	foreach (new i : Player) {
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return i;
	}
	return INVALID_PLAYER_ID;
}

IsWindowedVehicle(vehicleid) {
	static const g_aWindowStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1,
	    1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1,
		1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
	new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return false;

    return (g_aWindowStatus[modelid - 400]);
}

IsNewsVehicle(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
	    case 488, 582: return true;
	}
	return false;
}

IsACruiser(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
	    case 426, 523, 415, 541, 560, 427, 490, 482, 528, 596..599, 601:
	    {
			new carid = Car_GetID(vehicleid);

			if(CarData[carid][carFaction] == 1)
 				return true;
	    }
	}
	return false;
}

IsLSFDVehicle(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
		case 407, 544:
		    return true;
	}
	return false;
}*/

IsDoorVehicle(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return true;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return true;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return true;
	}
	return false;
}
/*
IsDoorVehicleWithModel(modelid) {
	switch (modelid) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return true;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return true;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return true;
	}
	return false;
}

IsPaintJob(vehid) {
    new pveh = GetVehicleModel(vehid);
    if(pveh == 576 || pveh == 575 || pveh == 567 || pveh == 565 || pveh == 562 || pveh == 561 ||
    pveh == 560 || pveh == 559 ||
    pveh == 558 || pveh == 536 || pveh == 535 || pveh == 534 || pveh == 483)
    {
        return true;
    }
	return false;
}

IsSpeedoVehicle(vehicleid) {
	if (GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 481 || !IsEngineVehicle(vehicleid)) {
	    return false;
	}
	return true;
}

IsABoat(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return true;
	}
	return false;
}

IsABike(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
		case 448, 461..463, 468, 521..523, 581, 586, 481, 509, 510, 471: return true;
	}
	return false;
}

IsAPlane(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return true;
	}
	return false;
}

IsATaxi(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
	    case 420: return true;
	}
	return true;
}

IsAHelicopter(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return true;
	}
	return false;
}*/

IsEngineVehicle(vehicleid) {
	static const g_aEngineStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return false;

    return (g_aEngineStatus[modelid - 400]);
}
/*
Float:GetPlayerSpeed(playerid) {
	static Float:velocity[3];

	if (IsPlayerInAnyVehicle(playerid))
	    GetVehicleVelocity(GetPlayerVehicleID(playerid), velocity[0], velocity[1], velocity[2]);
	else
	    GetPlayerVelocity(GetPlayerVehicleID(playerid), velocity[0], velocity[1], velocity[2]);

	return floatsqroot((velocity[0] * velocity[0]) + (velocity[1] * velocity[1]) + (velocity[2] * velocity[2])) * 170.0;
}*/
/*
GetVehicleSpeed(vehicleid) {
    new Float:xPos[3];
    GetVehicleVelocity(vehicleid, xPos[0], xPos[1], xPos[2]);
    return floatround(floatsqroot(xPos[0] * xPos[0] + xPos[1] * xPos[1] + xPos[2] * xPos[2]) * 170.00);
}*/

GetEngineStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (engine != 1)
		return false;

	return true;
}

GetHoodStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (bonnet != 1)
		return false;

	return true;
}
/*
GetTrunkStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (boot != 1)
		return false;

	return true;
}*/

GetLightStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (lights != 1)
		return false;

	return true;
}

GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z) {
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	static
	    Float:pos[7]
	;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];

	return true;
}

SetEngineStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
}

SetLightStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}
/*
SetTrunkStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, status, objective);
}

ChangeTrunk(vehicleid){
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, !boot, objective);
}*/

SetHoodStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}
/*
IsPlayerNearBoot(playerid, vehicleid) {
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleBoot(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 4.5, fX, fY, fZ);
}

IsPlayerNearBootLSPD(playerid, vehicleid) {
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleBoot(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 1.0, fX, fY, fZ);
}*/

IsPlayerNearHood(playerid, vehicleid) {
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleHood(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.0, fX, fY, fZ);
}

static const Letter[27][] = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
static const Number[10] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

SetPlateFree(playerid) {
	new plate[128];
 	new Caracter1, Caracter2, Caracter3, Caracter4, Caracter5, Caracter6, Caracter7;
 	Caracter1 = randomEx(0, 9);//Numero
 	Caracter2 = randomEx(0, 26);//Letra
 	Caracter3 = randomEx(0, 26);//Letra
 	Caracter4 = randomEx(0, 26);//Letra
 	Caracter5 = randomEx(0, 9);//Numero
 	Caracter6 = randomEx(0, 9);//Numero
 	Caracter7 = randomEx(0, 9);//Numero
 	format(plate, sizeof(plate), "%d%s%s%s%d%d%d", Number[Caracter1], Letter[Caracter2], Letter[Caracter3], Letter[Caracter4], Number[Caracter5], Number[Caracter6], Number[Caracter7]);
   
	mysql_format(DBConn, query, sizeof query, "SELECT `carID` FROM `vehicles` WHERE `carPlate` = '%s'", plate);
    new Cache:result = mysql_query(DBConn, query);

	new find = false;
	if(cache_num_rows() > 0) 
		find = true;

	cache_delete(result);

    if(find)
		return SetPlateFree(playerid);

	format(pInfo[playerid][pBuyingPlate], 120, "%s", plate);
	return true;
}

Car_GetCount(playerid) {
	new count = 0;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++){
		if (CarData[i][carExists] && CarData[i][carOwner] == pInfo[playerid][pID]){
   		    count++;
		}
	}
	return count;
}

SetCarAttributes(vehiclemodel, carid) {
	new count;
    for (new i = 0; i < sizeof(arrBatteryEngine); i ++)
	{
	    if(vehiclemodel == arrBatteryEngine[i][VehModel])
	    {
	        CarData[carid][carBattery] = arrBatteryEngine[i][VehBattery];
	        CarData[carid][carEngine] = arrBatteryEngine[i][VehEngine];
	        CarData[carid][carEnergyResource] = arrBatteryEngine[i][VehFuelType];
	        count++;
	        break;
	    }
	}
	if(!count)
	{
	    CarData[carid][carBattery] = 100.000;
     	CarData[carid][carEngine] = 100.000;
     	CarData[carid][carEnergyResource] = 1;
     	CarData[carid][carMaxHP] = 1000.0;
     	count = 0;
	}
	return true;

}

ResetVehicle(vehicleid) {
	if (1 <= vehicleid <= MAX_VEHICLES)
	{
	    CoreVehicles[vehicleid][vehWindowsDown] = false;
		CoreVehicles[vehicleid][vehTemporary] = 0;
		//CoreVehicles[vehicleid][vehLoads] = 0;
		//CoreVehicles[vehicleid][vehLoadType] = 0;
		CoreVehicles[vehicleid][vehCrate] = -1;
		//CoreVehicles[vehicleid][vehTrash] = 0;
		//CoreVehicles[vehicleid][vehRepairing] = 0;
		CoreVehicles[vehicleid][vehSirenOn] = 0;
		//CoreVehicles[vehicleid][vehRadio] = 0;
		CoreVehicles[vehicleid][MilesTraveled] = 0;
		CoreVehicles[vehicleid][MilesPos][0] = 0.0;
		CoreVehicles[vehicleid][MilesPos][1] = 0.0;
		CoreVehicles[vehicleid][MilesPos][2] = 0.0;
		CoreVehicles[vehicleid][vehAFK] = 0;

		new id = Car_GetID(vehicleid);
		if(id != -1)
		{
 			CarData[id][carHealthRepair] = 1000.0;

 			if(CarData[id][carFaction] != 0)
 			{
 			    if(CarData[id][carFuel] == 0)
 			    {
 			        CarData[id][carFuel] = CarData[id][carMaxFuel];
 			    }
 			}

 			if(CoreVehicles[vehicleid][vehFuel] == 0)
 			{
 			    CoreVehicles[vehicleid][vehFuel] = CarData[id][carFuel];
 			}

 			/*if(CarData[id][carModel] == 427 && CarData[id][carFaction] == FACTION_POLICE)
			    SetVehicleHealth(CarData[id][carVehicle], 3000);
			else if(CarData[id][carModel] == 428 && CarData[id][carFaction] == FACTION_POLICE)
			    SetVehicleHealth(CarData[id][carVehicle], 3000);
			else if(CarData[id][carModel] == 490 && CarData[id][carFaction] == FACTION_POLICE)
			    SetVehicleHealth(CarData[id][carVehicle], 2500);
			else if(CarData[id][carModel] == 528 && CarData[id][carFaction] == FACTION_POLICE)
			    SetVehicleHealth(CarData[id][carVehicle], 4000);
			else if(CarData[id][carModel] == 601 && CarData[id][carFaction] == FACTION_POLICE)
			    SetVehicleHealth(CarData[id][carVehicle], 6000);*/
		}
	}
	return 1;
}
/*
Car_GetRealID(carid) {
	if (carid == -1 || !CarData[carid][carExists] || CarData[carid][carVehicle] == INVALID_VEHICLE_ID)
	    return INVALID_VEHICLE_ID;

	return CarData[carid][carVehicle];
}*/

Car_GetID(vehicleid) {
	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carVehicle] == vehicleid) {
	    return i;
	}
	return -1;
}

SetCarSlotFree(playerid, carid) {
	for (new slot = 0; slot < MAX_PLAYER_VEHICLES; slot ++)
    {
    	if(!pInfo[playerid][pVehicles][slot])
    	{
    		pInfo[playerid][pVehicles][slot] = CarData[carid][carID];
     		break;
		}
   	}
	return 1;
}

RebuildCarList(playerid) {
    for (new slot = 0; slot < MAX_PLAYER_VEHICLES; slot ++)
            pInfo[playerid][pVehicles][slot] = 0;

	for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) {
		if (Car_IsOwner(playerid, i))
        	SetCarSlotFree(playerid, i);
    }
	return true;
}

forward AdaptandoLista(playerid);
public AdaptandoLista(playerid) {
    RebuildCarList(playerid);
    SendClientMessage(playerid, COLOR_LIGHTGREEN, "PROCESSADO: Lista reorganizada.");
	return false;
}

CheckCountVehicle(playerid) {
	new count = 0;

	for (new i = 0; i < MAX_DYNAMIC_CARS; i ++)
    {
		if(Car_IsOwner(playerid, i))
		{
			if(CarData[i][carVehicle])
			{
				count++;
			}
		}
  	}
	return count;
}

Car_IsOwner(playerid, carid) {
	if (!pInfo[playerid][pLogged] || pInfo[playerid][pID] == -1)
	    return false;

    if ((CarData[carid][carExists] && CarData[carid][carOwner] != 0) && CarData[carid][carOwner] == pInfo[playerid][pID])
		return true;

	return false;
}

Car_Inside(playerid) {
	new carid;

	if (IsPlayerInAnyVehicle(playerid) && (carid = Car_GetID(GetPlayerVehicleID(playerid))) != -1)
	    return carid;

	return -1;
}

SetVehicleLock(playerid) {
 	static
	    id = -1;

	if ((id = Car_Inside(playerid)) != -1 || (id = Car_NearestToLock(playerid)) != -1)
	{
	    static
	        engine,
	        lights,
	        alarm,
	        doors,
	        bonnet,
	        boot,
	        objective;

	    GetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);

	    if (Car_IsOwner(playerid, id) || pInfo[playerid][pID] == CarData[id][carRentPlayer])
	    {
			if (!CarData[id][carLocked])
			{
				CarData[id][carLocked] = true;
				Car_Save(id);

				GameTextForPlayer(playerid, "~r~Trancado", 2400, 4);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
			}
			else
			{
				CarData[id][carLocked] = false;
				Car_Save(id);

				GameTextForPlayer(playerid, "~g~Destrancado", 2400, 4);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
			}
		}
		else
			return SendErrorMessage(playerid, "Você não possui as chaves para destrancar este(a) %s.", ReturnVehicleModelName(CarData[id][carModel]));
	}
	else 
		SendErrorMessage(playerid, "Você não está próximo do seu veiculo.");
	
	return 1;
}

AddComponent(vehicleid, componentid) {
	if (!IsValidVehicle(vehicleid) || (componentid < 1000 || componentid > 1193))
	    return 0;

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carMods][GetVehicleComponentType(componentid)] = componentid;
	    Car_Save(id);
	}
	return AddVehicleComponent(vehicleid, componentid);
}

IsVehicleImpounded(vehicleid) {
    new id = Car_GetID(vehicleid);

	if (id != -1 && CarData[id][carImpounded] != -1 && CarData[id][carImpoundPrice] > 0)
	    return true;

	return false;
}

Car_NearestToLock(playerid) {
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carVehicle]) {
		GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(CarData[i][carVehicle]) && CarData[i][carOwner] == pInfo[playerid][pID]) {
		    return i;
		}
	}

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carVehicle]) {
		GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(CarData[i][carVehicle])) {
		    return i;
		}
	}
	return -1;
}

IsVehicleOccupied(vehicleid) {
    foreach(new i : Player) {
        if(IsPlayerConnected(i))
            if(IsPlayerInVehicle(i, vehicleid)) return true;
        
    }
    return false;
}

RespawnVehicle(vehicleid) {
	new id = Car_GetID(vehicleid);

	if (id != -1)
	    Car_Spawn(id);

	else SetVehicleToRespawn(vehicleid);

	ResetVehicle(vehicleid);
	return true;
}

ReturnVehicleHealth(vehicleid) {
	if (!IsValidVehicle(vehicleid))
	    return 0;

	static
	    Float:amount;

	GetVehicleHealth(vehicleid, amount);
	return floatround(amount, floatround_round);
}

IsCarInData(carid) {
	for(new i = 0; i < MAX_DYNAMIC_CARS; i++) {
		if(CarData[i][carExists] && CarData[i][carID] == carid)
			return i;
	}
	return -1;
}

/*Car_WeaponStorage(playerid, carid)
{
    if (!CarData[carid][carExists] || CarData[carid][carLocked])
	    return 0;

    static
	    string[3500];

	string[0] = 0;

	new tamanho = CheckTrunkSpace(CarData[carid][carVehicle]);

	for (new i = 0; i < tamanho; i ++)
	{
	    if (22 <= CarData[carid][carWeapons][i] <= 38)
	    {
	    	if(CarData[carid][carAmmo][i] > 1)
	    	{
		    	if(CarData[carid][carWeaponsType][i])
		    		format(string, sizeof(string), "%s%s (%d balas) **{BBBBBB}ARMA GOVERNAMENTAL{FFFFFF}**\n", string, ReturnWeaponName(CarData[carid][carWeapons][i]), CarData[carid][carAmmo][i]);
		    	else
		        	format(string, sizeof(string), "%s%s (%d balas)\n", string, ReturnWeaponName(CarData[carid][carWeapons][i]), CarData[carid][carAmmo][i]);
	    	}
	    	else
	    	{
		    	if(CarData[carid][carWeaponsType][i])
		    		format(string, sizeof(string), "%s%s (%d bala) **{BBBBBB}ARMA GOVERNAMENTAL{FFFFFF}**\n", string, ReturnWeaponName(CarData[carid][carWeapons][i]), CarData[carid][carAmmo][i]);
		    	else
		        	format(string, sizeof(string), "%s%s (%d bala)\n", string, ReturnWeaponName(CarData[carid][carWeapons][i]), CarData[carid][carAmmo][i]);
	    	}
	    }
		else
		{
			new str[128];
			format(str, 128, "%s **{BBBBBB}ARMA GOVERNAMENTAL{FFFFFF}**", ReturnWeaponName(CarData[carid][carWeapons][i]));

			if(CarData[carid][carWeaponsType][i])
				format(string, sizeof(string), "%s%s\n", string, (CarData[carid][carWeapons][i]) ? (str) : ("Slot Vazio"));
			else
			    format(string, sizeof(string), "%s%s\n", string, (CarData[carid][carWeapons][i]) ? (ReturnWeaponName(CarData[carid][carWeapons][i])) : ("Slot Vazio"));
		}
	}

	if(tamanho == 0) 
		return SendErrorMessage(playerid, "Este veiculo não possui armazenamento de armas.");

	new titulo[128];
	new modelo = GetVehicleModel(CarData[carid][carVehicle]);
	format(titulo, sizeof(titulo), "Porta-Malas - %s (Capacidade: %d)", ReturnVehicleModelName(modelo), tamanho);
	Dialog_Show(playerid, Trunk, DIALOG_STYLE_LIST, titulo, string, "Selecionar", "Cancelar");
	return true;
}*/