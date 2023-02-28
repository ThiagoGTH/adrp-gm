hook OnGameModeInit(){
    CreateDynamicPickup(1239, 23, 1485.1274, -1788.7457, 18.7360);
	CreateDynamic3DTextLabel("Taxas Governamentais\n{FFFFFF}Digite /taxas para verificar", COLOR_WHITE, 1485.1274, -1788.7457, 18.7360, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
    return true;
}