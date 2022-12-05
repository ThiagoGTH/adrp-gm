#include <YSI_Coding\y_hooks>

CMD:criargaragem(playerid, params[]) {
    new price, address[256], Float:pos[4];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "ds[256]", price, address))
        return SendSyntaxMessage(playerid, "/criargaragem [preço] [endereço único]");
    
    if(price < 1000)
        return SendErrorMessage(playerid, "O preço da garagem deve ser maior do que $1000.");
    
    CreateGarage(playerid, price, address, pos);

    return 1;
}

CMD:editargaragem(playerid, params[]) {
    new id, option[64], value[64];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if(sscanf(params, "ds[64]S()[64]", id, option, value)) {
        SendSyntaxMessage(playerid, "/editargaragem [id] [opção]");
        return SendClientMessage(playerid, COLOR_BEGE, "[Opções]: entrada, interior, preco, endereco");
    }

    if(!IsValidHouse(id))
        return SendErrorMessage(playerid, "Esse ID de garagem não existe.");

    // Editar a entrada (localização)
    if(!strcmp(option, "entrada", true)) {
        ChangeGarageEntry(playerid, id);
    }

    // Editar o interior (lado de dentro)
    if(!strcmp(option, "interior", true)) {
        ChangeGarageInterior(playerid, id);
    }

    return 1;
}

CMD:setargaragemcasa(playerid, params[]) {
    new garageId;
    new houseId = GetNearestHouseEntry(playerid);

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

    if (sscanf(params, "d", garageId))
        return SendSyntaxMessage(playerid, "/setargaragemcasa [id da garagem]");
    
    if (!houseId)
        return SendErrorMessage(playerid, "Você não está próximo à nenhuma casa.");
    
    if (hInfo[houseId][hGarage])
        return SendErrorMessage(playerid, "Essa casa já possui uma garagem.");
    
    AttachGarageToHouse(playerid, houseId, garageId);

    return 1;
}

CMD:irgaragem(playerid, params[]) {
    new id;

    if(GetPlayerAdmin(playerid) < 2)
        return SendPermissionMessage(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/irgaragem [id]");

    SendPlayerGarage(playerid, id);

    return 1;
}