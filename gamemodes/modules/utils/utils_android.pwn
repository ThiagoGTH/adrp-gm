#include <YSI_Players\y_android>

public OnAndroidCheck(playerid, bool:isDisgustingThiefToBeBanned) {
    if (isDisgustingThiefToBeBanned) {
        SendErrorMessage(playerid, "Voc� n�o pode se conectar no Advanced Roleplay atrav�s de um celular.");
        KickEx(playerid);
    }
}