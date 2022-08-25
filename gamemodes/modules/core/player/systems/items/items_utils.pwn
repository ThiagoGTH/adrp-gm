#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_ITEMS               (10)
#define MAX_DROPPED_ITEMS               (5)

#define MAX_INVENTORY_SLOTS             (30)

enum DI_ITEMS_DATA {
    diID,
    bool:diExists,
    diName[64],
    diDescription[256],
    bool:diUseful,
    diModel,
    diCategory,
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
		case 2: format(category, sizeof(category), "Itens de evento");
        case 3: format(category, sizeof(category), "Itens de facções");
		case 4: format(category, sizeof(category), "Coletes");
		case 5: format(category, sizeof(category), "Drogas");
		case 6: format(category, sizeof(category), "Armas");
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