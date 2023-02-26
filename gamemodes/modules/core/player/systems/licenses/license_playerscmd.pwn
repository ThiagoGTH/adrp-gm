CMD:licencamotorista(playerid, params[]) {
	static
	    userid;

    if (pLicenses[playerid][license_vehicle] != 1) return SendErrorMessage(playerid, "Você não possui uma licença de motorista válida.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/licencamotorista [id/nome]");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Este player não está próximo de você.");

    new gender[128], ethnicity[128], color_eyes[128], color_hair[128], status[128];
    switch(pInfo[playerid][pGender]) {
		case 1: format(gender, sizeof(gender), "Masculino");
		case 2: format(gender, sizeof(gender), "Feminino");
		default: format(gender, sizeof(gender), "Inválido");
	}
	switch(pLicenses[playerid][license_status]){
		case 0: status = "NENHUM";
		case 1: status = "ATIVA";
		case 2: status = "SUSPENSA";
		case 3: status = "REVOGADA";
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

	SendClientMessage(userid, COLOR_GREEN, "|_________ San Andreas Driver License _________|");
	va_SendClientMessage(userid, COLOR_WHITE, "SSN: %d | STATUS: %s", pLicenses[playerid][license_number], status);
	va_SendClientMessage(userid, COLOR_WHITE, "Nome: %s | Sexo: %s", pNome(playerid), gender);
	va_SendClientMessage(userid, COLOR_WHITE, "Data de Nascimento: %s", FormatDate(pInfo[playerid][pDateOfBirth], 4));
	va_SendClientMessage(userid, COLOR_WHITE, "Etnia: %s | Cabelo: %s | Olhos: %s", ethnicity, color_hair, color_eyes);
    va_SendClientMessage(userid, COLOR_WHITE, "Peso: %.1fkg | Altura: %dcm", pInfo[playerid][pWeight], pInfo[playerid][pHeight]);


	if(userid == playerid)
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s observa sua própria licença de motorista.", pNome(playerid));
	else
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s mostra a sua licença de motorista para %s.", pNome(playerid), pNome(userid));
	
	return true;
}

CMD:licencamedica(playerid, params[]) {
	static
	    userid;

    if (pLicenses[playerid][license_medical] != 1) return SendErrorMessage(playerid, "Você não possui uma licença de prática médica.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/licencamedica [id/nome]");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Este player não está próximo de você.");

    new gender[128];
    switch(pInfo[playerid][pGender]) {
		case 1: format(gender, sizeof(gender), "Masculino");
		case 2: format(gender, sizeof(gender), "Feminino");
		default: format(gender, sizeof(gender), "Inválido");
	}

	SendClientMessage(userid, COLOR_GREEN, "|_________ THE MEDICAL BOARD OF SAN ANDREAS _________|");
	va_SendClientMessage(userid, COLOR_WHITE, "SSN: %d", pLicenses[playerid][license_number]);
	va_SendClientMessage(userid, COLOR_WHITE, "Nome: %s | Sexo: %s", pNome(playerid), gender);
	va_SendClientMessage(userid, COLOR_WHITE, "Data de Nascimento: %s", FormatDate(pInfo[playerid][pDateOfBirth], 4));

	if(userid == playerid)
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s observa sua própria licença de prática médica.", pNome(playerid));
	else
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s mostra a sua licença de prática médica para %s.", pNome(playerid), pNome(userid));
	
	return true;
}

CMD:licencavoo(playerid, params[]) {
	static
	    userid;

    if (pLicenses[playerid][license_plane] != 1) return SendErrorMessage(playerid, "Você não possui uma licença de voo válida.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/licencavoo [id/nome]");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Este player não está próximo de você.");

    new gender[128], ethnicity[128], color_eyes[128], color_hair[128], status[128];
    switch(pInfo[playerid][pGender]) {
		case 1: format(gender, sizeof(gender), "Masculino");
		case 2: format(gender, sizeof(gender), "Feminino");
		default: format(gender, sizeof(gender), "Inválido");
	}
	switch(pLicenses[playerid][license_status]){
		case 0: status = "NENHUM";
		case 1: status = "ATIVA";
		case 2: status = "SUSPENSA";
		case 3: status = "REVOGADA";
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

	SendClientMessage(userid, COLOR_GREEN, "|_________ San Andreas Fly License _________|");
	va_SendClientMessage(userid, COLOR_WHITE, "SSN: %d | STATUS: %s", pLicenses[playerid][license_number], status);
	va_SendClientMessage(userid, COLOR_WHITE, "Nome: %s | Sexo: %s", pNome(playerid), gender);
	va_SendClientMessage(userid, COLOR_WHITE, "Data de Nascimento: %s", FormatDate(pInfo[playerid][pDateOfBirth], 4));
	va_SendClientMessage(userid, COLOR_WHITE, "Etnia: %s | Cabelo: %s | Olhos: %s", ethnicity, color_hair, color_eyes);
    va_SendClientMessage(userid, COLOR_WHITE, "Peso: %.1fkg | Altura: %dcm", pInfo[playerid][pWeight], pInfo[playerid][pHeight]);


	if(userid == playerid)
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s observa sua própria licença de voo.", pNome(playerid));
	else
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s mostra a sua licença de voo para %s.", pNome(playerid), pNome(userid));
	
	return true;
}

CMD:licencaarmas(playerid, params[]) {
	static
	    userid;

    if (pLicenses[playerid][license_gun] != 1) return SendErrorMessage(playerid, "Você não possui uma licença de armas válida.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/licencaarmas [id/nome]");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Este player não está próximo de você.");

    new gender[128], ethnicity[128], color_eyes[128], color_hair[128];
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

	SendClientMessage(userid, COLOR_GREEN, "|_________ San Andreas Gun License _________|");
	va_SendClientMessage(userid, COLOR_WHITE, "SSN: %d", pLicenses[playerid][license_number]);
	va_SendClientMessage(userid, COLOR_WHITE, "Nome: %s | Sexo: %s", pNome(playerid), gender);
	va_SendClientMessage(userid, COLOR_WHITE, "Data de Nascimento: %s", FormatDate(pInfo[playerid][pDateOfBirth], 4));
	va_SendClientMessage(userid, COLOR_WHITE, "Etnia: %s | Cabelo: %s | Olhos: %s", ethnicity, color_hair, color_eyes);
    va_SendClientMessage(userid, COLOR_WHITE, "Peso: %.1fkg | Altura: %dcm", pInfo[playerid][pWeight], pInfo[playerid][pHeight]);
	va_SendClientMessage(userid, COLOR_GREEN, "* Licença para porte de pistola, revólver ou outra arma de fogo oculta.");


	if(userid == playerid)
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s observa sua própria licença de armas.", pNome(playerid));
	else
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s mostra a sua licença de armas para %s.", pNome(playerid), pNome(userid));
	
	return true;
}

CMD:iniciarexame(playerid, params[]){
	//if(!IsPlayerInRangeOfPoint(playerid, 2.0, 1490.3473,1306.2144,1093.2964)) return SendErrorMessage(playerid,"Você não está próximo de um DMV.");

	new string [512];
	format(string, sizeof(string), "ID\tLicença\tValor\n \
		1\tLicença Veícular\t%d",
		DMV_VEHICLE_VALUE
	);
	
	Dialog_Show(playerid, DIALOG_DMV_ROUTE, DIALOG_STYLE_TABLIST_HEADERS, "Licenças", string, "Selecionar", "Cancelar");
	return true;
}