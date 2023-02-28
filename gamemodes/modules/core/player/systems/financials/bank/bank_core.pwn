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

    mysql_tquery(DBConn, "SELECT * FROM bankers WHERE (`ID` != '0');", "LoadBankers");
	mysql_tquery(DBConn, "SELECT * FROM bank_atms WHERE (`ID` != '0');", "LoadATMs");
    return true;
}

hook OnGameModeExit() {
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

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	if(Iter_Contains(ATMs, EditingATMID[playerid])) {
	    if(response == 1) {
	        new id = EditingATMID[playerid];
	        ATMData[id][atmX] = x;
	        ATMData[id][atmY] = y;
	        ATMData[id][atmZ] = z;
	        ATMData[id][atmRX] = rx;
	        ATMData[id][atmRY] = ry;
	        ATMData[id][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	        SetDynamicObjectRot(objectid, ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
            
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_X, ATMData[id][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_Y, ATMData[id][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_Z, ATMData[id][atmZ] + 0.85);

			mysql_format(DBConn, query, sizeof(query), "UPDATE bank_atms SET PosX='%f', PosY='%f', PosZ='%f', RotX='%f', RotY='%f', RotZ='%f' WHERE ID=%d", x, y, z, rx, ry, rz, id);
			mysql_tquery(DBConn, query);

	        EditingATMID[playerid] = -1;
	    }

	    if(response == 0) {
	        new id = EditingATMID[playerid];
	        SetDynamicObjectPos(objectid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	        SetDynamicObjectRot(objectid, ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
	        EditingATMID[playerid] = -1;
	    }
	}

	return true;
}