#include <YSI_Coding\y_hooks>
hook ClickDynamicPlayerTD(playerid, PlayerText:playertextid) {
	if(playertextid == MDC_Main[playerid][4])
	{
		MDC_Hide(playerid);
	}

	if(playertextid == MDC_Main[playerid][10])
	{
		ShowMDCPage(playerid, MDC_PAGE_MAIN);
	}

	if(playertextid == MDC_Main[playerid][11])
	{
		ShowMDCPage(playerid, MDC_PAGE_LOOKUP);
	}

	/*if(playertextid == MDC_Main[playerid][12])
	{
		ShowMDCPage(playerid, MDC_PAGE_WARRANTS);
	}*/

	if(playertextid == MDC_Main[playerid][13])
	{
		ShowMDCPage(playerid, MDC_PAGE_EMERGENCY);
	}

	if(playertextid == MDC_Main[playerid][14])
	{
		ShowMDCPage(playerid, MDC_PAGE_ROSTER);
	}

	if(playertextid == MDC_Main[playerid][15])
	{
		SendErrorMessage(playerid, "MDC iùerisinde CCTV kullanùmù ùu anda devre dùùù.");
		//ShowMDCPage(playerid, MDC_PAGE_CCTV);
	}

	if(playertextid == MDC_Main[playerid][16])
	{
		ShowMDCPage(playerid, MDC_PAGE_VEHICLEBOLO);
	}


	if(playertextid == MDC_LookUp_Name[playerid][0]) // ùsim Seùeneùi
	{
		MDC_LOOKUP_SelectOption(playerid, MDC_PAGE_LOOKUP_NAME);
	}

	if(playertextid == MDC_LookUp_Name[playerid][1]) // Plaka Seùeneùi
	{
		MDC_LOOKUP_SelectOption(playerid, MDC_PAGE_LOOKUP_PLATE);
	}

	if(playertextid == MDC_LookUp_Name[playerid][17]) // Mekan seùeneùi
	{
		MDC_LOOKUP_SelectOption(playerid, MDC_PAGE_LOOKUP_BUILDING);
	}


	if(playertextid == MDC_PenalCode[playerid][48])
	{
		new page = GetPVarInt(playerid, "penalcodelist_idx");

		MDC_ShowPenalCode(playerid, page + 1);
	}

	if(playertextid == MDC_PenalCode[playerid][37])
	{
		Dialog_Show(playerid, MDC_PenalCode_Filter, DIALOG_STYLE_INPUT, "Filtre Uygula", "Filtrelemek istediùiniz suùlamanùn bir kùsmùnù girin veya filtreyi sùfùrlamak iùin boù bùrakùn.", "Ara", "Vazgeù");
	}

	if(playertextid == MDC_PenalCode[playerid][36])
	{
		PlayerTextDrawSetString(playerid, MDC_PenalCode[playerid][37], "_filtre_uygula_...");
		PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][37], -1802201857);
		PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][37], -1);

		MDC_ShowPenalCode(playerid);
		RefreshChargeButton(playerid);
	}

	if(playertextid == MDC_PenalCode[playerid][47])
	{
		new page = GetPVarInt(playerid, "penalcodelist_idx");

		MDC_ShowPenalCode(playerid, page - 1);
	}

	if(playertextid == MDC_LookUp_Name[playerid][2]) // Bu bastùùù o text girme yeri.
	{
			if(GetPVarInt(playerid,"MDC_SearchMode") == 1)
				Dialog_Show(playerid, MDC_LookUp_EnterBox, DIALOG_STYLE_INPUT, "Veri Girin", "Kimi arùyorsunuz?", "Ara", "Vazgeù");

			if(GetPVarInt(playerid,"MDC_SearchMode") == 2)
				Dialog_Show(playerid, MDC_LookUp_EnterBox, DIALOG_STYLE_INPUT, "Veri Girin", "Kimi arùyorsunuz?\nPlaka aramasùysa direkt olarak plakayù gir.\nAraù ID ùzerindense, 'id:ARAùID' ùeklinde girmelisin (ùrn: id:120)", "Ara", "Vazgeù");
	}
	if(playertextid == MDC_LookUp_Name[playerid][3]) // Refresh butonu
	{
		MDC_LookUp_Refresh(playerid);
	}


	if(playertextid == MDC_LookUp_Name[playerid][9])
	{
		MDC_ShowAddress(playerid, MDC_PlastLastSearched_SQLID[playerid]);
	}

	if(playertextid == MDC_AdressDetails[playerid][5])
	{
		SetAddresMapPosition(playerid, GetPVarFloat(playerid, "ShowAddressID1_X"), GetPVarFloat(playerid, "ShowAddressID1_Y"));
	}

	if(playertextid == MDC_AdressDetails[playerid][6])
	{
		SetAddresMapPosition(playerid, GetPVarFloat(playerid, "ShowAddressID2_X"), GetPVarFloat(playerid, "ShowAddressID2_Y"));
	}

	if(playertextid == MDC_AdressDetails[playerid][7])
	{
		SetAddresMapPosition(playerid, GetPVarFloat(playerid, "ShowAddressID3_X"), GetPVarFloat(playerid, "ShowAddressID3_Y"));
	}

	if(playertextid == MDC_LookUp_Name[playerid][14])
	{

	}

	if(playertextid == MDC_CriminalRecords[playerid][14])
	{
		MDC_HideAfterPage(playerid);
	}



	if(playertextid == MDC_LookUp_Name[playerid][12]) // Penal Code'a gitme butonu
	{
		MDC_ShowPenalCode(playerid);
	}

	if(playertextid == MDC_LookUp_Name[playerid][13]) // Tutuklama Raporu
	{
		new query_warrants[128];
		mysql_format(DBConn, query_warrants, sizeof(query_warrants), "SELECT id, by_id, reason FROM player_arrest WHERE player_id = %i AND active = 1", MDC_PlastLastSearched_SQLID[playerid]);
		new Cache:cache = mysql_query(DBConn, query_warrants);

		if(!cache_num_rows())
		{
			Dialog_Show(playerid, MDC_ArrestRecord, DIALOG_STYLE_INPUT, "Tutuklama Kaydù", "Yazmaya baùladùùùnùzda tutuklama kaydùnùz burada gùzùkecek.", "Devam", "ùptal Et");
		}
		else
		{
			new prison_record[1028], by_id, idx;
			cache_get_value_name(0, "reason", prison_record, 1028);
			cache_get_value_name_int(0, "by_id", by_id);
			cache_get_value_name_int(0, "id", idx);

			SetPVarInt(playerid, "AskDeleteRecordID", idx);

			new ask_dialog[1028];
			strcat(ask_dialog, sprintf("{FFFFFF}%s adlù kiùinin zaten tutuklama raporu %s tarafùndan yazùlmùù. Silmek ister misin?", MDC_PlayerLastSearched[playerid], SQLName(by_id)));
			strcat(ask_dialog, sprintf("\n\n{FFFFFF}(( Geùerli tutuklama raporu )):\n{FFFFFF}%s", prison_record));

			Dialog_Show(playerid, MDC_AskDeleteRecord, DIALOG_STYLE_MSGBOX, "Tutuklama Kaydù", ask_dialog, "Evet", "Hayùr");
		}
		cache_delete(cache);
	}


	if(playertextid == MDC_LookUp_Name[playerid][10]) // Lisans yùneitim
	{
		MDC_ShowManageLicense(MDC_PlastLastSearched_SQLID[playerid], playerid);
	}

	if(playertextid == MDC_AdressDetails[playerid][0])
	{
		MDC_HideAfterPage(playerid);

		MDC_ReturnLastSearch(playerid);
	}

	if(playertextid == MDC_ManageLicense[playerid][0])
	{
		MDC_HideAfterPage(playerid);

		MDC_ReturnLastSearch(playerid);
	}

	if(playertextid == MDC_PenalCode[playerid][16])
	{
		MDC_HideAfterPage(playerid);

		PlayerTextDrawSetString(playerid, MDC_PenalCode[playerid][37], "_filtre_uygula_...");
		PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][37], -1802201857);
		PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][37], -1);

		MDC_ReturnLastSearch(playerid);
	}

	if(playertextid == MDC_ManageLicense[playerid][6]) // Sùrùcù Lisansù iptal etme
	{
		foreach(new pl : Player)
		{
			if(strlen(MDC_PlayerLastSearched[playerid]) == strlen(pNome(pl)))
			{
				if(pInfo[pl][pLicense] == false)
					return SendErrorMessage(playerid, "Bu kiùi bir ehliyete sahip deùil.");

				pInfo[pl][pLicense] = false;
			}
		}
		
		format(query, sizeof(query), "SELECT * FROM `players` WHERE `Name` = '%s'", MDC_PlayerLastSearched[playerid]);
		new Cache:cache = mysql_query(DBConn, query);

		new dl;
		if(cache_num_rows())
		{
			cache_get_value_name_int(0, "DriversLicense", dl);
			cache_delete(cache);
		}

		if(dl == 0)
			return SendErrorMessage(playerid, "Bu kiùi bir ehliyete sahip deùil.");

		mysql_format(DBConn, query, sizeof(query), "UPDATE players SET DriversLicense = 0 WHERE id = %i", MDC_PlastLastSearched_SQLID[playerid]);
		mysql_tquery(DBConn, query);
		MDC_ShowManageLicense(MDC_PlastLastSearched_SQLID[playerid], playerid);
		SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, sprintf("** HQ Duyurusu: %s %s, %s adlù kiùinin ehliyetini iptal etti. **", Faction_GetRank(playerid), pNome(playerid), MDC_PlayerLastSearched[playerid]));
	}

	if(playertextid == MDC_ManageLicense[playerid][7]) // Sùrùcù Lisansù uyarma
	{
		foreach(new pl : Player)
		{
			if(strlen(MDC_PlayerLastSearched[playerid]) == strlen(pNome(pl)))
			{
				if(pInfo[pl][DriversLicenseWarning] == 2)
					{
						pInfo[pl][pLicense] = false;
						pInfo[pl][DriversLicenseWarning] = 0;
						SaveSQLInt(pInfo[pl][pID], "players", "DriversLicense", pInfo[pl][pLicense]);
						SaveSQLInt(pInfo[pl][pID], "players", "DriversLicenseWarning", pInfo[pl][DriversLicenseWarning]);
						MDC_ShowManageLicense(MDC_PlastLastSearched_SQLID[playerid], playerid);
						SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, sprintf("** HQ Duyurusu: %s %s, %s adlù kiùinin ehliyetine ùùùncù uyarù sebebiyle el koydu. **", Faction_GetRank(playerid), pNome(playerid), MDC_PlayerLastSearched[playerid]));

						return 1;
					}

				if(pInfo[pl][pLicense] != true)
					return SendErrorMessage(playerid, "Ehliyeti olmayan birisine uyarù puanù veremezsiniz.");

				pInfo[pl][DriversLicenseWarning] +=1;
			}
		}

		new query_properties[128];
		format(query_properties, sizeof(query_properties), "SELECT * FROM `players` WHERE `Name` = '%s'", MDC_PlayerLastSearched[playerid]);
		new Cache:cache = mysql_query(DBConn, query_properties);

		new warnings, dl;
		if(cache_num_rows())
		{
			cache_get_value_name_int(0, "DriversLicenseWarning", warnings);
			cache_get_value_name_int(0, "DriversLicense", dl);
			cache_delete(cache);
		}

		if(dl == 0)
			return SendErrorMessage(playerid, "Ehliyeti olmayan birisine uyarù puanù veremezsiniz.");

		mysql_format(DBConn, query_properties, sizeof(query_properties), "UPDATE players SET DriversLicenseWarning = %d WHERE id = %i", warnings+1, MDC_PlastLastSearched_SQLID[playerid]);
		mysql_tquery(DBConn, query_properties);
		MDC_ShowManageLicense(MDC_PlastLastSearched_SQLID[playerid], playerid);
		SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, sprintf("** HQ Duyurusu: %s %s, %s adlù kiùinin ehliyetine uyarù puanù verdi. **", Faction_GetRank(playerid), pNome(playerid), MDC_PlayerLastSearched[playerid]));
	}


	if(playertextid == MDC_ManageLicense[playerid][14]) // Medikal Lisans iptal etme
	{
		foreach(new pl : Player)
		{
			if(strlen(MDC_PlayerLastSearched[playerid]) == strlen(pNome(pl)))
			{
				if(pInfo[pl][pMedicalLicense] == false)
					return SendErrorMessage(playerid, "Bu kiùi bir medikal lisansùna sahip deùil.");

				pInfo[pl][pMedicalLicense] = false;
			}
		}
		
		format(query, sizeof(query), "SELECT * FROM `players` WHERE `Name` = '%s'", MDC_PlayerLastSearched[playerid]);
		new Cache:cache = mysql_query(DBConn, query);

		new dl;
		if(cache_num_rows())
		{
			cache_get_value_name_int(0, "MedicalLicense", dl);
			cache_delete(cache);
		}

		if(dl == 0)
			return SendErrorMessage(playerid, "Bu kiùi bir medikal lisansa sahip deùil.");

		mysql_format(DBConn, query, sizeof(query), "UPDATE players SET MedicalLicense = 0 WHERE id = %i", MDC_PlastLastSearched_SQLID[playerid]);
		mysql_tquery(DBConn, query);
		MDC_ShowManageLicense(MDC_PlastLastSearched_SQLID[playerid], playerid);
		SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, sprintf("** HQ Duyurusu: %s %s, %s adlù kiùinin medikal lisansùnù iptal etti. **", Faction_GetRank(playerid), pNome(playerid), MDC_PlayerLastSearched[playerid]));
	}

	if(playertextid == MDC_ManageLicense[playerid][30])
	{
		foreach(new pl : Player)
		{
			if(strlen(MDC_PlayerLastSearched[playerid]) == strlen(pNome(pl)))
			{
				if(pInfo[pl][pMedicalLicense] == true)
					return SendErrorMessage(playerid, "Bu kiùi zaten bir medikal lisansa sahip.");

				pInfo[pl][pMedicalLicense] = true;
			}
		}
		
		format(query, sizeof(query), "SELECT * FROM `players` WHERE `Name` = '%s'", MDC_PlayerLastSearched[playerid]);
		new Cache:cache = mysql_query(DBConn, query);

		new dl;
		if(cache_num_rows())
		{
			cache_delete(cache);
			cache_get_value_name_int(0, "MedicalLicense", dl);
		}

		if(dl == 1)
		{
			SendErrorMessage(playerid, "Bu kiùi zaten bir medikal lisansa sahip.");
			return 1;
		}

		mysql_format(DBConn, query, sizeof(query), "UPDATE players SET MedicalLicense = 1 WHERE id = %i", MDC_PlastLastSearched_SQLID[playerid]);
		mysql_tquery(DBConn, query);
		MDC_ShowManageLicense(MDC_PlastLastSearched_SQLID[playerid], playerid);
		SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, sprintf("** HQ Duyurusu: %s %s, %s adlù kiùinin medikal lisansù verdi. **", Faction_GetRank(playerid), pNome(playerid), MDC_PlayerLastSearched[playerid]));
	}

	if(playertextid == MDC_ManageLicense[playerid][21]) // Silah lisansù verme
	{
		if(13 > pInfo[playerid][pFactionRank])
			return SendErrorMessage(playerid, "Bu komutu SGT1+ ùzeri kullanabilir.");

		foreach(new pl : Player)
		{
			if(strlen(MDC_PlayerLastSearched[playerid]) == strlen(pNome(pl)))
			{
				if(pInfo[pl][pWeaponsLicense] == true)
					return SendErrorMessage(playerid, "Bu kiùi zaten silah lisansùna sahip.");

				pInfo[pl][pWeaponsLicense] = true;
			}
		}
		
		format(query, sizeof(query), "SELECT * FROM `players` WHERE `Name` = '%s'", MDC_PlayerLastSearched[playerid]);
		new Cache:cache = mysql_query(DBConn, query);

		new dl;
		if(cache_num_rows())
		{
			cache_get_value_name_int(0, "WeaponsLicense", dl);
			cache_delete(cache);
		}

		if(dl == 1)
			return SendErrorMessage(playerid, "Bu kiùi zaten silah lisansùna sahip.");

		mysql_format(DBConn, query, sizeof(query), "UPDATE players SET WeaponsLicense = 1 WHERE id = %i", MDC_PlastLastSearched_SQLID[playerid]);
		mysql_tquery(DBConn, query);

		MDC_ShowManageLicense(MDC_PlastLastSearched_SQLID[playerid], playerid);
		SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, sprintf("** HQ Duyurusu: %s %s, %s adlù kiùiye silah lisansù verdi. **", Faction_GetRank(playerid), pNome(playerid), MDC_PlayerLastSearched[playerid]));
	}

	if(playertextid == MDC_ManageLicense[playerid][20]) // Silah lisansù iptal
	{
		if(13 > pInfo[playerid][pFactionRank])
			return SendErrorMessage(playerid, "Bu komutu SGT1+ ùzeri kullanabilir.");

		foreach(new pl : Player)
		{
			if(strlen(MDC_PlayerLastSearched[playerid]) == strlen(pNome(pl)))
			{
				if(pInfo[pl][pWeaponsLicense] == false)
					return SendErrorMessage(playerid, "Bu kiùi silah lisansùna sahip deùil.");

				pInfo[pl][pWeaponsLicense] = false;
			}
		}
		
		format(query, sizeof(query), "SELECT * FROM `players` WHERE `Name` = '%s'", MDC_PlayerLastSearched[playerid]);
		new Cache:cache = mysql_query(DBConn, query);

		new dl;
		if(cache_num_rows())
		{
			cache_get_value_name_int(0, "WeaponsLicense", dl);
			cache_delete(cache);
		}

		if(dl == 0)
			return SendErrorMessage(playerid, "Bu kiùi silah lisansùna sahip deùil.");

		mysql_format(DBConn, query, sizeof(query), "UPDATE players SET WeaponsLicense = 0 WHERE id = %i", MDC_PlastLastSearched_SQLID[playerid]);
		mysql_tquery(DBConn, query);
		MDC_ShowManageLicense(MDC_PlastLastSearched_SQLID[playerid], playerid);
		SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, sprintf("** HQ Duyurusu: %s %s, %s adlù kiùinin silah lisansùnù iptal etti. **", Faction_GetRank(playerid), pNome(playerid), MDC_PlayerLastSearched[playerid]));
	}

	if(playertextid == MDC_PenalCode[playerid][0]) // Penal Code geri gelme butonu, geri dùndùkten sonra en son kimi arattùùù tekrar ùùkmalù.
	{
		MDC_HideAfterPage(playerid);

		MDC_ReturnLastSearch(playerid);
	}

	for(new is = 17; is < 36; is++)
	{
	  if(playertextid == MDC_PenalCode[playerid][is]) // Penal Code listeden suù seùme ve detaylarùnù gùrme
		{
			RefreshChargeButton(playerid);
 			MDC_SelectCharges(playerid, MDC_PenalID[playerid][is-17]);
			SetPVarInt(playerid, "lastPenalCodeID", MDC_PenalID[playerid][is-17]);
		}
	}

	if(playertextid == MDC_PenalCode[playerid][46])
	{
		MDC_AddCharge(playerid, GetPVarInt(playerid, "lastPenalCodeID"));
	}

	if(playertextid == MDC_PenalCode[playerid][38])
	{
		if(GetPVarInt(playerid, "chargeATT") == 0)
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][38]);
			SetPVarInt(playerid, "chargeATT", 1);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][38], 0x54744DFF);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][38]);
		}else
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][38]);
			SetPVarInt(playerid, "chargeATT", 0);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][38], -1802201857);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][38]);
		}
	}

	if(playertextid == MDC_PenalCode[playerid][39])
	{
		if(GetPVarInt(playerid, "chargeSOL") == 0)
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][39]);
			SetPVarInt(playerid, "chargeSOL", 1);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][39], 0x54744DFF);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][39]);
		}else
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][39]);
			SetPVarInt(playerid, "chargeSOL", 0);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][39], -1802201857);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][39]);
		}
	}

	if(playertextid == MDC_PenalCode[playerid][40])
	{
		if(GetPVarInt(playerid, "chargeGOV") == 0)
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][42]);
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][40]);
			SetPVarInt(playerid, "chargeGOV", 1);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][40], 0x54744DFF);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][40]);
			PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][42], 0);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][42]);

			SetPVarInt(playerid, "chargeTime", CalculateChargeTime(playerid, GetPVarInt(playerid, "lastPenalCodeID")));
			EditChargeDescription(playerid, GetPVarInt(playerid, "lastPenalCodeID"));
		}else
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][40]);
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][42]);
			SetPVarInt(playerid, "chargeGOV", 0);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][40], -1802201857);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][40]);
			PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][42], 1);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][42]);

			SetPVarInt(playerid, "chargeTime", CalculateChargeTime(playerid, GetPVarInt(playerid, "lastPenalCodeID")));
			EditChargeDescription(playerid, GetPVarInt(playerid, "lastPenalCodeID"));
		}
	}

	if(playertextid == MDC_PenalCode[playerid][41])
	{
		if(GetPVarInt(playerid, "chargeCAC") == 0)
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][41]);
			SetPVarInt(playerid, "chargeCAC", 1);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][41], 0x54744DFF);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][41]);
		}else
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][41]);
			SetPVarInt(playerid, "chargeCAC", 0);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][41], -1802201857);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][41]);
		}
	}

	if(playertextid == MDC_PenalCode[playerid][42])
	{
		if(GetPVarInt(playerid, "chargeAAF") == 0)
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][40]);
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][42]);
			SetPVarInt(playerid, "chargeAAF", 1);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][42], 0x54744DFF);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][42]);
			PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][40], 0);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][40]);

			SetPVarInt(playerid, "chargeTime", CalculateChargeTime(playerid, GetPVarInt(playerid, "lastPenalCodeID")));
			EditChargeDescription(playerid, GetPVarInt(playerid, "lastPenalCodeID"));
		}else
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][40]);
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][42]);
			SetPVarInt(playerid, "chargeAAF", 0);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][42], -1802201857);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][42]);
			PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][40], 1);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][40]);

			SetPVarInt(playerid, "chargeTime", CalculateChargeTime(playerid, GetPVarInt(playerid, "lastPenalCodeID")));
			EditChargeDescription(playerid, GetPVarInt(playerid, "lastPenalCodeID"));
		}
	}


	if(playertextid == MDC_Emergency[playerid][4] || playertextid == MDC_Emergency[playerid][9] || playertextid == MDC_Emergency[playerid][14] || playertextid == MDC_Emergency[playerid][19]) // ùhbar detayù gùrme
	{
		//MDC_HideAfterPage(playerid);
		ShowEmergencyCallDetail(playerid, playertextid);
	}

	if(playertextid == MDC_Emergency[playerid][3] || playertextid == MDC_Emergency[playerid][8] || playertextid == MDC_Emergency[playerid][13] || playertextid == MDC_Emergency[playerid][18]) // ùhbar el koyma
	{
		HandleEmergency(playerid, playertextid);
	}

	if(playertextid == MDC_Emergency[playerid][20]) // ileri tuùu
	{
		new page = GetPVarInt(playerid, "emergencylist_idx");

		ShowEmergencyCalls(playerid, page + 1);
	}

	if(playertextid == MDC_Emergency[playerid][21]) // geri tuùu
	{
		new page = GetPVarInt(playerid, "emergencylist_idx");

		if(page == 0)
			return 1;

		ShowEmergencyCalls(playerid, page - 1);
	}

	if(playertextid == MDC_EmergencyDetails[playerid][4]) // ùhbar detayùndan geri dùnme butonu
	{
		for(new is = 0; is < 5; is++)
		{
	 		PlayerTextDrawHide(playerid, MDC_EmergencyDetails[playerid][is]);
		}
		ShowEmergencyCalls(playerid, GetPVarInt(playerid, "emergencylist_idx"));
	}


	if(playertextid == MDC_LookUp_Name[playerid][11]) // Sorgulanan kiùinin ceza kayùtlarùna gider
	{
		Show_CriminalData(playerid);
	}

	if(playertextid == MDC_CrimeHistory[playerid][21])
	{
		new page = GetPVarInt(playerid, "criminaldatalist_idx");
		Show_CriminalData(playerid, page + 1);
	}

	if(playertextid == MDC_CrimeHistory[playerid][22])
	{
		new page = GetPVarInt(playerid, "criminaldatalist_idx");
		Show_CriminalData(playerid, page - 1);
	}

	if(playertextid == MDC_CrimeHistory[playerid][23]) // Sorgulanan ceza kayùtlarùndan geri gider
	{
		MDC_HideAfterPage(playerid);
		MDC_ReturnLastSearch(playerid);
	}

	for(new id = 1; id < 21; id++)
	{
	  if(playertextid == MDC_CrimeHistory[playerid][id]) // Sorgulanan kiùinin ceza kayùtlarùndan bir tanesine basma butonlarùndan
		{
			MDC_HideAfterPage(playerid);
			Show_CriminalDataDetail(playerid, MDC_CriminalDataID[playerid][id-1]);
		}
	}

	if(playertextid == MDC_SelectedCrimeDetails[playerid][4]) // Sorgulanan kiùinin suù kayùtlarùndan seùilmiù suùun detayùndan geri dùnme tuùu
	{
		Show_CriminalData(playerid);
	}

	if(playertextid == MDC_SelectedCrimeDetails[playerid][5])
	{
		new prison_string[1028];
		GetPVarString(playerid, "lastPrisonRecord", prison_string, sizeof(prison_string));

		Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_MSGBOX, "Tutuklama Kaydù", prison_string, "Tamam", "");
	}

	if(playertextid == MDC_VehicleBolo_List[playerid][0])
	{

		format(lastBoloModel[playerid], 24, "");
		format(lastBoloPlate[playerid], 24, "");
		format(lastBoloCrimes[playerid], 512, "");
		format(lastBoloReport[playerid], 512, "");
		format(lastBoloReportShow[playerid], 512, "");

		new dialog[512], str[512];
		format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FFFFFF}Aracùn Modeli ve rengi nedir?\nùrnek: Siyah Tampa");
		strcat(dialog, str);
		Dialog_Show(playerid, MDC_AddVehicleBolo_Model, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
	}

	for(new is = 0; is < 6; is++)
	{
		if(playertextid == MDC_VehicleBolo_Details[playerid][is])
		{

		}
	}

	if(playertextid == MDC_VehicleBolo_List[playerid][22])
	{

		new page = GetPVarInt(playerid, "vbololist_idx");
		Show_VehicleBolos(playerid, page + 1);
	}

	if(playertextid == MDC_VehicleBolo_List[playerid][21])
	{

		new page = GetPVarInt(playerid, "vbololist_idx");
		Show_VehicleBolos(playerid, page - 1);
	}

	if(playertextid == MDC_VehicleBolo_Details[playerid][0])
	{
		new boloid = GetPVarInt(playerid, "boloLastID");

		
		mysql_format(DBConn, query, sizeof(query), "DELETE FROM vehicle_bolos WHERE id = %d", boloid);
		mysql_tquery(DBConn, query);

		Show_VehicleBolos(playerid);
	}


	if(playertextid == MDC_VehicleBolo_Details[playerid][1])
	{
		Show_VehicleBolos(playerid, GetPVarInt(playerid, "vbololist_idx"));
	}

	for(new is = 1; is < 21; is++)
	{
		if(playertextid == MDC_VehicleBolo_List[playerid][is])
		{
			MDC_HideAfterPage(playerid);
			ShowVehicleBoloDetails(playerid, is);
		}
	}
	return 1;
}

stock UI_MDC(playerid)
{
	MDC_Main[playerid][0] = CreatePlayerTextDraw(playerid, 148.300369, 150.643173, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][0], 0.000000, 32.372245);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][0], 527.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][0], -522329857);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][0], 0);

	MDC_Main[playerid][1] = CreatePlayerTextDraw(playerid, 149.900421, 153.836624, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][1], 0.000000, 0.954244);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][1], 525.299926, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][1], 203444479);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][1], 0);

	MDC_Main[playerid][2] = CreatePlayerTextDraw(playerid, 517.399047, 154.023117, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][2], 0.000000, 0.910245);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][2], 525.198242, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][2], -1407049473);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][2], 0);

	MDC_Main[playerid][3] = CreatePlayerTextDraw(playerid, 506.500030, 154.023117, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][3], 0.000000, 0.910245);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][3], 514.300903, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][3], 610587135);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][3], 0);

	MDC_Main[playerid][4] = CreatePlayerTextDraw(playerid, 521.400390, 151.480117, "x");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][4], 0.258399, 1.291378);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][4], 13.0, 7.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][4], 2);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][4], 560254720);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][4], 560254720);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Main[playerid][4], true);

	MDC_Main[playerid][5] = CreatePlayerTextDraw(playerid, 510.402587, 151.480117, "-");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][5], 0.258399, 1.291378);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][5], 2);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][5], 560254720);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][5], 0);

	MDC_Main[playerid][6] = CreatePlayerTextDraw(playerid, 151.199172, 154.113464, "hud:radar_emmetgun");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][6], 9.539989, 8.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][6], 0);

	MDC_Main[playerid][7] = CreatePlayerTextDraw(playerid, 163.800292, 153.680297, "MDC_PageName");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][7], 0.204399, 0.927954);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][7], 284.700103, -0.099999);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][7], -1329999105);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][7], -1329999360);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][7], 0);

	MDC_Main[playerid][8] = CreatePlayerTextDraw(playerid, 501.600402, 153.680282, "CharacterName1");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][8], 0.204399, 0.927954);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][8], 3);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][8], -2037207046);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][8], 0);

	MDC_Main[playerid][9] = CreatePlayerTextDraw(playerid, 223.900009, 168.595565, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][9], 0.000000, 30.160011);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][9], 224.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][9], -1);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][9], -1229736193);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][9], 0);

	MDC_Main[playerid][10] = CreatePlayerTextDraw(playerid, 184.000213, 168.693344, "Ana_Ekran");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][10], 0.198597, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][10], 10.559998, 68.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][10], 2);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][10], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][10], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Main[playerid][10], true);

	MDC_Main[playerid][11] = CreatePlayerTextDraw(playerid, 183.900177, 184.394302, "Sorgula");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][11], 0.198597, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][11], 10.559998, 68.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][11], 2);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][11], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][11], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][11], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Main[playerid][11], true);


	MDC_Main[playerid][13] = CreatePlayerTextDraw(playerid, 184.300170, 200.196243, "CAGRILAR");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][13], 0.198597, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][13], 10.559998, 68.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][13], 2);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][13], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][13], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Main[playerid][13], true);

	MDC_Main[playerid][14] = CreatePlayerTextDraw(playerid, 184.300170, 232.998779, " ");

	MDC_Main[playerid][16] = CreatePlayerTextDraw(playerid, 184.300170, 248.998779, "ARAC BOLO");
	PlayerTextDrawLetterSize(playerid, MDC_Main[playerid][16], 0.198597, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_Main[playerid][16], 10.559998, 68.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main[playerid][16], 2);
	PlayerTextDrawColour(playerid, MDC_Main[playerid][16], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_Main[playerid][16], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][16], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Main[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_Main[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Main[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Main[playerid][16], true);


	MDC_MainScreen[playerid][0] = CreatePlayerTextDraw(playerid, 242.199951, 165.951248, "");
	PlayerTextDrawLetterSize(playerid, MDC_MainScreen[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MainScreen[playerid][0], 241.000000, 206.000000);
	PlayerTextDrawAlignment(playerid, MDC_MainScreen[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_MainScreen[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MainScreen[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_MainScreen[playerid][0], -522330112);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, MDC_MainScreen[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][0], 0);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_MainScreen[playerid][0], 285);
	PlayerTextDrawSetPreviewRot(playerid, MDC_MainScreen[playerid][0], 0.000000, 0.000000, 0.000000, 0.899999);

	MDC_MainScreen[playerid][1] = CreatePlayerTextDraw(playerid, 229.900390, 258.163177, "box");
	PlayerTextDrawLetterSize(playerid, MDC_MainScreen[playerid][1], 0.000000, 18.012247);
	PlayerTextDrawTextSize(playerid, MDC_MainScreen[playerid][1], 514.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_MainScreen[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_MainScreen[playerid][1], 16777215);
	PlayerTextDrawUseBox(playerid, MDC_MainScreen[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_MainScreen[playerid][1], -522329857);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MainScreen[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_MainScreen[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_MainScreen[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][1], 0);

	MDC_MainScreen[playerid][2] = CreatePlayerTextDraw(playerid, 230.300003, 255.311096, "box");
	PlayerTextDrawLetterSize(playerid, MDC_MainScreen[playerid][2], 0.000000, 1.040012);
	PlayerTextDrawTextSize(playerid, MDC_MainScreen[playerid][2], 524.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_MainScreen[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_MainScreen[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, MDC_MainScreen[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_MainScreen[playerid][2], -1229736193);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MainScreen[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_MainScreen[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_MainScreen[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][2], 0);

	MDC_MainScreen[playerid][3] = CreatePlayerTextDraw(playerid, 366.200317, 255.426940, "Rank_CharacterName");
	PlayerTextDrawLetterSize(playerid, MDC_MainScreen[playerid][3], 0.204399, 0.927954);
	PlayerTextDrawAlignment(playerid, MDC_MainScreen[playerid][3], 2);
	PlayerTextDrawColour(playerid, MDC_MainScreen[playerid][3], 757674239);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MainScreen[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_MainScreen[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_MainScreen[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][3], 0);

	MDC_MainScreen[playerid][4] = CreatePlayerTextDraw(playerid, 233.300308, 272.749176, "AKTIF_PERSONELLER AKTIF_ARANMALAR");
	PlayerTextDrawLetterSize(playerid, MDC_MainScreen[playerid][4], 0.223998, 1.127063);
	PlayerTextDrawTextSize(playerid, MDC_MainScreen[playerid][4], 241.000000, 206.000000);
	PlayerTextDrawAlignment(playerid, MDC_MainScreen[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_MainScreen[playerid][4], 757674239);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MainScreen[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_MainScreen[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MainScreen[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][4], 0);

	MDC_MainScreen[playerid][5] = CreatePlayerTextDraw(playerid, 384.299316, 272.737884, "SON_ARANMALAR SON_TUTUKLAMALAR SON_CEZALAR");
	PlayerTextDrawLetterSize(playerid, MDC_MainScreen[playerid][5], 0.223998, 1.127063);
	PlayerTextDrawTextSize(playerid, MDC_MainScreen[playerid][5], 241.000000, 206.000000);
	PlayerTextDrawAlignment(playerid, MDC_MainScreen[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_MainScreen[playerid][5], 757674239);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MainScreen[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_MainScreen[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MainScreen[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][5], 0);

	MDC_MainScreen[playerid][6] = CreatePlayerTextDraw(playerid, 492.701934, 272.742401, "3 5 7");
	PlayerTextDrawLetterSize(playerid, MDC_MainScreen[playerid][6], 0.223998, 1.127063);
	PlayerTextDrawTextSize(playerid, MDC_MainScreen[playerid][6], 241.000000, 206.000000);
	PlayerTextDrawAlignment(playerid, MDC_MainScreen[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_MainScreen[playerid][6], -1667654401);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MainScreen[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_MainScreen[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MainScreen[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][6], 0);

	MDC_MainScreen[playerid][7] = CreatePlayerTextDraw(playerid, 338.502441, 272.724365, "3 5");
	PlayerTextDrawTextSize(playerid, MDC_MainScreen[playerid][7], 241.000000, 206.000000);
	PlayerTextDrawLetterSize(playerid, MDC_MainScreen[playerid][7], 0.223998, 1.127063);
	PlayerTextDrawAlignment(playerid, MDC_MainScreen[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_MainScreen[playerid][7], -1667654401);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MainScreen[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_MainScreen[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_MainScreen[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MainScreen[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MainScreen[playerid][7], 0);

	MDC_LookUp_Name[playerid][0] = CreatePlayerTextDraw(playerid, 254.199676, 177.730865, "ISIM");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][0], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][0], 10.559998, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][0], 2);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][0], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][0], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][0], true);

	MDC_LookUp_Name[playerid][1] = CreatePlayerTextDraw(playerid, 297.202301, 177.730865, "PLAKA");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][1], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][1], 10.559998, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][1], 2);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][1], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][1], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][1], true);

	MDC_LookUp_Name[playerid][2] = CreatePlayerTextDraw(playerid, 325.199707, 177.908264, "box");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][2], 0.000000, 1.030997);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][2], 464.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][2], true);

	MDC_LookUp_Name[playerid][3] = CreatePlayerTextDraw(playerid, 489.901702, 177.437606, "YENILE");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][3], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][3], 10.559998, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][3], 2);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][3], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][3], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][3], true);

	MDC_LookUp_Name[playerid][4] = CreatePlayerTextDraw(playerid, 327.800292, 177.355590, "SearchedText");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][4], 0.241199, 1.002665);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][4], 0);

	MDC_LookUp_Name[playerid][5] = CreatePlayerTextDraw(playerid, 146.900390, 183.111587, "");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][5], 239.000000, 196.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][5], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][5], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][5], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Name[playerid][5], 301);
	PlayerTextDrawSetPreviewRot(playerid, MDC_LookUp_Name[playerid][5], 0.000000, 0.000000, 30.000000, 1.000000);

	MDC_LookUp_Name[playerid][6] = CreatePlayerTextDraw(playerid, 230.500396, 273.403350, "box");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][6], 0.000000, 12.439991);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][6], 497.499908, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][6], 255);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][6], -572662273);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][6], 0);

	MDC_LookUp_Name[playerid][7] = CreatePlayerTextDraw(playerid, 302.699981, 202.675979, "ISIM:~n~NUMARA:~n~SABIKA:~n~LISANSLAR:~n~ADRESLER:");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][7], 0.167198, 1.012622);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][7], 348.000000, 150.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][7], 1044266751);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][7], 0);

	MDC_LookUp_Name[playerid][8] = CreatePlayerTextDraw(playerid, 368.303985, 202.675979, "SearchedName~n~SearchedNumber~n~SearchedPriors~n~SearchedLicenses~n~SearchedAddresses~n~~r~Bu_kisi_araniyor.");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][8],0.167198, 1.012622);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][8], 10.559998, 68.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][8], -1717986817);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][8], 0);

	MDC_LookUp_Name[playerid][9] = CreatePlayerTextDraw(playerid, 233.501403, 275.013336, "]_Bu_Oyuncu_Birden_Fazla_Adrese_Sahip,_Listelemek_icin_tiklayin");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][9], 0.187795, 0.982931);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][9], 517.000000, 9.0);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][9], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][9], -57089);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][9], true);

	MDC_LookUp_Name[playerid][10] = CreatePlayerTextDraw(playerid, 233.401428, 289.951171, "~>~_Lisanslari_Yonet");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][10], 0.187795, 0.982931);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][10], 373.000000, 9.0);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][10], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][10], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][10], true);

	MDC_LookUp_Name[playerid][11] = CreatePlayerTextDraw(playerid, 447.804534, 289.639862, "~y~]_~w~SABIKA_KAYDI_~y~]_");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][11], 0.187795, 0.982931);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][11], 10.559998, 140.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][11], 2);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][11], -1);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][11], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][11], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][11], true);

	MDC_LookUp_Name[playerid][12] = CreatePlayerTextDraw(playerid, 233.401428, 303.752014, "~>~_Islem_Uygula");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][12], 0.187795, 0.982931);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][12], 373.000000, 9.0);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][12], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][12], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][12], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][12], true);

	MDC_LookUp_Name[playerid][13] = CreatePlayerTextDraw(playerid, 233.401428, 317.552856, "~>~_Tutuklama_Raporu_Yaz");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][13], 0.187795, 0.982931);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][13], 373.000000, 9.0);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][13], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][13], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_LookUp_Name[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][13], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][13], true);

	MDC_LookUp_Name[playerid][14] = CreatePlayerTextDraw(playerid, 383.303619, 302.513458, "CriminalRecord1");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][14], 0.167198, 1.012622);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][14], 373.000000, 9.0);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][14], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][14], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][14], true);

	MDC_LookUp_Name[playerid][15] = CreatePlayerTextDraw(playerid, 492.299896, 359.664031, "");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][15], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][15], 8.779994, 9.320007);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][15], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][15], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][15], false);

	MDC_LookUp_Name[playerid][16] = CreatePlayerTextDraw(playerid, 502.800537, 359.664031, "");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Name[playerid][16], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Name[playerid][16], 8.779994, 9.320007);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Name[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][16], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Name[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Name[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Name[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Name[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Name[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_LookUp_Name[playerid][16], false);

	MDC_LookUp_Name[playerid][17] = CreatePlayerTextDraw(playerid, 340.604949, 177.730865, "");

	MDC_LookUp_Vehicle[playerid][0] = CreatePlayerTextDraw(playerid, 229.500122, 176.753524, "");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Vehicle[playerid][0], 78.000000, 79.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][0], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][0], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Vehicle[playerid][0], 406);
	PlayerTextDrawSetPreviewRot(playerid, MDC_LookUp_Vehicle[playerid][0], 0.000000, 0.000000, 90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_LookUp_Vehicle[playerid][0], 1, 1);

	MDC_LookUp_Vehicle[playerid][1] = CreatePlayerTextDraw(playerid, 229.500213, 224.907669, "");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Vehicle[playerid][1], 78.000000, 79.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][1], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][1], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][1], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Vehicle[playerid][1], 406);
	PlayerTextDrawSetPreviewRot(playerid, MDC_LookUp_Vehicle[playerid][1], 0.000000, 0.000000, 90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_LookUp_Vehicle[playerid][1], 1, 1);

	MDC_LookUp_Vehicle[playerid][2] = CreatePlayerTextDraw(playerid, 228.599945, 276.157653, "");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Vehicle[playerid][2], 78.000000, 79.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][2], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][2], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Vehicle[playerid][2], 406);
	PlayerTextDrawSetPreviewRot(playerid, MDC_LookUp_Vehicle[playerid][2], 0.000000, 0.000000, 90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_LookUp_Vehicle[playerid][2], 1, 1);

	MDC_LookUp_Vehicle[playerid][3] = CreatePlayerTextDraw(playerid, 229.599975, 328.540191, "");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Vehicle[playerid][3], 78.000000, 79.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][3], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][3], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][3], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Vehicle[playerid][3], 406);
	PlayerTextDrawSetPreviewRot(playerid, MDC_LookUp_Vehicle[playerid][3], 0.000000, 0.000000, 90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_LookUp_Vehicle[playerid][3], 1, 1);

	MDC_LookUp_Vehicle[playerid][4] = CreatePlayerTextDraw(playerid, 229.599990, 379.278747, "");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LookUp_Vehicle[playerid][4], 78.000000, 79.000000);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][4], 0);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][4], 0);
		PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][4], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Vehicle[playerid][4], 406);
	PlayerTextDrawSetPreviewRot(playerid, MDC_LookUp_Vehicle[playerid][4], 0.000000, 0.000000, 90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_LookUp_Vehicle[playerid][4], 1, 1);

	MDC_LookUp_Vehicle[playerid][5] = CreatePlayerTextDraw(playerid, 319.200164, 194.977767, "MODEL:~n~PLAKA:~n~SAHIP:~n~SIGORTA:~n~HACIZ");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][5], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][5], 255);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][5], 0);

	MDC_LookUp_Vehicle[playerid][6] = CreatePlayerTextDraw(playerid, 319.200164, 243.479080, "MODEL:~n~PLAKA:~n~SAHIP:~n~SIGORTA:~n~HACIZ");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][6], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][6], 255);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][6], 0);

	MDC_LookUp_Vehicle[playerid][7] = CreatePlayerTextDraw(playerid, 319.200164, 291.778900, "MODEL:~n~PLAKA:~n~SAHIP:~n~SIGORTA:~n~HACIZ");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][7], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][7], 255);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][7], 0);

	MDC_LookUp_Vehicle[playerid][8] = CreatePlayerTextDraw(playerid, 319.200164, 341.880859, "MODEL:~n~PLAKA:~n~SAHIP:~n~SIGORTA:~n~HACIZ");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][8], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][8], 255);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][8], 0);

	MDC_LookUp_Vehicle[playerid][9] = CreatePlayerTextDraw(playerid, 319.200164, 392.978363, "MODEL:~n~PLAKA:~n~SAHIP:~n~SIGORTA:~n~HACIZ");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][9], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][9], 255);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][9], 0);

	MDC_LookUp_Vehicle[playerid][10] = CreatePlayerTextDraw(playerid, 360.599945, 194.977767, "aracmodel~n~aracplaka~n~aracsahip~n~aracsigorta~n~arachaciz");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][10], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][10], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][10], 0);

	MDC_LookUp_Vehicle[playerid][11] = CreatePlayerTextDraw(playerid, 360.599945, 243.277832, "aracmodel~n~aracplaka~n~aracsahip~n~aracsigorta~n~arachaciz");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][11], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][11], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][11], 0);

	MDC_LookUp_Vehicle[playerid][12] = CreatePlayerTextDraw(playerid, 360.599945, 291.577667, "aracmodel~n~aracplaka~n~aracsahip~n~aracsigorta~n~arachaciz");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][12], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][12], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][12], 0);

	MDC_LookUp_Vehicle[playerid][13] = CreatePlayerTextDraw(playerid, 360.599945, 342.177398, "aracmodel~n~aracplaka~n~aracsahip~n~aracsigorta~n~arachaciz");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][13], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][13], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][13], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][13], 0);

	MDC_LookUp_Vehicle[playerid][14] = CreatePlayerTextDraw(playerid, 360.199951, 392.279357, "aracmodel~n~aracplaka~n~aracsahip~n~aracsigorta~n~arachaciz");
	PlayerTextDrawLetterSize(playerid, MDC_LookUp_Vehicle[playerid][14], 0.190799, 0.962844);
	PlayerTextDrawAlignment(playerid, MDC_LookUp_Vehicle[playerid][14], 1);
	PlayerTextDrawColour(playerid, MDC_LookUp_Vehicle[playerid][14], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LookUp_Vehicle[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_LookUp_Vehicle[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_LookUp_Vehicle[playerid][14], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LookUp_Vehicle[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_LookUp_Vehicle[playerid][14], 0);


	MDC_AdressDetails[playerid][0] = CreatePlayerTextDraw(playerid, 236.201202, 167.593261, "~<~_Geri_Git");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][0], 0.231199, 1.122133);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][0], 290.000488, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][0], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_AdressDetails[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_AdressDetails[playerid][0], 84215040);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_AdressDetails[playerid][0], true);

	MDC_AdressDetails[playerid][1] = CreatePlayerTextDraw(playerid, 228.300003, 186.304260, "Birincil_Adres");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][1], 0.208399, 1.117155);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][1], 1583243007);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][1], 0);

	MDC_AdressDetails[playerid][2] = CreatePlayerTextDraw(playerid, 233.400314, 196.004852, "secondaryAddress~n~addressCity~n~addressCounty~n~addressCountry");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][2], 0.208399, 1.117155);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][2], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][2], 0);

	MDC_AdressDetails[playerid][3] = CreatePlayerTextDraw(playerid, 369.399383, 166.349380, "samaps:gtasamapbit4");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][3], 131.000000, 138.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][3], 0);

	MDC_AdressDetails[playerid][4] = CreatePlayerTextDraw(playerid, 228.300003, 240.007537, "Diger_Adresler");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][4], 0.208399, 1.117155);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][4], 1583243007);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][4], 0);

	MDC_AdressDetails[playerid][5] = CreatePlayerTextDraw(playerid, 232.400238, 253.739410, "-_adressNumber1");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][5], 0.208399, 1.117155);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][5], 359.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][5], -1515870721);
	PlayerTextDrawUseBox(playerid, MDC_AdressDetails[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_AdressDetails[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_AdressDetails[playerid][5], true);

	MDC_AdressDetails[playerid][6] = CreatePlayerTextDraw(playerid, 232.400238, 269.640380, "-_adressNumber2");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][6], 0.208399, 1.117155);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][6], 359.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][6], -1515870721);
	PlayerTextDrawUseBox(playerid, MDC_AdressDetails[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_AdressDetails[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_AdressDetails[playerid][6], true);

	MDC_AdressDetails[playerid][7] = CreatePlayerTextDraw(playerid, 232.400238, 285.641357, "-_adressNumber3");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][7], 0.208399, 1.117155);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][7], 359.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][7], -1515870721);
	PlayerTextDrawUseBox(playerid, MDC_AdressDetails[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_AdressDetails[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_AdressDetails[playerid][7], true);

	MDC_AdressDetails[playerid][8] = CreatePlayerTextDraw(playerid, 232.400238, 301.842346, "-_adressNumber4");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][8], 0.208399, 1.117155);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][8], 359.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][8], -1515870721);
	PlayerTextDrawUseBox(playerid, MDC_AdressDetails[playerid][8], 1);
	PlayerTextDrawBoxColour(playerid, MDC_AdressDetails[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_AdressDetails[playerid][8], true);

	MDC_AdressDetails[playerid][9] = CreatePlayerTextDraw(playerid, 232.400238, 317.943328, "-_adressNumber5");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][9], 0.208399, 1.117155);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][9], 359.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][9], -1515870721);
	PlayerTextDrawUseBox(playerid, MDC_AdressDetails[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_AdressDetails[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_AdressDetails[playerid][9], true);

	MDC_AdressDetails[playerid][10] = CreatePlayerTextDraw(playerid, 348.399841, 332.408905, "LD_BEAT:right");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][10], 13.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_AdressDetails[playerid][10], true);

	MDC_AdressDetails[playerid][11] = CreatePlayerTextDraw(playerid, 338.399841, 332.408905, "LD_BEAT:left");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][11], 13.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_AdressDetails[playerid][11], true);

	MDC_AdressDetails[playerid][12] = CreatePlayerTextDraw(playerid, 369.399383, 304.250640, "samaps:gtasamapbit3");
	PlayerTextDrawLetterSize(playerid, MDC_AdressDetails[playerid][12], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][12], 131.000000, 138.000000);
	PlayerTextDrawAlignment(playerid, MDC_AdressDetails[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_AdressDetails[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_AdressDetails[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_AdressDetails[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, MDC_AdressDetails[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, MDC_AdressDetails[playerid][12], 0);

	MDC_ManageLicense[playerid][0] = CreatePlayerTextDraw(playerid, 236.201202, 167.593261, "~<~_Geri_Git");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][0], 0.231196, 1.122133);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][0], 290.000488, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][0], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][0], 84215040);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_ManageLicense[playerid][0], true);

	MDC_ManageLicense[playerid][1] = CreatePlayerTextDraw(playerid, 233.099624, 196.366577, "box");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][1], 0.000000, 7.030000);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][1], 364.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][1], 0);

	MDC_ManageLicense[playerid][2] = CreatePlayerTextDraw(playerid, 233.399856, 196.659851, "_________Surucu_Lisansi");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][2], 0.149997, 0.873242);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][2], 364.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][2], 859803647);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][2], 0);

	MDC_ManageLicense[playerid][3] = CreatePlayerTextDraw(playerid, 232.599426, 194.010894, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][3], 18.000000, 23.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][3], 0);

	MDC_ManageLicense[playerid][4] = CreatePlayerTextDraw(playerid, 254.200042, 207.624465, "Durum:~n~Uyarilar:");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][4], 0.185199, 1.012621);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][4], 1920103167);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][4], 0);

	MDC_ManageLicense[playerid][5] = CreatePlayerTextDraw(playerid, 294.802520, 207.624465, "playerDriverLicenses~n~playerDrLicenWarnings");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][5], 0.185199, 1.012621);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][5], 1920103167);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][5], 0);

	MDC_ManageLicense[playerid][6] = CreatePlayerTextDraw(playerid, 254.299896, 248.258010, "IPTAL ET");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][6], 0.180799, 0.962844);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][6], 10.000000, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][6], 2);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][6], 2115512063);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_ManageLicense[playerid][6], true);

	MDC_ManageLicense[playerid][7] = CreatePlayerTextDraw(playerid, 297.502532, 248.258010, "UYAR");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][7], 0.180799, 0.962844);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][7], 10.000000, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][7], 2);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][7], 572662527);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_ManageLicense[playerid][7], true);

	MDC_ManageLicense[playerid][9] = CreatePlayerTextDraw(playerid, 233.099624, 275.771423, "box");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][9], 0.000000, 7.030000);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][9], 364.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][9], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][9], 0);

	MDC_ManageLicense[playerid][10] = CreatePlayerTextDraw(playerid, 233.399856, 275.864685, "___________MEDIKAL_LISANS");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][10], 0.149997, 0.873242);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][10], 364.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][10], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][10], 859803647);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][10], 0);

	MDC_ManageLicense[playerid][11] = CreatePlayerTextDraw(playerid, 234.099304, 270.486694, "hud:radar_girlfriend");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][11], 17.000000, 19.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][11], 0);

	MDC_ManageLicense[playerid][12] = CreatePlayerTextDraw(playerid, 254.400146, 287.734161, "Durum:");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][12], 0.185199, 1.012621);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][12], 1920103167);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][12], 0);

	MDC_ManageLicense[playerid][13] = CreatePlayerTextDraw(playerid, 294.802307, 287.716247, "playerPilotLicense");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][13], 0.185199, 1.012621);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][13], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][13], 1920103167);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][13], 0);

	MDC_ManageLicense[playerid][14] = CreatePlayerTextDraw(playerid, 254.299957, 327.151947, "IPTAL ET");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][14], 0.180799, 0.962844);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][14], 10.000000, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][14], 2);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][14], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][14], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][14], 2115512063);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][14], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_ManageLicense[playerid][14], true);

	MDC_ManageLicense[playerid][15] = CreatePlayerTextDraw(playerid, 379.004516, 196.968887, "box");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][15], 0.000000, 6.959003);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][15], 510.770843, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][15], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][15], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][15], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][15], 0);

	MDC_ManageLicense[playerid][16] = CreatePlayerTextDraw(playerid, 379.008209, 196.757614, "_________SILAH_LISANSI");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][16], 0.149997, 0.873242);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][16], 510.910644, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][16], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][16], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][16], 859803647);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][16], 0);

	MDC_ManageLicense[playerid][17] = CreatePlayerTextDraw(playerid, 378.000976, 193.724411, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][17], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][17], 18.000000, 23.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][17], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][17], 0);

	MDC_ManageLicense[playerid][18] = CreatePlayerTextDraw(playerid, 401.801727, 207.626724, "Durum:");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][18], 0.185199, 1.012621);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][18], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][18], 1920103167);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][18], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][18], 0);

	MDC_ManageLicense[playerid][19] = CreatePlayerTextDraw(playerid, 444.404418, 207.724472, "playerGLicense");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][19], 0.185199, 1.012621);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][19], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][19], 1920103167);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][19], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][19], 0);

	MDC_ManageLicense[playerid][20] = CreatePlayerTextDraw(playerid, 401.400909, 248.255752, "IPTAL ET");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][20], 0.180799, 0.962844);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][20], 10.000000, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][20], 2);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][20], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][20], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][20], 2115512063);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][20], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_ManageLicense[playerid][20], true);

	MDC_ManageLicense[playerid][21] = CreatePlayerTextDraw(playerid, 445.403594, 248.255752, "VER");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][21], 0.180799, 0.962844);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][21], 10.000000, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][21], 2);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][21], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][21], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][21], 8388863);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][21], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][21], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_ManageLicense[playerid][21], true);


	MDC_ManageLicense[playerid][28] = CreatePlayerTextDraw(playerid, 236.699539, 198.008880, "hud:radar_impound");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][28], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][28], 10.000000, 14.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][28], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][28], -1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][28], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][28], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][28], 4);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][28], 0);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][28], 0);

	MDC_ManageLicense[playerid][29] = CreatePlayerTextDraw(playerid, 382.700439, 199.629272, "hud:radar_ammugun");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][29], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][29], 9.000000, 11.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][29], 1);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][29], -1);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][29], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][29], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][29], 4);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][29], 0);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][29], 0);

	MDC_ManageLicense[playerid][30] = CreatePlayerTextDraw(playerid, 297.502532, 327.151947, "VER");
	PlayerTextDrawLetterSize(playerid, MDC_ManageLicense[playerid][30], 0.180799, 0.962844);
	PlayerTextDrawTextSize(playerid, MDC_ManageLicense[playerid][30], 10.000000, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_ManageLicense[playerid][30], 2);
	PlayerTextDrawColour(playerid, MDC_ManageLicense[playerid][30], -1);
	PlayerTextDrawUseBox(playerid, MDC_ManageLicense[playerid][30], 1);
	PlayerTextDrawBoxColour(playerid, MDC_ManageLicense[playerid][30], 8388863);
	PlayerTextDrawSetShadow(playerid, MDC_ManageLicense[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, MDC_ManageLicense[playerid][30], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_ManageLicense[playerid][30], 255);
	PlayerTextDrawFont(playerid, MDC_ManageLicense[playerid][30], 2);
	PlayerTextDrawSetProportional(playerid, MDC_ManageLicense[playerid][30], 1);
	PlayerTextDrawSetShadow(playerid,MDC_ManageLicense[playerid][30], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_ManageLicense[playerid][30], true);

	MDC_PenalCode[playerid][16] = CreatePlayerTextDraw(playerid, 229.100463, 168.324035, "~<~_geri_don");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][16], 0.201388, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][16], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][16], 1465341951);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][16], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][16], -1886417152);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][16], true);

	MDC_PenalCode[playerid][17] = CreatePlayerTextDraw(playerid, 229.100463, 181.224212, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][17], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][17], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][17], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][17], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][17], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][17], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][17], true);

	MDC_PenalCode[playerid][18] = CreatePlayerTextDraw(playerid, 229.100463, 194.624206, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][18], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][18], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][18], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][18], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][18], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][18], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][18], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][18], true);

	MDC_PenalCode[playerid][19] = CreatePlayerTextDraw(playerid, 229.100463, 207.824340, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][19], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][19], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][19], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][19], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][19], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][19], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][19], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][19], true);

	MDC_PenalCode[playerid][20] = CreatePlayerTextDraw(playerid, 229.100463, 221.024475, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][20], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][20], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][20], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][20], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][20], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][20], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][20], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][20], true);

	MDC_PenalCode[playerid][21] = CreatePlayerTextDraw(playerid, 229.100463, 234.224609, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][21], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][21], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][21], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][21], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][21], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][21], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][21], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][21], true);

	MDC_PenalCode[playerid][22] = CreatePlayerTextDraw(playerid, 229.100463, 247.424743, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][22], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][22], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][22], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][22], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][22], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][22], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][22], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][22], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][22], true);

	MDC_PenalCode[playerid][23] = CreatePlayerTextDraw(playerid, 229.100463, 260.624633, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][23], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][23], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][23], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][23], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][23], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][23], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][23], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][23], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][23], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][23], true);

	MDC_PenalCode[playerid][24] = CreatePlayerTextDraw(playerid, 229.100463, 273.824096, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][24], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][24], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][24], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][24], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][24], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][24], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][24], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][24], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][24], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][24], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][24], true);

	MDC_PenalCode[playerid][25] = CreatePlayerTextDraw(playerid, 229.100463, 286.723571, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][25], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][25], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][25], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][25], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][25], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][25], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][25], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][25], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][25], true);

	MDC_PenalCode[playerid][26] = CreatePlayerTextDraw(playerid, 229.100463, 299.923034, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][26], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][26], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][26], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][26], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][26], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][26], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][26], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][26], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][26], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][26], true);

	MDC_PenalCode[playerid][27] = CreatePlayerTextDraw(playerid, 229.100463, 313.122497, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][27], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][27], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][27], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][27], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][27], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][27], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][27], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][27], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][27], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][27], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][27], true);

	MDC_PenalCode[playerid][28] = CreatePlayerTextDraw(playerid, 229.100463, 326.321960, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][28], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][28], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][28], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][28], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][28], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][28], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][28], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][28], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][28], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][28], true);

	MDC_PenalCode[playerid][29] = CreatePlayerTextDraw(playerid, 229.100463, 339.521423, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][29], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][29], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][29], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][29], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][29], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][29], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][29], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][29], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][29], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][29], true);

	MDC_PenalCode[playerid][30] = CreatePlayerTextDraw(playerid, 229.100463, 352.720886, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][30], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][30], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][30], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][30], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][30], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][30], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][30], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][30], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][30], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][30], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][30], true);

	MDC_PenalCode[playerid][31] = CreatePlayerTextDraw(playerid, 229.100463, 366.220336, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][31], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][31], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][31], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][31], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][31], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][31], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][31], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][31], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][31], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][31], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][31], true);

	MDC_PenalCode[playerid][32] = CreatePlayerTextDraw(playerid, 229.100463, 379.419799, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][32], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][32], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][32], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][32], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][32], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][32], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][32], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][32], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][32], true);

	MDC_PenalCode[playerid][33] = CreatePlayerTextDraw(playerid, 229.100463, 392.319274, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][33], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][33], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][33], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][33], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][33], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][33], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][33], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][33], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][33], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][33], true);

	MDC_PenalCode[playerid][34] = CreatePlayerTextDraw(playerid, 229.100463, 405.320068, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][34], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][34], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][34], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][34], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][34], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][34], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][34], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][34], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][34], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][34], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][34], true);

	MDC_PenalCode[playerid][35] = CreatePlayerTextDraw(playerid, 229.100463, 418.220855, "PENAL1");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][35], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][35], 345.200531, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][35], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][35], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][35], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][35], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][35], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][35], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][35], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][35], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][35], true);

	MDC_PenalCode[playerid][36] = CreatePlayerTextDraw(playerid, 483.201202, 181.224212, "_temizle");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][36], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][36], 521.778503, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][36], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][36], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][36], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][36], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][36], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][36], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][36], 2);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][36], true);

	MDC_PenalCode[playerid][37] = CreatePlayerTextDraw(playerid, 351.200744, 181.224212, "_filtre_uygula_...");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][37], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][37], 477.299926, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][37], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][37], -1802201857);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][37], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][37], -1);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][37], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][37], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][37], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][37], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][37], true);

	MDC_PenalCode[playerid][38] = CreatePlayerTextDraw(playerid, 350.900817, 194.224273, "ATT");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][38], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][38], 363.000000, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][38], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][38], -1802201857);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][38], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][38], -1802202112);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][38], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][38], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][38], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][38], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][38], true);

	MDC_PenalCode[playerid][39] = CreatePlayerTextDraw(playerid, 367.450439, 194.224273, "SOL");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][39], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][39], 379.549621, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][39], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][39], -1802201857);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][39], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][39], -1802202112);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][39], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][39], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][39], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][39], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][39], true);

	MDC_PenalCode[playerid][40] = CreatePlayerTextDraw(playerid, 383.949890, 194.224273, "GOV");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][40], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][40], 399.069091, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][40], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][40], -1802201857);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][40], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][40], -1802202112);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][40], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][40], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][40], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][40], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][40], true);

	MDC_PenalCode[playerid][41] = CreatePlayerTextDraw(playerid, 403.299438, 194.224273, "CAC");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][41], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][41], 416.000000, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][41], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][41], -1802201857);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][41], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][41], -1802202112);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][41], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][41], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][41], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][41], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][41], true);

	MDC_PenalCode[playerid][42] = CreatePlayerTextDraw(playerid, 420.399322, 194.224273, "AAF");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][42], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][42], 433.099884, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][42], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][42], -1802201857);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][42], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][42], -1802202112);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][42], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][42], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][42], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][42], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][42], true);

	MDC_PenalCode[playerid][43] = CreatePlayerTextDraw(playerid, 437.499206, 194.224273, "GNG");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][43], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][43], 451.000000, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][43], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][43], -1802201857);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][43], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][43], -1802202112);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][43], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][43], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][43], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][43], 1);

	MDC_PenalCode[playerid][44] = CreatePlayerTextDraw(playerid, 455.499084, 194.224273, "FTF");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][44], 0.198390, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][44], 468.999877, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][44], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][44], -1802201857);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][44], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][44], -1802202112);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][44], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][44], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][44], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][44], 1);

	MDC_PenalCode[playerid][45] = CreatePlayerTextDraw(playerid, 352.100646, 207.524322, "desc");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][45], 0.178387, 0.892929);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][45], 522.890014, 1.550000);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][45], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][45], 255);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][45], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][45], -1994712320);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][45], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][45], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][45], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][45], 1);

	MDC_PenalCode[playerid][46] = CreatePlayerTextDraw(playerid, 443.100891, 418.473205, "__~>~_Suclamayi_Uygula");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][46], 0.162387, 0.922930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][46], 523.498962, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][46], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][46], -1);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][46], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][46], -1994712065);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][46], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][46], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][46], 2);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][46], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][46], true);

	MDC_PenalCode[playerid][47] = CreatePlayerTextDraw(playerid, 229.100463, 431.120788, "_~<~");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][47], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][47], 245.000000, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][47], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][47], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][47], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][47], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][47], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][47], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][47], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][47], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][47], true);

	MDC_PenalCode[playerid][48] = CreatePlayerTextDraw(playerid, 329.200256, 431.120788, "__~>~");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCode[playerid][48], 0.178387, 0.972930);
	PlayerTextDrawTextSize(playerid, MDC_PenalCode[playerid][48], 345.099792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_PenalCode[playerid][48], 1);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][48], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCode[playerid][48], 1);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][48], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCode[playerid][48], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_PenalCode[playerid][48], 255);
	PlayerTextDrawFont(playerid, MDC_PenalCode[playerid][48], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCode[playerid][48], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][48], true);


	MDC_Emergency[playerid][0] = CreatePlayerTextDraw(playerid, 232.399871, 183.855056, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][0], 0.000000, 5.840000);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][0], 519.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][0], 0);

	MDC_Emergency[playerid][1] = CreatePlayerTextDraw(playerid, 234.199844, 185.278533, "Arayan:~n~Servis:~n~Lokasyon:~n~Aciklama:~n~Tarih:~n~Durum:");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][1], 0.207999, 0.928355);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][1], 1179010303);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][1], 0);

	MDC_Emergency[playerid][2] = CreatePlayerTextDraw(playerid, 279.702606, 185.278533, "caller1~n~service1~n~location1~n~situation1~n~time1~n~status1");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][2], 0.207999, 0.928355);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][2], -1431655937);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][2], 0);

	MDC_Emergency[playerid][3] = CreatePlayerTextDraw(playerid, 453.997863, 227.698638, "Ustlen");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][3], 0.151199, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][3], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][3], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][3], -2145901825);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][3], true);

	MDC_Emergency[playerid][4] = CreatePlayerTextDraw(playerid, 497.700561, 227.698638, "Detaylar");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][4], 0.151199, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][4], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][4], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][4], true);

	MDC_Emergency[playerid][5] = CreatePlayerTextDraw(playerid, 231.999893, 242.116699, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][5], 0.000000, 5.840000);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][5], 518.399902, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][5], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][5], 0);

	MDC_Emergency[playerid][6] = CreatePlayerTextDraw(playerid, 234.199813, 243.347793, "Arayan:~n~Servis:~n~Lokasyon:~n~Aciklama:~n~Tarih:~n~Durum:");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][6], 0.207999, 0.928355);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][6], 1179010303);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][6], 0);

	MDC_Emergency[playerid][7] = CreatePlayerTextDraw(playerid, 278.702423, 243.354522, "caller2~n~service2~n~location2~n~situation2~n~time2~n~status2");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][7], 0.207999, 0.928355);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][7], -1431655937);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][7], 0);

	MDC_Emergency[playerid][8] = CreatePlayerTextDraw(playerid, 454.497711, 285.753479, "Ustlen");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][8], 0.151199, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][8], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][8], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][8], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][8], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][8], -2145901825);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][8], true);

	MDC_Emergency[playerid][9] = CreatePlayerTextDraw(playerid, 497.800628, 285.803894, "Detaylar");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][9], 0.151199, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][9], 10.869999, 39.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][9], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][9], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][9], 255);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][9], true);

	MDC_Emergency[playerid][10] = CreatePlayerTextDraw(playerid, 231.999923, 300.499481, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][10], 0.000000, 5.840000);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][10], 518.399902, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][10], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][10], 0);

	MDC_Emergency[playerid][11] = CreatePlayerTextDraw(playerid, 234.199768, 301.557617, "Arayan:~n~Servis:~n~Lokasyon:~n~Aciklama:~n~Tarih:~n~Durum:");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][11], 0.207999, 0.928355);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][11], 1179010303);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][11], 0);

	MDC_Emergency[playerid][12] = CreatePlayerTextDraw(playerid, 278.702178, 302.039581, "caller3~n~service3~n~location3~n~situation3~n~time3~n~status3");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][12], 0.207999, 0.928355);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][12], -1431655937);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][12], 0);

	MDC_Emergency[playerid][13] = CreatePlayerTextDraw(playerid, 453.997711, 344.116027, "Ustlen");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][13], 0.151199, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][13], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][13], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][13], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][13], -2145901825);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][13], true);

	MDC_Emergency[playerid][14] = CreatePlayerTextDraw(playerid, 497.700622, 343.984527, "Detaylar");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][14], 0.151199, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][14], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][14], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][14], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][14], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][14], 255);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][14], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][14], true);

	MDC_Emergency[playerid][15] = CreatePlayerTextDraw(playerid, 232.199905, 358.629638, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][15], 0.000000, 5.840000);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][15], 519.019775, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][15], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][15], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][15], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][15], 0);

	MDC_Emergency[playerid][16] = CreatePlayerTextDraw(playerid, 234.199554, 358.908782, "Arayan:~n~Servis:~n~Lokasyon:~n~Aciklama:~n~Sure:~n~Durum:");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][16], 0.207999, 0.928355);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][16], 1179010303);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][16], 0);

	MDC_Emergency[playerid][17] = CreatePlayerTextDraw(playerid, 278.702392, 359.795349, "caller4~n~service4~n~location4~n~situation4~n~time4~n~status4");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][17], 0.207999, 0.928355);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][17], 1);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][17], -1431655937);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][17], 0);

	MDC_Emergency[playerid][18] = CreatePlayerTextDraw(playerid, 453.897216, 402.484436, "Ustlen");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][18], 0.151199, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][18], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][18], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][18], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][18], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][18], -2145901825);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][18], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][18], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][18], true);

	MDC_Emergency[playerid][19] = CreatePlayerTextDraw(playerid, 497.600708, 402.260589, "Detaylar");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][19], 0.151199, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][19], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][19], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][19], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][19], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][19], 255);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][19], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][19], true);

	MDC_Emergency[playerid][20] = CreatePlayerTextDraw(playerid, 456.299560, 417.986206, "~>~");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][20], 0.327599, 1.246577);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][20], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][20], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][20], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][20], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][20], 1987475199);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][20], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][20], true);

	MDC_Emergency[playerid][21] = CreatePlayerTextDraw(playerid, 295.598083, 417.905151, "~<~");
	PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][21], 0.327599, 1.246577);
	PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][21], 10.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][21], 2);
	PlayerTextDrawColour(playerid, MDC_Emergency[playerid][21], -1);
	PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][21], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Emergency[playerid][21], 1987475199);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Emergency[playerid][21], 255);
	PlayerTextDrawFont(playerid, MDC_Emergency[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][21], true);

	MDC_Warrants[playerid][0] = CreatePlayerTextDraw(playerid, 289.103332, 183.955062, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][0], 0.000000, 6.728005);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][0], 501.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][0], 0);

	MDC_Warrants[playerid][1] = CreatePlayerTextDraw(playerid, 232.402648, 183.943847, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][1], 0.000000, 6.720008);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][1], 279.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][1], 0);

	MDC_Warrants[playerid][2] = CreatePlayerTextDraw(playerid, 226.499847, 185.875701, "");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][2], 56.000000, 56.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][2], 2565888);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][2], 0);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_Warrants[playerid][2], 295);
	PlayerTextDrawSetPreviewRot(playerid, MDC_Warrants[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

	MDC_Warrants[playerid][3] = CreatePlayerTextDraw(playerid, 293.100036, 187.215606, "Aranan:~n~Aranma_Sebebi:");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][3], 0.183599, 0.843377);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][3], 572465919);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][3], 0);

	MDC_Warrants[playerid][4] = CreatePlayerTextDraw(playerid, 354.500305, 187.215606, "wantedName(20)~n~-wantedReason1~n~-wantedReason2~n~-wantedReason3~n~-wantedReason4~n~-wantedReason5");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][4], 0.183599, 0.843377);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][4], -1313885441);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][4], 0);

	MDC_Warrants[playerid][5] = CreatePlayerTextDraw(playerid, 472.700378, 235.420318, "Kaldir");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][5], 0.175799, 0.797244);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][5], 499.100067, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][5], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][5], -2145901825);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][5], true);

	MDC_Warrants[playerid][6] = CreatePlayerTextDraw(playerid, 442.098510, 235.420318, "__Ekle");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][6], 0.175799, 0.797244);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][6], 468.498199, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][6], 8388863);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][6], true);

	MDC_Warrants[playerid][7] = CreatePlayerTextDraw(playerid, 289.103332, 253.659317, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][7], 0.000000, 6.728005);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][7], 501.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][7], 0);

	MDC_Warrants[playerid][8] = CreatePlayerTextDraw(playerid, 232.401214, 253.711578, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][8], 0.000000, 6.720008);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][8], 280.398559, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][8], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][8], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][8], 0);

	MDC_Warrants[playerid][9] = CreatePlayerTextDraw(playerid, 226.499588, 252.511672, "");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][9], 56.000000, 56.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][9], 2565888);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][9], 0);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][9], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_Warrants[playerid][9], 26);
	PlayerTextDrawSetPreviewRot(playerid, MDC_Warrants[playerid][9], 0.000000, 0.000000, 0.000000, 1.000000);

	MDC_Warrants[playerid][10] = CreatePlayerTextDraw(playerid, 293.199951, 256.135101, "Aranan:~n~Aranma_Sebebi:");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][10], 0.183599, 0.843377);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][10], 572465919);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][10], 0);

	MDC_Warrants[playerid][11] = CreatePlayerTextDraw(playerid, 354.500305, 255.619781, "wantedName(20)~n~-wantedReason1~n~-wantedReason2~n~-wantedReason3~n~-wantedReason4~n~-wantedReason5");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][11], 0.183599, 0.843377);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][11], -1313885441);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][11], 0);

	MDC_Warrants[playerid][12] = CreatePlayerTextDraw(playerid, 472.700408, 304.626342, "Kaldir");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][12], 0.175799, 0.797244);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][12], 498.400024, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][12], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][12], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][12], -2145901825);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][12], true);

	MDC_Warrants[playerid][13] = CreatePlayerTextDraw(playerid, 442.198455, 304.554260, "__Ekle");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][13], 0.175799, 0.797244);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][13], 468.699981, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][13], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][13], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][13], 8388863);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][13], true);

	MDC_Warrants[playerid][14] = CreatePlayerTextDraw(playerid, 289.103210, 323.660827, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][14], 0.000000, 6.728005);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][14], 500.451293, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][14], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][14], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][14], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][14], 0);

	MDC_Warrants[playerid][15] = CreatePlayerTextDraw(playerid, 232.401077, 323.640960, "box");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][15], 0.000000, 6.720008);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][15], 279.999877, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][15], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][15], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][15], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][15], 0);

	MDC_Warrants[playerid][16] = CreatePlayerTextDraw(playerid, 226.399230, 323.079376, "");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][16], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][16], 56.000000, 56.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][16], 2565888);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][16], 5);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][16], 0);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][16], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, MDC_Warrants[playerid][16], 67);
	PlayerTextDrawSetPreviewRot(playerid, MDC_Warrants[playerid][16], 0.000000, 0.000000, 0.000000, 1.000000);

	MDC_Warrants[playerid][17] = CreatePlayerTextDraw(playerid, 293.100036, 326.562347, "Aranan:~n~Aranma_Sebebi:");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][17], 0.183599, 0.843377);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][17], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][17], 572465919);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][17], 0);

	MDC_Warrants[playerid][18] = CreatePlayerTextDraw(playerid, 354.500213, 325.580810, "wantedName(20)~n~-wantedReason1~n~-wantedReason2~n~-wantedReason3~n~-wantedReason4~n~-wantedReason5");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][18], 0.183599, 0.843377);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][18], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][18], -1313885441);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][18], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][18], 0);

	MDC_Warrants[playerid][19] = CreatePlayerTextDraw(playerid, 473.100341, 374.658050, "Kaldir");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][19], 0.175799, 0.797244);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][19], 498.799926, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][19], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][19], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][19], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][19], -2145901825);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][19], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][19], true);

	MDC_Warrants[playerid][20] = CreatePlayerTextDraw(playerid, 441.398345, 374.608612, "__Ekle");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][20], 0.175799, 0.797244);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][20], 468.999877, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][20], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][20], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][20], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][20], 8388863);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][20], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][20], true);

	MDC_Warrants[playerid][21] = CreatePlayerTextDraw(playerid, 478.100006, 390.257904, "~<~");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][21], 0.161599, 0.991467);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][21], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][21], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][21], 0);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][21], true);

	MDC_Warrants[playerid][22] = CreatePlayerTextDraw(playerid, 490.500762, 390.257904, "~>~");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][22], 0.161599, 0.991467);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][22], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][22], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][22], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][22], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][22], 0);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][22], true);

	MDC_Warrants[playerid][23] = CreatePlayerTextDraw(playerid, 431.000488, 169.157714, "~>~YENI_ARANMA_OLUSTUR");
	PlayerTextDrawLetterSize(playerid, MDC_Warrants[playerid][23], 0.137799, 0.946578);
	PlayerTextDrawTextSize(playerid, MDC_Warrants[playerid][23], 501.000305, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_Warrants[playerid][23], 1);
	PlayerTextDrawColour(playerid, MDC_Warrants[playerid][23], -1);
	PlayerTextDrawUseBox(playerid, MDC_Warrants[playerid][23], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Warrants[playerid][23], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Warrants[playerid][23], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Warrants[playerid][23], 255);
	PlayerTextDrawFont(playerid, MDC_Warrants[playerid][23], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Warrants[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Warrants[playerid][23], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Warrants[playerid][23], true);

	MDC_Roster[playerid][0] = CreatePlayerTextDraw(playerid, 230.400512, 181.774856, "BOLO1");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][0], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][0], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][0], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][0], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][0], 0);

	MDC_Roster[playerid][1] = CreatePlayerTextDraw(playerid, 522.999755, 181.774856, "BOLO1_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][1], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][1], 817.874023, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][1], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][1], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][1], 0);

	MDC_Roster[playerid][2] = CreatePlayerTextDraw(playerid, 230.400512, 194.674911, "BOLO2");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][2], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][2], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][2], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][2], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][2], 0);

	MDC_Roster[playerid][3] = CreatePlayerTextDraw(playerid, 522.999755, 194.674911, "BOLO2_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][3], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][3], 818.320007, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][3], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][3], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][3], 0);

	MDC_Roster[playerid][4] = CreatePlayerTextDraw(playerid, 230.400512, 207.574935, "BOLO3");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][4], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][4], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][4], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][4], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][4], 0);

	MDC_Roster[playerid][5] = CreatePlayerTextDraw(playerid, 522.999755, 207.574935, "BOLO3_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][5], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][5], 816.172851, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][5], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][5], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][5], 0);

	MDC_Roster[playerid][6] = CreatePlayerTextDraw(playerid, 230.400512, 220.525024, "BOLO4");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][6], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][6], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][6], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][6], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][6], 0);

	MDC_Roster[playerid][7] = CreatePlayerTextDraw(playerid, 522.999755, 220.525024, "BOLO4_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][7], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][7], 635.721862, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][7], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][7], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][7], 0);

	MDC_Roster[playerid][8] = CreatePlayerTextDraw(playerid, 230.400512, 233.574996, "BOLO5");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][8], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][8], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][8], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][8], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][8], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][8], 0);

	MDC_Roster[playerid][9] = CreatePlayerTextDraw(playerid, 522.999755, 233.574996, "BOLO5_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][9], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][9], 651.069213, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][9], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][9], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][9], 0);

	MDC_Roster[playerid][10] = CreatePlayerTextDraw(playerid, 230.400512, 247.025115, "BOLO6");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][10], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][10], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][10], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][10], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][10], 0);

	MDC_Roster[playerid][11] = CreatePlayerTextDraw(playerid, 522.999755, 247.025115, "BOLO6_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][11], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][11], 634.121276, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][11], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][11], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][11], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][11], 0);

	MDC_Roster[playerid][12] = CreatePlayerTextDraw(playerid, 230.400512, 260.425201, "BOLO7");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][12], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][12], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][12], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][12], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][12], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][12], 0);

	MDC_Roster[playerid][13] = CreatePlayerTextDraw(playerid, 522.999755, 260.425201, "BOLO7_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][13], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][13], 607.318176, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][13], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][13], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][13], 0);

	MDC_Roster[playerid][14] = CreatePlayerTextDraw(playerid, 230.400512, 273.425201, "BOLO8");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][14], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][14], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][14], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][14], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][14], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][14], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][14], 0);

	MDC_Roster[playerid][15] = CreatePlayerTextDraw(playerid, 522.999755, 273.425201, "BOLO8_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][15], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][15], 627.819396, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][15], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][15], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][15], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][15], 0);

	MDC_Roster[playerid][16] = CreatePlayerTextDraw(playerid, 230.400512, 286.925567, "BOLO9");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][16], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][16], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][16], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][16], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][16], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][16], 0);

	MDC_Roster[playerid][17] = CreatePlayerTextDraw(playerid, 522.999755, 286.925567, "BOLO9_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][17], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][17], 622.370971, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][17], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][17], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][17], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][17], 0);

	MDC_Roster[playerid][18] = CreatePlayerTextDraw(playerid, 230.400512, 300.276428, "BOLO10");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][18], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][18], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][18], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][18], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][18], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][18], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][18], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][18], 0);

	MDC_Roster[playerid][19] = CreatePlayerTextDraw(playerid, 522.999755, 300.276428, "BOLO10_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][19], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][19], 645.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][19], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][19], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][19], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][19], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][19], 0);

	MDC_Roster[playerid][20] = CreatePlayerTextDraw(playerid, 230.400512, 313.727050, "BOLO11");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][20], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][20], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][20], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][20], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][20], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][20], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][20], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][20], 0);

	MDC_Roster[playerid][21] = CreatePlayerTextDraw(playerid,522.999755, 313.727050, "BOLO11_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][21], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][21], 636.116882, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][21], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][21], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][21], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][21], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][21], 0);

	MDC_Roster[playerid][22] = CreatePlayerTextDraw(playerid, 230.400512, 327.127624, "BOLO12");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][22], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][22], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][22], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][22], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][22], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][22], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][22], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][22], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][22], 0);

	MDC_Roster[playerid][23] = CreatePlayerTextDraw(playerid, 522.999755, 327.127624, "BOLO12_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][23], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][23], 632.369018, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][23], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][23], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][23], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][23], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][23], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][23], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][23], 0);

	MDC_Roster[playerid][24] = CreatePlayerTextDraw(playerid, 230.400512, 340.227539, "BOLO13");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][24], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][24], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][24], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][24], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][24], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][24], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][24], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][24], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][24], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][24], 0);

	MDC_Roster[playerid][25] = CreatePlayerTextDraw(playerid, 522.999755, 340.227539, "BOLO13_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][25], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][25], 660.819396, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][25], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][25], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][25], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][25], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][25], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][25], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][25], 0);

	MDC_Roster[playerid][26] = CreatePlayerTextDraw(playerid, 230.400512, 353.527099, "BOLO14");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][26], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][26], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][26], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][26], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][26], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][26], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][26], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][26], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][26], 0);

	MDC_Roster[playerid][27] = CreatePlayerTextDraw(playerid, 522.999755, 353.527099, "BOLO14_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][27], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][27], 643.721252, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][27], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][27], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][27], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][27], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][27], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][27], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][27], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][27], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][27], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][27], 0);

	MDC_Roster[playerid][28] = CreatePlayerTextDraw(playerid, 230.400512, 366.527801, "BOLO15");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][28], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][28], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][28], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][28], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][28], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][28], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][28], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][28], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][28], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][28], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][28], 0);

	MDC_Roster[playerid][29] = CreatePlayerTextDraw(playerid, 522.999755, 366.527801, "BOLO15_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][29], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][29], 642.273437, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][29], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][29], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][29], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][29], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][29], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][29], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][29], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][29], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][29], 0);

	MDC_Roster[playerid][30] = CreatePlayerTextDraw(playerid, 230.400512, 380.027709, "BOLO16");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][30], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][30], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][30], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][30], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][30], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][30], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][30], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][30], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][30], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][30], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][30], 0);

	MDC_Roster[playerid][31] = CreatePlayerTextDraw(playerid, 522.999755, 380.027709, "BOLO16_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][31], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][31], 637.000000, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][31], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][31], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][31], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][31], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][31], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][31], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][31], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][31], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][31], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][31], 0);

	MDC_Roster[playerid][32] = CreatePlayerTextDraw(playerid, 230.400512, 393.527618, "BOLO17");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][32], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][32], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][32], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][32], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][32], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][32], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][32], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][32], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][32], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][32], 0);

	MDC_Roster[playerid][33] = CreatePlayerTextDraw(playerid, 522.999755, 393.527618, "BOLO17_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][33], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][33], 639.573364, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][33], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][33], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][33], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][33], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][33], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][33], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][33], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][33], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][33], 0);

	MDC_Roster[playerid][34] = CreatePlayerTextDraw(playerid, 230.400512, 407.027526, "BOLO18");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][34], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][34], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][34], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][34], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][34], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][34], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][34], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][34], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][34], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][34], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][34], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][34], 0);

	MDC_Roster[playerid][35] = CreatePlayerTextDraw(playerid, 522.999755, 407.027526, "BOLO18_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][35], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][35], 626.973022, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][35], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][35], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][35], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][35], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][35], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][35], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][35], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][35], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][35], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][35], 0);

	MDC_Roster[playerid][36] = CreatePlayerTextDraw(playerid, 230.400512, 420.527435, "BOLO19");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][36], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][36], 525.270263, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][36], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][36], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][36], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][36], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][36], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][36], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][36], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][36], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][36], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][36], 0);

	MDC_Roster[playerid][37] = CreatePlayerTextDraw(playerid, 522.999755, 420.527435, "BOLO19_TEXT");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][37], 0.209391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][37], 637.773315, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][37], 3);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][37], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][37], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][37], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][37], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][37], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][37], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][37], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][37], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][37], 0);

	MDC_Roster[playerid][38] = CreatePlayerTextDraw(playerid, 499.299896, 167.596420, "~<~");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][38], 0.180991, 0.992885);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][38], 505.909973, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][38], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][38], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][38], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][38], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][38], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][38], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][38], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][38], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][38], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][38], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Roster[playerid][38], true);

	MDC_Roster[playerid][39] = CreatePlayerTextDraw(playerid, 510.099822, 167.596420, "~>~");
	PlayerTextDrawLetterSize(playerid, MDC_Roster[playerid][39], 0.180991, 0.992885);
	PlayerTextDrawTextSize(playerid, MDC_Roster[playerid][39], 516.710083, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_Roster[playerid][39], 1);
	PlayerTextDrawColour(playerid, MDC_Roster[playerid][39], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_Roster[playerid][39], 1);
	PlayerTextDrawBoxColour(playerid, MDC_Roster[playerid][39], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][39], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Roster[playerid][39], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_Roster[playerid][39], 255);
	PlayerTextDrawFont(playerid, MDC_Roster[playerid][39], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Roster[playerid][39], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Roster[playerid][39], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Roster[playerid][39], true);


	MDC_EmergencyDetails[playerid][0] = CreatePlayerTextDraw(playerid, 235.599990, 192.986648, "Cagri_#No~n~~n~~n~Arayan:~n~TelefonNo:~n~Tarih:~n~Cagrilan_Servis:~n~Durum:~n~");
	PlayerTextDrawLetterSize(playerid, MDC_EmergencyDetails[playerid][0], 0.202799, 1.067377);
	PlayerTextDrawAlignment(playerid, MDC_EmergencyDetails[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_EmergencyDetails[playerid][0], 1431655935);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_EmergencyDetails[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_EmergencyDetails[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_EmergencyDetails[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_EmergencyDetails[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][0], 0);

	MDC_EmergencyDetails[playerid][1] = CreatePlayerTextDraw(playerid, 235.599472, 290.466003, "Konusma_dokumu_-_servis:~n~~n~~n~~n~Konusma_Dokumu_-_lokasyon:~n~~n~~n~~n~Konusma_Dokumu_-_aciklama:");
	PlayerTextDrawLetterSize(playerid, MDC_EmergencyDetails[playerid][1], 0.202799, 1.067377);
	PlayerTextDrawAlignment(playerid, MDC_EmergencyDetails[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_EmergencyDetails[playerid][1], 1431655935);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_EmergencyDetails[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_EmergencyDetails[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_EmergencyDetails[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_EmergencyDetails[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][1], 0);

	MDC_EmergencyDetails[playerid][2] = CreatePlayerTextDraw(playerid, 301.604003, 221.888412, "callerName~n~callerNumber~n~callerDate~n~callerService~n~callerSituation");
	PlayerTextDrawLetterSize(playerid, MDC_EmergencyDetails[playerid][2], 0.202799, 1.067377);
	PlayerTextDrawAlignment(playerid, MDC_EmergencyDetails[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_EmergencyDetails[playerid][2], -1970631937);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_EmergencyDetails[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_EmergencyDetails[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_EmergencyDetails[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_EmergencyDetails[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][2], 0);

	MDC_EmergencyDetails[playerid][3] = CreatePlayerTextDraw(playerid, 235.599472, 298.666503, "transcriptService~n~~n~~n~~n~transcriptLocation~n~~n~~n~~n~transcriptSituation");
	PlayerTextDrawLetterSize(playerid, MDC_EmergencyDetails[playerid][3], 0.202799, 1.067377);
	PlayerTextDrawAlignment(playerid, MDC_EmergencyDetails[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_EmergencyDetails[playerid][3], -1970631937);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_EmergencyDetails[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_EmergencyDetails[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_EmergencyDetails[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_EmergencyDetails[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][3], 0);

	MDC_EmergencyDetails[playerid][4] = CreatePlayerTextDraw(playerid, 236.201202, 167.593261, "~<~_Geri_Git");
	PlayerTextDrawLetterSize(playerid, MDC_EmergencyDetails[playerid][4], 0.231199, 1.122133);
	PlayerTextDrawTextSize(playerid, MDC_EmergencyDetails[playerid][4], 290.000488, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_EmergencyDetails[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_EmergencyDetails[playerid][4], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_EmergencyDetails[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_EmergencyDetails[playerid][4], 84215040);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_EmergencyDetails[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_EmergencyDetails[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_EmergencyDetails[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, MDC_EmergencyDetails[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_EmergencyDetails[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_EmergencyDetails[playerid][4], true);

	MDC_CrimeHistory[playerid][0] = CreatePlayerTextDraw(playerid, 234.000061, 192.986663, "box");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][0], 0.000000, 25.288013);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][0], 519.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][0], 0);

	MDC_CrimeHistory[playerid][1] = CreatePlayerTextDraw(playerid, 235.300109, 194.484497, "2020-00-00___Crime1");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][1], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][1], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][1], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][1], true);

	MDC_CrimeHistory[playerid][2] = CreatePlayerTextDraw(playerid, 235.300109, 206.085205, "2020-00-00___Crime2");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][2], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][2], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][2], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][2], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][2], true);

	MDC_CrimeHistory[playerid][3] = CreatePlayerTextDraw(playerid, 235.300109, 217.885925, "2020-00-00___Crime3");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][3], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][3], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][3], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][3], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][3], true);

	MDC_CrimeHistory[playerid][4] = CreatePlayerTextDraw(playerid, 235.300109, 229.686645, "2020-00-00___Crime4");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][4], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][4], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][4], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][4], true);

	MDC_CrimeHistory[playerid][5] = CreatePlayerTextDraw(playerid, 235.300109, 241.387359, "2020-00-00___Crime5");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][5], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][5], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][5], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][5], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][5], true);

	MDC_CrimeHistory[playerid][6] = CreatePlayerTextDraw(playerid, 235.300109, 253.088073, "2020-00-00___Crime6");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][6], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][6], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][6], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][6], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][6], true);

	MDC_CrimeHistory[playerid][7] = CreatePlayerTextDraw(playerid, 235.300109, 264.588775, "2020-00-00___Crime7");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][7], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][7], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][7], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][7], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][7], true);

	MDC_CrimeHistory[playerid][8] = CreatePlayerTextDraw(playerid, 235.300109, 276.189483, "2020-00-00___Crime8");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][8], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][8], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][8], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][8], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][8], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][8], true);

	MDC_CrimeHistory[playerid][9] = CreatePlayerTextDraw(playerid, 235.300109, 287.890197, "2020-00-00___Crime9");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][9], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][9], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][9], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][9], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][9], true);

	MDC_CrimeHistory[playerid][10] = CreatePlayerTextDraw(playerid, 235.300109, 299.490905, "2020-00-00___Crime10");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][10], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][10], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][10], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][10], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][10], true);

	MDC_CrimeHistory[playerid][11] = CreatePlayerTextDraw(playerid, 235.300109, 311.091613, "2020-00-00___Crime11");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][11], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][11], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][11], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][11], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][11], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][11], true);

	MDC_CrimeHistory[playerid][12] = CreatePlayerTextDraw(playerid, 235.300109, 322.592315, "2020-00-00___Crime12");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][12], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][12], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][12], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][12], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][12], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][12], true);

	MDC_CrimeHistory[playerid][13] = CreatePlayerTextDraw(playerid, 235.300109, 333.993011, "2020-00-00___Crime13");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][13], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][13], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][13], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][13], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][13], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][13], true);

	MDC_CrimeHistory[playerid][14] = CreatePlayerTextDraw(playerid, 235.300109, 345.393707, "2020-00-00___Crime14");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][14], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][14], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][14], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][14], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][14], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][14], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][14], true);

	MDC_CrimeHistory[playerid][15] = CreatePlayerTextDraw(playerid, 235.300109, 356.494384, "2020-00-00___Crime15");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][15], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][15], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][15], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][15], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][15], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][15], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][15], true);

	MDC_CrimeHistory[playerid][16] = CreatePlayerTextDraw(playerid, 235.300109, 367.895080, "2020-00-00___Crime16");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][16], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][16], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][16], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][16], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][16], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][16], true);

	MDC_CrimeHistory[playerid][17] = CreatePlayerTextDraw(playerid, 235.300109, 379.395782, "2020-00-00___Crime17");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][17], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][17], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][17], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][17], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][17], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][17], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][17], true);

	MDC_CrimeHistory[playerid][18] = CreatePlayerTextDraw(playerid, 235.300109, 390.696472, "2020-00-00___Crime18");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][18], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][18], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][18], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][18], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][18], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][18], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][18], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][18], true);

	MDC_CrimeHistory[playerid][19] = CreatePlayerTextDraw(playerid, 235.300109, 402.097167, "2020-00-00___Crime19");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][19], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][19], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][19], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][19], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][19], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][19], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][19], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][19], true);

	MDC_CrimeHistory[playerid][20] = CreatePlayerTextDraw(playerid, 235.300109, 413.597869, "2020-00-00___Crime20");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][20], 0.201999, 0.873244);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][20], 517.399902, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][20], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][20], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][20], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][20], 255);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][20], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][20], true);

	MDC_CrimeHistory[playerid][21] = CreatePlayerTextDraw(playerid, 507.199890, 426.444427, "~>~");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][21], 0.231199, 1.122133);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][21], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][21], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][21], true);

	MDC_CrimeHistory[playerid][22] = CreatePlayerTextDraw(playerid, 492.799011, 426.444427, "~<~");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][22], 0.231199, 1.122133);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][22], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][22], -1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][22], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][22], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][22], true);

	MDC_CrimeHistory[playerid][23] = CreatePlayerTextDraw(playerid, 236.201202, 167.593261, "~<~_Geri_Git");
	PlayerTextDrawLetterSize(playerid, MDC_CrimeHistory[playerid][23], 0.231199, 1.122133);
	PlayerTextDrawTextSize(playerid, MDC_CrimeHistory[playerid][23], 290.000488, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_CrimeHistory[playerid][23], 1);
	PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][23], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_CrimeHistory[playerid][23], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][23], 84215040);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CrimeHistory[playerid][23], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CrimeHistory[playerid][23], 255);
	PlayerTextDrawFont(playerid, MDC_CrimeHistory[playerid][23], 2);
	PlayerTextDrawSetProportional(playerid, MDC_CrimeHistory[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CrimeHistory[playerid][23], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CrimeHistory[playerid][23], true);

	MDC_SelectedCrimeDetails[playerid][0] = CreatePlayerTextDraw(playerid, 233.899719, 194.502502, "Islem_No~n~Isim~n~Uygulayan~n~Tarih~n~Tur");
	PlayerTextDrawLetterSize(playerid, MDC_SelectedCrimeDetails[playerid][0], 0.219999, 1.097244);
	PlayerTextDrawAlignment(playerid, MDC_SelectedCrimeDetails[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_SelectedCrimeDetails[playerid][0], 1330597887);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_SelectedCrimeDetails[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_SelectedCrimeDetails[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_SelectedCrimeDetails[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_SelectedCrimeDetails[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][0], 0);

	MDC_SelectedCrimeDetails[playerid][1] = CreatePlayerTextDraw(playerid, 233.899734, 274.956924, "Aciklama");
	PlayerTextDrawLetterSize(playerid, MDC_SelectedCrimeDetails[playerid][1], 0.219999, 1.097244);
	PlayerTextDrawAlignment(playerid, MDC_SelectedCrimeDetails[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_SelectedCrimeDetails[playerid][1], 1330597887);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_SelectedCrimeDetails[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_SelectedCrimeDetails[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_SelectedCrimeDetails[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_SelectedCrimeDetails[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][1], 0);

	MDC_SelectedCrimeDetails[playerid][2] = CreatePlayerTextDraw(playerid, 286.900756, 194.591247, "#_criminalNo~n~criminalName~n~criminialIssuier~n~criminalDate");
	PlayerTextDrawLetterSize(playerid, MDC_SelectedCrimeDetails[playerid][2], 0.219999, 1.097244);
	PlayerTextDrawAlignment(playerid, MDC_SelectedCrimeDetails[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_SelectedCrimeDetails[playerid][2], -1532713729);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_SelectedCrimeDetails[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_SelectedCrimeDetails[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_SelectedCrimeDetails[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_SelectedCrimeDetails[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][2], 0);

	MDC_SelectedCrimeDetails[playerid][3] = CreatePlayerTextDraw(playerid, 233.899734, 286.157592, "criminalQuote");
	PlayerTextDrawLetterSize(playerid, MDC_SelectedCrimeDetails[playerid][3], 0.219999, 1.097244);
	PlayerTextDrawAlignment(playerid, MDC_SelectedCrimeDetails[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_SelectedCrimeDetails[playerid][3], -1532713729);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_SelectedCrimeDetails[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_SelectedCrimeDetails[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_SelectedCrimeDetails[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_SelectedCrimeDetails[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][3], 0);

	MDC_SelectedCrimeDetails[playerid][4] = CreatePlayerTextDraw(playerid, 236.201202, 167.593261, "~<~_Geri_Git");
	PlayerTextDrawLetterSize(playerid, MDC_SelectedCrimeDetails[playerid][4], 0.231199, 1.122133);
	PlayerTextDrawTextSize(playerid, MDC_SelectedCrimeDetails[playerid][4], 290.000488, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_SelectedCrimeDetails[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_SelectedCrimeDetails[playerid][4], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_SelectedCrimeDetails[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_SelectedCrimeDetails[playerid][4], 84215040);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_SelectedCrimeDetails[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_SelectedCrimeDetails[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_SelectedCrimeDetails[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, MDC_SelectedCrimeDetails[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_SelectedCrimeDetails[playerid][4], true);

	MDC_SelectedCrimeDetails[playerid][5] = CreatePlayerTextDraw(playerid, 233.899734, 256.157592, "~>~Tutuklama_kaydini_gor");
	PlayerTextDrawLetterSize(playerid, MDC_SelectedCrimeDetails[playerid][5], 0.231199, 1.122133);
	PlayerTextDrawTextSize(playerid, MDC_SelectedCrimeDetails[playerid][5], 370.000488, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_SelectedCrimeDetails[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_SelectedCrimeDetails[playerid][5], -2139062017);
	PlayerTextDrawUseBox(playerid, MDC_SelectedCrimeDetails[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_SelectedCrimeDetails[playerid][5], 84215040);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_SelectedCrimeDetails[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_SelectedCrimeDetails[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_SelectedCrimeDetails[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, MDC_SelectedCrimeDetails[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_SelectedCrimeDetails[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_SelectedCrimeDetails[playerid][5], true);

	MDC_CCTV[playerid][0] = CreatePlayerTextDraw(playerid, 232.500411, 193.457519, "camera1");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][0], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][0], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][0], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][0], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][0], true);

	MDC_CCTV[playerid][1] = CreatePlayerTextDraw(playerid, 232.500411, 210.158538, "camera2");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][1], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][1], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][1], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][1], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][1], true);

	MDC_CCTV[playerid][2] = CreatePlayerTextDraw(playerid, 232.500411, 226.959564, "camera3");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][2], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][2], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][2], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][2], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][2], true);

	MDC_CCTV[playerid][3] = CreatePlayerTextDraw(playerid, 232.500411, 243.460571, "camera4");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][3], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][3], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][3], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][3], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][3], true);

	MDC_CCTV[playerid][4] = CreatePlayerTextDraw(playerid, 232.500411, 260.361602, "camera5");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][4], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][4], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][4], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][4], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][4], true);

	MDC_CCTV[playerid][5] = CreatePlayerTextDraw(playerid, 232.500411, 277.262634, "camera6");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][5], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][5], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][5], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][5], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][5], true);

	MDC_CCTV[playerid][6] = CreatePlayerTextDraw(playerid, 232.500411, 294.163665, "camera7");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][6], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][6], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][6], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][6], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][6], true);

	MDC_CCTV[playerid][7] = CreatePlayerTextDraw(playerid, 232.500411, 311.264709, "camera8");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][7], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][7], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][7], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][7], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][7], true);

	MDC_CCTV[playerid][8] = CreatePlayerTextDraw(playerid, 232.500411, 328.365753, "camera9");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][8], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][8], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][8], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][8], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][8], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][8], true);

	MDC_CCTV[playerid][9] = CreatePlayerTextDraw(playerid, 232.500411, 345.566802, "camera10");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][9], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][9], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][9], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][9], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][9], true);

	MDC_CCTV[playerid][10] = CreatePlayerTextDraw(playerid, 232.500411, 362.567840, "camera11");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][10], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][10], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][10], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][10], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][10], true);

	MDC_CCTV[playerid][11] = CreatePlayerTextDraw(playerid, 232.500411, 379.768890, "camera12");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][11], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][11], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][11], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][11], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][11], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][11], true);

	MDC_CCTV[playerid][12] = CreatePlayerTextDraw(playerid, 232.500411, 397.169952, "camera13");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][12], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][12], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][12], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][12], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][12], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][12], true);

	MDC_CCTV[playerid][13] = CreatePlayerTextDraw(playerid, 232.500411, 414.170989, "camera14");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][13], 0.190595, 1.201953);
	PlayerTextDrawTextSize(playerid, MDC_CCTV[playerid][13], 522.000000, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][13], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][13], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CCTV[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CCTV[playerid][13], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][13], true);

	MDC_CCTV[playerid][14] = CreatePlayerTextDraw(playerid, 513.599548, 427.542236, "~>~");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][14], 0.377199, 1.390933);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][14], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][14], true);

	MDC_CCTV[playerid][15] = CreatePlayerTextDraw(playerid, 340.099365, 427.542236, "~<~");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][15], 0.377199, 1.390933);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][15], 1);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CCTV[playerid][15], true);

	MDC_CCTV[playerid][16] = CreatePlayerTextDraw(playerid, 522.900024, 181.142288, "10/10");
	PlayerTextDrawLetterSize(playerid, MDC_CCTV[playerid][16], 0.234799, 0.937955);
	PlayerTextDrawAlignment(playerid, MDC_CCTV[playerid][16], 3);
	PlayerTextDrawColour(playerid, MDC_CCTV[playerid][16], 993737727);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CCTV[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CCTV[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_CCTV[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CCTV[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CCTV[playerid][16], 0);

	MDC_VehicleBolo_Details[playerid][0] = CreatePlayerTextDraw(playerid, 409.100311, 168.324035, "ARAC_BOLOSUNU_SIL");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_Details[playerid][0], 0.198597, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_Details[playerid][0], 525.199462, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_Details[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_Details[playerid][0], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_Details[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_Details[playerid][0], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_Details[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_Details[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_Details[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_Details[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_Details[playerid][0], true);

	MDC_VehicleBolo_Details[playerid][1] = CreatePlayerTextDraw(playerid, 229.799316, 168.324035, "~<~_ARAC_BOLOLARINA_GERI_DON");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_Details[playerid][1], 0.159395, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_Details[playerid][1], 340.199462, 10.559998);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_Details[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_Details[playerid][1], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_Details[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_Details[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_Details[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_Details[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_Details[playerid][1], true);

	MDC_VehicleBolo_Details[playerid][2] = CreatePlayerTextDraw(playerid, 237.499359, 193.624176, "BOLO_ID~n~Olusturan~n~Model~n~Plaka~n~Tarih~n~~n~Suclar~n~~n~~n~~n~Rapor");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_Details[playerid][2], 0.218595, 0.908263);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_Details[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_Details[playerid][2], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_Details[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_Details[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_Details[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_Details[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_Details[playerid][2], false);

	MDC_VehicleBolo_Details[playerid][3] = CreatePlayerTextDraw(playerid, 286.999633, 193.624176, "id~n~createdBy~n~Model~n~Plate~n~Date");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_Details[playerid][3], 0.218595, 0.908263);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_Details[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_Details[playerid][3], -1684300801);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_Details[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_Details[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_Details[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_Details[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_Details[playerid][3], false);

	MDC_VehicleBolo_Details[playerid][4] = CreatePlayerTextDraw(playerid, 244.099395, 251.924499, "boloCrimes");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_Details[playerid][4], 0.218595, 0.908263);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_Details[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_Details[playerid][4], -1684300801);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_Details[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_Details[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_Details[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_Details[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_Details[playerid][4], false);

	MDC_VehicleBolo_Details[playerid][5] = CreatePlayerTextDraw(playerid, 244.099395, 286.024688, "N/A");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_Details[playerid][5], 0.218595, 0.908263);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_Details[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_Details[playerid][5], -1684300801);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_Details[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_Details[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_Details[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_Details[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_Details[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_Details[playerid][5], false);

	MDC_VehicleBolo_List[playerid][0] = CreatePlayerTextDraw(playerid, 479.449951, 168.124023, "Yeni_bolo_olustur");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][0], 0.159395, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][0], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][0], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][0], 858994175);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][0], true);

	MDC_VehicleBolo_List[playerid][1] = CreatePlayerTextDraw(playerid, 230.400512, 181.774856, "BOLO1");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][1], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][1], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][1], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][1], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][1], true);

	MDC_VehicleBolo_List[playerid][2] = CreatePlayerTextDraw(playerid, 230.400512, 194.324890, "bolo2");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][2], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][2], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][2], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][2], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][2], true);

	MDC_VehicleBolo_List[playerid][3] = CreatePlayerTextDraw(playerid, 230.400512, 207.324890, "bolo3");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][3], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][3], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][3], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][3], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][3], true);

	MDC_VehicleBolo_List[playerid][4] = CreatePlayerTextDraw(playerid, 230.400512, 220.324890, "bolo4");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][4], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][4], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][4], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][4], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][4], true);

	MDC_VehicleBolo_List[playerid][5] = CreatePlayerTextDraw(playerid, 230.400512, 233.324890, "bolo5");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][5], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][5], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][5], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][5], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][5], true);

	MDC_VehicleBolo_List[playerid][6] = CreatePlayerTextDraw(playerid, 230.400512, 246.225021, "bolo6");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][6], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][6], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][6], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][6], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][6], true);

	MDC_VehicleBolo_List[playerid][7] = CreatePlayerTextDraw(playerid, 230.400512, 259.125000, "bolo7");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][7], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][7], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][7], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][7], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][7], true);

	MDC_VehicleBolo_List[playerid][8] = CreatePlayerTextDraw(playerid, 230.400512, 272.024475, "bolo8");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][8], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][8], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][8], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][8], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][8], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][8], true);

	MDC_VehicleBolo_List[playerid][9] = CreatePlayerTextDraw(playerid, 230.400512, 285.223937, "bolo9");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][9], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][9], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][9], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][9], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][9], true);

	MDC_VehicleBolo_List[playerid][10] = CreatePlayerTextDraw(playerid, 230.400512, 298.123413, "bolo10");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][10], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][10], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][10], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][10], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][10], true);

	MDC_VehicleBolo_List[playerid][11] = CreatePlayerTextDraw(playerid, 230.400512, 311.022888, "bolo11");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][11], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][11], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][11], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][11], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][11], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][11], true);

	MDC_VehicleBolo_List[playerid][12] = CreatePlayerTextDraw(playerid, 230.400512, 323.922363, "bolo12");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][12], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][12], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][12], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][12], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][12], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][12], true);

	MDC_VehicleBolo_List[playerid][13] = CreatePlayerTextDraw(playerid, 230.400512, 336.821838, "bolo13");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][13], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][13], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][13], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][13], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][13], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][13], true);

	MDC_VehicleBolo_List[playerid][14] = CreatePlayerTextDraw(playerid, 230.400512, 349.721313, "bolo14");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][14], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][14], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][14], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][14], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][14], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][14], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][14], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][14], true);

	MDC_VehicleBolo_List[playerid][15] = CreatePlayerTextDraw(playerid, 230.400512, 362.620788, "bolo15");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][15], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][15], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][15], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][15], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][15], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][15], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][15], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][15], true);

	MDC_VehicleBolo_List[playerid][16] = CreatePlayerTextDraw(playerid, 230.400512, 375.520263, "bolo16");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][16], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][16], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][16], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][16], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][16], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][16], true);

	MDC_VehicleBolo_List[playerid][17] = CreatePlayerTextDraw(playerid, 230.400512, 388.719726, "bolo17");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][17], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][17], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][17], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][17], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][17], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][17], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][17], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][17], true);

	MDC_VehicleBolo_List[playerid][18] = CreatePlayerTextDraw(playerid, 230.400512, 401.319213, "bolo18");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][18], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][18], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][18], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][18], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][18], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][18], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][18], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][18], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][18], true);

	MDC_VehicleBolo_List[playerid][19] = CreatePlayerTextDraw(playerid, 230.400512, 413.918701, "bolo19");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][19], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][19], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][19], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][19], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][19], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][19], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][19], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][19], true);

	MDC_VehicleBolo_List[playerid][20] = CreatePlayerTextDraw(playerid, 230.400512, 426.818176, "bolo20");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][20], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][20], 525.349792, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][20], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][20], 1683842303);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][20], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][20], -1431459073);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][20], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][20], true);

	MDC_VehicleBolo_List[playerid][21] = CreatePlayerTextDraw(playerid, 450.650329, 168.124023, "~<~");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][21], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][21], 459.200073, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][21], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][21], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][21], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][21], 1683842048);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][21], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][21], true);

	MDC_VehicleBolo_List[playerid][22] = CreatePlayerTextDraw(playerid, 463.050354, 168.124023, "~>~");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleBolo_List[playerid][22], 0.159391, 0.982930);
	PlayerTextDrawTextSize(playerid, MDC_VehicleBolo_List[playerid][22], 471.600097, 10.0);
	PlayerTextDrawAlignment(playerid, MDC_VehicleBolo_List[playerid][22], 1);
	PlayerTextDrawColour(playerid, MDC_VehicleBolo_List[playerid][22], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_VehicleBolo_List[playerid][22], 1);
	PlayerTextDrawBoxColour(playerid, MDC_VehicleBolo_List[playerid][22], 1683842048);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleBolo_List[playerid][22], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_VehicleBolo_List[playerid][22], 255);
	PlayerTextDrawFont(playerid, MDC_VehicleBolo_List[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleBolo_List[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleBolo_List[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_VehicleBolo_List[playerid][22], true);

	MDC_CriminalRecords[playerid][0] = CreatePlayerTextDraw(playerid, 230.000274, 168.693344, "~<~_geri_don");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][0], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][0], 279.999694, 1.889997);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][0], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][0], true);

	MDC_CriminalRecords[playerid][1] = CreatePlayerTextDraw(playerid, 498.251281, 422.393188, "~<~");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][1], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][1], 507.213378, 1.889997);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][1], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][1], true);

	MDC_CriminalRecords[playerid][2] = CreatePlayerTextDraw(playerid, 511.252075, 422.393188, "~>~");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][2], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][2], 520.211669, 1.889997);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][2], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][2], true);

	MDC_CriminalRecords[playerid][3] = CreatePlayerTextDraw(playerid, 232.350402, 184.843185, "box");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][3], 0.000000, 25.920318);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][3], 519.970031, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][3], 0);

	MDC_CriminalRecords[playerid][4] = CreatePlayerTextDraw(playerid, 232.400405, 185.143493, "1");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][4], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][4], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][4], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][4], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][4], true);

	MDC_CriminalRecords[playerid][5] = CreatePlayerTextDraw(playerid, 232.400405, 199.044342, "2");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][5], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][5], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][5], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][5], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][5], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][5], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][5], true);

	MDC_CriminalRecords[playerid][6] = CreatePlayerTextDraw(playerid, 232.400405, 213.044464, "3");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][6], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][6], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][6], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][6], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][6], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][6], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][6], true);

	MDC_CriminalRecords[playerid][7] = CreatePlayerTextDraw(playerid, 232.400405, 226.895309, "4");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][7], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][7], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][7], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][7], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][7], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][7], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][7], true);

	MDC_CriminalRecords[playerid][8] = CreatePlayerTextDraw(playerid, 232.400405, 240.846160, "5");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][8], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][8], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][8], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][8], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][8], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][8], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][8], true);

	MDC_CriminalRecords[playerid][9] = CreatePlayerTextDraw(playerid, 232.400405, 254.847015, "6");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][9], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][9], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][9], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][9], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][9], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][9], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][9], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][9], true);

	MDC_CriminalRecords[playerid][10] = CreatePlayerTextDraw(playerid, 232.400405, 268.743988, "7");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][10], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][10], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][10], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][10], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][10], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][10], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][10], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][10], true);

	MDC_CriminalRecords[playerid][11] = CreatePlayerTextDraw(playerid, 232.400405, 282.690582, "8");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][11], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][11], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][11], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][11], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][11], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][11], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][11], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][11], true);

	MDC_CriminalRecords[playerid][12] = CreatePlayerTextDraw(playerid, 232.400405, 296.637176, "9");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][12], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][12], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][12], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][12], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][12], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][12], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][12], true);

	MDC_CriminalRecords[playerid][13] = CreatePlayerTextDraw(playerid, 232.400405, 310.433807, "10");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][13], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][13], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][13], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][13], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][13], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][13], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][13], true);

	MDC_CriminalRecords[playerid][14] = CreatePlayerTextDraw(playerid, 232.400405, 324.530364, "11");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][14], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][14], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][14], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][14], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][14], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][14], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][14], true);

	MDC_CriminalRecords[playerid][15] = CreatePlayerTextDraw(playerid, 232.400405, 338.426971, "12");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][15], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][15], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][15], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][15], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][15], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][15], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][15], true);

	MDC_CriminalRecords[playerid][16] = CreatePlayerTextDraw(playerid, 232.400405, 352.423553, "13");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][16], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][16], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][16], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][16], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][16], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][16], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][16], true);

	MDC_CriminalRecords[playerid][17] = CreatePlayerTextDraw(playerid, 232.400405, 366.320159, "14");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][17], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][17], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][17], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][17], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][17], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][17], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][17], true);

	MDC_CriminalRecords[playerid][18] = CreatePlayerTextDraw(playerid, 232.400405, 380.216766, "15");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][18], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][18], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][18], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][18], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][18], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][18], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][18], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][18], true);

	MDC_CriminalRecords[playerid][19] = CreatePlayerTextDraw(playerid, 232.400405, 394.163360, "16");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][19], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][19], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][19], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][19], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][19], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][19], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][19], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][19], true);

	MDC_CriminalRecords[playerid][20] = CreatePlayerTextDraw(playerid, 232.400405, 408.109954, "17");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecords[playerid][20], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecords[playerid][20], 519.601501, 1.559998);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecords[playerid][20], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecords[playerid][20], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecords[playerid][20], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecords[playerid][20], -1381323265);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecords[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecords[playerid][20], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecords[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecords[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecords[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecords[playerid][20], true);

	MDC_CriminalRecordDetail[playerid][0] = CreatePlayerTextDraw(playerid, 230.000274, 168.693344, "~<~_geri_don");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecordDetail[playerid][0], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecordDetail[playerid][0], 279.999694, 1.889997);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecordDetail[playerid][0], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecordDetail[playerid][0], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecordDetail[playerid][0], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecordDetail[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecordDetail[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecordDetail[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecordDetail[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecordDetail[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecordDetail[playerid][0], true);

	MDC_CriminalRecordDetail[playerid][1] = CreatePlayerTextDraw(playerid, 230.000274, 184.893096, "Dosya_ID~n~Isim~n~Isleyen~n~Tarih~n~Tur");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecordDetail[playerid][1], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecordDetail[playerid][1], 279.999694, 1.889997);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecordDetail[playerid][1], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecordDetail[playerid][1], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecordDetail[playerid][1], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecordDetail[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecordDetail[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecordDetail[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecordDetail[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecordDetail[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][1], 0);

	MDC_CriminalRecordDetail[playerid][2] = CreatePlayerTextDraw(playerid, 271.400817, 184.893096, "id~n~name~n~issuer~n~date~n~type");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecordDetail[playerid][2], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecordDetail[playerid][2], 321.402221, 1.889997);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecordDetail[playerid][2], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecordDetail[playerid][2], -1566268161);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecordDetail[playerid][2], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecordDetail[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecordDetail[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecordDetail[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecordDetail[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecordDetail[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][2], 0);

	MDC_CriminalRecordDetail[playerid][3] = CreatePlayerTextDraw(playerid, 230.000274, 251.093292, "~>~_Tum_kaydi_gormek_icin_tiklayin.");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecordDetail[playerid][3], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecordDetail[playerid][3], 343.000000, 1.889997);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecordDetail[playerid][3], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecordDetail[playerid][3], -1532516353);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecordDetail[playerid][3], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecordDetail[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecordDetail[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecordDetail[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecordDetail[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecordDetail[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_CriminalRecordDetail[playerid][3], true);

	MDC_CriminalRecordDetail[playerid][4] = CreatePlayerTextDraw(playerid, 230.000274, 240.593261, "Tutuklama_Kaydi_(Martin tarafindan yazildi)");
	PlayerTextDrawLetterSize(playerid, MDC_CriminalRecordDetail[playerid][4], 0.198596, 1.092442);
	PlayerTextDrawTextSize(playerid, MDC_CriminalRecordDetail[playerid][4], 498.000000, 1.889997);
	PlayerTextDrawAlignment(playerid, MDC_CriminalRecordDetail[playerid][4], 1);
	PlayerTextDrawColour(playerid, MDC_CriminalRecordDetail[playerid][4], 892483071);
	PlayerTextDrawUseBox(playerid, MDC_CriminalRecordDetail[playerid][4], 1);
	PlayerTextDrawBoxColour(playerid, MDC_CriminalRecordDetail[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_CriminalRecordDetail[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, MDC_CriminalRecordDetail[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_CriminalRecordDetail[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_CriminalRecordDetail[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_CriminalRecordDetail[playerid][4], 0);
	return 1;
}