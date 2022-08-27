IsPetSpawned(playerid) {
    if(PetData[playerid][petSpawn])
        return 1;

    return 0;
}

ShowPetMenu(playerid) {
    new string[255], title[126];

    format(title, sizeof(title), "Gerenciar %s", PetData[playerid][petName]);

    if(PetData[playerid][petSpawn]) format(string, sizeof(string), "Ação: Fica\nAção: Segue\nAção: Senta\nAção: Deita\nAção: Pula\n\t\n{FF0000}Despawnar");
    else format(string, sizeof(string), "Alterar nome\n\t\n{36A717}Spawnar");

    Dialog_Show(playerid, PETMENU, DIALOG_STYLE_LIST, title, string, "Selecionar", "Fechar");
    return 1;
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
    return 1;
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
    return 1;
}

PetSit(playerid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_SIT;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "ped", "SEAT_down", 4.1, 0, 0, 0, 1, 0);
        SendServerMessage(playerid, "Your pet is now sit!");
    }
    return 1;
}

PetLay(playerid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_LAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "CRACK", "crckidle2", 4.1, 0, 0, 0, 1, 0);
        SendServerMessage(playerid, "Your pet is now lay!");
    }
    return 1;
}

PetJump(playerid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_LAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "BSKTBALL", "BBALL_DEF_JUMP_SHOT", 4.1, 1, 0, 0, 0, 0);
        SendServerMessage(playerid, "Your pet is now lay!");
    }
    return 1;
}

PetStay(playerid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_STAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        SendServerMessage(playerid, "Your pet is now Stay!");
    }
    return 1;
}

PetFollow(playerid, targetid) {
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        if(PetData[playerid][petStatus] == PET_FOLLOW)
        {
            stop PetData[playerid][petTimer];
        }
        PetData[playerid][petStatus] = PET_FOLLOW;
        ClearActorAnimations(PetData[playerid][petModel]);
        PetData[playerid][petTimer] = repeat Pet_Update(playerid, targetid);
        SendServerMessage(playerid, "Your pet is now following!");
    }
    return 1;
}

PetName(playerid) {
    if(PetData[playerid][petSpawn])
        return SendErrorMessage(playerid, "De-spawn pet mu terlebih dahulu!");

    if(strcmp(PetData[playerid][petName], "Jack", true))
        return SendErrorMessage(playerid, "Nama pet mu sudah tidak bisa di ubah lagi!");

    Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Pet Name", "WARNING: Pergantian nama pet hanya bisa 1x\n\nInput your pet name:", "Input Name", "Cancel");
    return 1;
}

Dialog:PET_NAME(playerid, response, listitem, inputtext[]) {
    if(response) {
        if(isnull(inputtext) || IsNumeric(inputtext))
            return Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Pet Name", "ERROR: Fill the name!\nInput your pet name:", "Input Name", "Cancel");

        if(strlen(inputtext) > 128)
            return Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Pet Name", "ERROR: Name are not allowed more than 128 character!\nInput your pet name:", "Input Name", "Cancel");

        format(PetData[playerid][petName], 128, "%s", inputtext);
        SendServerMessage(playerid, "You have change your pet name to %s", inputtext);
    }
    return 1;
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

Dialog:PET_MENU_FOLLOW(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new targetid;

        if(isnull(inputtext))
            return PetFollow(playerid, playerid);

        if(!IsNumeric(inputtext))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Pet Follow", "Input Player ID that you wanted your pet to follow!", "Follow", "Cancel");

        if(sscanf(inputtext, "u", targetid))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Pet Follow", "ERROR: Input playerid can't be empty!\n\nInput Player ID that you wanted your pet to follow!", "Follow", "Cancel");
    
        if(targetid == INVALID_PLAYER_ID || !IsPlayerSpawned(targetid))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Pet Follow", "ERROR: Invalid player id!\n\nInput Player ID that you wanted your pet to follow!", "Follow", "Cancel");


        PetFollow(playerid, targetid);
        SendServerMessage(playerid, "Your pet is now following %s", pNome(targetid));
    }
    return 1;
}

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
        case 20062..20069:
            return 1;
    }
    return 0;
}