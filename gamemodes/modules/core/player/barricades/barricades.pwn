/*

Modulo destinado ao sistema de barreiras para facções governamentais.

*/
#include <YSI_Coding\y_hooks>

#define MAX_BARRICADES 20

#define MODEL_LSPD_BARREIRAS (0)

enum barricadeinfo {
	cadeExists,
	cadeType,
	Float:cadePos[3],
    Float:cadefPos[3],
	cadeObject,
	cadeWorld,
    cadeInt,
    cadeModel,
    bool:beditando
};
new br_info[MAX_BARRICADES][barricadeinfo];

ShowBarricadeModelMenu(playerid)
{
    // create a dynamic PawnPlus list to populate with models.
    // you don't need to worry about deleting this list, it's handled by the include once it's passed to it
    new List:barreiras = list_new();

    // add skin IDs 0, 1, 29 and 60 with "cool people only" text above skin ID 29.
    AddModelMenuItem(barreiras, 1238, "Cone 1");
    AddModelMenuItem(barreiras, 997, "Corrimão 1");
    AddModelMenuItem(barreiras, 1237, "Cone 2");
    AddModelMenuItem(barreiras, 1282, "Placa 1");
    AddModelMenuItem(barreiras, 1422, "Barreira 1");
    AddModelMenuItem(barreiras, 973, "Corrimão 2");
    AddModelMenuItem(barreiras, 978, "Corrimão 3");
    AddModelMenuItem(barreiras, 3091, "Placa 2");
    AddModelMenuItem(barreiras, 19834, "Fixa 1");
    AddModelMenuItem(barreiras, 19972, "Placa 3");
    AddModelMenuItem(barreiras, 19950, "Placa 4");
    AddModelMenuItem(barreiras, 19951, "Placa 5");
    AddModelMenuItem(barreiras, 19952, "Placa 6");
    AddModelMenuItem(barreiras, 19953, "Placa 7");
    AddModelMenuItem(barreiras, 19954, "Placa 8");
    AddModelMenuItem(barreiras, 19967, "Placa 9");
    AddModelMenuItem(barreiras, 1425, "Placa 10");
    AddModelMenuItem(barreiras, 1459, "Barreira 2");
    AddModelMenuItem(barreiras, 1427, "Barreira 3");
    AddModelMenuItem(barreiras, 1424, "Barreira 4");
    AddModelMenuItem(barreiras, 1423, "Barreira 5");
    AddModelMenuItem(barreiras, 1428, "Escada 1");
    AddModelMenuItem(barreiras, 1437, "Escada 2");
    AddModelMenuItem(barreiras, 2899, "Tapete de Pregos");

    // show the menu to the player
    ShowModelSelectionMenu(playerid, "Barreiras", MODEL_LSPD_BARREIRAS, barreiras);
}

CMD:barreira(playerid, params[])
{
	if (isnull(params)){
	 	SendUsageMessage(playerid, "/barreira <opção>");
	    SendClientMessage(playerid, VERDE, "(Opções):{FFFFFF} colocar, editar, retirar, retirarall");
		return true;
	}
    
	static
        Float:fX,
        Float:fY,
        Float:fZ,
        Float:fA;

    GetPlayerPos(playerid, fX, fY, fZ);
    GetPlayerFacingAngle(playerid, fA);

	if (IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "VocÃª não pode usar esse comando de dentro de um veÃ­culo.");

	if (!strcmp(params, "colocar", true))
	{
	    ShowBarricadeModelMenu(playerid);
	}
	else if (!strcmp(params, "retirar", true))
	{
        for (new i = 0; i != MAX_BARRICADES; i ++) if (br_info[i][cadeExists] && br_info[i][cadeType] == 2 && IsPlayerInRangeOfPoint(playerid, 5.0, br_info[i][cadePos][0], br_info[i][cadePos][1], br_info[i][cadePos][2]))
	    {
            br_info[i][cadeExists] = 0;
            br_info[i][cadeType] = 0;
            br_info[i][beditando] = false;
            
            DestroyDynamicObject(br_info[i][cadeObject]);

            SendClientMessage(playerid, VERDE, "(Barreira):{FFFFFF} VocÃª removeu uma barreira do servidor.");
			return true;
		}
		SendErrorMessage(playerid, "vocÃª não estÃ¡ próximo a nenhuma barreira.");
	}
	else if (!strcmp(params, "retirarall", true))
	{
        for (new i = 0; i != MAX_BARRICADES; i ++) if (br_info[i][cadeExists] && br_info[i][cadeType] == 2)
	    {
            br_info[i][cadeExists] = 0;
            br_info[i][cadeType] = 0;
            br_info[i][beditando] = false;

			DestroyDynamicObject(br_info[i][cadeObject]);
		}
		SendClientMessage(playerid, VERDE, "(Barreira):{FFFFFF} VocÃª removeu todas as barreiras do servidor.");
	}
	else if (!strcmp(params, "editar", true)){
    	SetPVarInt(playerid, "SelectObject_Option", 1);
		SendClientMessage(playerid, VERDE, "(Barreira):{FFFFFF} Clique sobre a barreira que vocÃª deseja editar.");
		SelectObject(playerid);
		return true;
	}
	return true;
}
public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z) {
	new SelectOption = GetPVarInt(playerid, "SelectObject_Option");

    CancelEdit(playerid);

    if(SelectOption == 1) { //Barreira Editor
    	for(new i = 0; i < MAX_BARRICADES; i++) {
    		if(br_info[i][cadeObject] == objectid) {
    			//if(br_info[i][beditando] == true) return SendErrorMessage(playerid, "Este objeto jÃ¡ estÃ¡ sendo editado por outra pessoa.");
    			
                pInfo[playerid][pEditandoBareira] = i;

				if(!IsValidDynamicObject(br_info[i][cadeObject])) return SendErrorMessage(playerid, "ERRO #1 - Ocorreu um erro ao editar este objeto. Motivo: Objeto invÃ¡lido.");
				br_info[i][beditando] = true;
            	EditDynamicObject(playerid, br_info[i][cadeObject]);
				return true;
    		}
    	}
    }
    return true;
}

public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
    if ((response) && (extraid == MODEL_LSPD_BARREIRAS))
	{
	    static
            Float:fX,
            Float:fY,
            Float:fZ,
            Float:fA;

		new world = GetPlayerVirtualWorld(playerid);

        GetPlayerPos(playerid, fX, fY, fZ);
        GetPlayerFacingAngle(playerid, fA);
    
        for (new i = 0; i != MAX_BARRICADES; i ++) if (!br_info[i][cadeExists])
        {
            br_info[i][cadeExists] = true;
            br_info[i][cadeType] = 2;

            br_info[i][cadePos][0] = fX;
            br_info[i][cadePos][1] = fY;
            br_info[i][cadePos][2] = fZ;

            br_info[i][cadeModel] = modelid;

            br_info[i][cadeObject] = CreateDynamicObject(br_info[i][cadeModel], fX, fY, fZ, 0.0, 0.0, fA, world);
            SetPlayerPos(playerid, fX + 2, fY + 2, fZ + 2);
            br_info[i][cadeWorld] = world;

            SendClientMessage(playerid, VERDE, "(Barreira):{FFFFFF} VocÃª colocou uma barreira.");

            pInfo[playerid][pEditandoBareira] = i;
			if(!IsValidDynamicObject(br_info[i][cadeObject])) return SendErrorMessage(playerid, "ERRO #1 - Ocorreu um erro ao editar este objeto. Motivo: Objeto invÃ¡lido.");
            br_info[i][beditando] = true;
            EditDynamicObject(playerid, br_info[i][cadeObject]);
            pInfo[playerid][pEditandoBareira] = -1;
            return true;
        }
        SendErrorMessage(playerid, "(Barreira):{FFFFFF} O servidor atingiu o limite de barreiras spawnadas.");
	}
    return true;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(response == 0) {
        if(pInfo[playerid][pEditandoBareira] != -1){
            new id = pInfo[playerid][pEditandoBareira];
            if(IsValidDynamicObject(br_info[id][cadeObject]))
                DestroyDynamicObject(br_info[id][cadeObject]);

            br_info[id][beditando] = false;

            SendErrorMessage(playerid,"(Barreira):{FFFFFF} Edição da barreira foi cancelada.");
        }
        return true;
    }
   	if (response == 1){
        if(pInfo[playerid][pEditandoBareira] != -1)
        {
            new id = pInfo[playerid][pEditandoBareira];
	        if(IsPlayerInRangeOfPoint(playerid, 10, x, y, z)){
                br_info[id][cadePos][0] = x;
                br_info[id][cadePos][1] = y;
                br_info[id][cadePos][2] = z;
		        pInfo[playerid][pEditandoBareira] = -1;

		        DestroyDynamicObject(br_info[id][cadeObject]);
		        br_info[id][cadeObject] = CreateDynamicObject(br_info[id][cadeModel], x, y, z, rx, ry, rz, br_info[id][cadeWorld]);

		        SendClientMessage(playerid, VERDE, "(Barreira):{FFFFFF} Barreira editada com sucesso.");
		        return true;
            }   
            else{
                if(IsValidDynamicObject(br_info[id][cadeObject]))
                    DestroyDynamicObject(br_info[id][cadeObject]);

                br_info[id][beditando] = false;
                SendErrorMessage(playerid,"(Barreira):{FFFFFF} VocÃª não pode por a barreira tão distante de vocÃª.");
            }
		}            
    }
    return true;
}