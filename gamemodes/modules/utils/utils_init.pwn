#include <YSI_Coding\y_hooks>

forward OnGamemodeLoad();
public OnGamemodeLoad() {
    new rcon[255];
    if(SERVER_TYPE == 0){
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay - Local Host | Open.MP");
		else{
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay - Local Host | Open.MP");
		    SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password 0");
            SendRconCommand(rcon);

            printf("\n\n\n\n\n");
            print("O servidor iniciou no local host.");
            format(logString, sizeof(logString), "SYSTEM: O servidor iniciou mo local host.");
            logCreate(99998, logString, 5);
        } 
	}

    else if(SERVER_TYPE == 1){
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay - Manutenção | Open.MP");
		else{
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay - Closed Beta | Open.MP");
		    SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password closedbeta023");
            SendRconCommand(rcon);
            ServerStatus(1);

            printf("\n\n\n\n\n");
            print("O servidor iniciou em modo Closed Beta.");
            format(logString, sizeof(logString), "SYSTEM: O servidor iniciou em modo Closed Beta.");
            logCreate(99998, logString, 5);
        } 
	}
    else if(SERVER_TYPE == 2){
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay - Manutenção | Open.MP");
		else{
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay - Closed Alpha | Open.MP");
		    SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password closedalpha2023");
            SendRconCommand(rcon);
            ServerStatus(1);

            printf("\n\n\n\n\n");
            print("O servidor iniciou em modo Closed Alpha.");
            format(logString, sizeof(logString), "SYSTEM: O servidor iniciou em modo Closed Alpha.");
            logCreate(99998, logString, 5);
        } 
	}

	else if(SERVER_TYPE == 3) {
		format(rcon, sizeof(rcon), "hostname Advanced Sandbox | Open.MP");
		SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password sandbox333");
        SendRconCommand(rcon);

        printf("\n\n\n\n\n");
        print("O servidor iniciou em modo Sandbox.");
        format(logString, sizeof(logString), "SYSTEM: O servidor iniciou no modo Sandbox.");
        logCreate(99998, logString, 5);
	}

	else if(SERVER_TYPE == 4) {
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Manutenção");
		else format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Open.MP");
		SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password adrpthiagao");
        SendRconCommand(rcon);

        printf("\n\n\n\n\n");
        format(logString, sizeof(logString), "SYSTEM: O servidor iniciou em modo normal.");
        logCreate(99998, logString, 5);
	}

    return true;
}

public OnGameModeInit() {
    print("\n\n\n\nIniciando os serviços...");

    new gmText[128];
    format(gmText, sizeof(gmText), "AD:RP v%s", VERSIONING);

    SetGameModeText(gmText);
    SendRconCommand("hostname Advanced Roleplay | Iniciando serviços...");
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
    ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	ManualVehicleEngineAndLights();
	EnableVehicleFriendlyFire();
    DisableCrashDetectLongCall();

    CA_Init();
    MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
    new Float:pos;
    if (MapAndreas_FindAverageZ(20.001, 25.006, pos)) {
        // Found position - position saved in 'pos'
    }
    
    SetTimer("OnGamemodeLoad", 60000, false); 
    return true;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags) {
    if(!pInfo[playerid][pLogged]) return false;
    
    if(result == -1){
		SendClientMessage(playerid, COLOR_WHITE, "ERRO: Este comando não existe. Digite {89B9D9}/ajuda{FFFFFF} ou {89B9D9}/sos{FFFFFF} se você precisar de ajuda.");    
    }else{
        format(logString, sizeof(logString), "%s (%s) [%s]: /%s %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), cmd, params);
        logCreate(playerid, logString, 3);
    }
    pInfo[playerid][pAFKCount] = 0;
    return true;
}