CMD:pagar(playerid, params[])
{
	new userid, amount;

	if(sscanf(params, "ui", userid, amount))
		return SendSyntaxMessage(playerid, "/pagar [id/nome] [valor]");

	if (!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo desse jogador.");

    if (playerid == userid)
		return SendErrorMessage(playerid, "Voc� n�o pode pagar a si mesmo.");

    if (amount < 1)
		return SendErrorMessage(playerid, "Voc� n�o pode pagar essa quantia.");

	if (amount > GetMoney(playerid))
		return SendErrorMessage(playerid, "Voc� n�o tem essa quantidade de dinheiro.");

    if (!strcmp(GetPlayerIP(playerid), GetPlayerIP(userid)))
		return SendAdminWarning(1, "%s (ID: %i) tentou pagar %s (ID: %i) com o mesmo IP.", pNome(playerid), playerid, pNome(userid), userid);
		
    PayPlayer(playerid, userid, amount);
	return 1;
}