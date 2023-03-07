hook OnPlayerWeaponShot(playerid, weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	if(hittype == BULLET_HIT_TYPE_VEHICLE) {
		new vehid = VehicleGetID(hitid);
		
		if(vehid != -1) {
			new Float:health, Float:amount;
			GetVehicleHealth(vehid, health);

			if(weaponid == 22 || weaponid == 23 || weaponid == 28 || weaponid == 32)//9mm 
				vInfo[vehid][vDamage][1]++, amount = 15.0;
			else if(weaponid == 24)//.44
				vInfo[vehid][vDamage][2]++, amount = 30.0;
			else if(weaponid == 25 || weaponid == 26 || weaponid == 27)//12 Gauge
				vInfo[vehid][vDamage][3]++, amount = 30.0;
			else if(weaponid == 29)//9x19mm
				vInfo[vehid][vDamage][4]++, amount = 15.0;
			else if(weaponid == 30)//7.62mm
				vInfo[vehid][vDamage][5]++, amount = 20.0;
			else if(weaponid == 31)//5.56x45mm
				vInfo[vehid][vDamage][6]++, amount = 20.0;
			else if(weaponid == 33)//.40 LR
				vInfo[vehid][vDamage][7]++, amount = 30.0;
			else if(weaponid == 34)//.50 LR
				vInfo[vehid][vDamage][8]++, amount = 100.0;

			SetVehicleHealth(vehid, health-amount);
		}
	}
	return true;
}