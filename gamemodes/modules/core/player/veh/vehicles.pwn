#include <YSI_Coding\y_hooks>

enum coreVehicles {
	vehWindowsDown,
	vehCrate,
    vehTemporary,
	vehSirenOn,
	vehSirenObject,
};
new CoreVehicles[MAX_VEHICLES][coreVehicles];
new vehiclecallsign[MAX_VEHICLES];

new stock g_arrVehicleNames[][] =
{
	{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},
	{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},
	{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
	{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},
	{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},
	{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
	{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
	{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},
	{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
	{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},
	{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
	{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
	{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},
	{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
	{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
	{"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
	{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
	{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
	{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
	{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
	{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},
	{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},
	{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},
	{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
	{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
	{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
	{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},
	{"Utility Trailer"}
};

CMD:destruirveh(playerid, params[])
{
    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 4) return SendPermissionMessage(playerid);

    if(!isnull(params) && !strcmp(params, "todos", true))
	{
	    for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && CoreVehicles[i][vehTemporary])
		{
	        CoreVehicles[i][vehTemporary] = false;

	        DestroyVehicle(i);
	        ResetVehicle(i);
	    }
	    SendServerMessage(playerid, "Você destruiu todos os veículos temporários do servidor.");
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* destruiu todos os veiculos temporarios do servidor.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser]);
    	DCC_SendChannelMessage(DC_AdminCMD, textdc);
	    return 1;
	}
	else if (IsPlayerInAnyVehicle(playerid))
	{
	    new vehicleid = GetPlayerVehicleID(playerid);

	    if (CoreVehicles[vehicleid][vehTemporary])
		{
	        CoreVehicles[vehicleid][vehTemporary] = false;
	        DestroyVehicle(vehicleid);

	        ResetVehicle(vehicleid);
	        SendServerMessage(playerid, "Você destruiu esse veículo.");
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* destruiu um veiculo temporario do servidor.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser]);
    		DCC_SendChannelMessage(DC_AdminCMD, textdc);
		}
		else
		{
		    SendErrorMessage(playerid, "Você não pode destruir este veículo permanente.");
		}
	}
	return 1;
}

CMD:veh(playerid, params[])
{
	static
	    model[32],
		color1,
		color2;

    if(!pInfo[playerid][pLogged]) return 1;
	if(uInfo[playerid][uAdmin] < 4) return SendPermissionMessage(playerid);

	if (sscanf(params, "s[32]I(-1)I(-1)", model, color1, color2))
	    return SendUsageMessage(playerid, "/veh [model id/nome] <cor 1> <cor 2>");

	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendErrorMessage(playerid, "Modelo inválido.");

	static
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:a,
		vehicleid;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	vehicleid = CreateVehicle(model[0], x, y + 2, z, a, color1, color2, 0);

	if (GetPlayerInterior(playerid) != 0)
	    LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

	if (GetPlayerVirtualWorld(playerid) != 0)
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

	if (IsABoat(vehicleid) || IsAPlane(vehicleid) || IsAHelicopter(vehicleid))
	    PutPlayerInVehicle(playerid, vehicleid, 0);

	ResetVehicle(vehicleid);

	CoreVehicles[vehicleid][vehTemporary] = true;

    format(textdc, sizeof(textdc), "AdmCmd: %s %s criou um %s (%d, %d).", AdminRankName(playerid), pNome(playerid), ReturnVehicleModelName(model[0]), color1, color2);
	admin_chat(VERMELHO , textdc, 1);

    format(textdc, sizeof textdc, "`AdmCmd:` [%s] O %s **%s** *(%s)* criou um %s (%d, %d).", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], ReturnVehicleModelName(model[0]), color1, color2);
    DCC_SendChannelMessage(DC_AdminCMD, textdc);

	return 1;
}

CMD:luzes(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if (!IsEngineVehicle(vehicleid))
		return SendErrorMessage(playerid, "Você não está em um veículo.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você não pode fazer isso se não é o motorista do veículo.");

	switch (GetLightStatus(vehicleid))
	{
	    case false:
	    {
	        SetLightStatus(vehicleid, true);
            GameTextForPlayer(playerid,"~w~Luzes ~g~ligadas~w~!",3000,4);
		}
		case true:
		{
		    SetLightStatus(vehicleid, false);
            GameTextForPlayer(playerid,"~w~Luzes ~r~desligadas~w~!",3000,4);
		}
	}
	return 1;
}

CMD:capo(playerid, params[])
{
	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && IsPlayerNearHood(playerid, i))
	{
	    if (!IsDoorVehicle(i))
	        return SendErrorMessage(playerid, "Esse veículo não possui um capô.");

	    if (!GetHoodStatus(i))
		{
	        SetHoodStatus(i, true);

	        GameTextForPlayer(playerid,"~w~Capo ~g~aberto~w~!",3000,4);
		}
		else
		{
			SetHoodStatus(i, false);

	        GameTextForPlayer(playerid,"~w~Capo ~r~fechado~w~!",3000,4);
		}
	    return 1;
	}
	SendErrorMessage(playerid, "Você não está perto de nenhum veículo.");
	return 1;
}

CMD:janela(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
    new string[128];
	if (!IsWindowedVehicle(vehicleid))
		return SendErrorMessage(playerid, "Você não está em um carro com janelas.");

	switch (CoreVehicles[vehicleid][vehWindowsDown])
	{
	    case false:
	    {
	        CoreVehicles[vehicleid][vehWindowsDown] = true;
            format(string, sizeof(string),"> %s abre as janelas do veículo.", pNome(playerid));
		    SendClientMessage(playerid, COLOR_PURPLE, string);
		    SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 35.0, 10000);
        }
		case true:
		{
		    CoreVehicles[vehicleid][vehWindowsDown] = false;
		    format(string, sizeof(string),"> %s fecha as janelas do veículo.", pNome(playerid));
		    SendClientMessage(playerid, COLOR_PURPLE, string);
		    SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 35.0, 10000);
		}
	}
	return 1;
}

stock TotalledCheck()
{
	static
	    Float:fHealth;

	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && GetVehicleHealth(i, fHealth) && fHealth < 300.0) {
	    SetVehicleHealth(i, 300.0);
	    SetEngineStatus(i, false);
	}
	return 1;
}

stock GetEngineStatus(vehicleid)
{
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
		return 0;

	return 1;
}

stock GetHoodStatus(vehicleid)
{
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
		return 0;

	return 1;
}

stock GetTrunkStatus(vehicleid)
{
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
		return 0;

	return 1;
}

stock GetLightStatus(vehicleid)
{
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
		return 0;

	return 1;
}

stock SetEngineStatus(vehicleid, status)
{
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

stock SetLightStatus(vehicleid, status)
{
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

stock SetTrunkStatus(vehicleid, status)
{
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

stock SetHoodStatus(vehicleid, status)
{
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

stock IsDoorVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return 1;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return 1;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return 1;
	}
	return 0;
}

stock IsSpeedoVehicle(vehicleid)
{
	if (GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 481 || !IsEngineVehicle(vehicleid)) {
	    return 0;
	}
	return 1;
}

stock IsEngineVehicle(vehicleid)
{
	static const g_aEngineStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
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

public OnVehicleSpawn(vehicleid)
{
	vehiclecallsign[vehicleid] = 0;
    if (CoreVehicles[vehicleid][vehTemporary])
	{
	    CoreVehicles[vehicleid][vehTemporary] = false;
	    DestroyVehicle(vehicleid);
	}
    /*for (new i = 0; i != MAX_CRATES; i ++) if (CrateData[i][crateExists] && CrateData[i][crateVehicle] == vehicleid) {
	    Crate_Delete(i);
	}*/
	if (IsValidObject(CoreVehicles[vehicleid][vehCrate]) && GetVehicleModel(vehicleid) == 530)
	    DestroyObject(CoreVehicles[vehicleid][vehCrate]);

	ResetVehicle(vehicleid);
	return 1;
}

stock veh_OnVehicleDeath(vehicleid)
{
	if (CoreVehicles[vehicleid][vehTemporary])
	{
	    CoreVehicles[vehicleid][vehTemporary] = false;
	    DestroyVehicle(vehicleid);
	}
	for (new i = 0; i != MAX_CRATES; i ++) if (CrateData[i][crateExists] && CrateData[i][crateVehicle] == vehicleid) {
	    Crate_Delete(i);
	}
	return 1;
}

stock RespawnVehicle(vehicleid)
{
	new id = Car_GetID(vehicleid);

	if (id != -1)
	    Car_Spawn(id);

	else SetVehicleToRespawn(vehicleid);

	ResetVehicle(vehicleid);
	return 1;
}

stock SendVehicleMessage(vehicleid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
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

		foreach (new i : Player) if (GetPlayerVehicleID(i) == vehicleid) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (GetPlayerVehicleID(i) == vehicleid) {
 		SendClientMessage(i, color, string);
	}
	return 1;
}

stock IsWindowedVehicle(vehicleid)
{
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
        return 0;

    return (g_aWindowStatus[modelid - 400]);
}

ReturnVehicleHealth(vehicleid)
{
	if (!IsValidVehicle(vehicleid))
	    return 0;

	static
	    Float:amount;

	GetVehicleHealth(vehicleid, amount);
	return floatround(amount, floatround_round);
}

stock IsPlayerNearBoot(playerid, vehicleid)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleBoot(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ);
}

stock IsPlayerNearHood(playerid, vehicleid)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleHood(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.0, fX, fY, fZ);
}

stock GetVehicleMaxSeats(vehicleid)
{
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
	new
	    model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return 0;
}

stock GetNearestVehicle(playerid)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ))
	{
	    if (IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ)) return i;
	}
	return INVALID_VEHICLE_ID;
}

stock GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z)
{
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

	return 1;
}

ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

stock ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}
stock IsVehicleSeatUsed(vehicleid, seat)
{
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return 1;
	}
	return 0;
}

stock RemoveFromVehicle(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		static
		    Float:fX,
	    	Float:fY,
	    	Float:fZ;

		GetPlayerPos(playerid, fX, fY, fZ);
		SetPlayerPos(playerid, fX, fY, fZ + 1.5);
	}
	return 1;
}

stock GetAvailableSeat(vehicleid, start = 1)
{
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}

stock GetVehicleFromBehind(vehicleid)
{
	static
	    Float:fCoords[7];

	GetVehiclePos(vehicleid, fCoords[0], fCoords[1], fCoords[2]);
	GetVehicleZAngle(vehicleid, fCoords[3]);

	for (new i = 1; i != MAX_VEHICLES; i ++) if (i != vehicleid && GetVehiclePos(i, fCoords[4], fCoords[5], fCoords[6]))
	{
		if (floatabs(fCoords[0] - fCoords[4]) < 6 && floatabs(fCoords[1] - fCoords[5]) < 6 && floatabs(fCoords[2] - fCoords[6]) < 6)
			return i;
	}
	return INVALID_VEHICLE_ID;
}
/*
stock Car_GetID(vehicleid)
{
	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carVehicle] == vehicleid) {
	    return i;
	}
	return -1;
}

stock Car_Spawn(carid)
{
	if (carid != -1 && CarData[carid][carExists])
	{
		if (IsValidVehicle(CarData[carid][carVehicle]))
		    DestroyVehicle(CarData[carid][carVehicle]);

		if (CarData[carid][carColor1] == -1)
		    CarData[carid][carColor1] = random(127);

		if (CarData[carid][carColor2] == -1)
		    CarData[carid][carColor2] = random(127);

        CarData[carid][carVehicle] = CreateVehicle(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000));

        if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
        {
            if (CarData[carid][carPaintjob] != -1)
            {
                ChangeVehiclePaintjob(CarData[carid][carVehicle], CarData[carid][carPaintjob]);
			}
			if (CarData[carid][carLocked])
			{
			    new
					engine, lights, alarm, doors, bonnet, boot, objective;

				GetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
			}
			for (new i = 0; i < 14; i ++)
			{
			    if (CarData[carid][carMods][i]) AddVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);
			}
   			ResetVehicle(CarData[carid][carVehicle]);
			return 1;
		}
	}
	return 0;
}*/

GetVehicleDriver(vehicleid) {
	foreach (new i : Player) {
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return i;
	}
	return INVALID_PLAYER_ID;
}


GetVehicleModelByName(const name[])
{
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return 0;
}

stock IsABoat(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return 1;
	}
	return 0;
}

stock IsABike(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 448, 461..463, 468, 521..523, 581, 586, 481, 509, 510: return 1;
	}
	return 0;
}

stock IsAPlane(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return 1;
	}
	return 0;
}

stock IsAHelicopter(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return 1;
	}
	return 0;
}

stock Float:GetPlayerSpeed(playerid)
{
	static Float:velocity[3];

	if (IsPlayerInAnyVehicle(playerid))
	    GetVehicleVelocity(GetPlayerVehicleID(playerid), velocity[0], velocity[1], velocity[2]);
	else
	    GetPlayerVelocity(GetPlayerVehicleID(playerid), velocity[0], velocity[1], velocity[2]);

	return floatsqroot((velocity[0] * velocity[0]) + (velocity[1] * velocity[1]) + (velocity[2] * velocity[2])) * 100.0;
}

stock ResetVehicle(vehicleid)
{
	if (1 <= vehicleid <= MAX_VEHICLES)
	{
	    if (CoreVehicles[vehicleid][vehSirenOn] && IsValidDynamicObject(CoreVehicles[vehicleid][vehSirenObject]))
	        DestroyDynamicObject(CoreVehicles[vehicleid][vehSirenObject]);

	   // CoreVehicles[vehicleid][vehFuel] = 100;
		CoreVehicles[vehicleid][vehWindowsDown] = false;
		CoreVehicles[vehicleid][vehTemporary] = 0;
  		//CoreVehicles[vehicleid][vehLoads] = 0;
		//CoreVehicles[vehicleid][vehLoadType] = 0;
		CoreVehicles[vehicleid][vehCrate] = INVALID_OBJECT_ID;
		//CoreVehicles[vehicleid][vehTrash] = 0;
		//CoreVehicles[vehicleid][vehRepairing] = 0;
		CoreVehicles[vehicleid][vehSirenOn] = 0;
		//CoreVehicles[vehicleid][vehRadio] = 0;
	}
	return 1;
}