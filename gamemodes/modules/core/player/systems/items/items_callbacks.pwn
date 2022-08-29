#include <YSI_Coding\y_hooks>

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {

    new Float:oldX, Float:oldY, Float:oldZ,
	Float:oldRotX, Float:oldRotY, Float:oldRotZ;
	GetDynamicObjectPos(objectid, oldX, oldY, oldZ);
	GetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

    if(response == EDIT_RESPONSE_CANCEL) {
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
    } else if(response == EDIT_RESPONSE_FINAL) {
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

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
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
						format(finalstr, sizeof(finalstr), "%s", diInfo[itemid][diName]);
					    strcat(string, finalstr);
					    strcat(string, "\n");
				    }
			    }
		    }
	  	 	if (count == 1) {
		        new itemid = DroppedItems[id][droppedItem];
					
				/*if(itemid != -1 && GetPlayerHandStatus(playerid) != HANDS_CLEAN && g_aInventoryItems[itemid][e_InventoryHeavyItem])
		    		return SendErrorMessage(playerid, "Você está com as mãos ocupadas.");*/

				if (DroppedItems[id][droppedWeapon] != 0) {
				        if (PlayerData[playerid][pLevel] < 2)
							return SendErrorMessage(playerid, "Você deve possuir pelo menos level 2.");

						if (PlayerData[playerid][pNewbie] == 1337)
								return SendErrorMessage(playerid, "Você não pode ter armas pois é novato.");

		   				GiveWeaponToPlayer(playerid, DroppedItems[id][droppedWeapon], DroppedItems[id][droppedAmmo]);

		   				SendClientMessageEx(playerid, -1, "SERVER: Você pegou uma %s (%d) do chão.", ReturnWeaponName(DroppedItems[id][droppedWeapon]), DroppedItems[id][droppedAmmo]);
		                
		                SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pega uma %s do chão.", ReturnName(playerid, 0), ReturnWeaponName(DroppedItems[id][droppedWeapon]));
	                    new log[128];
						format(log, sizeof(log), "%s (%s) pegou um(a) %s (%d) (SQL: %d).", ReturnName(playerid, 0), PlayerData[playerid][pIP], ReturnWeaponName(DroppedItems[id][droppedWeapon]), DroppedItems[id][droppedAmmo], DroppedItems[id][droppedID]);
						LogSQL_Create(playerid, log, 10);

						Item_Delete(id);
					}
					else if (PickupItem(playerid, id))
					{
						new item_name[64];
						format(item_name, sizeof(item_name), "%s", DroppedItems[id][droppedItem]);
						new quantity = DroppedItems[id][droppedQuantity];
		    	
						if(!IsContainerItem(DroppedItems[id][droppedItem]))
							Item_Delete(id);

						SendClientMessageEx(playerid, -1, "SERVER: Você pegou o item %s (%d) do chão.", item_name, quantity);

						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pega o item \"%s\" do chão.", ReturnName(playerid, 0), item_name);
						new log[128];
						format(log, sizeof(log), "%s (%s) pegou um(a) %s em %s.", ReturnName(playerid, 0), PlayerData[playerid][pIP], item_name, GetPlayerLocation(playerid));
						LogSQL_Create(playerid, log, 10);
					}
					else
						SendErrorMessage(playerid, "Você não possui nenhum slot disponível no inventário.");
				}
				else Dialog_Show(playerid, PickupItems, DIALOG_STYLE_LIST, "Pegar Itens", string, "Pegar", "Cancelar");
			}
		}
	}
    return true;
}