Dialog:DIALOG_DMV_ROUTE(playerid, response, listitem, inputtext[]) {
	if(!response) return true;

    if (GetMoney(playerid) < DMV_VEHICLE_VALUE) return SendErrorMessage(playerid, "Você não tem dinheiro suficiente.");
    if (pLicenses[playerid][license_vehicle] == 1) return SendErrorMessage(playerid, "Você já possui uma licença de motorista válida.");

	DMVTestType[playerid] = listitem+1;
	StartTestingLicense(playerid);
	return true;
}