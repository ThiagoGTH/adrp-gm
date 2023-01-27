CMD:celular(playerid, params[])
{
	if(pInfo[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Erro: Seu telefone foi confiscado pela polícia.");

    if(pInfo[playerid][pInjured] || Dialog_Opened(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode usar o telefone neste momento.");

	if(pInfo[playerid][pPhoneNumber])
	{
     	if(!PhoneOpen{playerid})
	    {
			SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observação: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");

			Annotation(playerid, "Pega o telefone.");

			ShowPlayerPhone(playerid);

			SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Pressione ESC para voltar ao modo de caminhada.");
		}
		else
		{
			ClosePlayerPhone(playerid, true);
	      	CancelSelectTextDraw(playerid);

			if(ph_menuid[playerid] != 7) RemovePlayerAttachedObject(playerid, 9);

			Annotation(playerid, "puts their phone away.");
		}
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "   You do not have a phone");

	return true;
} 

CMD:selfie(playerid, params[])
{
	if(pInfo[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Erro: Seu telefone foi confiscado pela polícia.");

    if(pInfo[playerid][pInjured] || Dialog_Opened(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode usar o telefone neste momento.");

    OnPhoneClick_Selfie(playerid);
	return true;
}

CMD:atender(playerid, params[])
{
    if(pInfo[playerid][pInjured] || GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_NONE)
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

CMD:pc(playerid, params[])
{
	if(pInfo[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Erro: Seu telefone foi confiscado pela polícia.");

	if(!PhoneOpen{playerid} && pInfo[playerid][pPhoneNumber] && !pInfo[playerid][pInjured])
	{
		SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observação: para alternar o telefone, use /celular. Para ativar o mouse, use /pc.");

		ShowPlayerPhone(playerid);

		SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Pressione ESC para voltar ao modo de caminhada.");
	}
	else SelectTextDraw(playerid, 0x58ACFAFF);

	return true;
}

CMD:ligar(playerid, params[])
{
	CallNumber(playerid, params);
	return true;
}

CMD:sms(playerid, params[])
{
	SendSMS(playerid, params);
	return true;
}