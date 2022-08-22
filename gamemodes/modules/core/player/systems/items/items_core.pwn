#include <YSI_Coding\y_hooks>

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
    mysql_query(DBConn, "SELECT * FROM `items` WHERE (`ID` != '0') AND (`item_model` != '0');");

    for (new i; i < cache_num_rows(); i++) {
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
    printf("[ITENS DINAMICOS]: %d itens dinâmicos carregados com sucesso.", loadeditems);
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

GetInventorySlots(playerid){
    new value;
    switch(pInfo[playerid][pDonator]){
        case 0: value = 15;
        case 1: value = 20;
        case 2: value = 25;
        case 3: value = 30;
        default: value = 15;
    }
    return value;
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

CMD:teste(playerid, params[]){
    new value = GetInventorySlots(playerid);
    for (new i = 0; i < value; i++) {
        if(pInfo[playerid][iItem][i] != 0) {
            va_SendClientMessage(playerid, -1, "{%d} %s (%d) [%d]", diInfo[pInfo[playerid][iItem][i]][diModel], 
            diInfo[pInfo[playerid][iItem][i]][diName], 
            pInfo[playerid][iAmount][i], i);
        }
    }
    return true;
}

ShowPlayerInventory(playerid){
    new string[2048], value = GetInventorySlots(playerid), money = GetMoney(playerid), count = 0, title[128];

    if(money > 0) format(string, sizeof(string), "1212\tDinheiro~n~~g~%s\n", FormatNumber(money));
    else if(money <= 0) format(string, sizeof(string), "1212\tDinheiro~n~~r~US$ %s\n", FormatNumber(0));

    for (new i = 0; i < value; i++){
        if(pInfo[playerid][iItem][i] != 0) {
            format(string, sizeof(string), "%s%d\t%s~n~~n~~n~~n~~n~~y~(%d)~n~~w~%d\n", string,
            diInfo[pInfo[playerid][iItem][i]][diModel], diInfo[pInfo[playerid][iItem][i]][diName], pInfo[playerid][iAmount][i], i);
            count++;
        }
    }
    //AdjustTextDrawString(string);

	format(title, sizeof(title), "Inventário de %s (%d/%d)", pNome(playerid), count, value);
	AdjustTextDrawString(title);

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
            return true;
        }

        if (diInfo[pInfo[playerid][iItem][listitem]][diUseful] == true) format(string, sizeof(string), "Usar\nDar\nDropar\nDropar com edição\nJogar no lixo\nDescrição");
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

        if (!strcmp(inputtext, "Descrição", true))
            return ShowItemDescription(playerid, slotid);
    } else ShowPlayerInventory(playerid);
    return true;
}

ShowItemDescription(playerid, slotid){
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