#include <YSI_Coding\y_hooks>

new iProjObject[MAX_PROJECTILES];

CMD:arremessar(playerid) {
	new Float:x, Float:y, Float:z, Float:ang;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, ang);

	new i = CreateProjectile(x, y - 0.5 * floatcos(-(ang + 90.0), degrees), z, 10.0 * floatsin(-ang, degrees), 10.0 * floatcos(-ang, degrees), 4.0, .spherecol_radius = 0.10, .gravity = 13.0);
	if (i == -1)
	    return 0;
	DestroyObject(iProjObject[i]);
	iProjObject[i] = CreateObject(348, x, y - 0.5 * floatcos(-(ang + 90.0), degrees), z, 93.7, 120.0, ang + 60.0);

	ApplyAnimation(playerid,"GRENADE","WEAPON_throwu",3.0,0,0,0,0,0);
	return true;
}

public OnProjectileUpdate(projid)
{
	new Float:x, Float:y, Float:z;
	GetProjectilePos(projid, x, y, z);
	SetObjectPos(iProjObject[projid], x, y, z);
	return true;
}

public OnProjectileStop(projid)
{
	DestroyObject(iProjObject[projid]);
	return true;
}