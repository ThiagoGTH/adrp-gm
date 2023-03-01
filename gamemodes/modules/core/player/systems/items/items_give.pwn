PlayerGiveItem(playerid, slotid) {
    pInfo[playerid][pInventoryItem] = slotid;
    if (slotid == 999) {
        if(GetMoney(playerid) < 1) return SendErrorMessage(playerid, "Você não possui dinheiro em mãos.");
        new money = GetMoney(playerid);

        Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Dinheiro", "Dinheiro em mãos: US$ %s\n\nPor favor, especifique o jogador:", "Confirmar", "Cancelar", FormatNumber(money));
    } else 
	    Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Item", "Por favor, especifique o jogador:", "Confirmar", "Cancelar");
	return true;
}

Dialog:GiveItem(playerid, response, listitem, inputtext[]) {
	if (response) {
	    static userid = -1, slotid = -1;

		slotid = pInfo[playerid][pInventoryItem];

		if (slotid == -1)
		    return false;

        if(slotid == 999){
            new money = GetMoney(playerid);

            if (sscanf(inputtext, "u", userid))
                return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Dinheiro", "Dinheiro em mãos: US$ %s\n\nPor favor, especifique o jogador:", "Confirmar", "Cancelar", FormatNumber(money));

            if (userid == INVALID_PLAYER_ID)
                return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Dinheiro", "ERRO: O jogador especificado é inválido.\n\nDinheiro em mãos: US$ %s\n\nPor favor, especifique o jogador:", "Confirmar", "Cancelar", FormatNumber(money));

            if (!IsPlayerNearPlayer(playerid, userid, 2.0))
                return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Dinheiro", "ERRO: Você não está próximo deste jogador.\n\nDinheiro em mãos: US$ %s\n\nPor favor, especifique o jogador:", "Confirmar", "Cancelar", FormatNumber(money));
                
            if (userid == playerid)
                return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Dinheiro", "ERRO: Você não pode dar dinheiro para si mesmo.\n\nDinheiro em mãos: US$ %s\n\nPor favor, especifique o jogador:", "Confirmar", "Cancelar", FormatNumber(money));

            if (money == 1){
                SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s deu US$ %s para %s.", pNome(playerid), FormatNumber(money), pNome(userid));
                SendServerMessage(userid, "%s lhe deu US$ %s.", pNome(playerid), FormatNumber(money));

                format(logString, sizeof(logString), "%s (%s) deu US$ %s para %s (inventário)", pNome(playerid), GetPlayerUserEx(playerid), FormatNumber(money), pNome(userid));
                logCreate(playerid, logString, 20);
                GiveMoney(userid, money);
                GiveMoney(playerid, -money);
                pInfo[playerid][pInventoryItem] = -1;
            } else {
                Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dar Dinheiro", "Dinheiro em mãos: US$ %s\n\nEspecifique a quantidade de dinheiro que deseja dar a %s:", "Dar", "Cancelar", FormatNumber(money), pNome(userid));
                pInfo[playerid][pGiveItem] = userid;
            }
        } else {
            if (sscanf(inputtext, "u", userid))
                return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Item", "Por favor, especifique o jogador:", "Confirmar", "Cancelar");

            if (userid == INVALID_PLAYER_ID)
                return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Item", "ERRO: O jogador especificado é inválido.\n\nPor favor, especifique o jogador:", "Confirmar", "Cancelar");

            if (!IsPlayerNearPlayer(playerid, userid, 2.0))
                return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Item", "ERRO: Você não está próximo deste jogador.\n\nPor favor, especifique o jogador:", "Confirmar", "Cancelar");

            if (userid == playerid)
                return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dar Item", "ERRO: Você não pode dar itens para si mesmo.\n\nPor favor, especifique o jogador:", "Confirmar", "Cancelar");
                
            if (pInfo[playerid][iAmount][slotid] == 1) {
                new id = Inventory_Add(playerid, pInfo[playerid][iItem][slotid], 1);
                new itemid = pInfo[playerid][iItem][slotid];

                if (id == -1)
                    return SendErrorMessage(playerid, "Este jogador não possui slots do inventário disponíveis.");

                SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pega um %s e entrega para %s.", pNome(playerid), diInfo[itemid][diName], pNome(userid));
                SendServerMessage(userid, "%s lhe deu um(a) %s (adicionado ao inventário).", pNome(playerid), diInfo[itemid][diName]);

                format(logString, sizeof(logString), "%s (%s) deu um(a) %s (1) para %s", pNome(playerid), GetPlayerUserEx(playerid), diInfo[itemid][diName], pNome(userid));
                logCreate(playerid, logString, 18);

                Inventory_Remove(playerid, slotid);
                pInfo[playerid][pInventoryItem] = -1;
            } else {
                new itemid = pInfo[playerid][iItem][slotid];
                Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dar Item", "Item: %s (Quantidade: %d)\n\nPor favor, digite a quantidade deste item que você deseja dar para %s:", "Dar", "Cancelar", diInfo[itemid][diName], pInfo[playerid][iAmount][slotid], pNome(userid));
                pInfo[playerid][pGiveItem] = userid;
            }
        }
    }
	return true;
}

Dialog:GiveQuantity(playerid, response, listitem, inputtext[]) {
	if (response && pInfo[playerid][pGiveItem] != INVALID_PLAYER_ID) {
	    new
	        userid = pInfo[playerid][pGiveItem],
	        slotid = pInfo[playerid][pInventoryItem];

        if (slotid == 999){
            new money = GetMoney(playerid);
            if (isnull(inputtext))
                return Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dar Dinheiro", "Dinheiro em mãos: US$ %s\n\nEspecifique a quantidade de dinheiro que deseja dar a %s:", "Dar", "Cancelar", FormatNumber(money), pNome(userid));

            if (strval(inputtext) < 1 || strval(inputtext) > money)
                return Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dar Dinheiro", "ERRO: Você não possui essa quantidade em mãos.\nDinheiro em mãos: US$ %s\n\nEspecifique a quantidade de dinheiro que deseja dar a %s:", "Dar", "Cancelar", FormatNumber(money), pNome(userid));
            
            new quantity = strval(inputtext);

            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s deu US$ %s para %s.", pNome(playerid), FormatNumber(quantity), pNome(userid));
            SendServerMessage(userid, "%s lhe deu US$ %s.", pNome(playerid), FormatNumber(quantity));

            format(logString, sizeof(logString), "%s (%s) deu US$ %s para %s (inventário)", pNome(playerid), GetPlayerUserEx(playerid), FormatNumber(quantity), pNome(userid));
            logCreate(playerid, logString, 20);
            GiveMoney(userid, quantity);
            GiveMoney(playerid, -quantity);
            pInfo[playerid][pInventoryItem] = -1;
            pInfo[playerid][pGiveItem] = -1;
        } else {
            new id = Inventory_Add(playerid, pInfo[playerid][iItem][slotid], 1);
            new itemid = pInfo[playerid][iItem][slotid], quantity = strval(inputtext);

            if (isnull(inputtext))
                return Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dar Item", "Item: %s (Quantidade: %d)\n\nPor favor, digite a quantidade deste item que você deseja dar para %s:", "Dar", "Cancelar", diInfo[itemid][diName], pInfo[playerid][iAmount][slotid], pNome(userid));

            if (strval(inputtext) < 1 || strval(inputtext) > pInfo[playerid][iAmount][slotid])
                return  Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dar Item", "ERRO: Você não possui esta quantidade.\n\nItem: %s (Quantidade: %d)\n\nPor favor, digite a quantidade deste item que você deseja dar para %s:", "Dar", "Cancelar", diInfo[itemid][diName], pInfo[playerid][iAmount][slotid], pNome(userid));

            if (id == -1)
                return SendErrorMessage(playerid, "Este jogador não possui slots do inventário disponíveis.");

            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pega um %s e entrega para %s.", pNome(playerid), diInfo[itemid][diName], pNome(userid));
            SendServerMessage(userid, "%s lhe deu um(a) %s (%d) (adicionado ao inventário).", pNome(playerid), diInfo[itemid][diName], quantity);

            format(logString, sizeof(logString), "%s (%s) deu um(a) %s (%d) para %s", pNome(playerid), GetPlayerUserEx(playerid), diInfo[itemid][diName], quantity, pNome(userid));
            logCreate(playerid, logString, 18);

            Inventory_Remove(playerid, slotid, quantity);
            pInfo[playerid][pInventoryItem] = -1;
            pInfo[playerid][pGiveItem] = -1;
        }
	}
	return true;
}