#include <YSI_Coding\y_hooks>

new DCC_Channel:logChannels[7];
forward Discord_StartChannels();
public Discord_StartChannels(){
    logChannels[0] = DCC_FindChannelById("989303818896441345");     // Admin                (1)
    logChannels[1] = DCC_FindChannelById("989304049931268116");     // Login/Logout         (2)
    logChannels[2] = DCC_FindChannelById("990667978792116405");     // Comandos usados      (3)
    logChannels[3] = DCC_FindChannelById("989303613434253333");     // Deletar personagem   (4)
    logChannels[4] = DCC_FindChannelById("990686226216517642");     // System               (5)
    logChannels[5] = DCC_FindChannelById("991552258015776878");     // Mortes               (6)
    logChannels[6] = DCC_FindChannelById("991846277329465526");     // Investida            (7)
    
    return true;
}

forward Discord_PublishLog(playerid, log[], type);
public Discord_PublishLog(playerid, log[], type) {
    new convertedType = type-1;
    new string[512];
    format(string, 512, "```[%s] %s```", GetFullDate(gettime()), log);
    utf8encode(string, string);
    DCC_SendChannelMessage(logChannels[convertedType], string);
    return true;
}

hook OnGameModeInit(){
    Discord_StartChannels();
}

stock ReturnDate()
{
	new sendString[90], month, day, year;
	new hour, minute, second;

	gettime(hour, minute, second);
	getdate(year, month, day);

	format(sendString, 90, "%d/%d/%d - %02d:%02d:%02d", day, month, year, hour, minute, second);
	return sendString;
}


