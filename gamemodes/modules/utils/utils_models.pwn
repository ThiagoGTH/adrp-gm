#include <YSI_Coding\y_hooks>

public OnPlayerRequestDownload(playerid, type, crc) {
	if(!IsPlayerConnected(playerid))
		return false;

	InterpolateCameraPos(playerid, 1307.082153, -1441.499755, 221.137145, 1307.082153, -1441.499755, 221.137145, 1000);
    InterpolateCameraLookAt(playerid, 1311.717285, -1439.645874, 220.856262, 1311.717285, -1439.645874, 220.856262, 1000);

	return true;
}

new modelflags_flags[68] = {0,2097152,4,2097156,2097284,2097220,2097280,128,68,5,132,2,2048,64,140,2176,2099328,2097348,
196,1,129,8321,192,4100,4096,8192,32896,2162816,2130052,32900,2130048,32768,1048580,32,160,164,2097184,262148,65536,69,
2097157,2180,2097153,130,8196,131072,1024,1028,516,8324,2105476,2105348,12420,4194304,2098180,2098244,6,640,2146436,2113668,
2113540,2113536,2129924,2138244,2138116,2109572,2146308,2101248};

new modelflags_index[68] = {18631,18636,18637,18656,18783,19197,19489,19490,19605,19628,19857,11089,11102,11306,11324,8948,
9099,16013,16448,12800,13116,13273,17978,990,994,17040,1223,1225,1278,1306,1315,1350,1490,1491,1492,1493,1533,14547,14570,
4596,6489,6517,5750,3781,3948,2969,3034,1649,1651,800,881,882,904,2756,3850,3857,13595,8197,620,624,629,649,658,670,693,738,
739,1138};

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
	flags &= 0xFFFFFFDF;

	new x=0;
	while(x!=68) {
		if(modelflags_flags[x] == flags) return modelflags_index[x];
		x++;
	}
	return 19353;
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
}