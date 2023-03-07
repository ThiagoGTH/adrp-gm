#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
	for(new i = 0; i < MAX_VEHICLES; i++)
		VehicleInterior[i] = 0;

	SetTimer("VehicleCheck", 2250, true); //2s
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
	return ChangeVehicleColours(vInfo[vehicleid][vVehicle], color1, color2);
}

GetEngineStatus(vehicleid) {
	static
	    bool:engine,
	    bool:lights,
	    bool:alarm,
	    bool:doors,
	    bool:bonnet,
	    bool:boot,
	    bool:objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (engine != true)
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
	    bool:engine,
	    bool:lights,
	    bool:alarm,
	    bool:doors,
	    bool:bonnet,
	    bool:boot,
	    bool:objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (lights != true)
		return false;

	return true;
}

GetHoodStatus(vehicleid) {
	static
	    bool:engine,
	    bool:lights,
	    bool:alarm,
	    bool:doors,
	    bool:bonnet,
	    bool:boot,
	    bool:objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (bonnet != true)
		return false;

	return true;
}

GetDoorsStatus(vehicleid) {
	static
	    bool:engine,
	    bool:lights,
	    bool:alarm,
	    bool:doors,
	    bool:bonnet,
	    bool:boot,
	    bool:objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (doors != true)
		return false;

	return true;
}

SetEngineStatus(vehicleid, bool:status) {
	static
	    bool:engine,
	    bool:lights,
	    bool:alarm,
	    bool:doors,
	    bool:bonnet,
	    bool:boot,
	    bool:objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
}

SetLightStatus(vehicleid, bool:status) {
	static
	    bool:engine,
	    bool:lights,
	    bool:alarm,
	    bool:doors,
	    bool:bonnet,
	    bool:boot,
	    bool:objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}

SetHoodStatus(vehicleid, bool:status) {
	static
	    bool:engine,
	    bool:lights,
	    bool:alarm,
	    bool:doors,
	    bool:bonnet,
	    bool:boot,
	    bool:objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}

SetDoorsStatus(vehicleid, bool:status) {
	static
	    bool:engine,
	    bool:lights,
	    bool:alarm,
	    bool:doors,
	    bool:bonnet,
	    bool:boot,
	    bool:objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, status, bonnet, boot, objective);
}

GetVehicleFromBehind(vehicleid) {
	static
	    Float:fCoords[7];

	GetVehiclePos(vehicleid, fCoords[0], fCoords[1], fCoords[2]);
	GetVehicleZAngle(vehicleid, fCoords[3]);

	for (new i = 1; i != MAX_VEHICLES+1; i ++) if (i != vehicleid && GetVehiclePos(i, fCoords[4], fCoords[5], fCoords[6]))
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
	    for (new i = 1; i != MAX_VEHICLES+1; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ) && GetVehicleModel(i) != 530) {
		    if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ)) return i;
		}
	} else {
		for (new i = 1; i != MAX_VEHICLES+1; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ)) {
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

forward VehicleCheck();
public VehicleCheck() {
	static Float:fHealth;
	for (new i = 1; i != MAX_VEHICLES+1; i ++) if (IsValidVehicle(i) && GetVehicleHealth(i, fHealth) && fHealth < 300.0) {
	    SetVehicleHealth(i, 300.0);
	    new vehicleid;
		vehicleid = VehicleGetID(i);
		if(vInfo[vehicleid][vEngine] > 0.030) vInfo[vehicleid][vEngine] -= 0.030;
		
 		vInfo[vehicleid][vHealthRepair] = 300.0;
	    SetEngineStatus(i, false);
	}
	return true;
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

SendVehicleMessage(vehicleid, color, const str[], {Float,_}:...) {
	static
	    args,
	    start,
	    end;

	static string[256];
	
	string[0] = '\0';

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach(new i : Player) {
		 	if (GetPlayerVehicleID(i) == vehicleid) {
			    SendClientMessage(i, color, string);
				foreach(new ix : Player) {
				    if(pInfo[ix][pSpectating] == i)
				        va_SendClientMessage(ix, color, "[CHAT SPEC %s] %s", pNome(i), string);
				}
			}
		}
		return true;
	}

	foreach(new i : Player) {
		if (GetPlayerVehicleID(i) == vehicleid) {
 			SendClientMessage(i, color, string);

			foreach(new ix : Player) {
				if(pInfo[ix][pSpectating] == i)
				    va_SendClientMessage(ix, color, "[CHAT SPEC %s] %s", pNome(i), string);
			}
		}
	}
	return true;
}