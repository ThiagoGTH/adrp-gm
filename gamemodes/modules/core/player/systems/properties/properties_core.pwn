EntryProperty(playerid, vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3) {

    SetPlayerVirtualWorld(playerid, vwExit);
    SetPlayerInterior(playerid, interiorExit);
    SetPlayerPos(playerid, exitPos0, exitPos1, exitPos2);
    SetPlayerFacingAngle(playerid, exitPos3);
        
    return 1;
}

//Função para sair da empresa
ExitProperty(playerid, vwExit, interiorExit, exitPos0, exitPos1, exitPos2, exitPos3) {

    SetPlayerVirtualWorld(playerid, vwExit);
    SetPlayerInterior(playerid, interiorExit);
    SetPlayerPos(playerid, exitPos0, exitPos1, exitPos2);
    SetPlayerFacingAngle(playerid, exitPos3);
    
    return 1;
}