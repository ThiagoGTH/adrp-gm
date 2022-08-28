#include <YSI_Coding\y_hooks>

new baseurl[] = "http://26.244.244.209/models/";
public OnPlayerRequestDownload(playerid, type, crc) {
	if(!IsPlayerConnected(playerid))
		return false;

	InterpolateCameraPos(playerid, 1307.082153, -1441.499755, 221.137145, 1307.082153, -1441.499755, 221.137145, 1000);
    InterpolateCameraLookAt(playerid, 1311.717285, -1439.645874, 220.856262, 1311.717285, -1439.645874, 220.856262, 1000);

	new fullurl[256+1], dlfilename[64+1], foundfilename = 0;
	if(type == DOWNLOAD_REQUEST_TEXTURE_FILE)
		foundfilename = FindTextureFileNameFromCRC(crc, dlfilename, 64);
	else if(type == DOWNLOAD_REQUEST_MODEL_FILE)
		foundfilename = FindModelFileNameFromCRC(crc, dlfilename, 64);

	if(foundfilename) {
		format(fullurl, 256, "%s/%s", baseurl, dlfilename);
		RedirectDownload(playerid, fullurl);
	}
	return true;
}

public OnPlayerFinishedDownloading(playerid, virtualworld) {
	
	return true;
}

hook OnGameModeInit(){
    LoadInterfaces();
	LoadObjects();
	LoadPets();
    return true;
}

LoadObjects(){
	AddSimpleModel(-1, 19379, -1000, "objects/trailers/trailer1.dff", "objects/trailers/trailer1.txd");
}

LoadInterfaces(){ // -9000 +
	AddSimpleModel(-1, 19379, -9000, "interface/interface.dff", "interface/interface.txd");
	AddSimpleModel(-1, 19379, -9001, "interface/interface.dff", "interface/notify.txd");
    AddSimpleModel(-1, 19379, -9002, "interface/interface.dff", "interface/news.txd");
}


