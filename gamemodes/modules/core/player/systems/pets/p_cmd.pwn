CMD:darpet(playerid, params[]) {
    new targetid, petmodel;

    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    if(sscanf(params, "ud", targetid, petmodel)) return SendSyntaxMessage(playerid, "/darpet [playerid] [modelo]");
    if(!IsPlayerConnected(targetid)) return SendNotConnectedMessage(playerid);
    if(!IsValidPetModel(petmodel)) return SendErrorMessage(playerid, "Modelo inválido. Modelos válidos: 29900 ~ 29919.");   

    PetData[targetid][petModelID] = petmodel;
    format(PetData[targetid][petName], 128, "Jack");
    SendServerMessage(playerid, "Você deu um animal de estimação para %s.", pNome(targetid));
    format(logString, sizeof(logString), "%s (%s) deu um animal de estimação para %s.", pNome(playerid), GetPlayerUserEx(playerid), pNome(targetid));
	logCreate(playerid, logString, 1);
    return true;
}

CMD:pet(playerid, params[]) {
    if(pInfo[playerid][pDonator] != 3) return SendErrorMessage(playerid, "Você deve possuir um Premium Ouro ativo para utilizar isso.");
    if(!PetData[playerid][petModelID]) return SendErrorMessage(playerid, "Você não possui um animal de estimação.");

    ShowPetMenu(playerid);
    return true;
}