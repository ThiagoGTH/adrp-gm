#include <YSI_Coding\y_hooks>

ItemCreate(name, model){
    for (new i = 0; i != MAX_DYNAMIC_ITEMS; i ++) {
        if (!diInfo[i][diExists]) {

            diInfo[i][diExists] = true;
            format(diInfo[i][diName], 64, "%s", name);
            format(diInfo[i][diDescription], 256, "Nenhum");
            diInfo[i][diModel] = model;
            diInfo[i][diCategory] = 0;

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
    mysql_query(DBConn, "SELECT * FROM `items` WHERE (`ID` != '0) AND (`model` != '0');");

    for (new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "ID", id);

        if (diInfo[id][diExists]) return false;

        diInfo[id][diID] = id;
        diInfo[id][diExists] = true;
        cache_get_value_name(i, "item_name", diInfo[id][diName]);
        cache_get_value_name(i, "item_desc", diInfo[id][diDescription]);
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
        pInfo[playerid][iItem][slotid] = 
    }
}

Inventory_SlotFree(playerid){
    new value;

    switch(pInfo[playerid][pDonator]){
        case 0: value = 15;
        case 1: value = 20;
        case 2: value = 25;
        case 3: value = 30;
        default: value = 15;
    }

    for (new i = 0; i < value; i++){
        if(pInfo[playerid][iItem][i] == 0 && pInfo[playerid][iAmount][i] == 0) {
            return i;
        }
    }
    return -1;
}

GetItemID(playerid, item[]){
    for (new i = 0; i < MAX_DYNAMIC_ITEMS; i++){
        if(!diInfo[i][diExists])
            return -1;

        if(!stcmp(diInfo[i][diName], item)) return i;
    }
    return -1;
}