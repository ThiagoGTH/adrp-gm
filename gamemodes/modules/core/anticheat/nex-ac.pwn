#include <YSI_Coding\y_hooks>

forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code) {
	if(type) BlockIpAddress(ip_address, 0);
	else {
		if(GetPlayerAdmin(playerid) > 1335) return true;
		switch(code) {
			case 38: return true;
			case 5, 6, 11, 14, 22, 32: return SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%s) suspeita de cheating (#%03d).", pNome(playerid), GetPlayerUserEx(playerid), code), format(logString, sizeof(logString), "%s (%s) suspeita de cheating (#%03d)", pNome(playerid), GetPlayerUserEx(playerid), code), logCreate(playerid, logString, 21);
			case 40: SendServerMessage(playerid, "Você excedeu o número máximo de conexões pelo seu IP. Tente novamente mais tarde.");
			case 41: SendServerMessage(playerid, "Esta versão do client não é adequada para jogar no servidor.");
			default: {
                SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%s) foi kickado por suspeita de cheating (#%03d).", pNome(playerid), GetPlayerUserEx(playerid), code);

                format(logString, sizeof(logString), "%s (%s) foi kickado por suspeita de cheating (#%03d)", pNome(playerid), GetPlayerUserEx(playerid), code);
                logCreate(playerid, logString, 21);
            }
		}
		AntiCheatKickWithDesync(playerid, code);
	}
	return true;
}


