#include <YSI_Coding\y_hooks>

enum e_VehicleObjectData {
	e_ObjectID,
	e_ObjectName[64],
	e_ObjectType
};

static const g_aVehicleObjectData[][e_VehicleObjectData] = {
	{1000, "Spoiler 1", 0},
    {1002, "Spoiler 2", 0},
    {1003, "Spoiler 3", 0},
    {1014, "Spoiler 4", 0},
    {1015, "Spoiler 5", 0},
    {1143, "Saída de Ar 1", 0},
    {1145, "Saída de Ar 1", 0},
    {1145, "Saída de Ar 1", 0},
    {1008, "Cilindro de Nos Pequeno", 0},
    {1009, "Cilindro de Nos Médio", 0},
    {1010, "Cilindro de Nos Duplo", 0},
    {19917, "Motor", 0},

    {2404, "Prancha de Surf 1", 0},
    {2405, "Prancha de Surf 2", 0},
    {2406, "Prancha de Surf 3", 0},
    {2410, "Prancha de Surf 4", 0},

    {18645, "Capacete em Chamas", 0},
    {18976, "Capacete de Motocross", 0},
    {18977, "Capacete Vermelho", 0},

    {18641, "Lanterna Pequena", 0},
    {18633, "Chave de Boca", 0},
    {18644, "Chave de Fenda", 0},
    {18634, "Pé de Cabra", 0},
    {18635, "Martelo", 0},
    {18632, "Vara de Pesca", 0},
    {11738, "Medkit", 0},

    {19308, "Taxi 1", 0},
    {19309, "Taxi 2", 0},
    {19310, "Taxi 3", 0},
    {19311, "Taxi 4", 0},

    {19317, "Guitarra Vermelha", 0},
    {19318, "Guitarra Branca", 0},
    {19319, "Guitarra Preta", 0},

    {1428, "Escada", 0}
};

CheckVehObjectName(modelid) {
	new name[64];
	for (new i = 0; i < sizeof(g_aVehicleObjectData); i ++) {
		if (g_aVehicleObjectData[i][e_ObjectID] == modelid) {
			format(name, sizeof(name), "%s", g_aVehicleObjectData[i][e_ObjectName]);
    	}
	}
	return name;
}

CMD:vobjeto(playerid, params[]) {
    new id = GetNearestVehicle(playerid);
    if(!IsValidVehicle(id) || VehicleGetID(id) == -1) return SendErrorMessage(playerid, "Você deve estar próximo a um veículo.");
    id = VehicleGetID(id);
    if(vInfo[id][vCaravan] == 1) return SendErrorMessage(playerid, "Você não pode colocar um objeto em uma caravana.");
    if(!VehicleIsOwner(playerid, id)) return SendErrorMessage(playerid, "Você deve ser o proprietário do veículo para usar esse comando.");
    pInfo[playerid][pEditingVeh] = id;
    new string[512], title[256], slots;
    if(pInfo[playerid][pDonator] > 0) slots = 5;
    else slots = 3;

    if(vInfo[id][vNamePersonalized]) format(title, sizeof(title), "{FFFFFF}Objetos de %s", vInfo[id][vName]);
    else format(title, sizeof(title), "{FFFFFF}Objetos de %s", ReturnVehicleModelName(vInfo[id][vModel]));
    format(string, sizeof(string), "Slot\tObjeto\n");
    for(new i = 0; i < slots; i++) {
        format(string, sizeof(string), "%s%d\t%s\n", string, i, CheckVehObjectName(vInfo[id][vObject][i]));
    }

    Dialog_Show(playerid, ShowVehSlotObjects, DIALOG_STYLE_TABLIST_HEADERS, title, string, "Selecionar", "Fechar");
    return true;
}

Dialog:ShowVehSlotObjects(playerid, response, listitem, inputtext[]){
	if(response) {
        pInfo[playerid][pSlotEdVeh] = listitem;
        new id = pInfo[playerid][pEditingVeh];
        new string[2048], title[128];

        if(vInfo[id][vNamePersonalized]) format(title, sizeof(title), "Objetos_de_%s", vInfo[id][vName]);
        else format(title, sizeof(title), "Objetos_de_%s", ReturnVehicleModelName(vInfo[id][vModel]));
        AdjustTextDrawString(title);

        for(new i; i < sizeof(g_aVehicleObjectData); i++){
			new objectname[64];
            if(g_aVehicleObjectData[i][e_ObjectID] == 0) format(objectname, 64, "Slot vago");
			else format(objectname, 64, "%s", g_aVehicleObjectData[i][e_ObjectName]);
			AdjustTextDrawString(objectname);
			format(string, sizeof(string), "%s%d(0.0, 0.0, 180.0)\t~g~%s\n", string, g_aVehicleObjectData[i][e_ObjectID], objectname);	
			
		}
        Dialog_Show(playerid, ShowVehicleObjects, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
		return true;
	} else {
        pInfo[playerid][pEditingVeh] = 0;
        pInfo[playerid][pSlotEdVeh] = 0;
        SendServerMessage(playerid, "Você cancelou a adição de objeto veicular.");
    }
	return true;
}

Dialog:ShowVehicleObjects(playerid, response, listitem, inputtext[]) {
    new 
        Float:vehPos[3], 
        slot =  pInfo[playerid][pSlotEdVeh], 
        id = pInfo[playerid][pEditingVeh], 
        object;
    if(response){
        pInfo[playerid][pOjectVeh] = object = strval(inputtext);

        if (IsValidDynamicObject(vInfo[id][vObjectSlot][slot]))
        DestroyDynamicObject(vInfo[id][vObjectSlot][slot]);
        
        GetVehiclePos(vInfo[id][vVehicle], vehPos[0], vehPos[1], vehPos[2]);
        vInfo[id][vObjectSlot][slot] = CreateDynamicObject(object, vehPos[0], vehPos[1], vehPos[2], 0, 0, 0);
        EditDynamicObject(playerid, vInfo[id][vObjectSlot][slot]);
        SendServerMessage(playerid, "Agora você adicionando um objeto ao seu veículo."), SendServerMessage(playerid, "Aperte ESC para cancelar, ou o disquete para salvar quando estiver pronto.");
	} else {
        SendServerMessage(playerid, "Você cancelou a adição de objeto veicular.");
        vInfo[id][vObjectSlot][slot] = -1;
        pInfo[playerid][pEditingVeh] = 0;
        pInfo[playerid][pOjectVeh] = 0;
        vInfo[id][vObject][slot] = 0;
    }
    return true;
}

CMD:avobjeto(playerid, params[]) {
    if(GetPlayerAdmin(playerid) < 5) return SendPermissionMessage(playerid);
    new 
		id, 
		object,
        slot,
        Float:VehPos[3];

	if (sscanf(params, "ddd", id, slot, object)) return SendSyntaxMessage(playerid, "/vobjeto [id veículo] [slot] [id objeto]");
	if (!IsValidVehicle(id) || VehicleGetID(id) == -1) return SendErrorMessage(playerid, "Você especificou um veículo inválido.");
    
    if (slot < 0 || slot > 5) return SendErrorMessage(playerid, "Você especificou um slot inválido.");

	id = VehicleGetID(id);
    
    if(vInfo[id][vCaravan] == 1) return SendErrorMessage(playerid, "Você não pode colocar um objeto em uma caravana.");

    if (IsValidDynamicObject(vInfo[id][vObjectSlot][slot]))
        DestroyDynamicObject(vInfo[id][vObjectSlot][slot]);
        
    pInfo[playerid][pEditingVeh] = id;
    pInfo[playerid][pOjectVeh] = object;
    pInfo[playerid][pSlotEdVeh] = slot;

    GetVehiclePos(vInfo[id][vVehicle], VehPos[0], VehPos[1], VehPos[2]);
    vInfo[id][vObjectSlot][slot] = CreateDynamicObject(object, VehPos[0], VehPos[1], VehPos[2], 0, 0, 0);
    EditDynamicObject(playerid, vInfo[id][vObjectSlot][slot]);
    return true;
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
    
    if(response == 0) { // FUNÇÃO DE CANCELAR
        if(pInfo[playerid][pEditingVeh] != 0 && pInfo[playerid][pOjectVeh] != 0) {
            new vehicleid = pInfo[playerid][pEditingVeh];
            new slot = pInfo[playerid][pSlotEdVeh];

            if (IsValidDynamicObject(vInfo[vehicleid][vObjectSlot][slot]))
                DestroyDynamicObject(vInfo[vehicleid][vObjectSlot][slot]);

            SendErrorMessage(playerid, "Você cancelou a edição do item, então ele foi destruído.", pInfo[playerid][pSlotEdVeh]);

            vInfo[vehicleid][vObjectSlot][slot] = -1;
            pInfo[playerid][pEditingVeh] = 0;
            pInfo[playerid][pOjectVeh] = 0;
            vInfo[vehicleid][vObject][slot] = 0;
            return true;
        }
    } else if(response == 1) { // FUNÇÃO DE VALIDAR
        if(pInfo[playerid][pEditingVeh] != 0 && pInfo[playerid][pOjectVeh] != 0) {
            new vehicleid = pInfo[playerid][pEditingVeh];
            new slot = pInfo[playerid][pSlotEdVeh];
            new object = pInfo[playerid][pOjectVeh];

            new Float:ofx, Float:ofy, Float:ofz;
            new Float:ofaz, Float:finalx, Float:finaly;
            new Float:px, Float:py, Float:pz, Float:roz;

            GetVehiclePos(vInfo[vehicleid][vVehicle], px, py, pz);
            GetVehicleZAngle(vInfo[vehicleid][vVehicle], roz);
            ofx = x-px;
            ofy = y-py;
            ofz = z-pz;
            ofaz = rz-roz;
            finalx = ofx*floatcos(roz, degrees)+ofy*floatsin(roz, degrees);
            finaly = -ofx*floatsin(roz, degrees)+ofy*floatcos(roz, degrees);

            vInfo[vehicleid][vObjectPosX][slot] = finalx;
            vInfo[vehicleid][vObjectPosY][slot] = finaly;
            vInfo[vehicleid][vObjectPosZ][slot] = ofz;
            vInfo[vehicleid][vObjectRotX][slot] = rx;
            vInfo[vehicleid][vObjectRotY][slot] = ry;
            vInfo[vehicleid][vObjectRotZ][slot] = ofaz;
            if (IsValidDynamicObject(vInfo[vehicleid][vObjectSlot][slot]))
                DestroyDynamicObject(vInfo[vehicleid][vObjectSlot][slot]);

            
            vInfo[vehicleid][vObjectSlot][slot] = CreateDynamicObject(object, 0, 0, 0, 0, 0, 0);
            AttachDynamicObjectToVehicle(vInfo[vehicleid][vObjectSlot][slot], vInfo[vehicleid][vVehicle], finalx, finaly, ofz, rx, ry, ofaz);
            SendServerMessage(playerid, "O item foi colocado no slot %d do veículo.", pInfo[playerid][pSlotEdVeh]);

            vInfo[vehicleid][vObject][slot] = object;

            pInfo[playerid][pEditingVeh] = 0;
            pInfo[playerid][pOjectVeh] = 0;
            SaveVehicle(vehicleid);
            return true;
        }
    }
    return true;
}