#include <YSI_Coding\y_hooks> // COPIANDO ISSO AKI AINDA

new deathmode[MAX_PLAYERS];
new deathtime[MAX_PLAYERS];

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(!PlayerData[playerid][pInjured] && !PlayerData[playerid][pJailed])
	{
		PlayerData[playerid][pInjured] = 1;
		PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
		PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
		GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
		GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);
		deathtime[playerid] = 120;
	}
    BitFlag_Off(g_PlayerFlags[playerid], IS_PLAYER_SPAWNED);
    if(killerid != INVALID_PLAYER_ID) SQL_LogPlayerDeath(playerid,killerid,reason);
    else if(!PlayerData[playerid][pJailed])
	{
        if(!PlayerData[playerid][pInjured]) {
			PlayerData[playerid][pInjured] = 1;
			PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
			PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
			GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);
			deathtime[playerid] = 120;
		}
		else {
		    //KillTimer(HelpUpTimer[playerid]);
		    KnockedOut{playerid} = false;
			TogglePlayerControllable(playerid, false);

	     	SetPlayerChatBubble(playerid, "(( THIS PLAYER IS DEAD ))", 0xFF6347FF, 20.0, 60*1000);

	     	SendClientMessage(playerid, COLOR_YELLOW, "-> You're now dead. You need to wait 60 seconds until you can /respawnme.");

			deathmode[playerid] = 1;
			deathtime[playerid] = 60;

			if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0, 1);
			else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
		}
    }
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

    if(!PlayerData[playerid][pInjured] && !deathmode[playerid])
	{
	    if(GetPVarInt(playerid, "BrokenLeg") && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	    {
			if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP))
			{
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);
			}
		}
	 	if(GetPVarInt(playerid, "BrokenLeg") && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	    {
			if(newkeys & KEY_SPRINT && !(oldkeys & KEY_SPRINT))
			{
				ApplyAnimation(playerid, "ped", "FALL_collapse",4.1,0,1,1,0,0);
				ApplyAnimation(playerid, "ped", "FALL_collapse",4.1,0,1,1,0,0);
			}
		}
	}
    return true;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(PlayerData[issuerid][pInjured] || deathmode[issuerid]) return false;

	//if(DamageSync[playerid] == STATE_PENDING_HIT) DamageSync[playerid] = STATE_WAIT_HIT, KillTimer(IssueTimer[playerid]);

	//printf("OnPlayerTakeDamage: wpid %d %f", weaponid, amount);
	if(issuerid != INVALID_PLAYER_ID)
	{
	    if(DamageVariable[playerid] == INVALID_PLAYER_ID) return false;

        DamageVariable[playerid] = INVALID_PLAYER_ID;
        LastDamageFrom[playerid] = issuerid;
        
        if(pTackle[issuerid] && weaponid == 0)
		{
			TacklePlayer(issuerid, playerid);
			return false;
		}
		
		amount = WeaponDamage[weaponid][WepDamage];
		LastBlow[playerid] = weaponid;
	
	    //SendClientMessage(issuerid, -1, "OnPlayerTakeDamage called");
	
		new Float:health, Float:armour;
		//GetPlayerHealth(playerid, health);
		health = PlayerData[playerid][pHealth];
	  	GetPlayerArmour(playerid, armour);
	  	
	  	new bool:armourhit = false;

		if(!deathmode[playerid] && !PlayerData[playerid][pInjured])
		{
			/*switch(bodypart)
			{
				case 7,8:
				{
				    SetPVarInt(playerid, "BrokenLeg", 1);
			  	 	SendClientMessage(playerid, COLOR_LIGHTRED, "-> You've been shot in the legs, you are not able to jump and sprite.");
			  	 	//ApplyAnimation(playerid, "PED", "FALL_COLLAPSE", 4.1, 0, 1, 1, 0, 0, 1);
			  	  	//LegDelay[playerid] = 5;
			  	}
			}*/
			
			switch(bodypart)
			{
			    case BODY_PART_CHEST, BODY_PART_GROIN: armourhit = true;

				case BODY_PART_LEFT_ARM, BODY_PART_RIGHT_ARM:
				{
				    new chance = random(3);

				    if(chance == 1) armourhit = true;
				}

				case BODY_PART_LEFT_LEG, BODY_PART_RIGHT_LEG:
				{
				    amount = amount / 2;

				    new chance = random(2);

				    if(chance)
				    {
						SetPVarInt(playerid, "BrokenLeg", 1);
						SendClientMessage(playerid, COLOR_LIGHTRED, "-> You've been hit in the leg, you're gonna struggle with running and jumping.");
						BrokenLegTimer[playerid] = gettime();
				    }
				}

				case BODY_PART_HEAD:
				{
					if(PlayerData[playerid][pSwat])
					{
	                    amount = amount / 2;
					}
					else amount += amount / 2;
				}
			}
		}
		
		if(PlayerData[playerid][pSwat] && bodypart != BODY_PART_HEAD) armourhit = true;
		
		/*amount = CalculatePlayerDamage(playerid, issuerid, weaponid);

		switch(bodypart)
		{
		    case BODY_PART_CHEST, BODY_PART_GROIN: amount -= (amount / 4.0);
		    case BODY_PART_LEFT_ARM, BODY_PART_RIGHT_ARM: amount -= (amount / 2.5);
		    case BODY_PART_LEFT_LEG, BODY_PART_RIGHT_LEG: amount -= (amount / 2.9);
		}*/

		if(PlayerData[playerid][pInjured] || KnockedOut{playerid})
		{
			if(!deathmode[playerid] && deathtime[playerid] <= 117)
			{
			    //KillTimer(HelpUpTimer[playerid]);
			    KnockedOut{playerid} = false;
			    TogglePlayerControllable(playerid, false);
			
	            SetPlayerChatBubble(playerid, "(( THIS PLAYER IS DEAD ))", 0xFF6347FF, 20.0, 60*1000);

	            SendClientMessage(playerid, COLOR_YELLOW, "-> You're now dead. You need to wait 60 seconds and then you'll get the ability to /respawnme.");

				deathmode[playerid] = 1;
				deathtime[playerid] = 60;

				if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0);
				else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
			}
		}
		else
		{
			if(armour > 0.0 && armourhit)
			{
			    //SendClientMessage(issuerid, -1, "kevlar hit");

			    armour -= amount;

			    if(armour < 0.0)
			    {
			        SetPlayerArmour(playerid, 0.0);

			        health += armour;
			    }
			    else SetPlayerArmour(playerid, armour);
			}
			else
			{
				health -= amount;
			}
			
			CallbackDamages(playerid, issuerid, bodypart, weaponid, amount);

			if(health >= 11 && health <= 30)
			{
				SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 200);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 200);
    			SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 200);
    			SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 200);
    			SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 200);
    			SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 200);

				SendClientMessage(playerid, COLOR_LIGHTRED, "-> Low health, shooting skills at medium.");
			}
 			if(health <= 10)
			{
				SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 100);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 100);
    			SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 100);
   			 	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 100);
    			SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 100);
    			SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 100);

				SendClientMessage(playerid, COLOR_LIGHTRED, "-> Critical low health, shooting skills at minimum.");
			}
			
			if(health < 1)
			{
	   			deathtime[playerid] = 120;
				PlayerData[playerid][pInjured] = 1;
				PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
				PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
				GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
				GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);
				
				if(IsPlayerInAnyVehicle(playerid))
				{
				    TogglePlayerControllable(playerid, false);
					MakePlayerSuffer(playerid);
				}
				else SetPlayerSpawn(playerid);

				SetPlayerHealthEx(playerid, 25);

				SQL_LogPlayerDeath(playerid,issuerid,weaponid);
			}
			else SetPlayerHealthEx(playerid, health);
		}
	}
	else {
		PlayerData[playerid][pHealth] -= amount;

		/*if(PlayerData[playerid][pHealth] < 1) {

          	deathtime[playerid] = 300;
			PlayerData[playerid][pInjured] = 1;
			PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
			PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
			GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);
			SetPlayerSpawn(playerid);
			SetPlayerHealthEx(playerid, 25);
		}*/
	}
    return 1;
}

hook OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    if(PlayerData[playerid][pInjured] || deathmode[playerid]) return false;

 	if(playerid != INVALID_PLAYER_ID && damagedid != INVALID_PLAYER_ID)
	{
		//SendClientMessage(playerid, -1, "OnPlayerGiveDamage called");
		
		DamageVariable[damagedid] = playerid;
		
	    OnPlayerTakeDamage(damagedid, playerid, amount, weaponid, bodypart);
	
		/*if(DamageSync[playerid] == STATE_PENDING_HIT)
	 	{
	   		KillTimer(IssueTimer[damagedid]);
	      	IssueTimer[damagedid] = SetTimerEx("IssueHit", ISSUE_HIT_DELAY, false, "iifii", playerid, damagedid, Float:amount, weaponid, bodypart);
		}
		else
	  	{
	     	IssueTimer[damagedid] = SetTimerEx("IssueHit", ISSUE_HIT_DELAY, false, "iifii", playerid, damagedid, Float:amount, weaponid, bodypart);
	      	DamageSync[damagedid] = STATE_PENDING_HIT;
	  	}*/
    }
    return 1;
}

hook SetPlayerSpawn(playerid);
hook SetPlayerSpawn(playerid)
{
    if(!deathmode[playerid] && PlayerData[playerid][pInjured])
	{
		MakePlayerSuffer(playerid);
	}
    return true;
}
forward deathTimer(); // OtherTimer()
public deathTimer(){
    if(deathtime[i] > 0)
    	{
    	    if(KnockedOut{i} == true)
    	    {
    	        if(deathtime[i] > 0) deathtime[i]--;
    	    }
    	    else
    	    {
				if(!deathmode[i] && PlayerData[i][pInjured])
				{
				    if(deathtime[i] > 0) deathtime[i]--;

				    if(deathtime[i] <= 0 && PlayerData[i][pInjured] == 1)
				    {
				        //KillTimer(HelpUpTimer[i]);
				        KnockedOut{i} = false;
						TogglePlayerControllable(i, false);

			            SetPlayerChatBubble(i, "(( THIS PLAYER IS DEAD ))", 0xFF6347FF, 20.0, 60*1000);

			            SendClientMessage(i, COLOR_YELLOW, "-> You're now dead. You need to wait 60 seconds and then you'll get the ability to /respawnme.");

						deathmode[i] = 1;
						deathtime[i] = 60;

						if(!IsPlayerInAnyVehicle(i)) ApplyAnimation(i, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
				    }
				}
				else if(deathmode[i])
				{
				    if(deathtime[i] > 0) deathtime[i]--;

				    if(deathtime[i] <= 0 && PlayerData[i][pInjured])
				    {
				        SendClientMessage(i, COLOR_YELLOW, "-> Your death time is up, you can /respawnme right now.");
				    }
				}
			}
		}
}

CMD:acceptdeath(playerid, params[]){
    if(!PlayerData[playerid][pInjured])
 		return SendClientMessage(playerid, COLOR_GRAD1, "   You're not brutally wounded.");
 		
	if(deathmode[playerid])
		return SendClientMessage(playerid, COLOR_GRAD1, "   You're already dead.");
		
 	if(KnockedOut{playerid})
 	    return SendClientMessage(playerid, COLOR_GRAD1, "   You are knocked out.");

	if(deathtime[playerid] > 120)
		return SendClientMessage(playerid, COLOR_GRAD1, "   You have to wait 2 minutes to accept death.");

    SetPlayerChatBubble(playerid, "(( THIS PLAYER IS DEAD ))", 0xFF6347FF, 20.0, 60*1000);
    SendClientMessage(playerid, COLOR_YELLOW, "-> You are dead now You need to wait 60 seconds and then you will be able to /respawnme");

	deathmode[playerid] = 1;
	deathtime[playerid] = 60;

	return 1;
}

CMD:helpup(playerid, params[])
{
	new playerb;

	if(sscanf(params, "u", playerb))
		return SendSyntaxMessage(playerid, "/helpup [playerid OR name]");

	if(!IsPlayerConnected(playerb))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}The player you specified isn't connected.");
		
	if(!KnockedOut{playerb})
	    return SendClientMessage(playerid,  COLOR_LIGHTRED, "ERROR: {FFFFFF}That player isn't knocked out.");
	    
	if(playerid == playerb)
	    return SendClientMessage(playerid,  COLOR_LIGHTRED, "ERROR: {FFFFFF}Dummy");
	    
    if(deathtime[playerb] > 0)
   		return SendClientMessageEx(playerid,  COLOR_LIGHTRED, "ERROR: {FFFFFF}You must wait %d seconds before helping this player up.", deathtime[playerb]);
   		
   	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
   	    return SendClientMessage(playerid,  COLOR_LIGHTRED, "ERROR: {FFFFFF}You are not close to that player!");
    
    HelpUPStage[playerb] = 15;
    HelpingUP[playerb] = playerid;
    HelpingUP[playerid] = playerb;
    
    new string[128];
    format(string, sizeof(string), "is helping %s up.", ReturnName(playerb, 0));
    cmd_ame(playerid, string);
    
    KnockOutText[playerb] = Create3DTextLabel("(( --------------- ))\nHELPING UP", COLOR_GREEN2, 0.0, 0.0, 0.0, 10.0, 0);
    Attach3DTextLabelToPlayer(KnockOutText[playerb], playerb, 0.0, 0.0, 0.7);
    
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} You are helping %s up. This will take 15 seconds.", ReturnName(playerb, 0));
	SendClientMessageEx(playerb, COLOR_LIGHTRED, "[ ! ]{FFFFFF} %s is helping you up. It's going to take 15 seconds.", ReturnName(playerid, 0));
	
	HelpUpTimer[playerb] = SetTimerEx("HelpedUP", 1000, true, "dd", playerb, playerid);
	return 1;
}

forward HelpedUP(playerid, playerb);
public HelpedUP(playerid, playerb)
{
	if(!IsPlayerNearPlayer(playerb, playerid, 5.0))
	{
	    HelpingUP[playerb] = INVALID_PLAYER_ID;
	    HelpingUP[playerid] = INVALID_PLAYER_ID;
	
	    HelpUPStage[playerid] = 0;
		KillTimer(HelpUpTimer[playerid]);
	    Delete3DTextLabel(KnockOutText[playerid]);
	    KnockOutText[playerid] = Text3D:INVALID_3DTEXT_ID;
 		return SendClientMessage(playerid,  COLOR_LIGHTRED, "ERROR: {FFFFFF}Action has been canceled because you moved.");
	}

    HelpUPStage[playerid] --;

	switch(HelpUPStage[playerid])
	{
	    case 14: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( |-------------- ))\nHELPING UP");
	    case 13: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( ||------------- ))\nHELPING UP");
	    case 12: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( |||------------ ))\nHELPING UP");
	    case 11: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( ||||----------- ))\nHELPING UP");
	    case 10: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( |||||---------- ))\nHELPING UP");
	    case 9: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( ||||||--------- ))\nHELPING UP");
	    case 8: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( |||||||-------- ))\nHELPING UP");
	    case 7: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( ||||||||------- ))\nHELPING UP");
	    case 6: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( |||||||||------ ))\nHELPING UP");
	    case 5: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( ||||||||||----- ))\nHELPING UP");
	    case 4: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( |||||||||||---- ))\nHELPING UP");
	    case 3: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( ||||||||||||--- ))\nHELPING UP");
	    case 2: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( |||||||||||||-- ))\nHELPING UP");
	    case 1: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( ||||||||||||||- ))\nHELPING UP");
	    case 0: Update3DTextLabelText(KnockOutText[playerid], COLOR_GREEN2, "(( ||||||||||||||| ))\nHELPING UP");
	}
	
	if(!HelpUPStage[playerid])
	{
	    HelpingUP[playerb] = INVALID_PLAYER_ID;
	    HelpingUP[playerid] = INVALID_PLAYER_ID;
	
		KillTimer(HelpUpTimer[playerid]);
	    Delete3DTextLabel(KnockOutText[playerid]);
	    KnockOutText[playerid] = Text3D:INVALID_3DTEXT_ID;

		ClearDamages(playerid);
		PlayerData[playerid][pInjured] = 0;
		KnockedOut{playerid} = false;
		deathmode[playerid] = 0;
		deathtime[playerid] = 0;
		MedicBill[playerid] = 1;
		SetPVarInt(playerid, "BrokenLeg", 0);

		SetPlayerHealthEx(playerid, 25.0);

		TogglePlayerControllable(playerid, true);

		SendClientMessageEx(playerb, COLOR_LIGHTRED, "[ ! ]{FFFFFF} You helped %s up!", ReturnName(playerid, 0));
	 	SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} %s helped you up!", ReturnName(playerb, 0));
	}
 	return 1;
}

CMD:revive(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		return SendClientMessage(playerid, COLOR_GREY, "You are not allowed to use this command.");

	new playerb;

	if(sscanf(params, "u", playerb))
		return SendSyntaxMessage(playerid, "/revive [playerid OR name]");

	if(!IsPlayerConnected(playerb))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "The player you specified isn't connected.");

	if(!PlayerData[playerb][pInjured] && !deathmode[playerb])
		return SendClientMessage(playerid,  COLOR_LIGHTRED, "That player isn't dead or brutally wounded.");

	if(IsPlayerInAnyVehicle(playerb)) ClearAnimations(playerb);

	ClearDamages(playerb);
	PlayerData[playerb][pInjured] = 0;
	KnockedOut{playerb} = false;
	deathmode[playerb] = 0;
	deathtime[playerb] = 0;
	MedicBill[playerb] = 1;
	SetPVarInt(playerb, "BrokenLeg", 0);
	TotalPlayerDamages[playerb] = 0;
	//KillTimer(HelpUpTimer[playerb]);

    SendAdminAlert(COLOR_YELLOW, "%s revived player %s.", ReturnName(playerid), ReturnName(playerb));

	SetPlayerHealthEx(playerb, 100.0);

	TogglePlayerControllable(playerb, true);

	SetPlayerSkillLevel(playerb, WEAPONSKILL_PISTOL, 899);
	SetPlayerSkillLevel(playerb, WEAPONSKILL_MICRO_UZI, 0);
	SetPlayerSkillLevel(playerb, WEAPONSKILL_SPAS12_SHOTGUN, 0);
	SetPlayerSkillLevel(playerb, WEAPONSKILL_AK47, 999);
    SetPlayerSkillLevel(playerb, WEAPONSKILL_DESERT_EAGLE, 999);
    SetPlayerSkillLevel(playerb, WEAPONSKILL_SHOTGUN, 999);
    SetPlayerSkillLevel(playerb, WEAPONSKILL_M4, 999);
    SetPlayerSkillLevel(playerb, WEAPONSKILL_MP5, 999);
	
	SetPlayerChatBubble(playerb, "(( Respawned ))", COLOR_WHITE, 21.0, 3000);
	ClearDamages(playerb);
	GameTextForPlayer(playerb, "~b~You were revived", 3000, 4);
	return 1;
}

CMD:damages(playerid, params[])
{
	new playerb;

	if(sscanf(params, "u", playerb))
		return SendSyntaxMessage(playerid, "/damages [playerid OR name]");

	if(!IsPlayerConnected(playerb))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "The player you specified isn't connected.");

	if(isAdminDuty(playerid))
	{
		ShowPlayerDamages(playerb, playerid, 1);
	}
	else
	{
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You aren't near that player.");

		if(!PlayerData[playerb][pInjured] || deathmode[playerb])
			return SendClientMessage(playerid, COLOR_LIGHTRED, "That player isn't brutally wounded.");

		ShowPlayerDamages(playerb, playerid, 0);
	}
	return 1;
}

stock ShowPlayerDamages(damageid, playerid, adminView)
{
	new
		caption[33],
		str[355],
		longstr[1200]
	;

	format(caption, sizeof(caption), "%s", ReturnName(damageid));

	if (TotalPlayerDamages[damageid] < 1)
		return ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, "There aren't any damages to show.", "<<", "");

	switch(adminView)
	{
		case 0:
		{
			for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;

				format(str, sizeof(str), "%d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]);
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

				format(str, sizeof(str), "{FF6346}(%s){FFFFFF} %d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", ReturnDBIDName(DamageInfo[damageid][i][eDamageBy]), DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]);
				strcat(longstr, str);
			}

			ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, longstr, "<<", "");
		}
	}
	return 1;
}

stock ClearDamages(playerid)
{
    SetPVarInt(playerid, "BrokenLeg", 0);

    SetPlayerChatBubble(playerid, " ", COLOR_WHITE, 10.0, 100);

	for(new i = 0; i < 100; i++)
	{
		DamageInfo[playerid][i][eDamageTaken] = 0;
		DamageInfo[playerid][i][eDamageBy] = 0;

		DamageInfo[playerid][i][eDamageArmor] = 0;
		DamageInfo[playerid][i][eDamageBodypart] = 0;

		DamageInfo[playerid][i][eDamageTime] = 0;
		DamageInfo[playerid][i][eDamageWeapon] = 0;
	}

	return 1;
}

stock CallbackDamages(playerid, issuerid, bodypart, weaponid, Float:amount)
{
	new
		id,
		Float:armor
	;

	TotalPlayerDamages[playerid] ++;

	for(new i = 0; i < 100; i++)
	{
		if(!DamageInfo[playerid][i][eDamageTaken])
		{
			id = i;
			break;
		}
	}

	GetPlayerArmour(playerid, armor);

	if(armor > 1 && bodypart == BODY_PART_CHEST)
		DamageInfo[playerid][id][eDamageArmor] = 1;

	else DamageInfo[playerid][id][eDamageArmor] = 0;

	DamageInfo[playerid][id][eDamageTaken] = floatround(amount, floatround_round);
	DamageInfo[playerid][id][eDamageWeapon] = weaponid;

	DamageInfo[playerid][id][eDamageBodypart] = bodypart;
	DamageInfo[playerid][id][eDamageTime] = gettime();

	DamageInfo[playerid][id][eDamageBy] = PlayerData[issuerid][pID];
	return 1;
}

stock ReturnBodypartName(bodypart)
{
	new bodyname[20];

	switch(bodypart)
	{
		case BODY_PART_CHEST:bodyname = "CHEST";
		case BODY_PART_GROIN:bodyname = "GROIN";
		case BODY_PART_LEFT_ARM:bodyname = "LEFT ARM";
		case BODY_PART_RIGHT_ARM:bodyname = "RIGHT ARM";
		case BODY_PART_LEFT_LEG:bodyname = "LEFT LEG";
		case BODY_PART_RIGHT_LEG:bodyname = "RIGHT LEG";
		case BODY_PART_HEAD:bodyname = "HEAD";
	}

	return bodyname;
}

stock MakePlayerSuffer(playerid)
{
	new
 		bool:brutally_wounded = false,
 		reason = LastBlow[playerid]
	;

	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(!IsActualGun(reason) && !IsLethalMeele(reason))
		{
			new
				count,
				lethal_wounds
			;

			for(new i = 99; i > 0; i--)
			{
				if(!DamageInfo[playerid][i][eDamageTaken])
					continue;

				if(count == TotalPlayerDamages[playerid])
				    break;

				if(IsActualGun(DamageInfo[playerid][i][eDamageWeapon]))
				{
				    lethal_wounds++;
				}

				count++;
			}

			if(lethal_wounds > 1) brutally_wounded = true;
		}
		else brutally_wounded = true;

		if(brutally_wounded)
		{
			if((gettime() - LastKnockout[playerid]) < 900000) brutally_wounded = false;
		}
	}
	else brutally_wounded = true;

	SetPlayerHealthEx(playerid, 25.0);
	deathtime[playerid] = 120;
	
	if(brutally_wounded)
	{
		if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.0, 0, 0, 0, 1, 0, 1);
		else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);

		GameTextForPlayer(playerid, "~r~brutally wounded", 5000, 4);

		new body[500], weap_str[256], lost_weapons = 0;

		for(new i = 0; i < 13; i++)
		{
			if(PlayerData[playerid][pGuns][i] != 0 && PlayerData[playerid][pAmmo][i] != 0)
			{
				if(!lost_weapons) format(weap_str, 256, "%s[%d Ammo]", ReturnWeaponName(PlayerData[playerid][pGuns][i]), PlayerData[playerid][pAmmo][i]);
				else  format(weap_str, 256, "%s, %s[%d Ammo]", weap_str, ReturnWeaponName(PlayerData[playerid][pGuns][i]), PlayerData[playerid][pAmmo][i]);

				lost_weapons++;
			}
		}

		if(lost_weapons)
		{
			ResetWeapons(playerid);

			format(body, sizeof(body), "{FF6347}[ ! ]{FFFFFF} You lost weapons:\n%s", weap_str);

			new year, month, day, hour, minute, second;
			getdate(year, month, day);
			gettime(hour, minute, second);

			format(body, sizeof(body), "%s\n\n{FFFFFF}You lost your items on: {FF6347}%d/%d/%d -- %d:%d:%d", body, day, month, year, hour, minute, second);

			format(LostWeapons_Cache[playerid], 1000, "%s", body);

			SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} You died and lost your items. Use /lostitems to see what you lost.");
		}
		else LostWeapons_Cache[playerid][0] = EOS;

		SendClientMessage(playerid, COLOR_LIGHTRED, "You were brutally wounded, now if a medic or anyone else doesn't save you, you will die.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "To accept death type /acceptdeath.");

		format(szString, sizeof(szString), "(( Has been injured %d times, /damages %d for more information. ))", TotalPlayerDamages[playerid], playerid);
		SetPlayerChatBubble(playerid, szString, 0xFF6347FF, 20.0, 300*1000);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, szString);

		SetPlayerToTeamColor(playerid);
		
		SendAdminAlert(COLOR_LIGHTRED, "DeathMsg: %s has been brutally wounded by %s. (%s)", ReturnName(playerid), ReturnName(LastDamageFrom[playerid]), ReturnWeaponName(reason));
	}
	else
	{
	    KnockedOut{playerid} = true;
	
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);

		GameTextForPlayer(playerid, "~b~KNOCKED OUT", 5000, 4);
	
		format(szString, sizeof(szString), "(( Has been hit %d times and knocked out, /helpup %d to help them up. ))", TotalPlayerDamages[playerid], playerid);
		SetPlayerChatBubble(playerid, szString, 0xFF6347FF, 20.0, 300*1000);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, szString);

		SetPlayerToTeamColor(playerid);
		
		SendAdminAlert(COLOR_RED, "%s has been knocked out by %s. (%s)", ReturnName(playerid), ReturnName(LastDamageFrom[playerid]), ReturnWeaponName(reason));
	}
}

CMD:respawnme(playerid, params[])
{
	if(deathmode[playerid] && deathtime[playerid] <= 0)
	{
	    ResetPlayer(playerid);
		ClearDamages(playerid);
		SetPVarInt(playerid, "BrokenLeg", 0);
		deathmode[playerid] = 0;
		deathtime[playerid] = 0;
		MedicBill[playerid] = 0;
		PlayerData[playerid][pInjured]=0;
		PlayerData[playerid][pHealth]=100;
		BitFlag_Off(g_PlayerFlags[playerid], IS_PLAYER_SPAWNED);
		TogglePlayerControllable(playerid, true);
		SpawnPlayer(playerid);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "Please wait 60 seconds.");

	return 1;
}