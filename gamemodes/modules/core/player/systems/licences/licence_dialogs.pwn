Dialog:DIALOG_DMV_ROUTE(playerid, response, listitem, inputtext[]) {
	if(!response) return true;

    if(pInfo[playerid][pMoney] < DMV_VEHICLE_VALUE) return SendErrorMessage(playerid, "Você não tem dinheiro suficiente.");
    if(pLicences[playerid][licence_vehicle] == 1) return SendErrorMessage(playerid, "Você já possui uma licença de motorista válida.");

	DMVTestType[playerid] = listitem+1;
	StartTestingLicence(playerid);
	return true;
}