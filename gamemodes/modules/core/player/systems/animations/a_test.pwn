CMD:sex(playerid, params[])
{
    switch(strval(params))
    {
        case 1: ApplyAnimation(playerid, "SNM", "SPANKINGW", 4.1, 1, 0, 0, 1, 1, 1);
        case 2: ApplyAnimation(playerid, "SNM", "SPANKEDP", 4.1, 1, 0, 0, 1, 1, 1);
        case 3: ApplyAnimation(playerid, "SNM", "SPANKING_ENDW", 4.1, 1, 0, 0, 1, 1, 1);
        case 4: ApplyAnimation(playerid, "SNM", "SPANKEDW", 4.1, 1, 0, 0, 1, 1, 1);
        default: SendClientMessage(playerid, -1, "Usage: /sex [1-4]");
    }
    return true;
}
CMD:blowjob(playerid, params[])
{
    switch(strval(params))
    {
        case 1: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 1, 0, 0, 1, 1, 1);
        case 2: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 1, 1, 1);
        case 3: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 1, 0, 0, 1, 1, 1);
        case 4: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 1, 1, 1);
        default: SendClientMessage(playerid, -1, "Usage: /blowjob [1-4]");
    }
    return true;
}