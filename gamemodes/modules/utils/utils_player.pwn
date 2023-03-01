#include <a_samp>

#define Kick(%0)    			SetTimerEx("kickfix", 40, false, "d", %0)
#define Ban(%0)     			SetTimerEx("banfix", 50, false, "d", %0)

enum e_InteriorData {
	e_InteriorName[32],
	e_InteriorID,
	Float:e_InteriorX,
	Float:e_InteriorY,
	Float:e_InteriorZ
};

new const g_arrInteriorData[][e_InteriorData] = {
	{"24/7 1", 17, -25.884498, -185.868988, 1003.546875},
    {"24/7 2", 10, 6.091179, -29.271898, 1003.549438},
    {"24/7 3", 18, -30.946699, -89.609596, 1003.546875},
    {"24/7 4", 16, -25.132598, -139.066986, 1003.546875},
    {"24/7 5", 4, -27.312299, -29.277599, 1003.557250},
    {"24/7 6", 6, -26.691598, -55.714897, 1003.546875},
    {"Airport Ticket", 14, -1827.147338, 7.207417, 1061.143554},
    {"Airport Baggage", 14, -1861.936889, 54.908092, 1061.143554},
    {"Shamal", 1, 1.808619, 32.384357, 1199.593750},
    {"Andromada", 9, 315.745086, 984.969299, 1958.919067},
    {"Ammunation 1", 1, 286.148986, -40.644397, 1001.515625},
    {"Ammunation 2", 4, 286.800994, -82.547599, 1001.515625},
    {"Ammunation 3", 6, 296.919982, -108.071998, 1001.515625},
    {"Ammunation 4", 7, 314.820983, -141.431991, 999.601562},
    {"Ammunation 5", 6, 316.524993, -167.706985, 999.593750},
    {"Ammunation Booths", 7, 302.292877, -143.139099, 1004.062500},
    {"Ammunation Range", 7, 298.507934, -141.647048, 1004.054748},
    {"Blastin Fools Hallway", 3, 1038.531372, 0.111030, 1001.284484},
    {"Budget Inn Motel Room", 12, 444.646911, 508.239044, 1001.419494},
    {"Jefferson Motel", 15, 2215.454833, -1147.475585, 1025.796875},
    {"Off Track Betting Shop", 3, 833.269775, 10.588416, 1004.179687},
    {"Sex Shop", 3, -103.559165, -24.225606, 1000.718750},
    {"Meat Factory", 1, 963.418762, 2108.292480, 1011.030273},
    {"Zero's RC shop", 6, -2240.468505, 137.060440, 1035.414062},
    {"Dillimore Gas", 0, 663.836242, -575.605407, 16.343263},
    {"Catigula's Basement", 1, 2169.461181, 1618.798339, 999.976562},
    {"FC Janitor Room", 10, 1889.953369, 1017.438293, 31.882812},
    {"Woozie's Office", 1, -2159.122802, 641.517517, 1052.381713},
    {"Binco", 15, 207.737991, -109.019996, 1005.132812},
    {"Didier Sachs", 14, 204.332992, -166.694992, 1000.523437},
    {"Prolaps", 3, 207.054992, -138.804992, 1003.507812},
    {"Suburban", 1, 203.777999, -48.492397, 1001.804687},
    {"Victim", 5, 226.293991, -7.431529, 1002.210937},
    {"Zip", 18, 161.391006, -93.159156, 1001.804687},
    {"Club", 17, 493.390991, -22.722799, 1000.679687},
    {"Bar", 11, 501.980987, -69.150199, 998.757812},
    {"Lil' Probe Inn", 18, -227.027999, 1401.229980, 27.765625},
    {"Jay's Diner", 4, 457.304748, -88.428497, 999.554687},
    {"Gant Bridge Diner", 5, 454.973937, -110.104995, 1000.077209},
    {"Secret Valley Diner", 6, 435.271331, -80.958938, 999.554687},
    {"World of Coq", 1, 452.489990, -18.179698, 1001.132812},
    {"Welcome Pump", 1, 681.557861, -455.680053, -25.609874},
    {"Burger Shot", 10, 375.962463, -65.816848, 1001.507812},
    {"Cluckin' Bell", 9, 369.579528, -4.487294, 1001.858886},
    {"Well Stacked Pizza", 5, 373.825653, -117.270904, 1001.499511},
    {"Rusty Browns Donuts", 17, 381.169189, -188.803024, 1000.632812},
    {"Denise's Room", 1, 244.411987, 305.032989, 999.148437},
    {"Katie's Room", 2, 271.884979, 306.631988, 999.148437},
    {"Helena's Room", 3, 291.282989, 310.031982, 999.148437},
    {"Michelle's Room", 4, 302.180999, 300.722991, 999.148437},
    {"Barbara's Room", 5, 322.197998, 302.497985, 999.148437},
    {"Millie's Room", 6, 346.870025, 309.259033, 999.155700},
    {"Sherman Dam", 17, -959.564392, 1848.576782, 9.000000},
    {"Planning Dept", 3, 384.808624, 173.804992, 1008.382812},
    {"Area 51", 0, 223.431976, 1872.400268, 13.734375},
    {"LS Gym", 5, 772.111999, -3.898649, 1000.728820},
    {"SF Gym", 6, 774.213989, -48.924297, 1000.585937},
    {"LV Gym", 7, 773.579956, -77.096694, 1000.655029},
    {"B-Dup's House", 3, 1527.229980, -11.574499, 1002.097106},
    {"B-Dup's Crack Pad", 2, 1523.509887, -47.821197, 1002.130981},
    {"CJ's House", 3, 2496.049804, -1695.238159, 1014.742187},
    {"Madd Doggs Mansion", 5, 1267.663208, -781.323242, 1091.906250},
    {"OG Loc's House", 3, 513.882507, -11.269994, 1001.565307},
    {"Ryders House", 2, 2454.717041, -1700.871582, 1013.515197},
    {"Sweet's House", 1, 2527.654052, -1679.388305, 1015.498596},
    {"Crack Factory", 2, 2543.462646, -1308.379882, 1026.728393},
    {"Big Spread Ranch", 3, 1212.019897, -28.663099, 1000.953125},
    {"Fanny batters", 6, 761.412963, 1440.191650, 1102.703125},
    {"Strip Club", 2, 1204.809936, -11.586799, 1000.921875},
    {"Strip Club (Private Room)", 2, 1204.809936, 13.897239, 1000.921875},
    {"Unnamed Brothel", 3, 942.171997, -16.542755, 1000.929687},
    {"Tiger Skin Brothel", 3, 964.106994, -53.205497, 1001.124572},
    {"Pleasure Domes", 3, -2640.762939, 1406.682006, 906.460937},
    {"Liberty City Outside", 1, -729.276000, 503.086944, 1371.971801},
    {"Liberty City Inside", 1, -794.806396, 497.738037, 1376.195312},
    {"Gang House", 5, 2350.339843, -1181.649902, 1027.976562},
    {"Colonel Furhberger's", 8, 2807.619873, -1171.899902, 1025.570312},
    {"Crack Den", 5, 318.564971, 1118.209960, 1083.882812},
    {"Warehouse 1", 1, 1412.639892, -1.787510, 1000.924377},
    {"Warehouse 2", 18, 1302.519897, -1.787510, 1001.028259},
    {"Sweet's Garage", 0, 2522.000000, -1673.383911, 14.866223},
    {"Lil' Probe Inn Toilet", 18, -221.059051, 1408.984008, 27.773437},
    {"Unused Safe House", 12, 2324.419921, -1145.568359, 1050.710083},
    {"RC Battlefield", 10, -975.975708, 1060.983032, 1345.671875},
    {"Barber 1", 2, 411.625976, -21.433298, 1001.804687},
    {"Barber 2", 3, 418.652984, -82.639793, 1001.804687},
    {"Barber 3", 12, 412.021972, -52.649898, 1001.898437},
    {"Tatoo Parlor 1", 16, -204.439987, -26.453998, 1002.273437},
    {"Tatoo Parlor 2", 17, -204.439987, -8.469599, 1002.273437},
    {"Tatoo Parlor 3", 3, -204.439987, -43.652496, 1002.273437},
    {"LS Police HQ", 6, 246.783996, 63.900199, 1003.640625},
    {"SF Police HQ", 10, 246.375991, 109.245994, 1003.218750},
    {"LV Police HQ", 3, 288.745971, 169.350997, 1007.171875},
    {"Driving School", 3, -2029.798339, -106.675910, 1035.171875},
    {"8-Track", 7, -1398.065307, -217.028900, 1051.115844},
    {"Bloodbowl", 15, -1398.103515, 937.631164, 1036.479125},
    {"Dirt Track", 4, -1444.645507, -664.526000, 1053.572998},
    {"Kickstart", 14, -1465.268676, 1557.868286, 1052.531250},
    {"Vice Stadium", 1, -1401.829956, 107.051300, 1032.273437},
    {"SF Garage", 0, -1790.378295, 1436.949829, 7.187500},
    {"LS Garage", 0, 1643.839843, -1514.819580, 13.566620},
    {"SF Bomb Shop", 0, -1685.636474, 1035.476196, 45.210937},
    {"Blueberry Warehouse", 0, 76.632553, -301.156829, 1.578125},
    {"LV Warehouse 1", 0, 1059.895996, 2081.685791, 10.820312},
    {"LV Warehouse 2 (hidden part)", 0, 1059.180175, 2148.938720, 10.820312},
    {"Caligula's Hidden Room", 1, 2131.507812, 1600.818481, 1008.359375},
    {"Bank", 0, 2315.952880, -1.618174, 26.742187},
    {"Bank (Behind Desk)", 0, 2319.714843, -14.838361, 26.749565},
    {"LS Atrium", 18, 1710.433715, -1669.379272, 20.225049}
};

// Armazenar a variável de nome do jogador diretamente na string, ao invés de ter que terceirizar essa necessidade.

GetPlayerNameEx(playerid) {
    new returnString[24];
    GetPlayerName(playerid, returnString);
    return returnString;
}

// Basicamente a mesma coisa que a função de cima, mas pegar diretamente o IP do jogador.

GetPlayerIP(playerid) {
    new returnIP[16];
    GetPlayerIp(playerid, returnIP, 16);
    return returnIP;
}

Float:GetPlayerHealthEx(playerid) {
    new Float:formattedHealth;
    
    GetPlayerHealth(playerid, formattedHealth);

    return formattedHealth;
}

Float:GetPlayerArmourEx(playerid) {
    new Float:formattedArmour;
    
    GetPlayerArmour(playerid, formattedArmour);

    return formattedArmour;
}

// Funções nativas de banimento e kick ignoram obrigatoriamente a ação diretamente anterior, mas um timer anula a falha.

native KickxTimer(playerid) = Kick;
native BanxTimer(playerid) = Ban;


forward kickfix(playerid); public kickfix(playerid)
{
    KickxTimer(playerid);
}

forward banfix(playerid); public banfix(playerid){
    BanxTimer(playerid);
}

// Padronização de mensagens ao player

#define SendServerMessage(%0,%1) \
	va_SendClientMessage(%0, COLOR_GREEN, "SERVER: "%1)

#define SendSyntaxMessage(%0,%1) \
	va_SendClientMessage(%0, COLOR_BEGE, "USE: "%1)

#define SendErrorMessage(%0,%1) \
	va_SendClientMessage(%0, COLOR_LIGHTRED, ""%1)

#define SendAdminAction(%0,%1) \
	va_SendClientMessage(%0, COLOR_LIGHTRED, "AdmCmd: "%1)

#define SendInfoMessage(%0,%1) \
	va_SendClientMessage(%0, COLOR_WHITE, "* "%1) 

SendPermissionMessage(playerid)
    return SendErrorMessage(playerid, "Você não tem permissão suficiente para isso.");

SendNotConnectedMessage(playerid)
    return SendErrorMessage(playerid, "Este jogador não está conectado ou não existe.");

pNome(playerid) {
	if(playerid > -1 && playerid < MAX_PLAYERS){
		static 
			name[MAX_PLAYER_NAME + 1];

		GetPlayerName(playerid, name, sizeof(name));

		for (new i = 0, len = strlen(name); i < len; i ++){
			if(name[i] == '_') name[i] = ' ';
		}
		return name;
	} else {
		static 
			name[MAX_PLAYER_NAME + 1];

		GetPlayerName(playerid, name, sizeof(name));

		for (new i = 0, len = strlen(name); i < len; i ++){
			if(name[i] == '_') name[i] = ' ';
		}
		return name;
	}
}

stock SQLName(id) {
    new name[24];
    mysql_format(DBConn, query, sizeof(query), "SELECT `name` FROM `players` WHERE ID = %i LIMIT 1", id);
    new Cache: cache = mysql_query(DBConn, query);
    if(!cache_num_rows()) name = "Inválido";
    else cache_get_value_name(0, "name", name);
    cache_delete(cache);
    return name;
}

// Pegar o ID de um jogador pelo nome, ao invés do contrário
GetPlayerByName(const playerName[]) {
    new returnID = -1;
    foreach(new i : Player) {
        if(!strcmp(playerName, GetPlayerNameEx(i))) {
            returnID = i;
            break;
        }
    }
    return returnID;
}

// Limpar a tela
ClearPlayerChat(playerid, blankLines = 20) {
    for(new i; i < blankLines; i++)
        SendClientMessage(playerid, -1, " ");
} 

// Checa proximidade com outro jogador
forward IsPlayerNearPlayer(playerid, n_playerid, Float:radius);
IsPlayerNearPlayer(playerid, n_playerid, Float:radius) {
    new Float:npx, Float:npy, Float:npz;
    GetPlayerPos(n_playerid, npx, npy, npz);
    if(IsPlayerInRangeOfPoint(playerid, radius, npx, npy, npz))
    	return true;
    return false;
}

SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...) {
	static
		args,
		start,
		end,
		string[144];

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

		for (end = start + (args - 16); end > start; end -= 4)
		{
			#emit LREF.pri end
			#emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius)) {
				SendClientMessage(i, color, string);
			}
		}
		return true;
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, str);
		}
	}
	return true;
}

FormatNumber(number) {
    new length, value[32];

    format(value, sizeof(value), "%i", (number < 0) ? (-number) : (number));

    length = strlen(value);

    if(length > 3) {
        for(new l = 0, i = length; --i >= 0; l ++) {
            if((l % 3 == 0) && l > 0)  {
                strins(value, ".", i + 1);
            }
        }
    }
    return value;
} 

FormatFloat(Float:number) { // by Anakin2000
    new 
        str[24],
        length;

    format(str, sizeof(str), "%0.2f", number);

    if((length = strlen(str)) < 7)
        return str;

    for(length -= 6; length > 0; length -= 3) 
        strins(str, ",", length);

    return str;
}

PlaySoundForPlayersInRange(soundid, Float:range, Float:x, Float:y, Float:z)
{
    for(new i = 0; i <= MAX_PLAYERS; i++) {
        if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, range, x, y, z)) PlayerPlaySound(i, soundid, x, y, z);
    }
}

stock IsActualGun(id)
{
	switch(id)
	{
		case -1,0,2,3,5,6,7,10,11,12,13,14,15,40,41,42,43,44,45,46,47: return false;
	}
	return true;
}

stock IsLethalMeele(id)
{
	switch(id)
	{
	    case 4,8,9,18,16: return true;
	}
	return false;
}

AdjustTextDrawString(string[]) {
	static const
		scRealChars[256] =
		{
			  0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15,
			 16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31,
			 32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47,
			 48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63,
			 64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79,
			 80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95,
			 96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
			112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
			128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143,
			144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
			160,  94, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175,
			124, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 175,
			128, 129, 130, 130, 131, 197, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141,
			208, 173, 142, 143, 144, 144, 145, 215, 216, 146, 147, 148, 149, 221, 222, 150,
			151, 152, 153, 153, 154, 229, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164,
			240, 174, 165, 166, 167, 167, 168, 247, 248, 169, 170, 171, 172, 253, 254, 255
		};
	if (ispacked(string))
	{
		for (new i = 0, len = strlen(string); i != len; ++i)
		{
			string{i} = scRealChars[string{i}];
		}
	}
	else
	{
		for (new i = 0, len = strlen(string), ch; i != len; ++i)
		{
			if (0 <= (ch = string[i]) < 256)
			{
				string[i] = scRealChars[ch];
			}
		}
	}
	return true;
}

forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5) {
	if(IsPlayerConnected(playerid)) {
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		foreach(new i : Player) {
			if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))) {
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))) SendClientMessage(i, col1, string);
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))) SendClientMessage(i, col2, string);
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))) SendClientMessage(i, col3, string);
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))) SendClientMessage(i, col4, string);	
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) SendClientMessage(i, col5, string);
					
			}
		}
	}
	return true;
}

stock GetPlayerLocation(playerid)
{
	static
	    Float:fX,
	    Float:fY,
		Float:fZ,
		string[32];
	// id = -1;
/*	if ((id = House_Inside(playerid)) != -1)
	{
		fX = HouseData[id][housePos][0];
		fY = HouseData[id][housePos][1];
		fZ = HouseData[id][housePos][2];
	}
	else if ((id = Business_Inside(playerid)) != -1)
	{
		fX = BusinessData[id][bizPos][0];
		fY = BusinessData[id][bizPos][1];
		fZ = BusinessData[id][bizPos][2];
	}
	else if ((id = Entrance_Inside(playerid)) != -1)
	{
		fX = EntranceData[id][entrancePos][0];
		fY = EntranceData[id][entrancePos][1];
		fZ = EntranceData[id][entrancePos][2];
	}
	else */
	GetPlayerPos(playerid, fX, fY, fZ);

	format(string, 32, GetLocation(fX, fY, fZ));
	return string;
}

forward EditDynObject(playerid, objectid);
public EditDynObject(playerid, objectid) return EditDynamicObject(playerid, objectid);

GetLocation(Float:fX, Float:fY, Float:fZ) {
    enum e_ZoneData
	{
     	e_ZoneName[64 char],
     	Float:e_ZoneArea[6]
	};
	static const g_arrZoneData[][e_ZoneData] =
	{
		{!"The Big Ear", 	              {-410.00, 1403.30, -3.00, -137.90, 1681.20, 200.00}},
		{!"Aldea Malvada",                {-1372.10, 2498.50, 0.00, -1277.50, 2615.30, 200.00}},
		{!"Angel Pine",                   {-2324.90, -2584.20, -6.10, -1964.20, -2212.10, 200.00}},
		{!"Arco del Oeste",               {-901.10, 2221.80, 0.00, -592.00, 2571.90, 200.00}},
		{!"Avispa Country Club",          {-2646.40, -355.40, 0.00, -2270.00, -222.50, 200.00}},
		{!"Avispa Country Club",          {-2831.80, -430.20, -6.10, -2646.40, -222.50, 200.00}},
		{!"Avispa Country Club",          {-2361.50, -417.10, 0.00, -2270.00, -355.40, 200.00}},
		{!"Avispa Country Club",          {-2667.80, -302.10, -28.80, -2646.40, -262.30, 71.10}},
		{!"Avispa Country Club",          {-2470.00, -355.40, 0.00, -2270.00, -318.40, 46.10}},
		{!"Avispa Country Club",          {-2550.00, -355.40, 0.00, -2470.00, -318.40, 39.70}},
		{!"Back o Beyond",                {-1166.90, -2641.10, 0.00, -321.70, -1856.00, 200.00}},
		{!"Battery Point",                {-2741.00, 1268.40, -4.50, -2533.00, 1490.40, 200.00}},
		{!"Bayside",                      {-2741.00, 2175.10, 0.00, -2353.10, 2722.70, 200.00}},
		{!"Bayside Marina",               {-2353.10, 2275.70, 0.00, -2153.10, 2475.70, 200.00}},
		{!"Beacon Hill",                  {-399.60, -1075.50, -1.40, -319.00, -977.50, 198.50}},
		{!"Blackfield",                   {964.30, 1203.20, -89.00, 1197.30, 1403.20, 110.90}},
		{!"Blackfield",                   {964.30, 1403.20, -89.00, 1197.30, 1726.20, 110.90}},
		{!"Blackfield Chapel",            {1375.60, 596.30, -89.00, 1558.00, 823.20, 110.90}},
		{!"Blackfield Chapel",            {1325.60, 596.30, -89.00, 1375.60, 795.00, 110.90}},
		{!"Blackfield Intersection",      {1197.30, 1044.60, -89.00, 1277.00, 1163.30, 110.90}},
		{!"Blackfield Intersection",      {1166.50, 795.00, -89.00, 1375.60, 1044.60, 110.90}},
		{!"Blackfield Intersection",      {1277.00, 1044.60, -89.00, 1315.30, 1087.60, 110.90}},
		{!"Blackfield Intersection",      {1375.60, 823.20, -89.00, 1457.30, 919.40, 110.90}},
		{!"Blueberry",                    {104.50, -220.10, 2.30, 349.60, 152.20, 200.00}},
		{!"Blueberry",                    {19.60, -404.10, 3.80, 349.60, -220.10, 200.00}},
		{!"Blueberry Acres",              {-319.60, -220.10, 0.00, 104.50, 293.30, 200.00}},
		{!"Caligula's Palace",            {2087.30, 1543.20, -89.00, 2437.30, 1703.20, 110.90}},
		{!"Caligula's Palace",            {2137.40, 1703.20, -89.00, 2437.30, 1783.20, 110.90}},
		{!"Calton Heights",               {-2274.10, 744.10, -6.10, -1982.30, 1358.90, 200.00}},
		{!"Chinatown",                    {-2274.10, 578.30, -7.60, -2078.60, 744.10, 200.00}},
		{!"City Hall",                    {-2867.80, 277.40, -9.10, -2593.40, 458.40, 200.00}},
		{!"Come-A-Lot",                   {2087.30, 943.20, -89.00, 2623.10, 1203.20, 110.90}},
		{!"Commerce",                     {1323.90, -1842.20, -89.00, 1701.90, -1722.20, 110.90}},
		{!"Commerce",                     {1323.90, -1722.20, -89.00, 1440.90, -1577.50, 110.90}},
		{!"Commerce",                     {1370.80, -1577.50, -89.00, 1463.90, -1384.90, 110.90}},
		{!"Commerce",                     {1463.90, -1577.50, -89.00, 1667.90, -1430.80, 110.90}},
		{!"Commerce",                     {1583.50, -1722.20, -89.00, 1758.90, -1577.50, 110.90}},
		{!"Commerce",                     {1667.90, -1577.50, -89.00, 1812.60, -1430.80, 110.90}},
		{!"Conference Center",            {1046.10, -1804.20, -89.00, 1323.90, -1722.20, 110.90}},
		{!"Conference Center",            {1073.20, -1842.20, -89.00, 1323.90, -1804.20, 110.90}},
		{!"Cranberry Station",            {-2007.80, 56.30, 0.00, -1922.00, 224.70, 100.00}},
		{!"Creek",                        {2749.90, 1937.20, -89.00, 2921.60, 2669.70, 110.90}},
		{!"Dillimore",                    {580.70, -674.80, -9.50, 861.00, -404.70, 200.00}},
		{!"Doherty",                      {-2270.00, -324.10, -0.00, -1794.90, -222.50, 200.00}},
		{!"Doherty",                      {-2173.00, -222.50, -0.00, -1794.90, 265.20, 200.00}},
		{!"Downtown",                     {-1982.30, 744.10, -6.10, -1871.70, 1274.20, 200.00}},
		{!"Downtown",                     {-1871.70, 1176.40, -4.50, -1620.30, 1274.20, 200.00}},
		{!"Downtown",                     {-1700.00, 744.20, -6.10, -1580.00, 1176.50, 200.00}},
		{!"Downtown",                     {-1580.00, 744.20, -6.10, -1499.80, 1025.90, 200.00}},
		{!"Downtown",                     {-2078.60, 578.30, -7.60, -1499.80, 744.20, 200.00}},
		{!"Downtown",                     {-1993.20, 265.20, -9.10, -1794.90, 578.30, 200.00}},
		{!"Downtown Los Santos",          {1463.90, -1430.80, -89.00, 1724.70, -1290.80, 110.90}},
		{!"Downtown Los Santos",          {1724.70, -1430.80, -89.00, 1812.60, -1250.90, 110.90}},
		{!"Downtown Los Santos",          {1463.90, -1290.80, -89.00, 1724.70, -1150.80, 110.90}},
		{!"Downtown Los Santos",          {1370.80, -1384.90, -89.00, 1463.90, -1170.80, 110.90}},
		{!"Downtown Los Santos",          {1724.70, -1250.90, -89.00, 1812.60, -1150.80, 110.90}},
		{!"Downtown Los Santos",          {1370.80, -1170.80, -89.00, 1463.90, -1130.80, 110.90}},
		{!"Downtown Los Santos",          {1378.30, -1130.80, -89.00, 1463.90, -1026.30, 110.90}},
		{!"Downtown Los Santos",          {1391.00, -1026.30, -89.00, 1463.90, -926.90, 110.90}},
		{!"Downtown Los Santos",          {1507.50, -1385.20, 110.90, 1582.50, -1325.30, 335.90}},
		{!"East Beach",                   {2632.80, -1852.80, -89.00, 2959.30, -1668.10, 110.90}},
		{!"East Beach",                   {2632.80, -1668.10, -89.00, 2747.70, -1393.40, 110.90}},
		{!"East Beach",                   {2747.70, -1668.10, -89.00, 2959.30, -1498.60, 110.90}},
		{!"East Beach",                   {2747.70, -1498.60, -89.00, 2959.30, -1120.00, 110.90}},
		{!"East Los Santos",              {2421.00, -1628.50, -89.00, 2632.80, -1454.30, 110.90}},
		{!"East Los Santos",              {2222.50, -1628.50, -89.00, 2421.00, -1494.00, 110.90}},
		{!"East Los Santos",              {2266.20, -1494.00, -89.00, 2381.60, -1372.00, 110.90}},
		{!"East Los Santos",              {2381.60, -1494.00, -89.00, 2421.00, -1454.30, 110.90}},
		{!"East Los Santos",              {2281.40, -1372.00, -89.00, 2381.60, -1135.00, 110.90}},
		{!"East Los Santos",              {2381.60, -1454.30, -89.00, 2462.10, -1135.00, 110.90}},
		{!"East Los Santos",              {2462.10, -1454.30, -89.00, 2581.70, -1135.00, 110.90}},
		{!"Easter Basin",                 {-1794.90, 249.90, -9.10, -1242.90, 578.30, 200.00}},
		{!"Easter Basin",                 {-1794.90, -50.00, -0.00, -1499.80, 249.90, 200.00}},
		{!"Easter Bay Airport",           {-1499.80, -50.00, -0.00, -1242.90, 249.90, 200.00}},
		{!"Easter Bay Airport",           {-1794.90, -730.10, -3.00, -1213.90, -50.00, 200.00}},
		{!"Easter Bay Airport",           {-1213.90, -730.10, 0.00, -1132.80, -50.00, 200.00}},
		{!"Easter Bay Airport",           {-1242.90, -50.00, 0.00, -1213.90, 578.30, 200.00}},
		{!"Easter Bay Airport",           {-1213.90, -50.00, -4.50, -947.90, 578.30, 200.00}},
		{!"Easter Bay Airport",           {-1315.40, -405.30, 15.40, -1264.40, -209.50, 25.40}},
		{!"Easter Bay Airport",           {-1354.30, -287.30, 15.40, -1315.40, -209.50, 25.40}},
		{!"Easter Bay Airport",           {-1490.30, -209.50, 15.40, -1264.40, -148.30, 25.40}},
		{!"Easter Bay Chemicals",         {-1132.80, -768.00, 0.00, -956.40, -578.10, 200.00}},
		{!"Easter Bay Chemicals",         {-1132.80, -787.30, 0.00, -956.40, -768.00, 200.00}},
		{!"El Castillo del Diablo",       {-464.50, 2217.60, 0.00, -208.50, 2580.30, 200.00}},
		{!"El Castillo del Diablo",       {-208.50, 2123.00, -7.60, 114.00, 2337.10, 200.00}},
		{!"El Castillo del Diablo",       {-208.50, 2337.10, 0.00, 8.40, 2487.10, 200.00}},
		{!"El Corona",                    {1812.60, -2179.20, -89.00, 1970.60, -1852.80, 110.90}},
		{!"El Corona",                    {1692.60, -2179.20, -89.00, 1812.60, -1842.20, 110.90}},
		{!"El Quebrados",                 {-1645.20, 2498.50, 0.00, -1372.10, 2777.80, 200.00}},
		{!"Esplanade East",               {-1620.30, 1176.50, -4.50, -1580.00, 1274.20, 200.00}},
		{!"Esplanade East",               {-1580.00, 1025.90, -6.10, -1499.80, 1274.20, 200.00}},
		{!"Esplanade East",               {-1499.80, 578.30, -79.60, -1339.80, 1274.20, 20.30}},
		{!"Esplanade North",              {-2533.00, 1358.90, -4.50, -1996.60, 1501.20, 200.00}},
		{!"Esplanade North",              {-1996.60, 1358.90, -4.50, -1524.20, 1592.50, 200.00}},
		{!"Esplanade North",              {-1982.30, 1274.20, -4.50, -1524.20, 1358.90, 200.00}},
		{!"Fallen Tree",                  {-792.20, -698.50, -5.30, -452.40, -380.00, 200.00}},
		{!"Fallow Bridge",                {434.30, 366.50, 0.00, 603.00, 555.60, 200.00}},
		{!"Fern Ridge",                   {508.10, -139.20, 0.00, 1306.60, 119.50, 200.00}},
		{!"Financial",                    {-1871.70, 744.10, -6.10, -1701.30, 1176.40, 300.00}},
		{!"Fisher's Lagoon",              {1916.90, -233.30, -100.00, 2131.70, 13.80, 200.00}},
		{!"Flint Intersection",           {-187.70, -1596.70, -89.00, 17.00, -1276.60, 110.90}},
		{!"Flint Range",                  {-594.10, -1648.50, 0.00, -187.70, -1276.60, 200.00}},
		{!"Fort Carson",                  {-376.20, 826.30, -3.00, 123.70, 1220.40, 200.00}},
		{!"Foster Valley",                {-2270.00, -430.20, -0.00, -2178.60, -324.10, 200.00}},
		{!"Foster Valley",                {-2178.60, -599.80, -0.00, -1794.90, -324.10, 200.00}},
		{!"Foster Valley",                {-2178.60, -1115.50, 0.00, -1794.90, -599.80, 200.00}},
		{!"Foster Valley",                {-2178.60, -1250.90, 0.00, -1794.90, -1115.50, 200.00}},
		{!"Frederick Bridge",             {2759.20, 296.50, 0.00, 2774.20, 594.70, 200.00}},
		{!"Gant Bridge",                  {-2741.40, 1659.60, -6.10, -2616.40, 2175.10, 200.00}},
		{!"Gant Bridge",                  {-2741.00, 1490.40, -6.10, -2616.40, 1659.60, 200.00}},
		{!"Ganton",                       {2222.50, -1852.80, -89.00, 2632.80, -1722.30, 110.90}},
		{!"Ganton",                       {2222.50, -1722.30, -89.00, 2632.80, -1628.50, 110.90}},
		{!"Garcia",                       {-2411.20, -222.50, -0.00, -2173.00, 265.20, 200.00}},
		{!"Garcia",                       {-2395.10, -222.50, -5.30, -2354.00, -204.70, 200.00}},
		{!"Garver Bridge",                {-1339.80, 828.10, -89.00, -1213.90, 1057.00, 110.90}},
		{!"Garver Bridge",                {-1213.90, 950.00, -89.00, -1087.90, 1178.90, 110.90}},
		{!"Garver Bridge",                {-1499.80, 696.40, -179.60, -1339.80, 925.30, 20.30}},
		{!"Glen Park",                    {1812.60, -1449.60, -89.00, 1996.90, -1350.70, 110.90}},
		{!"Glen Park",                    {1812.60, -1100.80, -89.00, 1994.30, -973.30, 110.90}},
		{!"Glen Park",                    {1812.60, -1350.70, -89.00, 2056.80, -1100.80, 110.90}},
		{!"Green Palms",                  {176.50, 1305.40, -3.00, 338.60, 1520.70, 200.00}},
		{!"Greenglass College",           {964.30, 1044.60, -89.00, 1197.30, 1203.20, 110.90}},
		{!"Greenglass College",           {964.30, 930.80, -89.00, 1166.50, 1044.60, 110.90}},
		{!"Hampton Barns",                {603.00, 264.30, 0.00, 761.90, 366.50, 200.00}},
		{!"Hankypanky Point",             {2576.90, 62.10, 0.00, 2759.20, 385.50, 200.00}},
		{!"Harry Gold Parkway",           {1777.30, 863.20, -89.00, 1817.30, 2342.80, 110.90}},
		{!"Hashbury",                     {-2593.40, -222.50, -0.00, -2411.20, 54.70, 200.00}},
		{!"Hilltop Farm",                 {967.30, -450.30, -3.00, 1176.70, -217.90, 200.00}},
		{!"Hunter Quarry",                {337.20, 710.80, -115.20, 860.50, 1031.70, 203.70}},
		{!"Idlewood",                     {1812.60, -1852.80, -89.00, 1971.60, -1742.30, 110.90}},
		{!"Idlewood",                     {1812.60, -1742.30, -89.00, 1951.60, -1602.30, 110.90}},
		{!"Idlewood",                     {1951.60, -1742.30, -89.00, 2124.60, -1602.30, 110.90}},
		{!"Idlewood",                     {1812.60, -1602.30, -89.00, 2124.60, -1449.60, 110.90}},
		{!"Idlewood",                     {2124.60, -1742.30, -89.00, 2222.50, -1494.00, 110.90}},
		{!"Idlewood",                     {1971.60, -1852.80, -89.00, 2222.50, -1742.30, 110.90}},
		{!"Jefferson",                    {1996.90, -1449.60, -89.00, 2056.80, -1350.70, 110.90}},
		{!"Jefferson",                    {2124.60, -1494.00, -89.00, 2266.20, -1449.60, 110.90}},
		{!"Jefferson",                    {2056.80, -1372.00, -89.00, 2281.40, -1210.70, 110.90}},
		{!"Jefferson",                    {2056.80, -1210.70, -89.00, 2185.30, -1126.30, 110.90}},
		{!"Jefferson",                    {2185.30, -1210.70, -89.00, 2281.40, -1154.50, 110.90}},
		{!"Jefferson",                    {2056.80, -1449.60, -89.00, 2266.20, -1372.00, 110.90}},
		{!"Julius Thruway East",          {2623.10, 943.20, -89.00, 2749.90, 1055.90, 110.90}},
		{!"Julius Thruway East",          {2685.10, 1055.90, -89.00, 2749.90, 2626.50, 110.90}},
		{!"Julius Thruway East",          {2536.40, 2442.50, -89.00, 2685.10, 2542.50, 110.90}},
		{!"Julius Thruway East",          {2625.10, 2202.70, -89.00, 2685.10, 2442.50, 110.90}},
		{!"Julius Thruway North",         {2498.20, 2542.50, -89.00, 2685.10, 2626.50, 110.90}},
		{!"Julius Thruway North",         {2237.40, 2542.50, -89.00, 2498.20, 2663.10, 110.90}},
		{!"Julius Thruway North",         {2121.40, 2508.20, -89.00, 2237.40, 2663.10, 110.90}},
		{!"Julius Thruway North",         {1938.80, 2508.20, -89.00, 2121.40, 2624.20, 110.90}},
		{!"Julius Thruway North",         {1534.50, 2433.20, -89.00, 1848.40, 2583.20, 110.90}},
		{!"Julius Thruway North",         {1848.40, 2478.40, -89.00, 1938.80, 2553.40, 110.90}},
		{!"Julius Thruway North",         {1704.50, 2342.80, -89.00, 1848.40, 2433.20, 110.90}},
		{!"Julius Thruway North",         {1377.30, 2433.20, -89.00, 1534.50, 2507.20, 110.90}},
		{!"Julius Thruway South",         {1457.30, 823.20, -89.00, 2377.30, 863.20, 110.90}},
		{!"Julius Thruway South",         {2377.30, 788.80, -89.00, 2537.30, 897.90, 110.90}},
		{!"Julius Thruway West",          {1197.30, 1163.30, -89.00, 1236.60, 2243.20, 110.90}},
		{!"Julius Thruway West",          {1236.60, 2142.80, -89.00, 1297.40, 2243.20, 110.90}},
		{!"Juniper Hill",                 {-2533.00, 578.30, -7.60, -2274.10, 968.30, 200.00}},
		{!"Juniper Hollow",               {-2533.00, 968.30, -6.10, -2274.10, 1358.90, 200.00}},
		{!"K.A.C.C. Military Fuels",      {2498.20, 2626.50, -89.00, 2749.90, 2861.50, 110.90}},
		{!"Kincaid Bridge",               {-1339.80, 599.20, -89.00, -1213.90, 828.10, 110.90}},
		{!"Kincaid Bridge",               {-1213.90, 721.10, -89.00, -1087.90, 950.00, 110.90}},
		{!"Kincaid Bridge",               {-1087.90, 855.30, -89.00, -961.90, 986.20, 110.90}},
		{!"King's",                       {-2329.30, 458.40, -7.60, -1993.20, 578.30, 200.00}},
		{!"King's",                       {-2411.20, 265.20, -9.10, -1993.20, 373.50, 200.00}},
		{!"King's",                       {-2253.50, 373.50, -9.10, -1993.20, 458.40, 200.00}},
		{!"LVA Freight Depot",            {1457.30, 863.20, -89.00, 1777.40, 1143.20, 110.90}},
		{!"LVA Freight Depot",            {1375.60, 919.40, -89.00, 1457.30, 1203.20, 110.90}},
		{!"LVA Freight Depot",            {1277.00, 1087.60, -89.00, 1375.60, 1203.20, 110.90}},
		{!"LVA Freight Depot",            {1315.30, 1044.60, -89.00, 1375.60, 1087.60, 110.90}},
		{!"LVA Freight Depot",            {1236.60, 1163.40, -89.00, 1277.00, 1203.20, 110.90}},
		{!"Las Barrancas",                {-926.10, 1398.70, -3.00, -719.20, 1634.60, 200.00}},
		{!"Las Brujas",                   {-365.10, 2123.00, -3.00, -208.50, 2217.60, 200.00}},
		{!"Las Colinas",                  {1994.30, -1100.80, -89.00, 2056.80, -920.80, 110.90}},
		{!"Las Colinas",                  {2056.80, -1126.30, -89.00, 2126.80, -920.80, 110.90}},
		{!"Las Colinas",                  {2185.30, -1154.50, -89.00, 2281.40, -934.40, 110.90}},
		{!"Las Colinas",                  {2126.80, -1126.30, -89.00, 2185.30, -934.40, 110.90}},
		{!"Las Colinas",                  {2747.70, -1120.00, -89.00, 2959.30, -945.00, 110.90}},
		{!"Las Colinas",                  {2632.70, -1135.00, -89.00, 2747.70, -945.00, 110.90}},
		{!"Las Colinas",                  {2281.40, -1135.00, -89.00, 2632.70, -945.00, 110.90}},
		{!"Las Payasadas",                {-354.30, 2580.30, 2.00, -133.60, 2816.80, 200.00}},
		{!"Las Venturas Airport",         {1236.60, 1203.20, -89.00, 1457.30, 1883.10, 110.90}},
		{!"Las Venturas Airport",         {1457.30, 1203.20, -89.00, 1777.30, 1883.10, 110.90}},
		{!"Las Venturas Airport",         {1457.30, 1143.20, -89.00, 1777.40, 1203.20, 110.90}},
		{!"Las Venturas Airport",         {1515.80, 1586.40, -12.50, 1729.90, 1714.50, 87.50}},
		{!"Last Dime Motel",              {1823.00, 596.30, -89.00, 1997.20, 823.20, 110.90}},
		{!"Leafy Hollow",                 {-1166.90, -1856.00, 0.00, -815.60, -1602.00, 200.00}},
		{!"Liberty City",                 {-1000.00, 400.00, 1300.00, -700.00, 600.00, 1400.00}},
		{!"Lil' Probe Inn",               {-90.20, 1286.80, -3.00, 153.80, 1554.10, 200.00}},
		{!"Linden Side",                  {2749.90, 943.20, -89.00, 2923.30, 1198.90, 110.90}},
		{!"Linden Station",               {2749.90, 1198.90, -89.00, 2923.30, 1548.90, 110.90}},
		{!"Linden Station",               {2811.20, 1229.50, -39.50, 2861.20, 1407.50, 60.40}},
		{!"Little Mexico",                {1701.90, -1842.20, -89.00, 1812.60, -1722.20, 110.90}},
		{!"Little Mexico",                {1758.90, -1722.20, -89.00, 1812.60, -1577.50, 110.90}},
		{!"Los Flores",                   {2581.70, -1454.30, -89.00, 2632.80, -1393.40, 110.90}},
		{!"Los Flores",                   {2581.70, -1393.40, -89.00, 2747.70, -1135.00, 110.90}},
		{!"Los Santos International",     {1249.60, -2394.30, -89.00, 1852.00, -2179.20, 110.90}},
		{!"Los Santos International",     {1852.00, -2394.30, -89.00, 2089.00, -2179.20, 110.90}},
		{!"Los Santos International",     {1382.70, -2730.80, -89.00, 2201.80, -2394.30, 110.90}},
		{!"Los Santos International",     {1974.60, -2394.30, -39.00, 2089.00, -2256.50, 60.90}},
		{!"Los Santos International",     {1400.90, -2669.20, -39.00, 2189.80, -2597.20, 60.90}},
		{!"Los Santos International",     {2051.60, -2597.20, -39.00, 2152.40, -2394.30, 60.90}},
		{!"Marina",                       {647.70, -1804.20, -89.00, 851.40, -1577.50, 110.90}},
		{!"Marina",                       {647.70, -1577.50, -89.00, 807.90, -1416.20, 110.90}},
		{!"Marina",                       {807.90, -1577.50, -89.00, 926.90, -1416.20, 110.90}},
		{!"Market",                       {787.40, -1416.20, -89.00, 1072.60, -1310.20, 110.90}},
		{!"Market",                       {952.60, -1310.20, -89.00, 1072.60, -1130.80, 110.90}},
		{!"Market",                       {1072.60, -1416.20, -89.00, 1370.80, -1130.80, 110.90}},
		{!"Market",                       {926.90, -1577.50, -89.00, 1370.80, -1416.20, 110.90}},
		{!"Market Station",               {787.40, -1410.90, -34.10, 866.00, -1310.20, 65.80}},
		{!"Martin Bridge",                {-222.10, 293.30, 0.00, -122.10, 476.40, 200.00}},
		{!"Missionary Hill",              {-2994.40, -811.20, 0.00, -2178.60, -430.20, 200.00}},
		{!"Montgomery",                   {1119.50, 119.50, -3.00, 1451.40, 493.30, 200.00}},
		{!"Montgomery",                   {1451.40, 347.40, -6.10, 1582.40, 420.80, 200.00}},
		{!"Montgomery Intersection",      {1546.60, 208.10, 0.00, 1745.80, 347.40, 200.00}},
		{!"Montgomery Intersection",      {1582.40, 347.40, 0.00, 1664.60, 401.70, 200.00}},
		{!"Mulholland",                   {1414.00, -768.00, -89.00, 1667.60, -452.40, 110.90}},
		{!"Mulholland",                   {1281.10, -452.40, -89.00, 1641.10, -290.90, 110.90}},
		{!"Mulholland",                   {1269.10, -768.00, -89.00, 1414.00, -452.40, 110.90}},
		{!"Mulholland",                   {1357.00, -926.90, -89.00, 1463.90, -768.00, 110.90}},
		{!"Mulholland",                   {1318.10, -910.10, -89.00, 1357.00, -768.00, 110.90}},
		{!"Mulholland",                   {1169.10, -910.10, -89.00, 1318.10, -768.00, 110.90}},
		{!"Mulholland",                   {768.60, -954.60, -89.00, 952.60, -860.60, 110.90}},
		{!"Mulholland",                   {687.80, -860.60, -89.00, 911.80, -768.00, 110.90}},
		{!"Mulholland",                   {737.50, -768.00, -89.00, 1142.20, -674.80, 110.90}},
		{!"Mulholland",                   {1096.40, -910.10, -89.00, 1169.10, -768.00, 110.90}},
		{!"Mulholland",                   {952.60, -937.10, -89.00, 1096.40, -860.60, 110.90}},
		{!"Mulholland",                   {911.80, -860.60, -89.00, 1096.40, -768.00, 110.90}},
		{!"Mulholland",                   {861.00, -674.80, -89.00, 1156.50, -600.80, 110.90}},
		{!"Mulholland Intersection",      {1463.90, -1150.80, -89.00, 1812.60, -768.00, 110.90}},
		{!"North Rock",                   {2285.30, -768.00, 0.00, 2770.50, -269.70, 200.00}},
		{!"Ocean Docks",                  {2373.70, -2697.00, -89.00, 2809.20, -2330.40, 110.90}},
		{!"Ocean Docks",                  {2201.80, -2418.30, -89.00, 2324.00, -2095.00, 110.90}},
		{!"Ocean Docks",                  {2324.00, -2302.30, -89.00, 2703.50, -2145.10, 110.90}},
		{!"Ocean Docks",                  {2089.00, -2394.30, -89.00, 2201.80, -2235.80, 110.90}},
		{!"Ocean Docks",                  {2201.80, -2730.80, -89.00, 2324.00, -2418.30, 110.90}},
		{!"Ocean Docks",                  {2703.50, -2302.30, -89.00, 2959.30, -2126.90, 110.90}},
		{!"Ocean Docks",                  {2324.00, -2145.10, -89.00, 2703.50, -2059.20, 110.90}},
		{!"Ocean Flats",                  {-2994.40, 277.40, -9.10, -2867.80, 458.40, 200.00}},
		{!"Ocean Flats",                  {-2994.40, -222.50, -0.00, -2593.40, 277.40, 200.00}},
		{!"Ocean Flats",                  {-2994.40, -430.20, -0.00, -2831.80, -222.50, 200.00}},
		{!"Octane Springs",               {338.60, 1228.50, 0.00, 664.30, 1655.00, 200.00}},
		{!"Old Venturas Strip",           {2162.30, 2012.10, -89.00, 2685.10, 2202.70, 110.90}},
		{!"Palisades",                    {-2994.40, 458.40, -6.10, -2741.00, 1339.60, 200.00}},
		{!"Palomino Creek",               {2160.20, -149.00, 0.00, 2576.90, 228.30, 200.00}},
		{!"Paradiso",                     {-2741.00, 793.40, -6.10, -2533.00, 1268.40, 200.00}},
		{!"Pershing Square",              {1440.90, -1722.20, -89.00, 1583.50, -1577.50, 110.90}},
		{!"Pilgrim",                      {2437.30, 1383.20, -89.00, 2624.40, 1783.20, 110.90}},
		{!"Pilgrim",                      {2624.40, 1383.20, -89.00, 2685.10, 1783.20, 110.90}},
		{!"Pilson Intersection",          {1098.30, 2243.20, -89.00, 1377.30, 2507.20, 110.90}},
		{!"Pirates in Men's Pants",       {1817.30, 1469.20, -89.00, 2027.40, 1703.20, 110.90}},
		{!"Playa del Seville",            {2703.50, -2126.90, -89.00, 2959.30, -1852.80, 110.90}},
		{!"Prickle Pine",                 {1534.50, 2583.20, -89.00, 1848.40, 2863.20, 110.90}},
		{!"Prickle Pine",                 {1117.40, 2507.20, -89.00, 1534.50, 2723.20, 110.90}},
		{!"Prickle Pine",                 {1848.40, 2553.40, -89.00, 1938.80, 2863.20, 110.90}},
		{!"Prickle Pine",                 {1938.80, 2624.20, -89.00, 2121.40, 2861.50, 110.90}},
		{!"Queens",                       {-2533.00, 458.40, 0.00, -2329.30, 578.30, 200.00}},
		{!"Queens",                       {-2593.40, 54.70, 0.00, -2411.20, 458.40, 200.00}},
		{!"Queens",                       {-2411.20, 373.50, 0.00, -2253.50, 458.40, 200.00}},
		{!"Randolph Industrial Estate",   {1558.00, 596.30, -89.00, 1823.00, 823.20, 110.90}},
		{!"Redsands East",                {1817.30, 2011.80, -89.00, 2106.70, 2202.70, 110.90}},
		{!"Redsands East",                {1817.30, 2202.70, -89.00, 2011.90, 2342.80, 110.90}},
		{!"Redsands East",                {1848.40, 2342.80, -89.00, 2011.90, 2478.40, 110.90}},
		{!"Redsands West",                {1236.60, 1883.10, -89.00, 1777.30, 2142.80, 110.90}},
		{!"Redsands West",                {1297.40, 2142.80, -89.00, 1777.30, 2243.20, 110.90}},
		{!"Redsands West",                {1377.30, 2243.20, -89.00, 1704.50, 2433.20, 110.90}},
		{!"Redsands West",                {1704.50, 2243.20, -89.00, 1777.30, 2342.80, 110.90}},
		{!"Regular Tom",                  {-405.70, 1712.80, -3.00, -276.70, 1892.70, 200.00}},
		{!"Richman",                      {647.50, -1118.20, -89.00, 787.40, -954.60, 110.90}},
		{!"Richman",                      {647.50, -954.60, -89.00, 768.60, -860.60, 110.90}},
		{!"Richman",                      {225.10, -1369.60, -89.00, 334.50, -1292.00, 110.90}},
		{!"Richman",                      {225.10, -1292.00, -89.00, 466.20, -1235.00, 110.90}},
		{!"Richman",                      {72.60, -1404.90, -89.00, 225.10, -1235.00, 110.90}},
		{!"Richman",                      {72.60, -1235.00, -89.00, 321.30, -1008.10, 110.90}},
		{!"Richman",                      {321.30, -1235.00, -89.00, 647.50, -1044.00, 110.90}},
		{!"Richman",                      {321.30, -1044.00, -89.00, 647.50, -860.60, 110.90}},
		{!"Richman",                      {321.30, -860.60, -89.00, 687.80, -768.00, 110.90}},
		{!"Richman",                      {321.30, -768.00, -89.00, 700.70, -674.80, 110.90}},
		{!"Robada Intersection",          {-1119.00, 1178.90, -89.00, -862.00, 1351.40, 110.90}},
		{!"Roca Escalante",               {2237.40, 2202.70, -89.00, 2536.40, 2542.50, 110.90}},
		{!"Roca Escalante",               {2536.40, 2202.70, -89.00, 2625.10, 2442.50, 110.90}},
		{!"Rockshore East",               {2537.30, 676.50, -89.00, 2902.30, 943.20, 110.90}},
		{!"Rockshore West",               {1997.20, 596.30, -89.00, 2377.30, 823.20, 110.90}},
		{!"Rockshore West",               {2377.30, 596.30, -89.00, 2537.30, 788.80, 110.90}},
		{!"Rodeo",                        {72.60, -1684.60, -89.00, 225.10, -1544.10, 110.90}},
		{!"Rodeo",                        {72.60, -1544.10, -89.00, 225.10, -1404.90, 110.90}},
		{!"Rodeo",                        {225.10, -1684.60, -89.00, 312.80, -1501.90, 110.90}},
		{!"Rodeo",                        {225.10, -1501.90, -89.00, 334.50, -1369.60, 110.90}},
		{!"Rodeo",                        {334.50, -1501.90, -89.00, 422.60, -1406.00, 110.90}},
		{!"Rodeo",                        {312.80, -1684.60, -89.00, 422.60, -1501.90, 110.90}},
		{!"Rodeo",                        {422.60, -1684.60, -89.00, 558.00, -1570.20, 110.90}},
		{!"Rodeo",                        {558.00, -1684.60, -89.00, 647.50, -1384.90, 110.90}},
		{!"Rodeo",                        {466.20, -1570.20, -89.00, 558.00, -1385.00, 110.90}},
		{!"Rodeo",                        {422.60, -1570.20, -89.00, 466.20, -1406.00, 110.90}},
		{!"Rodeo",                        {466.20, -1385.00, -89.00, 647.50, -1235.00, 110.90}},
		{!"Rodeo",                        {334.50, -1406.00, -89.00, 466.20, -1292.00, 110.90}},
		{!"Royal Casino",                 {2087.30, 1383.20, -89.00, 2437.30, 1543.20, 110.90}},
		{!"San Andreas Sound",            {2450.30, 385.50, -100.00, 2759.20, 562.30, 200.00}},
		{!"Santa Flora",                  {-2741.00, 458.40, -7.60, -2533.00, 793.40, 200.00}},
		{!"Santa Maria Beach",            {342.60, -2173.20, -89.00, 647.70, -1684.60, 110.90}},
		{!"Santa Maria Beach",            {72.60, -2173.20, -89.00, 342.60, -1684.60, 110.90}},
		{!"Shady Cabin",                  {-1632.80, -2263.40, -3.00, -1601.30, -2231.70, 200.00}},
		{!"Shady Creeks",                 {-1820.60, -2643.60, -8.00, -1226.70, -1771.60, 200.00}},
		{!"Shady Creeks",                 {-2030.10, -2174.80, -6.10, -1820.60, -1771.60, 200.00}},
		{!"Sobell Rail Yards",            {2749.90, 1548.90, -89.00, 2923.30, 1937.20, 110.90}},
		{!"Spinybed",                     {2121.40, 2663.10, -89.00, 2498.20, 2861.50, 110.90}},
		{!"Starfish Casino",              {2437.30, 1783.20, -89.00, 2685.10, 2012.10, 110.90}},
		{!"Starfish Casino",              {2437.30, 1858.10, -39.00, 2495.00, 1970.80, 60.90}},
		{!"Starfish Casino",              {2162.30, 1883.20, -89.00, 2437.30, 2012.10, 110.90}},
		{!"Temple",                       {1252.30, -1130.80, -89.00, 1378.30, -1026.30, 110.90}},
		{!"Temple",                       {1252.30, -1026.30, -89.00, 1391.00, -926.90, 110.90}},
		{!"Temple",                       {1252.30, -926.90, -89.00, 1357.00, -910.10, 110.90}},
		{!"Temple",                       {952.60, -1130.80, -89.00, 1096.40, -937.10, 110.90}},
		{!"Temple",                       {1096.40, -1130.80, -89.00, 1252.30, -1026.30, 110.90}},
		{!"Temple",                       {1096.40, -1026.30, -89.00, 1252.30, -910.10, 110.90}},
		{!"The Camel's Toe",              {2087.30, 1203.20, -89.00, 2640.40, 1383.20, 110.90}},
		{!"The Clown's Pocket",           {2162.30, 1783.20, -89.00, 2437.30, 1883.20, 110.90}},
		{!"The Emerald Isle",             {2011.90, 2202.70, -89.00, 2237.40, 2508.20, 110.90}},
		{!"The Farm",                     {-1209.60, -1317.10, 114.90, -908.10, -787.30, 251.90}},
		{!"The Four Dragons Casino",      {1817.30, 863.20, -89.00, 2027.30, 1083.20, 110.90}},
		{!"The High Roller",              {1817.30, 1283.20, -89.00, 2027.30, 1469.20, 110.90}},
		{!"The Mako Span",                {1664.60, 401.70, 0.00, 1785.10, 567.20, 200.00}},
		{!"The Panopticon",               {-947.90, -304.30, -1.10, -319.60, 327.00, 200.00}},
		{!"The Pink Swan",                {1817.30, 1083.20, -89.00, 2027.30, 1283.20, 110.90}},
		{!"The Sherman Dam",              {-968.70, 1929.40, -3.00, -481.10, 2155.20, 200.00}},
		{!"The Strip",                    {2027.40, 863.20, -89.00, 2087.30, 1703.20, 110.90}},
		{!"The Strip",                    {2106.70, 1863.20, -89.00, 2162.30, 2202.70, 110.90}},
		{!"The Strip",                    {2027.40, 1783.20, -89.00, 2162.30, 1863.20, 110.90}},
		{!"The Strip",                    {2027.40, 1703.20, -89.00, 2137.40, 1783.20, 110.90}},
		{!"The Visage",                   {1817.30, 1863.20, -89.00, 2106.70, 2011.80, 110.90}},
		{!"The Visage",                   {1817.30, 1703.20, -89.00, 2027.40, 1863.20, 110.90}},
		{!"Unity Station",                {1692.60, -1971.80, -20.40, 1812.60, -1932.80, 79.50}},
		{!"Valle Ocultado",               {-936.60, 2611.40, 2.00, -715.90, 2847.90, 200.00}},
		{!"Verdant Bluffs",               {930.20, -2488.40, -89.00, 1249.60, -2006.70, 110.90}},
		{!"Verdant Bluffs",               {1073.20, -2006.70, -89.00, 1249.60, -1842.20, 110.90}},
		{!"Verdant Bluffs",               {1249.60, -2179.20, -89.00, 1692.60, -1842.20, 110.90}},
		{!"Verdant Meadows",              {37.00, 2337.10, -3.00, 435.90, 2677.90, 200.00}},
		{!"Verona Beach",                 {647.70, -2173.20, -89.00, 930.20, -1804.20, 110.90}},
		{!"Verona Beach",                 {930.20, -2006.70, -89.00, 1073.20, -1804.20, 110.90}},
		{!"Verona Beach",                 {851.40, -1804.20, -89.00, 1046.10, -1577.50, 110.90}},
		{!"Verona Beach",                 {1161.50, -1722.20, -89.00, 1323.90, -1577.50, 110.90}},
		{!"Verona Beach",                 {1046.10, -1722.20, -89.00, 1161.50, -1577.50, 110.90}},
		{!"Vinewood",                     {787.40, -1310.20, -89.00, 952.60, -1130.80, 110.90}},
		{!"Vinewood",                     {787.40, -1130.80, -89.00, 952.60, -954.60, 110.90}},
		{!"Vinewood",                     {647.50, -1227.20, -89.00, 787.40, -1118.20, 110.90}},
		{!"Vinewood",                     {647.70, -1416.20, -89.00, 787.40, -1227.20, 110.90}},
		{!"Whitewood Estates",            {883.30, 1726.20, -89.00, 1098.30, 2507.20, 110.90}},
		{!"Whitewood Estates",            {1098.30, 1726.20, -89.00, 1197.30, 2243.20, 110.90}},
		{!"Willowfield",                  {1970.60, -2179.20, -89.00, 2089.00, -1852.80, 110.90}},
		{!"Willowfield",                  {2089.00, -2235.80, -89.00, 2201.80, -1989.90, 110.90}},
		{!"Willowfield",                  {2089.00, -1989.90, -89.00, 2324.00, -1852.80, 110.90}},
		{!"Willowfield",                  {2201.80, -2095.00, -89.00, 2324.00, -1989.90, 110.90}},
		{!"Willowfield",                  {2541.70, -1941.40, -89.00, 2703.50, -1852.80, 110.90}},
		{!"Willowfield",                  {2324.00, -2059.20, -89.00, 2541.70, -1852.80, 110.90}},
		{!"Willowfield",                  {2541.70, -2059.20, -89.00, 2703.50, -1941.40, 110.90}},
		{!"Yellow Bell Station",          {1377.40, 2600.40, -21.90, 1492.40, 2687.30, 78.00}},
		{!"Los Santos",                   {44.60, -2892.90, -242.90, 2997.00, -768.00, 900.00}},
		{!"Las Venturas",                 {869.40, 596.30, -242.90, 2997.00, 2993.80, 900.00}},
		{!"Bone County",                  {-480.50, 596.30, -242.90, 869.40, 2993.80, 900.00}},
		{!"Tierra Robada",                {-2997.40, 1659.60, -242.90, -480.50, 2993.80, 900.00}},
		{!"Tierra Robada",                {-1213.90, 596.30, -242.90, -480.50, 1659.60, 900.00}},
		{!"San Fierro",                   {-2997.40, -1115.50, -242.90, -1213.90, 1659.60, 900.00}},
		{!"Red County",                   {-1213.90, -768.00, -242.90, 2997.00, 596.30, 900.00}},
		{!"Flint County",                 {-1213.90, -2892.90, -242.90, 44.60, -768.00, 900.00}},
		{!"Whetstone",                    {-2997.40, -2892.90, -242.90, -1213.90, -1115.50, 900.00}}
	};
	new
	    name[32] = "San Andreas";

	for (new i = 0; i != sizeof(g_arrZoneData); i ++) if ((fX >= g_arrZoneData[i][e_ZoneArea][0] && fX <= g_arrZoneData[i][e_ZoneArea][3]) && (fY >= g_arrZoneData[i][e_ZoneArea][1] && fY <= g_arrZoneData[i][e_ZoneArea][4]) && (fZ >= g_arrZoneData[i][e_ZoneArea][2] && fZ <= g_arrZoneData[i][e_ZoneArea][5])) {
		strunpack(name, g_arrZoneData[i][e_ZoneName]);

		break;
	}
	return name;
}

PremiumType(type) {
	new rank[128];
	switch(type) {
		case 0: format(rank, sizeof(rank), "Comum");
		case 1: format(rank, sizeof(rank), "Premium Bronze");
		case 2: format(rank, sizeof(rank), "Premium Prata");
		case 3: format(rank, sizeof(rank), "Premium Ouro");
		default: format(rank, sizeof(rank), "Comum");
	}
	return rank;
}

DealershipCategory(type) {
	new category[128];
	switch(type) {
		case 1: format(category, sizeof(category), "Aviões");
		case 2: format(category, sizeof(category), "Barcos");
		case 3: format(category, sizeof(category), "Bicicletas");
		case 4: format(category, sizeof(category), "Motos");
		case 5: format(category, sizeof(category), "Sedans");
		case 6: format(category, sizeof(category), "SUVs & Wagons");
		case 7: format(category, sizeof(category), "Lowriders");
		case 8: format(category, sizeof(category), "Esportivos");
		case 9: format(category, sizeof(category), "Industriais");
		case 10: format(category, sizeof(category), "Caminhonetes");
		case 11: format(category, sizeof(category), "Únicos");
		case 12: format(category, sizeof(category), "Trailers industriais");
		default: format(category, sizeof(category), "Inválido");
	}
	return category;
}

RenderingObjectsValue(playerid) {
	new value;
	switch (pInfo[playerid][pRenderObjects]){
		case 0: value = 500;
		case 1: value = 1000;
        case 2: value = 2000;
		case 3: value = 5000;
        case 4: value = 10000;
		default: value = 1000;
	}
	return value;
}

Float:RenderingObjectsRadius(playerid) {
	new Float:radius;
	switch (pInfo[playerid][pRenderObjects]){
		case 0: radius = 0.2;
		case 1: radius = 1.0;
        case 2: radius = 1.5;
		case 3: radius = 3.0;
        case 4: radius = 5.0;
		default: radius = 1.0;
	}
	return radius;
}

KickEx(playerid) {
	if (pInfo[playerid][pKicked]) return false;

	pInfo[playerid][pKicked] = 1;
	SetTimerEx("KickTimer", 200, false, "d", playerid);
	return true;
}

forward KickTimer(playerid);
public KickTimer(playerid) {
	if (pInfo[playerid][pKicked]) return Kick(playerid);
	return false;
}

Float:GetXYInFrontOfPlayer(playerid, &Float:q, &Float:w, Float:distance) {
    new Float:a;
    GetPlayerPos(playerid, q, w, a);
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    else GetPlayerFacingAngle(playerid, a);
    q += (distance * floatsin(-a, degrees));
    w += (distance * floatcos(-a, degrees));
    return a;
}

bool:IsPlayerRecording(playerid){
	return pInfo[playerid][pRecording];
}

bool:IsPlayerWatchingCamera(playerid){
	return pInfo[playerid][pWatching];
}

bool:IsPlayerLogged(playerid){
	return pInfo[playerid][pLogged];
}

stock bool:IsPlayerWatchingPlayerCamera(playerid, cameraman){
	if(pInfo[playerid][pWatchingPlayer] == cameraman) return true;
	return false;
}

IsPlayerMinimized(playerid, ms = 5000){
    return pInfo[playerid][pESC] != 0 && GetTickCount() > (pInfo[playerid][pESC] + ms);
}