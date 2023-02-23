CrashEat(playerid) {
    ClearAnimations(playerid);
    ApplyAnimation(playerid, "FOOD", "EAT_VOMIT_P", 4.1, false, false, false, false, 0);
    SetTimerEx("BlowUpPlayer", 3500, false, "d", playerid);
    return true;
}

forward BlowUpPlayer(playerid);
public BlowUpPlayer(playerid) {
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    PlaySoundForPlayersInRange(32201, 5.0, x, y, z);
    SetPlayerAttachedObject(playerid, 0, 18722, 2,  0.115000, 1.782999, 0.088999,  91.600044, -4.200001, 102.099937,  1.000000, 1.000000, 1.000000); 
}

CMD:vomitar(playerid) {
    CrashEat(playerid);
    return true;
}