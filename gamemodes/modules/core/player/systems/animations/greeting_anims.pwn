CMD:cumprimentar(playerid, params[])
{
	static userid, type;
	if (sscanf(params, "ud", userid, type)) return SendSyntaxMessage(playerid, "/cumprimentar [id/nome] [1-6]");
	if (!IsPlayerLogged(userid)) return SendErrorMessage(playerid, "Esse jogador está desconectado.");
	if (userid == playerid) return SendErrorMessage(playerid, "Você não pode cumprimentar a si mesmo.");
	if (!IsPlayerNearPlayer(playerid, userid, 6.0)) return SendErrorMessage(playerid, "Esse jogador está muito distante de você.");
	if (type < 1 || type > 6) return SendErrorMessage(playerid, "Esse é um cumprimento inválido.");

	pInfo[userid][pGreetingOffer] = playerid;
	pInfo[userid][pGreetingType] = type;

	SendServerMessage(userid, "%s lhe ofereceu um aperto de mão (Use \"/aceitarcumprimento\").", pNome(playerid));
	SendServerMessage(playerid, "Você ofereceu um aperto de mão para %s.", pNome(userid));
	return 1;
}

CMD:aceitarcumprimento(playerid)
{
	new userid = pInfo[playerid][pGreetingOffer];

	if (!IsPlayerNearPlayer(playerid, userid, 6.0)) return SendErrorMessage(playerid, "Esse jogador está muito distante de você.");

	SetPlayerToFacePlayer(playerid, userid);
	SetPlayerToFacePlayer(userid, playerid);

	switch (pInfo[playerid][pGreetingOffer]) {
		case 1: {
			ApplyAnimation(playerid, "GANGS", "hndshkaa", 4.0, false, false, false, false, 0);
			ApplyAnimation(userid, "GANGS", "hndshkaa", 4.0, false, false, false, false, 0);
		}
		case 2:
		{
			ApplyAnimation(playerid, "GANGS", "hndshkba", 4.0, false, false, false, false, 0);
			ApplyAnimation(userid, "GANGS", "hndshkba", 4.0, false, false, false, false, 0);
		}
		case 3:
		{
			ApplyAnimation(playerid, "GANGS", "hndshkda", 4.0, false, false, false, false, 0);
			ApplyAnimation(userid, "GANGS", "hndshkda", 4.0, false, false, false, false, 0);
		}
		case 4:
		{
			ApplyAnimation(playerid, "GANGS", "hndshkea", 4.0, false, false, false, false, 0);
			ApplyAnimation(userid, "GANGS", "hndshkea", 4.0, false, false, false, false, 0);
		}
		case 5:
		{
			ApplyAnimation(playerid, "GANGS", "hndshkfa", 4.0, false, false, false, false, 0);
			ApplyAnimation(userid, "GANGS", "hndshkfa", 4.0, false, false, false, false, 0);
		}
		case 6:
		{
			ApplyAnimation(playerid, "GANGS", "prtial_hndshk_biz_01", 4.0, false, false, false, false, 0);
			ApplyAnimation(userid, "GANGS", "prtial_hndshk_biz_01", 4.0, false, false, false, false, 0);
		}
  	}

	pInfo[playerid][pGreetingOffer] = INVALID_PLAYER_ID;
	pInfo[playerid][pGreetingType] = 0;

	SendServerMessage(playerid, "Você aceitou o cumprimento de %s.", pNome(userid));
	SendServerMessage(userid, "%s aceitou seu cumprimento.", pNome(playerid));
  	return 1;
}

CMD:acenar(playerid, params[])
{
	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/acenar [1-3]");
	if (type < 1 || type > 3) return SendErrorMessage(playerid, "Esse não é um aceno válido.");
	
	switch (type) {
		case 1: ApplyAnimation(playerid, "PED", "endchat_03", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "KISSING", "gfwave2", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.1, false, false, false, false, 0);
	}
	return 1;
}