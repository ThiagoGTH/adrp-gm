CMD:darpet(playerid, params[]) {
    new targetid, petmodel;

    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    if(sscanf(params, "ud", targetid, petmodel)) return SendSyntaxMessage(playerid, "/darpet [playerid] [modelo]");
    if(!IsPlayerConnected(targetid)) return SendNotConnectedMessage(playerid);
    if(!IsValidPetModel(petmodel)) return SendErrorMessage(playerid, "Modelo inv�lido!");   

    PetData[targetid][petModelID] = petmodel;
    format(PetData[targetid][petName], 128, "Jack");
    SendServerMessage(playerid, "Voc� deu um animal de estima��o para %s.", pNome(targetid));
    return true;
}

CMD:pet(playerid, params[]) {
    if(pInfo[playerid][pDonator] != 3) return SendErrorMessage(playerid, "Voc� deve possuir um Premium Ouro ativo para utilizar isso.");
    if(!PetData[playerid][petModelID]) return SendErrorMessage(playerid, "Voc� n�o possui um animal de estima��o.");

    ShowPetMenu(playerid);
    return true;
}