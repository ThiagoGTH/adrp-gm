#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_VEHICLES (2000)

enum E_VEHICLE_DATA {
    // PRIM�RIO
    vSQLID,                 // ID do ve�culo no MySQL
    vID,                    // ID real do ve�culo
    vExists,                // Definir se existe
    vModel,                 // ModelID do ve�culo
    vOwner,                 // ID do personagem dono do ve�culo
    vFaction,               // ID da fac��o do ve�culo
    vBusiness,              // ID da empresa do ve�culo
    vName[256],             // Nome personalizado
    vNamePersonalized,      // Se o nome � personalizado
    vLegal,                 // Se o ve�culo � legalizado
    vPlate[128],            // Placa do ve�culo
    vPlatePersonalized,     // Se a placa � personalizada
    vSpawned,               // Se esta spawnado
    bool:vLocked,           // Trancado 
    vColor1,                // Cor prim�ria
    vColor2,                // Cor secund�ria
    vPaintjob               // Paintjob do ve�culo
    Float:vPosPos[4],       // Posi��es (X, Y, Z, A) do ve�culo
    vVW,                    // Virtual World do ve�culo
    vInterior,              // Interior do ve�culo

    // SECUND�RIO
    Float:vFuel,            // Combust�vel do ve�culo
    Float:vHealth,          
    Float:vBattery,         // Bateria do ve�culo
	Float:vEngine,          // Motor do ve�culo
    Float:vMiles,           // Milhas rodadas
    Float:vMilesCon,        // Contagem de milhas

    vMods[17],              // Modifica��es
    vWeapons[30],           // Armas guardadas
	vWeaponsType[30],       // Tipo das armas
	vAmmo[30],              // Muni��o das armas

    // DANOS
    vDamage[23],            // 9 calibres + 14 partes veiculares que podem danificar
    vDismantling,
};

new vInfo[MAX_DYNAMIC_VEHICLES][E_VEHICLE_DATA];

// 
LoadVehicles() {
    new loadedVehicles;
    mysql_query(DBConn, "SELECT * FROM `vehicles`;");

    for(new i; i < cache_num_rows(); i++) {
        vInfo[id][hID] = i;

        cache_get_value_name_int(i, "id", vInfo[id][hSQLID]);
        cache_get_value_name_int(i, "character_id", hInfo[id][hOwner]);
        cache_get_value_name(i, "address", hInfo[id][hAddress]);
        cache_get_value_name_int(i, "locked", hInfo[id][hLocked]);
        cache_get_value_name_int(i, "price", hInfo[id][hPrice]);
        cache_get_value_name_int(i, "storage_money", hInfo[id][hStorageMoney]);
        cache_get_value_name_float(i, "entry_x", hInfo[id][hEntryPos][0]);
        cache_get_value_name_float(i, "entry_y", hInfo[id][hEntryPos][1]);
        cache_get_value_name_float(i, "entry_z", hInfo[id][hEntryPos][2]);
        cache_get_value_name_float(i, "entry_a", hInfo[id][hEntryPos][3]);
        cache_get_value_name_int(i, "vw_entry", hInfo[id][vwEntry]);
        cache_get_value_name_int(i, "interior_entry", hInfo[id][interiorEntry]);
        cache_get_value_name_float(i, "exit_x", hInfo[id][hExitPos][0]);
        cache_get_value_name_float(i, "exit_y", hInfo[id][hExitPos][1]);
        cache_get_value_name_float(i, "exit_z", hInfo[id][hExitPos][2]);
        cache_get_value_name_float(i, "exit_a", hInfo[id][hExitPos][3]);
        cache_get_value_name_int(i, "vw_exit", hInfo[id][vwExit]);
        cache_get_value_name_int(i, "interior_exit", hInfo[id][interiorExit]);

        loadedVehicles++;
    }

    printf("[VE�CULOS]: %d ve�culos carregados com sucesso.", loadedVehicles);
    return true;
}