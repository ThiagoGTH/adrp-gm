#include <YSI_Coding\y_hooks>

CMD:resetarinventario(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);
    new userid;
	if (sscanf(params, "u", userid)) return  SendSyntaxMessage(playerid, "/resetarinventario [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Voc� espec�ficou um jogador inv�lido.");

	Inventory_Reset(userid);
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s resetou o invent�rio de %s.", GetPlayerUserEx(playerid), pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) resetou o invent�rio de %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
    return true;
}

CMD:daritem(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);
	new userid, amount, item[64], id = -1;
	if (sscanf(params, "uds[64]", userid, amount, item)) return SendSyntaxMessage(playerid, "/daritem [id/nome] [quantia] [item nome]");
	if (userid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Voc� espec�ficou um jogador inv�lido.");
	if (amout < 1) return SendErrorMessage(playerid, "A quantidade deve ser maior que zero.");
	if (Inventory_Quantity(userid) >= GetInventorySlots(userid)) return SendErrorMessage(playerid, "O invent�rio deste jogador est� cheio.");
	id = GetItemID(item);
	if(id == -1) return SendErrorMessage(playerid, "Voc� especificou um item inv�lido.");
	if(diInfo[id][diCategory] == 0) SendErrorMessage(playerid, "O item especificado n�o pode ser colocado no invent�rio.");
	if(diInfo[id][diCategory] == 9) SendErrorMessage(playerid, "O item especificado � uma arma e s� pode ser dado a um jogador a partir do comando /dararma.");

	Inventory_Add(userid, id, amount);

	SendServerMessage(playerid, "Voc� deu a %s um(a) %s (%d).", pNome(userid), item, amount);
	SendServerMessage(userid, "%s lhe deu um(a) %s (%d).", GetPlayerUserEx(playerid), item, amount);

	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s deu %s para %s.", GetPlayerUserEx(playerid), item, pNome(userid));
	format(logString, sizeof(logString), "%s (%s) deu %s (%d) para %s", pNome(playerid), GetPlayerUserEx(playerid), item, amount, pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

// PLAYER
CMD:inv(playerid, params[]) {
    ShowPlayerInventory(playerid);
    return true;
} alias:inv("i", "inventario")