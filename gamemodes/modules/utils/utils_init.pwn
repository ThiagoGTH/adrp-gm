#include <YSI_Coding\y_hooks>

forward OnGamemodeLoad(playerid);
public OnGamemodeLoad(playerid) {
    new rcon[255];
    if(Server_Type == 1){
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Manuten��o");
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
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Manuten��o");
		else format(rcon, sizeof(rcon), "hostname Advanced Roleplay | SA-MP 0.3.DL-R1");
		SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password adrpthiagao");
        SendRconCommand(rcon);

        format(logString, sizeof(logString), "SYSTEM: O servidor iniciou em modo manuten��o.");
        logCreate(99998, logString, 5);
	}

    return true;
}

public OnGameModeInit() {
    new gmText[128];
    format(gmText, sizeof(gmText), "AD:RP v%s", VERSIONING);

    SetGameModeText(gmText);
    SendRconCommand("hostname Advanced Roleplay | Iniciando servi�os...");
    SendRconCommand("language Brazilian Portuguese");
    SendRconCommand("weburl http://advanced-roleplay.com.br");
    SendRconCommand("cookielogging 0");
	SendRconCommand("messageholelimit 9000");
	SendRconCommand("ackslimit 11000");
    SendRconCommand("password snd2n189w--");

    DisableInteriorEnterExits();
    EnableStuntBonusForAll(false);
    ShowPlayerMarkers(0);
	ManualVehicleEngineAndLights();
	EnableVehicleFriendlyFire();

    SetTimer("OnGamemodeLoad", 600, false);
    return true;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success) {
    if(!success){
		SendClientMessage(playerid, COLOR_WHITE, "ERRO: Desculpe, este comando n�o existe. Digite {89B9D9}/ajuda{FFFFFF} ou {89B9D9}/sos{FFFFFF} se voc� precisar de ajuda.");    
    }else{
        format(logString, sizeof(logString), "%s (%s) [%s]: %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), cmdtext);
        logCreate(playerid, logString, 3);
    }
    return true;
}