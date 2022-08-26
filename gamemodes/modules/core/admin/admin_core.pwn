/*

Este módulo é dedicado aos administradores

*/
 
#include <YSI_Coding\y_hooks>

AdminRankName(playerid) {
	new rank[128];
	switch(uInfo[playerid][uAdmin]) {
		case 1: format(rank, sizeof(rank), "Tester");
		case 2: format(rank, sizeof(rank), "Game Admin 1");
		case 3: format(rank, sizeof(rank), "Game Admin 2");
		case 4: format(rank, sizeof(rank), "Game Admin 3");
		case 5: format(rank, sizeof(rank), "Lead Admin");
        case 1337: format(rank, sizeof(rank), "Management");
		default: format(rank, sizeof(rank), "Inválido");
	}
	return rank;
}

GetPlayerAdmin(playerid) {
	new level;
	level = uInfo[playerid][uAdmin];
	return level;
}

GetUserTeam(playerid, team) {
	if (team == 1) { // Faction Team
		if (uInfo[playerid][uFactionTeam] == 1) return true;
		else return false;
	} else if (team == 2) { // Property Team
		if (uInfo[playerid][uPropertyTeam] == 1) return true;
		else return false;
	} else if (team == 3) { // Event Team
		if (uInfo[playerid][uEventTeam] == 1) return true;
		else return false;
	} else if (team == 4) { // CK Team
		if (uInfo[playerid][uCKTeam] == 1) return true;
		else return false;
	} else if (team == 5) { // Log Team
		if (uInfo[playerid][uLogTeam] == 1) return true;
		else return false;	
	}
	return false;
}

CMD:pegaradmin(playerid, params[]) {	
  	uInfo[playerid][uAdmin] = 1337;
	SaveUserInfo(playerid);
	return true;
}

CMD:aa(playerid, params[]) {	
  	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	ShowAdminCmds(playerid);
	return true;
}

ShowAdminCmds(playerid){
	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	if(GetPlayerAdmin(playerid) >= 1) {
	    va_SendClientMessage(playerid, -1, "{33AA33}_______________________________ {FFFFFF}COMANDOS ADMINISTRATIVOS{33AA33} _______________________________");
	}
	if(GetPlayerAdmin(playerid) >= 1) // TESTER
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[TESTER]{FFFFFF} /a, /aa, /personagens, /usuario, /listasos, /aj, /rj, /cs, /fs, /tj, /vw");
		va_SendClientMessage(playerid, -1, "{33AA33}[TESTER]{FFFFFF} /setarinterior");
	}
	if(GetPlayerAdmin(playerid) >= 2) // GAME ADMIN 1
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /listareports, /ar, /rr, /tapa, /vida, /reviver, /reclife, /ir, /trazer");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /colete, /infoplayer, /congelar, /descongelar, /ultimoatirador, /x, /y, /z");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /ban, /banoff, /bantemp, /bantempoff, /desban, /checarban, /spec");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /ajail, /ajailoff, /kick, /historico, /ircasa, /irentrada, /atrancar");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /listaentradas, /irveiculo, /trazerveiculo, /respawnarveiculo, /rtc");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /aremovercallsign, /checarveiculos");
	} 
	if(GetPlayerAdmin(playerid) >= 3) // GAME ADMIN 2
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 2]{FFFFFF} /skin, /jetpack, /checarip, /ultimoatirador, /resetararmas, /novato, /encerrarsinuca");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 2]{FFFFFF} /resetaraparencia, /entrarveiculo");
	}
	if(GetPlayerAdmin(playerid) >= 4) // GAME ADMIN 3
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 3]{FFFFFF} /curartodos, /clima, /redflag, /criarcasa, /deletarcasa, /editarcasa, /criarentrada");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 3]{FFFFFF} /editarentrada, /deletarentrada");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 3]{FFFFFF} /criarveiculo, /editarveiculo, /deletarveiculo, /amotor, /areparar");
	}
	if(GetPlayerAdmin(playerid) >= 5) // LEAD ADMIN
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[LEAD ADMIN]{FFFFFF} /setarequipe, /dararma, /setaradmin, /limparhistoricoban, /gerenciar, /darveiculo, /doublepd, /criarsinuca, /editarinvestimento");
		va_SendClientMessage(playerid, -1, "{33AA33}[LEAD ADMIN]{FFFFFF} /criarinvestimento, /destruirinvestimento, /darveiculo");
	}
	if(GetPlayerAdmin(playerid) >= 1335) // MANAGEMENT
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[MANAGEMENT]{FFFFFF} /dardinheiro, /gmx, /trancarserver, /fly, /pegarpaycheck, /atualizarinvestimentos");
	}
	return true;
}

CMD:trancarserver(playerid, params[]) {
    
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

CMD:tapa(playerid, params[]) {
	new
		userid;

	
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/tapa [playerid/nome]");
  	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	new
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

CMD:curartodos(playerid, params[]) {
	
    if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);
	foreach (new i : Player) {
	    SetPlayerHealth(i, pInfo[i][pHealthMax]);
	}
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s curou todos os jogadores on-line.", pNome(playerid));
	format(logString, sizeof(logString), "%s (%s) curou todos os jogadores on-lige.", pNome(playerid), GetPlayerUserEx(playerid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:vida(playerid, params[]) {
	static
		userid,
	  	Float:amount; 

	
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "uf", userid, amount)) return SendSyntaxMessage(playerid, "/vida [playerid/nome] [quantidade]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
	if (amount > pInfo[userid][pHealthMax]) return SendErrorMessage(playerid, "Você não pode aumentar a vida deste jogador além do limite dele. (Máximo: %.2f)");

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s setou a vida de %s em %.2f.", pNome(playerid), pNome(userid), amount);

	SetPlayerHealthEx(userid, amount);
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você setou %s com %.2f de vida.", pNome(userid), amount);
	format(logString, sizeof(logString), "%s (%s) setou %s com %.2f de vida.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), amount);
	logCreate(playerid, logString, 1);
	return true;
}

CMD:reclife(playerid, params[]) {
	static
		userid; 

	
  	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/reclife [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s recuperou a vida de %s.", pNome(playerid), pNome(userid));

	SetPlayerHealthEx(userid, pInfo[userid][pHealthMax]);
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você recuperou a vida de %s.", pNome(userid));
	format(logString, sizeof(logString), "%s (%s) recuperou a vida de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:colete(playerid, params[]) {
	static
		userid,
	    Float:amount;

	
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	if (sscanf(params, "uf", userid, amount)) return SendSyntaxMessage(playerid, "/colete [playerid/nome] [quantidade]");
	if (userid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

  	SetPlayerArmour(userid, amount);
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você setou %s com %.2f de colete.", pNome(userid), amount);
	format(logString, sizeof(logString), "%s (%s) setou %s com %.2f de colete.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), amount);
	logCreate(playerid, logString, 1);
	return true;
}

CMD:resetararmas(playerid, params[]) {
	static
		userid;

  	
  	if(GetPlayerAdmin(playerid) < 3) return SendPermissionMessage(playerid);
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/resetararmas [playerid/nome]");
  	if (userid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	ResetWeapons(userid);
	va_SendClientMessage(playerid, -1, "SERVER: Você resetou as armas de %s.", pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) resetou as armas de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:admins(playerid, params[]) {
	new count = 0;
	SendClientMessage(playerid, COLOR_GREEN, "Equipe administrativa on-line:");

    foreach (new i : Player) if (uInfo[i][uAdmin] > 0)
	{
		if(pInfo[playerid][pAdminDuty])
			va_SendClientMessage(playerid, COLOR_GREEN, "%s %s (%s) (ID: %d) | Status: Em serviço administrativo", AdminRankName(i), pNome(i), GetPlayerUserEx(i), i);
		else
			va_SendClientMessage(playerid, COLOR_GREY, "%s %s (%s) | Status: Em roleplay", AdminRankName(i), pNome(i), GetPlayerUserEx(i));
        count++;
	}
	if (!count) {
	    SendClientMessage(playerid, COLOR_WHITE, "Não há nenhum administrador online no momento.");
	}
	return true;
}

CMD:atrabalho(playerid, params[]) {
	
  	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	
	if (!pInfo[playerid][pAdminDuty]){
		SetPlayerColor(playerid, 0x408080FF);
		pInfo[playerid][pAdminDuty] = 1;
		SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%s) entrou em trabalho administrativo.", pNome(playerid), GetPlayerUserEx(playerid));
		format(logString, sizeof(logString), "%s (%s) entrou em trabalho administrativo.", pNome(playerid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 1);
	}else{
	    SetPlayerColor(playerid, DEFAULT_COLOR);
		pInfo[playerid][pAdminDuty] = 0;
		SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%s) saiu do trabalho administrativo.", pNome(playerid), GetPlayerUserEx(playerid));
		format(logString, sizeof(logString), "%s (%s) saiu do trabalho administrativo.", pNome(playerid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 1);
	}
	return true;
}

CMD:infoplayer(playerid, params[]) {
	
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new userid;
	if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/infoplayer [nome/playerid]");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	if(userid != INVALID_PLAYER_ID){

		va_SendClientMessage(playerid, COLOR_GREEN, "|________[ EXIBINDO INFORMAÇÕES ]________|");
		va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Nome: {FFFFFF}%s (%s)", pNome(userid), GetPlayerUserEx(playerid));
		va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Interior: {FFFFFF}%d", GetPlayerInterior(userid));
		va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Virtual World: {FFFFFF}%d", GetPlayerVirtualWorld(userid));
		va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Ping: {FFFFFF}%d", GetPlayerPing(userid));
		va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Colete: {FFFFFF}%.1f", GetPlayerArmourEx(userid));
		va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Vida: {FFFFFF}%.1f", GetPlayerHealthEx(userid));
        va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Arma: {FFFFFF}%s", ReturnWeaponName(GetPlayerWeapon(userid)));
		va_SendClientMessage(playerid, COLOR_LIGHTRED, "{FF6347}Munição: {FFFFFF}%d", GetPlayerAmmo(userid));
		if(GetPlayerAmmo(userid) == 40 || GetPlayerAmmo(userid) == 36 || GetPlayerAmmo(userid) == 18 || GetPlayerAmmo(userid) == 28 || GetPlayerAmmo(userid) == 37) SendServerMessage(playerid, "Atenção neste jogador, é possível que ele esteja utilizando algum cheater de armas. Investigue com cautela.");
	}
	return true;
} 

CMD:skin(playerid, params[]) {
	
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

CMD:proximo(playerid, params[]) {
    
	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	static id = -1;
	new count = 0;

	if(GetPlayerAdmin(playerid) > 5){
		if ((id = Pool_GetClosestTable(playerid)) != -1) {
			SendServerMessage(playerid, "Você está próximo da mesa de sinuca: %d.", id);
			count++;
		}
	}

	if(!count) SendErrorMessage(playerid, "Você não está próximo a nada dinâmico.");
	return true;
}

CMD:congelar(playerid, params[]) {
	
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new userid;
	if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/congelar [playerid/nome]");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	if(GetPlayerAdmin(userid) >= 1335 && GetPlayerAdmin(playerid) < 1335) SendErrorMessage(playerid, "Você não pode congelar um management!");
	
	TogglePlayerControllable(userid, false);
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s congelou %s.", pNome(playerid), pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) congelou %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:descongelar(playerid, params[]) {
	
  	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new userid;
	if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/descongelar [playerid/nome]");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);

	TogglePlayerControllable(userid, true);
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s descongelou %s.", pNome(playerid), pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) descongelou %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:dararma(playerid, params[]) {
	static
	    userid,
	    weaponid,
	    ammo;

    
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
	if (sscanf(params, "udI(500)", userid, weaponid, ammo)) return SendSyntaxMessage(playerid, "/dararma [playerid/nome] [arma id] [munição]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
	if (!IsPlayerSpawned(userid)) return SendNotConnectedMessage(playerid);
	if (weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21)) return SendErrorMessage(playerid, "Você específicou uma arma inválida.");

	GiveWeaponToPlayer(userid, weaponid, ammo);
	va_SendClientMessage(playerid, -1, "SERVER: Você deu para %s uma %s com %d munições.", pNome(userid), ReturnWeaponName(weaponid), ammo);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s deu uma %s(%d) para %s.", pNome(playerid), ReturnWeaponName(weaponid), ammo, pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) deu uma %s (ID:%d AMMO:%d) para %s.", pNome(playerid), GetPlayerUserEx(playerid), ReturnWeaponName(weaponid), weaponid, ammo, pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:dardinheiro(playerid, params[]){
	static
		userid,
	    amount;

	
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
    
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    new userid, admin;
    if(sscanf(params, "ud", userid, admin)) return SendSyntaxMessage(playerid,"/setaradmin [playerID/Nome] [admin level]");
    if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	if(admin > GetPlayerAdmin(playerid)) return SendErrorMessage(playerid, "Você não pode promover acima do seu nível.");
	
	if(GetPlayerAdmin(playerid) > 5){
		if (admin < 0 || admin > 1337)
			return SendClientMessage(playerid, COLOR_GREY, "Level inválido. Os niveis devem variar entre 0 a 1337.");

		if(GetPlayerAdmin(userid) >= 0) {
			uInfo[userid][uAdmin] = admin;
			va_SendClientMessage(playerid, COLOR_YELLOW,"Você promoveu %s para %s.", pNome(userid), AdminRankName(userid));
			va_SendClientMessage(userid, COLOR_YELLOW,"%s promoveu você para %s.", pNome(playerid), AdminRankName(userid));
			SaveUserInfo(userid);
		}
		else {
			uInfo[userid][uAdmin] = admin;
			va_SendClientMessage(playerid, COLOR_YELLOW,"Você removeu %s do quadro administrativo.", pNome(userid));
			va_SendClientMessage(userid, COLOR_YELLOW,"%s removeu você do quadro administrativo.", pNome(playerid));
			SaveUserInfo(userid);
		}
	} else { 
		if (admin < 0 || admin > 5) return SendClientMessage(playerid, COLOR_GREY, "Level inválido. Os niveis devem variar entre 0 a 4.");
		if (admin > GetPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Você não pode promover acima do seu nível.");

		if(GetPlayerAdmin(userid) >= 0) {
			uInfo[userid][uAdmin] = admin;
			va_SendClientMessage(playerid, COLOR_YELLOW,"Você promoveu %s para %s.", pNome(userid), AdminRankName(userid));
			va_SendClientMessage(userid, COLOR_YELLOW,"%s promoveu você para %s.", pNome(playerid), AdminRankName(userid));
			SaveUserInfo(userid);
		}
		else {
			uInfo[userid][uAdmin] = admin;
			va_SendClientMessage(playerid, COLOR_YELLOW,"Você removeu %s do quadro administrativo.", pNome(userid));
			va_SendClientMessage(userid, COLOR_YELLOW,"%s removeu você do quadro administrativo.", pNome(playerid));
			SaveUserInfo(userid);
		}
	}
    return true;
}

CMD:a(playerid, result[]) {
	if(GetPlayerAdmin(playerid) < 1) return SendPermissionMessage(playerid);
	if(isnull(result)) return SendSyntaxMessage(playerid, "/a (mensagem)");

	// JOGO:
	if (strlen(result) > 64){
	    SendAdminAlert(COLOR_ADMINCHAT, "[STAFF] %s %s (%s): %.64s", AdminRankName(playerid), pNome(playerid), GetPlayerUserEx(playerid), result);
	    SendAdminAlert(COLOR_ADMINCHAT, "...%s **", result[64]);
	}
	else SendAdminAlert(COLOR_ADMINCHAT, "[STAFF] %s %s (%s): %s", AdminRankName(playerid), pNome(playerid), GetPlayerUserEx(playerid), result);

	// DISCORD:
	new str[1024], dest[1024];
	format(str, sizeof(str), "[STAFF] %s %s (%s): %s", AdminRankName(playerid), pNome(playerid), GetPlayerUserEx(playerid), result);
	utf8encode(dest, str);
	DCC_SendChannelMessage(DCC_FindChannelById("989306920517136464"), dest);
	return true;
}

CMD:gmx(playerid, params[]) {
    
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

CMD:trazer(playerid, params[]) {
  	if(GetPlayerAdmin(playerid) < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse administrador está em modo espectador em alguém, por isso não pode puxa-lo.");

	new userid, Float: PlayerPos[3];
	GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/trazer [id/nick]");
	if(!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	SetPlayerPos(userid, PlayerPos[0], PlayerPos[1] + 2.0, PlayerPos[2]);
	
	format(logString, sizeof(logString), "%s (%s) levou %s até ele.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:ir(playerid, params[]) {
	static
	  	id,
	  	type[24],
		string[64];

	if(GetPlayerAdmin(playerid) < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

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
			Dialog_Show(playerid, goToInt, DIALOG_STYLE_LIST, "Ir > Interior", "Interiores Nativos\nInteriores Personalizados", "Selecionar", "Cancelar");
		    return true;
		} else return SendErrorMessage(playerid, "Você específicou um jogador inválido.");
	}
	if (!IsPlayerSpawned(id)) return SendErrorMessage(playerid, "Você não pode ir até um jogador que não spawnou.");
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse administrador está em modo espectador em alguém, por isso não pode ir até o mesmo.");

	SendPlayerToPlayer(playerid, id);

	
	format(logString, sizeof(logString), "%s (%s) foi até %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(id));
	logCreate(playerid, logString, 1);
	return true;
}

Dialog:goToInt(playerid, response, listitem, inputtext[]){
	if(response){
		if(listitem == 0){
			static
		        str[1536];
			str[0] = '\0';
			for (new i = 0; i < sizeof(g_arrInteriorData); i ++) {
			    strcat(str, g_arrInteriorData[i][e_InteriorName]);
			    strcat(str, "\n");
		    }
		    Dialog_Show(playerid, TeleportInterior, DIALOG_STYLE_LIST, "Ir > Interior > Nativos", str, "Selecionar", "Cancelar");
		}
		else if(listitem == 1){
			mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors_info WHERE `ID` >= 0");
            new Cache:result = mysql_query(DBConn, query);

            new string[1024], intName[64], intID;
            format(string, sizeof(string), "Nome\tID\n");
			for(new i; i < cache_num_rows(); i++){
				cache_get_value_name_int(i, "ID", intID);
				cache_get_value_name(i, "name", intName);

				format(string, sizeof(string), "%s%s\t%d\n", string, intName, intID);
            }
            cache_delete(result);

            Dialog_Show(playerid, goToPerInt, DIALOG_STYLE_TABLIST_HEADERS, "Ir > Interior > Personalizados", string, "Selecionar", "Voltar");
		}
	} 
	return true;
}

Dialog:goToPerInt(playerid, response, listitem, inputtext[]){
	if(response){
		new Float:pos[4], vw, int;
		format(pInfo[playerid][tempChar], 64, "%s", inputtext);
		mysql_format(DBConn, query, sizeof query, "SELECT * FROM interiors_info WHERE `name` = '%s'", pInfo[playerid][tempChar]);
        new Cache:result = mysql_query(DBConn, query);

        cache_get_value_name_float(0, "positionX", pos[0]);
		cache_get_value_name_float(0, "positionY", pos[1]);
		cache_get_value_name_float(0, "positionZ", pos[2]);
		cache_get_value_name_float(0, "positionA", pos[3]);
		cache_get_value_name_int(0, "interior", int);
    	cache_get_value_name_int(0, "virtual_world", vw);
        cache_delete(result);

		SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		SetPlayerFacingAngle(playerid, pos[3]);
		SetPlayerInterior(playerid, int);
		SetPlayerVirtualWorld(playerid, vw);

		SendServerMessage(playerid, "Você se teleportou para o interior '%s'.", pInfo[playerid][tempChar]);
		pInfo[playerid][tempChar][0] =  EOS;
		return true;
	}
	return true;
}

CMD:x(playerid, params[]){
	
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new Float:x, Float:y, Float:z, Float:npos;
	if(sscanf(params, "f", npos)) return SendSyntaxMessage(playerid, "/x [Coodernada]");
	
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x+npos, y, z);
	return true;	
}

CMD:y(playerid, params[]){
	
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new Float:x, Float:y, Float:z, Float:npos;
	if(sscanf(params, "f", npos)) return SendSyntaxMessage(playerid, "/y [Coodernada]");
	
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x, y+npos, z);
	return true;	
}

CMD:z(playerid, params[]){
	
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new Float:x, Float:y, Float:z, Float:npos;
	
	if(sscanf(params, "f", npos)) SendSyntaxMessage(playerid, "/z [Coodernada]");
	
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x, y, z+npos);
	return true;	
}

CMD:spec(playerid, params[])
{
	
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);

	new userid;
	if (!isnull(params) && !strcmp(params, "off", true)) {
	    if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
			return SendServerMessage(playerid, "Você não está observando nenhum jogador.");

	    PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
	    PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);
		SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
		SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
	    SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 
        pInfo[playerid][pPositionX], 
        pInfo[playerid][pPositionY], 
        pInfo[playerid][pPositionZ],
        pInfo[playerid][pPositionA],
         0, 0, 0, 0, 0, 0);
	    TogglePlayerSpectating(playerid, false);
	    
	  	EmSpec[playerid] = INVALID_PLAYER_ID;
		format(logString, sizeof(logString), "%s (%s) parou de observar.", pNome(playerid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 1);

	  	return SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você não está mais no modo espectador.");
	}

	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/spec <playerID/Nome>");
	if (!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
	if (IsPlayerWatchingCamera(userid)) return SendErrorMessage(playerid, "O jogador está assistindo uma transmissão, então não é possível espectar ele.");
	if (GetPlayerState(userid) != PLAYER_STATE_SPECTATING) return SendErrorMessage(playerid, "O administrador está de spec em alguém, então não é possível espectar ele.");

	if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING){
		GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
		GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);

		pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
		pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
	}
	SetPlayerInterior(playerid, GetPlayerInterior(userid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(userid));

	TogglePlayerSpectating(playerid, true);

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

CMD:jetpack(playerid, params[]){
	
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

GiveGMX() {
	foreach(new i : Player) {
		SendClientMessage(i, COLOR_LIGHTRED, "O servidor sofrerá um GMX em cinco minutos. Finalize o que você está fazendo e deslogue.");
		SaveCharacterInfo(i);
		SaveUserInfo(i);
		printf("[GMX] Reiniciando o servidor em cinco minutos.");
		SendRconCommand("hostname Advanced Roleplay | REINICIANDO");
		SendRconCommand("password 10102dmmdnsas7721jmm");
	}
	SetTimer("GMXA", 300000, false);
}

forward GMXA();
public GMXA() {
	foreach(new i : Player) {
		SendClientMessage(i, COLOR_YELLOW, "O servidor sofrerá um GMX AGORA. Você será KICKADO.");
		SaveCharacterInfo(i);
		SaveUserInfo(i);
		Kick(i);
	}
	SetTimer("GMXF", 400, false);
}

forward GMXF();
public GMXF() {
	foreach(new i : Player)
	{
		SendRconCommand("gmx");
	}
}

SendAdminAlert(color, const str[], {Float,_}:...) {
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

Dialog:TeleportInterior(playerid, response, listitem, inputtext[]) {
	if (response)
	{
	    SetPlayerInterior(playerid, g_arrInteriorData[listitem][e_InteriorID]);
	    SetPlayerPos(playerid, g_arrInteriorData[listitem][e_InteriorX], g_arrInteriorData[listitem][e_InteriorY], g_arrInteriorData[listitem][e_InteriorZ]);
	}
	return true;
}

SendPlayerToPlayer(playerid, userid) {
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

CMD:kick(playerid, params[]) {
	
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new userid, reason[128];
	if (sscanf(params, "us[128]", userid, reason)) return SendSyntaxMessage(playerid, "/kick [playerid/nome] [motivo]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	
	va_SendClientMessageToAll(COLOR_LIGHTRED,"AdmCmd: %s kickou %s por: %s.", GetPlayerUserEx(playerid), pNome(userid), reason);
	KickEx(userid);

	// Cria o log administrativo
	format(logString, sizeof(logString), "%s (%s) kickou %s (%s) por %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), GetPlayerUserEx(userid), reason);
	logCreate(playerid, logString, 1);

	// Cria o histórico do jogador
	format(logString, sizeof(logString), "%s (%s) foi kickado por %s (motivo: %s)", pNome(userid), GetPlayerUserEx(userid), GetPlayerUserEx(playerid), reason);
	logCreate(playerid, logString, 11);

	return true;
}

CMD:historico(playerid, params[]) {
	
	if(GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/historico [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	mysql_format(DBConn, query, sizeof query, "SELECT * FROM serverlogs WHERE `user` = '%s' AND `type` = '11' ORDER BY `timestamp` DESC LIMIT 20;", GetPlayerUserEx(userid));
    new Cache:result = mysql_query(DBConn, query);

    if(!cache_num_rows()) return SendErrorMessage(playerid, "Este jogador não tem nenhuma punição registrada em seu usuário.");

    new string[2056], timestamp, log[255], title[256];
	format(title, sizeof(title), "{FFFFFF}Punições de %s", GetPlayerUserEx(userid));
    format(string, sizeof(string), "{FF6347}ATENÇÃO: As punições são exibidas de acordo com o horário e apenas as últimas vinte são contabilizadas.\nPara informações mais detalhadas, busque auxilio de um membro da Log Team.\n\n");
    for(new i; i < cache_num_rows(); i++){
        cache_get_value_name_int(i, "timestamp", timestamp);
        cache_get_value_name(i, "log", log);

        format(string, sizeof(string), "%s{AFAFAF}[%s] {36A717}%s\n", string, GetFullDate(timestamp), log);
    }
    cache_delete(result);

    Dialog_Show(playerid, showLog, DIALOG_STYLE_MSGBOX, title, string, "Fechar", "");

	format(logString, sizeof(logString), "%s (%s) checou o histórico de %s.", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerUserEx(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:redflag(playerid, params[]) {
	if (!pInfo[playerid][pLogged]) return true;
	if (GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);
	new userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/redflag [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	if (uInfo[userid][uRedFlag]) {
		uInfo[userid][uRedFlag] = 0;
		SaveUserInfo(userid);

		SendServerMessage(playerid, "Você desmarcou %s (%s) como redflag.", pNome(userid), GetPlayerUserEx(userid));

		SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s desmarcou %s como redflag.", GetPlayerUserEx(playerid), pNome(userid));

		// Cria o log administrativo
		format(logString, sizeof(logString), "%s (%s) desmarcou %s (%s) como redflag", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), GetPlayerUserEx(userid));
		logCreate(playerid, logString, 1);

		// Cria o histórico do jogador
		format(logString, sizeof(logString), "%s (%s) foi desmarcado como redflag por %s", pNome(userid), GetPlayerUserEx(userid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 11);		
	} else {
		uInfo[userid][uRedFlag] = 1337;
		SaveUserInfo(userid);

		SendServerMessage(playerid, "Você marcou %s (%s) como redflag.", pNome(userid), GetPlayerUserEx(userid));
		SendServerMessage(userid, "Você foi marcado como redflag por um administrador.");

		SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s marcou %s como redflag.", GetPlayerUserEx(playerid), pNome(userid));

		// Cria o log administrativo
		format(logString, sizeof(logString), "%s (%s) marcou %s (%s) como redflag", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), GetPlayerUserEx(userid));
		logCreate(playerid, logString, 1);

		// Cria o histórico do jogador
		format(logString, sizeof(logString), "%s (%s) foi marcado como redflag por %s", pNome(userid), GetPlayerUserEx(userid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 11);	
	}
	return true;
}

CMD:vw(playerid, params[]) {
	new id, vw;

	if(GetPlayerAdmin(playerid) < 1)
		return SendPermissionMessage(playerid);

	if(sscanf(params, "ud", id, vw))
		return SendSyntaxMessage(playerid, "/vw [id/nome] [id do vw]");

	if(!IsPlayerConnected(id)) 
		return SendNotConnectedMessage(playerid);


	SetPlayerVirtualWorld(id, vw);
	SendServerMessage(id, "O seu VW foi alterado por um administrador.");
	SendServerMessage(playerid, "Você alterou o VW de %s para o VW %d.", pNome(id), vw);

	return 1;
}

CMD:setarinterior(playerid, params[]) {
	new id, interior;

	if(GetPlayerAdmin(playerid) < 1)
		return SendPermissionMessage(playerid);

	if(sscanf(params, "ud", id, interior))
		return SendSyntaxMessage(playerid, "/setarinterior [id/nome] [interior]");

	if(!IsPlayerConnected(id)) 
		return SendNotConnectedMessage(playerid);

	SetPlayerInterior(id, interior);
	SendServerMessage(id, "O seu interior foi alterado por um administrador.");
	SendServerMessage(playerid, "Você alterou o interior de %s para o interior %d.", pNome(id), interior);

	return 1;
}