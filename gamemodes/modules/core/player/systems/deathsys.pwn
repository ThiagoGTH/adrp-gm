/*
    Advanced Roleplay
    Death System
    Author: Thiago (https://github.com/ThiagoGTH)
    ----------------------------------------------
    Date: 28/06/2022
        
    Variables:
        pInfo[playerid][pInjured]
        pInfo[playerid][pBrutallyWounded]
        pInfo[playerid][pDead]
        pInfo[playerid][pDeadTime]

    Functions:
        SetBrutallyWounded(playerid);


*/

#include <YSI_Coding\y_hooks>

// DEFINES
#define BODY_PART_CHEST	        (3)
#define BODY_PART_GROIN         (4)
#define BODY_PART_LEFT_ARM      (5)
#define BODY_PART_RIGHT_ARM     (6)
#define BODY_PART_LEFT_LEG      (7)
#define BODY_PART_RIGHT_LEG     (8)
#define BODY_PART_HEAD          (9)

// VARIABLES
enum WeaponDamageInfo
{
	WeaponID,
	Float:WepDamage,
};

new WeaponDamage[][WeaponDamageInfo] =
{
	// WeaponID		WeaponDamage
	{0,				7.0},	//Unarmed
	{1,				15.0},	//Brass Knuckles
	{2,				15.0},	//Golf Club
	{3,				20.0},	//Nite Stick
	{4,				30.0},	//Knife
	{5,				10.0},	//Baseball Bat
	{6,				15.0},	//Shovel
	{7,				10.0},	//Pool Cue
	{8,				35.0},	//Katana
	{9,				0.0},	//Chainsaw
	{10,			1.0},	//Purple Dildo
	{12,			1.0},	//Large White Vibrator
	{11,			1.0},	//Small White Vibrator
	{13,			1.0},	//Silver Vibrator
	{14,			0.0},	//Flowers
	{15,			7.0},	//Cane
	{16,			0.0},	//Grenade
	{17,			0.0},	//Tear Gas
	{18,			10.0},	//Molotov Coctail
	{19,			0.0},	//Invalid Weapon
	{20,			0.0},	//Invalid Weapon
	{11,			0.0},	//Invalid Weapon
	{22,			20.0},	//Colt 9mm
	{23,			19.0},	//Silenced Colt 9mm
	{24,			45.0},	//Desert Eagle
	{25,			40.0},	//Shotgun
	{26,			65.0},	//Sawn-off Shotgun
	{27,			50.0},	//Combat Shotgun
	{28,			15.0},	//Micro SMG
	{29,			14.0},	//MP5
	{30,			28.0},	//AK-47
	{31,			25.0},	//M4
	{32,			15.0},	//Tec9
	{33,			85.0},	//Country Rifle
	{34,			500.0},	//Sniper Rifle
	{35,			0.0},	//Rocket Launcher
	{36,			0.0},	//HS Rocket Launcher
	{37,			0.0},	//Flamethrower
	{38,			0.0},	//Minigun
	{39,			0.0},	//Satchel Charge
	{40,			2.0},	//Satchel Detonator
	{41,			0.0},	//Spraycan
	{42,			0.0},	//Fire Extinguisher
	{43,			0.0},	//Camera
	{44,			0.0},	//Nightvision Goggles
	{45,			0.0},	//Thermal Goggles
	{46,			0.0},	//Thermal Goggles
	{47,			0.0},	//Fake Pistol
	{48,			0.0},	//Invalid Weapon
	{49,			15.0},	//Vehicle
	{50,			0.0},	//Heli-Blades
	{51,			100.0},	//Explosion 
	{52,			0.0},	//Invalid Weapon
	{53,			5.0},	//Drowned
	{54,			0.0}	//Splat
};

// FUNCTIONS

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart){
    if(pInfo[playerid][pDead] || pInfo[playerid][pBrutallyWounded]) return false;

    if(issuerid != INVALID_PLAYER_ID){
        /* -> Ainda não fiz esses sistemas, apenas um esboço para lembrar. 
        if(pInfo[issuerid][pTaser] || if(pInfo[issuerid][pBeanbag])){
            if(pInfo[issuerid][pTaser]) return taserEffect(playerid);
            if(pInfo[issuerid][pBeanbag]) return beanbagEffect(playerid);
            return false;
        }*/

        new Float:health, Float:armour;
        amount = WeaponDamage[weaponid][WepDamage];
        health = pInfo[playerid][pHealth];
        armour = pInfo[playerid][pArmour];

        new bool:armourhit = false; 
        switch(bodypart){
            case BODY_PART_CHEST, BODY_PART_GROIN: armourhit = true;

            case BODY_PART_LEFT_ARM, BODY_PART_RIGHT_ARM:
            {
                new chance = random(5); 
                if(chance == 1) armourhit = true;
            }

            case BODY_PART_LEFT_LEG, BODY_PART_RIGHT_LEG:
            {
                amount = amount/2;
                new chance = random(3);
                if(chance){
                    pInfo[playerid][pLimping] = true;
                    pInfo[playerid][pLimpingTime] = gettime() + 320;
                    SendClientMessage(playerid, COLOR_LIGHTRED, "-> Você foi atingido na perna, agora você sofrerá para correr ou pular.");
                }
            }

            case BODY_PART_HEAD:
            {
                if(pInfo[playerid][pSwat]) amount = amount/2;
                else amount += amount/2;
            }
        }
        if(pInfo[playerid][pSwat] && bodypart != BODY_PART_HEAD) armourhit = true;
        if(pInfo[playerid][pInjured] || pInfo[playerid][pPassedOut]){
            if(!pInfo[playerid][pDead]){
                TogglePlayerControllable(playerid, false);
                pInfo[playerid][pPassedOut] = false;
                
                SetPlayerChatBubble(playerid, "(( ESTE JOGADOR ESTÁ MORTO ))", COLOR_LIGHTRED, 15.0, 120*1000);
                SendClientMessage(playerid, COLOR_YELLOW, "-> Agora você está morto. Você precisa respawnar 120 segundos para utilizar o comando /respawnar.");
                pInfo[playerid][pAllowRespawn] = gettime()+120;
                pInfo[playerid][pDead] = 1;

                if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0);
                else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
            }
        } else {
            if(armour > 0.0 && armourhit){
                armour -= amount;
                if(armour < 0.0){
                    SetPlayerArmour(playerid, 0.0);
                    pInfo[playerid][pArmour] = 0.0;

                    health += armour;
                } else SetPlayerArmour(playerid, armour);
            } else {
                health -= amount;
            }
            if(health > 10 && health < 30){
                SetPlayerWeaponSkill(playerid, MEDIUM_SKILL);
                SendClientMessage(playerid, COLOR_LIGHTRED, "-> Vida baixa, suas skills de tiros estão no médio.");
            }
            if(health < 10){
                SetPlayerWeaponSkill(playerid, MINIMUM_SKILL);
                SendClientMessage(playerid, COLOR_LIGHTRED, "-> Vida crítica, suas skills de tiros estão no mínimo.");
            }
            if(health < 1){
                pInfo[playerid][pDeadTime] = 120;
                pInfo[playerid][pInjured] = 1;
                pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
                pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
                GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
                GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);

                if(IsPlayerInAnyVehicle(playerid))
				{
				    TogglePlayerControllable(playerid, false);
					//MakePlayerSuffer(playerid);
				}
                else SetPlayerSpawn(playerid);

                SetPlayerHealthEx(playerid, 25);
                
                format(logString, sizeof(logString), "%s (%s) [%s] matou %s com %s.", pNome(issuerid), GetPlayerUserEx(issuerid), GetPlayerIP(issuerid), pNome(playerid), ReturnWeaponName(weaponid));
                logCreate(playerid, logString, 6);
            } else SetPlayerHealthEx(playerid, health);
        }
    }
    else pInfo[playerid][pHealth] -= amount;
    return true;
}

hook OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart){
    if(pInfo[playerid][pDead]) return false;

    if(weaponid == 0){
        if(pInfo[playerid][pTackleMode]){
            if(pInfo[playerid][pTackleTimer] < gettime()){
                new chance = random(2);
                switch(chance){
                    case 0: // falha
                    {
                        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s falhou em tentar derrubar %s.", pNome(playerid), pNome(damagedid));

                        ApplyAnimation(playerid,"ped","EV_dive",4.0,0,1,1,0,0);

                        pInfo[playerid][pTackleTimer] = gettime() + 10;

                        format(logString, sizeof(logString), "%s (%s) falhou em derrubar %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(damagedid));
	                    logCreate(playerid, logString, 7);
                    }
                    case 1: // sucesso
                    {
                        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s derrubou %s no chão.", pNome(playerid), pNome(damagedid));
                        
                        ApplyAnimation(playerid, "PED", "FLOOR_hit_f", 4.0, 0, 1, 1, 1, 0, 1);
                        ApplyAnimation(damagedid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
                        ApplyAnimation(damagedid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);

                        pInfo[playerid][pTackleTimer] = gettime() + 10;

                        format(logString, sizeof(logString), "%s (%s) derrubou %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(damagedid));
	                    logCreate(playerid, logString, 7);
                    }
                }
            }
        }
    }
    if(playerid != INVALID_PLAYER_ID && damagedid != INVALID_PLAYER_ID){
        OnPlayerTakeDamage(damagedid, playerid, amount, weaponid, bodypart);
    }

    format(pInfo[damagedid][pLastShot], 64, "%s", pNome(playerid));
	pInfo[damagedid][pShotTime] = gettime();
    return true;
}

hook OnPlayerDeath(playerid, killerid, reason){
    if(!pInfo[playerid][pInjured]){
        pInfo[playerid][pDeadTime] = 120;
        pInfo[playerid][pInjured] = 1;
        pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
        pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
        GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
        GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
    } else {
        pInfo[playerid][pPassedOut] = false;
        TogglePlayerControllable(playerid, false);

        va_SendClientMessage(playerid, COLOR_YELLOW, "-> Você está morto agora. Será necessário esperar 60 segundos até poder utilizar o comando /respawnar.");

        SetPlayerChatBubble(playerid, "(( ESTE JOGADOR ESTÁ MORTO ))", COLOR_LIGHTRED, 15.0, 60*1000);

        pInfo[playerid][pDead] = 1;
        pInfo[playerid][pDeadTime] = 60;

        if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0, 1);
		else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
    }
    return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    if(pInfo[playerid][pLimping] && pInfo[playerid][pLimping] < gettime()){
	    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
			if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP)){
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
			}
		}
	 	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
			if(newkeys & KEY_SPRINT && !(oldkeys & KEY_SPRINT)){
				ApplyAnimation(playerid, "ped", "FALL_collapse", 4.1, 0, 1, 1, 0, 0);
				ApplyAnimation(playerid, "ped", "FALL_collapse", 4.1, 0, 1, 1, 0, 0);
			}
		}
	}
    return true;
}

forward SetPlayerSpawn(playerid);
public SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid)){
		if(pInfo[playerid][pInjured]){
			SetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
			SetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
			SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
			SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
			if(pInfo[playerid][pHealth]) SetPlayerHealthEx(playerid, pInfo[playerid][pHealth]);
			if(pInfo[playerid][pArmour]) SetPlayerArmour(playerid, pInfo[playerid][pArmour]);

			
            SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ], pInfo[playerid][pPositionA], -1, -1, -1, -1, -1, -1);
            SpawnPlayer(playerid);
            SetWeapons(playerid);
			//pInfo[playerid][pTimeout] = 0;
		}
		/*if(!deathmode[playerid] && pInfo[playerid][pInjured])
		{
			MakePlayerSuffer(playerid);
		}*/
	}else{
      	SetWeapons(playerid);
      	SetPlayerHealthEx(playerid, pInfo[playerid][pHealth]);
      	SetPlayerArmour(playerid, pInfo[playerid][pArmour]);
        SetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
		SetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
		SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
		SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
      	SetCameraBehindPlayer(playerid);
	}
    return true;
}


/*SetBrutallyWounded(playerid){


    ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);
    return true;
}*/

// COMMANDS
CMD:aceitarmorte(playerid, params[]){
    if (!pInfo[playerid][pInjured]) return SendErrorMessage(playerid, "Você não está ferido.");
    if (pInfo[playerid][pDead]) return SendErrorMessage(playerid, "Você já está morto.");

    va_SendClientMessage(playerid, COLOR_YELLOW, "-> Você está morto agora. Será necessário esperar 60 segundos até poder utilizar o comando /respawnar.");

    SetPlayerChatBubble(playerid, "(( ESTE JOGADOR ESTÁ MORTO ))", COLOR_LIGHTRED, 15.0, 60*1000);

    pInfo[playerid][pDead] = 1;
    pInfo[playerid][pDeadTime] = gettime() + 60;
    format(logString, sizeof(logString), "%s (%s) [%s] aceitou a morte.", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid));
    logCreate(playerid, logString, 6);
    return true;
}

CMD:investida(playerid, params[]){
	if (!pInfo[playerid][pTackleMode]){
		va_SendClientMessage(playerid, -1, "SERVER: Você ativou o modo investida. A partir de agora se você socar alguém, haverá chances de derruba-lo.");
		va_SendClientMessage(playerid, -1, "SERVER: Se o jogador for derrubado e não interpretar corretamente, utilize o /report.");
		pInfo[playerid][pTackleMode] = true;
	}else{
		va_SendClientMessage(playerid, -1, "SERVER: Você desativou o modo investida.");
		pInfo[playerid][pTackleMode] = false;
	}
	return true;
}

// ADMIN COMMANDS
CMD:ultimoatirador(playerid, params[]){
	if (!pInfo[playerid][pLogged]) return true;
  	if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
    static userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/ultimoatirador [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
	if (isnull(pInfo[userid][pLastShot])) return SendErrorMessage(playerid, "Este jogador não levou nenhum tiro desde que em logou no servidor.");

	SendServerMessage(playerid, "%s foi atingido pela última vez por %s (%s).", pNome(userid), pInfo[userid][pLastShot], GetDuration(gettime() - pInfo[userid][pShotTime]));
    
    format(logString, sizeof(logString), "%s (%s) checou o último atirador de %s [foi: %s (%s)].", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), pInfo[userid][pLastShot], GetDuration(gettime() - pInfo[userid][pShotTime]));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:reviver(playerid, params[]){
    if (!pInfo[playerid][pLogged]) return true;
  	if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
    static userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/reviver [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if (!pInfo[userid][pDead] || !pInfo[userid][pInjured]) return SendErrorMessage(playerid, "Você não pode reviver um jogador que não está ferido/morto.");

    pInfo[userid][pDead] = 0;
    pInfo[userid][pInjured] = 0;
    pInfo[userid][pDeadTime] = 0;
    pInfo[playerid][pLimping] = false;
    pInfo[playerid][pLimpingTime] = 0;
    SetCameraBehindPlayer(userid);
    TogglePlayerControllable(userid, true);
    SetPlayerChatBubble(userid, " ", COLOR_LIGHTRED, 15.0, 1);
    ApplyAnimation(userid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);

    SendServerMessage(playerid, "Você reviveu %s.", pNome(userid));
    SendServerMessage(userid, "%s reviveu o seu personagem.", pNome(playerid));

    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s reviveu %s.", pNome(playerid), pNome(userid));
    format(logString, sizeof(logString), "%s (%s) reviveu %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
    return true;
}