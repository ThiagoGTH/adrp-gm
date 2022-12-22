//Defini��o
#define MAX_SMS 30
#define MAX_CALLHISTORY 50

//Valores
#define PH_LBUTTON		0
#define PH_RBUTTON		1
#define PH_SELFIE		2
#define PH_UP 			3
#define PH_DOWN     	4
#define PH_CLICKOPEN  	5

#define PH_OUTGOING 0
#define PH_INCOMING 1
#define PH_MISSED 	2

//Phone System Variaveis
#define     cchargetime         30
#define     callcost            10
//Variais TextDrawn
new Text:TD_PhoneCover[9];
new PlayerText:TD_PhoneCoverModel[MAX_PLAYERS];
new PlayerText:TDPhone_Model[MAX_PLAYERS][14];
new PlayerText:TDPhone_TFButton[MAX_PLAYERS];
new PlayerText:TDPhone_TSButton[MAX_PLAYERS];
new PlayerText:TDPhone_BigText[MAX_PLAYERS];
new PlayerText:TDPhone_ScreenText[MAX_PLAYERS];
new PlayerText:TDPhone_Signal[MAX_PLAYERS];
new PlayerText:TDPhone_Picture[MAX_PLAYERS];
new PlayerText:TDPhone_NotifyText[MAX_PLAYERS];
new PlayerText:TDPhone_Choice[MAX_PLAYERS][4];

new bool:PCoverOpening[MAX_PLAYERS];
new bool:PhoneOpen[MAX_PLAYERS char];

new PCoverColor[MAX_PLAYERS];

//Variaiveis de menu
new ph_menuid[MAX_PLAYERS];
new ph_sub_menuid[MAX_PLAYERS];
new ph_selected[MAX_PLAYERS]; // GUI select id   0 - 3
new ph_select_data[MAX_PLAYERS];
new ph_call_string[MAX_PLAYERS][64];
new ph_data[MAX_PLAYERS][4];
new ph_page[MAX_PLAYERS]; // data of rows
new ph_airmode[MAX_PLAYERS];
new ph_silentmode[MAX_PLAYERS];
//new bool:ph_speaker[MAX_PLAYERS char];
new ph_TextTone[MAX_PLAYERS];
new ph_CallTone[MAX_PLAYERS];

//Ultilizadas (sms/call)
new calltimer[MAX_PLAYERS];
new smstimer[MAX_PLAYERS];

// Selfie
new Float:Degree[MAX_PLAYERS];
new Float:SelAngle[MAX_PLAYERS];
const Float: Radius = 1.4; //do not edit this
const Float: Speed  = 1.25; //do not edit this
const Float: Height = 1.0; // do not edit this
new Float:lX[MAX_PLAYERS];
new Float:lY[MAX_PLAYERS];
new Float:lZ[MAX_PLAYERS];
new selfie_timer[MAX_PLAYERS];

//Compatibilidade LSRP (new desconhecida)
new LastAnnotation[MAX_PLAYERS];

//Falta sistema de Load contact e sms.
//Data
enum contactData
{
	cID,
	contactID,
	contactName[24],
	contactNumber,
};

//Sms
enum smsData
{
	bool:smsExist,
	smsID,
	smsOwner,
	smsReceive,
	smsText[128],
	smsRead,
	smsArchive,
	smsDate[24],

};

//Hist�rico
enum chdata
{
	bool:chExists,
	chSec,
	chNumber,
	bool:chRead,
	chType // - Outgoing call to %s (%d), - Incoming call from %s (%d), - Missed call from %s (%d)
};

new 
	ContactData[MAX_PLAYERS][40][contactData],
    SmsData[MAX_PLAYERS][MAX_SMS][smsData],
	CallHistory[MAX_PLAYERS][MAX_CALLHISTORY][chdata];

hook OnPlayerConnect(playerid) {
	CreatePlayerPhoneTextDraws(playerid);
	return 1;
}

hook OnGameModeInit() {
	LoadContacts();
	SetTimer("CheckSMS", 60000, true); 
	CreatePhoneTextDraws();
	return 1;
}

hook PhoneTurnOff(playerid) {
	if(IsPlayerConnected(playerid)) {	
		RenderPlayerPhone(playerid, 6, 1);
	}
}

hook PhoneTurnOn(playerid) {
	if(IsPlayerConnected(playerid)) {
		if(!pInfo[playerid][pJailed]) {
			PlayerTextDrawColor(playerid, TDPhone_ScreenText[playerid], 488447487);
			RenderPlayerPhone(playerid, 0, 0);
		}
	}
}

hook HideEmo_Phone(playerid) {
	PlayerTextDrawSetString(playerid, TDPhone_Picture[playerid], "_");
	PlayerTextDrawHide(playerid, TDPhone_Picture[playerid]);
	return true;
}

hook SendPlayerSMS(playerid, numberid, number) {
	new text[128], exist = -1, phonenumb;

    GetPVarString(playerid, "SMSPhoneText", text, 128);
    DeletePVar(playerid, "SMSPhoneText");

    smstimer[playerid] = 0;

	new
		targetid = INVALID_PLAYER_ID
	;

  	foreach (new i : Player) {
		if(pInfo[playerid][pPhoneNumber] != pInfo[i][pPhoneNumber] && ((numberid != -1 && pInfo[i][pPhoneNumber] == ContactData[playerid][numberid][contactNumber]) || (number > 0 && pInfo[i][pPhoneNumber] == number))) {
			targetid = i;

			if(number > 0 && pInfo[i][pPhoneNumber] == number) phonenumb = number;
			else phonenumb = pInfo[i][pPhoneNumber];

			break;
		}
	}

	if(targetid != INVALID_PLAYER_ID && !ph_airmode[targetid] && ph_menuid[targetid] != 6 &&  !pInfo[targetid][pInjured] && !pInfo[targetid][pJailed]) {
		for(new x = 0; x < MAX_SMS; ++x) {
			if(!SmsData[targetid][x][smsExist]) {
				exist = x;
				break;
			}
		}

		if(exist != -1) {
			if(!PhoneOpen{targetid}) ShowPlayerPhone(targetid);
		    RenderPlayerPhone(targetid, ph_menuid[targetid], ph_sub_menuid[targetid]);
		    ShowEmo_Phone(targetid, 3);
		  	if(!ph_silentmode[targetid]) PlayPlayerTextTone(targetid);

			new pdate[24];
			format(pdate, 24, "%s", ReturnPhoneDateTime());

			SmsData[targetid][exist][smsExist] = true;
			SmsData[targetid][exist][smsOwner] = pInfo[playerid][pPhoneNumber];
			SmsData[targetid][exist][smsReceive] = phonenumb;
			SmsData[targetid][exist][smsArchive] = 0;
			SmsData[targetid][exist][smsRead] = 0;
			format(SmsData[targetid][exist][smsText], 128, text);
			format(SmsData[targetid][exist][smsDate], 24, pdate);

			mysql_format(DBConn, query, sizeof(query), "INSERT INTO `phone_sms` (`PhoneReceive`, `PhoneOwner`, `PhoneSMS`, `ReadSMS`, `Archive`, `Date`) VALUES ('%d', '%d', '%e', '0', '0', '%e');", phonenumb, pInfo[playerid][pPhoneNumber], text, pdate);						
			mysql_pquery(DBConn, query, "OnPhoneInsertSMS", "dd", targetid, exist);	

			RenderPlayerPhone(playerid, 5, 5);
	        ShowEmo_Phone(playerid, 1);
			GameTextForPlayer(playerid, "~r~$-1", 5000, 1);
			GiveMoney(playerid, 1);
		    return true;
	    }
	}

	ph_menuid[playerid] = 5;
	ph_sub_menuid[playerid] = 6;
	
	ShowEmo_Phone(playerid, 2);
	
	RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
	return true; 
}

hook OnPhoneInsertSMS(targetid, exist) {
	if(IsPlayerConnected(targetid)) {
		SmsData[targetid][exist][smsID] = cache_insert_id();
	}
}

hook SelfieTimer(playerid) {
	new Keys, ud, lr;

	if(ph_menuid[playerid] == 0 && ph_sub_menuid[playerid] == 2) {
		GetPlayerKeys(playerid, Keys, ud, lr);

		if(lr == KEY_LEFT) {
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
			Degree[playerid] += Speed;
			n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
			n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
			SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
			SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+ SelAngle[playerid]);
			SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		else if(lr == KEY_RIGHT) {
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
			Degree[playerid] -= Speed;
			n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
			n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
			SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
			SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+ SelAngle[playerid]);
			SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		if(ud == KEY_UP) {
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;

			if(SelAngle[playerid] < 1.0)
				SelAngle[playerid] += 0.1;

			n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
			n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
			SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
			SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+ SelAngle[playerid]);
			SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		else if(ud == KEY_DOWN) {
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;

			if(SelAngle[playerid] > 0.8)
				SelAngle[playerid] -= 0.1;

			n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
			n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
			SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
			SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+ SelAngle[playerid]);
			SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		if(Keys == KEY_SECONDARY_ATTACK) {
			ph_menuid[playerid] = 0;
			ph_sub_menuid[playerid] = 0;
			
			RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

			TogglePlayerControllable(playerid, true);
			
			SetCameraBehindPlayer(playerid);
			ClearAnimations(playerid);
		}
	}
	else
	{
		if(selfie_timer[playerid]) KillTimer(selfie_timer[playerid]);

		selfie_timer[playerid] = 0;
	}
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid) {
	if(PCoverOpening{playerid}) {
	    if(clickedid == TD_PhoneCover[1]) // Black
	    {
			PCoverColor[playerid] = 0;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18868);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[2]) // Red color
	    {
			PCoverColor[playerid] = 1;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18870);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[3]) // Yellow
	    {
			PCoverColor[playerid] = 2;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18873);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[4]) // Blue color
	    {
			PCoverColor[playerid] = 3;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18872);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[5]) // Green Watercolor
	    {
			PCoverColor[playerid] = 4;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18871);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[6]) // Orange
	    {
			PCoverColor[playerid] = 5;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18865);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[7]) // Pink
	    {
			PCoverColor[playerid] = 6;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18869);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[8]) // Purchase
	    {
			if(pInfo[playerid][pMoney] >= 500) {
			    pInfo[playerid][pPhoneModel] = PCoverColor[playerid];

				GiveMoney(playerid, 500);
				SendClientMessage(playerid, COLOR_WHITE, "Voc� comprou uma nova capa de telefone.");

				if(PhoneOpen{playerid}) ShowPlayerPhone(playerid);


			    for(new i = 0; i != sizeof(TD_PhoneCover); ++i)
					TextDrawHideForPlayer(playerid, TD_PhoneCover[i]);

	            PlayerTextDrawHide(playerid, TD_PhoneCoverModel[playerid]);

				PCoverOpening{playerid} = false;
				CancelSelectTextDraw(playerid);

			}
			else SendClientMessage(playerid, COLOR_WHITE, " Voc� n�o tem dinheiro suficiente ($ 500) !");
	    }
	}
  	if(clickedid == Text:INVALID_TEXT_DRAW) {
	    if(PhoneOpen{playerid}) {
	        SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Use '/pc' para trazer o cursor de volta ou '/phone' para ocultar o telefone.");
	    }
		if(PCoverOpening{playerid}) {
		    for(new i = 0; i != sizeof(TD_PhoneCover); ++i)
				TextDrawHideForPlayer(playerid, TD_PhoneCover[i]);

            PlayerTextDrawHide(playerid, TD_PhoneCoverModel[playerid]);

			PCoverOpening{playerid} = false;
		}
	}
	return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid) {
	if(PhoneOpen{playerid})
    {
        if(ph_menuid[playerid] == 6) {
	 		if(ph_sub_menuid[playerid] == 1 && playertextid == TDPhone_Model[playerid][4]) // PHONE ON
			{
	            RenderPlayerPhone(playerid, 6, 2);

				SetTimerEx("PhoneTurnOn", 4000, false, "d", playerid);
			}
        }
        else
        {
	    	if(playertextid == TDPhone_Model[playerid][7]) // First
	    	{
	    	    OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_LBUTTON);
	    	}
	    	else if(playertextid == TDPhone_Model[playerid][13]) // Second
	    	{
	    	    OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_RBUTTON);
	    	}
	    	else if(playertextid == TDPhone_Model[playerid][8]) // Up
	    	{
	    		OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_UP);
	    	}
	    	else if(playertextid == TDPhone_Model[playerid][9]) // Down
	    	{
	    	    OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_DOWN);
	    	}
			else if(playertextid == TDPhone_Model[playerid][3]) // INBOX
			{
				RenderPlayerPhone(playerid, 2, 3);
			}
			else if(playertextid == TDPhone_Model[playerid][12]) // SELFIE
			{
				if(ph_menuid[playerid]== 0 && ph_sub_menuid[playerid] == 2)
					PhoneSelfie_Stop(playerid);
				else
					OnPhoneClick_Selfie(playerid);
			}
			else if(playertextid == TDPhone_Model[playerid][4]) // PHONE OFF
			{
				if(ph_menuid[playerid] != 6)
					Dialog_Show(playerid, AskTurnOff, DIALOG_STYLE_MSGBOX, "Tem certeza?", "Tem certeza de que deseja desligar o telefone?", "Sim", "Nao");
			}
			else if(playertextid == TDPhone_NotifyText[playerid]) {
			    new missed_msg = CountMissedCall(playerid);

			    if(missed_msg)
			    {
                    RenderPlayerPhone(playerid, 3, 3);
			    }
			    else
			    {
		      		RenderPlayerPhone(playerid, 2, 3);
			    }
			}
			else
			{
		        for(new i = 0; i != 4; ++i) {
					if(playertextid == TDPhone_Choice[playerid][i]) {
						if(ph_selected[playerid] == i) {
							OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_CLICKOPEN);
						    return true;
						}

						ph_selected[playerid] = i;

		    			if((ph_menuid[playerid] == 1 && ph_sub_menuid[playerid] == 1) || (ph_menuid[playerid] == 2 && (ph_sub_menuid[playerid] == 1 || ph_sub_menuid[playerid] == 3 || ph_sub_menuid[playerid] == 4)) || (ph_menuid[playerid] == 3 && (ph_sub_menuid[playerid] == 1 || ph_sub_menuid[playerid] == 3)))
							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

						RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
			    	}
		    	}
	    	}
    	}
    }
	return 1;
}

hook OnCheckSMS(playerid) {
	//Coisas relacionadas ao telefone
	if(pInfo[playerid][pCellTime] > 0)
	{
		if(pInfo[playerid][pCallLine] != INVALID_PLAYER_ID)
		{
			new calling = pInfo[playerid][pCallLine];

			if(pInfo[playerid][pCellTime] == cchargetime)
			{
				pInfo[playerid][pCellTime] = 1;

				if(pInfo[calling][pCallLine] == playerid && !pInfo[playerid][pIncomingCall])
				{
					if(pInfo[playerid][pMoney] - (pInfo[playerid][pCallCost] + callcost) < 0)
					{
						GiveMoney(playerid, pInfo[playerid][pCallCost]);
						new sgstr[264];
						format(sgstr, sizeof(sgstr), "~w~O custo da chamada~n~~r~$%d", pInfo[playerid][pCallCost]);
						GameTextForPlayer(playerid, sgstr, 5000, 1);

						pInfo[playerid][pCallCost] = 0;

						SendClientMessage(calling,  COLOR_GRAD2, "[ ! ] Desligaram do outro lado da chamada.");
						CancelCall(playerid);
					}
					else pInfo[playerid][pCallCost] = pInfo[playerid][pCallCost] + callcost;
				}
			}

			pInfo[playerid][pCellTime]++;

			if(pInfo[calling][pIncomingCall] && pInfo[playerid][pCellTime] % 10 == 1 && !ph_silentmode[calling]) {
				PlayPlayerCallTone(calling);

				if(pInfo[playerid][pCellTime] == 10) AnnounceMyAction(calling, "phone begins to ring.");
			}
		}
	} return 1;
}

hook SendPlayerCall(playerid, number, numberid) {
	calltimer[playerid] = 0;

	/*if(!signal) {
		ph_menuid[playerid] = 5;
		ph_sub_menuid[playerid] = 7;

		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	    return 1;
	} */

	new targetid = INVALID_PLAYER_ID;

  	foreach (new i : Player) {
		if(pInfo[playerid][pPhoneNumber] != pInfo[i][pPhoneNumber] && ((numberid != -1 && pInfo[i][pPhoneNumber] == ContactData[playerid][numberid][contactNumber]) || (number > 0 && pInfo[i][pPhoneNumber] == number))) {
			targetid = i;
			number = pInfo[i][pPhoneNumber];
			break;
		}
	}

	if(targetid != INVALID_PLAYER_ID && pInfo[targetid][pSpectating] == INVALID_PLAYER_ID && !ph_airmode[targetid] && ph_menuid[targetid] != 6 &&  !pInfo[targetid][pInjured] && !pInfo[targetid][pJailed]) {
	    if(pInfo[targetid][pCallLine] != INVALID_PLAYER_ID) {
		 	ph_menuid[playerid] = 5;
			ph_sub_menuid[playerid] = 2;
			RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
			return true;
	    }

		if(!PhoneOpen{targetid}) {
			SendClientMessage(targetid, COLOR_WHITE, "[ ! ] Observa��o: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
			ShowPlayerPhone(targetid);
		}

		if(!ph_silentmode[targetid]) {
			PlayPlayerCallTone(targetid);

			AnnounceMyAction(targetid, "phone begins to ring.");

			SendClientMessage(targetid, COLOR_GREY, "[ ! ] To pick up the call, use /pickup");
		}

		new tar_contact = -1;

		for(new i = 0; i != 40; ++i) {
			if(ContactData[targetid][i][contactNumber] == pInfo[playerid][pPhoneNumber]) {
				tar_contact = i;
				break;
			}
		}

		if(tar_contact == -1) {
			format(ph_call_string[targetid], 64, "~n~%d", pInfo[playerid][pPhoneNumber]);
		}
		else format(ph_call_string[targetid], 64, "~n~%s~n~(%d)", ContactData[targetid][tar_contact][contactName], ContactData[targetid][tar_contact][contactNumber]);

		pInfo[targetid][pIncomingCall] = 1;
		pInfo[targetid][pCallLine] = playerid;

		ph_menuid[targetid] = 7;
		ph_sub_menuid[targetid] = 2;
		RenderPlayerPhone(targetid, ph_menuid[targetid], ph_sub_menuid[targetid]);
        pInfo[targetid][pCallConnect] = playerid;

        // Person variable phone
        pInfo[playerid][pCallConnect] = targetid;
		return true;
	}

	ph_menuid[playerid] = 5;
	ph_sub_menuid[playerid] = 3;

	RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	return true;
}

//Carrega todas empresas (MySQL).
LoadContacts() {
    new     
		exist,
        loadedContacts;

    mysql_query(DBConn, "SELECT * FROM `phone_contacts`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        ContactData[id][exist][cID] = id;

        cache_get_value_name_int(i, "contactID", ContactData[id][exist][contactID]);
        cache_get_value_name_int(i, "contactAdded", pInfo[id][pPhoneNumber]);
        cache_get_value_name_int(i, "contactAddee", ContactData[id][exist][contactNumber]);
        cache_get_value_name(i, "contactName", ContactData[id][exist][contactName]);
        loadedContacts++;
    }

    printf("[Contatos]: %d contatos carregadas com sucesso.", loadedContacts);

    return 1;
}

CreatePhoneTextDraws() {
	TD_PhoneCover[0] = TextDrawCreate(333.600036, 121.804512, "SELECT COLOR");
	TextDrawLetterSize(TD_PhoneCover[0], 0.279599, 1.465599);
	TextDrawTextSize(TD_PhoneCover[0], -0.149999, 139.000000);
	TextDrawAlignment(TD_PhoneCover[0], 2);
	TextDrawColor(TD_PhoneCover[0], -1);
	TextDrawUseBox(TD_PhoneCover[0], 1);
	TextDrawBoxColor(TD_PhoneCover[0], 80);
	TextDrawSetShadow(TD_PhoneCover[0], 0);
	TextDrawSetOutline(TD_PhoneCover[0], 0);
	TextDrawBackgroundColor(TD_PhoneCover[0], 255);
	TextDrawFont(TD_PhoneCover[0], 2);
	TextDrawSetProportional(TD_PhoneCover[0], 1);
	TextDrawSetShadow(TD_PhoneCover[0], 0);

	TD_PhoneCover[1] = TextDrawCreate(269.399841, 146.537796, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[1], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[1], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[1], 1);
	TextDrawColor(TD_PhoneCover[1], 286331391);
	TextDrawSetShadow(TD_PhoneCover[1], 0);
	TextDrawSetOutline(TD_PhoneCover[1], 0);
	TextDrawBackgroundColor(TD_PhoneCover[1], 255);
	TextDrawFont(TD_PhoneCover[1], 4);
	TextDrawSetProportional(TD_PhoneCover[1], 0);
	TextDrawSetShadow(TD_PhoneCover[1], 0);
	TextDrawSetSelectable(TD_PhoneCover[1], true);

	TD_PhoneCover[2] = TextDrawCreate(302.999847, 146.537841, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[2], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[2], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[2], 1);
	TextDrawColor(TD_PhoneCover[2], 1628113919);
	TextDrawSetShadow(TD_PhoneCover[2], 0);
	TextDrawSetOutline(TD_PhoneCover[2], 0);
	TextDrawBackgroundColor(TD_PhoneCover[2], 255);
	TextDrawFont(TD_PhoneCover[2], 4);
	TextDrawSetProportional(TD_PhoneCover[2], 0);
	TextDrawSetShadow(TD_PhoneCover[2], 0);
	TextDrawSetSelectable(TD_PhoneCover[2], true);

	TD_PhoneCover[3] = TextDrawCreate(268.999877, 181.880020, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[3], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[3], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[3], 1);
	TextDrawColor(TD_PhoneCover[3], 2104099071);
	TextDrawSetShadow(TD_PhoneCover[3], 0);
	TextDrawSetOutline(TD_PhoneCover[3], 0);
	TextDrawBackgroundColor(TD_PhoneCover[3], 255);
	TextDrawFont(TD_PhoneCover[3], 4);
	TextDrawSetProportional(TD_PhoneCover[3], 0);
	TextDrawSetShadow(TD_PhoneCover[3], 0);
	TextDrawSetSelectable(TD_PhoneCover[3], true);

	TD_PhoneCover[4] = TextDrawCreate(302.599945, 181.880142, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[4], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[4], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[4], 1);
	TextDrawColor(TD_PhoneCover[4], 405561855);
	TextDrawSetShadow(TD_PhoneCover[4], 0);
	TextDrawSetOutline(TD_PhoneCover[4], 0);
	TextDrawBackgroundColor(TD_PhoneCover[4], 255);
	TextDrawFont(TD_PhoneCover[4], 4);
	TextDrawSetProportional(TD_PhoneCover[4], 0);
	TextDrawSetShadow(TD_PhoneCover[4], 0);
	TextDrawSetSelectable(TD_PhoneCover[4], true);

	TD_PhoneCover[5] = TextDrawCreate(269.399963, 217.222259, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[5], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[5], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[5], 1);
	TextDrawColor(TD_PhoneCover[5], 388831231);
	TextDrawSetShadow(TD_PhoneCover[5], 0);
	TextDrawSetOutline(TD_PhoneCover[5], 0);
	TextDrawBackgroundColor(TD_PhoneCover[5], 255);
	TextDrawFont(TD_PhoneCover[5], 4);
	TextDrawSetProportional(TD_PhoneCover[5], 0);
	TextDrawSetShadow(TD_PhoneCover[5], 0);
	TextDrawSetSelectable(TD_PhoneCover[5], true);

	TD_PhoneCover[6] = TextDrawCreate(303.000061, 216.724502, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[6], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[6], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[6], 1);
	TextDrawColor(TD_PhoneCover[6], 0xce9100ff);
	TextDrawSetShadow(TD_PhoneCover[6], 0);
	TextDrawSetOutline(TD_PhoneCover[6], 0);
	TextDrawBackgroundColor(TD_PhoneCover[6], 255);
	TextDrawFont(TD_PhoneCover[6], 4);
	TextDrawSetProportional(TD_PhoneCover[6], 0);
	TextDrawSetShadow(TD_PhoneCover[6], 0);
	TextDrawSetSelectable(TD_PhoneCover[6], true);

	TD_PhoneCover[7] = TextDrawCreate(269.400024, 253.560089, "LD_SPAC:white");
	TextDrawLetterSize(TD_PhoneCover[7], 0.000000, 0.000000);
	TextDrawTextSize(TD_PhoneCover[7], 29.000000, 30.000000);
	TextDrawAlignment(TD_PhoneCover[7], 1);
	TextDrawColor(TD_PhoneCover[7], -2063576577);
	TextDrawSetShadow(TD_PhoneCover[7], 0);
	TextDrawSetOutline(TD_PhoneCover[7], 0);
	TextDrawBackgroundColor(TD_PhoneCover[7], 255);
	TextDrawFont(TD_PhoneCover[7], 4);
	TextDrawSetProportional(TD_PhoneCover[7], 0);
	TextDrawSetShadow(TD_PhoneCover[7], 0);
	TextDrawSetSelectable(TD_PhoneCover[7], true);

	TD_PhoneCover[8] = TextDrawCreate(364.400238, 262.177764, "Purchase");
	TextDrawLetterSize(TD_PhoneCover[8], 0.279599, 1.465599);
	TextDrawTextSize(TD_PhoneCover[8], 10.0, 77.000000);
	TextDrawAlignment(TD_PhoneCover[8], 2);
	TextDrawColor(TD_PhoneCover[8], -1);
	TextDrawUseBox(TD_PhoneCover[8], 1);
	TextDrawBoxColor(TD_PhoneCover[8], 80);
	TextDrawSetShadow(TD_PhoneCover[8], 0);
	TextDrawSetOutline(TD_PhoneCover[8], 0);
	TextDrawBackgroundColor(TD_PhoneCover[8], 255);
	TextDrawFont(TD_PhoneCover[8], 2);
	TextDrawSetProportional(TD_PhoneCover[8], 1);
	TextDrawSetShadow(TD_PhoneCover[8], 0);
	TextDrawSetSelectable(TD_PhoneCover[8], true);
}

CreatePlayerPhoneTextDraws(playerid) {
	TD_PhoneCoverModel[playerid] = CreatePlayerTextDraw(playerid, 325.400177, 140.0, "");
	PlayerTextDrawLetterSize(playerid, TD_PhoneCoverModel[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_PhoneCoverModel[playerid], 90.000000, 119.000000);
	PlayerTextDrawAlignment(playerid, TD_PhoneCoverModel[playerid], 1);
	PlayerTextDrawColor(playerid, TD_PhoneCoverModel[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawFont(playerid, TD_PhoneCoverModel[playerid], 5);
	PlayerTextDrawSetProportional(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawSetShadow(playerid, TD_PhoneCoverModel[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18868);
	PlayerTextDrawSetPreviewRot(playerid, TD_PhoneCoverModel[playerid], 80.000000, -30.000000, 0.000000, 0.600000);

	TDPhone_Model[playerid][0] = CreatePlayerTextDraw(playerid, 601.666931, 323.555450, "box");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][0], 0.000000, 15.181289);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][0], 498.333343, 0.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, TDPhone_Model[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 269619711);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][0], 0);

	TDPhone_Model[playerid][1] = CreatePlayerTextDraw(playerid, 496.199707, 314.288909, "ld_spac:tvcorn");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][1], 55.000000, 135.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -858993409);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][1], 4);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][1], 0);

	TDPhone_Model[playerid][2] = CreatePlayerTextDraw(playerid, 601.802307, 314.288909, "ld_spac:tvcorn");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][2], -55.000000, 135.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][2], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -858993409);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][2], 0);

	TDPhone_Model[playerid][3] = CreatePlayerTextDraw(playerid, 572.000122, 323.970397, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][3], 9.000018, 9.540739);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][3], true);

	TDPhone_Model[playerid][4] = CreatePlayerTextDraw(playerid, 579.667358, 319.822174, "ld_beat:circle");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][4], 15.999990, 15.762954);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][4], true);

	TDPhone_Model[playerid][5] = CreatePlayerTextDraw(playerid, 550.333374, 329.377868, "LS Telefonica");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][5], 0.199333, 0.865777);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][5], 0.000000, 2016.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][5], 2);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][5], -522133249);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][5], 1);

	TDPhone_Model[playerid][6] = CreatePlayerTextDraw(playerid, 592.000427, 349.944366, "box");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][6], 0.000000, 5.982919);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][6], 506.999633, 0.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][6], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][6], 0);
	PlayerTextDrawUseBox(playerid, TDPhone_Model[playerid][6], true);
	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][6], -572662273);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][6], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][6], 0);

	TDPhone_Model[playerid][7] = CreatePlayerTextDraw(playerid, 507.333282, 407.763031, "ld_dual:white"); // Left Button
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][7], 22.333309, 7.881487);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][7], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][7], -1717986817);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][7], 0);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][7], 4);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][7], true);

    ////
	TDPhone_Model[playerid][8] = CreatePlayerTextDraw(playerid, 544.666809, 409.422149, "ld_beat:up");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][8], 12.000005, 12.444459);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][8], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][8], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][8], true);

	TDPhone_Model[playerid][9] = CreatePlayerTextDraw(playerid, 544.666809, 425.600006, "ld_beat:down");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][9], 11.666647, 12.029617);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][9], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][9], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][9], true);

	TDPhone_Model[playerid][10] = CreatePlayerTextDraw(playerid, 534.666931, 417.718536, "ld_beat:left");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][10], 12.000015, 12.029621);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][10], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][10], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][10], true);

	TDPhone_Model[playerid][11] = CreatePlayerTextDraw(playerid, 554.333679, 417.718414, "ld_beat:right");
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][11], 12.333327, 12.029634);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][11], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][11], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Model[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][11], true);
	////

	TDPhone_Model[playerid][12] = CreatePlayerTextDraw(playerid, 596.699890, 423.302307, "ld_dual:white"); // Selfie
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][12], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][12], 5.000000, 18.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][12], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][12], 1145324799);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Model[playerid][12], 255);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][12], 4);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][12], true);

	TDPhone_Model[playerid][13] = CreatePlayerTextDraw(playerid, 569.333496, 407.762969, "LD_SPAC:white"); // Right button
	PlayerTextDrawLetterSize(playerid, TDPhone_Model[playerid][13], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Model[playerid][13], 22.333290, 7.881502);
	PlayerTextDrawAlignment(playerid, TDPhone_Model[playerid][13], 1);
	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][13], -1717986817);
	PlayerTextDrawSetShadow(playerid, TDPhone_Model[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Model[playerid][13], 0);
	PlayerTextDrawFont(playerid, TDPhone_Model[playerid][13], 4);
	PlayerTextDrawSetSelectable(playerid, TDPhone_Model[playerid][13], true);

	TDPhone_TFButton[playerid] = CreatePlayerTextDraw(playerid, 509.666534, 394.918609, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_TFButton[playerid], 0.197000, 0.778666);
	PlayerTextDrawTextSize(playerid, TDPhone_TFButton[playerid], 518.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_TFButton[playerid], 1);
	PlayerTextDrawColor(playerid, TDPhone_TFButton[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_TFButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_TFButton[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_TFButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_TFButton[playerid], 1);

	TDPhone_TSButton[playerid] = CreatePlayerTextDraw(playerid, 589.333190, 394.918701, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_TSButton[playerid], 0.197000, 0.778666);
	PlayerTextDrawTextSize(playerid, TDPhone_TSButton[playerid], 518.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_TSButton[playerid], 3);
	PlayerTextDrawColor(playerid, TDPhone_TSButton[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_TSButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_TSButton[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_TSButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_TSButton[playerid], 1);

	TDPhone_BigText[playerid] = CreatePlayerTextDraw(playerid, 549.666748, 354.681549, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_BigText[playerid], 0.298332, 1.114665);
	PlayerTextDrawAlignment(playerid, TDPhone_BigText[playerid], 2);
	PlayerTextDrawColor(playerid, TDPhone_BigText[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_BigText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_BigText[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_BigText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_BigText[playerid], 1);

	TDPhone_ScreenText[playerid] = CreatePlayerTextDraw(playerid, 549.666870, 365.051666, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_ScreenText[playerid], 0.200332, 0.757924);
	PlayerTextDrawTextSize(playerid, TDPhone_ScreenText[playerid], 0.000000, 2181.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_ScreenText[playerid], 2);
	PlayerTextDrawColor(playerid, TDPhone_ScreenText[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_ScreenText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_ScreenText[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_ScreenText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_ScreenText[playerid], 1);

	TDPhone_Signal[playerid] = CreatePlayerTextDraw(playerid, 589.666809, 348.874023, "IIIII");
	PlayerTextDrawLetterSize(playerid, TDPhone_Signal[playerid], 0.141333, 0.683259);
	PlayerTextDrawAlignment(playerid, TDPhone_Signal[playerid], 3);
	PlayerTextDrawColor(playerid, TDPhone_Signal[playerid], 488447487);
	PlayerTextDrawSetShadow(playerid, TDPhone_Signal[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Signal[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_Signal[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_Signal[playerid], 1);

	TDPhone_Picture[playerid] = CreatePlayerTextDraw(playerid, 488.199890, 296.000000, "_"); // Emo
	PlayerTextDrawLetterSize(playerid, TDPhone_Picture[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDPhone_Picture[playerid], -50.000000, 50.000000);
	PlayerTextDrawAlignment(playerid, TDPhone_Picture[playerid], 1);
	PlayerTextDrawColor(playerid, TDPhone_Picture[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TDPhone_Picture[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_Picture[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_Picture[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_Picture[playerid], 4);
	PlayerTextDrawSetProportional(playerid, TDPhone_Picture[playerid], 0);
	PlayerTextDrawSetShadow(playerid, TDPhone_Picture[playerid], 0);

	TDPhone_NotifyText[playerid] = CreatePlayerTextDraw(playerid, 578.799987, 351.280090, "_");
	PlayerTextDrawLetterSize(playerid, TDPhone_NotifyText[playerid], 0.139199, 0.659200);
	PlayerTextDrawTextSize(playerid, TDPhone_NotifyText[playerid], 598.799987, 15.0);
	PlayerTextDrawAlignment(playerid, TDPhone_NotifyText[playerid], 3);
	PlayerTextDrawColor(playerid, TDPhone_NotifyText[playerid], -16776961);
	PlayerTextDrawSetShadow(playerid, TDPhone_NotifyText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TDPhone_NotifyText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TDPhone_NotifyText[playerid], 255);
	PlayerTextDrawFont(playerid, TDPhone_NotifyText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDPhone_NotifyText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TDPhone_NotifyText[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, TDPhone_NotifyText[playerid], true);

    for(new i = 0, Float:y = 352.607360; i < 4; ++i) {
		TDPhone_Choice[playerid][i] = CreatePlayerTextDraw(playerid, 511.666717, y, "_");
		PlayerTextDrawLetterSize(playerid, TDPhone_Choice[playerid][i], 0.199666, 0.820148);
		PlayerTextDrawTextSize(playerid, TDPhone_Choice[playerid][i], 587.000000, 7.000000);
		PlayerTextDrawAlignment(playerid, TDPhone_Choice[playerid][i], 1);
		PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, TDPhone_Choice[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][i], 255);
		PlayerTextDrawSetShadow(playerid, TDPhone_Choice[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, TDPhone_Choice[playerid][i], 255);
		PlayerTextDrawFont(playerid, TDPhone_Choice[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TDPhone_Choice[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TDPhone_Choice[playerid][i], true);

		y += 13.274079;
	}
}

//Mostra o celular para o player
ShowPlayerPhone(playerid) {
    ClosePlayerPhone(playerid, true);
    SelectTextDraw(playerid, 0x58ACFAFF);

    switch(pInfo[playerid][pPhoneModel]) //dark grey, blue, green, yellow, purple and pink.
    {
        case 0: // dark grey
        {
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 286331391); // the machine
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -858993409); // Left border
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -858993409); // Right edge
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], -1717986902); // Side button
        	SetPlayerAttachedObject(playerid, 9, 18868, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 1: // Red
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 1628113919);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -16776961);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -16776961);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 1124534271);
        	SetPlayerAttachedObject(playerid, 9, 18870, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 2: // blue
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 405561855);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], 65535);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], 65535);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 270418943);
        	SetPlayerAttachedObject(playerid, 9, 18872, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 3: // green
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 388831231);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], 8388863);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], 8388863);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 270471423);
            SetPlayerAttachedObject(playerid, 9, 18871, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 4: // yellow
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 2104099071);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -65281);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -65281);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 1464467711);
        	SetPlayerAttachedObject(playerid, 9, 18873, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 5: // orange
		{
			//ce9100ff ba7407ff ba7407ff
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 0xce9100ff);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], 0xba7407ff);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], 0xba7407ff);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 0xba7407ff);
        	SetPlayerAttachedObject(playerid, 9, 18865, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 6: // pink
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], -2063576577);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -16711681);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -16711681);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 1560295679);
        	SetPlayerAttachedObject(playerid, 9, 18869, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
		}
    }

    for(new i = 0; i != 14; ++i) {
		PlayerTextDrawShow(playerid, TDPhone_Model[playerid][i]);
	}

	PhoneOpen{playerid} = true;

	RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
}

//Fecha o celular para o player
ClosePlayerPhone(playerid, bool:noforce = false) {
	HidePlayerPhoneText(playerid);

    for(new i = 0; i != 14; ++i) PlayerTextDrawHide(playerid, TDPhone_Model[playerid][i]);

	if(!noforce) {
	    // reset values
		ph_menuid[playerid] = 0;
		ph_sub_menuid[playerid] = 0;
		ph_selected[playerid] = 0;
		ph_select_data[playerid] = -1;
		ph_page[playerid] = 0;
	    CancelSelectTextDraw(playerid);
	}

    PhoneOpen{playerid} = false;
}

//Esconder os textdraw
HidePlayerPhoneText(playerid) {
	for(new i = 0; i != 4; ++i) PlayerTextDrawHide(playerid, TDPhone_Choice[playerid][i]);

	PlayerTextDrawHide(playerid, TDPhone_BigText[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_ScreenText[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_TFButton[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_TSButton[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_Signal[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_NotifyText[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_Picture[playerid]);
}

//Renderiza (o celular) - faz o textdraw aparecer.
RenderPlayerPhone(playerid, menuid, subid, select = 0) {
    ph_menuid[playerid] = menuid;
	ph_sub_menuid[playerid] = subid;

	if(Dialog_Opened(playerid)) Dialog_Close(playerid);

	if(ph_menuid[playerid] == 6 && ph_sub_menuid[playerid] >= 1)
		PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][6], 0x1C1C1CFF);
	else
		PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][6], -572662273);

    PlayerTextDrawShow(playerid, TDPhone_Model[playerid][6]);

    HidePlayerPhoneText(playerid);

	new str[64];

	if(!IsUnreadSMS(playerid) || (menuid == 6 && subid > 0)) {
		PlayerTextDrawColor(playerid, TDPhone_Model[playerid][3], -1);
		PlayerTextDrawShow(playerid, TDPhone_Model[playerid][3]);
	}
	else
	{
		PlayerTextDrawColor(playerid, TDPhone_Model[playerid][3], 0x298A08FF);
		PlayerTextDrawShow(playerid, TDPhone_Model[playerid][3]);
	} 

	switch(menuid) {
	    case 0: {
			switch(subid) {
				case 0, 2: // Main Page
				{
					//for(new i = 0, j = GetPhoneSignal(playerid); i != j; ++i)
					//	format(str, sizeof(str), "%sI", str);

					//PlayerTextDrawSetString(playerid, TDPhone_Signal[playerid], (!strlen(str)) ? ("X") : str);
					//PlayerTextDrawShow(playerid, TDPhone_Signal[playerid]);
					/*static
						month,
						date[3];

					getdate(date[2], date[1], date[0]);
					 switch(date[1]) {
						case 1: month = "Jan"; 
						case 2: month = "Fev";
						case 3: month = "Mar";
						case 4: month = "Abr";
						case 5: month = "Mai";
						case 6: month = "Jun";
						case 7: month = "Jul";
						case 8: month = "Ago";
						case 9: month = "Set";
						case 10: month = "Out";
						case 11: month = "Nov";
						case 12: month = "Dez";
					} */
					format(str, sizeof(str), "%02d:%02d", ghour, gminute);
					PlayerTextDrawSetString(playerid, TDPhone_BigText[playerid], str);
					PlayerTextDrawShow(playerid, TDPhone_BigText[playerid]);

					/*format(str, sizeof(str), "%02d %s %d", date[0], month, date[2]);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], str);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);*/

					new missed_msg = CountMissedCall(playerid), unread_msg = CountUnreadSMS(playerid);

					if(missed_msg) {
		           		format(str, sizeof(str), "%d missed call", missed_msg);
					}
					else if(unread_msg) {
						format(str, sizeof(str), "%d unread message", unread_msg);
					}
					else str[0] = EOS;

	 				PlayerTextDrawSetString(playerid, TDPhone_NotifyText[playerid], str);
					PlayerTextDrawShow(playerid, TDPhone_NotifyText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Menu");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
				case 1: // List Main menu
				{
					new choice[4][16] = { "Phonebook", "SMS", "Calls", "Settings" };

				    for(new i = 0; i != 4; ++i) {
						PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][i], choice[i]);
						PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][i], (select == i) ? 0x989898FF : 0x000000FF);
						PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][i], (select == i) ? 0x222222FF : 0xAAAAAAFF);
						PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][i]);
				    }
				}
			}
	    }
	    case 1:
	    {
			switch(subid) // Phonebook menu
			{
				case 0:
				{
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Adicionar um contato");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "List contacts");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);

					ph_page[playerid] = 0;
					ph_select_data[playerid] = -1;
    			}
				case 1: // List contacts
				{
                    new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != 40; ++i)
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(ContactData[playerid][i][contactNumber])
				        {
	                        if(next)
	                        {
	                            next--;
	                            continue;
	                        }

							if(count > 3)
							{
							    break;
							}

							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], ContactData[playerid][i][contactName]);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);

							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count) {
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Your contact list ~n~is currently empty");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4) {
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
				case 2: // List contacts --> Details
				{
				    if(ph_select_data[playerid] == -1)
						ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

					format(str, 32, "%s~n~(%d)", ContactData[playerid][ph_select_data[playerid]][contactName], ContactData[playerid][ph_select_data[playerid]][contactNumber]);

					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], str);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);


					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Op��es");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
				case 3: // List contacts --> Details --> Actions
				{
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Call");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Text");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "Delete");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
			}
	    }
	    case 2:
	    {
			switch(subid) // SMS menu { SMS a contact, SMS a number, Inbox, Archive }
			{
				case 0:
				{
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "SMS a contact");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "SMS a number");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "Inbox");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][3], "Archive");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][3]);

					ph_page[playerid] = 0;
					ph_select_data[playerid] = -1;

				}
				case 1: // SMS a contact
				{
					new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != 40; ++i)
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(ContactData[playerid][i][contactNumber])
				        {
	                        if(next)
	                        {
	                            next--;
	                            continue;
	                        }

							if(count > 3)
							{
							    break;
							}

							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], ContactData[playerid][i][contactName]);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);
							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count) {
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Sua lista de contatos ~n~est� vazio no momento");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4) {
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Selecione");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
				/*case 2: // SMS a number
				{
				    Dialog_Show(playerid, SMSNumber, DIALOG_STYLE_INPUT, "Inserir n�mero", "send SMS to Phone Number\n\n\t\tDigite o n�mero de contato:", "Continuar", "Volte");
				}*/ 

			    case 3, 4: // 3- INBOX   4- Archive
 				{
					new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != MAX_SMS; ++i) if(subid == 3 && !SmsData[playerid][i][smsArchive] || subid == 4 && SmsData[playerid][i][smsArchive])
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(SmsData[playerid][i][smsExist])
				        {
	                        if(next)
	                        {
	                            next--;
	                            continue;
	                        }

							if(count > 3)
							{
							    break;
							}

							format(str, sizeof(str), "%s%s", (!SmsData[playerid][i][smsRead]) ? ("~>~ ") : (""), GetContactName(playerid, SmsData[playerid][i][smsOwner]));
                            //printf(str);
							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], str);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);
							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count) {
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "No messages in this~n~directory");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4) {
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
			}
		}
		case 3: // Calls
		{
			switch(subid) // Calls SMS { Dial a contact, Dial a number, View call history }
			{
				case 0: {
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Dial a contact");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Dial a number");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "View call history");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);

					ph_page[playerid] = 0;
					ph_select_data[playerid] = -1;
				}
				case 1: // Dial a contact
				{
					new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != 40; ++i) {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(ContactData[playerid][i][contactNumber]) {
	                        if(next) {
	                            next--;
	                            continue;
	                        }
							if(count > 3) {
							    break;
							}

							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], ContactData[playerid][i][contactName]);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);
							ph_data[playerid][count] = i + 1;
							count++;
						}
					}

					if(!count) {
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Your contact list ~n~is currently empty");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4)
					 {
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Selecionar");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
				case 3: // View call history
				{
					new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != MAX_CALLHISTORY; ++i)
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(CallHistory[playerid][i][chExists]) {
	                        if(next) {
	                            next--;
	                            continue;
	                        }
							if(count > 3) {
							    break;
							}
							format(str, sizeof(str), "%s%s", (!CallHistory[playerid][i][chType]) ? ("~u~") : (CallHistory[playerid][i][chType] == 2) ? ("~d~~r~") : ("~d~"), GetContactName(playerid, CallHistory[playerid][i][chNumber]));
							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], str);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);
							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count) {
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Your call history is~n~empty");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4) {
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
			}
		}
		case 7:
	    {
	        new
				callstring[128]
			;

			switch(subid) {
				case 0: //Dialing
				{
				    format(callstring, 128, "Dialing%s", ph_call_string[playerid]);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], callstring);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Hangup");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
				case 1: //Call with
				{
				    format(callstring, 128, "Call with%s", ph_call_string[playerid]);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], callstring);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Hangup");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
				case 2: //Incoming call
				{
				    format(callstring, 128, "Incoming call%s", ph_call_string[playerid]);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], callstring);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Answer");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Igonore");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
			}
		}
	    case 5: { // Noti
			switch(subid) {
			    case 0: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Contact is full");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 1: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Error!~n~Invalid number");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 2: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Notice!~n~The line is busy");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 3: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Call failed");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 4: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Sending ...");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 5: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Message delivered!");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 6: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Delivery failed");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 7: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "No signal");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
			}
	    }
	    case 6: { //OFF PHONE
			switch(subid) {
			    case 0: {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "See you!");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);
			    }
			    case 2: {
					PlayerTextDrawColor(playerid, TDPhone_ScreenText[playerid], 0x111111FF);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Loading...");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);
			    }			
			}
	    }
	    case 4: //Setting phone
	    {
			switch(subid) //Change Ringtone , airplane mode, silent mode, Phone Info
			{
			    case 0: {
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Change Ringtone");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], (ph_airmode[playerid]) ? ("Disable airplane mode") : ("Enable airplane mode"));
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], (ph_silentmode[playerid]) ? ("Disable silent mode") : ("Enable silent mode"));
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][3], "Phone Info");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][3]);

					ph_page[playerid] = 0;
					ph_select_data[playerid] = -1;
			    }
			    case 1: { // Ringtone
			    	PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Call ringtone");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Text ringtone");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
			    case 2: { // Ringtone - Call
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Ringtone 1");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Ringtone 2");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "Ringtone 3");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Volte");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
			    case 3: { // Ringtone - Text
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Ringtone 1");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Ringtone 2");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "Ringtone 3");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][3], "Ringtone 4");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][3]);
			    }
				case 4: { // Phone Info
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Framework: v1");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Fechar");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
			}
	    }
	}
	if(!PhoneOpen{playerid})
		ClosePlayerPhone(playerid, true);

	ph_selected[playerid] = select;
}

//Funcionalidades
//Retorna o numero ordinal.
/* returnOrdinal(number) {
	new
	    ordinal[4][3] = { "st", "nd", "rd", "th" }
	;

	number = number < 0 ? -number : number;

	return (((10 < (number % 100) < 14)) ? ordinal[3] : (0 < (number % 10) < 4) ? ordinal[((number % 10) - 1)] : ordinal[3]);
 } */ 

//Conta a quantidade de chamadas (creio eu - testar)
CountMissedCall(playerid) {
	new count;

	for(new x = 0; x < MAX_CALLHISTORY; ++x) {
		if(CallHistory[playerid][x][chExists] && !CallHistory[playerid][x][chRead] && CallHistory[playerid][x][chType] == 2) {
			count++;
		}
	}

	return count;
}

//Conta o numero de SMS (creio eu - testar)
CountUnreadSMS(playerid) {
	new count;

	for(new x = 0; x < MAX_SMS; ++x) {
		if(SmsData[playerid][x][smsExist] && !SmsData[playerid][x][smsRead]) {
			count++;
		}
	}

	return count;
}

//Verifica o nome do contato.
GetContactName(playerid, number) {
	new name[24], success = false;

	for(new x = 0; x < 40; ++x) {
		if(ContactData[playerid][x][contactNumber] == number) {
			format(name, 24, "%s", ContactData[playerid][x][contactName]);

			success = true;
			break;
		}
	}
	if(!success) format(name, 24, "%06d", number);
	return name;
}

//Veriica o ID do contato
GetContactID(playerid, number) {
	new id = -1;

	for(new x = 0; x < 40; ++x) {
		if(ContactData[playerid][x][contactNumber] == number) {
			id = x;
			break;
		}
	}
	return id;
}

//Cancelar liga��o (desligar)
CancelCall(playerid) {
	new callerid = pInfo[playerid][pCallConnect];

	if(callerid != INVALID_PLAYER_ID) {
		ph_menuid[callerid] = 0;
		ph_sub_menuid[callerid] = 0;

		RenderPlayerPhone(callerid, ph_menuid[callerid], ph_sub_menuid[callerid]);

		if(GetPlayerSpecialAction(callerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(callerid,SPECIAL_ACTION_STOPUSECELLPHONE);

		pInfo[callerid][pCallConnect] = INVALID_PLAYER_ID;
	   	pInfo[callerid][pCallLine] = INVALID_PLAYER_ID;
	   	pInfo[callerid][pCellTime] = 0;
	}

	ph_menuid[playerid] = 0;
	ph_sub_menuid[playerid] = 0;

	RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);

	pInfo[playerid][pCallConnect] = INVALID_PLAYER_ID;
	pInfo[playerid][pCallLine] = INVALID_PLAYER_ID;
	pInfo[playerid][pCellTime] = 0;
}

//Som de toque (Liga��o)
PlayPlayerCallTone(playerid) {
	switch(ph_CallTone[playerid]) {
	    case 0: PlayerPlaySound(playerid, 23000, 0.0, 0.0, 0.0);
	    case 1: PlayerPlaySound(playerid, 20600, 0.0, 0.0, 0.0);
	    case 2: PlayerPlaySound(playerid, 20804, 0.0, 0.0, 0.0);
	}
}

//Som de toque (mensagem)
PlayPlayerTextTone(playerid) {
	switch(ph_TextTone[playerid]) {
	    case 0: PlayerPlaySound(playerid, 41603, 0.0, 0.0, 0.0);
	    case 1: PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
	    case 2: PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
	    case 3: PlayerPlaySound(playerid, 21002, 0.0, 0.0, 0.0);
	}
}

//Pre-visualizar som de toque (chamada)
PreviewCallTone(playerid, type) {
	switch(type) {
	    case 0: PlayerPlaySound(playerid, 23000, 0.0, 0.0, 0.0);
	    case 1: PlayerPlaySound(playerid, 20600, 0.0, 0.0, 0.0);
	    case 2: PlayerPlaySound(playerid, 20804, 0.0, 0.0, 0.0);
	}
}

//Pre-visualizar som de toque (mensagem)
PreviewTextTone(playerid, type) {
	switch(type) {
	    case 0: PlayerPlaySound(playerid, 41603, 0.0, 0.0, 0.0);
	    case 1: PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
	    case 2: PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
	    case 3: PlayerPlaySound(playerid, 21002, 0.0, 0.0, 0.0);
	}
}

ShowEmo_Phone(playerid, emo) {
	if(PhoneOpen{playerid}) {
		switch(emo) {
		    case 1: PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0), PlayerTextDrawSetString(playerid, TDPhone_Picture[playerid], "ld_chat:thumbup");
		    case 2: PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0), PlayerTextDrawSetString(playerid, TDPhone_Picture[playerid], "ld_chat:thumbdn");
		    case 3: PlayPlayerTextTone(playerid), PlayerTextDrawSetString(playerid, TDPhone_Picture[playerid], "ld_chat:goodcha");
		}

		PlayerTextDrawShow(playerid, TDPhone_Picture[playerid]);
		SetTimerEx("HideEmo_Phone", 5000, false, "d", playerid);
	}
	return true;
}

//Para a selfie
PhoneSelfie_Stop(playerid) {
	if(ph_menuid[playerid] == 0 && ph_sub_menuid[playerid] == 2) {
	    if(selfie_timer[playerid]) KillTimer(selfie_timer[playerid]);

	    selfie_timer[playerid] = 0;

		RenderPlayerPhone(playerid, 0, 0);

		TogglePlayerControllable(playerid, true);

		SetCameraBehindPlayer(playerid);
		ClearAnimations(playerid);
	}
	return true;
}

OnPhoneClick_Selfie(playerid) {
	if(pInfo[playerid][pCallConnect] == INVALID_PLAYER_ID && ph_menuid[playerid] != 6) {
	    CancelSelectTextDraw(playerid);

	    SetPlayerArmedWeapon(playerid, 0);

	    TogglePlayerControllable(playerid, false);

		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] Press F8 to take screenshot, F7 (twice) to hide your chat.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] Hold W, A, S and D to manipulate the camera, hold ENTER to return back.");
		SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Info: Use /headmove to stop your head from moving.");

		GetPlayerPos(playerid, lX[playerid], lY[playerid], lZ[playerid]);
		GetPlayerFacingAngle(playerid, Degree[playerid]);

		Degree[playerid] += 90.0;
        SelAngle[playerid] = 0.8;

  		static Float: n1X, Float: n1Y;

		n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);

		SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid] + SelAngle[playerid]);
		SetPlayerFacingAngle(playerid, Degree[playerid] - 90);

		RenderPlayerPhone(playerid, 0, 2);

		ApplyAnimation(playerid, "PED", "gang_gunstand", 4.1, 0, 0, 0, 1, 0, 0);

		selfie_timer[playerid] = SetTimerEx("SelfieTimer", 500, true, "d", playerid);
	}
	return true;
}


ForceSwitchPhone(playerid, bool:hide = false) {
	if(pInfo[playerid][pCallLine] != INVALID_PLAYER_ID) CancelCall(playerid);

	ph_menuid[playerid] = 6;
	ph_sub_menuid[playerid] = 1;

	PhoneSelfie_Stop(playerid);

	if(hide) ClosePlayerPhone(playerid, true);
}

IsUnreadSMS(playerid) {
	new count = false;

	for(new x = 0; x < MAX_SMS; ++x) {
		if(SmsData[playerid][x][smsExist] && !SmsData[playerid][x][smsRead]) {
			count = true;
			break;
		}
	}

	return count;
}

CheckPhoneStatus(playerid) {
	if(ph_menuid[playerid] == 6 && ph_sub_menuid[playerid] >= 0)
	    return false;

	return true;
}

OnPhoneEvent(playerid, menuid, subid, eventid) {
	switch(menuid) {
		case 0: // MAIN
		{
			switch(subid) {
				case 0: // Clock
				{
				    switch(eventid)
				    {
				        case PH_LBUTTON:
				        {
							RenderPlayerPhone(playerid, ph_menuid[playerid], 1);
				        }
  				        case PH_RBUTTON:
				        {
				            ClosePlayerPhone(playerid, true);
				            CancelSelectTextDraw(playerid);

				            RemovePlayerAttachedObject(playerid, 9);

						    Annotation(playerid, "puts their phone away.");
				        }
				    }
				}
 				case 1: // Main Menu { Phonebook, SMS, Calls, Settings }
				{
  				    switch(eventid)
				    {
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							ph_menuid[playerid] = ph_selected[playerid] + 1;
							ph_sub_menuid[playerid] = 0;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid] = 0;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				    }
				}
			}
		}
		case 1: // PHONEBOOK
		{
			switch(subid) {
				case 0: // Main Phonebook { Adicionar um contato, List contacts }
				{
				  	switch(eventid)
				    {
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 1)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_menuid[playerid]--;
                    		ph_sub_menuid[playerid]++;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
                    		if(ph_selected[playerid] == 0)
                    		{
                    			Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter the contact name:", "Continuar", "Volte");
                    		}
                    		else
                    		{
                    		    ph_sub_menuid[playerid]++;

                    		    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
							}
				        }
					}
				}
 				case 1: // List contacts
				{
				  	switch(eventid)
				    {
				        case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count-1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i = ph_data[playerid][3]; i != 40; ++i)
				                    {
				                    	if(ContactData[playerid][i][contactNumber])
								        {
									        ph_selected[playerid] = 0;
									        ph_page[playerid]++;
											break;
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid] = 3;
									ph_page[playerid]--;
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    if(ph_select_data[playerid] == -1)
								ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

	                   		ph_sub_menuid[playerid]++;

	                   		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
					}
				}
 				case 2: // Details NAME (NUMBER) {
					{
				  	switch(eventid)
				    {
				        case PH_LBUTTON:
				        {
                    		ph_sub_menuid[playerid]++;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_RBUTTON:
				        {
							ph_page[playerid] = 0;
							ph_select_data[playerid] = -1;

                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
					}
				}
 				case 3: // ACTION
				{
				  	switch(eventid)
   					{
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 2)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							switch(ph_selected[playerid])
							{
							    case 0:
								{
									new nstring[24];
			   						Int32(nstring, ContactData[playerid][ph_select_data[playerid]][contactNumber]);
									CallNumber(playerid, nstring);
								}
							    case 1:
								{
									new nstring[24];
			   						Int32(nstring, ContactData[playerid][ph_select_data[playerid]][contactNumber]);
							        SetPVarString(playerid,"SMSPhoneNumber", nstring);
									Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Servi�o de mensagens curtas", "Fill out the text:", "Enviar", "Volte");
                       			}
								case 2: Dialog_Show(playerid, DeleteContact, DIALOG_STYLE_MSGBOX, "Tem certeza?", "Are you sure you want to delete it? %s (%d) Out of contact list?", "Sim", "Nao", ContactData[playerid][ph_select_data[playerid]][contactName], ContactData[playerid][ph_select_data[playerid]][contactNumber]);
							}
				        }
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
					}
				}
 				/*case 4: // ACTION -> Call, Text, Delete
				{
					new i = ph_data[playerid][ph_selected[playerid]];
					format(str, 32, "~n~%s~n~(%d)", ContactData[playerid][i][contactName], ContactData[playerid][i][contactNumber]);
				  	switch(eventid)
				    {
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;
						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
					}
				}*/
			}
		} 
		case 2: // SMS
		{
			switch(subid) {
				case 0: // Main SMS { SMS a contact, SMS a number, Inbox, Archive }
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							ph_sub_menuid[playerid] = ph_selected[playerid] + 1;

							if(ph_sub_menuid[playerid] == 2)
							{
							    ph_sub_menuid[playerid] = 0;

							    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], 1);

								Dialog_Show(playerid, SMSNumber, DIALOG_STYLE_INPUT, "Inserir n�mero", "Send SMS via phone number\n\n\t\tDigite o n�mero de contato:", "Continuar", "Volte");
							}
							else
							{
								RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
							}
				        }
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 0, 1);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
 				case 1: // SMS a contact
				{
					switch(eventid)
				    {
				        case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count-1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i = ph_data[playerid][3]; i != 40; ++i)
				                    {
				                    	if(ContactData[playerid][i][contactNumber])
								        {
									        ph_selected[playerid] = 0;
									        ph_page[playerid]++;
											break;
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid]=3;
									ph_page[playerid]--;
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    if(ph_select_data[playerid] == -1)
								ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							new nstring[24];
			   				Int32(nstring, ContactData[playerid][ph_select_data[playerid]][contactNumber]);
							SetPVarString(playerid, "SMSPhoneNumber", nstring);

							Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Servi�o de mensagens curtas", "Preencha:", "Enviar", "Volte");
				        }
					}
				}
 				/*case 2: // SMS a number
				{

				}*/
 				case 3, 4: // 3- Inbox 4- Archive
				{
					switch(eventid)
				    {
						case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count-1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i=ph_data[playerid][3]; i != MAX_SMS; ++i)
									{
										if(subid == 3 && !SmsData[playerid][i][smsArchive] || subid == 4 && SmsData[playerid][i][smsArchive])
					                    {
					                    	if(SmsData[playerid][i][smsExist])
									        {
										        ph_selected[playerid] = 0;
										        ph_page[playerid]++;
												break;
											}
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid] --;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid] = 3;
									ph_page[playerid] --;
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid] = 0;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							new id = ph_select_data[playerid];

							if(SmsData[playerid][id][smsRead])
							{
								Dialog_Show(playerid, SMSRead, DIALOG_STYLE_MSGBOX, "SMS", "{A9C4E4}Sender:\t\t{7e98b6}%s\n{A9C4E4}Sent:  \t\t{7e98b6}%s\n\n{A9C4E4}%s", "Options", "Close", GetContactName(playerid, SmsData[playerid][id][smsOwner]), SmsData[playerid][id][smsDate], SmsData[playerid][id][smsText]);
	                        }
							else
							{
								SmsData[playerid][id][smsRead] = 1;

								RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
							}
				        }
					}
				}
			}
		}
		case 3: // Calls
		{
			switch(subid) {
				case 0: // Calls SMS { Dial a contact, Dial a number, View call history }
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							ph_sub_menuid[playerid] = ph_selected[playerid] + 1;

							if(ph_sub_menuid[playerid] == 2)
							{
							    ph_sub_menuid[playerid] = 0;

							    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], 1);

								Dialog_Show(playerid, CallNumber, DIALOG_STYLE_INPUT, "Insert a number", "Insert number you want to call.", "Call", "Cancel");
							}
							else
							{
								RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
							}
				        }
				        case PH_RBUTTON:
				        {
                    		ph_menuid[playerid] = 0;
                    		ph_sub_menuid[playerid] = 1;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
 				case 1: // Dial a contact
				{
					switch(eventid)
				    {
				        case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count - 1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i = ph_data[playerid][3]; i < 40; ++i)
				                    {
				                    	if(ContactData[playerid][i][contactNumber])
								        {
									        ph_selected[playerid] = 0;
									        ph_page[playerid]++;
											break;
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid] = 3;
									ph_page[playerid]--;
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    if(ph_select_data[playerid] == -1)
								ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							new id = ph_select_data[playerid], nstring[24];
						  	Int32(nstring, ContactData[playerid][id][contactNumber]);
							CallNumber(playerid, nstring);
				        }
					}
				}
 				case 3: // View call history
				{
				  	switch(eventid)
				    {
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    if(ph_select_data[playerid] == -1)
								ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							new id = ph_select_data[playerid], str[64], list[256];
							new Iscontact = GetContactID(playerid, CallHistory[playerid][id][chNumber]);
							if(Iscontact == -1) format(str, 64, "%s%d", (!CallHistory[playerid][id][chType]) ? ("Outgoing call to ") : (CallHistory[playerid][id][chType] == 2) ? ("Missed call form ") : ("Incoming call form "), CallHistory[playerid][id][chNumber]);
							else format(str, 64, "%s%s (%d)", (!CallHistory[playerid][id][chType]) ? ("Outgoing call to ") : (CallHistory[playerid][id][chType] == 2) ? ("Missed call form ") : ("Incoming call form "), ContactData[playerid][Iscontact][contactName], ContactData[playerid][Iscontact][contactNumber]);

							CallHistory[playerid][id][chRead] = true;

							new diff = gettime()-CallHistory[playerid][id][chSec];
							new mins, hours;
							format(list, 256, "%s\n%s ago\nCall\nText\n%s", str, ConvertTime(diff, mins, hours), (GetContactID(playerid,CallHistory[playerid][id][chNumber]) == -1) ? ("Save number") : ("View contact"));
							Dialog_Show(playerid, CallHistoryDialog, DIALOG_STYLE_LIST, str, list, "Select", "Close");
				        }
				        case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count-1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i = ph_data[playerid][3]; i < MAX_CALLHISTORY; ++i)
				                    {
				                    	if(CallHistory[playerid][i][chExists])
								        {
									        ph_selected[playerid] = 0;
									        ph_page[playerid]++;
											break;
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid]=3;
									ph_page[playerid]--;
							    }
							}
							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON: RenderPlayerPhone(playerid, 3, 0);
					}
				}
			}
		}
	    case 4: // Phone Settings
		{
			switch(subid) {
				case 0: //Change Ringtone , airplane mode, silent mode, Phone Info
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							switch(ph_selected[playerid])
							{
							    case 0: ph_sub_menuid[playerid] = 1;
			                	case 1:
								{
		                            if(ph_airmode[playerid]) ph_airmode[playerid] = 0;
		                            else ph_airmode[playerid] = 1;
								}
			                	case 2:
								{
		                            if(ph_silentmode[playerid]) ph_silentmode[playerid] = 0;
		                            else ph_silentmode[playerid] = 1;
								}
							    case 3: ph_sub_menuid[playerid] = 4;
       						}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 0, 1);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
				case 1: //Change Ringtone => Call ringtone, Text ringtone
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							switch(ph_selected[playerid])
							{
							    case 0: ph_sub_menuid[playerid] = 2;
							    case 1: ph_sub_menuid[playerid] = 3;
       						}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_RBUTTON:
				        {
                    		ph_menuid[playerid] = 4;
                    		ph_sub_menuid[playerid] = 0;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 1)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
				case 2: //Call ringtone (1 2 3)
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
				            SetPVarInt(playerid, "ringtype", 0);

							Dialog_Show(playerid, CallRingtone, DIALOG_STYLE_MSGBOX, "Confirm", "Would you like to use this ringtone?", "Yes", "No");
				        }
				        case PH_RBUTTON:
				        {
                    		ph_menuid[playerid] = 4;
                    		ph_sub_menuid[playerid] = 1;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 2)
							{
							    ph_selected[playerid]++;
							}

							PreviewCallTone(playerid, ph_selected[playerid]);

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							PreviewCallTone(playerid, ph_selected[playerid]);

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
				case 3: //Text ringtone (1 2 3 4)
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
				            SetPVarInt(playerid, "ringtype", 1);

							Dialog_Show(playerid, CallRingtone, DIALOG_STYLE_MSGBOX, "Confirm", "Would you like to use this ringtone?", "Yes", "No");
				        }
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 4, 1);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							PreviewTextTone(playerid, ph_selected[playerid]);

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							PreviewTextTone(playerid, ph_selected[playerid]);

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
				case 4: //Info
				{
  				  	switch(eventid)
   					{
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 4, 0);
				        }
					}
				}
			}
		}
		case 5: // Notify
		{
			switch(subid) {
				case 0..7: //
				{
				  	switch(eventid)
				    {
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 1, 0);
				        }
					}
				}
			}
		}
		case 7: // Dialing / Call with ...
		{
			switch(subid) {
				case 0: // Dialing
				{
				  	switch(eventid)
				    {
				        case PH_RBUTTON:
				        {
							if(calltimer[playerid])
							{
								KillTimer(calltimer[playerid]);

								calltimer[playerid] = 0;
							}

                            new targetid = pInfo[playerid][pCallConnect];

							if(targetid != INVALID_PLAYER_ID)
				            {
                                AddPlayerCallHistory(targetid, pInfo[playerid][pPhoneNumber], PH_MISSED);

								SendClientMessage(targetid, COLOR_GRAD2, "[ ! ] They hung up.");

	          					pInfo[targetid][pCallConnect] = INVALID_PLAYER_ID;
	          					pInfo[targetid][pCallLine] = INVALID_PLAYER_ID;

							    RenderPlayerPhone(targetid, 0, 0);

							    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);
							}

                    		pInfo[playerid][pCallLine] = INVALID_PLAYER_ID;
                    		pInfo[playerid][pCallConnect] = INVALID_PLAYER_ID;

						    RenderPlayerPhone(playerid, 0, 0);

						    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				        }
					}
				}
				case 1: // Call with
				{
				  	switch(eventid)
				    {
				        case PH_RBUTTON: //Terminate current
				        {
							new targetid = pInfo[playerid][pCallConnect];

							if(targetid != INVALID_PLAYER_ID)
				            {
				                SendClientMessage(targetid, COLOR_GRAD2, "[ ! ] They hung up.");

								pInfo[targetid][pCellTime] = 0;
								pInfo[targetid][pCallLine] = INVALID_PLAYER_ID;

							    RenderPlayerPhone(targetid, 0, 0);

							    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);

							    pInfo[targetid][pCallConnect] = INVALID_PLAYER_ID;
							}

							SendClientMessage(playerid, COLOR_GRAD2, "[ ! ] You hung up.");

							pInfo[playerid][pCellTime] = 0;
							pInfo[playerid][pCallLine] = INVALID_PLAYER_ID;
							pInfo[playerid][pCallConnect] = INVALID_PLAYER_ID;

							RenderPlayerPhone(playerid, 0, 0);

							SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				        }
					}
				}
				case 2: // Incoming
				{
				  	switch(eventid)
				    {
				        case PH_LBUTTON: //Receive calls
				        {
							new targetid = pInfo[playerid][pCallConnect];

							if(targetid != INVALID_PLAYER_ID)
				            {
				                SendClientMessage(targetid, COLOR_GREY, "[ ! ] You can talk now by using the chat box.");

								pInfo[targetid][pCellTime] = 0;
								pInfo[targetid][pCallLine] = playerid;

	                    		ph_sub_menuid[targetid] += 1;

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
				        case PH_RBUTTON: //Cancel incoming calls
				        {
				            new targetid = pInfo[playerid][pCallConnect];

				            if(targetid != INVALID_PLAYER_ID)
				            {
				                SendClientMessage(targetid, COLOR_GRAD2, "[ ! ] They hung up.");

							    RenderPlayerPhone(targetid, 0, 0);

							    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);

							    pInfo[targetid][pCallConnect] = INVALID_PLAYER_ID;
                            	pInfo[targetid][pCallLine] = INVALID_PLAYER_ID;

							    AddPlayerCallHistory(playerid, pInfo[targetid][pPhoneNumber], PH_MISSED);
				            }

							SendClientMessage(playerid, COLOR_GRAD2, "[ ! ] You hung up.");

				        	pInfo[playerid][pIncomingCall] = 0;
				        	pInfo[playerid][pCallConnect] = INVALID_PLAYER_ID;
							pInfo[playerid][pCallLine] = INVALID_PLAYER_ID;

						    RenderPlayerPhone(playerid, 0, 0);
				        }
					}
				}
			}
		}
	}
}

CallNumber(playerid, const params[]) {
	if(pInfo[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Your phone was confiscated by the cops.");

    if(pInfo[playerid][pInjured])
		return SendErrorMessage(playerid, "You can't do this right now.");

	if(!CheckPhoneStatus(playerid))
	    return SendErrorMessage(playerid, "You can't do this now (phone off).");

	if(ph_airmode[playerid])
		return SendErrorMessage(playerid, "You can't do this now (airplane mode on).");

  	if(calltimer[playerid] || smstimer[playerid] || GetPlayerSpecialAction(playerid) > 0 || pInfo[playerid][pMoney] < 10)
	  	return SendErrorMessage(playerid, "You can't do this right now.");

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
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observa��o: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~911");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "O Despacho de Emerg�ncia diz (telefone): Aqui est� o Despacho de Emerg�ncia 911. Qual servi�o voc� precisa?");

			pInfo[playerid][pCallLine] = 911;
			pInfo[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 991) {
			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid}) {
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observa��o: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~991");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "O Despacho da Pol�cia diz (telefone): Telefone fixo n�o emergencial para servi�os de aplica��o da lei, o que voc� ...");
			SendClientMessage(playerid, COLOR_YELLOW, "O Despacho da Pol�cia diz (telefone): ... sua localiza��o atual?");

			pInfo[playerid][pCallLine] = 991;
			pInfo[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 555) {
			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid}) {
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observa��o: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~555");

            RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "O Despacho Mec�nico diz (telefone): Los Santos Mechanical Services, como podemos ajudar?");

			pInfo[playerid][pCallLine] = 555;
			pInfo[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 544) {
			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid}) {
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observa��o: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~544");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "Taxi Dispatch diz (telefone): Al�, onde voc� quer ir?");

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
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Observa��o: para alternar o telefone, use /phone. Para ativar o mouse, use /pc.");
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

SendSMS(playerid, const params[]) {
	if(pInfo[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Erro: Seu telefone foi confiscado pela pol�cia.");

    if(pInfo[playerid][pInjured])
		return SendErrorMessage(playerid, "Voc� n�o pode fazer isso agora.");

	if(ph_menuid[playerid] == 6)
	    return SendErrorMessage(playerid, "Voc� n�o pode fazer isso agora (telefone desligado).");

	if(ph_airmode[playerid])
		return SendErrorMessage(playerid, "Voc� n�o pode fazer isso agora (modo avi�o ativado).");

  	if(calltimer[playerid] || smstimer[playerid] || GetPlayerSpecialAction(playerid) > 0 || pInfo[playerid][pMoney] < 1)
	  	return SendErrorMessage(playerid, "Voc� n�o pode fazer isso agora.");

	new phonenumb[24], sms_text[128];

	if(sscanf(params, "s[24]s[128]", phonenumb, sms_text))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Usage: /sms [numero/contato] [text]");

    if(pInfo[playerid][pPhoneNumber]) {
	    new phonenumber = strval(phonenumb);


		new nid = -1;

		for(new i = 0; i != 40; ++i) {
			if(ContactData[playerid][i][contactNumber] > 0 && (!strcmp(ContactData[playerid][i][contactName], phonenumb, true) || ContactData[playerid][i][contactNumber] == phonenumber)) {
				nid = i;
    			break;
   			}
  		}

  		Annotation(playerid, "digita algo em seu telefone.");

		if(!PhoneOpen{playerid}) ShowPlayerPhone(playerid);

		// SMS Screen
		ph_menuid[playerid] = 5;
		ph_sub_menuid[playerid] = 4;

		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

        SetPVarString(playerid,"SMSPhoneText", sms_text);

		/*new signal = GetPhoneSignal(playerid);
		
		if(signal > 4) smstimer[playerid] = SetTimerEx("SendPlayerSMS", 3000, false, "ddd", playerid, nid, phonenumber);
		else if(signal > 3) smstimer[playerid] = SetTimerEx("SendPlayerSMS", 4000, false, "ddd", playerid, nid, phonenumber);
		else if(signal > 2) smstimer[playerid] = SetTimerEx("SendPlayerSMS", 5000, false, "ddd", playerid, nid, phonenumber);
		else if(signal > 1) smstimer[playerid] = SetTimerEx("SendPlayerSMS", 6000, false, "ddd", playerid, nid, phonenumber); */
		smstimer[playerid] = SetTimerEx("SendPlayerSMS", 7000, false, "ddd", playerid, nid, phonenumber); 
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "   You don't have a phone.");

	return true;
}

AddPlayerCallHistory(playerid, number, type) {
	for(new i = MAX_CALLHISTORY - 1; i >= 0; i--) {
	    if(!CallHistory[playerid][i][chExists]) {
	        CallHistory[playerid][i][chExists] = true;
	        CallHistory[playerid][i][chSec] = gettime();
	        CallHistory[playerid][i][chType] = type;
	        CallHistory[playerid][i][chNumber] = number;
	        CallHistory[playerid][i][chRead] = false;
	    	break;
	    }
	}
}

//=========================================================================================================
Dialog:CallHistoryDialog(playerid, response, listitem, inputtext[]) {
	if(response) {
	    new id = ph_select_data[playerid], nstring[24];

		switch(listitem) {
		    case 2:
			{
			  	Int32(nstring, CallHistory[playerid][id][chNumber]);
				CallNumber(playerid, nstring);
		    }
		    case 3:
			{
			 	Int32(nstring, CallHistory[playerid][id][chNumber]);

				SetPVarString(playerid, "SMSPhoneNumber", nstring);

				Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Servi�o de mensagens curtas", "Preencha:", "Enviar", "Volte");
		    }
		    case 4:
			{
                new exist = -1;

				if((exist = GetContactID(playerid, CallHistory[playerid][id][chNumber])) != -1)
				{
		           	ph_menuid[playerid] = 1;
		       		ph_sub_menuid[playerid]=2;
		       		ph_page[playerid] = 0;
		       		ph_select_data[playerid]=exist;

		       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				}
				else
				{
				    Dialog_Show(playerid, AddHistoryContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tInsert contact name:", "Continuar", "Volte");
				}
		    }
		}
	}
	return true;
}

Dialog:CallRingtone(playerid, response, listitem, inputtext[]) {
	if(response) {
		if(!GetPVarInt(playerid, "ringtype")) ph_CallTone[playerid] = ph_selected[playerid];
		else ph_TextTone[playerid] = ph_selected[playerid];
	}

	DeletePVar(playerid, "ringtype");
}

Dialog:AddContact(playerid, response, listitem, inputtext[]) {
	if(response) {
		if(strlen(inputtext) < 2 || strlen(inputtext) > 20)
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter contact name:\t\tErro: Contact must be long. 2-20 caracters", "Continuar", "Volte");

		new Regex:r = Regex_New("^[A-Za-z0-9 ]+$"), RegexMatch:m;

		if(!Regex_Match(inputtext, r, m))
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter contact name:\t\tErro: Invalid symbol detected.", "Continuar", "Volte");

		//[a-zA-Z0-9]+
		SetPVarString(playerid, "ContactName", inputtext);

        Dialog_Show(playerid, AddContactNum, DIALOG_STYLE_INPUT, "Inserir n�mero", "Adicionar um contato\n\n\t\tDigite o n�mero de contato:", "Continuar", "Volte");
	}
	return true;
}

Dialog:AddContactNum(playerid, response, listitem, inputtext[]) {
	if(response) {
		new name[24];

		GetPVarString(playerid, "ContactName", name, sizeof(name));

		if(!IsNumeric(inputtext) || strlen(inputtext) > 10 || strlen(inputtext) <= 0)
			return Dialog_Show(playerid, AddContactNum, DIALOG_STYLE_INPUT, "Inserir n�mero", "Adicionar um contato\n\n\t\tDigite o n�mero de contato:\t\tErro: The specified number is invalid.", "Continuar", "Volte");

		new count, con_max = 16, exist = -1;

		/*switch(pInfo[playerid][pDonateRank]) {
		    case 0: con_max = 16;
		    case 1: con_max = 24;
		    case 2: con_max = 32;
		    case 3: con_max = 40;
		} */

		for(new i = 0; i < 40; ++i) {
		    if(ContactData[playerid][i][contactNumber]) {
                count++;
		    }
		    else
		    {
		        if(exist == -1) {
				    exist = i;
				}
		    }
		}

		if(count < con_max) {
			ContactData[playerid][exist][contactNumber] = strval(inputtext);
			format(ContactData[playerid][exist][contactName], 24, name);

	     	format(query, sizeof(query), "INSERT INTO `phone_contacts` (`contactAdded`, `contactAddee`, `contactName`) VALUES ('%d', '%d', '%s')", pInfo[playerid][pPhoneNumber], ContactData[playerid][exist][contactNumber], ContactData[playerid][exist][contactName]);
			mysql_pquery(DBConn, query);

			ContactData[playerid][exist][contactID] = cache_insert_id();

           	ph_menuid[playerid] = 1;
       		ph_sub_menuid[playerid] = 2;
       		ph_page[playerid] = 0;
       		ph_select_data[playerid]=exist;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
		else
		{
           	ph_menuid[playerid] = 5;
       		ph_sub_menuid[playerid] = 0;
       		ph_page[playerid] = 0;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
	}
	else
	{
	    DeletePVar(playerid, "ContactName");
	    Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter contact name:", "Continuar", "Volte");
	}
	return true;
}

Dialog:DeleteContact(playerid, response, listitem, inputtext[]) {
	if(response) {
		
		format(query, sizeof(query), "DELETE FROM `phone_contacts` WHERE `contactID` = %d", ContactData[playerid][ph_select_data[playerid]][contactID]);
  		mysql_pquery(DBConn, query);

  		ContactData[playerid][ph_select_data[playerid]][contactID] = 0;
  		ContactData[playerid][ph_select_data[playerid]][contactNumber] = 0;

		ph_page[playerid] = 0;
		ph_select_data[playerid] = -1;
     	ph_menuid[playerid] = 1;
      	ph_sub_menuid[playerid] = 1;

		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
	}
	return true;
}

Dialog:SMSNumber(playerid, response, listitem, inputtext[]) {
	if(response) {
	    SetPVarString(playerid,"SMSPhoneNumber",inputtext);
		Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Servi�o de mensagens curtas", "Preencha:", "Enviar", "Volte");
	}
	return true;
}

Dialog:SMSText(playerid, response, listitem, inputtext[]) {
	if(response) {
	    new str[128], phonenumb[16];
		GetPVarString(playerid, "SMSPhoneNumber", phonenumb, 16);
	    format(str, sizeof(str), "%s %s", phonenumb, inputtext);
		SendSMS(playerid, str);
	}

	DeletePVar(playerid, "SMSPhoneNumber");
	return true;
}

Dialog:SMSRead(playerid, response, listitem, inputtext[]) {
	if(response) {
	    new id = ph_select_data[playerid];
		Dialog_Show(playerid, SMSOption, DIALOG_STYLE_LIST, "Op��es", "Reply\nCall\n%s\nForward\nDelete\n%s", "Continuar", "Volte", (!SmsData[playerid][id][smsArchive]) ? ("Archive") : ("Remove form archive"), (GetContactID(playerid,SmsData[playerid][id][smsOwner]) == -1) ? ("Save number") : ("View contact"));
	}
	return true;
}

Dialog:SMSOption(playerid, response, listitem, inputtext[]) {
	new nstring[24], id = ph_select_data[playerid];

	if(response) {
		switch(listitem) {
		    case 0:  // reply
		    {
			 	Int32(nstring, SmsData[playerid][id][smsOwner]);
				SetPVarString(playerid,"SMSPhoneNumber", nstring);
				Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Servi�o de mensagens curtas", "Preencha:", "Enviar", "Volte");
			}
		    case 1:
			{
			  	Int32(nstring, SmsData[playerid][id][smsOwner]);
				CallNumber(playerid, nstring);
			}
		    case 2:  // archive
			{
				//

				if(SmsData[playerid][id][smsArchive]) SmsData[playerid][id][smsArchive] = 0;
				else SmsData[playerid][id][smsArchive] = 1;

				Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_INPUT, "Fechar", "%s", "OK", "", (SmsData[playerid][id][smsArchive]) ? ("Message archived") : ("Message removed from the archive"));

				RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
			}
		    case 3:
			{
				Dialog_Show(playerid, ForwardSMS, DIALOG_STYLE_INPUT, "Encaminhar SMS", "Digite o n�mero de telefone:", "Enviar", "Volte");
			}
		    case 4:
			{
				Dialog_Show(playerid, DeleteSMS, DIALOG_STYLE_MSGBOX, "Tem certeza?", "Are you sure you want to delete this message?", "Sim", "Nao");
			}
		    case 5:
			{
                new exist = -1;

				if((exist = GetContactID(playerid, SmsData[playerid][id][smsOwner])) != -1) {
		           	ph_menuid[playerid] = 1;
		       		ph_sub_menuid[playerid]=2;
		       		ph_page[playerid] = 0;
		       		ph_select_data[playerid]=exist;

		       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				}
				else Dialog_Show(playerid, AddSMSContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter contact name:", "Continuar", "Volte");
			}
		}
	}
	return true;
}

Dialog:ForwardSMS(playerid, response, listitem, inputtext[]) {
	if(response) {
	    new str[256], phonenumb = strval(inputtext), id = ph_select_data[playerid];

	    if(phonenumb && strlen(inputtext) < 16) {
		    format(str, sizeof(str), "%d %s", phonenumb, SmsData[playerid][id][smsText]);
			SendSMS(playerid, str);
        }
        else SendClientMessage(playerid, COLOR_LIGHTRED, "   The specified number is invalid.");
	}
	return true;
}

Dialog:AddSMSContact(playerid, response, listitem, inputtext[]) {
	if(response) {
		new id = ph_select_data[playerid];

		if(strlen(inputtext) < 2 || strlen(inputtext) > 20)
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter contact name:\t\tErro: Contact must be long. 2-20 caracters", "Continuar", "Volte");

		new Regex:r = Regex_New("^[A-Za-z0-9 ]+$"), RegexMatch:m;

		if(!Regex_Match(inputtext, r, m))
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter contact name:\t\tErro: Invalid symbol found.", "Continuar", "Volte");

		new count, con_max = 16, exist = -1;

		/*switch(pInfo[playerid][pDonateRank]) {
		    case 0: con_max = 16;
		    case 1: con_max = 24;
		    case 2: con_max = 32;
		    case 3: con_max = 40;
		} */

		for(new i = 0; i < 40; ++i) {
		    if(ContactData[playerid][i][contactNumber]) {
                count++;
		    }
		    else
		    {
		        if(exist == -1) {
				    exist = i;
				}
		    }
		}

		if(count < con_max) {
			ContactData[playerid][exist][contactNumber] = SmsData[playerid][id][smsOwner];
			format(ContactData[playerid][exist][contactName], 24, inputtext);

	     	format(query, sizeof(query), "INSERT INTO `phone_contacts` (`contactAdded`, `contactAddee`, `contactName`) VALUES ('%d', '%d', '%s')", pInfo[playerid][pPhoneNumber], ContactData[playerid][exist][contactNumber], ContactData[playerid][exist][contactName]);
			mysql_pquery(DBConn, query);

			ContactData[playerid][exist][contactID] = cache_insert_id();

           	ph_menuid[playerid] = 1;
       		ph_sub_menuid[playerid] = 2;
       		ph_page[playerid] = 0;
       		ph_select_data[playerid] = exist;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
		else
		{
           	ph_menuid[playerid] = 5;
       		ph_sub_menuid[playerid] = 0;
       		ph_page[playerid] = 0;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
	}
	return true;
}

Dialog:CallNumber(playerid, response, listitem, inputtext[]) {
	if(response) {
		CallNumber(playerid, inputtext);
	}
	return true;
}

Dialog:DeleteSMS(playerid, response, listitem, inputtext[]) {
	if(response) {
		new id = ph_select_data[playerid];
		
		mysql_format(DBConn, query, sizeof(query), "DELETE FROM `phone_sms` WHERE `id` = '%d' LIMIT 1", SmsData[playerid][id][smsID]);
		mysql_pquery(DBConn, query);

        SmsData[playerid][id][smsExist] = false;

  		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
	}
	return true;
}

Dialog:AddHistoryContact(playerid, response, listitem, inputtext[]) {
	if(response) {
		new id = ph_select_data[playerid];

		if(strlen(inputtext) < 2 || strlen(inputtext) > 20)
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter contact name:\t\tErro: Contact must be long. 2-20 caracters", "Continuar", "Volte");

		new Regex:r = Regex_New("^[A-Za-z0-9 ]+$"), RegexMatch:m;

		if(!Regex_Match(inputtext, r, m))
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Inseri o nome", "Adicionar um contato\n\n\t\tEnter contact name:\t\tErro: Invalid symbol found.", "Continuar", "Volte");

		new count, con_max = 16, exist = -1;

		/*switch(pInfo[playerid][pDonateRank]) {
		    case 0: con_max = 16;
		    case 1: con_max = 24;
		    case 2: con_max = 32;
		    case 3: con_max = 40;
		} */

		for(new i = 0; i < 40; ++i) {
		    if(ContactData[playerid][i][contactNumber]) {
                count++;
		    }
		    else
		    {
		        if(exist == -1) {
				    exist = i;
				}
		    }
		}

		if(count < con_max) {
			ContactData[playerid][exist][contactNumber] = CallHistory[playerid][id][chNumber];
			format(ContactData[playerid][exist][contactName], 24, inputtext);

	     	format(query,sizeof(query),"INSERT INTO `phone_contacts` (`contactAdded`, `contactAddee`, `contactName`) VALUES ('%d', '%d', '%s')", pInfo[playerid][pPhoneNumber], ContactData[playerid][exist][contactNumber], ContactData[playerid][exist][contactName]);
			mysql_pquery(DBConn, query);

			ContactData[playerid][exist][contactID] = cache_insert_id();

           	ph_menuid[playerid] = 1;
       		ph_sub_menuid[playerid]=2;
       		ph_page[playerid] = 0;
       		ph_select_data[playerid]=exist;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
		else
		{
           	ph_menuid[playerid]=5;
       		ph_sub_menuid[playerid] = 0;
       		ph_page[playerid] = 0;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
	}
	return true;
}

Dialog:AskTurnOff(playerid, response, listitem, inputtext[]) {
	if(response) {
        if(ph_menuid[playerid] != 6) {
			if(pInfo[playerid][pCallLine] != INVALID_PLAYER_ID) {
	      		SendClientMessage(pInfo[playerid][pCallLine],  COLOR_GRAD2, "[ ! ] They hung up.");
			    CancelCall(playerid);
			}

			PhoneSelfie_Stop(playerid);
			RenderPlayerPhone(playerid, 6, 0);

			SetTimerEx("PhoneTurnOff", 2000, false, "d", playerid);
		}
	}
	return true;
}

//=========================================================================================
//Fun��es complementares
Annotation(playerid, const message[]) {
	new str[128];
	format(str, sizeof(str), "* %s %s", pNome(playerid), message);
 	SetPlayerChatBubble(playerid, str, COLOR_PURPLE, 20.0, 6000);

 	SendClientMessage(playerid, COLOR_PURPLE, "> %s %s", pNome(playerid), message);

	LastAnnotation[playerid] = gettime();
}

//valstr fix by Slice
Int32(dest[], value, bool:pack = false) {
    // format can't handle cellmin properly
    static const cellmin_value[] = !"-2147483648";

    if(value == cellmin)
        pack && strpack(dest, cellmin_value, 12) || strunpack(dest, cellmin_value, 12);
    else
        format(dest, 12, "%d", value), pack && strpack(dest, dest, 12);
}

AnnounceMyAction(playerid, const text[]) {
	new playerName[MAX_PLAYER_NAME], bool:hasEnding = false, idx;

	format(playerName, sizeof(playerName), "%s", pNome(playerid));
	idx = strlen(playerName);

	if(playerName[idx-1] == 's' || playerName[idx-1] == 's') {
		hasEnding = true;
	}

	if(hasEnding == true) {
		if(strlen(text) > 80) {
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s' %.80s", pNome(playerid), text);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s' ...%s", pNome(playerid), text[80]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s' %s", pNome(playerid), text);
	}
	else
	{
		if(strlen(text) > 80) {
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s's %.80s", pNome(playerid), text);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s's ...%s", pNome(playerid), text[80]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s's %s", pNome(playerid), text);
	}
}

new const szMonthDay[][] =
{
	"Jan", "Fev", "Mar", "Abr",
	"Mai", "Jun", "Jul", "Ago", "Set", "Out",
	"Nov","Dez"
};

ReturnPhoneDateTime() {
 	static
	    szDay[64],
		date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(szDay, sizeof(szDay), "%s %d %d, %02d:%02d", szMonthDay[date[1] - 1], date[0], date[2], date[3], date[4]);

	return szDay;
}