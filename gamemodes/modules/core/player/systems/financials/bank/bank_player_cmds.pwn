CMD:banco(playerid, params[]) {
	if(!IsPlayerNearBanker(playerid)) return SendErrorMessage(playerid, "Você não está perto de um atendente do banco.");

	SetPVarInt(playerid, "usingATM", 0);
	Bank_ShowMenu(playerid);
	return true;
}

CMD:atm(playerid, params[]) {
	new id = GetClosestATM(playerid);
    if(id == -1) return SendErrorMessage(playerid, "Você não está perto de um ATM.");

    SetPVarInt(playerid, "usingATM", 1);
	Bank_ShowMenu(playerid);
	return true;
}