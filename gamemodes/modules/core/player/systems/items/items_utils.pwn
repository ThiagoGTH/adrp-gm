#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_ITEMS               (10)
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

hook OnGameModeInit() {
    LoadItems();
    return true;
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