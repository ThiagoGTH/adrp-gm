#define     MAX_BANKERS     (20)
#define     MAX_ATMS        (100)

#define     ACCOUNT_PRICE   (100)      	// valor para criar uma conta (default: 100)
#define     ACCOUNT_CLIMIT  (5)         // quantidade máxima de contas que um personagem pode ter
#define     ACCOUNT_LIMIT   (500000000) // valor máximo que uma conta pode ter (default: 500.000.000)

enum    _:E_BANK_LOGTYPE
{
	TYPE_NONE,
	TYPE_LOGIN,
	TYPE_DEPOSIT,
	TYPE_WITHDRAW,
	TYPE_TRANSFER,
	TYPE_PASSCHANGE
}

enum    E_BANKER
{
	// saved
	Skin,
	Float: bankerX,
	Float: bankerY,
	Float: bankerZ,
	Float: bankerA,
	bankerInterior,
	bankerVW,
	// temp
	bankerActorID,
	Text3D: bankerLabel
}

enum    E_ATM
{
	// saved
	Float: atmX,
	Float: atmY,
	Float: atmZ,
	Float: atmRX,
	Float: atmRY,
	Float: atmRZ,
	// temp
	atmObjID,
	
	Text3D: atmLabel
}

new
	BankerData[MAX_BANKERS][E_BANKER],
	ATMData[MAX_ATMS][E_ATM];

new
	Iterator: Bankers<MAX_BANKERS>,
	Iterator: ATMs<MAX_ATMS>;

new
	CurrentAccountID[MAX_PLAYERS] = {-1, ...},
	LogListType[MAX_PLAYERS] = {TYPE_NONE, ...},
	LogListPage[MAX_PLAYERS],
	EditingATMID[MAX_PLAYERS] = {-1, ...};