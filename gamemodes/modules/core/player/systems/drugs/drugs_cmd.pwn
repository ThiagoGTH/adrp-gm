CMD:usardroga(playerid, params[]) {
	if(PlayerDrugData[playerid][DrugsCooldown] > gettime()) return SendErrorMessage(playerid, "Você não pode usar drogas agora.");

	new amount, drug[64];
	if(sscanf(params, "is[64]", amount, drug)) return SendSyntaxMessage(playerid, "/usardroga [gramas] [nome da droga]");

    new item_id = GetItemID(drug);

    if(!IsDrugItemByID(item_id))
		return SendErrorMessage(playerid, "%s não é uma droga válida. Veja as drogas disponíveis no seu inventário. O nome da droga deve ser igual ao exibido no inventário, incluindo a acentuação.", drug);

	if(!(0 < amount <= 10)) return SendErrorMessage(playerid, "Você não pode usar menos de 1g ou mais de 10g por vez.");
    
    if(Inventory_Drug_Count(playerid, drug) < amount)
		return SendErrorMessage(playerid, "Você não possui %dg de %s.", amount, drug);

	PlayerDrugData[playerid][DrugsCooldown] = gettime() + (60 * amount);
	PlayerDrugData[playerid][Drugs] -= amount;
	PlayerDrugData[playerid][TotalUsed] += amount;

    Inventory_Remove(playerid, Inventory_Drug_Slot(playerid, drug), amount);

	SetPlayerWeather(playerid, 234);
	RegenTimer[playerid] = SetTimerEx("RegenHealth", 500, false, "ii", playerid, (5 * amount));
	EffectTimer[playerid] = SetTimerEx("RemoveEffects", (10 * amount) * 1000, false, "i", playerid);
	
    va_SendClientMessage(playerid, COLOR_YELLOW, "DROGAS: Você usou %dg de %s.", amount, drug);
	return true;
}