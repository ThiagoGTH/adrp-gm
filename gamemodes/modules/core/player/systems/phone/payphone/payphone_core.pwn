//Definição de máximo de "Telefone publico" na cidade.
#define MAX_PAYPHONE          1000

//Valores do "data".
enum E_PHONE_DATA {
    phoneID,             // ID da empresa no MySQL
    phoneObject,         // (Apenas uma varíavel não ultilizavel) - ID do Objeto da Telefone publico (isto para futuras mudanças no quesito Telefone publico - porém já ultilizo para)
    phoneVariable,       // Varíavel do objeto da Telefone publico
    phoneInterior,       // Interior da Telefone publico
    phoneWorld,          // Mundo da Telefone publico
    bool:phoneActive,    // Se está ativa ou não.
    bool:phoneStatus,    // Ativado/Desativado
    Float:Position[4], // Posições (X, Y, Z, A)
};

//Simplificação dos valores da "data"
new phoneInfo[MAX_PAYPHONE][E_PHONE_DATA];

hook OnGameModeInit() {
    LoadPHONES();
    return 1;
}

hook OnGamemodeExit() {
    SavePHONES();
    return 1;
}

hook OP_EditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if (response == 1)
	{
	    if (IsValidPhone(pInfo[playerid][oEditPhone]))
	    {
			phoneInfo[pInfo[playerid][oEditPhone]][Position][0] = x;
			phoneInfo[pInfo[playerid][oEditPhone]][Position][1] = y;
			phoneInfo[pInfo[playerid][oEditPhone]][Position][2] = z;
			phoneInfo[pInfo[playerid][oEditPhone]][Position][3] = rz;
            
            SavePHONE(pInfo[playerid][oEditPhone]);
            RefreshPHONE(pInfo[playerid][oEditPhone]);

            SendServerMessage(playerid, "Você editou o telefone de ID %d.", pInfo[playerid][oEditPhone]);
	    }
    }
	if (response == 1 || response == 0)
	{
	    if (pInfo[playerid][oEditPhone] != -1)
            return RefreshPHONE(pInfo[playerid][oEditPhone]);
            
		pInfo[playerid][oEditPhone] = -1;
	}
	return 1;
}

//Carrega todos os telefones publicos (MySQL).
LoadPHONES() {
    new     
        loadedPHONES;

    mysql_query(DBConn, "SELECT * FROM `payphone`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        
        phoneInfo[id][phoneID] = id;
        cache_get_value_name_int(i, "object", phoneInfo[id][phoneObject]);
        cache_get_value_name_float(i, "position_x", phoneInfo[id][Position][0]);
        cache_get_value_name_float(i, "position_y", phoneInfo[id][Position][1]);
        cache_get_value_name_float(i, "position_z", phoneInfo[id][Position][2]);
        cache_get_value_name_float(i, "position_a", phoneInfo[id][Position][3]);
        cache_get_value_name_int(i, "interior", phoneInfo[id][phoneInterior]);
        cache_get_value_name_int(i, "world", phoneInfo[id][phoneWorld]);

        CreateObjectPhone(id);
        loadedPHONES++;
    }

    printf("[PHONES]: %d Pay Phones carregadas com sucesso.", loadedPHONES);

    return 1;
}

//Carrega telefone publico específica (MySQL).
LoadPHONE(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `payphone` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    phoneInfo[id][phoneID] = id;
    cache_get_value_name_int(0, "object", phoneInfo[id][phoneObject]);
    cache_get_value_name_float(0, "position_x", phoneInfo[id][Position][0]);
    cache_get_value_name_float(0, "position_y", phoneInfo[id][Position][1]);
    cache_get_value_name_float(0, "position_z", phoneInfo[id][Position][2]);
    cache_get_value_name_float(0, "position_a", phoneInfo[id][Position][3]);
    cache_get_value_name_int(0, "interior", phoneInfo[id][phoneInterior]);
    cache_get_value_name_int(0, "world", phoneInfo[id][phoneWorld]);

    CreateObjectPhone(id);
    return 1;
}

//Salva todos os telefones publicos (MySQL).
SavePHONES() {
    new savedPHONES;

    for(new i; i < MAX_PAYPHONE; i++) {
        if(!phoneInfo[i][phoneID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `payphone` SET `position_x` = '%f', `position_y` = '%f', `position_z` = '%f', `position_a` = '%f', \
            `interior` = '%d', `world` = '%d', `object` = '%d' WHERE `id` = %d;", phoneInfo[i][Position][0], phoneInfo[i][Position][1], phoneInfo[i][Position][2], phoneInfo[i][Position][3], 
            phoneInfo[i][phoneInterior], phoneInfo[i][phoneWorld], phoneInfo[i][phoneObject], i);
        mysql_query(DBConn, query);

        RefreshPHONE(i); // Cria todas telfones publicos
        savedPHONES++;
    }

    printf("[PHONES]: %d Pay Phones salvas com sucesso.", savedPHONES);

    return 1;
}

//Salvar Telefone publico especifica.
SavePHONE(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `payphone` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `payphone` SET `position_x` = '%f', `position_y` = '%f', `position_z` = '%f', `position_a` = '%f', \
            `interior` = '%d', `world` = '%d', `object` = '%d' WHERE `id` = %d;", phoneInfo[id][Position][0], phoneInfo[id][Position][1], phoneInfo[id][Position][2], phoneInfo[id][Position][3], 
            phoneInfo[id][phoneInterior], phoneInfo[id][phoneWorld], phoneInfo[id][phoneObject], id);
    mysql_query(DBConn, query);

    return 1;
}

//Criar Telefone publico
CreatePayPhone(playerid) {
    new 
        Float:pos[4]; // Variável das posições
    
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    pos[0] += 2.0 * floatsin(-pos[3], degrees);
	pos[1] += 2.0 * floatcos(-pos[3], degrees);

    mysql_format(DBConn, query, sizeof query, "INSERT INTO `payphone` (`object`, `position_x`, `position_y`, `position_z`, `position_a`, `world`, `interior`) \
        VALUES (%d, %f, %f, %f, %f, %d, %d);", 1216, pos[0], pos[1], pos[2], pos[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_query(DBConn, query);

    new id = cache_insert_id();
    LoadPHONE(id);
    
    pInfo[playerid][oEditPhone] = id;
    EditDynamicObject(playerid, phoneInfo[id][phoneVariable]);
    
    SendServerMessage(playerid, "Você criou um telefone publico de ID %d.", id);
    format(logString, sizeof(logString), "%s (%s) criou um telefone publico de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
    logCreate(playerid, logString, 13);
    return 1;
}

//Criar objeto da Telefone publico
CreateObjectPhone(id) {
    phoneInfo[id][phoneVariable] = CreateDynamicObject(phoneInfo[id][phoneObject], phoneInfo[id][Position][0], phoneInfo[id][Position][1], phoneInfo[id][Position][2], 0.0, 0.0, phoneInfo[id][Position][3], phoneInfo[id][phoneWorld], phoneInfo[id][phoneInterior]);
    return 1;
}

//Deleta/exclui telefone (MySQL)
DeletePayPhone(playerid, id) 
{
    DestroyDynamicObject(phoneInfo[id][phoneVariable]);

    mysql_format(DBConn, query, sizeof query, "DELETE FROM `payphone` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    SendServerMessage(playerid, "Você deletou a Telefone publico de ID %d.", id);
    format(logString, sizeof(logString), "%s (%s) deletou a Telefone publico de ID %d.", pNome(playerid), GetPlayerUserEx(playerid), id);
	logCreate(playerid, logString, 13);

    new dummyReset[E_PHONE_DATA];
    phoneInfo[id] = dummyReset;
    return 1;
} 

// Recarrega ás telefones publicos (+ destroy todos os objetos existentes dela e create (novamente))
RefreshPHONE(id) {
	if (IsValidPhone(id))
	{
		if (IsValidDynamicObject(phoneInfo[id][phoneVariable]))
		    DestroyDynamicObject(phoneInfo[id][phoneVariable]);

        CreateObjectPhone(id);
	}
	return 1;
}

// ============================================================================================================================================
//Verifica se o ID/Telefones publicos  existe (MySQL) - ele retorna false (se o ID não existir).
IsValidPhone(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `payphone` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

// Verifica a Telefone publico (se possui alguma próxima ou não)
GetNearestPhone(playerid, Float:distance = 2.0) {
    for(new i; i < MAX_PAYPHONE; i++) {
        if(!phoneInfo[i][phoneID])
            continue;

        if(!IsPlayerInRangeOfPoint(playerid, distance, phoneInfo[i][Position][0], phoneInfo[i][Position][1], phoneInfo[i][Position][2]))
            continue;

        if(GetPlayerVirtualWorld(playerid) != phoneInfo[i][phoneWorld] || GetPlayerInterior(playerid) != phoneInfo[i][phoneInterior])
            continue;

        return i;
    }

    return 0;
}

//Mostra a dialog (principal) ao chamar está função.
ShowDialogPhone(playerid) {
    Dialog_Show(playerid, phoneAccount, DIALOG_STYLE_LIST, "Telefone publico > Acessando", "Usar (min)", "Selecionar", "Cancelar");
    return 1;
}

//Responde a dialog
Dialog:phoneAccount(playerid, response, listitem, inputtext[]){
	if(response){
		if(listitem == 0){
             SendErrorMessage(playerid, "Em desenvolvimento [Ligar telefone publico].");
             //Colocar para a dialog de senha e após isso que o mesmo acessa a conta.
		}
		/*else if(listitem == 1){
            SendErrorMessage(playerid, "Em desenvolvimento [?].");
            //Colocar para a dialog de senha e após isso que o mesmo acessa a conta.
        } */
	} 
	return true;
}