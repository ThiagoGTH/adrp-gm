CMD:danos(playerid, params[]) {
	new vehicleid = INVALID_VEHICLE_ID;

	if (sscanf(params, "d", vehicleid))  return SendSyntaxMessage(playerid, "/danos [ID do veículo]");
	if(!IsValidVehicle(vehicleid)) return SendErrorMessage(playerid, "Você especificou um veículo inválido.");

    new vehiclenear = false;
    new Float:fX, Float:fY, Float:fZ;

    for (new i = 0; i != MAX_VEHICLES+1; i ++) if (IsValidVehicle(vehicleid)) {
		GetVehiclePos(vehicleid, fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ)) {
		    vehiclenear = true;
		}
	}

	if(!vehiclenear)
		return SendErrorMessage(playerid, "Você está longe deste veiculo");

	new vehid = VehicleGetID(vehicleid);
	new string[512];

	//Perfurações balisticas no veículo:
	if(vInfo[vehid][vDamage][1] > 1)//9mm
		format(string, sizeof(string), "%s* %d perfurações de 9mm\n", string, vInfo[vehid][vDamage][1]);
	else if(vInfo[vehid][vDamage][1] == 1)//9mm
		format(string, sizeof(string), "%s* %d perfuração de 9mm\n", string, vInfo[vehid][vDamage][1]);

	if(vInfo[vehid][vDamage][2] > 1)//.44
		format(string, sizeof(string), "%s* %d perfurações de .44\n", string, vInfo[vehid][vDamage][2]);
	else if(vInfo[vehid][vDamage][2] == 1)//.44
		format(string, sizeof(string), "%s* %d perfuração de .44\n", string, vInfo[vehid][vDamage][2]);

	if(vInfo[vehid][vDamage][3] > 1)//12 Gauge
		format(string, sizeof(string), "%s* %d perfurações de 12 Gauge\n", string, vInfo[vehid][vDamage][3]);
	else if(vInfo[vehid][vDamage][3] == 1)//12 Gauge
		format(string, sizeof(string), "%s* %d perfuração de 12 Gauge\n", string, vInfo[vehid][vDamage][3]);

	if(vInfo[vehid][vDamage][4] > 1)//9x19mm
		format(string, sizeof(string), "%s* %d perfurações de 9x19mm\n", string, vInfo[vehid][vDamage][4]);
	else if(vInfo[vehid][vDamage][4] == 1)//9x19mm
		format(string, sizeof(string), "%s* %d perfuração de 9x19mm\n", string, vInfo[vehid][vDamage][4]);

	if(vInfo[vehid][vDamage][5] > 1)//7.62mm
		format(string, sizeof(string), "%s* %d perfurações de 7.62mm\n", string, vInfo[vehid][vDamage][5]);
	else if(vInfo[vehid][vDamage][5] == 1)//7.62mm
		format(string, sizeof(string), "%s* %d perfuração de 7.62mm\n", string, vInfo[vehid][vDamage][5]);

	if(vInfo[vehid][vDamage][6] > 1)//5.56x45mm
		format(string, sizeof(string), "%s* %d perfurações de 5.56x45mm\n", string, vInfo[vehid][vDamage][6]);
	else if(vInfo[vehid][vDamage][6] == 1)//5.56x45mm
		format(string, sizeof(string), "%s* %d perfuração de 5.56x45mm\n", string, vInfo[vehid][vDamage][6]);

	if(vInfo[vehid][vDamage][7] > 1)//.40 LR
		format(string, sizeof(string), "%s* %d perfurações de .40 LR\n", string, vInfo[vehid][vDamage][7]);
	else if(vInfo[vehid][vDamage][7] == 1)//.40 LR
		format(string, sizeof(string), "%s* %d perfuração de .40 LR\n", string, vInfo[vehid][vDamage][7]);

	if(vInfo[vehid][vDamage][8] > 1)//.50 LR
		format(string, sizeof(string), "%s* %d perfurações de .50 LR\n", string, vInfo[vehid][vDamage][8]);
	else if(vInfo[vehid][vDamage][8] == 1)//.50 LR
		format(string, sizeof(string), "%s* %d perfuração de .50 LR\n", string, vInfo[vehid][vDamage][8]);


	//Analisar peças fisicas danificadas do veículo:
	new count22;
	switch(vInfo[vehid][vModel])
	{
		case 401, 402, 403, 406, 408, 410, 411, 412, 414, 415, 417, 419, 422, 423, 424, 425, 429, 431, 433, 434, 436, 439, 442, 443, 451, 455, 456, 457, 467, 474, 475, 477, 478, 480, 483, 486, 489, 491, 494, 495, 496, 498, 499, 500, 502, 503, 504, 505, 506, 508, 514, 515, 517, 518, 524, 525, 526, 527, 528, 530, 531, 532, 533, 534, 535, 536, 539, 541, 542, 543, 544, 545, 550, 552, 554, 555, 558, 559, 562, 565, 568, 571, 572, 573, 574, 575, 576, 578, 587, 588, 589, 593, 599, 600, 601, 602, 603, 604, 605, 609:
		{
			count22++;
		}
	}

	new Bonnet, Boot, FrontLeft, FrontRight, RearLeft, RearRight, First, Second, Third, Fourth, FrontLeftTire, FrontRightTire, RearLeftTire, RearRightTire;
	new FrontLeft3, FrontRight3, RearLeft3, RearRight3, WindShield, FrontBumper, RearBumper;
	GetVehicleDoorsDamageStatus(vehicleid, Bonnet, Boot, FrontLeft, FrontRight, RearLeft, RearRight);
	GetVehicleLightsDamageStatus(vehicleid, First, Second, Third, Fourth);
	GetVehicleTiresDamageStatus(vehicleid, FrontLeftTire, FrontRightTire, RearLeftTire, RearRightTire);
	GetVehiclePanelsDamageStatus(vehicleid, FrontLeft3, FrontRight3, RearLeft3, RearRight3, WindShield, FrontBumper, RearBumper);

	if(Bonnet > 0)
		format(string, sizeof(string), "%s* Capô danificado\n", string);

	if(Boot > 0)
		format(string, sizeof(string), "%s* Porta-malas danificado\n", string);

	if(FrontBumper > 0)
		format(string, sizeof(string), "%s* Parachoque dianteiro danificado\n", string);

	if(RearBumper > 0)
		format(string, sizeof(string), "%s* Parachoque traseiro danificado\n", string);

	if(WindShield > 0)
		format(string, sizeof(string), "%s* Parabrisa danificado\n", string);

	if(FrontLeft > 0)
		format(string, sizeof(string), "%s* Porta dianteira esquerda danificado\n", string);

	if(FrontRight > 0)
		format(string, sizeof(string), "%s* Porta dianteira direita danificado\n", string);

	if(!count22) {
		if(RearLeft > 0)
			format(string, sizeof(string), "%s* Porta traseira esquerda danificado\n", string);

		if(RearRight > 0)
			format(string, sizeof(string), "%s* Porta traseira direita danificado\n", string);
	}

	if(First > 0 || Second > 0 || Third > 0 || Fourth > 0)
		format(string, sizeof(string), "%s* Farol danificado\n", string);

	if(FrontLeftTire > 0)
		format(string, sizeof(string), "%s* Pneu dianteiro esquerdo danificado\n", string);

	if(FrontRightTire > 0)
		format(string, sizeof(string), "%s* Pneu dianteiro direito danificado\n", string);

	if(RearLeftTire > 0)
		format(string, sizeof(string), "%s* Pneu traseiro esquerdo danificado\n", string);

	if(RearRightTire > 0)
		format(string, sizeof(string), "%s* Pneu traseiro direito danificado\n", string);

	if(isnull(string))
		return SendErrorMessage(playerid, "Este veículo não possui nenhum dano.");

	new string2[128];
	format(string2, sizeof(string2), "%s (%d)", ReturnVehicleModelName(vInfo[vehid][vModel]), vehicleid);
	Dialog_Show(playerid, CarInjuries, DIALOG_STYLE_LIST, string2, string, "FECHAR", "");
	return true;
}

GetVehiclePanelsDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight, &WindShield, &FrontBumper, &RearBumper) {
	new 
		Panels,
		Doors,
		Lights, 
		Tires;

	GetVehicleDamageStatus(vehicleid, t_VEHICLE_PANEL_STATUS:Panels, t_VEHICLE_DOOR_STATUS:Doors, t_VEHICLE_LIGHT_STATUS:Lights, t_VEHICLE_TYRE_STATUS:Tires);
	FrontLeft = Panels & 15;
	FrontRight = Panels >> 4 & 15;
	RearLeft = Panels >> 8 & 15;
	RearRight = Panels >> 12 & 15;
	WindShield = Panels >> 16 & 15;
	FrontBumper = Panels >> 20 & 15;
	RearBumper = Panels >> 24 & 15;
	return true;
}

GetVehicleDoorsDamageStatus(vehicleid, &Bonnet, &Boot, &FrontLeft, &FrontRight, &RearLeft, &RearRight) {
	new 
		Panels,
		Doors,
		Lights, 
		Tires;
        
	GetVehicleDamageStatus(vehicleid, t_VEHICLE_PANEL_STATUS:Panels, t_VEHICLE_DOOR_STATUS:Doors, t_VEHICLE_LIGHT_STATUS:Lights, t_VEHICLE_TYRE_STATUS:Tires);
	Bonnet = Doors & 7;
	Boot = Doors >> 8 & 7;
	FrontLeft = Doors >> 16 & 7;
	FrontRight = Doors >> 24 & 7;
	RearLeft = Doors >> 32 & 7;
	RearRight = Doors >> 40 & 7;
	return true;
}

GetVehicleLightsDamageStatus(vehicleid, &First, &Second, &Third, &Fourth) {
	new 
		Panels,
		Doors,
		Lights, 
		Tires;
        
	GetVehicleDamageStatus(vehicleid, t_VEHICLE_PANEL_STATUS:Panels, t_VEHICLE_DOOR_STATUS:Doors, t_VEHICLE_LIGHT_STATUS:Lights, t_VEHICLE_TYRE_STATUS:Tires);
	First = Lights & 1;
	Second = Lights >> 1 & 1;
	Third = Lights >> 2 & 1;
	Fourth = Lights >> 3 & 1;
	return true;
}

GetVehicleTiresDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight) {
	new 
		Panels,
		Doors,
		Lights, 
		Tires;
        
	GetVehicleDamageStatus(vehicleid, t_VEHICLE_PANEL_STATUS:Panels, t_VEHICLE_DOOR_STATUS:Doors, t_VEHICLE_LIGHT_STATUS:Lights, t_VEHICLE_TYRE_STATUS:Tires);
	RearRight = Tires & 1;
	FrontRight = Tires >> 1 & 1;
	RearLeft = Tires >> 2 & 1;
	FrontLeft = Tires >> 3 & 1;
	return true;
}