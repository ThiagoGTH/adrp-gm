#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_CARS (500)
#define MAX_IMPOUND_LOTS (20)
#define MAX_CAR_STORAGE (5)
#define MAX_OWNABLE_CARS (5)

/*
Trunk_GetSlot(vehicleid)
{
   switch(CarData[carid][carModel])
   {
		case 400: return 13;
		case 401: return 8;
		case 402: return 7;
		case 403: return 30;
		case 404, 405: return 10;
		case 406: return 30;
		case 407, 408: return 20;
		case 409: return 15;
		case 411: return 7;
		case 410, 412: return 10;
		case 413: return 20;
		case 414: return 25;
		case 415: return 7;
		case 416: return 20;
		case 417: return 30;
		case 418: return 15;
		case 419: return 6;
		case 420, 421: return 10;
		case 422, 423: return 15;
		case 424: return 3;
		case 425: return 30;
		case 426: return 10;
		case 427: return 20;
		case 428: return 20;
		case 429: return 6;
		case 430: return 10;
		case 431: return 30;
		case 432, 433: return 20;
		case 434: return 6;
		case 436: return 7;
		case 437: return 20;
		case 438: return 10;
		case 439: return 6;
		case 440: return 20;
		case 441: return 1;
		case 442: return 15;
		case 444: return 6;
		case 443: return 8;
		case 446, 447: return 10;
		case 448: return 2;
		case 449: return 5;
		case 451: return 6;
		case 452: return 8;
		case 453, 454: return 10;
		case 455: return 20;
		case 456: return 30;
		case 590, 591, 435, 450: return 30;
		case 457: return 2;
		case 458: return 11;
		case 459: return 18;
		case 460: return 3;
		case 461: return 3;
		case 462: return 2;
		case 463: return 3;
		case 464, 465: return 1;
		case 466, 467: return 8;
		case 468: return 2;
		case 469: return 5;
		case 470: return 10;
		case 471: return 3;
		case 472: return 15;
		case 473: return 2;
		case 474, 475: return 6;
		case 476, 477: return 5;
		case 478: return 13;
		case 479: return 11;
		case 480: return 6;
		case 481: return 0;
		case 482: return 18;
		case 483: return 14;
		case 485: return 2;
		case 486: return 2;
		case 487, 488: return 7;
		case 489, 490: return 10;
		case 491: return 6;
		case 492: return 9;
		case 493: return 5;
		case 494: return 7;
		case 495: return 6;
		case 496: return 6;
		case 497: return 7;
		case 498: return 25;
		case 499: return 21;
		case 500: return 5;
		case 501: return 0;
		case 502, 503, 504: return 5;
		case 505: return 10;
		case 506: return 6;
		case 507: return 9;
		case 508: return 15;
		case 509, 510: return 0;
		case 512, 513: return 2;
		case 514, 515: return 15;
		case 517, 518: return 7;
		case 519, 520: return 35;
		case 522: return 3;
		case 524: return 15;
		case 525: return 10;
		case 526, 527: return 8;
		case 528: return 9;
		case 529: return 7;
		case 530, 531: return 1;
		case 523: return 2;
		case 533, 534, 535: return 5;
		case 537, 538: return 5;
		case 539: return 2;
		case 540: return 8;
		case 541: return 5;
		case 542: return 8;
		case 543: return 9;
		case 544: return 25;
		case 545: return 4;
		case 546, 547: return 8;
		case 548: return 20;
		case 549, 550, 551: return 8;
		case 554: return 10;
		case 555: return 7;
		case 556, 557: return 4;
		case 558, 559: return 6;
		case 560: return 8;
		case 561: return 9;
		case 562: return 6;
		case 563: return 20;
		case 564: return 0;
		case 566, 567: return 9;
		case 568: return 1;
		case 571: return 0;
		case 572: return 1;
		case 573: return 20;
		case 574: return 2;
		case 575: return 6;
		case 576: return 8;
		case 577: return 35;
		case 578: return 4;
		case 579: return 10;
		case 580: return 9;
		case 581: return 3;
		case 582: return 15;
		case 583: return 1;
		case 585: return 8;
		case 586: return 3;
		case 587: return 7;
		case 588: return 15;
		case 589: return 7;
		case 592: return 35;
		case 593: return 5;
		case 595: return 15;
		case 596, 597, 598, 599, 601: return 10;
		case 600, 602, 603, 604, 605: return 8;
		case 609: return 25;
		default: return 5;
   }

   return 0;
}*/

enum carData {
	carID,
	carExists,
	carModel,
	carOwner,
	Float:carPos[4],
	carColor1,
	carColor2,
	carPaintjob,
	carLocked,
	carMods[14],
	carImpounded,
	carImpoundPrice,
	carFaction,
	carWeapons[5],
	carAmmo[5],
	carVehicle
};

enum impoundData {
	impoundID,
	impoundExists,
	Float:impoundLot[3],
	Float:impoundRelease[4],
	Text3D:impoundText3D,
	impoundPickup
};

new CarData[MAX_DYNAMIC_CARS][carData];
new ImpoundData[MAX_IMPOUND_LOTS][impoundData];
new ListedVehicles[MAX_PLAYERS][MAX_OWNABLE_CARS];

stock SetVehicleColor(vehicleid, color1, color2)
{
    new id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carColor1] = color1;
	    CarData[id][carColor2] = color2;
	    Car_Save(id);
	}
	return ChangeVehicleColor(vehicleid, color1, color2);
}

stock SetVehiclePaintjob(vehicleid, paintjobid)
{
    new id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carPaintjob] = paintjobid;
	    Car_Save(id);
	}
	return ChangeVehiclePaintjob(vehicleid, paintjobid);
}

stock RemoveComponent(vehicleid, componentid)
{
	if (!IsValidVehicle(vehicleid) || (componentid < 1000 || componentid > 1193))
	    return 0;

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carMods][GetVehicleComponentType(componentid)] = 0;
	    Car_Save(id);
	}
	return RemoveVehicleComponent(vehicleid, componentid);
}

stock AddComponent(vehicleid, componentid)
{
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


stock IsVehicleImpounded(vehicleid)
{
    new id = Car_GetID(vehicleid);

	if (id != -1 && CarData[id][carImpounded] != -1 && CarData[id][carImpoundPrice] > 0)
	    return 1;

	return 0;
}

stock Impound_Delete(impoundid)
{
    if (impoundid != -1 && ImpoundData[impoundid][impoundExists])
	{
		format(query, sizeof(query), "DELETE FROM `impoundlots` WHERE `impoundID` = '%d'", ImpoundData[impoundid][impoundID]);
		mysql_tquery(DBConn, query);

        if (IsValidDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]))
		    DestroyDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]);

	    if (IsValidDynamicPickup(ImpoundData[impoundid][impoundPickup]))
		    DestroyDynamicPickup(ImpoundData[impoundid][impoundPickup]);

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carImpounded] == ImpoundData[impoundid][impoundID]) {
		    CarData[i][carImpounded] = 0;
		    CarData[i][carImpoundPrice] = 0;
		    Car_Save(i);
		}
        ImpoundData[impoundid][impoundExists] = false;
        ImpoundData[impoundid][impoundID] = 0;
	}
	return 1;
}

stock GetImpoundByID(sqlid)
{
	for (new i = 0; i < MAX_IMPOUND_LOTS; i ++) if (ImpoundData[i][impoundExists] && ImpoundData[i][impoundID] == sqlid) {
	    return i;
	}
	return -1;
}

stock Impound_Nearest(playerid)
{
	for (new i = 0; i < MAX_IMPOUND_LOTS; i ++) if (ImpoundData[i][impoundExists] && IsPlayerInRangeOfPoint(playerid, 20.0, ImpoundData[i][impoundLot][0], ImpoundData[i][impoundLot][1], ImpoundData[i][impoundLot][2])) {
	    return i;
	}
	return -1;
}

stock Impound_Create(Float:x, Float:y, Float:z)
{
	for (new i = 0; i != MAX_IMPOUND_LOTS; i ++) if (!ImpoundData[i][impoundExists])
	{
	    ImpoundData[i][impoundExists] = true;
	    ImpoundData[i][impoundLot][0] = x;
	    ImpoundData[i][impoundLot][1] = y;
	    ImpoundData[i][impoundLot][2] = z;
	    ImpoundData[i][impoundRelease][0] = 0.0;
	    ImpoundData[i][impoundRelease][1] = 0.0;
	    ImpoundData[i][impoundRelease][2] = 0.0;

		mysql_tquery(DBConn, "INSERT INTO `impoundlots` (`impoundLotX`) VALUES('0.0')", "OnImpoundCreated", "d", i);
		Impound_Refresh(i);

		return i;
	}
	return -1;
}

stock Impound_Refresh(impoundid)
{
	if (impoundid != -1 && ImpoundData[impoundid][impoundExists])
	{
	    new
	        string[64];

		if (IsValidDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]))
		    DestroyDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]);

	    if (IsValidDynamicPickup(ImpoundData[impoundid][impoundPickup]))
		    DestroyDynamicPickup(ImpoundData[impoundid][impoundPickup]);

		format(string, sizeof(string), "[Ponto de Apreens�o %d]\n{FFFFFF}/apreender.", impoundid);
        ImpoundData[impoundid][impoundText3D] = CreateDynamic3DTextLabel(string, COLOR_DARKBLUE, ImpoundData[impoundid][impoundLot][0], ImpoundData[impoundid][impoundLot][1], ImpoundData[impoundid][impoundLot][2], 20.0);
        ImpoundData[impoundid][impoundPickup] = CreateDynamicPickup(1239, 23, ImpoundData[impoundid][impoundLot][0], ImpoundData[impoundid][impoundLot][1], ImpoundData[impoundid][impoundLot][2]);
	}
	return 1;
}

stock Impound_Save(impoundid)
{

	format(query, sizeof(query), "UPDATE `impoundlots` SET `impoundLotX` = '%.4f', `impoundLotY` = '%.4f', `impoundLotZ` = '%.4f', `impoundReleaseX` = '%.4f', `impoundReleaseY` = '%.4f', `impoundReleaseZ` = '%.4f', `impoundReleaseA` = '%.4f' WHERE `impoundID` = '%d'",
        ImpoundData[impoundid][impoundLot][0],
        ImpoundData[impoundid][impoundLot][1],
        ImpoundData[impoundid][impoundLot][2],
        ImpoundData[impoundid][impoundRelease][0],
        ImpoundData[impoundid][impoundRelease][1],
        ImpoundData[impoundid][impoundRelease][2],
        ImpoundData[impoundid][impoundRelease][3],
        ImpoundData[impoundid][impoundID]
	);
	return mysql_tquery(DBConn, query);
}

forward OnImpoundCreated(impoundid);
public OnImpoundCreated(impoundid)
{
	if (impoundid == -1 || !ImpoundData[impoundid][impoundExists])
	    return 0;

	ImpoundData[impoundid][impoundID] = cache_insert_id();
	Impound_Save(impoundid);

	return 1;
}

stock Car_GetRealID(carid)
{
	if (carid == -1 || !CarData[carid][carExists] || CarData[carid][carVehicle] == INVALID_VEHICLE_ID)
	    return INVALID_VEHICLE_ID;

	return CarData[carid][carVehicle];
}

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
}

hook OnGameModeInit()
{
	mysql_tquery(DBConn, "SELECT * FROM `cars`", "Car_Load", "");
	mysql_tquery(DBConn, "SELECT * FROM `impoundlots`", "Impound_Load", "");
	return 1;
}

forward Car_Load();
public Car_Load()
{
	static
	    rows,
		str[128];

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_CARS)
	{
	    CarData[i][carExists] = true;

		cache_get_value_name_int(i, "carID",  CarData[i][carID]);
		cache_get_value_name_int(i, "carModel", CarData[i][carModel]);
		cache_get_value_name_int(i, "carOwner", CarData[i][carOwner]);

		cache_get_value_name_float(i, "carPosX", CarData[i][carPos][0]);
		cache_get_value_name_float(i, "carPosY", CarData[i][carPos][1]);
		cache_get_value_name_float(i, "carPosZ", CarData[i][carPos][2]);
		cache_get_value_name_float(i, "carPosR", CarData[i][carPos][3]);

		cache_get_value_name_int(i, "carColor1", CarData[i][carColor1]);
		cache_get_value_name_int(i, "carColor2", CarData[i][carColor2]);

		cache_get_value_name_int(i, "carPaintjob", CarData[i][carPaintjob]);
		cache_get_value_name_int(i, "carLocked", CarData[i][carLocked]);
		cache_get_value_name_int(i, "carImpounded", CarData[i][carImpounded]);
		cache_get_value_name_int(i, "carImpoundPrice", CarData[i][carImpoundPrice]);

		cache_get_value_name_int(i, "carFaction", CarData[i][carFaction]);

		for (new j = 0; j < 14; j ++)
		{
		    if (j < 5)
		    {
				format(str, sizeof(str), "carWeapon%d", j + 1);
	        	cache_get_value_name_int(i, str, CarData[i][carWeapons][j]);

				format(str, sizeof(str), "carAmmo%d", j + 1);
	        	cache_get_value_name_int(i, str, CarData[i][carAmmo][j]);
	        }
			format(str, sizeof(str), "carMod%d", j + 1);
	        cache_get_value_name_int(i, str, CarData[i][carMods][j]);
	    }
	    Car_Spawn(i);
	}
	printf("VEHICLE SYSTEM: %d carros foram carregados.", rows);
	return 1;
}

forward Impound_Load();
public Impound_Load()
{
	static
	    rows;
	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_IMPOUND_LOTS)
	{
	    ImpoundData[i][impoundExists] = true;

		cache_get_value_name_int(i, "impoundID",  ImpoundData[i][impoundID]);

		cache_get_value_name_float(i, "impoundLotX",  ImpoundData[i][impoundLot][0]);
		cache_get_value_name_float(i, "impoundLotY",  ImpoundData[i][impoundLot][1]);
		cache_get_value_name_float(i, "impoundLotZ",  ImpoundData[i][impoundLot][2]);

		cache_get_value_name_float(i, "impoundReleaseX",  ImpoundData[i][impoundRelease][0]);
		cache_get_value_name_float(i, "impoundReleaseY",  ImpoundData[i][impoundRelease][1]);
		cache_get_value_name_float(i, "impoundReleaseZ",  ImpoundData[i][impoundRelease][2]);
		cache_get_value_name_float(i, "impoundReleaseA",  ImpoundData[i][impoundRelease][3]);

		Impound_Refresh(i);
	}
	printf("VEHICLE SYSTEM: %d pontos de apreens�o foram carregados.", rows);
	return 1;
}

Car_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (CarData[i][carExists] && CarData[i][carOwner] == pInfo[playerid][pID])
   		{
   		    count++;
		}
	}
	return count;
}

Car_IsOwner(playerid, carid)
{
	if (!pInfo[playerid][pLogged] || pInfo[playerid][pID] == -1)
	    return 0;

    if ((CarData[carid][carExists] && CarData[carid][carOwner] != 0) && CarData[carid][carOwner] == pInfo[playerid][pID])
		return 1;

	return 0;
}

Car_WeaponStorage(playerid, carid)
{
    if (!CarData[carid][carExists] || CarData[carid][carLocked])
	    return 0;

    static
	    string[164];

	string[0] = 0;
	
	for (new i = 0; i < 5; i ++)
	{
	    if (22 <= CarData[carid][carWeapons][i] <= 38)
	        format(string, sizeof(string), "%s%s - Muni��o: %d\n", string, ReturnWeaponName(CarData[carid][carWeapons][i]), CarData[carid][carAmmo][i]);

		else
		    format(string, sizeof(string), "%s%s\n", string, (CarData[carid][carWeapons][i]) ? (ReturnWeaponName(CarData[carid][carWeapons][i])) : ("Slot vazio"));
	}
	Dialog_Show(playerid, Trunk, DIALOG_STYLE_LIST, "Porta-malas", string, "Selecionar", "Cancelar");
	return 1;
}

Car_Create(ownerid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, type = 0)
{
    for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (!CarData[i][carExists])
   		{
   		    if (color1 == -1)
   		        color1 = random(127);

			if (color2 == -1)
			    color2 = random(127);

   		    CarData[i][carExists] = true;
            CarData[i][carModel] = modelid;
            CarData[i][carOwner] = ownerid;

            CarData[i][carPos][0] = x;
            CarData[i][carPos][1] = y;
            CarData[i][carPos][2] = z;
            CarData[i][carPos][3] = angle;

            CarData[i][carColor1] = color1;
            CarData[i][carColor2] = color2;
            CarData[i][carPaintjob] = -1;
            CarData[i][carLocked] = false;
            CarData[i][carImpounded] = -1;
            CarData[i][carImpoundPrice] = 0;
            CarData[i][carFaction] = type;

            for (new j = 0; j < 14; j ++)
			{
                if (j < 5)
				{
                    CarData[i][carWeapons][j] = 0;
                    CarData[i][carAmmo][j] = 0;
                }
                CarData[i][carMods][j] = 0;
            }
            CarData[i][carVehicle] = CreateVehicle(modelid, x, y, z, angle, color1, color2, -1);

            if (CarData[i][carVehicle] != INVALID_VEHICLE_ID) {
                ResetVehicle(CarData[i][carVehicle]);
            }
            mysql_tquery(DBConn, "INSERT INTO `cars` (`carModel`) VALUES(0)", "OnCarCreated", "d", i);
            return i;
		}
	}
	return -1;
}

Car_Delete(carid)
{
    if (carid != -1 && CarData[carid][carExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `cars` WHERE `carID` = '%d'", CarData[carid][carID]);
		mysql_tquery(DBConn, string);

		if (IsValidVehicle(CarData[carid][carVehicle]))
			DestroyVehicle(CarData[carid][carVehicle]);

		Car_RemoveAllItems(carid);

        CarData[carid][carExists] = false;
	    CarData[carid][carID] = 0;
	    CarData[carid][carOwner] = 0;
	    CarData[carid][carVehicle] = 0;
	}
	return 1;
}

Car_Save(carid)
{
	if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
	{
	    for (new i = 0; i < 14; i ++) {
			CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], i);
	    }
	}
	format(query, sizeof(query), "UPDATE `cars` SET `carModel` = '%d', `carOwner` = '%d', `carPosX` = '%.4f', `carPosY` = '%.4f', `carPosZ` = '%.4f', `carPosR` = '%.4f', `carColor1` = '%d', `carColor2` = '%d', `carPaintjob` = '%d', `carLocked` = '%d'",
        CarData[carid][carModel],
        CarData[carid][carOwner],
        CarData[carid][carPos][0],
        CarData[carid][carPos][1],
        CarData[carid][carPos][2],
        CarData[carid][carPos][3],
        CarData[carid][carColor1],
        CarData[carid][carColor2],
        CarData[carid][carPaintjob],
        CarData[carid][carLocked]
	);
	format(query, sizeof(query), "%s, `carMod1` = '%d', `carMod2` = '%d', `carMod3` = '%d', `carMod4` = '%d', `carMod5` = '%d', `carMod6` = '%d', `carMod7` = '%d', `carMod8` = '%d', `carMod9` = '%d', `carMod10` = '%d', `carMod11` = '%d', `carMod12` = '%d', `carMod13` = '%d', `carMod14` = '%d'",
		query,
		CarData[carid][carMods][0],
		CarData[carid][carMods][1],
		CarData[carid][carMods][2],
		CarData[carid][carMods][3],
		CarData[carid][carMods][4],
		CarData[carid][carMods][5],
		CarData[carid][carMods][6],
		CarData[carid][carMods][7],
		CarData[carid][carMods][8],
		CarData[carid][carMods][9],
		CarData[carid][carMods][10],
		CarData[carid][carMods][11],
		CarData[carid][carMods][12],
		CarData[carid][carMods][13]
	);
	format(query, sizeof(query), "%s, `carImpounded` = '%d', `carImpoundPrice` = '%d', `carFaction` = '%d', `carWeapon1` = '%d', `carWeapon2` = '%d', `carWeapon3` = '%d', `carWeapon4` = '%d', `carWeapon5` = '%d', `carAmmo1` = '%d', `carAmmo2` = '%d', `carAmmo3` = '%d', `carAmmo4` = '%d', `carAmmo5` = '%d' WHERE `carID` = '%d'",
		query,
		CarData[carid][carImpounded],
		CarData[carid][carImpoundPrice],
		CarData[carid][carFaction],
		CarData[carid][carWeapons][0],
		CarData[carid][carWeapons][1],
		CarData[carid][carWeapons][2],
		CarData[carid][carWeapons][3],
		CarData[carid][carWeapons][4],
		CarData[carid][carAmmo][0],
		CarData[carid][carAmmo][1],
		CarData[carid][carAmmo][2],
		CarData[carid][carAmmo][3],
		CarData[carid][carAmmo][4],
		CarData[carid][carID]
	);
	return mysql_tquery(DBConn, query);
}

Car_Nearest(playerid)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists]) {
		GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 3.0, fX, fY, fZ)) {
		    return i;
		}
	}
	return -1;
}

Car_RemoveAllItems(carid)
{
	for (new i = 0; i < 5; i ++) 
	{
	    CarData[carid][carWeapons][i] = 0;
	    CarData[carid][carAmmo][i] = 0;
	}
	return 1;
}

forward OnCarCreated(carid);
public OnCarCreated(carid)
{
	if (carid == -1 || !CarData[carid][carExists])
	    return 0;

	CarData[carid][carID] = cache_insert_id();
	Car_Save(carid);
	return 1;
}

Car_Inside(playerid)
{
	new carid;

	if (IsPlayerInAnyVehicle(playerid) && (carid = Car_GetID(GetPlayerVehicleID(playerid))) != -1)
	    return carid;

	return -1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	new
		id = Car_GetID(vehicleid),
		slot = GetVehicleComponentType(componentid);

	if (id != -1)
	{
	    CarData[id][carMods][slot] = componentid;
	    Car_Save(id);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (IsPlayerNPC(playerid))
	    return 1;

	if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY) {
	    ClearAnimations(playerid);

	    return 0;
	}
	new id = Car_GetID(vehicleid);

	if (!ispassenger && id != -1 && CarData[id][carFaction] > 0 && GetFactionType(playerid) != CarData[id][carFaction]) {
	    ClearAnimations(playerid);

	    return SendErrorMessage(playerid, "Voc� n�o possui as chaves desse ve�culo.");
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate)
{
	if (IsPlayerNPC(playerid))
	    return 1;

	new vehicleid = GetPlayerVehicleID(playerid);

	if (newstate == PLAYER_STATE_DRIVER)
	{
	    new id = Car_GetID(vehicleid);

		if (id != -1 && CarData[id][carFaction] > 0 && GetFactionType(playerid) != CarData[id][carFaction]) {
		    RemovePlayerFromVehicle(playerid);

	    	return SendErrorMessage(playerid, "Voc� n�o possui as chaves desse ve�culo.");
		}
        return 1;
    }
    return 1;
}

Dialog:ReleaseCar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			carid = ListedVehicles[playerid][listitem],
			id = GetImpoundByID(CarData[carid][carImpounded]);

	    if (carid != -1 && id != -1 && CarData[carid][carExists] && CarData[carid][carImpounded] != -1)
	    {
	        if (GetMoney(playerid) < CarData[carid][carImpoundPrice])
	            return SendErrorMessage(playerid, "Voc� n�o pode pagar pela soltura deste ve�culo.");

            GiveMoney(playerid, -CarData[carid][carImpoundPrice]);

            CarData[carid][carPos][0] = ImpoundData[id][impoundRelease][0];
            CarData[carid][carPos][1] = ImpoundData[id][impoundRelease][1];
            CarData[carid][carPos][2] = ImpoundData[id][impoundRelease][2];
            CarData[carid][carPos][3] = ImpoundData[id][impoundRelease][3];

			SetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
			SetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

			va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� liberou o(a) seu(sua) %s por $%s.", ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(CarData[carid][carImpoundPrice]));

            CarData[carid][carImpounded] = -1;
            CarData[carid][carImpoundPrice] = 0;

            Car_Save(carid);
	    }
	}
	return 1;
}

Dialog:Trunk(playerid, response, listitem, inputtext[])
{
    new carid = Car_Nearest(playerid);

	if (CarData[carid][carImpounded] != -1)
    	return SendErrorMessage(playerid, "Este ve�culo est� apreendido e voc� n�o pode us�-lo.");

	if (carid != -1 && !CarData[carid][carLocked])
 	{
		if (response)
		{
			if (!CarData[carid][carWeapons][listitem])
			{
			    if (!GetWeapon(playerid))
			        return SendErrorMessage(playerid, "Voc� n�o est� segurando nenhuma arma.");

       			if (GetWeapon(playerid) == 23 && pInfo[playerid][pTazer])
	    			return SendErrorMessage(playerid, "Voc� n�o pode guardar um taser no porta-malas.");

                if (GetWeapon(playerid) == 25 && pInfo[playerid][pBeanBag])
	    			return SendErrorMessage(playerid, "Voc� n�o pode guardar uma beanbag shotgun no porta-malas.");

				if (!Car_IsOwner(playerid, carid) && GetFactionType(playerid) == FACTION_POLICE)
        			return SendErrorMessage(playerid, "Voc� n�o pode guardar armas sendo de uma fac��o policial.");

	   			CarData[carid][carWeapons][listitem] = GetWeapon(playerid);
	            CarData[carid][carAmmo][listitem] = GetPlayerAmmo(playerid);

	            ResetWeapon(playerid, CarData[carid][carWeapons][listitem]);
	            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s guardou uma %s no porta-malas do ve�culo.", pNome(playerid), ReturnWeaponName(CarData[carid][carWeapons][listitem]));
                format(textdc, sizeof textdc, "`VEHLOG:` [%s] **%s** *(%s)* guardou uma %s no porta-malas do veiculo ID: %d.", ReturnDate(), GetPlayerNameEx(playerid), PlayerIP(playerid), ReturnWeaponName(CarData[carid][carWeapons][listitem]), carid);
                discord(DC_LogVeh, textdc);
	            Car_Save(carid);
				Car_WeaponStorage(playerid, carid);
			}
			else
			{
			    GiveWeaponToPlayer(playerid, CarData[carid][carWeapons][listitem], CarData[carid][carAmmo][listitem]);
	            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pegou uma %s do porta-malas do ve�culo.", pNome(playerid), ReturnWeaponName(CarData[carid][carWeapons][listitem]));
                format(textdc, sizeof textdc, "`VEHLOG:` [%s] **%s** *(%s)* pegou uma %s no porta-malas do veiculo ID: %d.", ReturnDate(), GetPlayerNameEx(playerid), PlayerIP(playerid), ReturnWeaponName(CarData[carid][carWeapons][listitem]), carid);
                discord(DC_LogVeh, textdc);
	            CarData[carid][carWeapons][listitem] = 0;
	            CarData[carid][carAmmo][listitem] = 0;

	            Car_Save(carid);
	            Car_WeaponStorage(playerid, carid);
			}
	    }
	}
	return 1;
}

CMD:abandonar(playerid, params[])
{
	static
	    id = -1;

	if ((id = Car_Inside(playerid)) != -1 && Car_IsOwner(playerid, id))
	{
	    if (isnull(params) || (!isnull(params) && strcmp(params, "confirmo", true) != 0))
	    {
	        SendUsageMessage(playerid, "/abandonar [confirmo]");
	        SendClientMessage(playerid, COLOR_LIGHTRED, "AVISO: {FFFFFF} Voc� est� prestes a abandonar o seu ve�culo SEM o direito � refundo.");
		}
		else if (CarData[id][carImpounded] != -1)
    		return SendErrorMessage(playerid, "Este ve�culo est� apreendido e voc� n�o pode us�-lo.");

		else if (!strcmp(params, "confirmo", true))
		{
			new
			    model = CarData[id][carModel];

			Car_Delete(id);

			va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� abandonou o(a) seu(sua) %s.", ReturnVehicleModelName(model));
            format(textdc, sizeof textdc, "`VEHLOG:` [%s] **%s** *(%s)* abandonou seu %s.", ReturnDate(), GetPlayerNameEx(playerid), PlayerIP(playerid), ReturnVehicleModelName(model));
            discord(DC_LogVeh, textdc);
        }
	}
	else SendErrorMessage(playerid, "Voc� n�o est� perto de nada que possa abandonar.");
	return 1;
}

CMD:vender(playerid, params[])
{
	static
	    targetid,
	    type[24],
	    string[128];

	if (sscanf(params, "us[24]S()[128]", targetid, type, string))
	{
	    SendUsageMessage(playerid, "/vender [playerid/nome] [syntax]");
	    SendClientMessage(playerid, -1, "SYNTAXES: veiculo");
	    return 1;
	}
	if (targetid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, targetid, 5.0))
	{
		SendErrorMessage(playerid, "Este jogador est� desconectado ou n�o est� perto de voc�.");
		return 1;
	}
	if (targetid == playerid)
	{
		SendErrorMessage(playerid, "Voc� n�o pode vender para si mesmo.");
		return 1;
	}
	if (!strcmp(type, "veiculo", true))
	{
		static
		    price,
			carid = -1;

		if (sscanf(string, "d", price))
			return SendUsageMessage(playerid, "/vender [playerid/nome] [veiculo] [valor]");

		if (price < 1)
		    return SendErrorMessage(playerid, "O valor n�o pode ser menor que $1.");

		if ((carid = Car_Inside(playerid)) != -1 && Car_IsOwner(playerid, carid)) {
			pInfo[targetid][pCarSeller] = playerid;
			pInfo[targetid][pCarOffered] = carid;
			pInfo[targetid][pCarValue] = price;

		    va_SendClientMessage(playerid, COLOR_GREEN, "Voc� ofereceu � %s para comprar o seu ve�culo %s por %s.", pNome(targetid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
            va_SendClientMessage(playerid, COLOR_GREEN, "%s ofereceu o ve�culo %s por %s (type \"/comprar veiculo\" para aceitar).", pNome(playerid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
		}
		else SendErrorMessage(playerid, "Voc� n�o est� perto de nenhum de seus ve�culos.");
	}
	return 1;
}

CMD:comprar(playerid, params[])
{
	if (isnull(params))
 	{
	 	SendUsageMessage(playerid, "/comprar [syntax]");
		SendClientMessage(playerid, -1, "SYNTAXES: veiculo");
		return 1;
	}
    if (!strcmp(params, "veiculo", true) && pInfo[playerid][pCarSeller] != INVALID_PLAYER_ID)
	{
	    new
	        sellerid = pInfo[playerid][pCarSeller],
	        carid = pInfo[playerid][pCarOffered],
	        price = pInfo[playerid][pCarValue];

		if (!IsPlayerNearPlayer(playerid, sellerid, 6.0))
		    return SendErrorMessage(playerid, "Voc� n�o est� perto do jogador.");

		if (GetMoney(playerid) < price)
		    return SendErrorMessage(playerid, "Voc� n�o possui dinheiro o suficiente para comprar este ve�culo.");

		if (Car_Nearest(playerid) != carid)
		    return SendErrorMessage(playerid, "Voc� precisa estar perto do ve�culo para compra-lo.");

		if (!Car_IsOwner(sellerid, carid))
		    return SendErrorMessage(playerid, "A oferta deste ve�culo n�o � mais v�lida.");

		va_SendClientMessage(playerid, COLOR_GREEN, "Voc� comprou com sucesso de %s o ve�culo %s por %s.", pNome(sellerid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
		va_SendClientMessage(sellerid, COLOR_GREEN, "%s comprou com sucesso o(a) seu(sua) %s por %s.", pNome(playerid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
        format(textdc, sizeof textdc, "`VEHLOG:` [%s] **%s** *(%s)* vendeu seu %s para **%s** *(%s)* por $%s.", ReturnDate(), GetPlayerNameEx(sellerid), PlayerIP(sellerid), ReturnVehicleModelName(CarData[carid][carModel]), pNome(playerid), PlayerIP(sellerid), FormatNumber(price));
        discord(DC_LogVeh, textdc);

		CarData[carid][carOwner] = GetPlayerSQLID(playerid);
		Car_Save(carid);

		GiveMoney(playerid, -price);
		GiveMoney(sellerid, price);

		pInfo[playerid][pCarSeller] = INVALID_PLAYER_ID;
		pInfo[playerid][pCarOffered] = -1;
		pInfo[playerid][pCarValue] = 0;
	}
    return 1;
}


CMD:estacionar(playerid, params[])
{
	new
	    carid = GetPlayerVehicleID(playerid);

	if (!carid)
	    return SendErrorMessage(playerid, "Voc� precisa estar dentro do ve�culo.");

    if (IsVehicleImpounded(carid))
    	return SendErrorMessage(playerid, "Este ve�culo est� apreendido e voc� n�o pode us�-lo.");

	if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "Voc� precisa ser o motorista!");

	    static
			g_arrSeatData[10] = {INVALID_PLAYER_ID, ...},
			g_arrDamage[4],
			Float:health,
			seatid;

        for (new i = 0; i < 14; i ++) {
			CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], i);
	    }
		GetVehicleDamageStatus(CarData[carid][carVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
		GetVehicleHealth(CarData[carid][carVehicle], health);

		foreach (new i : Player) if (IsPlayerInVehicle(i, CarData[carid][carVehicle])) {
		    seatid = GetPlayerVehicleSeat(i);

		    g_arrSeatData[seatid] = i;
		}
		GetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
		GetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

		Car_Spawn(carid);
		Car_Save(carid);

		va_SendClientMessage(playerid, -1, "SERVER: Voc� estacionou com sucesso o(a) seu(a) %s.", ReturnVehicleName(CarData[carid][carVehicle]));

        UpdateVehicleDamageStatus(CarData[carid][carVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
		SetVehicleHealth(CarData[carid][carVehicle], health);

		for (new i = 0; i < sizeof(g_arrSeatData); i ++) if (g_arrSeatData[i] != INVALID_PLAYER_ID) {
		    PutPlayerInVehicle(g_arrSeatData[i], CarData[carid][carVehicle], i);

		    g_arrSeatData[i] = INVALID_PLAYER_ID;
		}
	}
	else SendErrorMessage(playerid, "Voc� n�o est� em nada que possa ser estacionado.");
	return 1;
}

/*
CMD:unmod(playerid, params[])
{
	new
	    carid = GetPlayerVehicleID(playerid);

	if (!carid)
	    return SendErrorMessage(playerid, "Voc� precisa estar dentro do ve�culo.");

    if (IsVehicleImpounded(carid))
    	return SendErrorMessage(playerid, "Este ve�culo est� apreendido e voc� n�o pode us�-lo.");

	if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "Voc� precisa ser o motorista!");

		for (new i = 0; i < 14; i ++) {
		    RemoveVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);

		    CarData[carid][carMods][i] = 0;
		}
		Car_Save(carid);
		SendServerMessage(playerid, "Voc� removeu as modifica��es do ve�culo.");
	}
	else SendErrorMessage(playerid, "Voc� n�o est� dentro de nada que possa modificar.");
	return 1;
}*/


CMD:motor(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new carid = GetPlayerVehicleID(playerid);

	if (IsVehicleImpounded(vehicleid))
    	return SendErrorMessage(playerid, "Este ve�culo est� apreendido e voc� n�o pode us�-lo.");

	new id = Car_GetID(vehicleid);

	if ((carid = Car_GetID(vehicleid)) != -1 && Car_IsOwner(playerid, carid) || (pInfo[playerid][pFaction] != -1 && CarData[id][carFaction] == GetFactionType(playerid)))
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "Voc� precisa ser o motorista!");

		if (ReturnVehicleHealth(vehicleid) <= 300)
			return SendErrorMessage(playerid, "Esse ve�culo est� com o motor fundido e n�o pode ser iniciado.");

		switch (GetEngineStatus(vehicleid))
		{
			case false:
			{
				SetEngineStatus(vehicleid, true);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s insere a chave na igni��o do ve�culo e liga o motor.", pNome(playerid));
			}
			case true:
			{
				SetEngineStatus(vehicleid, false);
			}
		}
		return 1;
	}
	return 1;
}

CMD:portamalas(playerid, params[])
{
	new
	    id = -1,
		option[32];

	if (sscanf(params,"s[32]", option))
 	{
	 	SendUsageMessage(playerid, "/portamalas [syntax]");
	    SendClientMessage(playerid, -1, "SYNTAXES: abrir, fechar, ver.");
		return 1;
	}

	for (new i = 1; i != MAX_DYNAMIC_CARS; i ++) if ((id = Car_Nearest(playerid)) != -1)
	{
		if (IsVehicleImpounded(CarData[id][carVehicle]))
	        return SendErrorMessage(playerid, "Este ve�culo est� apreendido e voc� n�o pode us�-lo.");

	    if (IsPlayerInAnyVehicle(playerid))
	        return SendErrorMessage(playerid, "Voc� precisa sair do ve�culo primeiro.");

		if (!IsDoorVehicle(CarData[id][carVehicle]))
		    return SendErrorMessage(playerid, "Este ve�culo n�o possui um porta-malas.");

		if (CarData[id][carLocked])
		    return SendErrorMessage(playerid, "Este ve�culo est� trancado.");

		if(strcmp(option, "abrir", true) == 0)
		{
			if (!GetTrunkStatus(i))
			{
				SetTrunkStatus(i, true);

				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s abriu o porta-malas do ve�culo.", pNome(playerid));
				GameTextForPlayer(playerid,"~w~Porta-malas ~g~aberto~w~!",3000,4);
				return 1;
			}
			else 
			{
				SendErrorMessage(playerid, "O porta-malas deste ve�culo j� est� aberto.");
				return 1;
			}
		}

		if(strcmp(option, "fechar", true) == 0)
		{
			if (GetTrunkStatus(i))
			{
				SetTrunkStatus(i, false);

				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s fechou o porta-malas do ve�culo.", pNome(playerid));
				GameTextForPlayer(playerid,"~w~Porta-malas ~r~fechado~w~!",3000,4);
				return 1;
			}
			else 
			{
				SendErrorMessage(playerid, "O porta-malas deste ve�culo j� est� fechado.");
				return 1;
			}
		}
		if(strcmp(option, "ver", true) == 0)
		{
			if (!GetTrunkStatus(i))
				return SendErrorMessage(playerid, "O porta-malas deste ve�culo est� fechado, abra-o primeiro.");

			Car_WeaponStorage(playerid, id);
			return 1;
		}
	}
	else 
	{
		SendErrorMessage(playerid, "O porta-malas deste ve�culo j� est� fechado.");
		return 1;
	}
	return 1;
}

CMD:soltarcarro(playerid, params[])
{
	/*if (!IsPlayerInRangeOfPoint(playerid, 3.0, 361.1653, 175.8127, 1008.3828))
	    return SendErrorMessage(playerid, "Voc� n�o est� na prefeitura.");*/

	new
	    string[32 * MAX_OWNABLE_CARS],
		count;

	for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (count < MAX_OWNABLE_CARS && CarData[i][carExists] && Car_IsOwner(playerid, i) && CarData[i][carImpounded] != -1)
	{
		format(string, sizeof(string), "%s%d: %s (%s)\n", string, count + 1, ReturnVehicleName(CarData[i][carVehicle]), FormatNumber(CarData[i][carImpoundPrice]));
        ListedVehicles[playerid][count++] = i;
	}
	if (!count)
	    SendErrorMessage(playerid, "Voc� n�o possui nenhum ve�culo apreendido.");

	else Dialog_Show(playerid, ReleaseCar, DIALOG_STYLE_LIST, "Soltar Ve�culo", string, "Selecionar", "Cancelar");
	return 1;
}

CMD:guinchar(playerid, params[])
{
	if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
	    return SendErrorMessage(playerid, "Voc� n�o est� dirigindo um tow truck.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Voc� n�o � o motorista.");

	new vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid));

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendErrorMessage(playerid, "N�o h� nenhum ve�culo no alcance.");

	if (!IsDoorVehicle(vehicleid) || IsAPlane(vehicleid) || IsABoat(vehicleid) || IsAHelicopter(vehicleid))
	    return SendErrorMessage(playerid, "Voc� n�o pode guinchar este ve�culo.");

	AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s encaixou o guincho do tow truck no %s.", pNome(playerid), ReturnVehicleName(vehicleid));
	return 1;
}

CMD:soltarguincho(playerid, params[])
{
	if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
	    return SendErrorMessage(playerid, "Voc� n�o est� dirigindo um tow truck.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Voc� n�o � o motorista.");

	new
	    trailerid = GetVehicleTrailer(GetPlayerVehicleID(playerid));

    if (!trailerid)
	    return SendErrorMessage(playerid, "N�o h� nenhum ve�culo sendo guinchado.");

	DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s retirou o guincho de %s do tow truck.", pNome(playerid), ReturnVehicleName(trailerid));

	return 1;
}

CMD:apreender(playerid, params[])
{
	new
		price,
		id = Impound_Nearest(playerid),
		vehicleid = GetPlayerVehicleID(playerid);

    if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "Voc� precisa ser de uma fac��o policial.");

    if (sscanf(params, "d", price))
        return SendUsageMessage(playerid, "/apreender [valor]");

	if (price < 1 || price > 5000)
	    return SendErrorMessage(playerid, "O valor n�o pode ser menor que $1 ou maior que $5.000.");

	if (GetVehicleModel(vehicleid) != 525)
	    return SendErrorMessage(playerid, "Voc� n�o est� dirigindo um tow truck.");

	if (id == -1)
	    return SendErrorMessage(playerid, "Voc� n�o est� perto de nenhum ponto de apreens�o.");

	if (!GetVehicleTrailer(vehicleid))
	    return SendErrorMessage(playerid, "N�o h� nenhum ve�culo guinchado.");

 	vehicleid = Car_GetID(GetVehicleTrailer(vehicleid));

	if (vehicleid == -1)
	    return SendErrorMessage(playerid, "Voc� n�o pode guinchar este ve�culo.");

	if (CarData[vehicleid][carImpounded] != -1)
	    return SendErrorMessage(playerid, "Este ve�culo j� est� apreendido.");

	CarData[vehicleid][carImpounded] = ImpoundData[id][impoundID];
	CarData[vehicleid][carImpoundPrice] = price;

	Tax_AddMoney(price);

	GetVehiclePos(CarData[vehicleid][carVehicle], CarData[vehicleid][carPos][0], CarData[vehicleid][carPos][1], CarData[vehicleid][carPos][2]);
	Car_Save(vehicleid);

	SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, "RADIO: %s apreendeu o carro %s por %s.", pNome(playerid), ReturnVehicleModelName(CarData[vehicleid][carModel]), FormatNumber(price));
 	DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));

    format(textdc, sizeof textdc, "`VEHLOG:` [%s] **%s** *(%s)* apreendeu o veiculo %s [%d] por $%s.", ReturnDate(), GetPlayerNameEx(playerid), PlayerIP(playerid), ReturnVehicleModelName(CarData[vehicleid][carModel]), vehicleid, FormatNumber(price));
    discord(DC_LogVeh, textdc);

	return 1;
}

CMD:listacarros(playerid, params[])
{
	new
	    Float:fX,
	    Float:fY,
	    Float:fZ,
		userid,
		count;

	if (sscanf(params, "u", userid))
	{
		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (Car_IsOwner(playerid, i)) {
		    GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

		    va_SendClientMessage(playerid, -1, "* ID: %d | Modelo: %s | Localiza��o: %s", CarData[i][carVehicle], ReturnVehicleModelName(CarData[i][carModel]), GetLocation(fX, fY, fZ));
		    count++;
		}
		if (!count)
		    SendClientMessage(playerid, COLOR_WHITE, "Voc� n�o possui nenhum ve�culo.");

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	}
	else if (uInfo[playerid][uAdmin] >= 3)
	{
		if (userid == INVALID_PLAYER_ID)
	    	return SendErrorMessage(playerid, "Voc� espec�ficou o ID de um jogador inv�lido.");

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
  		va_SendClientMessage(playerid, COLOR_YELLOW, "Ve�culos de %s (ID: %d):", pNome(userid), userid);

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (Car_IsOwner(userid, i)) {
  			GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

			va_SendClientMessage(playerid, -1, "** ID: %d | Modelo: %s | Localiza��o: %s", CarData[i][carVehicle], ReturnVehicleModelName(CarData[i][carModel]), GetLocation(fX, fY, fZ));
			count++;
		}
		if (!count)
		    SendClientMessage(playerid, COLOR_WHITE, "Este jogador n�o possui ve�culos.");

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	}
	return 1;
}

CMD:destruirveiculo(playerid, params[])
{
	static
	    id = 0;

    if (uInfo[playerid][uAdmin] < 5)
	    return SendErrorMessage(playerid, "Voc� n�o possui autoriza��o para utilizar esse comando.");

	if (sscanf(params, "d", id))
 	{
	 	if (IsPlayerInAnyVehicle(playerid))
		 	id = GetPlayerVehicleID(playerid);

		else return SendUsageMessage(playerid, "/destruirveiculo [id do ve�culo]");
	}
	if (!IsValidVehicle(id) || Car_GetID(id) == -1)
	    return SendErrorMessage(playerid, "Voc� espec�ficou o ID de um ve�culo inv�lido.");

	Car_Delete(Car_GetID(id));
	va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� destruiu com sucesso o ve�culo ID: %d.", id);
	
    format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* destruiu o veiculo ID %d.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
	discord(DC_AdminCMD, textdc);
    return 1;
}

CMD:criarveiculo(playerid, params[])
{
	static
		model[32],
		color1,
		color2,
		id = -1,
		type = 0;

    if (uInfo[playerid][uAdmin] < 5)
	    return SendErrorMessage(playerid, "Voc� n�o possui autoriza��o para utilizar esse comando.");

	if (sscanf(params, "s[32]I(-1)I(-1)I(0)", model, color1, color2, type))
 	{
	 	SendUsageMessage(playerid, "/criarveiculo <modelid/nome> <cor1> <cor2> <tipo>");
	 	SendClientMessage(playerid, -1, "TIPOS: 1: Policial | 2: Not�cias | 3: Medica | 4: Governamental");
	 	return 1;
	}
	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendErrorMessage(playerid, "Voc� espec�ficou o ID de um ve�culo inv�lido.");

	static
	    Float:x,
		Float:y,
		Float:z,
		Float:angle;

    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	id = Car_Create(0, model[0], x, y, z, angle, color1, color2, type);

	if (id == -1)
	    return SendErrorMessage(playerid, "O servidor chegou ao limite de ve�culos.");

	SetPlayerPosEx(playerid, x, y, z + 2, 1000);
	va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� criou com sucesso o ve�culo ID: %d.", CarData[id][carVehicle]);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* criou o veiculo ID %d.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
	discord(DC_AdminCMD, textdc);
    
    return 1;
}

CMD:editarveiculo(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (uInfo[playerid][uAdmin] < 4)
	    return SendErrorMessage(playerid, "Voc� n�o possui autoriza��o para utilizar esse comando.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendUsageMessage(playerid, "/editarveiculo [id] [syntax]");
	    SendClientMessage(playerid, -1, "SYNTAXES: pos, fac, cor1, cor2");
		return 1;
	}
	if (!IsValidVehicle(id) || Car_GetID(id) == -1)
	    return SendErrorMessage(playerid, "Voc� espec�ficou o ID de um ve�culo inv�lido.");

	id = Car_GetID(id);

	if (!strcmp(type, "pos", true))
	{
 		GetPlayerPos(playerid, CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2]);
		GetPlayerFacingAngle(playerid, CarData[id][carPos][3]);

		Car_Save(id);
		Car_Spawn(id);

		SetPlayerPosEx(playerid, CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2] + 2.0, 1000);
		va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� alterou a posi��o do ve�culo ID: %d.", CarData[id][carVehicle]);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou a pos do veiculo ID %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], CarData[id][carVehicle]);
        discord(DC_AdminCMD, textdc);
    }
	else if (!strcmp(type, "fac", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendUsageMessage(playerid, "/editarveiculo [id] [fac] [tipo]");
		 	SendClientMessage(playerid, -1, "TIPOS: 1: Policial | 2: Not�cias | 3: Medica | 4: Governamental");
		 	return 1;
		}
		if (typeint < 0 || typeint > 4)
		    return SendErrorMessage(playerid, "O tipo de fac��o n�o pode ser menor que um ou maior que quatro.");

		CarData[id][carFaction] = typeint;

		Car_Save(id);
		va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� alterou o tipo do ve�culo ID: %d para %d.", CarData[id][carVehicle], typeint);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou o tipo do veiculo ID: %d para %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], CarData[id][carVehicle], typeint);
        discord(DC_AdminCMD, textdc);
    }
    else if (!strcmp(type, "cor1", true))
	{
	    new color1;

	    if (sscanf(string, "d", color1))
			return SendUsageMessage(playerid, "/editarveiculo [id] [cor1] [cor1]");

		if (color1 < 0 || color1 > 255)
		    return SendErrorMessage(playerid, "A cor espec�ficada n�o pode ser menor que 0 ou maior que 255. que 255.");

		CarData[id][carColor1] = color1;
		ChangeVehicleColor(CarData[id][carVehicle], CarData[id][carColor1], CarData[id][carColor2]);

		Car_Save(id);
		va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� ajustou a cor 1 do ve�culo ID: %d para %d.", CarData[id][carVehicle], color1);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou a cor 1 do veiculo ID: %d para %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], CarData[id][carVehicle], color1);
        discord(DC_AdminCMD, textdc);
    }
    else if (!strcmp(type, "cor2", true))
	{
	    new color2;

	    if (sscanf(string, "d", color2))
			return SendUsageMessage(playerid, "/editarveiculo [id] [cor2] [cor2]");

		if (color2 < 0 || color2 > 255)
		    return SendErrorMessage(playerid, "A cor espec�ficada n�o pode ser menor que 0 ou maior que 255. que 255.");

		CarData[id][carColor2] = color2;
		ChangeVehicleColor(CarData[id][carVehicle], CarData[id][carColor1], CarData[id][carColor2]);

		Car_Save(id);
		va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� ajustou a cor 2 do ve�culo ID: %d para %d.", CarData[id][carVehicle], color2);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou a cor 2 do veiculo ID: %d para %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], CarData[id][carVehicle], color2);
        discord(DC_AdminCMD, textdc);
    }
	return 1;
}


CMD:darveiculo(playerid, params[])
{
	static
		userid,
	    model[32];

    if (uInfo[playerid][uAdmin] < 5)
	    return SendErrorMessage(playerid, "Voc� n�o possui autoriza��o para utilizar esse comando.");

	if (sscanf(params, "us[32]", userid, model))
	    return SendUsageMessage(playerid, "/darveiculo [playerid/nome] [modelid/nome]");

	if (Car_GetCount(userid) >= MAX_OWNABLE_CARS)
	    return SendErrorMessage(playerid, "Este jogador j� possui o n�mero m�ximo de ve�culos.");

    if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendErrorMessage(playerid, "Modelo/ID do ve�culo inv�lido.");

	static
	    Float:x,
		Float:y,
		Float:z,
		Float:angle,
		id = -1;

    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, angle);

	id = Car_Create(pInfo[userid][pID], model[0], x, y + 2, z + 1, angle, random(127), random(127), 0);

	if (id == -1)
	    return SendErrorMessage(playerid, "O servidor chegou ao limite de ve�culos.");

	va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� criou o ve�culo ID: %d para %s.", CarData[id][carVehicle], pNome(userid));
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* criou o veiculo ID: %d para %s.", 
    ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], CarData[id][carVehicle], pNome(userid));
    discord(DC_AdminCMD, textdc);
    return 1;
}

CMD:criarpa(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

    if (uInfo[playerid][uAdmin] < 4)
	    return SendErrorMessage(playerid, "Voc� n�o possui autoriza��o para utilizar esse comando.");

	if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
 		return SendErrorMessage(playerid, "Voc� n�o pode criar um ponto de apreens�o em um interior.");

	GetPlayerPos(playerid, x, y, z);

	id = Impound_Create(x, y, z);

	if (id == -1)
	    return SendErrorMessage(playerid, "O servidor chegou ao limite de pontos de apreens�o.");

	va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� criou com sucesso o ponto de apreens�o ID: %d.", id);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* criou o ponto de apreensao ID: %d.", 
    ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
    discord(DC_AdminCMD, textdc);
    return 1;
}

CMD:destruirpa(playerid, params[])
{
	static
	    id = 0;

    if (uInfo[playerid][uAdmin] < 4)
	    return SendErrorMessage(playerid, "Voc� n�o possui autoriza��o para utilizar esse comando.");

	if (sscanf(params, "d", id))
	    return SendUsageMessage(playerid, "/destruirpa [id ponto de apreens�o]");

	if ((id < 0 || id >= MAX_IMPOUND_LOTS) || !ImpoundData[id][impoundExists])
	    return SendErrorMessage(playerid, "Voc� espec�ficou um ponto de apreens�o inv�lido.");

	Impound_Delete(id);
	va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� destruiu com sucesso o ponto de apreens�o ID: %d.", id);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* destruiu o ponto de apreensao ID: %d.", 
    ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
    discord(DC_AdminCMD, textdc);
    return 1;
}

CMD:editarpa(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (uInfo[playerid][uAdmin] < 4)
	    return SendErrorMessage(playerid, "Voc� n�o possui autoriza��o para utilizar esse comando.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendUsageMessage(playerid, "/editarpa [id] [syntax]");
	    SendClientMessage(playerid, -1, "SYNTAXES: local, soltura");
		return 1;
	}
	if ((id < 0 || id >= MAX_IMPOUND_LOTS) || !ImpoundData[id][impoundExists])
	    return SendErrorMessage(playerid, "Voc� espec�ficou um ponto de apreens�o inv�lido.");

	if (!strcmp(type, "local", true))
	{
	    static
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		ImpoundData[id][impoundLot][0] = x;
		ImpoundData[id][impoundLot][1] = y;
		ImpoundData[id][impoundLot][2] = z;

		Impound_Refresh(id);
		Impound_Save(id);

		va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� editou a posi��o do ponto de apreens�o ID: %d.", id);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* editou a pos do ponto de apreensao ID: %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
        discord(DC_AdminCMD, textdc);
    }
	else if (!strcmp(type, "soltura", true))
	{
	    static
	        Float:x,
	        Float:y,
	        Float:z,
			Float:angle;

	    GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		ImpoundData[id][impoundRelease][0] = x;
		ImpoundData[id][impoundRelease][1] = y;
		ImpoundData[id][impoundRelease][2] = z;
		ImpoundData[id][impoundRelease][3] = angle;

		Impound_Save(id);
		va_SendClientMessage(playerid, COLOR_YELLOW, "Voc� editou o ponto de soltura do ponto de apreens�o ID: %d.", id);
        format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* editou o ponto de soltura do ponto de apreensao ID: %d.", 
        ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
        discord(DC_AdminCMD, textdc);
    }
	return 1;
}

GetPlayerSQLID(playerid)
{
	return (pInfo[playerid][pID]);
}