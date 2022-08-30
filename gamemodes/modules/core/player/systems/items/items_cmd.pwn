#include <YSI_Coding\y_hooks>

CMD:resetarinventario(playerid, params[]) {

    return true;
}

// PLAYER
CMD:inv(playerid, params[]) {
    ShowPlayerInventory(playerid);
    return true;
} alias:inv("i", "inventario")