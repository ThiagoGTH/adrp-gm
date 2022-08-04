#include <YSI_Coding\y_hooks>

hook OnGameModeInit(){
	SetTimer("vehSecondCheck", 1100, true); //1s
	SetTimer("vehMinuteCheck", 60000, true); //1min

	mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles` WHERE (`carFaction` > '0' OR `carJob` > '0' OR `carBiz` > '0') AND `carModel` > '0'");
	mysql_tquery(DBConn, query, "Car_Load");

	return true;
}

hook OnPlayerEnterCheckpoint(playerid){
	if(pInfo[playerid][pSpawnVeh]) {
    	DisablePlayerCheckpoint(playerid);
    	pInfo[playerid][pSpawnVeh] = 0;
	}
	return true;
}
 
// FUNÇÕES
Car_Create(ownerid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, type = 0, alarm=0, lock=0, immob=0, insurance=0, plate[], xmradio=0, sunpass=0) {
    for (new i = 0; i != MAX_DYNAMIC_CARS; i ++){
		if (!CarData[i][carExists]){
			new cName[64] = "NULL";
   		    if (color1 == -1)
   		        color1 = random(127);

			if (color2 == -1)
			    color2 = random(127);

   		    CarData[i][carExists] = true;
            CarData[i][carModel] = modelid;
            CarData[i][carOwner] = ownerid;

            CarData[i][carParkTime] = -1;

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

            CarData[i][carSunPass] = 0;
            CarData[i][carFaction] = type;

			CarData[i][carNamePer] = 0;
			format(CarData[i][carName], 120, "%s", cName);
            CarData[i][carPlatePer] = 0;
			format(CarData[i][carPlate], 120, "%s", plate);

			CarData[i][carHealth] = 1000;
			CarData[i][carHealthRepair] = 1000;
			CarData[i][carHealthUpdate] = 1000;
			CarData[i][carAlarm] = alarm;
			CarData[i][carLock] = lock;
			CarData[i][carImob] = immob;
			CarData[i][carXMRadio] = xmradio;
			CarData[i][carInsurance] = insurance;
			CarData[i][carSunPass] = sunpass;
			CarData[i][carMiles] = 0.0;
			CarData[i][carJob] = 0;
			CarData[i][carRentPrice] = 0;
			CarData[i][carDismantling] = false;
			CarData[i][carRentPlayer] = -1;
			CarData[i][carRentTime] = 0;
			CarData[i][carRentSpawnTime] = 0;

			CarData[i][carVW] = 0;
			CarData[i][carInterior] = 0;

			SetCarAttributes(modelid, i);

			new count;
		    for (new ix = 0; ix < sizeof(arrBatteryEngine); ix ++)
			{
			    if(CarData[i][carModel] == arrBatteryEngine[ix][VehModel])
			    {
		    	    CarData[i][carMaxFuel] = arrBatteryEngine[ix][VehMaxFuel];
		        	CarData[i][carFuel] = arrBatteryEngine[ix][VehMaxFuel];
		        	count++;
			        break;
			    }
			}
			if(!count)
			{
			    CarData[i][carMaxFuel] = 70.0;
      			CarData[i][carFuel] = 70.0;
    	  		count = 0;
			}

            for (new j = 0; j < 30; j ++)
			{
               CarData[i][carWeapons][j] = 0;
               CarData[i][carAmmo][j] = 0;
               CarData[i][carWeaponsType][j] = 0;
            }
			for (new m = 0; m < 14; m ++)
			{
                CarData[i][carMods][m] = 0;
			}
            new string[120];
            CarData[i][carVehicle] = CreateVehicle(modelid, x, y, z, angle, color1, color2, -1);
			printf("Car_Create");
            format(string, sizeof(string), "%s", CarData[i][carPlate]);
            SetVehicleNumberPlate(CarData[i][carVehicle], string);
            GetVehiclePos(CarData[i][carVehicle], CoreVehicles[CarData[i][carVehicle]][MilesPos][0], CoreVehicles[CarData[i][carVehicle]][MilesPos][1], CoreVehicles[CarData[i][carVehicle]][MilesPos][2]);

            if (CarData[i][carVehicle] != INVALID_VEHICLE_ID) {
                ResetVehicle(CarData[i][carVehicle]);
            }

	        mysql_tquery(DBConn, "INSERT INTO `vehicles` (`carModel`) VALUES(0)", "OnCarCreated", "d", i);
            return i;
		}
    }
	return -1;
}

Car_Save(carid){
    printf("[1] Car_Save");
    mysql_format(DBConn, query, sizeof query, "UPDATE vehicles SET `carModel` = '%d', `carOwner` = '%d', `carPosX` = '%.4f', `carPosY` = '%.4f', `carPosZ` = '%.4f', `carPosR` = '%.4f', `carColor1` = '%d', `carColor2` = '%d', `carPaintjob` = '%d', `carLocked` = '%d'",
        CarData[carid][carModel],
        CarData[carid][carOwner],
        CarData[carid][carPos][0],
        CarData[carid][carPos][1],
        CarData[carid][carPos][2],
        CarData[carid][carPos][3],
        CarData[carid][carColor1],
        CarData[carid][carColor2],
        CarData[carid][carPaintjob],
        CarData[carid][carLocked]);
    printf("[2] Car_Save");
    for(new i = 0; i < 14; i++)
	    mysql_format(DBConn, query, sizeof query, "%s, `carMod%d` = '%d'", query, i+1, CarData[carid][carMods][i]);
    printf("[3] Car_Save");
    mysql_format(DBConn, query, sizeof query, "%s, `carImpounded` = '%d', `carImpoundPrice` = '%d', `carFaction` = '%d', `carBiz` = '%d' WHERE `carID` = '%d'",
		query,
		CarData[carid][carImpounded],
		CarData[carid][carImpoundPrice],
		CarData[carid][carFaction],
		CarData[carid][carBiz],
		CarData[carid][carID]
	);
    mysql_query(DBConn, query);
    printf("[4] Car_Save");
    mysql_format(DBConn, query, sizeof query, "UPDATE `vehicles` SET `carPlate` = '%s', `carHealth` = '%.4f', `carAlarm` = '%d', `carLock` = '%d', `carImob` = '%d', `carInsurance` = '%d', `carBattery` = '%.3f', `carEngine` = '%.3f', `carMiles` = '%.3f', `carDoorsStatus` = '%d', `carPanelsStatus` = '%d', `carLightsStatus` = '%d'",
		CarData[carid][carPlate],
		CarData[carid][carHealth],
		CarData[carid][carAlarm],
		CarData[carid][carLock],
		CarData[carid][carImob],
		CarData[carid][carInsurance],
        CarData[carid][carBattery],
		CarData[carid][carEngine],
		CarData[carid][carMiles],
		CarData[carid][carDoorsStatus],
    	CarData[carid][carPanelsStatus],
    	CarData[carid][carLightsStatus]
	);
    printf("[5] Car_Save");
    mysql_format(DBConn, query, sizeof query, "%s, `carTiresStatus` = '%d', `carPlatePer` = '%d', `carXMRadio` = '%d', `carJob` = '%d', `carRentPrice` = '%d', `carRentPlayer` = '%d', `carRentTime` = '%d', `carFuel` = '%.1f', `carSunPass` = '%d', `carNOSInstalled` = '%d', `carNOS` = '%d'",
		query,
    	CarData[carid][carTiresStatus],
    	CarData[carid][carPlatePer],
    	CarData[carid][carXMRadio],
    	CarData[carid][carJob],
    	CarData[carid][carRentPrice],
    	CarData[carid][carRentPlayer],
    	CarData[carid][carRentTime],
        CarData[carid][carFuel],
        CarData[carid][carSunPass],
        CarData[carid][carNOSInstalled],
        CarData[carid][carNOS]
	);
    printf("[6] Car_Save");
    mysql_format(DBConn, query, sizeof query, "%s, `carVW` = '%d', `carInterior` = '%d', `carName` = '%s', `carNamePer` = '%d' WHERE `carID` = '%d'",
		query,
		CarData[carid][carName],
		CarData[carid][carNamePer],
		CarData[carid][carVW],
		CarData[carid][carInterior],
		CarData[carid][carID]
	);
    mysql_query(DBConn, query);
    printf("[7] Car_Save");
    mysql_format(DBConn, query, sizeof query, "UPDATE vehicles_weapons SET");
    for(new i = 0; i < 30; i++)
	    mysql_format(DBConn, query, sizeof query, "%s `carWeapon%d` = '%d',", query, i+1, CarData[carid][carWeapons][i]);
    printf("[8] Car_Save");
    for(new i = 0; i < 30; i++)
	    mysql_format(DBConn, query, sizeof query, "%s `carAmmo%d` = '%d',", query, i+1, CarData[carid][carAmmo][i]);
    printf("[9] Car_Save");
    for(new i = 0; i < 30; i++)
	    mysql_format(DBConn, query, sizeof query, "%s `carWeaponType%d` = '%d',", query, i+1, CarData[carid][carWeaponsType][i]);
    printf("[10] Car_Save");
    mysql_format(DBConn, query, sizeof query, "%s `empty` = '0' WHERE `carID` = '%d'", query, CarData[carid][carID]);
    mysql_query(DBConn, query);
    printf("[11] Car_Save");
}

Car_Spawn(carid) {
	if (carid != -1 && CarData[carid][carExists]) {
		if (IsValidVehicle(CarData[carid][carVehicle]))
		    DestroyVehicle(CarData[carid][carVehicle]);

		if (CarData[carid][carColor1] == -1)
		    CarData[carid][carColor1] = random(127);

		if (CarData[carid][carColor2] == -1)
		    CarData[carid][carColor2] = random(127);

		new string[128];
		if(CarData[carid][carFaction] == 1) {
        	CarData[carid][carVehicle] = CreateVehicle(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000), true);
            LinkVehicleToInterior(CarData[carid][carVehicle], CarData[carid][carInterior]);
            SetVehicleVirtualWorld(CarData[carid][carVehicle], CarData[carid][carVW]);
            format(string, sizeof(string), "{000000}%d", 1234567+CarData[carid][carID]);
		} else if(CarData[carid][carFaction] == 3) {
        	CarData[carid][carVehicle] = CreateVehicle(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000), true);
            LinkVehicleToInterior(CarData[carid][carVehicle], CarData[carid][carInterior]);
            SetVehicleVirtualWorld(CarData[carid][carVehicle], CarData[carid][carVW]);
            format(string, sizeof(string), "{000000}FIRE");
		} else if(CarData[carid][carFaction] == 4) {
        	CarData[carid][carVehicle] = CreateVehicle(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000), false);
            LinkVehicleToInterior(CarData[carid][carVehicle], CarData[carid][carInterior]);
            SetVehicleVirtualWorld(CarData[carid][carVehicle], CarData[carid][carVW]);
            format(string, sizeof(string), "{000000}CITY");
		} else if(CarData[carid][carRentPrice] > 0) {
        	CarData[carid][carVehicle] = CreateVehicle(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000), false);
            LinkVehicleToInterior(CarData[carid][carVehicle], CarData[carid][carInterior]);
            SetVehicleVirtualWorld(CarData[carid][carVehicle], CarData[carid][carVW]);
            format(string, sizeof(string), "{000000}RENT");
		} else {
        	CarData[carid][carVehicle] = CreateVehicle(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000), false);
        	LinkVehicleToInterior(CarData[carid][carVehicle], CarData[carid][carInterior]);
        	SetVehicleVirtualWorld(CarData[carid][carVehicle], CarData[carid][carVW]);
        	format(string, sizeof(string), "%s", CarData[carid][carPlate]);
		}
        SetVehicleNumberPlate(CarData[carid][carVehicle], string);

        new doors, lights;
        if(CarData[carid][carInsurance] == 0) {
            CarData[carid][carHealthRepair] = 1000.0;
      		UpdateVehicleDamageStatus(CarData[carid][carVehicle], CarData[carid][carPanelsStatus], CarData[carid][carDoorsStatus], CarData[carid][carLightsStatus], CarData[carid][carTiresStatus]);
		}
		else if(CarData[carid][carInsurance] == 1) {
            CarData[carid][carHealth] = 1000;
            CarData[carid][carHealthRepair] = 1000.0;
            UpdateVehicleDamageStatus(CarData[carid][carVehicle], CarData[carid][carPanelsStatus], CarData[carid][carDoorsStatus], CarData[carid][carLightsStatus], CarData[carid][carTiresStatus]);
		}
		else if(CarData[carid][carInsurance] == 2) {
        	UpdateVehicleDamageStatus(CarData[carid][carVehicle], CarData[carid][carPanelsStatus], CarData[carid][carDoorsStatus], CarData[carid][carLightsStatus], CarData[carid][carTiresStatus]);
     		CarData[carid][carHealth] = 1000;
     		CarData[carid][carHealthRepair] = 1000.0;
     		RepairVehicle(CarData[carid][carVehicle]);
     		CarData[carid][carDamage][1] = 0;//9mm
			CarData[carid][carDamage][2] = 0;//.44
			CarData[carid][carDamage][3] = 0;//12 Gauge
			CarData[carid][carDamage][4] = 0;//9x19mm
			CarData[carid][carDamage][5] = 0;//7.62mm
			CarData[carid][carDamage][6] = 0;//5.56x45mm
			CarData[carid][carDamage][7] = 0;//.40 LR
			CarData[carid][carDamage][8] = 0;//.50 LR
     	}
		else if(CarData[carid][carInsurance] == 3) {
        	UpdateVehicleDamageStatus(CarData[carid][carVehicle], CarData[carid][carPanelsStatus], CarData[carid][carDoorsStatus], CarData[carid][carLightsStatus], CarData[carid][carTiresStatus]);
     		CarData[carid][carHealth] = 1000;
     		CarData[carid][carHealthRepair] = 1000.0;
     		RepairVehicle(CarData[carid][carVehicle]);
     		CarData[carid][carDamage][1] = 0;//9mm
			CarData[carid][carDamage][2] = 0;//.44
			CarData[carid][carDamage][3] = 0;//12 Gauge
			CarData[carid][carDamage][4] = 0;//9x19mm
			CarData[carid][carDamage][5] = 0;//7.62mm
			CarData[carid][carDamage][6] = 0;//5.56x45mm
			CarData[carid][carDamage][7] = 0;//.40 LR
			CarData[carid][carDamage][8] = 0;//.50 LR
		}
		CarData[carid][carTrunkPlayer] = INVALID_PLAYER_ID;
		SetVehicleParamsEx(CarData[carid][carVehicle], 0, 0, 0, 0, 0, 0, 0);

		/*if(CarData[carid][carModel] == 427 && CarData[carid][carFaction] == FACTION_POLICE)
		    SetVehicleHealth(CarData[carid][carVehicle], 3000);
		else if(CarData[carid][carModel] == 428 && CarData[carid][carFaction] == FACTION_POLICE)
		    SetVehicleHealth(CarData[carid][carVehicle], 3000);
		else if(CarData[carid][carModel] == 490 && CarData[carid][carFaction] == FACTION_POLICE)
		    SetVehicleHealth(CarData[carid][carVehicle], 2500);
		else if(CarData[carid][carModel] == 528 && CarData[carid][carFaction] == FACTION_POLICE)
		    SetVehicleHealth(CarData[carid][carVehicle], 4000);
		else if(CarData[carid][carModel] == 601 && CarData[carid][carFaction] == FACTION_POLICE)
		    SetVehicleHealth(CarData[carid][carVehicle], 6000);

		if(CarData[carid][carJob] == JOB_TAXI && CarData[carid][carRentPrice] > 0)
			SetVehicleVirtualWorld(CarData[carid][carVehicle], 9);
		else if(CarData[carid][carJob] == JOB_GARBAGE && CarData[carid][carRentPrice] > 0)
			SetVehicleVirtualWorld(CarData[carid][carVehicle], 9);
		else if(CarData[carid][carJob] == JOB_MECHANIC && CarData[carid][carRentPrice] > 0)
			SetVehicleVirtualWorld(CarData[carid][carVehicle], 9);*/

		/*if(IsValidDynamic3DTextLabel(vehicle3Dtexttrunk[CarData[carid][carVehicle]]))
	 		DestroyDynamic3DTextLabel(vehicle3Dtexttrunk[CarData[carid][carVehicle]]);*/

        if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
        {
            if (CarData[carid][carPaintjob] != -1)
                ChangeVehiclePaintjob(CarData[carid][carVehicle], CarData[carid][carPaintjob]);

			if (CarData[carid][carLocked]) {
			    new
					engine, alarm, bonnet, boot, objective;

				GetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
			}
			for (new i = 0; i < 14; i ++) {
			    if (CarData[carid][carMods][i]) AddVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);
			}

			if(CarData[carid][carNOS] > 0)
				AddComponent(CarData[carid][carVehicle], 1009);

			CoreVehicles[CarData[carid][carVehicle]][vehCARID] = carid;
   			ResetVehicle(CarData[carid][carVehicle]);
			return true;
		}
	}
	return false;
}

Car_Reset(carid) {
	if (carid != -1 && CarData[carid][carExists])
	{
		CarData[carid][carTrunkPlayer] = INVALID_PLAYER_ID;

		if (IsValidVehicle(CarData[carid][carVehicle]))
			return DestroyVehicle(CarData[carid][carVehicle]);
	}
	return false;
}
/*
Car_Delete(carid) {
    if (carid != -1 && CarData[carid][carExists])
	{
		mysql_format(DBConn, query, sizeof query, "DELETE FROM vehicles WHERE `carID` = '%s';",  CarData[carid][carID]);
        mysql_query(DBConn, query);


		if (IsValidVehicle(CarData[carid][carVehicle]))
			DestroyVehicle(CarData[carid][carVehicle]);

		//Car_RemoveAllItems(carid);

        CarData[carid][carExists] = false;
	    CarData[carid][carID] = 0;
	    CarData[carid][carOwner] = 0;
	    CarData[carid][carParkTime] = -1;
	    CoreVehicles[CarData[carid][carVehicle]][vehCARID] = -1;
	    CarData[carid][carVehicle] = 0;
	    CarData[carid][carBiz] = -1;
	}
	return true;
}*/

Car_Park(carid) {
	if(gettime() < CarData[carid][carParkTime])
		return true;
	else if(!IsValidVehicle(CarData[carid][carVehicle]))
		return true;

	static
		g_arrDamage[4],
		Float:health;

	GetVehicleDamageStatus(CarData[carid][carVehicle], CarData[carid][carPanelsStatus], CarData[carid][carDoorsStatus], CarData[carid][carLightsStatus], CarData[carid][carTiresStatus]);
	GetVehicleHealth(CarData[carid][carVehicle], health);

	CarData[carid][carHealth] = health;
	CarData[carid][carHealthRepair] = health;
	CarData[carid][carHealthUpdate] = health;

	foreach (new i : Player) {
		if(pInfo[i][pLogged] && pInfo[i][pID] == CarData[carid][carOwner])
			SendServerMessage(i, "%s foi estacionado(a) na vaga.", ReturnVehicleName(CarData[carid][carVehicle]));
	}
   	
	CarData[carid][carFuel] = CoreVehicles[CarData[carid][carVehicle]][vehFuel];
	CarData[carid][carParkTime] = -1;
	Car_Save(carid);
	Car_Reset(carid);
	CoreVehicles[CarData[carid][carVehicle]][vehCARID] = -1;
	CarData[carid][carVehicle] = 0;

	UpdateVehicleDamageStatus(CarData[carid][carVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
	SetVehicleHealth(CarData[carid][carVehicle], health);
	CarData[carid][carHealthRepair] = health;
	return true;
}

ListPlayerVehicle(playerid) {
	new string[2048];
	new count = 0;
    for (new i = 0; i < MAX_DYNAMIC_CARS; i ++){
        if (Car_IsOwner(playerid, i)){
            new name[10];
			if(strlen(ReturnVehicleModelName(CarData[i][carModel])) < 12) format(name, 10, "%s", ReturnVehicleModelName(CarData[i][carModel]));
			else format(name, 10, "%.10s...", ReturnVehicleModelName(CarData[i][carModel]));

            if (CarData[i][carImpounded] != -1) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~ID Registro~n~~w~%d\n", string, CarData[i][carModel], CarData[i][carColor1], CarData[i][carColor2], name, CarData[i][carID]);
            else if(IsValidVehicle(CarData[i][carVehicle])) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~ID Real~n~~w~%d\n", string, CarData[i][carModel], CarData[i][carColor1], CarData[i][carColor2], ReturnVehicleModelName(CarData[i][carModel]), CarData[i][carVehicle]);
            else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~w~%s~n~~n~~n~~n~ID Registro~n~~w~%d\n", string, CarData[i][carModel], CarData[i][carColor1], CarData[i][carColor2], ReturnVehicleModelName(CarData[i][carModel]), CarData[i][carID]);

            count++;
        }
    }
    if (!count) return SendErrorMessage(playerid, "Você não possui nenhum veículo.");
    new title[128];
    format(title, sizeof(title), "Lista_de_veículos_de_%s", pNome(playerid));
    AdjustTextDrawString(title);

    ShowPlayerDialog(playerid, 9998, DIALOG_STYLE_PREVIEW_MODEL_WITHOUT, title, string, "Selecionar", "Cancelar");
	return true;
}

ParkPlayerVehicle(playerid) {
	new carid = GetPlayerVehicleID(playerid);

	if (!carid)
	    return SendErrorMessage(playerid, "Você deve estar dentro do seu veículo.");

    if (IsVehicleImpounded(carid))
    	return SendErrorMessage(playerid, "Este veículo está apreendido, portanto você não pode utilizá-lo.");

	if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid)) {
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "Você deve ser o motorista!");

	    /*if(CarData[carid][carTrunkPlayer] != INVALID_PLAYER_ID)
	    {
	    	for(new i = 0; i < MAX_PLAYERS; i++)
	    	{
	    		if(CarData[carid][carTrunkPlayer] == i)
	    		{
	    			if(!pInfo[playerid][pInsideTrunkCar])
	    				CarData[carid][carTrunkPlayer] = INVALID_PLAYER_ID;
	    		}
	    	}	
	    }*/
	    
	    /*if(CarData[carid][carTrunkPlayer] != INVALID_PLAYER_ID)
	    	return SendErrorMessage(playerid, "Você deve retirar o jogador do porta-malas antes de estacionar o veículo.");*/

		if(IsPlayerInRangeOfPoint(playerid, 5.0, CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]) && CarData[carid][carVW] == GetPlayerVirtualWorld(playerid) && CarData[carid][carInterior] == GetPlayerInterior(playerid))
		{
			if(CarData[carid][carParkTime] != -1)
				return SendErrorMessage(playerid, "Este veiculo já está sendo estacionado.");

			if(CarData[carid][carVW] == 0)
				CarData[carid][carParkTime] = gettime()+30;
			else
				CarData[carid][carParkTime] = gettime()+30;

			RemovePlayerFromVehicle(playerid);

			for(new i = 0; i < MAX_PLAYERS; i++)
	    	{
	    		if(GetPlayerState(i) == PLAYER_STATE_PASSENGER && GetPlayerVehicleID(i) == CarData[carid][carVehicle])
	    			RemovePlayerFromVehicle(i);
	    	}

	    	if(CarData[carid][carVW] == 0)
				SendServerMessage(playerid, "%s será estacionado(a) em trinta segundos.", ReturnVehicleName(CarData[carid][carVehicle]));
			else
				SendServerMessage(playerid, "%s será estacionado(a) em trinta segundos.", ReturnVehicleName(CarData[carid][carVehicle]));
		}
		else{
		    SendErrorMessage(playerid, "Você não está perto de sua vaga.");
			if(CarData[carid][carVW] == 0){
				va_SendClientMessage(playerid, 0xFF00FFFF, "Info: Você pode usar a marca vermelha no mapa para achar a vaga do seu veículo.");
				SetPlayerCheckpoint(playerid, CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], 3.0);
			}
		}
	}
	else SendErrorMessage(playerid, "Você não está dentro de nenhum veículo que possa ser estacionado.");
	return true;
}

CarBuyPark(playerid) {
	new carid = GetPlayerVehicleID(playerid);

	if (!carid)
	    return SendErrorMessage(playerid, "Você deve estar dentro do seu veículo.");

    if (IsVehicleImpounded(carid))
    	return SendErrorMessage(playerid, "Este veículo está apreendido, portanto você não pode utilizá-lo.");

	if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid)) {
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "Você deve ser o motorista!");
		
		/*if(CarData[carid][carTrunkPlayer] != INVALID_PLAYER_ID){
			for(new i = 0; i < MAX_PLAYERS; i++){
				if(CarData[carid][carTrunkPlayer] == i){
					if(!pInfo[playerid][pInsideTrunkCar])
						CarData[carid][carTrunkPlayer] = INVALID_PLAYER_ID;
				}
			}	
		}*/

		/*if(CarData[carid][carTrunkPlayer] != INVALID_PLAYER_ID)
	    	return SendErrorMessage(playerid, "Você deve retirar o jogador do porta-malas antes de comprar uma nova vaga para veículo.");*/

	    GetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
		GetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

		CarData[carid][carVW] = GetPlayerVirtualWorld(playerid);
		CarData[carid][carInterior] = GetPlayerInterior(playerid);

		Car_Save(carid);
		SendServerMessage(playerid, "Você atualizou a vaga do seu veículo com sucesso.", ReturnVehicleName(CarData[carid][carVehicle]));
		
	}
	else SendErrorMessage(playerid, "Você não está dentro de nenhum veículo que possa ser estacionado.");
	return true;
}

Car_LoadByID(carid) {
	mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles` WHERE `carID` ='%d'", carid);
	mysql_tquery(DBConn, query, "Car_Load2");
	return true;
}

forward Car_Load();
public Car_Load() {
	for (new i = 0; i < cache_num_rows(); i ++) {
		if (!CarData[i][carExists]) {
		    CarData[i][carExists] = true;

			cache_get_value_name_int(i, "carID", CarData[i][carID]);
			cache_get_value_name_int(i, "carModel", CarData[i][carModel]);
			cache_get_value_name_int(i, "carOwner", CarData[i][carOwner]);

			cache_get_value_name_int(i, "carFaction", CarData[i][carFaction]);
			cache_get_value_name_int(i, "carBiz", CarData[i][carBiz]);
			cache_get_value_name_int(i, "carJob", CarData[i][carJob]);

			cache_get_value_name_float(i, "carPosX", CarData[i][carPos][0]);
			cache_get_value_name_float(i, "carPosY", CarData[i][carPos][1]);
			cache_get_value_name_float(i, "carPosZ", CarData[i][carPos][2]);
			cache_get_value_name_float(i, "carPosR", CarData[i][carPos][3]);

			cache_get_value_name_int(i, "carVW", CarData[i][carVW]);
			cache_get_value_name_int(i, "carInterior", CarData[i][carInterior]);

			cache_get_value_name_int(i, "carColor1", CarData[i][carColor1]);
			cache_get_value_name_int(i, "carColor2", CarData[i][carColor2]);
			cache_get_value_name_int(i, "carPaintjob", CarData[i][carPaintjob]);

			cache_get_value_name_int(i, "carLocked", CarData[i][carLocked]);
			cache_get_value_name_int(i, "carNOSInstalled", CarData[i][carNOSInstalled]);
			cache_get_value_name_int(i, "carNOS", CarData[i][carNOS]);

			cache_get_value_name_int(i, "carImpounded", CarData[i][carImpounded]);
			cache_get_value_name_int(i, "carImpoundPrice", CarData[i][carImpoundPrice]);
			cache_get_value_name_int(i, "carSunPass", CarData[i][carSunPass]);

			cache_get_value_name(i, "carName", CarData[i][carName]);
			cache_get_value_name_int(i, "carNamePer", CarData[i][carNamePer]);
			cache_get_value_name(i, "carPlate", CarData[i][carPlate]);
			cache_get_value_name_int(i, "carPlatePer", CarData[i][carPlatePer]);

			cache_get_value_name_float(i, "carFuel", CarData[i][carFuel]);

			cache_get_value_name_float(i, "carHealth", CarData[i][carHealth]);	
			cache_get_value_name_float(i, "carHealth", CarData[i][carHealthUpdate]);
			cache_get_value_name_int(i, "carAlarm", CarData[i][carAlarm]);
			cache_get_value_name_int(i, "carLock", CarData[i][carLock]);	
			cache_get_value_name_int(i, "carImob", CarData[i][carImob]);
			cache_get_value_name_int(i, "carXMRadio", CarData[i][carXMRadio]);
			cache_get_value_name_int(i, "carInsurance", CarData[i][carInsurance]);

			cache_get_value_name_float(i, "carBattery", CarData[i][carBattery]);
			cache_get_value_name_float(i, "carEngine", CarData[i][carEngine]);
			cache_get_value_name_float(i, "carMiles", CarData[i][carMiles]);
		    
			cache_get_value_name_int(i, "carEnergyResource", CarData[i][carEnergyResource]);	
			cache_get_value_name_int(i, "carDoorsStatus", CarData[i][carDoorsStatus]);
			cache_get_value_name_int(i, "carPanelsStatus", CarData[i][carPanelsStatus]);
			cache_get_value_name_int(i, "carLightsStatus", CarData[i][carLightsStatus]);	
			cache_get_value_name_int(i, "carTiresStatus", CarData[i][carTiresStatus]);
			cache_get_value_name_int(i, "carCarparts", CarData[i][carCarparts]);

		    cache_get_value_name_int(i, "carRentPrice", CarData[i][carRentPrice]);	
			cache_get_value_name_int(i, "carRentPlayer", CarData[i][carRentPlayer]);
			cache_get_value_name_int(i, "carRentTime", CarData[i][carRentTime]);
  	
			CarData[i][carRentSpawnTime] = 0;

			if(CarData[i][carRentPrice] > 0)
				CarData[i][carFuel] = 1.0;

			CarData[i][carMilesCon] = 0.0;
			CarData[i][carDismantling] = false;
	        CarData[i][carParkTime] = -1;
	        CarData[i][carTrunkPlayer] = INVALID_PLAYER_ID;

		    new count;
		    for (new ix = 0; ix < sizeof(arrBatteryEngine); ix ++) {
			    if(CarData[i][carModel] == arrBatteryEngine[ix][VehModel])
			    {
			        CarData[i][carMaxFuel] = arrBatteryEngine[ix][VehMaxFuel];

					if(CarData[i][carFuel] == -1.0)
	            		CarData[i][carFuel] = arrBatteryEngine[ix][VehMaxFuel];

					count++;
			        break;
			    }
			}
			if(!count) {
			    CarData[i][carMaxFuel] = 20.0;

				if(CarData[i][carFuel] == -1.0)
	    			CarData[i][carFuel] = 20.0;

	      		count = 0;
			}

			for (new m = 0; m < 14; m ++) {
				format(query, sizeof(query), "carMod%d", m + 1);
				cache_get_value_name_int(0, query, CarData[i][carMods][m]);
			}

			mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `ID` = '%d'", CarData[i][carID]);
			mysql_tquery(DBConn, query, "OnLoadVehWeapons", "d", i);

		    if(CarData[i][carOwner] == 0)
				Car_Spawn(i);
		    else if(CarData[i][carRentPrice] > 0)
				Car_Spawn(i);
			else if(CarData[i][carBiz] != -1)
				Car_Spawn(i);

		}
	}
	return true;
}

forward Car_Load2();
public Car_Load2() {
	for (new i = 0; i < cache_num_rows(); i ++) {
		if (!CarData[i][carExists]) {
		    CarData[i][carExists] = true;

			cache_get_value_name_int(i, "carID", CarData[i][carID]);
			cache_get_value_name_int(i, "carModel", CarData[i][carModel]);
			cache_get_value_name_int(i, "carOwner", CarData[i][carOwner]);

			cache_get_value_name_int(i, "carFaction", CarData[i][carFaction]);
			cache_get_value_name_int(i, "carBiz", CarData[i][carBiz]);
			cache_get_value_name_int(i, "carJob", CarData[i][carJob]);

			cache_get_value_name_float(i, "carPosX", CarData[i][carPos][0]);
			cache_get_value_name_float(i, "carPosY", CarData[i][carPos][1]);
			cache_get_value_name_float(i, "carPosZ", CarData[i][carPos][2]);
			cache_get_value_name_float(i, "carPosR", CarData[i][carPos][3]);

			cache_get_value_name_int(i, "carVW", CarData[i][carVW]);
			cache_get_value_name_int(i, "carInterior", CarData[i][carInterior]);

			cache_get_value_name_int(i, "carColor1", CarData[i][carColor1]);
			cache_get_value_name_int(i, "carColor2", CarData[i][carColor2]);
			cache_get_value_name_int(i, "carPaintjob", CarData[i][carPaintjob]);

			cache_get_value_name_int(i, "carLocked", CarData[i][carLocked]);
			cache_get_value_name_int(i, "carNOSInstalled", CarData[i][carNOSInstalled]);
			cache_get_value_name_int(i, "carNOS", CarData[i][carNOS]);

			cache_get_value_name_int(i, "carImpounded", CarData[i][carImpounded]);
			cache_get_value_name_int(i, "carImpoundPrice", CarData[i][carImpoundPrice]);
			cache_get_value_name_int(i, "carSunPass", CarData[i][carSunPass]);

			cache_get_value_name(i, "carName", CarData[i][carName]);
			cache_get_value_name_int(i, "carNamePer", CarData[i][carNamePer]);
			cache_get_value_name(i, "carPlate", CarData[i][carPlate]);
			cache_get_value_name_int(i, "carPlatePer", CarData[i][carPlatePer]);

			cache_get_value_name_float(i, "carFuel", CarData[i][carFuel]);

			cache_get_value_name_float(i, "carHealth", CarData[i][carHealth]);	
			cache_get_value_name_float(i, "carHealth", CarData[i][carHealthUpdate]);
			cache_get_value_name_int(i, "carAlarm", CarData[i][carAlarm]);
			cache_get_value_name_int(i, "carLock", CarData[i][carLock]);	
			cache_get_value_name_int(i, "carImob", CarData[i][carImob]);
			cache_get_value_name_int(i, "carXMRadio", CarData[i][carXMRadio]);
			cache_get_value_name_int(i, "carInsurance", CarData[i][carInsurance]);

			cache_get_value_name_float(i, "carBattery", CarData[i][carBattery]);
			cache_get_value_name_float(i, "carEngine", CarData[i][carEngine]);
			cache_get_value_name_float(i, "carMiles", CarData[i][carMiles]);
		    
			cache_get_value_name_int(i, "carEnergyResource", CarData[i][carEnergyResource]);	
			cache_get_value_name_int(i, "carDoorsStatus", CarData[i][carDoorsStatus]);
			cache_get_value_name_int(i, "carPanelsStatus", CarData[i][carPanelsStatus]);
			cache_get_value_name_int(i, "carLightsStatus", CarData[i][carLightsStatus]);	
			cache_get_value_name_int(i, "carTiresStatus", CarData[i][carTiresStatus]);
			cache_get_value_name_int(i, "carCarparts", CarData[i][carCarparts]);

		    cache_get_value_name_int(i, "carRentPrice", CarData[i][carRentPrice]);	
			cache_get_value_name_int(i, "carRentPlayer", CarData[i][carRentPlayer]);
			cache_get_value_name_int(i, "carRentTime", CarData[i][carRentTime]);
  	
			CarData[i][carRentSpawnTime] = 0;

			if(CarData[i][carRentPrice] > 0)
				CarData[i][carFuel] = 1.0;

			CarData[i][carMilesCon] = 0.0;
			CarData[i][carDismantling] = false;
	        CarData[i][carParkTime] = -1;
	        CarData[i][carTrunkPlayer] = INVALID_PLAYER_ID;

		    new count;
		    for (new ix = 0; ix < sizeof(arrBatteryEngine); ix ++) {
			    if(CarData[i][carModel] == arrBatteryEngine[ix][VehModel])
			    {
			        CarData[i][carMaxFuel] = arrBatteryEngine[ix][VehMaxFuel];

					if(CarData[i][carFuel] == -1.0)
	            		CarData[i][carFuel] = arrBatteryEngine[ix][VehMaxFuel];

					count++;
			        break;
			    }
			}
			if(!count) {
			    CarData[i][carMaxFuel] = 20.0;

				if(CarData[i][carFuel] == -1.0)
	    			CarData[i][carFuel] = 20.0;

	      		count = 0;
			}

			for (new m = 0; m < 14; m ++) {
				format(query, sizeof(query), "carMod%d", m + 1);
				cache_get_value_name_int(0, query, CarData[i][carMods][m]);
			}

			mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `ID` = '%d'", CarData[i][carID]);
			mysql_tquery(DBConn, query, "OnLoadVehWeapons", "d", i);
		}
	}
	return true;
}

forward OnLoadVehWeapons(carid);
public OnLoadVehWeapons(carid){
	if(cache_num_rows()) {
		for (new i = 0; i < 30; i ++) {
			format(query, sizeof(query), "carWeapon%d", i + 1);
			cache_get_value_name_int(0, query, CarData[carid][carWeapons][i]);
			format(query, sizeof(query), "carWeaponType%d", i + 1);
			cache_get_value_name_int(0, query, CarData[carid][carWeaponsType][i]);
			format(query, sizeof(query), "carAmmo%d", i + 1);
			cache_get_value_name_int(0, query, CarData[carid][carAmmo][i]);
		}
	}
	return true;
}

forward OnCarCreated(carid);
public OnCarCreated(carid){
	if (carid == -1 || !CarData[carid][carExists])
	    return false;
    printf("[1] OnCarCreated");
	CarData[carid][carID] = cache_insert_id();
    printf("[2] OnCarCreated");
    mysql_format(DBConn, query, sizeof query, "INSERT INTO vehicles_weapons (`carID`) VALUES ('%d');", cache_insert_id());
    printf("[3] OnCarCreated");
    mysql_query(DBConn, query);
    printf("[4] OnCarCreated");
	Car_Save(carid);
    printf("[5] OnCarCreated");
	return true;
}

forward vehSecondCheck();
public vehSecondCheck() {
	foreach (new i : Player){
		if(pInfo[i][pTimerSpawn] > 0) 
			pInfo[i][pTimerSpawn]--;
	}
	return true;
}

forward vehMinuteCheck();
public vehMinuteCheck() {
	for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (CarData[i][carVehicle] != INVALID_VEHICLE_ID){
		if(GetEngineStatus(CarData[i][carVehicle])) {
	        if(CarData[i][carEngine] > 0.001){
				CarData[i][carEngine] -= 0.001;
			}
	    }
	    if(GetLightStatus(CarData[i][carVehicle])) {
	        if(CarData[i][carModel] != 481 && CarData[i][carModel] != 509 && CarData[i][carModel] != 510) {
	        	if(CarData[i][carBattery] > 0.001) {
					CarData[i][carBattery] -= 0.001;
				}
			}
	    }
	    if(CarData[i][carBattery] < 0.0) { CarData[i][carBattery] = 0.0; }
	    if(CarData[i][carEngine] < 0.0) { CarData[i][carEngine] = 0.0; }

	    if(CarData[i][carParkTime] != -1 && IsValidVehicle(CarData[i][carVehicle]) && CarData[i][carFaction] == 0 && CarData[i][carJob] == 0 && CarData[i][carOwner] != 0)
			Car_Park(i);

	    if(IsValidVehicle(CarData[i][carVehicle]) && CarData[i][carRentTime] != 0 && CarData[i][carRentPlayer] != -1) {
	        if(CarData[i][carRentTime] < gettime()) {
	        	CarData[i][carRentTime] = 0;
				foreach(new ix : Player) {
			    	if(pInfo[ix][pID] == CarData[i][carRentPlayer]) {
			        	SendErrorMessage(ix, "O aluguel do %s que você alugou expirou.", ReturnVehicleModelName(CarData[i][carModel]));
			    	}
				}

				CarData[i][carRentPlayer] = -1;
				CarData[i][carRentSpawnTime] = gettime()+600;
				SetEngineStatus(CarData[i][carVehicle], false);
  				SetLightStatus(CarData[i][carVehicle], false);

				static
	        		engine,
				    lights,
				    alarm,
		        	doors,
	    	    	bonnet,
			    	boot,
				    objective;

				GetVehicleParamsEx(CarData[i][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);

				CarData[i][carLocked] = false;
				SetVehicleParamsEx(CarData[i][carVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
			}
  		}

		if(IsValidVehicle(CarData[i][carVehicle]) && CarData[i][carRentSpawnTime] > 0 && CarData[i][carRentPlayer] == -1) {
			if(gettime() > CarData[i][carRentSpawnTime]) {
		    	if(!IsVehicleOccupied(CarData[i][carVehicle])) {
		        	RespawnVehicle(CarData[i][carVehicle]);
		        	CarData[i][carRentSpawnTime] = 0;

					static
	        			engine,
				        lights,
				        alarm,
		        		doors,
	    	    		bonnet,
			    	    boot,
				        objective;

				    GetVehicleParamsEx(CarData[i][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);

					CarData[i][carLocked] = false;
					SetVehicleParamsEx(CarData[i][carVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
          		}
			}
    	}
	}
	return true;
}
// DIALOGS

Dialog:Vehicles_List(playerid, response, listitem, inputtext[]) {
	if(response) {
		new id = CheckCountVehicle(playerid);

		if(id >= pInfo[playerid][pSpawnVehicle])
	  		return SendErrorMessage(playerid, "Você atingiu o limite de veiculos spawnados ao mesmo tempo. (Seu limite de spawn é %d veiculo(s))", pInfo[playerid][pSpawnVehicle]);

	    if (pInfo[playerid][pTimerSpawn] > 0)
			return va_SendClientMessage(playerid, COLOR_LIGHTRED, "Aguarde... faltam %d segundos para utilizar esse comando novamente.", pInfo[playerid][pTimerSpawn]);

	    new count = 0;

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) {
			if(CarData[i][carExists] && Car_IsOwner(playerid, i)) {
				if(count == listitem)
				{
					if(CarData[i][carVehicle]) {
						SendErrorMessage(playerid, "Este veiculo já está spawnado.");
						break;
					}

	  			  	if(CarData[i][carImpounded] != -1) {
	    				CarData[i][carParkTime] = -1;

						Car_Spawn(i);

						if(CarData[i][carHealth] == 0) {
						    CarData[i][carHealth] = 300;
						    CarData[i][carHealthUpdate] = 300;
						}
						if(CarData[i][carInsurance] >= 1) {
						    if(CarData[i][carHealth] == 0) {
						    	CarData[i][carHealth] = 1000;
						    	CarData[i][carHealthUpdate] = 1000;
						    }
			    		}

						/*if(IsValidDynamic3DTextLabel(vehicle3Dtexttrunk[CarData[i][carVehicle]]))
			 				DestroyDynamic3DTextLabel(vehicle3Dtexttrunk[CarData[i][carVehicle]]);*/

			    		CoreVehicles[CarData[i][carVehicle]][vehFuel] = CarData[i][carFuel];
						SetVehicleHealth(CarData[i][carVehicle], CarData[i][carHealth]);
						CarData[i][carHealthUpdate] = CarData[i][carHealth];
						va_SendClientMessage(playerid, COLOR_GREEN, "%s foi spawnado no local onde você estacionou:", ReturnVehicleModelName(CarData[i][carModel]));

						if(CarData[i][carModel] == 481 || CarData[i][carModel] == 509 || CarData[i][carModel] == 510)
							va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Engrenagem[%.2f], Milhas Rodadas[%.1f]", CarData[i][carEngine], CarData[i][carMiles]);
						else
							va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Motor[%.2f], Bateria[%.2f], Milhas Rodadas[%.1f]", CarData[i][carEngine], CarData[i][carBattery], CarData[i][carMiles]);

						if(CarData[i][carVW] == 0) {
							va_SendClientMessage(playerid, 0xFF00FFFF, "Info: Você pode usar a marca vermelha no mapa para achar seu veiculo.");
							SetPlayerCheckpoint(playerid, CarData[i][carPos][0], CarData[i][carPos][1], CarData[i][carPos][2], 3.0);
						}

		                pInfo[playerid][pSpawnVeh] = 1;
		                
						GetVehiclePos(CarData[i][carVehicle], CoreVehicles[CarData[i][carVehicle]][MilesPos][0], CoreVehicles[CarData[i][carVehicle]][MilesPos][1], CoreVehicles[CarData[i][carVehicle]][MilesPos][2]);
		                
						SetVehicleVelocity(CarData[i][carVehicle], 0, 0, 0);

						if (IsValidDynamicObject(CoreVehicles[CarData[i][carVehicle]][vehSirenObject])) {
							DestroyDynamicObject(CoreVehicles[CarData[i][carVehicle]][vehSirenObject]);
							CoreVehicles[CarData[i][carVehicle]][vehSirenObject] = -1;
						}

						pInfo[playerid][pTimerSpawn] = 5;
												
						/*for(new ix = 0; ix < MAX_CAR_STORAGE; ix++) {
						    CarStorage[i][ix][cItemExists] = false;
						    CarStorage[i][ix][cItemModel] = 0;
						    CarStorage[i][ix][cItemQuantity] = 0;
						    
						    new str[128];
						    format(str, sizeof(str), "");
						    strpack(CarStorage[i][ix][cItemName], str, 64 char);

					        CarStorage[i][ix][cItemID] = -1;
						}*/

						mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `ID` = '%d'", CarData[i][carID]);
						mysql_tquery(DBConn, query, "OnLoadVehWeapons", "d", i);
						break;
		    		} else {
		    			CarData[i][carParkTime] = -1;

						Car_Spawn(i);

						if(CarData[i][carHealth] == 0) {
						    CarData[i][carHealth] = 300;
						    CarData[i][carHealthUpdate] = 300;
						}
						if(CarData[i][carInsurance] >= 1) {
						    if(CarData[i][carHealth] == 0) {
						    	CarData[i][carHealth] = 1000;
						    	CarData[i][carHealthUpdate] = 1000;
						    }
			    		}

						/*if(IsValidDynamic3DTextLabel(vehicle3Dtexttrunk[CarData[i][carVehicle]]))
			 				DestroyDynamic3DTextLabel(vehicle3Dtexttrunk[CarData[i][carVehicle]]);*/

			    		CoreVehicles[CarData[i][carVehicle]][vehFuel] = CarData[i][carFuel];
						SetVehicleHealth(CarData[i][carVehicle], CarData[i][carHealth]);
						CarData[i][carHealthUpdate] = CarData[i][carHealth];
						va_SendClientMessage(playerid, COLOR_GREEN, "%s foi spawnado no local onde você estacionou:", ReturnVehicleModelName(CarData[i][carModel]));

						if(CarData[i][carModel] == 481 || CarData[i][carModel] == 509 || CarData[i][carModel] == 510)
							va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Engrenagem[%.2f], Milhas Rodadas[%.1f]", CarData[i][carEngine], CarData[i][carMiles]);
						else
							va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Motor[%.2f], Bateria[%.2f], Milhas Rodadas[%.1f]", CarData[i][carEngine], CarData[i][carBattery], CarData[i][carMiles]);

						if(CarData[i][carVW] == 0) {
							va_SendClientMessage(playerid, 0xFF00FFFF, "Info: Você pode usar a marca vermelha no mapa para achar seu veiculo.");
							SetPlayerCheckpoint(playerid, CarData[i][carPos][0], CarData[i][carPos][1], CarData[i][carPos][2], 3.0);
						}

		                pInfo[playerid][pSpawnVeh] = 1;
		                
						GetVehiclePos(CarData[i][carVehicle], CoreVehicles[CarData[i][carVehicle]][MilesPos][0], CoreVehicles[CarData[i][carVehicle]][MilesPos][1], CoreVehicles[CarData[i][carVehicle]][MilesPos][2]);
		                
						SetVehicleVelocity(CarData[i][carVehicle], 0, 0, 0);

						if (IsValidDynamicObject(CoreVehicles[CarData[i][carVehicle]][vehSirenObject])) {
							DestroyDynamicObject(CoreVehicles[CarData[i][carVehicle]][vehSirenObject]);
							CoreVehicles[CarData[i][carVehicle]][vehSirenObject] = -1;
						}

						pInfo[playerid][pTimerSpawn] = 5;
						
						/*for(new ix = 0; ix < MAX_CAR_STORAGE; ix++) {
						    CarStorage[i][ix][cItemExists] = false;
						    CarStorage[i][ix][cItemModel] = 0;
						    CarStorage[i][ix][cItemQuantity] = 0;
						    
						    new str[128];
						    format(str, sizeof(str), "");
						    strpack(CarStorage[i][ix][cItemName], str, 64 char);

					        CarStorage[i][ix][cItemID] = -1;
						}*/

						mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `vehicles_weapons` WHERE `ID` = '%d'", CarData[i][carID]);
						mysql_tquery(DBConn, query, "OnLoadVehWeapons", "d", i);
						break;
					}
				}
				else 
					count++;
			}
	  	}
	}
	return true;
}