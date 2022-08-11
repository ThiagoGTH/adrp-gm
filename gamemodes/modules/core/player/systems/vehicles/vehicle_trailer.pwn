#include <YSI_Coding\y_hooks>

CMD:trailer(playerid, params[]) {

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Voc� n�o � o motorista.");

    new vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid));
	if (vehicleid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "N�o tem nenhum veiculo pr�ximo.");
    LinkVehicleToInterior(vehicleid, 1);
    AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
	return true;
}

CMD:trailerex(playerid, params[]) {

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Voc� n�o � o motorista.");

    new vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid));
	if (vehicleid == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "N�o tem nenhum veiculo pr�ximo.");

    DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	return true;
}