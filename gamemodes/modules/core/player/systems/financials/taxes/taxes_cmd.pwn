CMD:taxas(playerid, params[]) {
	if (!IsPlayerInRangeOfPoint(playerid, 2.0, 1485.1274, -1788.7457, 18.7360)) return SendErrorMessage(playerid,"Você não está na prefeitura.");
	
	Taxes_ShowLogMenu(playerid);
	return true;
}