/*
    Etnia:
    1 - Branco;
    2 - Negro;
    3 - Hispânico;
    4 - Asiático.

    Físico:
    1 - Super magro;
    2 - Magro;
    3 - Normal;
    4 - Gordo;
    5 - Obeso;
    6 - Musculoso.

    Olhos:
    1 - Azul;
    2 - Azul-esverdeado;
    3 - Cinza;
    4 - Castanho;
    5 - Verde;
    6 - Avelã;
    7 - Âmbar;
    8 - Heterocromia.

    Cabelo:
    1 - Careca;
    2 - Loiro claro;
    3 - Loiro médio;
    4 - Loiro escuro;
    5 - Castanho claro;
    6 - Castanho médio;
    7 - Castanho escuro;
    8 - Castanho meio ruivo;
    9 - Ruivo;
    10 - Preto;
    11 - Grisalho ou Cinza;
    12 - Branco.
*/

#include <YSI_Coding\y_hooks>

ApparenceReset(playerid) {
    pInfo[playerid][pEthnicity] = 0;
    pInfo[playerid][pColorEyes] = 0;
    pInfo[playerid][pColorHair] = 0;
    pInfo[playerid][pBuild] = 0;
    pInfo[playerid][pHeight] = 0;
    pInfo[playerid][pWeight] = 0.0;
    format(pInfo[playerid][pDescription], 128, "N/A");

    SavePlayerApparence(playerid);
    return true;
}

CMD:veraparencia(playerid, params[]) {
    static userid;
    if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/veraparencia [playerid/nome]");
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if(!IsPlayerNearPlayer(playerid, userid, 20.0)) return SendErrorMessage(playerid, "Você não está perto deste jogador.");

    new gender[128], ethnicity[128], color_eyes[128], color_hair[128], build[128];

    switch(pInfo[userid][pGender]) {
		case 1: format(gender, sizeof(gender), "Masculino");
		case 2: format(gender, sizeof(gender), "Feminino");
		default: format(gender, sizeof(gender), "Inválido");
	}
    switch(pInfo[userid][pEthnicity]) {
		case 1: format(ethnicity, sizeof(ethnicity), "Branco");
		case 2: format(ethnicity, sizeof(ethnicity), "Negro");
		case 3: format(ethnicity, sizeof(ethnicity), "Hispânico");
		case 4: format(ethnicity, sizeof(ethnicity), "Asiático");
		default: format(ethnicity, sizeof(ethnicity), "Inválido");
	}
    switch(pInfo[userid][pColorEyes]) {
		case 1: format(color_eyes, sizeof(color_eyes), "Azul");
		case 2: format(color_eyes, sizeof(color_eyes), "Azul-esverdeado");
		case 3: format(color_eyes, sizeof(color_eyes), "Cinza");
		case 4: format(color_eyes, sizeof(color_eyes), "Castanho");
        case 5: format(color_eyes, sizeof(color_eyes), "Verde");
        case 6: format(color_eyes, sizeof(color_eyes), "Avelã");
        case 7: format(color_eyes, sizeof(color_eyes), "Âmbar");
        case 8: format(color_eyes, sizeof(color_eyes), "Heterocromia");
		default: format(color_eyes, sizeof(color_eyes), "Inválido");
	}
    switch(pInfo[userid][pColorHair]) {
		case 1: format(color_hair, sizeof(color_hair), "Careca");
		case 2: format(color_hair, sizeof(color_hair), "Loiro claro");
		case 3: format(color_hair, sizeof(color_hair), "Loiro médio");
		case 4: format(color_hair, sizeof(color_hair), "Loiro escuro");
        case 5: format(color_hair, sizeof(color_hair), "Castanho claro");
        case 6: format(color_hair, sizeof(color_hair), "Castanho médio");
        case 7: format(color_hair, sizeof(color_hair), "Castanho escuro");
        case 8: format(color_hair, sizeof(color_hair), "Castanho meio ruivo");
        case 9: format(color_hair, sizeof(color_hair), "Ruivo");
        case 10: format(color_hair, sizeof(color_hair), "Preto");
        case 11: format(color_hair, sizeof(color_hair), "Grisalho ou Cinza");
        case 12: format(color_hair, sizeof(color_hair), "Branco");
		default: format(color_hair, sizeof(color_hair), "Inválido");
	}
    switch(pInfo[userid][pBuild]) {
		case 1: format(build, sizeof(build), "Super magro");
		case 2: format(build, sizeof(build), "Magro");
		case 3: format(build, sizeof(build), "Normal");
		case 4: format(build, sizeof(build), "Gordo");
        case 5: format(build, sizeof(build), "Obeso");
        case 6: format(build, sizeof(build), "Musculoso");
		default: format(build, sizeof(build), "Inválido");
	}

    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s observa a aparência de %s.", pNome(playerid), pNome(userid));

    va_SendClientMessage(playerid, COLOR_GREEN, "___________________[Aparência de %s]___________________", pNome(userid));
    va_SendClientMessage(playerid, COLOR_WHITE, "Etnia: %s | Cabelo: %s | Olhos: %s", ethnicity, color_hair, color_eyes);
    va_SendClientMessage(playerid, COLOR_WHITE, "Físico: %s | Peso: %.1fkg | Altura: %dcm", build, pInfo[userid][pWeight], pInfo[userid][pHeight]);
    va_SendClientMessage(playerid, COLOR_WHITE, "Descrição:");
    if (strlen(pInfo[userid][pDescription]) > 64){
        va_SendClientMessage(playerid, COLOR_PURPLE, "* %s %.64s", pInfo[userid][pDescription]);
        va_SendClientMessage(playerid, COLOR_PURPLE, "* ...%s", pInfo[userid][pDescription][64]);
    } else va_SendClientMessage(playerid, COLOR_PURPLE, "* %s", pInfo[userid][pDescription]);


    return true;
}

CMD:resetaraparencia(playerid, params[]){
    if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);

    static
	    userid,
	    type[24];

    if (sscanf(params, "us[24]", userid, type)) {
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /resetaraparencia [playerid/nome] [opção]");
	    SendClientMessage(playerid, COLOR_BEGE, "[Opções]: gênero, etnia, altura, peso, tudo");
		return true;
	}
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if (!strcmp(type, "gênero", true) || !strcmp(type, "genero", true) || !strcmp(type, "sexo", true)) {
	    pInfo[userid][pGender] = 0;
        SendServerMessage(playerid, "Você autorizou %s a alterar de gênero.", pNome(userid));
        SendServerMessage(playerid, "Um administrador autorizou você a alterar de gênero. Use /editaraparencia.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) autorizou %s a mudar de gênero", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	}
	else if (!strcmp(type, "etnia", true)) {
	    pInfo[playerid][pEthnicity] = 0;
        SendServerMessage(playerid, "Você autorizou %s a alterar de etnia.", pNome(userid));
        SendServerMessage(playerid, "Um administrador autorizou você a alterar de etnia. Use /editaraparencia.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) autorizou %s a mudar de etnia", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	}
    else if (!strcmp(type, "altura", true)) {
	    pInfo[playerid][pHeight] = 0;
        SendServerMessage(playerid, "Você autorizou %s a alterar de altura.", pNome(userid));
        SendServerMessage(playerid, "Um administrador autorizou você a alterar de altura. Use /editaraparencia.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) autorizou %s a mudar de altura", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	}
    else if (!strcmp(type, "peso", true)) {
	    pInfo[playerid][pWeight] = 0.0;
        SendServerMessage(playerid, "Você autorizou %s a alterar de peso.", pNome(userid));
        SendServerMessage(playerid, "Um administrador autorizou você a alterar de peso. Use /editaraparencia.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) autorizou %s a mudar de peso", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	}
    else if (!strcmp(type, "tudo", true)) {
	    ApparenceReset(userid);
        SendServerMessage(playerid, "Você resetou toda a aparência de %s.", pNome(userid));
        SendServerMessage(playerid, "Um administrador resetou toda sua aparência.", pNome(userid));
        format(logString, sizeof(logString), "%s (%s) resetou toda a aparência de %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	    logCreate(playerid, logString, 1);
	}

    return true;
}

CMD:editaraparencia(playerid, params[]){
    new gender[128], ethnicity[128], color_eyes[128], color_hair[128], build[128], title[124], text[1024];

    switch(pInfo[playerid][pGender]) {
		case 1: format(gender, sizeof(gender), "Masculino");
		case 2: format(gender, sizeof(gender), "Feminino");
		default: format(gender, sizeof(gender), "Inválido");
	}
    switch(pInfo[playerid][pEthnicity]) {
		case 1: format(ethnicity, sizeof(ethnicity), "Branco");
		case 2: format(ethnicity, sizeof(ethnicity), "Negro");
		case 3: format(ethnicity, sizeof(ethnicity), "Hispânico");
		case 4: format(ethnicity, sizeof(ethnicity), "Asiático");
		default: format(ethnicity, sizeof(ethnicity), "Inválido");
	}
    switch(pInfo[playerid][pColorEyes]) {
		case 1: format(color_eyes, sizeof(color_eyes), "Azul");
		case 2: format(color_eyes, sizeof(color_eyes), "Azul-esverdeado");
		case 3: format(color_eyes, sizeof(color_eyes), "Cinza");
		case 4: format(color_eyes, sizeof(color_eyes), "Castanho");
        case 5: format(color_eyes, sizeof(color_eyes), "Verde");
        case 6: format(color_eyes, sizeof(color_eyes), "Avelã");
        case 7: format(color_eyes, sizeof(color_eyes), "Âmbar");
        case 8: format(color_eyes, sizeof(color_eyes), "Heterocromia");
		default: format(color_eyes, sizeof(color_eyes), "Inválido");
	}
    switch(pInfo[playerid][pColorHair]) {
		case 1: format(color_hair, sizeof(color_hair), "Careca");
		case 2: format(color_hair, sizeof(color_hair), "Loiro claro");
		case 3: format(color_hair, sizeof(color_hair), "Loiro médio");
		case 4: format(color_hair, sizeof(color_hair), "Loiro escuro");
        case 5: format(color_hair, sizeof(color_hair), "Castanho claro");
        case 6: format(color_hair, sizeof(color_hair), "Castanho médio");
        case 7: format(color_hair, sizeof(color_hair), "Castanho escuro");
        case 8: format(color_hair, sizeof(color_hair), "Castanho meio ruivo");
        case 9: format(color_hair, sizeof(color_hair), "Ruivo");
        case 10: format(color_hair, sizeof(color_hair), "Preto");
        case 11: format(color_hair, sizeof(color_hair), "Grisalho ou Cinza");
        case 12: format(color_hair, sizeof(color_hair), "Branco");
		default: format(color_hair, sizeof(color_hair), "Inválido");
	}
    switch(pInfo[playerid][pBuild]) {
		case 1: format(build, sizeof(build), "Super magro");
		case 2: format(build, sizeof(build), "Magro");
		case 3: format(build, sizeof(build), "Normal");
		case 4: format(build, sizeof(build), "Gordo");
        case 5: format(build, sizeof(build), "Obeso");
        case 6: format(build, sizeof(build), "Musculoso");
		default: format(build, sizeof(build), "Inválido");
	}

    format(title, sizeof(title), "Editar aparência");
    format(text, sizeof(text), "{FFFFFF}Gênero:\t%s\n\
    Etnia:\t%s\n\
    Cabelo:\t%s\n\
    Olhos:\t%s\n\
    Físico:\t%s\n\
    Altura:\t%dcm\n\
    Peso:\t%.1fkg\n\n\
    Descrição:\t%s", 
    gender, 
    ethnicity,
    color_hair,
    color_eyes,
    build,
    pInfo[playerid][pHeight],
    pInfo[playerid][pWeight],
    pInfo[playerid][pDescription]);

    Dialog_Show(playerid, EditApparence, DIALOG_STYLE_TABLIST, title, text, "Alterar", "Fechar");
    return true;
}

Dialog:EditApparence(playerid, response, listitem, inputtext[]){
    if(response){
        if(listitem == 0){ // Gênero
            if (pInfo[playerid][pGender] > 0) return SendErrorMessage(playerid, "Você não pode alterar seu gênero sem a autorização de um administrador.");

            Dialog_Show(playerid, ChangeGender, DIALOG_STYLE_LIST, "Alterar Gênero", "Masculino\nFeminino", "Alterar", "Fechar");
            return true;
        } 
        else if(listitem == 1){ // Etnia
            if (pInfo[playerid][pEthnicity] > 0) return SendErrorMessage(playerid, "Você não pode alterar sua etnia sem a autorização de um administrador.");

            Dialog_Show(playerid, ChangeEthnicity, DIALOG_STYLE_LIST, "Alterar Etnia", "Branco\nNegro\nHispânico\nAsiático", "Alterar", "Fechar");
            return true;
        }
        else if(listitem == 2){ // Cabelo
            Dialog_Show(playerid, ChangeHair, DIALOG_STYLE_LIST, "Alterar Cabelo", 
            "Careca\nLoiro claro\nLoiro médio\nLoiro escuro\nCastanho claro\nCastanho médio\nCastanho escuro\nCastanho meio ruivo\nRuivo\nPreto\nGrisalho ou Cinza\nBranco", "Alterar", "Fechar");
            return true;
        }
        else if(listitem == 3){ // Olhos
            Dialog_Show(playerid, ChangeEyes, DIALOG_STYLE_LIST, "Alterar Olhos", 
            "Azul\nAzul-esverdeado\nCinza\nCastanho\nVerde\nAvelã\nÂmbar\nHeterocromia", "Alterar", "Fechar");
            return true;
        }
        else if(listitem == 4){ // Físico
            Dialog_Show(playerid, ChangeBuild, DIALOG_STYLE_LIST, "Alterar Físico", 
            "Super magro\nMagro\nNormal\nGordo\nObeso\nMusculoso", "Alterar", "Fechar");
            return true;
        }
        else if(listitem == 5){ // Altura
            if (pInfo[playerid][pHeight] > 0) return SendErrorMessage(playerid, "Você não pode alterar sua altura sem a autorização de um administrador.");

            Dialog_Show(playerid, ChangeHeight, DIALOG_STYLE_INPUT, "Alterar Altura", "Digite sua nova altura:", "Alterar", "Fechar");
            return true;
        }
        else if(listitem == 6){ // Peso
            if (pInfo[playerid][pWeight] > 0.0) return SendErrorMessage(playerid, "Você não pode alterar seu peso sem a autorização de um administrador.");
            
            Dialog_Show(playerid, ChangeWeight, DIALOG_STYLE_INPUT, "Alterar Peso", "Digite seu novo peso:", "Alterar", "Fechar");
            return true;
        }
        else if(listitem == 7){ // Descrição
            Dialog_Show(playerid, ChangeDescription, DIALOG_STYLE_INPUT, "Alterar Descrição", "Digite sua nova descrição:", "Alterar", "Fechar");
            return true;
        }
    }
    return true;
}

Dialog:ChangeGender(playerid, response, listitem, inputtext[]) {
    if(!response) {
        pInfo[playerid][pGender] = 1;
        return SendServerMessage(playerid, "Você cancelou a sua troca de gênero, então foi definido automaticamente para masculino.");
    }

    if (listitem == 0) {
        pInfo[playerid][pGender] = 1;
        SendServerMessage(playerid, "Você definiu seu gênero como masculino.");
    }
    else if (listitem == 1) {
        pInfo[playerid][pGender] = 2;
        SendServerMessage(playerid, "Você definiu seu gênero como feminino.");
    }
	return true;
}

Dialog:ChangeEthnicity(playerid, response, listitem, inputtext[]) {
    if(!response) return SendServerMessage(playerid, "Você cancelou a troca de estilo de cabelo, então foi redefinida.");

    if (listitem == 0) {
        pInfo[playerid][pEthnicity] = 1;
        SendServerMessage(playerid, "Você definiu sua etnia como branca.");
    }
    else if (listitem == 1) {
        pInfo[playerid][pEthnicity] = 2;
        SendServerMessage(playerid, "Você definiu sua etnia como negra.");
    }
    else if (listitem == 2) {
        pInfo[playerid][pEthnicity] = 3;
        SendServerMessage(playerid, "Você definiu sua etnia como hispânica.");
    }
    else if (listitem == 3) {
        pInfo[playerid][pEthnicity] = 4;
        SendServerMessage(playerid, "Você definiu sua etnia como asiática.");
    }
	return true;
}

Dialog:ChangeHair(playerid, response, listitem, inputtext[]) {
    if(!response) return SendServerMessage(playerid, "Você cancelou a troca de estilo de cabelo, então foi redefinida.");

    if (listitem == 0) {
        pInfo[playerid][pColorHair] = 1;
        SendServerMessage(playerid, "Você definiu seu cabelo como careca.");
    }
    else if (listitem == 1) {
        pInfo[playerid][pColorHair] = 2;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como loiro claro.");
    }
    else if (listitem == 2) {
        pInfo[playerid][pColorHair] = 3;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como loiro médio.");
    }
    else if (listitem == 3) {
        pInfo[playerid][pColorHair] = 4;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como loiro escuro.");
    }
    else if (listitem == 4) {
        pInfo[playerid][pColorHair] = 5;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como castanho claro.");
    }
    else if (listitem == 5) {
        pInfo[playerid][pColorHair] = 6;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como castanho médio.");
    }
    else if (listitem == 6) {
        pInfo[playerid][pColorHair] = 7;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como castanho escuro.");
    }
    else if (listitem == 7) {
        pInfo[playerid][pColorHair] = 8;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como castanho meio ruivo.");
    }
    else if (listitem == 8) {
        pInfo[playerid][pColorHair] = 9;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como ruivo.");
    }
    else if (listitem == 9) {
        pInfo[playerid][pColorHair] = 10;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como preto.");
    }
    else if (listitem == 10) {
        pInfo[playerid][pColorHair] = 11;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como grisalho ou cinza.");
    }
    else if (listitem == 11) {
        pInfo[playerid][pColorHair] = 12;
        SendServerMessage(playerid, "Você definiu a coloração do seu cabelo como branco.");
    }
	return true;
}

Dialog:ChangeEyes(playerid, response, listitem, inputtext[]) {
    if(!response) return SendServerMessage(playerid, "Você cancelou a sua troca de olhos, então foi redefinida.");

    if (listitem == 0) {
        pInfo[playerid][pColorEyes] = 1;
        SendServerMessage(playerid, "A cor dos seus olhos foi alterada para azul.");
    }
    else if (listitem == 1) {
        pInfo[playerid][pColorEyes] = 2;
        SendServerMessage(playerid, "A cor dos seus olhos foi alterada para azul-esverdeado.");
    }
    else if (listitem == 2) {
        pInfo[playerid][pColorEyes] = 3;
        SendServerMessage(playerid, "A cor dos seus olhos foi alterada para cinza.");
    }
    else if (listitem == 3) {
        pInfo[playerid][pColorEyes] = 4;
        SendServerMessage(playerid, "A cor dos seus olhos foi alterada para castanho.");
    }
    else if (listitem == 4) {
        pInfo[playerid][pColorEyes] = 5;
        SendServerMessage(playerid, "A cor dos seus olhos foi alterada para verde.");
    }
    else if (listitem == 5) {
        pInfo[playerid][pColorEyes] = 6;
        SendServerMessage(playerid, "A cor dos seus olhos foi alterada para âmbar.");
    }
    else if (listitem == 6) {
        pInfo[playerid][pColorEyes] = 7;
        SendServerMessage(playerid, "A cor dos seus olhos foi alterada para avelã.");
    }
    else if (listitem == 7) {
        pInfo[playerid][pColorEyes] = 8;
        SendServerMessage(playerid, "Seus olhos foram definidos com heterocromia.");
    }
	return true;
}

Dialog:ChangeBuild(playerid, response, listitem, inputtext[]) {
    if(!response) return SendServerMessage(playerid, "Você cancelou a sua troca de físico, então foi redefinida.");

    if (listitem == 0) {
        pInfo[playerid][pBuild] = 1;
        SendServerMessage(playerid, "Seu físico foi alterado para super magro.");
    }
    else if (listitem == 1) {
        pInfo[playerid][pBuild] = 2;
        SendServerMessage(playerid, "Seu físico foi alterado para magro.");
    }
    else if (listitem == 2) {
        pInfo[playerid][pBuild] = 3;
        SendServerMessage(playerid, "Seu físico foi alterado para normal.");
    }
    else if (listitem == 3) {
        pInfo[playerid][pBuild] = 4;
        SendServerMessage(playerid, "Seu físico foi alterado para gordo.");
    }
    else if (listitem == 4) {
        pInfo[playerid][pBuild] = 5;
        SendServerMessage(playerid, "Seu físico foi alterado para obeso.");
    }
    else if (listitem == 5) {
        pInfo[playerid][pBuild] = 6;
        SendServerMessage(playerid, "Seu físico foi alterado para musculoso.");
    }
	return true;
}

Dialog:ChangeHeight(playerid, response, listitem, inputtext[]){
    if(!response) return SendServerMessage(playerid, "Você cancelou a sua troca de altura, então foi redefinida.");

    if(isnull(inputtext)) return Dialog_Show(playerid, ChangeHeight, DIALOG_STYLE_INPUT, "Alterar Altura", "ERRO: Você não digitou nada.\n\nDigite seu novo peso:", "Alterar", "Fechar");
    if(strval(inputtext) > 500) return Dialog_Show(playerid, ChangeHeight, DIALOG_STYLE_INPUT, "Alterar Altura", "ERRO: Você digitou uma altura inválida\nO máximo é de 500cm\n\nDigite sua nova altura:", "Alterar", "Fechar");

    pInfo[playerid][pHeight] = strval(inputtext);

    SendServerMessage(playerid, "Sua altura foi alterada para %dcm", pInfo[playerid][pHeight]);
    return true;
}

Dialog:ChangeWeight(playerid, response, listitem, inputtext[]){
    if(!response) return SendServerMessage(playerid, "Você cancelou a sua troca de peso, então foi redefinida.");

    if(isnull(inputtext)) return Dialog_Show(playerid, ChangeWeight, DIALOG_STYLE_INPUT, "Alterar Peso", "ERRO: Você não digitou nada.\n\nDigite seu novo peso:", "Alterar", "Fechar");
    if(floatstr(inputtext) > 500.00) return Dialog_Show(playerid, ChangeWeight, DIALOG_STYLE_INPUT, "Alterar Peso", "ERRO: Você digitou um peso inválido\nO máximo é de 500.00kg\n\nDigite seu novo peso:", "Alterar", "Fechar");

    pInfo[playerid][pWeight] = floatstr(inputtext);

    SendServerMessage(playerid, "Seu peso foi alterado para %.1fkg", pInfo[playerid][pWeight]);
    return true;
}

Dialog:ChangeDescription(playerid, response, listitem, inputtext[]){
    if(!response) return SendServerMessage(playerid, "Você cancelou a sua troca de gênero, então foi redefinida.");
    if(isnull(inputtext)) return Dialog_Show(playerid, ChangeDescription, DIALOG_STYLE_INPUT, "Alterar Descrição", "ERRO: Você não digitou nada.\n\nDigite sua nova descrição:", "Alterar", "Fechar");
    if(strlen(inputtext) > 128) return Dialog_Show(playerid, ChangeDescription, DIALOG_STYLE_INPUT, "Alterar Descrição", "ERRO: Você digitou uma descrição grande demais.\nO máximo é de 128 caracteres.\n\nDigite sua nova descrição:", "Alterar", "Fechar");

    format(pInfo[playerid][pDescription], 128, "%s", inputtext);
    SendServerMessage(playerid, "Sua descrição foi alterada.");
    return true;
}