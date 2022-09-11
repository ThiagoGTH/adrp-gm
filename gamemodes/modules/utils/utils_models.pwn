#include <YSI_Coding\y_hooks>

public OnPlayerRequestDownload(playerid, type, crc) {
	if(!IsPlayerConnected(playerid))
		return false;

	InterpolateCameraPos(playerid, 1307.082153, -1441.499755, 221.137145, 1307.082153, -1441.499755, 221.137145, 1000);
    InterpolateCameraLookAt(playerid, 1311.717285, -1439.645874, 220.856262, 1311.717285, -1439.645874, 220.856262, 1000);

	return true;
}

hook OnGameModeInit(){
    LoadInterfaces();
	LoadObjects();
	LoadPets();
	LoadItemsModels();
    return true;
}

LoadObjects(){
	AddSimpleModel(-1, 19379, -1000, "objects/trailers/trailer1.dff", "objects/trailers/trailer1.txd");
}

LoadInterfaces(){ // -9000 +
	AddSimpleModel(-1, 19379, -9000, "interface/interface.dff", "interface/interface.txd");
	AddSimpleModel(-1, 19379, -9001, "interface/interface.dff", "interface/notify.txd");
    AddSimpleModel(-1, 19379, -9002, "interface/interface.dff", "interface/news.txd");
	AddSimpleModel(-1, 19379, -9003, "interface/interface.dff", "interface/slot_machine.txd");
}


