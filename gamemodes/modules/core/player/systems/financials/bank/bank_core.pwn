#include <YSI_Coding\y_hooks>

hook OnGameModeInit(){

    for(new i; i < MAX_BANKERS; i++) {
        BankerData[i][bankerActorID] = -1;

        #if defined BANKER_USE_MAPICON
        BankerData[i][bankerIconID] = -1;
        #endif

        BankerData[i][bankerLabel] = Text3D: -1;
    }

    for(new i; i < MAX_ATMS; i++) {
        ATMData[i][atmObjID] = -1;

        ATMData[i][atmLabel] = Text3D: -1;
    }

    mysql_tquery(DBConn, "SELECT * FROM bankers", "LoadBankers");
	mysql_tquery(DBConn, "SELECT * FROM bank_atms", "LoadATMs");
    return true;
}

hook OnFilterScriptExit() {
	foreach(new i : Bankers) {
	    if(IsValidActor(BankerData[i][bankerActorID])) DestroyActor(BankerData[i][bankerActorID]);
	}
	return true;
}

hook OnPlayerConnect(playerid) {
	CurrentAccountID[playerid] = -1;
	LogListType[playerid] = TYPE_NONE;
	LogListPage[playerid] = 0;

	EditingATMID[playerid] = -1;
	return true;
}