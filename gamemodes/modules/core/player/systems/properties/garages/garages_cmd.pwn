CMD:criargaragem(playerid, params[]) {
    new price, address[256], Float:pos[4];

    if(GetPlayerAdmin(playerid) < 2 || !GetUserTeam(playerid, 2)) return SendPermissionMessage(playerid);

	if (sscanf(params, "ds[256]", price, address))
        return SendSyntaxMessage(playerid, "/criargaragem [pre�o] [endere�o �nico]");
    
    if(price < 1000)
        return SendErrorMessage(playerid, "O pre�o da garagem deve ser maior do que $1000.");
    
    CreateGarage(price, address, pos);

    return 1;
}