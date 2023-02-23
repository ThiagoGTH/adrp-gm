//#define POKER_DEBUG
//#define POKER_LSRP

const MAX_POKER_GAMES = 20;
const MAX_POKER_PLAYERS = 6;
const MAX_POKER_BACKGROUND_TEXTDRAWS = 7;
const MAX_POKER_MENU_ITEMS = 4;
const POKER_DIALOG_ID = 9997;
const MAX_POKER_DECK_CARDS = 52;
const POKER_OBJECT_MODEL = 19474;
const MAX_TABLE_CARDS = 5;
const POKER_DEFAULT_BLIND = 100;
const INVALID_POKER_GAME_ID = -1;
const MAX_POKER_TIMER = 20; // TODO: This can later be configurable...
const Float:POKER_CAMERA_HEIGHT = 4.0;

/* PVar Names */
#define POKER_PLAYER_GAME_VAR "PlayerPokerGame"
#define POKER_PLAYER_READY_VAR "PlayerPokerReady"
#define POKER_PLAYER_RAISE_AMOUNT_VAR "PlayerPokerRaiseAmount"
#define POKER_PLAYER_BET_AMOUNT_VAR "PlayerPokerBetAmount"
#define POKER_SPECTATE_VAR_NAME "POKER_SPECTATE_VAR_NAME"
#define POKER_CAMERA_VAR_NAME "POKER_CAMERA"
#define POKER_SIT_VAR_NAME "POKER_SIT_VAR"
#define POKER_CHIPS_VAR_NAME "POKER_CHIPS"

#if !defined BYTES_PER_CELL
    #define BYTES_PER_CELL (cellbits / 8)
#endif

enum
{
	STRAIGHT_FLUSH,
	FOUR_OF_A_KIND,
	FULL_HOUSE,
	FLUSH,
	STRAIGHT,
	THREE_OF_A_KIND,
	TWO_PAIR,
	ONE_PAIR,
	HIGH_CARD
};

enum POKER_GAME_POSITION {
    Float: PokerX,
    Float: PokerY,
    Float: PokerZ
};

enum POKER_PLAYER_STATUS {
    EMPTY,
    LOBBY,
    PLAYING, // ACTIVE
    WAITING, // ACTIVE
    CHECKED, // NON-AGGRESSIVE
    RAISED, // AGGRESSIVE
    CALLED, // NON-AGGRESSIVE
    ALL_IN, // IN-ACTIVE
    FOLDED, // IN-ACTIVE
    SMALL_BLIND, // ACTIVE
    BIG_BLIND, // ACTIVE & AGGRESSIVE
    DEALER, // ACTIVE
    EVALUATED,
    BET
};

enum POKER_MENU_STATES
{
    BET,
    RAISE,
    CHECK,
    CALL
};

enum POKER_DIALOGS
{
    SIT,
    SIT_CONFIRM,
    RAISE,
    RAISE_CONFIRM,
    CALL_CONFIRM,
    CHECK_CONFIRM,
    BET,
    BET_CONFIRM,
    STATS,
	FOLD_CONFIRM,
	ALL_IN_CONFIRM,
	CHIPS,
	CHIPS_CONFIRM
};

enum POKER_GAME_STATUS
{
    LOBBY,
    INITIAL_BETTING,
    FLOP,
    TURN,
    RIVER,
    EVALUATION
};

enum POKER_GAME {
    bool: IS_ASSIGNED,
    PLAYERS[MAX_POKER_PLAYERS],
    OBJECT_ID,
    POSITION[POKER_GAME_POSITION],
    Text: READY_TEXTDRAWS[MAX_POKER_PLAYERS],
    Text: MENU_TEXTDRAWS[MAX_POKER_MENU_ITEMS],
    Text: PLAYER_STATUS_TEXTDRAWS[MAX_POKER_PLAYERS],
    Text: PLAYER_CHIPS_TEXTDRAWS[MAX_POKER_PLAYERS],
    Text: POT_TEXTDRAW,
    Text: PLAYER_GAME_CARD_ONE_TEXTDRAW[MAX_POKER_PLAYERS],
    Text: PLAYER_GAME_CARD_TWO_TEXTDRAW[MAX_POKER_PLAYERS],
    Text: POKER_BLINDS_TEXTDRAW,
    Text: TABLE_CARDS_TEXTDRAWS[MAX_TABLE_CARDS],
	Text: TIMER_TEXTDRAW,
    PlayerText: PLAYER_PRIV_CARD_ONE_TEXTDRAW[MAX_POKER_PLAYERS],
    PlayerText: PLAYER_PRIV_CARD_TWO_TEXTDRAW[MAX_POKER_PLAYERS],
    POKER_MENU_STATES: MENU_ITEM_ONE_STATE,
    POKER_MENU_STATES: MENU_ITEM_TWO_STATE,
    TABLE_CARD_VALUES[MAX_TABLE_CARDS],
    PLAYER_CARD_ONE_VALUE[MAX_POKER_PLAYERS],
    PLAYER_CARD_TWO_VALUE[MAX_POKER_PLAYERS],
    POT,
    PLAYER_CHIPS[MAX_POKER_PLAYERS],
    POKER_PLAYER_STATUS: PLAYER_STATUS[MAX_POKER_PLAYERS],
    BLIND,
    DEALER,
    SMALL_BLIND_POSITION,
    BIG_BLIND_POSITION,
    CURRENT_PLAYER_POSITION,
    POKER_GAME_STATUS: GAME_STATUS,
    CURRENT_BET,
    PLAYER_POT_CONTRIBUTIONS[MAX_POKER_PLAYERS],
    PLAYER_BET_CONTRIBUTIONS[MAX_POKER_PLAYERS],
    LAST_AGGRESSIVE_PLAYER,
    AMOUNT_OF_PLAYS,
    LAST_BET,
	TIMER,
	TIMER_START,
	BUSINESS_ID
};
new g_rgPokerGames[MAX_POKER_GAMES][POKER_GAME];

#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

#define Pkr_GetObjectId(%0) \
            g_rgPokerGames[%0][OBJECT_ID]

#define Pkr_SetObjectId(%0,%1) \
            g_rgPokerGames[%0][OBJECT_ID] = %1

#define Pkr_ForeachGame(%0) \
            for(new %0 = 0; %0 < MAX_POKER_GAMES; ++%0)

#define Pkr_ForeachTable(%0) \
            for(new %0 = 0; %0 < MAX_TM_POKER_TABLES; ++%0)

#define Pkr_ForeachPlayer(%0) \
            for(new %0 = 0; %0 < MAX_POKER_PLAYERS; ++%0)

#define Pkr_ForeachPlayerIdInPool(%0) \
            for(new %0 = 0, poolSize = GetPlayerPoolSize(); %0 <= poolSize; ++%0)

#define Pkr_GetLastBet(%0) \
            g_rgPokerGames[%0][LAST_BET]

#define Pkr_SetLastBet(%0,%1) \
            g_rgPokerGames[%0][LAST_BET] = %1

#define Pkr_GetLastAggressivePlayer(%0) \
            g_rgPokerGames[%0][LAST_AGGRESSIVE_PLAYER]

#define Pkr_SetLastAggressivePlayer(%0,%1) \
            g_rgPokerGames[%0][LAST_AGGRESSIVE_PLAYER] = %1

#define Pkr_GetAmountOfPlays(%0) \
            g_rgPokerGames[%0][AMOUNT_OF_PLAYS]

#define Pkr_SetAmountOfPlays(%0,%1) \
            g_rgPokerGames[%0][AMOUNT_OF_PLAYS] = %1

#define Pkr_IncAmountOfPlays(%0) \
            ++g_rgPokerGames[%0][AMOUNT_OF_PLAYS]

#define Pkr_SetPlayerBetContribution(%0,%1,%2) \
            g_rgPokerGames[%0][PLAYER_BET_CONTRIBUTIONS][%1] = %2

#define Pkr_GetPlayerBetContribution(%0,%1) \
            g_rgPokerGames[%0][PLAYER_BET_CONTRIBUTIONS][%1]

#define Pkr_ResetPlayerBetContributions(%0) \
    for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i) Pkr_SetPlayerBetContribution(%0, _i, 0)

#define Pkr_AddToPlayerBetContribution(%0,%1,%2) \
            Pkr_SetPlayerBetContribution(%0, %1, Pkr_GetPlayerBetContribution(%0, %1) + %2)

#define Pkr_GetPlayerPotContribution(%0,%1) \
            g_rgPokerGames[%0][PLAYER_POT_CONTRIBUTIONS][%1]

#define Pkr_SetPlayerPotContribution(%0,%1,%2) \
            g_rgPokerGames[%0][PLAYER_POT_CONTRIBUTIONS][%1] = %2

#define Pkr_AddToPlayerPotContribution(%0,%1,%2) \
            Pkr_SetPlayerPotContribution(%0, %1, Pkr_GetPlayerPotContribution(%0, %1) + %2)

#define Pkr_SetAllPlayerPotContribution(%0,%1) \
            for(new _j = 0; _j < MAX_POKER_PLAYERS; ++_j) Pkr_SetPlayerPotContribution(%0, _j, %1)

#define Pkr_GetCurrentBet(%0) \
            g_rgPokerGames[%0][CURRENT_BET]

#define Pkr_SetCurrentBet(%0,%1)  \
            g_rgPokerGames[%0][CURRENT_BET] = %1

#define Pkr_AddToCurrentBet(%0,%1)  \
            g_rgPokerGames[%0][CURRENT_BET] = Pkr_GetCurrentBet(%0) + %1

#define Pkr_GetGameStatus(%0) \
            g_rgPokerGames[%0][GAME_STATUS]

#define Pkr_SetGameStatus(%0,%1) \
            g_rgPokerGames[%0][GAME_STATUS] = %1

#define Pkr_GetPlayerId(%0,%1) \
            g_rgPokerGames[%0][PLAYERS][%1]

#define Pkr_SetPlayerId(%0,%1,%2) \
            g_rgPokerGames[%0][PLAYERS][%1] = %2

#define Pkr_GetSmallBlindPosition(%0) \
            g_rgPokerGames[%0][SMALL_BLIND_POSITION]

#define Pkr_GetBigBlindPosition(%0) \
            g_rgPokerGames[%0][BIG_BLIND_POSITION]

#define Pkr_SetSmallBlindPosition(%0,%1) \
            g_rgPokerGames[%0][SMALL_BLIND_POSITION] = %1

#define Pkr_SetBigBlindPosition(%0,%1) \
            g_rgPokerGames[%0][BIG_BLIND_POSITION] = %1

#define Pkr_GetDealerPosition(%0) \
            g_rgPokerGames[%0][DEALER]

#define Pkr_SetDealerPosition(%0,%1) \
            g_rgPokerGames[%0][DEALER] = %1

#define Pkr_GetCurrentPlayerPosition(%0) \
            g_rgPokerGames[%0][CURRENT_PLAYER_POSITION]

#define Pkr_SetCurrentPlayerPosition(%0,%1) \
            g_rgPokerGames[%0][CURRENT_PLAYER_POSITION] = %1

#define Pkr_GetPlayerChips(%0,%1) \
            g_rgPokerGames[%0][PLAYER_CHIPS][%1]

#define Pkr_GetPotAmount(%0) \
            g_rgPokerGames[%0][POT]

#define Pkr_AddToPot(%0,%1) \
            Pkr_SetPotAmount(%0, Pkr_GetPotAmount(%0) + %1)

#define Pkr_SubFromPot(%0,%1) \
            Pkr_SetPotAmount(%0, Pkr_GetPotAmount(%0) - %1)

#define Pkr_SetPokerDialog(%0,%1) \
            SetPVarInt(%0, "PokerDialog", _:%1)

#define Pkr_GetPokerDialog(%0) \
            GetPVarInt(%0, "PokerDialog")

#define Pkr_IsOdd(%0) \
            (%0 % 2)

#define Pkr_GetTimerTextdraw(%0) \
			g_rgPokerGames[%0][TIMER_TEXTDRAW]

#define Pkr_SetTimerTextdraw(%0,%1) \
			g_rgPokerGames[%0][TIMER_TEXTDRAW] = %1

#define Pkr_GetTimer(%0) \
			g_rgPokerGames[%0][TIMER]

#define Pkr_SetTimer(%0,%1) \
			g_rgPokerGames[%0][TIMER] = %1

#define Pkr_GetTimerStart(%0) \
			g_rgPokerGames[%0][TIMER_START]

#define Pkr_SetTimerStart(%0,%1) \
			g_rgPokerGames[%0][TIMER_START] = %1

#define Pkr_ShowCursorForPlayerId(%0) \
		SelectTextDraw(%0, COLOR_ORANGE)

#define Pkr_HideCursorForPlayerId(%0) \
		CancelSelectTextDraw(playerid)

#define Pkr_SetAllPlayersNotReady(%0) \
    	Pkr_ForeachPlayer(playerSlot) if(Pkr_GetPlayerId(%0, playerSlot) != INVALID_PLAYER_ID) Pkr_SetPlayerNotReady(%0, playerSlot)

#define Pkr_SetRake(%0,%1) \
			BusinessData[%0][BusinessRake] = %1

//#define Pkr_GetRake(%0) \
			BusinessData[%0][BusinessRake]

#define Pkr_SetBusiness(%0,%1) \
			g_rgPokerGames[%0][BUSINESS_ID] = %1

#define Pkr_GetBusiness(%0) \
			g_rgPokerGames[%0][BUSINESS_ID]

#define Pkr_ShowPlayerMenuTextDraws(%0,%1) \
            for(new _i; _i < MAX_POKER_MENU_ITEMS; ++_i) TextDrawShowForPlayer(%0, g_rgPokerGames[%1][MENU_TEXTDRAWS][_i])

#define Pkr_HidePlayerMenuTextDraws(%0,%1) \
            for(new _i; _i < MAX_POKER_MENU_ITEMS; ++_i) TextDrawHideForPlayer(%0, g_rgPokerGames[%1][MENU_TEXTDRAWS][_i])

#define Pkr_SetMenuItemOneBet(%0) \
    TextDrawSetString(g_rgPokerGames[%0][MENU_TEXTDRAWS][1], "BAHIS")

#define Pkr_SetMenuItemOneRaise(%0) \
    TextDrawSetString(g_rgPokerGames[%0][MENU_TEXTDRAWS][1], "ARTTIR")

#define Pkr_SetMenuItemTwoCheck(%0) \
    TextDrawSetString(g_rgPokerGames[%0][MENU_TEXTDRAWS][2], "CHECK")

#define Pkr_SetMenuItemTwoCall(%0) \
    TextDrawSetString(g_rgPokerGames[%0][MENU_TEXTDRAWS][2], "CALL")

#define Pkr_ForeachBackground(%0) \
            for(new %0 = 0; %0 < MAX_POKER_BACKGROUND_TEXTDRAWS; ++%0)

#define Pkr_GetBackgroundTextDrawId(%0) \
            g_rgPokerBackground[%0]

#define Pkr_SetBackgroundTextDrawId(%0,%1) \
            g_rgPokerBackground[%0] = %1

#define Pkr_ShowPlayerBackgroundTextDraws(%0) \
            Pkr_ForeachBackground(background) TextDrawShowForPlayer(%0, g_rgPokerBackground[background])

#define Pkr_HidePlayerBackgroundTextDraws(%0) \
            Pkr_ForeachBackground(background) TextDrawHideForPlayer(%0, g_rgPokerBackground[background])

new Text: g_rgPokerBackground[MAX_POKER_BACKGROUND_TEXTDRAWS] = { Text: INVALID_TEXT_DRAW, ... };


#define MAX_POKER_READY_TEXTDRAWS (6)

#define Pkr_GetPlayerReadyTextDrawId(%0,%1) \
            g_rgPokerGames[%0][READY_TEXTDRAWS][%1]

#define Pkr_SetPlayerReadyTextDrawId(%0,%1,%2) \
            Pkr_GetPlayerReadyTextDrawId(%0,%1) = %2

#define Pkr_ForeachReadyTextDraw(%0) \
            for(new %0 = 0; %0 < MAX_POKER_READY_TEXTDRAWS; ++%0)

#define Pkr_ShowPlayerReadyTextDraw(%0,%1) \
            for(new _i; _i < 6; ++_i) TextDrawShowForPlayer(%0, g_rgPokerGames[%1][READY_TEXTDRAWS][_i])

#define Pkr_HidePlayerReadyTextDraw(%0,%1) \
            for(new _i; _i < 6; ++_i) TextDrawHideForPlayer(%0, g_rgPokerGames[%1][READY_TEXTDRAWS][_i])

#define Pkr_SetReadyTextDrawReady(%0,%1) \
            TextDrawSetString(g_rgPokerGames[%0][READY_TEXTDRAWS][%1], "~g~HAZIR")

#define Pkr_SetReadyTextDrawNotReady(%0,%1) \
            TextDrawSetString(g_rgPokerGames[%0][READY_TEXTDRAWS][%1], "~r~HAZIR DEGIL")

#define Pkr_SetReadyTextDrawEmpty(%0,%1) \
            TextDrawSetString(g_rgPokerGames[%0][READY_TEXTDRAWS][%1], "~w~BOS KOLTUK")

#define POKER_LOG_PATH "scriptfiles/poker.log"

#if defined POKER_DEBUG
    static const LOGGING_ADMIN_LEVEL = 1;
#endif

//Pkr_Log(fstring[], {Float, _}:...)


PkrCMD_Camera(const playerid) {
	new gameId = Pkr_GetPlayerGame(playerid);
	if(gameId == -1 || gameId == INVALID_POKER_GAME_ID) {
		SendClientMessage(playerid, COLOR_RED, "Poker oynamùyorsun.");
		return;
	}

	new objectId = Pkr_GetObjectId(gameId);

	if(GetPVarType(playerid, POKER_CAMERA_VAR_NAME) == PLAYER_VARTYPE_NONE) {
		PkrSys_SetPlayerCamera(playerid, objectId);
		SetPVarInt(playerid, POKER_CAMERA_VAR_NAME, 1);
		return;
	}

	SetCameraBehindPlayer(playerid);
	DeletePVar(playerid, POKER_CAMERA_VAR_NAME);
	return;
}

PkrSys_SetPlayerCamera(const playerid, const objectid) {
	if(!IsValidDynamicObject(objectid)) return false;
	new Float:_pos[4], Float:_offset[2];
	GetDynamicObjectPos(objectid, _pos[0], _pos[1], _pos[2]);
	GetDynamicObjectRot(objectid, _pos[3], _pos[3], _pos[3]);
	_pos[3] += 270;
	_offset[0] = _pos[0];
	_offset[1] = _pos[1];
	_offset[0] += (0.1 * floatsin(-_pos[3], degrees));
	_offset[1] += (0.1 * floatcos(-_pos[3], degrees));
	SetPlayerCameraPos(playerid, _offset[0], _offset[1], _pos[2] + POKER_CAMERA_HEIGHT);
	SetPlayerCameraLookAt(playerid, _pos[0], _pos[1], _pos[2]);
	return true;
}

new g_rgCardDeck[MAX_POKER_DECK_CARDS];
new g_rgPrimeNumbers[] = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41 };

#define Pkr_InitDeck() \
            for(new a, b, c, suit = 0x8000; a < 4; a++, suit >>= 1) for(b = 0; b < 13; b++, c++) g_rgCardDeck[c] = g_rgPrimeNumbers[b] | (b << 8) | suit | (1 << (16 + b))

#define Pkr_GetBlindsTextDrawId(%0) \
            g_rgPokerGames[%0][POKER_BLINDS_TEXTDRAW]

#define Pkr_SetBlindsTextDrawId(%0,%1) \
            g_rgPokerGames[%0][POKER_BLINDS_TEXTDRAW] = %1

#define Pkr_ShowPlayerBlindTextDraw(%0,%1) \
            TextDrawShowForPlayer(%0, Pkr_GetBlindsTextDrawId(%1))

#define Pkr_HidePlayerBlindTextDraw(%0,%1) \
            TextDrawHideForPlayer(%0, Pkr_GetBlindsTextDrawId(%1))

#define Pkr_SetBlindTextDraw(%0,%1) \
            TextDrawSetString(Pkr_GetBlindsTextDrawId(%1), %1)

Pkr_CreateBlindTextDraw(const gameId)
{
    Pkr_SetBlindsTextDrawId(gameId, TextDrawCreate(317.000000, 244.000000, "BAHISLER: ~y~$100 ~w~/ ~y~$200"));
    new Text: textId = Pkr_GetBlindsTextDrawId(gameId);
    TextDrawAlignment(textId, 2);
    TextDrawBackgroundColour(textId, 255);
    TextDrawFont(textId, 2);
    TextDrawLetterSize(textId, 0.210000, 1.300000);
    TextDrawColour(textId, -1);
    TextDrawSetOutline(textId, 1);
    TextDrawSetProportional(textId, 1);
    TextDrawSetShadow(textId, 1);
    TextDrawSetSelectable(textId, 0);
    return;
}

Pkr_DestroyBlindTextDraw(const gameId)
{
    TextDrawDestroy(Pkr_GetBlindsTextDrawId(gameId));
    Pkr_SetBlindsTextDrawId(gameId, Text: INVALID_TEXT_DRAW);
    return;
}

#define Pkr_GetSmallBlind(%0) \
            g_rgPokerGames[%0][BLIND]

#define Pkr_GetBigBlind(%0) \
            (g_rgPokerGames[%0][BLIND] << 1)

#define Pkr_SetBlind(%0,%1) \
            g_rgPokerGames[%0][BLIND] = %1


PkrCMD_SetBlind(const playerid, const parameters[]) {
	new gameId = Pkr_GetPlayerGame(playerid);

	if(gameId == -1) {
        SendClientMessage(playerid, COLOR_RED, "Poker oynamùyorsun.");
        return;
    }

	new POKER_GAME_STATUS: status = Pkr_GetGameStatus(gameId);
	if(status != POKER_GAME_STATUS: LOBBY) {
		SendClientMessage(playerid, COLOR_RED, "The blinds can only be modified in the lobby!");
		return;
	}

    new amount;
    if(sscanf(parameters, "i", amount))
    {
        SendClientMessage(playerid, COLOR_GREY, "USAGE: /pkr blind [amount]");
        return;
    }

	if(amount < 0 || amount > 10000) {
		SendClientMessage(playerid, COLOR_RED, "You can only set the small blind in a range of $0 - $10000.");
		return;
	}

	Pkr_SetBlindValue(gameId, amount);
	Pkr_SetAllPlayersNotReady(gameId);
	Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s has set the small blind to: $%d. Make sure you have enough cash to meet the blinds!", pNome(playerid), amount);
	return;
}

Pkr_SetBlindValue(const gameId, const amount) {
	Pkr_SetBlind(gameId, amount);
	new tdText[128];
	format(tdText, sizeof(tdText), "BAHISLER: ~y~$%d ~w~/ ~y~$%d", amount, amount << 1);
	TextDrawSetString(Pkr_GetBlindsTextDrawId(gameId), tdText);
	return;
}

Pkr_ShowAllPlayersReadyTextDraw(const gameId) {
	Pkr_ForeachPlayer(playerSlot) {
		new playerId = Pkr_GetPlayerId(gameId, playerSlot);
		if(playerId != INVALID_PLAYER_ID && GetPVarType(playerId, POKER_SIT_VAR_NAME) != PLAYER_VARTYPE_NONE)
			Pkr_ShowPlayerReadyTextDraw(playerId, gameId);
	}
	return;
}

Pkr_CreateReadyTextDraws(const gameId)
{
    g_rgPokerGames[gameId][READY_TEXTDRAWS][0] = TextDrawCreate(234.000000, 280.000000, "~w~BOS KOLTUK");
    TextDrawAlignment(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 255);
    TextDrawFont(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 0.200000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 16711935);
    TextDrawSetOutline(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 15, 84);
    TextDrawSetSelectable(g_rgPokerGames[gameId][READY_TEXTDRAWS][0], 1);

    g_rgPokerGames[gameId][READY_TEXTDRAWS][1] = TextDrawCreate(182.000000, 218.000000, "~w~BOS KOLTUK");
    TextDrawAlignment(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 255);
    TextDrawFont(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 0.200000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 16711935);
    TextDrawSetOutline(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 15, 84);
    TextDrawSetSelectable(g_rgPokerGames[gameId][READY_TEXTDRAWS][1], 1);

    g_rgPokerGames[gameId][READY_TEXTDRAWS][2] = TextDrawCreate(233.000000, 155.000000, "~w~BOS KOLTUK");
    TextDrawAlignment(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 255);
    TextDrawFont(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 0.200000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 16711935);
    TextDrawSetOutline(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 15, 84);
    TextDrawSetSelectable(g_rgPokerGames[gameId][READY_TEXTDRAWS][2], 1);

    g_rgPokerGames[gameId][READY_TEXTDRAWS][3] = TextDrawCreate(408.000000, 155.000000, "~w~BOS KOLTUK");
    TextDrawAlignment(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 255);
    TextDrawFont(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 0.200000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 16711935);
    TextDrawSetOutline(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 15, 84);
    TextDrawSetSelectable(g_rgPokerGames[gameId][READY_TEXTDRAWS][3], 1);

    g_rgPokerGames[gameId][READY_TEXTDRAWS][4] = TextDrawCreate(465.000000, 218.000000, "~w~BOS KOLTUK");
    TextDrawAlignment(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 255);
    TextDrawFont(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 0.200000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 16711935);
    TextDrawSetOutline(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 15, 84);
    TextDrawSetSelectable(g_rgPokerGames[gameId][READY_TEXTDRAWS][4], 1);

    g_rgPokerGames[gameId][READY_TEXTDRAWS][5] = TextDrawCreate(407.000000, 280.000000, "~w~BOS KOLTUK");
    TextDrawAlignment(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 255);
    TextDrawFont(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 0.200000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 16711935);
    TextDrawSetOutline(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 15, 84);
    TextDrawSetSelectable(g_rgPokerGames[gameId][READY_TEXTDRAWS][5], 1);
    return;
}

Pkr_DestroyReadyTextDraws(const gameId)
{
    Pkr_ForeachPlayer(playerSlot)
    {
        TextDrawDestroy(g_rgPokerGames[gameId][READY_TEXTDRAWS][playerSlot]);
        g_rgPokerGames[gameId][READY_TEXTDRAWS][playerSlot] = Text: INVALID_TEXT_DRAW;
    }
    return;
}

#define Pkr_GetPlayerReady(%0) \
            GetPVarInt(%0, POKER_PLAYER_READY_VAR)

Pkr_SetPlayerReady(const gameId, const playerSlot)
{
    SetPVarInt(Pkr_GetPlayerId(gameId, playerSlot), POKER_PLAYER_READY_VAR, 1);
    Pkr_SetReadyTextDrawReady(gameId, playerSlot);
    return;
}

Pkr_SetPlayerNotReady(const gameId, const playerSlot)
{
    DeletePVar(Pkr_GetPlayerId(gameId, playerSlot), POKER_PLAYER_READY_VAR);
    Pkr_SetReadyTextDrawNotReady(gameId, playerSlot);
    return;
}

Pkr_GetPlayerReadyCount(const gameId)
{
    new count = 0;
    new playerId = INVALID_PLAYER_ID;
    Pkr_ForeachPlayer(playerSlot)
    {
        playerId = Pkr_GetPlayerId(gameId, playerSlot);
        if(playerId != INVALID_PLAYER_ID && Pkr_GetPlayerReady(playerId) == 1)
            count++;
    }
    return count;
}

bool: Pkr_PlayerReadyTextDrawClick(const playerid, const Text: clickedid)
{
    new _game = Pkr_GetPlayerGame(playerid);

    if(_game == -1)
        return false;

    new _slot = -1;

    #if defined POKER_DEBUG
        for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i)
        {
            if(g_rgPokerGames[_game][READY_TEXTDRAWS][_i] == clickedid)
            {
                _slot = _i;
                break;
            }
        }

        if(_slot == -1)
            return false;

        if(Pkr_GetPlayerId(_game, _slot) == INVALID_PLAYER_ID)
            return true;
    #else
        _slot = Pkr_GetPlayerSlot(playerid, _game);
    #endif

    if(_slot == -1)
        return false;

    if(clickedid != g_rgPokerGames[_game][READY_TEXTDRAWS][_slot])
        return false;

    if(Pkr_GetPlayerReady(g_rgPokerGames[_game][PLAYERS][_slot]))
        Pkr_SetPlayerNotReady(_game, _slot);
    else
        Pkr_SetPlayerReady(_game, _slot);
    PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);

    return true;
}

#define Pkr_ShowPlayerStatusTextDraw(%0,%1) \
            for(new i; i < MAX_POKER_PLAYERS; ++i) TextDrawShowForPlayer(%0, g_rgPokerGames[%1][PLAYER_STATUS_TEXTDRAWS][i])

#define Pkr_HidePlayerStatusTextDraw(%0,%1) \
            for(new i; i < MAX_POKER_PLAYERS; ++i) TextDrawHideForPlayer(%0, g_rgPokerGames[%1][PLAYER_STATUS_TEXTDRAWS][i])

#define Pkr_SetPlayerStatusTextDrawEmpty(%0,%1) \
            TextDrawSetString(g_rgPokerGames[%0][PLAYER_STATUS_TEXTDRAWS][%1], "_")

Pkr_SetPlayerStatusTextDraw(const gameId, const slot, const text[])
{
    new _status[128];
    format(_status, sizeof(_status), "%s: ~g~%s", pNome(g_rgPokerGames[gameId][PLAYERS][slot]), text);
    TextDrawSetString(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][slot], _status);

    return;
}

Pkr_CreatePlayerStatusTDs(const gameId)
{
    g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0] = TextDrawCreate(233.000000, 308.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][0], 0);

    g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1] = TextDrawCreate(182.000000, 245.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][1], 0);

    g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2] = TextDrawCreate(233.000000, 182.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][2], 0);

    g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3] = TextDrawCreate(407.000000, 182.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][3], 0);

    g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4] = TextDrawCreate(465.000000, 245.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][4], 0);

    g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5] = TextDrawCreate(408.000000, 308.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][5], 0);

    return;
}

Pkr_DestroyPlayerStatusTDs(const gameId)
{
    for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i)
    {
        TextDrawDestroy(g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][_i]);
        g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][_i] = Text: INVALID_TEXT_DRAW;
    }

    return;
}

#define Pkr_GetPlayerStatus(%0,%1) \
            g_rgPokerGames[%0][PLAYER_STATUS][%1]

#define Pkr_SetPlayerStatus(%0,%1,%2) \
            g_rgPokerGames[%0][PLAYER_STATUS][%1] = %2

stock Pkr_SetPlayerStatusInLobby(const gameId, const playerSlot) {
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: LOBBY);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, "LOBI");
    return;
}

stock Pkr_SetPlayerStatusWaiting(const gameId, const playerSlot) {
    new POKER_PLAYER_STATUS: playerStatus = Pkr_GetPlayerStatus(gameId, playerSlot);

    if(playerStatus == POKER_PLAYER_STATUS: FOLDED || playerStatus == POKER_PLAYER_STATUS: ALL_IN)
        return;

    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: WAITING);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, "BEKLIYOR");
    return;
}

stock Pkr_SetPlayerStatusPlaying(const gameId, const playerSlot) {
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: PLAYING);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, "OYNUYOR");
    return;
}

stock Pkr_SetPlayerStatusChecked(const gameId, const playerSlot) {
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: CHECKED);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, "GORDU");
    return;
}

stock Pkr_SetPlayerStatusAllIn(const gameId, const playerSlot) {
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: ALL_IN);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, "ALL-IN");
    return;
}

stock Pkr_SetPlayerStatusCalled(const gameId, const playerSlot, const amount) {
    new text[128];
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: CALLED);
    format(text, sizeof(text), "GORDU: ~r~$%d", amount);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, text);
    return;
}

stock Pkr_SetPlayerStatusBet(const gameId, const playerSlot, const amount)
{
    new text[128];
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: BET);
    format(text, sizeof(text), "BAHIS: ~r~$%d", amount);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, text);
    return;
}

stock Pkr_SetPlayerStatusRaised(const gameId, const playerSlot, const amount)
{
    new text[128];
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: RAISED);
    format(text, sizeof(text), "ARTTIRDI: ~r~$%d", amount);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, text);
    return;
}

stock Pkr_SetPlayerStatusFolded(const gameId, const playerSlot) {
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: FOLDED);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, "CEKILDI");
    return;
}

stock Pkr_SetPlayerStatusSmallBlind(const gameId, const playerSlot)
{
    new text[128];
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: SMALL_BLIND);
    format(text, sizeof(text), "KUCUK KOR BAHIS: ~r~$%d", Pkr_GetSmallBlind(gameId));
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, text);
    return;
}

stock Pkr_SetPlayerStatusBigBlind(const gameId, const playerSlot)
{
    new text[128];
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: BIG_BLIND);
    format(text, sizeof(text), "BUYUK KOR BAHIS: ~r~$%d", Pkr_GetBigBlind(gameId));
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, text);
    return;
}

stock Pkr_SetPlayerStatusDealer(const gameId, const playerSlot)
{
    if(Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: FOLDED || Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: ALL_IN)
        return;

    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: DEALER);
    Pkr_SetPlayerStatusTextDraw(gameId, playerSlot, "DEALER");
    return;
}

stock Pkr_SetPlayerStatusEvaluated(const gameId, const playerSlot)
{
    Pkr_SetPlayerStatus(gameId, playerSlot, POKER_PLAYER_STATUS: EVALUATED);
    return;
}

Pkr_SetAllPlayerStatusInLobby(const gameId)
{
    Pkr_ForeachPlayer(playerSlot)
    {
        if(Pkr_GetPlayerId(gameId, playerSlot) == INVALID_PLAYER_ID)
            continue;

        Pkr_SetPlayerStatusInLobby(gameId, playerSlot);
    }
    return;
}

Pkr_SetAllPlayerStatusWaiting(const gameId)
{
    Pkr_ForeachPlayer(playerSlot)
    {
        if(Pkr_GetPlayerId(gameId, playerSlot) == INVALID_PLAYER_ID)
            continue;

        Pkr_SetPlayerStatusWaiting(gameId, playerSlot);
    }
    return;
}

Pkr_CountPlayerStatus(const gameId, const POKER_PLAYER_STATUS: status)
{
    new count = 0;
    Pkr_ForeachPlayer(playerSlot)
    {
        if(Pkr_GetPlayerId(gameId, playerSlot) != INVALID_PLAYER_ID && Pkr_GetPlayerStatus(gameId, playerSlot) == status)
            count++;
    }
    return count;
}

stock bool: Pkr_ActivePlayers(const gameId)
{
    new count = 0;
    Pkr_ForeachPlayer(playerSlot)
    {
        if(Pkr_GetPlayerId(gameId, playerSlot) != INVALID_PLAYER_ID && (Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: WAITING || Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: DEALER || Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: PLAYING || Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: SMALL_BLIND))
            ++count;
    }
    return count > 0;
}

// TODO: Try and simplify this logic and remove calculating the contribution
stock Pkr_HasEveryonePlayed(const gameId)
{
    new count = 0;
    Pkr_ForeachPlayer(playerSlot)
    {
        if(Pkr_GetPlayerId(gameId, playerSlot) != INVALID_PLAYER_ID &&
           (Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: RAISED ||
            Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: BET ||
            Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: BIG_BLIND) ||
            (Pkr_GetPlayerStatus(gameId, playerSlot) == POKER_PLAYER_STATUS: ALL_IN && Pkr_GetPlayerBetContribution(gameId, playerSlot) > 0))
        {
            ++count;
        }
    }

    return count == 0 && !Pkr_ActivePlayers(gameId) && Pkr_GetLastAggressivePlayer(gameId) != INVALID_PLAYER_ID;
}

// TODO: Try and simplify this search it might not be needed
Pkr_GetFirstPlayerWithoutStatus(const gameId, const POKER_PLAYER_STATUS: playerState)
{
    Pkr_ForeachPlayer(playerSlot)
    {
        if(Pkr_GetPlayerId(gameId, playerSlot) != INVALID_PLAYER_ID && Pkr_GetPlayerStatus(gameId, playerSlot) != playerState)
            return playerSlot;
    }
    return -1;
}

#define Pkr_ShowPlayerChipsTextDraw(%0,%1) \
            for(new i; i < MAX_POKER_PLAYERS; ++i) TextDrawShowForPlayer(%0, g_rgPokerGames[%1][PLAYER_CHIPS_TEXTDRAWS][i])

#define Pkr_HidePlayerChipsTextDraw(%0,%1) \
            for(new i; i < MAX_POKER_PLAYERS; ++i) TextDrawHideForPlayer(%0, g_rgPokerGames[%1][PLAYER_CHIPS_TEXTDRAWS][i])

#define Pkr_SetPlayerChipsTextDraw(%0,%1,%2) \
            TextDrawSetString(g_rgPokerGames[%0][PLAYER_CHIPS_TEXTDRAWS][%1], %2)

Pkr_CreatePlayerChipsTDs(const gameId)
{
    g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0] = TextDrawCreate(233.000000, 254.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][0], 0);

    g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1] = TextDrawCreate(182.000000, 191.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][1], 0);

    g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2] = TextDrawCreate(233.000000, 128.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][2], 0);

    g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3] = TextDrawCreate(407.000000, 128.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][3], 0);

    g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4] = TextDrawCreate(464.000000, 191.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][4], 0);

    g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5] = TextDrawCreate(407.000000, 254.000000, "");
    TextDrawAlignment(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], 0.170000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][5], 0);

    return;
}

Pkr_DestroyPlayerChipsTDs(const gameId)
{
    for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i)
    {
        TextDrawDestroy(g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][_i]);
        g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][_i] = Text: INVALID_TEXT_DRAW;
    }

    return;
}

stock Pkr_SetPlayerChips(const gameId, const slot, const amount) {
    g_rgPokerGames[gameId][PLAYER_CHIPS][slot] = amount;
    new _chips[128];
    format(_chips, sizeof(_chips), "CIP: ~g~$%s", Pkr_FormatNumber(amount));
    Pkr_SetPlayerChipsTextDraw(gameId, slot, _chips);
}

stock Pkr_AddPlayerChips(const gameId, const slot, const amount)
{
    g_rgPokerGames[gameId][PLAYER_CHIPS][slot] += amount;
    new _chips[128];
    format(_chips, sizeof(_chips), "CIP: ~g~$%s", Pkr_FormatNumber(g_rgPokerGames[gameId][PLAYER_CHIPS][slot]));
    Pkr_SetPlayerChipsTextDraw(gameId, slot, _chips);
}

stock Pkr_MinusPlayerChips(const gameId, const slot, const amount)
{
    g_rgPokerGames[gameId][PLAYER_CHIPS][slot] -= amount;
    new _chips[128];
    format(_chips, sizeof(_chips), "CIP: ~g~$%s", Pkr_FormatNumber(g_rgPokerGames[gameId][PLAYER_CHIPS][slot]));
    Pkr_SetPlayerChipsTextDraw(gameId, slot, _chips);
}

Float: Pkr_ReturnAverageChips(const gameId) {
    new _total = 0;
    new _playerCount = 0;

	Pkr_ForeachPlayer(playerSlot) {
		if(Pkr_GetPlayerId(gameId, playerSlot) != INVALID_PLAYER_ID) {
			_total += g_rgPokerGames[gameId][PLAYER_CHIPS][playerSlot];
            _playerCount++;
		}
    }

    return _playerCount == 0 ? 0.0 : float(_total) / float(_playerCount);
}

PkrCMD_Chips(const playerid) {
	new gameId = Pkr_GetPlayerGame(playerid);

	if(gameId == -1) {
        SendClientMessage(playerid, COLOR_RED, "Poker oynamùyorsun.");
        return;
    }

	new POKER_GAME_STATUS: status = Pkr_GetGameStatus(gameId);
	if(status != POKER_GAME_STATUS: LOBBY) {
		SendClientMessage(playerid, COLOR_RED, "You can only buy more chips in the lobby!");
		return;
	}

	Pkr_ShowChipsDialog(playerid);
	return;
}

enum PLAYER_CHIPS_DIALOG_ERROR {
	NONE,
	NAN,
	NO_MONEY
}

Pkr_ShowChipsDialog(const playerid, const PLAYER_CHIPS_DIALOG_ERROR: error = PLAYER_CHIPS_DIALOG_ERROR: NONE)
{
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: CHIPS);

	new message[2048];
    format(message, sizeof(message), "Hey {FF9900}%s{A9C4E4},\n\nPlease insert an amount of chips you\nwishto add to your stack below.\n\nPlease ensure you add an amount\nwhich will allow you to meet the\nblinds.\n\n", pNome(playerid));

	switch(error)
    {
        case (PLAYER_CHIPS_DIALOG_ERROR: NAN):
            format(message, sizeof(message), "%s{D10047}You have entered an invalid number.\nPlease enter a valid amount of chips\nyou wish to add.{A9C4E4}\n\n", message);
        case (PLAYER_CHIPS_DIALOG_ERROR: NO_MONEY):
            format(message, sizeof(message), "%s{D10047}You cannot afford that many chips.\nPlease enter\na valid amount of chips\nyou wish to add.{A9C4E4}\n\n", message);
    }

	ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_INPUT, "Texas Hold 'em Poker - Add Chips", message, "Buy", "Cancel");
	Pkr_HideCursorForPlayerId(playerid);
    return;
}

Pkr_ShowChipsConfirmDialog(const playerid, const amount)
{
	new message[2048];
	SetPVarInt(playerid, POKER_CHIPS_VAR_NAME, amount);
	Pkr_SetPokerDialog(playerid, POKER_DIALOGS: CHIPS_CONFIRM);
	format(message, sizeof(message), "Are you sure you wish to add $%s chips to your stack?", Pkr_FormatNumber(amount));
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Texas Hold 'em Poker - Add Chips Confirm", message, "Confirm", "Back");
    return;
}

Pkr_PlayerChipsDialogResponse(const playerid, const response, const inputtext[]) {
    new pokerDialogId = Pkr_GetPokerDialog(playerid);
	new gameId = Pkr_GetPlayerGame(playerid);

    switch(pokerDialogId) {
        case (POKER_DIALOGS: CHIPS): {
			if(!response) {
				Pkr_ShowCursorForPlayerId(playerid);
				return;
			}

			new POKER_GAME_STATUS: status = Pkr_GetGameStatus(gameId);
			if(status != POKER_GAME_STATUS: LOBBY) {
				SendClientMessage(playerid, COLOR_RED, "You can only add more chips to your stack in the lobby.");
				return;
			}

			if(!Pkr_IsNumeric(inputtext)) {
				Pkr_ShowChipsDialog(playerid, PLAYER_CHIPS_DIALOG_ERROR: NAN);
				return;
			}

			new amount = strval(inputtext);
			new playerMoney = pInfo[playerid][pMoney];

			if(amount <= 0) {
				Pkr_ShowChipsDialog(playerid, PLAYER_CHIPS_DIALOG_ERROR: NAN);
				return;
			}

			if(amount > playerMoney) {
				Pkr_ShowChipsDialog(playerid, PLAYER_CHIPS_DIALOG_ERROR: NO_MONEY);
				return;
			}

			Pkr_ShowChipsConfirmDialog(playerid, amount);
            return;
        }

		case (POKER_DIALOGS: CHIPS_CONFIRM): {
			new amount = GetPVarInt(playerid, POKER_CHIPS_VAR_NAME);
			DeletePVar(playerid, POKER_CHIPS_VAR_NAME);

			if(!response) {
				Pkr_ShowChipsDialog(playerid);
				return;
			}

			new POKER_GAME_STATUS: status = Pkr_GetGameStatus(gameId);
			if(status != POKER_GAME_STATUS: LOBBY) {
				SendClientMessage(playerid, COLOR_RED, "You can only add more chips to your stack in the lobby.");
				return;
			}

			new slot = Pkr_GetPlayerSlot(playerid, gameId);

			Pkr_AddPlayerChips(gameId, slot, amount);
			GivePlayerMoney(playerid, -amount);
			Pkr_ShowCursorForPlayerId(playerid);
			Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s has added $%s chips to their stack.", pNome(playerid), Pkr_FormatNumber(amount));
            //Pkr_Log("%s has added $%s chips to their stack on GameId %d.", pNome(playerid), Pkr_FormatNumber(amount), gameId);
			return;
		}
    }
    return;
}

#define Pkr_IsValidGameId(%0) \
            (0 <= %0 < MAX_POKER_GAMES)



Pkr_InitialisePoker() {
    for(new _i = 0; _i < MAX_POKER_GAMES; ++_i)
        Pkr_InitialiseGame(_i);

    Pkr_InitDeck();
}

Pkr_GetGameCount() {
    new _count = 0;
    for(new _i = 0; _i < MAX_POKER_GAMES; ++_i)
        if(g_rgPokerGames[_i][IS_ASSIGNED])
            ++_count;
    return _count;
}

#define Pkr_GetIsAssigned(%0) \
            g_rgPokerGames[%0][IS_ASSIGNED]

#define Pkr_SetIsAssigned(%0,%1) \
        g_rgPokerGames[%0][IS_ASSIGNED] = %1

stock bool: Pkr_GetPosition(const gameId, &Float: x, &Float: y, &Float: z) {
    if(Pkr_IsValidGameId(gameId)) {
        x = g_rgPokerGames[gameId][POSITION][PokerX];
        y = g_rgPokerGames[gameId][POSITION][PokerY];
        z = g_rgPokerGames[gameId][POSITION][PokerZ];
        return true;
    }
    return false;
}

bool: Pkr_SetPosition(const gameId, const Float: x, const Float: y, const Float: z) {
    if(Pkr_IsValidGameId(gameId)) {
        g_rgPokerGames[gameId][POSITION][PokerX] = x;
        g_rgPokerGames[gameId][POSITION][PokerY] = y;
        g_rgPokerGames[gameId][POSITION][PokerZ] = z;
        return true;
    }
    return false;
}

Pkr_InitialiseGame(const gameId) {
    g_rgPokerGames[gameId][IS_ASSIGNED] = false;
    g_rgPokerGames[gameId][POT_TEXTDRAW] = Text: INVALID_TEXT_DRAW;
    g_rgPokerGames[gameId][POT] = 0;
    g_rgPokerGames[gameId][BLIND] = 0;
    g_rgPokerGames[gameId][MENU_ITEM_ONE_STATE] = POKER_MENU_STATES: BET;
    g_rgPokerGames[gameId][MENU_ITEM_TWO_STATE] = POKER_MENU_STATES: CALL;
    g_rgPokerGames[gameId][DEALER] = INVALID_PLAYER_ID;
    g_rgPokerGames[gameId][SMALL_BLIND_POSITION] = -1;
    g_rgPokerGames[gameId][BIG_BLIND_POSITION] = -1;
    g_rgPokerGames[gameId][GAME_STATUS] = POKER_GAME_STATUS: LOBBY;
    Pkr_SetCurrentBet(gameId, 0);
    Pkr_SetCurrentPlayerPosition(gameId, -1);
    Pkr_SetLastAggressivePlayer(gameId, INVALID_PLAYER_ID);
    Pkr_SetLastBet(gameId, 0);
    Pkr_SetObjectId(gameId, INVALID_OBJECT_ID);
	Pkr_SetTimerStart(gameId, MAX_POKER_TIMER);
	Pkr_SetTimer(gameId, MAX_POKER_TIMER);
	Pkr_SetBusiness(gameId, -1);

    for(new _j = 0; _j < MAX_POKER_PLAYERS; ++_j) {
        g_rgPokerGames[gameId][PLAYERS][_j] = INVALID_PLAYER_ID;
        g_rgPokerGames[gameId][READY_TEXTDRAWS][_j] = Text: INVALID_TEXT_DRAW;
        g_rgPokerGames[gameId][PLAYER_STATUS_TEXTDRAWS][_j] = Text: INVALID_TEXT_DRAW;
        g_rgPokerGames[gameId][PLAYER_CHIPS_TEXTDRAWS][_j] = Text: INVALID_TEXT_DRAW;
        g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][_j] = Text: INVALID_TEXT_DRAW;
        g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][_j] = Text: INVALID_TEXT_DRAW;
        g_rgPokerGames[gameId][PLAYER_CHIPS][_j] = 0;
        g_rgPokerGames[gameId][PLAYER_STATUS][_j] = POKER_PLAYER_STATUS: EMPTY;
        g_rgPokerGames[gameId][PLAYER_CARD_ONE_VALUE][_j] = -1;
        g_rgPokerGames[gameId][PLAYER_CARD_TWO_VALUE][_j] = -1;
        g_rgPokerGames[gameId][PLAYER_POT_CONTRIBUTIONS][_j] = 0;
        Pkr_SetPlayerBetContribution(gameId, _j, 0);
    }

    for(new _i = 0; _i < MAX_TABLE_CARDS; ++_i)
    {
        g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][_i] = Text: INVALID_TEXT_DRAW;
        g_rgPokerGames[gameId][TABLE_CARD_VALUES][_i] = -1;
    }
    return;
}

Pkr_GetUnassignedGame() {
    for(new i = 0; i < MAX_POKER_GAMES; ++i) {
        if(g_rgPokerGames[i][IS_ASSIGNED] == false) {
            return i;
        }
    }
    return -1;
}

Pkr_CreateGame(const Float: x, const Float: y, const Float: z) {
    new _gameId = Pkr_GetUnassignedGame();
    if(_gameId != -1) {
        Pkr_SetIsAssigned(_gameId, true);
        Pkr_SetPosition(_gameId, x, y, z);
        Pkr_CreateGameTextDraws(_gameId);
        Pkr_SetBlind(_gameId, POKER_DEFAULT_BLIND);
        return _gameId;
    }
    return -1;
}

Pkr_CreateGameByObjectId(const objectId, const businessId = -1) {
    new Float: x, Float: y, Float: z;
    if(GetDynamicObjectPos(objectId, x, y, z) == 0)
        return -1;
    new gameId = Pkr_CreateGame(x, y, z);
    Pkr_SetObjectId(gameId, objectId);
	if(businessId != -1)
		Pkr_SetBusiness(gameId, businessId);
    return gameId;
}

Pkr_DestroyGame(const gameId) {
	Pkr_ForeachPlayer(playerSlot) {
		Pkr_UnassignPlayerSlotFromGame(gameId, playerSlot);
	}
	Pkr_UnassignAllSpectators(gameId);
    Pkr_DestroyGameTextDraws(gameId);
    Pkr_InitialiseGame(gameId);
    return;
}

Pkr_GetGameByObjectId(const objectId) {
    if(objectId == INVALID_OBJECT_ID) {
        return -1;
    }

    Pkr_ForeachGame(gameId) {
        if(Pkr_GetObjectId(gameId) == objectId)
            return gameId;
    }

    return -1;
}

bool: HaveAllPlayersFolded(const gameId)
{
    new amountOfPlayersOnGame = Pkr_GetAmountOfPlayersOnGame(gameId);
    new amountOfPlayerAllIn = Pkr_CountPlayerStatus(gameId, POKER_PLAYER_STATUS: ALL_IN);
    new amountOfFoldedPlayers = Pkr_CountPlayerStatus(gameId, POKER_PLAYER_STATUS: FOLDED);
    return (amountOfFoldedPlayers == amountOfPlayersOnGame - amountOfPlayerAllIn) || (amountOfFoldedPlayers == (amountOfPlayersOnGame - 1 - amountOfPlayerAllIn)) && amountOfFoldedPlayers > 0;
}

bool: HaveAllPlayersChecked(const gameId)
{
    new amountOfPlayersOnGame = Pkr_GetAmountOfPlayersOnGame(gameId);
    new amountOfPlayersFolded = Pkr_CountPlayerStatus(gameId, POKER_PLAYER_STATUS: FOLDED);
    new amountOfPlayersAllIn = Pkr_CountPlayerStatus(gameId, POKER_PLAYER_STATUS: ALL_IN);
    new amountOfCheckedPlayers = Pkr_CountPlayerStatus(gameId, POKER_PLAYER_STATUS: CHECKED);
    return amountOfCheckedPlayers == amountOfPlayersOnGame - amountOfPlayersFolded - amountOfPlayersAllIn && amountOfCheckedPlayers > 1;
}

stock Pkr_SetNextPlayerPlaying(const gameId)
{
    /*
        When the betting round has completed one full circle around the table,
        if no player has taken an aggressive action (that is, if no player has bet),
        then the betting round is over, and the poker hand continues according to the rules of the variant being played.

        If one or more players have taken an aggressive action, then the betting round continues clockwise
        around the table until the most recent aggressive action has been closed. This is achieved either by all
        ctive players other than the most recent aggressor folding, or by all active players other than the most
        recent aggressor calling the aggressor's bet or raise.
    */

    new activePlayer = Pkr_GetCurrentPlayerPosition(gameId);
    new haveAllPlayersFolded = HaveAllPlayersFolded(gameId);
    new haveAllPlayersChecked = HaveAllPlayersChecked(gameId);
    new plays = Pkr_GetAmountOfPlays(gameId);
    new amountOfPlayers = Pkr_GetAmountOfPlayersOnGame(gameId);
    new amountOfFoldedPlayers = Pkr_CountPlayerStatus(gameId, POKER_PLAYER_STATUS: FOLDED);
    new amountOfAllInPlayers = Pkr_CountPlayerStatus(gameId, POKER_PLAYER_STATUS: ALL_IN);
    new activePlayers = amountOfPlayers - amountOfFoldedPlayers - amountOfAllInPlayers;

	if(amountOfFoldedPlayers == amountOfPlayers - 1)
	{
		new nonFoldedPlayer = Pkr_GetFirstPlayerWithoutStatus(gameId, FOLDED);
		new nonFoldedPlayerId = Pkr_GetPlayerId(gameId, nonFoldedPlayer);

		new pot = Pkr_GetPotAmount(gameId);
		// new rakeAmount = Pkr_TakeRake(gameId, pot);
		if(rakeAmount > 0.0)
			pot -= rakeAmount;

		Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s wins the game due to all players folding.", pNome(nonFoldedPlayerId));
        //Pkr_Log("%s wins GameId: %d with pot: $%d due to all players folding.", pNome(nonFoldedPlayerId), gameId, pot);
		Pkr_AddPlayerChips(gameId, nonFoldedPlayer, pot);
		Pkr_SetPotAmount(gameId, 0);
		Pkr_SetGameToLobby(gameId);
		return;
	}

    if(amountOfPlayers == amountOfAllInPlayers) {
		Pkr_DealRemainingRounds(gameId);
        return;
    }

    if(haveAllPlayersFolded && (activePlayers == 0 || amountOfPlayers == 2))
    {
        if(amountOfAllInPlayers > 1) {
			Pkr_DealRemainingRounds(gameId);
            return;
        }

        new nonFoldedPlayer = Pkr_GetFirstPlayerWithoutStatus(gameId, FOLDED);
        new nonFoldedPlayerId = Pkr_GetPlayerId(gameId, nonFoldedPlayer);

		new pot = Pkr_GetPotAmount(gameId);
		// new rakeAmount = Pkr_TakeRake(gameId, pot);
		if(rakeAmount > 0.0)
			pot -= rakeAmount;

        Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s wins the game due to all players folding.", pNome(nonFoldedPlayerId));
        //Pkr_Log("%s wins GameId: %d with pot: $%d due to all players folding.", pNome(nonFoldedPlayerId), gameId, pot);
        Pkr_AddPlayerChips(gameId, nonFoldedPlayer, pot);
        Pkr_SetPotAmount(gameId, 0);
        Pkr_SetGameToLobby(gameId);
        return;
    }

    if(haveAllPlayersChecked) {
        Pkr_DealNextRound(gameId);
        return;
    }

    if(plays == activePlayers) {
        if(activePlayers == 1) {
			Pkr_DealRemainingRounds(gameId);
            return;
        }

        Pkr_DealNextRound(gameId);
        return;
    }

    new _nextPlayer = Pkr_FindNextPlayer(gameId, activePlayer);
    Pkr_SetPlayerPlaying(gameId, _nextPlayer);
    return;
}

stock Pkr_SetPlayerPlaying(const gameId, const playerSlot)
{
	Pkr_SetTimerValue(gameId, Pkr_GetTimerStart(gameId));
	Pkr_SetCurrentPlayerPosition(gameId, playerSlot);

    if(Pkr_GetCurrentBet(gameId) > 0)
        Pkr_SetMenuItemOneStateRaise(gameId);
    else
        Pkr_SetMenuItemOneStateBet(gameId);

    if(Pkr_GetCurrentBet(gameId) > Pkr_GetPlayerBetContribution(gameId, playerSlot))
        Pkr_SetMenuItemTwoStateCall(gameId);
    else
        Pkr_SetMenuItemTwoStateCheck(gameId);

	new playerid = Pkr_GetPlayerId(gameId, playerSlot);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    Pkr_SetPlayerStatusPlaying(gameId, playerSlot);
    return;
}

stock Pkr_StartGame(const gameId)
{
	for(new _j, _playerId = INVALID_PLAYER_ID; _j < MAX_POKER_PLAYERS; ++_j)
    {
        _playerId = Pkr_GetPlayerId(gameId, _j);
        if(_playerId == INVALID_PLAYER_ID)
            continue;

        Pkr_HidePlayerReadyTextDraw(_playerId, gameId);
        Pkr_ClearPlayerCards(gameId, _j);
        Pkr_DealPlayerCard(gameId, _j);
        Pkr_DealPlayerCard(gameId, _j);
        Pkr_SetPlayerStatusWaiting(gameId, _j);
    }

    new _dealer = PkrSys_GetNextDealer(gameId);
    if(_dealer != -1)
    {
        Pkr_SetDealerPosition(gameId, _dealer);
        Pkr_SetPlayerStatusDealer(gameId, _dealer);
    }

    PkrSys_AssignBlinds(gameId);
    Pkr_StartBettingRound(gameId);
    Pkr_SetGameStatus(gameId, INITIAL_BETTING);

    return;
}

stock Pkr_StartBettingRound(const gameId)
{
    new _startingPlayer = Pkr_FindNextPlayer(gameId, Pkr_GetBigBlindPosition(gameId));
    Pkr_SetPlayerPlaying(gameId, _startingPlayer);

    return;
}

stock Pkr_DealNextRound(const gameId)
{
    switch(Pkr_GetGameStatus(gameId))
    {
        case (POKER_GAME_STATUS: INITIAL_BETTING):
            Pkr_DealFlop(gameId);

        case (POKER_GAME_STATUS: FLOP):
            Pkr_DealTurn(gameId);

        case (POKER_GAME_STATUS: TURN):
            Pkr_DealRiver(gameId);

        case (POKER_GAME_STATUS: RIVER):
            Pkr_Evaluate(gameId);
    }

    Pkr_SetCurrentBet(gameId, 0);
    Pkr_SetLastAggressivePlayer(gameId, INVALID_PLAYER_ID);
    Pkr_SetLastBet(gameId, 0);
    Pkr_ResetPlayerBetContributions(gameId);
    Pkr_SetAmountOfPlays(gameId, 0);

    new dealerPosition = Pkr_GetDealerPosition(gameId);
    Pkr_SetAllPlayerStatusWaiting(gameId);

	new dealerPlayerId = Pkr_GetPlayerId(gameId, dealerPosition);
	if(dealerPlayerId != INVALID_PLAYER_ID)
		Pkr_SetPlayerStatusDealer(gameId, dealerPosition);


    new _nextPlayer = Pkr_FindNextPlayer(gameId, dealerPosition);
    Pkr_SetPlayerPlaying(gameId, _nextPlayer);
    return;
}

stock Pkr_DealFlop(const gameId)
{
    Pkr_SetGameStatus(gameId, POKER_GAME_STATUS: FLOP);
    Pkr_DealTableCard(gameId);
    Pkr_DealTableCard(gameId);
    Pkr_DealTableCard(gameId);

    return;
}

stock Pkr_DealTurn(const gameId)
{
    Pkr_SetGameStatus(gameId, POKER_GAME_STATUS: TURN);
    Pkr_DealTableCard(gameId);

    return;
}

stock Pkr_DealRiver(const gameId)
{
    Pkr_SetGameStatus(gameId, POKER_GAME_STATUS: RIVER);
    Pkr_DealTableCard(gameId);

    return;
}

Pkr_DealRemainingRounds(const gameId)
{
    switch(Pkr_GetGameStatus(gameId))
    {
        case (POKER_GAME_STATUS: INITIAL_BETTING):
        {
            Pkr_DealFlop(gameId);
            Pkr_DealTurn(gameId);
            Pkr_DealRiver(gameId);
            Pkr_Evaluate(gameId);
        }


        case (POKER_GAME_STATUS: FLOP):
        {
            Pkr_DealTurn(gameId);
            Pkr_DealRiver(gameId);
            Pkr_Evaluate(gameId);
        }

        case (POKER_GAME_STATUS: TURN):
        {
            Pkr_DealRiver(gameId);
            Pkr_Evaluate(gameId);
        }

        case (POKER_GAME_STATUS: RIVER):
        {
            Pkr_Evaluate(gameId);
        }
    }

    return;
}


/*Pkr_TakeRake(const gameId, const pot) {
	new businessId = Pkr_GetBusiness(gameId);

	if(businessId != -1) {
		new Float: rake = Pkr_GetRake(businessId);

		if(rake > 0.0) {
			// new rakeAmount = floatround((pot / 100) * rake);

			//BusinessData[businessId][BusinessCashbox] += rakeAmount;

			new rakeMessage[128];
			format(rakeMessage, sizeof(rakeMessage), "The business has taken a %.1f percentage rake off of the pot which amounts to: $%s", rake, Pkr_FormatNumber(rakeAmount));
			Pkr_SendGameMessage(gameId, COLOR_ORANGE, rakeMessage);
			return rakeAmount;
		}
	}
	return 0;
}*/

stock Pkr_Evaluate(const gameId)
{
    Pkr_SetGameStatus(gameId, POKER_GAME_STATUS: EVALUATION);
	Pkr_ShowAllPlayerCards(gameId);

    new _sz[128];
    new _winners[MAX_POKER_PLAYERS] = {INVALID_PLAYER_ID, ...};
    new _value = Pkr_FindWinner(gameId, _winners);
    new _wincount;
    for(new i; i < MAX_POKER_PLAYERS; ++i)
        if(_winners[i] != INVALID_PLAYER_ID)
            ++_wincount;

    if(Pkr_CountPlayerStatus(gameId, POKER_PLAYER_STATUS: ALL_IN) == 0)
    {
		if(_wincount > 1)
        {
			new pot = Pkr_GetPotAmount(gameId);

			// new rakeAmount = Pkr_TakeRake(gameId, pot);
            if(rakeAmount > 0) {
				pot -= rakeAmount;
            }

			new _split = floatround(pot / _wincount);

			new message[128];

			for(new i; i < _wincount; ++i) {
                if(_winners[i] == INVALID_PLAYER_ID)
                    continue;
                Pkr_AddPlayerChips(gameId, _winners[i], _split);
				new playerId = Pkr_GetPlayerId(gameId, _winners[i]);
				format(message, sizeof(message), "%s %s", message, pNome(playerId));
			}
			Pkr_SetPotAmount(gameId, 0);

            format(message, sizeof(message), "Pot {CC6600}%s {FF9900}arasùnda %s en yùksek %i deùeriyle paylaùtùrùldù.", message, Pkr_ReturnHandName(Pkr_HandRank(_value)), _value);
            Pkr_SendGameMessage(gameId, COLOR_ORANGE, message);
            //Pkr_Log("The pot: %d has been split: $%d between %s due to players having a %s with a value of %i for GameId: %d.", pot, _split, message, Pkr_ReturnHandName(Pkr_HandRank(_value)), _value, gameId);
        }
        else // One winner
        {
            new pot = Pkr_GetPotAmount(gameId);
            // new rakeAmount = Pkr_TakeRake(gameId, pot);
            if(rakeAmount > 0) {
				pot -= rakeAmount;
            }

			format(_sz, sizeof(_sz), "{CC6600}%s {FF9900}($%s) miktarlùk potu %s en yùksek %i deùeriyle kazandù.", pNome(g_rgPokerGames[gameId][PLAYERS][_winners[0]]), Pkr_FormatNumber(Pkr_GetPotAmount(gameId)), Pkr_ReturnHandName(Pkr_HandRank(_value)), _value);
            Pkr_SendGameMessage(gameId, COLOR_ORANGE, _sz);
            Pkr_SetPlayerChips(gameId, _winners[0], Pkr_GetPlayerChips(gameId, _winners[0]) + Pkr_GetPotAmount(gameId));
            //Pkr_Log("%s wins the pot ($%s) with a %s and a value of %i for GameId: %d.", pNome(g_rgPokerGames[gameId][PLAYERS][_winners[0]]), Pkr_FormatNumber(Pkr_GetPotAmount(gameId)), Pkr_ReturnHandName(Pkr_HandRank(_value)), _value, gameId);
            Pkr_SetPotAmount(gameId, 0);
        }
    }
    else
    {
		/*
            ORDER EVERY CONTRIBUTION ASCENDING
            MINUS LOWEST FROM EVERY PLAYER
            CHECK WINNER

            LOWEST CONTRIBUTOR EXCLUDED
            ORDER AGAIN
            MINUS LOWEST
            CHECK WINNER

            REPEAT
        */


		// All of the contributions
		/*
			0: Player Slot
			1: Amount
		*/
		new count; // The count of the pots dished out...
        new contributions[MAX_POKER_PLAYERS][2];

		new contributionSum = 0;

        for(new i; i < MAX_POKER_PLAYERS; ++i) {
            contributions[i][0] = i;
            contributions[i][1] = Pkr_GetPlayerPotContribution(gameId, i);
			contributionSum += contributions[i][1];
        }

        Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "Pot'a yapùlan toplam katkù: $%d ùu anki pot miktarù: $%d.", contributionSum, Pkr_GetPotAmount(gameId));

		// Ordered contributions bubble sort...
        for(new i; i < MAX_POKER_PLAYERS; ++i)
        {
            for(new j; j < MAX_POKER_PLAYERS; ++j)
            {
                if(contributions[i][1] < contributions[j][1])
                {
					new tmp = contributions[i][0];
                    contributions[i][0] = contributions[j][0];
                    contributions[j][0] = tmp;

                    tmp = contributions[i][1];
                    contributions[i][1] = contributions[j][1];
                    contributions[j][1] = tmp;
                }
            }
        }

		// Foreach contribution
		for(new i; i < MAX_POKER_PLAYERS; ++i) {

			// If there is nothing in this contribution continue...
			if(contributions[i][1] == 0) {
				// Mark the player as evaluated, they contributed nothing...
				Pkr_SetPlayerStatusEvaluated(gameId, contributions[i][0]);
				continue;
			}

			// Reset the last winners...
			for(new j; j < MAX_POKER_PLAYERS; ++j)
				_winners[j] = INVALID_PLAYER_ID;

			// Get the winner...
			_value = Pkr_FindWinner(gameId, _winners);

			// Store the current lowest value...
			new lowest = contributions[i][1];

			new pot;

			// Foreach player
			for(new j; j < MAX_POKER_PLAYERS; ++j) {
				if(Pkr_GetPlayerStatus(gameId, contributions[j][0]) != POKER_PLAYER_STATUS: EVALUATED && contributions[j][1] != 0) {
					pot += lowest;
					contributions[j][1] -= lowest;
				}
			}

			// The lowest contributor has now been excluded...
			Pkr_SetPlayerStatusEvaluated(gameId, contributions[i][0]);

			_wincount = 0;
			for(new j; j < MAX_POKER_PLAYERS; ++j)
				if(_winners[j] != INVALID_PLAYER_ID) ++_wincount;

			if(_wincount > 1) // Multiple winners
			{
                new originalPot = pot;
                // new rakeAmount = Pkr_TakeRake(gameId, pot);
                if(rakeAmount > 0) {
    				pot -= rakeAmount;
                }

				Pkr_SubFromPot(gameId, originalPot);

				new message[128];

				for(new j = 0; j < _wincount; ++j) {
					if(_winners[j] == INVALID_PLAYER_ID)
						continue;
					format(message, sizeof(message), "%s %s", message, pNome(g_rgPokerGames[gameId][PLAYERS][_winners[j]]));
				}


				format(message, sizeof(message), "{CC6600}%s {FF9900}($%s) miktarlùk %s %s en yùksek %i deùeriyle kazandùlar.", message, Pkr_FormatNumber(pot), (count == 0) ? ("ana potu") : ("yan potu"), Pkr_ReturnHandName(Pkr_HandRank(_value)), _value);
                ////Pkr_Log("%s are the winners of the %s ($%s) with a %s and a value of %i for GameId: %d.", message, (count == 0) ? ("ana pot") : ("yan pot"), Pkr_FormatNumber(pot), Pkr_ReturnHandName(Pkr_HandRank(_value)), _value, gameId);
                Pkr_SendGameMessage(gameId, COLOR_ORANGE, message);

				new _split = floatround(pot / _wincount);

				// Give the split to each player who won...
				for(new j = 0; j < _wincount; ++j) {
                    if(_winners[j] == INVALID_PLAYER_ID)
                        continue;
					Pkr_AddPlayerChips(gameId, _winners[j], _split);
                    //Pkr_Log("%s wins the split with a value of $%d for GameId: %d.", pNome(g_rgPokerGames[gameId][PLAYERS][_winners[j]]), gameId, _split);
				}
			}
            else if(_wincount == 0)
            {
                Pkr_SubFromPot(gameId, pot);
                //Pkr_Log("Looks like no one is elligable for these chips due to a disconnect $%d.", pot);
            }
			else
			{
				new originalPot = pot;

                // new rakeAmount = Pkr_TakeRake(gameId, pot);
                if(rakeAmount > 0) {
    				pot -= rakeAmount;
                }

				format(_sz, sizeof(_sz), "{CC6600}%s {FF9900}($%s) miktarlùk %s %s en yùksek %i deùeriyle kazandù.", pNome(g_rgPokerGames[gameId][PLAYERS][_winners[0]]), Pkr_FormatNumber(pot), (count == 0) ? ("ana potu") : ("yan potu"), Pkr_ReturnHandName(Pkr_HandRank(_value)), _value);
				Pkr_SendGameMessage(gameId, COLOR_ORANGE, _sz);
                ////Pkr_Log("%s is the winner of the %s ($%s) with a %s and a value of %i for GameId: %d.", pNome(g_rgPokerGames[gameId][PLAYERS][_winners[0]]), (count == 0) ? ("ana pot") : ("yan pot"), Pkr_FormatNumber(pot), Pkr_ReturnHandName(Pkr_HandRank(_value)), _value, gameId);
				Pkr_AddPlayerChips(gameId, _winners[0], pot);
				Pkr_SubFromPot(gameId, originalPot);
			}

			++count;
		}
    }

    Pkr_SendFormattedGameMessage(gameId, COLOR_GREY, "'/pkr sonrakiel' yazarak yeni bir el baùlatabilirsin.");
    return;
}

stock Pkr_SetGameToLobby(const gameId)
{
    PkrClearTableCards(gameId);
    Pkr_ClearAllPlayerCards(gameId);
    Pkr_SetAllPlayerStatusInLobby(gameId);
    Pkr_SetAllPlayersNotReady(gameId);
    Pkr_ShowAllPlayersReadyTextDraw(gameId);
    Pkr_SetSmallBlindPosition(gameId, -1);
    Pkr_SetBigBlindPosition(gameId, -1);
    Pkr_SetGameStatus(gameId, POKER_GAME_STATUS: LOBBY);
    Pkr_SetAllPlayerPotContribution(gameId, 0);
    Pkr_ResetPlayerBetContributions(gameId);
    Pkr_SetPotAmount(gameId, 0);
    Pkr_SetLastBet(gameId, 0);
    Pkr_SetAmountOfPlays(gameId, 0);
	Pkr_SetTimerTextDrawText(gameId, "_");
    Pkr_SendFormattedGameMessage(gameId, COLOR_GREY, "'/pkr baslat' yazarak eli baùlatabilirsin.");
    return;
}

Pkr_BlindMeetCheck(const gameId) {
	new playerid = INVALID_PLAYER_ID;
	for(new i; i < MAX_POKER_PLAYERS; ++i)
	{
		playerid = Pkr_GetPlayerId(gameId, i);
		if(playerid != INVALID_PLAYER_ID)
		{
			if(Pkr_GetPlayerChips(gameId, i) < Pkr_GetSmallBlind(gameId))
			{
				SendClientMessage(playerid, COLOR_RED, "You cannot meet the small blind, you have been removed from the game.");
				Pkr_UnassignPlayerFromGame(playerid, gameId);
			}
		}
	}
	return;
}

static stock Pkr_FindNextPlayer(const gameId, const currentPlayer)
{
    new _nextPlayer = currentPlayer + 1;
    new bool: _found = false;

    do
    {
        if(_nextPlayer == MAX_POKER_PLAYERS)
            _nextPlayer = 0;

        if(Pkr_GetPlayerId(gameId, _nextPlayer) != INVALID_PLAYER_ID && Pkr_GetPlayerStatus(gameId, _nextPlayer) != POKER_PLAYER_STATUS: FOLDED && Pkr_GetPlayerStatus(gameId, _nextPlayer) != POKER_PLAYER_STATUS: ALL_IN)
        {
            _found = true;
            break;
        }

        _nextPlayer++;
    }
    while(_found == false);

    return _nextPlayer;
}

static stock PkrSys_GetNextDealer(const gameId)
{
	new
		_found,
		_count,
		_current = (g_rgPokerGames[gameId][DEALER] != INVALID_PLAYER_ID) ? g_rgPokerGames[gameId][DEALER] + 1 : 0;
	do
	{
		if(_count > MAX_POKER_PLAYERS) return -1;
		if(_current >= MAX_POKER_PLAYERS) _current = 0;
		if(g_rgPokerGames[gameId][PLAYERS][_current] != INVALID_PLAYER_ID)
		{
			if(_current != g_rgPokerGames[gameId][DEALER])
			{
				_found = 1;
				g_rgPokerGames[gameId][DEALER] = _current;
			}
			else
			{
				_count++;
				_current++;
			}
		}
		else
		{
			_count++;
			_current++;
		}
	}
	while(!_found);

	return _current;
}

static stock PkrSys_AssignBlinds(const gameId)
{
    new _smallBlindPosition = PkrSys_FindNextPlayerForBlind(gameId);
    Pkr_SetSmallBlindPosition(gameId, _smallBlindPosition);
    new _bigBlindPosition = PkrSys_FindNextPlayerForBlind(gameId);
    Pkr_SetBigBlindPosition(gameId, _bigBlindPosition);

    Pkr_SetPlayerStatusSmallBlind(gameId, _smallBlindPosition);
    Pkr_AddToPlayerPotContribution(gameId, _smallBlindPosition, Pkr_GetSmallBlind(gameId));
    Pkr_SetPlayerChips(gameId, _smallBlindPosition, Pkr_GetPlayerChips(gameId, _smallBlindPosition) - Pkr_GetSmallBlind(gameId));
    //Pkr_Log("%s is the small blind $%d for GameId: %d", pNome(Pkr_GetPlayerId(gameId, _smallBlindPosition)), Pkr_GetSmallBlind(gameId), gameId);
    Pkr_AddToPot(gameId, Pkr_GetSmallBlind(gameId));
    Pkr_AddToPlayerBetContribution(gameId, _smallBlindPosition, Pkr_GetSmallBlind(gameId));

    Pkr_SetPlayerStatusBigBlind(gameId, _bigBlindPosition);
    Pkr_AddToPlayerPotContribution(gameId, _bigBlindPosition, Pkr_GetBigBlind(gameId));
    Pkr_SetPlayerChips(gameId, _bigBlindPosition, Pkr_GetPlayerChips(gameId, _bigBlindPosition) - Pkr_GetBigBlind(gameId));
    //Pkr_Log("%s is the big blind $%d for GameId: %d", pNome(Pkr_GetPlayerId(gameId, _bigBlindPosition)), Pkr_GetBigBlind(gameId), gameId);
    Pkr_SetCurrentBet(gameId, Pkr_GetBigBlind(gameId));
    Pkr_AddToPot(gameId, Pkr_GetBigBlind(gameId));
    Pkr_AddToPlayerBetContribution(gameId, _bigBlindPosition, Pkr_GetBigBlind(gameId));
    Pkr_SetLastAggressivePlayer(gameId, _bigBlindPosition);
    Pkr_SetLastBet(gameId, Pkr_GetBigBlind(gameId));


    Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s tarafùndan en yùksek: $%d.", pNome(Pkr_GetPlayerId(gameId, _bigBlindPosition)), Pkr_GetBigBlind(gameId));
    Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "Aktif pot ùu an: $%d", Pkr_GetPotAmount(gameId));
    return;
}

static stock PkrSys_FindNextPlayerForBlind(const gameId)
{
    new _playerSlot = -1;
    new _currentSlot;
    new _playerCount = Pkr_GetAmountOfPlayersOnGame(gameId);

    if(_playerCount == 2 && Pkr_GetSmallBlindPosition(gameId) == -1)
        return Pkr_GetDealerPosition(gameId);

    if(Pkr_GetSmallBlindPosition(gameId) == -1)
    {
        _currentSlot = Pkr_GetDealerPosition(gameId) + 1;
    }
    else if(Pkr_GetBigBlindPosition(gameId) == -1)
    {
        _currentSlot = Pkr_GetSmallBlindPosition(gameId) + 1;
    }
    else
        return -1;

    while(_playerSlot == -1)
    {
        if(_currentSlot == MAX_POKER_PLAYERS)
            _currentSlot = 0;

        if(Pkr_GetPlayerId(gameId, _currentSlot) != INVALID_PLAYER_ID)
        {
            _playerSlot = _currentSlot;
            break;
        }

        _currentSlot++;
    }

    return _currentSlot;
}

stock Pkr_FindWinner(const gameId, winners[MAX_POKER_PLAYERS])
{
	new _value = -1;
	for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i) winners[_i] = INVALID_PLAYER_ID;
	for(new _i, _b = 0, _newValue, _oldValue = 999999, _handArray[7]; _i < MAX_POKER_PLAYERS; ++_i)
	{
		if(g_rgPokerGames[gameId][PLAYERS][_i] != INVALID_PLAYER_ID)
		{
			if(Pkr_GetPlayerStatus(gameId, _i) != POKER_PLAYER_STATUS: FOLDED && Pkr_GetPlayerStatus(gameId, _i) != POKER_PLAYER_STATUS: EVALUATED)
			{
				_handArray[0] = g_rgPokerGames[gameId][PLAYER_CARD_ONE_VALUE][_i];
				_handArray[1] = g_rgPokerGames[gameId][PLAYER_CARD_TWO_VALUE][_i];

				_handArray[2] = g_rgPokerGames[gameId][TABLE_CARD_VALUES][0];
				_handArray[3] = g_rgPokerGames[gameId][TABLE_CARD_VALUES][1];
				_handArray[4] = g_rgPokerGames[gameId][TABLE_CARD_VALUES][2];
				_handArray[5] = g_rgPokerGames[gameId][TABLE_CARD_VALUES][3];
				_handArray[6] = g_rgPokerGames[gameId][TABLE_CARD_VALUES][4];
				//_newValue = Eval7(_handArray[0], _handArray[1], _handArray[2], _handArray[3], _handArray[4], _handArray[5], _handArray[6]);

				if(_newValue < _oldValue)
				{
					_oldValue = _newValue;
					_value = _newValue;
					winners[0] = _i;
					for(_b = 1; _b < MAX_POKER_PLAYERS; ++_b) winners[_b] = INVALID_PLAYER_ID;
				}
				else if(_newValue == _oldValue)
				{
					for(new _c = 0; _c < MAX_POKER_PLAYERS; ++_c)
					{
						if(winners[_c] == INVALID_PLAYER_ID)
						{
							winners[_c] = _i;
							break;
						}
					}
				}
			}
		}
	}

	return _value;
}

Pkr_PlayerConfirmBet(const gameId, const player, const amount)
{
    Pkr_AddToPot(gameId, amount);
    Pkr_MinusPlayerChips(gameId, player, amount);
    //Pkr_Log("%s confirmed the bet with $%d for GameId: %d.", pNome(Pkr_GetPlayerId(gameId, player)), amount, gameId);
    Pkr_SetLastAggressivePlayer(gameId, player);
    Pkr_AddToPlayerBetContribution(gameId, player, amount);
    Pkr_AddToPlayerPotContribution(gameId, player, amount);
    Pkr_SetLastBet(gameId, amount);
    Pkr_AddToCurrentBet(gameId, amount);
    Pkr_SetPlayerStatusBet(gameId, player, amount);
    Pkr_SetAmountOfPlays(gameId, 1);
    Pkr_SetNextPlayerPlaying(gameId);
    return;
}


Pkr_PlayerConfirmRaise(const gameId, const player, const amount, const meetAmount)
{
    Pkr_AddToPot(gameId, meetAmount + amount);
    Pkr_MinusPlayerChips(gameId, player, meetAmount + amount);
    //Pkr_Log("%s confirmed the raise with $%d for GameId: %d.", pNome(Pkr_GetPlayerId(gameId, player)), meetAmount + amount, gameId);
    Pkr_AddToPlayerBetContribution(gameId, player, meetAmount + amount);
    Pkr_AddToPlayerPotContribution(gameId, player, meetAmount + amount);
    Pkr_SetLastAggressivePlayer(gameId, player);
    Pkr_SetLastBet(gameId, amount);
    Pkr_AddToCurrentBet(gameId, amount);
    Pkr_SetPlayerStatusRaised(gameId, player, amount);
    Pkr_SetAmountOfPlays(gameId, 1);
    Pkr_SetNextPlayerPlaying(gameId);
    return;
}

Pkr_PlayerConfirmCall(const gameId, const player, const amount)
{
    Pkr_AddToPot(gameId, amount);
    Pkr_MinusPlayerChips(gameId, player, amount);
    //Pkr_Log("%s confirmed the call with $%d for GameId: %d.", pNome(Pkr_GetPlayerId(gameId, player)), amount, gameId);
    Pkr_AddToPlayerBetContribution(gameId, player, amount);
    Pkr_AddToPlayerPotContribution(gameId, player, amount);
    Pkr_IncAmountOfPlays(gameId);
    Pkr_SetPlayerStatusCalled(gameId, player, amount);
    Pkr_SetNextPlayerPlaying(gameId);
    return;
}

Pkr_PlayerCheckConfirm(const gameId, const player)
{
    Pkr_IncAmountOfPlays(gameId);
    Pkr_SetPlayerStatusChecked(gameId, player);
    Pkr_SetNextPlayerPlaying(gameId);
    return;
}

#if defined POKER_DEBUG
PkrCMD_Destroy(const playerid, const parameters[]) {
	new gameId = INVALID_POKER_GAME_ID;

    if(sscanf(parameters, "i", gameId))
    {
        SendClientMessage(playerid, COLOR_GREY, "DEBUG USAGE: /pkr destroy [gameId]");
        return;
    }

    if(!Pkr_IsValidGameId(gameId))
    {
        SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid gameId.");
        return;
    }

	if(!Pkr_GetIsAssigned(gameId)) {
		SendClientMessage(playerid, COLOR_RED, "ERROR: That game does not exist.");
		return;
	}

	Pkr_DestroyGame(gameId);

    new message[128];
    format(message, sizeof(message), "Destroyed the game with Game ID: %d", gameId);
	SendClientMessage(playerid, COLOR_RED, message);
	return;
}
#endif

PkrCMD_Start(const playerId)
{
    new _gameId = Pkr_GetPlayerGame(playerId);
    if(_gameId == -1)
    {
        SendClientMessage(playerId, COLOR_RED, "Poker oynamùyorsun.");
        return;
    }

    new _playerSlot = Pkr_GetPlayerSlot(playerId, _gameId);
    if(_playerSlot == -1)
    {
        SendClientMessage(playerId, COLOR_RED, "Poker oynamùyorsun.");
        return;
    }

	new POKER_GAME_STATUS: _status = Pkr_GetGameStatus(_gameId);
	if(_status != POKER_GAME_STATUS: LOBBY)
    {
        SendClientMessage(playerId, COLOR_RED, "Bu komut sadece lobide kullanùlabilir.");
        return;
    }

    new _playerCount = Pkr_GetAmountOfPlayersOnGame(_gameId);

    if(_playerCount < 3)
    {
        SendClientMessage(playerId, COLOR_RED, "Poker en az 3 kiùiyle oynanabilir.");
        return;
    }

    new _readyCount = Pkr_GetPlayerReadyCount(_gameId);
    if(_readyCount != _playerCount)
    {
        SendClientMessage(playerId, COLOR_RED, "Oyuna baùlayabilmek iùin herkesin hazùr olmasù gerekiyor.");
        return;
    }

	Pkr_BlindMeetCheck(_gameId);
	_playerCount = Pkr_GetAmountOfPlayersOnGame(_gameId);
	if(_playerCount < 2)
		return;

    Pkr_StartGame(_gameId);
    return;
}

PkrCMD_NextHand(const playerId)
{
    new _gameId = Pkr_GetPlayerGame(playerId);
    if(_gameId == -1)
    {
        SendClientMessage(playerId, COLOR_RED, "Poker oynamùyorsun.");
        return;
    }

    new _playerSlot = Pkr_GetPlayerSlot(playerId, _gameId);
    if(_playerSlot == -1)
    {
        SendClientMessage(playerId, COLOR_RED, "Poker oynamùyorsun.");
        return;
    }

    new POKER_GAME_STATUS: _status = Pkr_GetGameStatus(_gameId);

    if(_status != POKER_GAME_STATUS: EVALUATION)
    {
        SendClientMessage(playerId, COLOR_RED, "Sadece el sonunda yeni ele geùebilirsin.");
        return;
    }

    Pkr_SetGameToLobby(_gameId);
    return;
}

enum RAISE_DIALOG_ERROR
{
    NAN,
    NO_MONEY,
    LAST_BET,
    NONE
};

enum BET_DIALOG_ERROR
{
    NAN,
    NO_MONEY,
	ZERO,
    NONE
};

stock Pkr_GameShowBetDialog(const playerid, const BET_DIALOG_ERROR: error = BET_DIALOG_ERROR: NONE)
{
    new _format[2048];

    format(_format, 2048, "Merhaba {FF9900}%s{A9C4E4},\n\nBy betting you're adding chips to the pot\nof an amount you're willing to pay.\n\n", pNome(playerid));

    switch(error)
    {
        case (BET_DIALOG_ERROR: NAN):
            format(_format, 2048, "%s{D10047}Hatalù miktar girdiniz, lùtfen bahis yapmak istediùiniz geùerli ùip miktarù girin.{A9C4E4}\n\n", _format);
        case (BET_DIALOG_ERROR: NO_MONEY):
            format(_format, 2048, "%s{D10047}Bu bahise paranùz yetmiyor, lùtfen bahis yapmak istediùiniz geùerli ùip miktarù girin.{A9C4E4}\n\n", _format);
        case (BET_DIALOG_ERROR: ZERO):
            format(_format, 2048, "%s{D10047}$0 ile bahis yapamazsùnùz, lùtfen bahis yapmak istediùiniz geùerli ùip miktarù girin.{A9C4E4}\n\n", _format);
    }

    format(_format, 2048, "%sBahis yapmak istediùiniz ùip miktarùnù girin ve '{FF9900}Bet{A9C4E4}' tùklayùn, eùer bahisinizi iptal etmek isterseniz'{FF9900}Geri{A9C4E4}' tùklayùn.", _format);
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: BET);
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_INPUT, "Texas Hold 'em Poker - Bahis", _format, "Bahis", "Geri");
    Pkr_HideCursorForPlayerId(playerid);
    return;
}

stock Pkr_GameShowBetConfirmDialog(const playerid)
{
    new _format[2048];
    new _gameId = Pkr_GetPlayerGame(playerid);
    new _slot = Pkr_GetCurrentPlayerPosition(_gameId);
    new _betAmount = GetPVarInt(playerid, POKER_PLAYER_BET_AMOUNT_VAR);

    new _playerChips = Pkr_GetPlayerChips(_gameId, _slot) - _betAmount;

    format(_format, sizeof(_format), "Teùekkùr ederiz {FF9900}%s{A9C4E4},\n\nBahis yapmadan ùnce bahis miktarùnùzù doùrulayacaùùz.\n\n", pNome(playerid));
    format(_format, sizeof(_format), "%sSeùtiùiniz ùipler: {00AD43}$%s{A9C4E4}.\nBu doùrulamadan ùnceki paranùz: {00AD43}$%s{A9C4E4}.\nBu doùrulamadan sonraki paranùz: {00AD43}$%s{A9C4E4}.\n\nDevam etmek ve onaylamak iùin '{FF9900}Bahis{A9C4E4}'\nyada iptal edip, geri dùnmek iùin '{FF9900}Geri{A9C4E4}' tùklayùn.", _format, Pkr_FormatNumber(_betAmount), Pkr_FormatNumber(Pkr_GetPlayerChips(_gameId, _slot)), Pkr_FormatNumber(_playerChips));
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Texas Hold 'em Poker - Bahis Onayla", _format, "Bahis", "Geri");
    Pkr_HideCursorForPlayerId(playerid);
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: BET_CONFIRM);
    return;
}

stock Pkr_GameShowRaiseDialog(const playerid, const gameId, const RAISE_DIALOG_ERROR: error = RAISE_DIALOG_ERROR: NONE)
{
    new _format[2048];
    new _slot = Pkr_GetCurrentPlayerPosition(gameId);

    format(_format, 2048, "Merhaba {FF9900}%s{A9C4E4},\n\nBu yùkseltme iùlemiyle mevcut bahis miktarùnù yùkselteceksiniz.\n\n", pNome(playerid));

    switch(error)
    {
        case (RAISE_DIALOG_ERROR: NAN):
            format(_format, 2048, "%s{D10047}Hatalù miktar girdiniz, lùtfen bahisi artùrttùrmak istediùiniz geùerli ùip miktarùnù girin.{A9C4E4}\n\n", _format);
        case (RAISE_DIALOG_ERROR: NO_MONEY):
            format(_format, 2048, "%s{D10047}Paranùz yetersiz, lùtfen bahisi arttùrmak istediùiniz geùerli ùip miktarùnù girin.{A9C4E4}\n\n", _format);
        case (RAISE_DIALOG_ERROR: LAST_BET):
            format(_format, 2048, "%s{D10047}Artùùùnùz son bahisten yùksek olmalù, lùtfen bahis yapmak istediùiniz geùerli ùip miktarùnù girin.{A9C4E4}\n\n", _format);
    }

    format(_format, 2048, "%sùipleriniz: {00AD43}$%s{A9C4E4}.\nMinimum Arttùrma: {00AD43}$%s{A9C4E4}.\n", _format, Pkr_FormatNumber(Pkr_GetPlayerChips(gameId, _slot)), Pkr_FormatNumber(Pkr_GetLastBet(gameId)));
    format(_format, 2048, "%sArttùrmak istediùiniz ùip miktarùnù girin ve onaylamak iùin '{FF9900}Arttùr{A9C4E4}' basùn, eùer fikrinizi deùiùtirirseniz '{FF9900}Geri{A9C4E4}' basùn.", _format);
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: RAISE);
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_INPUT, "Texas Hold 'em Poker - Arttùr", _format, "Arttùr", "Geri");
    Pkr_HideCursorForPlayerId(playerid);
    return;
}

stock Pkr_GameShowRaiseConfirmDialog(const playerid)
{
    new _format[2048];
    new _gameId = Pkr_GetPlayerGame(playerid);
    new _slot = Pkr_GetCurrentPlayerPosition(_gameId);

    new _inputAmount = GetPVarInt(playerid, POKER_PLAYER_RAISE_AMOUNT_VAR);
    new _amountToMeet = Pkr_GetCurrentBet(_gameId) - Pkr_GetPlayerBetContribution(_gameId, _slot);
    new _raiseAmount = _inputAmount + _amountToMeet;
    new _playerChips = Pkr_GetPlayerChips(_gameId, _slot) - _raiseAmount;

    format(_format, sizeof(_format), "Teùekkùr ederiz {FF9900}%s{A9C4E4},\n\nBahisi arttùrmadan ùnce bu iùleminizi doùrulamak istiyoruz.\n\n", pNome(playerid));
    format(_format, sizeof(_format), "%sSeùtiùiniz ùipler: {00AD43}$%s{A9C4E4}.\nBu doùrulamadan ùnceki paranùz: {00AD43}$%s{A9C4E4}.\nBu doùrulamadan sonraki paranùz: {00AD43}$%s{A9C4E4}.\n\nDevam etmek ve onaylamak iùin '{FF9900}Arttùr{A9C4E4}'yada iptal edip geri dùnmek iùin '{FF9900}Geri{A9C4E4}' basùn.", _format, Pkr_FormatNumber(_raiseAmount), Pkr_FormatNumber(Pkr_GetPlayerChips(_gameId, _slot)), Pkr_FormatNumber(_playerChips));
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Texas Hold 'em Poker - Arttùrma Onayla", _format, "Arttùr", "Geri");
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: RAISE_CONFIRM);
    Pkr_HideCursorForPlayerId(playerid);
    return;
}

stock Pkr_GameShowCallConfirmDialog(const playerid, const gameId)
{
    new _playerSlot = Pkr_GetCurrentPlayerPosition(gameId);
    new _format[2048];
    new _currentBet = Pkr_GetCurrentBet(gameId) - Pkr_GetPlayerBetContribution(gameId, _playerSlot);

    format(_format, sizeof(_format), "Teùekkùr ederiz {FF9900}%s{A9C4E4},\n\n Call yapmadan ùnce bu miktarù doùrulayacaùùz.\n\n", pNome(playerid));
    format(_format, sizeof(_format), "%sBu doùrulamadan ùnceki paranùz: {00AD43}$%s{A9C4E4}.\nBu doùrulamadan sonraki paranùz: {00AD43}$%s{A9C4E4}.\nTotal to call: {00AD43}$%s{A9C4E4}.\n\n", _format, Pkr_FormatNumber(Pkr_GetPlayerChips(gameId, _playerSlot)), Pkr_FormatNumber(Pkr_GetPlayerChips(gameId, _playerSlot) - _currentBet), Pkr_FormatNumber(_currentBet));
    format(_format, sizeof(_format), "%sDevam etmek ve onaylamak iùin '{FF9900}Call{A9C4E4}'\nor geri dùnmek iùin'{FF9900}Geri{A9C4E4}' tùklayùn.", _format);
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Texas Hold 'em Poker - Call", _format, "Call", "Geri");
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: CALL_CONFIRM);
    Pkr_HideCursorForPlayerId(playerid);
    return;
}

stock Pkr_GameShowCheckConfirmDialog(const playerid)
{
    new _format[2048];
    format(_format, sizeof(_format), "Teùekkùr ederiz {FF9900}%s{A9C4E4},\n\nBu kontrolden ùnce doùrulama yapacaùùz.\n\n", pNome(playerid));
    format(_format, sizeof(_format), "%sDevam etmek ve onaylamak iùin '{FF9900}Check{A9C4E4}'\nor iptal etmek iùin '{FF9900}Back{A9C4E4}' tùklayùn.", _format);
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Texas Hold 'em Poker - Check", _format, "Check", "Geri");
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: CHECK_CONFIRM);
    Pkr_HideCursorForPlayerId(playerid);
    return;
}

stock Pkr_GameShowFoldDialog(const playerid) {
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Texas Hold 'em Poker - Fold", "Fold yapmak istediùinizden emin misiniz?", "Fold", "Geri");
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: FOLD_CONFIRM);
    Pkr_HideCursorForPlayerId(playerid);
    return;
}

stock Pkr_GameShowAllInDialog(const playerid) {
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Texas Hold 'em Poker - All In", "All in yapmak istediùinizden emin misiniz?", "All In", "Geri");
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: ALL_IN_CONFIRM);
    Pkr_HideCursorForPlayerId(playerid);
    return;
}

Pkr_GameDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused dialogid, listitem, inputtext

    new _pokerDialogId = Pkr_GetPokerDialog(playerid);

	new gameId = Pkr_GetPlayerGame(playerid);

	if(gameId == INVALID_POKER_GAME_ID)
		return;

	#if !defined POKER_DEBUG
		new currentPlayerPosition = Pkr_GetCurrentPlayerPosition(gameId);
		new playerPosition = Pkr_GetPlayerSlot(playerid, gameId);
		if(playerPosition != currentPlayerPosition) {
			SendClientMessage(playerid, COLOR_RED, "Aktif bir poker oyuncusu deùilsin!");
			return;
		}
	#endif

    switch(_pokerDialogId)
    {
        case (POKER_DIALOGS: BET):
        {
            if(!response) {
				Pkr_ShowCursorForPlayerId(playerid);
				return;
			}

            new _gameId = Pkr_GetPlayerGame(playerid);
            new _slot = Pkr_GetCurrentPlayerPosition(_gameId);
            new inputAmount = strval(inputtext);

            if(!Pkr_IsNumeric(inputtext) || strlen(inputtext) > 9)
            {
                Pkr_GameShowBetDialog(playerid, BET_DIALOG_ERROR: NAN);
                return;
            }

			if(inputAmount == 0) {
				Pkr_GameShowBetDialog(playerid, BET_DIALOG_ERROR: ZERO);
				return;
			}

            if(Pkr_GetPlayerChips(_gameId, _slot) < inputAmount)
            {
                Pkr_GameShowBetDialog(playerid, BET_DIALOG_ERROR: NO_MONEY);
                return;
            }

            if(Pkr_GetPlayerChips(_gameId, _slot) == inputAmount)
            {
				Pkr_GameShowAllInDialog(playerid);
                return;
            }

            SetPVarInt(playerid, POKER_PLAYER_BET_AMOUNT_VAR, inputAmount);
            Pkr_GameShowBetConfirmDialog(playerid);
            return;
        }

        case (POKER_DIALOGS: BET_CONFIRM):
        {
            new _gameId = Pkr_GetPlayerGame(playerid);
            new _slot = Pkr_GetCurrentPlayerPosition(_gameId);
            new _inputAmount = GetPVarInt(playerid, POKER_PLAYER_BET_AMOUNT_VAR);

            if(!response)
            {
                Pkr_GameShowBetDialog(playerid);
                return;
            }

            Pkr_PlayerConfirmBet(_gameId, _slot, _inputAmount);
			Pkr_ShowCursorForPlayerId(playerid);
            return;
        }

        case (POKER_DIALOGS: RAISE):
        {
            if(!response) {
				Pkr_ShowCursorForPlayerId(playerid);
				return;
			}

            new _gameId = Pkr_GetPlayerGame(playerid);
            new _slot = Pkr_GetCurrentPlayerPosition(_gameId);
            new inputAmount = strval(inputtext);
            new _amountToMeet = Pkr_GetCurrentBet(_gameId) - Pkr_GetPlayerBetContribution(_gameId, _slot);
            new _totalCost = _amountToMeet + inputAmount;
			new playerChips = Pkr_GetPlayerChips(_gameId, _slot);

            if(!Pkr_IsNumeric(inputtext) || strlen(inputtext) > 9)
            {
                Pkr_GameShowRaiseDialog(playerid, _gameId, RAISE_DIALOG_ERROR: NAN);
                return;
            }

            if(inputAmount < Pkr_GetLastBet(_gameId))
            {
                Pkr_GameShowRaiseDialog(playerid, _gameId, RAISE_DIALOG_ERROR: LAST_BET);
                return;
            }

            if(playerChips < _totalCost)
            {
                Pkr_GameShowRaiseDialog(playerid, _gameId, RAISE_DIALOG_ERROR: NO_MONEY);
                return;
            }

			if(_totalCost == playerChips)
			{
				Pkr_GameShowAllInDialog(playerid);
				return;
			}

            SetPVarInt(playerid, POKER_PLAYER_RAISE_AMOUNT_VAR, inputAmount);
            Pkr_GameShowRaiseConfirmDialog(playerid);
            return;
        }

        case (POKER_DIALOGS: RAISE_CONFIRM):
        {
            new _gameId = Pkr_GetPlayerGame(playerid);
            new _slot = Pkr_GetCurrentPlayerPosition(_gameId);
            new _inputAmount = GetPVarInt(playerid, POKER_PLAYER_RAISE_AMOUNT_VAR);
            new _amountToMeet = Pkr_GetCurrentBet(_gameId) - Pkr_GetPlayerBetContribution(_gameId, _slot);

            if(!response)
            {
                Pkr_GameShowRaiseDialog(playerid, _gameId);
                return;
            }

            Pkr_PlayerConfirmRaise(_gameId, _slot, _inputAmount, _amountToMeet);
			Pkr_ShowCursorForPlayerId(playerid);
            return;
        }

        case (POKER_DIALOGS: CALL_CONFIRM):
        {
			Pkr_ShowCursorForPlayerId(playerid);

			if(!response) {
				return;
			}

            new _gameId = Pkr_GetPlayerGame(playerid);
            new _playerSlot = Pkr_GetCurrentPlayerPosition(_gameId);
            new _callAmount = Pkr_GetCurrentBet(_gameId) - Pkr_GetPlayerBetContribution(_gameId, _playerSlot);

            Pkr_PlayerConfirmCall(_gameId, _playerSlot, _callAmount);
            return;
        }

        case (POKER_DIALOGS: CHECK_CONFIRM):
        {
			Pkr_ShowCursorForPlayerId(playerid);

			if(!response) {
				return;
			}

            new _gameId = Pkr_GetPlayerGame(playerid);
            new _playerSlot = Pkr_GetCurrentPlayerPosition(_gameId);

            Pkr_PlayerCheckConfirm(_gameId, _playerSlot);
            return;
        }

		case (POKER_DIALOGS: FOLD_CONFIRM): {
			Pkr_ShowCursorForPlayerId(playerid);

			if(!response) {
				return;
			}

			new playerSlot = Pkr_GetCurrentPlayerPosition(gameId);

			Pkr_SetPlayerStatusFolded(gameId, playerSlot);
			Pkr_SetNextPlayerPlaying(gameId);
			return;
		}

		case (POKER_DIALOGS: ALL_IN_CONFIRM): {
			Pkr_ShowCursorForPlayerId(playerid);

			if(!response) {
				return;
			}

			new playerSlot = Pkr_GetCurrentPlayerPosition(gameId);

			Pkr_SetPlayerStatusAllIn(gameId, playerSlot);

			new playerChips = Pkr_GetPlayerChips(gameId, playerSlot);
			new currentBet = Pkr_GetCurrentBet(gameId);
			new amountToMeet = playerChips - Pkr_GetPlayerBetContribution(gameId, playerSlot);

			if(currentBet < amountToMeet)
			{
				Pkr_SetLastAggressivePlayer(gameId, playerSlot);
				Pkr_SetAmountOfPlays(gameId, 0);
				Pkr_AddToCurrentBet(gameId, playerChips);
				Pkr_SetLastBet(gameId, playerChips);
			}

			Pkr_AddToPot(gameId, playerChips);
			Pkr_AddToPlayerBetContribution(gameId, playerSlot, playerChips);
			Pkr_AddToPlayerPotContribution(gameId, playerSlot, playerChips);
			Pkr_MinusPlayerChips(gameId, playerSlot, playerChips);
            //Pkr_Log("%s went all in with $%d for GameId: %d.", pNome(Pkr_GetPlayerId(gameId, playerSlot)), playerChips, gameId);
			Pkr_SetNextPlayerPlaying(gameId);
			return;
		}
    }

    return;
}

stock Pkr_FormatNumber(number)
{
	new _str[128];
	format(_str, sizeof(_str), "%i", number);
	new _len = strlen(_str);
	if(_len > 3)
	{
		new _i;
		if(_len >= 4) _i = 1;
		if(_len >= 5) _i = 2;
		if(_len >= 6) _i = 3;
		if(_len >= 7) _i = 1;
		if(_len >= 8) _i = 2;
		if(_len >= 9) _i = 3;

		while(_i < _len)
		{
			strins(_str, ",", _i);
			_i += 4;
		}
	}
	return _str;
}

new cardMap[13] = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1 };

stock Pkr_ReturnCardSpriteName(value)
{
	new
		spriteName[16],
		val = ((value >> 8) & 0xF);

	if(value & 0x8000) format(spriteName, sizeof(spriteName), "LD_CARD:cd%ic", cardMap[val]);
	else if(value & 0x4000) format(spriteName, sizeof(spriteName), "LD_CARD:cd%id",  cardMap[val]);
	else if(value & 0x2000) format(spriteName, sizeof(spriteName), "LD_CARD:cd%ih", cardMap[val]);
	else format(spriteName, sizeof(spriteName), "LD_CARD:cd%is", cardMap[val]);
	return spriteName;
}

stock PkrSys_ReturnRandomUnusedCard(const gameId)
{
	new _f, _c, _i;
	do
	{
		_f = 0;
		_c = random(52);
		for(_i = 0; _i < MAX_TABLE_CARDS; ++_i) if(g_rgCardDeck[_c] == g_rgPokerGames[gameId][TABLE_CARD_VALUES][_i]) ++_f;
		for(_i = 0; _i < MAX_POKER_PLAYERS; ++_i) if(g_rgCardDeck[_c] == g_rgPokerGames[gameId][PLAYER_CARD_ONE_VALUE][_i] || g_rgCardDeck[_c] == g_rgPokerGames[gameId][PLAYER_CARD_TWO_VALUE][_i]) ++_f;
	}
	while(_f > 0);
	return _c;
}

Pkr_IsNumeric(const string[])
{
    for(new i = 0, j = strlen(string); i < j; i++) if (string[i] > '9' || string[i] < '0') return 0;
    return true;
}

stock Pkr_HandRank(const value)
{
	if(value > 6185) return HIGH_CARD;
	if(value > 3325) return ONE_PAIR;
	if(value > 2467) return TWO_PAIR;
	if(value > 1609) return THREE_OF_A_KIND;
	if(value > 1599) return STRAIGHT;
	if(value > 322) return FLUSH;
	if(value > 166) return FULL_HOUSE;
	if(value > 10) return FOUR_OF_A_KIND;
	return STRAIGHT_FLUSH;
}

stock Pkr_ReturnHandName(const rank)
{
	new _sz[128] = "ERROR_NO_NAME";
	switch(rank)
	{
		case (HAND_TYPES: HIGH_CARD): format(_sz, sizeof(_sz), "High Card");
		case (HAND_TYPES: ONE_PAIR): format(_sz, sizeof(_sz), "One Pair");
		case (HAND_TYPES: TWO_PAIR): format(_sz, sizeof(_sz), "Two Pair");
		case (HAND_TYPES: THREE_OF_A_KIND): format(_sz, sizeof(_sz), "Three of a Kind");
		case (HAND_TYPES: STRAIGHT): format(_sz, sizeof(_sz), "Straight");
		case (HAND_TYPES: FLUSH): format(_sz, sizeof(_sz), "Flush");
		case (HAND_TYPES: FULL_HOUSE): format(_sz, sizeof(_sz), "Full House");
		case (HAND_TYPES: FOUR_OF_A_KIND): format(_sz, sizeof(_sz), "Four of a Kind");
		case (HAND_TYPES: STRAIGHT_FLUSH): format(_sz, sizeof(_sz), "Straight Flush");
	}
	return _sz;
}

Pkr_SendGameMessage(const gameId, const color, const message[])
{
	Pkr_ForeachPlayer(player)
		if(g_rgPokerGames[gameId][PLAYERS][player] != INVALID_PLAYER_ID)
			SendClientMessage(g_rgPokerGames[gameId][PLAYERS][player], color, message);

	Pkr_ForeachPlayerIdInPool(playerId)
        if(GetPVarType(playerId, POKER_SPECTATE_VAR_NAME) != PLAYER_VARTYPE_NONE && GetPVarInt(playerId, POKER_SPECTATE_VAR_NAME) == gameId)
			SendClientMessage(playerId, color, message);

    return;
}

Pkr_SendFormattedGameMessage(const gameId, const color, str[], {Float, _}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144];

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		Pkr_SendGameMessage(gameId, color, string);
		return true;
	}

	Pkr_SendGameMessage(gameId, color, str);
	return true;
}

enum SIT_DIALOG_ERROR
{
    NONE,
    NAN,
    NO_MONEY,
    BLINDS
};

Pkr_PlayerShowDialog(const playerid, const gameId, const SIT_DIALOG_ERROR: error = SIT_DIALOG_ERROR: NONE)
{
    new _format[2048];

    format(_format, 2048, "Merhaba {FF9900}%s{A9C4E4},\n\nBu masaya oturabilmek iùin bir miktar ùipe sahip\nolmalùsùnùz. Lùtfen oyunda zorlanmayacaùùnùz\nbir miktar ùip ile giriù yapùnùz.\n\n", pNome(playerid));

    switch(error)
    {
        case (SIT_DIALOG_ERROR: NAN):
            format(_format, 2048, "%s{D10047}Hatalù bir deùer girdiniz, lùtfen masaya katùlmak istediùiniz geùerli ùip miktarùnù girin.{A9C4E4}\n\n", _format);
        case (SIT_DIALOG_ERROR: NO_MONEY):
            format(_format, 2048, "%s{D10047}Bu ùipi almak iùin yeterli paranùz yok, geùerli bir ùip miktarù girin.{A9C4E4}\n\n", _format);
        case (SIT_DIALOG_ERROR: BLINDS):
            format(_format, 2048, "%s{D10047}Bu miktarda bahis yapamazsùnùz,ùtfen masaya katùlmak istediùiniz geùerli ùip miktarùnù girin.{A9C4E4}\n\n", _format);
    }

    format(_format, 2048, "%sParanùz: {00AD43}$%s{A9C4E4}.\nOrtalama Oyuncu ùipleri: {00AD43}$%.0f{A9C4E4}.\nBùyùk Kùr Bahis: {00AD43}$%s{A9C4E4}.\nKùùùk Kùr Bahis: {00AD43}$%s{A9C4E4}.\nOyuncu Sayùsù: %i/6.", _format, Pkr_FormatNumber(pInfo[playerid][pMoney]), Float:Pkr_ReturnAverageChips(gameId), Pkr_FormatNumber((g_rgPokerGames[gameId][BLIND] << 1)), Pkr_FormatNumber(g_rgPokerGames[gameId][BLIND]), Pkr_GetAmountOfPlayersOnGame(gameId));
    format(_format, 2048, "%s\n\nMasaya katùlmak istediùiniz ùip miktarùnù girin,\nsonra onaylamak iùin '{FF9900}Otur{A9C4E4},\neùer masadan ayrùlmak isterseniz '{FF9900}Ayrùl{A9C4E4}' tùklayùn.", _format);
    SetPVarInt(playerid, "Pkr_SitGameId", gameId);
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: SIT);
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_INPUT, "Texas Hold 'em Poker - Otur", _format, "Otur", "Ayrùl");
    Pkr_HideCursorForPlayerId(playerid);
    return true;
}

Pkr_PlayerShowConfirmDialog(const playerid)
{
    new _format[2048];
    new _sitcash = GetPVarInt(playerid, "Pkr_SitCash");
    format(_format, sizeof(_format), "Teùekkùrler {FF9900}%s{A9C4E4},\n\nMasaya katùlmadan ùnce oynamak istediùiniz ùip miktarùnù onaylayùn.\n\n", pNome(playerid));
    format(_format, sizeof(_format), "%sùipleriniz: {00AD43}$%s{A9C4E4}.\nBu doùrulamadan ùnce paranùz: {00AD43}$%s{A9C4E4}.\nBu doùrulamadan sonra paranùz: {00AD43}$%s{A9C4E4}.\n\nDevam etmek iùin '{FF9900}Onayla{A9C4E4}' yada geri dùnmek iùin '{FF9900}Geri{A9C4E4}' tùklayùn.", _format, Pkr_FormatNumber(_sitcash), Pkr_FormatNumber(pInfo[playerid][pMoney]), Pkr_FormatNumber(pInfo[playerid][pMoney] - _sitcash));
    ShowPlayerDialog(playerid, POKER_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Texas Hold 'em Poker", _format, "Onayla", "Geri");
    Pkr_SetPokerDialog(playerid, POKER_DIALOGS: SIT_CONFIRM);
    Pkr_HideCursorForPlayerId(playerid);
    return true;
}

PkrCMD_Join(const playerid) {
    if(Pkr_GetPlayerGame(playerid) != -1) {
        SendClientMessage(playerid, COLOR_RED, "Poker oynuyorsun.");
        return;
    }

	if(GetPVarType(playerid, POKER_SPECTATE_VAR_NAME) != PLAYER_VARTYPE_NONE) {
		SendClientMessage(playerid, COLOR_RED, "Poker masasùnù izlerken oyuna katùlamazsùn.");
		return;
	}

	new objectId = furn_pokerTableCheck(playerid);
    if(objectId <= 0 || objectId == INVALID_OBJECT_ID) {
        SendClientMessage(playerid, COLOR_RED, "Yakùnùnda poker masasù yok.");
        return;
    }

    new gameId = Pkr_GetGameByObjectId(objectId);
    if(gameId == -1) {
		new businessId = IsPlayerInBusiness(playerid);
		gameId = Pkr_CreateGameByObjectId(objectId, businessId);
    }

    if(gameId == -1) {
        SendClientMessage(playerid, COLOR_RED, "Oops! Oyun yaratùlamadù, lùtfen sonra tekrar deneyin.");
        return;
    }

    if(Pkr_GetGameStatus(gameId) != POKER_GAME_STATUS: LOBBY) {
        SendClientMessage(playerid, COLOR_RED, "Bu masada oyun baùlamùù. -/pkr izle yazarak izleyebilirsin.");
        return;
    }

    if(Pkr_GetAmountOfPlayersOnGame(gameId) == 6) {
        SendClientMessage(playerid, COLOR_RED, "Bu masa dolu. - /pkr izle yazarak izleyebilirsin.");
        return;
    }

    Pkr_PlayerShowDialog(playerid, gameId);
    return;
}

PkrCMD_Leave(const playerid)
{
    new _game = Pkr_GetPlayerGame(playerid);
    if(_game == -1) {
        SendClientMessage(playerid, COLOR_RED, "Poker oynamùyorsun.");
        return true;
    }

    if(Pkr_UnassignPlayerFromGame(playerid, _game)) {
        SendClientMessage(playerid, COLOR_RED, "Poker masasùndan ayrùldùn.");
        return true;
    }

    SendClientMessage(playerid, COLOR_RED, "Oyundan ùùkarùlamadùn.");
    return true;
}

PkrCMD_Mouse(const playerid)
{
    new _game = Pkr_GetPlayerGame(playerid);
    if(_game == -1) {
        SendClientMessage(playerid, COLOR_RED, "Poker oynamùyorsun.");
        return;
    }

    Pkr_ShowCursorForPlayerId(playerid);
    SendClientMessage(playerid, COLOR_ORANGE, "Mouse kontrolù aktif edildi.");
    return;
}

PkrCMD_Help(const playerid) {
	SendClientMessage(playerid, COLOR_ORANGE, "Poker Sistemi:");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr katil - Poker oyununa katùlùrsùnùz.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr ayril - Poker oyunundan ayrùlùrsùnùz.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr baslat - Oyunu baùlatmanùzù saùlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr sonrakiel - Sonraki ele geùip sùfùrlamanùzù saùlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr mouse - Seùeneklere tùklayabilmek iùin iùaretùiyi aktif eder.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr izle - Masayù izlemenizi saùlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr cam - Kamera gùrùnùmùne geùmenizi saùlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr durus - Bir masada duruùunuzu dùzeltir.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr otur - Masada oturmanùzù saùlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr ùip - Masaya daha fazla ùip yerleùtirmenizi saùlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr komisyon - ùùletme sahiplerinin masaya komisyon ayarlamasùnù saùlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/pkr timer - Sayaù zamanlayùcùsùnù dùzenlemenize yarar.");
	return;
}

PkrCMD_Spectate(const playerid) {
	if(Pkr_GetPlayerGame(playerid) != -1) {
        SendClientMessage(playerid, COLOR_RED, "Poker oynuyorsun.");
        return;
    }

	new objectId = furn_pokerTableCheck(playerid);
    if(objectId == INVALID_OBJECT_ID) {
        SendClientMessage(playerid, COLOR_RED, "Yakùnùnda poker masasù yok.");
        return;
    }

    new gameId = Pkr_GetGameByObjectId(objectId);
	if(gameId == -1)
    {
		SendClientMessage(playerid, COLOR_RED, "Yakùnùnda poker masasù yok.");
		return;
	}

	if(GetPVarType(playerid, POKER_SPECTATE_VAR_NAME) == PLAYER_VARTYPE_NONE) {
		SetPVarInt(playerid, POKER_SPECTATE_VAR_NAME, gameId);
		Pkr_ShowPlayerTextDraws(playerid, gameId);
		SendClientMessage(playerid, COLOR_DARKGREEN, "Poker oyununu seyretmeye baùladùn.");
        TogglePlayerControllable(playerid, false);
		return;
	}

	DeletePVar(playerid, POKER_SPECTATE_VAR_NAME);
	Pkr_HidePlayerTextDraws(playerid, gameId);
	SendClientMessage(playerid, COLOR_DARKGREEN, "Poker oyununu seyretmeyi bùraktùn.");
    TogglePlayerControllable(playerid, true);
	return;
}

PkrCMD_Sit(const playerid) {
	new gameId = Pkr_GetPlayerGame(playerid);
	if(gameId == -1) {
		SendClientMessage(playerid, COLOR_RED, "Poker oynamùyorsun.");
		return;
	}

	if(GetPVarType(playerid, POKER_SIT_VAR_NAME) != PLAYER_VARTYPE_NONE) {
		SendClientMessage(playerid, COLOR_RED, "Zaten oturuyorsun.");
		return;
	}

	new tableObjectId = furn_pokerTableCheck(playerid);
	if(tableObjectId < 0) {
		SendClientMessage(playerid, COLOR_RED, "Oturmak iùin masanùn yanùnda olmalùsùn.");
		return;
	}

	new POKER_GAME_STATUS: status = Pkr_GetGameStatus(gameId);
	if(status == POKER_GAME_STATUS: LOBBY)
		Pkr_ShowPlayerReadyTextDraw(playerid, gameId);

	new objectId = Pkr_GetObjectId(gameId);
	PkrSys_SetPlayerCamera(playerid, objectId);
	Pkr_ShowPlayerTextDraws(playerid, gameId);
	Pkr_ShowCursorForPlayerId(playerid);
	TogglePlayerControllable(playerid, false);
	SetPVarInt(playerid, POKER_SIT_VAR_NAME, 1);
	return;
}

PkrCMD_Stand(const playerid) {
	new gameId = Pkr_GetPlayerGame(playerid);
	if(gameId == -1) {
		SendClientMessage(playerid, COLOR_RED, "Poker oynamùyorsun.");
		return;
	}

	if(GetPVarType(playerid, POKER_SIT_VAR_NAME) == PLAYER_VARTYPE_NONE) {
		SendClientMessage(playerid, COLOR_RED, "Zaten duruù durumundasùn.");
		return;
	}

	SetCameraBehindPlayer(playerid);
	Pkr_HidePlayerTextDraws(playerid, gameId);
	Pkr_HideCursorForPlayerId(playerid);
	TogglePlayerControllable(playerid, true);
	DeletePVar(playerid, POKER_SIT_VAR_NAME);
	return;
}

Pkr_PlayerDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused playerid, dialogid, response, listitem, inputtext

    new _pokerDialogId = Pkr_GetPokerDialog(playerid);

    switch(_pokerDialogId)
    {
        case (POKER_DIALOGS: SIT):
        {
            new _gameId = GetPVarInt(playerid, "Pkr_SitGameId");

			new POKER_GAME_STATUS: status = Pkr_GetGameStatus(_gameId);
			if(status != POKER_GAME_STATUS: LOBBY) {
				SendClientMessage(playerid, COLOR_RED, "Bu oyun baùlamùù. ùzlemek iùin /pkr izle yazabilirsin.");
				return;
			}

            if(!response) {
                if(Pkr_GetAmountOfPlayersOnGame(_gameId) == 0 && Pkr_GetAmountOfJoiningPlayers(_gameId) == 1) {
                    Pkr_DestroyGame(_gameId);
                }

				DeletePVar(playerid, "Pkr_SitGameId");
				Pkr_ShowCursorForPlayerId(playerid);
                return;
            }

            if(!Pkr_IsNumeric(inputtext))
            {
                Pkr_PlayerShowDialog(playerid, _gameId, SIT_DIALOG_ERROR: NAN);
                return;
            }

            new _iSitCash = strval(inputtext);
            new _iPlayerMoney = pInfo[playerid][pMoney];

            if(_iPlayerMoney < _iSitCash)
            {
                Pkr_PlayerShowDialog(playerid, _gameId, SIT_DIALOG_ERROR: NO_MONEY);
                return;
            }

            if(_iSitCash < Pkr_GetBigBlind(_gameId))
            {
                Pkr_PlayerShowDialog(playerid, _gameId, SIT_DIALOG_ERROR: BLINDS);
                return;
            }

            SetPVarInt(playerid, "Pkr_SitCash", _iSitCash);
            Pkr_PlayerShowConfirmDialog(playerid);
            return;
        }

        case (POKER_DIALOGS: SIT_CONFIRM):
        {
            new _gameId = GetPVarInt(playerid, "Pkr_SitGameId");

			new POKER_GAME_STATUS: status = Pkr_GetGameStatus(_gameId);
			if(status != POKER_GAME_STATUS: LOBBY) {
				SendClientMessage(playerid, COLOR_RED, "Bu oyun baùlamùù. ùzlemek iùin /pkr izle yazabilirsin.");
				return;
			}

            if(!response)
            {
                Pkr_PlayerShowDialog(playerid, _gameId);
                return;
            }

            new _iSitCash = GetPVarInt(playerid, "Pkr_SitCash");
            Pkr_AssignPlayerToGame(playerid, _gameId, _iSitCash);
			DeletePVar(playerid, "Pkr_SitGameId");
            return;
        }
    }

    return;
}

Pkr_CreateBackgroundTextDraws()
{
    new Text: textDrawId = Text: INVALID_TEXT_DRAW;
    Pkr_SetBackgroundTextDrawId(0, TextDrawCreate(202.000000, 266.000000, "_"));
    textDrawId = Pkr_GetBackgroundTextDrawId(0);
    TextDrawBackgroundColour(textDrawId, 255);
    TextDrawFont(textDrawId, 0);
    TextDrawLetterSize(textDrawId, 1.500000, 4.400000);
    TextDrawColour(textDrawId, -1);
    TextDrawSetOutline(textDrawId, 0);
    TextDrawSetProportional(textDrawId, 1);
    TextDrawSetShadow(textDrawId, 1);
    TextDrawUseBox(textDrawId, 1);
    TextDrawBoxColour(textDrawId, 255);
    TextDrawTextSize(textDrawId, 264.000000, 50.000000);
    TextDrawSetSelectable(textDrawId, 0);

    Pkr_SetBackgroundTextDrawId(1, TextDrawCreate(150.000000, 203.000000, "_"));
    textDrawId = Pkr_GetBackgroundTextDrawId(1);
    TextDrawBackgroundColour(textDrawId, 255);
    TextDrawFont(textDrawId, 0);
    TextDrawLetterSize(textDrawId, 1.500000, 4.400000);
    TextDrawColour(textDrawId, -1);
    TextDrawSetOutline(textDrawId, 0);
    TextDrawSetProportional(textDrawId, 1);
    TextDrawSetShadow(textDrawId, 1);
    TextDrawUseBox(textDrawId, 1);
    TextDrawBoxColour(textDrawId, 255);
    TextDrawTextSize(textDrawId, 212.000000, 50.000000);
    TextDrawSetSelectable(textDrawId, 0);


    Pkr_SetBackgroundTextDrawId(2, TextDrawCreate(202.000000, 140.000000, "_"));
    textDrawId = Pkr_GetBackgroundTextDrawId(2);
    TextDrawBackgroundColour(textDrawId, 255);
    TextDrawFont(textDrawId, 0);
    TextDrawLetterSize(textDrawId, 1.500000, 4.400000);
    TextDrawColour(textDrawId, -1);
    TextDrawSetOutline(textDrawId, 0);
    TextDrawSetProportional(textDrawId, 1);
    TextDrawSetShadow(textDrawId, 1);
    TextDrawUseBox(textDrawId, 1);
    TextDrawBoxColour(textDrawId, 255);
    TextDrawTextSize(textDrawId, 264.000000, 50.000000);
    TextDrawSetSelectable(textDrawId, 0);

    Pkr_SetBackgroundTextDrawId(3, TextDrawCreate(376.000000, 140.000000, "_"));
    textDrawId = Pkr_GetBackgroundTextDrawId(3);
    TextDrawBackgroundColour(textDrawId, 255);
    TextDrawFont(textDrawId, 0);
    TextDrawLetterSize(textDrawId, 1.500000, 4.400000);
    TextDrawColour(textDrawId, -1);
    TextDrawSetOutline(textDrawId, 0);
    TextDrawSetProportional(textDrawId, 1);
    TextDrawSetShadow(textDrawId, 1);
    TextDrawUseBox(textDrawId, 1);
    TextDrawBoxColour(textDrawId, 255);
    TextDrawTextSize(textDrawId, 438.000000, 60.000000);
    TextDrawSetSelectable(textDrawId, 0);

    Pkr_SetBackgroundTextDrawId(4, TextDrawCreate(433.000000, 203.000000, "_"));
    textDrawId = Pkr_GetBackgroundTextDrawId(4);
    TextDrawBackgroundColour(textDrawId, 255);
    TextDrawFont(textDrawId, 0);
    TextDrawLetterSize(textDrawId, 1.500000, 4.400000);
    TextDrawColour(textDrawId, -1);
    TextDrawSetOutline(textDrawId, 0);
    TextDrawSetProportional(textDrawId, 1);
    TextDrawSetShadow(textDrawId, 1);
    TextDrawUseBox(textDrawId, 1);
    TextDrawBoxColour(textDrawId, 255);
    TextDrawTextSize(textDrawId, 495.000000, 50.000000);
    TextDrawSetSelectable(textDrawId, 0);

    Pkr_SetBackgroundTextDrawId(5, TextDrawCreate(376.000000, 266.000000, "_"));
    textDrawId = Pkr_GetBackgroundTextDrawId(5);
    TextDrawBackgroundColour(textDrawId, 255);
    TextDrawFont(textDrawId, 0);
    TextDrawLetterSize(textDrawId, 1.500000, 4.400000);
    TextDrawColour(textDrawId, -1);
    TextDrawSetOutline(textDrawId, 0);
    TextDrawSetProportional(textDrawId, 1);
    TextDrawSetShadow(textDrawId, 1);
    TextDrawUseBox(textDrawId, 1);
    TextDrawBoxColour(textDrawId, 255);
    TextDrawTextSize(textDrawId, 438.000000, 50.000000);
    TextDrawSetSelectable(textDrawId, 0);

    Pkr_SetBackgroundTextDrawId(6, TextDrawCreate(236.000000, 203.000000, "_"));
    textDrawId = Pkr_GetBackgroundTextDrawId(6);
    TextDrawBackgroundColour(textDrawId, 255);
    TextDrawFont(textDrawId, 0);
    TextDrawLetterSize(textDrawId, 1.500000, 4.400000);
    TextDrawColour(textDrawId, -1);
    TextDrawSetOutline(textDrawId, 0);
    TextDrawSetProportional(textDrawId, 1);
    TextDrawSetShadow(textDrawId, 1);
    TextDrawUseBox(textDrawId, 1);
    TextDrawBoxColour(textDrawId, 255);
    TextDrawTextSize(textDrawId, 394.000000, 50.000000);
    TextDrawSetSelectable(textDrawId, 0);
    return;
}

Pkr_DestroyBackgroundTextDraws()
{
    Pkr_ForeachBackground(background)
    {
        TextDrawDestroy(Pkr_GetBackgroundTextDrawId(background));
        Pkr_SetBackgroundTextDrawId(background, Text: INVALID_TEXT_DRAW);
    }
    return;
}

Pkr_CreateMenuTextDraws(const gameId)
{
    g_rgPokerGames[gameId][MENU_TEXTDRAWS][0] = TextDrawCreate(315.000000, 270.000000, "ALL IN");
    TextDrawAlignment(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 255);
    TextDrawFont(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 0.300000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 5, 64);
    TextDrawSetSelectable(g_rgPokerGames[gameId][MENU_TEXTDRAWS][0], 1);

    g_rgPokerGames[gameId][MENU_TEXTDRAWS][1] = TextDrawCreate(315.000000, 281.000000, "BAHIS");
    TextDrawAlignment(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 255);
    TextDrawFont(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 0.300000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 5, 64);
    TextDrawSetSelectable(g_rgPokerGames[gameId][MENU_TEXTDRAWS][1], 1);

    g_rgPokerGames[gameId][MENU_TEXTDRAWS][2] = TextDrawCreate(315.000000, 292.000000, "GOR");
    TextDrawAlignment(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 255);
    TextDrawFont(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 0.300000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 5, 64);
    TextDrawSetSelectable(g_rgPokerGames[gameId][MENU_TEXTDRAWS][2], 1);

    g_rgPokerGames[gameId][MENU_TEXTDRAWS][3] = TextDrawCreate(315.000000, 302.000000, "CEKIL");
    TextDrawAlignment(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 255);
    TextDrawFont(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 0.300000, 1.000000);
    TextDrawColour(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 0);
    TextDrawTextSize(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 5, 64);
    TextDrawSetSelectable(g_rgPokerGames[gameId][MENU_TEXTDRAWS][3], 1);

    return;
}

Pkr_DestroyMenuTextDraws(const gameId)
{
    for(new _i = 0; _i < MAX_POKER_MENU_ITEMS; ++_i)
    {
        TextDrawDestroy(g_rgPokerGames[gameId][MENU_TEXTDRAWS][_i]);
        g_rgPokerGames[gameId][MENU_TEXTDRAWS][_i] = Text: INVALID_TEXT_DRAW;
    }

    return;
}

#define Pkr_SetMenuItemOneState(%0,%1) \
            g_rgPokerGames[%0][MENU_ITEM_ONE_STATE] = %1

#define Pkr_SetMenuItemTwoState(%0,%1) \
            g_rgPokerGames[%0][MENU_ITEM_TWO_STATE] = %1

#define Pkr_GetMenuItemOneState(%0) \
            g_rgPokerGames[%0][MENU_ITEM_ONE_STATE]

#define Pkr_GetMenuItemTwoState(%0) \
            g_rgPokerGames[%0][MENU_ITEM_TWO_STATE]

stock Pkr_SetMenuItemOneStateBet(const gameId)
{
    Pkr_SetMenuItemOneState(gameId, POKER_MENU_STATES: BET);
    Pkr_SetMenuItemOneBet(gameId);
    return;
}

stock Pkr_SetMenuItemOneStateRaise(const gameId)
{
    Pkr_SetMenuItemOneState(gameId, POKER_MENU_STATES: RAISE);
    Pkr_SetMenuItemOneRaise(gameId);
    return;
}

stock Pkr_SetMenuItemTwoStateCheck(const gameId)
{
    Pkr_SetMenuItemTwoState(gameId, POKER_MENU_STATES: CHECK);
    Pkr_SetMenuItemTwoCheck(gameId);
    return;
}

stock Pkr_SetMenuItemTwoStateCall(const gameId)
{
    Pkr_SetMenuItemTwoState(gameId, POKER_MENU_STATES: CALL);
    Pkr_SetMenuItemTwoCall(gameId);
    return;
}

Pkr_PlayerMenuTextDrawClick(const playerid, const Text: clickedid)
{
    new _gameId = Pkr_GetPlayerGame(playerid);

    if(_gameId == -1)
        return;

	new _currentPlayer = Pkr_GetCurrentPlayerPosition(_gameId);
	new _playerSlot = Pkr_GetPlayerSlot(playerid, _gameId);

	#if defined POKER_DEBUG
		new currentPlayersId = Pkr_GetPlayerId(_gameId, _currentPlayer);
		if(_currentPlayer != _playerSlot && !IsPlayerNPC(currentPlayersId)) {
			SendClientMessage(playerid, COLOR_RED, "You can only control the actions of NPC's.");
			return;
		}
	#elseif !defined POKER_DEBUG
		if(_currentPlayer != _playerSlot) {
			SendClientMessage(playerid, COLOR_RED, "Oynama sùrasù sende deùil.");
			return;
		}
	#endif

    if(_playerSlot == -1)
        return;

    if(Pkr_GetGameStatus(_gameId) == POKER_GAME_STATUS: LOBBY || Pkr_GetGameStatus(_gameId) == POKER_GAME_STATUS: EVALUATION)
    {
        SendClientMessage(playerid, COLOR_RED, "Menù lobi veya deùerlendirme aùamasùnda kullanùlamaz.");
        return;
    }

    if(clickedid == g_rgPokerGames[_gameId][MENU_TEXTDRAWS][0]) // ALL IN
    {
		Pkr_GameShowAllInDialog(playerid);
		PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
        return;
    }

    if(clickedid == g_rgPokerGames[_gameId][MENU_TEXTDRAWS][1]) // BET OR RAISE
    {
        new _foldedPlayersCount = Pkr_CountPlayerStatus(_gameId, POKER_PLAYER_STATUS: FOLDED);
        new _allInPlayersCount = Pkr_CountPlayerStatus(_gameId, POKER_PLAYER_STATUS: ALL_IN);
        new _playersOn = Pkr_GetAmountOfPlayersOnGame(_gameId);

        if(_allInPlayersCount == _playersOn - _foldedPlayersCount - 1)
        {
            SendClientMessage(playerid, COLOR_RED, "All-in yapmak zorundasùn.");
            return;
        }

        if(Pkr_GetCurrentBet(_gameId) >= Pkr_GetPlayerChips(_gameId, _currentPlayer))
        {
            SendClientMessage(playerid, COLOR_RED, "Yùkseltme yapacak kadar ùipin yok, all-in yapmalùsùn ya da ùekilmelisin.");
            return;
        }

        if(Pkr_GetMenuItemOneState(_gameId) == POKER_MENU_STATES: BET)
        {
            Pkr_GameShowBetDialog(playerid);
        }
        else
        {
            Pkr_GameShowRaiseDialog(playerid, _gameId);
        }

        PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
        return;
    }

    if(clickedid == g_rgPokerGames[_gameId][MENU_TEXTDRAWS][2]) // CHECK OR CALL
    {
        if(Pkr_GetCurrentBet(_gameId) >= Pkr_GetPlayerChips(_gameId, _currentPlayer))
        {
            SendClientMessage(playerid, COLOR_RED, "Yùkseltme yapacak kadar ùipin yok, all-in yapmalùsùn ya da ùekilmelisin.");
            return;
        }

        if(Pkr_GetMenuItemTwoState(_gameId) == POKER_MENU_STATES: CHECK)
        {
            Pkr_GameShowCheckConfirmDialog(playerid);
        }
        else
        {
            Pkr_GameShowCallConfirmDialog(playerid, _gameId);
        }

        PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
        return;
    }

    if(clickedid == g_rgPokerGames[_gameId][MENU_TEXTDRAWS][3])
    {
		Pkr_GameShowFoldDialog(playerid);
		PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
		return;
    }

    return;
}

#define Pkr_ShowPlayerPotTextDraw(%0,%1) \
            TextDrawShowForPlayer(%0, g_rgPokerGames[%1][POT_TEXTDRAW])

#define Pkr_HidePlayerPotTextDraw(%0,%1) \
            TextDrawHideForPlayer(%0, g_rgPokerGames[%1][POT_TEXTDRAW])

stock Pkr_SetPotTextDraw(const gameId, const amount)
{
    new _szPotString[128];
    format(_szPotString, sizeof(_szPotString), "~w~ POT: ~g~$%d", amount);
    TextDrawSetString(g_rgPokerGames[gameId][POT_TEXTDRAW], _szPotString);
    return;
}

Pkr_CreatePotTextDraw(const gameId) {
    g_rgPokerGames[gameId][POT_TEXTDRAW] = TextDrawCreate(314.000000, 192.000000, "~w~ POT: ~g~$0");
    TextDrawAlignment(g_rgPokerGames[gameId][POT_TEXTDRAW], 2);
    TextDrawBackgroundColour(g_rgPokerGames[gameId][POT_TEXTDRAW], 255);
    TextDrawFont(g_rgPokerGames[gameId][POT_TEXTDRAW], 2);
    TextDrawLetterSize(g_rgPokerGames[gameId][POT_TEXTDRAW], 0.139999, 0.799999);
    TextDrawColour(g_rgPokerGames[gameId][POT_TEXTDRAW], -6749953);
    TextDrawSetOutline(g_rgPokerGames[gameId][POT_TEXTDRAW], 1);
    TextDrawSetProportional(g_rgPokerGames[gameId][POT_TEXTDRAW], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][POT_TEXTDRAW], 0);
    TextDrawSetSelectable(g_rgPokerGames[gameId][POT_TEXTDRAW], 0);

    return;
}

Pkr_DestroyPotTextDraw(const gameId) {
    TextDrawDestroy(g_rgPokerGames[gameId][POT_TEXTDRAW]);
    g_rgPokerGames[gameId][POT_TEXTDRAW] = Text: INVALID_TEXT_DRAW;
    return;
}

stock Pkr_SetPotAmount(const gameId, const amount)
{
    g_rgPokerGames[gameId][POT] = amount;
    Pkr_SetPotTextDraw(gameId, g_rgPokerGames[gameId][POT]);
    return;
}

#define Pkr_SetPlayerCardOneTextDraw(%0,%1,%2) \
            TextDrawSetString(g_rgPokerGames[%0][PLAYER_GAME_CARD_ONE_TEXTDRAW][%1], %2)

#define Pkr_SetPlayerCardTwoTextDraw(%0,%1,%2) \
            TextDrawSetString(g_rgPokerGames[%0][PLAYER_GAME_CARD_TWO_TEXTDRAW][%1], %2)

Pkr_ShowPlayerCardTextDraws(const playerid, const gameId)
{
    for(new _i; _i < MAX_POKER_PLAYERS; ++_i)
    {
        TextDrawShowForPlayer(playerid, g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][_i]);
        TextDrawShowForPlayer(playerid, g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][_i]);
    }

    return;
}

Pkr_HidePlayerCardTextDraws(const playerid, const gameId) {
    for(new _i; _i < MAX_POKER_PLAYERS; ++_i)
    {
        TextDrawHideForPlayer(playerid, g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][_i]);
        TextDrawHideForPlayer(playerid, g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][_i]);
    }

    return;
}

Pkr_CreatePlayerCardTDs(const gameId)
{
    g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0] = TextDrawCreate(202.000000, 266.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][0], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1] = TextDrawCreate(150.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][1], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2] = TextDrawCreate(202.000000, 140.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][2], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3] = TextDrawCreate(376.000000, 140.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][3], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4] = TextDrawCreate(433.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][4], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5] = TextDrawCreate(376.000000, 266.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][5], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0] = TextDrawCreate(234.000000, 266.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][0], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1] = TextDrawCreate(182.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][1], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2] = TextDrawCreate(234.000000, 140.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][2], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3] = TextDrawCreate(408.000000, 140.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][3], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4] = TextDrawCreate(465.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][4], 0);

    g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5] = TextDrawCreate(408.000000, 266.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 255);
    TextDrawFont(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][5], 0);

    return;
}

Pkr_DestroyPlayerCardTDs(const gameId)
{
    for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i)
    {
        TextDrawDestroy(g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][_i]);
        TextDrawDestroy(g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][_i]);
        g_rgPokerGames[gameId][PLAYER_GAME_CARD_ONE_TEXTDRAW][_i] = Text: INVALID_TEXT_DRAW;
        g_rgPokerGames[gameId][PLAYER_GAME_CARD_TWO_TEXTDRAW][_i] = Text: INVALID_TEXT_DRAW;
    }

    return;
}

#define Pkr_SetPrivateCardOneTextDraw(%0,%1,%2,%3) \
            PlayerTextDrawSetString(%0, g_rgPokerGames[%1][PLAYER_PRIV_CARD_ONE_TEXTDRAW][%2], %3)

#define Pkr_SetPrivateCardTwoTextDraw(%0,%1,%2,%3) \
            PlayerTextDrawSetString(%0, g_rgPokerGames[%1][PLAYER_PRIV_CARD_TWO_TEXTDRAW][%2], %3)

Pkr_CreatePlayerPrivateCardTDs(const gameId, const playerSlot)
{
    new _iPlayerId = Pkr_GetPlayerId(gameId, playerSlot);

    switch(playerSlot)
	{
		case 0:
		{
			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0] = CreatePlayerTextDraw(_iPlayerId, 202.000000, 266.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][0], 0);

			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0] = CreatePlayerTextDraw(_iPlayerId, 234.000000, 266.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][0], 0);
		}

		case 1:
		{
			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1] = CreatePlayerTextDraw(_iPlayerId, 150.000000, 203.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][1], 0);

			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1] = CreatePlayerTextDraw(_iPlayerId, 182.000000, 203.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][1], 0);
		}

		case 2:
		{
			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2] = CreatePlayerTextDraw(_iPlayerId, 202.000000, 140.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][2], 0);

			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2] = CreatePlayerTextDraw(_iPlayerId, 234.000000, 140.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][2], 0);
		}

		case 3:
		{
			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3] = CreatePlayerTextDraw(_iPlayerId, 376.000000, 140.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][3], 0);

			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3] = CreatePlayerTextDraw(_iPlayerId, 408.000000, 140.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][3], 0);
		}

		case 4:
		{
			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4] = CreatePlayerTextDraw(_iPlayerId, 433.000000, 203.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][4], 0);

			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4] = CreatePlayerTextDraw(_iPlayerId, 465.000000, 203.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][4], 0);
		}

		case 5:
		{
			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5] = CreatePlayerTextDraw(_iPlayerId, 376.000000, 266.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][5], 0);

			g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5] = CreatePlayerTextDraw(_iPlayerId, 408.000000, 266.000000, "_");
			PlayerTextDrawBackgroundColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 255);
			PlayerTextDrawFont(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 4);
			PlayerTextDrawLetterSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 0.470000, 0.899999);
			PlayerTextDrawColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], -1);
			PlayerTextDrawSetOutline(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 0);
			PlayerTextDrawSetProportional(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 1);
			PlayerTextDrawSetShadow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 1);
			PlayerTextDrawUseBox(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 1);
			PlayerTextDrawBoxColour(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 255);
			PlayerTextDrawTextSize(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 30.000000, 40.000000);
			PlayerTextDrawSetSelectable(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][5], 0);
		}
	}

	PlayerTextDrawShow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][playerSlot]);
	PlayerTextDrawShow(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][playerSlot]);

	return;
}

Pkr_DestroyPlayerPrivateCardTDs(const gameId, const playerSlot)
{
    new _iPlayerId = Pkr_GetPlayerId(gameId, playerSlot);

    PlayerTextDrawDestroy(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][playerSlot]);
    PlayerTextDrawDestroy(_iPlayerId, g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][playerSlot]);

    g_rgPokerGames[gameId][PLAYER_PRIV_CARD_ONE_TEXTDRAW][playerSlot] = PlayerText:INVALID_TEXT_DRAW;
	g_rgPokerGames[gameId][PLAYER_PRIV_CARD_TWO_TEXTDRAW][playerSlot] = PlayerText:INVALID_TEXT_DRAW;

    return;
}


#define Pkr_SetPlayerCardOneValue(%0,%1,%2) \
            g_rgPokerGames[%0][PLAYER_CARD_ONE_VALUE][%1] = %2

#define Pkr_GetPlayerCardOneValue(%0,%1) \
            g_rgPokerGames[%0][PLAYER_CARD_ONE_VALUE][%1]

#define Pkr_SetPlayerCardTwoValue(%0,%1,%2) \
            g_rgPokerGames[%0][PLAYER_CARD_TWO_VALUE][%1] = %2

#define Pkr_GetPlayerCardTwoValue(%0,%1) \
            g_rgPokerGames[%0][PLAYER_CARD_TWO_VALUE][%1]

stock Pkr_DealPlayerCard(const gameId, const playerSlot)
{
    new _card = PkrSys_ReturnRandomUnusedCard(gameId);
    new _cardValue = g_rgCardDeck[_card];
    new _playerId = Pkr_GetPlayerId(gameId, playerSlot);
    #pragma unused _playerId

    if(Pkr_GetPlayerCardOneValue(gameId, playerSlot) == -1)
    {
        Pkr_SetPlayerCardOneValue(gameId, playerSlot, _cardValue);
		#if !defined POKER_DEBUG
			Pkr_SetPlayerCardOneTextDraw(gameId, playerSlot, "LD_CARD:cdback");
			Pkr_SetPrivateCardOneTextDraw(_playerId, gameId, playerSlot, Pkr_ReturnCardSpriteName(_cardValue));
		#else
			Pkr_SetPlayerCardOneTextDraw(gameId, playerSlot, Pkr_ReturnCardSpriteName(_cardValue));
		#endif
	}
    else if(Pkr_GetPlayerCardTwoValue(gameId, playerSlot) == -1)
    {
        Pkr_SetPlayerCardTwoValue(gameId, playerSlot, _cardValue);
		#if !defined POKER_DEBUG
			Pkr_SetPlayerCardTwoTextDraw(gameId, playerSlot, "LD_CARD:cdback");
			Pkr_SetPrivateCardTwoTextDraw(_playerId, gameId, playerSlot, Pkr_ReturnCardSpriteName(_cardValue));
		#else
			Pkr_SetPlayerCardTwoTextDraw(gameId, playerSlot, Pkr_ReturnCardSpriteName(_cardValue));
		#endif
    }

    return;
}

stock Pkr_ClearPlayerCards(const gameId, const playerSlot)
{
    new _playerId = Pkr_GetPlayerId(gameId, playerSlot);

    Pkr_SetPlayerCardOneValue(gameId, playerSlot, -1);
    Pkr_SetPlayerCardOneTextDraw(gameId, playerSlot, "_");
	Pkr_SetPlayerCardTwoValue(gameId, playerSlot, -1);
    Pkr_SetPlayerCardTwoTextDraw(gameId, playerSlot, "_");

	if(_playerId != INVALID_PLAYER_ID) {
		Pkr_SetPrivateCardOneTextDraw(_playerId, gameId, playerSlot, "_");
		Pkr_SetPrivateCardTwoTextDraw(_playerId, gameId, playerSlot, "_");
	}

    return;
}

stock Pkr_ShowPlayerCards(const gameId, const playerSlot)
{
	new playerId = Pkr_GetPlayerId(gameId, playerSlot);
	new cardOne = Pkr_GetPlayerCardOneValue(gameId, playerSlot);
	new cardTwo = Pkr_GetPlayerCardTwoValue(gameId, playerSlot);


    Pkr_SetPlayerCardOneTextDraw(gameId, playerSlot, Pkr_ReturnCardSpriteName(cardOne));
    Pkr_SetPrivateCardOneTextDraw(playerId, gameId, playerSlot, "_");

    Pkr_SetPlayerCardTwoTextDraw(gameId, playerSlot, Pkr_ReturnCardSpriteName(cardTwo));
    Pkr_SetPrivateCardTwoTextDraw(playerId, gameId, playerSlot, "_");
    return;
}

stock Pkr_ShowAllPlayerCards(const gameId) {
	Pkr_ForeachPlayer(player) {
		if(Pkr_GetPlayerId(gameId, player) != INVALID_PLAYER_ID && Pkr_GetPlayerStatus(gameId, player) != POKER_PLAYER_STATUS: FOLDED)
			Pkr_ShowPlayerCards(gameId, player);
	}
	return;
}

stock Pkr_ClearAllPlayerCards(const gameId)
{
    for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i)
    {
        Pkr_ClearPlayerCards(gameId, _i);
    }

    return;
}

#define Pkr_SetTableCardTextDraw(%0,%1,%2) \
            TextDrawSetString(g_rgPokerGames[%0][TABLE_CARDS_TEXTDRAWS][%1], %2)

#define Pkr_ShowTableCardTextDraws(%0,%1) \
            for(new _i; _i < MAX_TABLE_CARDS; ++_i) TextDrawShowForPlayer(%0, g_rgPokerGames[%1][TABLE_CARDS_TEXTDRAWS][_i])

#define Pkr_HideTableCardTextDraws(%0,%1) \
            for(new _i; _i < MAX_TABLE_CARDS; ++_i) TextDrawHideForPlayer(%0, g_rgPokerGames[%1][TABLE_CARDS_TEXTDRAWS][_i])

Pkr_CreateTableCardTextDraws(const gameId)
{
    g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0] = TextDrawCreate(236.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 255);
    TextDrawFont(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][0], 0);

    g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1] = TextDrawCreate(268.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 255);
    TextDrawFont(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][1], 0);

    g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2] = TextDrawCreate(300.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 255);
    TextDrawFont(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][2], 0);

    g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3] = TextDrawCreate(332.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 255);
    TextDrawFont(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][3], 0);

    g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4] = TextDrawCreate(364.000000, 203.000000, "_");
    TextDrawBackgroundColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 255);
    TextDrawFont(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 4);
    TextDrawLetterSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 0.470000, 0.899999);
    TextDrawColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], -1);
    TextDrawSetOutline(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 0);
    TextDrawSetProportional(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 1);
    TextDrawSetShadow(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 1);
    TextDrawUseBox(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 1);
    TextDrawBoxColour(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 255);
    TextDrawTextSize(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 30.000000, 40.000000);
    TextDrawSetSelectable(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][4], 0);

    return;
}

Pkr_DestroyTableCardTextDraws(const gameId) {
    for(new _i = 0; _i < MAX_TABLE_CARDS; ++_i)
    {
        TextDrawDestroy(g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][_i]);
        g_rgPokerGames[gameId][TABLE_CARDS_TEXTDRAWS][_i] = Text: INVALID_TEXT_DRAW;
    }

    return;
}

#define Pkr_SetTableCardValue(%0,%1,%2) \
            g_rgPokerGames[%0][TABLE_CARD_VALUES][%1] = %2

stock Pkr_DealTableCard(const gameId)
{
    new _card = PkrSys_ReturnRandomUnusedCard(gameId);
    new _cardValue = g_rgCardDeck[_card];
    new _tableCardIndex = Pkr_GetNextTableCardIndex(gameId);

    if(_tableCardIndex == -1)
        return;

    Pkr_SetTableCardValue(gameId, _tableCardIndex, _cardValue);
    Pkr_SetTableCardTextDraw(gameId, _tableCardIndex, Pkr_ReturnCardSpriteName(_cardValue));

    return;
}

stock PkrClearTableCards(const gameId)
{
    for(new _i = 0; _i < MAX_TABLE_CARDS; ++_i)
    {
        Pkr_SetTableCardValue(gameId, _i, -1);
        Pkr_SetTableCardTextDraw(gameId, _i, "_");
    }
}

static stock Pkr_GetNextTableCardIndex(const gameId)
{
    new _index = -1;
    for(new _i = 0; _i < MAX_TABLE_CARDS; ++_i)
    {
        if(g_rgPokerGames[gameId][TABLE_CARD_VALUES][_i] == -1)
        {
            _index = _i;
            break;
        }
    }

    return _index;
}


#if defined POKER_DEBUG
    #include "Stats\StatsMain.pwn"
#endif

Pkr_ShowPlayerTextDraws(const playerId, const gameId)
{
    Pkr_ShowPlayerBackgroundTextDraws(playerId);
    Pkr_ShowPlayerReadyTextDraw(playerId, gameId);
    Pkr_ShowPlayerMenuTextDraws(playerId, gameId);
    Pkr_ShowPlayerStatusTextDraw(playerId, gameId);
    Pkr_ShowPlayerChipsTextDraw(playerId, gameId);
    Pkr_ShowPlayerPotTextDraw(playerId, gameId);
    Pkr_ShowPlayerBlindTextDraw(playerId, gameId);
    Pkr_ShowPlayerCardTextDraws(playerId, gameId);
    Pkr_ShowTableCardTextDraws(playerId, gameId);
	Pkr_ShowTimerTextDraw(playerId, gameId);
    return;
}

Pkr_HidePlayerTextDraws(const playerId, const gameId)
{
    Pkr_HidePlayerBackgroundTextDraws(playerId);
    Pkr_HidePlayerReadyTextDraw(playerId, gameId);
    Pkr_HidePlayerMenuTextDraws(playerId, gameId);
    Pkr_HidePlayerStatusTextDraw(playerId, gameId);
    Pkr_HidePlayerChipsTextDraw(playerId, gameId);
    Pkr_HidePlayerPotTextDraw(playerId, gameId);
    Pkr_HidePlayerBlindTextDraw(playerId, gameId);
    Pkr_HidePlayerCardTextDraws(playerId, gameId);
    Pkr_HideTableCardTextDraws(playerId, gameId);
	Pkr_HideTimerTextDraw(playerId, gameId);
    return;
}

Pkr_CreateGameTextDraws(const gameId)
{
    if(g_rgPokerBackground[0] == Text: INVALID_TEXT_DRAW)
        Pkr_CreateBackgroundTextDraws();

    Pkr_CreateMenuTextDraws(gameId);
    Pkr_CreateReadyTextDraws(gameId);
    Pkr_CreatePlayerStatusTDs(gameId);
    Pkr_CreatePlayerChipsTDs(gameId);
    Pkr_CreatePotTextDraw(gameId);
    Pkr_CreateBlindTextDraw(gameId);
    Pkr_CreatePlayerCardTDs(gameId);
    Pkr_CreateTableCardTextDraws(gameId);
	Pkr_CreateTimerTextDraw(gameId);
    return;
}

Pkr_DestroyGameTextDraws(const gameId)
{
    if(Pkr_GetGameCount() == 0)
        Pkr_DestroyBackgroundTextDraws();

    Pkr_DestroyReadyTextDraws(gameId);
    Pkr_DestroyPotTextDraw(gameId);
    Pkr_DestroyPlayerStatusTDs(gameId);
    Pkr_DestroyPlayerChipsTDs(gameId);
    Pkr_DestroyMenuTextDraws(gameId);
    Pkr_DestroyBlindTextDraw(gameId);
    Pkr_DestroyPlayerCardTDs(gameId);
    Pkr_DestroyTableCardTextDraws(gameId);
	Pkr_DestroyTimerTextDraw(gameId);
    return;
}

#define Pkr_IsPlayerOnAnyGame(%0) \
            (Pkr_GetPlayerGame(%0) != -1)

Pkr_GetPlayerGame(const playerid) {
    for(new _i = 0; _i < MAX_POKER_GAMES; ++_i) {
        new _slot = Pkr_GetPlayerSlot(playerid, _i);
        if(_slot != -1)
            return _i;
    }
    return -1;
}

Pkr_GetPlayerSlot(const playerid, const gameId) {
    for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i) {
        if(g_rgPokerGames[gameId][PLAYERS][_i] == playerid) {
            return _i;
        }
    }
    return -1;
}

Pkr_AssignPlayerToGame(const playerid, const gameId, const chips) {
    if(Pkr_GetIsAssigned(gameId) == true) {
        new _slot = Pkr_GetAvailablePlayerSlot(gameId);
        if(_slot == -1) {
            return false;
        }
        g_rgPokerGames[gameId][PLAYERS][_slot] = playerid;
        Pkr_ShowPlayerTextDraws(playerid, gameId);
        Pkr_SetPlayerNotReady(gameId, _slot);
        Pkr_SetPlayerChips(gameId, _slot, chips);
        Pkr_SetPlayerStatusInLobby(gameId, _slot);
        Pkr_CreatePlayerPrivateCardTDs(gameId, _slot);
        Pkr_ShowCursorForPlayerId(playerid);

        new objectId = furn_pokerTableCheck(playerid);
        if(objectId >= 0) {
			PkrSys_SetPlayerCamera(playerid, objectId);
			SetPVarInt(playerid, POKER_CAMERA_VAR_NAME, 1);
		}

		TogglePlayerControllable(playerid, false);
		GiveMoney(playerid, -chips);
		SetPVarInt(playerid, POKER_SIT_VAR_NAME, 1);
        Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s poker masasùna katùldù. (Oyun ID: %d)", pNome(playerid), gameId);
        //Pkr_Log("%s has joined GameId: %d with: $%d chips.", pNome(playerid), gameId, chips);
        return true;
    }
    return false;
}

furn_pokerTableCheck(playerid)
{
	new data[e_furniture];
	for(new i, j = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i < j; i++)
	{
	    if(!IsValidDynamicObject(i)) continue;
	   	if(!IsPokerTable(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID))) continue;
	    if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, 0)) continue;

	    Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
    	if(IsPlayerInRangeOfPoint(playerid, 3.5, data[furnitureX], data[furnitureY], data[furnitureZ]))
		{
			return data[TempObjectID];
	 	}
	}
	return 0;
}

Pkr_UnassignPlayerFromGame(const playerid, const gameId) {
    new _slot = Pkr_GetPlayerSlot(playerid, gameId);
    if(_slot == -1)
        return false;

	new currentPlayer = Pkr_GetCurrentPlayerPosition(gameId);
	new POKER_GAME_STATUS: gameStatus = Pkr_GetGameStatus(gameId);
	if(currentPlayer == _slot && gameStatus != POKER_GAME_STATUS: LOBBY && gameStatus != POKER_GAME_STATUS: EVALUATION)
		Pkr_SetNextPlayerPlaying(gameId);

	new chips = Pkr_GetPlayerChips(gameId, _slot);
	GiveMoney(playerid, chips);

    Pkr_UnassignPlayerSlotFromGame(gameId, _slot);

    Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s poker masasùndan kalktù. (Oyun ID: %d)", pNome(playerid), gameId);
    //Pkr_Log("%s has left GameId: %d with: $%d chips.", pNome(playerid), gameId, chips);

	new amountOfPlayersOnGame = Pkr_GetAmountOfPlayersOnGame(gameId);
	new POKER_GAME_STATUS: status = Pkr_GetGameStatus(gameId);

	if(amountOfPlayersOnGame == 1 && status != POKER_GAME_STATUS: LOBBY) {
		new nonFoldedPlayer = Pkr_GetCurrentPlayerPosition(gameId);
		new nonFoldedPlayerId = Pkr_GetPlayerId(gameId, nonFoldedPlayer);

		new pot = Pkr_GetPotAmount(gameId);
		// new rakeAmount = Pkr_TakeRake(gameId, pot);
		if(rakeAmount > 0)
			pot -= rakeAmount;

		Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s isimli kiùi herkesin ùùkmasùyla oyunu kazandù.", pNome(nonFoldedPlayerId));
        //Pkr_Log("%s wins GameId: %d due to all players leaving.", pNome(nonFoldedPlayerId), gameId);
		Pkr_AddPlayerChips(gameId, nonFoldedPlayer, pot);
		Pkr_SetPotAmount(gameId, 0);
		Pkr_SetGameToLobby(gameId);
	}
    else if(amountOfPlayersOnGame == 0)
        Pkr_DestroyGame(gameId);

	Pkr_HideCursorForPlayerId(playerid);
	TogglePlayerControllable(playerid, true);
    return true;
}

Pkr_UnassignPlayerSlotFromGame(const gameId, const playerSlot)
{
	new playerid = Pkr_GetPlayerId(gameId, playerSlot);

	if(playerid == INVALID_PLAYER_ID)
        return;

	SetCameraBehindPlayer(playerid);
	DeletePVar(playerid, POKER_SIT_VAR_NAME);

	new POKER_GAME_STATUS: gameStatus = Pkr_GetGameStatus(gameId);

	if(gameStatus == POKER_GAME_STATUS: LOBBY)
		Pkr_ClearPlayerCards(gameId, playerSlot);

    Pkr_DestroyPlayerPrivateCardTDs(gameId, playerSlot);
    Pkr_SetReadyTextDrawEmpty(gameId, playerSlot);
    Pkr_SetPlayerChipsTextDraw(gameId, playerSlot, "_");
    Pkr_SetPlayerStatusTextDrawEmpty(gameId, playerSlot);
    Pkr_HidePlayerTextDraws(Pkr_GetPlayerId(gameId, playerSlot), gameId);
    Pkr_RemovePlayerVars(gameId, playerSlot);
}

#define Pkr_UnassignAllPlayers(%0) \
            for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i) Pkr_UnassignPlayerSlotFromGame(%0, _i)

Pkr_UnassignAllSpectators(const gameId) {
	Pkr_ForeachPlayerIdInPool(playerid) {
		if(GetPVarType(playerid, POKER_SPECTATE_VAR_NAME) != PLAYER_VARTYPE_NONE && GetPVarInt(playerid, POKER_SPECTATE_VAR_NAME) == gameId)
			Pkr_HidePlayerTextDraws(playerid, gameId);
	}
	return;
}

Pkr_GetAmountOfPlayersOnGame(const gameId) {
    if(Pkr_GetIsAssigned(gameId) == true) {
        new _count = 0;
        for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i) {
            if(g_rgPokerGames[gameId][PLAYERS][_i] != INVALID_PLAYER_ID)
                ++_count;
        }
        return _count;
    }
    return -1;
}

Pkr_GetAmountOfJoiningPlayers(const gameId) {
	new count = 0;
	Pkr_ForeachPlayerIdInPool(playerid) {
		if(GetPVarInt(playerid, "Pkr_SitGameId") == gameId)
			++count;
	}
	return count;
}

Pkr_GetAvailablePlayerSlot(const gameId) {
    if(Pkr_GetIsAssigned(gameId) == false)
        return -1;

    for(new _i = 0; _i < MAX_POKER_PLAYERS; ++_i) {
        if(g_rgPokerGames[gameId][PLAYERS][_i] == INVALID_PLAYER_ID)
            return _i;
    }
    return -1;
}

stock Pkr_GetGameNearPlayer(const playerid) {
    for(new _i = 0, Float: _pos[3], Float: _distance; _i < MAX_POKER_GAMES; ++_i) {
        Pkr_GetPosition(_i, _pos[0], _pos[1], _pos[2]);
        _distance = GetPlayerDistanceFromPoint(playerid, _pos[0], _pos[1], _pos[2]);
        if(_distance < 1.6 && Pkr_GetIsAssigned(_i))
            return _i;
    }
    return -1;
}

stock Pkr_GetTableNearPlayer(const playerid) {
    new Float: positionX = 0.0,
        Float: positionY = 0.0,
        Float: positionZ = 0.0,
        Float: distance = 0.0;

    new objectId = INVALID_OBJECT_ID;

    Pkr_ForeachTable(table) {
        if(!TM_DoesIndexContainTable(table))
            continue;

        objectId = TM_GetTableObjectId(table);
        GetDynamicObjectPos(objectId, positionX, positionY, positionZ);

        distance = GetPlayerDistanceFromPoint(playerid, positionX, positionY, positionZ);
        if(distance < 1.6)
            return objectId;
    }

    return INVALID_OBJECT_ID;
}

Pkr_RemovePlayerVars(const gameId, const player) {
    DeletePVar(g_rgPokerGames[gameId][PLAYERS][player], POKER_PLAYER_READY_VAR);
    g_rgPokerGames[gameId][PLAYERS][player] = INVALID_PLAYER_ID;
    g_rgPokerGames[gameId][PLAYER_CHIPS][player] = 0;
    g_rgPokerGames[gameId][PLAYER_STATUS][player] = POKER_PLAYER_STATUS: EMPTY;
    return;
}

#if defined POKER_DEBUG

PkrCMD_AddBot(const playerid, const params[])
{
    new gameId = 0;
    new botId = INVALID_PLAYER_ID;

    if(sscanf(params, "i", gameId))
    {
        SendClientMessage(playerid, COLOR_GREY, "DEBUG USAGE: /pkr addbot [gameId]");
        return;
    }

    botId = Pkr_FindAvailableBot();

    if(botId == INVALID_PLAYER_ID)
    {
        SendClientMessage(playerid, COLOR_RED, "No bots available, either there are no bots connected or they are all assigned to poker games!");
        return;
    }

    static amount = 50000;

    Pkr_AssignPlayerToGame(botId, gameId, amount);

    amount += 10000;

    new message[128];
    format(message, sizeof(message), "You have assigned botId: %d to gameId: %d. You can use '/pkr removebot [botId]' to remove them later.", botId, gameId);
    SendClientMessage(playerid, COLOR_GREEN, message);
    return;
}

PkrCMD_RemoveBot(const playerid, const params[])
{
    new botId = 0;
    if(sscanf(params, "i", botId))
    {
        SendClientMessage(playerid, COLOR_GREY, "USAGE: /pkr removebot [botId]");
        return;
    }

    if(!IsPlayerNPC(botId))
    {
        SendClientMessage(playerid, COLOR_RED, "You can only remove NPC players with this command.");
        return;
    }

    new gameId = Pkr_GetPlayerGame(botId);

    if(gameId == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "That bot is not playing poker.");
        return;
    }

    Pkr_UnassignPlayerFromGame(botId, gameId);

    new message[128];
    format(message, sizeof(message), "You have unassigned botId: %d from gameId: %d.", botId, gameId);
    SendClientMessage(playerid, COLOR_GREEN, message);
    return;
}

static Pkr_FindAvailableBot()
{
    Pkr_ForeachPlayerIdInPool(playerId)
    {
        if(!Pkr_IsPlayerOnAnyGame(playerId) && IsPlayerNPC(playerId))
            return playerId;
    }
    return INVALID_PLAYER_ID;
}

#endif

Pkr_RouteCommands(playerid, cmdtext[])
{
    if(playerid == INVALID_PLAYER_ID)
    {
        SendClientMessage(playerid, COLOR_RED, "Bu sistem pasif.");
    }
    else
    {
        new command[16], parameters[112];
        sscanf(cmdtext, "s[16]s[112]", command, parameters);

    	if(strlen(command) == 0) {
    		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /pkr [komut]");
    		SendClientMessage(playerid, COLOR_GREY, "ùpucu: '/pkr yardim' yazarak tùm listeyi gùrebilirsin.");
    		return true;
    	}

        if(strcmp("katil", command) == 0) PkrCMD_Join(playerid);
        else if(strcmp("ayril", command) == 0) PkrCMD_Leave(playerid);
    	else if(strcmp("mouse", command) == 0) PkrCMD_Mouse(playerid);
        else if(strcmp("baslat", command) == 0) PkrCMD_Start(playerid);
    	else if(strcmp("sonrakiel", command) == 0) PkrCMD_NextHand(playerid);
    	#if defined POKER_DEBUG
        else if(strcmp("istatistik", command) == 0) PkrCMD_Stats(playerid, parameters);
    	else if(strcmp("yoket", command) == 0) PkrCMD_Destroy(playerid, parameters);
    	else if(strcmp("oyuncuanlas", command) == 0) PkrCMD_DealPlayer(playerid, parameters);
    	else if(strcmp("tabloanlas", command) == 0) PkrCMD_DealTable(playerid, parameters);
    	else if(strcmp("addbot", command) == 0) PkrCMD_AddBot(playerid, parameters);
    	else if(strcmp("removebot", command) == 0) PkrCMD_RemoveBot(playerid, parameters);
    	#endif
    	else if(strcmp("izle", command) == 0) PkrCMD_Spectate(playerid);
    	else if(strcmp("cam", command) == 0) PkrCMD_Camera(playerid);
    	else if(strcmp("otur", command) == 0) PkrCMD_Sit(playerid);
    	else if(strcmp("durus", command) == 0) PkrCMD_Stand(playerid);
    	else if(strcmp("kùrlùk", command) == 0) PkrCMD_SetBlind(playerid, parameters);
        else if(strcmp("herkesikùret", command) == 0) PkrCMD_SetBlind(playerid, parameters);
    	else if(strcmp("ùip", command) == 0) PkrCMD_Chips(playerid);
    	else if(strcmp("komisyon", command) == 0) PkrCMD_SetRake(playerid, parameters);
    	else if(strcmp("timer", command) == 0) PkrCMD_SetTimer(playerid, parameters);
    	else if(strcmp("yardim", command) == 0) PkrCMD_Help(playerid);
    }
	return true;
}

CMD:pkr(playerid, cmdtext[])
{
	Pkr_RouteCommands(playerid, cmdtext);
	return true;
}

CMD:poker(playerid, cmdtext[])
{
	Pkr_RouteCommands(playerid, cmdtext);
	return true;
}

#if defined POKER_DEBUG

PkrCMD_DealPlayer(const playerid, const parameters[]) {
	new gameId;
	new slot;
	new cardSlot;
	new card;

	if(sscanf(parameters, "iiii", gameId, slot, cardSlot, card)) {
		SendClientMessage(playerid, COLOR_GREY, "DEBUG USAGE: /pkr dealplayer [gameId] [playerSlot] [cardSlot] [card]");
		return;
	}

	if(slot < 0 || slot >= MAX_POKER_PLAYERS) {
		SendClientMessage(playerid, COLOR_GREY, "The player slot has to be 0 - 5");
		return;
	}

	if(cardSlot != 0 && cardSlot != 1) {
		SendClientMessage(playerid, COLOR_GREY, "The card slot has to be 0 or 1");
		return;
	}

	if(card < 0 || card >= MAX_POKER_DECK_CARDS) {
		SendClientMessage(playerid, COLOR_GREY, "The card has to be 0 to 51");
		return;
	}

	new cardValue = g_rgCardDeck[card];

	if(cardSlot == 0) {
		Pkr_SetPlayerCardOneValue(gameId, slot, cardValue);
		Pkr_SetPlayerCardOneTextDraw(gameId, slot, Pkr_ReturnCardSpriteName(cardValue));
	}
	else {
		Pkr_SetPlayerCardTwoValue(gameId, slot, cardValue);
		Pkr_SetPlayerCardTwoTextDraw(gameId, slot, Pkr_ReturnCardSpriteName(cardValue));
	}

	SendClientMessage(playerid, COLOR_GREY, "Dealt the card to that player!");
	return;
}

PkrCMD_DealTable(const playerid, const parameters[]) {
	new gameId;
	new tableSlot;
	new card;

	if(sscanf(parameters, "iii", gameId, tableSlot, card)) {
		SendClientMessage(playerid, COLOR_GREY, "DEBUG USAGE: /pkr dealtable [gameId] [tableSlot] [card]");
		return;
	}

	if(tableSlot < 0 || tableSlot >= 5) {
		SendClientMessage(playerid, COLOR_GREY, "The table slot has to be 0 - 5.");
		return;
	}

	if(card < 0 || card >= MAX_POKER_DECK_CARDS) {
		SendClientMessage(playerid, COLOR_GREY, "The card has to be 0 to 51");
		return;
	}

	new cardValue = g_rgCardDeck[card];

	Pkr_SetTableCardValue(gameId, tableSlot, cardValue);
	Pkr_SetTableCardTextDraw(gameId, tableSlot, Pkr_ReturnCardSpriteName(cardValue));

	return;
}

#endif

Pkr_CreateTimerTextDraw(const gameId) {
	new Text: textDraw = TextDrawCreate(307.332977, 149.762985, "_");
	Pkr_SetTimerTextdraw(gameId, textDraw);
	TextDrawLetterSize(textDraw, 0.400000, 1.600000);
	TextDrawAlignment(textDraw, 1);
	TextDrawColour(textDraw, -1);
	TextDrawSetShadow(textDraw, 0);
	TextDrawSetOutline(textDraw, 1);
	TextDrawBackgroundColour(textDraw, 255);
	TextDrawFont(textDraw, 1);
	TextDrawSetProportional(textDraw, 1);
	TextDrawSetShadow(textDraw, 0);
	return;
}

Pkr_DestroyTimerTextDraw(const gameId) {
	new Text: textDraw = Pkr_GetTimerTextdraw(gameId);
	TextDrawDestroy(textDraw);
	Pkr_SetTimerTextdraw(gameId, Text: INVALID_TEXT_DRAW);
	return;
}

Pkr_SetTimerTextDrawText(const gameId, const text[]) {
	new Text: textDraw = Pkr_GetTimerTextdraw(gameId);
	new newText[4];
	format(newText, sizeof(newText), "%s", text);
	TextDrawSetString(textDraw, newText);
	return;
}

Pkr_ShowTimerTextDraw(const playerid, const gameId) {
	new Text: textDraw = Pkr_GetTimerTextdraw(gameId);
	TextDrawShowForPlayer(playerid, textDraw);
	return;
}

Pkr_HideTimerTextDraw(const playerid, const gameId) {
	new Text: textDraw = Pkr_GetTimerTextdraw(gameId);
	TextDrawHideForPlayer(playerid, textDraw);
	return;
}

Pkr_SetTimerValue(const gameId, const value) {
	if(Pkr_GetTimerStart(gameId) == 0)
		return;

	new tdText[128];
	format(tdText, sizeof(tdText), "%d", value);
	Pkr_SetTimerTextDrawText(gameId, tdText);
	Pkr_SetTimer(gameId, value);
	return;
}

forward Pkr_OnOneSecond();
public Pkr_OnOneSecond()
{
	Pkr_ForeachGame(gameId)
	{
		if(!Pkr_GetIsAssigned(gameId) || Pkr_GetTimerStart(gameId) == 0) continue;

		new POKER_GAME_STATUS: gameStatus = Pkr_GetGameStatus(gameId);
		if(gameStatus != POKER_GAME_STATUS: LOBBY && gameStatus != POKER_GAME_STATUS: EVALUATION)
		{
			new currentTime = Pkr_GetTimer(gameId);
			if(currentTime <= 6 && currentTime > 0) Pkr_PlaySoundForPlayers(gameId, 1137);

			if(currentTime == 0)
			{
				Pkr_PlaySoundForPlayers(gameId, 1085);
				new playerSlot = Pkr_GetCurrentPlayerPosition(gameId);
				Pkr_SetPlayerStatusFolded(gameId, playerSlot);
				Pkr_SetNextPlayerPlaying(gameId);
				continue;
			}

			Pkr_SetTimerValue(gameId, currentTime - 1);
		}
	}

	return true;
}

Pkr_PlaySoundForPlayers(const gameId, const soundId) {
	Pkr_ForeachPlayer(playerSlot) {
		PlayerPlaySound(Pkr_GetPlayerId(gameId, playerSlot), soundId, 0.0, 0.0, 0.0);
	}
}

PkrCMD_SetTimer(const playerid, const parameters[]) {
	new gameId = Pkr_GetPlayerGame(playerid);

	if(gameId == -1) {
        SendClientMessage(playerid, COLOR_RED, "Poker oynamùyorsun.");
        return;
    }

	new POKER_GAME_STATUS: status = Pkr_GetGameStatus(gameId);
	if(status != POKER_GAME_STATUS: LOBBY) {
		SendClientMessage(playerid, COLOR_RED, "Sùre sadece lobide ayarlanabilir!");
		return;
	}

    new amount;
    if(sscanf(parameters, "i", amount))
    {
		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /pkr timer [miktar]");
        SendClientMessage(playerid, COLOR_GREY, "ùPUCU: Sùreyi 10 - 60 aralùùùnda ayarlayabilirsin.");
		SendClientMessage(playerid, COLOR_GREY, "Miktara 0 girerek sùreyi iptal edebilirsin.");
        return;
    }

	if(amount != 0 && (amount < 10 || amount > 60)) {
		SendClientMessage(playerid, COLOR_RED, "Sùreyi sadece 10 - 60 saniye aralùùùnda ayarlayabilirsin.");
		return;
	}

	Pkr_SetTimerStart(gameId, amount);
	Pkr_SetAllPlayersNotReady(gameId);

	if(amount == 0)
		Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s sùreyi kapattù.", pNome(playerid));
	else
		Pkr_SendFormattedGameMessage(gameId, COLOR_RED, "%s sùreyi %d olarak ayarladù.", pNome(playerid), amount);
	return;
}

PkrCMD_SetRake(const playerid, const parameters[]) {
	new Float: amount;
    if(sscanf(parameters, "f", amount)) {
        SendClientMessage(playerid, COLOR_RED, "KULLANIM: /pkr komisyon [yùzde]");
		SendClientMessage(playerid, COLOR_GREY, "IPUCU: komisyon yùzde 0.0 ila 10.0 arasùnda olabilir.");
        return;
    }

	/*new businessId = GetPlayersCurrentBusiness(playerid);

	if(businessId == -1) {
		SendClientMessage(playerid, COLOR_RED, "You need to be inside a business to use this command.");
        return;
	}*/

	/*new hasAccess = DoesPlayerAccessBusiness(playerid, businessId);

	if(!hasAccess) {
		SendClientMessage(playerid, COLOR_RED, "You need to own or be employed by the business to use this command.");
        return;
	}*/

	if(amount < 0.0 || amount > 10.0) {
		SendClientMessage(playerid, COLOR_RED, "Komisyon yùzde 0.0 ila 10.0 aralùùùnda bir deùer olmalùdùr.");
        return;
	}

	//Pkr_SetRake(businessId, amount);
	new message[128];
	format(message, sizeof(message), "Komisyonu %.1f olarak gùncelledin.", amount);
	SendClientMessage(playerid, COLOR_RED, message);
	return;
}

//#include "TableManager\Main.pwn"