#include <a_samp>
#include <a_http>

#undef MAX_PLAYERS
#define MAX_PLAYERS (50)

#include <fixes>
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
//#include <progress2>
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
#include "modules\utils\utils_models.pwn"
#include "modules\utils\utils_interface.pwn"
#include "modules\utils\utils_init.pwn"
#include "modules\utils\utils_vehicles.pwn"

// Incluindo do setup/core da database
#include "modules\core\database\mysql_core.pwn"

// Inclusão dos módulos de gerenciamento geral da conta (usuário e personagens)
#include "modules\core\player\account\user.pwn"
#include "modules\core\player\account\character.pwn"
#include "modules\core\player\account\changechar.pwn"

// Inclusão de módulos relativos a membros
#include "modules\core\player\player_core.pwn"
#include "modules\core\player\tela.pwn"

//
#include "modules\core\player\licences\base_licence.pwn"

// Inclusão de módulos relativos a sistemas
#include "modules\core\player\systems\ads.pwn"
#include "modules\core\player\systems\rpcmds.pwn"
#include "modules\core\player\systems\nametag.pwn"
#include "modules\core\player\systems\death.pwn"
#include "modules\core\player\systems\mechanic.pwn"
#include "modules\core\player\systems\vehicles\vehicles_core.pwn"

//#include "modules\core\player\systems\elevator.pwn"
#include "modules\core\discord\discord_core.pwn"

// FACTIONS
#include "modules\core\player\systems\factions\news.pwn"

// Inclusão de módulos relativos a jogos
//#include "modules\core\player\systems\games\poker.pwn"

// Inclusão de módulos relativos a administração
#include "modules\core\admin\ban.pwn"
#include "modules\core\admin\fly.pwn"
#include "modules\core\admin\config.pwn"
#include "modules\core\admin\ipcheck.pwn"
#include "modules\core\admin\reports.pwn"
#include "modules\core\admin\admin_core.pwn"

main() {
    print("\nGamemode conectado\n");
    printf("Última atualização em: %s\n \n", LASTEST_RELEASE);
}

