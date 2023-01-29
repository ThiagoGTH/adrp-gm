#include <YSI_Coding\y_hooks>

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {

    new Float:oldX, Float:oldY, Float:oldZ,
	Float:oldRotX, Float:oldRotY, Float:oldRotZ;
	GetDynamicObjectPos(objectid, oldX, oldY, oldZ);
	GetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

    if(response == 0) {
        if (pInfo[playerid][pEditDropped] != -1 && DroppedItems[pInfo[playerid][pEditDropped]][droppedObject] == objectid) {
			SetDynamicObjectPos(DroppedItems[pInfo[playerid][pEditDropped]][droppedObject], oldX, oldY, oldZ);
			SetDynamicObjectRot(DroppedItems[pInfo[playerid][pEditDropped]][droppedObject], oldRotX, oldRotY, oldRotZ);
			SendErrorMessage(playerid, "Você cancelou a edição do seu item dropado, ele foi colocado na posição anterior.");
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][0] = oldX;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][1] = oldY;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][2] = oldZ;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][3] = oldRotX;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][4] = oldRotY;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][5] = oldRotZ;
			pInfo[playerid][pEditDropped] = 0;
		}
    } else if(response == 1) {
        if (pInfo[playerid][pEditDropped] != -1 && DroppedItems[pInfo[playerid][pEditDropped]][droppedObject] == objectid) {
			SetDynamicObjectPos(DroppedItems[pInfo[playerid][pEditDropped]][droppedObject], x, y, z);
			SetDynamicObjectRot(DroppedItems[pInfo[playerid][pEditDropped]][droppedObject], rx, ry, rz);
			SendClientMessage(playerid, -1, "Você ajustou com sucesso seu item dropado.");
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][0] = x;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][1] = y;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][2] = z;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][3] = rx;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][4] = ry;
			DroppedItems[pInfo[playerid][pEditDropped]][droppedPos][5] = rz;

            mysql_format(DBConn, query, sizeof query, "UPDATE `items_dropped` SET \
            `item_positionX` = '%.4f',  \
            `item_positionY` = '%.4f',  \
            `item_positionZ` = '%.4f',  \
            `item_positionRX` = '%.4f', \
            `item_positionRY` = '%.4f', \
            `item_positionRZ` = '%.4f' WHERE `item_id` = '%d'", x, y, z, rx, ry, rz, DroppedItems[pInfo[playerid][pEditDropped]][droppedID]);
            new Cache:result = mysql_query(DBConn, query);
            cache_delete(result);
			pInfo[playerid][pEditDropped] = -1;
		}
    }
    return true;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {
	if (newkeys & KEY_NO && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK) {
			static string[512];
		    new count = 0, id = Item_Nearest(playerid);
		    if (id != -1) {
				string = "";
		        for (new i = 0; i < MAX_DROPPED_ITEMS; i ++) {
		        	if (count < MAX_LISTED_ITEMS && DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 5.0, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]) && GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld]) {
				        NearestItems[playerid][count++] = i;
						new itemid = DroppedItems[i][droppedItem];
					    new finalstr[64];
						if(DroppedItems[i][droppedModel] == -6000){
							format(finalstr, sizeof(finalstr), "Dinheiro (US$ %s)", FormatNumber(DroppedItems[i][droppedQuantity]));
							strcat(string, finalstr);
							strcat(string, "\n");
						} else {
							format(finalstr, sizeof(finalstr), "%s (%d)", diInfo[itemid][diName], DroppedItems[i][droppedQuantity]);
							strcat(string, finalstr);
							strcat(string, "\n");
						}
				    }
			    }
		    }
	  	 	if (count == 1) {
				/*if(itemid != -1 && GetPlayerHandStatus(playerid) != HANDS_CLEAN && g_aInventoryItems[itemid][e_InventoryHeavyItem])
		    		return SendErrorMessage(playerid, "Você está com as mãos ocupadas.");*/

				if (DroppedItems[id][droppedWeapon] != 0) {
				    /*if (pInfo[playerid][pScore] < 2)
						return SendErrorMessage(playerid, "Você deve possuir pelo menos level dois.");*/

					if (uInfo[playerid][uNewbie] == 1337) return SendErrorMessage(playerid, "Você não pode ter armas pois é novato.");

		   			GiveWeaponToPlayer(playerid, DroppedItems[id][droppedWeapon], DroppedItems[id][droppedAmmo]);

		   			SendServerMessage(playerid, "Você pegou uma %s (%d) do chão.", ReturnWeaponName(DroppedItems[id][droppedWeapon]), DroppedItems[id][droppedAmmo]);
		                
		            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pega uma %s do chão.", pNome(playerid), ReturnWeaponName(DroppedItems[id][droppedWeapon]));

					format(logString, sizeof(logString), "%s (%s) pegou um(a) %s (%d) [SQL: %d] em %s (%.4f, %.4f, %.4f)", pNome(playerid), GetPlayerUserEx(playerid), ReturnWeaponName(DroppedItems[id][droppedWeapon]), DroppedItems[id][droppedAmmo], DroppedItems[id][droppedID], GetPlayerLocation(playerid), DroppedItems[id][droppedPos][0], DroppedItems[id][droppedPos][1], DroppedItems[id][droppedPos][2]);
        			logCreate(playerid, logString, 18);

					Item_Delete(id);
				}
				else if(DroppedItems[id][droppedModel] == -6000){
					new quantity = DroppedItems[id][droppedQuantity];

					SendServerMessage(playerid, "Você pegou US$ %s do chão.", FormatNumber(quantity));

					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pegou US$ %s do chão.", pNome(playerid), FormatNumber(quantity));

					format(logString, sizeof(logString), "%s (%s) pegou US$ %s [SQL: %d] em %s (%.4f, %.4f, %.4f)", pNome(playerid), GetPlayerUserEx(playerid), FormatNumber(quantity), DroppedItems[id][droppedID], GetPlayerLocation(playerid), DroppedItems[id][droppedPos][0], DroppedItems[id][droppedPos][1], DroppedItems[id][droppedPos][2]);
        			logCreate(playerid, logString, 18);
					GiveMoney(playerid, quantity);
					Item_Delete(id);
				}
				else if (PickupItem(playerid, id)) {
					new itemid = DroppedItems[id][droppedItem];
					new quantity = DroppedItems[id][droppedQuantity];

					SendServerMessage(playerid, "Você pegou o item %s (%d) do chão.", diInfo[itemid][diName], quantity);

					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pega o item \"%s\" do chão.", pNome(playerid), diInfo[itemid][diName]);

					format(logString, sizeof(logString), "%s (%s) pegou um(a) %s (%d) [SQL: %d] em %s (%.4f, %.4f, %.4f)", pNome(playerid), GetPlayerUserEx(playerid), diInfo[itemid][diName], quantity, DroppedItems[id][droppedID], GetPlayerLocation(playerid), DroppedItems[id][droppedPos][0], DroppedItems[id][droppedPos][1], DroppedItems[id][droppedPos][2]);
        			logCreate(playerid, logString, 18);

					Item_Delete(id);
				} else SendErrorMessage(playerid, "Você não possui nenhum slot disponível no inventário.");
			}
			else Dialog_Show(playerid, PickupItems, DIALOG_STYLE_LIST, "Pegar Itens", string, "Pegar", "Cancelar");	
		}
	}
    return true;
}