#include <YSI_Coding\y_hooks>

CMD:ajuda(playerid, params[]) {
  	new type[128];
   	if (sscanf(params, "s[128]", type)){
		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
		//SendClientMessage(playerid, COLOR_CYAN1, "[CONTA] ");
		SendClientMessage(playerid, COLOR_CYAN2, "[GERAL] /admins, /sos, /report, /cs, /tackle");
		SendClientMessage(playerid, COLOR_CYAN1, "[CHAT] (/g)ritar, /baixo, /me, /do, /ame, /ado, (/s)ussurrar, /b, /limparmeuchat");
		SendClientMessage(playerid, COLOR_CYAN2, "[DINHEIRO] /pagar, /investimentos, /taxas");
		SendClientMessage(playerid, COLOR_CYAN1, "[OUTROS] /config, /tela, /largarcorpo, /pegarcorpo, /respawnar");
		SendClientMessage(playerid, COLOR_CYAN2, "[OUTROS] /ajuda empresa, /ajuda casa, /ajuda cassino, /ajuda sinuca, /ajuda tela, /ajuda veiculo");
		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
        SendClientMessage(playerid, COLOR_CYAN1, "Se tiver dúvida na utilização de algum comando envie um /sos e fale com um administrador.");
		return true;
	}
	if (!strcmp(type, "tela", true)){
		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
        SendClientMessage(playerid, COLOR_CYAN1, "[TELA] /tela 0 desativa; /tela 1 ao 4 define um tipo específico.");
        SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
		return true; 
	} 
	else if (!strcmp(type, "empresa", true)){
		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
        SendClientMessage(playerid, COLOR_CYAN1, "[EMPRESA] ble");
        SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
		return true; 
	} else if (!strcmp(type, "casa", true)){
		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
        SendClientMessage(playerid, COLOR_CYAN1, "[CASA] ble");
        SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
		return true;
	} else if (!strcmp(type, "cassino", true)){
		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
        SendClientMessage(playerid, COLOR_CYAN1, "[CAÇA-NÍQUEL] 'Y' próximo de uma máquina inicia o jogo");
		SendClientMessage(playerid, COLOR_CYAN2, "[CAÇA-NÍQUEL] 'ESPAÇO' inicia a aposta");
		SendClientMessage(playerid, COLOR_CYAN1, "[CAÇA-NÍQUEL] 'F' ou 'ENTER' abandona a máquina");
		SendClientMessage(playerid, COLOR_CYAN2, "[CAÇA-NÍQUEL] 'LSHIFT' aumenta o valor da aposta");
        SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
		SendClientMessage(playerid, COLOR_CYAN1, "Você pode conferir um guia completo sobre o sistema em nosso fórum.");
		return true;
	} else if (!strcmp(type, "sinuca", true)){
		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
        SendClientMessage(playerid, COLOR_CYAN1, "[SINUCA] 'Y' próximo de uma mesa inicia/deixa o jogo");
		SendClientMessage(playerid, COLOR_CYAN2, "[SINUCA] 'botão de mirar' mira na bola");
		SendClientMessage(playerid, COLOR_CYAN1, "[SINUCA] 'botão de atirar' define a força da tacada");
        SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
		SendClientMessage(playerid, COLOR_CYAN1, "Você pode conferir um guia completo sobre o sistema em nosso fórum.");
		return true;
	}
	else if (!strcmp(type, "veiculo", true)){
		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
        SendClientMessage(playerid, COLOR_CYAN1, "[VEÍCULOS] /v, /vobjeto, /placa, /motor, /luzes, /capo, /janela");
		SendClientMessage(playerid, COLOR_CYAN2, "[VEÍCULOS] /trailer [temporário], /trailerex [temporário], /quebrartrava");
        SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
		SendClientMessage(playerid, COLOR_CYAN1, "Você pode conferir um guia completo sobre o sistema em nosso fórum.");
		return true;
	}
	
	else if (!strcmp(type, "fly", true)){
		
    	if(GetPlayerAdmin(playerid) < 1335) return SendPermissionMessage(playerid);

		SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
        SendClientMessage(playerid, COLOR_CYAN1, "[FLY] /fly - inicia/finaliza o modo de voo");
		SendClientMessage(playerid, COLOR_CYAN2, "[FLY] botão de atirar - aumenta a altura");
		SendClientMessage(playerid, COLOR_CYAN1, "[FLY] botão de mirar - diminui a altura");
		SendClientMessage(playerid, COLOR_CYAN2, "[FLY] botão de correr (espaço) - aumenta a velocidade");
		SendClientMessage(playerid, COLOR_CYAN1, "[FLY] botão de andar (lalt) - diminui a velocidade");
        SendClientMessage(playerid, COLOR_GREEN, "____________________________________________________");
		return true;
	} else if (!strcmp(type, "admin", true)) return ShowAdminCmds(playerid);

	return true;
}

CMD:limparmeuchat(playerid, params[]){
	
	ClearPlayerChat(playerid);
	return true;
}

CMD:meuvw(playerid) {
	return SendServerMessage(playerid, "O seu VW atual é %d.", GetPlayerVirtualWorld(playerid));
}

/*GetWeapon(playerid){
	new weaponid = GetPlayerWeapon(playerid);

	if (1 <= weaponid <= 46 && pInfo[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
		return weaponid;

	return false;
}*/

GiveWeaponToPlayer(playerid, weaponid, ammo){
	if (weaponid < 0 || weaponid > 46)
	return false;

	pInfo[playerid][pGuns][g_aWeaponSlots[weaponid]] = weaponid;
	pInfo[playerid][pAmmo][g_aWeaponSlots[weaponid]] += ammo;

	return GivePlayerWeapon(playerid, WEAPON:weaponid, ammo);
}

SetWeapons(playerid){
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) if (pInfo[playerid][pGuns][i] > 0 && pInfo[playerid][pAmmo][i] > 0) {
		GivePlayerWeapon(playerid, WEAPON:pInfo[playerid][pGuns][i], pInfo[playerid][pAmmo][i]);
	}
	return true;
}

ResetWeapons(playerid){
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) {
		pInfo[playerid][pGuns][i] = 0;
		pInfo[playerid][pAmmo][i] = 0;
	}
	return true;
}

/*ResetWeapon(playerid, weaponid)
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
	return true;
}*/

/*
PlayerHasWeapon(playerid, weaponid)
{
	new
		weapon,
		ammo;

	for (new i = 0; i < 13; i ++) if (pInfo[playerid][pGuns][i] == weaponid)
	{
		GetPlayerWeaponData(playerid, i, weapon, ammo);

		if (weapon == weaponid && ammo > 0) return true;
	}
	return false;
}

GetInitials(const string[])
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
}*/

ApplyAnimationEx(playerid, const animlib[], const animname[], Float:fDelta, bool:loop, bool:lockx, bool:locky, bool:freeze, time, forcesync = 0) {
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, t_FORCE_SYNC:forcesync);
	return true;
}


/*PlayerHasTazer(playerid)
{
	return (GetPlayerWeapon(playerid) == 23 && pInfo[playerid][pTazer]);
}

PlayerHasBeanBag(playerid)
{
	return (GetPlayerWeapon(playerid) == 25 && pInfo[playerid][pBeanBag]);
}*/

/*IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
if (i == 0 && str[0] == '-')
	continue;

else if (str[i] < '0' || str[i] > '9')
	return false;
	}
	return true;
}*/

/*getVehicleName(vehicleid){
	new vehmodel = GetVehicleModel(vehicleid);
	new nameVeh[75];

	if (vehmodel < 400 || vehmodel > 611) {
		strcat(nameVeh, "Nenhum");
		return nameVeh;
	}
	strcat(nameVeh, VehicleNames[vehmodel - 400]);
	return nameVeh;
}*/
/*
UpdateWeapons(playerid)
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
	return true;
}*/

/*IsPlayerInWater(playerid)
{
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >=  1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return true;
	return false;
}*/


/*SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, time = 2000)
{
	if (pInfo[playerid][pFreeze])
	{
	    KillTimer(pInfo[playerid][pFreezeTimer]);

	    pInfo[playerid][pFreeze] = 0;
	    TogglePlayerControllable(playerid, true);
	}
	SetPlayerPos(playerid, x, y, z + 0.5);
	TogglePlayerControllable(playerid, false);

	pInfo[playerid][pFreeze] = 1;
	pInfo[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", time, false, "dfff", playerid, x, y, z);
	return true;
}*/

forward SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z);
public SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z) {
	if (!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
	    return false;

	pInfo[playerid][pFreeze] = 0;

	SetPlayerPos(playerid, x, y, z);
	TogglePlayerControllable(playerid, true);
	return true;
}

SetPlayerHealthEx(playerid, Float:hp) {
	if(hp <= 30) SetPlayerWeaponSkill(playerid, MINIMUM_SKILL);
 	else if(hp <= 40) SetPlayerWeaponSkill(playerid, MEDIUM_SKILL);
	else SetPlayerWeaponSkill(playerid, FULL_SKILL);
			
	pInfo[playerid][pHealth] = hp;
	return SetPlayerHealth(playerid, hp);
}

randomEx(min, max){
    new rand = random(max-min)+min;
    return rand;
}