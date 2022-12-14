//Simplificação de hook (retira warming - 31 characters)
DEFINE_HOOK_REPLACEMENT(OnPlayer, OP_);

//Definição de máximo de "ATM" na cidade.
#define MAX_ATM          1000

//Valores do "data".
enum E_ATM_DATA {
    atmID,             // ID da empresa no MySQL
    atmObject,         // (Apenas uma varíavel não ultilizavel) - ID do Objeto da ATM (isto para futuras mudanças no quesito ATM - porém já ultilizo para)
    atmVariable,       // Varíavel do objeto da ATM
    atmInterior,       // Interior da ATM
    atmWorld,          // Mundo da ATM
    //atmExists,       // (Se a atm existe) - valor não salvo no MySQL
    bool:atmActive,    // Se está ativa ou não.
    bool:atmStatus,    // Ativado/Desativado
    Float:Position[4], // Posições (X, Y, Z, A)
};

//Simplificação dos valores da "data"
new atmInfo[MAX_ATM][E_ATM_DATA];

hook OnGameModeInit() {
    LoadATMS();
    return 1;
}

hook OnGamemodeExit() {
    SaveATMS();
    return 1;
}

hook OP_EditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if (response == EDIT_RESPONSE_FINAL)
	{
	    if (IsValidAtm(pInfo[playerid][oEditATM]))
	    {
			atmInfo[pInfo[playerid][oEditATM]][Position][0] = x;
			atmInfo[pInfo[playerid][oEditATM]][Position][1] = y;
			atmInfo[pInfo[playerid][oEditATM]][Position][2] = z;
			atmInfo[pInfo[playerid][oEditATM]][Position][3] = rz;
            
            SaveATM(pInfo[playerid][oEditATM]);
            RefreshATM(pInfo[playerid][oEditATM]);

            SendServerMessage(playerid, "Você editou a ATM de ID %d.", pInfo[playerid][oEditATM]);
	    }
    }
	if (response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
	{
	    if (pInfo[playerid][oEditATM] != -1)
            return RefreshATM(pInfo[playerid][oEditATM]);
            
		pInfo[playerid][oEditATM] = -1;
	}
	return 1;
}

//Carrega todas ATMs (MySQL).
LoadATMS() {
    new     
        loadedATMS;

    mysql_query(DBConn, "SELECT * FROM `atm`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        
        atmInfo[id][atmID] = id;
        cache_get_value_name_int(i, "object", atmInfo[id][atmObject]);
        cache_get_value_name_float(i, "position_x", atmInfo[id][Position][0]);
        cache_get_value_name_float(i, "position_y", atmInfo[id][Position][1]);
        cache_get_value_name_float(i, "position_z", atmInfo[id][Position][2]);
        cache_get_value_name_float(i, "position_a", atmInfo[id][Position][3]);
        cache_get_value_name_int(i, "interior", atmInfo[id][atmInterior]);
        cache_get_value_name_int(i, "world", atmInfo[id][atmWorld]);

        CreateObjectAtm(id);
        loadedATMS++;
    }

    printf("[ATMs]: %d ATMs carregadas com sucesso.", loadedATMS);

    return 1;
}

//Carrega atm específica (MySQL).
LoadATM(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `atm` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    atmInfo[id][atmID] = id;
    cache_get_value_name_int(0, "object", atmInfo[id][atmObject]);
    cache_get_value_name_float(0, "position_x", atmInfo[id][Position][0]);
    cache_get_value_name_float(0, "position_y", atmInfo[id][Position][1]);
    cache_get_value_name_float(0, "position_z", atmInfo[id][Position][2]);
    cache_get_value_name_float(0, "position_a", atmInfo[id][Position][3]);
    cache_get_value_name_int(0, "interior", atmInfo[id][atmInterior]);
    cache_get_value_name_int(0, "world", atmInfo[id][atmWorld]);

    CreateObjectAtm(id);
    return 1;
}

//Salva todas atms (MySQL).
SaveATMS() {
    new savedATMS;

    for(new i; i < MAX_ATM; i++) {
        if(!atmInfo[i][atmID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `atm` SET `position_x` = '%f', `position_y` = '%f', `position_z` = '%f', `position_a` = '%f', \
            `interior` = '%d', `world` = '%d', `object` = '%d' WHERE `id` = %d;", atmInfo[i][Position][0], atmInfo[i][Position][1], atmInfo[i][Position][2], atmInfo[i][Position][3], 
            atmInfo[i][atmInterior], atmInfo[i][atmWorld], atmInfo[i][atmObject], i);
        mysql_query(DBConn, query);

        /*mysql_format(DBConn, query, sizeof query, "UPDATE `atm` SET `position_x` = '%f', `position_y` = '%f', `position_z` = '%f', `position_a` = '%f', \
            `interior` = '%d', `world` = '%d', `object` = '%d', `exit_a` = '%f', `vw_exit` = '%d', `interior_exit` = %d WHERE `id` = %d;", atmInfo[i][Position][0], atmInfo[i][Position][1], atmInfo[i][Position][2], atmInfo[i][Position][3],
            hInfo[i][hEntryPos][0], hInfo[i][hEntryPos][1], hInfo[i][hEntryPos][2], hInfo[i][hEntryPos][3], hInfo[i][vwEntry], hInfo[i][interiorEntry],
            hInfo[i][hExitPos][0], hInfo[i][hExitPos][1], hInfo[i][hExitPos][2], hInfo[i][hExitPos][3], hInfo[i][vwExit], hInfo[i][interiorExit], i);
        mysql_query(DBConn, query); */

        RefreshATM(i); // Cria todas ATMs
        savedATMS++;
    }

    printf("[ATMs]: %d ATMs salvas com sucesso.", savedATMS);

    return 1;
}

//Salvar ATM especifica.
SaveATM(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `atm` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `atm` SET `position_x` = '%f', `position_y` = '%f', `position_z` = '%f', `position_a` = '%f', \
            `interior` = '%d', `world` = '%d', `object` = '%d' WHERE `id` = %d;", atmInfo[id][Position][0], atmInfo[id][Position][1], atmInfo[id][Position][2], atmInfo[id][Position][3], 
            atmInfo[id][atmInterior], atmInfo[id][atmWorld], atmInfo[id][atmObject], id);
    mysql_query(DBConn, query);

    return 1;
}

//Criar ATM
CreateATM(playerid) {
    new 
        Float:pos[4]; // Variável das posições
    
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    pos[0] += 2.0 * floatsin(-pos[3], degrees);
	pos[1] += 2.0 * floatcos(-pos[3], degrees);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `atm` (`object`, `position_x`, `position_y`, `position_z`, `position_a`, `world`, `interior`) \
        VALUES (%d, %f, %f, %f, %f, %d, %d);", 2942, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();
    LoadATM(id);
    
    pInfo[playerid][oEditATM] = id;
    EditDynamicObject(playerid, atmInfo[id][atmVariable]);
    
    SendServerMessage(playerid, "Você criou a ATM de ID %d.", id);
    format(logString, sizeof(logString), "%s (%s) criou a ATM de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
    logCreate(playerid, logString, 13);
    return 1;
}

//Criar objeto da ATM
CreateObjectAtm(id) {
    atmInfo[id][atmVariable] = CreateDynamicObject(atmInfo[id][atmObject], atmInfo[id][Position][0], atmInfo[id][Position][1], atmInfo[id][Position][2], 0.0, 0.0, atmInfo[id][Position][3], atmInfo[id][atmWorld], atmInfo[id][atmInterior]);
    return 1;
}

//Deletar/excluir empresa (MySQL)
DeleteAtm(playerid, id) 
{
    DestroyDynamicObject(atmInfo[id][atmVariable]);

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `atm` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    SendServerMessage(playerid, "Você deletou a ATM de ID %d.", id);
    format(logString, sizeof(logString), "%s (%s) deletou a ATM de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
	logCreate(playerid, logString, 13);

    new dummyReset[E_ATM_DATA];
    atmInfo[id] = dummyReset;
    return 1;
} 

// Recarrega ás ATMs (+ destroy todos os objetos existentes dela e create (novamente))
RefreshATM(id) {
	if (IsValidAtm(id))
	{
		if (IsValidDynamicObject(atmInfo[id][atmVariable]))
		    DestroyDynamicObject(atmInfo[id][atmVariable]);

        CreateObjectAtm(id);
	}
	return 1;
}

// ============================================================================================================================================
//Verifica se o ID/atm  existe (MySQL) - ele retorna false (se o ID não existir).
IsValidAtm(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `atm` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

// Verifica a ATM (se possui alguma próxima ou não)
GetNearestAtm(playerid, Float:distance = 2.0) {
    for(new i; i < MAX_ATM; i++) {
        if(!atmInfo[i][atmID])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, atmInfo[i][Position][0], atmInfo[i][Position][1], atmInfo[i][Position][2]))
            continue;

        if(GetPlayerVirtualWorld(playerid) != atmInfo[i][atmWorld] || GetPlayerInterior(playerid) != atmInfo[i][atmInterior])
            continue;

        return i;
    }

    return 0;
}

/*
(Comentado para impedir o warming (de não estar sendo ultilizada)) 
// (em teste) - muda o resultado da atm (se está ou não sendo ultilizada)
OnUsingAtm(playerid, atmID) {
    return atmInfo[atmID][atmActive] = !atmInfo[atmID][atmActive];
}  */

//Mostra a dialog (principal) ao chamar está função.
ShowDialogATM(playerid) {
    Dialog_Show(playerid, atmAccount, DIALOG_STYLE_LIST, "ATM > Acessando conta", "Minha Conta \nConta Compartilhada", "Selecionar", "Cancelar");
    return 1;
}

//Responde a dialog
Dialog:atmAccount(playerid, response, listitem, inputtext[]){
	if(response){
		if(listitem == 0){
             SendErrorMessage(playerid, "Em desenvolvimento [Minha conta].");
             //Colocar para a dialog de senha e após isso que o mesmo acessa a conta.
		}
		else if(listitem == 1){
            SendErrorMessage(playerid, "Em desenvolvimento [Conta Compartilhada].");
            //Colocar para a dialog de senha e após isso que o mesmo acessa a conta.
        }
	} 
	return true;
}