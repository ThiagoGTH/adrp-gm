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

GiveBankMoney(playerid, amount) {
	pInfo[playerid][pBank] += amount;
	return true;
}

GetBankMoney(playerid) {
	return (pInfo[playerid][pBank]);
}

hook native GivePlayerMoney(playerid, money) {
    pInfo[playerid][pMoney] += money;
    if(GetPlayerMoney(playerid) != pInfo[playerid][pMoney]) {
        CallLocalFunction("OnPlayerMoneyChange", "iii", playerid, GetPlayerMoney(playerid), pInfo[playerid][pMoney]);
    }
    return continue(playerid, money);
}

hook native ResetPlayerMoney(playerid) {
    pInfo[playerid][pMoney] = 0;
    return continue(playerid);
}

forward OnPlayerMoneyChange(playerid, previous, current);