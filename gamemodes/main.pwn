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
#include <dcc>
#include <eSelection>
#include <easyDialog>

#define LASTEST_RELEASE "19/11/2021"
#define VERSIONING "0.0.1a - BETA"
#define SERVERIP "127.0.0.1"

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

// Inclusão dos modulos de gerenciamento geral da conta (usuário e personagens)

#include "modules\core\player\account\user.pwn"
#include "modules\core\discord\discord_core.pwn"
#include "modules\core\player\account\character.pwn"

// Inclusão de modulos relativos a administração

#include "modules\core\admin\ban.pwn"
#include "modules\core\admin\ipcheck.pwn"

// Inclusão de modulos relativos a membros

#include "modules\core\player\player_core.pwn"
#include "modules\core\player\tela.pwn"

#include "modules\core\player\veh\vehicles.pwn"

#include "modules\core\factions\fac.pwn"
#include "modules\core\factions\tickets.pwn"
#include "modules\core\factions\wf.pwn"

#include "modules\core\player\house\house.pwn"
#include "modules\core\player\house\entrance.pwn"

//====

#include "modules\core\player\licences\base_licence.pwn"
#include "modules\core\player\veh\veh_uniques.pwn"
#include "modules\core\player\veh\ownveh.pwn"

#include "modules\core\admin\admin_core.pwn"
//==
#include "modules\core\player\fire.pwn"

 
main() {
    print("\nGamemode conectado\n");
    printf("Última atualização em: %s\n \n", LASTEST_RELEASE);

}

stock pNome(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	for(new i = 0; i < MAX_PLAYER_NAME; i++)
	{
		if(name[i] == '_') name[i] = ' ';
	}
	return name;
}

public OnGameModeInit() {
    new gmText[128];

    format(gmText, sizeof(gmText), "P:RP v%s", VERSIONING);

    SetGameModeText(gmText);
    SendRconCommand("hostname Paradise Roleplay | SAMP 0.3.DL-R1");
    SendRconCommand("language Português");
    

    SetNameTagDrawDistance(20);
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(false);

    ShowPlayerMarkers(0);
	ShowNameTags(1);
	ManualVehicleEngineAndLights();
	EnableVehicleFriendlyFire();

    new string[256];
    new DCC_Embed:embed = DCC_CreateEmbed("CONEXAO COM O SERVIDOR REALIZADA");
    format(string, sizeof string, "%s", LASTEST_RELEASE);
    DCC_AddEmbedField(embed, "Ultima atualizacao em:", string, false);
    format(string, sizeof string, "%s", VERSIONING);
    DCC_AddEmbedField(embed, "Versao do servidor:", string, false);
    format(string, sizeof string, "%s", SERVERIP);
    DCC_AddEmbedField(embed, "IP do servidor:", string, false);
    DCC_SetEmbedColor(embed, 5763719);
    DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352074907734037.png");
    DCC_SetEmbedFooter(embed, "Conexao com o servidor estabelecida com sucesso.", "https://cdn.discordapp.com/emojis/894983761878466601.png");
    DCC_SendChannelEmbedMessage(DC_Status, embed);

    return true;
}

public OnGameModeExit(){
    new string[256];
    new DCC_Embed:embed = DCC_CreateEmbed("CONEXAO COM O SERVIDOR PERDIDA");
    format(string, sizeof string, "%s", LASTEST_RELEASE);
    DCC_AddEmbedField(embed, "Ultima atualizacao em:", string, false);
    format(string, sizeof string, "%s", VERSIONING);
    DCC_AddEmbedField(embed, "Versao do servidor:", string, false);
    DCC_AddEmbedField(embed, "Erro:", "0x93", false);
    DCC_SetEmbedColor(embed, 15548997);
    DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352074907734037.png");
    DCC_SetEmbedFooter(embed, "Conexao com o servidor desestabilizada.", "https://cdn.discordapp.com/emojis/894352160479932468.png");
    DCC_SendChannelEmbedMessage(DC_Status, embed);
    return true;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success){
        va_SendClientMessage(playerid, CINZA,"ERRO:{FFFFFF} O comando '%s' não existe. Use '/ajuda' para ver os comandos ou '/sos' para solicitar ajuda.", cmdtext);
        return true;
    }
    return true;
}