#include <YSI_Coding\y_hooks> 

#include "modules\utils\textdraws\td_footer.pwn"
#include "modules\utils\textdraws\td_ptextdraws.pwn"
#include "modules\utils\textdraws\td_banned.pwn"
#include "modules\utils\textdraws\td_news.pwn"
#include "modules\utils\textdraws\td_characters.pwn"
#include "modules\utils\textdraws\td_speedo.pwn"
#include "modules\utils\textdraws\td_hud.pwn"
#include "modules\utils\textdraws\td_interface.pwn"

hook OnPlayerConnect(playerid) {
    CreateLoginTextdraws(playerid);
    CreateCharacterTextdraws(playerid);
    CreatePlayerTextdraws(playerid);
    CreateNewsTextdraws(playerid);
    CreateNotifyTextdraws(playerid);
    return true;
}

hook OnPlayerDisconnect(playerid, reason) {
    HideLoginTextdraws(playerid);
    HideCharacterTextdraws(playerid);
    HideBannedTextdraws(playerid);
    HideNewsTextdraws(playerid);
    HidePlayerFooter(playerid);
    return true;
}

hook OnGameModeInit() {
    CreateBannedTextdraws();
    CreateSpeedometerTextdraws();
    CreateHUDTextdraws();

    // TIMERS
    SetTimer("SpeedoCheck", 300, true);
    SetTimer("HUDCheck", 1250, true);
    return true;
}

hook OnGameModeExit() {
    DestroyBannedTextdraws();
    DestroySpeedoTextdraws();
    return true;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
    if (pInfo[playerid][pChoosingCharacter] == 1) {
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d'", uInfo[playerid][uID]);
        new Cache:result = mysql_query(DBConn, query);

        if(!cache_num_rows()){
            SendServerMessage(playerid, "ERRO#50 - Reporte sobre este problema a um desenvolvedor o mais rápido possível.");
            SendServerMessage(playerid, "Você será kickado do servidor agora. Tire uma screenshot desta tela.");
            return KickEx(playerid);
        }
        new count = 0;
        if (playertextid == CharTD_1[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 1) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }
        } else if (playertextid == CharTD_2[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 2) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }
        } else if (playertextid == CharTD_3[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 3) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }
        } else if (playertextid == CharTD_4[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 4) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }            
        } else if (playertextid == CharTD_5[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 5) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }
        } else if (playertextid == CharTD_6[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 6) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }
        } else if (playertextid == CharTD_7[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 7) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }
        } else if (playertextid == CharTD_8[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 8) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }

        } else if (playertextid == CharTD_9[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 9) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                } 
            }
        } else if (playertextid == CharTD_10[playerid][0]) {
            for(new i; i < cache_num_rows(); i++) {
                count++;
                if (count == 10) {
                    cache_get_value_name_int(i, "ID", pInfo[playerid][pCharacterChoosed]);
                    cache_get_value_name_int(i, "skin", pInfo[playerid][pCharacterActorSkin]);
                }
            }
        } else if (playertextid == CharTD_BUTTON[playerid][0]) {
            DestroyActor(pInfo[playerid][pCharacterActor]);
            
            CancelSelectTextDraw(playerid);
            ResetCharacterData(playerid);
            
            LoadCharacterInfoID(playerid, pInfo[playerid][pCharacterChoosed]);
            SpawnSelectedCharacter(playerid);
            HideCharacterTextdraws(playerid);
            pInfo[playerid][pCharacterChoosed] = 0;
            pInfo[playerid][pCharacterActorSkin] = 0;
            ResetCharacterSelection(playerid);

            ShowPlayerFooter(playerid, "BEM-VINDO(A)!", 2);
            pInfo[playerid][pInterfaceTimer] = SetTimerEx("SetPlayerInterface", 2000, false, "dd", playerid, 888);
            return true;
        }

        SelectTextDraw(playerid, 0x5964F4FF);
        InterpolateCameraPos(playerid, 398.892791, -2044.198242, 9.665472, 396.914611, -2042.464477, 8.440737, 1000);
        InterpolateCameraLookAt(playerid, 396.500122, -2040.112792, 11.273117, 393.339019, -2038.973510, 8.272800, 1000);
        DestroyActor(pInfo[playerid][pCharacterActor]);
        pInfo[playerid][pCharacterActor] = CreateActor(pInfo[playerid][pCharacterActorSkin], 396.1454, -2041.9301, 7.8359, 208.4032);
        SetActorVirtualWorld(pInfo[playerid][pCharacterActor], playerid+1000);

        ShowCharacterButtonTextdraws(playerid);
        cache_delete(result);
    }
    return false;
}