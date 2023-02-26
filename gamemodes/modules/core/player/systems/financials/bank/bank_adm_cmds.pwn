/******************************** [ATM] ********************************/
CMD:criaratm(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 3 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	new id = Iter_Free(ATMs);
	if(id == -1) return SendErrorMessage(playerid, "O servidor atingiu o limite de ATMs criados.");
	ATMData[id][atmRX] = ATMData[id][atmRY] = 0.0;

	GetPlayerPos(playerid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	GetPlayerFacingAngle(playerid, ATMData[id][atmRZ]);

	ATMData[id][atmX] += (2.0 * floatsin(-ATMData[id][atmRZ], degrees));
    ATMData[id][atmY] += (2.0 * floatcos(-ATMData[id][atmRZ], degrees));
    ATMData[id][atmZ] -= 0.3;

	ATMData[id][atmObjID] = CreateDynamicObject(19324, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
    if(IsValidDynamicObject(ATMData[id][atmObjID])) {		
        EditingATMID[playerid] = id;
        EditDynamicObject(playerid, ATMData[id][atmObjID]);
    }

	new label_string[64];
	format(label_string, sizeof(label_string), "ATM (%d)\n\n{FFFFFF}Use {F1C40F}/atm", id);
	ATMData[id][atmLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ] + 0.85, 1.0, .testlos = 1);

	mysql_format(DBConn, query, sizeof(query), "INSERT INTO bank_atms SET ID=%d, PosX='%f', PosY='%f', PosZ='%f', RotX='%f', RotY='%f', RotZ='%f'", id, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
	mysql_tquery(DBConn, query);

	format(logString, sizeof(logString), "%s (%s) criou um ATM em %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid));
	logCreate(playerid, logString, 1);

	Iter_Add(ATMs, id);
	return true;
}

CMD:editaratm(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 3 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/editaratm [ATM ID]");
	if(!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Você específicou o ID de um ATM inválido.");

	if(!IsPlayerInRangeOfPoint(playerid, 30.0, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ])) return SendErrorMessage(playerid, "Você não está perto do ATM que deseja editar.");
	if(EditingATMID[playerid] != -1) return SendErrorMessage(playerid, "Você já está editando um ATM.");

	format(logString, sizeof(logString), "%s (%s) editou um ATM em %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid));
	logCreate(playerid, logString, 1);

	EditingATMID[playerid] = id;
	EditDynamicObject(playerid, ATMData[id][atmObjID]);
	return true;
}

CMD:deletaratm(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 3 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/deletaratm [ATM ID]");
	if(!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Você específicou o ID de um ATM inválido.");

	if(IsValidDynamicObject(ATMData[id][atmObjID])) DestroyDynamicObject(ATMData[id][atmObjID]);
	ATMData[id][atmObjID] = -1;

    if(IsValidDynamic3DTextLabel(ATMData[id][atmLabel])) DestroyDynamic3DTextLabel(ATMData[id][atmLabel]);
    ATMData[id][atmLabel] = Text3D: -1;
	
	Iter_Remove(ATMs, id);

	format(logString, sizeof(logString), "%s (%s) removeu um ATM em %s (ID: %d)", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid), id);
	logCreate(playerid, logString, 1);
	
	mysql_format(DBConn, query, sizeof(query), "DELETE FROM bank_atms WHERE ID=%d", id);
	mysql_tquery(DBConn, query);
	return true;
}

/******************************** [BANCÁRIOS] ********************************/
CMD:criarbancario(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 3 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	new id = Iter_Free(Bankers);
	if(id == -1) return SendErrorMessage(playerid, "O servidor atingiu o limite de bancários criados.");

	new skin;
	if(sscanf(params, "i", skin)) return SendSyntaxMessage(playerid, "/criarbancario [Skin ID]");
	if(!(0 <= skin <= 311)) return SendErrorMessage(playerid, "Você específicou o ID de uma skin inválida.");

	BankerData[id][Skin] = skin;
	GetPlayerPos(playerid, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ]);
	GetPlayerFacingAngle(playerid, BankerData[id][bankerA]);
	BankerData[id][bankerVW] = GetPlayerVirtualWorld(playerid);
	BankerData[id][bankerInterior] = GetPlayerInterior(playerid);

	SetPlayerPos(playerid, BankerData[id][bankerX] + (1.0 * floatsin(-BankerData[id][bankerA], degrees)), BankerData[id][bankerY] + (1.0 * floatcos(-BankerData[id][bankerA], degrees)), BankerData[id][bankerZ]);

	BankerData[id][bankerActorID] = CreateActor(skin, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);

	if(IsValidActor(BankerData[id][bankerActorID])) SetActorInvulnerable(BankerData[id][bankerActorID], true), SetActorVirtualWorld(BankerData[id][bankerActorID], BankerData[id][bankerVW]);

	new label_string[64];
	format(label_string, sizeof(label_string), "Bancário (%d)\n\n{FFFFFF}Use {F1C40F}/banco", id);
	BankerData[id][bankerLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ] + 0.25, 1.0, .testlos = 1);

	mysql_format(DBConn, query, sizeof(query), "INSERT INTO bankers SET ID=%d, Skin=%d, PosX='%f', PosY='%f', PosZ='%f', PosA='%f', Interior='%d', VirtualWorld='%d'", id, skin, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA], BankerData[id][bankerInterior], BankerData[id][bankerVW]);
	mysql_tquery(DBConn, query);

	format(logString, sizeof(logString), "%s (%s) criou um bancário em %s (ID: %d)", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid), id);
	logCreate(playerid, logString, 1);

	Iter_Add(Bankers, id);
	return true;
}

CMD:deletarbancario(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 3 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/deletar [Bancário ID]");
	if(!Iter_Contains(Bankers, id)) return SendErrorMessage(playerid, "Você específicou o ID de um bancário inválido.");

	if(IsValidActor(BankerData[id][bankerActorID])) DestroyActor(BankerData[id][bankerActorID]);
	BankerData[id][bankerActorID] = -1;

    if(IsValidDynamic3DTextLabel(BankerData[id][bankerLabel])) DestroyDynamic3DTextLabel(BankerData[id][bankerLabel]);
    BankerData[id][bankerLabel] = Text3D: -1;

	Iter_Remove(Bankers, id);

	format(logString, sizeof(logString), "%s (%s) deletou o bancário ID: %d", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid), id);
	logCreate(playerid, logString, 1);

	mysql_format(DBConn, query, sizeof(query), "DELETE FROM bankers WHERE ID=%d", id);
	mysql_tquery(DBConn, query);
	return true;
}