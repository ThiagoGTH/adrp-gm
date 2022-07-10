#include <YSI_Coding\y_hooks>

#define USER_CHARACTERS_LIMIT 5
#define USER_CHARACTERS_LIMIT_VIP 10

new MySQL:DBConn;
new logString[255];
new loginAttempts[MAX_PLAYERS];

enum User_Data {
    uID,
    uName[24],
    uPass[16],
    uAdmin,
    uVip,
    uFactionMod,
	uPropertyMod,
};

new uInfo[MAX_PLAYERS][User_Data];

enum Player_Data {
    pID,
    pName[24],
    pUser[24],
    pFirstIP[15],
    pLastIP[15],
    pAdmin,

    pAge,
    pGender[15],
    pBackground[50],

    Float:pHealth,
    Float:pArmour,

    pMoney,
    pBank,

    pSkin,
    pScore,

    Float:pPositionX,
    Float:pPositionY,
    Float:pPositionZ,
    Float:pPositionA,
    pVirtualWorld,
    pInterior,

    pPhoneNumber,
    pPhoneType,

    pEditandoBareira,
    pLicence,

    pFreeze,
    pFreezeTimer,

    pGuns[13],
	pAmmo[13],

    pLastShot[64],
    pShotTime,

    pJetpack,
    pAdminDuty,

    pInjured,
    pBrutallyWounded, 
    pDead,
    pDeadTime,
    pLastBlow,
    Text3D:pBrutallyTag,
    Text3D:pNametag,
    pNametagType,
    pAllowRespawn,
    pLastKnockout,
    pTotalDamages,

    pLimping,
    pLimpingTime,
    bool:pPassedOut,

    pTackleMode,
    pTackleTimer,

    pAdTick,

    pESC,
    Float:pHealthMax,

    // CAMERA-MAN
    bool:pWatching,
	pWatchingPlayer,
	bool:pRecording,
	pCameraTimer,

    // FACTIONS
    pSwat,

    pJailed,
    // Temp variables
    bool:pLogged,
    pFlying,
    pQuestion,
    pAnswer,
    characterDelete[24],
    tempChar[64],
    tempChar2[64],
    pInterfaceTimer
};
new pInfo[MAX_PLAYERS][Player_Data];

new const g_aWeaponSlots[] = {
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11
};

void:ResetUserData(playerid) {
    loginAttempts[playerid]               = 
    uInfo        [playerid][uAdmin]       = 
    uInfo        [playerid][uID]          = 
    uInfo        [playerid][uVip]         = 
    uInfo        [playerid][uFactionMod]  = 
    uInfo        [playerid][uPropertyMod] = 0;

    uInfo[playerid][uName][0] = EOS;
}

void:ResetCharacterData(playerid) {
    pInfo[playerid][pID] = 0;
    pInfo[playerid][pName][0] =
    pInfo[playerid][pUser][0] =
    pInfo[playerid][pFirstIP][0] =
    pInfo[playerid][pLastIP][0] = 
    pInfo[playerid][pGender][0] =
    pInfo[playerid][pBackground][0] = EOS;

    pInfo[playerid][pHealth] = 0;
    pInfo[playerid][pArmour] = 0;
    pInfo[playerid][pMoney] = 0;
    pInfo[playerid][pBank] = 0;
    pInfo[playerid][pSkin] = 0;
    pInfo[playerid][pScore] = 0;
    pInfo[playerid][pPositionX] = 0;
    pInfo[playerid][pPositionY] = 0;
    pInfo[playerid][pPositionZ] = 0;
    pInfo[playerid][pPositionA] = 0;
    pInfo[playerid][pVirtualWorld] = 0; 
    pInfo[playerid][pInterior] = 0; 
    pInfo[playerid][pEditandoBareira] = 0;
    pInfo[playerid][pLicence] = 0;
    pInfo[playerid][pPhoneType] = 0;
    pInfo[playerid][pPhoneNumber] = 0;

    pInfo[playerid][pFreeze] = 0;
    pInfo[playerid][pFreezeTimer] = 0;
    pInfo[playerid][pJetpack] = 0;
    pInfo[playerid][pAdminDuty] = 0;

    pInfo[playerid][pInjured] = 0;
    pInfo[playerid][pBrutallyWounded] = 0;
    pInfo[playerid][pLastKnockout] = 0;
    pInfo[playerid][pDead] = 0;
    pInfo[playerid][pDeadTime] = 0;
    pInfo[playerid][pAllowRespawn] = 0;
    pInfo[playerid][pLastBlow] = 0;
    pInfo[playerid][pTotalDamages] = 0;
    pInfo[playerid][pHealthMax] = 0;
    pInfo[playerid][pLimping] = 0;
    pInfo[playerid][pLimpingTime] = 0;
    pInfo[playerid][pPassedOut] = false;
    pInfo[playerid][pJailed] = 0;
    pInfo[playerid][pSwat] = 0;
    pInfo[playerid][pNametagType] = 0;

    pInfo[playerid][pTackleMode] = false;
    pInfo[playerid][pTackleTimer] = 0;
    pInfo[playerid][pAdTick] = 0;
    pInfo[playerid][pFlying] = 0;
    pInfo[playerid][pESC] = 0;
    ClearDamages(playerid);

    pInfo[playerid][pRecording] = false;
    pInfo[playerid][pWatching] = false;
    pInfo[playerid][pWatchingPlayer] = INVALID_PLAYER_ID;
    pInfo[playerid][pCameraTimer] = -1;
    
    // TEMP VARS
    pInfo[playerid][tempChar][0] = 
    pInfo[playerid][tempChar2][0] = 
    pInfo[playerid][characterDelete][0] = EOS;
    pInfo[playerid][pAnswer] = -1;
    pInfo[playerid][pQuestion] = -1;
    pInfo[playerid][pInterfaceTimer] = -1;

    if (IsValidDynamic3DTextLabel(pInfo[playerid][pBrutallyTag]))
	{
		DestroyDynamic3DTextLabel(pInfo[playerid][pBrutallyTag]);
	    pInfo[playerid][pBrutallyTag] = Text3D:INVALID_3DTEXT_ID;
	}

	for (new i = 0; i < 12; i ++) {
		pInfo[playerid][pGuns][i] = 0;
		pInfo[playerid][pAmmo][i] = 0;
	}
    format(pInfo[playerid][pLastShot], 64, "");
    pInfo[playerid][pShotTime] = 0;
}
