CMD:deal(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/deal [1-6]");
	if (type < 1 || type > 6) return SendErrorMessage(playerid, "Essa não é uma animação válida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "DEALER", "DRUGS_BUY", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "DEALER", "shop_pay", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_02", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_03", 4.1, false, false, false, false, 0);
	}
	return 1;
}