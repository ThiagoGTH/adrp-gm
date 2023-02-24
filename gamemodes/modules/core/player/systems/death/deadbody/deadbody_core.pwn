#include <YSI_Coding\y_hooks>
new DraggingCorpse[MAX_PLAYERS];
new CorpseID[MAX_PLAYERS];
new CarryingCorpse[MAX_PLAYERS][24];
new Timer:CorpseTimer[MAX_PLAYERS];
new Float:LastX[MAX_PLAYERS];
new Float:LastY[MAX_PLAYERS];
new Float:LastZ[MAX_PLAYERS];
new Float:LastA[MAX_PLAYERS];

forward DeleteDeadBody(playerid); 
public DeleteDeadBody(playerid) {
    if(IsValidActor(DeadBody[playerid][e_ACTOR])) {
        DestroyActor(DeadBody[playerid][e_ACTOR]);
    }

    if(IsValidDynamic3DTextLabel(DeadBody[playerid][e_TEXT])) {
        DestroyDynamic3DTextLabel(DeadBody[playerid][e_TEXT]);
    }

    DeadBody[playerid][e_SKIN] = -1;
    DeadBody[playerid][e_POS][0] = 0.0;
    DeadBody[playerid][e_POS][1] = 0.0;
    DeadBody[playerid][e_POS][2] = 0.0;
    DeadBody[playerid][e_POS][3] = 0.0;
    DeadBody[playerid][e_WORLD] = 0;
    DeadBody[playerid][e_INTERIOR] = 0;
    DeadBody[playerid][e_DEADBY][0] = EOS;
    DeadBody[playerid][e_NAME][0] = EOS;

    DestroyActor(DeadBody[playerid][e_ACTOR]);
    DeadBody[playerid][e_ACTOR] = -1;

    DestroyDynamic3DTextLabel(DeadBody[playerid][e_TEXT]);
    DeadBody[playerid][e_TEXT] = Text3D:INVALID_3DTEXT_ID;

    KillTimer(DeadBody[playerid][e_TIME]);
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
    DeadBody[playerid][e_ACTOR] = CreateActor(DeadBody[playerid][e_SKIN], DeadBody[playerid][e_POS][0], DeadBody[playerid][e_POS][1], DeadBody[playerid][e_POS][2], DeadBody[playerid][e_POS][3]);

    SetActorFacingAngle(DeadBody[playerid][e_ACTOR], DeadBody[playerid][e_POS][3]);
    SetActorVirtualWorld(DeadBody[playerid][e_ACTOR], DeadBody[playerid][e_WORLD]);
    ApplyActorAnimation(DeadBody[playerid][e_ACTOR], "PED", "FLOOR_hit_f", 25.0, false, true, true, true, 1);

    format(DeadBody[playerid][e_NAME], 24, "%s", pNome(playerid));
    format(DeadBody[playerid][e_DEADBY], 128, "%s", pInfo[playerid][pDeadBy]);

    new string[256];
    format(string, sizeof(string), "{D0AEEB}* Possível notar um corpo *\n* %s *{AFAFAF}\n(( %s (%d) ))", DeadBody[playerid][e_DEADBY], DeadBody[playerid][e_NAME], playerid);

    DeadBody[playerid][e_TEXT] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, DeadBody[playerid][e_POS][0], DeadBody[playerid][e_POS][1], DeadBody[playerid][e_POS][2]-0.5, 5.0);

    DeadBody[playerid][e_TIME] = SetTimerEx("DeleteDeadBody", 300000, false, "d", playerid); // 300000 5 min
    return true;
}

GetClosestDeadBody(playerid, &Float: dis = 5.00) {
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

hook OnPlayerDisconnect(playerid, reason) {
    DeleteDeadBody(playerid);
    DraggingCorpse[playerid] = INVALID_ACTOR_ID;
    CorpseID[playerid] = -1;
    return true;
}

SetActorBehindPlayer(actorid, playerid, Float:distance = 0.2) {
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    x += (distance * floatsin( -a + 180, degrees));
    y += (distance * floatcos( -a + 180, degrees));

    SetActorPos(actorid, x, y, z + 0.80);
    SetActorFacingAngle(actorid, a-180);
    return true;
}

timer UpdateCorpse[100](playerid) {
    if(DraggingCorpse[playerid] != INVALID_ACTOR_ID) {
        new actor = DraggingCorpse[playerid];

        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);

        if(x != LastX[playerid] || y != LastY[playerid] || z != LastZ[playerid] || a != LastA[playerid]) {
            SetActorPos(actor, x, y, z + 1.5);
            SetActorFacingAngle(actor, a);
            ApplyActorAnimation(actor, "PED", "Drown", 4.1, false, true, true, true, 1);
            SetActorBehindPlayer(actor, playerid);

            GetPlayerPos(playerid, LastX[playerid], LastY[playerid], LastZ[playerid]);
            GetPlayerFacingAngle(playerid, LastA[playerid]);
        }
        defer UpdateCorpse(playerid);
    }
}