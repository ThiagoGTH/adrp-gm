#include <YSI_Coding\y_hooks>

CMD:config(playerid, params[]){
    

    return true;
}

CMD:nametag1(playerid, params[]){
    pInfo[playerid][pNametagType] = 0;
    return true;
}

CMD:nametag2(playerid, params[]){
    pInfo[playerid][pNametagType] = 1;
    return true;
}