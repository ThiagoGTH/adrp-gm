#include <YSI_Coding\y_hooks>

public OnPlayerText(playerid, text[]) {
    if (!pInfo[playerid][pLogged]) return false;
    if (IsPlayerWatchingCamera(playerid)) {
        SendErrorMessage(playerid, "Você não pode falar enquanto assiste uma transmissão ao vivo.");
        return false;
    }
    if (pInfo[playerid][pSpectating] != INVALID_PLAYER_ID) {
        SendErrorMessage(playerid, "Você não pode falar enquanto esta de spec em alguém.");
        return false;
    }
    
    new str[256];
    if (IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(GetPlayerVehicleID(playerid)) && !vInfo[GetPlayerVehicleID(playerid)][vWindowsDown]) {
        if (strlen(text) > 64) {
            SendVehicleMessage(GetPlayerVehicleID(playerid), COLOR_WHITE, "[Janelas Fechadas] %s diz: %.64s", pNome(playerid), text);
            SendVehicleMessage(GetPlayerVehicleID(playerid), COLOR_WHITE, "...%s", text[64]);
        } else SendVehicleMessage(GetPlayerVehicleID(playerid), COLOR_WHITE, "[Janelas Fechadas] %s diz: %s", pNome(playerid), text);
    } else {
        if (strlen(text) > 64) {
            format(str, sizeof(str), "%s diz: %.64s", pNome(playerid), text);
            ProxDetector(15.0, playerid, str,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            format(str, sizeof(str), "...%s", text[64]);
            ProxDetector(15.0, playerid, str,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
        } else {
            format(str, sizeof(str), "%s diz: %s", pNome(playerid), text);
            ProxDetector(15.0, playerid, str, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
        }
    }
    return false;
}