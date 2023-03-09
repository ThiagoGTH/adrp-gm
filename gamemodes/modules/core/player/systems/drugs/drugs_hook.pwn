#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
    new emptydata[E_PLAYER];
	PlayerDrugData[playerid] = emptydata;
	PlayerDrugData[playerid][DrugsOfferedBy] = INVALID_PLAYER_ID;
	RegenTimer[playerid] = EffectTimer[playerid] = -1;
}