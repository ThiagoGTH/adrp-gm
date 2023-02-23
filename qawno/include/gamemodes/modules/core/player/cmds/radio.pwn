#include <YSI_Coding\y_hooks>

CMD:radio(playerid, params[]) {
    new type[16], string[64];

    if(sscanf(params, "s[16]S()[64]", type, string))
    {
        SendClientMessage(playerid, COLOR_BEGE, "_______________________________________________________________________");
        SendClientMessage(playerid, COLOR_BEGE, "USE: /radio [opção]");
        SendClientMessage(playerid, COLOR_BEGE, "[Opções] status, canal, renomear, info");
        SendClientMessage(playerid, COLOR_BEGE, "[Status] Habilita ou desabilita todas as transmissões do rádio.");
        SendClientMessage(playerid, COLOR_BEGE, "[Canal] Define a frequência do rádio nos canais disponíveis.");
        SendClientMessage(playerid, COLOR_BEGE, "[Renomear] Altera o nome do canal sintonizado no slot escolhido.");
        SendClientMessage(playerid, COLOR_BEGE, "[Info] Verifica o tipo do aparelho e todos os canais sintonizados.");
        SendClientMessage(playerid, COLOR_BEGE, "_______________________________________________________________________");
        return true;
    } else if(!strcmp(type, "status", true)) {
        if(pInfo[playerid][rRadioState])
        {
            if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
            if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid, "O seu rádio já está desligado.");

            pInfo[playerid][rRadioState] = 0;
            SendClientMessage(playerid, -1, "Você desligou as transmissões de seu rádio.");
        }
        else
        {
            if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
            if(pInfo[playerid][rRadioState] == 1) return SendErrorMessage(playerid, "O seu rádio já está ligado.");

            pInfo[playerid][rRadioState] = 1;
            SendClientMessage(playerid, -1, "Você habilitou as transmissões de seu rádio.");
        }
    }
    else if(!strcmp(type, "canal", true))
    {
        new channel, slot, private = 0;

        if(sscanf(string, "dd", slot, channel)) return SendSyntaxMessage(playerid, "/radio canal [slot] [frequência]. Marque a frequência como 0 para desativá-la.");
    
        if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
        if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid, "O seu rádio está desligado.");

        if(channel == 0)
        {
            switch(slot)
            {
                case 1:
                {
                    if(pInfo[playerid][rRadioSlot][0] == 0) return SendErrorMessage(playerid, "O primeiro slot de seu aparelho já está desativado.");
                    SendClientMessage(playerid, COLOR_WHITE, "Você desativou as transmissões do primeiro slot.");
                    pInfo[playerid][rRadioSlot][0] = 0;
                }
                case 2:
                {
                    if(pInfo[playerid][rRadioSlot][1] == 0) return SendErrorMessage(playerid, "O segundo slot de seu aparelho já está desativado.");
                    SendClientMessage(playerid, COLOR_WHITE, "Você desativou as transmissões do segundo slot.");
                    pInfo[playerid][rRadioSlot][1] = 0;
                }
                case 3:
                {
                    if(pInfo[playerid][rRadioSlot][2] == 0) return SendErrorMessage(playerid, "O terceiro slot de seu aparelho já está desativado.");
                    SendClientMessage(playerid, COLOR_WHITE, "Você desativou as transmissões do terceiro slot.");
                    pInfo[playerid][rRadioSlot][2] = 0;
                }
                case 4:
                {
                    if(pInfo[playerid][pRadioNvl] == 2) return SendErrorMessage(playerid, "Seu aparelho não possui capacidade para mais slots.");
                    if(pInfo[playerid][rRadioSlot][3] == 0) return SendErrorMessage(playerid, "O quarto slot de seu aparelho já está desativado.");
                    SendClientMessage(playerid, COLOR_WHITE, "Você desativou as transmissões do quarto slot.");
                    pInfo[playerid][rRadioSlot][3] = 0;
                }
                case 5:
                {
                    if(pInfo[playerid][pRadioNvl] == 2) return SendErrorMessage(playerid, "Seu aparelho não possui capacidade para mais slots.");
                    if(pInfo[playerid][rRadioSlot][4] == 0) return SendErrorMessage(playerid, "O quinto slot de seu aparelho já está desativado.");
                    SendClientMessage(playerid, COLOR_WHITE, "Você desativou as transmissões do quinto slot.");
                    pInfo[playerid][rRadioSlot][4] = 0;
                }
                case 6:
                {
                    if((pInfo[playerid][pRadioNvl] == 2 || pInfo[playerid][pRadioNvl] == 3)) return SendErrorMessage(playerid, "Seu aparelho não possui capacidade para mais slots.");
                    if(pInfo[playerid][rRadioSlot][5] == 0) return SendErrorMessage(playerid, "O sexto slot de seu aparelho já está desativado.");
                    SendClientMessage(playerid, COLOR_WHITE, "Você desativou as transmissões do sexto slot.");
                    pInfo[playerid][rRadioSlot][5] = 0;
                }
                case 7:
                {
                    if((pInfo[playerid][pRadioNvl] == 2 || pInfo[playerid][pRadioNvl] == 3)) return SendErrorMessage(playerid, "Seu aparelho não possui capacidade para mais slots.");
                    if(pInfo[playerid][rRadioSlot][6] == 0) return SendErrorMessage(playerid, "O sétimo slot de seu aparelho já está desativado.");
                    SendClientMessage(playerid, COLOR_WHITE, "Você desativou as transmissões do sétimo slot.");
                    pInfo[playerid][rRadioSlot][6] = 0;
                }
            }
            return true;
        }

        if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
        if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid, "O seu rádio está desligado.");
        if(channel < 0 || channel > 99999) return SendErrorMessage(playerid, "A frequência do aparelho precisa ser de 0 a 99999.");
        if(slot <= 0 || slot >= 8) return SendErrorMessage(playerid, "O slot do canal precisa ser entre 1 a 7.");
        if(channel == pInfo[playerid][rRadioSlot][0] || channel == pInfo[playerid][rRadioSlot][1] || channel == pInfo[playerid][rRadioSlot][2] || channel == pInfo[playerid][rRadioSlot][3] || channel == pInfo[playerid][rRadioSlot][4] || channel == pInfo[playerid][rRadioSlot][5] || channel == pInfo[playerid][rRadioSlot][6])
            return SendErrorMessage(playerid, "Essa frequência já está sintonizada em outro canal de seu aparelho.");
    
        if(!private)
        {
            switch(slot)
            {
                case 1:
                {
                    pInfo[playerid][rRadioSlot][0] = channel;
                    va_SendClientMessage(playerid, COLOR_GREEN2, "Você alterou a frequência do canal %d para %d. Utilize \"/r1 [mensagem]\" para falar nesta frequência.", slot, channel);
                }
                case 2:
                {
                    pInfo[playerid][rRadioSlot][1] = channel;
                    va_SendClientMessage(playerid, COLOR_GREEN2, "Você alterou a frequência do canal %d para %d. Utilize \"/r2 [mensagem]\" para falar nesta frequência.", slot, channel);
                }
                case 3:
                {
                    pInfo[playerid][rRadioSlot][2] = channel;
                    va_SendClientMessage(playerid, COLOR_GREEN2, "Você alterou a frequência do canal %d para %d. Utilize \"/r3 [mensagem]\" para falar nesta frequência.", slot, channel);
                }
                case 4:
                {
                    pInfo[playerid][rRadioSlot][3] = channel;
                    va_SendClientMessage(playerid, COLOR_GREEN2, "Você alterou a frequência do canal %d para %d. Utilize \"/r4 [mensagem]\" para falar nesta frequência.", slot, channel);
                }
                case 5:
                {
                    pInfo[playerid][rRadioSlot][4] = channel;
                    va_SendClientMessage(playerid, COLOR_GREEN2, "Você alterou a frequência do canal %d para %d. Utilize \"/r5 [mensagem]\" para falar nesta frequência.", slot, channel);
                }
                case 6:
                {
                    pInfo[playerid][rRadioSlot][5] = channel;
                    va_SendClientMessage(playerid, COLOR_GREEN2, "Você alterou a frequência do canal %d para %d. Utilize \"/r6 [mensagem]\" para falar nesta frequência.", slot, channel);
                }
                case 7:
                {
                    pInfo[playerid][rRadioSlot][6] = channel;
                    va_SendClientMessage(playerid, COLOR_GREEN2, "Você alterou a frequência do canal %d para %d. Utilize \"/r7 [mensagem]\" para falar nesta frequência.", slot, channel);
                }
            }
        }
    }
    else if(!strcmp(type, "info", true))
    {
        if((pInfo[playerid][pRadioNvl] == 0) || (pInfo[playerid][pRadioNvl] >= 4))
        {
            SendErrorMessage(playerid, "Você não possui um rádio.");
        }
        else if(pInfo[playerid][pRadioNvl] == 1)
        {
            SendClientMessage(playerid, COLOR_BEGE, "Modelo: Rateck Radio 1.40 (3 slots)");
            va_SendClientMessage(playerid, COLOR_BEGE, "Status: %s", GetState(playerid));
            if(!strcmp(pInfo[playerid][rRadioName1], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 1: %i", pInfo[playerid][rRadioSlot][0]); }
            if(strcmp(pInfo[playerid][rRadioName1], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 1: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][0], pInfo[playerid][rRadioName1]); }
            if(!strcmp(pInfo[playerid][rRadioName2], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 2: %i", pInfo[playerid][rRadioSlot][1]); }
            if(strcmp(pInfo[playerid][rRadioName2], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 2: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][1], pInfo[playerid][rRadioName2]); }
            if(!strcmp(pInfo[playerid][rRadioName3], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 3: %i", pInfo[playerid][rRadioSlot][2]); }
            if(strcmp(pInfo[playerid][rRadioName3], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 3: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][2], pInfo[playerid][rRadioName3]); }
        }
        else if(pInfo[playerid][pRadioNvl] == 2)
        {
            SendClientMessage(playerid, COLOR_BEGE, "Modelo: Rateck Radio 2.20 (5 slots)");
            va_SendClientMessage(playerid, COLOR_BEGE, "Status: %s", GetState(playerid));
            if(!strcmp(pInfo[playerid][rRadioName1], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 1: %i", pInfo[playerid][rRadioSlot][0]); }
            if(strcmp(pInfo[playerid][rRadioName1], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 1: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][0], pInfo[playerid][rRadioName1]); }
            if(!strcmp(pInfo[playerid][rRadioName2], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 2: %i", pInfo[playerid][rRadioSlot][1]); }
            if(strcmp(pInfo[playerid][rRadioName2], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 2: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][1], pInfo[playerid][rRadioName2]); }
            if(!strcmp(pInfo[playerid][rRadioName3], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 3: %i", pInfo[playerid][rRadioSlot][2]); }
            if(strcmp(pInfo[playerid][rRadioName3], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 3: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][2], pInfo[playerid][rRadioName3]); }
            if(!strcmp(pInfo[playerid][rRadioName4], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 4: %i", pInfo[playerid][rRadioSlot][3]); }
            if(strcmp(pInfo[playerid][rRadioName4], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 4: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][3], pInfo[playerid][rRadioName4]); }
            if(!strcmp(pInfo[playerid][rRadioName5], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 5: %i", pInfo[playerid][rRadioSlot][4]); }
            if(strcmp(pInfo[playerid][rRadioName5], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 5: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][4], pInfo[playerid][rRadioName5]); }
        }
        else if(pInfo[playerid][pRadioNvl] == 3)
        {
            SendClientMessage(playerid, COLOR_BEGE, "Modelo: Rateck Radio 3.60 (7 slots)");
            va_SendClientMessage(playerid, COLOR_BEGE, "Status: %s", GetState(playerid));
            if(!strcmp(pInfo[playerid][rRadioName1], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 1: %i", pInfo[playerid][rRadioSlot][0]); }
            if(strcmp(pInfo[playerid][rRadioName1], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 1: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][0], pInfo[playerid][rRadioName1]); }
            if(!strcmp(pInfo[playerid][rRadioName2], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 2: %i", pInfo[playerid][rRadioSlot][1]); }
            if(strcmp(pInfo[playerid][rRadioName2], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 2: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][1], pInfo[playerid][rRadioName2]); }
            if(!strcmp(pInfo[playerid][rRadioName3], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 3: %i", pInfo[playerid][rRadioSlot][2]); }
            if(strcmp(pInfo[playerid][rRadioName3], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 3: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][2], pInfo[playerid][rRadioName3]); }
            if(!strcmp(pInfo[playerid][rRadioName4], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 4: %i", pInfo[playerid][rRadioSlot][3]); }
            if(strcmp(pInfo[playerid][rRadioName4], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 4: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][3], pInfo[playerid][rRadioName4]); }
            if(!strcmp(pInfo[playerid][rRadioName5], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 5: %i", pInfo[playerid][rRadioSlot][4]); }
            if(strcmp(pInfo[playerid][rRadioName5], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 5: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][4], pInfo[playerid][rRadioName5]); }
            if(!strcmp(pInfo[playerid][rRadioName6], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 6: %i", pInfo[playerid][rRadioSlot][5]); }
            if(strcmp(pInfo[playerid][rRadioName6], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 6: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][5], pInfo[playerid][rRadioName6]); }
            if(!strcmp(pInfo[playerid][rRadioName7], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 7: %i", pInfo[playerid][rRadioSlot][6]); }
            if(strcmp(pInfo[playerid][rRadioName7], "0")) { va_SendClientMessage(playerid, COLOR_BEGE, "Slot 7: %i   |   Nome: %s", pInfo[playerid][rRadioSlot][6], pInfo[playerid][rRadioName7]); }
        }
    }
    else if(!strcmp(type, "renomear", true))
    {
        new name[8], slot2;

        if(sscanf(string, "is[24]", slot2, name)) return SendSyntaxMessage(playerid, "/radio renomear [slot] [nome]. Marque a renomeação como 0 para desativar o nome.");
        if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
        if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid, "O seu rádio está desligado.");
        if(slot2 <= 0 || slot2 >= 8) return SendErrorMessage(playerid, "O slot do canal precisa ser entre 1 a 7.");
        if(strlen(name) >= 7) return SendErrorMessage(playerid, "O limite de caracteres de uma renomeação é de 6.");
        if(strcmp(name, "0"))
        {
            if(!strcmp(name, pInfo[playerid][rRadioName1], true) || !strcmp(name, pInfo[playerid][rRadioName2], true) || !strcmp(name, pInfo[playerid][rRadioName3], true) || !strcmp(name, pInfo[playerid][rRadioName4], true) || !strcmp(name, pInfo[playerid][rRadioName5], true) 
            || !strcmp(name, pInfo[playerid][rRadioName6], true) || !strcmp(name, pInfo[playerid][rRadioName7], true)) return SendErrorMessage(playerid, "Você já possui esse nome em algum outro canal de seu aparelho.");
        }

        for(new i = 0; i < strlen(name); i ++)
        {
            if((strcmp(name[i], "0")) && (name[i] == tolower(name[i]))) return SendErrorMessage(playerid, "O nome do seu slot deve conter somente letras maiúsculas.");
        }


        if(IsPlayerConnected(playerid))
        {
            switch(slot2)
            {
                case 1:
                {
                    if(!strcmp(name[playerid], "0")) return va_SendClientMessage(playerid, COLOR_GREEN2, "O nome de seu slot %d foi restaurado.", slot2) && format(pInfo[playerid][rRadioName1], 90, "0");
                    format(pInfo[playerid][rRadioName1], 90, "%s", name);
                    va_SendClientMessage(playerid, COLOR_GREEN2, "O seu slot %d foi renomeado para \"%s\".", slot2, name);
                }
                case 2:
                {
                    if(!strcmp(name[playerid], "0")) return va_SendClientMessage(playerid, COLOR_GREEN2, "O nome de seu slot %d foi restaurado.", slot2) && format(pInfo[playerid][rRadioName2], 90, "0");
                    format(pInfo[playerid][rRadioName2], 90, "%s", name);
                    va_SendClientMessage(playerid, COLOR_GREEN2, "O seu slot %d foi renomeado para \"%s\".", slot2, name);
                }
                case 3:
                {
                    if(!strcmp(name[playerid], "0")) return va_SendClientMessage(playerid, COLOR_GREEN2, "O nome de seu slot %d foi restaurado.", slot2) && format(pInfo[playerid][rRadioName3], 90, "0");
                    format(pInfo[playerid][rRadioName3], 90, "%s", name);
                    va_SendClientMessage(playerid, COLOR_GREEN2, "O seu slot %d foi renomeado para \"%s\".", slot2, name);
                }
                case 4:
                {
                    if(!strcmp(name[playerid], "0")) return va_SendClientMessage(playerid, COLOR_GREEN2, "O nome de seu slot %d foi restaurado.", slot2) && format(pInfo[playerid][rRadioName4], 90, "0");
                    if(pInfo[playerid][pRadioNvl] == 1) return SendErrorMessage(playerid, "Seu aparelho não possui capacidade para mais slots.");
                    format(pInfo[playerid][rRadioName4], 90, "%s", name);
                    va_SendClientMessage(playerid, COLOR_GREEN2, "O seu slot %d foi renomeado para \"%s\".", slot2, name);
                }
                case 5:
                {
                    if(!strcmp(name[playerid], "0")) return va_SendClientMessage(playerid, COLOR_GREEN2, "O nome de seu slot %d foi restaurado.", slot2) && format(pInfo[playerid][rRadioName5], 90, "0");
                    if(pInfo[playerid][pRadioNvl] == 1) return SendErrorMessage(playerid, "Seu aparelho não possui capacidade para mais slots.");
                    format(pInfo[playerid][rRadioName5], 90, "%s", name);
                    va_SendClientMessage(playerid, COLOR_GREEN2, "O seu slot %d foi renomeado para \"%s\".", slot2, name);
                }
                case 6:
                {
                    if(!strcmp(name[playerid], "0")) return va_SendClientMessage(playerid, COLOR_GREEN2, "O nome de seu slot %d foi restaurado.", slot2) && format(pInfo[playerid][rRadioName6], 90, "0");
                    if((pInfo[playerid][pRadioNvl] == 1 || pInfo[playerid][pRadioNvl] == 2)) return SendErrorMessage(playerid, "Seu aparelho não possui capacidade para mais slots.");
                    format(pInfo[playerid][rRadioName6], 90, "%s", name);
                    va_SendClientMessage(playerid, COLOR_GREEN2, "O seu slot %d foi renomeado para \"%s\".", slot2, name);
                }
                case 7:
                {
                    if(!strcmp(name[playerid], "0")) return va_SendClientMessage(playerid, COLOR_GREEN2, "O nome de seu slot %d foi restaurado.", slot2) && format(pInfo[playerid][rRadioName7], 90, "0");
                    if((pInfo[playerid][pRadioNvl] == 1 || pInfo[playerid][pRadioNvl] == 2)) return SendErrorMessage(playerid, "Seu aparelho não possui capacidade para mais slots.");
                    format(pInfo[playerid][rRadioName7], 90, "%s", name);
                    va_SendClientMessage(playerid, COLOR_GREEN2, "O seu slot %d foi renomeado para \"%s\".", slot2, name);
                }
            }
            return true;
        }
    }
    return true;
}

CMD:r1(playerid, params[])
{
    new text[2056];
    if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
    if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid, "Seu rádio não está ligado.");
    if(pInfo[playerid][rRadioSlot][0] == 0) return SendErrorMessage(playerid, "A frequência desejada está desativada.");
    if(isnull(params)) return SendSyntaxMessage(playerid, "/r [mensagem].");

    for(new i, j = MAX_PLAYERS; i <= j; i++)
    {
        if((pInfo[i][rRadioState] == 1) && (pInfo[i][pRadioNvl] == 1 || 2 || 3))
        {
            if((pInfo[playerid][rRadioSlot][0] == pInfo[i][rRadioSlot][0]) && (i != playerid)) va_SendClientMessage(i, -1, "{FFFF9A}[CH: %s - S: 1] %s: %s", TransmissionName(i, 1), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][0] == pInfo[i][rRadioSlot][1]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 2] %s: %s", TransmissionName(i, 2), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][0] == pInfo[i][rRadioSlot][2]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 3] %s: %s", TransmissionName(i, 3), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][0] == pInfo[i][rRadioSlot][3]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 4] %s: %s", TransmissionName(i, 4), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][0] == pInfo[i][rRadioSlot][4]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 5] %s: %s", TransmissionName(i, 5), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][0] == pInfo[i][rRadioSlot][5]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 6] %s: %s", TransmissionName(i, 6), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][0] == pInfo[i][rRadioSlot][6]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 7] %s: %s", TransmissionName(i, 7), pNome(playerid), params);
        }
    }

    va_SendClientMessage(playerid, -1, "{FFFF9A}[CH: %s - S: 1] %s: %s", TransmissionName(playerid, 1), pNome(playerid), params);
    format(text, sizeof(text), "(no rádio) %s: %s", pNome(playerid), params);
    ProxDetector(15.0, playerid, text, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2);
    return true;
}
alias:r1("r")

CMD:r2(playerid, params[])
{
    new text[2056];
    if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
    if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid,"Seu rádio não está ligado.");
    if(pInfo[playerid][rRadioSlot][1] == 0) return SendErrorMessage(playerid, "A frequência desejada está desativada.");
    if(isnull(params)) return SendSyntaxMessage(playerid, "/r2 [mensagem].");

    for(new i, j = MAX_PLAYERS; i <= j; i++)
    {
        if((pInfo[i][rRadioState] == 1) && (pInfo[i][pRadioNvl] == 1 || 2 || 3))
        {
            if((pInfo[playerid][rRadioSlot][1] == pInfo[i][rRadioSlot][0]) && (i != playerid)) va_SendClientMessage(i, -1, "{FFFF9A}[CH: %s - S: 1] %s: %s", TransmissionName(i, 1), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][1] == pInfo[i][rRadioSlot][1]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 2] %s: %s", TransmissionName(i, 2), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][1] == pInfo[i][rRadioSlot][2]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 3] %s: %s", TransmissionName(i, 3), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][1] == pInfo[i][rRadioSlot][3]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 4] %s: %s", TransmissionName(i, 4), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][1] == pInfo[i][rRadioSlot][4]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 5] %s: %s", TransmissionName(i, 5), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][1] == pInfo[i][rRadioSlot][5]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 6] %s: %s", TransmissionName(i, 6), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][1] == pInfo[i][rRadioSlot][6]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 7] %s: %s", TransmissionName(i, 7), pNome(playerid), params);
        }
    }

    va_SendClientMessage(playerid, -1, "{877D49}[CH: %s - S: 2] %s: %s", TransmissionName(playerid, 2), pNome(playerid), params);
    format(text, sizeof(text), "(no rádio) %s: %s", pNome(playerid), params);
    ProxDetector(15.0, playerid, text, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2);
    return true;
}

CMD:r3(playerid, params[])
{
    new text[2056];
    if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
    if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid,"Seu rádio não está ligado.");
    if(pInfo[playerid][rRadioSlot][2] == 0) return SendErrorMessage(playerid, "A frequência desejada está desativada.");
    if(isnull(params)) return SendSyntaxMessage(playerid, "/r3 [mensagem].");
    
    for(new i, j = MAX_PLAYERS; i <= j; i++)
    {
        if((pInfo[i][rRadioState] == 1) && (pInfo[i][pRadioNvl] == 1 || 2 || 3))
        {
            if((pInfo[playerid][rRadioSlot][2] == pInfo[i][rRadioSlot][0]) && (i != playerid)) va_SendClientMessage(i, -1, "{FFFF9A}[CH: %s - S: 1] %s: %s", TransmissionName(i, 1), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][2] == pInfo[i][rRadioSlot][1]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 2] %s: %s", TransmissionName(i, 2), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][2] == pInfo[i][rRadioSlot][2]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 3] %s: %s", TransmissionName(i, 3), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][2] == pInfo[i][rRadioSlot][3]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 4] %s: %s", TransmissionName(i, 4), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][2] == pInfo[i][rRadioSlot][4]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 5] %s: %s", TransmissionName(i, 5), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][2] == pInfo[i][rRadioSlot][5]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 6] %s: %s", TransmissionName(i, 6), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][2] == pInfo[i][rRadioSlot][6]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 7] %s: %s", TransmissionName(i, 7), pNome(playerid), params);
        }
    }
    va_SendClientMessage(playerid, -1, "{877D49}[CH: %s - S: 3] %s: %s", TransmissionName(playerid, 3), pNome(playerid), params);
    format(text, sizeof(text), "(no rádio) %s: %s", pNome(playerid), params);
    ProxDetector(15.0, playerid, text, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2);
    return true;
}

CMD:r4(playerid, params[])
{
    new text[2056];
    if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
    if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid,"Seu rádio não está ligado.");
    if(pInfo[playerid][rRadioSlot][3] == 0) return SendErrorMessage(playerid, "A frequência desejada está desativada.");
    if(isnull(params)) return SendSyntaxMessage(playerid, "/r4 [mensagem].");
    if(pInfo[playerid][pRadioNvl] == 1) return SendErrorMessage(playerid, "O seu rádio não possui capacidade.");
    
    for(new i, j = MAX_PLAYERS; i <= j; i++)
    {
        if((pInfo[i][rRadioState] == 1) && (pInfo[i][pRadioNvl] == 2 || 3))
        {
            if((pInfo[playerid][rRadioSlot][3] == pInfo[i][rRadioSlot][0]) && (i != playerid)) va_SendClientMessage(i, -1, "{FFFF9A}[CH: %s - S: 1] %s: %s", TransmissionName(i, 1), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][3] == pInfo[i][rRadioSlot][1]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 2] %s: %s", TransmissionName(i, 2), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][3] == pInfo[i][rRadioSlot][2]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 3] %s: %s", TransmissionName(i, 3), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][3] == pInfo[i][rRadioSlot][3]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 4] %s: %s", TransmissionName(i, 4), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][3] == pInfo[i][rRadioSlot][4]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 5] %s: %s", TransmissionName(i, 5), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][3] == pInfo[i][rRadioSlot][5]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 6] %s: %s", TransmissionName(i, 6), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][3] == pInfo[i][rRadioSlot][6]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 7] %s: %s", TransmissionName(i, 7), pNome(playerid), params);
        }
    }
    va_SendClientMessage(playerid, -1, "{877D49}[CH: %s - S: 4] %s: %s", TransmissionName(playerid, 4), pNome(playerid), params);
    format(text, sizeof(text), "(no rádio) %s: %s", pNome(playerid), params);
    ProxDetector(15.0, playerid, text, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2);
    return true;
}

CMD:r5(playerid, params[])
{
    new text[2056];
    if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
    if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid,"Seu rádio não está ligado.");
    if(pInfo[playerid][rRadioSlot][4] == 0) return SendErrorMessage(playerid, "A frequência desejada está desativada.");
    if(isnull(params)) return SendSyntaxMessage(playerid, "/r5 [mensagem].");
    if(pInfo[playerid][pRadioNvl] == 1) return SendErrorMessage(playerid, "O seu rádio não possui capacidade.");
    
    for(new i, j = MAX_PLAYERS; i <= j; i++)
    {
        if((pInfo[i][rRadioState] == 1) && (pInfo[i][pRadioNvl] == 2 || 3))
        {
            if((pInfo[playerid][rRadioSlot][4] == pInfo[i][rRadioSlot][0]) && (i != playerid)) va_SendClientMessage(i, -1, "{FFFF9A}[CH: %s - S: 1] %s: %s", TransmissionName(i, 1), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][4] == pInfo[i][rRadioSlot][1]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 2] %s: %s", TransmissionName(i, 2), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][4] == pInfo[i][rRadioSlot][2]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 3] %s: %s", TransmissionName(i, 3), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][4] == pInfo[i][rRadioSlot][3]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 4] %s: %s", TransmissionName(i, 4), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][4] == pInfo[i][rRadioSlot][4]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 5] %s: %s", TransmissionName(i, 5), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][4] == pInfo[i][rRadioSlot][5]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 6] %s: %s", TransmissionName(i, 6), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][4] == pInfo[i][rRadioSlot][6]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 7] %s: %s", TransmissionName(i, 7), pNome(playerid), params);
        }
    }
    va_SendClientMessage(playerid, -1, "{877D49}[CH: %s - S: 5] %s: %s", TransmissionName(playerid, 5), pNome(playerid), params);
    format(text, sizeof(text), "(no rádio) %s: %s", pNome(playerid), params);
    ProxDetector(15.0, playerid, text, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2);
    return true;
}

CMD:r6(playerid, params[])
{
    new text[2056];
    if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
    if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid,"Seu rádio não está ligado.");
    if(pInfo[playerid][rRadioSlot][5] == 0) return SendErrorMessage(playerid, "A frequência desejada está desativada.");
    if(isnull(params)) return SendSyntaxMessage(playerid, "/r6 [mensagem].");
    if((pInfo[playerid][pRadioNvl] == 1 || pInfo[playerid][pRadioNvl] == 2)) return SendErrorMessage(playerid, "O seu rádio não possui capacidade.");
    
    for(new i, j = MAX_PLAYERS; i <= j; i++)
    {
        if((pInfo[i][rRadioState] == 1) && (pInfo[i][pRadioNvl] == 3))
        {
            if((pInfo[playerid][rRadioSlot][5] == pInfo[i][rRadioSlot][0]) && (i != playerid)) va_SendClientMessage(i, -1, "{FFFF9A}[CH: %s - S: 1] %s: %s", TransmissionName(i, 1), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][5] == pInfo[i][rRadioSlot][1]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 2] %s: %s", TransmissionName(i, 2), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][5] == pInfo[i][rRadioSlot][2]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 3] %s: %s", TransmissionName(i, 3), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][5] == pInfo[i][rRadioSlot][3]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 4] %s: %s", TransmissionName(i, 4), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][5] == pInfo[i][rRadioSlot][4]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 5] %s: %s", TransmissionName(i, 5), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][5] == pInfo[i][rRadioSlot][5]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 6] %s: %s", TransmissionName(i, 6), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][5] == pInfo[i][rRadioSlot][6]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 7] %s: %s", TransmissionName(i, 7), pNome(playerid), params);
        }
    }
    va_SendClientMessage(playerid, -1, "{877D49}[CH: %s - S: 6] %s: %s", TransmissionName(playerid, 6), pNome(playerid), params);
    format(text, sizeof(text), "(no rádio) %s: %s", pNome(playerid), params);
    ProxDetector(15.0, playerid, text, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2);
    return true;
}

CMD:r7(playerid, params[])
{
    new text[2056];
    if(pInfo[playerid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Você não possui um rádio.");
    if(pInfo[playerid][rRadioState] == 0) return SendErrorMessage(playerid,"Seu rádio não está ligado.");
    if(pInfo[playerid][rRadioSlot][6] == 0) return SendErrorMessage(playerid, "A frequência desejada está desativada.");
    if(isnull(params)) return SendSyntaxMessage(playerid, "/r7 [mensagem].");
    if((pInfo[playerid][pRadioNvl] == 1 || pInfo[playerid][pRadioNvl] == 2)) return SendErrorMessage(playerid, "O seu rádio não possui capacidade.");
   
    for(new i, j = MAX_PLAYERS; i <= j; i++)
    {
        if((pInfo[i][rRadioState] == 1) && (pInfo[i][pRadioNvl] == 3))
        {
            if((pInfo[playerid][rRadioSlot][6] == pInfo[i][rRadioSlot][0]) && (i != playerid)) va_SendClientMessage(i, -1, "{FFFF9A}[CH: %s - S: 1] %s: %s", TransmissionName(i, 1), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][6] == pInfo[i][rRadioSlot][1]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 2] %s: %s", TransmissionName(i, 2), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][6] == pInfo[i][rRadioSlot][2]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 3] %s: %s", TransmissionName(i, 3), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][6] == pInfo[i][rRadioSlot][3]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 4] %s: %s", TransmissionName(i, 4), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][6] == pInfo[i][rRadioSlot][4]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 5] %s: %s", TransmissionName(i, 5), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][6] == pInfo[i][rRadioSlot][5]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 6] %s: %s", TransmissionName(i, 6), pNome(playerid), params);
            if((pInfo[playerid][rRadioSlot][6] == pInfo[i][rRadioSlot][6]) && (i != playerid)) va_SendClientMessage(i, -1, "{877D49}[CH: %s - S: 7] %s: %s", TransmissionName(i, 7), pNome(playerid), params);
        }
    }
    va_SendClientMessage(playerid, -1, "{877D49}[CH: %s - S: 7] %s: %s", TransmissionName(playerid, 7), pNome(playerid), params);
    format(text, sizeof(text), "(no rádio) %s: %s", pNome(playerid), params);
    ProxDetector(15.0, playerid, text, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2, COLOR_FADE2);
    return true;
}

CMD:darradio(playerid, params[])
{
    new type[16], targetid;
    if(sscanf(params, "us[128]", targetid, type)) return SendSyntaxMessage(playerid, "/darradio [ID] [1-3].");
    if(!IsPlayerConnected(targetid)) return SendErrorMessage(playerid, "Este jogador está indisponível ou desconectado.");
    else if(!strcmp(type, "0", true))
    {
        if(pInfo[targetid][pRadioNvl] == 0) return SendErrorMessage(playerid, "Este jogador já não possui um rádio.");
        pInfo[targetid][pRadioNvl] = 0;
        SendClientMessage(targetid, -1, "{228B22}O seu rádio foi removido.");
        va_SendClientMessage(playerid, -1, "{228B22}Você removeu o rádio do jogador %s.", pNome(targetid));
    }
    else if(!strcmp(type, "1", true))
    {
        if(pInfo[targetid][pRadioNvl] == 1) return SendErrorMessage(playerid, "Este jogador já possui um rádio com esse nível.");
        pInfo[targetid][pRadioNvl] = 1;
        SendClientMessage(targetid, -1, "{228B22}Você recebeu um rádio nível 1.");
        va_SendClientMessage(playerid, -1, "{228B22}Você deu um rádio nível 1 ao jogador %s.", pNome(targetid));
    }

    else if(!strcmp(type, "2", true))
    {
        if(pInfo[targetid][pRadioNvl] == 2) return SendErrorMessage(playerid, "Este jogador já possui um rádio com esse nível.");
        pInfo[targetid][pRadioNvl] = 2;
        SendClientMessage(targetid, -1, "{228B22}Você recebeu um rádio nível 2.");
        va_SendClientMessage(playerid, -1, "{228B22}Você deu um rádio nível 2 ao jogador %s.", pNome(targetid));
    }

    else if(!strcmp(type, "3", true))
    {
        if(pInfo[targetid][pRadioNvl] == 3) return SendErrorMessage(playerid, "Este jogador já possui um rádio com esse nível.");
        pInfo[targetid][pRadioNvl] = 3;
        SendClientMessage(targetid, -1, "{228B22}Você recebeu um rádio nível 3.");
        va_SendClientMessage(playerid, -1, "{228B22}Você deu um rádio nível 3 ao jogador %s.", pNome(targetid));
    }
    return true;
}

// Verificação se está ou não renomeado
TransmissionName(playerid, number)
{
    new frt1[90];
    switch(number)
    {
        case 1:
        {
            if(strcmp(pInfo[playerid][rRadioName1], "0"))
            {
                format(frt1, sizeof(frt1), "%s", pInfo[playerid][rRadioName1]);
            }
            if(!strcmp(pInfo[playerid][rRadioName1], "0"))
            {
                format(frt1, sizeof(frt1), "%i", pInfo[playerid][rRadioSlot][0]);
            }
        }
        case 2:
        {
            if(strcmp(pInfo[playerid][rRadioName2], "0"))
            {
                format(frt1, sizeof(frt1), "%s", pInfo[playerid][rRadioName2]);
            }
            if(!strcmp(pInfo[playerid][rRadioName2], "0"))
            {
                format(frt1, sizeof(frt1), "%i", pInfo[playerid][rRadioSlot][1]);
            }
        }
        case 3:
        {
            if(strcmp(pInfo[playerid][rRadioName3], "0"))
            {
                format(frt1, sizeof(frt1), "%s", pInfo[playerid][rRadioName3]);
            }
            if(!strcmp(pInfo[playerid][rRadioName3], "0"))
            {
                format(frt1, sizeof(frt1), "%i", pInfo[playerid][rRadioSlot][2]);
            }
        }
        case 4:
        {
            if(strcmp(pInfo[playerid][rRadioName4], "0"))
            {
                format(frt1, sizeof(frt1), "%s", pInfo[playerid][rRadioName4]);
            }
            if(!strcmp(pInfo[playerid][rRadioName4], "0"))
            {
                format(frt1, sizeof(frt1), "%i", pInfo[playerid][rRadioSlot][3]);
            }
        }
        case 5:
        {
            if(strcmp(pInfo[playerid][rRadioName5], "0"))
            {
                format(frt1, sizeof(frt1), "%s", pInfo[playerid][rRadioName5]);
            }
            if(!strcmp(pInfo[playerid][rRadioName5], "0"))
            {
                format(frt1, sizeof(frt1), "%i", pInfo[playerid][rRadioSlot][4]);
            }
        }
        case 6:
        {
            if(strcmp(pInfo[playerid][rRadioName6], "0"))
            {
                format(frt1, sizeof(frt1), "%s", pInfo[playerid][rRadioName6]);
            }
            if(!strcmp(pInfo[playerid][rRadioName6], "0"))
            {
                format(frt1, sizeof(frt1), "%i", pInfo[playerid][rRadioSlot][5]);
            }
        }
        case 7:
        {
            if(strcmp(pInfo[playerid][rRadioName7], "0"))
            {
                format(frt1, sizeof(frt1), "%s", pInfo[playerid][rRadioName7]);
            }
            if(!strcmp(pInfo[playerid][rRadioName7], "0"))
            {
                format(frt1, sizeof(frt1), "%i", pInfo[playerid][rRadioSlot][6]);
            }
        }
    }
    return frt1;
}

// Substitui os números inteiros pela palavra significativa
GetState(playerid) {
    if(pInfo[playerid][rRadioState] == 0) {
        new st[40];
        format(st, sizeof(st), "Desabilitado");
        return st;
    } else {
        new st2[40];
        format(st2, sizeof(st2), "Habilitado");
        return st2;
    }
}