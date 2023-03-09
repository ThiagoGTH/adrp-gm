ItemCreate(model) {
    for (new i = 0; i != MAX_DYNAMIC_ITEMS; i ++) {
        if (!diInfo[i][diExists]) {
            new Cache:result;
            diInfo[i][diExists] = true;
            format(diInfo[i][diName], 64, "Inválido");
            format(diInfo[i][diDescription], 256, "N/A");
            diInfo[i][diModel] = model;
            diInfo[i][diCategory] = 0;
            diInfo[i][diUseful] = false;
            diInfo[i][diLegality] = true;

            mysql_format(DBConn, query, sizeof query, "INSERT INTO `items` (`item_name`, `item_desc`, `item_model`, `item_category`, `item_useful`, `item_legality`) VALUES ('Inválido', 'N/A', '%d', '0', '0', '1')", model);
            result = mysql_query(DBConn, query);
            diInfo[i][diID] = cache_insert_id();
            cache_delete(result);

            return i;
        }
    }
    return -1;
}

LoadItems() {
    new loadeditems;
    mysql_query(DBConn, "SELECT * FROM `items` WHERE (`ID` != '0');");

    for (new i; i < cache_num_rows(); i++) if (i < MAX_DYNAMIC_ITEMS) {
        new id;
        cache_get_value_name_int(i, "ID", id);
        if (diInfo[i][diExists]) return false;

        diInfo[id][diID] = id;
        diInfo[id][diExists] = true;
        cache_get_value_name(i, "item_name", diInfo[id][diName]);
        cache_get_value_name(i, "item_desc", diInfo[id][diDescription]);
        cache_get_value_name_int(i, "item_useful", diInfo[id][diUseful]);
        cache_get_value_name_int(i, "item_legality", diInfo[id][diLegality]);
        cache_get_value_name_int(i, "item_model", diInfo[id][diModel]);
        cache_get_value_name_int(i, "item_category", diInfo[id][diCategory]);

        loadeditems++;
    }
    printf("[ITENS DINÂMICOS]: %d itens dinâmicos carregados com sucesso.", loadeditems);
    return true;
}

LoadDroppeds() {
    new loadeddroppeds;
    mysql_query(DBConn, "SELECT * FROM `items_dropped` WHERE (`item_world` = '0' OR `item_int` = '0');");

    for (new i; i < cache_num_rows(); i++) if (i < MAX_DROPPED_ITEMS) {
        cache_get_value_name_int(i, "ID", DroppedItems[i][droppedID]);

        if (DroppedItems[i][droppedExists]) return false;

        DroppedItems[i][droppedExists] = true;

        cache_get_value_name_int(i, "item_id", DroppedItems[i][droppedItem]);
        cache_get_value_name_int(i, "item_player", DroppedItems[i][droppedPlayer]);
        cache_get_value_name_int(i, "item_model", DroppedItems[i][droppedModel]);
        cache_get_value_name_int(i, "item_quantity", DroppedItems[i][droppedQuantity]);
        cache_get_value_name_int(i, "item_weapon", DroppedItems[i][droppedWeapon]);
        cache_get_value_name_int(i, "item_ammo", DroppedItems[i][droppedAmmo]);
        cache_get_value_name_int(i, "item_int", DroppedItems[i][droppedInt]);
        cache_get_value_name_int(i, "item_world", DroppedItems[i][droppedWorld]);

        cache_get_value_name_float(i, "item_positionX", DroppedItems[i][droppedPos][0]);
        cache_get_value_name_float(i, "item_positionY", DroppedItems[i][droppedPos][1]);
        cache_get_value_name_float(i, "item_positionZ", DroppedItems[i][droppedPos][2]);
        cache_get_value_name_float(i, "item_positionRX", DroppedItems[i][droppedPos][3]);
        cache_get_value_name_float(i, "item_positionRY", DroppedItems[i][droppedPos][4]);
        cache_get_value_name_float(i, "item_positionRZ", DroppedItems[i][droppedPos][5]);

        DroppedItems[i][droppedObject] = CreateDynamicObject(DroppedItems[i][droppedModel], DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2], DroppedItems[i][droppedPos][3], DroppedItems[i][droppedPos][4], DroppedItems[i][droppedPos][5], DroppedItems[i][droppedWorld], DroppedItems[i][droppedInt], -1);
        loadeddroppeds++;
    }
    printf("[ITENS DROPADOS]: %d itens dropados foram carregados.", loadeddroppeds);
    return true;
}

Inventory_Remove(playerid, slotid, quantity = 1){
    if(pInfo[playerid][iAmount][slotid] > 1) return pInfo[playerid][iAmount][slotid] -= quantity;
    else if(pInfo[playerid][iAmount][slotid] >= quantity) return pInfo[playerid][iItem][slotid] = 0, pInfo[playerid][iAmount][slotid] = 0, OrganizeInventory(playerid);
    else if(pInfo[playerid][iAmount][slotid] == 1) return pInfo[playerid][iItem][slotid] = 0, pInfo[playerid][iAmount][slotid] = 0, OrganizeInventory(playerid);
    return -1;
}

Inventory_Reset(playerid) {
    for (new i = 0; i < MAX_INVENTORY_SLOTS; i++) {
    	pInfo[playerid][iItem][i] = 0;
        pInfo[playerid][iAmount][i] = 0;
    }
    return true;
}

Inventory_Quantity(playerid) {
	new count = 0, value = GetInventorySlots(playerid);
	for (new i = 0; i < value; i ++) {
	    if(pInfo[playerid][iItem][i] != 0) count++;
	}

	return count;
}

forward GetItemID(item[]);
public GetItemID(item[]){
    printf("Item: %s", item);
    for (new i = 0; i < MAX_DYNAMIC_ITEMS; i++){

        printf("strcmp: %s; %s", diInfo[i][diName], item);
        if(!strcmp(diInfo[i][diName], item, true)) return diInfo[i][diID];
    }
    return -1;
}

forward GetItemRealID(item[]);
public GetItemRealID(item[]){
    for (new i = 0; i < MAX_DYNAMIC_ITEMS; i++){
        if(!diInfo[i][diExists])
            return -1;

        if(!strcmp(diInfo[i][diName], item)) return i;
    }
    return -1;
}

ShowPlayerInventory(playerid){
    new string[2048], money = GetMoney(playerid), title[128];

    if(money > 0) format(string, sizeof(string), "-6000\tDinheiro~n~~g~US$ %s\n", FormatNumber(money));
    else if(money <= 0) format(string, sizeof(string), "-6000\tDinheiro~n~~r~US$ %s\n", FormatNumber(0));

    for (new i = 0; i < GetInventorySlots(playerid); i++){
        if(pInfo[playerid][iItem][i] != 0) {
            format(string, sizeof(string), "%s%d\t%s~n~~n~~n~~n~~n~~y~(%d)~n~~w~%d\n", string,
            diInfo[pInfo[playerid][iItem][i]][diModel], diInfo[pInfo[playerid][iItem][i]][diName], pInfo[playerid][iAmount][i], i);
        }
    }
	format(title, sizeof(title), "Inventário de %s (%d/%d)", pNome(playerid), Inventory_Quantity(playerid), GetInventorySlots(playerid));
	AdjustTextDrawString(title);

    AdjustTextDrawString(string);
    Dialog_Show(playerid, PlayerInventory, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
    return true;
}

Dialog:PlayerInventory(playerid, response, listitem, inputtext[]) {
    if(response) {
        new model_id = strval(inputtext), slotid = listitem-1, title[128], string[256], money = GetMoney(playerid);

        if (model_id == -6000){
            if(GetMoney(playerid) < 1) return SendErrorMessage(playerid, "Você não possui dinheiro em mãos.");

            format(title, sizeof(title), "Dinheiro (US$ %s)", FormatNumber(money));
            format(string, sizeof(string), "Dar\nDropar\nDropar com edição\nJogar no lixo");
            Dialog_Show(playerid, PlayerInventorySelected, DIALOG_STYLE_LIST, title, string, "Selecionar", "Voltar");
            pInfo[playerid][pInventoryItem] = 999;
            return true;
        }

        if (diInfo[pInfo[playerid][iItem][slotid]][diUseful] == true) format(string, sizeof(string), "Usar\nDar\nDropar\nDropar com edição\nJogar no lixo\nDescrição");
        else format(string, sizeof(string), "Dar\nDropar\nDropar com edição\nJogar no lixo\nDescrição");

        pInfo[playerid][pInventoryItem] = slotid;

        format(title, sizeof(title), "%s (%d)", diInfo[pInfo[playerid][iItem][slotid]][diName], pInfo[playerid][iAmount][slotid]);
        Dialog_Show(playerid, PlayerInventorySelected, DIALOG_STYLE_LIST, title, string, "Selecionar", "Voltar");
    } 
    return true;
}

Dialog:PlayerInventorySelected(playerid, response, listitem, inputtext[]) {
    if (response) {
        new slotid = pInfo[playerid][pInventoryItem];
        
        if (!strcmp(inputtext, "Usar", true))
			return SendServerMessage(playerid, "Indisponível no momento.");  
        if (!strcmp(inputtext, "Dar", true))
			return PlayerGiveItem(playerid, slotid);
        if (!strcmp(inputtext, "Dropar", true))
            return PlayerDropItem(playerid, slotid);
        if (!strcmp(inputtext, "Dropar com edição", true))
            return PlayerDropItemWithEdit(playerid, slotid); 
        if (!strcmp(inputtext, "Jogar no lixo", true))
			return SendServerMessage(playerid, "Indisponível no momento."); 
        if (!strcmp(inputtext, "Descrição", true))
            return ShowItemDescription(playerid, slotid);
            
    } else ShowPlayerInventory(playerid);
    return true;
}

ShowItemDescription(playerid, slotid) {
    new string[512], title[128];

    format(title, sizeof(title), "{FFFFFF}%s", diInfo[pInfo[playerid][iItem][slotid]][diName]);

    if (strlen(diInfo[pInfo[playerid][iItem][slotid]][diDescription]) > 128) format(string, sizeof(string), "{FFFFFF}%.64s\n%s", diInfo[pInfo[playerid][iItem][slotid]][diDescription], diInfo[pInfo[playerid][iItem][slotid]][diDescription][64]);
	else format(string, sizeof(string), "{FFFFFF}%s", diInfo[pInfo[playerid][iItem][slotid]][diDescription]);

    Dialog_Show(playerid, Dg_ShowItemDescription, DIALOG_STYLE_MSGBOX, title, string, "Voltar", "Fechar");
    return true;
}

Dialog:Dg_ShowItemDescription(playerid, response, listitem, inputtext[]) {
    if (response) ShowPlayerInventory(playerid);
    else pInfo[playerid][pInventoryItem] = -1;
    return true;
}

IsDrugItemByID(itemid) {
	if(itemid == -1)
		return false;
	else if(diInfo[itemid][diCategory] == 7){
		return true;
    }
	else
		return false;
}

Inventory_Drug_Count(playerid, item[]) {
	new itemid = GetItemID(item);
	if(itemid == -1) return false;

	if(IsDrugItemByID(itemid)) {
		for (new i = 0; i < GetInventorySlots(playerid); i ++) {
            printf("pInfo[playerid][iItem][i] %d / itemid %d", pInfo[playerid][iItem][i], itemid);

            if(pInfo[playerid][iItem][i] == itemid) {
                return pInfo[playerid][iAmount][i];
            }
        }
	}
    return false;
}

Inventory_Drug_Slot(playerid, item[]) {
	new itemid = GetItemID(item);
	if(itemid == -1) return false;

	if(IsDrugItemByID(itemid)) {
		for (new i = 0; i < GetInventorySlots(playerid); i ++) {
            if(pInfo[playerid][iItem][i] == itemid) {
                return i;
            }
        }
	}
    return false;
}
