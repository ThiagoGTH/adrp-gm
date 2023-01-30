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

	Iter_Add(ATMs, id);
	return true;
}

CMD:editaratm(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 3 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/editaratm [ATM ID]");
	if(!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Voc� espec�ficou o ID de um ATM inv�lido.");

	if(!IsPlayerInRangeOfPoint(playerid, 30.0, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ])) return SendErrorMessage(playerid, "Voc� n�o est� perto do ATM que deseja editar.");
	if(EditingATMID[playerid] != -1) return SendErrorMessage(playerid, "Voc� j� est� editando um ATM.");

	EditingATMID[playerid] = id;
	EditDynamicObject(playerid, ATMData[id][atmObjID]);
	return true;
}

CMD:removeatm(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 3 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/removeratm [ATM ID]");
	if(!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Voc� espec�ficou o ID de um ATM inv�lido.");

	if(IsValidDynamicObject(ATMData[id][atmObjID])) DestroyDynamicObject(ATMData[id][atmObjID]);
	ATMData[id][atmObjID] = -1;

    if(IsValidDynamic3DTextLabel(ATMData[id][atmLabel])) DestroyDynamic3DTextLabel(ATMData[id][atmLabel]);
    ATMData[id][atmLabel] = Text3D: -1;
	
	Iter_Remove(ATMs, id);
	
	mysql_format(DBConn, query, sizeof(query), "DELETE FROM bank_atms WHERE ID=%d", id);
	mysql_tquery(DBConn, query);
	return true;
}