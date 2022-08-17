/*

*/
#include <YSI_Coding\y_hooks>

CMD:trocarpersonagem(playerid, params[]){
    mysql_format(DBConn, query, sizeof query, "UPDATE players SET `online` = '0' WHERE `ID` = '%d';", pInfo[playerid][pID]);
    mysql_query(DBConn, query);
    
    TogglePlayerSpectating(playerid, true);
    new string[256];
    format(string,sizeof(string),"(( %s (%s) (Foi para a tela de seleção de personagem) ))", pNome(playerid), GetPlayerUserEx(playerid));
	SendNearbyMessage(playerid, 30.0, COLOR_WHITE, string);
    ClearPlayerChat(playerid);
    
    SaveCharacterInfo(playerid);
    ResetCharacterData(playerid);
    SOS_Clear(playerid);
    Report_Clear(playerid);

    ShowChangeCharacters(playerid);
    return true;
}

ShowChangeCharacters(playerid) {
    new characterName[24], string[128], majorString[2056],
        characterScore, lastLogin;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d'", uInfo[playerid][uID]);
    mysql_query(DBConn, query);

    if(!cache_num_rows()){
        SendServerMessage(playerid, "ERRO#23 - Reporte sobre este problema a um desenvolvedor o mais rápido possível.");
        SendServerMessage(playerid, "Você será kickado do servidor agora. Tire uma screenshot desta tela.");
        return Kick(playerid);
    }

    majorString[0] = EOS;
    strcat(majorString, "Nome\tNível\tÚltimo login\n");
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name(i, "name", characterName);
        cache_get_value_name_int(i, "score", characterScore);
        cache_get_value_name_int(i, "last_login", lastLogin);
        
        format(string, sizeof(string), "%s\t%d\t%s\n", characterName, characterScore, GetFullDate(lastLogin));
        strcat(majorString, string);
    }
    return Dialog_Show(playerid, ShowChangeChars, DIALOG_STYLE_TABLIST_HEADERS, "Personagens", majorString, "Confirmar", "Sair");
}

Dialog:ShowChangeChars(playerid, response, listitem, inputtext[]){
    if(response){
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s';", inputtext);
        mysql_query(DBConn, query);
        if(!cache_num_rows())
            return SendErrorMessage(playerid, "ERRO#23 - Reporte sobre este problema a um desenvolvedor o mais rápido possível.");
                
        ResetCharacterData(playerid);
        LoadCharacterInfo(playerid, inputtext);
        SpawnSelectedCharacter(playerid);
    }else{
        SendServerMessage(playerid, "Você será kickado do servidor agora.");
        return Kick(playerid);
    }
    return true;
}