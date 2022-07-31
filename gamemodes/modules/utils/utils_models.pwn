#include <YSI_Coding\y_hooks>

/*new baseurl[] = "http://158.69.184.5/";
public OnPlayerRequestDownload(playerid, type, crc)
{
	if(!IsPlayerConnected(playerid))
		return false;

	new fullurl[256+1], dlfilename[64+1], foundfilename = 0;

	if(type == DOWNLOAD_REQUEST_TEXTURE_FILE)
		foundfilename = FindTextureFileNameFromCRC(crc, dlfilename, 64);
	else if(type == DOWNLOAD_REQUEST_MODEL_FILE)
		foundfilename = FindModelFileNameFromCRC(crc, dlfilename, 64);

	if(foundfilename){
		format(fullurl, 256, "%s/%s", baseurl, dlfilename);
		RedirectDownload(playerid, fullurl);
	}

	return true;
}*/

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return true;
}

hook OnGameModeInit(){
    LoadInterfaces();
    return true;
}

LoadInterfaces(){ // -9000 +
    AddSimpleModel(-1, 19379, -9000, "interface/interface.dff", "interface/login.txd");
    AddSimpleModel(-1, 19379, -9001, "interface/interface.dff", "interface/character.txd");
    AddSimpleModel(-1, 19379, -9002, "interface/interface.dff", "interface/news.txd");
}


