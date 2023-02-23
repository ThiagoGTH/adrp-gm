CMD:dancar(playerid, params[])
{
	static type;

	if (sscanf(params, "d", type))
		return SendSyntaxMessage(playerid, "/dancar [1-4]");

	if (type < 1 || type > 14)
		return SendErrorMessage(playerid, "Essa é uma dança inválida.");

	switch (type) {
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
		case 5: ApplyAnimation(playerid, "DANCING", "dance_loop", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimation(playerid, "DANCING", "DAN_Left_A", 4.1, false, false, false, false, 0);
		case 7: ApplyAnimation(playerid, "DANCING", "DAN_Right_A", 4.1, false, false, false, false, 0);
		case 8: ApplyAnimation(playerid, "DANCING", "DAN_Loop_A", 4.1, false, false, false, false, 0);
		case 9: ApplyAnimation(playerid, "DANCING", "DAN_Up_A", 4.1, false, false, false, false, 0);
		case 10: ApplyAnimation(playerid, "DANCING", "DAN_Down_A", 4.1, false, false, false, false, 0);
		case 11: ApplyAnimation(playerid, "DANCING", "dnce_M_a", 4.1, false, false, false, false, 0);
		case 12: ApplyAnimation(playerid, "DANCING", "dnce_M_e", 4.1, false, false, false, false, 0);
		case 13: ApplyAnimation(playerid, "DANCING", "dnce_M_b", 4.1, false, false, false, false, 0);
		case 14: ApplyAnimation(playerid, "DANCING", "dnce_M_c", 4.1, false, false, false, false, 0);
	}
	return 1;
}

CMD:taichi(playerid)
{
	ApplyAnimationEx(playerid, "PARK", "Tai_Chi_Loop", 4.1, false, false, false, false, 0);
	return 1;
}