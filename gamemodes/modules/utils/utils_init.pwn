#include <YSI_Coding\y_hooks>

forward OnGamemodeLoad(playerid);
public OnGamemodeLoad(playerid) {
    new rcon[255];
    if(Server_Type == 1){
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Manutenção");
		else{
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay | SA-MP 0.3.DL-R1");
		    SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password 0");
            SendRconCommand(rcon);
            ServerStatus(1);

            format(logString, sizeof(logString), "SYSTEM: O servidor iniciou com acesso normal.");
            logCreate(99998, logString, 5);
        } 
	}

	else if(Server_Type == 2) {
		format(rcon, sizeof(rcon), "hostname Advanced Sandbox | SA-MP 0.3.DL-R1");
		SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password sandbox333");
        SendRconCommand(rcon);

        format(logString, sizeof(logString), "SYSTEM: O servidor iniciou no modo Sandbox.");
        logCreate(99998, logString, 5);
	}

	else if(Server_Type == 3) {
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Manutenção");
		else format(rcon, sizeof(rcon), "hostname Advanced Roleplay | SA-MP 0.3.DL-R1");
		SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password adrpthiagao");
        SendRconCommand(rcon);

        format(logString, sizeof(logString), "SYSTEM: O servidor iniciou em modo manutenção.");
        logCreate(99998, logString, 5);
	}

    return true;
}

public OnGameModeInit() {
    new gmText[128];
    format(gmText, sizeof(gmText), "AD:RP v%s", VERSIONING);

    SetGameModeText(gmText);
    SendRconCommand("hostname Advanced Roleplay | Iniciando serviços...");
    SendRconCommand("language Brazilian Portuguese");
    SendRconCommand("weburl http://advanced-roleplay.com.br");
    SendRconCommand("cookielogging 0");
	SendRconCommand("messageholelimit 9000");
	SendRconCommand("ackslimit 11000");
    SendRconCommand("password snd2n189w--");

    Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 1200);
    Streamer_SetChunkSize(STREAMER_TYPE_OBJECT, 50);
	Streamer_SetTickRate(200);

    //Streamer_ToggleChunkStream(0);
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(false);
    ShowPlayerMarkers(0);
	ManualVehicleEngineAndLights();
	EnableVehicleFriendlyFire();
    DisableCrashDetectLongCall();

    SetTimer("OnGamemodeLoad", 600, false);
    return true;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags) {
    if(!pInfo[playerid][pLogged]) return SendErrorMessage(playerid, "Você não pode usar um comando agora.");
    
    if(result == -1){
		SendClientMessage(playerid, COLOR_WHITE, "ERRO: Desculpe, este comando não existe. Digite {89B9D9}/ajuda{FFFFFF} ou {89B9D9}/sos{FFFFFF} se você precisar de ajuda.");    
    }else{
        format(logString, sizeof(logString), "%s (%s) [%s]: /%s %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), cmd, params);
        logCreate(playerid, logString, 3);
    }
    pInfo[playerid][pAFKCount] = 0;
    return true;
}