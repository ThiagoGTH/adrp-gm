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

CMD:pegarcorpo(playerid, params[]) {
    static bodyid = -1;
    bodyid = GetClosestDeadBody(playerid);
    if(bodyid == -1) SendErrorMessage(playerid, "Você não está próximo de nenhum corpo.");

    DraggingCorpse[playerid] = DeadBody[bodyid][e_ACTOR];
    CorpseID[playerid] = bodyid;
    format(CarryingCorpse[playerid], 24, "%s", DeadBody[playerid][e_NAME]);
    CorpseTimer[playerid] = repeat UpdateCorpse(playerid);

    if(IsValidDynamic3DTextLabel(DeadBody[bodyid][e_TEXT])) {
        DestroyDynamic3DTextLabel(DeadBody[bodyid][e_TEXT]);
    }
    return true;
}

CMD:largarcorpo(playerid, params[]) {
    if(DraggingCorpse[playerid] == INVALID_ACTOR_ID)
        return SendErrorMessage(playerid, "Você não está carregando nenhum corpo.");

    new actor = DraggingCorpse[playerid], bodyid = CorpseID[playerid];
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s colocou o corpo de %s no chão.", pNome(playerid), DeadBody[actor][e_NAME]);
    stop CorpseTimer[playerid];
    ClearActorAnimations(actor);

    GetPlayerPos(playerid, DeadBody[bodyid][e_POS][0], DeadBody[bodyid][e_POS][1], DeadBody[bodyid][e_POS][2]);
    GetPlayerFacingAngle(playerid, DeadBody[bodyid][e_POS][3]);
    DeadBody[bodyid][e_INTERIOR] = GetPlayerInterior(playerid);
	DeadBody[bodyid][e_WORLD] = GetPlayerVirtualWorld(playerid);

    SetActorPos(actor, DeadBody[bodyid][e_POS][0]+0.5, DeadBody[bodyid][e_POS][1], DeadBody[bodyid][e_POS][2]);
    SetActorFacingAngle(actor, DeadBody[bodyid][e_POS][3]-180);
    SetActorVirtualWorld(actor, DeadBody[bodyid][e_WORLD]);
    ApplyActorAnimation(actor, "PED", "FLOOR_hit", 25.0, false, true, true, true, 1);

    new string[256];
    format(string, sizeof(string), "{D0AEEB}* Possível notar um corpo *\n* %s *{AFAFAF}\n(( %s (%d) ))", DeadBody[bodyid][e_DEADBY], DeadBody[bodyid][e_NAME], bodyid);

    DeadBody[bodyid][e_TEXT] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, DeadBody[bodyid][e_POS][0], DeadBody[bodyid][e_POS][1], DeadBody[bodyid][e_POS][2]-0.5, 5.0);

    DraggingCorpse[playerid] = INVALID_ACTOR_ID;
    CorpseID[playerid] = -1;
    return true;
}