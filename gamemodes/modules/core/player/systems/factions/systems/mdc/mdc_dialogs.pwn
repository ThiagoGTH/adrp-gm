Dialog:MDC_AskDeleteRecord(playerid, response, listitem, inputtext[])
{
	new id = GetPVarInt(playerid, "AskDeleteRecordID");
	if(response) {
		mysql_format(DBConn, query, sizeof(query), "DELETE FROM player_arrest WHERE id = %d", id);
		mysql_tquery(DBConn, query);
	}
	return 1;
}

Dialog:MDC_ArrestRecord(playerid, response, listitem, inputtext[])
{
	if(response)
	{
			MDC_ArrestRecordCount[playerid] = 0;

			strcat(MDC_ArrestRecord[playerid][MDC_ArrestRecordCount[playerid]], inputtext);
			strcat(MDC_ArrestRecord[playerid][MDC_ArrestRecordCount[playerid]], "\n");
			MDC_ArrestRecordCount[playerid]+=1;

			new str_dialog[512];
			strcat(str_dialog, sprintf("{FFFFFF}%s iùin tutuklama kaydù.\nùptal etmek iùin {FF6347}iptal{FFFFFF}, tamamlamak iùin {33AA33}bitir {FFFFFF}yaz.\n", MDC_PlayerLastSearched[playerid]));
			strcat(str_dialog, "\n\n");

			for(new is; is < MDC_ArrestRecordCount[playerid]; is++)
			{
					strcat(str_dialog, MDC_ArrestRecord[playerid][is]);
			}
			Dialog_Show(playerid, MDC_ArrestRecord_Add, DIALOG_STYLE_INPUT, sprintf("Tutuklama Kaydù (5 satùrdan %d)", MDC_ArrestRecordCount[playerid]), str_dialog, "ùleri", "Geri Al");
			return 1;
	}
	return 1;
}

Dialog:MDC_ArrestRecord_Add(playerid, response, listitem, inputtext[])
{
	if(response)
	{
			if(strfind(inputtext, "iptal", true) != -1)
			{
				for(new is; is < MDC_ArrestRecordCount[playerid]; is++)
				{
					format(MDC_ArrestRecord[playerid][is], 128, "");
				}

				MDC_ArrestRecordCount[playerid] = 0;
				return 1;
			}


			if(strfind(inputtext, "bitir", true) != -1)
			{
				CreateArrestRecord(playerid);
				return 1;
			}

			new str_dialog[512];

			if(MDC_ArrestRecordCount[playerid] > 4)
			{
				strcat(str_dialog, "Daha fazla ekleyemezsin.\n");
				strcat(str_dialog, sprintf("{FFFFFF}%s iùin tutuklama kaydù.\nùptal etmek iùin {FF6347}iptal{FFFFFF}, tamamlamak iùin {33AA33}bitir {FFFFFF}yaz.\n", MDC_PlayerLastSearched[playerid]));
				strcat(str_dialog, "\n\n");
				for(new is; is < MDC_ArrestRecordCount[playerid]; is++)
				{
					strcat(str_dialog, MDC_ArrestRecord[playerid][is]);
					strcat(str_dialog, "\n");
				}
				Dialog_Show(playerid, MDC_ArrestRecord_Add, DIALOG_STYLE_INPUT, sprintf("Tutuklama Kaydù (5 satùrdan %d)", MDC_ArrestRecordCount[playerid]), str_dialog, "ùleri", "Geri Al");
				return 1;
			}

			strcat(MDC_ArrestRecord[playerid][MDC_ArrestRecordCount[playerid]], inputtext);
			strcat(MDC_ArrestRecord[playerid][MDC_ArrestRecordCount[playerid]], "\n");
			MDC_ArrestRecordCount[playerid]+=1;

			strcat(str_dialog, sprintf("{FFFFFF}%s iùin tutuklama kaydù.\nùptal etmek iùin {FF6347}iptal{FFFFFF}, tamamlamak iùin {33AA33}bitir {FFFFFF}yaz.\n", MDC_PlayerLastSearched[playerid]));
			strcat(str_dialog, "\n\n");
			for(new is; is < MDC_ArrestRecordCount[playerid]; is++)
			{
				strcat(str_dialog, MDC_ArrestRecord[playerid][is]);
			}
			Dialog_Show(playerid, MDC_ArrestRecord_Add, DIALOG_STYLE_INPUT, sprintf("Tutuklama Kaydù (5 satùrdan %d)", MDC_ArrestRecordCount[playerid]), str_dialog, "ùleri", "Geri Al");
			return 1;
	}
	else
	{
		MDC_ArrestRecordCount[playerid] -=1;
		format(MDC_ArrestRecord[playerid][MDC_ArrestRecordCount[playerid]], 128, "");

		if(MDC_ArrestRecordCount[playerid] > 0)
		{
			new str_dialog[512];
			strcat(str_dialog, sprintf("{FFFFFF}%s iùin tutuklama kaydù.\nùptal etmek iùin {FF6347}iptal{FFFFFF}, tamamlamak iùin {33AA33}bitir {FFFFFF}yaz.\n", MDC_PlayerLastSearched[playerid]));
			strcat(str_dialog, "\n\n");

			for(new is; is < MDC_ArrestRecordCount[playerid]; is++)
			{
					strcat(str_dialog, MDC_ArrestRecord[playerid][is]);
			}

			Dialog_Show(playerid, MDC_ArrestRecord_Add, DIALOG_STYLE_INPUT, sprintf("Tutuklama Kaydù (5 satùrdan %d)", MDC_ArrestRecordCount[playerid]), str_dialog, "ùleri", "Geri Al");
			return 1;
		}

		for(new is; is < 6; is++)
		{
				format(MDC_ArrestRecord[playerid][is], 128, "");
		}
	}
	return 1;
}

Dialog:MDC_PenalCode_Filter(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;

	if(strlen(inputtext) < 3)
	{
		Dialog_Show(playerid, MDC_PenalCode_Filter, DIALOG_STYLE_INPUT, "Filtre Uygula", "Bulmak istediùiniz ùeyi 3 kelime ile bulamazsùnùz.\nFiltrelemek istediùiniz suùlamanùn bir kùsmùnù girin veya filtreyi sùfùrlamak iùin boù bùrakùn.", "Ara", "Vazgeù");
		return 1;
	}

	
	mysql_format(DBConn, query, sizeof(query), "SELECT penal, id, category, category_name FROM penalcode_list WHERE selectable = 1");
	new Cache:cache = mysql_query(DBConn, query);

	MDC_HideAfterPage(playerid);

	PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][37]);
	PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][36]);
	PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][16]);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][37], -1802201857);
	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][37], -1);

	new searchbox[128];

	PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][37], 0xFFFFFFFF);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][37], 0x232323FF);

	format(searchbox, sizeof(searchbox), "%s", inputtext);
	PlayerTextDrawSetString(playerid, MDC_PenalCode[playerid][37], AdjustTextDrawString(searchbox));
	PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][37]);
	

	new countdown = 0, strtext = 17, lastcategory = -1, penalid = -1;

	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{
		if(countdown > 12)
			return 1;

		new id, penal[128], category;

			cache_get_value_name_int(i, "id", id);
			cache_get_value_name(i, "penal", penal, 128);

			if(strfind(penal, inputtext, true) != -1)
			{

				cache_get_value_name_int(i, "category", category);

				if(category != lastcategory)
				{
					if (countdown + 2 > 15)
						return 1;

					new category_name[128];
					cache_get_value_name(i, "category_name", category_name, 128);

					if(strlen(category_name) > 34)
					{
						format(category_name, sizeof(category_name), "%.33s...", category_name);
					}


					PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][strtext], 0);
					PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][strtext], -1);
					PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][strtext], 0x333333FF);
					PlayerTextDrawSetString(playerid, MDC_PenalCode[playerid][strtext], AdjustTextDrawString(category_name));
					PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][strtext]);
					strtext+=1;
					penalid+=1;
				}

				if(strlen(penal) > 34)
				{
					format(penal, sizeof(penal), "%.33s...", penal);
				}

				PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][strtext], 1);
				PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][strtext], -1802201857);
				PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][strtext], -1);
				PlayerTextDrawSetString(playerid, MDC_PenalCode[playerid][strtext], AdjustTextDrawString(penal));
				PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][strtext]);
				penalid+=1;
				MDC_PenalID[playerid][penalid] = id;

				countdown = countdown + 1;
				strtext+=1;
				lastcategory = category;
		}
	}

	if(countdown == 0)
	{
			format(searchbox, sizeof(searchbox), "Hata: Eslesme bulunamadi.");

			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][37]);
			PlayerTextDrawSetString(playerid, MDC_PenalCode[playerid][37], searchbox);
			PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][37], 0x9E1729FF);
			PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][37], 0xFFFFFFFF);
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][37]);
			return 1;
	}

	cache_delete(cache);
	return 1;
}


Dialog:MDC_AddVehicleBolo_Model(playerid, response, listitem, inputtext[])
{
	if(!response) return 0;


	format(lastBoloModel[playerid], 24, "%s", inputtext);
	// MDC_LookUp_EnterBox
	new dialog[1028], str[1028];
	format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Modeli:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloModel[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FFFFFF}Aracùn plakasù nedir?");
	strcat(dialog, str);

	Dialog_Show(playerid, MDC_AddVehicleBolo_Plate, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
	return 1;
}

Dialog:MDC_AddVehicleBolo_Plate(playerid, response, listitem, inputtext[])
{

	if(!response) return 0;

	format(lastBoloPlate[playerid], 24, "%s", inputtext);
	new dialog[1028], str[1028];
	format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Modeli:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloModel[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Plakasù:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloPlate[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FFFFFF}BOLO ne iùin?");
	strcat(dialog, str);

	Dialog_Show(playerid, MDC_ABolo_Charges, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
	return 1;
}

Dialog:MDC_ABolo_Charges(playerid, response, listitem, inputtext[])
{
	if(!response) return 0;

	if(strlen(inputtext) > 70)
	{
		new dialog[1028], str[1028];
		format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Modeli:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloModel[playerid]);
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Plakasù:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloPlate[playerid]);
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FFFFFF}BOLO ne iùin?");
		strcat(dialog, str);

		format(str, sizeof(str), "\n\n{BF0000}Aùùklama 70 karakteden fazla olamaz.");
		strcat(dialog, str);

		Dialog_Show(playerid, MDC_ABolo_Charges, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
		return 1;
	}

	format(lastBoloCrimes[playerid], 128, "%s", inputtext);
	new dialog[1028], str[1028];
	format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Modeli:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloModel[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Plakasù:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloPlate[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Suùlarù:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloCrimes[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FFFFFF}ARAù BOLO'sunun rapor iùeriùini giriniz. Rapor iùin olayùn tamamùnù yazmalùsùnùz.\nRapor cùmleler halinde eklenir. Cùmle bittiùi zaman {008000}ENTER {FFFFFF}tuùuna basarak alt satùra inin.");
	strcat(dialog, str);

	Dialog_Show(playerid, MDC_AddBolo_Report, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
	return 1;
}

Dialog:MDC_AddBolo_Report(playerid, response, listitem, inputtext[])
{
	if(!response) return 0;

	if(strlen(inputtext) > 70)
	{
		new dialog[1028], str[1028];
		format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Modeli:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloModel[playerid]);
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Plakasù:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloPlate[playerid]);
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Suùlarù:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloCrimes[playerid]);
		strcat(dialog, str);

		format(str, sizeof(str), "\n\n{FFFFFF}ARAù BOLO'sunun rapor iùeriùini giriniz. Rapor iùin olayùn tamamùnù yazmalùsùnùz.\nRapor cùmleler halinde eklenir. Cùmle bittiùi zaman {008000}ENTER {FFFFFF}tuùuna basarak alt satùra inin.\nEùer rapor detaylarù bittiyse BOLO oluùturmak iùin kutucuùa {008000}'bitti' {FFFFFF}yazmanùz yeterli.");
		strcat(dialog, str);

		format(str, sizeof(str), "\n\n{BF0000}Raporun bir cùmlesi 70 harften uzun olamaz.");
		strcat(dialog, str);

		Dialog_Show(playerid, MDC_AddBolo_Report, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
		return 1;
	}

	strcat(lastBoloReportShow[playerid], inputtext);
	strcat(lastBoloReport[playerid], inputtext);

	new dialog[1028], str[1028];
	format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Modeli:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloModel[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Plakasù:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloPlate[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Suùlarù:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloCrimes[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Raporu:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloReportShow[playerid]);
	strcat(dialog, str);

	format(str, sizeof(str), "\n\n{FFFFFF}ARAù BOLO'sunun rapor iùeriùini giriniz. Rapor iùin olayùn tamamùnù yazmalùsùnùz.\nRapor cùmleler halinde eklenir. Cùmle bittiùi zaman {008000}ENTER {FFFFFF}tuùuna basarak alt satùra inin.\nEùer rapor detaylarù bittiyse BOLO oluùturmak iùin kutucuùa {008000}'bitti' {FFFFFF}yazmanùz yeterli.");
	strcat(dialog, str);

	Dialog_Show(playerid, MDC_AddBolo_ReportOrDone, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
	return 1;
}

Dialog:MDC_AddBolo_ReportOrDone(playerid, response, listitem, inputtext[])
{
	if(!response) return 0;

	if(strlen(inputtext) > 70)
	{
		new dialog[1028], str[1028];
		format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Modeli:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloModel[playerid]);
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Plakasù:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloPlate[playerid]);
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Suùlarù:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloCrimes[playerid]);
		strcat(dialog, str);
		format(str, sizeof(str), "\n\n{FF6347}Araù Raporu:");
		strcat(dialog, str);
		format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloReportShow[playerid]);
		strcat(dialog, str);

		format(str, sizeof(str), "\n\n{FFFFFF}ARAù BOLO'sunun rapor iùeriùini giriniz. Rapor iùin olayùn tamamùnù yazmalùsùnùz.\nRapor cùmleler halinde eklenir. Cùmle bittiùi zaman {008000}ENTER {FFFFFF}tuùuna basarak alt satùra inin.\nEùer rapor detaylarù bittiyse BOLO oluùturmak iùin kutucuùa {008000}'bitti' {FFFFFF}yazmanùz yeterli.");
		strcat(dialog, str);

		format(str, sizeof(str), "\n\n{BF0000}Raporun bir cùmlesi 70 harften uzun olamaz.");
		strcat(dialog, str);

		Dialog_Show(playerid, MDC_AddBolo_ReportOrDone, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
		return 1;
	}

	if(strmatch(inputtext, "bitti"))
	{
		SaveBolo(pNome(playerid), lastBoloPlate[playerid], lastBoloModel[playerid], lastBoloCrimes[playerid], lastBoloReport[playerid]);
		Show_VehicleBolos(playerid);

		format(lastBoloModel[playerid], 24, "");
		format(lastBoloPlate[playerid], 24, "");
		format(lastBoloCrimes[playerid], 512, "");
		format(lastBoloReport[playerid], 512, "");
		format(lastBoloReportShow[playerid], 512, "");
		return 1;
	}

	strcat(lastBoloReportShow[playerid], "\n");
	strcat(lastBoloReportShow[playerid], inputtext);

	strcat(lastBoloReport[playerid], "~n~");
	strcat(lastBoloReport[playerid], inputtext);

	new dialog[1028], str[1028];
	format(str, sizeof(str), "{FFFFFF}                   {8D8DFF}Los Santos Police Department{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF}                   {FF8282}BOLO KAYDI{FFFFFF}                   {FFFFFF} {FFFFFF}");
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Modeli:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloModel[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Plakasù:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloPlate[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Suùlarù:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloCrimes[playerid]);
	strcat(dialog, str);
	format(str, sizeof(str), "\n\n{FF6347}Araù Raporu:");
	strcat(dialog, str);
	format(str, sizeof(str), "\n{FFFFFF} {FFFFFF} {FFFFFF} {FFFFFF}%s", lastBoloReportShow[playerid]);
	strcat(dialog, str);

	format(str, sizeof(str), "\n\n{FFFFFF}ARAù BOLO'sunun rapor iùeriùini giriniz. Rapor iùin olayùn tamamùnù yazmalùsùnùz.\nRapor cùmleler halinde eklenir. Cùmle bittiùi zaman {008000}ENTER {FFFFFF}tuùuna basarak alt satùra inin.\nEùer rapor detaylarù bittiyse BOLO oluùturmak iùin kutucuùa {008000}'bitti' {FFFFFF}yazmanùz yeterli.");
	strcat(dialog, str);

	Dialog_Show(playerid, MDC_AddBolo_ReportOrDone, DIALOG_STYLE_INPUT, "BOLO KAYDI", dialog, "Devam", "ùptal Et");
	return 1;
}

Dialog:MDCCall2(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		SetPVarInt(playerid, "lastEmergencyID", 0);
		return 1;
	}

    Dialog_Show(playerid, MDCCallRespond, DIALOG_STYLE_LIST, "{8D8DFF}MDC - ùAùRI BùLGùSù", "- ùaùrùyù ùstlen\n- ùaùrùyù Sil", "Seù", "Geri");
	return 1;
}

Dialog:MDCCallRespond(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		SetPVarInt(playerid, "lastEmergencyID", 0);
		return 1;
	}
	
	if(!listitem)
	{
		new e_id = GetPVarInt(playerid, "lastEmergencyID");

		if(strlen(GetEmergencyStatusName(e_id, "niner_status")) != strlen("Kontrol edilmemiù"))
		{
			SendErrorMessage(playerid, "Bu ùaùrùyù bir baùkasù ùstlenmiù.");
			return 1;
		}
	
		new handle_text[64];
		format(handle_text, sizeof(handle_text), "ùlgilenildi - %s", pNome(playerid));

		if(pInfo[playerid][pCallsign] != -1)
		{
			strcat(handle_text, sprintf("_(%s)", EkipBilgi[pInfo[playerid][pCallsign]][ekipkodu]));
		}

		
		mysql_format(DBConn, query, sizeof(query), "UPDATE niner SET niner_status = '%e' WHERE id = %i", handle_text, e_id);
		mysql_tquery(DBConn, query);

		MDC_HideAfterPage(playerid);
		ShowEmergencyCalls(playerid, GetPVarInt(playerid, "emergencylist_idx"));
		SetPVarInt(playerid, "lastEmergencyID", 0);
		SendClientMessageEx(playerid, COLOR_RADIO, "%d numaralù ùaùrùyù ùstlendiniz.", e_id);

		MDC_HideAfterPage(playerid);
		ShowEmergencyCalls(playerid, GetPVarInt(playerid, "emergencylist_idx"));
	}
	else
	{
		new e_id = GetPVarInt(playerid, "lastEmergencyID");
		
		mysql_format(DBConn, query, sizeof(query), "DELETE FROM niner WHERE id = %i", e_id);
		mysql_tquery(DBConn, query);
		SetPVarInt(playerid, "lastEmergencyID", 0);
		SendClientMessageEx(playerid, COLOR_RADIO, "%d numaralù ùaùrùyù sildiniz.", e_id);

		MDC_HideAfterPage(playerid);
		ShowEmergencyCalls(playerid, GetPVarInt(playerid, "emergencylist_idx"));
	}
	return 1;
}

Dialog:MDC_LookUp_EnterBox(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;

	 if(response)
	{
			new sorgu[144];
			if(GetPVarInt(playerid,"MDC_SearchMode") == 1)
			{
				format(sorgu, sizeof(sorgu), "SELECT * FROM `players` WHERE `Name` = '%s'", inputtext);
				mysql_tquery(DBConn, sorgu, "KisiSorgula", "sdd", inputtext, playerid, 0);
			}

			if(GetPVarInt(playerid,"MDC_SearchMode") == 2)
			{
				if(strfind(inputtext, "id", true) != -1)
				{
					MDC_SearchVehicleWithID(playerid, inputtext);
					return 1;
				}
			format(sorgu, sizeof(sorgu), "SELECT * FROM `vehicles` WHERE `Plate` = '%s'", inputtext);
			mysql_tquery(DBConn, sorgu, "KisiSorgula", "sdd", inputtext, playerid, 1);
			}
	}
  return 1;
}

/*Dialog:DIALOG_ALPRLOG(playerid, response, listitem, inputtext[])
{
	if(!response) return 0;
	if(response)
	{
		cmd_mdc(playerid, " ");
		new id = strval(inputtext);
		MDC_HideAfterPage(playerid);
		ShowMDCPage(playerid, MDC_PAGE_LOOKUP);
		MDC_LOOKUP_SelectOption(playerid, MDC_PAGE_LOOKUP_PLATE);

		new sorgu[256];
		format(sorgu, sizeof(sorgu), "SELECT * FROM `vehicles` WHERE `Plate` = '%s'", 0);
		mysql_tquery(DBConn, sorgu, "KisiSorgula", "sdd", VehicleBolo[id][vBoloPlate], playerid, 1);
	}
	return 1;
}*/