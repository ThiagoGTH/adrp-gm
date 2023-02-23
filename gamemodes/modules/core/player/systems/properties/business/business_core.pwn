#include <YSI_Coding\y_hooks>

#define MAX_BUSINESS          1000

enum E_BUSINESS_DATA {
    bID,                // ID da empresa no MySQL
    bOwner,             // ID do personagem dono da empresa
    bAddress[256],      // Endereço
    bool:bLocked,       // Trancado
    bName[256],         // Nome da empresa
    bType,              // Tipo da empresa (lojas (eletronicos, mercado, entre outros), concecionaria, "firma")
    bInventory,         // Estoque da empresa
    bStorageMoney,      // Dinheiro guardado/cofre da empresa
    bPrice,             // Preço da empresa
    Float:bExitPos[4],  // Posições (X, Y, Z, A) do interior
    vwExit,             // VW do interior
    interiorExit,       // Interior do interior
    Float:bEntryPos[4], // Posições (X, Y, Z, A) do exterior
    vwEntry,            // VW do exterior
    interiorEntry,      // Interior do exterior
    bVariable,          // Salvamento da Varíavel de criação
};

new bInfo[MAX_BUSINESS][E_BUSINESS_DATA];

#define B_MAX_STORAGE          1000

enum B_STORAGE_DATA  {
    sbID,                 // ID do Item MySQL (vamor usar com cód barras)
    sbName[64],           // Nome do Item (tem que ser customizados)
    sbModel,              // ID do Modelo
    sbPrice,              // Valor do item (valor que deixará a venda)
    sbOwner,              // Empresa dona (em que estoque está)
    sbQuantity,           // Quantidade de item
    sbCategory,           // Categoria
    bool:sbStatus,        // Se está a venda ou não.
};

new sbInfo[B_MAX_STORAGE][B_STORAGE_DATA];
// ============================================================================================================================================

hook OnGameModeInit() {
    LoadBusinesss();
    LoadStoragesBusiness();
    return 1;
}

hook OnGamemodeExit() {
    SaveBusinesss();
    SaveStoragesBusiness();
    return 1;
}

// ============================================================================================================================================
//Carrega todas empresas (MySQL).
LoadBusinesss() {
    new     
        loadedBusiness;

    mysql_query(DBConn, "SELECT * FROM `business`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        bInfo[id][bID] = id;

        cache_get_value_name_int(i, "character_id", bInfo[id][bOwner]);
        cache_get_value_name(i, "address", bInfo[id][bAddress]);
        cache_get_value_name_int(i, "locked", bInfo[id][bLocked]);
        cache_get_value_name(i, "name", bInfo[id][bName]);
        cache_get_value_name_int(i, "type", bInfo[id][bType]);
        cache_get_value_name_int(i, "inventory", bInfo[id][bInventory]);
        cache_get_value_name_int(i, "storage_money", bInfo[id][bStorageMoney]);
        cache_get_value_name_int(i, "price", bInfo[id][bPrice]);
        cache_get_value_name_float(i, "entry_x", bInfo[id][bEntryPos][0]);
        cache_get_value_name_float(i, "entry_y", bInfo[id][bEntryPos][1]);
        cache_get_value_name_float(i, "entry_z", bInfo[id][bEntryPos][2]);
        cache_get_value_name_float(i, "entry_a", bInfo[id][bEntryPos][3]);
        cache_get_value_name_int(i, "vw_entry", bInfo[id][vwEntry]);
        cache_get_value_name_int(i, "interior_entry", bInfo[id][interiorEntry]);
        cache_get_value_name_float(i, "exit_x", bInfo[id][bExitPos][0]);
        cache_get_value_name_float(i, "exit_y", bInfo[id][bExitPos][1]);
        cache_get_value_name_float(i, "exit_z", bInfo[id][bExitPos][2]);
        cache_get_value_name_float(i, "exit_a", bInfo[id][bExitPos][3]);
        cache_get_value_name_int(i, "vw_exit", bInfo[id][vwExit]);
        cache_get_value_name_int(i, "interior_exit", bInfo[id][interiorExit]);
        CreateObjectEntry(id);
        loadedBusiness++;
    }

    printf("[EMPRESAS]: %d empresas carregadas com sucesso.", loadedBusiness);

    return 1;
}

//Carrega empresa específica (MySQL).
LoadBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    bInfo[id][bID] = id;
    cache_get_value_name_int(0, "character_id", bInfo[id][bOwner]);
    cache_get_value_name(0, "address", bInfo[id][bAddress]);
    cache_get_value_name_int(0, "locked", bInfo[id][bLocked]);
    cache_get_value_name(0, "name", bInfo[id][bName]);
    cache_get_value_name_int(0, "type", bInfo[id][bType]);
    cache_get_value_name_int(0, "inventory", bInfo[id][bInventory]);
    cache_get_value_name_int(0, "storage_money", bInfo[id][bStorageMoney]);
    cache_get_value_name_int(0, "price", bInfo[id][bPrice]);
    cache_get_value_name_float(0, "entry_x", bInfo[id][bEntryPos][0]);
    cache_get_value_name_float(0, "entry_y", bInfo[id][bEntryPos][1]);
    cache_get_value_name_float(0, "entry_z", bInfo[id][bEntryPos][2]);
    cache_get_value_name_float(0, "entry_a", bInfo[id][bEntryPos][3]);
    cache_get_value_name_int(0, "vw_entry", bInfo[id][vwEntry]);
    cache_get_value_name_int(0, "interior_entry", bInfo[id][interiorEntry]);
    cache_get_value_name_float(0, "exit_x", bInfo[id][bExitPos][0]);
    cache_get_value_name_float(0, "exit_y", bInfo[id][bExitPos][1]);
    cache_get_value_name_float(0, "exit_z", bInfo[id][bExitPos][2]);
    cache_get_value_name_float(0, "exit_a", bInfo[id][bExitPos][3]);
    cache_get_value_name_int(0, "vw_exit", bInfo[id][vwExit]);
    cache_get_value_name_int(0, "interior_exit", bInfo[id][interiorExit]);
    CreateObjectEntry(id);
    return 1;
}

//Salva todas empresas (MySQL).
SaveBusinesss() {
    new savedBusinesss;

    for(new i; i < MAX_BUSINESS; i++) {
        if(!bInfo[i][bID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `character_id` = '%d', `address` = '%e', `locked` = '%d', `name` = '%e', `type` = '%d', `inventory` = '%d', `storage_money` = '%d', \
            `price` = '%d', `entry_x` = '%f', `entry_y` = '%f', `entry_z` = '%f', `entry_a` = '%f', `vw_entry` = '%d', `interior_entry` = '%d', \
            `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `vw_exit` = '%d', \
            `interior_exit` = %d WHERE `id` = %d;", bInfo[i][bOwner], bInfo[i][bAddress], bInfo[i][bLocked], bInfo[i][bName], bInfo[i][bType], bInfo[i][bInventory], bInfo[i][bStorageMoney], 
            bInfo[i][bPrice], bInfo[i][bEntryPos][0], bInfo[i][bEntryPos][1], bInfo[i][bEntryPos][2], bInfo[i][bEntryPos][3], bInfo[i][vwEntry], bInfo[i][interiorEntry],
            bInfo[i][bExitPos][0], bInfo[i][bExitPos][1], bInfo[i][bExitPos][2], bInfo[i][bExitPos][3], bInfo[i][vwExit], 
            bInfo[i][interiorExit], i);
        mysql_query(DBConn, query);

        savedBusinesss++;
    }

    printf("[EMPRESAS]: %d empresas salvas com sucesso.", savedBusinesss);

    return 1;
}

//Salva empresa específica (MySQL).
SaveBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `character_id` = '%d', `address` = '%e', `locked` = '%d', `name` = '%e', `type` = '%d', `inventory` = '%d', `storage_money` = '%d', \
            `price` = '%d', `entry_x` = '%f', `entry_y` = '%f', `entry_z` = '%f', `entry_a` = '%f', `vw_entry` = '%d', `interior_entry` = '%d', \
            `exit_x` = '%f', `exit_y` = '%f', `exit_z` = '%f', `exit_a` = '%f', `vw_exit` = '%d', \
            `interior_exit` = %d WHERE `id` = %d;", bInfo[id][bOwner], bInfo[id][bAddress], bInfo[id][bLocked], bInfo[id][bName], bInfo[id][bType], bInfo[id][bInventory], bInfo[id][bStorageMoney], 
            bInfo[id][bPrice], bInfo[id][bEntryPos][0], bInfo[id][bEntryPos][1], bInfo[id][bEntryPos][2], bInfo[id][bEntryPos][3], bInfo[id][vwEntry], bInfo[id][interiorEntry],
            bInfo[id][bExitPos][0], bInfo[id][bExitPos][1], bInfo[id][bExitPos][2], bInfo[id][bExitPos][3], bInfo[id][vwExit], 
            bInfo[id][interiorExit], id);
    mysql_query(DBConn, query);
    RefreshObjectEntry(id);
    return 1;
}

// Criar empresa (MySQL)
CreateBusiness(playerid, type, price, address[256]) {
    new
       Float:pos[4];

    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `business` (`address`, `type`, `price`, `entry_x`, `entry_y`, `entry_z`, `entry_a`, `vw_entry`, `interior_entry`) \
        VALUES ('%s', %d, %d, %f, %f, %f, %f, %d, %d);", address, type, price, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();

    mysql_format(DBConn, query, sizeof query, "UPDATE `business` SET `vw_exit` = '%d' WHERE `id` = '%d';", id, id);
    mysql_query(DBConn, query);

    SetIntDefaultBusiness(id);
    LoadBusiness(id);

    SendServerMessage(playerid, "Você criou a empresa de ID %d no endereço: '%s' ($%s) (Tipo: %s)", id, bInfo[id][bAddress], FormatNumber(price), BusinessType(id));
    format(logString, sizeof(logString), "%s (%s) criou a empresa de ID %d no endereço: '%s'. ($%s) (tipo: %s)", pNome(playerid), GetPlayerUserEx(playerid), id, address,  FormatNumber(price), BusinessType(id));
	logCreate(playerid, logString, 13);
    return 1;
}

//Deletar/excluir empresa (MySQL)
DeleteBusiness(playerid, id)  {
    mysql_format(DBConn, query, sizeof query, "DELETE FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    SendServerMessage(playerid, "Você deletou a empresa de ID %d.", id);

    format(logString, sizeof(logString), "%s (%s) deletou a empresa de ID %d. (%s)", pNome(playerid), GetPlayerUserEx(playerid), id, bInfo[id][bAddress]);
	logCreate(playerid, logString, 13);

    new dummyReset[E_BUSINESS_DATA];
    bInfo[id] = dummyReset;
    return 1;
} 

// ============================================================================================================================================
//Carrega todas empresas (MySQL).
LoadStoragesBusiness() {
    new     
        loadedStorage;

    mysql_query(DBConn, "SELECT * FROM `business_storage`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        sbInfo[id][sbID] = id;

        cache_get_value_name(i, "name", sbInfo[id][sbName]); 
        cache_get_value_name_int(i, "model", sbInfo[id][sbModel]);
        cache_get_value_name_int(i, "price", sbInfo[id][sbPrice]);
        cache_get_value_name_int(i, "owner", sbInfo[id][sbOwner]);
        cache_get_value_name_int(i, "quantity", sbInfo[id][sbQuantity]);
        cache_get_value_name_int(i, "category", sbInfo[id][sbCategory]);
        cache_get_value_name_int(i, "status", sbInfo[id][sbStatus]);
        loadedStorage++;
    }
    printf("[ARMAZEM]: %d items foram carregados com sucesso.", loadedStorage);
    return 1;
}

//Carrega estoque especifico específica (MySQL).
/*LoadStorageBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business_storage` WHERE `owner` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    sbInfo[id][sbID] = id;
    cache_get_value_name(i, "name", sbInfo[id][sbName]); 
    cache_get_value_name_int(i, "model", sbInfo[id][sbModel]);
    cache_get_value_name_int(i, "price", sbInfo[id][sbPrice]);
    cache_get_value_name_int(i, "owner", sbInfo[id][sbOwner]);
    cache_get_value_name_int(i, "quantity", sbInfo[id][sbQuantity]);
    cache_get_value_name_int(i, "category", sbInfo[id][sbCategory]);
    return 1;
} */

//Salva todos os estoques das empresas (MySQL).
SaveStoragesBusiness() {
    new savedStorage;

    for(new i; i < B_MAX_STORAGE; i++) {
        if(!sbInfo[i][sbID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `business_storage` SET `name` = '%e', `model` = '%d', `price` = '%d', `owner` = '%d', `quantity` = '%d', \
            `category` = = %d WHERE `id` = %d;", sbInfo[i][sbName], sbInfo[i][sbModel], sbInfo[i][sbPrice], sbInfo[i][sbOwner], sbInfo[i][sbQuantity],
            sbInfo[i][sbCategory], i);
        mysql_query(DBConn, query);
        savedStorage++;
    }
    printf("[ARMAZEM]: %d items salvos com sucesso.", savedStorage);
    return 1;
}

//Salva estoque específico (MySQL).
/*SaveStorageBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business_storage` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `business_storage` SET `name` = '%e', `model` = '%d', `price` = '%d', `owner` = '%d', `quantity` = '%d', \
        `category` = = %d WHERE `id` = %d;", sbInfo[id][sbName], sbInfo[id][sbModel], sbInfo[id][sbPrice], sbInfo[id][sbOwner], sbInfo[id][sbQuantity],
        sbInfo[id][sbCategory], id);
    mysql_query(DBConn, query);

    return 1;
} */
// ============================================================================================================================================
//Verifica se o ID existe empresa (MySQL) - ele retorna false (se o ID não existir).
IsValidBusiness(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `business` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

// Efetua a validação e/ou verifca o dono.
BusinessHasOwner(id) {
    return IsValidBusiness(id) && (bInfo[id][bOwner]);
}

//Criar Pickup de entrada
CreateObjectEntry(id)  {
    bInfo[id][bVariable] = CreateDynamicObject(19198, bInfo[id][bEntryPos][0], bInfo[id][bEntryPos][1], bInfo[id][bEntryPos][2], 0.0, 0.0, bInfo[id][bEntryPos][3], bInfo[id][vwEntry], bInfo[id][interiorEntry], -1, 10.0);

    return 1;
}

// Recarrega ás ATMs (+ destroy todos os objetos existentes dela e create (novamente))
RefreshObjectEntry(id) {
	if (IsValidBusiness(id))
	{
		if (IsValidObject(bInfo[id][bVariable]))
		    DestroyDynamicObject(bInfo[id][bVariable]);

        CreateObjectEntry(id);
	}
	return 1;
}

// Procura por alguma entrada da empresa
GetNearestBusinessEntry(playerid, Float:distance = 2.0) {
    for(new i; i < MAX_BUSINESS; i++) {
        if(!bInfo[i][bID])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, bInfo[i][bEntryPos][0], bInfo[i][bEntryPos][1], bInfo[i][bEntryPos][2]))
            continue;

        if(GetPlayerVirtualWorld(playerid) != bInfo[i][vwEntry] || GetPlayerInterior(playerid) != bInfo[i][interiorEntry])
            continue;

        return i;
    }

    return -1;
}

// Procura por alguma saída da empresa
GetNearestBusinessExit(playerid, Float:distance = 2.0) {
    for(new i; i < MAX_BUSINESS; i++) {
        if(!bInfo[i][bID])
            continue;
        
        if(GetPlayerVirtualWorld(playerid) != bInfo[i][vwExit] || GetPlayerInterior(playerid) != bInfo[i][interiorExit])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, bInfo[i][bExitPos][0], bInfo[i][bExitPos][1], bInfo[i][bExitPos][2]))
            continue;

        return i;
    }

    return 0;
}

//Verifica o endereço da empresa
GetBusinessAddress(id) {
    IsValidBusiness(id);

    new address[256];
    format(address, sizeof(address), "%s", bInfo[id][bAddress]);

    return address;
}

//Tipos de empresa
BusinessType(id) {
	new btype[128];
	switch(bInfo[id][bType]) {
        case 1: format(btype, sizeof(btype), "24/7");
		case 2: format(btype, sizeof(btype), "Ammunation");
		case 3: format(btype, sizeof(btype), "Lojas de roupas");
		case 4: format(btype, sizeof(btype), "Fast Food");
		case 5: format(btype, sizeof(btype), "Concessionária");
		case 6: format(btype, sizeof(btype), "Posto de gasolina");
        case 7: format(btype, sizeof(btype), "Firma/Empresa");
		default: format(btype, sizeof(btype), "Inválido");
	}
	return btype;
}

//Seta interior de forma automatica (MySQL)
SetIntDefaultBusiness(businessID) {
    new bint[128];
	switch(bInfo[businessID][bType]) {
        case 1: {
        	bInfo[businessID][bExitPos][0] = -25.8473;
        	bInfo[businessID][bExitPos][1] = -188.2483;
        	bInfo[businessID][bExitPos][2] = 1003.5469;
        	bInfo[businessID][bExitPos][3] = 1.1815;
			bInfo[businessID][interiorEntry] = 17;
        }
        case 2: {
        	bInfo[businessID][bExitPos][0] = 316.3963;
        	bInfo[businessID][bExitPos][1] = -169.8375;
        	bInfo[businessID][bExitPos][2] = 999.6010;
        	bInfo[businessID][bExitPos][3] = 0.0000;
			bInfo[businessID][interiorEntry] = 6;
		}
		case 3: {
        	bInfo[businessID][bExitPos][0] = 161.4801;
        	bInfo[businessID][bExitPos][1] = -96.5368;
        	bInfo[businessID][bExitPos][2] = 1001.8047;
            bInfo[businessID][bExitPos][3] = 0.0000;
			bInfo[businessID][interiorEntry] = 18;
		}
		case 4: {
        	bInfo[businessID][bExitPos][0] = 363.3402;
        	bInfo[businessID][bExitPos][1] = -74.6679;
        	bInfo[businessID][bExitPos][2] = 1001.5078;
        	bInfo[businessID][bExitPos][3] = 315.0000;
			bInfo[businessID][interiorEntry] = 10;

		}
		case 5: {
        	bInfo[businessID][bExitPos][0] = 1494.5612;
        	bInfo[businessID][bExitPos][1] = 1304.2061;
        	bInfo[businessID][bExitPos][2] = 1093.2891;
        	bInfo[businessID][bExitPos][3] = 0.0000;
			bInfo[businessID][interiorEntry] = 3;
		}
		case 6: {
			bInfo[businessID][bExitPos][0] = 6.1172;
   			bInfo[businessID][bExitPos][1] = -31.4720;
		   	bInfo[businessID][bExitPos][2] = 1003.5494;
      		bInfo[businessID][bExitPos][3] = 5.0982;
			bInfo[businessID][interiorEntry] = 10;
		}
		case 7: {
			bInfo[businessID][bExitPos][0] = -2240.4954;
   			bInfo[businessID][bExitPos][1] = 128.3774;
		   	bInfo[businessID][bExitPos][2] = 1035.4210;
      		bInfo[businessID][bExitPos][3] = 270.0000;
			bInfo[businessID][interiorEntry] = 6;
		}
		default: {
            format(bint, sizeof(bint), "Inválido");
        }
	}
	return bint;
}
// ============================================================================================================================================

EditEntryBusiness(playerid, businessID) {
    GetPlayerPos(playerid, bInfo[businessID][bEntryPos][0], bInfo[businessID][bEntryPos][1], bInfo[businessID][bEntryPos][2]);
    GetPlayerFacingAngle(playerid, bInfo[businessID][bEntryPos][3]);
    bInfo[businessID][vwEntry] =  GetPlayerVirtualWorld(playerid);
    bInfo[businessID][interiorEntry] = GetPlayerInterior(playerid);
    SaveBusiness(businessID);
    return 1;
}

EditExitBusiness(playerid, businessID) {
    GetPlayerPos(playerid, bInfo[businessID][bExitPos][0], bInfo[businessID][bExitPos][1], bInfo[businessID][bExitPos][2]);
    GetPlayerFacingAngle(playerid, bInfo[businessID][bExitPos][3]);
    bInfo[businessID][interiorExit] = GetPlayerInterior(playerid);
    TeleportBusiness(playerid, businessID);
    SaveBusiness(businessID);
    return 1;
}

//Função que edita nome da empresa
EditNameBusiness(businessID, newName) {
    bInfo[businessID][bName] = newName;
    SaveBusiness(businessID);
    return 1;
}

//Função que edita o preço
EditPriceBusiness(businessID, newName) {
    bInfo[businessID][bPrice] = newName;
    SaveBusiness(businessID);
    return 1;
}

//Função que edita o tipo da empresa
EditTypeBusiness(businessID, newType) {
    bInfo[businessID][bType] = newType;
    SetIntDefaultBusiness(businessID); // Seta o interior da empresa + salva os dados.
    return 1;
}

//Verifica se (playerid) está dentro de uma empresa (retorna o ID da empresa que ele está.).
IsBusinessInside(playerid) {
    for (new i = 0; i != MAX_BUSINESS; i ++) if (GetPlayerInterior(playerid) == bInfo[i][interiorExit] && GetPlayerVirtualWorld(playerid) == bInfo[i][vwExit]) {
	        return i;
	} 
    return -1;
}

//Teleporta o player para determinada empresa (via o ID > Onde está localizada a entrada)
TeleportBusiness(playerid, id) {
    if(!bInfo[id][bID])
        return SendErrorMessage(playerid, "Esse ID de empresa não existe.");

    SetPlayerVirtualWorld(playerid, bInfo[id][vwEntry]);
    SetPlayerInterior(playerid, bInfo[id][interiorEntry]);
    SetPlayerPos(playerid, bInfo[id][bEntryPos][0], bInfo[id][bEntryPos][1], bInfo[id][bEntryPos][2]);
    SetPlayerFacingAngle(playerid, bInfo[id][bEntryPos][3]);

    SendServerMessage(playerid, "Você teleportou até a empresa de ID %d.", id);
    return 1;
}

// ============================================================================================================================================
ManagerBusiness(playerid) {
    new businessID = IsBusinessInside(playerid);
    new string[1024];
    
    if(businessID == -1)
        return -1;

    if(bInfo[businessID][bOwner] != pInfo[playerid][pID])
        //return SendErrorMessage(playerid, "Essa propriedade não é sua.");
        return printf("IsBusinessInside %d", businessID);

    format(string, sizeof(string), "Gerenciamento Geral\nGerenciamento de Equipe\nGerenciamento de Publicidade\nGerenciamento de Produtos\n");
    Dialog_Show(playerid, ManagerPageHome, DIALOG_STYLE_LIST, "Gerenciamento de Empresa", string, "Selecionar", "Fechar");
    return true;
}

Dialog:ManagerPageHome(playerid, response, listitem, inputtext[]) {
    if(response) {
        switch(listitem) {
            case 0: SendErrorMessage(playerid, "Está opção está em desenvolvimento.");
            case 1: SendErrorMessage(playerid, "Está opção está em desenvolvimento.");
            case 2: SendErrorMessage(playerid, "Está opção está em desenvolvimento.");
            case 3: ManagerStorage(playerid);
        } 
    }
    return 1;
}

ManagerStorage(playerid) {
    new businessID = IsBusinessInside(playerid);
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM business_storage WHERE `owner` = '%d'", businessID);
    new Cache:result = mysql_query(DBConn, query);

    new string[1024], cod_id, cod_name[24], price, quantity;
    format(string, sizeof(string), "Cod ID\tNome\tQuantidade\tPreço\n");
    format(string, sizeof(string), "%sSolicitar Produto\n", string);
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name_int(i, "id", cod_id);
        cache_get_value_name(i, "name", cod_name);
        cache_get_value_name_int(i, "price", price);

        format(string, sizeof(string), "%s%d\t%s\t%d\t$%d\n", string, cod_id, cod_name, quantity, price);
    }
    cache_delete(result);

    Dialog_Show(playerid, ManagerPageStorage, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciamento de Empresa > Produtos", string, "Selecionar", "<<");
    return true;
}

Dialog:ManagerPageStorage(playerid, response, listitem, inputtext[]) {
    if(!response)
        return ManagerBusiness(playerid);

    if(response) {    
        if(!strcmp(inputtext, "Solicitar Produto", true)) {
            BusinessProductList(playerid);
        }
        else {
            printf("%d solicita edição de produto do produto %s", playerid, inputtext);   
        }
    }
    return 1;
}

BusinessProductList(playerid) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM items WHERE `ID` > 0");
    new Cache:result = mysql_query(DBConn, query);

    new string[1024], cod_id, cod_name[64], price;
    format(string, sizeof(string), "Cod ID\tNome\tPreço\n");
    for(new i; i < cache_num_rows(); i++) {
        cache_get_value_name_int(i, "ID", cod_id);
        cache_get_value_name(i, "item_name", cod_name);
        cache_get_value_name_int(i, "item_price", price);
        printf("Carregando produto ID: %d", cod_id);
        format(string, sizeof(string), "%s%d\t%s\t$%d\n", string, cod_id, cod_name, price);
    }
    cache_delete(result);

    pInfo[playerid][sTempPrice] = price;
    Dialog_Show(playerid, PageProductList, DIALOG_STYLE_TABLIST_HEADERS, "Gerenciamento de Empresa > Produtos > Solicitação de Produto", string, "Selecionar", "<<");
    return true;
}

Dialog:PageProductList(playerid, response, listitem, inputtext[]) {
    if(!response)
        return ManagerStorage(playerid);

    if(response) {    
        new itemName[64];
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM items WHERE `ID` = '%s'", inputtext);
        new Cache:result = mysql_query(DBConn, query);
        cache_get_value_name(0, "item_name", itemName);
        cache_delete(result);

        new string[512];
        format(string, sizeof(string), "Cada %s custa $%d. Quantos necessita?", itemName, pInfo[playerid][sTempPrice]);

        //Colocando dados dentro da váriavel (temp)
        pInfo[playerid][sTempItem] = strval(inputtext);

        Dialog_Show(playerid, PageProductBuy, DIALOG_STYLE_INPUT, "{FFFFFF}Solicitar Produto (compra)", string, "Continuar", "<<");
        return 1;
        }
    return -1;
}

Dialog:PageProductBuy(playerid, response, listitem, inputtext[]) {
    if(!response)
        return ManagerStorage(playerid);

    if(response) {    
        new itemName[64];
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM items WHERE `ID` = '%s'", inputtext);
        new Cache:result = mysql_query(DBConn, query);
        cache_get_value_name(0, "item_name", itemName);
        cache_delete(result);

        new quantity = strval(inputtext);
        new total = quantity * pInfo[playerid][sTempPrice];

        pInfo[playerid][sTempQuantity] = quantity;
        pInfo[playerid][sTempTotal] = total;

        new string[512];
        format(string, sizeof(string), "Produto: %s\nValor Unitário: $%d\nQuantidade solicitada: %d\nValor total: $%d", itemName, pInfo[playerid][sTempPrice], quantity, total);
        Dialog_Show(playerid, ProductBuy, DIALOG_STYLE_MSGBOX, "{FFFFFF}Solicitação de Produto (compra)", string, "Confirmar", "Cancelar");
        return 1;
        }
    return -1;
}

Dialog:ProductBuy(playerid, response, listitem, inputtext[]) {
    if(!response)
        return ManagerStorage(playerid);

    if(response) {    
        IsProductBuy(playerid, pInfo[playerid][sTempItem], pInfo[playerid][sTempTotal], pInfo[playerid][sTempQuantity]);

        pInfo[playerid][sTempItem] = -1;
        pInfo[playerid][sTempPrice] = -1;
        pInfo[playerid][sTempTotal] = -1;
        pInfo[playerid][sTempQuantity] = -1;
        return 1;
        }
    return -1;
}

IsProductBuy(playerid, productID, total, quantity) {
    printf("Playerid: %d - Produto ID: %d - Total: $%d - Quantidade: %d", playerid, productID, total, quantity);
    return 1;
}

//cmd:comprar (dentro da empresa - dialog de compra).
BuyInTheBusiness(playerid) {
    return playerid;
}