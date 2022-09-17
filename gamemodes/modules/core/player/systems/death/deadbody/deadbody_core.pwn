#include <YSI_Coding\y_hooks>

forward DeleteDeadBody(playerid); 
public DeleteDeadBody(playerid) {
    if(IsValidDynamicActor(DeadBody[playerid][e_ACTOR])) {
        DestroyDynamicActor(DeadBody[playerid][e_ACTOR]);
        DeadBody[playerid][e_ACTOR] = -1;
    }

    if(IsValidDynamic3DTextLabel(DeadBody[playerid][e_TEXT])) {
        DestroyDynamic3DTextLabel(DeadBody[playerid][e_TEXT]);
        DeadBody[playerid][e_TEXT] = Text3D:INVALID_3DTEXT_ID; 
    }

    KillTimer(DeadBody[playerid][e_TIME]);
    DeadBody[playerid][e_SKIN] = -1;
    DeadBody[playerid][e_POS][0] = 0.0;
    DeadBody[playerid][e_POS][1] = 0.0;
    DeadBody[playerid][e_POS][2] = 0.0;
    DeadBody[playerid][e_POS][3] = 0.0;
    DeadBody[playerid][e_WORLD] = 0;
    DeadBody[playerid][e_INTERIOR] = 0;
    DeadBody[playerid][e_DEADBY][0] = EOS;
    DeadBody[playerid][e_NAME][0] = EOS;
    return true;
}

CreateDeadBody(playerid) {
    DeleteDeadBody(playerid);

    GetPlayerPos(playerid, DeadBody[playerid][e_POS][0], DeadBody[playerid][e_POS][1], DeadBody[playerid][e_POS][2]);
    GetPlayerFacingAngle(playerid, DeadBody[playerid][e_POS][3]);
    DeadBody[playerid][e_INTERIOR] = GetPlayerInterior(playerid);
	DeadBody[playerid][e_WORLD] = GetPlayerVirtualWorld(playerid);
    DeadBody[playerid][e_SKIN] = pInfo[playerid][pSkin];

    DeadBody[playerid][e_ACTOR] = playerid;
    DeadBody[playerid][e_ACTOR] = CreateDynamicActor(DeadBody[playerid][e_SKIN], DeadBody[playerid][e_POS][0], DeadBody[playerid][e_POS][1], DeadBody[playerid][e_POS][2], DeadBody[playerid][e_POS][3], .worldid = DeadBody[playerid][e_WORLD], .interiorid = DeadBody[playerid][e_INTERIOR]);
        
    SetDynamicActorFacingAngle(DeadBody[playerid][e_ACTOR], DeadBody[playerid][e_POS][3]);
    SetDynamicActorVirtualWorld(DeadBody[playerid][e_ACTOR], DeadBody[playerid][e_WORLD]);
    ApplyDynamicActorAnimation(DeadBody[playerid][e_ACTOR], "PED", "FLOOR_hit_f", 25.0, false, true, true, true, 1);

    format(DeadBody[playerid][e_NAME], 24, "%s", pNome(playerid));
    format(DeadBody[playerid][e_DEADBY], 128, "%s", pInfo[playerid][pDeadBy]);

    new string[256];
    format(string, sizeof(string), "{D0AEEB}* Possível notar um corpo *\n* %s *{AFAFAF}\n(( %s (%d) ))", DeadBody[playerid][e_DEADBY], DeadBody[playerid][e_NAME], playerid);

    DeadBody[playerid][e_TEXT] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, DeadBody[playerid][e_POS][0], DeadBody[playerid][e_POS][1], DeadBody[playerid][e_POS][2]-0.5, 5.0);

    DeadBody[playerid][e_TIME] = SetTimerEx("DeleteDeadBody", 300000, false, "i", playerid); // 300000 = 3min
    return true;
}

GetClosestDeadBody(playerid, &Float: dis = 15.00) {
	new deadbody = -1, player_world = GetPlayerVirtualWorld(playerid);

	for (new i = 0; i < MAX_PLAYERS; i++) if (DeadBody[i][e_WORLD] == player_world) {
    	new
    		Float: dis2 = GetPlayerDistanceFromPoint(playerid, DeadBody[i][e_POS][0], DeadBody[i][e_POS][1], DeadBody[i][e_POS][2]);

    	if (dis2 < dis && dis2 != -1.00) {
    	    dis = dis2;
    	    deadbody = i;
		}
	}
	return deadbody;
}

hook OnPlayerDisconnect(playerid, reason){
    DeleteDeadBody(playerid);
    return true;
}