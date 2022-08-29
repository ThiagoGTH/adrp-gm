enum E_PET_SHOP_DATA {
    PET_MODELID,
    PET_NAME[128],
    PET_PRICE
};

new const PET_SHOP[][E_PET_SHOP_DATA] = {
    {29900, "Boxer", 3000},
    {29901, "Fila", 3000},
    {29902, "Buldogue Frânces Preto", 3000},
    {29903, "Buldogue Frânces Preto e Branco", 3000},
    {29904, "Bull Terrier", 3000},
    {29905, "Dalmata", 3000},
    {29906, "Sem Raça Definida", 3000},
    {29907, "Sem Raça Definida", 3000},
    {29908, "Dobermann", 3000},
    {29909, "Akita Inu", 3000},
    {29910, "Husky Siberiano", 3000},
    {29911, "Pastor Belga", 3000},
    {29912, "American Bully Branco", 3000},
    {29913, "American Bully Branco e Cinza", 3000},
    {29914, "American Bully Branco e Laranja", 3000},
    {29915, "American Bully Preto e Branco", 3000},
    {29916, "Shar-pei", 3000},
    {29917, "Sem Raça Definida", 3000},
    {29918, "Rottweiler", 3000},
    {29919, "Pastor Alemão", 3000}
};

CMD:menupet(playerid, params[]) {
    static string[sizeof(PET_SHOP) * 64];
    if (string[0] == EOS) {
        for (new i; i < sizeof(PET_SHOP); i++) {
            format(string, sizeof string, "%s%d(0.0, 0.0, -50.0, 1.5)\t%s~n~~g~~h~$%s\n", string, PET_SHOP[i][PET_MODELID], PET_SHOP[i][PET_NAME], FormatNumber(PET_SHOP[i][PET_PRICE]));
        }
    }
    new title[128];
    format(title, sizeof title, "Animais disponíveis");
    AdjustTextDrawString(title);
    AdjustTextDrawString(string);
    Dialog_Show(playerid, BuyPetsDialog, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Comprar", "Cancelar");
    return true;
}

Dialog:BuyPetsDialog(playerid, response, listitem, inputtext[]) {
    if(response) {
        if(GetMoney(playerid) < PET_SHOP[listitem][PET_PRICE]) {
            SendErrorMessage(playerid, "Você não possui US$ %s em mãos para comprar um %s.", FormatNumber(PET_SHOP[listitem][PET_PRICE]), PET_SHOP[listitem][PET_NAME]);
            return PC_EmulateCommand(playerid, "/menupet");
        }
        GiveMoney(playerid, -PET_SHOP[listitem][PET_PRICE]);
        PetData[playerid][petModelID] = PET_SHOP[listitem][PET_MODELID];
        format(PetData[playerid][petName], 128, "Jack");
        SendServerMessage(playerid, "Você comprou um %s e pagou US$ %s nele.", PET_SHOP[listitem][PET_NAME], FormatNumber(PET_SHOP[listitem][PET_PRICE]));

        format(logString, sizeof(logString), "%s (%s) comprou um %s por US$ %s", pNome(playerid), GetPlayerUserEx(playerid), PET_SHOP[listitem][PET_NAME], FormatNumber(PET_SHOP[listitem][PET_PRICE]));
        logCreate(playerid, logString, 19);
    }
    return true;
}
