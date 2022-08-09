#include <YSI_Coding\y_hooks>

CMD:vobjeto(playerid, params[]) {
    
    new 
		id, 
		object,
        slot,
        Float:VehPos[3];

	if (sscanf(params, "ddd", id, slot, object)) return SendSyntaxMessage(playerid, "/vobjeto [id veículo] [slot] [id objeto]");
	if (!IsValidVehicle(id) || VehicleGetID(id) == -1) return SendErrorMessage(playerid, "Você especificou um veículo inválido.");

    if (slot < 0 || slot > 5) return SendErrorMessage(playerid, "Você especificou um slot inválido.");

	id = VehicleGetID(id);
    pInfo[playerid][pEditingVeh] = id;
    pInfo[playerid][pOjectVeh] = object;
    pInfo[playerid][pSlotEdVeh] = slot;

    GetVehiclePos(vInfo[id][vVehicle], VehPos[0], VehPos[1], VehPos[2]);
    vInfo[id][vObject][slot] = CreateDynamicObject(object, VehPos[0], VehPos[1], VehPos[2], 0, 0, 0);
    EditDynamicObject(playerid, vInfo[id][vObject][slot]);
    return true;
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
    
    if(response == EDIT_RESPONSE_CANCEL) { // FUNÇÃO DE CANCELAR
        if(pInfo[playerid][pEditingVeh] != 0 && pInfo[playerid][pOjectVeh] != 0) {
            new vehicleid = pInfo[playerid][pEditingVeh];
            new slot = pInfo[playerid][pSlotEdVeh];

            DestroyDynamicObject(vInfo[vehicleid][vObject][slot]);
            SendErrorMessage(playerid, "Você cancelou a edição do item, então ele foi destruído.", pInfo[playerid][pSlotEdVeh]);

            pInfo[playerid][pEditingVeh] = 0;
            pInfo[playerid][pOjectVeh] = 0;
            vInfo[vehicleid][vObject][slot] = 0;
            return true;
        }
    } else if(response == EDIT_RESPONSE_FINAL) { // FUNÇÃO DE VALIDAR
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

            vInfo[vehicleid][vObjectPosX][0] = finalx;
            vInfo[vehicleid][vObjectPosY][1] = finaly;
            vInfo[vehicleid][vObjectPosZ][2] = ofz;
            vInfo[vehicleid][vObjectRotX][0] = rx;
            vInfo[vehicleid][vObjectRotY][1] = ry;
            vInfo[vehicleid][vObjectRotZ][2] = ofaz;
            vInfo[vehicleid][vObject][slot] = object;

            AttachDynamicObjectToVehicle(vInfo[vehicleid][vObject][slot], vInfo[vehicleid][vVehicle], finalx, finaly, ofz, rx, ry, ofaz);
            SendServerMessage(playerid, "O item foi colocado no slot %d do veículo.", pInfo[playerid][pSlotEdVeh]);

            pInfo[playerid][pEditingVeh] = 0;
            pInfo[playerid][pOjectVeh] = 0;
            SaveVehicle(vehicleid);
            return true;
        }
    }
    return true;
}

/*CMD:teste(playerid, params[]) {
    if (pInfo[playerid][pEditingVehObject] || !IsPlayerInAnyVehicle(playerid))
        return 1;
    
    new objectid, Float:VehPos[3];
    GetVehiclePos(GetPlayerVehicleID(playerid), VehPos[0], VehPos[1], VehPos[2]);
    objectid = CreateDynamicObject(19917, VehPos[0], VehPos[1], VehPos[2], 0, 0, 0);
    EditDynamicObject(playerid, objectid);
    pInfo[playerid][pEditingVehObject] = 1;
    return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(response == EDIT_RESPONSE_UPDATE)
    {
        return 1;
    }
    if(response == EDIT_RESPONSE_FINAL && pInfo[playerid][pEditingVehObject])
    {
        pInfo[playerid][pEditingVehObject] = 0;
    
        if (!IsPlayerInAnyVehicle(playerid))
            return 0;
    
        new Float:ofx, Float:ofy, Float:ofz;
        new Float:ofaz, Float:finalx, Float:finaly;
        new Float:px, Float:py, Float:pz, Float:roz;
        GetVehiclePos(GetPlayerVehicleID(playerid), px, py, pz);
        GetVehicleZAngle(GetPlayerVehicleID(playerid), roz);
        ofx = x-px;
        ofy = y-py;
        ofz = z-pz;
        ofaz = rz-roz;
        finalx = ofx*floatcos(roz, degrees)+ofy*floatsin(roz, degrees);
        finaly = -ofx*floatsin(roz, degrees)+ofy*floatcos(roz, degrees);
      
        SendClientMessage(playerid, 0x58ACFAFF, "The object attached to your vehicle.");
        AttachDynamicObjectToVehicle(objectid, GetPlayerVehicleID(playerid), finalx, finaly, ofz, rx, ry, ofaz);
    }
    return 1;
}*/