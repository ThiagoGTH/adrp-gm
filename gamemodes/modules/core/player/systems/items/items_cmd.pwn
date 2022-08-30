#include <YSI_Coding\y_hooks>

CMD:resetarinventario(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);
    new userid;
	if (sscanf(params, "u", userid))
		return  SendSyntaxMessage(playerid, "/resetarinventario [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Voc� espec�ficou um jogador inv�lido.");

	Inventory_Reset(userid);
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s resetou o invent�rio de %s.", GetPlayerUserEx(playerid), pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) resetou o invent�rio de %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
    return true;
}

// PLAYER
CMD:inv(playerid, params[]) {
    ShowPlayerInventory(playerid);
    return true;
} alias:inv("i", "inventario")