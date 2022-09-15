#include <a_samp>
#include <a_http>
#include <omp>

#undef MAX_PLAYERS
#define MAX_PLAYERS (50)

#include <streamer>

#include <a_mysql>
#include <YSI_Coding\y_va>
#include <YSI_Data\y_foreach>
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

#pragma warning disable 214
#pragma warning disable 239
//#include <nex-ac_pt.lang>
#include <nex-ac>
#pragma warning enable 214
#pragma warning enable 239

#define YSI_NO_HEAP_MALLOC

/* ==============================[modules]============================== */
#include <YSI_Coding\y_timers>

#include "modules\utils\utils.pwn"
#include "modules\core\anticheat\nex-ac.pwn"
#include "modules\core\anticheat\money-ac.pwn"
#include "modules\core\maps\maps.pwn"
#include "modules\core\database\mysql_core.pwn"
#include "modules\core\player\account\account.pwn"
#include "modules\core\player\player_core.pwn"
#include "modules\core\player\cmds\cmds.pwn"
#include "modules\core\player\licences\base_licence.pwn"
#include "modules\core\player\systems\main\systems.pwn"
#include "modules\core\player\systems\items\items.pwn"
#include "modules\core\player\systems\vehicles\vehicles.pwn"
#include "modules\core\player\systems\houses\houses.pwn"
#include "modules\core\player\systems\pets\pets.pwn"
#include "modules\core\player\systems\investment\investment.pwn"
#include "modules\core\player\systems\factions\factions.pwn"
#include "modules\core\player\systems\games\games.pwn"
#include "modules\core\player\systems\animations\animations.pwn"
#include "modules\core\player\systems\elevators\elevator.pwn"
#include "modules\core\discord\discord_core.pwn"
#include "modules\core\admin\admin.pwn"

#include "modules\core\player\main\main.pwn"

main() { }