#include <YSI_Coding\y_hooks>

CMD:resetarinventario(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);

	if (sscanf(params, "u", userid))
		return  SendSyntaxMessage(playerid, "/resetarinventario [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	GiveMoney(userid, amount);
	SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s resetou o inventário de %s.", pNome(playerid), pNome(userid));
	
	format(logString, sizeof(logString), "%s (%s) deu $%s para %s.", pNome(playerid), GetPlayerUserEx(playerid), FormatNumber(amount), pNome(userid));
	logCreate(playerid, logString, 1);
    return true;
}

// PLAYER
CMD:inv(playerid, params[]) {
    ShowPlayerInventory(playerid);
    return true;
} alias:inv("i", "inventario")