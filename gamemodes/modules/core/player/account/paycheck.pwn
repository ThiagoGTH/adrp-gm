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
    if(Server_Type == 2) {
        
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
	
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

    pInfo[playerid][pPlayingMinutes] = 59;
    va_SendClientMessage(playerid, -1, "%d.", pInfo[playerid][pPlayingMinutes]);
	return true;
}

forward MinuteCheck();
public MinuteCheck(){
	foreach (new i : Player){
		if (IsPlayerMinimized(i)) pInfo[i][pAFKCount] ++;
        if (pInfo[i][pAFKCount] < 31) pInfo[i][pPlayingMinutes] ++;
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

    new 
        pTotal = 0, 
        pBasePayment = 0, 
        pBizPayment = 0, 
        pFacPayment = 0,
        pVehTaxes = 0,
        pBizTaxes = 0,
        pHouseTaxes = 0,
        pTaxes = 0,
        pFinalPayment = 0;

    new 
        pBankBefore = pInfo[i][pBank], 
        pSavingsBefore = pInfo[i][pSavings],
        pSavingsAfter = 0,
        pSavings2 = 0;

    // Jogador irá receber NEWBIE_PAYMENT até a 30° hora jogada, após isso receberá o NORMAL_PAYMENT
    if (pInfo[i][pPlayingHours] < 30) {
        pBasePayment = NEWBIE_PAYMENT;
        SendServerMessage(i, "Você recebeu a ajuda incial de $%s.", FormatNumber(NEWBIE_PAYMENT));
    } else if (pInfo[i][pPlayingHours] == 30) {
        pBasePayment = NEWBIE_PAYMENT;
        SendServerMessage(i, "Você terminou o período de ajuda inicial, agora seu salário base será de $%s.", FormatNumber(NORMAL_PAYMENT));
    } else pBasePayment = NORMAL_PAYMENT;

    //pVehTaxes = Car_GetCount(i)*25;

    // Juros da poupança dependendo do status premium do jogador
    if (pInfo[i][pDonator] == 2) pSavings2 = takeFees(pSavingsBefore, 3);
    else if (pInfo[i][pDonator] == 3) pSavings2 = takeFees(pSavingsBefore, 4);
    else pSavings2 = takeFees(pSavingsBefore, 2);
    pSavingsAfter = pSavingsBefore + pSavings2;

    pTotal = pBasePayment + pBizPayment + pFacPayment;
    pTaxes = pVehTaxes + pBizTaxes + pHouseTaxes;
    pFinalPayment = pTotal - pTaxes;

    // FUNÇÃO PARA DEFINIR OS GANHOS
    if (pInfo[i][pSavings] <= MAX_SAVINGS){
        if (DoublePaycheck == 0){
            pInfo[i][pBank] += pFinalPayment;
            pInfo[i][pSavings] += pSavingsAfter;
        } else {
            pInfo[i][pBank] += pFinalPayment*2;
            pInfo[i][pSavings] += pSavingsAfter*2;
        }
    }

    va_SendClientMessage(i, -1, "|__________ PAYCHECK __________|");
    va_SendClientMessage(i, COLOR_GREY, "Saldo anterior: $%s", FormatNumber(pBankBefore));
    va_SendClientMessage(i, COLOR_GREY, "Salário bruto: $%s", FormatNumber(pTotal));
    if (pVehTaxes > 0) va_SendClientMessage(i, COLOR_GREY, "Taxa veicular: $%s", FormatNumber(pVehTaxes));
    if (pBizTaxes > 0) va_SendClientMessage(i, COLOR_GREY, "Taxa empresarial: $%s", FormatNumber(pBizTaxes));
    if (pHouseTaxes > 0) va_SendClientMessage(i, COLOR_GREY, "Taxa residencial: $%s", FormatNumber(pHouseTaxes));
    if (pTaxes > 0) va_SendClientMessage(i, COLOR_GREY, "Total de taxas: $%s", FormatNumber(pTaxes));
    va_SendClientMessage(i, COLOR_GREY, "Salário líquido: $%s", FormatNumber(pFinalPayment));
    va_SendClientMessage(i, COLOR_GREY, "Saldo atual: $%s", FormatNumber(pInfo[i][pBank]));
    if (pInfo[i][pSavings] > 0){
        if (pInfo[i][pSavings] >= MAX_SAVINGS){
            va_SendClientMessage(i, COLOR_GREY, "Saldo da poupança: $%s", FormatNumber(pSavingsBefore));
            va_SendClientMessage(i, COLOR_GREY, "* Sua poupança atingiu o limite permitido pelo banco.");
        } else {
            va_SendClientMessage(i, COLOR_GREY, "Saldo anterior da poupança: $%s", FormatNumber(pSavingsBefore));
            va_SendClientMessage(i, COLOR_GREY, "Juros da poupança: $%s", FormatNumber(pSavings2));
            va_SendClientMessage(i, COLOR_GREY, "Saldo atual da poupança: $%s", FormatNumber(pInfo[i][pSavings]));
        }
    }
    if (DoublePaycheck != 0) SendServerMessage(i, "Pagamento duplo ativado.");
    return true;
}

takeFees(value, fees){
    new number, number2, number3;
	number = value/100;
	number2 = number/10;
	number3 = number2*fees;
    return number3;
}