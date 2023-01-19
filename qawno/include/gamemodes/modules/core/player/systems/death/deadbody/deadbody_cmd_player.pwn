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

CMD:pegarcorpo(playerid, params[]) {
    static bodyid = -1;
    bodyid = GetClosestDeadBody(playerid);
    if(bodyid == -1) SendErrorMessage(playerid, "Voc� n�o est� pr�ximo de nenhum corpo.");

    DraggingCorpse[playerid] = DeadBody[bodyid][e_ACTOR];
    format(CarryingCorpse[playerid], 24, "%s", DeadBody[playerid][e_NAME]);
    CorpseTimer[playerid] = repeat UpdateCorpse(playerid);
    return true;
}

CMD:largarcorpo(playerid, params[]) {
    if(DraggingCorpse[playerid] == INVALID_ACTOR_ID)
        return SendErrorMessage(playerid, "Voc� n�o est� carregando nenhum corpo.");

    new actor = DraggingCorpse[playerid];
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "%s colocou o corpo de %s no ch�o.", pNome(playerid), DeadBody[actor][e_NAME]);
    DraggingCorpse[playerid] = INVALID_ACTOR_ID;
    stop CorpseTimer[playerid];
    ClearActorAnimations(actor);

    GetPlayerPos(playerid, DeadBody[playerid][e_POS][0], DeadBody[playerid][e_POS][1], DeadBody[playerid][e_POS][2]);
    GetPlayerFacingAngle(playerid, DeadBody[playerid][e_POS][3]);
    DeadBody[playerid][e_INTERIOR] = GetPlayerInterior(playerid);
	DeadBody[playerid][e_WORLD] = GetPlayerVirtualWorld(playerid);

    SetActorPos(actor, DeadBody[playerid][e_POS][0]+0.5, DeadBody[playerid][e_POS][1], DeadBody[playerid][e_POS][2]);
    SetActorFacingAngle(actor, DeadBody[playerid][e_POS][3]-180);
    SetActorVirtualWorld(actor, DeadBody[playerid][e_WORLD]);
    ApplyActorAnimation(actor, "PED", "FLOOR_hit", 25.0, false, true, true, true, 1);

    return true;
}