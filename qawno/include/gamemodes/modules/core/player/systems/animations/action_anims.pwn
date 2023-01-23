CMD:stopanim(playerid)
{
	if (IsPlayerInAnyVehicle(playerid)) return true;
	ClearAnimations(playerid, 1);
	return true;
}

CMD:renderse(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return true;
}

CMD:mijar(playerid)
{
	SetPlayerSpecialAction(playerid, 68);
	return true;
}

CMD:tapinha(playerid)
{
	ApplyAnimation(playerid, "BASEBALL", "Bat_M", 4.1, false, false, false, false, 0);
	return true;
}

CMD:bomba(playerid)
{
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, false, 0);
	return true;
}

CMD:carry(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/carry [1-6]");
	if (type < 1 || type > 6) return SendErrorMessage(playerid, "Essa � uma anima��o invalida.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "CARRY", "liftup", 4.1, false, false, false, false, 0);
	    case 2: ApplyAnimation(playerid, "CARRY", "liftup05", 4.1, false, false, false, false, 0);
	    case 3: ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, false, false, false, false, 0);
	    case 4: ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, false, false, false, false, 0);
	    case 5: ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, false, false, false, false, 0);
	    case 6: ApplyAnimation(playerid, "CARRY", "putdwn105", 4.1, false, false, false, false, 0);
	}
	return true;
}

CMD:comer(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/comer [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Essa � uma anima��o invalida.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, false, false, false, false, 0);
	    case 2: ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 4.1, false, false, false, false, 0);
	    case 3: ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, false, false, false, false, 0);
	}
	return true;
}

CMD:chat(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/chat [1-6]");
	if (type < 1 || type > 6) return SendErrorMessage(playerid, "Essa � uma anima��o invalida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkE", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkF", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkG", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkH", 4.1, false, false, false, false, 0);
	}
	return true;
}

CMD:goggles(playerid)
{
	ApplyAnimation(playerid, "goggles", "goggles_put_on", 4.1, false, false, false, false, 0);
	return true;
}

CMD:jogar(playerid)
{
	ApplyAnimation(playerid, "GRENADE", "WEAPON_throw", 4.1, false, false, false, false, 0);
	return true;
}

CMD:swipe(playerid)
{
	ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, false, false, false, false, 0);
	return true;
}

CMD:beijo(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type)) return SendSyntaxMessage(playerid, "/beijo [1-6]");
	if (type < 1 || type > 6) return SendErrorMessage(playerid, "Essa � uma anima��o invalida.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_01", 4.1, false, false, false, false, 0);
		case 5: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.1, false, false, false, false, 0);
		case 6: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_03", 4.1, false, false, false, false, 0);
	}
	return true;
}

CMD:dj(playerid, params[])
{
  	static type;

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/dj [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Essa � uma anima��o invalida.");

	switch (type) {
    case 1: ApplyAnimationEx(playerid, "SCRATCHING", "scdldlp", 4.1, false, false, false, false, 0);
		case 2: ApplyAnimationEx(playerid, "SCRATCHING", "scdlulp", 4.1, false, false, false, false, 0);
		case 3: ApplyAnimationEx(playerid, "SCRATCHING", "scdrdlp", 4.1, false, false, false, false, 0);
		case 4: ApplyAnimationEx(playerid, "SCRATCHING", "scdrulp", 4.1, false, false, false, false, 0);
	}
	return true;
}

CMD:bebado(playerid)
{
	ApplyAnimation(playerid, "PED", "WALK_drunk", 4.1, true, true, true, true, 1);
	return true;
}

CMD:chorar(playerid)
{
	ApplyAnimation(playerid, "GRAVEYARD", "mrnF_loop", 4.1, false, false, false, false, 0);
	return true;
}