#include <YSI_Coding\y_hooks>

#define MAX_FACTIONS            (30)

#define FACTION_MAX_RANKS       (30)

#define FACTION_POLICE          (1)
#define FACTION_NEWS            (2)
#define FACTION_MEDIC           (3)
#define FACTION_GOV             (4)
#define FACTION_DOJ             (5)
#define FACTION_CIVIL           (6)
#define FACTION_CRIMINAL        (7)

#define FACTION_VERIFIED        (1)
#define FACTION_OFFICIAL        (2)

enum E_FACTION_DATA {
    factionID,
    bool:factionExists,
    factionName[32],
    factionType,
    factionColor,
    factionRanks,
    factionPaycheck[30],

    factionHasLocker,
    Float:factionLockerPos[3],
    factionLockerInt,
    factionLockerWorld,

    factionSkins[50],

    factionWeapons[15],
    factionAmmo[15],

    factionTogF,
    factionVault,
    //factionPermissions[13],

    factionStatus
}

new FactionData[MAX_FACTIONS][E_FACTION_DATA];
new FactionRanks[MAX_FACTIONS][30][32];