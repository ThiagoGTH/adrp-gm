#include <open.mp>
#include <a_http>

#undef MAX_PLAYERS
#define MAX_PLAYERS (50)

#define CGEN_MEMORY 30000

#include <crashdetect>
#include <streamer>

#include <a_mysql>
#include <YSI_Coding\y_va>
#include <YSI_Data\y_foreach>
#include <YSI_Data\y_iterate>
#include <Pawn.CMD>
#include <memory>
#include <sscanf2>
#include <indirection>
#include <discord-connector>
#include <strlib>
#include <bcrypt>
#include <progress2>
#include <PreviewDialog>
#include <easyDialog>
#include <modelsizes>
#include <physics>
#include <colandreas>
#include <mapandreas>
#include <env>
#include <Pawn.Regex>

#define YSI_NO_CACHE_MESSAGE
#define YSI_NO_OPTIMISATION_MESSAGE
#define YSI_NO_VERSION_CHECK
#define YSI_NO_HEAP_MALLOC

/*#pragma warning disable 214
#pragma warning disable 239
//#include <nex-ac_pt.lang>
#include <nex-ac>
#pragma warning enable 214
#pragma warning enable 239*/

/* ==============================[modules]============================== */
#include <YSI_Coding\y_timers>

#include "modules\utils\utils.pwn"
//#include "modules\core\anticheat\nex-ac.pwn"
#include "modules\core\anticheat\money-ac.pwn"
#include "modules\core\maps\maps.pwn"
#include "modules\core\database\mysql_core.pwn"
#include "modules\core\player\account\account.pwn"
#include "modules\core\player\player_core.pwn"
#include "modules\core\player\cmds\cmds.pwn"

// SISTEMAS
#include "modules\core\player\systems\licenses\licenses.pwn"
#include "modules\core\player\systems\main\systems.pwn"
#include "modules\core\player\systems\death\damages.pwn"
#include "modules\core\player\systems\items\items.pwn"
#include "modules\core\player\systems\vehicles\vehicles.pwn"
#include "modules\core\player\systems\pets\pets.pwn"
#include "modules\core\player\systems\investment\investment.pwn"
#include "modules\core\player\systems\factions\factions.pwn"
#include "modules\core\player\systems\status\status.pwn"
#include "modules\core\player\systems\games\games.pwn"
#include "modules\core\player\systems\animations\animations.pwn"
#include "modules\core\player\systems\elevators\elevator.pwn"
#include "modules\core\player\systems\properties\business\business.pwn"
#include "modules\core\player\systems\properties\houses\houses.pwn"
#include "modules\core\player\systems\properties\garages\garages.pwn"
#include "modules\core\player\systems\properties\properties.pwn"

#include "modules\core\player\systems\financials\financial.pwn"
#include "modules\core\player\systems\drugs\drugs.pwn"

// Phone System more Towers System
//#include "modules\core\player\systems\phone\towers\towers.pwn" (in beta - desativado)
#include "modules\core\player\systems\phone\smartphone\smartphone.pwn"
#include "modules\core\player\systems\phone\payphone\payphone.pwn"

// OUTROS
#include "modules\core\discord\discord_core.pwn"
#include "modules\core\admin\admin.pwn"

#include "modules\core\player\main\main.pwn"

main() {
    DisableCrashDetectLongCall();
}