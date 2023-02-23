#include <YSI_Coding\y_hooks>

forward LoadBankers();
public LoadBankers() {
	
	new rows = cache_num_rows();
	if(rows) {
	    new id, label_string[64];
	    for(new i; i < rows; i++) {
		    cache_get_value_name_int(i, "ID", id);
		    cache_get_value_name_int(i, "Skin", BankerData[id][Skin]);
		    cache_get_value_name_float(i, "PosX", BankerData[id][bankerX]);
		    cache_get_value_name_float(i, "PosY", BankerData[id][bankerY]);
		    cache_get_value_name_float(i, "PosZ", BankerData[id][bankerZ]);
		    cache_get_value_name_float(i, "PosA", BankerData[id][bankerA]);
            cache_get_value_name_int(i, "Interior", BankerData[id][bankerInterior]);
            cache_get_value_name_int(i, "VirtualWorld", BankerData[id][bankerVW]);

		    BankerData[id][bankerActorID] = CreateActor(BankerData[id][Skin], BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);
		    if(!IsValidActor(BankerData[id][bankerActorID])) {
				printf("BANK SYSTEM: Não foi possível criar o ator do bancário ID %d.", id);
			} else {
			    SetActorInvulnerable(BankerData[id][bankerActorID], true); 
                SetActorVirtualWorld(BankerData[id][bankerActorID], BankerData[id][bankerVW]);
			}

			format(label_string, sizeof(label_string), "Bancário (%d)\n\n{FFFFFF}Use {F1C40F}/banco", id);
			BankerData[id][bankerLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ] + 0.25, 1.0, .testlos = 1);

			Iter_Add(Bankers, id);
		}
	}
	printf("BANK SYSTEM: %d bancários carregados.", Iter_Count(Bankers));
	return true;
}

forward LoadATMs();
public LoadATMs() {
	new rows = cache_num_rows();
	if(rows) {
	    new id, label_string[64];
	    
	    for(new i; i < rows; i++) {
		    cache_get_value_name_int(i, "ID", id);
	     	cache_get_value_name_float(i, "PosX", ATMData[id][atmX]);
	     	cache_get_value_name_float(i, "PosY", ATMData[id][atmY]);
	     	cache_get_value_name_float(i, "PosZ", ATMData[id][atmZ]);
	     	cache_get_value_name_float(i, "RotX", ATMData[id][atmRX]);
	     	cache_get_value_name_float(i, "RotY", ATMData[id][atmRY]);
	     	cache_get_value_name_float(i, "RotZ", ATMData[id][atmRZ]);

		    ATMData[id][atmObjID] = CreateDynamicObject(19324, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);

			if(!IsValidDynamicObject(ATMData[id][atmObjID])) printf("BANK SYSTEM: Não foi possível criar o objeto do ATM ID %d.", id);

			format(label_string, sizeof(label_string), "ATM (%d)\n\n{FFFFFF}Use {F1C40F}/atm", id);
			ATMData[id][atmLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ] + 0.85, 1.0, .testlos = 1);

			Iter_Add(ATMs, id);
		}
	}
    printf("BANK SYSTEM: %d ATMs carregados.", Iter_Count(ATMs));
	return true;
}