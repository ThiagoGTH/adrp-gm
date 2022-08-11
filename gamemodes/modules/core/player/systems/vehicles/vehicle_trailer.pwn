#include <YSI_Coding\y_hooks>

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