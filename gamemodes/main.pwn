#include <a_samp>
#include <a_http>

#undef MAX_PLAYERS
#define MAX_PLAYERS (50)

#include <streamer> 
#include <a_mysql>
#include <YSI_Coding\y_va>
#include <YSI_Data\y_foreach>
#include <zcmd>
#include <memory>
#include <sscanf2>
#include <discord-connector>
#include <strlib>
#include <easyDialog>
#include <bcrypt>
#include <streamer>
#include <easyDialog>  

#define     TYPE                (1)
#define     LASTEST_RELEASE     "24/06/2022"
#define     VERSIONING          "0.0.1a - BETA"
#define     SERVERIP            "localhost"
#define     SERVERUCP           "https://advanced-roleplay.com.br"
#define     SERVERFORUM         "https://forum.advanced-roleplay.com.br"

new Server_Instability = 0; // 0 = Acesso normal | 1 = Acesso suspenso
new Server_Type = TYPE; // 0 = localhost | 1  = Oficial | 2  = Sandbox	
new SERVER_MAINTENANCE = 0;  // 0 = fora de manutenção | 1 = em manutenção

new query[2048];

#define public2:%0(%1) forward %0(%1); public %0(%1)

// Incluindo módulos úteis a diversos sistemas.
#include "modules\utils\utils_globals.pwn"
#include "modules\utils\utils_colors.pwn"
#include "modules\utils\utils_player.pwn"
#include "modules\utils\utils_dialogs.pwn"
#include "modules\utils\utils_time.pwn"
#include "modules\utils\utils_discord.pwn"
#include "modules\utils\utils_logs.pwn"

// Incluindo do setup/core da database
#include "modules\core\database\mysql_core.pwn"

// Inclusão dos módulos de gerenciamento geral da conta (usuário e personagens)
#include "modules\core\player\account\user.pwn"
#include "modules\core\player\account\character.pwn"

// Inclusão de módulos relativos a membros
#include "modules\core\player\player_core.pwn"
#include "modules\core\player\tela.pwn"

//
#include "modules\core\player\licences\base_licence.pwn"

// Inclusão de módulos relativos a sistemas
#include "modules\core\player\systems\nametag.pwn"
#include "modules\core\player\systems\rpcmds.pwn"
#include "modules\core\player\systems\deathsys.pwn"
//#include "modules\core\player\systems\games\pool.pwn"
#include "modules\core\discord\discord_core.pwn"

// Inclusão de módulos relativos a administração
#include "modules\core\admin\ban.pwn"
#include "modules\core\admin\config.pwn"
#include "modules\core\admin\ipcheck.pwn"
#include "modules\core\admin\reports.pwn"
#include "modules\core\admin\admin_core.pwn"

main() {
    print("\nGamemode conectado\n");
    printf("Última atualização em: %s\n \n", LASTEST_RELEASE);
}

forward OnGamemodeLoad(playerid);
public OnGamemodeLoad(playerid){
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

	else if(Server_Type == 2){
		format(rcon, sizeof(rcon), "hostname Advanced Sandbox | SA-MP 0.3.DL-R1");
		SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password sandbox333");
        SendRconCommand(rcon);

        format(logString, sizeof(logString), "SYSTEM: O servidor iniciou no modo Sandbox.");
        logCreate(99998, logString, 5);
	}

	else if(Server_Type == 3){
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

    DisableInteriorEnterExits();
    EnableStuntBonusForAll(false);
    ShowPlayerMarkers(0);
	ManualVehicleEngineAndLights();
	EnableVehicleFriendlyFire();

    SetTimer("OnGamemodeLoad", 600, false);
    return true;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success){
		SendClientMessage(playerid, COLOR_WHITE, "ERRO: Desculpe, este comando não existe. Digite {89B9D9}/ajuda{FFFFFF} ou {89B9D9}/sos{FFFFFF} se você precisar de ajuda.");    
    }else{
        format(logString, sizeof(logString), "%s (%s) [%s]: %s", pNome(playerid), GetPlayerUserEx(playerid), GetPlayerIP(playerid), cmdtext);
        logCreate(playerid, logString, 3);
    }
    return true;
}