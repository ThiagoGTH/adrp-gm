CMD:checarcorpo(playerid, params[]){
    static bodyid;
    new count = 0;

    if ((bodyid = GetClosestDeadBody(playerid)) != -1) {
		SendServerMessage(playerid, "Você está próximo do corpo: %d.", bodyid);
		count++;
	}

    if(!count) SendErrorMessage(playerid, "Você não está próximo de nenhum corpo.");
    return true;
}