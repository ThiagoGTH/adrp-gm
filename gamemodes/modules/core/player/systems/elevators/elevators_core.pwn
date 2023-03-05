#if !defined _ELEVATOR_MOVE_SPEED
    #define _ELEVATOR_MOVE_SPEED 5.0
#endif
#if !defined MAX_ELEVATORS
    #define MAX_ELEVATORS 5
#endif
#if !defined MAX_FLOOR_ELEVATOR
    #define MAX_FLOOR_ELEVATOR 22
#endif

enum _elevator_enum {
    _ElevatorObj,
    _ElevatorPortR,
    _ElevatorPortL,
    Float:_ElevatorFloor[MAX_FLOOR_ELEVATOR],
    _ElevatorArea,
    _ElevatorOnFloor,
    _ElevatorDoorArea[MAX_FLOOR_ELEVATOR],
    _ElevatorDoorPortR[MAX_FLOOR_ELEVATOR],
    _ElevatorDoorPortL[MAX_FLOOR_ELEVATOR],
    bool:_ElevatorDoorOpened[MAX_FLOOR_ELEVATOR],
    _ElevatorName[32]
}   
static _ElevatorData[MAX_ELEVATORS][_elevator_enum];
static _ElevatorFloorName[MAX_ELEVATORS][MAX_FLOOR_ELEVATOR][32];

/*
native AddElevator(Float:posx, Float:posy, Float:posz, Float:ang, ElevatorName[] = "", Interior = -1, VirtualWorld = -1);
native IsValidElevator(elevatorid);
native DestroyElevator(elevatorid);
native GetElevatorName(elevatorid, &ElevatorName[], &size);
native GetElevatorPos(elevatorid, Float:x, Float:y, Float:z);
native GetElevatorOnFloor(elevatorid);
native AddFloorToElevator(elevatorid, Float:fz, floorname[], bool:IsOpen = false);
native CallElevatorToFloor(elevatorid, floorid);
native OpenPortsElevator(elevatorid);
native ClosePortsElevator(elevatorid);
native SelectFloorOnElevator(elevatorid, floorid);
native GetMaxFloorElevator(elevatorid);
native GetFloorNameForElevator(floorid, elevatorid, &floorname[], &size);
native IsPlayerInElevator(playerid, elevatorid);
native GetPlayerFrontElevator(playerid, elevatorid);
native GetElevatorPoolSize();
*/

stock IsValidElevator(elevatorid) return IsValidDynamicObject(_ElevatorData[elevatorid][_ElevatorObj]);
stock GetElevatorPoolSize() {
    new Counter=-1;
    for(new i; i < MAX_FLOOR_ELEVATOR; i++)
        if(IsValidElevator(elevatorid))
            Counter++;
    return Counter;
}

stock IsPlayerInElevator(playerid, elevatorid) return IsPlayerInDynamicArea(playerid, _ElevatorData[elevatorid][_ElevatorArea]);
stock GetPlayerFrontElevator(playerid, elevatorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    for(new doors; doors < MAX_FLOOR_ELEVATOR; doors++)
    {
        if(_ElevatorData[elevatorid][_ElevatorDoorArea][doors] != 0 && IsPlayerInDynamicArea(playerid, _ElevatorData[elevatorid][_ElevatorDoorArea][doors]))
            return doors;
    }   
    return -1;
}

stock GetElevatorPos(elevatorid, &Float:x, &Float:y, &Float:z) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    if(!IsValidElevator(elevatorid)) return false;
    return GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorObj], x, y, z);
}

stock GetElevatorOnFloor(elevatorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    if(!IsValidElevator(elevatorid)) return false;
    return _ElevatorData[elevatorid][_ElevatorOnFloor];
}

stock AddElevator(Float:x, Float:y, Float:z, Float:a, const ElevatorName[] = "", Interior = -1, VirtualWorld = -1) {
    new Obj = CreateDynamicObject(18755, x, y, z, 0.0, 0.0, a, VirtualWorld, Interior), Ports[2], Area, elevid=-1;
    Ports[0] = CreateDynamicObject(18757, x, y, z, 0.0, 0.0, a, VirtualWorld, Interior);
    Ports[1] = CreateDynamicObject(18756, x, y, z, 0.0, 0.0, a, VirtualWorld, Interior);
    Area = CreateDynamicRectangle(-1.79897, -2.13561, 2.04287,  2.02911, VirtualWorld, Interior);
    AttachDynamicAreaToObject(Area, Obj, STREAMER_OBJECT_TYPE_DYNAMIC, INVALID_PLAYER_ID, 0.0021, 0.1012, -1.9275);
    for(elevid=1; elevid < MAX_ELEVATORS; elevid++) 
    {
        if(_ElevatorData[elevid][_ElevatorObj] == 0)
        {
            _ElevatorData[elevid][_ElevatorObj] = Obj;
            _ElevatorData[elevid][_ElevatorPortR] = Ports[0];
            _ElevatorData[elevid][_ElevatorPortL] = Ports[1];
            _ElevatorData[elevid][_ElevatorArea] = Area;
            format(_ElevatorData[elevid][_ElevatorName], 32, ElevatorName);
            break;
        }
    }
    OpenPortsElevator(elevid);
    return elevid;
}

stock DestroyElevator(elevatorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    if(!IsValidDynamicObject(_ElevatorData[elevatorid][_ElevatorObj])) return false;
    DestroyDynamicObject(_ElevatorData[elevatorid][_ElevatorObj]);
    DestroyDynamicObject(_ElevatorData[elevatorid][_ElevatorPortR]);
    DestroyDynamicObject(_ElevatorData[elevatorid][_ElevatorPortL]);
    DestroyDynamicArea(_ElevatorData[elevatorid][_ElevatorArea]);
    _ElevatorData[elevatorid][_ElevatorFloor] = 0.0;
    for(new i; i < MAX_FLOOR_ELEVATOR; i++) {
        _ElevatorFloorName[elevatorid][i] = "";
        DestroyDynamicArea(_ElevatorData[elevatorid][_ElevatorDoorArea][i]);
        _ElevatorData[elevatorid][_ElevatorDoorArea][i] = 0;
        DestroyDynamicObject(_ElevatorData[elevatorid][_ElevatorDoorPortR][i]);
        DestroyDynamicObject(_ElevatorData[elevatorid][_ElevatorDoorPortL][i]);
    }
    _ElevatorData[elevatorid][_ElevatorObj] = _ElevatorData[elevatorid][_ElevatorPortR] = _ElevatorData[elevatorid][_ElevatorPortL] = 0;
    return true;
}

stock GetElevatorName(elevatorid, ElevatorName[], size) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    return format(ElevatorName, size, _ElevatorData[elevatorid][_ElevatorName]);
}

stock AddFloorToElevator(elevatorid, Float:fz, const floorname[], bool:IsOpen = false) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    for(new i; i < MAX_FLOOR_ELEVATOR; i++) {
        if(_ElevatorData[elevatorid][_ElevatorFloor][i] == 0.00) {
            _ElevatorData[elevatorid][_ElevatorFloor][i] = fz;
            format(_ElevatorFloorName[elevatorid][i], 32, floorname);
            new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, VirtualWorld, Interior; 
            GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorObj], x, y, z);
            GetDynamicObjectRot(_ElevatorData[elevatorid][_ElevatorObj], rx, ry, rz);
            VirtualWorld = Streamer_GetIntData(STREAMER_TYPE_OBJECT, _ElevatorData[elevatorid][_ElevatorObj], E_STREAMER_WORLD_ID);
            Interior = Streamer_GetIntData(STREAMER_TYPE_OBJECT, _ElevatorData[elevatorid][_ElevatorObj], E_STREAMER_INTERIOR_ID);
            // -3.8183, 0.1608, -1.9275                     
            _ElevatorData[elevatorid][_ElevatorDoorArea][i] = CreateDynamicSphere(x + (-3.5 * floatsin(-(rz - 90.0), degrees)), y + (-3.5 * floatcos(-(rz - 90.0), degrees)), fz - 1.92, 2.0, VirtualWorld, Interior);          
            _ElevatorData[elevatorid][_ElevatorDoorPortR][i] = CreateDynamicObject(18757, x + (0.26 * floatsin(-(rz + 90.0), degrees)), y + (0.26 * floatcos(-(rz + 90.0), degrees)), fz, 0.0, 0.0, rz, VirtualWorld, Interior);
            _ElevatorData[elevatorid][_ElevatorDoorPortL][i] = CreateDynamicObject(18756, x + (0.26 * floatsin(-(rz + 90.0), degrees)), y + (0.26 * floatcos(-(rz + 90.0), degrees)), fz, 0.0, 0.0, rz, VirtualWorld, Interior);
            if(IsOpen) 
            {
                CallElevatorToFloor(elevatorid, i);             
            }
            break;
        }
    }
    return true;
}

stock OpenDoorForFloor(elevatorid, floorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    if(floorid >= MAX_FLOOR_ELEVATOR) return false;
    if(_ElevatorData[elevatorid][_ElevatorDoorOpened]) return false; 
    new Float:x1, Float:y1, Float:z1, Float:rx1, Float:ry1, Float:rz1, Float:x2, Float:y2, Float:z2, Float:rx2, Float:ry2, Float:rz2;
    GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorDoorPortR][floorid], x1, y1, z1);
    GetDynamicObjectRot(_ElevatorData[elevatorid][_ElevatorDoorPortR][floorid], rx1, ry1, rz1);
    GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorDoorPortL][floorid], x2, y2, z2);
    GetDynamicObjectRot(_ElevatorData[elevatorid][_ElevatorDoorPortL][floorid], rx2, ry2, rz2);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorDoorPortR][floorid], x1 + (1.75 * floatsin(-(rz1 - 360.0), degrees)), y1 + (1.75 * floatcos(-(rz1 - 360.0), degrees)), z1, _ELEVATOR_MOVE_SPEED);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorDoorPortL][floorid], x2 + (1.75 * floatsin(-(rz2 - 180.0), degrees)), y2 + (1.75 * floatcos(-(rz2 - 180.0), degrees)), z2, _ELEVATOR_MOVE_SPEED);
    _ElevatorData[elevatorid][_ElevatorDoorOpened] = true;
    return true;
}

stock CloseDoorForFloor(elevatorid, floorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    if(floorid >= MAX_FLOOR_ELEVATOR) return false;
    if(!_ElevatorData[elevatorid][_ElevatorDoorOpened]) return false; 
    new Float:x1, Float:y1, Float:z1, Float:rx1, Float:ry1, Float:rz1, Float:x2, Float:y2, Float:z2, Float:rx2, Float:ry2, Float:rz2;
    GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorDoorPortR][floorid], x1, y1, z1);
    GetDynamicObjectRot(_ElevatorData[elevatorid][_ElevatorDoorPortR][floorid], rx1, ry1, rz1);
    GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorDoorPortL][floorid], x2, y2, z2);
    GetDynamicObjectRot(_ElevatorData[elevatorid][_ElevatorDoorPortL][floorid], rx2, ry2, rz2);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorDoorPortR][floorid], x1 - (1.75 * floatsin(-(rz1 - 360.0), degrees)), y1 - (1.75 * floatcos(-(rz1 - 360.0), degrees)), z1, _ELEVATOR_MOVE_SPEED);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorDoorPortL][floorid], x2 - (1.75 * floatsin(-(rz2 - 180.0), degrees)), y2 - (1.75 * floatcos(-(rz2 - 180.0), degrees)), z2, _ELEVATOR_MOVE_SPEED);
    _ElevatorData[elevatorid][_ElevatorDoorOpened] = false;
    return true;
}

stock CallElevatorToFloor(elevatorid, floorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    if(!IsValidElevator(elevatorid)) return false;
    if(IsDynamicObjectMoving(_ElevatorData[elevatorid][_ElevatorObj])) return false;
    ClosePortsElevator(elevatorid);
    CloseDoorForFloor(elevatorid, _ElevatorData[elevatorid][_ElevatorOnFloor]);
    return SetTimerEx("Timer_CallElevator", 1000, false, "dd", elevatorid, floorid);
}

forward Timer_CallElevator(elevatorid, floorid);
public Timer_CallElevator(elevatorid, floorid) {
    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorObj], x, y, z);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorObj], x, y, _ElevatorData[elevatorid][_ElevatorFloor][floorid], _ELEVATOR_MOVE_SPEED);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorPortR], x, y, _ElevatorData[elevatorid][_ElevatorFloor][floorid] - 0.04, _ELEVATOR_MOVE_SPEED);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorPortL], x, y, _ElevatorData[elevatorid][_ElevatorFloor][floorid] - 0.04, _ELEVATOR_MOVE_SPEED);
    _ElevatorData[elevatorid][_ElevatorOnFloor] = floorid;
    return CallLocalFunction("OnElevatorCalled", "dd", elevatorid, floorid);
}

stock OpenPortsElevator(elevatorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz;
    GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorObj], x, y, z);
    GetDynamicObjectRot(_ElevatorData[elevatorid][_ElevatorObj], rx, ry, rz);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorPortR], x + (1.75 * floatsin(-(rz - 360.0), degrees)), y + (1.75 * floatcos(-(rz - 360.0), degrees)), z - 0.0001, _ELEVATOR_MOVE_SPEED);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorPortL], x + (1.75 * floatsin(-(rz - 180.0), degrees)), y + (1.75 * floatcos(-(rz - 180.0), degrees)), z - 0.0001, _ELEVATOR_MOVE_SPEED);
    return true;
}

stock ClosePortsElevator(elevatorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz;
    GetDynamicObjectPos(_ElevatorData[elevatorid][_ElevatorObj], x, y, z);
    GetDynamicObjectRot(_ElevatorData[elevatorid][_ElevatorObj], rx, ry, rz);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorPortR], x, y, z, _ELEVATOR_MOVE_SPEED);
    MoveDynamicObject(_ElevatorData[elevatorid][_ElevatorPortL], x, y, z, _ELEVATOR_MOVE_SPEED);
    return true;
}

stock GetMaxFloorElevator(elevatorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    new Counter;
    for(new i; i < MAX_FLOOR_ELEVATOR; i++)
        if(_ElevatorData[elevatorid][_ElevatorFloor][i] != 0.00)
            Counter++;
    return Counter;
}

stock GetFloorNameForElevator(floorid, elevatorid, floorname[], size) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    if(floorid >= MAX_FLOOR_ELEVATOR) return false;
    format(floorname, size, _ElevatorFloorName[elevatorid][floorid]);
    return true;
}

stock SelectFloorOnElevator(elevatorid, floorid) {
    if(elevatorid >= MAX_ELEVATORS) return false;
    if(floorid >= MAX_FLOOR_ELEVATOR) return false;
    if(!IsValidElevator(elevatorid)) return false;
    if(IsDynamicObjectMoving(_ElevatorData[elevatorid][_ElevatorObj])) return false;
    if(IsDynamicObjectMoving(_ElevatorData[elevatorid][_ElevatorPortR])) return false;
    if(IsDynamicObjectMoving(_ElevatorData[elevatorid][_ElevatorPortL])) return false;
    if(IsDynamicObjectMoving(_ElevatorData[elevatorid][_ElevatorDoorPortL][floorid])) return false;
    if(IsDynamicObjectMoving(_ElevatorData[elevatorid][_ElevatorDoorPortR][floorid])) return false;
    CloseDoorForFloor(elevatorid, _ElevatorData[elevatorid][_ElevatorOnFloor]);
    CallElevatorToFloor(elevatorid, floorid);
    ClosePortsElevator(elevatorid);
    return true;
}

// hook
public OnDynamicObjectMoved(STREAMER_TAG_OBJECT:objectid) {
    for(new elevatorid; elevatorid < MAX_ELEVATORS; elevatorid++) {
        if(objectid == _ElevatorData[elevatorid][_ElevatorObj]) {
            OpenPortsElevator(elevatorid);
            OpenDoorForFloor(elevatorid, _ElevatorData[elevatorid][_ElevatorOnFloor]);
            return CallLocalFunction("OnElevatorStoped", "d", elevatorid);
        }
    }
    return CallLocalFunction("_elevator_OnDynObjMoved", "d", objectid);
}

forward _elevator_OnDynObjMoved(objectid);
#if defined _ALS_OnDynamicObjectMoved
    #undef OnDynamicObjectMoved
#else
    #define _ALS_OnDynamicObjectMoved
#endif
#define OnDynamicObjectMoved _elevator_OnDynObjMoved

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {
    for(new elevatorid; elevatorid < MAX_ELEVATORS; elevatorid++) {
        if(areaid == _ElevatorData[elevatorid][_ElevatorArea]) {
            return CallLocalFunction("OnPlayerEnterElevator", "dd", playerid, elevatorid);
        }
        for(new floor; floor < MAX_FLOOR_ELEVATOR; floor++) {
            if(areaid == _ElevatorData[elevatorid][_ElevatorDoorArea][floor]) {
                return CallLocalFunction("OnPlayerIsFrontElevator", "ddd", playerid, elevatorid, floor);
            }
        }
    }
    return CallLocalFunction("_elevator_OnPlayerEnterDynArea", "dd", playerid, areaid);
}

forward _elevator_OnPlayerEnterDynArea(playerid, areaid);
#if defined _ALS_OnPlayerEnterDynamicArea
    #undef OnPlayerEnterDynamicArea
#else
    #define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea _elevator_OnPlayerEnterDynArea

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {
    for(new elevatorid; elevatorid < MAX_ELEVATORS; elevatorid++) {
        if(areaid == _ElevatorData[elevatorid][_ElevatorArea]) {
            return CallLocalFunction("OnPlayerLeaveElevator", "dd", playerid, elevatorid);
        }
        for(new floor; floor < MAX_FLOOR_ELEVATOR; floor++) {
            if(areaid == _ElevatorData[elevatorid][_ElevatorDoorArea][floor]) {
                return CallLocalFunction("OnPlayerLeaveFrontElevator", "ddd", playerid, elevatorid, floor);
            }
        }
    }
    return CallLocalFunction("_elevator_OnPlayerLeaveDynArea", "dd", playerid, areaid);
}
forward _elevator_OnPlayerLeaveDynArea(playerid, areaid);
#if defined _ALS_OnPlayerLeaveDynamicArea
    #undef OnPlayerLeaveDynamicArea
#else
    #define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea _elevator_OnPlayerLeaveDynArea


forward OnElevatorCalled(elevatorid, floorid);
forward OnElevatorStoped(elevatorid);
forward OnPlayerEnterElevator(playerid, elevatorid);
forward OnPlayerIsFrontElevator(playerid, elevatorid, floor);
forward OnPlayerLeaveElevator(playerid, elevatorid);
forward OnPlayerLeaveFrontElevator(playerid, elevatorid, floor);