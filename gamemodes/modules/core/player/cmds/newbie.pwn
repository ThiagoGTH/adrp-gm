/* Módulo dedicado a interação do help-center in-game */
#include <YSI_Coding\y_hooks>

CMD:hc(playerid, params[]){
    if (!pInfo[playerid][pLogged]) return true;
    if (!pInfo[playerid][pTogNewbie]) return SendErrorMessage(playerid, "Você não ativou o help-center, ative-o no /tog.");
    if (pInfo[playerid][pDelayNewbie] != 0) return SendErrorMessage(playerid, "Você não pode enviar outra mensagem no canal de dúvidas agora, espere mais alguns segundos.");
    if (isnull(params)) return SendSyntaxMessage(playerid, "/hc [dúvida]");

	if (strlen(params) > 64) {
		if (GetPlayerAdmin(playerid) > 0) {
			SendNewbieChat("[Help-center] %s %s: %.64s", AdminRankName(playerid), GetPlayerUserEx(playerid), params);
			SendNewbieChat("...%s", params[64]);
		}
		else if (uInfo[playerid][uNewbie]) {
			SendNewbieChat("[Help-center] Novato %s (ID: %d): %.64s", pNome(playerid), playerid, params);
			SendNewbieChat("...%s", params[64]);
			pInfo[playerid][pDelayNewbie] = 90;
		} else {
			SendNewbieChat("[Help-center] Jogador %s (ID: %d): %.64s", pNome(playerid), playerid, params);
			SendNewbieChat("...%s", params[64]);
			pInfo[playerid][pDelayNewbie] = 90;
		}
	} else {
		if (GetPlayerAdmin(playerid) > 0) {
			SendNewbieChat("[Help-center] %s %s: %s", AdminRankName(playerid), GetPlayerUserEx(playerid), params);
		}
		else if (uInfo[playerid][uNewbie]) {
			SendNewbieChat("[Help-center] Novato %s (ID: %d): %s", pNome(playerid), playerid, params);
			pInfo[playerid][pDelayNewbie] = 90;
		} else {
			SendNewbieChat("[Help-center] Jogador %s (ID: %d): %s", pNome(playerid), playerid, params);
			pInfo[playerid][pDelayNewbie] = 90;
		}
	}
    return true;
} alias:hc("n", "helpcenter")

CMD:novato(playerid, params[]) {
	if (!pInfo[playerid][pLogged]) return true;
	if (GetPlayerAdmin(playerid) < 2) return SendPermissionMessage(playerid);
	new userid;
	if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/novato [playerid/nome]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);

	if (uInfo[userid][uNewbie]) {
		uInfo[userid][uNewbie] = 0;
		SaveUserInfo(userid);

		SendServerMessage(playerid, "Você desmarcou %s (%s) como novato.", pNome(userid), GetPlayerUserEx(userid));
		SendServerMessage(userid, "Você foi desmarcado como novato por um administrador.");

		SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s desmarcou %s como novato.", GetPlayerUserEx(playerid), pNome(userid));

		// Cria o log administrativo
		format(logString, sizeof(logString), "%s (%s) desmarcou %s (%s) como novato", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), GetPlayerUserEx(userid));
		logCreate(playerid, logString, 1);

		// Cria o histórico do jogador
		format(logString, sizeof(logString), "%s (%s) foi desmarcado como novato por %s", pNome(userid), GetPlayerUserEx(userid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 11);		
	} else {
		uInfo[userid][uNewbie] = 1337;
        pInfo[playerid][pTogNewbie] = 0;
		SaveUserInfo(userid);

		SendServerMessage(playerid, "Você marcou %s (%s) como novato.", pNome(userid), GetPlayerUserEx(userid));
		SendServerMessage(userid, "Você foi marcado como novato por um administrador.");

		SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s marcou %s como novato.", GetPlayerUserEx(playerid), pNome(userid));

		// Cria o log administrativo
		format(logString, sizeof(logString), "%s (%s) marcou %s (%s) como novato", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid), GetPlayerUserEx(userid));
		logCreate(playerid, logString, 1);

		// Cria o histórico do jogador
		format(logString, sizeof(logString), "%s (%s) foi marcado como novato por %s", pNome(userid), GetPlayerUserEx(userid), GetPlayerUserEx(playerid));
		logCreate(playerid, logString, 11);	
	}
	return true;
}

CMD:novatos(playerid, params[]) {
    if (!pInfo[playerid][pLogged]) return true;

	new count = 0;
	SendClientMessage(playerid, COLOR_GREEN, "Novatos:");
    foreach (new i : Player) if (uInfo[i][uNewbie] == 1337){
		va_SendClientMessage(playerid, COLOR_GREY, "%s (ID: %d)", pNome(playerid), i);
        count++;
	}
	if (!count) 
	    SendClientMessage(playerid, COLOR_GREY, "Não há novatos online neste momento.");
	return true;
}

SendNewbieChat(const str[], {Float,_}:...) {
	static
	    args,
	    start,
	    end,
	    string[144];

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8) {
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player) {
			if (pInfo[i][pTogNewbie] == 0) {
  				SendClientMessage(i, 0x0195EFFF, string);
			}
		}
		return true;
	}
	foreach (new i : Player) {
		if (pInfo[i][pTogNewbie] == 0) {
			SendClientMessage(i, 0x0195EFFF, str);
		}
	}
	return true;
}