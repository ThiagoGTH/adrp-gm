#include <YSI_Coding\y_hooks>

forward OnGamemodeLoad(playerid);
public OnGamemodeLoad(playerid) {
    new rcon[255];
    if(Server_Type == 1){
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Manuten��o");
		else{
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay - Closed Alpha | Open.MP");
		    SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password closedalpha2022");
            SendRconCommand(rcon);
            ServerStatus(1);

            print("O servidor iniciou com acesso normal.");
            format(logString, sizeof(logString), "SYSTEM: O servidor iniciou com acesso normal.");
            logCreate(99998, logString, 5);
        } 
	}

	else if(Server_Type == 2) {
		format(rcon, sizeof(rcon), "hostname Advanced Sandbox | Open.MP");
		SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password sandbox333");
        SendRconCommand(rcon);

        format(logString, sizeof(logString), "SYSTEM: O servidor iniciou no modo Sandbox.");
        logCreate(99998, logString, 5);
	}

	else if(Server_Type == 3) {
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Manuten��o");
		else format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Open.MP");
		SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password adrpthiagao");
        SendRconCommand(rcon);

        format(logString, sizeof(logString), "SYSTEM: O servidor iniciou em modo manuten��o.");
        logCreate(99998, logString, 5);
	}

    return true;
}

public OnGameModeInit() {
    CA_Init();

    MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
    new Float:pos;
    if (MapAndreas_FindAverageZ(20.001, 25.006, pos)) {
        // Found position - position saved in 'pos'
    }
    
    new gmText[128];
    format(gmText, sizeof(gmText), "AD:RP v%s", VERSIONING);

    SetGameModeText(gmText);
    SendRconCommand("hostname Advanced Roleplay | Iniciando servi�os...");
    SendRconCommand("language Brazilian Portuguese");
    SendRconCommand("weburl http://advanced-roleplay.com.br");
	SendRconCommand("messageholelimit 9000");
	SendRconCommand("ackslimit 11000");
    SendRconCommand("password snd2n189w--");

    //Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 2000);
    Streamer_SetChunkSize(STREAMER_TYPE_OBJECT, 50);
	Streamer_SetTickRate(60);

    //Streamer_ToggleChunkStream(0);
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(false);
    ShowPlayerMarkers(0);
	ManualVehicleEngineAndLights();
	EnableVehicleFriendlyFire();
    DisableCrashDetectLongCall();

    print("\n\n\nIniciando os servi�os...");
    SetTimer("OnGamemodeLoad", 1000, false);
    return true;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags) {
    if(!pInfo[playerid][pLogged]) return false;
    
    if(result == -1){
		SendClientMessage(playerid, COLOR_WHITE, "ERRO: Este comando n�o existe. Digite {89B9D9}/ajuda{FFFFFF} ou {89B9D9}/sos{FFFFFF} se voc� precisar de ajuda.");    
    }else{
        format(logString, sizeof(logString), "%s (%s) [%s]: /%s %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), cmd, params);
        logCreate(playerid, logString, 3);
    }
    pInfo[playerid][pAFKCount] = 0;
    return true;
}