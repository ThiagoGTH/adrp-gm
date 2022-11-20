#define MAX_GARAGES          2000

enum E_GARAGE_DATA {
	gID,                    // ID da garagem no MySQL
	gOwner,                 // ID do personagem dono da garagem
    gHouse,                 // ID da casa atrelada (caso haja)
	gAddress[24],           // Endere�o da Garagem, podendo ser o mesmo da casa
	bool:gLocked,           // Garagem trancada
    gInv,                   // ID do invent�rio da Garagem
    gPrice,                 // Pre�o de venda (pelo servidor)
    gStorageMoney,          // Dinheiro guardado
    Float:gStorageItem[6]   //
    F�pat:gStorageAmount[6] //
    Float:gEntryPos[4],     // Posi��es (X, Y, Z, A) do exterior
    gVwEntry,               // VW do exterior
    gInteriorEntry,         // Interior do exterior
    Float:gExitPos[4],      // Posi��es (X, Y, Z, A) do interior
    gVwExit,                // VW do interior
    gInteriorExit,          // Interior do interior
};

new gInfo[MAX_GARAGES][E_GARAGE_DATA];
