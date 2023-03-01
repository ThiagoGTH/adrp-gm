#include <YSI_Players\y_android>

public OnAndroidCheck(playerid, bool:isDisgustingThiefToBeBanned) {
    if (isDisgustingThiefToBeBanned) {
        SendErrorMessage(playerid, "Você não pode se conectar no Advanced Roleplay através de um celular.");
        KickEx(playerid);
    }
}