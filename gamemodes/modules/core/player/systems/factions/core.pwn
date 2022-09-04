#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    LoadFactions();
    return true;
}

LoadFactions() {
    new loadedfactions;
    mysql_query(DBConn, "SELECT * FROM `factions` WHERE (`ID` != '0');");

    factionMaxRanks,
    factionPaycheck[30],

    factionHasLocker,
    Float:factionLockerPos[3],
    factionLockerInt,
    factionLockerWorld,

    factionSkins[100],
    factionWeapons[15],
    factionAmmo[15],


    for (new i; i < cache_num_rows(); i++) if (i < MAX_FACTIONS) {
        cache_get_value_name_int(i, "ID", FactionData[i][factionID]);
        FactionData[i][factionExists] = true;
        FactionData[i][factionTogF] = false;

        cache_get_value_name(i, "name", FactionData[i][factionName]);
        cache_get_value_name_int(i, "type", FactionData[i][factionType]);
        cache_get_value_name_int(i, "color", FactionData[i][factionColor]);
        cache_get_value_name_int(i, "vault", FactionData[i][factionVault]);
        cache_get_value_name_int(i, "status", FactionData[i][factionStatus]);

        cache_get_value_name_int(i, "maxranks", FactionData[i][factionMaxRanks]);
        cache_get_value_name_int(i, "locker", FactionData[i][factionHasLocker]);
        
        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `factions_skins` WHERE `faction_id` = '%d'", FactionData[i][factionID]);
        mysql_tquery(DBConn, query, "LoadFactionSkins", "d", i); //

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `factions_ranks` WHERE `faction_id` = '%d'", FactionData[i][factionID]);
        mysql_tquery(DBConn, query, "LoadFactionRanks", "d", i);

        mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `factions_weapons` WHERE `faction_id` = '%d'", FactionData[i][factionID]);
        mysql_tquery(DBConn, query, "LoadFactionWeapons", "d", i);

        if(FactionData[i][factionHasLocker] != 0) {
            mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `factions_locker` WHERE `faction_id` = '%d'", FactionData[i][factionID]);
            mysql_tquery(DBConn, query, "LoadFactionLocker", "d", i);
        }

        loadedfactions++;
    }
    printf("[FACÇÕES]: %d facções carregadas.", loadedfactions);
    return true;
}

forward LoadFactionSkins(i);
public LoadFactionSkins(i) {
    format(query, sizeof(query), "p<|>dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    cache_get_value_name(0, query, FactionData[i][factionSkins][0],
        FactionData[i][factionSkins][1],
        FactionData[i][factionSkins][2],
        FactionData[i][factionSkins][3],
        FactionData[i][factionSkins][4],
        FactionData[i][factionSkins][5],
        FactionData[i][factionSkins][6],
        FactionData[i][factionSkins][7],
        FactionData[i][factionSkins][8],
        FactionData[i][factionSkins][9],
        FactionData[i][factionSkins][10],
        FactionData[i][factionSkins][11],
        FactionData[i][factionSkins][12],
        FactionData[i][factionSkins][13],
        FactionData[i][factionSkins][14],
        FactionData[i][factionSkins][15],
        FactionData[i][factionSkins][16],
        FactionData[i][factionSkins][17],
        FactionData[i][factionSkins][18],
        FactionData[i][factionSkins][19],
        FactionData[i][factionSkins][20],
        FactionData[i][factionSkins][21],
        FactionData[i][factionSkins][22],
        FactionData[i][factionSkins][23],
        FactionData[i][factionSkins][24],
        FactionData[i][factionSkins][25],
        FactionData[i][factionSkins][26],
        FactionData[i][factionSkins][27],
        FactionData[i][factionSkins][28],
        FactionData[i][factionSkins][29],
        FactionData[i][factionSkins][30],
        FactionData[i][factionSkins][31],
        FactionData[i][factionSkins][32],
        FactionData[i][factionSkins][33],
        FactionData[i][factionSkins][34],
        FactionData[i][factionSkins][35],
        FactionData[i][factionSkins][36],
        FactionData[i][factionSkins][37],
        FactionData[i][factionSkins][38],
        FactionData[i][factionSkins][39],
        FactionData[i][factionSkins][40],
        FactionData[i][factionSkins][41],
        FactionData[i][factionSkins][42],
        FactionData[i][factionSkins][43],
        FactionData[i][factionSkins][44],
        FactionData[i][factionSkins][45],
        FactionData[i][factionSkins][46],
        FactionData[i][factionSkins][47],
        FactionData[i][factionSkins][48],
        FactionData[i][factionSkins][49],
        FactionData[i][factionSkins][50],
        FactionData[i][factionSkins][51],
        FactionData[i][factionSkins][52],
        FactionData[i][factionSkins][53],
        FactionData[i][factionSkins][54],
        FactionData[i][factionSkins][55],
        FactionData[i][factionSkins][56],
        FactionData[i][factionSkins][57],
        FactionData[i][factionSkins][58],
        FactionData[i][factionSkins][59],
        FactionData[i][factionSkins][60],
        FactionData[i][factionSkins][61],
        FactionData[i][factionSkins][62],
        FactionData[i][factionSkins][63],
        FactionData[i][factionSkins][64],
        FactionData[i][factionSkins][65],
        FactionData[i][factionSkins][66],
        FactionData[i][factionSkins][67],
        FactionData[i][factionSkins][68],
        FactionData[i][factionSkins][69],
        FactionData[i][factionSkins][70],
        FactionData[i][factionSkins][71],
        FactionData[i][factionSkins][72],
        FactionData[i][factionSkins][73],
        FactionData[i][factionSkins][74],
        FactionData[i][factionSkins][75],
        FactionData[i][factionSkins][76],
        FactionData[i][factionSkins][77],
        FactionData[i][factionSkins][78],
        FactionData[i][factionSkins][79],
        FactionData[i][factionSkins][80],
        FactionData[i][factionSkins][81],
        FactionData[i][factionSkins][82],
        FactionData[i][factionSkins][83],
        FactionData[i][factionSkins][84],
        FactionData[i][factionSkins][85],
        FactionData[i][factionSkins][86],
        FactionData[i][factionSkins][87],
        FactionData[i][factionSkins][88],
        FactionData[i][factionSkins][89],
        FactionData[i][factionSkins][90],
        FactionData[i][factionSkins][91],
        FactionData[i][factionSkins][92],
        FactionData[i][factionSkins][93],
        FactionData[i][factionSkins][94],
        FactionData[i][factionSkins][95],
        FactionData[i][factionSkins][96],
        FactionData[i][factionSkins][97],
        FactionData[i][factionSkins][98],
        FactionData[i][factionSkins][99]
    );
    return true;
}