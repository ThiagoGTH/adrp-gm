hook OnPlayerConnect(playerid, reason)
{
    PetData[playerid][petModel] = INVALID_ACTOR_ID;
    PetData[playerid][petStatus] = PET_NONE;
    PetData[playerid][petSpawn] = false;
}

hook OnPlayerDisconnectEx(playerid, reason)
{
    PetDespawn(playerid);
}