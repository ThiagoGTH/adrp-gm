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
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /aremovercallsign, /checarveiculos, /novato, /ferimentos (em modo trabalho)");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 1]{FFFFFF} /recuperar, /deletarcorpo, /acuracia");
	} 
	if(GetPlayerAdmin(playerid) >= 3) // GAME ADMIN 2
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 2]{FFFFFF} /skin, /jetpack, /checarip, /ultimoatirador, /resetararmas, /encerrarsinuca");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 2]{FFFFFF} /resetaraparencia, /entrarveiculo, /abrutal, /amatar");
	}
	if(GetPlayerAdmin(playerid) >= 4) // GAME ADMIN 3
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 3]{FFFFFF} /curartodos, /clima, /redflag, /criarcasa, /deletarcasa, /editarcasa, /criarentrada");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 3]{FFFFFF} /editarentrada, /deletarentrada");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 3]{FFFFFF} /criarveiculo, /editarveiculo, /deletarveiculo, /amotor, /areparar, /resetaraparencia");
		va_SendClientMessage(playerid, -1, "{33AA33}[GAME ADMIN 3]{FFFFFF} /resetarinventario, /listaitem, /daritem");
	}
	if(GetPlayerAdmin(playerid) >= 5) // LEAD ADMIN
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[LEAD ADMIN]{FFFFFF} /setarequipe, /dararma, /setaradmin, /limparhistoricoban, /gerenciar, /darveiculo, /doublepd, /criarsinuca, /deletarsinuca");
		va_SendClientMessage(playerid, -1, "{33AA33}[LEAD ADMIN]{FFFFFF} /darcaravana, /darpet, /destruirinvestimento, /avobjeto, /checarspecs");
		va_SendClientMessage(playerid, -1, "{33AA33}[LEAD ADMIN]{FFFFFF} /darlicenca");
	}
	if(GetPlayerAdmin(playerid) >= 1337) // MANAGEMENT
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[MANAGEMENT]{FFFFFF} /dardinheiro, /gmx, /trancarserver, /fly, /pegarpaycheck, /atualizarinvestimentos, /gravidade, /resetardinheiro");
	}
	if(GetUserTeam(playerid, 1)) // Faction Team
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[FACTION TEAM]{FFFFFF} /criarfaccao, /deletarfaccao, /editarfaccao");
	}
	if(GetUserTeam(playerid, 2)) // Property Team
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[PROPERTY TEAM]{FFFFFF} /criarcasa, /deletarcasa, /editarcasa, /ircasa, /criarcasaentrada, /editarcasaentrada, /deletarcasaentrada");
		va_SendClientMessage(playerid, -1, "{33AA33}[PROPERTY TEAM]{FFFFFF} /ircasaentrada, /listacasaentradas, /atrancar, /criarinvestimento, /editarinvestimento, /deletarinvestimento");
		va_SendClientMessage(playerid, -1, "{33AA33}[PROPERTY TEAM]{FFFFFF} /criarbancario, /deletarbancario, /criaratm, /editaratm, /deletaratm");
	}
	if(GetUserTeam(playerid, 3)) // Event Team
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[EVENT TEAM]{FFFFFF} N/A");
	}
	if(GetUserTeam(playerid, 4)) // CK Team
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[CK TEAM]{FFFFFF} N/A");
	}
	if(GetUserTeam(playerid, 5)) // Log Team
	{
		va_SendClientMessage(playerid, -1, "{33AA33}[LOG TEAM]{FFFFFF} /logs");
	}
	return true;
}