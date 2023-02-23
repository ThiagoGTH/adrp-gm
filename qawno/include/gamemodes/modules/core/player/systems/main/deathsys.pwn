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
#define MAX_PLAYER_DAMAGES      (100)
// VARIABLES

enum WeaponDamageInfo
{
	WeaponID,
	Float:WepDamage,
};

enum damageInfo
{
	eDamageTaken,
	eDamageTime,

	eDamageWeapon,

	eDamageBodypart,
	eDamageArmor,

	eDamageBy,
};

new DamageInfo[MAX_PLAYERS][MAX_PLAYER_DAMAGES][damageInfo];

new WeaponDamage[][WeaponDamageInfo] =
{
	// WeaponID		WeaponDamage
	{0,				3.0},	//Unarmed
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
    if(pInfo[playerid][pDead] || pInfo[issuerid][pInjured]) return false;

    if(issuerid != INVALID_PLAYER_ID){
        /* -> Ainda não fiz esses sistemas, apenas um esboço para lembrar. 
        if(pInfo[issuerid][pTaser] || if(pInfo[issuerid][pBeanbag])){
            if(pInfo[issuerid][pTaser]) return taserEffect(playerid);
            if(pInfo[issuerid][pBeanbag]) return beanbagEffect(playerid);
            return false;
        }*/

        new Float:health, Float:armour;
        amount = WeaponDamage[weaponid][WepDamage];
        pInfo[playerid][pLastBlow] = weaponid;
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
                new chance = random(2);
                if(chance){
                    pInfo[playerid][pLimping] = true;
                    pInfo[playerid][pLimpingTime] = gettime() + 320;
                    SendClientMessage(playerid, COLOR_LIGHTRED, "-> Você foi atingido na perna, agora você sofrerá para correr ou pular.");
                    SendClientMessageToAll(-1, "[1] PERNA MANCANDO");
                }
            }

            case BODY_PART_HEAD:
            {
                if(pInfo[playerid][pSwat]) amount = amount/2;
                else amount += amount/2;
                SendClientMessageToAll(-1, "[2] CABEÇA");
            }
        }
        if(pInfo[playerid][pSwat] && bodypart != BODY_PART_HEAD) armourhit = true;
        if(pInfo[playerid][pInjured] || pInfo[playerid][pPassedOut]){
            if(!pInfo[playerid][pDead]){
                TogglePlayerControllable(playerid, false);
                pInfo[playerid][pPassedOut] = false;
                pInfo[playerid][pInjured] = false;
                
                SetPlayerChatBubble(playerid, "(( ESTE JOGADOR ESTÁ MORTO ))", COLOR_LIGHTRED, 15.0, 120*1000);
                va_SendClientMessage(playerid, COLOR_YELLOW, "-> Você está morto agora. Será necessário esperar 60 segundos até poder utilizar o comando /respawnar.");
                pInfo[playerid][pAllowRespawn] = gettime()+60;
                pInfo[playerid][pDead] = 1;
                SendClientMessageToAll(-1, "[3] MORTO -> pDead = 1");
                if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0);
                else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, false, false, false, true, 0);
            }
        } else {
            if(armour > 0.0 && armourhit){
                armour -= amount;
                if(armour < 0.0){
                    SetPlayerArmour(playerid, 0.0);
                    pInfo[playerid][pArmour] = 0.0;

                    health += armour;
                } else SetPlayerArmour(playerid, armour);
            } else health -= amount;
            
            CallbackDamages(playerid, issuerid, bodypart, weaponid, amount);

            if(health > 10 && health < 30){
                SetPlayerWeaponSkill(playerid, MEDIUM_SKILL);
                SendClientMessage(playerid, COLOR_LIGHTRED, "-> Vida baixa, suas skills de tiros estão no médio.");
                SendClientMessageToAll(-1, "[4] VIDA BAIXA -> skill média");
            }
            if(health < 10){
                SetPlayerWeaponSkill(playerid, MINIMUM_SKILL);
                SendClientMessage(playerid, COLOR_LIGHTRED, "-> Vida crítica, suas skills de tiros estão no mínimo.");
                SendClientMessageToAll(-1, "[5] VIDA BAIXA -> skill mínima");
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
					MakePlayerSuffer(playerid);
                    SendClientMessageToAll(-1, "[6] MAKEPLAYERSUFFER -> VEICULO");
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
        TogglePlayerControllable(playerid, false);
        pInfo[playerid][pInjured] = true;

        if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0);
        else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, false, false, false, true, 0);

        pInfo[playerid][pDeadTime] = 120;
        pInfo[playerid][pInjured] = 1;
        pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
        pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
        GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
        GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
        SendClientMessageToAll(-1, "[8] FERIDO");
    } else {
        pInfo[playerid][pPassedOut] = false;
        TogglePlayerControllable(playerid, false);

        va_SendClientMessage(playerid, COLOR_YELLOW, "-> Você está morto agora. Será necessário esperar 60 segundos até poder utilizar o comando /respawnar.");
        SetPlayerChatBubble(playerid, "(( ESTE JOGADOR ESTÁ MORTO ))", COLOR_LIGHTRED, 15.0, 60*1000);

        SendClientMessageToAll(-1, "[7] MORREU");

        pInfo[playerid][pDead] = 1;
        pInfo[playerid][pDeadTime] = 60;

        if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0, 1);
		else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, false, false, false, true, 0);
    }
    return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    if(pInfo[playerid][pDead]) return false;

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

hook OnGameModeInit(){
    SetTimer("DeathTimer", 1000, true);
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

			
            SetSpawnInfo(playerid, false, pInfo[playerid][pSkin], pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ], pInfo[playerid][pPositionA], -1, -1, -1, -1, -1, -1);
            SpawnPlayer(playerid);
            SetWeapons(playerid);
            SendClientMessageToAll(-1, "[9] SET SPAWN");
			//pInfo[playerid][pTimeout] = 0;
		}
		if(!pInfo[playerid][pDead] && pInfo[playerid][pInjured]) MakePlayerSuffer(playerid);

	}else{
      	SetWeapons(playerid);
      	SetPlayerHealthEx(playerid, pInfo[playerid][pHealth]);
      	SetPlayerArmour(playerid, pInfo[playerid][pArmour]);
        SetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
		SetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);
		SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
		SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
      	SetCameraBehindPlayer(playerid);

        SendClientMessageToAll(-1, "[10] SET SPAWN");
	}
    return true;
}

forward DeathTimer();
public DeathTimer(){
    foreach (new i : Player){
        if(pInfo[i][pDeadTime] > 0){
            if(pInfo[i][pPassedOut] == true) if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
            else {
                if(!pInfo[i][pDead] && pInfo[i][pInjured]){
                    if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
                
                    if(pInfo[i][pDeadTime] <= 0 && pInfo[i][pInjured] == 1){
                        pInfo[i][pPassedOut] = false;
                        TogglePlayerControllable(i, false);

                        va_SendClientMessage(i, COLOR_YELLOW, "-> Você está morto agora. Será necessário esperar 60 segundos até poder utilizar o comando /respawnar.");

                        SetPlayerChatBubble(i, "(( ESTE JOGADOR ESTÁ MORTO ))", COLOR_LIGHTRED, 15.0, 60*1000);
                        SendClientMessageToAll(-1, "[11] MORTO TIMER");

                        pInfo[i][pDead] = 1;
                        pInfo[i][pDeadTime] = 60;

                        if(IsPlayerInAnyVehicle(i)) ApplyAnimation(i, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0, 1);
                        else ApplyAnimation(i, "WUZI", "CS_Dead_Guy", 4.1, false, false, false, true, 0);
                    }
                    else if(pInfo[i][pDead]){
                        if(pInfo[i][pDeadTime] > 0) pInfo[i][pDeadTime]--;
                        if(pInfo[i][pDeadTime] <= 0 && pInfo[i][pInjured]){
                            va_SendClientMessage(i, COLOR_YELLOW, "-> Você já pode usar /respawnar agora.");
                            SendClientMessageToAll(-1, "[12] MORTO TIMER -> Allow respawn");
                        }
                    }
                }
            }
        }
    }
    return true;
}

MakePlayerSuffer(playerid){
    new reason = pInfo[playerid][pLastBlow];
    if(!IsPlayerInAnyVehicle(playerid)){
        if(!IsActualGun(reason) && !IsLethalMeele(reason)){
            new count,
                lethal_wounds;

            for (new i = 99; i > 0; i--){
                if(!DamageInfo[playerid][i][eDamageTaken]) 
                    continue;

                if(count == pInfo[playerid][pTotalDamages]) 
                    break;

                if(IsActualGun(DamageInfo[playerid][i][eDamageWeapon])) lethal_wounds++;

                count++;
                SendClientMessageToAll(-1, "[13] COUNT DAMAGE");
            }
            if(lethal_wounds > 1) pInfo[playerid][pBrutallyWounded] = true;
        } else pInfo[playerid][pBrutallyWounded] = true;

        if(pInfo[playerid][pBrutallyWounded]){
            if((gettime() - pInfo[playerid][pLastKnockout]) < 900000) pInfo[playerid][pBrutallyWounded] = false;
        }
        else pInfo[playerid][pBrutallyWounded] = true;

        SetPlayerHealth(playerid, 25.0);
        pInfo[playerid][pDeadTime] = 120;

        if(pInfo[playerid][pBrutallyWounded])
        {
            if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0, 1);
            else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, false, false, false, true, 0);

            SendClientMessageToAll(-1, "[14] BRUTALLY WOUNDED");

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
                ResetWeapons(playerid);	
            } else SendServerMessage(playerid, "Você não possuia nenhuma arma quando morreu.");

            va_SendClientMessage(playerid, COLOR_LIGHTRED, "Você está brutalmente ferido, agora se um médico ou alguém não lhe ajudar, você irá morrer.");
            va_SendClientMessage(playerid, COLOR_LIGHTRED, "Para aceitar a morte digite /aceitarmorte.");

            new string[256];
            format(string, sizeof(string), "(( Ferido %d vezes, /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);
            SetPlayerChatBubble(playerid, string, COLOR_LIGHTRED, 15.0, 300*1000);
            ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, false, false, false, true, 0);

            va_SendClientMessage(playerid, COLOR_LIGHTRED, "(( Você foi ferido %d vezes, /ferimentos %d para mais informações ))", pInfo[playerid][pTotalDamages], playerid);
            SendClientMessageToAll(-1, "[15] FERIMENTOS");
        }else{
            pInfo[playerid][pPassedOut] = true;
            ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, false, false, false, true, 0);
            SendClientMessageToAll(-1, "[15] DESMAIOU");
            new string[256];
            format(string, sizeof(string), "(( Ferido %d vezes, /levantar %d para ajuda-lo ))", pInfo[playerid][pTotalDamages], playerid);
            SetPlayerChatBubble(playerid, string, COLOR_LIGHTRED, 15.0, 300*1000);
        }
    }
}

CallbackDamages(playerid, issuerid, bodypart, weaponid, Float:amount){
    new id,
        Float: armour;

    pInfo[playerid][pTotalDamages] ++;

    for(new i = 0; i < 100; i++){
		if(!DamageInfo[playerid][i][eDamageTaken]){
			id = i;
			break;
		}
	}
    GetPlayerArmour(playerid, armour);

    if(armour > 1 && bodypart == BODY_PART_CHEST)
		DamageInfo[playerid][id][eDamageArmor] = 1;

	else DamageInfo[playerid][id][eDamageArmor] = 0;

    DamageInfo[playerid][id][eDamageTaken] = floatround(amount, floatround_round);
	DamageInfo[playerid][id][eDamageWeapon] = weaponid;

	DamageInfo[playerid][id][eDamageBodypart] = bodypart;
	DamageInfo[playerid][id][eDamageTime] = gettime();

	DamageInfo[playerid][id][eDamageBy] = pInfo[issuerid][pID];
    return true;
}

ShowPlayerDamages(damageid, playerid, view){
    new caption[33],
        str[255],
        longstr[1200];

    format(caption, sizeof(caption), "%s", pNome(damageid));
    if (pInfo[damageid][pTotalDamages] < 1)
		return ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, "Não existe nenhum dano para mostrar.", "<<", "");
    
    switch(view){
        case 0:
        {
            for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;

                format(str, sizeof(str), "%d de dano por um(a) %s no(a) %s (COLETE: %d) há %ds\n", DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]);
				strcat(longstr, str);
            }
            ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, longstr, "<<", "");
        }
        case 1:
        {
            for(new i = 0; i < 100; i ++)
			{
                if(!DamageInfo[damageid][i][eDamageTaken])
                    continue;

                format(str, sizeof(str), "{FF6346}(%s){FFFFFF} %d de dano por um(a) %s no(a) %s (COLETE: %d) há %ds\n", pNome(DamageInfo[damageid][i][eDamageBy]), DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]);
                strcat(longstr, str);
            }
            ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, longstr, "<<", "");
        } 
    }
    return true;
}

ClearDamages(playerid){
    SetPlayerChatBubble(playerid, " ", COLOR_WHITE, 10.0, 100);

    pInfo[playerid][pLimping] = false;
    pInfo[playerid][pLimpingTime] = 0;

	for(new i = 0; i < 100; i++){
		DamageInfo[playerid][i][eDamageTaken] = 0;
		DamageInfo[playerid][i][eDamageBy] = 0;

		DamageInfo[playerid][i][eDamageArmor] = 0;
		DamageInfo[playerid][i][eDamageBodypart] = 0;

		DamageInfo[playerid][i][eDamageTime] = 0;
		DamageInfo[playerid][i][eDamageWeapon] = 0;
	}
	return true;
}

ReturnBodypartName(bodypart){
	new bodyname[20];
	switch(bodypart){
		case BODY_PART_CHEST:bodyname = "PEITO";
		case BODY_PART_GROIN:bodyname = "VIRILHA";
		case BODY_PART_LEFT_ARM:bodyname = "BRAÇO ESQUERDO";
		case BODY_PART_RIGHT_ARM:bodyname = "BRAÇO DIREITO";
		case BODY_PART_LEFT_LEG:bodyname = "PERNA ESQUERDA";
		case BODY_PART_RIGHT_LEG:bodyname = "PERNA DIREITA";
		case BODY_PART_HEAD:bodyname = "CABEÇA";
	}
	return bodyname;
}

// COMMANDS
CMD:aceitarmorte(playerid, params[]){
    if (!pInfo[playerid][pInjured]) return SendErrorMessage(playerid, "Você não está ferido.");
    if (pInfo[playerid][pDead]) return SendErrorMessage(playerid, "Você já está morto.");
    if (pInfo[playerid][pPassedOut]) return SendErrorMessage(playerid, "Você está nocauteado.");
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
		SendServerMessage(playerid, "Você ativou o modo investida. A partir de agora se você socar alguém, haverá chances de derruba-lo.");
		SendServerMessage(playerid, "Se o jogador for derrubado e não interpretar corretamente, utilize o /report.");
		pInfo[playerid][pTackleMode] = true;
	}else{
		SendServerMessage(playerid, "Você desativou o modo investida.");
		pInfo[playerid][pTackleMode] = false;
	}
	return true;
}

CMD:ferimentos(playerid, params[]){
    if (!pInfo[playerid][pLogged]) return true;
    static userid;
    if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/ferimentos [playerid/nome]");
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

    if (pInfo[playerid][pAdminDuty]) ShowPlayerDamages(userid, playerid, 1);
    else{
        if(!IsPlayerNearPlayer(playerid, userid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste jogador.");
        ShowPlayerDamages(userid, playerid, 0);
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
    pInfo[playerid][pPassedOut] = false;
    pInfo[playerid][pLimping] = false;
    pInfo[playerid][pLimpingTime] = 0;
    SetCameraBehindPlayer(userid);
    TogglePlayerControllable(userid, true);
    SetPlayerChatBubble(userid, " ", COLOR_LIGHTRED, 15.0, 1);
    ApplyAnimation(userid, "CARRY", "crry_prtial", 2.0, false, false, false, false, 0);
    ClearDamages(playerid);

    SendServerMessage(playerid, "Você reviveu %s.", pNome(userid));
    SendServerMessage(userid, "%s reviveu o seu personagem.", pNome(playerid));

    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s reviveu %s.", pNome(playerid), pNome(userid));
    format(logString, sizeof(logString), "%s (%s) reviveu %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
    return true;
}