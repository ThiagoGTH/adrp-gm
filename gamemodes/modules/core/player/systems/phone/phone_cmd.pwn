CMD:ligar(playerid, params[]) {
    new isPayPhone = GetNearestPhone(playerid);

    if(pInfo[playerid][pInjured])
		return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

    if(!isPayPhone) {
        if(pInfo[playerid][pJailed])
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Seu celular foi confiscado pela polícia.");

        if(!CheckPhoneStatus(playerid))
            return SendErrorMessage(playerid, "Você não pode fazer isso agora (celular desligado).");

        if(ph_airmode[playerid])
            return SendErrorMessage(playerid, "Você não pode fazer isso agora (modo avião ligado).");

        if(calltimer[playerid] || smstimer[playerid] || GetPlayerSpecialAction(playerid) > 0 || pInfo[playerid][pMoney] < 10)
            return SendErrorMessage(playerid, "Você não pode fazer isso agora.");
        
        CallNumber(playerid, params);
    }

	CallNumber(playerid, params);

	return true;
}

CMD:atender(playerid, params[])
{
    if(pInfo[playerid][pInjured] || GetPlayerSpecialAction(playerid) > 0)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode usar o telefone neste momento.");

	if(ph_menuid[playerid] == 7 && ph_sub_menuid[playerid] == 2)
	{
		new targetid = pInfo[playerid][pCallConnect];

		if(targetid != INVALID_PLAYER_ID)
		{
			SendClientMessage(targetid, COLOR_GREY, "[ ! ] Você pode conversar agora usando a caixa de bate-papo.");

			pInfo[targetid][pCellTime] = 0;
			pInfo[targetid][pCallLine] = playerid;

	  		ph_sub_menuid[targetid] = 1;
			RenderPlayerPhone(targetid, ph_menuid[targetid], ph_sub_menuid[targetid]);

			AddPlayerCallHistory(playerid, pInfo[targetid][pPhoneNumber], PH_INCOMING);
		}

		pInfo[playerid][pIncomingCall] = 0;
		pInfo[playerid][pCellTime] = 0;
		pInfo[playerid][pCallLine] = targetid;

		ph_sub_menuid[playerid] -= 1;

  		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
  		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	}
	else SendErrorMessage(playerid, "Ninguém está ligando para você.");

	return true;
}

CMD:desligar(playerid, params[])
{
    if(pInfo[playerid][pInjured])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode usar o telefone neste momento.");

	if(ph_menuid[playerid] == 7)
	{
		new targetid = pInfo[playerid][pCallConnect];

		if(targetid != INVALID_PLAYER_ID)
		{
			SendClientMessage(targetid, COLOR_GRAD2, "[ ! ] Eles desligaram. ((Use /celular para ocultar o telefone))");

			pInfo[targetid][pCellTime] = 0;
			pInfo[targetid][pCallLine] = INVALID_PLAYER_ID;

			RenderPlayerPhone(targetid, 0, 0);

			if(GetPlayerSpecialAction(targetid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(targetid,SPECIAL_ACTION_STOPUSECELLPHONE);

			pInfo[playerid][pCallConnect] = INVALID_PLAYER_ID;
			pInfo[targetid][pCallConnect] = INVALID_PLAYER_ID;
		}

		if(ph_menuid[playerid] == 7 && ph_sub_menuid[playerid] == 0)
		{
			if(calltimer[playerid])
			{
				KillTimer(calltimer[playerid]);

				calltimer[playerid] = 0;
			}
		}
		else SendClientMessage(playerid, COLOR_GRAD2, "[ ! ] Você desligou.");

		pInfo[playerid][pCellTime] = 0;
		pInfo[playerid][pCallLine] = INVALID_PLAYER_ID;

		RenderPlayerPhone(playerid, 0, 0);

		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
	}
	return true;
}