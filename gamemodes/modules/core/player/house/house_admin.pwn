#include <YSI_Coding\y_hooks>

CMD:criarcasa(playerid, params[]) {
    new address[128], moneyPrice, cashPrice, houseID;

    if(uInfo[playerid][uAdmin] < GAME_ADMIN) return SendPermissionMessage(playerid);
    if(sscanf(params, "dds[128]", moneyPrice, cashPrice, address)) return SendUsageMessage(playerid, "/criarcasa [preço dinheiro] [preço cash] [endereço]");
    if(moneyPrice < 1) return SendErrorMessage(playerid, "O preço em dinheiro deve ser maior do que 0."); // Casas com 0 de cash serão consideradas como incompráveis por cash.
    
    new Float:housePosition[4];
    GetPlayerPos(playerid, housePosition[0], housePosition[1], housePosition[2]);
    GetPlayerFacingAngle(playerid, housePosition[3]);

    mysql_format(DBConn, query, sizeof query, 
        "INSERT INTO houses (`owner`, `address`, `money_price`, `money_price_default`, `cash_price`, `cash_price_default`, `selling`, \
            `entry_x`, `entry_y`, `entry_z`, `entry_a`) VALUES ('Nenhum', '%s', %d, %d, %d, %d, 1, %f, %f, %f, %f);",
        address, moneyPrice, moneyPrice, cashPrice, cashPrice,
            housePosition[0], housePosition[1], housePosition[2], housePosition[3] + 180);
    mysql_query(DBConn, query);
    houseID = cache_insert_id();

    LoadHouse(houseID);
    va_SendClientMessage(playerid, VERDE, "Você criou a casa %d com sucesso. Não esqueça de editar o interior.", houseID);

    return 1;
}

CMD:destruircasa(playerid, params[]) {
    new houseID;
    
    if(uInfo[playerid][uAdmin] < GAME_ADMIN) return SendPermissionMessage(playerid);
    if(sscanf(params, "d", houseID)) return SendUsageMessage(playerid, "/destruircasa [ID]");

    if(!DeleteHouse(houseID)) 
        return SendErrorMessage(playerid, "Não foi possível encontrar uma casa com este ID.");

    va_SendClientMessage(playerid, VERDE, "Você destruiu a casa de ID %d.", houseID);

    return 1;
}

CMD:ecasa(playerid, params[]) return cmd_editarcasa(playerid, params);
CMD:editarcasa(playerid, params[]) {
    new id, option[128], value[128], Float:pos[4];

    if(uInfo[playerid][uAdmin] < GAME_ADMIN) return SendPermissionMessage(playerid);
    if(sscanf(params, "ds[128]S()[128]", id, option, value)) return SendUsageMessage(playerid, "/e(ditar)casa [id] [opção] <valor>"),
        va_SendClientMessage(playerid, CINZA, "[OPÇÕES] vendendo, interior, entrada, dinheiro, dinheiropadrao, cash, cashpadrao, endereco");
    if(!IsValidHouse(id)) return SendErrorMessage(playerid, "Não foi possível encontrar uma casa com este ID.");

    if(!strcmp(option, "vendendo")) {

        if(hInfo[id][hSelling]) {
            hInfo[id][hSelling] = false;
            va_SendClientMessage(playerid, VERDE, "Você alterou o estado da casa %d para INDISPONÍVEL.", id);
        } else {
            hInfo[id][hSelling] = true;
            va_SendClientMessage(playerid, VERDE, "Você alterou o estado da casa %d para DISPONÍVEL.", id);
        }

        ReloadHouse(id);

    } else if(!strcmp(option, "interior")) { 
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);

        hInfo[id][hExitX] = pos[0];
        hInfo[id][hExitY] = pos[1];
        hInfo[id][hExitZ] = pos[2];
        hInfo[id][hExitA] = pos[3];
        hInfo[id][hInterior] = GetPlayerInterior(playerid);
        ReloadHouse(id);

        va_SendClientMessage(playerid, VERDE, "Você alterou o interior da casa %d com sucesso.", id);
    } else if(!strcmp(option, "entrada")) {

        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);

        hInfo[id][hEntryX] = pos[0];
        hInfo[id][hEntryY] = pos[1];
        hInfo[id][hEntryZ] = pos[2];
        hInfo[id][hEntryA] = pos[3];
        ReloadHouse(id);

        va_SendClientMessage(playerid, VERDE, "Você alterou a entrada da casa %d com sucesso.", id);
    } else if(!strcmp(option, "dinheiro")) {

        if(!strval(value)) return SendErrorMessage(playerid, "Você precisa especificar um valor (número) maior do que zero.");
        new intValue = strval(value);
        
        hInfo[id][hMoneyPrice] = intValue;
        va_SendClientMessage(playerid, VERDE, "Você alterou o preço em dinheiro da casa %d para %d.", id, intValue);
    } else if(!strcmp(option, "dinheiropadrao")) {

        if(!strval(value)) return SendErrorMessage(playerid, "Você precisa especificar um valor (número) maior do que zero.");
        new intValue = strval(value);
        
        hInfo[id][hDefaultMoneyPrice] = intValue;
        va_SendClientMessage(playerid, VERDE, "Você alterou o valor padrão em dinheiro da casa %d para %d.", id, intValue);
    } else if(!strcmp(option, "cash")) {

        if(!strval(value)) return SendErrorMessage(playerid, "Você precisa especificar um valor (número) maior do que zero.");
        new intValue = strval(value);
        
        hInfo[id][hCashPrice] = intValue;
        va_SendClientMessage(playerid, VERDE, "Você alterou o preço em cash da casa %d para %d%s.", id, intValue, intValue == 0 ? (" (Bloqueado)") : (""));
    } else if(!strcmp(option, "cashpadrao")) {

        if(!strval(value)) return SendErrorMessage(playerid, "Você precisa especificar um valor como número");
        new intValue = strval(value);

        hInfo[id][hDefaultCashPrice] = intValue;
        va_SendClientMessage(playerid, VERDE, "Você alterou o preço em cash da casa %d para %d%s.", id, intValue, intValue == 0 ? (" (Bloqueado)") : (""));
    } else if(!strcmp(option, "endereco")) {

        if(!strlen(value)) return SendErrorMessage(playerid, "Você precisa especificar um endereço.");

        format(hInfo[id][hAddress], 128, "%s", value);
        va_SendClientMessage(playerid, VERDE, "Você alterou o endereço da casa %d para %s.", id, value);
    } else return SendUsageMessage(playerid, "/e(ditar)casa [opção]"),
        va_SendClientMessage(playerid, CINZA, "[OPÇÕES] vendendo, interior, entrada");

    return 1;
}

CMD:removerdonocasa(playerid, params[]) {
    new id;
    
    if(uInfo[playerid][uAdmin] < GAME_ADMIN) return SendPermissionMessage(playerid);
    if(sscanf(params, "d", id)) return SendUsageMessage(playerid, "/removerdonocasa [id]");
    if(!IsValidHouse(id)) return SendErrorMessage(playerid, "Não foi possível encontrar uma casa com este ID.");

    va_SendClientMessage(playerid, VERDE, "Você removeu o dono %s como proprietário da casa.", hInfo[id][hOwner]);
    format(hInfo[id][hOwner], 24, "Nenhum");

    ReloadHouse(id);
    
    return 1;
}