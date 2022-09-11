#include <YSI_Coding\y_hooks>

// RANKS
FactionShowRanks(playerid, factionid) {
    if (factionid != -1 && FactionData[factionid][factionExists]) {
		static
		    string[1024];

		string[0] = 0;

		for (new i = 0; i < FactionData[factionid][factionMaxRanks]; i ++)
		    format(string, sizeof(string), "%sCargo %d: %s\n", string, i + 1, FactionRanks[factionid][i]);

		pInfo[playerid][pFactionEdit] = factionid;
		Dialog_Show(playerid, EditRanks, DIALOG_STYLE_LIST, FactionData[factionid][factionName], string, "Alterar", "Cancelar");
	}
	return true;
}

Dialog:EditRanks(playerid, response, listitem, inputtext[]) {
	if (response) {
	    if (!FactionData[pInfo[playerid][pFactionEdit]][factionExists])
			return false;

		pInfo[playerid][pSelectedSlot] = listitem;
		Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Alterar Cargo", "Cargo: %s (%d)\n\nPor favor, digite um novo nome para este cargo abaixo:", "Confirmar", "Cancelar", FactionRanks[pInfo[playerid][pFactionEdit]][pInfo[playerid][pSelectedSlot]], pInfo[playerid][pSelectedSlot]);
	}
	return true;
}

Dialog:SetRankName(playerid, response, listitem, inputtext[]) {
    new id = pInfo[playerid][pFactionEdit], slot = pInfo[playerid][pSelectedSlot];

	if (response) {

	    if (isnull(inputtext))
			return Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Alterar Cargo", "Cargo: %s (%d)\n\nPor favor, digite um novo nome para este cargo abaixo:", "Confirmar", "Voltar", FactionRanks[id][slot], slot);

	    if (strlen(inputtext) > 32) return Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Alterar Cargo", "Error: O cargo n�o pode exceder 32 caracteres.\n\nCargo: %s (%d)\n\nPor favor, digite um novo nome para este cargo abaixo:", "Confirmar", "Voltar", FactionRanks[id][slot], slot);

        SendServerMessage(playerid, "Voc� alterou o cargo da fac��o %s (%d) para %s (%s).", FactionData[id][factionName], id, inputtext, slot);

		format(logString, sizeof(logString), "%s (%s) alterou o cargo da fac��o %s (%d) de %s para %s (cargo %d)", pNome(playerid), GetPlayerUserEx(playerid), FactionData[id][factionName], id, FactionRanks[id][slot], inputtext, slot);
		logCreate(playerid, logString, 1);

		format(FactionRanks[id][slot], 32, inputtext);
        SaveFaction(id);

		FactionShowRanks(playerid, id);
	}
	else FactionShowRanks(playerid, id);
	return true;
}

//PAYCHECK
FactionPaycheck(playerid, factionid) {
    if (factionid != -1 && FactionData[factionid][factionExists]) {
		static
		    string[1024];

		string[0] = 0;

		for (new i = 0; i < FactionData[factionid][factionMaxRanks]; i ++)
		    format(string, sizeof(string), "%s%d. %s: %s\n", string, i + 1, FactionGetRankName(factionid, i), FormatNumber(FactionData[factionid][factionPaycheck][i]));

		pInfo[playerid][pFactionEdit] = factionid;
		Dialog_Show(playerid, EditPaycheck, DIALOG_STYLE_LIST, FactionData[factionid][factionName], string, "Alterar", "Cancelar");
	}
	return true;
}

Dialog:EditPaycheck(playerid, response, listitem, inputtext[]) {
	if(response) {
		new factionid = pInfo[playerid][pFactionEdit];

		pInfo[playerid][pSelectedSlot] = listitem;

		new string[128];
		format(string, sizeof(string), "Defina o valor em dinheiro do sal�rio por paycheck do cargo %s:", FactionGetRankName(factionid, listitem));

		Dialog_Show(playerid, SetPaycheck, DIALOG_STYLE_INPUT, FactionData[factionid][factionName], string, "Definir", "Cancelar");
	}
	return true;
}

Dialog:SetPaycheck(playerid, response, listitem, inputtext[]) {
	if(response) {
		new rankid = pInfo[playerid][pSelectedSlot], factionid = pInfo[playerid][pFactionEdit];

		if(!IsNumeric(inputtext)) {
			new string[128];
			format(string, sizeof(string), "ERRO: Apenas n�meros s�o permitidos!\nDefina o valor em dinheiro do sal�rio por paycheck do cargo %s:", FactionGetRankName(factionid, rankid));
			Dialog_Show(playerid, SetPaycheck, DIALOG_STYLE_INPUT, FactionData[factionid][factionName], string, "Definir", "Cancelar");
		} else if(isnull(inputtext)) {
			new string[128];
			format(string, sizeof(string), "ERRO: Voc� n�o pode deixar este campo vazio!\nDefina o valor em dinheiro do sal�rio por paycheck do cargo %s:", FactionGetRankName(factionid, rankid));
			Dialog_Show(playerid, SetPaycheck, DIALOG_STYLE_INPUT, FactionData[factionid][factionName], string, "Definir", "Cancelar");
		}
		
        SendServerMessage(playerid, "Voc� alterou o sal�rio do cargo %s da fac��o %s (%d) de %s para %s.", FactionGetRankName(factionid, rankid), FactionData[factionid][factionName], factionid, FormatNumber(FactionData[factionid][factionPaycheck][rankid]), FormatNumber(strval(inputtext)));

		format(logString, sizeof(logString), "%s (%s) alterou o sal�rio do cargo %s da fac��o %s (%d) de %s para %s (cargo %d)", pNome(playerid), GetPlayerUserEx(playerid), FactionGetRankName(factionid, rankid), FactionData[factionid][factionName], factionid, FormatNumber(FactionData[factionid][factionPaycheck][rankid]), FormatNumber(strval(inputtext)));
		logCreate(playerid, logString, 1);

		FactionData[factionid][factionPaycheck][rankid] = strval(inputtext);
		
        SaveFaction(factionid);
		FactionPaycheck(playerid, factionid);
	}
	return true;
}

// SKINS
FactionSetSkins(playerid, factionid) {    
    new str[2058];
	format(str, sizeof(str), "19132(0.0, 0.0, -80.0, 1.0)\t~g~Adicionar\n");

	for(new i = 0; i < 50; i ++) {
		if(FactionData[factionid][factionSkins][i] > 0)
			format(str, sizeof(str), "%s%d\t~n~~n~~n~~n~~n~~n~~n~~w~%d\n", str, FactionData[factionid][factionSkins][i], FactionData[factionid][factionSkins][i]);
	}

	pInfo[playerid][pFactionEdit] = factionid;

	Dialog_Show(playerid, FactionSkins, DIALOG_STYLE_PREVIEW_MODEL, FactionData[factionid][factionName], str, "Selecionar", "<<");
    return true;
}

Dialog:FactionSkins(playerid, response, listitem, inputtext[]) {
	if(response) {
		new factionid = pInfo[playerid][pFactionEdit];
		if(listitem == 0)
			Dialog_Show(playerid, AddFactionSkin, DIALOG_STYLE_INPUT, "Adicionar skin", "Especifique o ID da skin:", "Adicionar", "Cancelar");
		else {
			new string[128];
			format(string, sizeof(string), "Voc� deseja realmente remover a skin %d?", FactionData[factionid][factionSkins][listitem-1]);
			Dialog_Show(playerid, RemoveFactionSkin, DIALOG_STYLE_MSGBOX, "Remover skin", string, "Confirmar", "Cancelar");
			pInfo[playerid][pSelectedSlot] = listitem-1;
		}
	}
	return true;
}

Dialog:AddFactionSkin(playerid, response, listitem, inputtext[]) {
	if(response) {
		if(!IsNumeric(inputtext))
			return Dialog_Show(playerid, AddFactionSkin, DIALOG_STYLE_INPUT, "Adicionar skin", "ERRO: Voc� n�o especificou um n�mero!\nEspecifique o ID da skin:", "Adicionar", "Cancelar");

		if(isnull(inputtext))
			return Dialog_Show(playerid, AddFactionSkin, DIALOG_STYLE_INPUT, "Adicionar skin", "ERRO: Voc� n�o especificou nada!\nEspecifique o ID da skin:", "Adicionar", "Cancelar");

		new factionid = pInfo[playerid][pFactionEdit], count = 0;
		for(new i = 0; i < 50; i ++) {
			if(FactionData[factionid][factionSkins][i] < 1) {
				count++;
				FactionData[factionid][factionSkins][i] = strval(inputtext);
				
                SendServerMessage(playerid, "Voc� adicionou a skin %d na fac��o %s (%d).", FactionData[factionid][factionSkins][i], FactionData[factionid][factionName], factionid);

                format(logString, sizeof(logString), "%s (%s) adicionou a skin %d na fac��o %s (%d)", pNome(playerid), GetPlayerUserEx(playerid), FactionData[factionid][factionSkins][i], FactionData[factionid][factionName], factionid);
                logCreate(playerid, logString, 1);

                SaveFaction(factionid);
				FactionSetSkins(playerid, factionid);

                pInfo[playerid][pFactionEdit] = -1;
				break;
			}
		}
		if(!count) return SendErrorMessage(playerid, "N�o existe slot de skins dispon�vel para essa fac��o.");
	}
	return true;
}

Dialog:RemoveFactionSkin(playerid, response, listitem, inputtext[]) {
	if(response) {
		new factionid = pInfo[playerid][pFactionEdit], slotid = pInfo[playerid][pSelectedSlot];

        SendServerMessage(playerid, "Voc� removeu a skin %d da fac��o %s (%d).", FactionData[factionid][factionSkins][slotid], FactionData[factionid][factionName], factionid);

        format(logString, sizeof(logString), "%s (%s) removeu a skin %d da fac��o %s (%d)", pNome(playerid), GetPlayerUserEx(playerid), FactionData[factionid][factionSkins][slotid], FactionData[factionid][factionName], factionid);
        logCreate(playerid, logString, 1);

        FactionData[factionid][factionSkins][slotid] = 0;

		pInfo[playerid][pFactionEdit] = -1;
		pInfo[playerid][pSelectedSlot] = -1;

        SaveFaction(factionid);	
	}
	return true;
}

// LOCKER
FactionConfigLocker(playerid, factionid) {
    if(FactionData[factionid][factionType] == FACTION_CRIMINAL) return SendErrorMessage(playerid, "Voc� n�o pode editar arm�rio de fac��es criminosas.");

	new title[128];
	format(title, 128, "Arm�rio da Fac��o %s (%d)", FactionData[factionid][factionName], factionid);
    pInfo[playerid][pFactionEdit] = factionid;
	Dialog_Show(playerid, FactionLocker, DIALOG_STYLE_LIST, title, "Alterar Local\nArmas", "Selecionar", "Cancelar");
    return true;
}

// OTHERS
FactionGetRankName(factionid, rankid) {
    new
		rank[32] = "Nenhum";

 	if (factionid == -1)
	    return rank;

	format(rank, 32, FactionRanks[factionid][rankid]);
	return rank;
}

GetFactionType(playerid) {
	if (pInfo[playerid][pFaction] == -1)
	    return false;

	return (FactionData[pInfo[playerid][pFaction]][factionType]);
}

GetFactionTypeID(type){
    new name[64];
    switch(type){
        case 1: format(name, 64, "Policial");
        case 2: format(name, 64, "Midi�tica");
        case 3: format(name, 64, "M�dica");
        case 4: format(name, 64, "Prefeitura");
        case 5: format(name, 64, "Governamental");
        case 6: format(name, 64, "Civil");
        case 7: format(name, 64, "Criminal");
        default: format(name, 64, "Inv�lido");
    }
    return name;
}

SetFactionColor(playerid) {
	new factionid = pInfo[playerid][pFaction];

	if (factionid != -1)
		return SetPlayerColor(playerid, RemoveAlpha(FactionData[factionid][factionColor]));

	return false;
}

RemoveAlpha(color) {
    return (color & ~0xFF);
}