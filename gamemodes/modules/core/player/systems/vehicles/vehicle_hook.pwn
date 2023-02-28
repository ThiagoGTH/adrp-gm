hook OnPlayerWeaponShot(playerid, weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	if(hittype == BULLET_HIT_TYPE_VEHICLE) {
		new vehid = VehicleGetID(hitid);
		
		if(vehid != -1) {
			if(weaponid == 22 || weaponid == 23 || weaponid == 28 || weaponid == 32)//9mm
				vInfo[vehid][vDamage][1]++;
			else if(weaponid == 24)//.44
				vInfo[vehid][vDamage][2]++;
			else if(weaponid == 25 || weaponid == 26 || weaponid == 27)//12 Gauge
				vInfo[vehid][vDamage][3]++;
			else if(weaponid == 29)//9x19mm
				vInfo[vehid][vDamage][4]++;
			else if(weaponid == 30)//7.62mm
				vInfo[vehid][vDamage][5]++;
			else if(weaponid == 31)//5.56x45mm
				vInfo[vehid][vDamage][6]++;
			else if(weaponid == 33)//.40 LR
				vInfo[vehid][vDamage][7]++;
			else if(weaponid == 34)//.50 LR
				vInfo[vehid][vDamage][8]++;
		}
	}
	return true;
}