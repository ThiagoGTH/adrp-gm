MembersOnline(playerid) {
    new count = 0;
    foreach(new i : Player)
    {
		if(pInfo[i][pFaction] == pInfo[playerid][pFaction] && pInfo[i][pLAWduty])
		{
			count++;
		}
    }
    return count;
}

RefreshChargeButton(playerid)
{
	SetPVarInt(playerid, "chargeGOV", 0);
	SetPVarInt(playerid, "chargeAAF", 0);
	SetPVarInt(playerid, "chargeSOL", 0);
	SetPVarInt(playerid, "chargeATT", 0);
	SetPVarInt(playerid, "chargeCAC", 0);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][38], -1802201857);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][39], -1802201857);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][40], -1802201857);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][41], -1802201857);
	PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][42], -1802201857);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][42], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][40], 1);
	return 1;
}

MDC_AddCharge(playerid, charge)
{
	new gov = GetPVarInt(playerid, "chargeGOV");
	new aaf = GetPVarInt(playerid, "chargeAAF");
	new att = GetPVarInt(playerid, "chargeATT");
	new sol = GetPVarInt(playerid, "chargeSOL");
	new cac = GetPVarInt(playerid, "chargeCAC");

	
	mysql_format(DBConn, query, sizeof(query), "INSERT INTO player_charges (type, player_dbid, issuer, active, minute, charge_name, charge_id, gov, aaf, att, sol, cac, time) VALUES (1, %d, %d, 1, %d,'%e', %d, %d, %d, %d, %d, %d, %d)", MDC_PlastLastSearched_SQLID[playerid], pInfo[playerid][pID], CalculateChargeTime(playerid, charge), ReturnChargeName(charge), charge, gov, aaf, att, sol, cac, gettime());
	mysql_tquery(DBConn, query);

	MDC_ShowPenalCode(playerid);

	SendFactionMessage(pInfo[playerid][pFaction], COLOR_RADIO, sprintf("** HQ Duyurusu: %s %s, %s adlù kiùi ùzerinde %d dakikalùk suùlamada bulundu. **", Faction_GetRank(playerid), pNome(playerid), MDC_PlayerLastSearched[playerid], CalculateChargeTime(playerid, charge)));
	RefreshChargeButton(playerid);
	return 1;
}

CalculateChargeTime(playerid, charge)
{
	new time = ReturnChargeTime(charge);
	new gov = GetPVarInt(playerid, "chargeGOV");
	new aaf = GetPVarInt(playerid, "chargeAAF");

	if(gov == 1)
	{
		time = time + (time * 66 / 100);
	}
	if(aaf == 1)
	{
		time = time/2;
	}
	return time;
}

ReturnChargeName(id) {
	new penal[64];
	mysql_format(DBConn, query, sizeof(query), "SELECT penal FROM penalcode_list WHERE id = %i", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "penal", penal, sizeof(penal));
	cache_delete(cache);
	return penal;
}

ReturnChargeTime(id)
{
	mysql_format(DBConn, query, sizeof(query), "SELECT minute FROM penalcode_list WHERE id = %i", id);
	new Cache: cache = mysql_query(DBConn, query);

	new charge_time;
	cache_get_value_name_int(0, "minute", charge_time);
	cache_delete(cache);
	return charge_time;
}

ShowVehicleBoloDetails(playerid, i)
{
	new id = MDC_BolosID[playerid][i - 1];
	SetPVarInt(playerid, "boloLastID", id);

	new vbolo_details[256];
	format(vbolo_details, 256, "#%d~n~%s_%s~n~%s~n~%s~n~%s", id, Faction_GetRank(playerid), GetBoloAuthor(id), GetBoloModel(id), GetBoloPlate(id), GetFullDate(GetBoloDate(id)));

	AdjustTextDrawString(vbolo_details);
	PlayerTextDrawSetString(playerid, MDC_VehicleBolo_Details[playerid][3], vbolo_details);

	new vbolo_crimes[256];
	format(vbolo_crimes, 256, "%s", GetBoloCrime(id));
	AdjustTextDrawString(vbolo_crimes);
	PlayerTextDrawSetString(playerid, MDC_VehicleBolo_Details[playerid][4], vbolo_crimes);

	new vbolo_report[256];
	format(vbolo_report, 256, "%s", GetBoloReport(id));
	AdjustTextDrawString(vbolo_report);
	PlayerTextDrawSetString(playerid, MDC_VehicleBolo_Details[playerid][5], vbolo_report);

	for(new is = 0; is < 6; is++) {
		PlayerTextDrawShow(playerid, MDC_VehicleBolo_Details[playerid][is]);
	}
	return 1;
}

GetBoloReport(id) {
	new n_text[256];
	mysql_format(DBConn, query, sizeof(query), "SELECT report FROM vehicle_bolos WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "report", n_text);
	cache_delete(cache);
	return n_text;
}

GetBoloCrime(id)
{
	new n_text[256];
	mysql_format(DBConn, query, sizeof(query), "SELECT crimes FROM vehicle_bolos WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "crimes", n_text);
	cache_delete(cache);
	return n_text;
}

GetBoloPlate(id)
{
	new n_text[32];
	mysql_format(DBConn, query, sizeof(query), "SELECT plate FROM vehicle_bolos WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "plate", n_text);
	cache_delete(cache);
	return n_text;
}

GetBoloModel(id)
{
	new n_text[64];
	mysql_format(DBConn, query, sizeof(query), "SELECT model FROM vehicle_bolos WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "model", n_text);
	cache_delete(cache);
	return n_text;
}

GetBoloDate(id)
{
	new n_time;
	mysql_format(DBConn, query, sizeof(query), "SELECT time FROM vehicle_bolos WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name_int(0, "time", n_time);
	cache_delete(cache);
	return n_time;
}

GetBoloAuthor(id)
{
	new n_text[24];
	mysql_format(DBConn, query, sizeof(query), "SELECT author FROM vehicle_bolos WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "author", n_text);
	cache_delete(cache);
	return n_text;
}

CreateArrestRecord(playerid) {
	new str_entry[5 * 128];

	for(new is; is < MDC_ArrestRecordCount[playerid]; is++)
	{
			strcat(str_entry, MDC_ArrestRecord[playerid][is]);
			format(MDC_ArrestRecord[playerid][is], 128, "");
	}

	MDC_ArrestRecordCount[playerid] = 0;

	mysql_format(DBConn, query, sizeof(query), "INSERT INTO player_arrest (by_id, player_id, reason, time, active) VALUES (%d, %d, '%e', %i, %i)", pInfo[playerid][pID], MDC_PlastLastSearched_SQLID[playerid], str_entry, gettime(), 1);
	mysql_tquery(DBConn, query);
	return 1;
}

SaveBolo(author[], plate[], model[], crimes[], report[]) {
	
	mysql_format(DBConn, query, sizeof(query), "INSERT INTO vehicle_bolos (author, plate, model, crimes, report, time) VALUES ('%e', '%e', '%e', '%e', '%e', %i)", author, plate, model, crimes, report, gettime());
	mysql_tquery(DBConn, query);
	return 1;
}

ShowMDCPage(playerid, page) {
	PlayerTextDrawSetString(playerid, MDC_Main[playerid][7], sprintf("%s", MDC_GetPageName(playerid, page)));
    MDC_SideMenuColours(playerid, page);
	MDC_HideAfterPage(playerid);

    PlayerTextDrawSetString(playerid, MDC_Main[playerid][8], pNome(playerid));

    for(new is; is < 18; is++) {
        PlayerTextDrawShow(playerid, MDC_Main[playerid][is]);
    }

    switch(page)
    {
        case MDC_PAGE_MAIN:
        {
			PlayerTextDrawSetPreviewModel(playerid, MDC_MainScreen[playerid][0], pInfo[playerid][pSkin]);
			PlayerTextDrawSetString(playerid, MDC_MainScreen[playerid][3], sprintf("%s_%s", Faction_GetRank(playerid), pNome(playerid)));

			new warrants_count;

			foreach(new i : Player) {
				if(pInfo[i][pActiveListing] == 1) warrants_count++;
			}

			PlayerTextDrawSetString(playerid, MDC_MainScreen[playerid][7], sprintf("%d %d", MembersOnline(playerid), warrants_count));
			PlayerTextDrawSetString(playerid, MDC_MainScreen[playerid][6], sprintf("%d %d %d",TotalWarants, TotalJailees, TotalFines));

      		for(new is; is < 8; is++){
                PlayerTextDrawShow(playerid, MDC_MainScreen[playerid][is]);
            }
        }

        case MDC_PAGE_LOOKUP:
        {
					   for(new is; is < 4; is++)
					     {
					        PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][is]);
							PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][17]);
					    }
        }

				case MDC_PAGE_WARRANTS:
				{
					for(new is; is < 24; is++)
					{
					   	PlayerTextDrawShow(playerid, MDC_Warrants[playerid][is]);
					}
				}

				case MDC_PAGE_EMERGENCY:
				{

					ShowEmergencyCalls(playerid);
				}

				case MDC_PAGE_ROSTER:
				{
					//Show_Roster(playerid);
				}


				case MDC_PAGE_CCTV:
				{
					//ShowCCTV_List(playerid);
				}


				case MDC_PAGE_VEHICLEBOLO:
				{
					Show_VehicleBolos(playerid);
				}
    }

    return 1;
}

Show_CriminalData(playerid, page = 0)
{
	SetPVarInt(playerid, "criminaldatalist_idx", page);

	mysql_format(DBConn, query, sizeof(query), "SELECT id, type, time, charge_name, gov, aaf, att, sol, cac FROM player_charges WHERE player_dbid = %i ORDER BY time DESC LIMIT %i, 21", MDC_PlastLastSearched_SQLID[playerid], page*MAX_CRIMINALDATA_SHOW);
	mysql_tquery(DBConn, query, "SQL_ListCriminal", "ii", playerid, page);
	return 1;
}

SQL_ListCriminal(playerid, page)
{
	MDC_HideAfterPage(playerid);

	if(!cache_num_rows())
	{
			MDC_ReturnLastSearch(playerid);
			SendErrorMessage(playerid, "Bu kiùinin sabùka kaydùnda hiùbir ùey yok.");
			return 1;
	}

	if(page < 0)
		return 1;

	PlayerTextDrawShow(playerid, MDC_CrimeHistory[playerid][23]);

	// MDC_CrimeHistory[playerid][21]
	new strtext = 1, countdown = 0;
	new type, time, charge_name[256];

	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{

		new rows = cache_num_rows();

		if(rows > MAX_CRIMINALDATA_SHOW)
		{
			PlayerTextDrawShow(playerid, MDC_CrimeHistory[playerid][21]);
			PlayerTextDrawShow(playerid, MDC_CrimeHistory[playerid][22]);
		}

		if(page == 0)
		{
				PlayerTextDrawHide(playerid, MDC_CrimeHistory[playerid][22]);
			}

		if(page != 0)
		{
				PlayerTextDrawShow(playerid, MDC_CrimeHistory[playerid][22]);
		}

		if(strtext > 20)
			return 1;


		cache_get_value_name_int(i, "id", MDC_CriminalDataID[playerid][countdown]);
		cache_get_value_name_int(i, "type", type);
		cache_get_value_name_int(i, "time", time);


		if(type == 1)
		{
			new gov, aaf, att, sol, cac;
			cache_get_value_name_int(i, "gov", gov);
			cache_get_value_name_int(i, "aaf", aaf);
			cache_get_value_name_int(i, "att", att);
			cache_get_value_name_int(i, "sol", sol);
			cache_get_value_name_int(i, "cac", cac);

			new sub_charge[256];
			cache_get_value_name(i, "charge_name", sub_charge, 256);

			format(charge_name, sizeof(charge_name), "%s__%s", GetFullDate(time), sub_charge);

			if(gov == 1)
			{
				strcat(charge_name, " / Gov. Calisani");
			}

			if(aaf == 1)
			{
				strcat(charge_name, " / Yardim Yataklik");
			}

			if(att == 1)
			{
				strcat(charge_name, " / Teùebbùs");
			}

			if(sol == 1)
			{
				strcat(charge_name, " / Azmettirme");
			}

			if(cac == 1)
			{
				strcat(charge_name, " / Suc Ortakligi");
			}
		}

		if(type == 1)
		{
			PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][strtext], 0xFFFFFFFF);
			PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][strtext], 0x656565FF);
		}

		if(type == 2)
		{
			format(charge_name, sizeof(charge_name), "%s__Hapis");
			PlayerTextDrawBoxColour(playerid, MDC_CrimeHistory[playerid][strtext], 0xAA2124FF);
			PlayerTextDrawColour(playerid, MDC_CrimeHistory[playerid][strtext], 0xBAC1CAFF);
		}

		if(strlen(charge_name) > 80)
		{
			format(charge_name, sizeof(charge_name), "%.79s...", charge_name);
		}

		PlayerTextDrawSetString(playerid, MDC_CrimeHistory[playerid][strtext], AdjustTextDrawString(charge_name));
		PlayerTextDrawShow(playerid, MDC_CrimeHistory[playerid][strtext]);
		strtext+=1;
		countdown+=1;
	}

	return 1;
}

Show_CriminalDataDetail(playerid, criminal)
{
	PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][4]);

	
	mysql_format(DBConn, query, sizeof(query), "SELECT type, player_dbid, time, issuer, charge_name, gov, aaf, att, sol, cac, prison_record FROM player_charges WHERE id = %i", criminal);
	new Cache: cache = mysql_query(DBConn, query);

	new type;
	new str_detail[512];
	cache_get_value_name_int(0, "type", type); // MDC_SelectedCrimeDetails[playerid][2]

	if(type == 1) // Islem_No~n~Isim~n~Uygulayan~n~Tarih~n~Tur
	{
		new gov, aaf, att, sol, cac;
		new db, issuer, charge_name[128], time;

		cache_get_value_name_int(0, "player_dbid", db);
		cache_get_value_name_int(0, "issuer", issuer);
		cache_get_value_name_int(0, "time", time);
		cache_get_value_name_int(0, "gov", gov);
		cache_get_value_name_int(0, "aaf", aaf);
		cache_get_value_name_int(0, "att", att);
		cache_get_value_name_int(0, "sol", sol);
		cache_get_value_name_int(0, "cac", cac);

		cache_get_value_name(0, "charge_name", charge_name);

		if(gov == 1)
		{
			strcat(charge_name, " / GOV");
		}

		if(aaf == 1)
		{
			strcat(charge_name, " / AAF");
		}

		if(att == 1)
		{
			strcat(charge_name, " / ATT");
		}

		if(sol == 1)
		{
			strcat(charge_name, " / SOL");
		}

		if(cac == 1)
		{
			strcat(charge_name, " / CAC");
		}

		strcat(str_detail, sprintf("#00%d~n~", criminal));
		strcat(str_detail, sprintf("%s~n~", SQLName(db)));
		strcat(str_detail, sprintf("%s~n~", SQLName(issuer)));
		strcat(str_detail, sprintf("%s~n~Normal", GetFullDate(time)));

		AdjustTextDrawString(charge_name);
		AdjustTextDrawString(str_detail);
		PlayerTextDrawSetString(playerid, MDC_SelectedCrimeDetails[playerid][3], charge_name);
		PlayerTextDrawSetString(playerid, MDC_SelectedCrimeDetails[playerid][2], str_detail);

		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][0]);
		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][1]);
		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][3]);
		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][2]);
	}
	if(type == 2)
	{
		new db, issuer, charge_name[512], time, prison_record[1028];
		cache_get_value_name_int(0, "player_dbid", db);
		cache_get_value_name_int(0, "issuer", issuer);
		cache_get_value_name_int(0, "time", time);
		cache_get_value_name(0, "charge_name", charge_name);
		cache_get_value_name(0, "prison_record", prison_record);
		SetPVarString(playerid, "lastPrisonRecord", prison_record);

		strcat(str_detail, sprintf("#00%d~n~", criminal));
		strcat(str_detail, sprintf("%s~n~", SQLName(db)));
		strcat(str_detail, sprintf("%s~n~", SQLName(issuer)));
		strcat(str_detail, sprintf("%s~n~~r~Hapis", GetFullDate(time)));

		AdjustTextDrawString(charge_name);
		AdjustTextDrawString(str_detail);
		PlayerTextDrawSetString(playerid, MDC_SelectedCrimeDetails[playerid][3], charge_name);
		PlayerTextDrawSetString(playerid, MDC_SelectedCrimeDetails[playerid][2], str_detail);

		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][0]);
		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][1]);
		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][3]);
		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][2]);
		PlayerTextDrawShow(playerid, MDC_SelectedCrimeDetails[playerid][5]);
	}
	cache_delete(cache);
	return 1;
}

/*Show_Roster(playerid, page = 0)
{
	MDC_HideAfterPage(playerid);

	SetPVarInt(playerid, "rosterlist_idx", page);

	new count = 0, f = GetPatrolID(playerid);

	for(new i = 0; i != MAX_PATROL; i++)
	{
			if (!PatrolInfo[f][i][patrulExists])                    continue;

			new unit_name[256], unit_players[128];
			format(unit_name, sizeof(unit_name), "%s", PatrolInfo[f][i][patrulName]);

			new patrol1 = PatrolInfo[f][i][patrulOfficer][0];
			new patrol2 = PatrolInfo[f][i][patrulOfficer][1];

			new p_count;
			if(patrol1 != INVALID_PLAYER_ID && pLoggedIn[patrol1] == true)
			{
				strcat(unit_players, sprintf("%s", ReturnLastName(patrol1)));
				p_count = p_count + 1;
			}

			if(patrol2 != INVALID_PLAYER_ID && pLoggedIn[patrol2] == true)
			{
				if(p_count != 0) strcat(unit_players, ",_");
				strcat(unit_players, sprintf("%s", ReturnLastName(patrol2)));
			}

			PlayerTextDrawSetString(playerid, MDC_Roster[playerid][count], AdjustTextDrawString(unit_name));
			PlayerTextDrawShow(playerid, MDC_Roster[playerid][count]);
			count = count + 1;
			PlayerTextDrawSetString(playerid, MDC_Roster[playerid][count], AdjustTextDrawString(unit_players));
			PlayerTextDrawShow(playerid, MDC_Roster[playerid][count]);
			count = count + 1;
	}

	if (!count)
	{
			PlayerTextDrawSetString(playerid, MDC_Roster[playerid][0], "_Su anda aktif devriye yok..");
			PlayerTextDrawShow(playerid, MDC_Roster[playerid][0]);
	}

	
	mysql_format(DBConn, query, sizeof(query), "SELECT unit, unit_players FROM roster_list LIMIT %i, 20", page*MAX_ROSTER_SHOW);
	mysql_tquery(DBConn, query, "SQL_RosterList", "ii", playerid, page);
	return 1;
}

SQL_RosterList(playerid, page) // 38 geri, 39 ileri
{
	// MDC_Roster[playerid][17]

	new countdown = 0, strtext = 0;
	new unit[256];
	new player_string[256];

	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{
			new rows = cache_num_rows();

			if(rows > MAX_ROSTER_SHOW)
			{
				PlayerTextDrawShow(playerid, MDC_Roster[playerid][38]);
				PlayerTextDrawShow(playerid, MDC_Roster[playerid][39]);
			}

			if(page == 0)
				{
					PlayerTextDrawHide(playerid, MDC_Roster[playerid][38]);
				}

			if(page != 0)
			{
					PlayerTextDrawShow(playerid, MDC_Roster[playerid][38]);
			}

				cache_get_value_name(i, "unit", unit, 256);
				cache_get_value_name(i, "unit_players", player_string, 256);

				if(strtext < 37)
				{
					PlayerTextDrawSetString(playerid, MDC_Roster[playerid][strtext], AdjustTextDrawString(unit));
					PlayerTextDrawShow(playerid, MDC_Roster[playerid][strtext]);
					strtext+=1;

					PlayerTextDrawSetString(playerid, MDC_Roster[playerid][strtext], AdjustTextDrawString(player_string));
					PlayerTextDrawShow(playerid, MDC_Roster[playerid][strtext]);
					strtext+=1;
				}
				countdown+=1;
	}

	if(countdown == 0)
	{
		PlayerTextDrawSetString(playerid, MDC_Roster[playerid][0], AdjustTextDrawString("Liste boù."));
		PlayerTextDrawShow(playerid, MDC_Roster[playerid][strtext]);
	}
	return 1;
}
*/

Show_VehicleBolos(playerid, page = 0)
{
	if(page < 0)
		return 1;

	SetPVarInt(playerid, "vbololist_idx", page);
	MDC_HideAfterPage(playerid);

	PlayerTextDrawShow(playerid, MDC_VehicleBolo_List[playerid][0]);

	
	mysql_format(DBConn, query, sizeof(query), "SELECT id, author, plate, model, crimes, report, time FROM vehicle_bolos ORDER BY time DESC LIMIT %i, 21", page*MAX_BOLO_SHOW);
	mysql_tquery(DBConn, query, "SQL_VehicleBolos", "ii", playerid, page);
	return 1;
}

SQL_VehicleBolos(playerid, page)
{
	new countdown = 0, strtext = 1;
	new plate[24], model[64];
	new bolo_string[256];


	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{
			new rows = cache_num_rows();

			if(rows > MAX_BOLO_SHOW)
			{
				PlayerTextDrawShow(playerid, MDC_VehicleBolo_List[playerid][22]);
				PlayerTextDrawShow(playerid, MDC_VehicleBolo_List[playerid][21]);
			}

			if(page == 0)
				{
					PlayerTextDrawHide(playerid, MDC_VehicleBolo_List[playerid][21]);
				}

			if(page != 0)
				{
					PlayerTextDrawShow(playerid, MDC_VehicleBolo_List[playerid][21]);
				}

			if(countdown > 20)
				return 1;

			cache_get_value_name_int(i, "id", MDC_BolosID[playerid][countdown]);
			cache_get_value_name(i, "plate", plate, 24);
			cache_get_value_name(i, "model", model, 64);

			if(strtext == 20)
				return 1;

			format(bolo_string, sizeof(bolo_string), "%s, %s", plate, model);
			AdjustTextDrawString(bolo_string);
			PlayerTextDrawSetString(playerid, MDC_VehicleBolo_List[playerid][strtext], bolo_string);
			PlayerTextDrawShow(playerid, MDC_VehicleBolo_List[playerid][strtext]);

			countdown++;
			strtext+=1;
	}

	return 1;
}

/*ShowCCTV_List(playerid)
{
	new
		countdown = 0, sub[90];

	PlayerTextDrawSetString(playerid, MDC_CCTV[playerid][16], "CCTV LISTESI");
	PlayerTextDrawShow(playerid, MDC_CCTV[playerid][16]);

	foreach(new i : Cameras)
	{
		if(countdown > 13)
		{
			PlayerTextDrawShow(playerid, MDC_CCTV[playerid][14]);
			PlayerTextDrawShow(playerid, MDC_CCTV[playerid][15]);
			return 1;
		}

		format(sub, sizeof(sub), "%s_-[%s]~n~", CameraData[i][CameraName], GetStreet(CameraData[i][CameraLocation][0], CameraData[i][CameraLocation][1], CameraData[i][CameraLocation][2]));
		PlayerTextDrawSetString(playerid, MDC_CCTV[playerid][countdown], sub);
		PlayerTextDrawShow(playerid, MDC_CCTV[playerid][countdown]);
		Player_CCTVPage[playerid] = 1;
		countdown++;
	}
	return 1;
}*/

/*GetNinerCaller(id)
{
	new niner_caller[32];
	mysql_format(DBConn, query, sizeof(query), "SELECT niner_by FROM niner WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "niner_by", niner_caller);
	cache_delete(cache);
	return niner_caller;
}

GetNinerCallerNumber(id)
{
	new number;
	mysql_format(DBConn, query, sizeof(query), "SELECT niner_number FROM niner WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name_int(0, "niner_number", number);
	cache_delete(cache);
	return number;
}

GetNinerDate(id)
{
	new n_time;
	mysql_format(DBConn, query, sizeof(query), "SELECT niner_time FROM niner WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name_int(0, "niner_time", n_time);
	cache_delete(cache);
	return n_time;
}

GetNinerLocation(id)
{
	new n_text[32];
	mysql_format(DBConn, query, sizeof(query), "SELECT niner_location FROM niner WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "niner_location", n_text);
	cache_delete(cache);
	return n_text;
}

GetNinerText(id)
{
	new n_text[256];
	mysql_format(DBConn, query, sizeof(query), "SELECT niner_text FROM niner WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "niner_text", n_text);
	cache_delete(cache);
	return n_text;
}

GetNinerStatus(id)
{
	new n_text[256];
	mysql_format(DBConn, query, sizeof(query), "SELECT niner_status FROM niner WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "niner_status", n_text);
	cache_delete(cache);
	return n_text;
}*/

HandleEmergency(playerid, PlayerText:tid)
{
	new e_id = -1;
	switch (tid)
	{
		case 187: e_id = MDC_CallsID[playerid][0];
		case 192: e_id = MDC_CallsID[playerid][1];
		case 197: e_id = MDC_CallsID[playerid][2];
		case 202: e_id = MDC_CallsID[playerid][3];
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
	return 1;
}

/*ShowEmergencyCallDetail(playerid, PlayerText:tid)
{
	new e_id = -1;

	switch (tid)
	{
		case 197: e_id = MDC_CallsID[playerid][0];
		case 202: e_id = MDC_CallsID[playerid][1];
		case 207: e_id = MDC_CallsID[playerid][2];
		case 212: e_id = MDC_CallsID[playerid][3];
	}

	new e_details1[256];
	format(e_details1, sizeof(e_details1), "%s~n~%d~n~%s~n~~n~%s", GetNinerCaller(e_id), GetNinerCallerNumber(e_id), GetFullDate(GetNinerDate(e_id)), GetNinerStatus(e_id));

	new niner_text[128];
	format(niner_text, sizeof(niner_text), "%s",GetNinerText(e_id));

	new e_details2[256];
	format(e_details2, sizeof(e_details2), "Los_Santos_Police_Department~n~~n~~n~~n~%s~n~~n~~n~~n~_%.72s~n~%s", GetNinerLocation(e_id), niner_text, niner_text[72]);

	PlayerTextDrawSetString(playerid, MDC_EmergencyDetails[playerid][0], sprintf("Cagri_#%d~n~~n~~n~Arayan:~n~TelefonNo:~n~Tarih:~n~~n~Durum:~n~", e_id));
	PlayerTextDrawSetString(playerid, MDC_EmergencyDetails[playerid][2], FixPenalCodeWord(e_details1));
	PlayerTextDrawSetString(playerid, MDC_EmergencyDetails[playerid][3], FixPenalCodeWord(e_details2));

	for(new is = 0; is < 5; is++)
	{
		PlayerTextDrawShow(playerid, MDC_EmergencyDetails[playerid][is]);
	}

	return 1;
}*/

ShowEmergencyCallDetail(playerid, PlayerText:tid)
{
	new e_id = -1;

	switch (tid)
	{
		case 188: e_id = MDC_CallsID[playerid][0];
		case 193: e_id = MDC_CallsID[playerid][1];
		case 198: e_id = MDC_CallsID[playerid][2];
		case 203: e_id = MDC_CallsID[playerid][3];
	}

	new mes[512];

    format(mes, sizeof(mes), "{B4B5B7}911-ùAùRI BùLGùSù - #%i\n\n\
	Arayan:\t\t%s\n\
	Telefon Numarasù:\t%i\n\
	Vaka:\t\t%s\n\
	Lokasyon:\t%s\n\
	Tarih:\t\t\t%s\n\n\
	Durum:\t\t\t%s", GetEmergencyStatusInt(e_id, "id"), GetEmergencyStatusName(e_id, "niner_by"), GetEmergencyStatusInt(e_id, "niner_number"), GetEmergencyStatusName(e_id, "niner_text"), GetEmergencyStatusName(e_id, "niner_location"), GetFullDate(GetEmergencyStatusInt(e_id, "niner_time")), GetEmergencyStatusName(e_id, "niner_status"));
    
	SetPVarInt(playerid, "lastEmergencyID", e_id);
    Dialog_Show(playerid, MDCCall2, DIALOG_STYLE_MSGBOX, "{8D8DFF}MDC - ùAùRI BùLGùSù", mes, "Seùenekler", "Geri");
	return 1;
}



ShowEmergencyCalls(playerid, page = 0)
{
	if(page < 0)
		return 1;

	MDC_HideAfterPage(playerid);

	SetPVarInt(playerid, "emergencylist_idx", page);

	
	mysql_format(DBConn, query, sizeof(query), "SELECT id, niner_by, niner_number, niner_location, niner_text, niner_status, niner_time FROM niner ORDER BY niner_time DESC LIMIT %i, 5", page*MAX_EMERGENCY_SHOW);
	mysql_tquery(DBConn, query, "SQL_EmergencyCalls", "ii", playerid, page);
	return 1;
}

SQL_EmergencyCalls(playerid, page)
{
	new strtext = 2;
	new countdown = 0;
	new n_name[25];
	new n_number;
	new niner_location[33];
	new niner_text[256];
	new niner_status[64];
	new niner_time;
	new n_list_string[256];


	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{
			new rows = cache_num_rows();
			if(rows > MAX_EMERGENCY_SHOW)
			{
				PlayerTextDrawShow(playerid, MDC_Emergency[playerid][20]);
				PlayerTextDrawShow(playerid, MDC_Emergency[playerid][21]);
			}

			if(page == 0)
				{
					PlayerTextDrawHide(playerid, MDC_Emergency[playerid][21]);
				}

			if(page != 0)
				{
					PlayerTextDrawShow(playerid, MDC_Emergency[playerid][21]);
				}

			if(countdown == 4)
				return 1;

			cache_get_value_name_int(i, "id", MDC_CallsID[playerid][countdown]);
			cache_get_value_name_int(i, "niner_number", n_number);
			cache_get_value_name(i, "niner_by", n_name, 25);
			cache_get_value_name(i, "niner_location", niner_location, 33);
			cache_get_value_name(i, "niner_text", niner_text, 256);
			cache_get_value_name(i, "niner_status", niner_status, 64);
			cache_get_value_name_int(i, "niner_time", niner_time);

			 AdjustTextDrawString(niner_status);
			format(n_list_string, sizeof(n_list_string), "#%d_%s~n~%s~n~%s~n~%.21s...~n~%s~n~%s", n_number, n_name, n_name, niner_location, niner_text, GetFullDate(niner_time), niner_status);

			PlayerTextDrawSetString(playerid, MDC_Emergency[playerid][strtext], FixPenalCodeWord(n_list_string));
			PlayerTextDrawShow(playerid, MDC_Emergency[playerid][strtext-1]);
			PlayerTextDrawShow(playerid, MDC_Emergency[playerid][strtext-2]);
			PlayerTextDrawShow(playerid, MDC_Emergency[playerid][strtext]);
			PlayerTextDrawShow(playerid, MDC_Emergency[playerid][strtext+2]);


			if(strlen(niner_status) == strlen("Kontrol edilmemiù"))
			{
				PlayerTextDrawShow(playerid, MDC_Emergency[playerid][strtext+1]);
			}

			countdown = countdown + 1;
			strtext = strtext + 5;
	}

	// 21 geri tuùu
	return 1;
}

MDC_LOOKUP_SelectOption(playerid, option)
{
	for(new i = 0; i < 2; i++)
	{
			PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][i], 0xAAAAAAFF);
			PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][i], 0x333333FF);
			PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][17], 0xAAAAAAFF);
			PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][17], 0x333333FF);
	}

	switch(option)
	{
		case MDC_PAGE_LOOKUP_NAME:
		{
			PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][0]);
			PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][0], 0x333333FF);
			PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][0], 0xAAAAAAFF);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][0]);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][1]);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][17]);
			SetPVarInt(playerid, "MDC_SearchMode", 1);
		}
		case MDC_PAGE_LOOKUP_PLATE:
		{
			PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][1]);
			PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][1], 0x333333FF);
			PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][1], 0xAAAAAAFF);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][1]);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][0]);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][17]);
			SetPVarInt(playerid, "MDC_SearchMode", 2);
		}
		case MDC_PAGE_LOOKUP_BUILDING:
		{
			PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][17]);
			PlayerTextDrawBoxColour(playerid, MDC_LookUp_Name[playerid][17], 0x333333FF);
			PlayerTextDrawColour(playerid, MDC_LookUp_Name[playerid][17], 0xAAAAAAFF);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][1]);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][0]);
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][17]);
			SetPVarInt(playerid, "MDC_SearchMode", 3);
		}
	}
	return 1;
}

MDC_SideMenuColours(playerid, page)
{
    for(new i = 10; i < 18; i++)
    {
        PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][i], 0xAAAAAAFF);
		PlayerTextDrawColour(playerid, MDC_Main[playerid][i], 0x333333FF);
    }

    switch(page)
    {
        case MDC_PAGE_MAIN:
		{
			PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][10], 0x333333FF);
			PlayerTextDrawColour(playerid, MDC_Main[playerid][10], 0xAAAAAAFF);
		}
        case MDC_PAGE_LOOKUP:
		{
			PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][11], 0x333333FF);
			PlayerTextDrawColour(playerid, MDC_Main[playerid][11], 0xAAAAAAFF);
		}
		/*case MDC_PAGE_WARRANTS:
		{
			PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][12], 0x333333FF);
			PlayerTextDrawColour(playerid, MDC_Main[playerid][12], 0xAAAAAAFF);
		}*/
				case MDC_PAGE_EMERGENCY:
				{
				PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][13], 0x333333FF);
				PlayerTextDrawColour(playerid, MDC_Main[playerid][13], 0xAAAAAAFF);
				}
				case MDC_PAGE_ROSTER:
				{
				PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][14], 0x333333FF);
				PlayerTextDrawColour(playerid, MDC_Main[playerid][14], 0xAAAAAAFF);
				}
				case MDC_PAGE_CCTV:
				{
				PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][15], 0x333333FF);
				PlayerTextDrawColour(playerid, MDC_Main[playerid][15], 0xAAAAAAFF);
				}
				case MDC_PAGE_VEHICLEBOLO:
				{
				PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][16], 0x333333FF);
				PlayerTextDrawColour(playerid, MDC_Main[playerid][16], 0xAAAAAAFF);
				}
    }

    return 1;
}

MDC_GetPageName(playerid, page)
{
	new factionstats;
	new factionid = pInfo[playerid][pFaction];

	if(strfind(FactionData[factionid][FactionName], "Los Santos Sheriff Department", true) != -1)
	{
		factionstats = 2;
		PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][1], 324608767);
	}
	else
	{
		factionstats = 1;
		PlayerTextDrawBoxColour(playerid, MDC_Main[playerid][1], 203444479);
	}

	new pagename[128];
	switch(page)
	{
		case MDC_PAGE_MAIN: format(pagename, 128, sprintf("%s", factionstats != 2 ? ("Los Santos Police Department") : ("Los Santos Sheriff Department")));
		case MDC_PAGE_LOOKUP: format(pagename, 128, sprintf("%s_~>~_Sorgula", factionstats != 2 ? ("POLICE") : ("SHERIFF")));
		case MDC_PAGE_WARRANTS: format(pagename, 128, sprintf("%s_~>~_Aranmalar", factionstats != 2 ? ("POLICE") : ("SHERIFF")));
		case MDC_PAGE_EMERGENCY: format(pagename, 128, sprintf("%s_~>~_Cagrilar", factionstats != 2 ? ("POLICE") : ("SHERIFF")));
		case MDC_PAGE_ROSTER: format(pagename, 128, sprintf("%s_~>~_Liste", factionstats != 2 ? ("POLICE") : ("SHERIFF")));
		case MDC_PAGE_DATABASE: format(pagename, 128, sprintf("%s_~>~_Veritabani", factionstats != 2 ? ("POLICE") : ("SHERIFF")));
		case MDC_PAGE_CCTV: format(pagename, 128, sprintf("%s_~>~_CCTV", factionstats != 2 ? ("POLICE") : ("SHERIFF")));
		case MDC_PAGE_STAFF: format(pagename, 128, sprintf("%s_~>~_Yetkili", factionstats != 2 ? ("POLICE") : ("SHERIFF")));
		case MDC_PAGE_VEHICLEBOLO: format(pagename, 128, sprintf("%s_~>~_ARAC_BOLOLARI", factionstats != 2 ? ("POLICE") : ("SHERIFF")));
	}
	return pagename;
}

GetCrimeMinute(chargeid)
{
	new minute;
	mysql_format(DBConn, query, sizeof(query), "SELECT minute FROM penalcode WHERE id = %i LIMIT 1", chargeid);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name_int(0, "minute", minute);
	cache_delete(cache);
	return minute;
}

GetCategoryName(category)
{
	new detail[256];
	mysql_format(DBConn, query, sizeof(query), "SELECT category_name FROM penalcode_category WHERE id = %i LIMIT 1", category);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "category_name", detail);
	cache_delete(cache);
	return detail;
}

GetCrimeName(chargeid)
{
	new detail[256];
	mysql_format(DBConn, query, sizeof(query), "SELECT crime FROM penalcode WHERE id = %i LIMIT 1", chargeid);
	new Cache: cache = mysql_query(DBConn, query);
	cache_get_value_name(0, "crime", detail);
	cache_delete(cache);
	return detail;
}

MDC_ShowAddress(playerid, playerdbid, page = 0)
{
	if(page < 0)
		return 1;

	MDC_HideAfterPage(playerid);

	SetPVarInt(playerid, "showadresslist_idx", page);

	
	mysql_format(DBConn, query, sizeof(query), "SELECT * FROM properties WHERE OwnerSQL = %d LIMIT %i, 4", playerdbid, page*MAX_ADRESSLIST_SHOW);
	mysql_tquery(DBConn, query, "SQL_ShowAddress", "iii", playerid, playerdbid, page);
	return 1;
}

SQL_ShowAddress(playerid, playerdbid, page)
{

	new Float:houseX, Float:houseY, Float:houseZ;
	new id, textdrawstr = 5;
	new countdown = 0;

	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{
		countdown = countdown + 1;

		if(textdrawstr > 7)
			return 1;

		cache_get_value_name_int(i, "id", id);
		cache_get_value_name_float(i, "ExteriorX", houseX);
		cache_get_value_name_float(i, "ExteriorY", houseY);
		cache_get_value_name_float(i, "ExteriorZ", houseZ);

		SetPVarFloat(playerid, sprintf("ShowAddressID%d_X", countdown), houseX);
		SetPVarFloat(playerid, sprintf("ShowAddressID%d_Y", countdown), houseY);

		if(countdown == 1)
		{
			PlayerTextDrawSetString(playerid, MDC_AdressDetails[playerid][2], sprintf("%i_%s~n~%s~n~%s_%d~n~San_Andreas", id, GetStreet(houseX, houseY, houseZ), GetZoneName(houseX, houseY, houseZ), GetCityName(houseX, houseY, houseZ), ReturnAreaCode(GetZoneID(houseX, houseY, houseZ))));
			SetAddresMapPosition(playerid, GetPVarFloat(playerid, "ShowAddressID1_X"), GetPVarFloat(playerid, "ShowAddressID1_Y"));
		}

		PlayerTextDrawSetString(playerid, MDC_AdressDetails[playerid][textdrawstr], sprintf("-__%s_%i", GetStreet(houseX, houseY, houseZ), id));
		PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][textdrawstr]);

		textdrawstr = textdrawstr + 1;
	}


	if(countdown > 1)
	{
		PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][4]);
	}

	/*if(countdown > 4)
	{
		PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][10]);
	}

	if(page != 0)
	{
		PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][11]);
	}*/

	PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][0]);
	PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][1]);
	PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][2]);
	return 1;
}

MDC_SelectCharges(playerid, chargeid)
{
	for(new is = 38; is < 47; is++)
	{
		PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][is]);
	}

	for(new is = 38; is < 47; is++)
	{
		PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][is]);
	}

	SetPVarInt(playerid, "chargeTime", ReturnChargeTime(chargeid));
	EditChargeDescription(playerid, chargeid);
	return 1;
}

EditChargeDescription(playerid, chargeid)
{
	new charge_desc[1028];

	PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][45]);

	if(ReturnChargeFine(chargeid) == 0)
	{
		new sub_str[256];

		if(GetPVarInt(playerid, "chargeTime") > 4000)
		{
			format(sub_str, sizeof(sub_str), "%s, Mùebbet hapis cezasùyla cezalandùrùlan bir suù.", ReturnChargeName(chargeid));
		}
		else
		{
			format(sub_str, sizeof(sub_str), "%s, %d dakika hapis cezasùyla cezalandùrùlan bir suù.", ReturnChargeName(chargeid), GetPVarInt(playerid, "chargeTime"));
		}

		if(strlen(sub_str) > 55)
		{
			new sub_str2[256];
			strcat(sub_str2, sprintf("%.54s~n~", sub_str));
			strcat(sub_str2, sprintf("%s", sub_str[54]));
			strcat(charge_desc, sub_str2);
		}
		else
		{
			strcat(charge_desc, sub_str);
		}
	}
	else
	{
		new sub_str[256];
		format(sub_str, sizeof(sub_str), "%s, $%s para cezasùyla cezalandùrùlan bir suù.", ReturnChargeName(chargeid), MoneyFormat(GetPVarInt(playerid, "chargeTime")));

		if(strlen(sub_str) > 55)
		{
			new sub_str2[256];
			strcat(sub_str2, sprintf("%.54s~n~", sub_str));
			strcat(sub_str2, sprintf("%s", sub_str[54]));
			strcat(charge_desc, sub_str2);
		}
		else
		{
			strcat(charge_desc, sub_str);
		}
		PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][46]);
	}

	strcat(charge_desc, "~n~~n~~n~");
	strcat(charge_desc, ReturnChargeDescription(chargeid));

	PlayerTextDrawSetString(playerid, MDC_PenalCode[playerid][45], FixChargeDescription(charge_desc));
	PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][45]);
	return 1;
}

ReturnChargeFine(id)
{
	
	mysql_format(DBConn, query, sizeof(query), "SELECT type_fine FROM penalcode_list WHERE id = %i", id);
	new Cache: cache = mysql_query(DBConn, query);
	new charge_time;
	cache_get_value_name_int(0, "type_fine", charge_time);
	cache_delete(cache);
	return charge_time;
}

GetEmergencyStatusInt(id, text[])
{
	
	mysql_format(DBConn, query, sizeof(query), "SELECT %s FROM niner WHERE id = %i", text, id);
	new Cache: cache = mysql_query(DBConn, query);
	new text2;
	cache_get_value_name_int(0, text, text2);
	cache_delete(cache);
	return text2;
}

GetEmergencyStatusName(id, text[])
{
	
	mysql_format(DBConn, query, sizeof(query), "SELECT %s FROM niner WHERE id = %i", text, id);
	new Cache: cache = mysql_query(DBConn, query);
	new text2[256];
	cache_get_value_name(0, text, text2);
	cache_delete(cache);
	return text2;
}

ReturnChargeDescription(id)
{
    new player_name[1028];
    mysql_format(DBConn, query, sizeof(query), "SELECT penal_desc FROM penalcode_list WHERE id = %i LIMIT 1", id);
    new Cache: cache = mysql_query(DBConn, query);
    if(!cache_num_rows()) player_name = "Yok";
    else cache_get_value_name(0, "penal_desc", player_name);
    cache_delete(cache);
    return player_name;
}

MDC_ShowPenalCode(playerid, page = 0)
{
	if(page < 0)
		return 1;

	MDC_HideAfterPage(playerid);

	SetPVarInt(playerid, "penalcodelist_idx", page);

	
	mysql_format(DBConn, query, sizeof(query), "SELECT id, penal, color, bgcolor, selectable FROM penalcode_list LIMIT %i, 20", page*MAX_PENAL_SHOW);
	mysql_tquery(DBConn, query, "SQL_PenalCode", "ii", playerid, page);
	return 1;
}

SQL_PenalCode(playerid, page)
{
	// MDC_PenalCode
	new id, penal[256], color, bgcolor, selectable, strtext = 17;

	PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][16]);
	PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][36]);
	PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][37]);

	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{
		new rows = cache_num_rows();

		if(rows > MAX_PENAL_SHOW)
		{
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][48]);
		}

		if(page == 0)
		{
			PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][47]);
		}

		if(page != 0)
		{
			PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][47]);
		}

		if(strtext > 35)
			return 1;

		cache_get_value_name_int(i, "id", id);
		cache_get_value_name_int(i, "color", color);
		cache_get_value_name_int(i, "bgcolor", bgcolor);
		cache_get_value_name_int(i, "selectable", selectable);
		cache_get_value_name(i, "penal", penal, 256);

		MDC_PenalID[playerid][i] = id;

		if(strlen(penal) > 34)
		{
			format(penal, sizeof(penal), "%.33s...", penal);
		}

		PlayerTextDrawSetSelectable(playerid, MDC_PenalCode[playerid][strtext], selectable);
		PlayerTextDrawColour(playerid, MDC_PenalCode[playerid][strtext], color);
		PlayerTextDrawBoxColour(playerid, MDC_PenalCode[playerid][strtext], bgcolor);
		AdjustTextDrawString(penal);
		PlayerTextDrawSetString(playerid, MDC_PenalCode[playerid][strtext], penal);
		PlayerTextDrawShow(playerid, MDC_PenalCode[playerid][strtext]);
		strtext+=1;
	}
	return 1;
}

MDC_ShowManageLicense(playerdbid, playerid)
{
	MDC_HideAfterPage(playerid);

	foreach(new players : Player)
	{
		if(pInfo[players][pID] == playerdbid)
		{
			PlayerTextDrawSetString(playerid, MDC_ManageLicense[playerid][5], sprintf("%s~n~%d", (pInfo[players][pDriversLicense] != true) ? ("Mevcut_Degil") : ("Mevcut"), pInfo[players][DriversLicenseWarning]));
			PlayerTextDrawSetString(playerid, MDC_ManageLicense[playerid][19], sprintf("%s", (pInfo[players][pWeaponsLicense] != true) ? ("Mevcut_Degil") : ("Mevcut")));
			PlayerTextDrawSetString(playerid, MDC_ManageLicense[playerid][13], sprintf("%s", (pInfo[players][pMedicalLicense] != true) ? ("Mevcut_Degil") : ("Mevcut")));

			for(new is; is < 34; is++)
			{
				PlayerTextDrawShow(playerid, MDC_ManageLicense[playerid][is]);
			}
			return 1;
		}
	}

	new query_properties[128];
	mysql_format(DBConn, query_properties, sizeof(query_properties), "SELECT * FROM players WHERE id = %i", playerdbid);

	new DriverLicenses, WeaponsLicenses, DriverWarning, licensewarning, driverlicensesus, MedicalLicense;
	if(cache_num_rows())
	{
		cache_get_value_name_int(0, "DriversLicense", DriverLicenses);
		cache_get_value_name_int(0, "DriversLicenseWarning", DriverWarning);

		cache_get_value_name_int(0, "WeaponsLicense", WeaponsLicenses);
		cache_get_value_name_int(0, "DriversLicenseWarning", licensewarning);
		cache_get_value_name_int(0, "DriversLicenseSuspend", driverlicensesus);
		cache_get_value_name_int(0, "MedicalLicense", MedicalLicense);
	}

	PlayerTextDrawSetString(playerid, MDC_ManageLicense[playerid][5], sprintf("%s~n~%d", (DriverLicenses != 1) ? ("Mevcut_Degil") : ("Mevcut"), licensewarning));
	PlayerTextDrawSetString(playerid, MDC_ManageLicense[playerid][19], sprintf("%s", (WeaponsLicenses != 1) ? ("Mevcut_Degil") : ("Mevcut")));
	PlayerTextDrawSetString(playerid, MDC_ManageLicense[playerid][13], sprintf("%s", (MedicalLicense != 1) ? ("Mevcut_Degil") : ("Mevcut")));

	for(new is; is < 34; is++)
	{
		PlayerTextDrawShow(playerid, MDC_ManageLicense[playerid][is]);
	}
	return 1;
}


forward MDC_SearchVehicleWithID(playerid, text[]); public MDC_SearchVehicleWithID(playerid, text[])
{
	new text2[2][12];
	split(text, text2, ':');
	new vehid = strval(text2[1]);

	if(!IsValidVehicle(vehid))
	{
		Dialog_Show(playerid, MDC_LookUp_EnterBox, DIALOG_STYLE_INPUT, "Veri Girin", "HATA: Bu ID'ye ait bir araù bulunamadù.\n\nKimi arùyorsunuz?\nPlaka aramasùysa direkt olarak plakayù gir.\nAraù ID ùzerindense, 'id:ARAùID' ùeklinde girmelisin (ùrn: id:120)", "Ara", "Vazgeù");
		return 1;
	}

	for(new i = 0; i < sizeof dmv_vehicles; i++) if(vehid == dmv_vehicles[i])
	{
		Dialog_Show(playerid, MDC_LookUp_EnterBox, DIALOG_STYLE_INPUT, "Veri Girin", "HATA: Bu ID'ye ait bir araù bulunamadù.\n\nKimi arùyorsunuz?\nPlaka aramasùysa direkt olarak plakayù gir.\nAraù ID ùzerindense, 'id:ARAùID' ùeklinde girmelisin (ùrn: id:120)", "Ara", "Vazgeù");
		return 1;
	}

	if(vehid < 12)
	{
		Dialog_Show(playerid, MDC_LookUp_EnterBox, DIALOG_STYLE_INPUT, "Veri Girin", "HATA: Bu ID'ye ait bir araù bulunamadù.\n\nKimi arùyorsunuz?\nPlaka aramasùysa direkt olarak plakayù gir.\nAraù ID ùzerindense, 'id:ARAùID' ùeklinde girmelisin (ùrn: id:120)", "Ara", "Vazgeù");
		return 1;
	}

	for(new is = 4; is < 18; is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][is]);
		PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][17]);
	}

	Hide_PageAttachement(playerid);

	PlayerTextDrawSetString(playerid, MDC_LookUp_Name[playerid][4], sprintf("id:%d", vehid)); // aranma boùluùunun metni elleme
	PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][4]);

	PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Vehicle[playerid][0], CarData[vehid][carModel]); // veritabanùndan araù modeli ùek mustafa
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_LookUp_Vehicle[playerid][0], CarData[vehid][carColor1], CarData[vehid][carColor2]); // burda ise veritabanùndan aracùn rengi
	PlayerTextDrawShow(playerid, MDC_LookUp_Vehicle[playerid][0]);
	PlayerTextDrawShow(playerid, MDC_LookUp_Vehicle[playerid][5]);

	new vehicle_details[72];
	format(vehicle_details, sizeof(vehicle_details), "%s~n~%s~n~%s~n~~r~Level_%d~n~%s", ReturnVehicleModelName(GetVehicleModel(vehid)), CarData[vehid][carPlates], SQLName(CarData[vehid][carOwnerID]), CarData[vehid][carInsurance], CarData[vehid][carImpounded] != 1 ? ("~l~Hayir") : ("~r~Evet"));
	PlayerTextDrawSetString(playerid, MDC_LookUp_Vehicle[playerid][10], vehicle_details);
	PlayerTextDrawShow(playerid, MDC_LookUp_Vehicle[playerid][10]);
	return 1;
}

forward KisiSorgula(text[], playerid, secenek); public KisiSorgula(text[], playerid, secenek)
{
	new rows, fields;
	cache_get_row_count(rows);
	cache_get_field_count(fields);
	if(!rows)
	{
		switch(secenek)
		{
			case 0:
				Dialog_Show(playerid, MDC_LookUp_EnterBox, DIALOG_STYLE_INPUT, "Veri Girin", "HATA: Bu isimle kayùtlù vatandaù bulunamadù.\n\nKimi arùyorsunuz?", "Ara", "Vazgeù");

			case 1:
			{

					Dialog_Show(playerid, MDC_LookUp_EnterBox, DIALOG_STYLE_INPUT, "Veri Girin", "HATA: Bu plakayla kayùtlù araù bulunamadù.\n\nKimi arùyorsunuz?\nPlaka aramasùysa direkt olarak plakayù gir.\nAraù ID ùzerindense, 'id:ARAùID' ùeklinde girmelisin (ùrn: id:120)", "Ara", "Vazgeù");
			}
		}
		return true;
	}

	format(MDC_PlayerLastSearched[playerid], 24, text);
	for(new is = 4; is < 18; is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][is]);
		PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][17]);
	}

	Hide_PageAttachement(playerid);

	PlayerTextDrawSetString(playerid, MDC_LookUp_Name[playerid][4], text); // aranma boùluùunun metni elleme
	PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][4]);

	switch(GetPVarInt(playerid,"MDC_SearchMode"))
	{
		case 1:
		{
			new Skin;
			new Name[24];
			new playerNumber;
			new JailTimes;
			new playerdbid;

			cache_get_value_name_int(0, "id", playerdbid);
			cache_get_value_name_int(0, "Skin", Skin);
			cache_get_value_name(0, "Name", Name);
			cache_get_value_name_int(0, "PhoneNumber", playerNumber);

			cache_get_value_name_int(0, "JailTimes", JailTimes);

			new
				primary[600], sub[128];

			format(sub, sizeof(sub), "%s~n~", Name);
			strcat(primary, sub);

			format(sub, sizeof(sub), "%d~n~", playerNumber);
			strcat(primary, sub);


			if(JailTimes != 0)
			{
				format(sub, sizeof(sub), "%d_kere_hapis~n~", JailTimes);
				strcat(primary, sub);
			}else
			{
				format(sub, sizeof(sub), "Yok~n~");
				strcat(primary, sub);
			}

			new count = 0, licenses[32], dl, wl, ml;
			cache_get_value_name_int(0, "DriversLicense", dl);
			cache_get_value_name_int(0, "WeaponsLicense", wl);
			cache_get_value_name_int(0, "MedicalLicense", ml);
			if (dl == 1)
			{
						count++;
					format(licenses, sizeof(licenses), "Surucu");
			}

			if (wl == 1)
			{
						if (count > 0) format(licenses, sizeof(licenses), "%s,_", licenses);
					format(licenses, sizeof(licenses), "%sSilah", licenses);
						count++;
			}

			if (ml == 1)
			{
						if (count > 0) format(licenses, sizeof(licenses), "%s,_", licenses);
					format(licenses, sizeof(licenses), "%sMedikal", licenses);
						count++;
			}

			strcat(primary, licenses);


			format(sub, sizeof(sub), "~n~%s", AdjustTextDrawString(GetPlayerAdressList(playerdbid)));
			strcat(primary, sub);

			PlayerTextDrawSetString(playerid, MDC_LookUp_Name[playerid][8], primary);

			PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Name[playerid][5], Skin); // burada ùekilen skin database skin ile deùiùecek

			format(MDC_PlayerLastSearched[playerid], 24, "%s", Name);
			MDC_PlastLastSearched_SQLID[playerid] = playerdbid;

			
			mysql_format(DBConn, query, sizeof(query), "SELECT gov, aaf, att, sol, cac, active, type, charge_name FROM player_charges WHERE player_dbid = %d AND active = 1 AND type = 1 ORDER BY time DESC LIMIT 5", MDC_PlastLastSearched_SQLID[playerid]);
			mysql_tquery(DBConn, query, "SQL_CriminalPreview", "i", playerid);

			for(new is = 4; is < 18; is++)
			{
				PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][is]);
			}

			PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][9]);

			if(GetPlayerAdress(playerdbid) == 1)
			{
				PlayerTextDrawSetString(playerid, MDC_LookUp_Name[playerid][9], "]_Bu_Oyuncu_Eve_Sahip,_Listelemek_icin_tiklayin");
				PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][9]);
			}

			if(GetPlayerAdress(playerdbid) > 1)
			{
				PlayerTextDrawSetString(playerid,  MDC_LookUp_Name[playerid][9], "]_Bu_Oyuncu_Birden_Fazla_Adrese_Sahip,_Listelemek_icin_tiklayin");
				PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][9]);
			}

		}
		case 2:
		{

			new vModel, vColor1, vColor2, carPlate[24], ownerid, carInsur, carimpound;

			cache_get_value_name_int(0, "ModelID", vModel);
			cache_get_value_name_int(0, "Color1", vColor1);
			cache_get_value_name_int(0, "Color2", vColor2);
			cache_get_value_name(0, "Plate", carPlate, 24);
			cache_get_value_name_int(0, "OwnerID", ownerid);
			cache_get_value_name_int(0, "Insurance", carInsur);
			cache_get_value_name_int(0, "Impounded", carimpound);

			PlayerTextDrawSetString(playerid, MDC_LookUp_Name[playerid][4], carPlate); // aranma boùluùunun metni elleme
			PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][4]);


			PlayerTextDrawSetPreviewModel(playerid, MDC_LookUp_Vehicle[playerid][0], vModel); // veritabanùndan araù modeli ùek mustafa
			PlayerTextDrawSetPreviewVehCol(playerid, MDC_LookUp_Vehicle[playerid][0], vColor1, vColor2); // burda ise veritabanùndan aracùn rengi
			PlayerTextDrawShow(playerid, MDC_LookUp_Vehicle[playerid][0]);
			PlayerTextDrawShow(playerid, MDC_LookUp_Vehicle[playerid][5]);

			new vehicle_details[72];
			format(vehicle_details, sizeof(vehicle_details), "%s~n~%s~n~%s~n~~r~Level_%d~n~%s", ReturnVehicleModelName(vModel),  carPlate, SQLName(ownerid), carInsur, (carimpound != 1) ? ("~l~HAYIR") : ("~r~Evet"));
			PlayerTextDrawSetString(playerid, MDC_LookUp_Vehicle[playerid][10], vehicle_details);
			PlayerTextDrawShow(playerid, MDC_LookUp_Vehicle[playerid][10]);
		}
	}
	return 1;
}

SQL_CriminalPreview(playerid)
{
	new records[512], charge_name[128], gov, aaf, att, sol, cac;

	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{
		cache_get_value_name_int(i, "gov", gov);
		cache_get_value_name_int(i, "aaf", aaf);
		cache_get_value_name_int(i, "att", att);
		cache_get_value_name_int(i, "sol", sol);
		cache_get_value_name_int(i, "cac", cac);
		cache_get_value_name(i, "charge_name", charge_name, 128);


		if(gov == 1)
		{
			strcat(charge_name, " / GOV");
		}

		if(aaf == 1)
		{
			strcat(charge_name, " / AAF");
		}

		if(att == 1)
		{
			strcat(charge_name, " / ATT");
		}

		if(sol == 1)
		{
			strcat(charge_name, " / SOL");
		}

		if(cac == 1)
		{
			strcat(charge_name, " / CAC");
		}

		if(strlen(charge_name) > 45)
		{
			format(charge_name, sizeof(charge_name), "- %.44s...", charge_name);
		}
		else
		{
			format(charge_name, sizeof(charge_name), "- %s", charge_name);
		}

		strcat(records, charge_name);
		strcat(records, "~n~");
	}

	if(!cache_num_rows())
	{
		strcat(records, sprintf("Bu kiùinin ùzerinde aktif suùlama yok."));
	}

	AdjustTextDrawString(records);
	PlayerTextDrawSetString(playerid, MDC_LookUp_Name[playerid][14], records);
	PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][14]);
}

GetPlayerAdress(playerdbid)
{
	new countdown = 0;

		new query_properties[128];
		mysql_format(DBConn, query_properties, sizeof(query_properties), "SELECT * FROM properties WHERE OwnerSQL = %i", playerdbid);
		new Cache:cache = mysql_query(DBConn, query_properties);

		if(!cache_num_rows())
		{
			cache_delete(cache);
		}
		else
		{
			for(new i = 0; i < cache_num_rows(); i++)
			{
				countdown+= 1;
			}
			cache_delete(cache);
			return countdown;
		}
	return countdown;
}

GetPlayerAdressList(playerdbid)
{
	new str[256];

		new query_properties[128], gethouseadress[1287];
		mysql_format(DBConn, query_properties, sizeof(query_properties), "SELECT * FROM properties WHERE OwnerSQL = %i", playerdbid);
		new Cache:cache = mysql_query(DBConn, query_properties);

		if(!cache_num_rows())
		{
			format(gethouseadress, sizeof(gethouseadress), "Yok");
		}
		else
		{
			new Float:houseX, Float:houseY, Float:houseZ;
			cache_get_value_name_float(0, "ExteriorX", houseX);
			cache_get_value_name_float(0, "ExteriorY", houseY);
			cache_get_value_name_float(0, "ExteriorZ", houseZ);

			format(str, sizeof(str), "%s~n~%s~n~%s_%i", GetStreet(houseX, houseY, houseZ), GetZoneName(houseX, houseY, houseZ), GetCityName(houseX, houseY, houseZ), ReturnAreaCode(GetZoneID(houseX, houseY, houseZ)));
		}
	cache_delete(cache);
	return str;
}

MDC_LookUp_Refresh(playerid)
{
	for(new is = 0; is < 17; is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Vehicle[playerid][is]);
	}


	for(new is = 4; is < 18;is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][is]);
		PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][17]);
	}

	for(new is = 0; is < 49; is++)
	{
		PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][is]);
	}

	for(new is = 0; is < 34; is++)
	{
		PlayerTextDrawHide(playerid, MDC_ManageLicense[playerid][is]);
	}
	return 1;
}

MDC_Hide(playerid)
{
	for(new is; is < 18; is++)
	{
		PlayerTextDrawHide(playerid, MDC_Main[playerid][is]);
	}

	for(new is; is < 23; is++)
	{
		PlayerTextDrawHide(playerid, MDC_VehicleBolo_List[playerid][is]);
	}

	for(new is; is < 6; is++)
	{
		PlayerTextDrawHide(playerid, MDC_VehicleBolo_Details[playerid][is]);
	}

	for(new is; is < 8; is++)
	{
		PlayerTextDrawHide(playerid, MDC_MainScreen[playerid][is]);
	}

	for(new is; is < 18; is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][is]);
	}


	for(new is; is < 17; is++)
	{
		PlayerTextDrawHide(playerid, MDC_CCTV[playerid][is]);
	}

	for(new is = 0; is < 17; is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Vehicle[playerid][is]);
	}

	for(new is = 0; is < 14; is++)
	{
		PlayerTextDrawHide(playerid, MDC_AdressDetails[playerid][is]);
	}

	for(new is = 0; is < 34; is++)
	{
		PlayerTextDrawHide(playerid, MDC_ManageLicense[playerid][is]);
	}

	for(new is = 0; is < 5; is++)
	{
	 	PlayerTextDrawHide(playerid, MDC_EmergencyDetails[playerid][is]);
	}

	for(new is = 0; is < 49; is++)
	{
		PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][is]);
	}

	for(new is; is < 24; is++)
	{
		PlayerTextDrawHide(playerid, MDC_Emergency[playerid][is]);
	}

	for(new is; is < 24; is++)
	{
		PlayerTextDrawHide(playerid, MDC_Warrants[playerid][is]);
	}

	for(new is; is < 40; is++)
	{
		PlayerTextDrawHide(playerid, MDC_Roster[playerid][is]);
	}

	for(new is = 0; is < 24; is++)
	{
	 	PlayerTextDrawHide(playerid, MDC_CrimeHistory[playerid][is]);
	}

	for(new is = 0; is < 6; is++)
	{
	 	PlayerTextDrawHide(playerid, MDC_SelectedCrimeDetails[playerid][is]);
	}


	SetPVarInt(playerid, "MDC_SearchMode", 0);
	CancelSelectTextDraw(playerid);
	return 1;
}

MDC_ReturnLastSearch(playerid)
{
	PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][0]);
	PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][1]);
	PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][2]);
	PlayerTextDrawShow(playerid, MDC_LookUp_Name[playerid][3]);

	new sorgu[256];
	format(sorgu, sizeof(sorgu), "SELECT * FROM `players` WHERE `Name` = '%s'", MDC_PlayerLastSearched[playerid]);
	mysql_tquery(DBConn, sorgu, "KisiSorgula", "sdd", MDC_PlayerLastSearched[playerid], playerid, 0);
	return 1;
}

MDC_HideAfterPage(playerid)
{
	for(new is; is < 8; is++)
	{
		PlayerTextDrawHide(playerid, MDC_MainScreen[playerid][is]);
	}

	for(new is; is < 5; is++)
	{
		PlayerTextDrawHide(playerid, MDC_CriminalRecordDetail[playerid][is]);
	}

	for(new is; is < 21; is++)
	{
		PlayerTextDrawHide(playerid, MDC_CriminalRecords[playerid][is]);
	}

	for(new is; is < 8; is++)
	{
		PlayerTextDrawHide(playerid, MDC_MainScreen[playerid][is]);
	}

	for(new is; is < 6; is++)
	{
		PlayerTextDrawHide(playerid, MDC_VehicleBolo_Details[playerid][is]);
	}

	for(new is; is < 23; is++)
	{
		PlayerTextDrawHide(playerid, MDC_VehicleBolo_List[playerid][is]);
	}

	for(new is; is < 18; is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Name[playerid][is]);
	}

	for(new is = 0; is < 17; is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Vehicle[playerid][is]);
	}

	for(new is = 0; is < 24; is++)
	{
	 	PlayerTextDrawHide(playerid, MDC_CrimeHistory[playerid][is]);
	}

	for(new is = 0; is < 6; is++)
	{
	 	PlayerTextDrawHide(playerid, MDC_SelectedCrimeDetails[playerid][is]);
	}

	for(new is = 0; is < 14; is++)
	{
		PlayerTextDrawHide(playerid, MDC_AdressDetails[playerid][is]);
	}

	for(new is; is < 17; is++)
	{
		PlayerTextDrawHide(playerid, MDC_CCTV[playerid][is]);
	}

	for(new is = 0; is < 34; is++)
	{
		PlayerTextDrawHide(playerid, MDC_ManageLicense[playerid][is]);
	}

	for(new is = 0; is < 49; is++)
	{
		PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][is]);
	}

	for(new is; is < 24; is++)
	{
		PlayerTextDrawHide(playerid, MDC_Emergency[playerid][is]);
	}
	for(new is; is < 24; is++)
	{
		PlayerTextDrawHide(playerid, MDC_Warrants[playerid][is]);
	}

	for(new is; is < 40; is++)
	{
		PlayerTextDrawHide(playerid, MDC_Roster[playerid][is]);
	}
	for(new is = 0; is < 5; is++)
	{
	 		PlayerTextDrawHide(playerid, MDC_EmergencyDetails[playerid][is]);
	}
}



SetAddresMapPosition(playerid, Float:X, Float:Y)
{
	PlayerTextDrawDestroy(playerid, MDC_AdressDetails[playerid][13]);

	new
			Float:map_kY = -0.04595376,
			Float:map_kX = 0.0469,

			Float:map_sX = 333.999420,
			Float:map_sY = 299.8809,

			Float:corX, Float:corY;

	if(X > 0.000)
	{
		PlayerTextDrawSetString(playerid, MDC_AdressDetails[playerid][3], "samaps:gtasamapbit2");
		PlayerTextDrawSetString(playerid, MDC_AdressDetails[playerid][12], "samaps:gtasamapbit4");

		map_kX = 0.0425;
		map_sX = 369.800;

		corX = X * map_kX + map_sX;
		corY = Y * map_kY + map_sY;
	}
	else
	{
		PlayerTextDrawSetString(playerid, MDC_AdressDetails[playerid][3], "samaps:gtasamapbit1");
		PlayerTextDrawSetString(playerid, MDC_AdressDetails[playerid][12], "samaps:gtasamapbit3");

		map_kX = -0.0425;
		map_sX = 495.2644;

		corX = map_sX - X * map_kX;
		corY = Y * map_kY + map_sY;
	}

	PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][3]);
	PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][12]);

	MDC_AdressDetails[playerid][13] = CreatePlayerTextDraw(playerid, corX, corY, "hud:radar_propertyG");
	PlayerTextDrawTextSize(playerid, MDC_AdressDetails[playerid][13], 7.000000, 7.000000);
	PlayerTextDrawFont(playerid, MDC_AdressDetails[playerid][13], 4);

	PlayerTextDrawShow(playerid, MDC_AdressDetails[playerid][13]);
	return 1;
}

Hide_PageAttachement(playerid)
{
	for(new is = 0; is < 49; is++)
	{
		PlayerTextDrawHide(playerid, MDC_PenalCode[playerid][is]);
	}

	for(new is = 0; is < 17; is++)
	{
		PlayerTextDrawHide(playerid, MDC_LookUp_Vehicle[playerid][is]);
	}

	for(new is = 0; is < 34; is++)
	{
		PlayerTextDrawHide(playerid, MDC_ManageLicense[playerid][is]);
	}

	for(new is = 0; is < 34; is++)
	{
		PlayerTextDrawHide(playerid, MDC_ManageLicense[playerid][is]);
	}

	for(new is = 0; is < 23; is++)
	{
		PlayerTextDrawHide(playerid, MDC_VehicleBolo_List[playerid][is]);
	}

	for(new is = 0; is < 6; is++)
	{
		PlayerTextDrawHide(playerid, MDC_VehicleBolo_Details[playerid][is]);
	}
	return 1;
}