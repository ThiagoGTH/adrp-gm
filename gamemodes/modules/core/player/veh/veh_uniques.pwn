#include <YSI_Coding\y_hooks>

new
	ShipObject[MAX_VEHICLES] = {INVALID_OBJECT_ID, ...};

hook OnGameModeExit()
{
	for(new i; i < MAX_VEHICLES; ++i)
	{
	    if(IsValidVehicle(i) && IsValidObject(ShipObject[i]))
	    {
	        DestroyVehicle(i);
	        DestroyObject(ShipObject[i]);
	        ShipObject[i] = INVALID_OBJECT_ID;
	    }
	}

	return 1;
}

CMD:ovni(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 1337) return SendPermissionMessage(playerid);
    
	if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Você não pode utilizar este comando dentro de um veículo.");
	if(GetPlayerInterior(playerid) > 0) return SendErrorMessage(playerid, "Você não pode utilizar este comando dentro de um interior.");
	new Float: x, Float: y, Float: z, Float: a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	new id = CreateVehicle(501, x, y, z, a, 1, 1, -1);
  	LinkVehicleToInterior(id, 1);
	ShipObject[id] = CreateObject(18846, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(ShipObject[id], id, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	PutPlayerInVehicle(playerid, id, 0);
	SendClientMessage(playerid, CINZA, "Você entrou em um OVNI, para sair digite: /ovnisair.");
    new string[128];
    format(string, sizeof string, "`OVNI:` [%s] **%s** *(%s)* entrou em um OVNI.", ReturnDate(), GetPlayerNameEx(playerid), PlayerIP(playerid));
    DCC_SendChannelMessage(DC_VehUniques, string);
	return 1;
}

CMD:ovnisair(playerid, params[])
{
	if(!pInfo[playerid][pLogged]) return 1;
    if(uInfo[playerid][uAdmin] < 1337) return SendPermissionMessage(playerid);

	//if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você não pode utilizar este comando se não estiver em um veículo.");
	if(!IsValidObject(ShipObject[ GetPlayerVehicleID(playerid) ])) return SendErrorMessage(playerid, "Você não está utilizando um OVNI.");
	new id = GetPlayerVehicleID(playerid);
	DestroyVehicle(id);
	DestroyObject(ShipObject[id]);
	ShipObject[id] = INVALID_OBJECT_ID;
    new string[128];
    format(string, sizeof string, "`OVNI:` [%s] **%s** *(%s)* saiu de um OVNI.", ReturnDate(), GetPlayerNameEx(playerid), PlayerIP(playerid));
    DCC_SendChannelMessage(DC_VehUniques, string);
	return 1;
}

hook OnVehicleDeath(vehicleid)
{
	if(IsValidObject(ShipObject[vehicleid]))
	{
	    DestroyVehicle(vehicleid);
	    DestroyObject(ShipObject[vehicleid]);
	    ShipObject[vehicleid] = INVALID_OBJECT_ID;
	}
	return 1;
}