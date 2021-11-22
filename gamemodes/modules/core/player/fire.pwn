/*

Modulo destinado ao sistema de incêndio

*/

#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
	SetTimer("PlayerUpdate", 1000, true);
    return 1;
}


//==============================================================================================================================================
//                                                                  news
new fire_Object[36] = {INVALID_OBJECT_ID, ...};
new fire_extintor[36];

//==============================================================================================================================================
//                                                          Funções
public2:CreateFire()
{
	for (new i = 0; i < sizeof(fire_Object); i ++)
	{
	    fire_extintor[i] = 0;

	    if (IsValidDynamicObject(fire_Object[i]))
	        DestroyDynamicObject(fire_Object[i]);
	}
	switch (random(5))
	{
	    case 0:
	    {
			fire_Object[0] = CreateDynamicObject(18691, 1930.4942, -1784.1799, 10.9368, 0.0, 0.0, 0.0);
			fire_Object[1] = CreateDynamicObject(18691, 1930.5037, -1782.1473, 10.9368, 0.0, 0.0, 0.0);
			fire_Object[2] = CreateDynamicObject(18691, 1930.5136, -1779.6364, 10.9368, 0.0, 0.0, 0.0);
			fire_Object[3] = CreateDynamicObject(18691, 1930.5238, -1777.1058, 10.9368, 0.0, 0.0, 0.0);
			fire_Object[4] = CreateDynamicObject(18691, 1930.5346, -1774.5141, 10.9368, 0.0, 0.0, 0.0);
			fire_Object[5] = CreateDynamicObject(18691, 1930.5428, -1772.4306, 10.9368, 0.0, 0.0, 0.0);
			fire_Object[6] = CreateDynamicObject(18691, 1930.5507, -1770.4219, 10.9368, 0.0, 0.0, 0.0);
			fire_Object[7] = CreateDynamicObject(18691, 1930.5588, -1768.3559, 10.9368, 0.0, 0.0, 0.0);
			fire_Object[8] = CreateDynamicObject(18691, 1929.1459, -1767.9173, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[9] = CreateDynamicObject(18691, 1928.8776, -1769.5853, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[10] = CreateDynamicObject(18691, 1928.8422, -1772.0158, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[11] = CreateDynamicObject(18691, 1928.8189, -1773.6047, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[12] = CreateDynamicObject(18691, 1928.8001, -1774.8883, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[13] = CreateDynamicObject(18691, 1928.7772, -1776.4462, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[14] = CreateDynamicObject(18691, 1928.7534, -1778.0637, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[15] = CreateDynamicObject(18691, 1928.7347, -1779.3225, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[16] = CreateDynamicObject(18691, 1928.7145, -1780.7152, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[17] = CreateDynamicObject(18691, 1928.6938, -1782.1208, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[18] = CreateDynamicObject(18691, 1928.6655, -1784.0491, 14.3093, 0.0, 0.0, 0.0);
			fire_Object[19] = CreateDynamicObject(18691, 1935.3200, -1783.8045, 10.7728, 0.0, 0.0, 0.0);
			fire_Object[20] = CreateDynamicObject(18691, 1935.2098, -1781.6428, 10.7728, 0.0, 0.0, 0.0);
			fire_Object[21] = CreateDynamicObject(18691, 1935.0748, -1778.9934, 10.7728, 0.0, 0.0, 0.0);
			fire_Object[22] = CreateDynamicObject(18691, 1934.9506, -1776.5572, 10.7728, 0.0, 0.0, 0.0);
			fire_Object[23] = CreateDynamicObject(18691, 1934.8343, -1774.2791, 10.7728, 0.0, 0.0, 0.0);
			fire_Object[24] = CreateDynamicObject(18691, 1934.7189, -1772.0156, 10.7728, 0.0, 0.0, 0.0);
			fire_Object[25] = CreateDynamicObject(18691, 1934.6302, -1770.2773, 10.7728, 0.0, 0.0, 0.0);
			fire_Object[26] = CreateDynamicObject(18691, 1934.5228, -1768.1666, 10.7728, 0.0, 0.0, 0.0);
		}
		case 1:
		{
			fire_Object[0] = CreateDynamicObject(18691, 1238.8894, -1563.0980, 10.9999, 0.0, 0.0, 0.0);
			fire_Object[1] = CreateDynamicObject(18691, 1241.6730, -1562.6481, 11.0068, 0.0, 0.0, 0.0);
			fire_Object[2] = CreateDynamicObject(18691, 1243.2508, -1561.0845, 10.9444, 0.0, 0.0, 0.0);
			fire_Object[3] = CreateDynamicObject(18691, 1245.5793, -1560.6265, 10.9450, 0.0, 0.0, 0.0);
			fire_Object[4] = CreateDynamicObject(18691, 1247.4980, -1560.4841, 10.9455, 0.0, 0.0, 0.0);
			fire_Object[5] = CreateDynamicObject(18691, 1249.9790, -1560.3701, 10.9539, 0.0, 0.0, 0.0);
			fire_Object[6] = CreateDynamicObject(18691, 1249.5944, -1562.7432, 11.0053, 0.0, 0.0, 0.0);
			fire_Object[7] = CreateDynamicObject(18691, 1247.4562, -1562.7996, 11.0045, 0.0, 0.0, 0.0);
			fire_Object[8] = CreateDynamicObject(18691, 1245.7386, -1563.1572, 10.9990, 0.0, 0.0, 0.0);
			fire_Object[9] = CreateDynamicObject(18691, 1243.7620, -1563.7636, 10.9896, 0.0, 0.0, 0.0);
			fire_Object[10] = CreateDynamicObject(18691, 1242.2908, -1563.0959, 10.9999, 0.0, 0.0, 0.0);
			fire_Object[11] = CreateDynamicObject(18691, 1242.3502, -1564.7818, 10.9740, 0.0, 0.0, 0.0);
			fire_Object[12] = CreateDynamicObject(18691, 1244.8713, -1564.6507, 10.9760, 0.0, 0.0, 0.0);
			fire_Object[13] = CreateDynamicObject(18691, 1246.8665, -1564.5694, 10.9772, 0.0, 0.0, 0.0);
			fire_Object[14] = CreateDynamicObject(18691, 1249.1672, -1563.8638, 10.9881, 0.0, 0.0, 0.0);
			fire_Object[15] = CreateDynamicObject(18691, 1250.8759, -1563.9959, 10.9861, 0.0, 0.0, 0.0);
			fire_Object[16] = CreateDynamicObject(18691, 1252.2437, -1562.3538, 11.0113, 0.0, 0.0, 0.0);
			fire_Object[17] = CreateDynamicObject(18691, 1252.4475, -1561.7529, 13.6369, 0.0, 0.0, 0.0);
			fire_Object[18] = CreateDynamicObject(18691, 1250.9642, -1561.7822, 13.6519, 0.0, 0.0, 0.0);
			fire_Object[19] = CreateDynamicObject(18691, 1248.5258, -1561.3541, 13.8278, 0.0, 0.0, 0.0);
			fire_Object[20] = CreateDynamicObject(18691, 1245.9611, -1561.1191, 13.5507, 0.0, 0.0, 0.0);
			fire_Object[21] = CreateDynamicObject(18691, 1242.7899, -1561.6608, 13.7519, 0.0, 0.0, 0.0);
			fire_Object[22] = CreateDynamicObject(18691, 1250.3793, -1561.5445, 10.9462, 0.0, 0.0, 0.0);
			fire_Object[23] = CreateDynamicObject(18691, 1252.8653, -1561.6358, 10.9468, 0.0, 0.0, 0.0);
			fire_Object[24] = CreateDynamicObject(18691, 1252.9653, -1563.4675, 10.9942, 0.0, 0.0, 0.0);
			fire_Object[25] = CreateDynamicObject(18691, 1252.5823, -1563.9747, 10.9864, 0.0, 0.0, 0.0);
		}
		case 2:
		{
		    fire_Object[0] = CreateDynamicObject(18691, 1786.4844, -1164.2786, 21.2181, 0.0, 0.0, 0.0);
			fire_Object[1] = CreateDynamicObject(18691, 1787.8876, -1164.3374, 21.2181, 0.0, 0.0, 0.0);
			fire_Object[2] = CreateDynamicObject(18691, 1790.0416, -1164.8181, 21.2181, 0.0, 0.0, 0.0);
			fire_Object[3] = CreateDynamicObject(18691, 1791.7430, -1165.1977, 21.2181, 0.0, 0.0, 0.0);
			fire_Object[4] = CreateDynamicObject(18691, 1793.3637, -1165.5594, 21.2181, 0.0, 0.0, 0.0);
			fire_Object[5] = CreateDynamicObject(18691, 1794.8229, -1165.8847, 21.2181, 0.0, 0.0, 0.0);
			fire_Object[6] = CreateDynamicObject(18691, 1796.5830, -1166.2770, 21.2181, 0.0, 0.0, 0.0);
			fire_Object[7] = CreateDynamicObject(18691, 1798.3182, -1166.6638, 21.2181, 0.0, 0.0, 0.0);
			fire_Object[8] = CreateDynamicObject(18691, 1798.2283, -1166.9202, 22.1465, 0.0, 0.0, 0.0);
			fire_Object[9] = CreateDynamicObject(18691, 1797.1246, -1166.2222, 22.5881, 0.0, 0.0, 0.0);
			fire_Object[10] = CreateDynamicObject(18691, 1796.1480, -1165.5697, 22.5401, 0.0, 0.0, 0.0);
			fire_Object[11] = CreateDynamicObject(18691, 1795.4377, -1165.1295, 22.1495, 0.0, 0.0, 0.0);
			fire_Object[12] = CreateDynamicObject(18691, 1794.7139, -1164.6824, 21.4488, 0.0, 0.0, 0.0);
			fire_Object[13] = CreateDynamicObject(18691, 1789.6914, -1164.0892, 22.3047, 0.0, 0.0, 0.0);
			fire_Object[14] = CreateDynamicObject(18691, 1788.5687, -1163.1995, 22.3698, 0.0, 0.0, 0.0);
			fire_Object[15] = CreateDynamicObject(18691, 1788.0295, -1162.8452, 21.9937, 0.0, 0.0, 0.0);
			fire_Object[16] = CreateDynamicObject(18691, 1786.2319, -1163.1064, 21.8608, 0.0, 0.0, 0.0);
			fire_Object[17] = CreateDynamicObject(18691, 1785.3194, -1163.1263, 21.9294, 0.0, 0.0, 0.0);
			fire_Object[18] = CreateDynamicObject(18691, 1791.5643, -1163.1118, 21.3996, 0.0, 0.0, 0.0);
			fire_Object[19] = CreateDynamicObject(18691, 1791.8800, -1164.3983, 22.2759, 0.0, 0.0, 0.0);
			fire_Object[20] = CreateDynamicObject(18691, 1791.8519, -1165.1618, 22.5094, 0.0, 0.0, 0.0);
			fire_Object[21] = CreateDynamicObject(18691, 1788.8287, -1163.4260, 22.0600, 0.0, 0.0, 0.0);
			fire_Object[22] = CreateDynamicObject(18691, 1790.2512, -1164.0129, 21.2942, 0.0, 0.0, 0.0);
		}
		case 3:
		{
		    fire_Object[0] = CreateDynamicObject(18691, 1315.0238, -1368.2282, 10.9438, 0.0, 0.0, 0.0);
			fire_Object[1] = CreateDynamicObject(18691, 1314.0100, -1368.2265, 10.9438, 0.0, 0.0, 0.0);
			fire_Object[2] = CreateDynamicObject(18691, 1312.6562, -1368.2235, 10.9399, 0.0, 0.0, 0.0);
			fire_Object[3] = CreateDynamicObject(18691, 1311.8308, -1367.5294, 10.9296, 0.0, 0.0, 0.0);
			fire_Object[4] = CreateDynamicObject(18691, 1310.9281, -1367.4926, 10.9273, 0.0, 0.0, 0.0);
			fire_Object[5] = CreateDynamicObject(18691, 1309.7708, -1367.4902, 10.9252, 0.0, 0.0, 0.0);
			fire_Object[6] = CreateDynamicObject(18691, 1308.6425, -1367.4877, 10.9232, 0.0, 0.0, 0.0);
			fire_Object[7] = CreateDynamicObject(18691, 1307.3302, -1368.0213, 10.9332, 0.0, 0.0, 0.0);
			fire_Object[8] = CreateDynamicObject(18691, 1306.0062, -1368.3232, 10.9355, 0.0, 0.0, 0.0);
			fire_Object[9] = CreateDynamicObject(18691, 1304.3460, -1368.3197, 10.9354, 0.0, 0.0, 0.0);
			fire_Object[10] = CreateDynamicObject(18691, 1304.4842, -1369.0036, 10.9451, 0.0, 0.0, 0.0);
			fire_Object[11] = CreateDynamicObject(18691, 1305.8629, -1369.4384, 10.9513, 0.0, 0.0, 0.0);
			fire_Object[12] = CreateDynamicObject(18691, 1307.2315, -1369.3804, 10.9512, 0.0, 0.0, 0.0);
			fire_Object[13] = CreateDynamicObject(18691, 1309.0936, -1369.7593, 10.9550, 0.0, 0.0, 0.0);
			fire_Object[14] = CreateDynamicObject(18691, 1310.8515, -1369.5230, 10.9544, 0.0, 0.0, 0.0);
			fire_Object[15] = CreateDynamicObject(18691, 1312.0820, -1369.2214, 10.9522, 0.0, 0.0, 0.0);
			fire_Object[16] = CreateDynamicObject(18691, 1309.4581, -1367.9462, 13.2241, 0.0, 0.0, 0.0);
			fire_Object[17] = CreateDynamicObject(18691, 1307.8933, -1367.5498, 13.5101, 0.0, 0.0, 0.0);
			fire_Object[18] = CreateDynamicObject(18691, 1307.3311, -1369.9162, 13.0364, 0.0, 0.0, 0.0);
			fire_Object[19] = CreateDynamicObject(18691, 1306.5539, -1370.5288, 12.7001, 0.0, 0.0, 0.0);
			fire_Object[20] = CreateDynamicObject(18691, 1310.9852, -1369.3835, 12.2585, 0.0, 0.0, 0.0);
			fire_Object[21] = CreateDynamicObject(18691, 1310.3361, -1370.6992, 12.9585, 0.0, 0.0, 0.0);
			fire_Object[22] = CreateDynamicObject(18691, 1313.2864, -1370.2733, 10.9708, 0.0, 0.0, 0.0);
			fire_Object[23] = CreateDynamicObject(18691, 1313.3056, -1371.2634, 10.9838, 0.0, 0.0, 0.0);
			fire_Object[24] = CreateDynamicObject(18691, 1311.6168, -1370.8870, 10.9735, 0.0, 0.0, 0.0);
			fire_Object[25] = CreateDynamicObject(18691, 1308.9244, -1371.1181, 10.9726, 0.0, 0.0, 0.0);
			fire_Object[26] = CreateDynamicObject(18691, 1306.5335, -1370.7678, 10.9712, 0.0, 0.0, 0.0);
		}
		case 4:
		{
		    fire_Object[0] = CreateDynamicObject(18691, 997.7821, -910.8650, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[1] = CreateDynamicObject(18691, 998.0914, -911.5863, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[2] = CreateDynamicObject(18691, 998.2116, -913.0366, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[3] = CreateDynamicObject(18691, 998.3492, -914.6963, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[4] = CreateDynamicObject(18691, 998.4992, -916.5079, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[5] = CreateDynamicObject(18691, 998.6508, -918.3324, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[6] = CreateDynamicObject(18691, 998.7961, -920.0861, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[7] = CreateDynamicObject(18691, 998.9600, -922.0629, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[8] = CreateDynamicObject(18691, 999.1196, -923.9867, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[9] = CreateDynamicObject(18691, 999.2616, -925.7003, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[10] = CreateDynamicObject(18691, 999.4187, -927.5945, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[11] = CreateDynamicObject(18691, 999.5601, -929.3013, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[12] = CreateDynamicObject(18691, 1000.5933, -931.6047, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[13] = CreateDynamicObject(18691, 1002.6428, -931.3463, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[14] = CreateDynamicObject(18691, 1004.6893, -931.3514, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[15] = CreateDynamicObject(18691, 1007.2104, -931.1424, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[16] = CreateDynamicObject(18691, 1009.8325, -930.9251, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[17] = CreateDynamicObject(18691, 1012.1341, -930.7343, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[18] = CreateDynamicObject(18691, 1014.4911, -930.5388, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[19] = CreateDynamicObject(18691, 1014.4734, -932.3157, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[20] = CreateDynamicObject(18691, 1013.0949, -932.3657, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[21] = CreateDynamicObject(18691, 1011.4746, -932.4245, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[22] = CreateDynamicObject(18691, 1009.7496, -932.4875, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[23] = CreateDynamicObject(18691, 1008.1029, -932.5473, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[24] = CreateDynamicObject(18691, 1006.0109, -932.6234, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[25] = CreateDynamicObject(18691, 1003.9039, -932.7000, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[26] = CreateDynamicObject(18691, 1002.0654, -932.7668, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[27] = CreateDynamicObject(18691, 1002.6585, -933.5130, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[28] = CreateDynamicObject(18691, 1004.5731, -933.4433, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[29] = CreateDynamicObject(18691, 1006.4688, -933.3743, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[30] = CreateDynamicObject(18691, 1008.4611, -933.3016, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[31] = CreateDynamicObject(18691, 1010.4176, -933.2304, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[32] = CreateDynamicObject(18691, 1012.0813, -933.1698, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[33] = CreateDynamicObject(18691, 1013.1374, -933.1314, 39.5696, 0.0, 0.0, 0.0);
			fire_Object[34] = CreateDynamicObject(18691, 1015.3114, -933.0523, 39.5696, 0.0, 0.0, 0.0);
		}
	}
	new Float:FirePos[3];

	GetDynamicObjectPos(fire_Object[0], FirePos[0], FirePos[1], FirePos[2]);
	CreateExplosion(FirePos[0], FirePos[1], FirePos[2], 12, 5.0);
	return 1;
}

public2:PlayerUpdate(playerid){

	static keys[3];

    if(!pInfo[playerid][pLogged]) return 1;

	if ((keys[0] & KEY_FIRE) && GetPlayerWeapon(playerid) == 42){
       	new Float:FirePos[3];
	     
		for (new i = 0; i < sizeof(fire_Object); i ++){
			GetDynamicObjectPos(fire_Object[i], FirePos[0], FirePos[1], FirePos[2]);

			if ((IsValidDynamicObject(fire_Object[i]) && IsPlayerInRangeOfPoint(playerid, 4.0, FirePos[0], FirePos[1], FirePos[2])) && ++ fire_extintor[i] == 32){
   			    SetTimerEx("DestroyFire", 2000, false, "d", CreateDynamicObject(18744, FirePos[0], FirePos[1], FirePos[2] - 0.2, 0.0, 0.0, 0.0));

      			DestroyDynamicObject(fire_Object[i]);
	        	fire_extintor[i] = 0;
			}
		}
	}
	if ((keys[0] & KEY_FIRE) && (GetVehicleModel(GetPlayerVehicleID(playerid)) == 407 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 544))
	{
	    new Float:FirePos[3],
			Float:fVector[3],
			Float:fCamera[3];

	    GetPlayerCameraFrontVector(playerid, fVector[0], fVector[1], fVector[2]);
	    GetPlayerCameraPos(playerid, fCamera[0], fCamera[1], fCamera[2]);

	    for (new i = 0; i < sizeof(fire_Object); i ++)
	    {
			GetDynamicObjectPos(fire_Object[i], FirePos[0], FirePos[1], FirePos[2]);

			if (IsValidDynamicObject(fire_Object[i]) && IsPlayerInRangeOfPoint(playerid, 3050, FirePos[0], FirePos[1], FirePos[2]))
			{
				if (++fire_extintor[i] == 64 && DistanceCameraTargetToLocation(fCamera[0], fCamera[1], fCamera[2], FirePos[0], FirePos[1], FirePos[2] + 2.5, fVector[0], fVector[1], fVector[2]) < 12.0)
				{
   			    	SetTimerEx("DestroyFire", 2000, false, "d", CreateDynamicObject(18744, FirePos[0], FirePos[1], FirePos[2] - 0.2, 0.0, 0.0, 0.0));
	      			DestroyDynamicObject(fire_Object[i]);
		        	fire_extintor[i] = 0;
				}
		  	}
	    }
	}
    return 1;
}
public2:DestroyFire(objectid){
	if (IsValidDynamicObject(objectid))
	    DestroyDynamicObject(objectid);
	return 0;
}

//==============================================================================================================================================
//                                                              Comandos
CMD:criarincendio(playerid, params[]){
    
    if(uInfo[playerid][uAdmin] < GAME_ADMIN) return SendPermissionMessage(playerid);

	new Float:FirePos[3];

	CreateFire();

	GetDynamicObjectPos(fire_Object[0], FirePos[0], FirePos[1], FirePos[2]);

    SendClientMessage(playerid, VERDE, "(Incêndio):{FFFFFF} Você criou um incêncio com sucesso.");
    return 1;
}
CMD:destruirincendio(playerid, params[])
{
	if(uInfo[playerid][uAdmin] < GAME_ADMIN) return SendPermissionMessage(playerid);

	for (new i = 0; i < sizeof(fire_Object); i ++){
	    fire_extintor[i] = 0;
	    if (IsValidDynamicObject(fire_Object[i]))
	        DestroyDynamicObject(fire_Object[i]);
	}
    SendClientMessage(playerid, VERDE, "(Incêndio):{FFFFFF} Você deletou todos os incêndios no servidor.");
	return 1;
}

CMD:pegararma(playerid, params[]){
    GivePlayerWeapon(playerid, 42, 9999);
    return 1;
}
