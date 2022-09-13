#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_CARS            (1500)

#define MAX_OWNABLE_CARS            (5)
#define MAX_OWNABLE_HOUSES          (3)
#define MAX_OWNABLE_BUSINESSES      (3)
#define MAX_PLAYER_VEHICLES         (20)

#define MAX_LISTED_ITEMS (10)

new MySQL:DBConn;
new logString[255];
new loginAttempts[MAX_PLAYERS];
new szBigString [256];

enum User_Data {
    uID,
    uName[24],
    uPass[16],
    uAdmin,
    // Teams
    uHeadFTeam, // Faction 
    uHeadPTeam, // Property
    uHeadETeam, // Event
    uHeadCTeam, // CK
    uFactionTeam,
    uPropertyTeam,
    uEventTeam,
    uCKTeam,
    uLogTeam,
    // Premium
    uPoints,
    uNameChanges,
    uNumberChanges,
    uFightChanges,
    uPlateChanges,
    uCharSlots,
    // Stats
    uRedFlag,
    uNewbie,
    uSOSAns,
    uDutyTime,
    uJailed
};

new uInfo[MAX_PLAYERS][User_Data];

enum Player_Data {
    pID,
    pName[24],
    pUser,
    pFirstIP[15],
    pLastIP[15],
    pAdmin,
    pDonator,
    pDonatorTime,

    pDateOfBirth[16],
    pBackground[128],

    Float:pHealth,
    Float:pArmour,

    pMoney,
    pBank,
    pSavings,
    pSkin,
    pScore,
    pPlayingMinutes,
    pPlayingHours,

    Float:pPositionX,
    Float:pPositionY,
    Float:pPositionZ,
    Float:pPositionA,
    pVirtualWorld,
    pInterior,

    // INFOS
    pGender,
    pEthnicity,
    pColorEyes,
    pColorHair,
    pHeight,
    Float:pWeight,
    pBuild,
    pDescription[128],

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

    // PLAYERS CONFIG
    pSetting,
    pTogNewbie,
    pTogAdmin,
    pNametagType,
    pRenderObjects,
    
    pAllowRespawn,
    pLastKnockout,
    pTotalDamages,

    pLimping,
    pLimpingTime,
    bool:pPassedOut,

    pTackleMode,
    pTackleTimer,
    pAFKCount,

    pAdTick,

    pESC,
    Float:pHealthMax,

    // RADIO
    rRadioState,            // Estado do rádio, se ligado ou desligado
    rRadioSlot[7],          // Os canais conectados nos slots, vai do 1 ao 7
    rRadioName1[32],        //
    rRadioName2[32],        //
    rRadioName3[32],        //
    rRadioName4[32],        //      O nome dos slots, trocados pelo /radio renomear
    rRadioName5[32],        //
    rRadioName6[32],        //
    rRadioName7[32],        //
    pRadioNvl[4],           // O nível do rádio

    // CAMERA-MAN
    bool:pWatching,
	pWatchingPlayer,
	bool:pRecording,
	pCameraTimer,

    pKicked,
    pShowFooter,
    // FACTIONS
    pFaction,
    pFactionRank,
    pFactionEdit,
    pSelectedSlot,

    pOnDuty,
    pSwat,

    pJailed,
    // Temp variables
    bool:pLogged,
    pBJOffer,
    pFlying,
    pQuestion,
    pAnswer,
    characterDelete[24],
    tempChar[64],
    tempChar2[64],
    pInterfaceTimer,
    pBuyingPlate[128],
    pTimerSpawn,
    pDelayNewbie,
    pInvestment,
    pChoosingCharacter,
    pCharacterChoosed,
    pCharacterActorSkin,
    pCharacterActor,
    pCharacterFinalizing,

    pSpectating,

    pEditingVeh,
    pOjectVeh,
    pSlotEdVeh,

    // Dealership
    dModel,
    dColor1,
    dColor2,
    dBuyVehicle,
    dVehPrice,
    dAlarm,
    dInsurance,
    dSunpass,
    dLegalized,
    dFinalPrice,
    dCam,
    dBuyingEditMenu,

    dEditingSQL,
    dEditingModel,
    dEditingPremium,
    dEditingCategory,
    dEditingPrice,
    dEditingMenu,

    iEditingSQL,
    iEditingModel,
    iEditingUseful,
    iEditingLegality,
    iEditingCategory,
    iEditingMenu,
    iEditingName[64],
    iEditingDesc[256],

    // Inventory
    iItem[30],
    iAmount[30],
    pInventoryItem,
    pEditDropped,
    pGiveItem,
};
new pInfo[MAX_PLAYERS][Player_Data];

new NearestItems[MAX_PLAYERS][MAX_LISTED_ITEMS];

new const g_aWeaponSlots[] = {
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11
};

void:ResetUserData(playerid) {
    uInfo[playerid][uName][0] = EOS;

    loginAttempts[playerid]               = 
    uInfo        [playerid][uAdmin]       = 
    // Teams
    uInfo        [playerid][uHeadFTeam]   = 
    uInfo        [playerid][uHeadPTeam]   = 
    uInfo        [playerid][uHeadETeam]   = 
    uInfo        [playerid][uHeadCTeam]   = 
    uInfo        [playerid][uFactionTeam] = 
    uInfo        [playerid][uPropertyTeam]= 
    uInfo        [playerid][uEventTeam]   = 
    uInfo        [playerid][uCKTeam]      = 
    uInfo        [playerid][uLogTeam]     = 

    uInfo        [playerid][uID]          = 
    // Stats
    uInfo        [playerid][uRedFlag]     =
    uInfo        [playerid][uNewbie]      = 
    uInfo        [playerid][uSOSAns]      = 
    uInfo        [playerid][uDutyTime]    =
    // Premium
    uInfo        [playerid][uPoints]        = 
    uInfo        [playerid][uNameChanges]   = 
    uInfo        [playerid][uNumberChanges] = 
    uInfo        [playerid][uFightChanges]  = 
    uInfo        [playerid][uPlateChanges]  = 
    uInfo        [playerid][uCharSlots]     = 0;


    uInfo        [playerid][uJailed]      = -1;
}

void:ResetCharacterData(playerid) {
    pInfo   [playerid][pID]             = 
    pInfo   [playerid][pUser]           = 0;
    pInfo   [playerid][pName][0]        =
    pInfo   [playerid][pFirstIP][0]     =
    pInfo   [playerid][pLastIP][0]      =
    pInfo   [playerid][pBackground][0]  = EOS;

    pInfo   [playerid][pDonator]        =
    pInfo   [playerid][pDonatorTime]    = 0;
    pInfo   [playerid][pPlayingMinutes] =
    pInfo   [playerid][pPlayingHours]   =
    pInfo   [playerid][pAFKCount]       =
    pInfo   [playerid][pAdmin]          = 0;
    pInfo   [playerid][pHealth]         = 0.00;
    pInfo   [playerid][pArmour]         = 0.00;
    pInfo   [playerid][pMoney]          =
    pInfo   [playerid][pBank]           =
    pInfo   [playerid][pSavings]        =
    pInfo   [playerid][pSkin]           =
    pInfo   [playerid][pScore]          = 0;
    pInfo   [playerid][pPositionX]      =
    pInfo   [playerid][pPositionY]      =
    pInfo   [playerid][pPositionZ]      =
    pInfo   [playerid][pPositionA]      = 0.00;
    pInfo   [playerid][pVirtualWorld]   =
    pInfo   [playerid][pInterior]       =
    pInfo   [playerid][pEditandoBareira]=
    pInfo   [playerid][pLicence]        =
    pInfo   [playerid][pPhoneType]      =
    pInfo   [playerid][pPhoneNumber]    = 0;

    pInfo   [playerid][pGender]             =
    pInfo   [playerid][pEthnicity]          = 
    pInfo   [playerid][pColorEyes]          = 
    pInfo   [playerid][pColorHair]          = 
    pInfo   [playerid][pHeight]             = 
    pInfo   [playerid][pBuild]              = 0;
    pInfo   [playerid][pWeight]             = 0.00;
    pInfo   [playerid][pDescription][0]     = EOS;

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

    pInfo[playerid][pFaction] = 0;
    pInfo[playerid][pFactionRank] = 0;
    pInfo[playerid][pFactionEdit] = 0;
    pInfo[playerid][pSelectedSlot] = 0;

    pInfo[playerid][pOnDuty] = 0;
    pInfo[playerid][pSwat] = 0;

    pInfo[playerid][pSetting] =
    pInfo[playerid][pTogNewbie] =
    pInfo[playerid][pTogAdmin] =
    pInfo[playerid][pNametagType] =
    pInfo[playerid][pRenderObjects] = 0;

    pInfo[playerid][pTackleMode] = false;
    pInfo[playerid][pTackleTimer] = 0;
    pInfo[playerid][pAdTick] = 0;
    pInfo[playerid][pFlying] = 0;
    pInfo[playerid][pBJOffer] = -1;
    pInfo[playerid][pESC] = 0;
    pInfo[playerid][pDelayNewbie] = 0;

    pInfo[playerid][pEditingVeh] = 0;
    pInfo[playerid][pOjectVeh] = 0;
    pInfo[playerid][pSlotEdVeh] = 0;

    pInfo[playerid][pInvestment] = 0;
    ClearDamages(playerid);

    pInfo[playerid][pRecording] = false;
    pInfo[playerid][pWatching] = false;
    pInfo[playerid][pWatchingPlayer] = INVALID_PLAYER_ID;
    pInfo[playerid][pCameraTimer] = -1;

    pInfo[playerid][pSpectating] = INVALID_PLAYER_ID;

    // RADIO
    pInfo[playerid][rRadioState] = 0;
    pInfo[playerid][rRadioSlot][0] = 0;
    pInfo[playerid][rRadioSlot][1] = 0;
    pInfo[playerid][rRadioSlot][2] = 0;
    pInfo[playerid][rRadioSlot][3] = 0;
    pInfo[playerid][rRadioSlot][4] = 0;
    pInfo[playerid][rRadioSlot][5] = 0;
    pInfo[playerid][rRadioSlot][6] = 0;
    format(pInfo[playerid][rRadioName1], 90, "0");
    format(pInfo[playerid][rRadioName2], 90, "0");
    format(pInfo[playerid][rRadioName3], 90, "0");
    format(pInfo[playerid][rRadioName4], 90, "0");
    format(pInfo[playerid][rRadioName5], 90, "0");
    format(pInfo[playerid][rRadioName6], 90, "0");
    format(pInfo[playerid][rRadioName7], 90, "0");

    pInfo[playerid][pKicked] = 0;
    
    // TEMP VARS
    pInfo[playerid][tempChar][0] = 
    pInfo[playerid][tempChar2][0] = 
    pInfo[playerid][characterDelete][0] = EOS;
    pInfo[playerid][pAnswer] = -1;
    pInfo[playerid][pQuestion] = -1;
    pInfo[playerid][pInterfaceTimer] = -1;
    format(pInfo[playerid][pBuyingPlate], 120, "");
    pInfo[playerid][pTimerSpawn] = 0;

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

    pInfo[playerid][dModel] =
    pInfo[playerid][dBuyVehicle] =
    pInfo[playerid][dVehPrice] =
    pInfo[playerid][dAlarm] =
    pInfo[playerid][dInsurance] =
    pInfo[playerid][dColor1] =
    pInfo[playerid][dColor2] =
    pInfo[playerid][dSunpass] =
    pInfo[playerid][dLegalized] =
    pInfo[playerid][dCam] =
    pInfo[playerid][dBuyingEditMenu] =
    pInfo[playerid][dFinalPrice] = 0;

    pInfo[playerid][dEditingSQL] =
    pInfo[playerid][dEditingModel] =
    pInfo[playerid][dEditingPremium] =
    pInfo[playerid][dEditingCategory] =
    pInfo[playerid][dEditingPrice] =
    pInfo[playerid][dEditingMenu] = 0;

    pInfo[playerid][iEditingSQL] =
    pInfo[playerid][iEditingModel] =
    pInfo[playerid][iEditingUseful] =
    pInfo[playerid][iEditingLegality] =
    pInfo[playerid][iEditingCategory] =
    pInfo[playerid][iEditingMenu] = 0;
    pInfo[playerid][iEditingDesc][0] =
    pInfo[playerid][iEditingName][0] = EOS;
    
    // INVENTORY
    for (new i = 0; i < 30; i ++) {
    	pInfo[playerid][iItem][i] = 0;
        pInfo[playerid][iAmount][i] = 0;
	}
    pInfo[playerid][pInventoryItem] = -1;
    pInfo[playerid][pEditDropped] = 0;
    pInfo[playerid][pGiveItem] = -1;

    for (new i = 0; i < MAX_LISTED_ITEMS; i ++) {
	    NearestItems[playerid][i] = -1;
	}
}

void:ResetCharacterSelection(playerid){
    pInfo[playerid][pShowFooter] = 0;
    pInfo[playerid][pChoosingCharacter] = 0;
    pInfo[playerid][pCharacterChoosed] = 0;
    pInfo[playerid][pCharacterActorSkin] = 0;
    pInfo[playerid][pCharacterActor] = 0;
    DestroyActor(pInfo[playerid][pCharacterActor]);
}