CMD:checarcorpo(playerid, params[]){
    static bodyid;
    new count = 0;

    if ((bodyid = GetClosestDeadBody(playerid)) != -1) {
		SendServerMessage(playerid, "Voc� est� pr�ximo do corpo: %d.", bodyid);
		count++;
	}

    if(!count) SendErrorMessage(playerid, "Voc� n�o est� pr�ximo de nenhum corpo.");
    return true;
}