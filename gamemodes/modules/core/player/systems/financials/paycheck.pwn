#include <YSI_Coding\y_hooks>

#define     NEWBIE_PAYMENT      5000        // Pagamento para as horas iniciais;
#define     NORMAL_PAYMENT      400         // Pagamento para as horas posteriores;
#define     MAX_SAVINGS         2000000     // Dinheiro máximo na poupança. O valor será o mesmo para todos os jogadores.

new DoublePaycheck = 0;                     // Pagamento duplo

hook OnGameModeInit(){
    SetTimer("MinuteCheck", 60000, true); // 1 minuto
    return true;
}

CMD:horas(playerid, params[]){
	static
	    string[128],
		month[12],
		date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	switch (date[1]) {
	    case 1: month = "Jan";
	    case 2: month = "Fev";
	    case 3: month = "Mar";
	    case 4: month = "Abr";
	    case 5: month = "Mai";
	    case 6: month = "Jun";
	    case 7: month = "Jul";
	    case 8: month = "Ago";
	    case 9: month = "Set";
	    case 10: month = "Out";
	    case 11: month = "Nov";
	    case 12: month = "Dez";
	}

	va_SendClientMessage(playerid, COLOR_GREEN, "%d/60 minutos para o pagamento.", pInfo[playerid][pPlayingMinutes]);
	if(uInfo[playerid][uJailed] > 0){
		va_SendClientMessage(playerid, COLOR_LIGHTRED, "Restam %d minutos para concluir sua sentença.", uInfo[playerid][uJailed]);
	}
	format(string, sizeof(string), "~w~%02d/%s/%d~n~~w~%02d:%02d:%02d", date[0], month, date[2], date[3], date[4], date[5]);
	GameTextForPlayer(playerid, string, 6000, 1);
	return true;
}

CMD:doublepd(playerid, params[]){
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    if (DoublePaycheck == 0){
        va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s ativou o pagamento duplo.", GetPlayerUserEx(playerid));
        DoublePaycheck = 1;
        format(logString, sizeof(logString), "%s (%s) ativou o pagamento duplo.", pNome(playerid), GetPlayerUserEx(playerid));
        logCreate(playerid, logString, 1);
    } else {
        va_SendClientMessageToAll(COLOR_LIGHTRED, "AdmCmd: %s desativou o pagamento duplo.", GetPlayerUserEx(playerid));
        DoublePaycheck = 0;
        format(logString, sizeof(logString), "%s (%s) desativou o pagamento duplo.", pNome(playerid), GetPlayerUserEx(playerid));
        logCreate(playerid, logString, 1);
    }
	return true;
}

CMD:pegarpaycheck(playerid, params[]){
    if(SERVER_TYPE == 2) {
        if(GetPlayerAdmin(playerid) < 1335) return SendPermissionMessage(playerid);
        pInfo[playerid][pPlayingMinutes] = 60;
        Payday(playerid);
        format(logString, sizeof(logString), "%s (%s) pegou um paycheck antecipado.", pNome(playerid), GetPlayerUserEx(playerid));
        logCreate(playerid, logString, 1);
    } else {
        if(GetPlayerAdmin(playerid) < 1335) return SendClientMessage(playerid, COLOR_WHITE, "ERRO: Desculpe, este comando não existe. Digite {89B9D9}/ajuda{FFFFFF} ou {89B9D9}/sos{FFFFFF} se você precisar de ajuda.");
        pInfo[playerid][pPlayingMinutes] = 60;
        Payday(playerid);
        format(logString, sizeof(logString), "%s (%s) pegou um paycheck antecipado.", pNome(playerid), GetPlayerUserEx(playerid));
        logCreate(playerid, logString, 1);
    }
	return true;
}

CMD:setarhoras(playerid, params[]){
    if(GetPlayerAdmin(playerid) < 1337) return SendPermissionMessage(playerid);

    pInfo[playerid][pPlayingMinutes] = 59;
    va_SendClientMessage(playerid, -1, "%d.", pInfo[playerid][pPlayingMinutes]);
	return true;
}

forward MinuteCheck();
public MinuteCheck(){
	foreach (new i : Player){
		if (IsPlayerMinimized(i)) pInfo[i][pAFKCount] ++;
        if (pInfo[i][pAFKCount] < 121) pInfo[i][pPlayingMinutes] ++;
        if (GetPlayerAdmin(i) > 0) {
            if (pInfo[i][pAFKCount] < 10 && pInfo[i][pAdminDuty]) uInfo[i][uDutyTime] ++;
            else if (pInfo[i][pAFKCount] > 9) {
                if (pInfo[i][pAdminDuty]) {
                    SetPlayerColor(i, DEFAULT_COLOR);
                    pInfo[i][pAdminDuty] = 0;

                    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s (%s) saiu do trabalho administrativo automaticamente por estar AFK.", pNome(i), GetPlayerUserEx(i));
                    format(logString, sizeof(logString), "%s (%s) saiu do trabalho administrativo automaticamente por estar AFK.", pNome(i), GetPlayerUserEx(i));
                    logCreate(i, logString, 1);
                }
            }
        }
        if (pInfo[i][pPlayingMinutes] >= 60) Payday(i);
	} return true;
}

Payday(i) {
    if (pInfo[i][pPlayingMinutes] < 60) return true;
    pInfo[i][pPlayingMinutes] = 0;
    pInfo[i][pPlayingHours] ++;
    uInfo[i][uHours] ++;

    new 
        pTotal = 0, 
        pBasePayment = 0, 
        pBizPayment = 0, 
        pFacPayment = 0,
        pVehTaxes = 0,
        pBizTaxes = 0,
        pHouseTaxes = 0,
        pTaxesFinal = 0;

    new 
        pPaymentBefore = pInfo[i][pPayment], 
        pTaxesBefore = pInfo[i][pTaxes];

    // Jogador irá receber NEWBIE_PAYMENT até a 30° hora jogada, após isso receberá o NORMAL_PAYMENT
    if (uInfo[i][uHours] < 30) {
        pBasePayment = NEWBIE_PAYMENT;
    } else if (uInfo[i][uHours] == 30) {
        pBasePayment = NEWBIE_PAYMENT;
    } else pBasePayment = NORMAL_PAYMENT;

    pVehTaxes = Vehicle_GetCount(i)*25;

    pTotal = pBasePayment + pBizPayment + pFacPayment;
    pTaxesFinal = pVehTaxes + pBizTaxes + pHouseTaxes;

    // FUNÇÃO PARA DEFINIR OS GANHOS
    if (pInfo[i][pTaxes] <= MAX_SAVINGS){
        if (DoublePaycheck == 0){
            pInfo[i][pPayment] += pTotal;
            pInfo[i][pTaxes] += pTaxesFinal;
        } else {
            pInfo[i][pPayment] += pTotal*2;
            pInfo[i][pTaxes] += pTaxesFinal;
        }
    }

    va_SendClientMessage(i, -1, "|_____________ PAYCHECK _____________|");

    // TAXAS
    if (pVehTaxes > 0) {
        va_SendClientMessage(i, COLOR_GREY, "Taxa veicular: $%s.", FormatNumber(pVehTaxes));
        Taxes_SaveLog(i, TYPE_VEHICLE, pVehTaxes);
    }
    if (pHouseTaxes > 0) {
        va_SendClientMessage(i, COLOR_GREY, "Taxa residencial: $%s.", FormatNumber(pHouseTaxes));
        Taxes_SaveLog(i, TYPE_RESIDENTIAL, pHouseTaxes);
    } 
    if (pBizTaxes > 0) {
        va_SendClientMessage(i, COLOR_GREY, "Taxa empresarial: $%s.", FormatNumber(pBizTaxes));
        Taxes_SaveLog(i, TYPE_BUSINESS, pBizTaxes);
    }

    if(pTaxesFinal > 0) va_SendClientMessage(i, COLOR_GREY, "Total de taxas cobradas: $%s.", FormatNumber(pTaxesFinal));
    if(pTaxesBefore > 0) va_SendClientMessage(i, COLOR_LIGHTRED, "Você tem um total de taxas acumuladas em: $%s.", FormatNumber(pInfo[i][pTaxes]));

    // SALÁRIO
    va_SendClientMessage(i, COLOR_GREY, "Salário recebido: $%s.", FormatNumber(pTotal));
    if(pPaymentBefore > 0) va_SendClientMessage(i, COLOR_LIGHTRED, "Você tem um pagamento acumulado de: $%s.", FormatNumber(pInfo[i][pPayment]));
    
    if (uInfo[i][uHours] < 30) SendServerMessage(i, "Você recebeu a ajuda incial de $%s.", FormatNumber(NEWBIE_PAYMENT));
    else if (uInfo[i][uHours] == 30) SendServerMessage(i, "Você terminou o período de ajuda inicial, agora seu salário base será de $%s.", FormatNumber(NORMAL_PAYMENT));

    if (DoublePaycheck != 0) SendServerMessage(i, "Pagamento duplo ativado.");
    return true;
}

/*takeFees(value, fees){
    new number, number2, number3;
	number = value/100;
	number2 = number/10;
	number3 = number2*fees;
    return number3;
}*/