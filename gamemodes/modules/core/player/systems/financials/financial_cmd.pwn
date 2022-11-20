CMD:pagar(playerid, params[])
{
	new userid, amount, str[128]; 

	if(sscanf(params, "ui", userid, amount))
		return SendSyntaxMessage(playerid, "/pagar [id OU nome] [valor]");

	if (!IsPlayerConnected(userid)) return SendNotConnectedMessage(playerid);
		
	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo desse jogador."); 

    if(playerid == userid)
		return SendErrorMessage(playerid, "Voc� n�o pode pagar a si mesmo."); 

    if(amount < 1)
		return SendErrorMessage(playerid, "Voc� n�o pode pagar menos de $1.");

	if(amount > GetMoney(playerid))
		return SendErrorMessage(playerid, "Voc� n�o tem essa quantidade de dinheiro.");
	
    if(!strcmp(GetPlayerIp(playerid), GetPlayerIp(userid)))
    {
        format(str, sizeof(str), "%s (ID: %d) tentou pagar dinheiro para %s (ID: %d) com o mesmo IP.", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(userid), userid);
		SendAdminWarning(1, str);

        return 1;
    }

    PayPlayer(playerid, userid, amount)
	return 1;
}