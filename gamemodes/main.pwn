#include <a_samp>
#include <a_http>

#undef MAX_PLAYERS
#define MAX_PLAYERS (50)

#include <streamer>
#include <a_mysql>
#include <strlib>
#include <YSI_Coding\y_va>
#include <YSI_Data\y_foreach>
#include <zcmd>
#include <sscanf2>
#include <discord-connector>
#include <eSelection>
#include <easyDialog>
#include <bcrypt>

#define TYPE (1)
#define LASTEST_RELEASE "24/06/2022"
#define VERSIONING "0.0.1a - BETA"
#define SERVERIP "localhost"

//new Server_Instability = 0; // 0 = Acesso normal | 1 = Acesso suspenso
new Server_Type = TYPE; // 0 = localhost | 1  = Oficial | 2  = Sandbox	
new SERVER_MAINTENANCE = 0;  // 0 = fora de manutenção | 1 = em manutenção

new query[2048];

#define public2:%0(%1) forward %0(%1); public %0(%1)

// Incluindo módulos úteis a diversos sistemas.
#include "modules\utils\utils_colors.pwn"
#include "modules\utils\utils_player.pwn"
#include "modules\utils\utils_dialogs.pwn"
#include "modules\utils\utils_time.pwn"
#include "modules\utils\utils_discord.pwn"

// Incluindo do setup/core da database
#include "modules\core\database\mysql_core.pwn"

// Inclusão dos módulos de gerenciamento geral da conta (usuário e personagens)
#include "modules\core\player\account\user.pwn"
#include "modules\core\discord\discord_core.pwn"
#include "modules\core\player\account\character.pwn"

// Inclusão de módulos relativos a membros
#include "modules\core\player\player_core.pwn"
#include "modules\core\player\tela.pwn"

//
#include "modules\core\player\licences\base_licence.pwn"

// Inclusão de módulos relativos a sistemas
#include "modules\core\player\systems\nametag.pwn"

// Inclusão de módulos relativos a administração
#include "modules\core\admin\ban.pwn"
#include "modules\core\admin\ipcheck.pwn"
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
            new title[32],
                text[4900],
                update1[128],
                update2[128],
                versao1[128],
                versao2[128],
                ip1[128],
                ip2[128],
                footer[128];

            format(title, 32, "Servidor on-line");
            utf8encode(title, title);
            new DCC_Embed:embed = DCC_CreateEmbed(title);
            DCC_SetEmbedColor(embed, 0x238C00);
            
            format(text, 4900, "O acesso ao serviço SA-MP foi iniciado, a partir de agora você já pode se conectar com seu personagem.", text);
            utf8encode(text, text);
            DCC_SetEmbedDescription(embed, text);
            
            format(update1, 128, "%s", LASTEST_RELEASE);
            utf8encode(update1, update1);
            format(update2, 128, "Última Atualização", update2);
            utf8encode(update2, update2);
            DCC_AddEmbedField(embed, update2, update1, false);
            
            format(versao1, 128, "%s", VERSIONING);
            utf8encode(versao1, versao1);
            format(versao2, 128, "Versão do Gamemode", versao2);
            utf8encode(versao2, versao2);
            DCC_AddEmbedField(embed, versao2, versao1, false);

            format(ip1, 128, "%s", SERVERIP);
            utf8encode(ip1, ip1);
            format(ip2, 128, "Endereço de Conexão", ip2);
            utf8encode(ip2, ip2);
            DCC_AddEmbedField(embed, ip2, ip1, false);
            
            format(footer, 128, "Conexão estabelecida em: %s.", _:Now());
            utf8encode(footer, footer);

            DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/1DvanXG.png");
            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989747574367997982"), embed);
            //ServerStatus();
        } 
	}

	else if(Server_Type == 2){
		format(rcon, sizeof(rcon), "hostname Advanced Sandbox | SA-MP 0.3.DL-R1");
		SendRconCommand(rcon);
	}
    
	else if(Server_Type == 3){
		if(SERVER_MAINTENANCE) format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Manutenção");
		else format(rcon, sizeof(rcon), "hostname Advanced Roleplay | SA-MP 0.3.DL-R1");
		SendRconCommand(rcon);
	}

	if(SERVER_MAINTENANCE == 1) 
        format(rcon, sizeof(rcon), "password adrpthiagao");
	else{
		if(Server_Type == 1){
            format(rcon, sizeof(rcon), "password 0");
        }
		else
			format(rcon, sizeof(rcon), "password sandbox333");
	}
	SendRconCommand(rcon);

    return true;
}

public OnGameModeInit() {
    new gmText[128];
    format(gmText, sizeof(gmText), "AD:RP v%s", VERSIONING);

    SetGameModeText(gmText);
    SendRconCommand("hostname Advanced Roleplay | Iniciando serviços...");
    SendRconCommand("language Brazilian Portuguese");
    SendRconCommand("weburl http://advanced-roleplay.com.br");
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
		SendClientMessage(playerid, COLOR_WHITE, "ERROR: Desculpe, este comando não existe. Digite {89B9D9}/ajuda{FFFFFF} ou {89B9D9}/sos{FFFFFF} se você precisar de ajuda.");
    }
    return true;
}