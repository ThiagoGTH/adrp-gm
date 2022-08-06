#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_VEHICLES (2000)

enum E_VEHICLE_DATA {
    // 1°
    vSQLID,                 // ID do veículo no MySQL
    vID,                    // ID real do veículo
    vVehicle,               // CreateVehicle
    vExists,                // Definir se existe
    vModel,                 // ModelID do veículo
    vOwner,                 // ID do personagem dono do veículo
    vFaction,               // ID da facção do veículo
    vBusiness,              // ID da empresa do veículo
    vJob,                   // ID do emprego pertencente ao veículo
    vName[256],             // Nome personalizado
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

    // 2°
    Float:vFuel,            // Combustível do veículo
    Float:vHealth,          
    Float:vBattery,         // Bateria do veículo
	Float:vEngine,          // Motor do veículo
    Float:vMiles,           // Milhas rodadas
    Float:vMilesCon,        // Contagem de milhas

    // 3°
    vInsurance,
    vSunpass,
    vAlarm,

    // 4°
    vMods[17],              // Modificações

    // 5°
    vWeapons[30],           // Armas guardadas
	vWeaponsType[30],       // Tipo das armas
	vAmmo[30],              // Munição das armas

    // 6°
    vDamage[23],            // 9 calibres + 14 partes veiculares que podem danificar
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

hook OnGameModeInit(){
    LoadVehicles();
    return true;
}



static const Letter[27][] = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
static const Number[10] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

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