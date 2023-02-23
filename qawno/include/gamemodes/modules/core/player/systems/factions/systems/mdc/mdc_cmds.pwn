CMD:mdc(playerid, params[]){
    if (!GetFactionType(playerid) == FACTION_POLICE || !GetFactionType(playerid) == FACTION_DOJ || !GetFactionType(playerid) == FACTION_MEDIC); return SendPermissionMessage(playerid);

	if(GetPVarInt(playerid, "OnPlayerUseMDC") == 1) {
		MDC_Hide(playerid);
		SetPVarInt(playerid, "OnPlayerUseMDC", 0);
		return true;
	}
    if (IsACruiser(GetPlayerVehicleID(playerid)){
        SelectTextDraw(playerid, 0x030103FF);
		ShowMDCPage(playerid, MDC_PAGE_MAIN);
		SetPVarInt(playerid, "OnPlayerUseMDC", 1);

        PC_EmulateCommand(playerid, "/ame acessa o Mobile Data Computer.");
        return true;
    } else return SendErrorMessage(playerid, "Você deve estar dentro de uma viatura ou dentro do departamento para utilizar este comando.");
    return true;
}