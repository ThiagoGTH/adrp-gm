#include <YSI_Coding\y_hooks>

CMD:aceitarboquete(playerid, params[]) {
    new targetid = pInfo[playerid][pBJOffer];
    if(!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste jogador.");
 
/*    SetPlayerToFacePlayer(playerid, targetid);
	SetPlayerToFacePlayer(targetid, playerid);*/

	ApplyAnimation(playerid, "BLOWJOBZ", "BJ_Car_Start_P", 1.0, true, true, true, false, 0);
	ApplyAnimation(targetid, "BLOWJOBZ", "BJ_Car_Start_W", 1.0, true, true, true, false, 0);

	SetTimerEx("BlowJob", 1500, false, "ddd", targetid, playerid, 0);

    pInfo[playerid][pBJOffer] = -1;
    return true;
}

CMD:boquete(playerid, params[]) {
    static
	    userid;
	
    if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/boquete [id/nome]");
    if (userid == playerid) return SendErrorMessage(playerid, "Você não fazer um boquete em si mesmo.");
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if(!IsPlayerNearPlayer(playerid, userid, 5.0)) return SendErrorMessage(playerid, "Você não está perto deste jogador.");

	pInfo[userid][pBJOffer] = playerid;

    va_SendClientMessage(userid, COLOR_YELLOW, "%s ofereceu um boquete (use: \"/aceitarboquete\").", pNome(userid));
	SendServerMessage(playerid, "Você ofereceu um boquete para %s.", pNome(userid));

	return true;
}

forward BlowJob(playerid, userid, step);
public BlowJob(playerid, userid, step) {
	switch(step) {
	    case 0:
	    {
			ApplyAnimation(userid, "BLOWJOBZ", "BJ_Car_Loop_P", 2.0, true, true, true, false, 0);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_Car_Loop_W", 2.0, true, true, true, false, 0);
            SetTimerEx("BlowJob", 10000, false, "ddd", playerid, userid, 1);
	    }
	    case 1:
	    {
			ApplyAnimation(userid, "BLOWJOBZ", "BJ_Car_End_P", 2.0, false, true, true, false, 0);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_Car_End_W", 2.0, true, true, true, false, 0);
            SetTimerEx("BlowJob", 2500, false, "ddd", playerid, userid, 2);
	    }
	    case 2:
	    {
	        ClearAnimations(playerid);
	        ClearAnimations(userid);
	    }
	}
}

SetPlayerToFacePlayer(playerid, targetid) {
	static
	    Float:x[2],
	    Float:y[2],
	    Float:z[2],
	    Float:angle;

	GetPlayerPos(targetid, x[0], y[0], z[0]);
	GetPlayerPos(playerid, x[1], y[1], z[1]);

	angle = (180.0 - atan2(x[1] - x[0], y[1] - y[0]));
	SetPlayerFacingAngle(playerid, angle + (5.0 * -1));
}