CMD:gsign(playerid, params[])
{
  	static type;
	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/gsign [1-15]");
	if (type < 1 || type > 15) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "GHANDS", "gsign1", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "GHANDS", "gsign1LH", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "GHANDS", "gsign2", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimation(playerid, "GHANDS", "gsign2LH", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimation(playerid, "GHANDS", "gsign3", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimation(playerid, "GHANDS", "gsign3LH", 4.1, false, false, false, false, 0);
		case 7: ApplyAnimation(playerid, "GHANDS", "gsign4", 4.1, false, false, false, false, 0);
		case 8: ApplyAnimation(playerid, "GHANDS", "gsign4LH", 4.1, false, false, false, false, 0);
		case 9: ApplyAnimation(playerid, "GHANDS", "gsign5", 4.1, false, false, false, false, 0);
		case 10: ApplyAnimation(playerid, "GHANDS", "gsign5", 4.1, false, false, false, false, 0);
		case 11: ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.1, false, false, false, false, 0);
		case 12: ApplyAnimation(playerid, "GANGS", "Invite_No", 4.1, false, false, false, false, 0);
		case 13: ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.1, false, false, false, false, 0);
		case 14: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.1, false, false, false, false, 0);
		case 15: ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, false, false, false, false, 0);
	}
	return 1;
}

CMD:wave(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/wave [1-8]");
	if (type < 1 || type > 8) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "ON_LOOKERS", "shout_02", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "ON_LOOKERS", "shout_in", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimation(playerid, "RIOT", "RIOT_CHANT", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimation(playerid, "RIOT", "RIOT_shout", 4.1, false, false, false, false, 0);
		case 7: ApplyAnimation(playerid, "STRIP", "PUN_HOLLER", 4.1, false, false, false, false, 0);
		case 8: ApplyAnimation(playerid, "OTB", "wtchrace_win", 4.1, false, false, false, false, 0);
	}
	return 1;
}
