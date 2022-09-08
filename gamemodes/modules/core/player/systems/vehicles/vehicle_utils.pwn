#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_VEHICLES (2000)

enum E_VEHICLE_DATA {
    // 1°                   // MAIN
    vID,                    // ID do veículo
    vVehicle,               // CreateVehicle
    vExists,                // Definir se existe
    vModel,                 // ModelID do veículo
    vOwner,                 // ID do personagem dono do veículo
    vFaction,               // ID da facção do veículo
    vBusiness,              // ID da empresa do veículo
    vJob,                   // ID do emprego pertencente ao veículo
    vName[64],              // Nome personalizado
    vNamePersonalized,      // Se o nome é personalizado
    vLegal,                 // Se o veículo é legalizado
    vPlate[128],            // Placa do veículo
    vPlatePersonalized,     // Se a placa é personalizada
    bool:vLocked,           // Trancado 
    vColor1,                // Cor primária
    vColor2,                // Cor secundária
    vPaintjob,              // Paintjob do veículo
    Float:vPos[4],          // Posições (X, Y, Z, A) do veículo
    vVW,                    // Virtual World do veículo
    vInterior,              // Interior do veículo
    vImpounded,             // Se o veículo está apreendido ou não
    vImpoundedPrice,        // Valor da apreensão
    vImpoundedReason[64],   // Motivo da apreensão

	// CARAVAN SYSTEM
	vCaravan,
	vCaravanModelID,
	vCaravanModelName[64],
	vCaravanType,

    // 2°                   // STATS
    vInsurance,             // Seguro
    vSunpass,               // Pedágio
    vAlarm,                 // Alarme
    Float:vFuel,            // Combustível do veículo
	Float:vMaxFuel,
    Float:vHealth,
	Float:vHealthRepair,
	Float:vMaxHealth,
	vEnergyResource,
    Float:vBattery,         // Bateria do veículo
	Float:vEngine,          // Motor do veículo
    Float:vMiles,           // Milhas rodadas
    Float:vMilesCon,        // Contagem de milhas
	Float:MilesPos[3],		// Contagem de milhas
    
    // 3°
    vMods[17],              // Modificações

    // 4°                   // INVENTORY 1
    vWeapons[30],           // Armas guardadas
	vWeaponsType[30],       // Tipo das armas
	vAmmo[30],              // Munição das armas

	// 5°
    vPanelsStatus,			// Status da lataria 
	vDoorsStatus,			// Status das portas
    vLightsStatus,			// Status das luzes
    vTiresStatus,			// Status dos pneus

    // 6°
    vDamage[23],            // 9 calibres + 14 partes veiculares que podem danificar

	// 7° 
	vObject[5],
	vObjectSlot[5],
	Float:vObjectPosX[5],
	Float:vObjectPosY[5],
	Float:vObjectPosZ[5],
	Float:vObjectRotX[5],
	Float:vObjectRotY[5],
	Float:vObjectRotZ[5],
	
	vWindowsDown,
};
new vInfo[MAX_DYNAMIC_VEHICLES][E_VEHICLE_DATA];

new g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

enum e_Delaerhipspawns {
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ,
	Float:e_PosA
};

new DealershipSpawns[][e_Delaerhipspawns] = {
    {1542.2360,-1024.6117,23.5313,346.3439},
	{1546.6907,-1025.8572,23.5312,343.0172},
	{1550.9995,-1027.3229,23.5312,343.8101},
	{1555.3621,-1028.5148,23.5313,344.2106},
	{1559.4102,-1030.1896,23.5312,344.2696},
	{1563.7837,-1031.2640,23.5332,342.1118},
	{1569.9720,-1034.6222,23.5370,322.3119},
	{1573.6327,-1037.0845,23.5351,323.2692},
	{1576.9586,-1039.8826,23.5313,321.9445},
	{1580.9771,-1043.8435,23.5310,309.5742},
	{1583.6866,-1047.7462,23.5312,308.1384},
	{1586.6826,-1050.9348,23.5312,309.0961},
	{1589.3503,-1054.3530,23.5313,309.1660},
	{1591.7571,-1058.0079,23.5313,309.9774},
	{1616.3893,-1119.2391,23.5312,269.5218},
	{1616.1642,-1123.6984,23.5312,270.9124},
	{1616.3887,-1128.0815,23.5311,270.1531},
	{1616.2263,-1132.6082,23.5312,271.6229},
	{1616.0321,-1136.9890,23.5311,270.8761},
	{1648.6288,-1136.4696,23.5312,359.9271},
	{1652.8175,-1136.4324,23.5312,1.5374},
	{1657.1638,-1136.5662,23.5311,1.4549},
	{1661.7793,-1136.5715,23.5312,0.1469},
	{1666.2274,-1136.7086,23.5310,0.1492},
	{1676.7905,-1129.6621,23.5312,93.1014},
	{1676.5288,-1125.0447,23.5313,89.4460},
	{1676.1620,-1120.4838,23.5313,89.8538},
	{1676.3015,-1115.9683,23.5313,90.3656},
	{1676.3922,-1111.4583,23.5309,88.6138},
	{1675.6786,-1107.1677,23.5313,90.5686},
	{1675.6431,-1102.5200,23.5313,88.8061},
	{1675.8954,-1098.0477,23.5311,90.3075},
	{1657.7754,-1111.4502,23.5331,269.8254},
	{1658.0958,-1107.0847,23.5314,269.2282},
	{1657.9182,-1102.5706,23.5311,269.8751},
	{1658.1592,-1097.9357,23.5313,270.0888},
	{1657.8911,-1093.5106,23.5310,270.9572},
	{1657.9454,-1089.0105,23.5312,270.3036},
	{1658.4119,-1084.5455,23.5313,270.4046},
	{1658.5104,-1080.2562,23.5273,270.0807},
	{1650.0708,-1080.0994,23.5273,88.6770},
	{1649.9807,-1084.4951,23.5310,89.7324},
	{1650.4044,-1089.1899,23.5313,90.7966},
	{1650.1404,-1093.6421,23.5313,90.0449},
	{1650.4620,-1098.1344,23.5312,90.3383},
	{1650.4100,-1102.5435,23.5312,90.1501},
	{1650.1863,-1107.0691,23.5297,89.8570},
	{1650.5200,-1111.6249,23.5389,89.6484},
	{1688.0536,-1086.1393,23.5313,359.6960},
	{1692.6145,-1086.1602,23.5313,0.0189},
	{1697.0568,-1086.1359,23.5310,0.9957},
	{1701.5020,-1086.1157,23.5310,0.6741},
	{1705.7939,-1086.3381,23.5312,1.7950},
	{1691.1628,-1068.6859,23.5312,180.6728},
	{1695.8848,-1069.0952,23.5313,179.7258},
	{1700.2722,-1069.0918,23.5312,178.7473},
	{1704.7407,-1069.3519,23.5311,178.9091},
	{1709.2694,-1069.4880,23.5312,178.8587},
	{1713.9117,-1069.4022,23.5313,178.9711},
	{1718.4803,-1069.7915,23.5315,180.0878},
	{1722.5574,-1069.5089,23.5468,178.8316},
	{1722.5365,-1061.4296,23.5475,357.2256},
	{1718.1686,-1061.4440,23.5347,1.0971},
	{1713.7205,-1061.3135,23.5311,359.3974},
	{1709.1454,-1061.0574,23.5313,358.7676},
	{1704.6288,-1060.5796,23.5312,359.6633},
	{1700.0756,-1060.7389,23.5312,359.7759},
	{1695.7224,-1061.2557,23.5374,1.4531},
	{1691.0991,-1061.0695,23.5390,0.3052},
	{1726.3060,-1086.1207,23.5490,0.5504},
	{1731.0281,-1085.8689,23.5696,359.1255},
	{1735.5256,-1085.7216,23.5859,0.9270},
	{1739.9530,-1085.7546,23.5858,359.8902},
	{1744.3679,-1085.5648,23.5871,359.2624},
	{1748.9213,-1085.0221,23.5858,359.1736},
	{1753.4652,-1084.5168,23.5859,0.0165},
	{1758.2010,-1085.4580,23.5857,358.6385},
	{1762.5901,-1085.8434,23.5856,359.9503},
	{1767.0842,-1085.9690,23.5859,0.1052},
	{1771.6490,-1085.7590,23.5857,358.4984},
	{1776.0669,-1085.6714,23.5860,358.3434},
	{1780.6066,-1085.6119,23.5859,358.1335},
	{1785.0131,-1085.7083,23.5936,3.4201},
	{1789.4934,-1085.7999,23.5936,0.5430},
	{1794.1021,-1085.7478,23.5936,0.4017},
	{1798.7618,-1085.7323,23.5860,359.9929},
	{1803.0709,-1085.9442,23.5860,0.2310},
	{1793.5698,-1069.8688,23.5860,181.9941},
	{1789.0693,-1070.0328,23.5858,180.0233},
	{1784.6412,-1070.1337,23.5859,183.5098},
	{1780.0410,-1070.4957,23.5861,183.4062},
	{1775.6200,-1069.9172,23.5858,179.5867},
	{1771.0295,-1069.8800,23.5860,181.1211},
	{1766.6044,-1069.8502,23.5860,181.1936},
	{1761.9922,-1070.1455,23.5859,179.1303},
	{1761.7892,-1061.6543,23.5856,0.7004},
	{1766.2404,-1061.1010,23.5857,0.1983},
	{1770.8870,-1061.9840,23.5861,1.7904},
	{1775.5857,-1061.2102,23.5861,358.4935},
	{1779.8065,-1061.2319,23.5860,0.8215},
	{1784.4387,-1061.5955,23.5859,359.4618},
	{1788.8041,-1061.4899,23.5859,1.5609},
	{1793.3254,-1062.2195,23.5880,1.2185},
	{1783.8590,-1025.5891,23.5858,154.6801},
	{1780.0261,-1023.3765,23.5859,153.2074},
	{1775.7577,-1021.7193,23.5859,153.6755},
	{1771.6874,-1019.8876,23.5860,152.8153},
	{1767.9709,-1017.7709,23.5860,154.4268},
	{1761.8378,-1015.5675,23.5860,169.4669},
	{1757.6420,-1014.2505,23.5858,167.5832},
	{1753.2190,-1013.4634,23.5859,167.5858},
	{1748.9591,-1012.5097,23.5857,169.2995},
	{1744.3599,-1011.4575,23.5858,168.6774},
	{1740.0981,-1010.4650,23.5859,169.0888},
	{1735.3843,-1010.2865,23.5802,167.8623},
	{1731.2019,-1008.3849,23.5683,167.8993},
	{1726.5599,-1008.3083,23.5517,168.2916},
	{1721.6335,-1006.9210,23.5385,173.3235},
	{1717.3151,-1006.5552,23.5389,173.9828},
	{1712.8722,-1005.9280,23.5391,173.5323},
	{1708.5970,-1004.9974,23.5387,171.7829},
	{1704.0168,-1004.8300,23.5332,172.4534},
	{1695.7330,-1005.9623,23.5314,199.7377},
	{1691.4688,-1007.5286,23.5312,198.6150},
	{1687.1727,-1008.7377,23.5311,198.5688},
	{1683.0540,-1010.6589,23.5252,198.6588},
	{1678.6497,-1011.6384,23.5234,198.7501},
	{1674.4520,-1012.8191,23.5232,199.3653},
	{1664.9764,-1015.0216,23.5233,189.9058},
	{1660.5732,-1016.0446,23.5233,190.5177},
	{1656.0986,-1017.0989,23.5233,190.7142},
	{1651.6637,-1017.5366,23.5231,191.8499},
	{1645.0432,-1017.3976,23.5234,160.8183},
	{1641.0686,-1015.7132,23.5234,162.0445},
	{1636.7344,-1014.2963,23.5233,162.9924},
	{1632.4333,-1013.1403,23.5233,162.3118},
	{1628.0199,-1011.6286,23.5235,160.6392},
	{1623.6577,-1010.6827,23.5234,161.9116},
	{1617.8346,-1009.7468,23.5251,179.6969},
	{1613.3705,-1009.5706,23.5309,178.6674},
	{1608.8408,-1009.2726,23.5311,178.5003},
	{1604.5713,-1008.9873,23.5310,177.5547},
	{1599.2847,-1009.1979,23.5309,187.2868},
	{1594.8192,-1009.8619,23.5313,187.2494},
	{1590.4019,-1010.0584,23.5311,186.9876},
	{1585.8944,-1010.3735,23.5310,186.2652},
	{1581.3331,-1011.0332,23.5311,186.8344},
	{1576.3866,-1011.5908,23.5313,181.6466},
	{1572.0118,-1011.5558,23.5314,180.5832},
	{1567.5398,-1011.5623,23.5342,180.8227},
	{1562.9642,-1011.9204,23.5311,179.8128},
	{1558.3816,-1011.6439,23.5312,179.4166},
	{1627.3711,-1046.3330,23.5233,179.2373},
	{1631.8037,-1046.5537,23.5233,179.6692},
	{1636.2355,-1046.2911,23.5234,179.2253},
	{1640.8901,-1046.6263,23.5233,180.0847},
	{1645.3324,-1046.6375,23.5235,179.9828},
	{1649.7596,-1046.4589,23.5232,178.8383},
	{1654.3190,-1046.8727,23.5235,180.5410},
	{1658.7585,-1047.0035,23.5234,180.1205},
	{1658.6710,-1037.7396,23.5234,0.3762},
	{1654.3044,-1037.7615,23.5235,359.4613},
	{1649.6930,-1037.8229,23.5231,358.0718},
	{1645.1161,-1037.7610,23.5231,359.9977},
	{1640.7394,-1037.5958,23.5234,359.0540},
	{1636.3495,-1037.6277,23.5236,359.7141},
	{1631.7527,-1037.4911,23.5233,359.0566},
	{1627.1511,-1037.7479,23.5233,359.9191},
	{1680.9504,-1044.3389,23.5251,179.8846},
	{1685.3749,-1044.6700,23.5313,179.6816},
	{1690.0277,-1044.0547,23.5312,180.3938},
	{1694.4763,-1044.5619,23.5313,179.4375},
	{1698.8359,-1044.4840,23.5310,178.8886},
	{1703.3644,-1044.4719,23.5312,179.3879},
	{1708.0359,-1044.7526,23.5312,179.5467},
	{1712.4385,-1044.5712,23.5312,179.6582},
	{1712.2156,-1035.4324,23.5389,359.2698},
	{1707.8462,-1035.9050,23.5330,359.9983},
	{1703.3665,-1035.6522,23.5311,0.6012},
	{1698.7162,-1035.8922,23.5309,0.0803},
	{1694.2228,-1035.9382,23.5312,359.9393},
	{1689.8650,-1035.6217,23.5313,359.0363},
	{1685.2164,-1035.3302,23.5309,0.7211},
	{1680.7379,-1035.3241,23.5312,1.3771},
	{1744.0405,-1046.1755,23.5859,179.9857},
	{1748.5070,-1046.4469,23.5857,180.3561},
	{1753.0229,-1046.5551,23.5859,180.1937},
	{1757.5028,-1046.0896,23.5861,179.3913},
	{1761.9386,-1046.2875,23.5870,179.5633},
	{1761.7339,-1036.9855,23.5861,357.2029},
	{1757.4225,-1037.1243,23.5858,358.9639},
	{1752.9812,-1037.1747,23.5861,358.9543},
	{1748.3463,-1037.0854,23.5861,359.0058},
	{1743.9247,-1037.1682,23.5858,0.2652}
};

enum vehicleattributes {
	VehModel,
	Float:VehBattery,
	Float:VehEngine,
	VehFuelType,
	Float:VehMaxVelocity,
	Float:VehMass,
	Float:VehConsumation,
	Float:VehMaxFuel
};

stock const arrBatteryEngine[141][vehicleattributes] = {
    //Fuel Types:
    //0 - Sem motor
    //1 - Normal Fuel
    //2 - Diesel
    //3 - Eletric
    //4 - Turbo

    //Sem motor
    {509, 100.0, 100.0, 0, 120.0, 100.0, 0.0, 0.0}, //Lowriderbike
    {510, 100.0, 100.0, 0, 140.0, 100.0, 0.0, 0.0}, //Moutainbike
    {481, 100.0, 100.0, 0, 120.0, 100.0, 0.0, 0.0}, //BMX
    //Normal Fuel
    {522, 100.000, 100.000, 1, 190.0, 400.0, 4.0, 7.0}, //Nrg
    {256, 100.000, 100.000, 1, 230.0, 1400.0, 4.0, 17.0}, //SuperGT
    {477, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 17.0}, //ZR325
    {480, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 17.0}, //Comet
    {580, 100.000, 100.000, 1, 165.0, 2200.0, 4.0, 19.0}, //Stafford
    {409, 100.000, 100.000, 1, 180.0, 2200.0, 4.0, 22.0}, //Stretch
    {545, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 18.0}, //Hustler
    {429, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 16.0}, //Banshee
    {541, 100.000, 100.000, 1, 230.0, 1200.0, 5.0, 14.0}, //Bullet
    {415, 100.000, 100.000, 1, 230.0, 1200.0, 5.0, 16.0}, //Chettah
    {411, 100.000, 100.000, 1, 240.0, 1400.0, 7.0, 14.0}, //Infernus
    {423, 100.000, 100.000, 1, 180.0, 2200.0, 4.0, 21.0}, //Mr. Whooper
    {560, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 19.0}, //Sultan
    {451, 100.000, 100.000, 1, 240.0, 1400.0, 5.0, 17.0}, //Turismo
    {521, 100.000, 100.000, 1, 190.0, 500.0, 7.0, 10.0}, //FCR
    {461, 100.000, 100.000, 1, 190.0, 500.0, 6.0, 10.0}, //PCJ
    {581, 100.000, 100.000, 1, 190.0, 500.0, 6.0, 10.0}, //BF-400
    {468, 100.000, 100.000, 1, 190.0, 500.0, 6.0, 10.0}, //Sanchez
    {562, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 19.0}, //Elegy
    {558, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 22.0}, //Uranus
    {559, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 23.0}, //Jester
    {565, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 19.0}, //Flash
    {603, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 18.0}, //Phoenix
    {402, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 19.0}, // Buffalo
    {555, 100.000, 100.000, 1, 180.0, 1500.0, 5.0, 20.0}, // Windsor
    {575, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 20.0}, // Broadway
    {535, 100.000, 100.000, 1, 160.0, 1950.0, 5.0, 23.0}, //Slamvan
    {567, 100.000, 100.000, 1, 160.0, 1500.0, 5.0, 21.0}, //Savanna
    {551, 100.000, 100.000, 1, 165.0, 1800.0, 5.0, 22.0}, //Merit
    {491, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 20.0}, //Virgo
    {587, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 19.0}, //Euros
    {445, 100.000, 100.000, 1, 165.0, 1650.0, 5.0, 22.0}, //Admiral
    {401, 100.000, 100.000, 1, 165.0, 1650.0, 5.0, 17.0}, //Bravura
    {405, 100.000, 100.000, 1, 165.0, 1600.0, 5.0, 21.0}, //Sentinel
    {426, 100.000, 100.000, 1, 200.0, 1600.0, 5.0, 20.0}, //Premier
    {561, 100.000, 100.000, 1, 200.0, 1800.0, 5.0, 21.0}, //Stratum
    {439, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 20.0}, //Stallion
    {602, 100.000, 100.000, 1, 200.0, 1500.0, 5.0, 17.0}, //Alpha
    {589, 100.000, 100.000, 1, 200.0, 1400.0, 5.0, 16.0}, //Club
    {550, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 19.0}, //Sunrise
    {517, 100.000, 100.000, 1, 165.0, 1400.0, 5.0, 19.0}, //Majestic
    {516, 100.000, 100.000, 1, 165.0, 1400.0, 5.0, 19.0}, //Nebula
    {507, 100.000, 100.000, 1, 165.0, 2200.0, 4.0, 19.0}, //Elegant
    {496, 100.000, 100.000, 1, 200.0, 1000.0, 5.0, 19.0}, //Blista
    {475, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 19.0}, //Sabre
    {474, 100.000, 100.000, 1, 160.0, 1950.0, 4.0, 19.0}, //Hermes
    {424, 100.000, 100.000, 1, 170.0, 1200.0, 5.0, 15.0}, //BFInjection
    {421, 100.000, 100.000, 1, 180.0, 1850.0, 4.0, 21.0}, //Washington
    {533, 100.000, 100.000, 1, 200.0, 1600.0, 5.0, 22.0}, //Feltzer
    {600, 100.000, 100.000, 1, 165.0, 1600.0, 5.0, 20.0}, //Picador
    {586, 100.000, 100.000, 1, 190.0, 800.0, 5.0, 10.0}, //Wayfarer
    {463, 100.000, 100.000, 1, 190.0, 800.0, 5.0, 10.0}, //Freeway
    {534, 100.000, 100.000, 1, 160.0, 1800.0, 4.0, 20.0}, //Remington
    {536, 100.000, 100.000, 1, 160.0, 1500.0, 4.0, 20.0}, //Blade
    {529, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 20.0}, //Willard
    {526, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 20.0}, //Fortune
    {518, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 20.0}, //Buccaner
    {492, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 20.0}, //Greenwood
    {467, 100.000, 100.000, 1, 160.0, 1900.0, 4.0, 20.0}, //Oceanic
    {466, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 20.0}, //Glandale
    {419, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 20.0}, //Esperanto
    {412, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 20.0}, //Voodoo
    {499, 100.000, 100.000, 1, 140.0, 3500.0, 4.0, 20.0}, //Benson
    {540, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 20.0}, //Vincent
    {609, 100.000, 100.000, 1, 140.0, 5500.0, 4.0, 25.0}, //Boxburg
    {524, 100.000, 100.000, 1, 110.0, 5500.0, 4.0, 25.0}, //Cement Truck
    {413, 100.000, 100.000, 1, 160.0, 2600.0, 4.0, 28.0}, //Pony
    {440, 100.000, 100.000, 1, 160.0, 2000.0, 4.0, 27.0}, //Rumpo
    {459, 100.000, 100.000, 1, 160.0, 1900.0, 5.0, 26.0}, //Topfun
    {552, 100.000, 100.000, 1, 160.0, 2600.0, 4.0, 29.0}, //Utily Van
    {478, 100.000, 100.000, 1, 150.0, 1850.0, 5.0, 24.0}, //Walton
    {572, 100.000, 100.000, 1, 60.0, 800.0, 6.0, 24.0}, //Mower
    {530, 100.000, 100.000, 1, 60.0, 1000.0, 5.0, 10.0}, //Forkflit
    {438, 100.000, 100.000, 1, 160.0, 1750.0, 5.0, 22.0}, //Cabbie
    {420, 100.000, 100.000, 1, 180.0, 1450.0, 5.0, 22.0}, //Taxi
    {525, 100.000, 100.000, 1, 160.0, 5500.0, 4.0, 24.0}, //Towtruck
    {588, 100.000, 100.000, 1, 140.0, 5500.0, 4.0, 19.0}, //Hotdogcar
    {462, 100.000, 100.000, 1, 190.0, 500.0, 6.0, 8.0}, //Faggio
    {604, 100.000, 100.000, 1, 110.0, 1600.0, 5.0, 20.0}, //Glendale Wreck
    {605, 100.000, 100.000, 1, 105.0, 1700.0, 5.0, 20.0}, //Sadler Wreck
    {466, 100.000, 100.000, 1, 110.0, 1600.0, 5.0, 20.0}, //Glendale
    {605, 100.000, 100.000, 1, 105.0, 1700.0, 5.0, 20.0}, //Sadler Wreck
    {585, 100.000, 100.000, 1, 165.0, 1800.0, 5.0, 22.0}, //Emperor
    {566, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 22.0}, //Tahoma
    {576, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 22.0}, //Tornado
    {549, 100.000, 100.000, 1, 160.0, 1700.0, 5.0, 22.0}, //Tampa
    {547, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 22.0}, //Primo
    {546, 100.000, 100.000, 1, 160.0, 1800.0, 5.0, 22.0}, //Intruder
    {543, 100.000, 100.000, 1, 165.0, 1700.0, 5.0, 19.0}, //Sadler
    {542, 100.000, 100.000, 1, 160.0, 1600.0, 5.0, 20.0}, //Clover
    {527, 100.000, 100.000, 1, 160.0, 1200.0, 5.0, 21.0}, //Cadrona
    {508, 100.000, 100.000, 1, 140.0, 3500.0, 4.0, 24.0}, //Journey
    {483, 100.000, 100.000, 1, 120.0, 1900.0, 5.0, 23.0}, //Camper
    {482, 100.000, 100.000, 1, 150.0, 1900.0, 5.0, 27.0}, //Burrito
    {479, 100.000, 100.000, 1, 165.0, 1500.0, 5.0, 22.0}, //Regina
    {458, 100.000, 100.000, 1, 165.0, 2000.0, 4.0, 22.0}, //Solair
    {436, 100.000, 100.000, 1, 160.0, 1400.0, 5.0, 22.0}, //Previon
    {418, 100.000, 100.000, 1, 150.0, 2000.0, 4.0, 25.0}, //Moonbeam
    {410, 100.000, 100.000, 1, 160.0, 1000.0, 5.0, 17.0}, //Manana
    {404, 100.000, 100.000, 1, 150.0, 1200.0, 5.0, 19.0}, //Perenniel
    {457, 100.000, 100.000, 1, 60.0, 400.0, 6.0, 10.0}, //Caddy
    {471, 100.000, 100.000, 1, 160.0, 400.0, 6.0, 7.0}, //Quad
    {514, 100.000, 100.000, 1, 120.0, 3800.0, 6.0, 100.0}, //Petrol Tanker
    //Diesel
    {431, 100.000, 100.000, 2, 130.0, 5500.0, 7.0, 30.0}, //Bus
    {437, 100.000, 100.000, 2, 130.0, 5500.0, 7.0, 30.0}, //Coach
    {531, 100.000, 100.000, 2, 70.0, 2000.0, 6.0, 25.0}, //Tractor
    {408, 100.000, 100.000, 2, 110.0, 5500.0, 7.0, 30.0}, //Tashmaster
    {515, 100.000, 100.000, 2, 120.0, 3800.0, 6.0, 30.0}, //Roadtraion
    {578, 100.000, 100.000, 2, 110.0, 5500.0, 6.0, 30.0}, //DFT
    {455, 100.000, 100.000, 2, 140.0, 8500.0, 7.0, 30.0}, //Flatbet
    {403, 100.000, 100.000, 2, 120.0, 3500.0, 6.0, 30.0}, //Linerunner
    {414, 100.000, 100.000, 2, 140.0, 3500.0, 6.0, 30.0}, //Mule
    {443, 100.000, 100.000, 2, 150.0, 8000.0, 7.0, 30.0}, //Packer
    {498, 100.000, 100.000, 2, 140.0, 5500.0, 7.0, 30.0}, //Boxville
    {422, 100.000, 100.000, 2, 165.0, 1700.0, 6.0, 25.0}, //Bobcat
    {489, 100.000, 100.000, 2, 170.0, 1700.0, 6.0, 25.0}, //Rancher
    {554, 100.000, 100.000, 2, 170.0, 1700.0, 6.0, 25.0}, //Yosemite
    {400, 100.000, 100.000, 2, 160.0, 1700.0, 6.0, 25.0}, //Landstalker
    {579, 100.000, 100.000, 2, 160.0, 2500.0, 6.0, 25.0}, //Huntley
    {500, 100.000, 100.000, 2, 160.0, 1300.0, 6.0, 25.0}, //Mesa
    {434, 100.000, 100.000, 2, 200.0, 2500.0, 6.0, 25.0}, //Hotkine
    {470, 100.000, 100.000, 2, 170.0, 2500.0, 6.0, 30.0},//Patriot
    {456, 100.000, 100.000, 2, 160.0, 4500.0, 7.0, 30.0}, //Yankee
    {406, 100.000, 100.000, 2, 110.0, 10500.0, 7.0, 50.0}, //Dumper
    {434, 100.000, 100.000, 2, 170.0, 2300.0, 7.0, 30.0},//Hotknife
    //Turbo
    {593, 100.000, 100.000, 4, 200.0, 2500.0, 10.0, 250.0}, //Dodo
    {563, 100.000, 100.000, 4, 200.0, 2500.0, 10.0, 250.0}, //Raindance
    {519, 100.000, 100.000, 4, 200.0, 15000.0, 10.0, 250.0}, //Shamal
    {469, 100.000, 100.000, 4, 200.0, 2500.0, 10.0, 250.0}, //Sparrow
    {446, 100.000, 100.000, 4, 200.0, 2500.0, 10.0, 250.0}, //Squalo
    {453, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Reefer
    {454, 100.000, 100.000, 4, 200.0, 2200.0, 10.0, 250.0}, //Tropic
    {473, 100.000, 100.000, 4, 200.0, 800.0, 10.0, 250.0}, //Dinghy
    {484, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Marquis
    {487, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Maverick
    {511, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Beagle
    {417, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0}, //Levetian
    {520, 100.000, 100.000, 4, 200.0, 5000.0, 10.0, 250.0} //Hydra
};

new Text3D:v3DText[MAX_VEHICLES];
new vCallsign[MAX_VEHICLES];
new VehicleInterior[MAX_VEHICLES];

hook OnGameModeInit() {
	for(new i = 0; i < MAX_VEHICLES; i++)
		VehicleInterior[i] = 0;

    LoadVehicles();
	SetTimer("VehicleCheck", 2250, true); //2s
    return true;
}

hook LinkVehicleToInterior(vehicleid, interiorid) {
	VehicleInterior[vehicleid] = interiorid;
	return true;
}

static const Letter[27][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
static const Number[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

SetPlateFree(playerid) {
	new plate[128], Caracter1, Caracter2, Caracter3, Caracter4, Caracter5, Caracter6, Caracter7;
 	Caracter1 = randomEx(0, 9);     //Numero
 	Caracter2 = randomEx(0, 26);    //Letra
 	Caracter3 = randomEx(0, 26);    //Letra
 	Caracter4 = randomEx(0, 26);    //Letra
 	Caracter5 = randomEx(0, 9);     //Numero
 	Caracter6 = randomEx(0, 9);     //Numero
 	Caracter7 = randomEx(0, 9);     //Numero
 	format(plate, sizeof(plate), "%d%s%s%s%d%d%d", Number[Caracter1], Letter[Caracter2], Letter[Caracter3], Letter[Caracter4], Number[Caracter5], Number[Caracter6], Number[Caracter7]);
    
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM vehicles WHERE `plate` = '%s'", plate);
    new Cache:result = mysql_query(DBConn, query);
	if(cache_num_rows() > 0)
		return SetPlateFree(playerid);

	cache_delete(result);
	
	format(pInfo[playerid][pBuyingPlate], 120, "%s", plate);
	return true;
}

ReturnVehicleModelName(model) {
	new name[32] = "Nenhum";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

GetVehicleModelByName(const name[]) {
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return false;
}

VehicleGetID(vehicleid) {
	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (vInfo[i][vExists] && vInfo[i][vVehicle] == vehicleid) {
	    return i;
	}
	return -1;
}

VehicleNearest(playerid) {
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (vInfo[i][vExists] && vInfo[i][vVehicle]) {
		GetVehiclePos(vInfo[i][vVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vInfo[i][vVehicle])) {
		    return i;
		}
	}
	return -1;
}

VehicleNearestToLock(playerid) {
	static Float:fX, Float:fY, Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (vInfo[i][vExists] && vInfo[i][vVehicle]) {
		GetVehiclePos(vInfo[i][vVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vInfo[i][vVehicle]) && vInfo[i][vOwner] == pInfo[playerid][pID]) return i;
		
	}

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (vInfo[i][vExists] && vInfo[i][vVehicle]) {
		GetVehiclePos(vInfo[i][vVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vInfo[i][vVehicle])) return i;
	}
	return -1;
}

IsVehicleImpounded(vehicleid) {
    new id = VehicleGetID(vehicleid);

	if (id != -1 && vInfo[id][vImpounded] != -1 && vInfo[id][vImpoundedPrice] > 0)
	    return true;

	return false;
}

VehicleIsOwner(playerid, vehicleid) {
	if(vehicleid == -1) return false;
    if(!pInfo[playerid][pLogged] || pInfo[playerid][pID] == -1) return false;
    if((vInfo[vehicleid][vExists] && vInfo[vehicleid][vOwner] != 0) && (vInfo[vehicleid][vOwner] == pInfo[playerid][pID])) return true;
	return false;
}

VehicleInside(playerid) {
	new vehicleid;
	if (IsPlayerInAnyVehicle(playerid) && (vehicleid = VehicleGetID(GetPlayerVehicleID(playerid))) != -1)
	    return vehicleid;
	return -1;
}

ReturnVehicleHealth(vehicleid) {
	if (!IsValidVehicle(vehicleid))
	    return 0;

	static
	    Float:amount;

	GetVehicleHealth(vehicleid, amount);
	return floatround(amount, floatround_round);
}

SetVehicleColor(vehicleid, color1, color2) {
	if (vehicleid != -1) {
	    vInfo[vehicleid][vColor1] = color1;
	    vInfo[vehicleid][vColor2] = color2;
	    SaveVehicle(vehicleid);
	}
	return ChangeVehicleColor(vInfo[vehicleid][vVehicle], color1, color2);
}

GetEngineStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (engine != 1)
		return false;
 
	return true;
}

GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z) {
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID) return (x = 0.0, y = 0.0, z = 0.0), 0;

	static Float:pos[7];
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];
	return true;
}

GetLightStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (lights != 1)
		return false;

	return true;
}

GetHoodStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (bonnet != 1)
		return false;

	return true;
}

GetDoorsStatus(vehicleid) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (doors != 1)
		return false;

	return true;
}

SetEngineStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
}

SetLightStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}

SetHoodStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}

SetDoorsStatus(vehicleid, status) {
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, alarm, alarm, status, bonnet, boot, objective);
}

GetVehicleFromBehind(vehicleid) {
	static
	    Float:fCoords[7];

	GetVehiclePos(vehicleid, fCoords[0], fCoords[1], fCoords[2]);
	GetVehicleZAngle(vehicleid, fCoords[3]);

	for (new i = 1; i != MAX_VEHICLES+1; i ++) if (i != vehicleid && GetVehiclePos(i, fCoords[4], fCoords[5], fCoords[6]))
	{
		if (floatabs(fCoords[0] - fCoords[4]) < 6 && floatabs(fCoords[1] - fCoords[5]) < 6 && floatabs(fCoords[2] - fCoords[6]) < 6)
			return i;
	}
	return INVALID_VEHICLE_ID;
}

GetNearestVehicle(playerid, forkflit=0) {
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	if(forkflit) {
	    for (new i = 1; i != MAX_VEHICLES+1; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ) && GetVehicleModel(i) != 530) {
		    if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ)) return i;
		}
	} else {
		for (new i = 1; i != MAX_VEHICLES+1; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ)) {
		    if (IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ)) return i;
		}
	}
	return INVALID_VEHICLE_ID;
}

GetAvailableSeat(vehicleid, start = 1) {
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}

GetVehicleMaxSeats(vehicleid) {
    static const g_arrMaxSeats[] = {
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
		2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
		4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
		1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
		4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
		4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
		0, 0
	};

	new  model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return false;
}

IsVehicleSeatUsed(vehicleid, seat) {
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return true;
	}
	return false;
}

IsEngineVehicle(vehicleid) {
	static const g_aEngineStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}

IsDoorVehicle(vehicleid) {
	switch (GetVehicleModel(vehicleid)) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return true;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return true;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return true;
	}
	return false;
}

IsPlayerNearHood(playerid, vehicleid) {
	static Float:fX, Float:fY, Float:fZ;
	GetVehicleHood(vehicleid, fX, fY, fZ);
	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.0, fX, fY, fZ);
}

SetCarAttributes(vehiclemodel, vehicleid) {
	new count;
    for (new i = 0; i < sizeof(arrBatteryEngine); i ++) {
	    if(vehiclemodel == arrBatteryEngine[i][VehModel]) {
	        vInfo[vehicleid][vBattery] = arrBatteryEngine[i][VehBattery];
	        vInfo[vehicleid][vEngine] = arrBatteryEngine[i][VehEngine];
	        vInfo[vehicleid][vEnergyResource] = arrBatteryEngine[i][VehFuelType];
	        count++;
	        break;
	    }
	} if(!count) {
	    vInfo[vehicleid][vBattery] = 100.000;
     	vInfo[vehicleid][vEngine] = 100.000;
     	vInfo[vehicleid][vEnergyResource] = 1;
     	vInfo[vehicleid][vMaxHealth] = 1000.0;
     	count = 0;
	}
	return true;
}

forward VehicleCheck();
public VehicleCheck() {
	static Float:fHealth;
	for (new i = 1; i != MAX_VEHICLES+1; i ++) if (IsValidVehicle(i) && GetVehicleHealth(i, fHealth) && fHealth < 300.0) {
	    SetVehicleHealth(i, 300.0);
	    new vehicleid;
		vehicleid = VehicleGetID(i);
		if(vInfo[vehicleid][vEngine] > 0.030) vInfo[vehicleid][vEngine] -= 0.030;
		
 		vInfo[vehicleid][vHealthRepair] = 300.0;
	    SetEngineStatus(i, false);
	}
	return true;
}

IsWindowedVehicle(vehicleid) {
	static const g_aWindowStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1,
	    1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1,
		1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
	new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return false;

    return (g_aWindowStatus[modelid - 400]);
}

SendVehicleMessage(vehicleid, color, const str[], {Float,_}:...) {
	static
	    args,
	    start,
	    end;

	static string[144];
	
	string[0] = '\0';

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach(new i : Player)
		{
		 	if (GetPlayerVehicleID(i) == vehicleid)
		 	{
			    SendClientMessage(i, color, string);
				foreach(new ix : Player) {
				    if(pInfo[ix][pSpectating] == i)
				        va_SendClientMessage(ix, color, "[CHAT SPEC %s] %s", pNome(i), string);
				}
			}
		}
		return true;
	}

	foreach(new i : Player) {
		if (GetPlayerVehicleID(i) == vehicleid) {
 			SendClientMessage(i, color, string);

			foreach(new ix : Player) {
				if(pInfo[ix][pSpectating] == i)
				    va_SendClientMessage(ix, color, "[CHAT SPEC %s] %s", pNome(i), string);
			}
		}
	}
	return true;
}