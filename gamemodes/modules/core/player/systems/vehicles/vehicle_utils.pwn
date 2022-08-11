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
    Float:vHealth,          
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

new Vehicle_Interior[MAX_VEHICLES];

hook OnGameModeInit(){
	for(new i = 0; i < MAX_VEHICLES; i++)
		Vehicle_Interior[i] = 0;

    LoadVehicles();
    return true;
}

hook LinkVehicleToInterior(vehicleid, interiorid)
{
	Vehicle_Interior[vehicleid] = interiorid;
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