#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_ITEMS               (10)
#define MAX_DROPPED_ITEMS               (500)

#define MAX_INVENTORY_SLOTS             (30)

enum DI_ITEMS_DATA {
    diID,
    bool:diExists,
    diName[64],
    diDescription[256],
    bool:diUseful,
	bool:diLegality,
    diModel,
    diCategory,
	diPrice,
};

new diInfo[MAX_DYNAMIC_ITEMS][DI_ITEMS_DATA];

enum DROPPED_ITEMS_DATA {
	droppedID,
    bool:droppedExists,
	droppedItem,
	droppedPlayer,
	droppedModel,
	droppedQuantity,
	Float:droppedPos[6],
	droppedWeapon,
	droppedAmmo,
	droppedInt,
	droppedWorld,
	droppedObject,
};

new DroppedItems[MAX_DROPPED_ITEMS][DROPPED_ITEMS_DATA];

hook OnGameModeInit() {
    LoadItems();
	LoadDroppeds();
}

OrganizeInventory(playerid) {
    for(new i = 0; i < GetInventorySlots(playerid); i++) {
        if(pInfo[playerid][iItem][i] != 0) {
            for(new a = 0; a < GetInventorySlots(playerid); a++) {
                if(pInfo[playerid][iItem][a] == 0) {
                    pInfo[playerid][iItem][a] = pInfo[playerid][iItem][i];
					pInfo[playerid][iAmount][a] = pInfo[playerid][iAmount][i];
					pInfo[playerid][iItem][i] = 0;
					pInfo[playerid][iAmount][i] = 0;
                }
			}
		}
		return i;
	}
	return true;
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

ItemCategory(type) {
	new category[128];
	switch(type) {
        case 0: format(category, sizeof(category), "Inválido");
		case 1: format(category, sizeof(category), "Itens gerais");
		case 2: format(category, sizeof(category), "Itens comestíveis");
		case 3: format(category, sizeof(category), "Itens bebíveis");
		case 4: format(category, sizeof(category), "Itens de evento");
        case 5: format(category, sizeof(category), "Itens de facções");
		case 6: format(category, sizeof(category), "Coletes");
		case 7: format(category, sizeof(category), "Drogas");
		case 8: format(category, sizeof(category), "Armas");
	}
	return category;
}

IsWeaponModel(model) {
    static const g_aWeaponModels[] = {
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
    };
    for (new i = 0; i < sizeof(g_aWeaponModels); i ++) if (g_aWeaponModels[i] == model) {
        return true;
	}
	return false;
}

Item_Nearest(playerid) {
	for (new i = 0; i != MAX_DROPPED_ITEMS; i ++) if (DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2])) {
		if (GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld])
			return i;
	}
	return -1;
}

Item_Delete(itemid) {
    if (itemid != -1 && DroppedItems[itemid][droppedModel]) {
        DroppedItems[itemid][droppedModel] =
		DroppedItems[itemid][droppedQuantity] =
	    DroppedItems[itemid][droppedInt] =
	    DroppedItems[itemid][droppedWorld] = 0;

	    DroppedItems[itemid][droppedPos][0] =
	    DroppedItems[itemid][droppedPos][1] =
	    DroppedItems[itemid][droppedPos][2] =
	    DroppedItems[itemid][droppedPos][3] =
	    DroppedItems[itemid][droppedPos][4] =
	    DroppedItems[itemid][droppedPos][5] = 0.0;

		DroppedItems[itemid][droppedPlayer] = -1;
		DroppedItems[itemid][droppedExists] = false;



        if (IsValidDynamicObject(DroppedItems[itemid][droppedObject])) {
	    	DestroyDynamicObject(DroppedItems[itemid][droppedObject]);
	    	DroppedItems[itemid][droppedObject] = -1;
		}

		mysql_format(DBConn, query, sizeof query, "DELETE FROM `items_dropped` WHERE `ID` = '%d';", DroppedItems[itemid][droppedID]);
    	new Cache:result = mysql_query(DBConn, query);
		cache_delete(result);
	}
	return true;
}

Inventory_Add(playerid, item, quantity = 1){
	new value = GetInventorySlots(playerid);

    for (new i = 0; i < value; i++) {
        if(pInfo[playerid][iItem][i] == item) {
            pInfo[playerid][iAmount][i] += quantity;
            return i;
        }
    }
    for(new slotid = 0; slotid < value; slotid ++) {
        if(pInfo[playerid][iItem][slotid] == 0) {
            pInfo[playerid][iItem][slotid] = item;
            pInfo[playerid][iAmount][slotid] = quantity;
            return slotid;
        }
    }
    return -1;
}

stock Inventory_HasItem(playerid, const item[]) {
	new exists = false;
	for (new i = 0; i < GetInventorySlots(playerid); i ++) {
		if(!strcmp(diInfo[pInfo[playerid][iItem][i]][diName], item)){
			if(pInfo[playerid][iAmount][i] > 0){
				exists = true;
				return exists;
			}
		}
	}
	return exists;
}