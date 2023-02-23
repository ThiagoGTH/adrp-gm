#define     MAX_PLANTS      	(250)   // limit of drug plants
#define     MAX_DEALERS         (15)    // limit of drug dealers

#define     USE_DRUNKLEVEL              // remove this line if you don't want SetPlayerDrunkLevel to be used while on drugs
#define     PLAYER_LIMIT    	(5)     // a player can plant up to x drug plants (Default: 5)
#define     PLANT_MAX_GROWTH	(75)    // a plant will grow up to x grams of drugs (Default: 75)
#define     GROWTH_INTERVAL 	(45)    // a plant will grow up every x seconds (Default: 45)
#define     ROT_INTERVAL        (300)   // a plant will rot after x seconds of fully growing (Default: 300)
#define     CARRY_LIMIT         (150)   // a player can carry up to x grams of drugs (Default: 150)
#define     SEED_LIMIT         	(25)   	// a player can carry up to x drug plant seeds (Default: 25)
#define     SEED_PRICE      	(50)    // price players will pay for a drug plant seed (Default: 50)
#define     DRUG_BUY_PRICE      (20)    // price players will pay a dealer for a gram of drugs (Default: 20)
#define     DRUG_SELL_PRICE     (16)    // price dealers will pay a player for a gram of drugs (Default: 16)
#define     OFFER_COOLDOWN      (30)    // how many seconds does a player wait to send an another offer to someone (Default: 30)

enum    _:E_DIALOG
{
	DIALOG_DRUG_STATS = 8620,
	DIALOG_CONFIRM_RESET,
	DIALOG_DRUG_DEALER,
	DIALOG_DRUG_DEALER_BUY_SEEDS,
	DIALOG_DRUG_DEALER_BUY_DRUGS,
	DIALOG_DRUG_DEALER_SELL,
	DIALOG_DRUG_OFFER
}

enum    E_PLANT
{
	plantedBy[MAX_PLAYER_NAME],
	Float: plantX,
	Float: plantY,
	Float: plantZ,
	plantGrowth,
	plantObj,
	plantTimer,
	Text3D: plantLabel,
	bool: gotLeaves
}

enum    E_PLAYER
{
	// saved
	Drugs,
	Seeds,
	TotalUsed,
	TotalPlanted,
	TotalHarvestedPlants,
	TotalHarvestedGrams,
	TotalGiven,
	TotalReceived,
	TotalBought,
	TotalBoughtPrice,
	TotalSold,
	TotalSoldPrice,
	// temp
	DrugsCooldown,
	DealerID,
	DrugsOfferedBy,
	DrugsOfferedPrice,
	DrugsOfferCooldown
}

enum    E_DEALER
{
	// loaded from db
	dealerSkin,
	dealerDrugs,
	Float: dealerX,
	Float: dealerY,
	Float: dealerZ,
	Float: dealerA,
	// temp
	dealerActorID,
	Text3D: dealerLabel
}

new
	PlantData[MAX_PLANTS][E_PLANT],
	Iterator: Plants<MAX_PLANTS>;
	
new
	PlayerDrugData[MAX_PLAYERS][E_PLAYER],
	RegenTimer[MAX_PLAYERS] = {-1, ...},
	EffectTimer[MAX_PLAYERS] = {-1, ...};
	
new
	DealerData[MAX_DEALERS][E_DEALER],
	Iterator: Dealers<MAX_DEALERS>;
	
new
	DB: DrugDB;
	
new
	DBStatement: LoadPlayer,
	DBStatement: InsertPlayer,
	DBStatement: SavePlayer;
	
new
	DBStatement: LoadDealers,
	DBStatement: AddDealer,
	DBStatement: UpdateDealer,
	DBStatement: UpdateDealerDrugs,
	DBStatement: RemoveDealer;