#define BODY_PART_CHEST	        (3)
#define BODY_PART_GROIN         (4)
#define BODY_PART_LEFT_ARM      (5)
#define BODY_PART_RIGHT_ARM     (6)
#define BODY_PART_LEFT_LEG      (7)
#define BODY_PART_RIGHT_LEG     (8)
#define BODY_PART_HEAD          (9)

#define MAX_PLAYER_DAMAGES      (100)

enum damageInfo
{
	eDamageTaken,
	eDamageTime,

	eDamageWeapon,

	eDamageBodypart,
	eDamageArmor,

	eDamageBy,
};

new DamageInfo[MAX_PLAYERS][MAX_PLAYER_DAMAGES][damageInfo];

CallbackDamages(playerid, issuerid, bodypart, weaponid, Float:amount){
    new id,
        Float: armour;

    pInfo[playerid][pTotalDamages] ++;

    for(new i = 0; i < 100; i++){
		if(!DamageInfo[playerid][i][eDamageTaken]){
			id = i;
			break;
		}
	}
    GetPlayerArmour(playerid, armour);

    if(armour > 1 && bodypart == BODY_PART_CHEST)
		DamageInfo[playerid][id][eDamageArmor] = 1;

	else DamageInfo[playerid][id][eDamageArmor] = 0;

    DamageInfo[playerid][id][eDamageTaken] = floatround(amount, floatround_round);
	DamageInfo[playerid][id][eDamageWeapon] = weaponid;

	DamageInfo[playerid][id][eDamageBodypart] = bodypart;
	DamageInfo[playerid][id][eDamageTime] = gettime();

	DamageInfo[playerid][id][eDamageBy] = pInfo[issuerid][pID];
    return true;
}

ShowPlayerDamages(damageid, playerid, view){
    new caption[33],
        str[1024];
        //longstr[1200];

	if(pInfo[damageid][pTotalDamages] <= 0) format(caption, sizeof(caption), "%s — nenhum ferimento", pNome(damageid));
	else if (pInfo[damageid][pTotalDamages] == 1) format(caption, sizeof(caption), "%s — %d ferimento", pNome(damageid), pInfo[damageid][pTotalDamages]);
	else format(caption, sizeof(caption), "%s — %d ferimentos", pNome(damageid), pInfo[damageid][pTotalDamages]);

    if (pInfo[damageid][pTotalDamages] < 1)
		return Dialog_Show(playerid, damagesDialog, DIALOG_STYLE_LIST, caption, "Não existe nenhum dano para mostrar.", "Fechar", "");
    
    switch(view) {
        case 0:
        {
			format(str, sizeof(str), "Parte do corpo\tArma\tTempo\tDano\n");
            for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;

				format(str, sizeof(str), "%s%s\t%s\t%ds\t%d\n", str,
				ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), 
				ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), 
				gettime() - DamageInfo[damageid][i][eDamageTime],
				DamageInfo[damageid][i][eDamageTaken]);
				//strcat(longstr, str);
            }
			Dialog_Show(playerid, damagesDialog, DIALOG_STYLE_TABLIST_HEADERS, caption, str, "Fechar", "");
        }
        case 1:
        {
			format(str, sizeof(str), "Parte do corpo\tArma\tTempo\tDano\n");
            for(new i = 0; i < 100; i ++)
			{
                if(!DamageInfo[damageid][i][eDamageTaken])
                    continue;

				format(str, sizeof(str), "%s%s\t%s\t%ds\t%d\n", str,
				ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), 
				ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), 
				pNome(DamageInfo[damageid][i][eDamageBy]),
				gettime() - DamageInfo[damageid][i][eDamageTime],
				DamageInfo[damageid][i][eDamageTaken]);
				//strcat(longstr, str);
            }
            Dialog_Show(playerid, damagesDialog, DIALOG_STYLE_TABLIST_HEADERS, caption, str, "Fechar", "");
        } 
    }
    return true;
}

ClearDamages(playerid){
    SetPlayerChatBubble(playerid, " ", COLOR_WHITE, 10.0, 100);

    pInfo[playerid][pLimping] = false;
    pInfo[playerid][pLimpingTime] = 0;

	for(new i = 0; i < 100; i++){
		DamageInfo[playerid][i][eDamageTaken] = 0;
		DamageInfo[playerid][i][eDamageBy] = 0;

		DamageInfo[playerid][i][eDamageArmor] = 0;
		DamageInfo[playerid][i][eDamageBodypart] = 0;

		DamageInfo[playerid][i][eDamageTime] = 0;
		DamageInfo[playerid][i][eDamageWeapon] = 0;
	}
	return true;
}

ReturnBodypartName(bodypart){
	new bodyname[20];
	switch(bodypart){
		case BODY_PART_CHEST:bodyname = "Peito";
		case BODY_PART_GROIN:bodyname = "Virilha";
		case BODY_PART_LEFT_ARM:bodyname = "Braço esquerdo";
		case BODY_PART_RIGHT_ARM:bodyname = "Braço direito";
		case BODY_PART_LEFT_LEG:bodyname = "Perna esquerda";
		case BODY_PART_RIGHT_LEG:bodyname = "Perna direita";
		case BODY_PART_HEAD:bodyname = "Cabeça";
	}
	return bodyname;
}