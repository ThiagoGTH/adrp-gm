#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    AddSimpleModelEx(8674, -1107, "maps/env/ls_freeway/LosSantosFreeway1.dff", "maps/env/ls_freeway/LosSantosFreeway1.txd");
    CreateModelObject(MODEL_TYPE_2DFX, -1107,1624.6650390,-1833.9570310,28.7280000,0.0000000,0.0000000,15.0000110);
    return true;
}
