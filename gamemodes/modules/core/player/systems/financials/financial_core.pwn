PayPlayer(playerid, userid, amount) {
    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); 
    PlayerPlaySound(userid, 1052, 0.0, 0.0, 0.0); 
	
	SendClientMessageEx(playerid, COLOR_YELLOW, "* Voc� pagou $%s para %s.", FormatNumber(amount), GetPlayerNameEx(userid));
	SendClientMessageEx(userid, COLOR_YELLOW, "* Voc� recebeu $%s de %s.", FormatNumber(amount), GetPlayerNameEx(playerid));
	
    if (amount < 1000)
    {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s d� algum dinheiro para %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(userid)); 
    }
    else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s d� um monte de dinheiro para %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(userid)); 
	
    PlayerPlaySound(userid, 1083, 0.0, 0.0, 0.0);
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	GiveMoney(playerid, -amount); 
    GiveMoney(userid, amount);
}