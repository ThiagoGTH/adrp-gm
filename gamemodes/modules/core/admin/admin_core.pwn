/*

Este módulo é dedicado aos administradores

*/

#include <YSI_Coding\y_hooks>

stock AdminRankName(playerid) {
	new rank[128];
	switch(uInfo[playerid][uAdmin]) {
		case 1: format(rank, sizeof(rank), "Tester");
		case 2: format(rank, sizeof(rank), "Game Admin 1");
		case 3: format(rank, sizeof(rank), "Game Admin 2");
		case 4: format(rank, sizeof(rank), "Game Admin 3");
		case 5: format(rank, sizeof(rank), "Lead Admin");
		case 1335: format(rank, sizeof(rank), "Manager");
		case 1336: format(rank, sizeof(rank), "Community Manager");
        case 1337: format(rank, sizeof(rank), "Development Manager");
	}
	return rank;
}

stock GetPlayerAdmin(playerid) {
	new level;
	level = uInfo[playerid][uAdmin];
	return level;
}

CMD:aa(playerid)
{	
    if(!pInfo[playerid][pLogged]) return true;
  	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	ShowAdminCmds(playerid);
	return true;
}

stock ShowAdminCmds(playerid){
	if(GetPlayerAdmin(playerid) >= 1)
	{
	    va_SendClientMessage(playerid, -1, "{33AA33}_______________________________ {FFFFFF}COMANDOS ADMINISTRATIVOS{33AA33} _______________________________");
	}
	if(GetPlayerAdmin(playerid) >= 1) // TESTER
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[TESTER]{FFFFFF} /a, /aa, /tapa, /vida, /proximo, /usuario, /personagens, /ir, /trazer");
	}
	if(GetPlayerAdmin(playerid) >= 2) // GAME ADMIN 1
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /colete, /resetararmas, /infoplayer, /congelar, /descongelar, /spec");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /ban, /banoff, /bantemp, /bantempoff, /desban, /checarban");
	}
	if(GetPlayerAdmin(playerid) >= 3) // GAME ADMIN 2
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 2]{FFFFFF} /skin, /jetpack, ");
	}
	if(GetPlayerAdmin(playerid) >= 4) // GAME ADMIN 3
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 3]{FFFFFF} /curartodos, /clima");
	}
	if(GetPlayerAdmin(playerid) >= 5) // LEAD ADMIN
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[LEAD ADMIN]{FFFFFF} /setarequipe, /dararma, /setaradmin, /limparhistoricoban");
	}
	if(GetPlayerAdmin(playerid) >= 1335) // MANAGEMENT
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[MANAGEMENT]{FFFFFF} /dardinheiro, /gmx, /trancarserver");
	}
	return true;
}

hook OnGameModeInit(){
    SetTimer("OnPlayerUpdate_Timer", 600, true);
    return true;
}

hook OnPlayerConnect(playerid, reason) {
    DesarmandoPlayer[playerid] = 2;
    return true;
}

CMD:trancarserver(playerid, params[])
{
    if(!pInfo[playerid][pLogged]) return true;
    if(GetPlayerAdmin(playerid) < 1335) return SendPermissionMessage(playerid);

	new password[30], string[128];
    if(sscanf(params, "s[128]", password)) return SendSyntaxMessage(playerid, "/trancarserver [senha]");
	format(string, sizeof(string), "Você definiu a senha do servidor como: %s.", password);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	format(string, sizeof(string), "password %s", password);
	SendRconCommand(string);

	format(logString, sizeof(logString), "%s (%s) definiu a senha do servidor como '%s'.", pNome(playerid), GetPlayerUserEx(playerid), password);
	logCreate(playerid, logString, 1);
	return true;
}

CMD:tapa(playerid, params[])
{
	static
		userid;

	if(!pInfo[playerid][pLogged]) return true;
  	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/tapa [playerid/name]");
  	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	static
		Float:x,
	  	Float:y,
	  	Float:z;

	GetPlayerPos(userid, x, y, z);
	SetPlayerPos(userid, x, y, z + 5);

	PlayerPlaySound(userid, 1130, 0.0, 0.0, 0.0);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s deu um tapa em %s.", pNome(playerid), pNome(userid));
	format(logString, sizeof(logString), "%s (%s) deu um tapa em %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:curartodos(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return true;
    if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);
	foreach (new i : Player) {
	    SetPlayerHealth(i, 100.0);
	}
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: O administrador %s curou todos os jogadores on-line.", pNome(playerid));
	format(logString, sizeof(logString), "%s (%s) curou todos os jogadores on-lige.", pNome(playerid), GetPlayerUserEx(playerid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:vida(playerid, params[])
{
	static
		userid,
	  	Float:amount;

	if(!pInfo[playerid][pLogged]) return true;
  	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	if (sscanf(params, "uf", userid, amount)) return SendSyntaxMessage(playerid, "/vida [playerid/nome] [quantidade]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	SetPlayerHealth(userid, amount);
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você setou %s com %.2f de vida.", pNome(userid), amount);
	format(logString, sizeof(logString), "%s (%s) setou %s com %.2f de vida.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), amount);
	logCreate(playerid, logString, 1);
	return true;
}

CMD:colete(playerid, params[])
{
	static
		userid,
	    Float:amount;

	if(!pInfo[playerid][pLogged]) return true;
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "uf", userid, amount)) return SendSyntaxMessage(playerid, "/colete [playerid/nome] [quantidade]");
	if (userid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

  	SetPlayerArmour(userid, amount);
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você setou %s com %.2f de colete.", pNome(userid), amount);
	format(logString, sizeof(logString), "%s (%s) setou %s com %.2f de colete.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), amount);
	logCreate(playerid, logString, 1);
	return true;
}

CMD:resetararmas(playerid, params[])
{
	static
		userid;

  	if(!pInfo[playerid][pLogged]) return true;
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/resetararmas [playerid/nome]");
  	if (userid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	ResetWeapons(userid);
	va_SendClientMessage(playerid, -1, "SERVER: Você resetou as armas de %s.", pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) resetou as armas de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:admins(playerid, params[])
{
	new count = 0;
	SendClientMessage(playerid, COLOR_GREEN, "Equipe administrativa on-line:");

    foreach (new i : Player) if (uInfo[i][uAdmin] > 0)
	{
		if(pInfo[playerid][pAdminDuty])
			va_SendClientMessage(playerid, COLOR_GREEN, "%s %s (%s) (ID: %d) | Status: Em serviço administrativo", AdminRankName(i), pNome(i), pInfo[i][pUser], i);
		else
			va_SendClientMessage(playerid, COLOR_GREY, "%s %s (%s) | Status: Em roleplay", AdminRankName(i), pNome(i), pInfo[i][pUser]);
        count++;
	}
	if (!count) {
	    SendClientMessage(playerid, COLOR_WHITE, "Não há nenhum administrador online no momento.");
	}
	return true;
}

CMD:atrabalho(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return true;
  	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	
	if (!pInfo[playerid][pAdminDuty]){
		SetPlayerColor(playerid, 0x408080FF);
		pInfo[playerid][pAdminDuty] = 1;
		SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%s) entrou em trabalho administrativo.", pNome(playerid), pInfo[playerid][pUser]);
		format(logString, sizeof(logString), "%s (%s) entrou em trabalho administrativo.", pNome(playerid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 1);
	}else{
	    SetPlayerColor(playerid, DEFAULT_COLOR);
		pInfo[playerid][pAdminDuty] = 0;
		SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%s) saiu do trabalho administrativo.", pNome(playerid), pInfo[playerid][pUser]);
		format(logString, sizeof(logString), "%s (%s) saiu do trabalho administrativo.", pNome(playerid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 1);
	}
	return true;
}

public2:OnPlayerUpdate_Timer() {
//======================================================================
	//Anti Weapon Hack
	new weapons[13][2];
	for (new playerid; playerid < MAX_PLAYERS; playerid++) {

		if(DesarmandoPlayer[playerid] < 1) {
			for (new i = 0; i <= 12; i++) {
	    		GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);

	    		if(weapons[i][0] > 0 && weapons[i][1] > 0) {
		    		//SendServerMessage(playerid, "O anti-cheat de armas está ATIVO.");
					SendAdminAlert(COLOR_LIGHTRED, "(Weapon Hack) %s pode estar utilizando HACK DE ARMAS. Cheque com cuidado.", pNome(playerid));
					return true;
	    		}
			}
		}
	}
	//======================================================================
	return true;
}

CMD:setarequipe(playerid, params[])
{
	static
		userid,
		type[24];

	if(!pInfo[playerid][pLogged]) return true;
	if(GetPlayerAdmin(playerid) < 5) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "us[32]", userid, type))
	{
	    SendSyntaxMessage(playerid, "/setarequipe [playerid/nome] [equipe]");
		SendClientMessage(playerid, -1, "EQUIPES: faction team, property team");
		return true;
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
		}
		else
		{
			uInfo[userid][uFactionMod] = true;

			va_SendClientMessage(playerid, -1, "SERVER: Você colocou %s na faction team.", pNome(userid));
			va_SendClientMessage(userid, -1, "SERVER: %s colocou você na faction team.", pNome(playerid));
		}
	}

	if (!strcmp(type, "property team", true))
	{
		if (uInfo[userid][uPropertyMod])
		{
			uInfo[userid][uPropertyMod] = false;

			va_SendClientMessage(playerid, -1, "SERVER: Você retirou %s da property team.", pNome(userid));
			va_SendClientMessage(userid, -1, "SERVER: %s removeu você da property team.", pNome(playerid));
		}
		else
		{
			uInfo[userid][uPropertyMod] = true;

			va_SendClientMessage(playerid, -1, "SERVER: Você colocou %s na property team.", pNome(userid));
			va_SendClientMessage(userid, -1, "SERVER: %s colocou você na property team.", pNome(playerid));
		}
	}
	return true;
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
	return true;
}

CMD:infoplayer(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return true;
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);

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
	if(sscanf(params, "u", giveplayerid)) return SendSyntaxMessage(playerid, "/infoplayer [id do player]");
	if(IsPlayerConnected(giveplayerid)){
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
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GREY, "Este jogador está off-line !");
	    return true;
	}
	return true;
}

CMD:skin(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return true;
	if(GetPlayerAdmin(playerid) < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	new userid, level;
	if(sscanf(params, "ud", userid, level)) return SendSyntaxMessage(playerid, "/skin [playerid] [skin id]");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	if(level < 1 || level > 30000) return SendErrorMessage(playerid, "Você selecionou um ID restrito à Management.");

	if(userid != INVALID_PLAYER_ID){
		pInfo[userid][pSkin] = level;
		SendServerMessage(userid, "O administrador %s mudou sua skin para %d.", pNome(playerid), level);
		SendServerMessage(playerid, "Você mudou a skin de %s para %d.", pNome(userid), level);
		SetPlayerSkin(userid, pInfo[userid][pSkin]);
		format(logString, sizeof(logString), "%s (%s) mudou a skin de %s para %d.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), level);
		logCreate(playerid, logString, 1);
	}
	return true;
}

CMD:proximo(playerid, params[])
{
    if(!pInfo[playerid][pLogged]) return true;
	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	
	// A FAZER
	return true;
}

CMD:congelar(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return true;
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new userid;
	if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/congelar [playerid/nome]");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	if(GetPlayerAdmin(userid) >= 1335 && GetPlayerAdmin(playerid) < 1335) SendErrorMessage(playerid, "Você não pode congelar um management!");
	
	TogglePlayerControllable(userid, 0);
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s congelou %s.", pNome(playerid), pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) congelou %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:descongelar(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return true;
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new userid;
	if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/descongelar [playerid/nome]");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);

	TogglePlayerControllable(userid, 1);
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s descongelou %s.", pNome(playerid), pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) descongelou %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:dararma(playerid, params[])
{
	static
	    userid,
	    weaponid,
	    ammo;

    if(!pInfo[playerid][pLogged]) return true;
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
	if (sscanf(params, "udI(500)", userid, weaponid, ammo)) return SendSyntaxMessage(playerid, "/dararma [playerid/nome] [arma id] [munição]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
	if (!IsPlayerSpawned(userid)) return SendNotConnectedMessage(playerid);
	if (weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21)) return SendErrorMessage(playerid, "Você específicou uma arma inválida.");

	GiveWeaponToPlayer(userid, weaponid, ammo);
	va_SendClientMessage(playerid, -1, "SERVER: Você deu para %s uma %s com %d munições.", pNome(userid), ReturnWeaponName(weaponid), ammo);
	
	format(logString, sizeof(logString), "%s (%s) deu uma %s (ID:%d AMMO:%d) para %s.", pNome(playerid), GetPlayerUserEx(playerid), ReturnWeaponName(weaponid), weaponid, ammo, pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:dardinheiro(playerid, params[])
{
	static
		userid,
	    amount;

	if(!pInfo[playerid][pLogged]) return true;
    if(GetPlayerAdmin(playerid) < 1335) return SendPermissionMessage(playerid);

	if (sscanf(params, "ud", userid, amount))
		return  SendSyntaxMessage(playerid, "/dardinheiro [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	GiveMoney(userid, amount);
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s deu $%s para %s.", pNome(playerid), FormatNumber(amount), pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) deu $%s para %s.", pNome(playerid), GetPlayerUserEx(playerid), FormatNumber(amount), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:setaradmin(playerid, params[]) {
    if(!pInfo[playerid][pLogged]) return true;
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    new userid, admin;
    if(sscanf(params, "ui", userid, admin)) return SendSyntaxMessage(playerid,"/setaradmin [playerID/Nome] [admin level]");
    if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	if(admin > GetPlayerAdmin(playerid)) return SendErrorMessage(playerid, "Você não pode promover acima do seu nível.");
	
	if(GetPlayerAdmin(playerid) > 5){
		if (admin < 0 || admin > 1337)
			return SendClientMessage(playerid, COLOR_GREY, "Level inválido. Os niveis devem variar entre 0 a 1337.");

		if(GetPlayerAdmin(userid) > 0) {
			va_SendClientMessage(playerid, COLOR_YELLOW,"Você promoveu %s para %s.", pNome(userid), AdminRankName(userid));
			va_SendClientMessage(userid, COLOR_YELLOW,"%s promoveu você para %s.", pNome(playerid), AdminRankName(userid));
			uInfo[userid][uAdmin] = admin;
		}
		else {
			va_SendClientMessage(playerid, COLOR_YELLOW,"Você removeu %s do quadro administrativo.", pNome(userid));
			va_SendClientMessage(userid, COLOR_YELLOW,"%s removeu você do quadro administrativo.", pNome(playerid));
			uInfo[userid][uAdmin] = admin;
		}
	} else { 
		if (admin < 0 || admin > 5) return SendClientMessage(playerid, COLOR_GREY, "Level inválido. Os niveis devem variar entre 0 a 4.");
		if (admin > GetPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Você não pode promover acima do seu nível.");

		if(GetPlayerAdmin(userid) > 0) {
			va_SendClientMessage(playerid, COLOR_YELLOW,"Você promoveu %s para %s.", pNome(userid), AdminRankName(userid));
			va_SendClientMessage(userid, COLOR_YELLOW,"%s promoveu você para %s.", pNome(playerid), AdminRankName(userid));
			uInfo[userid][uAdmin] = admin;
		}
		else {
			va_SendClientMessage(playerid, COLOR_YELLOW,"Você removeu %s do quadro administrativo.", pNome(userid));
			va_SendClientMessage(userid, COLOR_YELLOW,"%s removeu você do quadro administrativo.", pNome(playerid));
			uInfo[userid][uAdmin] = admin;
		}
	}
    return true;
}

CMD:a(playerid, result[])
{
	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	if(isnull(result))return SendSyntaxMessage(playerid, "/a (mensagem)");

	// JOGO:
	if (strlen(result) > 64){
	    SendAdminAlert(COLOR_ADMINCHAT, "[STAFF] %s %s (%s): %.64s", AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], result);
	    SendAdminAlert(COLOR_ADMINCHAT, "...%s **", result[64]);
	}
	else SendAdminAlert(COLOR_ADMINCHAT, "[STAFF] %s %s (%s): %s", AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], result);

	// DISCORD:
	new str[1024], dest[1024];
	format(str, sizeof(str), "[STAFF] %s %s (%s): %s", AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], result);
	utf8encode(dest, str);
	DCC_SendChannelMessage(DCC_FindChannelById("989306920517136464"), dest);
	return true;
}

CMD:gmx(playerid, params[]) {
    if(!pInfo[playerid][pLogged]) return true;
    if(GetPlayerAdmin(playerid) < 1335) return SendPermissionMessage(playerid);

    GiveGMX();
	
	format(logString, sizeof(logString), "%s (%s) forçou um GMX no servidor.", pNome(playerid), GetPlayerUserEx(playerid));
	logCreate(playerid, logString, 1);
    return true;
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
	if(!pInfo[playerid][pLogged]) return true;
    if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);

	new weather, hora;
	if(sscanf(params, "dd", hora, weather)) return SendSyntaxMessage(playerid, "/clima [hora (0 - 24)] [tempo (0 - 44]");
	if(hora < 0 || hora > 24) return SendErrorMessage(playerid, "Hora mínima, de 0 ~ 24!");
	if(weather < 0||weather > 44) return SendErrorMessage(playerid, "Tempo mínimo, de 0 ~ 44 !");
	SetWeather(weather);
	SetWorldTime(hora);
	SendInfoMessage(playerid, "Hora configurada para %dh e clima para %s.", hora, TempoNomes[weather]);

	
	format(logString, sizeof(logString), "%s (%s) configurou a hora para %d e o clima como '%s'.", pNome(playerid), hora, TempoNomes[weather]);
	logCreate(playerid, logString, 1);
	return true;
}

CMD:trazer(playerid, params[])
{
  	if(GetPlayerAdmin(playerid) < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse administrador está em modo espectador em alguém, por isso não pode puxa-lo.");

	new userid, Float: PlayerPos[3];
	GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "trazer [id/nick]");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	SetPlayerPos(userid, PlayerPos[0], PlayerPos[1] + 2.0, PlayerPos[2]);
	
	format(logString, sizeof(logString), "%s (%s) levou %s até ele.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:ir(playerid, params[])
{
	static
	  	id,
	  	type[24],
		string[64];

	if(GetPlayerAdmin(playerid) < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "u", id)) {
	 	SendSyntaxMessage(playerid, "/ir [playerid ou syntax]");
		SendClientMessage(playerid, -1, "SYNTAXES: pos, interior");
		return true;
	}

 	if (id == INVALID_PLAYER_ID){
	  	if (sscanf(params, "s[24]S()[64]", type, string)) {
		  	SendSyntaxMessage(playerid, "/ir [player ou nome]");
			SendClientMessage(playerid, -1, "NOMES: pos, interior");
			return true;
		}

	    if (!strcmp(type, "pos", true)) {
			new Float:X2,Float:Y2,Float:Z2;
			if (GetPlayerAdmin(playerid) < 3) return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
			if (sscanf(string, "fff", X2, Y2, Z2)) return SendSyntaxMessage(playerid, "/ir pos [x] [y] [z]");
			SetPlayerPos(playerid, X2, Y2, Z2);
	    	return va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você foi até as coordenadas.");
		}
		else if (!strcmp(type, "interior", true)){
		    static
		        str[1536];
			str[0] = '\0';
			for (new i = 0; i < sizeof(g_arrInteriorData); i ++) {
			    strcat(str, g_arrInteriorData[i][e_InteriorName]);
			    strcat(str, "\n");
		    }
		    Dialog_Show(playerid, TeleportInterior, DIALOG_STYLE_LIST, "Teleporte: Lista de Interiores", str, "Selecionar", "Cancelar");
		    return true;
		}
	    else return SendErrorMessage(playerid, "Você específicou um jogador inválido.");
	}
	if (!IsPlayerSpawned(id)) return SendErrorMessage(playerid, "Você não pode ir até um jogador que não spawnou.");
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse administrador está em modo espectador em alguém, por isso não pode ir até o mesmo.");

	SendPlayerToPlayer(playerid, id);

	
	format(logString, sizeof(logString), "%s (%s) foi até %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(id));
	logCreate(playerid, logString, 1);
	return true;
}


CMD:spec(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return true;
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);

	new userid;
	if (!isnull(params) && !strcmp(params, "off", true)) {
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
	    
	  	EmSpec[playerid] = INVALID_PLAYER_ID;
	  	return SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você não está mais no modo espectador.");
	}

	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/spec <playerID/Nome>");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);

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

	va_SendClientMessage(playerid, COLOR_LIGHTRED, "Você agora está observando %s (ID: %d). Use '/spec off' para sair do spec.", pNome(userid), userid);
	EmSpec[playerid] = userid;

	
	format(logString, sizeof(logString), "%s (%s) está observando %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:jetpack(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return true;
	if(GetPlayerAdmin(playerid) < 3) return SendPermissionMessage(playerid);
	new userid;
	if (sscanf(params, "u", userid)){
 	    pInfo[playerid][pJetpack] = 1;
	 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	} else {
		pInfo[userid][pJetpack] = 1;
		SetPlayerSpecialAction(userid, SPECIAL_ACTION_USEJETPACK);
		SendServerMessage(playerid, "Você spawnou um jetpack para %s.", pNome(userid));
		
		format(logString, sizeof(logString), "%s está observando %s.", pNome(playerid), pNome(userid));
		logCreate(playerid, logString, 1);
	}
	return true;
}

stock GiveGMX() {
	foreach(new i : Player) {
		SendClientMessage(i, COLOR_LIGHTRED, "O servidor sofrerá um GMX em cinco minutos. Finalize o que você está fazendo e deslogue.");
		SaveCharacterInfo(i);
		SaveUserInfo(i);
		printf("[GMX] Reiniciando o servidor em cinco minutos.");
		SendRconCommand("hostname Advanced Roleplay | REINICIANDO");
		SendRconCommand("password 10102dmmdnsas7721jmm");
	}
	SetTimer("GMXA", 300000, 0);
}

forward GMXA();
public GMXA() {
	foreach(new i : Player) {
		SendClientMessage(i, COLOR_YELLOW, "O servidor sofrerá um GMX AGORA. Você será KICKADO.");
		SaveCharacterInfo(i);
		SaveUserInfo(i);
		Kick(i);
	}
	SetTimer("GMXF", 400, 0);
}
forward GMXF();
public GMXF() {
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

        foreach (new i : Player) if (uInfo[i][uAdmin] >= 1) SendClientMessage(i, color, string);
		return true;
	}
	foreach (new i : Player) if (uInfo[i][uAdmin] >= 1) SendClientMessage(i, color, string);
	return true;
}

Dialog:TeleportInterior(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    SetPlayerInterior(playerid, g_arrInteriorData[listitem][e_InteriorID]);
	    SetPlayerPos(playerid, g_arrInteriorData[listitem][e_InteriorX], g_arrInteriorData[listitem][e_InteriorY], g_arrInteriorData[listitem][e_InteriorZ]);
	}
	return true;
}

SendPlayerToPlayer(playerid, userid)
{
	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(userid, x, y, z);

	if (IsPlayerInAnyVehicle(playerid))
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), x, y + 2, z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(userid));
	}
	else

	SetPlayerPos(playerid, x + 1, y, z);

	SetPlayerInterior(playerid, GetPlayerInterior(userid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(userid));
}