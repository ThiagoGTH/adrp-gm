#include <YSI_Coding\y_hooks>

CMD:ajuda(playerid, params[]) {
    
    SendClientMessage(playerid, CINZA, "[COMANDOS] /ajuda | /usuario | /personagens | /iniciarteste");

    return 1;
}

stock GetWeapon(playerid)
{
	new weaponid = GetPlayerWeapon(playerid);

	if (1 <= weaponid <= 46 && pInfo[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
		return weaponid;

	return 0;
}

GiveWeaponToPlayer(playerid, weaponid, ammo)
{
	if (weaponid < 0 || weaponid > 46)
	return 0;

	pInfo[playerid][pGuns][g_aWeaponSlots[weaponid]] = weaponid;
	pInfo[playerid][pAmmo][g_aWeaponSlots[weaponid]] += ammo;

	return GivePlayerWeapon(playerid, weaponid, ammo);
}

/*SetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) if (pInfo[playerid][pGuns][i] > 0 && pInfo[playerid][pAmmo][i] > 0) {
		GivePlayerWeapon(playerid, pInfo[playerid][pGuns][i], pInfo[playerid][pAmmo][i]);
	}
	return 1;
}*/

ResetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) {
		pInfo[playerid][pGuns][i] = 0;
		pInfo[playerid][pAmmo][i] = 0;
	}
	return 1;
}

/*esetWeapon(playerid, weaponid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++)
	{
		if (pInfo[playerid][pGuns][i] != weaponid) {
			GivePlayerWeapon(playerid, pInfo[playerid][pGuns][i], pInfo[playerid][pAmmo][i]);
		}
		else {
			pInfo[playerid][pGuns][i] = 0;
			pInfo[playerid][pAmmo][i] = 0;
		}
	}
	return 1;
}*/

stock IsPlayerSpawned(playerid)
{
	if (playerid < 0 || playerid >= MAX_PLAYERS)
		return 0;

	return (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING && GetPlayerState(playerid) != PLAYER_STATE_NONE && GetPlayerState(playerid) != PLAYER_STATE_WASTED);
}

stock PlayerHasWeapon(playerid, weaponid)
{
	new
		weapon,
		ammo;

	for (new i = 0; i < 13; i ++) if (pInfo[playerid][pGuns][i] == weaponid)
	{
		GetPlayerWeaponData(playerid, i, weapon, ammo);

		if (weapon == weaponid && ammo > 0) return 1;
	}
	return 0;
}

stock GetInitials(const string[])
{
	new
		ret[32],
		index = 0;

	for (new i = 0, l = strlen(string); i != l; i ++)
	{
		if (('A' <= string[i] <= 'Z') && (i == 0 || string[i - 1] == ' '))
			ret[index++] = string[i];
	}
	return ret;
}

stock ApplyAnimationEx(playerid, const animlib[], const animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);

	pInfo[playerid][pLoopAnim] = true;
	return 1;
}

stock PlayerHasTazer(playerid)
{
	return (GetPlayerWeapon(playerid) == 23 && pInfo[playerid][pTazer]);
}

stock PlayerHasBeanBag(playerid)
{
	return (GetPlayerWeapon(playerid) == 25 && pInfo[playerid][pBeanBag]);
}

/*IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
if (i == 0 && str[0] == '-')
	continue;

else if (str[i] < '0' || str[i] > '9')
	return 0;
	}
	return 1;
}*/

stock getVehicleName(vehicleid){
	new vehmodel = GetVehicleModel(vehicleid);
	new nameVeh[75];

	if (vehmodel < 400 || vehmodel > 611) {
		strcat(nameVeh, "Nenhum");
		return nameVeh;
	}
	strcat(nameVeh, VehicleNames[vehmodel - 400]);
	return nameVeh;
}

stock UpdateWeapons(playerid)
{
	for (new i = 0; i < 13; i ++) if (pInfo[playerid][pGuns][i])
	{
		if ((i == 2 && pInfo[playerid][pTazer]) || (i == 3 && pInfo[playerid][pBeanBag]))
		continue;

		GetPlayerWeaponData(playerid, i, pInfo[playerid][pGuns][i], pInfo[playerid][pAmmo][i]);

		if (pInfo[playerid][pGuns][i] != 0 && !pInfo[playerid][pAmmo][i]) {
			pInfo[playerid][pGuns][i] = 0;
		}
	}
	return 1;
}

GiveMoney(playerid, amount)
{
	pInfo[playerid][pMoney] += amount;
	GivePlayerMoney(playerid, amount);
	return 1;
}

/*GiveMaterial(playerid, amount)
{
	pInfo[playerid][pMaterial] += amount;
	return 1;
}

GetMaterial(playerid)
{
	return (pInfo[playerid][pMaterial]);
}

GetMoney(playerid)
{
	return (pInfo[playerid][pMoney]);
}*/

stock IsPlayerInWater(playerid)
{
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >=  1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return true;
	return false;
}


stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, time = 2000)
{
	if (pInfo[playerid][pFreeze])
	{
	    KillTimer(pInfo[playerid][pFreezeTimer]);

	    pInfo[playerid][pFreeze] = 0;
	    TogglePlayerControllable(playerid, 1);
	}
	SetPlayerPos(playerid, x, y, z + 0.5);
	TogglePlayerControllable(playerid, 0);

	pInfo[playerid][pFreeze] = 1;
	pInfo[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", time, false, "dfff", playerid, x, y, z);
	return 1;
}

forward SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z);
public SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z)
{
	if (!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
	    return 0;

	pInfo[playerid][pFreeze] = 0;

	SetPlayerPos(playerid, x, y, z);
	TogglePlayerControllable(playerid, 1);
	return 1;
}
