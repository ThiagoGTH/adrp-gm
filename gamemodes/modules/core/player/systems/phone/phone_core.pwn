CallNumber(playerid, const params[]) {

	new phonenumb[24];

	if(strlen(params) < 24 && sscanf(params, "s[24]", phonenumb)) {
	/*	SendClientMessage(playerid, COLOR_GREY, "[ Common numbers ]");
		SendClientMessage(playerid, COLOR_WHITE, "Emergency (police/paramedic): 911");
		SendClientMessage(playerid, COLOR_WHITE, "Police Non-Emergency landline: 991");
		SendClientMessage(playerid, COLOR_WHITE, "Taxi dispatch: 544");
		SendClientMessage(playerid, COLOR_WHITE, "Mechanic dispatch: 555");
		SendClientMessage(playerid, COLOR_WHITE, "Impounder dispatch: 533");
		SendClientMessage(playerid, COLOR_WHITE, "Police Department: 1-800-POLICE");
		SendClientMessage(playerid, COLOR_WHITE, "Sheriff's Department: 1-800-SHERIFF");
		SendClientMessage(playerid, COLOR_WHITE, "Prison Landline: 1-800-PRISON");
		SendClientMessage(playerid, COLOR_WHITE, "Fire Department: 1-800-FIRE");
		SendClientMessage(playerid, COLOR_WHITE, "San Andreas Network: 1-800-SAN");
		SendClientMessage(playerid, COLOR_WHITE, "Roux Enterprise: 1-800-ROUX");
		SendClientMessage(playerid, COLOR_WHITE, "The Government: 1-800-GOV");
		SendClientMessage(playerid, COLOR_WHITE, "Courts: 1-800-COURTS");
		SendClientMessage(playerid, COLOR_WHITE, "Federal Bureau of Investigation: 1-800-FBI");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Usage: /call [numero/contato]"); */
		return true;
	}

    if(pInfo[playerid][pPhoneNumber]) {
		new pnumber = strval(phonenumb);

  		if(pnumber == 911) {
			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid}) {
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observação: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~911");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "O Despacho de Emergência diz (telefone): Aqui está o Despacho de Emergência 911. Qual serviço você precisa?");

			pInfo[playerid][pCallLine] = 911;
			pInfo[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 991) {
			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid}) {
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observação: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~991");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "O Despacho da Polícia diz (telefone): Telefone fixo não emergencial para serviços de aplicação da lei, o que você ...");
			SendClientMessage(playerid, COLOR_YELLOW, "O Despacho da Polícia diz (telefone): ... sua localização atual?");

			pInfo[playerid][pCallLine] = 991;
			pInfo[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 555) {
			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid}) {
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observação: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~555");

            RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "O Despacho Mecânico diz (telefone): Los Santos Mechanical Services, como podemos ajudar?");

			pInfo[playerid][pCallLine] = 555;
			pInfo[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 544) {
			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid}) {
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observação: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~544");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "Taxi Dispatch diz (telefone): Alô, onde você quer ir?");

			pInfo[playerid][pCallLine] = 544;
			pInfo[playerid][pIncomingCall] = 0;
			return true;
		}
		else
		{
			new nid = -1;

			for(new i = 0; i != 40; ++i) {
				if(ContactData[playerid][i][contactNumber] > 0 && (!strcmp(ContactData[playerid][i][contactName], phonenumb, true) || ContactData[playerid][i][contactNumber] == pnumber)) {
					nid = i;
				 	break;
				}
			}

			if(nid == -1 && pnumber == 0) {
				RenderPlayerPhone(playerid, 5, 1);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				return true;
			}

			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid}) {
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observação: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

			if(nid == -1) {
				format(ph_call_string[playerid], 64, "~n~555-%06d", pnumber);
				AddPlayerCallHistory(playerid, pnumber, PH_OUTGOING);
			}
			else
			{
				format(ph_call_string[playerid], 64, " %s~n~(%d)", ContactData[playerid][nid][contactName], ContactData[playerid][nid][contactNumber]);
                AddPlayerCallHistory(playerid, ContactData[playerid][nid][contactNumber], PH_OUTGOING);
			}

			RenderPlayerPhone(playerid, 7, 0);

			/*new signal = GetPhoneSignal(playerid);

			if(signal > 4) calltimer[playerid] = SetTimerEx("SendPlayerCall", 2000, false, "dddd", playerid, signal, pnumber, nid);
			else if(signal > 3) calltimer[playerid] = SetTimerEx("SendPlayerCall", 2500, false, "dddd", playerid, signal, pnumber, nid);
			else if(signal > 2) calltimer[playerid] = SetTimerEx("SendPlayerCall", 3000, false, "dddd", playerid, signal, pnumber, nid);
			else if(signal > 1) calltimer[playerid] = SetTimerEx("SendPlayerCall", 3500, false, "dddd", playerid, signal, pnumber, nid);
			else */
			calltimer[playerid] = SetTimerEx("SendPlayerCall", 4000, false, "ddd", playerid, pnumber, nid);
		}
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "You don't have a mobile phone.");

	return true;
}