#include <YSI_Coding\y_hooks>

/* ================================ DEFINIÇÕES ================================ */
#define MAX_STOCKS					    (12)
#define STOCK_REPORTING_PERIOD 		    (86400) // um dia
#define STOCK_REPORTING_PERIODS 	    (30) // últimos trinta dias
#define STOCK_MM_USER_ID			    (0)

#define DIALOG_STOCK_MARKET 		    8923
#define DIALOG_PLAYER_STOCKS 		    8924
#define DIALOG_STOCK_MARKET_BUY 	    8925
#define DIALOG_STOCK_MARKET_SELL 	    8926
#define DIALOG_STOCK_MARKET_OPTIONS     8927
#define DIALOG_STOCK_MARKET_HOLDERS     8928
#define DIALOG_STOCK_MARKET_INFO 	    8929
#define DIALOG_STOCK_POPTIONS 		    8930
#define DIALOG_STOCK_MARKET_DONATE 	    8931

/* ================================ CONSTANTES ================================ */
static const Float: STOCK_MARKET_TRADING_FEE = 0.01;		// porcentagem da taxa de negociação (compra/venda) como decimal
static const Float: STOCK_MARKET_PRICE_FLOOR = 1.0; 		// o menor preço que uma ação pode ter

static const Float: STOCK_DEFAULT_START_POOL = 0.0; 		// o valor padrão para o qual o pool é definido em um novo relatório
static const Float: STOCK_DEFAULT_START_DONATIONS = 0.0;	// o valor padrão em que o pool de doações começa (inútil)
static const Float: STOCK_DEFAULT_START_PRICE = 0.0; 		// o preço inicial padrão para um novo relatório (inútil)

static const Float: STOCK_BANKRUPTCY_PERCENT = -80.0;		// a % que faz uma empresa falir
static const Float: STOCK_BANKRUPTCY_LOSS_PERCENT = 5.0;	// a % que é perdida pelo usuário quando um estoque cai

// static const Float: STOCK_BANKRUPTCY_MIN_PERCENT = -5.0; 	// a % que deve fazer uma empresa falir 'novamente' depois de $1

/* ================================ VARIAVEIS ================================ */
enum E_STOCK_MARKET_DATA
{
	E_NAME[64],					    E_SYMBOL[4],				E_DESCRIPTION[64],
	Float: E_MAX_SHARES,			Float: E_POOL_FACTOR,		Float: E_PRICE_FACTOR,
	Float: E_AVAILABLE_SHARES,

	// market maker
	Float: E_IPO_SHARES,			Float: E_IPO_PRICE,			Float: E_MAX_PRICE
};

enum E_STOCK_MARKET_PRICE_DATA
{
	E_SQL_ID,						Float: E_PRICE, 			Float: E_POOL,
	Float: E_DONATIONS
};

enum
{
	E_STOCK_MINING_COMPANY,
	E_STOCK_VEHICLES,
	E_STOCK_BURGERSHOT,
	E_STOCK_SUPA_SAVE,
	E_STOCK_KEVINCLONE,
	E_STOCK_GOPOSTAL,
	E_STOCK_EYEFIND,
	E_STOCK_MAZE_BANK,
	E_STOCK_DUDE,
	E_STOCK_AVIATION,
	E_STOCK_BATTLE_ROYAL_CENTER
};

static stock
	g_stockMarketData 				[MAX_STOCKS][E_STOCK_MARKET_DATA],
	g_stockMarketReportData 		[MAX_STOCKS][STOCK_REPORTING_PERIODS][E_STOCK_MARKET_PRICE_DATA],
	Iterator: stockmarkets 			<MAX_STOCKS>,

	Float: p_PlayerShares 			[MAX_PLAYERS][MAX_STOCKS],
	bool: p_PlayerHasShare 			[MAX_PLAYERS][MAX_STOCKS char]
;

/* ================================ HOOKS ================================ */
hook OnScriptInit() {
	AddServerVariable("stock_report_time", "0", GLOBAL_VARTYPE_INT);
	AddServerVariable("stock_trading_fees", "0.0", GLOBAL_VARTYPE_FLOAT);

	// 	ID - NAME - SYMBOL - MAX SHARES - IPO_PRICE - MAX_PRICE - POOL_FACTOR - PRICE_FACTOR - DESCRIPTION
	CreateStockMarket(E_STOCK_MINING_COMPANY, "Tianqi Lithium", "TL", 100000.0, 25.0, 500.0, 100000.0, 10.0, "Empresa chinesa de mineração e manufatura");
	CreateStockMarket(E_STOCK_VEHICLES, "Grotti, Inc", "GI", 100000.0, 25.0, 500.0, 100000.0, 10.0,	"Empresa americana automotiva e de armazenamento de energia");
	CreateStockMarket(E_STOCK_BURGERSHOT, "BurgerShot Corporation", "BC", 100000.0, 25.0, 1000.0, 100000.0, 20.0, "Maior cadeia mundial de restaurantes de fast food");
	CreateStockMarket(E_STOCK_SUPA_SAVE, "Supa-Save", "SS", 100000.0, 25.0, 500.0, 100000.0, 10.0, "Empresa multinacional estadunidense de lojas de departamento");
	CreateStockMarket(E_STOCK_KEVINCLONE, "Kevin Clone", "KC", 100000.0, 50.0, 500.0, 100000.0, 20.0, "Empresa estadunidense de calçados, roupas, e acessórios");
	CreateStockMarket(E_STOCK_GOPOSTAL, "GoPostal", "GP", 100000.0, 50.0, 500.0, 100000.0, 20.0, "Empresa estadunidense de entregas e armazenamento");
	CreateStockMarket(E_STOCK_EYEFIND, "Eyefind.info", "EYE", 100000.0, 50.0, 500.0, 100000.0, 20.0, "Empresa de serviços online e software dos Estados Unidos");
	CreateStockMarket(E_STOCK_MAZE_BANK, "Maze Bank", "MB", 100000.0, 990.0, 7500.0, 100000.0, 150.0, "É uma cadeia de bancos de San Andreas");
	CreateStockMarket(E_STOCK_DUDE, "DUDE", "DD", 100000.0, 750.0, 7500.0, 100000.0, 150.0, "Empresa de maquinários pesados e produtos químicos");
	CreateStockMarket(E_STOCK_AVIATION, "Adios Airlines", "AA", 100000.0, 50.0, 500.0, 100000.0, 20.0, "Maior companhia aérea de SA em número de passageiros");
	CreateStockMarket(E_STOCK_BATTLE_ROYAL_CENTER, "Department of Water & Power", "DWP", 100000.0, 50.0, 500.0, 100000.0, 20.0, "Empresa governamental, que fornece água e eletricidade");

	// force inactive share holders to sell their shares on startup
	/*mysql_format(DBConn, query, sizeof(query), "SELECT so.* FROM `STOCK_OWNERS` so JOIN `players` u ON so.`USER_ID`=u. `ID` WHERE UNIX_TIMESTAMP() -u. `last_login` >604800 AND so.`USER_ID` != %d", STOCK_MM_USER_ID);
	mysql_tquery(DBConn, query, "StockMarket_ForceShareSale");*/
	
	return true;
}

hook OnTradingUpdate() {
	mysql_format(DBConn, query, sizeof(query), "SELECT so.* FROM `STOCK_OWNERS` so JOIN `players` u ON so.`USER_ID`=u. `ID` WHERE UNIX_TIMESTAMP() -u. `last_login` >604800 AND so.`USER_ID` != %d", STOCK_MM_USER_ID);
	mysql_tquery(DBConn, query, "StockMarket_ForceShareSale", "");
	return true;
}

hook OnServerUpdate() {
	new current_time = GetServerTime();
	new last_reporting = GetServerVariableInt("stock_report_time");

	// check if its reporting time
	if (current_time > last_reporting) {
		// reporting period
		UpdateServerVariableInt("stock_report_time", current_time + STOCK_REPORTING_PERIOD);

		// create a new reporting period for every stock there
		foreach (new s : stockmarkets) {
			StockMarket_ReleaseDividends(s);
		}

		print("Novo período de relatório criado com sucesso para todas as empresas on-line");
	}
	return true;
}

hook OnPlayerDisconnect(playerid, reason) {
	for (new i = 0; i < MAX_STOCKS; i ++) {
		p_PlayerShares[playerid][i] = 0.0;
		p_PlayerHasShare[playerid] { i } = false;
	}
	return true;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if (dialogid == DIALOG_STOCK_MARKET && response) {
		new
			x = 0;

		foreach (new s : stockmarkets) {
			if (x == listitem) {
				ShowPlayerStockMarketOptions(playerid, s);
				SetPVarInt(playerid, "stockmarket_selection", s);
				break;
			}
			x ++;
		}
		return true;
	}
	else if ((dialogid == DIALOG_STOCK_MARKET_HOLDERS || dialogid == DIALOG_STOCK_MARKET_INFO) && ! response) {
		new
			stockid = GetPVarInt(playerid, "stockmarket_selection");

		if (!Iter_Contains(stockmarkets, stockid)) {
			return SendErrorMessage(playerid, "Ocorreu um erro com a ação que você estava visualizando, tente novamente.");
		}
		return ShowPlayerStockMarketOptions(playerid, stockid);
	} else if (dialogid == DIALOG_STOCK_MARKET_OPTIONS) {
		if (!response) {
			return ShowPlayerStockMarket(playerid);
		}

		new stockid = GetPVarInt(playerid, "stockmarket_selection");

		if (!Iter_Contains(stockmarkets, stockid)) {
			return SendErrorMessage(playerid, "Ocorreu um erro com a ação que você estava visualizando, tente novamente.");
		}

		switch (listitem) {
			case 0: StockMarket_ShowBuySlip(playerid, stockid);
			case 1: StockMarket_ShowDonationSlip(playerid, stockid);
			case 2: {
				mysql_format(DBConn, query, sizeof(query), "SELECT s.*, u.`name` FROM `STOCK_OWNERS` s LEFT JOIN `players` u ON s.`USER_ID` = u.`ID` WHERE s.`STOCK_ID`= %d ORDER BY s.`SHARES` DESC", stockid);
				mysql_tquery(DBConn, query, "StockMarket_ShowShareholders", "dd", playerid, stockid);
			}
			case 3: {
				new Float: market_cap = g_stockMarketReportData[stockid][1][E_PRICE] * g_stockMarketData[stockid][E_MAX_SHARES] / 1000000.0;

				format(
					szLargeString, sizeof (szLargeString),
					"{AFAFAF}Ação\t{FFFFFF}%s\n\
					{AFAFAF}Símbolo\t{FFFFFF}%s\n\
					{AFAFAF}Preço Atual\t{FFFFFF}%s\n\
					{AFAFAF}Máximo de Ações\t{FFFFFF}%s\n\
					{AFAFAF}Capitalização\t{FFFFFF}%sM\n\
					{AFAFAF}Ganhos (24H)\t{FFFFFF}%s\n\
					{AFAFAF}Doações (24H)\t{FFFFFF}%s\n\
					{AFAFAF}Descrição\t{FFFFFF}%s",
					g_stockMarketData[stockid][E_NAME], g_stockMarketData[stockid][E_SYMBOL],
					FormatCash(g_stockMarketReportData[stockid][1][E_PRICE], .decimals = 2),
					FormatNumber2(g_stockMarketData[stockid][E_MAX_SHARES], .decimals = 0),
					FormatCash(market_cap, .decimals = 2),
					FormatCash(g_stockMarketReportData[stockid][0][E_POOL] - g_stockMarketReportData[stockid][0][E_DONATIONS], .decimals = 0),
					FormatCash(g_stockMarketReportData[stockid][0][E_DONATIONS], .decimals = 0),
					g_stockMarketData[stockid][E_DESCRIPTION]
				);
				ShowPlayerDialog(playerid, DIALOG_STOCK_MARKET_INFO, DIALOG_STYLE_TABLIST, "Mercado de Ações", szLargeString, "Fechar", "Voltar");
			}
		}
		return true;
	} else if (dialogid == DIALOG_STOCK_MARKET_DONATE) {
		new stockid = GetPVarInt(playerid, "stockmarket_selection");
		if (!Iter_Contains(stockmarkets, stockid)) return SendErrorMessage(playerid, "Ocorreu um erro com a ação que você estava visualizando, tente novamente.");
		if (!response) return ShowPlayerStockMarketOptions(playerid, stockid);
		
		new donation_amount;
		if (sscanf(inputtext, "d", donation_amount)) SendErrorMessage(playerid, "Você não especificou um valor de doação válido.");
		else if (!(100 <= donation_amount <= 10000000)) SendErrorMessage(playerid, "Você deve especificar um valor entre $100 e $10.000.000 para doar.");
		else if (donation_amount > GetMoney(playerid)) SendErrorMessage(playerid, "Você não possui esse dinheiro com você.");
		else {
			new
				final_donation_amount = floatround(float(donation_amount) * 0.5);

			// contribuição
			StockMarket_UpdateEarnings(stockid, final_donation_amount, .donation_amount = final_donation_amount);

			// reduce player balance and alert
			GiveMoney(playerid, -donation_amount);
			SendServerMessage(playerid, "Os acionistas de %s agradecem sua doação de %s!", g_stockMarketData[stockid][E_NAME], FormatCash(donation_amount));
			return true;
		}
		return StockMarket_ShowDonationSlip(playerid, stockid);
	} else if (dialogid == DIALOG_PLAYER_STOCKS && response) {
		new x = 0;

		foreach (new stockid : stockmarkets) if (p_PlayerHasShare[playerid] { stockid }) {
			if (x == listitem) {
				ShowPlayerShareOptions(playerid, stockid);
				SetPVarInt(playerid, "stockmarket_selling_stock", stockid);
				break;
			}
			x ++;
		}
		return true;
	} else if (dialogid == DIALOG_STOCK_POPTIONS) {
		if (!response) return ShowPlayerShares(playerid);
		new stockid = GetPVarInt(playerid, "stockmarket_selling_stock");

		if (!Iter_Contains(stockmarkets, stockid)) return SendErrorMessage(playerid, "Ocorreu um erro ao processar seu pedido de venda. Tente novamente.");
		

		switch (listitem) {
			case 0: StockMarket_ShowSellSlip(playerid, stockid);
			case 1: {
				mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `STOCK_SELL_ORDERS` WHERE `USER_ID` = %d AND `STOCK_ID` = %d", GetPlayerSQLID(playerid), stockid);
				mysql_tquery(DBConn, query, "StockMarket_OnCancelOrder", "d", playerid);
			}
		}
		return true;
	} else if (dialogid == DIALOG_STOCK_MARKET_SELL) {
		new stockid = GetPVarInt(playerid, "stockmarket_selling_stock");
		if (!Iter_Contains(stockmarkets, stockid)) return SendErrorMessage(playerid, "Ocorreu um erro ao processar seu pedido de venda. Tente novamente.");
		if (!response) return ShowPlayerShareOptions(playerid, stockid);
		
		new input_shares;
		if (sscanf(inputtext, "d", input_shares)) SendErrorMessage(playerid, "Você deve usar um valor válido.");
		else if (input_shares > floatround(p_PlayerShares[playerid][stockid], floatround_floor)) SendErrorMessage(playerid, "Você não tem tantas ações disponíveis para vender.");
		else if (input_shares < 1) SendErrorMessage(playerid, "O número mínimo de ações que você pode vender é 1.");
		else {
			new Float: shares = float(input_shares);

			if ((p_PlayerShares[playerid][stockid] -= shares) < 0.1) {
				mysql_single_query(sprintf("DELETE FROM `STOCK_OWNERS` WHERE `USER_ID`=%d AND `STOCK_ID`=%d", GetPlayerSQLID(playerid), stockid));
			} else {
				StockMarket_GiveShares(stockid, GetPlayerSQLID(playerid), -shares);
			}
			StockMarket_UpdateSellOrder(stockid, GetPlayerSQLID(playerid), shares);
			SendServerMessage(playerid, "Você fez uma ordem de venda para as ações de %s a %s cada. Use /shares para cancelar ordens de venda", FormatNumber2(shares, .decimals = 2), FormatCash(g_stockMarketReportData[stockid][1][E_PRICE], .decimals = 2));
			return true;
		}
		return StockMarket_ShowSellSlip(playerid, stockid);
	}
	else if (dialogid == DIALOG_STOCK_MARKET_BUY)
	{
		new
			stockid = GetPVarInt(playerid, "stockmarket_selection");

		if (response)
		{
			new
				shares;

			if (sscanf(inputtext, "d", shares)) SendErrorMessage(playerid, "Você deve usar um valor válido.");
			else if (shares < 1) SendErrorMessage(playerid, "O número mínimo de ações que você pode comprar é 1.");
			else {
				mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `STOCK_SELL_ORDERS` WHERE `STOCK_ID`= '%d' ORDER BY `LIST_DATE` ASC", stockid);
				mysql_tquery(DBConn, query, "StockMarket_OnPurchaseOrder", "ddf", playerid, stockid, float(shares));
				return true;
			}
			return StockMarket_ShowBuySlip(playerid, stockid);
		} else 
			return ShowPlayerStockMarket(playerid);
		
	}
	return true;
}

/* ================================ SQL ================================ */
Stock_UpdateReportingPeriods(stockid) {
	new
		rows = cache_get_row_count();

	if (rows) {
		for (new row = 0; row < rows; row ++) {
			g_stockMarketReportData[stockid][row][E_SQL_ID] = cache_get_field_content_int(row, "ID");
			g_stockMarketReportData[stockid][row][E_POOL] = cache_get_field_content_float(row, "POOL");
			g_stockMarketReportData[stockid][row][E_DONATIONS] = cache_get_field_content_float(row, "DONATIONS");
			g_stockMarketReportData[stockid][row][E_PRICE] = cache_get_field_content_float(row, "PRICE");
		}
	} else { // no historical reporting data, restock the market maker
		for (new i = 0; i < 3; i ++) { // create 3 reports for the company using the IPO price ... this way the price is not $0
			StockMarket_ReleaseDividends(stockid, .is_ipo = true);
		}
		// put market maker shares on the market
		StockMarket_UpdateSellOrder(stockid, STOCK_MM_USER_ID, g_stockMarketData[stockid][E_IPO_SHARES]);
	}
	return true;
}

StockMarket_InsertReport(stockid, Float: default_start_pool, Float: default_start_price, Float: default_donation_pool, bool: is_ipo) {
	new Float: before_price = g_stockMarketReportData[stockid][1][E_PRICE];

	// set the new price of the company [ todo: use parabola for factor difficulty?]
	new Float: new_price = (g_stockMarketReportData[stockid][0][E_POOL] / g_stockMarketData[stockid][E_POOL_FACTOR]) * g_stockMarketData[stockid][E_PRICE_FACTOR] + STOCK_MARKET_PRICE_FLOOR;

	// reduce price of shares depending on shares available from the start (200K max shares from IPO 100k means 50% reduction)
	new_price *= floatpower(0.5, g_stockMarketData[stockid][E_MAX_SHARES] / g_stockMarketData[stockid][E_IPO_SHARES] - 1.0);

	// check if price exceeds maximum price
	if (new_price > g_stockMarketData[stockid][E_MAX_PRICE]) { // dont want wild market caps
		new_price = g_stockMarketData[stockid][E_MAX_PRICE];
	}

	// force a minimum of $1 per share
	if (new_price < STOCK_MARKET_PRICE_FLOOR) {
		new_price = STOCK_MARKET_PRICE_FLOOR;
	}

	// check if its an ipo... if it is then set to ipo price
	if (is_ipo) {
		new_price = g_stockMarketData[stockid][E_IPO_PRICE];
	}

	// bankrupt motherf**kers
	new Float: price_change = ((new_price / before_price) - 1.0) * 100.0;

	// stock is above the floor
	if (price_change <= STOCK_BANKRUPTCY_PERCENT) {
		format(szLargeString, sizeof(szLargeString),
			"SELECT   USER_ID, SUM(HELD_SHARES) AS HELD_SHARES, SUM(OWNED_SHARES) AS OWNED_SHARES " \
			"FROM     (" \
			"	(SELECT STOCK_ID, USER_ID, SHARES AS HELD_SHARES, 0 AS OWNED_SHARES FROM STOCK_SELL_ORDERS t1 WHERE STOCK_ID=%d) " \
			"	UNION ALL " \
			"	(SELECT STOCK_ID, USER_ID, 0 AS HELD_SHARES, SHARES AS OWNED_SHARES FROM STOCK_OWNERS t2 WHERE STOCK_ID=%d) " \
			") t_union " \
			"GROUP BY USER_ID",
			stockid, stockid
		);
		mysql_tquery(dbHandle, szLargeString, "StockMarket_PanicSell", "d", stockid);
	}

	// full bankruptcy if a stock is $1 (UNTESTED!)
	// else if (price_change <= STOCK_BANKRUPTCY_MIN_PERCENT && new_price == STOCK_MARKET_PRICE_FLOOR)
	// {
	// 	// purge all user association to the stock
	// 	mysql_single_query(sprintf("DELETE FROM `STOCK_SELL_ORDERS` WHERE `STOCK_ID`=%d", stockid));
	// 	mysql_single_query(sprintf("DELETE FROM `STOCK_OWNERS` WHERE `STOCK_ID`=%d", stockid));

	// 	// allow market maker to sell the shares again at IPO price
	// 	StockMarket_UpdateSellOrder(stockid, STOCK_MM_USER_ID, g_stockMarketData[stockid][E_IPO_SHARES]);
	// 	new_price = g_stockMarketData[stockid][E_IPO_PRICE];

	// 	// inform everyone of the sale
	// 	SendClientMessageToAllFormatted(-1, "[STOCKS] %s has went bankrupt, all shareholders have suffered a loss!", g_stockMarketData[stockid][E_NAME]);
	// 	printf("[STOCK MAJOR BANKRUPTCY] %s(%d) has went majorly bankrupt.", g_stockMarketData[stockid][E_NAME], stockid);
	// }

	// set the new price of the asset
	g_stockMarketReportData[stockid][0][E_PRICE] = new_price;
	mysql_single_query(sprintf("UPDATE `STOCK_REPORTS` SET `PRICE` = %f WHERE `ID` = %d", g_stockMarketReportData[stockid][0][E_PRICE], g_stockMarketReportData[stockid][0][E_SQL_ID]));

	// store temporary stock info
	new temp_stock_price_data[MAX_STOCKS][STOCK_REPORTING_PERIODS][E_STOCK_MARKET_PRICE_DATA];
	temp_stock_price_data = g_stockMarketReportData;

	// shift all report data by one
	for (new r = 0; r < sizeof(g_stockMarketReportData[]) - 2; r ++) {
		g_stockMarketReportData[stockid][r + 1][E_SQL_ID] = temp_stock_price_data[stockid][r][E_SQL_ID];
		g_stockMarketReportData[stockid][r + 1][E_POOL] = temp_stock_price_data[stockid][r][E_POOL];
		g_stockMarketReportData[stockid][r + 1][E_DONATIONS] = temp_stock_price_data[stockid][r][E_DONATIONS];
		g_stockMarketReportData[stockid][r + 1][E_PRICE] = temp_stock_price_data[stockid][r][E_PRICE];
	}

	// reset earnings
	g_stockMarketReportData[stockid][0][E_SQL_ID] = cache_insert_id();
	g_stockMarketReportData[stockid][0][E_POOL] = default_start_pool;
	g_stockMarketReportData[stockid][0][E_DONATIONS] = default_donation_pool;
	g_stockMarketReportData[stockid][0][E_PRICE] = default_start_price;
	return true;
}

StockMarket_PanicSell(stockid)
{
	new
		rows = cache_get_row_count();

	if (rows)
	{
		new
			Float: global_shares_forfeited = 0.0;

		// remove the percentage of stock from the user
		for (new row = 0; row < rows; row ++)
		{
			new user_id = cache_get_field_content_int(row, "USER_ID");

			if (user_id == STOCK_MM_USER_ID)
				continue; // ignore market maker account

			new Float: held_shares = cache_get_field_content_float(row, "HELD_SHARES");
			new Float: owned_shares = cache_get_field_content_float(row, "OWNED_SHARES");
			new Float: player_shares_forfeited = floatround((held_shares + owned_shares) * STOCK_BANKRUPTCY_LOSS_PERCENT / 100.0);

			// the amount forfeitted succeeds the amount in sale orders ... remove them
			if ((held_shares - player_shares_forfeited) <= 0.0) {
				// printf("Strip sell orders if there is any for user %d, stock %d", user_id, stockid);
				mysql_single_query(sprintf("DELETE FROM `STOCK_SELL_ORDERS` WHERE `STOCK_ID`=%d AND `USER_ID`=%d", stockid, user_id));
				player_shares_forfeited -= held_shares;
				global_shares_forfeited += held_shares;
			} else {
				// printf("Deduct sell orders if there is any for user %d, stock %d", user_id, stockid);
				mysql_single_query(sprintf("UPDATE `STOCK_SELL_ORDERS` SET `SHARES`=%f WHERE `STOCK_ID`=%d AND `USER_ID`=%d", held_shares - player_shares_forfeited, stockid, user_id));
				global_shares_forfeited += player_shares_forfeited;
				player_shares_forfeited = 0.0;
			}

			// the amount forfeitted succeeds the amount in holdings ... remove them too
			if ((owned_shares - player_shares_forfeited) <= 0.0) {
				// printf("Strip owners if there is any for user %d, stock %d", user_id, stockid);
				mysql_single_query(sprintf("DELETE FROM `STOCK_OWNERS` WHERE `STOCK_ID`=%d AND `USER_ID`=%d", stockid, user_id));
				global_shares_forfeited += owned_shares;
			} else {
				// printf("Deduct owners if there is any for user %d, stock %d", user_id, stockid);
				mysql_single_query(sprintf("UPDATE `STOCK_OWNERS` SET `SHARES`=%f WHERE `STOCK_ID`=%d AND `USER_ID`=%d", owned_shares - player_shares_forfeited, stockid, user_id));
				global_shares_forfeited += player_shares_forfeited;
			}
		}

		// allow market maker to sell the shares again at IPO price
		StockMarket_UpdateSellOrder(stockid, STOCK_MM_USER_ID, floatround(global_shares_forfeited));

		// inform everyone of the sale
		SendClientMessageToAllFormatted(-1, "[STOCKS] %s has penalized its shareholders and has %d shares available for sale.", g_stockMarketData[stockid][E_NAME], floatround(global_shares_forfeited));
		printf("[STOCK MAJOR BANKRUPTCY] %s(%d) has went partly bankrupt.", g_stockMarketData[stockid][E_NAME], stockid);
	}
	return true;
}

StockMarket_OnPurchaseOrder(playerid, stockid, Float: shares)
{
	new
		rows = cache_get_row_count();

	if (!rows) {
		return SendErrorMessage(playerid, "This stock has no available shares for sale.");
	}

	// check if quantity is valid
	new
		Float: available_quantity = 0.0;

	for (new r = 0; r < rows; r ++) {
		available_quantity += cache_get_field_content_float(r, "SHARES");
	}

	if (shares > available_quantity) {
		return SendErrorMessage(playerid, "There are not that many shares available for sale."), StockMarket_ShowBuySlip(playerid, stockid), 1;
	}

	// check if the player has the money for the purchase
	new Float: ask_price = g_stockMarketReportData[stockid][1][E_PRICE];
	new purchase_cost = floatround(ask_price * shares);

	new Float: purchase_fee = ask_price * shares * STOCK_MARKET_TRADING_FEE;

	UpdateServerVariableFloat("stock_trading_fees", GetServerVariableFloat("stock_trading_fees") + (purchase_fee / 1000.0));

	new purchase_cost_plus_fee = purchase_cost + floatround(purchase_fee);

	if (GetMoney(playerid) < purchase_cost_plus_fee) {
		return SendErrorMessage(playerid, "You need at least %s to purchase this many shares.", FormatCash(purchase_cost_plus_fee)), StockMarket_ShowBuySlip(playerid, stockid), 1;
	}

	new
		Float: amount_remaining = shares;

	for (new row = 0; row < rows; row ++)
	{
		new sell_order_user_id = cache_get_field_content_int(row, "USER_ID");
		new Float: sell_order_shares = cache_get_field_content_float(row, "SHARES");

		// check if seller is online
		new
			sellerid;

		foreach (sellerid : Player) if (GetPlayerSQLID(sellerid) == sell_order_user_id) {
			break;
		}

		new Float: sold_shares = amount_remaining > sell_order_shares ? sell_order_shares : amount_remaining;

		StockMarket_CreateTradeLog(stockid, GetPlayerSQLID(playerid), sell_order_user_id, sold_shares, ask_price);

		new Float: sold_amount_fee = sold_shares * ask_price * STOCK_MARKET_TRADING_FEE;

		UpdateServerVariableFloat("stock_trading_fees", GetServerVariableFloat("stock_trading_fees") + (sold_amount_fee / 1000.0));

		new sold_amount_minus_fee = floatround(sold_shares * ask_price - sold_amount_fee);

		if (0 <= sellerid < MAX_PLAYERS && Iter_Contains(Player, sellerid) && IsPlayerLoggedIn(sellerid)) {
			GivePlayerBankMoney(sellerid, sold_amount_minus_fee), Beep(sellerid);
			SendServerMessage(sellerid, "You have sold %s %s shares to %s(%d) for %s (plus %0.1f%s fee)!", FormatNumber2(sold_shares, .decimals = 0), g_stockMarketData[stockid][E_NAME], ReturnPlayerName(playerid), playerid, FormatCash(sold_amount_minus_fee), STOCK_MARKET_TRADING_FEE * 100.0, "%%");
		} else {
			mysql_single_query(sprintf("UPDATE `USERS` SET `BANKMONEY` = `BANKMONEY` + %d WHERE `ID` = %d", sold_amount_minus_fee, sell_order_user_id));
		}

		// remove the sell order if there is little to no shares available
		if (sell_order_shares - amount_remaining < 1.0)
		{
			// get rid of this sell order
			mysql_single_query(sprintf("DELETE FROM `STOCK_SELL_ORDERS` WHERE `USER_ID`=%d and `STOCK_ID`=%d", sell_order_user_id, stockid));

			// deduct the sell order amount from amount remaining
			amount_remaining -= sell_order_shares;

			// remove number of available shares
			g_stockMarketData[stockid][E_AVAILABLE_SHARES] -= sell_order_shares;
		}
		else
		{
			// reduce sell order quantity
			StockMarket_UpdateSellOrder(stockid, sell_order_user_id, -amount_remaining);

			// the player's buy order was filled in the single sell order ... prevent updating
			break;
		}
	}

	// increment the players shares
	StockMarket_GiveShares(stockid, GetPlayerSQLID(playerid), shares);

	// reduce player balance and alert
	GiveMoney(playerid, -purchase_cost_plus_fee);
	SendServerMessage(playerid, "You have purchased %s shares of %s (@ %s/ea) for %s. (inc. %0.1f%s fee)", FormatNumber2(shares, .decimals = 0), g_stockMarketData[stockid][E_NAME], FormatCash(ask_price, .decimals = 2), FormatCash(purchase_cost_plus_fee), STOCK_MARKET_TRADING_FEE * 100.0, "%%");
	return true;
}

StockMarket_OnShowBuySlip(playerid, stockid)
{
	new
		rows = cache_get_row_count();

	if (!rows) {
		return SendErrorMessage(playerid, "This stock does not currently have any shares available to buy.");
	}

	new
		Float: available_quantity = cache_get_field_content_float(0, "SALE_SHARES");

	format(
		szBigString, sizeof (szBigString),
		"You can buy shares of %s for {36A717}%s each.\n\nThere are %s available shares to buy.",
		g_stockMarketData[stockid][E_NAME],
		FormatCash(g_stockMarketReportData[stockid][1][E_PRICE], .decimals = 2),
		FormatNumber2(available_quantity, .decimals = 0)
	);
	ShowPlayerDialog(playerid, DIALOG_STOCK_MARKET_BUY, DIALOG_STYLE_INPUT, "Mercado de Ações", szBigString, "Buy", "Back");
	return true;
}

StockMarket_OnShowShares(playerid)
{
	new
		rows = cache_get_row_count();

	if (!rows) {
		return SendErrorMessage(playerid, "You are not holding any shares of any company.");
	}

	szLargeString = "Stock\tActive Shares\tShares Being Sold\t{36A717}Value ($)\n";

	for (new row = 0; row < rows; row ++)
	{
		new
			stockid = cache_get_field_content_int(row, "STOCK_ID");

		if (Iter_Contains(stockmarkets, stockid))
		{
			new Float: shares = cache_get_field_content_float(row, "OWNED_SHARES");
			new Float: held_shares = cache_get_field_content_float(row, "HELD_SHARES");

			format(
				szLargeString, sizeof(szLargeString),
				"%s%s (%s)\t%s (%0.2f%%)\t%s (%0.2f%%)\t{36A717}%s\n",
				szLargeString,
				g_stockMarketData[stockid][E_NAME],
				g_stockMarketData[stockid][E_SYMBOL],
				FormatNumber2(shares, .decimals = 0),
				(shares / g_stockMarketData[stockid][E_MAX_SHARES]) * 100.0,
				FormatNumber2(held_shares, .decimals = 0),
				(held_shares / g_stockMarketData[stockid][E_MAX_SHARES]) * 100.0,
				FormatCash(floatround((shares + held_shares) * g_stockMarketReportData[stockid][1][E_PRICE]))
			);

			// store player stocks in a variable for reference
			p_PlayerShares[playerid][stockid] = shares;
			p_PlayerHasShare[playerid] { stockid } = true;
		}
		else
		{
			p_PlayerHasShare[playerid] { stockid } = false;
		}
	}
	return ShowPlayerDialog(playerid, DIALOG_PLAYER_STOCKS, DIALOG_STYLE_TABLIST_HEADERS, "Mercado de Ações", szLargeString, "Select", "Close"), 1;
}

Stock_OnDividendPayout(stockid, bool: is_ipo)
{
	new
		rows = cache_get_row_count();

	// pay out existing shareholders
	if (rows)
	{
		new
			Float: total_shares = g_stockMarketData[stockid][E_MAX_SHARES];

		for (new row = 0; row < rows; row ++)
		{
			new account_id = cache_get_field_content_int(row, "USER_ID");
			new Float: shares_owned = cache_get_field_content_float(row, "SHARES");

			new Float: dividend_rate = shares_owned / total_shares;
			new dividend_payout = floatround(g_stockMarketReportData[stockid][0][E_POOL] * dividend_rate);

			new
				shareholder;

			foreach (shareholder : Player) if (GetPlayerSQLID(shareholder) == account_id) {
				break;
			}

			if (0 <= shareholder < MAX_PLAYERS && Iter_Contains(Player, shareholder)) {
				GivePlayerBankMoney(shareholder, dividend_payout), Beep(shareholder);
				SendServerMessage(shareholder, "You have been paid a %s dividend (%0.2f%s) for owning %s!", FormatCash(dividend_payout), dividend_rate * 100.0, "%%", g_stockMarketData[stockid][E_NAME]);
			} else {
				mysql_single_query(sprintf("UPDATE `USERS` SET `BANKMONEY` = `BANKMONEY` + %d WHERE `ID` = %d", dividend_payout, account_id));
			}
		}
	}

	// insert to database a new report
	mysql_format(dbHandle, szBigString, sizeof (szBigString), "INSERT INTO `STOCK_REPORTS` (`STOCK_ID`, `POOL`, `DONATIONS`, `PRICE`) VALUES (%d, %f, %f, %f)", stockid, STOCK_DEFAULT_START_POOL, STOCK_DEFAULT_START_DONATIONS, STOCK_DEFAULT_START_PRICE);
	mysql_tquery(dbHandle, szBigString, "StockMarket_InsertReport", "dfffd", stockid, STOCK_DEFAULT_START_POOL, STOCK_DEFAULT_START_DONATIONS, STOCK_DEFAULT_START_PRICE, bool: is_ipo);
	return true;
}

Stock_UpdateMaximumShares(stockid)
{
	new
		rows = cache_get_row_count();

	if (rows)
	{
		g_stockMarketData[stockid][E_AVAILABLE_SHARES] = cache_get_field_content_float(0, "SHARES_HELD");
		g_stockMarketData[stockid][E_MAX_SHARES] = g_stockMarketData[stockid][E_AVAILABLE_SHARES] + cache_get_field_content_float(0, "SHARES_OWNED");

		// rows shown but still showing as 0 maximum shares? set it to the ipo issued amount
		if (!g_stockMarketData[stockid][E_MAX_SHARES])
		{
			g_stockMarketData[stockid][E_AVAILABLE_SHARES] = g_stockMarketData[stockid][E_IPO_SHARES];
			g_stockMarketData[stockid][E_MAX_SHARES] = g_stockMarketData[stockid][E_IPO_SHARES];
		}
	}
	else
	{
		g_stockMarketData[stockid][E_AVAILABLE_SHARES] = g_stockMarketData[stockid][E_IPO_SHARES];
		g_stockMarketData[stockid][E_MAX_SHARES] = g_stockMarketData[stockid][E_IPO_SHARES];
	}
	return true;
}

StockMarket_OnCancelOrder(playerid)
{
	new
		rows = cache_get_row_count();

	if (rows)
	{
		new
			player_account = GetPlayerSQLID(playerid);

		for (new row = 0; row < rows; row ++)
		{
			new stockid = cache_get_field_content_int(row, "STOCK_ID");
			new Float: shares = cache_get_field_content_float(row, "SHARES");

			g_stockMarketData[stockid][E_AVAILABLE_SHARES] -= shares;
			mysql_single_query(sprintf("DELETE FROM `STOCK_SELL_ORDERS` WHERE `STOCK_ID`=%d AND `USER_ID`=%d", stockid, player_account));
			StockMarket_GiveShares(stockid, player_account, shares);

			SendServerMessage(playerid, "You have cancelled your order of to sell %s shares of %s.", FormatNumber2(shares, .decimals = 0), g_stockMarketData[stockid][E_NAME]);
		}
		return true;
	}
	else
	{
		return ShowPlayerShares(playerid), SendErrorMessage(playerid, "You don't have any sell orders for this stock to cancel."), 1;
	}
}

StockMarket_ShowShareholders(playerid, stockid)
{
	new rows = cache_get_row_count();

	// format dialog title
	szHugeString = "User\tShares\tPercentage (%)\n";

	// track the shares that are held by players
	new Float: out_standing_shares = g_stockMarketData[stockid][E_MAX_SHARES];

	// show all the shareholders
	if (rows)
	{
		new
			player_name[24];

		for (new row = 0; row < rows; row ++)
		{
			cache_get_field_content(row, "NAME", player_name);

			new is_online = cache_get_field_content_int(row, "ONLINE");
			new Float: shares = cache_get_field_content_float(row, "SHARES");

			out_standing_shares -= shares;
			format(szHugeString, sizeof (szHugeString), "%s%s%s\t%s\t%s%%\n", szHugeString, is_online ? COL_GREEN : COL_WHITE, player_name, FormatNumber2(shares, .decimals = 0), FormatNumber2(shares / g_stockMarketData[stockid][E_MAX_SHARES] * 100.0, .decimals = 3));
		}
	}

	// tell players the shares tied up in sell orders
	if (out_standing_shares > 0.0) {
		format(szHugeString, sizeof (szHugeString), "%s{666666}Held In Sell Orders\t{666666}%s\t{666666}%s%%\n", szHugeString, FormatNumber2(out_standing_shares, .decimals = 0), FormatNumber2(out_standing_shares / g_stockMarketData[stockid][E_MAX_SHARES] * 100.0, .decimals = 3));
	}

	// format dialog
	ShowPlayerDialog(playerid, DIALOG_STOCK_MARKET_HOLDERS, DIALOG_STYLE_TABLIST_HEADERS, "Mercado de Ações - Shareholders", szHugeString, "Fechar", "Voltar");
	return true;
}

StockMarket_ForceShareSale()
{
	new
		rows = cache_get_row_count();

	if (rows)
	{
		for (new row = 0; row < rows; row ++)
		{
			new accountid = cache_get_field_content_int(row, "USER_ID");
			new stockid = cache_get_field_content_int(row, "STOCK_ID");
			new Float: shares = cache_get_field_content_float(row, "SHARES");

			mysql_single_query(sprintf("DELETE FROM `STOCK_OWNERS` WHERE `USER_ID`=%d AND `STOCK_ID`=%d", accountid, stockid));
			StockMarket_UpdateSellOrder(stockid, accountid, shares);
			printf("Inactive shares (user id: %d, stock id: %s, shares: %f)", accountid, g_stockMarketData[stockid][E_NAME], shares);
		}
	}
	return true;
}

/* ================================ COMANDOS ================================ */
//CMD:stocks(playerid, params[]) return cmd_stockmarkets(playerid, params);
CMD:stockmarkets(playerid, params[])
{
	SendServerMessage(playerid, "The stock market will payout dividends in %s.", secondstotime(GetServerVariableInt("stock_report_time") - GetServerTime()));
	return ShowPlayerStockMarket(playerid);
}

CMD:shares(playerid, params[])
{
	return ShowPlayerShares(playerid);
}

CMD:astock(playerid, params[])
{
	if (!IsPlayerAdmin(playerid) || ! IsPlayerLeadMaintainer(playerid)) {
		return false;
	}

	if (strmatch(params, "update maxshares")) {
		foreach (new s : stockmarkets) {
			UpdateStockMaxShares(s);
		}
		return SendServerMessage(playerid, "Max shares has been updated for all stocks.");
	}
	else if (strmatch(params, "new report")) {
		foreach (new s : stockmarkets) {
			StockMarket_ReleaseDividends(s);
		}
		UpdateServerVariableInt("stock_report_time", GetServerTime() + STOCK_REPORTING_PERIOD);
		return SendServerMessage(playerid, "All stocks have now had their dividends distributed.");
	}
	return SendUsage(playerid, "/astock [UPDATE MAXSHARES/NEW REPORT]");
}

/* ================================ FUNÇÕES ================================ */
static stock CreateStockMarket(stockid, const name[64], const symbol[4], Float: ipo_shares, Float: ipo_price, Float: max_price, Float: pool_factor, Float: price_factor, const description[72])
{
	if (!Iter_Contains(stockmarkets, stockid))
	{
		strcpy(g_stockMarketData[stockid][E_NAME], name);
		strcpy(g_stockMarketData[stockid][E_SYMBOL], symbol);
		strcpy(g_stockMarketData[stockid][E_DESCRIPTION], description);

		g_stockMarketData[stockid][E_IPO_SHARES] = ipo_shares;
		g_stockMarketData[stockid][E_IPO_PRICE] = ipo_price;
		g_stockMarketData[stockid][E_MAX_PRICE] = max_price;
		g_stockMarketData[stockid][E_POOL_FACTOR] = pool_factor;
		g_stockMarketData[stockid][E_PRICE_FACTOR] = price_factor;

		// reset stock price information
		for (new r = 0; r < sizeof(g_stockMarketReportData[]); r ++) {
			g_stockMarketReportData[stockid][r][E_POOL] = 0.0;
			g_stockMarketReportData[stockid][r][E_DONATIONS] = 0.0;
			g_stockMarketReportData[stockid][r][E_PRICE] = 0.0;
		}

		// load price information if there is
 		mysql_tquery(dbHandle, sprintf("SELECT * FROM `STOCK_REPORTS` WHERE `STOCK_ID`=%d ORDER BY `REPORTING_TIME` DESC, `ID` DESC LIMIT %d", stockid, sizeof(g_stockMarketReportData[])), "Stock_UpdateReportingPeriods", "d", stockid);

 		// load the maximum number of shares
		UpdateStockMaxShares(stockid);

 		// add to iterator
		Iter_Add(stockmarkets, stockid);
	}
	return stockid;
}

static stock StockMarket_ReleaseDividends(stockid, bool: is_ipo = false)
{
	mysql_format(dbHandle, szBigString, sizeof (szBigString), "SELECT * FROM `STOCK_OWNERS` WHERE `STOCK_ID`=%d", stockid);
	mysql_tquery(dbHandle, szBigString, "Stock_OnDividendPayout", "dd", stockid, is_ipo);
	return true;
}

stock StockMarket_UpdateEarnings(stockid, amount, Float: factor = 1.0, Float: donation_amount = 0.0)
{
	if (!Iter_Contains(stockmarkets, stockid))
		return false;

	// ensure that pool remains always above 0 dollars
	if ((g_stockMarketReportData[stockid][0][E_POOL] += float(amount) * factor) < 0.0) {
		g_stockMarketReportData[stockid][0][E_POOL] = 0.0;
	}

	// update donation amount
	g_stockMarketReportData[stockid][0][E_DONATIONS] += donation_amount;

	// save to database
	mysql_single_query(sprintf("UPDATE `STOCK_REPORTS` SET `POOL`=%f, `DONATIONS`=%f WHERE `ID` = %d", g_stockMarketReportData[stockid][0][E_POOL], g_stockMarketReportData[stockid][0][E_DONATIONS], g_stockMarketReportData[stockid][0][E_SQL_ID]));
	return true;
}

static stock StockMarket_GiveShares(stockid, accountid, Float: shares)
{
	mysql_format(
		dbHandle, szBigString, sizeof (szBigString),
		"INSERT INTO `STOCK_OWNERS` (`USER_ID`, `STOCK_ID`, `SHARES`) VALUES (%d, %d, %f) ON DUPLICATE KEY UPDATE `SHARES` = `SHARES` + %f",
		accountid, stockid, shares, shares
	);
	mysql_single_query(szBigString);
}

static stock StockMarket_UpdateSellOrder(stockid, accountid, Float: shares)
{
	mysql_format(
		dbHandle, szBigString, sizeof (szBigString),
		"INSERT INTO `STOCK_SELL_ORDERS` (`STOCK_ID`, `USER_ID`, `SHARES`) VALUES (%d, %d, %f) ON DUPLICATE KEY UPDATE `SHARES` = `SHARES` + %f",
		stockid, accountid, shares, shares
	);
	mysql_single_query(szBigString);

	// we are just using this variable to loosely track available shares
	g_stockMarketData[stockid][E_AVAILABLE_SHARES] += shares;
}

static stock StockMarket_CreateTradeLog(stockid, buyer_acc, seller_acc, Float: shares, Float: price)
{
	mysql_format(
		dbHandle, szBigString, sizeof (szBigString),
		"INSERT INTO `STOCK_TRADE_LOG` (`STOCK_ID`, `BUYER_ID`, `SELLER_ID`, `SHARES`, `PRICE`) VALUES (%d, %d, %d, %f, %f)",
		stockid, buyer_acc, seller_acc, shares, price
	);
	mysql_single_query(szBigString);
}

static stock StockMarket_ShowBuySlip(playerid, stockid)
{
	mysql_tquery(dbHandle, sprintf("SELECT SUM(`SHARES`) AS `SALE_SHARES` FROM `STOCK_SELL_ORDERS` WHERE `STOCK_ID`=%d", stockid), "StockMarket_OnShowBuySlip", "dd", playerid, stockid);
	return true;
}

static stock StockMarket_ShowSellSlip(playerid, stockid)
{
	format(
		szLargeString, sizeof (szLargeString),
		"You can sell shares of %s for {36A717}%s each.\n\nThough, you will have to wait until a person buys them.\n\nYou have %s available shares to sell.",
		g_stockMarketData[stockid][E_NAME],
		FormatCash(g_stockMarketReportData[stockid][1][E_PRICE], .decimals = 2),
		FormatNumber2(p_PlayerShares[playerid][stockid], .decimals = 0)
	);
	ShowPlayerDialog(playerid, DIALOG_STOCK_MARKET_SELL, DIALOG_STYLE_INPUT, "Mercado de Ações", szLargeString, "Sell", "Back");
	return true;
}

static stock StockMarket_ShowDonationSlip(playerid, stockid)
{
	format(
		szLargeString, sizeof (szLargeString),
		"Donations can be used to prop up %s's stock price.\n\n50%% of the money donated is distributed as dividends.\n\nYou do not get any shares for donating to a company!",
		g_stockMarketData[stockid][E_NAME]
	);
	ShowPlayerDialog(playerid, DIALOG_STOCK_MARKET_DONATE, DIALOG_STYLE_INPUT, "Mercado de Ações", szLargeString, "Donate", "Back");
	return true;
}

static stock ShowPlayerStockMarket(playerid)
{
	szLargeString = "Stock\tAvailable Shares\tDividend Per Share ($)\tPrice ($)\n";

	foreach (new s : stockmarkets)
	{
		new Float: price_change = ((g_stockMarketReportData[s][1][E_PRICE] / g_stockMarketReportData[s][2][E_PRICE]) - 1.0) * 100.0;
		new Float: payout = g_stockMarketReportData[s][0][E_POOL] / g_stockMarketData[s][E_MAX_SHARES];

		format(
			szLargeString, sizeof(szLargeString),
			"%s%s (%s)\t%s\t{36A717}%s\t%s%s (%s%%)\n",
			szLargeString,
			g_stockMarketData[s][E_NAME],
			g_stockMarketData[s][E_SYMBOL],
			FormatNumber2(g_stockMarketData[s][E_AVAILABLE_SHARES], .decimals = 0),
			FormatCash(payout, .decimals = 2),
			price_change >= 0.0 ? COLOR_GREEN : COLOR_RED,
			FormatCash(g_stockMarketReportData[s][1][E_PRICE], .decimals = 2),
			FormatNumber2(price_change, .decimals = 2, .prefix = (price_change >= 0.0 ? '+' : '\0'))
		);
	}
	return ShowPlayerDialog(playerid, DIALOG_STOCK_MARKET, DIALOG_STYLE_TABLIST_HEADERS, "Mercado de Ações", szLargeString, "Select", "Close");
}

static stock ShowPlayerStockMarketOptions(playerid, stockid)
{
	format(szBigString, sizeof(szBigString), "Buy shares\t{36A717}%s\nDonate to company\t>>>\nView shareholders\t>>>\nView stock information\t>>>", FormatCash(g_stockMarketReportData[stockid][1][E_PRICE], .decimals = 2));
	ShowPlayerDialog(playerid, DIALOG_STOCK_MARKET_OPTIONS, DIALOG_STYLE_TABLIST, sprintf("Mercado de Ações - %s", g_stockMarketData[stockid][E_NAME]), szBigString, "Select", "Back");
	return true;
}

static stock ShowPlayerShareOptions(playerid, stockid)
{
	format(szBigString, sizeof(szBigString), "Sell shares\t{36A717}%s\n{FF0000}Cancel Sell Orders\t{FF0000}>>>", FormatCash(g_stockMarketReportData[stockid][1][E_PRICE], .decimals = 2));
	ShowPlayerDialog(playerid, DIALOG_STOCK_POPTIONS, DIALOG_STYLE_TABLIST, sprintf("Mercado de Ações - %s", g_stockMarketData[stockid][E_NAME]), szBigString, "Select", "Back");
	return true;
}

static stock ShowPlayerShares(playerid)
{
	new
		accountid = GetPlayerSQLID(playerid);

	mysql_format(
		dbHandle, szLargeString, 512,
		"SELECT   STOCK_ID, SUM(HELD_SHARES) AS HELD_SHARES, SUM(OWNED_SHARES) AS OWNED_SHARES " \
		"FROM     (" \
		"	(SELECT STOCK_ID, USER_ID, SHARES AS HELD_SHARES, 0 AS OWNED_SHARES FROM STOCK_SELL_ORDERS t1 WHERE USER_ID=%d) " \
		"	UNION ALL " \
		"	(SELECT STOCK_ID, USER_ID, 0 AS HELD_SHARES, SHARES AS OWNED_SHARES FROM STOCK_OWNERS t2 WHERE USER_ID=%d) " \
		") t_union " \
		"GROUP BY STOCK_ID",
		accountid, accountid
	);
	mysql_tquery(dbHandle, szLargeString, "StockMarket_OnShowShares", "d", playerid);
	return true;
}

static stock UpdateStockMaxShares(stockid) {
	mysql_tquery(dbHandle, sprintf("SELECT (SELECT SUM(`SHARES`) FROM `STOCK_OWNERS` WHERE `STOCK_ID`=%d) AS `SHARES_OWNED`, (SELECT SUM(`SHARES`) FROM `STOCK_SELL_ORDERS` WHERE `STOCK_ID`=%d) AS `SHARES_HELD`", stockid, stockid), "Stock_UpdateMaximumShares", "d", stockid);
}

/*
	DROP TABLE `STOCK_REPORTS`;
	CREATE TABLE IF NOT EXISTS `STOCK_REPORTS` (
		`ID` int(11) primary key auto_increment,
		`STOCK_ID` int(11),
		`POOL` float,
		`PRICE` float,
		`REPORTING_TIME` TIMESTAMP default CURRENT_TIMESTAMP
	);
	ALTER TABLE STOCK_REPORTS ADD DONATIONS float DEFAULT 0.0 AFTER POOL;

	DROP TABLE `STOCK_OWNERS`;
	CREATE TABLE IF NOT EXISTS `STOCK_OWNERS` (
		`USER_ID` int(11),
		`STOCK_ID` int(11),
		`SHARES` float,
		PRIMARY KEY (USER_ID, STOCK_ID)
	);

	DROP TABLE `STOCK_SELL_ORDERS`;
	CREATE TABLE IF NOT EXISTS `STOCK_SELL_ORDERS` (
		`STOCK_ID` int(11),
		`USER_ID` int(11),
		`SHARES` float,
		`LIST_DATE` TIMESTAMP default CURRENT_TIMESTAMP,
		PRIMARY KEY (STOCK_ID, USER_ID)
	);

	DROP TABLE `STOCK_TRADE_LOG`;
	CREATE TABLE IF NOT EXISTS `STOCK_TRADE_LOG` (
		`ID` int(11) primary key auto_increment,
		`STOCK_ID` int(11),
		`BUYER_ID` int(11),
		`SELLER_ID` int(11),
		`SHARES` float,
		`PRICE` float,
		`DATE` TIMESTAMP default CURRENT_TIMESTAMP
	);
 */
