#include <YSI_Coding\y_hooks>

CMD:aceitarboquete(playerid, params[]) {
    new targetid = pInfo[playerid][pBJOffer];
    if(!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendErrorMessage(playerid, "Voc� n�o est� perto deste jogador.");

    SetPlayerToFacePlayer(playerid, targetid);
	SetPlayerToFacePlayer(targetid, playerid);

	ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_P", 1.0, 1, 1, 1, 0, 0, 1);
	ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_START_W", 1.0, 1, 1, 1, 0, 0, 1);

	SetTimerEx("BlowJob", 1500, false, "ddd", targetid, playerid, 0);

    pInfo[playerid][pBJOffer] = -1;
    return true;
}

CMD:boquete(playerid, params[]) {
    static
	    userid;
	
    if (sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/boquete [id/nome]");
    if (userid == playerid) return SendErrorMessage(playerid, "Voc� n�o fazer um boquete em si mesmo.");
    if (userid == INVALID_PLAYER_ID) return SendNotConnectedMessage(playerid);
    if(!IsPlayerNearPlayer(playerid, userid, 5.0)) return SendErrorMessage(playerid, "Voc� n�o est� perto deste jogador.");

	pInfo[userid][pBJOffer] = playerid;

    va_SendClientMessage(userid, COLOR_YELLOW, "%s ofereceu um boquete (use: \"/aceitarboquete\").", pNome(userid));
	SendServerMessage(playerid, "Voc� ofereceu um boquete para %s.", pNome(userid));

	return true;
}

forward BlowJob(playerid, userid, step);
public BlowJob(playerid, userid, step) {
	switch(step) {
	    case 0:
	    {
			ApplyAnimation(userid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 2.0, 1, 1, 1, 0, 0, 1);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 2.0, 1, 1, 1, 0, 0, 1);
            SetTimerEx("BlowJob", 10000, false, "ddd", playerid, userid, 1);
	    }
	    case 1:
	    {
			ApplyAnimation(userid, "BLOWJOBZ", "BJ_STAND_END_P", 2.0, 0, 1, 1, 0, 0, 1);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_W", 2.0, 1, 1, 1, 0, 0, 1);
            SetTimerEx("BlowJob", 2500, false, "ddd", playerid, userid, 2);
	    }
	    case 2:
	    {
			TogglePlayerControllable(playerid, 1);
			TogglePlayerControllable(userid, 1);
	        ClearAnimations(playerid), SetCameraBehindPlayer(playerid);
	        ClearAnimations(userid), SetCameraBehindPlayer(userid);
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