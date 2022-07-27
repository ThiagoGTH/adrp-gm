#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_CARS            (1500)

#define MAX_OWNABLE_CARS            (5)
#define MAX_OWNABLE_HOUSES          (3)
#define MAX_OWNABLE_BUSINESSES      (3)
#define MAX_PLAYER_VEHICLES         (20)

new MySQL:DBConn;
new logString[255];
new loginAttempts[MAX_PLAYERS];
new 
    szBigString [256],
    szLargeString [1024],
    szHugeString [2048];
    
enum User_Data {
    uID,
    uName[24],
    uPass[16],
    uAdmin,
    uCharSlots,
    uRedFlag,
    uNewbie,
    uSOSAns,
    uDutyTime,
    uJailed,
    uPoints
};

new uInfo[MAX_PLAYERS][User_Data];

enum Player_Data {
    pID,
    pName[24],
    pUser[24],
    pFirstIP[15],
    pLastIP[15],
    pAdmin,
    pDonator,

    pAge,
    pGender[15],
    pBackground[50],

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
    pAFKCount,

    pAdTick,

    pESC,
    Float:pHealthMax,

    pVehicles[MAX_PLAYER_VEHICLES],
    pSpawnVehicle,
	vListOpen,
    pVehicleSell,
	pVehicleSellPrice,
    pSpawnVeh,

    // CAMERA-MAN
    bool:pWatching,
	pWatchingPlayer,
	bool:pRecording,
	pCameraTimer,

    // FACTIONS
    pSwat,


    // TOG
    pTogNewbie,

    pJailed,
    // Temp variables
    bool:pLogged,
    pFlying,
    pQuestion,
    pAnswer,
    characterDelete[24],
    tempChar[64],
    tempChar2[64],
    pInterfaceTimer,
    pBuyingPlate[128],
    pBuyingPlateRemove,
    pTimerSpawn,
    pDelayNewbie,

};
new pInfo[MAX_PLAYERS][Player_Data];

new const g_aWeaponSlots[] = {
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11
};

void:ResetUserData(playerid) {
    loginAttempts[playerid]               = 
    uInfo        [playerid][uAdmin]       = 
    uInfo        [playerid][uID]          = 
    uInfo        [playerid][uRedFlag]     =
    uInfo        [playerid][uNewbie]      = 
    uInfo        [playerid][uSOSAns]      = 
    uInfo        [playerid][uDutyTime]    =
    uInfo        [playerid][uCharSlots]   =
    uInfo        [playerid][uPoints]      = 0;
    uInfo        [playerid][uJailed]      = -1;

    uInfo[playerid][uName][0] = EOS;
}

void:ResetCharacterData(playerid) {
    pInfo   [playerid][pID]             = 0;
    pInfo   [playerid][pName][0]        =
    pInfo   [playerid][pUser][0]        =
    pInfo   [playerid][pFirstIP][0]     =
    pInfo   [playerid][pLastIP][0]      = 
    pInfo   [playerid][pGender][0]      =
    pInfo   [playerid][pBackground][0]  = EOS;

    pInfo   [playerid][pDonator]        = 0;
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
    pInfo[playerid][pDelayNewbie] = 0;
    ClearDamages(playerid);

    pInfo[playerid][pRecording] = false;
    pInfo[playerid][pWatching] = false;
    pInfo[playerid][pWatchingPlayer] = INVALID_PLAYER_ID;
    pInfo[playerid][pCameraTimer] = -1;

    for (new i = 0; i < 6; i ++)
	{
    	pInfo[playerid][pVehicles][i] = 0;
	}
    pInfo[playerid][pVehicleSell] = -1;
    pInfo[playerid][pVehicleSellPrice] = 0;
    pInfo[playerid][pSpawnVeh] = 0;
    
    // TEMP VARS
    pInfo[playerid][tempChar][0] = 
    pInfo[playerid][tempChar2][0] = 
    pInfo[playerid][characterDelete][0] = EOS;
    pInfo[playerid][pAnswer] = -1;
    pInfo[playerid][pQuestion] = -1;
    pInfo[playerid][pInterfaceTimer] = -1;
    format(pInfo[playerid][pBuyingPlate], 120, "");
	pInfo[playerid][pBuyingPlateRemove] = 0;
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
}

// VEHICLES
//new vehiclecallsign[MAX_VEHICLES];

enum coreVehicles {
    Float:vehFuel,
	vehWindowsDown,
	vehCrate,
    vehTemporary,
	vehSirenOn,
	vehSirenObject,
    Float:MilesPos[5],
 	Float:MilesTraveled,
    vehAFK,
    vehCARID
};
new CoreVehicles[MAX_VEHICLES][coreVehicles];

enum carData {
	carID,
	carExists,
	carModel,
	carOwner,
    carParkTime,
	Float:carPos[4],
    carVW,
    carInterior,
	carColor1,
	carColor2,
	carLocked,
	carImpounded,
	carImpoundPrice,
	carVehicle,
    carSpawned,
    carTrunkPlayer,
    // Storage
    carWeapons[30],
    carWeaponsType[30],
	carAmmo[30],
    carGunrackWeapon[3],
    carGunrackAmmo[3],
    // Types
    carFaction,
    carBiz,
    carJob,
    carRent,
    carRentTime,
    carRentPlayer,
    carRentPrice,
    carRentSpawnTime,
    // Tunning
    carPaintjob,
    carMods[14],
    carNOSInstalled,
    carNOS,
    // Status
    Float:carBattery, // Bateria do veículo
	Float:carEngine, // Motor do veículo
    Float:carMiles, // Milhas rodadas
    Float:carMilesCon, // Milhas para descontar no gasto do veículo
    Float:carFuel, // Combustível atual do veículo
    Float:carMaxHP,
    Float:carMaxFuel, // Combustível máximo do veículo
    Float:carHealth,
    Float:carHealthUpdate,
    // Adicionais
    carName[64], // Nome (modelo) do veículo
    carNamePer, // Status do modelo do veículo
    carPlate[128], // Placa personalizada
	carPlatePer, // Status da placa personalizada
    carAlarm, // Alarme
 	carLock, // Travas
 	carImob, // Immobilizer
 	carInsurance, // Seguro
 	carXMRadio, // Rádio
    carSunPass, // SunPass
    carEnergyResource,
    // Danos
    Float:carHealthRepair,
    carDoorsStatus,
    carPanelsStatus,
    carLightsStatus,
    carTiresStatus,
    carDamage[23], // 9 calibres + 14 partes veiculares que podem danificar
    carDismantling, // Desmanche
    carCarparts // Desmanche
};
new CarData[MAX_DYNAMIC_CARS][carData];


