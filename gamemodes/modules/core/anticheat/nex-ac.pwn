#include <YSI_Coding\y_hooks>

forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code) {
	if(type) BlockIpAddress(ip_address, 0);
	else
	{
		switch(code)
		{
			case 5, 6, 11, 14, 22, 32: return 1;
			case 40: SendServerMessage(playerid, "Voc� excedeu o n�mero m�ximo de conex�es pelo seu IP. Tente novamente mais tarde.");
			case 41: SendServerMessage(playerid, "Esta vers�o do client n�o � adequada para jogar no servidor.");
			default: {
                SendServerMessage(playerid, "Voc� foi kickado por suspeitas de uso de cheating (#%03d).", code);

                SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%s) foi kickado por suspeita de cheating (#%03d).", pNome(playerid), GetPlayerUserEx(playerid), code);

                format(logString, sizeof(logString), "%s (%s) foi kickado por suspeita de cheating (#%03d)", pNome(playerid), GetPlayerUserEx(playerid), code);
                logCreate(playerid, logString, 21);
            }
		}
		AntiCheatKickWithDesync(playerid, code);
	}
	return true;
}