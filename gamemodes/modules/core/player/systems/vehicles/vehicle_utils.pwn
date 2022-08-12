#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_VEHICLES (2000)

enum E_VEHICLE_DATA {
    // 1°                   // MAIN
    vID,                    // ID do veículo
    vVehicle,               // CreateVehicle
    vExists,                // Definir se existe
    vModel,                 // ModelID do veículo
    vOwner,                 // ID do personagem dono do veículo
    vFaction,               // ID da facção do veículo
    vBusiness,              // ID da empresa do veículo
    vJob,                   // ID do emprego pertencente ao veículo
    vName[64],              // Nome personalizado
    vNamePersonalized,      // Se o nome é personalizado
    vLegal,                 // Se o veículo é legalizado
    vPlate[128],            // Placa do veículo
    vPlatePersonalized,     // Se a placa é personalizada
    bool:vLocked,           // Trancado 
    vColor1,                // Cor primária
    vColor2,                // Cor secundária
    vPaintjob,              // Paintjob do veículo
    Float:vPos[4],          // Posições (X, Y, Z, A) do veículo
    vVW,                    // Virtual World do veículo
    vInterior,              // Interior do veículo
    vImpounded,             // Se o veículo está apreendido ou não
    vImpoundedPrice,        // Valor da apreensão
    vImpoundedReason[64],   // Motivo da apreensão

    // 2°                   // STATS
    vInsurance,             // Seguro
    vSunpass,               // Pedágio
    vAlarm,                 // Alarme
    Float:vFuel,            // Combustível do veículo
	Float:vMaxFuel,
    Float:vHealth,
	Float:vHealthRepair,
	Float:vMaxHealth,
	vEnergyResource,
    Float:vBattery,         // Bateria do veículo
	Float:vEngine,          // Motor do veículo
    Float:vMiles,           // Milhas rodadas
    Float:vMilesCon,        // Contagem de milhas
	Float:MilesPos[3],		// Contagem de milhas
    
    // 3°
    vMods[17],              // Modificações

    // 4°                   // INVENTORY 1
    vWeapons[30],           // Armas guardadas
	vWeaponsType[30],       // Tipo das armas
	vAmmo[30],              // Munição das armas

	// 5°
    vPanelsStatus,			// Status da lataria 
	vDoorsStatus,			// Status das portas
    vLightsStatus,			// Status das luzes
    vTiresStatus,			// Status dos pneus

    // 6°
    vDamage[23],            // 9 calibres + 14 partes veiculares que podem danificar

	// 7° 
	vObject[5],
	vObjectSlot[5],
	Float:vObjectPosX[5],
	Float:vObjectPosY[5],
	Float:vObjectPosZ[5],
	Float:vObjectRotX[5],
	Float:vObjectRotY[5],
	Float:vObjectRotZ[5],
};
new vInfo[MAX_DYNAMIC_VEHICLES][E_VEHICLE_DATA];

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

new Text3D:v3DText[MAX_VEHICLES];
new vCallsign[MAX_VEHICLES];
new VehicleInterior[MAX_VEHICLES];

hook OnGameModeInit() {
	for(new i = 0; i < MAX_VEHICLES; i++)
		VehicleInterior[i] = 0;

    LoadVehicles();
    return true;
}

hook LinkVehicleToInterior(vehicleid, interiorid) {
	VehicleInterior[vehicleid] = interiorid;
	return true;
}

static const Letter[27][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
static const Number[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

SetPlateFree(playerid) {
	new plate[128], Caracter1, Caracter2, Caracter3, Caracter4, Caracter5, Caracter6, Caracter7;
 	Caracter1 = randomEx(0, 9);     //Numero
 	Caracter2 = randomEx(0, 26);    //Letra
 	Caracter3 = randomEx(0, 26);    //Letra
 	Caracter4 = randomEx(0, 26);    //Letra
 	Caracter5 = randomEx(0, 9);     //Numero
 	Caracter6 = randomEx(0, 9);     //Numero
 	Caracter7 = randomEx(0, 9);     //Numero
 	format(plate, sizeof(plate), "%d%s%s%s%d%d%d", Number[Caracter1], Letter[Caracter2], Letter[Caracter3], Letter[Caracter4], Number[Caracter5], Number[Caracter6], Number[Caracter7]);
    
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `plate` = '%s'", plate);
    new Cache:result = mysql_query(DBConn, query);
	if(cache_num_rows() > 0)
		return SetPlateFree(playerid);

	cache_delete(result);
	
	format(pInfo[playerid][pBuyingPlate], 120, "%s", plate);
	return true;
}

ReturnVehicleModelName(model) {
	new name[32] = "Nenhum";

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

VehicleGetID(vehicleid) {
	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (vInfo[i][vExists] && vInfo[i][vVehicle] == vehicleid) {
	    return i;
	}
	return -1;
}

VehicleNearest(playerid) {
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (vInfo[i][vExists] && vInfo[i][vVehicle]) {
		GetVehiclePos(vInfo[i][vVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vInfo[i][vVehicle])) {
		    return i;
		}
	}
	return -1;
}

VehicleNearestToLock(playerid) {
	static Float:fX, Float:fY, Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (vInfo[i][vExists] && vInfo[i][vVehicle]) {
		GetVehiclePos(vInfo[i][vVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vInfo[i][vVehicle]) && vInfo[i][vOwner] == pInfo[playerid][pID]) return i;
		
	}

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (vInfo[i][vExists] && vInfo[i][vVehicle]) {
		GetVehiclePos(vInfo[i][vVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vInfo[i][vVehicle])) return i;
	}
	return -1;
}

IsVehicleImpounded(vehicleid) {
    new id = VehicleGetID(vehicleid);

	if (id != -1 && vInfo[id][vImpounded] != -1 && vInfo[id][vImpoundedPrice] > 0)
	    return true;

	return false;
}

VehicleIsOwner(playerid, vehicleid) {
	if(vehicleid == -1) return false;
    if(!pInfo[playerid][pLogged] || pInfo[playerid][pID] == -1) return false;
    if((vInfo[vehicleid][vExists] && vInfo[vehicleid][vOwner] != 0) && (vInfo[vehicleid][vOwner] == pInfo[playerid][pID])) return true;
	return false;
}

VehicleInside(playerid) {
	new vehicleid;
	if (IsPlayerInAnyVehicle(playerid) && (vehicleid = VehicleGetID(GetPlayerVehicleID(playerid))) != -1)
	    return vehicleid;
	return -1;
}

ReturnVehicleHealth(vehicleid) {
	if (!IsValidVehicle(vehicleid))
	    return 0;

	static
	    Float:amount;

	GetVehicleHealth(vehicleid, amount);
	return floatround(amount, floatround_round);
}

SetVehicleColor(vehicleid, color1, color2) {
	if (vehicleid != -1) {
	    vInfo[vehicleid][vColor1] = color1;
	    vInfo[vehicleid][vColor2] = color2;
	    SaveVehicle(vehicleid);
	}
	return ChangeVehicleColor(vInfo[vehicleid][vVehicle], color1, color2);
}

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

GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z) {
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID) return (x = 0.0, y = 0.0, z = 0.0), 0;

	static Float:pos[7];
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];
	return true;
}

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

GetDoorsStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (doors != 1)
		return false;

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

SetAlarmStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, status, doors, bonnet, boot, objective);
}

SetDoorsStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, alarm, alarm, status, bonnet, boot, objective);
}

GetVehicleFromBehind(vehicleid) {
	static
	    Float:fCoords[7];

	GetVehiclePos(vehicleid, fCoords[0], fCoords[1], fCoords[2]);
	GetVehicleZAngle(vehicleid, fCoords[3]);

	for (new i = 1; i != GetVehiclePoolSize()+1; i ++) if (i != vehicleid && GetVehiclePos(i, fCoords[4], fCoords[5], fCoords[6]))
	{
		if (floatabs(fCoords[0] - fCoords[4]) < 6 && floatabs(fCoords[1] - fCoords[5]) < 6 && floatabs(fCoords[2] - fCoords[6]) < 6)
			return i;
	}
	return INVALID_VEHICLE_ID;
}

GetNearestVehicle(playerid, forkflit=0) {
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	if(forkflit) {
	    for (new i = 1; i != GetVehiclePoolSize()+1; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ) && GetVehicleModel(i) != 530) {
		    if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ)) return i;
		}
	} else {
		for (new i = 1; i != GetVehiclePoolSize()+1; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ)) {
		    if (IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ)) return i;
		}
	}
	return INVALID_VEHICLE_ID;
}

GetAvailableSeat(vehicleid, start = 1) {
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}

GetVehicleMaxSeats(vehicleid) {
    static const g_arrMaxSeats[] = {
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
		2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
		4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
		1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
		4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
		4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
		0, 0
	};

	new  model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return false;
}

IsVehicleSeatUsed(vehicleid, seat) {
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return true;
	}
	return false;
}

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
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}

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

IsPlayerNearHood(playerid, vehicleid) {
	static Float:fX, Float:fY, Float:fZ;
	GetVehicleHood(vehicleid, fX, fY, fZ);
	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.0, fX, fY, fZ);
}

SetCarAttributes(vehiclemodel, vehicleid) {
	new count;
    for (new i = 0; i < sizeof(arrBatteryEngine); i ++) {
	    if(vehiclemodel == arrBatteryEngine[i][VehModel]) {
	        vInfo[vehicleid][vBattery] = arrBatteryEngine[i][VehBattery];
	        vInfo[vehicleid][vEngine] = arrBatteryEngine[i][VehEngine];
	        vInfo[vehicleid][vEnergyResource] = arrBatteryEngine[i][VehFuelType];
	        count++;
	        break;
	    }
	} if(!count) {
	    vInfo[vehicleid][vBattery] = 100.000;
     	vInfo[vehicleid][vEngine] = 100.000;
     	vInfo[vehicleid][vEnergyResource] = 1;
     	vInfo[vehicleid][vMaxHealth] = 1000.0;
     	count = 0;
	}
	return true;
}