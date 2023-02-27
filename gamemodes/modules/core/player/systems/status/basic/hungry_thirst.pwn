#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    SetTimer("HungryThistyCheck", 5000, true);//1s
	return true;
}

forward HungryThistyCheck();
public HungryThistyCheck() {
    foreach (new i : Player) {
        static Float: health;
        GetPlayerHealth(i, health);
        if (++ pInfo[i][pHungerTime] >= 600) {
			if (pInfo[i][pHunger] > 0) pInfo[i][pHunger]--;
	    	else if (pInfo[i][pHunger] <= 0) SetPlayerHealthEx(i, health - 10);

	        pInfo[i][pHungerTime] = 0;
	    }
		if (++ pInfo[i][pThirstTime] >= 540) {
			if (pInfo[i][pThirst] > 0) pInfo[i][pThirst]--;
			else if (pInfo[i][pThirst] <= 0) SetPlayerHealthEx(i, health - 5);
	        
            pInfo[i][pThirstTime] = 0;
		}
	}
}