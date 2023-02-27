IsPetSpawned(playerid) {
    if(PetData[playerid][petSpawn])
        return true;

    return 0;
}

ShowPetMenu(playerid) {
    new string[255], title[126];

    format(title, sizeof(title), "Gerenciar %s", PetData[playerid][petName]);

    if(PetData[playerid][petSpawn]) format(string, sizeof(string), "Ação: Segue\nAção: Fica\nAção: Senta\nAção: Deita\nAção: Pula\n\t\n{FF0000}Despawnar");
    else format(string, sizeof(string), "Alterar nome\n\t\n{36A717}Spawnar");

    Dialog_Show(playerid, PETMENU, DIALOG_STYLE_LIST, title, string, "Selecionar", "Fechar");
    return true;
}

PetSpawn(playerid) {
    if(PetData[playerid][petSpawn]) return SendErrorMessage(playerid, "Seu animal de estimação já está spawnado.");
    if(GetPlayerVirtualWorld(playerid) != 0) return SendErrorMessage(playerid, "Você não pode utilizar esse comando em um interior.");
    if(GetPlayerInterior(playerid) != 0) return SendErrorMessage(playerid, "Você não pode utilizar esse comando em um interior.");

    new petmodelid = PetData[playerid][petModelID], Float:fX, Float:fY, Float:fZ, Float:fAngle;

    GetXYInFrontOfPlayer(playerid, fX, fY, -1.0);
    GetPlayerPos(playerid, fZ, fZ, fZ);
    GetPlayerFacingAngle(playerid, fAngle);

    PetData[playerid][petModel] = CreateActor(petmodelid, fX, fY+2, fZ, fAngle);

    PetData[playerid][petSpawn] = true;
    PetData[playerid][petStatus] = PET_FOLLOW;
    SendServerMessage(playerid, "Você spawnou seu animal de estimação %s.", PetData[playerid][petName]);
    PetData[playerid][petTimer] = repeat Pet_Update(playerid, playerid);

    format(logString, sizeof(logString), "%s (%s) spawnou seu animal de estimação em %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid));
    logCreate(playerid, logString, 19);
    return true;
}

PetDespawn(playerid) {
    if(PetData[playerid][petSpawn]) {
        if(IsValidActor(PetData[playerid][petModel]))
            DestroyActor(PetData[playerid][petModel]);

        PetData[playerid][petModel] = INVALID_ACTOR_ID;
        PetData[playerid][petStatus] = PET_NONE;
        PetData[playerid][petSpawn] = false;
        stop PetData[playerid][petTimer];

        SendServerMessage(playerid, "Você desespawnou seu animal de estimação %s.", PetData[playerid][petName]);
        format(logString, sizeof(logString), "%s (%s) desespawnou seu animal de estimação em %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerLocation(playerid));
        logCreate(playerid, logString, 19);
    }
    return true;
}

PetSit(playerid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Seu animal de estimação não está spawnado.");

    if(IsValidActor(PetData[playerid][petModel])) {
        PetData[playerid][petStatus] = PET_SIT;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "ped", "SEAT_down", 4.1, false, false, false, true, 0);
        
        SendServerMessage(playerid, "Seu animal de estimação agora está sentado.");
    }
    return true;
}

PetLay(playerid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Seu animal de estimação não está spawnado.");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_LAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "CRACK", "crckidle2", 4.1, false, false, false, true, 0);
        SendServerMessage(playerid, "Seu animal de estimação agora está deitado.");
    }
    return true;
}

PetJump(playerid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Seu animal de estimação não está spawnado.");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_LAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "BSKTBALL", "BBALL_DEF_JUMP_SHOT", 4.1, true, false, false, false, 0);
        SendServerMessage(playerid, "Seu animal de estimação agora está pulando.");
    }
    return true;
}

PetStay(playerid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Seu animal de estimação não está spawnado.");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_STAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        SendServerMessage(playerid, "Seu animal de estimação agora está parado.");
    }
    return true;
}

PetFollow(playerid, targetid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Seu animal de estimação não está spawnado.");

    if(IsValidActor(PetData[playerid][petModel])) {
        if(PetData[playerid][petStatus] == PET_FOLLOW)
        {
            stop PetData[playerid][petTimer];
        }
        PetData[playerid][petStatus] = PET_FOLLOW;
        ClearActorAnimations(PetData[playerid][petModel]);
        PetData[playerid][petTimer] = repeat Pet_Update(playerid, targetid);
        SendServerMessage(playerid, "Seu animal de estimação agora está acompanhando.");
    }
    return true;
}

PetName(playerid) {
    if(PetData[playerid][petSpawn])
        return SendErrorMessage(playerid, "Seu animal de estimação não pode estar spawnado para utilizar isso.");

    if(strcmp(PetData[playerid][petName], "Jack", true))
        return SendErrorMessage(playerid, "O nome do seu animal de estimação não pode mais ser alterado.");

    Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Alterar Nome", "{FFFFFF}ATENÇÃO: Você só pode alterar os nomes dos animais de estimação uma vez\n\nDigite o nome desejado:", "Confirmar", "Cancelar");
    return true;
}

Dialog:PET_NAME(playerid, response, listitem, inputtext[]) {
    if(response) {
        if(isnull(inputtext) || IsNumeric(inputtext))
            return Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Alterar Nome", "{FFFFFF}ATENÇÃO: Você só pode alterar os nomes dos animais de estimação uma vez\n{FF0000}ERRO: Você não digitou nada\n{FFFFFF}Digite o nome desejado:", "Confirmar", "Cancelar");

        if(strlen(inputtext) > 128)
            return Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Alterar Nome", "{FFFFFF}ATENÇÃO: Você só pode alterar os nomes dos animais de estimação uma vez\n{FF0000}ERRO: O nome não pode ter mais que 128 caracteres\n{FFFFFF}Digite o nome desejado:", "Confirmar", "Cancelar");
            
        format(PetData[playerid][petName], 128, "%s", inputtext);
        SendServerMessage(playerid, "Você definiu o nome do seu animal de estimação como %s.", inputtext);
        format(logString, sizeof(logString), "%s (%s) definiu o nome do seu animal de estimação como %s", pNome(playerid), GetPlayerUserEx(playerid), inputtext);
        logCreate(playerid, logString, 19);
    }
    return true;
}

Dialog:PETMENU(playerid, response, listitem, inputtext[]) {
    if(response) {
        if (!strcmp(inputtext, "Spawnar", true))
            return PetSpawn(playerid);
        if (!strcmp(inputtext, "Despawnar", true))
            return PetDespawn(playerid);
        if (!strcmp(inputtext, "Alterar nome", true))
            return PetName(playerid);
        if (!strcmp(inputtext, "Ação: Fica", true))
            return PetStay(playerid);
        if (!strcmp(inputtext, "Ação: Segue", true))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Ação: Segue", "Digite o ID do jogador que você quer que seu animal siga.\nDeixe em branco se quer que ele siga você.", "Seguir", "Cancelar");
        if (!strcmp(inputtext, "Ação: Senta", true))
            return PetSit(playerid);
        if (!strcmp(inputtext, "Ação: Deita", true))
            return PetLay(playerid);
        if (!strcmp(inputtext, "Ação: Pula", true))
            return PetJump(playerid);        
    }
    return true;
}

Dialog:PET_MENU_FOLLOW(playerid, response, listitem, inputtext[]) {
    if(response) {
        new targetid;
        if(isnull(inputtext))
            return PetFollow(playerid, playerid);

        if(!IsNumeric(inputtext))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Ação: Segue", "{FFFFFF}Insira o ID do jogador que você deseja que seu animal de estimação siga:", "Seguir", "Cancelar");

        if(sscanf(inputtext, "u", targetid))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Ação: Segue", "{FF0000}ERRO: O ID inserido é inválido.\n\n{FFFFFF}Insira o ID do jogador que você deseja que seu animal de estimação siga:", "Seguir", "Cancelar");

        if(targetid == INVALID_PLAYER_ID || !IsPlayerSpawned(targetid))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Ação: Segue", "{FF0000}ERRO: O jogador especificado é inválido.\n\n{FFFFFF}Insira o ID do jogador que você deseja que seu animal de estimação siga:", "Seguir", "Cancelar");
        
        if(!IsPlayerNearPlayer(playerid, targetid, 10.0)) return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Ação: Segue", "{FF0000}ERRO: O jogador especificado não está perto o suficiente.\n\n{FFFFFF}Insira o ID do jogador que você deseja que seu animal de estimação siga:", "Seguir", "Cancelar");
        
        PetFollow(playerid, targetid);
        SendServerMessage(playerid, "Seu animal de estimação agora está seguindo %s.", pNome(targetid));
        format(logString, sizeof(logString), "%s (%s) colocou seu animal de estimação para seguir %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(targetid));
        logCreate(playerid, logString, 19);
    }
    return true;
}

/*GetDistance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2) {
	return floatround(floatsqroot(
        ((x1 - x2) * (x1 - x2)) + 
        ((y1 - y2) * (y1 - y2)) + 
        ((z1 - z2) * (z1 - z2))
        )
    );
} */

Float:GetDistance2D(Float:x1, Float:y1, Float:x2, Float:y2) {
	return floatsqroot(
		((x1 - x2) * (x1 - x2)) +
		((y1 - y2) * (y1 - y2))
	);
}

Float:GetAbsoluteAngle(Float:angle) {
	while(angle < 0.0) {
		angle += 360.0;
	}
	while(angle > 360.0) {
		angle -= 360.0;
	}
	return angle;
}

// Returns the offset heading from north between a point and a destination
Float:GetAngleToPoint(Float:fPointX, Float:fPointY, Float:fDestX, Float:fDestY) {
	return GetAbsoluteAngle(-(
		90.0 - (
			atan2(
				(fDestY - fPointY),
				(fDestX - fPointX)
			)
		)
	));
}

GetXYFromAngle(&Float:x, &Float:y, Float:a, Float:distance) {
    x += (distance*floatsin(-a,degrees));
    y += (distance*floatcos(-a,degrees));
}

SetFacingPlayer(actorid, playerid) {
    new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid, pX, pY, pZ);

    return SetFacingPoint(actorid, pX, pY);
}

SetFacingPoint(actorid, Float:x, Float:y) {
    new Float:pX, Float:pY, Float:pZ;
    GetActorPos(actorid, pX, pY, pZ);

    new Float:angle;

    if( y > pY ) angle = (-acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 90.0);
    else if( y < pY && x < pX ) angle = (acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 450.0);
    else if( y < pY ) angle = (acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 90.0);

    if(x > pX) angle = (floatabs(floatabs(angle) + 180.0));
    else angle = (floatabs(angle) - 180.0);

    return SetActorFacingAngle(actorid, angle);
}

IsValidPetModel(skinid) {
    switch(skinid) {
        case 29900..29919:
            return true;
    }
    return false;
}