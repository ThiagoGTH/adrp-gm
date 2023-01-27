//Definição
#define MAX_SIGNALTOWER 60

//Torre de sinal
enum signalData
{
	signalID,
	signalExists,
    Float:Position[4],
    Float:towerRadius,
	signalName[64],
	signalObject,
    signalVariable,
    Interior,
    World,
};

new SignalData[MAX_SIGNALTOWER][signalData];

hook OnGameModeInit() {
    LoadTOWERS();
    return 1;
}

hook OP_EditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if (response == 1)
	{
	    if (IsValidTower(pInfo[playerid][oEditTower]))
	    {
			SignalData[pInfo[playerid][oEditTower]][Position][0] = x;
			SignalData[pInfo[playerid][oEditTower]][Position][1] = y;
			SignalData[pInfo[playerid][oEditTower]][Position][2] = z;
			SignalData[pInfo[playerid][oEditTower]][Position][3] = rz;
            
            SaveTOWER(pInfo[playerid][oEditTower]);
            RefreshTOWER(pInfo[playerid][oEditTower]);

            SendServerMessage(playerid, "Você editou a TORRRE de ID %d.", pInfo[playerid][oEditTower]);
	    }
    }
	if (response == 1 || response == 0)
	{
	    if (pInfo[playerid][oEditTower] != -1)
            return RefreshTOWER(pInfo[playerid][oEditTower]);
            
		pInfo[playerid][oEditTower] = -1;
	}
	return 1;
}

//Carrega todas tores de sinal (MySQL).
LoadTOWERS() {
    new     
        loadedTOWERS;

    mysql_query(DBConn, "SELECT * FROM `signal_tower`;");

    for(new i; i < cache_num_rows(); i++) {
        new id;
        cache_get_value_name_int(i, "id", id);
        
        SignalData[id][signalID] = id;
        cache_get_value_name_int(i, "object", SignalData[id][signalObject]);
        cache_get_value_name_float(i, "position_x", SignalData[id][Position][0]);
        cache_get_value_name_float(i, "position_y", SignalData[id][Position][1]);
        cache_get_value_name_float(i, "position_z", SignalData[id][Position][2]);
        cache_get_value_name_float(i, "position_a", SignalData[id][Position][3]);
        cache_get_value_name_float(i, "radius", SignalData[id][towerRadius]);
        cache_get_value_name_int(i, "interior", SignalData[id][Interior]);
        cache_get_value_name_int(i, "world", SignalData[id][World]);

        CreateObjectTower(id);
        loadedTOWERS++;
    }
    printf("[Torres]: %d Torres de Sinal carregadas com sucesso.", loadedTOWERS);
    return 1;
}

//Carrega atm específica (MySQL).
LoadTOWER(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `signal_tower` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    SignalData[id][signalID] = id;
    cache_get_value_name_int(0, "object", SignalData[id][signalObject]);
    cache_get_value_name_float(0, "position_x", SignalData[id][Position][0]);
    cache_get_value_name_float(0, "position_y", SignalData[id][Position][1]);
    cache_get_value_name_float(0, "position_z", SignalData[id][Position][2]);
    cache_get_value_name_float(0, "position_a", SignalData[id][Position][3]);
    cache_get_value_name_float(0, "radius", SignalData[id][towerRadius]);
    cache_get_value_name_int(0, "interior", SignalData[id][Interior]);
    cache_get_value_name_int(0, "world", SignalData[id][World]);
    CreateObjectTower(id);
    return 1;
}

//Salva todas towers (MySQL).
SaveTOWERS() {
    new savedTOWERS;

    for(new i; i < MAX_ATM; i++) {
        if(!SignalData[i][signalID])
            continue;

        mysql_format(DBConn, query, sizeof query, "UPDATE `signal_tower` SET `position_x` = '%f', `position_y` = '%f', `position_z` = '%f', `position_a` = '%f', \
            `radius` = '%f', `interior` = '%d', `world` = '%d', `object` = '%d' WHERE `id` = %d;", SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2], SignalData[i][Position][3], 
            SignalData[i][towerRadius], SignalData[i][Interior], SignalData[i][World], SignalData[i][signalObject], i);
        mysql_query(DBConn, query);

        RefreshTOWER(i); // Cria todos ás torres
        savedTOWERS++;
    }

    printf("[TOWERs]: %d TOWERs salvas com sucesso.", savedTOWERS);
    return 1;
}

//Salvar TORRE especifica.
SaveTOWER(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `signal_tower` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    mysql_format(DBConn, query, sizeof query, "UPDATE `signal_tower` SET `position_x` = '%f', `position_y` = '%f', `position_z` = '%f', `position_a` = '%f', \
        `radius` = '%f', `interior` = '%d', `world` = '%d', `object` = '%d' WHERE `id` = %d;", SignalData[id][Position][0], SignalData[id][Position][1], SignalData[id][Position][2], SignalData[id][Position][3], 
        SignalData[id][towerRadius], SignalData[id][Interior], SignalData[id][World], SignalData[id][signalObject], id);
    mysql_query(DBConn, query);

    return 1;
}

// Recarrega ás torre (+ destroy todos os objetos existentes dela e create (novamente))
RefreshTOWER(id) {
	if (IsValidTower(id))
	{
		if (IsValidDynamicObject(SignalData[id][signalVariable]))
		    DestroyDynamicObject(SignalData[id][signalVariable]);

        CreateObjectTower(id);
	}
	return 1;
}

//Criar objeto da toore
CreateObjectTower(id) {
    SignalData[id][signalVariable] = CreateDynamicObject(SignalData[id][signalObject], SignalData[id][Position][0], SignalData[id][Position][1], SignalData[id][Position][2], 0.0, 0.0, SignalData[id][Position][3], SignalData[id][World], SignalData[id][Interior]);
    return 1;
}

// ============================================================================================================================================
//Verifica se o ID/tower  existe (MySQL) - ele retorna false (se o ID não existir).
IsValidTower(id) {
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `signal_tower` WHERE `id` = %d;", id);
    mysql_query(DBConn, query);

    if(!cache_num_rows())
        return 0;

    return 1;
}

//Sinal da torre (verifica qual é o sinal do torre(mais próxima))
GetPhoneSignal(playerid) {
	new tower = GetCloseSignal(playerid), signal, Float:dis, Float:cal;
	
	if(tower == -1) return 0;

	if(pInfo[playerid][pLocal] != 255) {
		if(pInfo[playerid][pLocal] == 101) dis = GetDistance(1554.4711,-1675.6097,16.1953, SignalData[tower][Position][0], SignalData[tower][Position][1], SignalData[tower][Position][2]);
        else if(pInfo[playerid][pLocal] == 102) dis = GetDistance(1481.0662,-1771.3069,18.7958,  SignalData[tower][Position][0], SignalData[tower][Position][1], SignalData[tower][Position][2]);
        else if(pInfo[playerid][pLocal] == 103) dis = GetDistance(1173.1841,-1323.3143,15.3952,  SignalData[tower][Position][0], SignalData[tower][Position][1], SignalData[tower][Position][2]);
        else if(pInfo[playerid][pLocal] == 104) dis = GetDistance(533.4344,-1812.9364,6.5781,  SignalData[tower][Position][0], SignalData[tower][Position][1], SignalData[tower][Position][2]);
		else
		{
	 		/*foreach (new x : Business) {
			 	if(pInfo[playerid][pLocal] - LOCAL_BIZZ == x && GetPlayerInterior(playerid) == BusinessData[x][bInterior])
			 	{
					dis = GetDistance(BusinessData[x][bEntranceX], BusinessData[x][bEntranceY], BusinessData[x][bEntranceZ], SignalData[tower][Position][0], SignalData[tower][Position][1], SignalData[tower][Position][2]);
				}
			} */
		}
	}
	else dis = GetPlayerDistanceFromPoint(playerid, SignalData[tower][Position][0], SignalData[tower][Position][1], SignalData[tower][Position][2]);
	cal = SignalData[tower][towerRadius] / 5;
	if(dis > cal * 4 ) signal = 1;
 	else if(dis > cal * 3 ) signal = 2;
	else if(dis > cal * 2 ) signal = 3;
	else if(dis > cal * 1 ) signal = 4;
	else signal = 5;

	return signal;
}

GetCloseSignal(playerid) {
	new
	    Float:fDistance[2] = {99999.0, 0.0},
	    iIndex = -1
	;

	for(new i = 0; i < sizeof(SignalData); ++i) {
		if(SignalData[i][signalExists]) {
		    if(pInfo[playerid][pLocal] != 255) {
				if(pInfo[playerid][pLocal] == 101) fDistance[1] = GetDistance(1554.4711,-1675.6097,16.1953, SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);
				else if(pInfo[playerid][pLocal] == 102) fDistance[1] = GetDistance(1481.0662,-1771.3069,18.7958, SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);
				else if(pInfo[playerid][pLocal] == 103) fDistance[1] = GetDistance(1173.1841,-1323.3143,15.3952, SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);
				else if(pInfo[playerid][pLocal] == 103) fDistance[1] = GetDistance(533.4344,-1812.9364,6.5781, SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);
				else
				{
		 		    /*for(new x = 0; x != MAX_BUSINESS; ++x) if(pInfo[playerid][pLocal]-LOCAL_BIZZ == x && GetPlayerInterior(playerid) == BusinessData[x][bInterior]) {
						fDistance[1] = GetDistance(BusinessData[x][bEntranceX],BusinessData[x][bEntranceY],BusinessData[x][bEntranceZ], SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);
					}

					new x;

					if(InBusiness[playerid] != -1)
					{
		   				x = InBusiness[playerid];

						fDistance[1] = GetDistance(BusinessData[x][bEntranceX],BusinessData[x][bEntranceY],BusinessData[x][bEntranceZ], SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);
					}
					else if(InProperty[playerid] != -1)
					{
					    x = InProperty[playerid];

						fDistance[1] = GetDistance(PropertyData[x][hEntranceX],PropertyData[x][hEntranceY],PropertyData[x][hEntranceZ], SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);
					}
					else if(InApartment[playerid] != -1)
					{
					    x = InApartment[playerid];

						fDistance[1] = GetDistance(ComplexData[x][aEntranceX],ComplexData[x][aEntranceY],ComplexData[x][aEntranceZ], SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);
					} */
				}
			}
			else fDistance[1] = GetPlayerDistanceFromPoint(playerid, SignalData[i][Position][0], SignalData[i][Position][1], SignalData[i][Position][2]);

			if(fDistance[1] < fDistance[0] && SignalData[i][towerRadius] >= fDistance[1]) {
			    fDistance[0] = fDistance[1];
			    iIndex = i;
			}
		}
	}
	return iIndex;
}