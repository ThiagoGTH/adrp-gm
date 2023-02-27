PayPlayer(playerid, userid, amount) {
    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); 
    PlayerPlaySound(userid, 1052, 0.0, 0.0, 0.0); 
	
	va_SendClientMessage(playerid, COLOR_YELLOW, "* Você pagou $%s para %s.", FormatNumber(amount), pNome(userid));
	va_SendClientMessage(userid, COLOR_YELLOW, "* Você recebeu $%s de %s.", FormatNumber(amount), pNome(playerid));
	
    if (amount < 1000) SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s deu certa quantia de dinheiro para %s.", pNome(playerid), pNome(userid)); 
    else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s deu uma grande quantidade de dinheiro para %s.", pNome(playerid), pNome(userid)); 
	
    PlayerPlaySound(userid, 1083, 0.0, 0.0, 0.0);
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    
	GiveMoney(playerid, -amount); 
    GiveMoney(userid, amount);
}