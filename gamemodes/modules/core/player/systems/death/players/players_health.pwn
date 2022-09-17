#define MIN_PLAYER_HEALTH   (0.0)
#define MAX_PLAYER_HEALTH   (150.0)

#define MIN_BW_HEALTH       (5.0)

#include <YSI_Coding\y_hooks>

hook function SetPlayerHealth(playerid, Float:health) {
    new Float:oldHealth;
    GetPlayerHealth(playerid, oldHealth);

    new Float:newHealth = oldHealth + health;
    if (newHealth > MAX_PLAYER_HEALTH) newHealth = MAX_PLAYER_HEALTH;
    else if (newHealth < MIN_PLAYER_HEALTH) newHealth = MIN_PLAYER_HEALTH;

    if(newHealth <= MIN_BW_HEALTH) newHealth = MIN_BW_HEALTH;
    return continue(playerid, newHealth);
}