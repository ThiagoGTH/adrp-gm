EntryProperty(playerid, vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3) {

    SetPlayerVirtualWorld(playerid, vwExit);
    SetPlayerInterior(playerid, interiorExit);
    SetPlayerPos(playerid, exitPos0, exitPos1, exitPos2);
    SetPlayerFacingAngle(playerid, exitPos3);
        
    return 1;
}

ExitProperty(playerid, vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3) {

    SetPlayerVirtualWorld(playerid, vwExit);
    SetPlayerInterior(playerid, interiorExit);
    SetPlayerPos(playerid, exitPos0, exitPos1, exitPos2);
    SetPlayerFacingAngle(playerid, exitPos3);
    
    return 1;
}

BuyProperty(id, playerid, propertyType) {

    if(propertyType === 1) {
        hInfo[id][hOwner] = pInfo[playerid][pID];
        SaveHouse(id);
        format(logString, sizeof(logString), "%s (%s) comprou a casa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(hInfo[id][hPrice]));
    
        return 1;
    }

    if(propertyType === 2) {
        bInfo[id][bOwner] = pInfo[playerid][pID];
        SaveBusiness(id);

        format(logString, sizeof(logString), "%s (%s) comprou a empresa ID %d por $%s.", pNome(playerid), GetPlayerUserEx(playerid), id, FormatNumber(bInfo[id][bPrice]));
        logCreate(playerid, logString, 13);

        return 1;
    }

	logCreate(playerid, logString, 13);

    return 1;
}