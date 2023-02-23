#include <YSI_Coding\y_hooks>

CMD:darcaravana(playerid, params[]) {
	if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);

	static userid, type;
	if (sscanf(params, "ud", userid, type)) return SendSyntaxMessage(playerid, "/darcaravana [id/nome] [tipo]");
	if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if (type < 1 || type > 3) return SendErrorMessage(playerid, "Você especificou um tipo de caravana inválido. Os tipos variam entre um e três.");
    
	static Float:x, Float:y, Float:z, Float:a, id = -1;
    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, a);
	SetPlateFree(playerid);

    id = VehicleCreate(pInfo[userid][pID], 697, x, y + 2, z + 1, a, 0, 0, pInfo[playerid][pBuyingPlate], 0, 0, 0, 0, 0, 0, 1, type);
	pInfo[playerid][pBuyingPlate][0] = EOS;

	if (id == -1) return SendErrorMessage(playerid, "O servidor chegou ao limite máximo de veículos dinâmicos.");

	SendServerMessage(playerid, "Você criou uma caravana para %s.", pNome(userid));

	format(logString, sizeof(logString), "%s (%s) criou uma caravana para %s", pNome(playerid), GetPlayerUserEx(playerid), pNome(userid));
	logCreate(playerid, logString, 1);
	return true;
}

CMD:trailer(playerid, params[]) {

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você não é o motorista.");

    new vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid));
	if (vehicleid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Não tem nenhum veiculo próximo.");
    LinkVehicleToInterior(vehicleid, 1);
    AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
	return true;
}

CMD:trailerex(playerid, params[]) {

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você não é o motorista.");

    new vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid));
	if (vehicleid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Não tem nenhum veiculo próximo.");

    DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	return true;
}