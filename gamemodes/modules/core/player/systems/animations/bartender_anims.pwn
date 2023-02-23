CMD:bar(playerid, params[])
{
  	static type;
	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/bar [1-8]");
	if (type < 1 || type > 8) return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "BAR", "Barserve_give", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "BAR", "Barserve_glass", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimation(playerid, "BAR", "Barserve_in", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimation(playerid, "BAR", "Barserve_order", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimationEx(playerid, "BAR", "BARman_idle", 4.1, false, false, false, false, 0);
		case 7: ApplyAnimationEx(playerid, "BAR", "dnk_stndM_loop", 4.1, false, false, false, false, 0);
		case 8: ApplyAnimationEx(playerid, "BAR", "dnk_stndF_loop", 4.1, false, false, false, false, 0);
	}
	return 1;
}
