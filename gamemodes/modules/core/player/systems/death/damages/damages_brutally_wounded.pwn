#include <YSI_Coding\y_hooks>

hook OnGameModeInit(){
    SetTimer("DeathTimer", 1000, true);
    return true;
}

public OnPlayerDeath(playerid, killerid, reason) {
	GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
	GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
	
	if (uInfo[playerid][uJailed] > 0) {
		SetPlayerPos(playerid, 197.6346, 175.3765, 1003.0234);
        SetPlayerInterior(playerid, 3);
        SetPlayerVirtualWorld(playerid, (playerid + 100));
        SetPlayerFacingAngle(playerid, 0.0);
        SetCameraBehindPlayer(playerid);

        SetPlayerHealthEx(playerid, pInfo[playerid][pHealthMax]);
	}

	if (killerid != INVALID_PLAYER_ID) {
		if (reason == 50 && killerid != INVALID_PLAYER_ID)
		    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s matou %s com heli-kill.", pNome(killerid), pNome(playerid));

        if (reason == 29 && killerid != INVALID_PLAYER_ID && GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
		    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s matou %s com driver-by shooting.", pNome(killerid), pNome(playerid));

		OnPlayerGetBrutallyWounded(playerid, killerid, reason);
	}
	return true;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart){
	if(pInfo[damagedid][pDead]) return false;
	if(uInfo[damagedid][uJailed] > 0) return false;
	if(pInfo[playerid][pESC] > 0) return false;

	if(weaponid == 0) {
		if(pInfo[damagedid][pBrutallyWounded] && pInfo[damagedid][pDead]) return false;
	}

    if(weaponid == 0 && pInfo[playerid][pTackleMode]) {
        if(pInfo[playerid][pTackleTimer] < gettime()){
            new chance = random(2);
            switch(chance){
                case 0: {
                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s falhou em tentar derrubar %s.", pNome(playerid), pNome(damagedid));

                    ApplyAnimation(playerid,"ped", "EV_dive", 4.0, false, true, true, false, 0);
                    pInfo[playerid][pTackleTimer] = gettime() + 10;

                    format(logString, sizeof(logString), "%s (%s) falhou em derrubar %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(damagedid));
	                logCreate(playerid, logString, 7);
                }
                case 1: {
                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s derrubou %s no chão.", pNome(playerid), pNome(damagedid));
                        
                    ApplyAnimation(playerid, "PED", "FLOOR_hit_f", 4.0, false, true, true, true, 0);
                    ApplyAnimation(damagedid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 0);
                    ApplyAnimation(damagedid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 0);

                    pInfo[playerid][pTackleTimer] = gettime() + 10;

                    format(logString, sizeof(logString), "%s (%s) derrubou %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(damagedid));
	                logCreate(playerid, logString, 7);
                }
            }
        } 
    }

    new Float:health, Float:armour;
    amount = GetWeaponDamageVal(weaponid);
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);

    health = pInfo[damagedid][pHealth];
    armour = pInfo[damagedid][pArmour];

    format(pInfo[damagedid][pLastShot], 64, "%s", pNome(playerid));
	pInfo[damagedid][pShotTime] = gettime();

	new bool:armourhit = false; 
	switch(bodypart) {
		case BODY_PART_CHEST, BODY_PART_GROIN: armourhit = true;

		case BODY_PART_LEFT_ARM, BODY_PART_RIGHT_ARM: {
			amount = amount / 2;
			new chance = random(3);
			if(chance == 1) armourhit = true;
		}

		case BODY_PART_LEFT_LEG, BODY_PART_RIGHT_LEG: {
			amount = amount / 3;

			new chance = random(2);
			if(chance){
				pInfo[damagedid][pLimping] = true;
                pInfo[damagedid][pLimpingTime] = 320;
			}
		}

		case BODY_PART_HEAD: {
			if(pInfo[damagedid][pSwat]) amount = amount/4;
		}
	}
	if(armour > 0.0 && armourhit) {
        armour -= amount;
        if(armour <= 0.0){
         	SetPlayerArmour(damagedid, 0.0);
            pInfo[damagedid][pArmour] = 0.0;
        } else SetPlayerArmour(damagedid, armour);
    } else health -= amount;
	CallbackDamages(damagedid, playerid, bodypart, weaponid, amount);

	SetPlayerHealthEx(damagedid, health);
	if(health > 10.00 && health < 30.00){
		if(!pInfo[damagedid][pBrutallyWounded] && !pInfo[damagedid][pDead]){
			SetPlayerWeaponSkill(damagedid, MEDIUM_SKILL);
		}
    }
    if(health < 10.00){
		if(!pInfo[damagedid][pBrutallyWounded] && !pInfo[damagedid][pDead]){
			SetPlayerWeaponSkill(damagedid, MINIMUM_SKILL);
		}
    }
	if(health < 1.00) {
		if(!pInfo[damagedid][pBrutallyWounded] && !pInfo[damagedid][pDead]){ // BRUTALMENTE FERIDO 
			OnPlayerGetBrutallyWounded(damagedid, playerid, weaponid);
		} else if(pInfo[damagedid][pBrutallyWounded]) { // MORTO 
			OnPlayerGetDeath(damagedid, playerid, weaponid);
		}
		return true;
	}

    return true;
}

OnPlayerGetBrutallyWounded(playerid, issuerid, weaponid) {
	if(RegenTimer[playerid] != -1) {
	    KillTimer(RegenTimer[playerid]);
	    RegenTimer[playerid] = -1;
	}
    pInfo[playerid][pBrutallyWounded] = true;
	pInfo[playerid][pDeadTime] = 240;
	pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
	pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
	GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
	GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);

	SetPlayerHealthEx(playerid, 25.0);
	pInfo[playerid][pHealth] = 25.0;

	SendClientMessage(playerid, COLOR_LIGHTRED, "Você está brutalmente ferido, agora se um médico ou alguém não lhe ajudar, você irá morrer.");
	SendClientMessage(playerid, COLOR_LIGHTRED, "Para aceitar a morte digite /aceitarmorte.");

	new textstring[512];
	if (!IsValidDynamic3DTextLabel(pInfo[playerid][pBrutallyTag])) {
		if(pInfo[playerid][pTotalDamages] == 1)
			format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vez,\n /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);
		else
			format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vezes,\n /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);

		pInfo[playerid][pBrutallyTag] = CreateDynamic3DTextLabel(textstring, COLOR_LIGHTRED, 0.0, 0.0, 0.4, 8.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1);
    } else {
	    if(pInfo[playerid][pTotalDamages] == 1)
			format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vez,\n /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);
		else 
			format(textstring, sizeof(textstring), "(( Este jogador foi ferido %d vezes,\n /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);

		UpdateDynamic3DTextLabelText(pInfo[playerid][pBrutallyTag], COLOR_LIGHTRED, textstring);
    }

	if(IsPlayerInAnyVehicle(playerid)) {
		TogglePlayerControllable(playerid, false);
		ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, false, true, true, true, 0);
	} else {
		TogglePlayerControllable(playerid, true);
        //ApplyAnimationById(playerid, SWEET_LAFIN_SWEET, 4.1, false, true, true, true, 0);
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, false, true, true, true, 0);
	}

	if(issuerid != 999 && weaponid != 999){
		format(logString, sizeof(logString), "%s (%s) [%s] deixou %s brutalmente ferido com um(a) %s.", pNome(issuerid), GetPlayerUserEx(issuerid), GetPlayerIP(issuerid), pNome(playerid), ReturnWeaponName(weaponid));
		logCreate(playerid, logString, 6);
	} else {
		format(logString, sizeof(logString), "%s (%s) [%s] ficou com o status de brutalmente ferido.", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid));
		logCreate(playerid, logString, 6);
	}
    return true;
}

OnPlayerGetDeath(playerid, issuerid, weaponid) {
	PlayerDrugData[playerid][DrugsCooldown] = 0;
	if(EffectTimer[playerid] != -1) {
	    KillTimer(EffectTimer[playerid]);
	    EffectTimer[playerid] = -1;
	}

    pInfo[playerid][pBrutallyWounded] = false;
	pInfo[playerid][pDead] = true;
	pInfo[playerid][pDeadTime] = 60;
	if(weaponid != 999) format(pInfo[playerid][pDeadBy], 128, "Aparenta feridas de %s", ReturnWeaponName(weaponid));
	else format(pInfo[playerid][pDeadBy], 128, "Ferimentos desconhecidos");

	pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
	pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
	GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
	GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);

	SetPlayerHealthEx(playerid, 25.0);
	pInfo[playerid][pHealth] = 25.0;

	TogglePlayerControllable(playerid, false);

	SendClientMessage(playerid, COLOR_YELLOW, "-> Você está morto agora. Você precisa esperar 60 segundos para utilizar o comando /respawnar.");

	new countwep = 0;
    for (new i = 0; i < 12; i ++) if (pInfo[playerid][pGuns][i] != 0) {
        if(pInfo[playerid][pAmmo][i] > 0)
            countwep++;
    }

    if(countwep > 0) {
        SendServerMessage(playerid, "Por segurança, estas eram as armas de %s antes de morrer.", pNome(playerid));
        va_SendClientMessage(playerid, COLOR_LIGHTRED, "Armas:");
        for (new i = 0; i < 12; i ++) if (pInfo[playerid][pGuns][i] && pInfo[playerid][pAmmo][i] > 0) {
            va_SendClientMessage(playerid, -1, "%s (%d)", ReturnWeaponName(pInfo[playerid][pGuns][i]), pInfo[playerid][pAmmo][i]);
        }	
    } else SendServerMessage(playerid, "Você não possuia nenhuma arma quando morreu.");
	
	ResetWeapons(playerid);

	new textstring[512];
	if (!IsValidDynamic3DTextLabel(pInfo[playerid][pBrutallyTag])) {
		format(textstring, sizeof(textstring), "(( ESTE JOGADOR ESTÁ MORTO ))");
		pInfo[playerid][pBrutallyTag] = CreateDynamic3DTextLabel(textstring, COLOR_LIGHTRED, 0.0, 0.0, 0.4, 8.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1);
	} else {
		format(textstring, sizeof(textstring), "(( ESTE JOGADOR ESTÁ MORTO ))");
		UpdateDynamic3DTextLabelText(pInfo[playerid][pBrutallyTag], COLOR_LIGHTRED, textstring);
	}

	if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "PED", "CAR_dead_LHS", 4.1, false, true, true, true, 0);
	else ApplyAnimation(playerid, "PED", "FLOOR_hit_f", 25.0, false, true, true, true, 0);

	if(issuerid != 999 && weaponid != 999){
		format(logString, sizeof(logString), "%s (%s) [%s] deixou %s com o status de morto com um(a) %s.", pNome(issuerid), GetPlayerUserEx(issuerid), GetPlayerIP(issuerid), pNome(playerid), ReturnWeaponName(weaponid));
		logCreate(playerid, logString, 6);
	} else {
		format(logString, sizeof(logString), "%s (%s) [%s] aceitou a morte ou não resistiu aos ferimentos.", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid));
		logCreate(playerid, logString, 6);
	}

    return true;
}

forward DeathTimer(); public DeathTimer() {
    foreach (new i : Player){
        if(pInfo[i][pDeadTime] > 0){
            if(pInfo[i][pBrutallyWounded]) if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
            else {
                if(!pInfo[i][pDead] && pInfo[i][pBrutallyWounded]) {
                    if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
                
					if(pInfo[i][pDeadTime] == 180 && pInfo[i][pBrutallyWounded]) {
						va_SendClientMessage(i, COLOR_YELLOW, "-> Você já pode utilizar o /aceitarmorte.");
                    }

                    if(pInfo[i][pDeadTime] == 0 && pInfo[i][pBrutallyWounded]) {
						va_SendClientMessage(i, COLOR_YELLOW, "-> Você não resistiu aos ferimentos e ficou com o status de morto.");
                        OnPlayerGetDeath(i, 999, 999);
                    }
                }
            }
			else if(pInfo[i][pDead] && !pInfo[i][pBrutallyWounded]){
                if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
                if(pInfo[i][pDeadTime] == 0 && pInfo[i][pDead]) {
                    va_SendClientMessage(i, COLOR_YELLOW, "-> Você já pode usar /respawnar agora.");
                }
            }
        }
    }
    return true;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys){
	if(pInfo[playerid][pDead]) return false;

    if(pInfo[playerid][pLimping] && pInfo[playerid][pLimping] < gettime()){
	    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
			if(newkeys & KEY_JUMP) {
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.0, false, true, true, false, 0);
			}
		}
	 	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
			if(newkeys & KEY_SPRINT) {
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, false, false, false, false, 0);
				ClearAnimations(playerid);

				ApplyAnimation(playerid, "Ped", "FALL_collapse", 3.0, false, true, true, false, 0);
			}
		}
	}
    return true;
}

#if !defined PLAYER_STATE
	#define PLAYER_STATE: _:
#endif

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate) {
	if (newstate == PLAYER_STATE_WASTED) {
		if(!pInfo[playerid][pBrutallyWounded] && !pInfo[playerid][pDead]){ // BRUTALMENTE FERIDO 
			OnPlayerGetBrutallyWounded(playerid, 999, 999);
		} else if(pInfo[playerid][pBrutallyWounded]) { // MORTO 
			OnPlayerGetDeath(playerid, 999, 999);
		}
	}
	return true;
}

OnPlayerRevive(playerid){
	ClearDamages(playerid);
	pInfo[playerid][pDead] = 0;
    pInfo[playerid][pInjured] = 0;
    pInfo[playerid][pDeadTime] = -1;
	pInfo[playerid][pBrutallyWounded] = 0;
    pInfo[playerid][pPassedOut] = false;
    pInfo[playerid][pLimping] = false;
    pInfo[playerid][pLimpingTime] = 0;
	pInfo[playerid][pTotalDamages] = 0;
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	if (IsValidDynamic3DTextLabel(pInfo[playerid][pBrutallyTag])) {
		DestroyDynamic3DTextLabel(pInfo[playerid][pBrutallyTag]);
		pInfo[playerid][pBrutallyTag] = Text3D:INVALID_3DTEXT_ID;
	}
	SetPlayerHealthEx(playerid, pInfo[playerid][pHealthMax]);
	return true;
}

SendPlayerHospital(playerid){
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, 1177.3075, -1323.5679, 14.0642);
	SetPlayerFacingAngle(playerid, 268.3186);
	SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);

	return true;
}

/*static const Float:arrHospitalSpawns[6][4] = {
	{-2655.1240, 638.6232, 14.4531, 180.0000},
	{-318.8799, 1049.2433, 20.3403, 0.0000},
	{1607.4869, 1816.0693, 10.8203, 0.0000},
	{1173.0907, -1323.3217, 15.3965, 90.4037},
	{2034.0670, -1402.6815, 17.2938, 180.0000},
	{1241.6802, 326.4038, 19.7555, 335.0000}
};

GetClosestHospital(playerid) {
	new
	    Float:fDistance[2] = {99999.0, 0.0},
	    iIndex = -1
	;
	for (new i = 0; i < sizeof(arrHospitalSpawns); i ++)
	{
		fDistance[1] = GetPlayerDistanceFromPoint(playerid, arrHospitalSpawns[i][0], arrHospitalSpawns[i][1], arrHospitalSpawns[i][2]);

		if (fDistance[1] < fDistance[0])
		{
		    fDistance[0] = fDistance[1];
		    iIndex = i;
		}
	}
	return iIndex;
}*/