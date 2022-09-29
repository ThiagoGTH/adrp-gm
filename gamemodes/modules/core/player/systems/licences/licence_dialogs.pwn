Dialog:DIALOG_DMV_ROUTE(playerid, response, listitem, inputtext[]) {
	if(!response) return true;

    if(pInfo[playerid][pMoney] < DMV_VEHICLE_VALUE) return SendErrorMessage(playerid, "Voc� n�o tem dinheiro suficiente.");
    if(pLicences[playerid][licence_vehicle] == 1) return SendErrorMessage(playerid, "Voc� j� possui uma licen�a de motorista v�lida.");

	DMVTestType[playerid] = listitem+1;
	StartTestingLicence(playerid);
	return true;
}