#include <YSI_Coding\y_hooks>

GetFactionType(playerid) {
	if (pInfo[playerid][pFaction] == -1)
	    return false;

	return (FactionData[pInfo[playerid][pFaction]][factionType]);
}

GetFactionTypeID(type){
    new name[64];
    switch(type){
        case 1: format(name, 64, "Policial");
        case 2: format(name, 64, "Midiática");
        case 3: format(name, 64, "Médica");
        case 4: format(name, 64, "Prefeitura");
        case 5: format(name, 64, "Governamental");
        case 6: format(name, 64, "Civil");
        case 7: format(name, 64, "Criminal");
        default: format(name, 64, "Inválido");
    }
    return name;
}

SetFactionColor(playerid) {
	new factionid = pInfo[playerid][pFaction];

	if (factionid != -1)
		return SetPlayerColor(playerid, RemoveAlpha(FactionData[factionid][factionColor]));

	return false;
}

RemoveAlpha(color) {
    return (color & ~0xFF);
}