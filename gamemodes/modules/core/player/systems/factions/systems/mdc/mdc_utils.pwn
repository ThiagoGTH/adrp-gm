#define MDC_PAGE_MAIN 						(1)
#define MDC_PAGE_LOOKUP 					(2)
#define MDC_PAGE_WARRANTS					(3)
#define MDC_PAGE_EMERGENCY					(4)
#define MDC_PAGE_ROSTER						(5)
#define MDC_PAGE_DATABASE					(6)
#define MDC_PAGE_CCTV						(7)
#define MDC_PAGE_STAFF						(8)
#define MDC_PAGE_VEHICLEBOLO 		        (9)

#define MDC_PAGE_LOOKUP_NAME				(10)
#define MDC_PAGE_LOOKUP_PLATE				(11)
#define MDC_PAGE_LOOKUP_BUILDING			(21)

#define MAX_EMERGENCY_SHOW 					(4)
#define MAX_BOLO_SHOW 						(20)
#define MAX_ROSTER_SHOW 					(19)
#define MAX_CRIMINALDATA_SHOW 				(20)
#define MAX_PENAL_SHOW 						(19)
#define MAX_ADRESSLIST_SHOW 				(3)

new PlayerText:MDC_Main[MAX_PLAYERS][18];
new PlayerText:MDC_MainScreen[MAX_PLAYERS][8];

new PlayerText:MDC_LookUp_Name[MAX_PLAYERS][18];
new PlayerText:MDC_LookUp_Vehicle[MAX_PLAYERS][17];
new PlayerText:MDC_AdressDetails[MAX_PLAYERS][14];
new PlayerText:MDC_CrimeHistory[MAX_PLAYERS][24];
new PlayerText:MDC_SelectedCrimeDetails[MAX_PLAYERS][6];
new PlayerText:MDC_ManageLicense[MAX_PLAYERS][34];
new PlayerText:MDC_PenalCode[MAX_PLAYERS][49];

new PlayerText:MDC_Emergency[MAX_PLAYERS][24];
new PlayerText:MDC_EmergencyDetails[MAX_PLAYERS][5];

new PlayerText:MDC_CriminalRecords[MAX_PLAYERS][21];
new PlayerText:MDC_CriminalRecordDetail[MAX_PLAYERS][5];

new PlayerText:MDC_Warrants[MAX_PLAYERS][24];
new PlayerText:MDC_Roster[MAX_PLAYERS][40];
new PlayerText:MDC_CCTV[MAX_PLAYERS][17];
//new PlayerText:MDC_ADRESSICON[MAX_PLAYERS][1];
new PlayerText:MDC_VehicleBolo_Details[MAX_PLAYERS][6];
new PlayerText:MDC_VehicleBolo_List[MAX_PLAYERS][23];

new lastBoloModel[MAX_PLAYERS][24],
	lastBoloPlate[MAX_PLAYERS][24],
	lastBoloCrimes[MAX_PLAYERS][512],
	lastBoloReportShow[MAX_PLAYERS][512],
	lastBoloReport[MAX_PLAYERS][512];

new MDC_PlayerLastSearched[MAX_PLAYERS][24],
	MDC_PlastLastSearched_SQLID[MAX_PLAYERS];

new Player_CCTVPage[MAX_PLAYERS];
new MDC_CallsID[MAX_PLAYERS][7];
new MDC_BolosID[MAX_PLAYERS][21];
new MDC_CriminalDataID[MAX_PLAYERS][MAX_CRIMINALDATA_SHOW];
new MDC_PenalID[MAX_PLAYERS][20];


new MDC_ArrestRecordCount[MAX_PLAYERS] = 0,
	MDC_ArrestRecord[MAX_PLAYERS][31][128];