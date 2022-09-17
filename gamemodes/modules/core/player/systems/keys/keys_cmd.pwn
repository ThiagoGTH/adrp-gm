#include <YSI_Coding\y_hooks>

CMD:minhaschaves(playerid) {
    va_SendClientMessage(playerid, COLOR_BEGE, "Sua Chaves:");
    if(!strcmp(pInfo[playerid][pHouseKeySlot1], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 1: %i", pInfo[playerid][pHouseKey][0]); }
    if(strcmp(pInfo[playerid][pHouseKeySlot1], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 1: %i   |   Casa: %s", pInfo[playerid][pHouseKey][0], pInfo[playerid][rRadioName1]); }
    if(!strcmp(pInfo[playerid][pHouseKeySlot2], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 2: %i", pInfo[playerid][pHouseKey][1]); }
    if(strcmp(pInfo[playerid][pHouseKeySlot2], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 2: %i   |   Casa: %s", pInfo[playerid][pHouseKey][1], pInfo[playerid][rRadioName2]); }
    if(!strcmp(pInfo[playerid][pHouseKeySlot3], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 3: %i", pInfo[playerid][pHouseKey][2]); }
    if(strcmp(pInfo[playerid][pHouseKeySlot3], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 3: %i   |   Casa: %s", pInfo[playerid][pHouseKey][2], pInfo[playerid][rRadioName3]); }

    return 1;
}

CMD:copiarchave(playerid, params[]) {
    new type[16];

    if(sscanf(params, "s[16]", type)) {
        SendClientMessage(playerid, COLOR_BEGE, "_______________________________________________________________________");
        SendClientMessage(playerid, COLOR_BEGE, "USE: /copiarchave [opção]");
        SendClientMessage(playerid, COLOR_BEGE, "[Opções] casa");
        SendClientMessage(playerid, COLOR_BEGE, "[Casa] Copia a chave de uma de suas casas para suas chaves.");
        SendClientMessage(playerid, COLOR_BEGE, "_______________________________________________________________________");
        return 1;
    } 

    if(!strcmp(type, "casa", true)) {
        new houseID = GetNearestHouseEntry(playerid);

        if(!houseID || hInfo[houseID][hOwner] != pInfo[playerid][pID])
            return SendErrorMessage(playerid, "Você não está próximo de nenhuma casa sua.");
        
        CreateKey(playerid, houseID);

        return 1;
    }

    return 1;
}

// excluir chave
// dar chave
