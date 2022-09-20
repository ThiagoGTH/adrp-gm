#include <YSI_Coding\y_hooks>

CMD:trocarpersonagem(playerid, params[]){
    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `online` = '0' WHERE `ID` = '%d';", pInfo[playerid][pID]);
    mysql_query(DBConn, query);
    
    new string[256];
    format(string,sizeof(string),"(( %s (%s) (Foi para a tela de seleção de personagem) ))", pNome(playerid), GetPlayerUserEx(playerid));
	SendNearbyMessage(playerid, 30.0, COLOR_WHITE, string);
    ClearPlayerChat(playerid);
    
    SaveCharacterInfo(playerid);
    ResetCharacterData(playerid);
    ResetCharacterSelection(playerid);
    SOS_Clear(playerid);
    Report_Clear(playerid);

    ShowCharactersTD(playerid);
    return true;
}