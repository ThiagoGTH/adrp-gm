ItemCreate(name, model) {
    for (new i = 0; i != MAX_DYNAMIC_ITEMS; i ++) {
        if (!diInfo[i][diExists]) {

            diInfo[i][diExists] = true;
            format(diInfo[i][diName], 64, "%s", name);
            format(diInfo[i][diDescription], 256, "Nenhum");
            diInfo[i][diModel] = model;
            diInfo[i][diCategory] = 0;
            diInfo[i][diUseful] = false;

            mysql_format(DBConn, query, sizeof query, "INSERT INTO items (`item_name`, `item_model`) VALUES ('%s', '%d');", name, model);
            new Cache:result = mysql_query(DBConn, query);       
            diInfo[i][diID] = cache_delete(result);
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
        if (diInfo[id][diExists]) return false;

        diInfo[id][diID] = id;
        diInfo[id][diExists] = true;
        cache_get_value_name(i, "item_name", diInfo[id][diName]);
        cache_get_value_name(i, "item_desc", diInfo[id][diDescription]);
        cache_get_value_name_int(i, "item_useful", diInfo[id][diUseful]);
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
        new id;
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

Inventory_Add(playerid, item[], quantity = 1){
    new slotid = Inventory_SlotFree(playerid);
    if(slotid != -1){
        pInfo[playerid][iItem][slotid] = GetItemID(playerid, item);
        pInfo[playerid][iAmount][slotid] = quantity;
        return slotid;
    }
    return -1;
}

Inventory_Remove(playerid, slotid, quantity = 1){
    if(pInfo[playerid][iAmount][slotid] > 1) return pInfo[playerid][iAmount][slotid] -= quantity;
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
	new count = 0;

	for (new i = 0; i < MAX_INVENTORY_SLOTS; i ++) {
	    if(pInfo[playerid][iItem][i] != 0) count++;
	}

	return count;
}

Inventory_SlotFree(playerid){
    new value = GetInventorySlots(playerid);
    for (new i = 0; i < value; i++){
        if(pInfo[playerid][iItem][i] == 0 && pInfo[playerid][iAmount][i] == 0) {
            return i;
        }
    }
    return -1;
}

forward GetItemID(playerid, item[]);
public GetItemID(playerid, item[]){
    for (new i = 0; i < MAX_DYNAMIC_ITEMS; i++){
        if(!diInfo[i][diExists])
            return -1;

        if(!strcmp(diInfo[i][diName], item)) return i;
    }
    return -1;
}

ShowPlayerInventory(playerid){
    new string[2048], value = GetInventorySlots(playerid), money = GetMoney(playerid), count = 0, title[128];

    if(money > 0) format(string, sizeof(string), "1212\tDinheiro~n~~g~US$ %s\n", FormatNumber(money));
    else if(money <= 0) format(string, sizeof(string), "1212\tDinheiro~n~~r~US$ %s\n", FormatNumber(0));

    for (new i = 0; i < value; i++){
        if(pInfo[playerid][iItem][i] != 0) {
            format(string, sizeof(string), "%s%d\t%s~n~~n~~n~~n~~n~~y~(%d)~n~~w~%d\n", string,
            diInfo[pInfo[playerid][iItem][i]][diModel], diInfo[pInfo[playerid][iItem][i]][diName], pInfo[playerid][iAmount][i], i);
            count++;
        }
    }
	format(title, sizeof(title), "Inventário de %s (%d/%d)", pNome(playerid), count, value);
	AdjustTextDrawString(title);

    AdjustTextDrawString(string);
    Dialog_Show(playerid, PlayerInventory, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
    return true;
}

Dialog:PlayerInventory(playerid, response, listitem, inputtext[]) {
    if(response) {
        new model_id = strval(inputtext), slotid = listitem-1, title[128], string[256], money = GetMoney(playerid);

        if (model_id == 1212){
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
        

        if (!strcmp(inputtext, "Dropar", true))
            return PlayerDropItem(playerid, slotid);
        if (!strcmp(inputtext, "Dropar com edição", true))
            return PlayerDropItemWithEdit(playerid, slotid);  
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

PlayerDropItem(playerid, slotid) {
    if (IsPlayerInAnyVehicle(playerid) || !IsPlayerSpawned(playerid)) 
        return SendErrorMessage(playerid, "Você não pode dropar itens neste momento.");

    if (pInfo[playerid][pInventoryItem] == 999) {
        if(GetMoney(playerid) < 1) return SendErrorMessage(playerid, "Você não possui dinheiro em mãos.");
        new money = GetMoney(playerid);

        Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Dinheiro", "Dinheiro em mãos: US$ %s\n\nPor favor, especifique quantos dólares você deseja dropar:", "Dropar", "Cancelar", FormatNumber(money));
    } else if (pInfo[playerid][iAmount][slotid] == 1) DropPlayerItem(playerid, slotid);
	else Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Item", "Item: %s - Quantidade: %d\n\nPor favor, especifique a quantidade que você deseja dropar deste item:", "Dropar", "Cancelar", diInfo[pInfo[playerid][iItem][slotid]][diName], pInfo[playerid][iAmount][slotid]);

    return true;
}

Dialog:DropItem(playerid, response, listitem, inputtext[]) {
	new slotid = pInfo[playerid][pInventoryItem];

	if (response) {
        if(slotid == 999) {
            new money = GetMoney(playerid);
            if (isnull(inputtext))
                return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Dinheiro", "Dinheiro em mãos: US$ %s\n\nPor favor, especifique quantos dólares você deseja dropar:", "Dropar", "Cancelar", FormatNumber(money));

            if (strval(inputtext) < 1 || strval(inputtext) > money)
                return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Dinheiro", "ERRO: O valor especificado é inválido.\n\nDinheiro em mãos: US$ %s\n\nPor favor, especifique quantos dólares você deseja dropar:", "Dropar", "Cancelar", FormatNumber(money));
                
            DropPlayerItem(playerid, slotid, strval(inputtext));
        } else {
            if (isnull(inputtext))
                return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Item", "Item: %s - Quantidade: %d\n\nPor favor, especifique a quantidade que você deseja dropar deste item:", "Dropar", "Cancelar", diInfo[pInfo[playerid][iItem][slotid]][diName], pInfo[playerid][iAmount][slotid]);
                
            if (strval(inputtext) < 1 || strval(inputtext) > pInfo[playerid][iAmount][slotid])
                return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Item", "ERRO: A quantidade especificada é inválida.\n\nItem: %s - Quantidade: %d\n\nPor favor, especifique a quantidade que você deseja dropar deste item:", "Dropar", "Cancelar", diInfo[pInfo[playerid][iItem][slotid]][diName], pInfo[playerid][iAmount][slotid]);
                
            DropPlayerItem(playerid, slotid, strval(inputtext));
        }
	}
	return 1;
}

DropPlayerItem(playerid, slotid, quantity = 1) {
    static
		Float:x,
  		Float:y,
    	Float:z,
		Float:angle,
		interior,
        world;

    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
    world = GetPlayerVirtualWorld(playerid);
    interior = GetPlayerInterior(playerid);

    if(slotid == 999){
        va_SendClientMessage(playerid, 0xFF00FFFF, "INFO: Este item desaparecerá no próximo shutdown diário.");

        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s dropou US$ %s.", pNome(playerid), FormatNumber(quantity));

        format(logString, sizeof(logString), "%s (%s) dropou US$ %s em %s (%.4f, %.4f, %.4f)", pNome(playerid), GetPlayerUserEx(playerid), FormatNumber(quantity), GetPlayerLocation(playerid), x, y, z);
        logCreate(playerid, logString, 18);

        DropItem(playerid, -1, 1212, quantity, x, y, z, interior, world);
        GiveMoney(playerid, -quantity);
    } else {
        if(GetPlayerVirtualWorld(playerid) == 0) va_SendClientMessage(playerid, 0xFF00FFFF, "INFO: Este item desaparecerá no próximo shutdown diário, apenas itens dropados em interiores não somem após o shutdown.");

        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s dropou um(a) %s.", pNome(playerid), diInfo[pInfo[playerid][iItem][slotid]][diName]);

        format(logString, sizeof(logString), "%s (%s) dropou um(a) %s (%d) em %s (%.4f, %.4f, %.4f)", pNome(playerid), GetPlayerUserEx(playerid), diInfo[pInfo[playerid][iItem][slotid]][diName], quantity, GetPlayerLocation(playerid), x, y, z);
        logCreate(playerid, logString, 18);

        DropItem(playerid, diInfo[pInfo[playerid][iItem][slotid]][diID], diInfo[pInfo[playerid][iItem][slotid]][diModel], quantity, x, y, z, interior, world);

        Inventory_Remove(playerid, slotid, quantity);
    }
    return true;
}

PlayerDropItemWithEdit(playerid, slotid) {

    if (IsPlayerInAnyVehicle(playerid) || !IsPlayerSpawned(playerid)) 
        return SendErrorMessage(playerid, "Você não pode dropar itens neste momento.");

    if (pInfo[playerid][pInventoryItem] == 999) {
        if(GetMoney(playerid) < 1) return SendErrorMessage(playerid, "Você não possui dinheiro em mãos.");
        new money = GetMoney(playerid);

        Dialog_Show(playerid, DropItemWithEdit, DIALOG_STYLE_INPUT, "Dropar Dinheiro", "Dinheiro em mãos: US$ %s\n\nPor favor, especifique quantos dólares você deseja dropar:", "Dropar", "Cancelar", FormatNumber(money));
    } else if (pInfo[playerid][iAmount][slotid] == 1) DropPlayerItemWithEdit(playerid, slotid);
	else Dialog_Show(playerid, DropItemWithEdit, DIALOG_STYLE_INPUT, "Dropar Item", "Item: %s - Quantidade: %d\n\nPor favor, especifique a quantidade que você deseja dropar deste item:", "Dropar", "Cancelar", diInfo[pInfo[playerid][iItem][slotid]][diName], pInfo[playerid][iAmount][slotid]);	
	return 1;
}

Dialog:DropItemWithEdit(playerid, response, listitem, inputtext[]) {
	new slotid = pInfo[playerid][pInventoryItem];

	if (response) {
        if(slotid == 999) {
            new money = GetMoney(playerid);
            if (isnull(inputtext))
                return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Dinheiro", "Dinheiro em mãos: US$ %s\n\nPor favor, especifique quantos dólares você deseja dropar:", "Dropar", "Cancelar", FormatNumber(money));

            if (strval(inputtext) < 1 || strval(inputtext) > money)
                return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Dinheiro", "ERRO: O valor especificado é inválido.\n\nDinheiro em mãos: US$ %s\n\nPor favor, especifique quantos dólares você deseja dropar:", "Dropar", "Cancelar", FormatNumber(money));
                
            DropPlayerItemWithEdit(playerid, slotid, strval(inputtext));
        } else {
            if (isnull(inputtext))
                return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Item", "Item: %s - Quantidade: %d\n\nPor favor, especifique a quantidade que você deseja dropar deste item:", "Dropar", "Cancelar", diInfo[pInfo[playerid][iItem][slotid]][diName], pInfo[playerid][iAmount][slotid]);
                
            if (strval(inputtext) < 1 || strval(inputtext) > pInfo[playerid][iAmount][slotid])
                return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Dropar Item", "ERRO: A quantidade especificada é inválida.\n\nItem: %s - Quantidade: %d\n\nPor favor, especifique a quantidade que você deseja dropar deste item:", "Dropar", "Cancelar", diInfo[pInfo[playerid][iItem][slotid]][diName], pInfo[playerid][iAmount][slotid]);
                
            DropPlayerItemWithEdit(playerid, slotid, strval(inputtext));
        }
	}
	return 1;
}

DropPlayerItemWithEdit(playerid, slotid, quantity = 1) {
    static
		Float:x,
  		Float:y,
    	Float:z,
		Float:angle,
		interior,
        world;

    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
    world = GetPlayerVirtualWorld(playerid);
    interior = GetPlayerInterior(playerid);

    if(slotid == 999){
        va_SendClientMessage(playerid, 0xFF00FFFF, "INFO: Este item desaparecerá no próximo shutdown diário.");

        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s dropou US$ %s.", pNome(playerid), FormatNumber(quantity));

        format(logString, sizeof(logString), "%s (%s) dropou US$ %s em %s (%.4f, %.4f, %.4f)", pNome(playerid), GetPlayerUserEx(playerid), FormatNumber(quantity), GetPlayerLocation(playerid), x, y, z);
        logCreate(playerid, logString, 18);

        pInfo[playerid][pEditDropped] = DropItem(playerid, -1, 1212, quantity, x, y, z, interior, world);

        GiveMoney(playerid, -quantity);

        SetTimerEx("EditDynObject", 1000, false, "ii", playerid, DroppedItems[pInfo[playerid][pEditDropped]][droppedObject]);
    } else {
        if(GetPlayerVirtualWorld(playerid) == 0) va_SendClientMessage(playerid, 0xFF00FFFF, "INFO: Este item desaparecerá no próximo shutdown diário, apenas itens dropados em interiores não somem após o shutdown.");

        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s dropou um(a) %s.", pNome(playerid), diInfo[pInfo[playerid][iItem][slotid]][diName]);

        format(logString, sizeof(logString), "%s (%s) dropou um(a) %s (%d) em %s (%.4f, %.4f, %.4f)", pNome(playerid), GetPlayerUserEx(playerid), diInfo[pInfo[playerid][iItem][slotid]][diName], quantity, GetPlayerLocation(playerid), x, y, z);
        logCreate(playerid, logString, 18);

        pInfo[playerid][pEditDropped] = DropItem(playerid, diInfo[pInfo[playerid][iItem][slotid]][diID], diInfo[pInfo[playerid][iItem][slotid]][diModel], quantity, x, y, z, interior, world);

        Inventory_Remove(playerid, slotid, quantity);

        SetTimerEx("EditDynObject", 1000, false, "ii", playerid, DroppedItems[pInfo[playerid][pEditDropped]][droppedObject]);
    }
    return true;
}

DropItem(playerid, item, model, quantity, Float:x, Float:y, Float:z, interior, world, weaponid = 0, ammo = 0) {
    for (new i = 0; i != MAX_DROPPED_ITEMS; i ++) if (!DroppedItems[i][droppedModel]) {
        z = z-1.0;

	    DroppedItems[i][droppedPlayer] = playerid;
		DroppedItems[i][droppedModel] = model;
        DroppedItems[i][droppedItem] = item;
		DroppedItems[i][droppedQuantity] = quantity;
		DroppedItems[i][droppedWeapon] = weaponid;
  		DroppedItems[i][droppedAmmo] = ammo;
		DroppedItems[i][droppedPos][0] = x;
		DroppedItems[i][droppedPos][1] = y;
		DroppedItems[i][droppedPos][2] = z;
		DroppedItems[i][droppedPos][3] = 0.0;
		DroppedItems[i][droppedPos][4] = 0.0;
		DroppedItems[i][droppedPos][5] = 0.0;
        DroppedItems[i][droppedInt] = interior;
		DroppedItems[i][droppedWorld] = world;
        if (IsWeaponModel(model)) {
			DroppedItems[i][droppedObject] = CreateDynamicObject(model, x, y, z, 93.7, 120.0, 120.0, world, interior);
			DroppedItems[i][droppedPos][3] = 93.7;
			DroppedItems[i][droppedPos][4] = 120.0;
			DroppedItems[i][droppedPos][5] = 120.0;
		} else DroppedItems[i][droppedObject] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, 0.0, world, interior, -1);

        mysql_format(DBConn, query, sizeof query, "INSERT INTO `items_dropped` (\
        `item_id`, \
        `item_player`, \
        `item_model`, \
        `item_quantity`, \
        `item_weapon`, \
        `item_ammo`, \
        `item_int`, \
        `item_world`, \
        `item_positionX`, \
        `item_positionY`, \
        `item_positionZ`) VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%.4f', '%.4f', '%.4f');", item, pInfo[playerid][pID], model, quantity, weaponid, ammo, interior, world, x, y, z);
        new Cache:result = mysql_query(DBConn, query);
        cache_delete(result);
        return i;
    }
    return -1;
}