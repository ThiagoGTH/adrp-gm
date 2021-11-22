#include <YSI_Coding\y_hooks>

new DCC_Channel:DC_ChatAdmin,
    DCC_Channel:DC_EntrouSaiu,
    DCC_Channel:DC_AdminCMD,
    DCC_Channel:DC_BotChannel,
    DCC_Channel:DC_BotChannelHead,
    DCC_Channel:DC_Status,
    DCC_Channel:DC_AllAdminLogs,
    DCC_Channel:DC_VehUniques,
    DCC_Channel:DC_LogFac,
    DCC_Channel:DC_LogVeh,
    DCC_Channel:DC_LogHouse,
    DCC_Channel:DC_LogFurniture;

stock ReturnDate()
{
	new sendString[90], month, day, year;
	new hour, minute, second;

	gettime(hour, minute, second);
	getdate(year, month, day);

	format(sendString, 90, "%d/%d/%d - %02d:%02d:%02d", day, month, year, hour, minute, second);
	return sendString;
}

hook OnGameModeInit()
{
    DC_ChatAdmin = DCC_FindChannelById("894356989088518144");
    DC_EntrouSaiu = DCC_FindChannelById("894357604954935356");
    DC_AdminCMD = DCC_FindChannelById("894347595596595210"); 
    DC_BotChannel = DCC_FindChannelById("894436274298060831"); 
    DC_BotChannelHead = DCC_FindChannelById("911397150196387853"); 
    DC_Status = DCC_FindChannelById("894976320319139840");
    DC_AllAdminLogs = DCC_FindChannelById("895683123617095690");
    DC_VehUniques = DCC_FindChannelById("895737908760313876");
    DC_LogFac = DCC_FindChannelById("894347625132863528");
    DC_LogVeh = DCC_FindChannelById("898359436966526976");
    DC_LogHouse = DCC_FindChannelById("911299679768166511");
    DC_LogFurniture = DCC_FindChannelById("911302339988697088");
    return 1;
}


