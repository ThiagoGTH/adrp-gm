CMD:entrar(playerid) {
    new vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3;

    new houseID = GetNearestHouseEntry(playerid), entryID = GetNearestHouseSecondEntry(playerid);
    new businessID = GetNearestBusinessEntry(playerid);
    
    if(houseID !== -1) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa est� trancada.");
        
        vwExit = hInfo[houseID][vwExit];
        interiorExit = hInfo[houseID][interiorExit];
        exitPos0 = hInfo[houseID][exitPos][0]
        exitPos1 = hInfo[houseID][exitPos][1]
        exitPos2 = hInfo[houseID][exitPos][2]
        exitPos3 = hInfo[houseID][exitPos][3]
        EntryProperty(playerid, vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3);

        return 1;
    }

    if (businessID !== -1) {
        if(bInfo[businessID][bLocked])
            return SendErrorMessage(playerid, "Est� empresa est� trancada.");
        
        vwExit = bInfo[businessID][vwExit];
        interiorExit = bInfo[businessID][interiorExit];
        exitPos0 = bInfo[businessID][exitPos][0]
        exitPos1 = bInfo[businessID][exitPos][1]
        exitPos2 = bInfo[businessID][exitPos][2]
        exitPos3 = bInfo[businessID][exitPos][3]
        EntryProperty(playerid, vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3);

        return 1;
    }

    return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo de nenhuma propriedade.");

}

CMD:sair(playerid) {
    new vwEntry, interiorEntry, entryPos0, entryPos1, entryPos2, entryPos3;

    new houseID = GetNearestHouseExit(playerid), entryID = GetNearestHouseSecondExit(playerid);
    new businessID = GetNearestBusinessExit(playerid);
    
    if(houseID !== -1) {
        if(hInfo[houseID][hLocked])
            return SendErrorMessage(playerid, "Esta casa est� trancada.");
        
        vwEntry = hInfo[houseID][vwEntry];
        interiorEntry = hInfo[houseID][interiorEntry];
        entryPos0 = hInfo[houseID][entryPos][0]
        entryPos1 = hInfo[houseID][entryPos][1]
        entryPos2 = hInfo[houseID][entryPos][2]
        entryPos3 = hInfo[houseID][entryPos][3]
        EntryProperty(playerid, vwEntry, interiorEntry, entryPos0, entryPos1, entryPos2, entryPos3);

        return 1;
    }

    if (businessID !== -1) {
        if(bInfo[businessID][bLocked])
            return SendErrorMessage(playerid, "Est� empresa est� trancada.");
        
        vwEntry = bInfo[businessID][vwEntry];
        interiorEntry = bInfo[businessID][interiorEntry];
        entryPos0 = bInfo[businessID][entryPos][0]
        entryPos1 = bInfo[businessID][entryPos][1]
        entryPos2 = bInfo[businessID][entryPos][2]
        entryPos3 = bInfo[businessID][entryPos][3]
        EntryProperty(playerid, vwEntry, interiorEntry, entryPos0, entryPos1, entryPos2, entryPos3);

        return 1;
    }

    return SendErrorMessage(playerid, "Voc� n�o est� pr�ximo de nenhuma sa�da");

}