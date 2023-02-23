CMD:strip(playerid, params[])
{
  	static type;
  
	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/strip [1-7]");

	if (type < 1 || type > 7) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "STRIP", "strip_A", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "STRIP", "strip_B", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "STRIP", "strip_C", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimation(playerid, "STRIP", "strip_D", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimation(playerid, "STRIP", "strip_E", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimation(playerid, "STRIP", "strip_F", 4.1, false, false, false, false, 0);
		case 7: ApplyAnimation(playerid, "STRIP", "strip_G", 4.1, false, false, false, false, 0);
	}
	return 1;
}