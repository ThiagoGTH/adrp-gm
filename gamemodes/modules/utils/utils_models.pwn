#include <YSI_Coding\y_hooks>

#if !defined DOWNLOAD_REQUEST
	#define DOWNLOAD_REQUEST: _:
#endif

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc) {
	if(!IsPlayerConnected(playerid))
		return false;

	InterpolateCameraPos(playerid, 1307.082153, -1441.499755, 221.137145, 1307.082153, -1441.499755, 221.137145, 1000);
    InterpolateCameraLookAt(playerid, 1311.717285, -1439.645874, 220.856262, 1311.717285, -1439.645874, 220.856262, 1000);

	return true;
}

enum MODEL_TYPES {
	MODEL_TYPE_NONE,		//0
	MODEL_TYPE_LANDMASSES,	//1
	MODEL_TYPE_BUILDINGS,	//2
	MODEL_TYPE_OBJECTS,		//3
	MODEL_TYPE_VEGETATION,	//4
	MODEL_TYPE_INTERIORS,	//5
	MODEL_TYPE_2DFX			//6
};

enum E_MODELS_INFO
{
	bool:StaticObject,
	Float:ObjectStreamDistance,
	ObjectPriority
};

new ObjectsInfo[_:MODEL_TYPES][E_MODELS_INFO] =
{
	{false,	300.0,	1},	//0 none
	{true,	1000.0,	6},	//1 landmasses
	{true,	800.0,	5},	//2 buildings
	{false,	300.0,	4},	//3 objects
	{false,	300.0,	3},	//4 vegetation
	{false,	200.0,	2},	//5 interiors
	{false,	200.0,	1}	//6 2dfx
};

FindModelIDForFlags(flags) {
	if (flags == 0) return 19353;
	else return flags;
}

AddSimpleModelEx(flags, newmodelid, const dffname[], const txdname[], timeon = 0, timeoff = 0) {
	new dffpath[256], txdpath[256];
	format(dffpath, 256, "%s", dffname);
	format(txdpath, 256, "%s", txdname);
	if(timeon == 0 && timeoff == 0) AddSimpleModel(-1, FindModelIDForFlags(flags), newmodelid, dffpath, txdpath);
	else AddSimpleModelTimed(-1, FindModelIDForFlags(flags), newmodelid, dffpath, txdpath, timeon, timeoff);
	return true;
}

CreateModelObject(MODEL_TYPES:model_type, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, world = -1, interior = -1) {
	new objectid = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, world, interior, .streamdistance = ObjectsInfo[_:model_type][ObjectStreamDistance] + 50.0, .drawdistance = ObjectsInfo[_:model_type][ObjectStreamDistance], .priority = ObjectsInfo[_:model_type][ObjectPriority]);
	if(ObjectsInfo[_:model_type][StaticObject]) Streamer_ToggleItemStatic(STREAMER_TYPE_OBJECT, objectid, true);
	return objectid;
}

hook OnGameModeInit(){
    LoadInterfaces();
	LoadObjects();
	LoadPets();
	LoadItemsModels();
    return true;
}

LoadObjects(){
	AddSimpleModelEx(0, -1000, "objects/trailers/trailer1.dff", "objects/trailers/trailer1.txd");
}

LoadInterfaces(){ // -9000 +
	AddSimpleModelEx(0, -9000, "interface/interface.dff", "interface/interface.txd");
	AddSimpleModelEx(0, -9001, "interface/interface.dff", "interface/notify.txd");
	AddSimpleModelEx(0, -9002, "interface/interface.dff", "interface/news.txd");
	AddSimpleModelEx(0, -9003, "interface/interface.dff", "interface/slot_machine.txd");
	AddSimpleModelEx(0, -9004, "interface/interface.dff", "interface/speedo.txd");
	AddSimpleModelEx(0, -9005, "interface/interface.dff", "interface/icons.txd");
}