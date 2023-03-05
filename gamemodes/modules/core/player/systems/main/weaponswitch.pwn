#include <YSI_Coding\y_hooks>

// taken from weapon-config (https://github.com/oscar-broman/samp-weapon-config/blob/master/weapon-config.inc)

IsBulletWeapon(weaponid)
    return t_WEAPON:weaponid == t_WEAPON:WEAPON_COLT45 || (t_WEAPON:WEAPON_SHOTGUN <= t_WEAPON:weaponid <= t_WEAPON:WEAPON_SNIPER);

SetPlayerArmedWeaponEx(playerid, weaponid) {
	SetPVarInt(playerid, "switch_WeaponID", weaponid);
	PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
	return SetPlayerArmedWeapon(playerid, t_WEAPON:weaponid);
}

hook OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate) {
	if(newstate == PLAYER_STATE:3) {
	    new weapID = GetPlayerWeapon(playerid);
		SetPVarInt(playerid, "switch_WeaponID", weapID);
		if(IsBulletWeapon(weapID)) SendServerMessage(playerid, "Você pode trocar as armas na mão utilizando ~k~~CONVERSATION_YES~/~k~~CONVERSATION_NO~.");
	}

    if(oldstate == PLAYER_STATE:3)
		pInfo[playerid][pShootingDrive] = false;
	
    if (newstate == PLAYER_STATE:3) {
	    switch (GetPlayerWeapon(playerid)) {
	        case 22, 25..33:
	    		SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid));

			default: SetPlayerArmedWeapon(playerid, t_WEAPON:0);
		}
	}
	return true;
}

RemovePlayerFromDriveBy(playerid) {
	/*new Float:actuallyPos[3];
	new vehicleid = GetPlayerVehicleID(playerid);
	new seatid = GetPlayerVehicleSeat(playerid);

	GetPlayerPos(playerid, actuallyPos[0], actuallyPos[1], actuallyPos[2]);
	SetPlayerPos(playerid, actuallyPos[0], actuallyPos[1], floatadd(actuallyPos[2], 2.0));

	SetTimerEx("ReturnPlayerToVehicle", 250, false, "dddd", playerid, vehicleid, seatid, GetPlayerWeapon(playerid));*/

    new weaponid = GetPlayerWeapon(playerid);
    SetPlayerArmedWeapon(playerid, t_WEAPON:0);
    ApplyAnimationEx(playerid, "PED", "CAR_GETIN_RHS", 4.1, false, false, false, false, 1);
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, false, false, false, false, 0);
    SetTimerEx("returnDriveBy", 250, false, "dd", playerid, weaponid);
	return true;
}

forward returnDriveBy(playerid, weaponid);
public returnDriveBy(playerid, weaponid) {
    SetPlayerArmedWeapon(playerid, t_WEAPON:weaponid);
    pInfo[playerid][pShootingDrive] = false;
    return true;
}

forward ReturnPlayerToVehicle(playerid, vehicleid, seatid, weaponid);
public ReturnPlayerToVehicle(playerid, vehicleid, seatid, weaponid) {
	PutPlayerInVehicle(playerid, vehicleid, seatid);
	SetPlayerArmedWeaponEx(playerid, t_WEAPON:weaponid);
	return true;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {
    new PlayerState = GetPlayerState(playerid);

	if(PLAYER_STATE:PlayerState == PLAYER_STATE:3 && IsBulletWeapon(GetPVarInt(playerid, "switch_WeaponID"))) {
	    if(newkeys & KEY_YES) {
			new 
                t_WEAPON:curWeap = t_WEAPON:GetPVarInt(playerid, "switch_WeaponID"), 
                weapSlot = GetWeaponSlot(curWeap), 
                t_WEAPON:weapID, 
                weapAmmo;
			
			for(new i = weapSlot + 1; i <= 7; i++) {
				GetPlayerWeaponData(playerid, t_WEAPON_SLOT:i, t_WEAPON:weapID, weapAmmo);
				if(IsBulletWeapon(weapID) && weapID != t_WEAPON:curWeap) {
				 	SetPlayerArmedWeaponEx(playerid, weapID);
				 	GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Proxima Arma ~>~", 1000, 3);
				 	break;
				}
			}
		}

		if(newkeys & KEY_NO) {
			new 
                t_WEAPON:curWeap = t_WEAPON:GetPVarInt(playerid, "switch_WeaponID"), 
                weapSlot = GetWeaponSlot(curWeap), 
                t_WEAPON:weapID, 
                weapAmmo;
			
			for(new i = weapSlot - 1; i >= 2; i--) {
				GetPlayerWeaponData(playerid, t_WEAPON_SLOT:i, t_WEAPON:weapID, weapAmmo);
				if(IsBulletWeapon(weapID) && t_WEAPON:weapID != t_WEAPON:curWeap) {
					SetPlayerArmedWeaponEx(playerid, weapID);
					GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~~<~ Arma Anterior", 1000, 3);
					break;
				}
			}
		}
	}

    if(PLAYER_STATE:PlayerState == PLAYER_STATE:3 && newkeys == t_KEY:2) {
	    if(GetPlayerWeapon(playerid) == t_WEAPON:22 || GetPlayerWeapon(playerid) == t_WEAPON:25 || GetPlayerWeapon(playerid) == t_WEAPON:26 || GetPlayerWeapon(playerid) == t_WEAPON:27 || GetPlayerWeapon(playerid) == t_WEAPON:28 || GetPlayerWeapon(playerid) == t_WEAPON:29 || GetPlayerWeapon(playerid) == t_WEAPON:30 || GetPlayerWeapon(playerid) == t_WEAPON:31 || GetPlayerWeapon(playerid) == t_WEAPON:32 || GetPlayerWeapon(playerid) == t_WEAPON:33) {
		    if(pInfo[playerid][pShootingDrive])
	            RemovePlayerFromDriveBy(playerid);
			else {
		        SendServerMessage(playerid, "Você pode apertar 'H' novamente para voltar para dentro do veículo.");
		        pInfo[playerid][pShootingDrive] = true;
		    }
		}
	}

	return true;
}