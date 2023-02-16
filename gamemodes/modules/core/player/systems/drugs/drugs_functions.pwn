GetClosestPlant(playerid, Float: range = 1.5) {
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Plants) {
	    tempdist = GetPlayerDistanceFromPoint(playerid, PlantData[i][plantX], PlantData[i][plantY], PlantData[i][plantZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

GetClosestDealer(playerid, Float: range = 2.0) {
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Dealers) {
	    tempdist = GetPlayerDistanceFromPoint(playerid, DealerData[i][dealerX], DealerData[i][dealerY], DealerData[i][dealerZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

Player_PlantCount(playerid) {
	new count = 0, name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	foreach(new i : Plants) if(!strcmp(PlantData[i][plantedBy], name, true)) count++;
	return count;
}

ShowDrugStats(playerid)
{
	new dialog[350];
	format(
		dialog,
		sizeof(dialog),
		"Drugs\t%s grams\n\
		Seeds\t%s\n\
		Used Drugs\t%s grams\n\
		Planted Drugs\t%s\n\
		Harvested Plants\t%s (%s grams)\n\
		Drugs Given\t%s grams\n\
		Drugs Received\t%s grams\n\
		Drugs Bought\t%s grams {2ECC71}(%s)\n\
		Drugs Sold\t%s grams {2ECC71}(%s)\n\
		{FF0000}Reset Stats",
		formatInt(PlayerDrugData[playerid][Drugs], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][Seeds], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalUsed], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalPlanted], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalHarvestedPlants], .iCurrencyChar = '\0'), formatInt(PlayerDrugData[playerid][TotalHarvestedGrams], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalGiven], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalReceived], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalBought], .iCurrencyChar = '\0'), formatInt(PlayerDrugData[playerid][TotalBoughtPrice]),
		formatInt(PlayerDrugData[playerid][TotalSold], .iCurrencyChar = '\0'), formatInt(PlayerDrugData[playerid][TotalSoldPrice])
	);
	
	ShowPlayerDialog(playerid, DIALOG_DRUG_STATS, DIALOG_STYLE_TABLIST, "Drug Stats", dialog, "Choose", "Close");
	return 1;
}

Player_Init(playerid) {
	new emptydata[E_PLAYER];
	PlayerDrugData[playerid] = emptydata;
	PlayerDrugData[playerid][DrugsOfferedBy] = INVALID_PLAYER_ID;
	RegenTimer[playerid] = EffectTimer[playerid] = -1;
	
	// load player
	new drugs, seeds, totalused, totalplanted, harvested[2], given, received, bought[2], sold[2];
	stmt_bind_value(LoadPlayer, 0, DB::TYPE_STRING, Player_GetName(playerid));
	stmt_bind_result_field(LoadPlayer, 0, DB::TYPE_INTEGER, drugs);
	stmt_bind_result_field(LoadPlayer, 1, DB::TYPE_INTEGER, seeds);
	stmt_bind_result_field(LoadPlayer, 2, DB::TYPE_INTEGER, totalused);
	stmt_bind_result_field(LoadPlayer, 3, DB::TYPE_INTEGER, totalplanted);
	stmt_bind_result_field(LoadPlayer, 4, DB::TYPE_INTEGER, harvested[0]);
    stmt_bind_result_field(LoadPlayer, 5, DB::TYPE_INTEGER, harvested[1]);
    stmt_bind_result_field(LoadPlayer, 6, DB::TYPE_INTEGER, given);
    stmt_bind_result_field(LoadPlayer, 7, DB::TYPE_INTEGER, received);
    stmt_bind_result_field(LoadPlayer, 8, DB::TYPE_INTEGER, bought[0]);
    stmt_bind_result_field(LoadPlayer, 9, DB::TYPE_INTEGER, bought[1]);
    stmt_bind_result_field(LoadPlayer, 10, DB::TYPE_INTEGER, sold[0]);
    stmt_bind_result_field(LoadPlayer, 11, DB::TYPE_INTEGER, sold[1]);
    
	if(stmt_execute(LoadPlayer))
	{
	    if(stmt_rows_left(LoadPlayer) > 0) {
	        stmt_fetch_row(LoadPlayer);

	        PlayerDrugData[playerid][Drugs] = drugs;
	        PlayerDrugData[playerid][Seeds] = seeds;
	        PlayerDrugData[playerid][TotalUsed] = totalused;
	        PlayerDrugData[playerid][TotalPlanted] = totalplanted;
	        PlayerDrugData[playerid][TotalHarvestedPlants] = harvested[0];
	        PlayerDrugData[playerid][TotalHarvestedGrams] = harvested[1];
	        PlayerDrugData[playerid][TotalGiven] = given;
	        PlayerDrugData[playerid][TotalReceived] = received;
	        PlayerDrugData[playerid][TotalBought] = bought[0];
	        PlayerDrugData[playerid][TotalBoughtPrice] = bought[1];
	        PlayerDrugData[playerid][TotalSold] = sold[0];
	        PlayerDrugData[playerid][TotalSoldPrice] = sold[1];
	    }else{
	        stmt_bind_value(InsertPlayer, 0, DB::TYPE_STRING, Player_GetName(playerid));
	        stmt_execute(InsertPlayer);
	    }
	}
	
	return true;
}