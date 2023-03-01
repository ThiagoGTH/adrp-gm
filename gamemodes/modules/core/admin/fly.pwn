#include <YSI_Coding\y_hooks>

static bool:OnFly[MAX_PLAYERS];
forward bool:StartFly(playerid);
forward Fly(playerid);
forward bool:StopFly(playerid);

CMD:fly(playerid) {
    if(GetPlayerAdmin(playerid) < 1337) return SendPermissionMessage(playerid);
	if(IsPlayerInAnyVehicle(playerid))  return SendErrorMessage(playerid, "Você não pode utilizar esse comando estando dentro de um veículo.");
	
	if(pInfo[playerid][pFlying] == 0) {
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerHealth(playerid, 99999.0);
		SetPlayerAttachedObject(playerid, 8, 2992, 2, 0.306000, -0.012000, 0.009000, 0.000000, -95.299942, -1.399999, 1.000000, 1.000000, 1.000000);
		SetPlayerAttachedObject(playerid, 7, 2992, 2, 0.313000, -0.007000, 0.032999, -0.299999, 83.700019, 0.000000, 1.000000, 1.000000, 1.000000);
		SendServerMessage(playerid, "Digite /ajuda fly para aprender a voar.");
		StartFly(playerid);
		pInfo[playerid][pFlying] = 1;
	} else if (pInfo[playerid][pFlying] == 1) {
		RemovePlayerAttachedObject(playerid, 8);
		RemovePlayerAttachedObject(playerid, 7);
		SetPlayerHealth(playerid, 150.0);
		SendServerMessage(playerid, "Você saiu do modo de voo.");
		StopFly(playerid);
		pInfo[playerid][pFlying] = 0;
	}
	return true;
}

bool:StartFly(playerid) {
	if(OnFly[playerid])
        return false;
    OnFly[playerid] = true;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SetPlayerPos(playerid,x,y,z);
	ApplyAnimation(playerid, "PARACHUTE", "PARA_steerR", 6.1, true, true, true, true, 0);
	Fly(playerid);
	return true;
}

public Fly(playerid) {
	if(!IsPlayerConnected(playerid))
		return true;
	new KEY:k, KEY:ud, KEY:lr;
	GetPlayerKeys(playerid, k, ud, lr);
	new Float:v_x,Float:v_y,Float:v_z,
		Float:x,Float:y,Float:z;
	if(ud)	// forward
	{
		GetPlayerCameraFrontVector(playerid,x,y,z);
		v_x = x+0.1;
		v_y = y+0.1;
	}
	if(k & KEY_DOWN)	// down
		v_z = -0.2;
	else if(k & KEY_FIRE)	// up
		v_z = 0.2;
	if(k & KEY_WALK)	// slow
	{
		v_x /=5.0;
		v_y /=5.0;
		v_z /=5.0;
	}
	if(k & KEY_SPRINT)	// fast
	{
		v_x *=4.0;
		v_y *=4.0;
		v_z *=4.0;
	}
	if(v_z == 0.0)
		v_z = 0.025;
	SetPlayerVelocity(playerid,v_x,v_y,v_z);
	if(v_x == 0 && v_y == 0) {
		if(GetPlayerAnimationIndex(playerid) == 959)
		ApplyAnimation(playerid,"PARACHUTE","PARA_steerR", 6.1, true, true, true, true, 0);
	} else {
		GetPlayerCameraFrontVector(playerid,v_x,v_y,v_z);
		GetPlayerCameraPos(playerid,x,y,z);
		SetPlayerLookAt(playerid,v_x*500.0+x,v_y*500.0+y);
		if(GetPlayerAnimationIndex(playerid) != 959)
		ApplyAnimation(playerid,"PARACHUTE", "FALL_SkyDive_Accel", 6.1, true, true, true, true, 0);
	} if(OnFly[playerid])
		SetTimerEx("Fly", 200, false, "i", playerid);
	return true;
}

bool:StopFly(playerid) {
	if(!OnFly[playerid])
        return false;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SetPlayerPos(playerid,x,y,z);
	OnFly[playerid] = false;
	return true;
}

hook OnPlayerDisconnect(playerid){
	OnFly[playerid] = false;
	return true;
}

SetPlayerLookAt(playerid, Float:X, Float:Y) { // credits to someone in samp forums I can not remember
	new Float:Px, Float:Py, Float: Pa;
	GetPlayerPos(playerid, Px, Py, Pa);
	Pa = floatabs(atan((Y-Py)/(X-Px)));
	if (X <= Px && Y >= Py) Pa = floatsub(180, Pa);
	else if (X < Px && Y < Py) Pa = floatadd(Pa, 180);
	else if (X >= Px && Y <= Py) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	SetPlayerFacingAngle(playerid, Pa);
}