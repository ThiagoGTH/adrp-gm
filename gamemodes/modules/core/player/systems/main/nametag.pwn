#include <YSI_Coding\y_hooks>
 
#define NT_DISTANCE 15.0
  
hook OnGameModeInit(){
    ShowNameTags(false);
    //SetNameTagDrawDistance(15.0);
    SetTimer("UpdateNametag", 1000, true);
    return true;
}

static GetHealthDots(playerid){
    new
        dots[64], Float: HP;

    GetPlayerHealth(playerid, HP);
 
    if(HP >= 100)
        dots = "••••••••••";
    else if(HP >= 90)
        dots = "•••••••••{660000}•";
    else if(HP >= 80)
        dots = "••••••••{660000}••";
    else if(HP >= 70)
        dots = "•••••••{660000}•••";
    else if(HP >= 60)
        dots = "••••••{660000}••••";
    else if(HP >= 50)
        dots = "•••••{660000}•••••";
    else if(HP >= 40)
        dots = "••••{660000}••••••";
    else if(HP >= 30)
        dots = "•••{660000}•••••••";
    else if(HP >= 20)
        dots = "••{660000}••••••••";
    else if(HP >= 10)
        dots = "•{660000}•••••••••";
    else if(HP >= 0)
        dots = "{660000}••••••••••";
 
    return dots;
}

static GetArmorDots(playerid){
    new
        dots[64], Float: AR;
 
    GetPlayerArmour(playerid, AR);
 
    if(AR >= 100)
        dots = "••••••••••";
    else if(AR >= 90)
        dots = "•••••••••{666666}•";
    else if(AR >= 80)
        dots = "••••••••{666666}••";
    else if(AR >= 70)
        dots = "•••••••{666666}•••";
    else if(AR >= 60)
        dots = "••••••{666666}••••";
    else if(AR >= 50)
        dots = "•••••{666666}•••••";
    else if(AR >= 40)
        dots = "••••{666666}••••••";
    else if(AR >= 30)
        dots = "•••{666666}•••••••";
    else if(AR >= 20)
        dots = "••{666666}••••••••";
    else if(AR >= 10)
        dots = "•{666666}•••••••••";
    else if(AR >= 0)
        dots = "{666666}••••••••••";
 
    return dots;
}
 
hook OnPlayerConnect(playerid){
    pInfo[playerid][pNametag] = CreateDynamic3DTextLabel("Carregando nametag...", 0xFFFFFFFF, 0.0, 0.0, 0.2, NT_DISTANCE, .attachedplayer = playerid, .testlos = 1);
    pInfo[playerid][pESC] = 0;
    return true;
}

hook OnPlayerUpdate(playerid){
    pInfo[playerid][pESC] = GetTickCount();
    return true;
}

hook OnPlayerDisconnect(playerid, reason){
    if(IsValidDynamic3DTextLabel(pInfo[playerid][pNametag]))
        DestroyDynamic3DTextLabel(pInfo[playerid][pNametag]);
    return true;
}

forward UpdateNametag();
public UpdateNametag(){
    for(new i = 0, j = MAX_PLAYERS; i <= j; i++){
        if(IsPlayerConnected(i)){
            new nametag[128], Float:armour;
            GetPlayerArmour(i, armour);
            if(IsPlayerMinimized(i)){
                if(armour > 1.0) format(nametag, sizeof(nametag), "{858585}%s (%i){FFFFFF}\n{FFFFFF}%s\n{FF0000}%s", pNome(i), i, GetArmorDots(i), GetHealthDots(i));
                else format(nametag, sizeof(nametag), "{858585}%s (%i){FFFFFF}\n{FF0000}%s", pNome(i), i, GetHealthDots(i));
            }else{
                if(armour > 1.0) format(nametag, sizeof(nametag), "{%06x}%s (%i){FFFFFF}\n{FFFFFF}%s\n{FF0000}%s", GetPlayerColor(i) >>> 8, pNome(i), i, GetArmorDots(i), GetHealthDots(i));
                else format(nametag, sizeof(nametag), "{%06x}%s (%i){FFFFFF}\n{FF0000}%s", GetPlayerColor(i) >>> 8, pNome(i), i, GetHealthDots(i));
            }
            UpdateDynamic3DTextLabelText(pInfo[i][pNametag], 0xFFFFFFFF, nametag);
        }
    }
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart){
    if(IsPlayerConnected(playerid)){
        new nametag[128], Float:armour;
        GetPlayerArmour(playerid, armour);
        if(armour > 1.0)
            format(nametag, sizeof(nametag), "{FF0000}%s (%i){FFFFFF}\n{FFFFFF}%s\n{FF0000}%s", pNome(playerid), playerid, GetArmorDots(playerid), GetHealthDots(playerid));
        else  format(nametag, sizeof(nametag), "{FF0000}%s (%i){FFFFFF}\n{FF0000}%s", pNome(playerid), playerid, GetHealthDots(playerid));
        UpdateDynamic3DTextLabelText(pInfo[playerid][pNametag], 0xFFFFFFFF, nametag);
    }
    return true;
}