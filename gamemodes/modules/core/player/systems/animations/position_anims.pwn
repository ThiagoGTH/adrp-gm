CMD:sentar(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/sentar [1-11]");
	if (type < 1 || type > 11) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "BEACH", "bather", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "BEACH", "Lay_Bac_Loop", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimation(playerid, "BEACH", "ParkSit_W_loop", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimation(playerid, "BEACH", "SitnWait_loop_W", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loop", 4.1, true, false, false, false, 0);
		case 7: ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_In", 4.1, false, false, false, true, 0);
		case 8: ApplyAnimationEx(playerid, "MISC", "SEAT_LR", 4.1, true, false, false, false, 0);
		case 9: ApplyAnimationEx(playerid, "MISC", "Seat_talk_01", 4.1, true, false, false, false, 0);
		case 10: ApplyAnimationEx(playerid, "MISC", "Seat_talk_02", 4.1, true, false, false, false, 0);
		case 11: ApplyAnimationEx(playerid, "ped", "SEAT_down", 4.1, false, false, false, true, 0);
	}
	return 1;
}

CMD:crack(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/crack [1-6]");
	if (type < 1 || type > 6) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth1", 4.1, false, false, false, true, 0);
	    case 2: ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.1, false, false, false, false, 0);
	    case 3: ApplyAnimationEx(playerid, "CRACK", "crckdeth3", 4.1, false, false, false, true, 0);
	    case 4: ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.1, false, false, false, true, 0);
	    case 5: ApplyAnimationEx(playerid, "CRACK", "crckidle2", 4.1, false, false, false, true, 0);
	    case 6: ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.1, false, false, false, true, 0);
	}
	return 1;
}

CMD:dormir(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/dormir [1-2]");
	if (type < 1 || type > 2) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.1, false, false, false, true, 0);
	    case 2: ApplyAnimation(playerid, "CRACK", "crckidle4", 4.1, false, false, false, true, 0);
	}
	return 1;
}

CMD:escritorio(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/escritorio [1-6]");
	if (type < 1 || type > 6) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Drink", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Read", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Watch", 4.1, false, false, false, false, 0);
	}
	return 1;
}

CMD:abaixar(playerid)
{
	ApplyAnimationEx(playerid, "PED", "cower", 4.1, false, false, false, true, 0);
	return 1;
}

CMD:crossarms(playerid, params[])
{
    new type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/crossarms [1-4]");
	if (type < 1 || type > 4) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, false, true, true, true, 0);
	    case 2: ApplyAnimationEx(playerid, "GRAVEYARD", "prst_loopa", 4.1, false, false, false, false, 0);
	    case 3: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.1, false, false, false, false, 0);
	    case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.1, false, true, true, true, 0);
	}
	return 1;
}