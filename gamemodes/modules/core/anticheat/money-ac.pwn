#include <YSI_Coding\y_hooks>

hook OnPlayerSecondUpdate(playerid) {
    if ((GetPlayerMoney(playerid) != pInfo[playerid][pMoney]) && (GetPlayerMoney(playerid) > pInfo[playerid][pMoney])) {
        pInfo[playerid][pOldMoney] = pInfo[playerid][pMoney];
        ResetPlayerMoney(playerid);

        GivePlayerMoney(playerid, pInfo[playerid][pOldMoney]);
    }
    return true;
}

GiveMoney(playerid, amount) {
	pInfo[playerid][pMoney] += amount;
	GivePlayerMoney(playerid, amount);
	return true;
}

GetMoney(playerid) {
	return (pInfo[playerid][pMoney]);
}