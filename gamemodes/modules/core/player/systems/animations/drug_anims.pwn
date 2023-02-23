CMD:fumar(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type))
		return SendSyntaxMessage(playerid, "/fumar [1-3]");

	if (type < 1 || type > 3)
		return SendErrorMessage(playerid, "Essa é uma animação invalida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "SMOKING", "M_smk_drag", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimationEx(playerid, "SMOKING", "M_smklean_loop", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 4.1, false, false, false, false, 0);
	}
	return 1;
}
