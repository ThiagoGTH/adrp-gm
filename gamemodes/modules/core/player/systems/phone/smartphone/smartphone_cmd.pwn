CMD:celular(playerid, params[])
{
	if(pInfo[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Erro: Seu telefone foi confiscado pela pol�cia.");

    if(pInfo[playerid][pInjured] || Dialog_Opened(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� n�o pode usar o telefone neste momento.");

	if(pInfo[playerid][pPhoneNumber])
	{
     	if(!PhoneOpen{playerid})
	    {
			SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observa��o: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");

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
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Erro: Seu telefone foi confiscado pela pol�cia.");

    if(pInfo[playerid][pInjured] || Dialog_Opened(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� n�o pode usar o telefone neste momento.");

    OnPhoneClick_Selfie(playerid);
	return true;
}



CMD:pc(playerid, params[])
{
	if(pInfo[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Erro: Seu telefone foi confiscado pela pol�cia.");

	if(!PhoneOpen{playerid} && pInfo[playerid][pPhoneNumber] && !pInfo[playerid][pInjured])
	{
		SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observa��o: para alternar o telefone, use /celular. Para ativar o mouse, use /pc.");

		ShowPlayerPhone(playerid);

		SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Pressione ESC para voltar ao modo de caminhada.");
	}
	else SelectTextDraw(playerid, 0x58ACFAFF);

	return true;
}

CMD:sms(playerid, params[])
{
	SendSMS(playerid, params);
	return true;
}