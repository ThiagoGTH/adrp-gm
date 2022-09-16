new actorsito[MAX_PLAYERS];
  
hook OnPlayerDeath(playerid, killerid, reason)
{
    new Float: x_, Float: y_, Float: z_, Float: r_;
    actorsito[playerid] = playerid;
    GetPlayerPos(playerid, x_, y_, z_);
    GetPlayerFacingAngle(playerid, r_);
    actorsito[playerid] = CreateActor(GetPlayerSkin(playerid), x_, y_, z_, r_);
    SetActorVirtualWorld(actorsito[playerid], GetPlayerVirtualWorld(playerid));
    ApplyActorAnimation(actorsito[playerid], "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1); //
    SetTimerEx("borrar_a", 15000, false, "i", playerid); // 15000 = 15seg
    return true;
}
 
forward borrar_a(playerid); public borrar_a(playerid)
{
    if (actorsito[playerid] != -1){
        DestroyActor(actorsito[playerid]);
        actorsito[playerid] = -1;
    }
    return true;
}
 
hook OnPlayerConnect(playerid)
{
    actorsito[playerid] = -1;
}
 
// Opcional.
CMD:deletecorpse(playerid, params[])
{
    new id;
    if (!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "* Not authorized.");
    if (sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "CMD: /deletecorpse [id jugador]");
    if (actorsito[id] == -1) return SendClientMessage(playerid, -1, "* Player is not corpse.");
    DestroyActor(actorsito[id]);
    actorsito[id] = -1;
    return 1;
}