/*

Este módulo é dedicado aos administradores

*/

#include <YSI_Coding\y_hooks>

CMD:aa(playerid)
{
	new MEGAString[2500];
    MEGAString[0]=EOS;
	
    if(uInfo[playerid][uAdmin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if(uInfo[playerid][uAdmin] >= 1)
	{
	    strcat(MEGAString, "{33AA33}_______________________________ {FFFFFF}COMANDOS ADMINISTRATIVOS{33AA33} _______________________________\n\n");
	}
	if(uInfo[playerid][uAdmin] >= 1)
	{
     	strcat(MEGAString, "[Helper] /a /ir /trazer /usuario /personagens /perto /darvida /tapa\n\n");
	}
	if(uInfo[playerid][uAdmin] >= 2)
	{
		strcat(MEGAString, "[Game Admin] /spec /infoplayer /congelar /descongelar /darcolete /resetararmas\n\n");
	}
	if(uInfo[playerid][uAdmin] >= 3)
	{
		strcat(MEGAString, "[Senior Admin] /setskin /jetpack /checarip\n\n");
	}
	if(uInfo[playerid][uAdmin] >= 4)
	{
		strcat(MEGAString, "[Lead Admin] /curartodos /clima\n\n");
	}
	if(uInfo[playerid][uAdmin] >= 5)
	{
	    strcat(MEGAString, "[Head Admin] /setaradmin /setarequipe /dararma\n\n");
	}
	if(uInfo[playerid][uAdmin] >= 1336)
	{
	    strcat(MEGAString, "[Community Manager] /gmx /dargrana /trancarserver\n\n");
	}
	if(uInfo[playerid][uAdmin] >= 1337)
	{
	    strcat(MEGAString, "[Development Manager] /ovni\n\n");
	}
	
	if(uInfo[playerid][uFactionMod] >= 1)
	{
		strcat(MEGAString, "{33AA33}FACTION TEAM:{FFFFFF} /ajuda ft\n\n");
	}
	if(uInfo[playerid][uPropertyMod] >= 1)
	{
		strcat(MEGAString, "{33AA33}PROPERTY TEAM:{FFFFFF} /ajuda pt\n\n");
	}
	ShowPlayerDialog(playerid, 8724, DIALOG_STYLE_MSGBOX, "COMANDOS ADMINISTRATIVOS", MEGAString, "OK","");
	return true;
}

hook OnGameModeInit(){
    SetTimer("OnPlayerUpdate_Timer", 600, true);
    return 1;
}

hook OnPlayerConnect(playerid, reason) {
    DesarmandoPlayer[playerid] = 2;
    return 1;
}

CMD:trancarserver(playerid, params[])
{
    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 1336) return SendPermissionMessage(playerid);

	new password[30], string[128];
    if(sscanf(params, "s[128]", password)) return SendClientMessage(playerid, COLOR_GREY, "USE: /trancarserver [senha]");
	format(string, sizeof(string), "Você definiu a senha do servidor como: %s.", password);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	format(string, sizeof(string), "password %s", password);
	SendRconCommand(string);

	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* definiu a senha do servidor como: %s.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], password);
	discord(DC_AdminCMD, textdc);

	return 1;
}

CMD:tapa(playerid, params[])
{
	static
	    userid;

    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 1) return SendPermissionMessage(playerid);
	if (uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_GREY, "USE: /tapa [playerid/name]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");

	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(userid, x, y, z);
	SetPlayerPos(userid, x, y, z + 5);

	PlayerPlaySound(userid, 1130, 0.0, 0.0, 0.0);

	format(textdc, sizeof(textdc), "AdmCmd: %s deu um tapa em %s.", pNome(playerid), pNome(userid));
	admin_chat(VERMELHO, textdc, 1);

	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* deu um tapa em **%s**.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid));
	discord(DC_AdminCMD, textdc);
	return 1;
}

CMD:curartodos(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 4) return SendPermissionMessage(playerid);
	foreach (new i : Player) {
	    SetPlayerHealth(i, 100.0);
	}
	format(textdc, sizeof(textdc), "AdmCmd: O administrador %s curou todos os jogadores online.", pNome(playerid));
	admin_chat(VERMELHO, textdc, 1);

	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* curou todos os jogadores online.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser]);
	discord(DC_AdminCMD, textdc);
	return 1;
}

CMD:darvida(playerid, params[])
{
	static
		userid,
	    Float:amount;

	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 1) return SendPermissionMessage(playerid);
	if(uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if (sscanf(params, "uf", userid, amount))
		return SendUsageMessage(playerid, "/darvida [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	SetPlayerHealth(userid, amount);
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você setou %s com %.2f de vida.", pNome(userid), amount);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* setou **%s** com %.2f de vida.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid), amount);
	discord(DC_AdminCMD, textdc);
	return 1;
}

CMD:darcolete(playerid, params[])
{
	static
		userid,
	    Float:amount;

	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
	if(uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if (sscanf(params, "uf", userid, amount))
		return SendUsageMessage(playerid, "/darcolete [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

    SetPlayerArmour(userid, amount);
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você setou %s com %.2f de colete.", pNome(userid), amount);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* setou **%s** com %.2f de colete.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid), amount);
	discord(DC_AdminCMD, textdc);
	return 1;
}

CMD:resetararmas(playerid, params[])
{
	static
	    userid;

    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
	if(uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if (sscanf(params, "u", userid))
	    return SendUsageMessage(playerid, "/resetararmas [playerid/nome]");

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	ResetWeapons(userid);
	va_SendClientMessage(playerid, -1, "SERVER: Você resetou as armas de %s.", pNome(userid));
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* resetou as armas de **%s**.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid));
	discord(DC_AdminCMD, textdc);
	return 1;
}

CMD:admins(playerid, params[])
{
	new count = 0;
	SendClientMessage(playerid, COLOR_WHITE, "Administradores online:");

    foreach (new i : Player) if (uInfo[i][uAdmin] > 0)
	{
		if(AdminTrabalhando[playerid] == 1)
			va_SendClientMessage(playerid, -1, "* %s %s (%s) [%d]: {33CC33}Em trabalho", AdminRankName(playerid), pNome(i), pInfo[i][pUser], i);
		else
			va_SendClientMessage(playerid, -1, "* %s %s (%s) [%d]: {FF6347}Em roleplay", AdminRankName(playerid), pNome(i), pInfo[i][pUser], i);

        count++;
	}
	if (!count) {
	    SendClientMessage(playerid, COLOR_WHITE, "Não há nenhum administrador online no momento.");
	}
	return 1;
}

CMD:atrabalho(playerid, params[])
{
    if(uInfo[playerid][uAdmin] > 0)
    {
		switch(AdminTrabalhando[playerid])
		{
		    case 0:
			{
				format(textdc, sizeof(textdc), "AdmCmd: %s entrou em modo de trabalho administrativo.", pNome(playerid));
				admin_chat(VERMELHO, textdc, 1);
   				//SendClientMessage(playerid, COLOR_YELLOW, "Você entrou em modo de trabalho administrativo.");
      			AdminTrabalhando[playerid] = 1;
                SetPlayerColor(playerid,0x587B95FF);
                SetPlayerAttachedObject(playerid, 8, 2992, 2, 0.306000, -0.012000, 0.009000, 0.000000, -95.299942, -1.399999, 1.000000, 1.000000, 1.000000);
                SetPlayerAttachedObject(playerid, 7, 2992, 2, 0.313000, -0.007000, 0.032999, -0.299999, 83.700019, 0.000000, 1.000000, 1.000000, 1.000000);
				format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* entrou em modo administrativo.", 
				ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser]);
				discord(DC_AdminCMD, textdc);
			}
		    case 1:
		    {
				format(textdc, sizeof(textdc), "AdmCmd: %s saiu do modo de trabalho administrativo.", pNome(playerid));
				admin_chat(VERMELHO, textdc, 1);
		        //SendClientMessage(playerid, COLOR_YELLOW, "Você saiu do modo de trabalho administrativo.");
      			AdminTrabalhando[playerid] = 0;
                SetPlayerColor(playerid,COLOR_WHITE);
                RemovePlayerAttachedObject(playerid, 8);
                RemovePlayerAttachedObject(playerid, 7);
				format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* saiu do administrativo.", 
				ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser]);
				discord(DC_AdminCMD, textdc);
		    }
		}
	}
	return true;
}

public2:OnPlayerUpdate_Timer() {
//======================================================================
	//Anti Weapon Hack
	new weapons[13][2],
		string[148];
	for (new playerid; playerid < MAX_PLAYERS; playerid++) {

		if(DesarmandoPlayer[playerid] < 1) {
			for (new i = 0; i <= 12; i++) {
	    		GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);

	    		if(weapons[i][0] > 0 && weapons[i][1] > 0) {
		    		SendServerMessage(playerid,"O anti-cheat de armas está ATIVO.");

					format(string, sizeof(string), "(Weapon Hack) %s pode estar utilizando HACK DE ARMAS. Cheque com cuidado.", pNome(playerid));
					admin_chat(VERMELHO , string, 1);
					return 1;
	    		}
			}
		}
	}
	//======================================================================
	return 1;
}

CMD:setarequipe(playerid, params[])
{
	static
		userid,
		type[24];

	if(!pInfo[playerid][pLogged]) return 1;
	if(uInfo[playerid][uAdmin] < 5) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "us[32]", userid, type))
	{
	    SendUsageMessage(playerid, "/setarequipe [playerid/nome] [equipe]");
		SendClientMessage(playerid, -1, "EQUIPES: faction team, property team");
		return 1;
	}

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

    if (!strcmp(type, "faction team", true))
	{
		if (uInfo[userid][uFactionMod])
		{
			uInfo[userid][uFactionMod] = false;

			va_SendClientMessage(playerid, -1, "SERVER: Você retirou %s da faction team.", pNome(userid));
			va_SendClientMessage(userid, -1, "SERVER: %s removeu você da faction team.", pNome(playerid));
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* retirou **%s** da faction team.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid));
			discord(DC_AdminCMD, textdc);
		}
		else
		{
			uInfo[userid][uFactionMod] = true;

			va_SendClientMessage(playerid, -1, "SERVER: Você colocou %s na faction team.", pNome(userid));
			va_SendClientMessage(userid, -1, "SERVER: %s colocou você na faction team.", pNome(playerid));
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* colocou **%s** na faction team.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid));
			discord(DC_AdminCMD, textdc);
		}
	}

	if (!strcmp(type, "property team", true))
	{
		if (uInfo[userid][uPropertyMod])
		{
			uInfo[userid][uPropertyMod] = false;

			va_SendClientMessage(playerid, -1, "SERVER: Você retirou %s da property team.", pNome(userid));
			va_SendClientMessage(userid, -1, "SERVER: %s removeu você da property team.", pNome(playerid));
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* retirou **%s** da property team.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid));
			discord(DC_AdminCMD, textdc);
		}
		else
		{
			uInfo[userid][uPropertyMod] = true;

			va_SendClientMessage(playerid, -1, "SERVER: Você colocou %s na property team.", pNome(userid));
			va_SendClientMessage(userid, -1, "SERVER: %s colocou você na property team.", pNome(playerid));
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* colocou **%s** na property team.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid));
			discord(DC_AdminCMD, textdc);
		}
	}
	return 1;
}

stock RemovePlayerWeapon(playerid, weaponid) {
	new plyWeapons[12];
	new plyAmmo[12];

    DesarmandoPlayer[playerid] = 2;

	for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);

		if(wep != weaponid)
		{
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}
	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
	{
		SetWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
	}
}

stock SetWeapon(playerid, weaponid, ammo) {
    DesarmandoPlayer[playerid] = 3;
    GivePlayerWeapon(playerid, weaponid, ammo);
	return 1;
}

stock AdminRankName(playerid) {
	new rank[128];
	switch(uInfo[playerid][uAdmin]) {
		case 1: format(rank, sizeof(rank), "Helper");
		case 2: format(rank, sizeof(rank), "Game Admin");
		case 3: format(rank, sizeof(rank), "Senior Admin");
		case 4: format(rank, sizeof(rank), "Lead Admin");
		case 5: format(rank, sizeof(rank), "Head Admin");
		case 1336: format(rank, sizeof(rank), "Community Manager");
        case 1337: format(rank, sizeof(rank), "Development Manager");
	}
	return rank;
}

stock admin_chat(COLOR, const string[], level)
{
	foreach(new i : Player)
	{
		if (uInfo[i][uAdmin] >= level)
		{
			SendClientMessage(i, COLOR, string);
		}
		DCC_SendChannelMessage(DC_AllAdminLogs, string);
	}
	printf("%s", string);
	return true;
}


CMD:infoplayer(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
	if (uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new giveplayerid;
	new armatext[30];
	new municao;
	new arma;
	new Float:plrtempheal;
	new Float:plrarmour;
	new plrping;
	new iplayer[MAX_PLAYER_NAME];
	new smunicao;
	new string[128];
	new ip[32];
	if(sscanf(params, "u", giveplayerid))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USE: /infoplayer [id do player]");
		return true;
	}
	if(IsPlayerConnected(giveplayerid))
	{
		if(giveplayerid != INVALID_PLAYER_ID)
		{
   			GetPlayerName(giveplayerid, iplayer, sizeof(iplayer));
   			GetPlayerIp(giveplayerid,ip,128);
   			new intid = GetPlayerInterior(giveplayerid);
			new world = GetPlayerVirtualWorld(giveplayerid);
			plrping = GetPlayerPing(giveplayerid);
			GetPlayerArmour(giveplayerid, plrarmour);
			GetPlayerHealth(giveplayerid,plrtempheal);
			arma = GetPlayerWeapon(giveplayerid);
			municao = GetPlayerAmmo(giveplayerid);
			SendClientMessage(playerid, COLOR_GREEN, "|________[ EXIBINDO INFORMAÇÕES ]________|");
			format(string, sizeof(string), "{FF6347}Nome: {FFFFFF} %s", iplayer);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}IP: {FFFFFF}%s", ip);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Interior: {FFFFFF}%d", intid);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Mundo: {FFFFFF}%d", world);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Ping: {FFFFFF}%d", plrping);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Colete: {FFFFFF}%1f", plrarmour);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Saúde: {FFFFFF}%1f", plrtempheal);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			if(arma == 38) { armatext = "Minigun";}
			else if(arma == 40) { armatext = "Detonador"; }
			else if(arma == 36) { armatext = "Lança missil RPG"; }
			else if(arma == 35) { armatext = "Lança missil"; }
			else if(arma == 16) { armatext = "Granada"; }
			else if(arma == 18) { armatext = "Coktel Molotov"; }
			else if(arma == 22) { armatext = "Pistola de Duas mãos 9mm"; }
			else if(arma == 26) { armatext = "Escopeta de Cano Serrado"; }
			else if(arma == 27) { armatext = "Escopeta de Combate"; }
			else if(arma == 28) { armatext = "Micro Uzi"; }
			else if(arma == 32) { armatext = "Tec9"; }
			else if(arma == 37) { armatext = "Lança Chamas"; }
			else if(arma == 0) { armatext = "Desarmado"; }
            else if(arma == 4) { armatext = "Faca"; }
            else if(arma == 5) { armatext = "Bastão de Base Ball"; }
            else if(arma == 9) { armatext = "Motoserra"; }
            else if(arma == 14) { armatext = "Flores"; }
            else if(arma == 17) { armatext = "Granada de Gas"; }
            else if(arma == 23) { armatext = "Pistola com silênciador"; }
            else if(arma == 16) { armatext = "Granada"; }
            else if(arma == 24) { armatext = "Desert Eagle"; }
            else if(arma == 25) { armatext = "ShotGun"; }
            else if(arma == 29) { armatext = "MP5"; }
            else if(arma == 30) { armatext = "AK-47"; }
            else if(arma == 31) { armatext = "M4"; }
            else if(arma == 33) { armatext = "Rifle"; }
            else if(arma ==  34) { armatext = "Rifle Sniper"; }
            else if(arma == 41) { armatext = "Spray"; }
            else if(arma == 42) { armatext = "Extintor"; }
            else if(arma == 46) { armatext = "Paraquedas"; }
            else { armatext = "Desconhecido"; }
            format(string, sizeof(string), "{FF6347}Arma: {FFFFFF}%s", armatext);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			if(arma == 40 || arma == 36 || arma == 18 || arma == 28 || arma == 37)
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "/spec nele, pois ele pode estar usando xiter de armas");
			}
			if(municao == 65535) { smunicao = 0; } else { smunicao = municao; }
			format(string, sizeof(string), "{FF6347}Munição: {FFFFFF}%d", smunicao);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
		}
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* checou as informacoes de %s.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(giveplayerid));
		discord(DC_AdminCMD, textdc);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GREY, "Este jogador está off-line !");
	    return true;
	}
	return true;
}

CMD:setskin(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;
	if(uInfo[playerid][uAdmin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new para1, level;
	if(sscanf(params, "ud", para1, level))
	{
		SendClientMessage(playerid, COLOR_GREY, "USE: /setskin [playerid] [skin id]");
		return true;
	}
	if(level < 1 || level > 30000)
	{
		SendClientMessage(playerid, COLOR_GREY, "ERRO: Você selecionou um ID restrito à Management.");
		return true;
	}
	new string[128];
	if(IsPlayerConnected(para1))
	{
		if(para1 != INVALID_PLAYER_ID)
		{
			pInfo[para1][pSkin] = level;
			format(string, sizeof(string), "O administrador %s mudou sua skin para %d.", pNome(playerid), level);
			SendClientMessage(para1, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "Você mudou a skin de %s para %d.", pNome(para1), level);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			SetPlayerSkin(para1, pInfo[para1][pSkin]);

			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* alterou a skin de %s para %d.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(para1), level);
			discord(DC_AdminCMD, textdc);
		}
	}
	return true;
}

CMD:perto(playerid, params[])
{
	static
	    id = -1;

    if(!pInfo[playerid][pLogged]) return 1;
	if(uInfo[playerid][uAdmin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	
	if ((id = House_Nearest(playerid)) != -1)
	    va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você está perto da casa ID: %d.", id);

	/*if ((id = Gate_Nearest(playerid)) != -1)
	    va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você está perto do portão ID: %d.", id);*/
		
    if ((id = Entrance_Nearest(playerid)) != -1)
	    va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você está perto da entrada ID: %d.", id);

   /* if ((id = Arrest_Nearest(playerid)) != -1)
	    va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você está perto do ponto de prisão ID: %d.", id);

    if ((id = IsPlayerNearBanker(playerid)) != -1)
	    va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você está perto do banco ID: %d.", id);

    if ((id = GetClosestATM(playerid)) != -1)
	    va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você está perto do ATM ID: %d.", id);
*/
    if ((id = Graffiti_Nearest(playerid)) != -1)
 		va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você está perto do ponto de pichação ID: %d.", id);

	return 1;
}

CMD:congelar(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;
	if(uInfo[playerid][uAdmin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	new playa;
	if(sscanf(params, "u", playa))
	{
		SendClientMessage(playerid, COLOR_GRAD1, "USE: /congelar [playerid/nome]");
	}
	if(IsPlayerConnected(playa))
	{
		if(uInfo[playa][uAdmin] >= 1336 && uInfo[playerid][uAdmin] < 1336)
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Você não pode congelar um management!");
			return true;
		}

		TogglePlayerControllable(playa, 0);
		format(textdc, sizeof(textdc), "AdmCmd: %s congelou %s.", pNome(playerid), pNome(playa));
		admin_chat(VERMELHO, textdc, 1);

		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* congelou **%s**.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(playa));
		discord(DC_AdminCMD, textdc);
	}
	return 1;
}

CMD:descongelar(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
	if(uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	new playa;
	if(sscanf(params, "u", playa))
	{
		SendClientMessage(playerid, COLOR_GRAD1, "USE: /descongelar [playerid/nome]");
	}
	if(IsPlayerConnected(playa))
	{
		if(uInfo[playa][uAdmin] >= 1336 && uInfo[playerid][uAdmin] < 1336)
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Você não pode descongelar um management!");
			return true;
		}
		TogglePlayerControllable(playa, 1);
		format(textdc, sizeof(textdc), "AdmCmd: %s descongelou %s.", pNome(playerid), pNome(playa));
		admin_chat(VERMELHO, textdc, 1);

		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* descongelou **%s**.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(playa));
		discord(DC_AdminCMD, textdc);
	}
	return 1;
}

CMD:dararma(playerid, params[])
{
	static
	    userid,
	    weaponid,
	    ammo;

    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 5) return SendPermissionMessage(playerid);

	if (sscanf(params, "udI(500)", userid, weaponid, ammo))
	    return SendUsageMessage(playerid, "/dararma [playerid/nome] [arma id] [munição]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você não pode dar arma para jogadores desconectados.");

	if (!IsPlayerSpawned(userid))
	    return SendErrorMessage(playerid, "Você não pode dar arma para jogadores que ainda não entraram no servidor.");

	if (weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
		return SendErrorMessage(playerid, "Você específicou uma arma inválida.");

	GiveWeaponToPlayer(userid, weaponid, ammo);
	va_SendClientMessage(playerid, -1, "SERVER: Você deu para %s uma %s com %d munições.", pNome(userid), ReturnWeaponName(weaponid), ammo);

	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* deu arma (%s com %d balas) para %s.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], ReturnWeaponName(weaponid), ammo, pNome(userid));
	discord(DC_AdminCMD, textdc);
	return 1;
}

CMD:dargrana(playerid, params[])
{
	static
		userid,
	    amount;

	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 1336) return SendPermissionMessage(playerid);

	if (sscanf(params, "ud", userid, amount))
		return  SendUsageMessage(playerid, "/dargrana [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	GiveMoney(userid, amount);

	format(textdc, sizeof(textdc), "AdmCmd: %s %s deu $%s para %s.", AdminRankName(playerid), pNome(playerid), FormatNumber(amount), pNome(userid));
	admin_chat(VERMELHO, textdc, 1);

	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* deu **$%s** para **%s** *(%s)*.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], FormatNumber(amount), pNome(userid), PlayerIP(userid));
	discord(DC_AdminCMD, textdc);
	return 1;
}

CMD:setaradmin(playerid, params[]) {
    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 5) return SendPermissionMessage(playerid);

    new targetid, admin;
    if(sscanf(params, "ui", targetid, admin)) return SendUsageMessage(playerid,"/setaradmin [playerID/Nome] [admin level]");
    if(!IsPlayerConnected(targetid)) return SendErrorMessage(playerid, "Este jogador não está online.");

    uInfo[targetid][uAdmin] = admin;

	if (admin < 0 || admin > 5)
		return SendClientMessage(playerid, COLOR_GREY, "Level inválido. Os niveis devem variar entre 0 a 5.");

    if(uInfo[targetid][uAdmin] > 0) {
        va_SendClientMessage(playerid, COLOR_YELLOW,"Você promoveu %s para %s.", pNome(targetid), AdminRankName(targetid));
        va_SendClientMessage(targetid, COLOR_YELLOW,"%s promoveu você para %s.", pNome(playerid), AdminRankName(targetid));
    }
    else {
        va_SendClientMessage(playerid, COLOR_YELLOW,"Você removeu %s do quadro administrativo.", pNome(targetid));
        va_SendClientMessage(targetid, COLOR_YELLOW,"%s removeu você do quadro administrativo.", pNome(playerid));
    }
    return 1;
}

CMD:a(playerid, result[])
{
	if(uInfo[playerid][uAdmin] < 1) return SendPermissionMessage(playerid);
	if(isnull(result))return SendUsageMessage(playerid, "/a (mensagem)");
	new string[256];
	if (uInfo[playerid][uAdmin] > 0){
		format(string, sizeof(string), "[Admin] %s %s (%s): %s", AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], result);
		admin_chat(COR_ADMINCHAT , string, 1);


		format(string, sizeof(string), "[Admin] %s %s (%s): %s", AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], result);
		discord(DC_ChatAdmin, string);
	}
	return true;
}

CMD:gmx(playerid, params[]) {
    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 1336) return SendPermissionMessage(playerid);

    format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* deu um GMX no servidor.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser]);
    DCC_SendChannelMessage(DC_AdminCMD, textdc);

    SendRconCommand("gmx");
    return 1;
}

static const TempoNomes[][] = {
	/*0 -*/ 	"Tempo limpo",
	/*1 -*/ 	"Tempo firme, sem chances de chuva",
	/*2 -*/ 	"Poucas nuvens, sem chuva",
	/*3 -*/ 	"Tempo seco",
	/*4 -*/ 	"Algumas nuvens com vento",
	/*5 -*/ 	"Tempo firme",
	/*6 -*/ 	"Tempo seco",
	/*7 -*/ 	"Vento forte, mas sem chuva",
	/*8 -*/ 	"Temporal forte",
	/*9 -*/ 	"Neblina intensa",
	/*10 -*/ 	"Sem muitas nuvens",
	/*11 -*/ 	"Sem nuvens",
	/*12 -*/ 	"Nublado",
	/*13 -*/ 	"Ceu com poucas nuvens",
	/*14 -*/ 	"Ceu com poucas nuvens",
	/*15 -*/ 	"Nublado, com muito vento",
	/*16 -*/ 	"Temporal com vento forte",
	/*17 -*/ 	"Nublado e tempo firme",
	/*18 -*/ 	"Nublado e tempo firme",
	/*19 -*/ 	"Tempestade de areia",
	/*20 -*/ 	"Tempo fechado, com chances de chuva",
	/*21 -*/ 	"Tempo escuro",
	/*22 -*/ 	"Tempo escuro",
	/*23 -*/ 	"Sol e tempo firme",
	/*24 -*/ 	"Poucas nuvens",
	/*25 -*/ 	"Tempo fechado",
	/*26 -*/ 	"Nuvens no ceu, mas sem chuva",
	/*27 -*/ 	"Pouca neblina",
	/*28 -*/ 	"Ceu incoberto",
	/*29 -*/ 	"Ceu incoberto",
	/*30 -*/ 	"nublado, com chances de chuva",
	/*31 -*/ 	"Nublado, com risco de chuva",
	/*32 -*/ 	"Neblina forte",
	/*33 -*/ 	"Poucas nuvens",
	/*34 -*/ 	"Sem nuvens",
	/*35 -*/ 	"Ceu incoberto",
	/*36 -*/ 	"Tempo firme",
	/*37 -*/ 	"Tempo firme",
	/*38 -*/ 	"Tempo nublado",
	/*39 -*/ 	"Com muita chance de chuva",
	/*40 -*/ 	"Tempo claro",
	/*41 -*/	"Tempo claro",
	/*42 -*/ 	"Neblina forte e intensa",
	/*43 -*/ 	"Risco de tempestades",
	/*44 -*/ 	"Tempo fechado"
};

CMD:clima(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 4) return SendPermissionMessage(playerid);

	new weather, hora;
	if(sscanf(params, "dd", hora, weather))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USE: /clima [hora (0 - 24)] [tempo (0 - 44]");
		return true;
	}
	if(hora < 0 || hora > 24)
	{
		SendClientMessage(playerid, COLOR_GRAD2, "Hora mínima, de 0 ~ 24!");
		return true;
	}
	if(weather < 0||weather > 44) { SendClientMessage(playerid, COLOR_GREY, "Tempo mínimo, de 0 ~ 44 !"); return 1; }
	new string[128];
	SetWeather(weather);
	SetWorldTime(hora);
	format(string, sizeof(string), "Hora configurada para %d horas e clima para %s.", hora, TempoNomes[weather]);
	SendClientMessageToAll(COLOR_GRAD1, string);

	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* configurou a hora para %d e o clima para %s.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser],  hora, TempoNomes[weather]);
	discord(DC_AdminCMD, textdc);

	return true;
}

CMD:trazer(playerid, params[])
{
    if(uInfo[playerid][uAdmin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if(uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 


	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse administrador está em modo espectador em alguém, por isso não pode puxa-lo.");

	new targetid, Float: PlayerPos[3];
	GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_GREY, "USE: /trazer [id/nick]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "Usuário inválido ou offline.");

	SetPlayerPos(targetid, PlayerPos[0], PlayerPos[1] + 2.0, PlayerPos[2]);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* levou **%s** ate ele.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(targetid));
	discord(DC_AdminCMD, textdc);

	return 1;
}

CMD:ir(playerid, params[])
{
	static
	    id,
	    type[24],
		string[64];

	if(uInfo[playerid][uAdmin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if(uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 

	if (sscanf(params, "u", id))
 	{
	 	SendUsageMessage(playerid, "/ir [player ou nome]");
		SendClientMessage(playerid, -1, "NOMES: pos, veiculo, pichação, prisão, interior, entrada, casa, objeto");
		return 1;
	}
    if (id == INVALID_PLAYER_ID)
	{
	    if (sscanf(params, "s[24]S()[64]", type, string))
		{
		    SendUsageMessage(playerid, "/ir [player ou nome]");
			SendClientMessage(playerid, -1, "NOMES: pos, veiculo, pichação, prisão, interior, entrada, casa, objeto");
			return 1;
	    }

	    if (!strcmp(type, "pos", true)) {

			if (uInfo[playerid][uAdmin] < 3)
				return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
			
			new Float:X2,Float:Y2,Float:Z2;
			if (sscanf(string, "fff", X2, Y2, Z2))
				return SendUsageMessage(playerid, "/ir pos [x] [y] [z]");
			SetPlayerPos(playerid, X2, Y2, Z2);

			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* foi ate as coordenadas %d, %d, %d.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], X2, Y2, Z2);
			discord(DC_AdminCMD, textdc);

	        return va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você foi até as coordenadas.");
		}

		else if (!strcmp(type, "veiculo", true))
		{
			new vehicleid;
			if (sscanf(params, "d", vehicleid)) 
				return SendUsageMessage(playerid, "/ir veiculo [id]");

			if (vehicleid < 1 || vehicleid > MAX_DYNAMIC_CARS)
				return SendErrorMessage(playerid, "Você especificou o ID de um veículo inexistente.");

			static
				Float:x,
				Float:y,
				Float:z;

			GetVehiclePos(vehicleid, x, y, z);
			SetPlayerPos(playerid, x, y - 2, z + 2);
	        SetPlayerPos(playerid, 283.5930, 1413.3511, 10.4078);
	        SetPlayerFacingAngle(playerid, 180.0000);

	        SetPlayerInterior(playerid, 0);
	        SetPlayerVirtualWorld(playerid, 0);

			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* foi ate o veiculo ID %d.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], vehicleid);
			discord(DC_AdminCMD, textdc);

	        return va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você se teleportou até o carro.");
		}
		else if (!strcmp(type, "entrada", true))
		{
		    if (sscanf(string, "d", id))
		        return SendUsageMessage(playerid, "/ir entrada [ID]");

			if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
			    return SendErrorMessage(playerid, "Você especificou o ID de uma entrada inexistente.");

		    SetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
		    SetPlayerInterior(playerid, EntranceData[id][entranceExterior]);

			SetPlayerVirtualWorld(playerid, EntranceData[id][entranceExteriorVW]);
		    va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você se teleportou para a entrada ID: %d.", id);
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* foi ate a entrada ID %d.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
			discord(DC_AdminCMD, textdc);
		    return 1;
		}

		else if (!strcmp(type, "casa", true))
		{
		    if (sscanf(string, "d", id))
		        return SendUsageMessage(playerid, "/ir casa [ID]");

			if(!Iter_Contains(Houses, id)) 
			    return SendErrorMessage(playerid, "Você especificou o ID de uma casa inexistente.");

		    SetPlayerPos(playerid, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* foi ate a casa ID %d.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
			discord(DC_AdminCMD, textdc);
		    va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você se teleportou para a casa ID: %d.", id);
		    return 1;
		}

		if (!strcmp(type, "pichação", true)) 
		{
			if (sscanf(string, "d", id))
				return SendUsageMessage(playerid, "/ir pichação [pichação id]");

			if ((id < 0 || id >= MAX_GRAFFITI_POINTS) || !GraffitiData[id][graffitiExists])
				return SendErrorMessage(playerid, "Você especificou uma pichação inválida.");

			SetPlayerPos(playerid, GraffitiData[id][graffitiPos][0], GraffitiData[id][graffitiPos][1], GraffitiData[id][graffitiPos][2]);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* foi ate a pichacao ID %d.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
			discord(DC_AdminCMD, textdc);
	       	return va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você se teleportou para a pichação.");
		}

		/*if (!strcmp(type, "objeto", true)) 
		{
			if (sscanf(string, "d", id))
				return SendUsageMessage(playerid, "/ir objeto [objeto id]");

			if(!(0 <= id <= MAX_COP_OBJECTS - 1))
				return SendErrorMessage(playerid, "Você especificou um objeto inválido.");

			if(!CopObjectData[id][ObjCreated]) return SendErrorMessage(playerid, "Você especificou um objeto inexistente.");

			SetPlayerPos(playerid, CopObjectData[id][ObjX], CopObjectData[id][ObjY], CopObjectData[id][ObjZ] + 1.75);
			SetPlayerInterior(playerid, CopObjectData[id][ObjInterior]);
			SetPlayerVirtualWorld(playerid, CopObjectData[id][ObjVirtualWorld]);
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* foi ate o objeto ID %d.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
			discord(DC_AdminCMD, textdc);
	       	return va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você se teleportou para o objeto.");
		}

		if (!strcmp(type, "prisão", true)) 
		{
			if (sscanf(string, "d", id))
				return SendUsageMessage(playerid, "/ir prisão [prisão id]");

			if ((id < 0 || id >= MAX_ARREST_POINTS) || !ArrestData[id][arrestExists])
				return SendErrorMessage(playerid, "Você específicou um ponto de prisão inválido.");

			SetPlayerPos(playerid, ArrestData[id][arrestPos][0], ArrestData[id][arrestPos][1], ArrestData[id][arrestPos][2]);
			SetPlayerInterior(playerid, ArrestData[id][arrestInterior]);
			SetPlayerVirtualWorld(playerid, ArrestData[id][arrestWorld]);
			format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* foi ate a prisao ID %d.", 
			ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], id);
			discord(DC_AdminCMD, textdc);
	       	return va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você se teleportou para a prisão.");
		}*/
		else if (!strcmp(type, "interior", true))
		{
		    static
		        str[1536];

			str[0] = '\0';

			for (new i = 0; i < sizeof(g_arrInteriorData); i ++) {
			    strcat(str, g_arrInteriorData[i][e_InteriorName]);
			    strcat(str, "\n");
		    }
		    Dialog_Show(playerid, TeleportInterior, DIALOG_STYLE_LIST, "Teleporte: Lista de Interiores", str, "Selecionar", "Cancelar");
		    return 1;
		}
	    else return SendErrorMessage(playerid, "Você específicou um jogador inválido.");
	}
	if (!IsPlayerSpawned(id))
		return SendErrorMessage(playerid, "Você não pode ir até um jogador que não spawnou.");

	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse administrador está em modo espectador em alguém, por isso não pode ir até o mesmo.");

	SendPlayerToPlayer(playerid, id);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* foi ate o jogador **%s**.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(id));
	discord(DC_AdminCMD, textdc);
	return 1;
}


CMD:spec(playerid, params[])
{
    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 2) return SendPermissionMessage(playerid);
	if (uInfo[playerid][uAdmin] < 3 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new userid;

	if (!isnull(params) && !strcmp(params, "off", true))
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
			return SendServerMessage(playerid, "Você não está observando nenhum jogador.");

	    PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
	    PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);

	    SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 
        pInfo[playerid][pPositionX], 
        pInfo[playerid][pPositionY], 
        pInfo[playerid][pPositionZ],
        pInfo[playerid][pPositionA],
         0, 0, 0, 0, 0, 0);
	    TogglePlayerSpectating(playerid, false);

	    if (!AdminTrabalhando[playerid]){
		    SetPlayerColor(playerid, COLOR_ADMIN);
	    }
	    
	    EmSpec[playerid] = INVALID_PLAYER_ID;
		format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* saiu do modo espectador.", 
		ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser]);
		discord(DC_AdminCMD, textdc);
	    return SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você não está mais no modo espectador.");

	}

	if (sscanf(params, "u", userid)) return SendUsageMessage(playerid, "/spec <playerID/Nome>");

	if(!IsPlayerConnected(userid)) return SendErrorMessage(playerid, "Este jogador não está online.");

	if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
		GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
		GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);

		pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
		pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
	}
	SetPlayerInterior(playerid, GetPlayerInterior(userid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(userid));

	TogglePlayerSpectating(playerid, 1);

	if (IsPlayerInAnyVehicle(userid))
	    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(userid));

	else
		PlayerSpectatePlayer(playerid, userid);

	va_SendClientMessage(playerid, VERMELHO, "Você agora está observando %s (ID: %d). Use '/spec off' para sair do spec.", pNome(userid), userid);
	EmSpec[playerid] = userid;

	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* entrou em spec em **%s**.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], pNome(userid));
	discord(DC_AdminCMD, textdc);
	return 1;
}

CMD:jetpack(playerid, params[]){
    if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 3) return SendPermissionMessage(playerid);
	va_SendClientMessage(playerid, CINZA,"AdmCmd: Jetpack criado com sucesso.");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	format(textdc, sizeof textdc, "`AdmCmd:` [%s] %s **%s** *(%s)* pegou um jetpack.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser]);
	discord(DC_AdminCMD, textdc);
	return 1;
}

stock GiveGMX()
{
	foreach(new i : Player)
	{
		SendClientMessage(i, COLOR_LIGHTRED, "O servidor sofrerá um GMX em cinco minutos. Finalize o que você está fazendo e deslogue.");
		SaveCharacterInfo(i);
		printf("[GMX] Reiniciando o servidor em cinco minutos.");
		SendRconCommand("hostname Paradise Roleplay | REINICIANDO");
		SendRconCommand("password 10102dmmdnsas7721jmm");
	}
	SetTimer("GMXA", 300000, 0);
}
forward GMXA();
public GMXA()
{
	foreach(new i : Player)
	{
		new string[256];
        new DCC_Embed:embed = DCC_CreateEmbed("SERVIDOR REINICIANDO");
        format(string, sizeof string, "%s", LASTEST_RELEASE);
        DCC_AddEmbedField(embed, "Ultima atualizacao em:", string, false);
        format(string, sizeof string, "%s", VERSIONING);
        DCC_AddEmbedField(embed, "Versao do servidor:", string, false);
        DCC_AddEmbedField(embed, "Motivo:", "GMX manual.", false);
        DCC_SetEmbedColor(embed, 15548997);
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352074907734037.png");
        DCC_SetEmbedFooter(embed, "Servidor desconectado.", "https://cdn.discordapp.com/emojis/894352160479932468.png");
        DCC_SendChannelEmbedMessage(DC_Status, embed);

		SendClientMessage(i, COLOR_YELLOW, "O servidor sofrerá um GMX AGORA. Você será KICKADO.");
		SaveCharacterInfo(i);
		Kick(i);
	}
	SetTimer("GMXF", 400, 0);
}
forward GMXF();
public GMXF()
{
	foreach(new i : Player)
	{
		SendRconCommand("gmx");
	}
}

stock SendAdminAlert(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (uInfo[i][uAdmin] >= 1) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (uInfo[i][uAdmin] >= 1) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

Dialog:TeleportInterior(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    SetPlayerInterior(playerid, g_arrInteriorData[listitem][e_InteriorID]);
	    SetPlayerPos(playerid, g_arrInteriorData[listitem][e_InteriorX], g_arrInteriorData[listitem][e_InteriorY], g_arrInteriorData[listitem][e_InteriorZ]);
	}
	return 1;
}

SendPlayerToPlayer(playerid, targetid)
{
	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(targetid, x, y, z);

	if (IsPlayerInAnyVehicle(playerid))
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), x, y + 2, z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
	}
	else

	SetPlayerPos(playerid, x + 1, y, z);

	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

	pInfo[playerid][pHouse] = pInfo[targetid][pHouse];
	//PlayerInfo[playerid][pBusiness] = PlayerInfo[targetid][pBusiness];
	pInfo[playerid][pEntrance] = pInfo[targetid][pEntrance];
	//PlayerInfo[playerid][pHospitalInt]  = PlayerInfo[targetid][pHospitalInt];
}