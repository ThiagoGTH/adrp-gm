#include <YSI_Coding\y_hooks>

#define ALARM_PRICE_1                   (1000)
#define ALARM_PRICE_2                   (1250)
#define ALARM_PRICE_3                   (1500)
#define SUNPASS_PRICE_1                 (500)
#define LEGALITY_PRICE_1                (3000)

hook OnGameModeInit() {
    CreateDynamicPickup(1239, 23, 542.0506, -1292.9080, 17.2422);
	CreateDynamic3DTextLabel("Grotti Dealership\n{FFFFFF}/concessionaria", COLOR_WHITE, 542.0506, -1292.9080, 17.2422, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    CreateDynamicPickup(1239, 23, 2131.8108, -1150.8969, 24.1069);
	CreateDynamic3DTextLabel("Coutt & Schutz Dealership\n{FFFFFF}/concessionaria", COLOR_WHITE, 2131.8108, -1150.8969, 24.1069, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    return true;
}

CMD:concessionaria(playerid, params[]){
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 542.0506, -1292.9080, 17.2422)) Dialog_Show(playerid, Dealership_Init1, DIALOG_STYLE_LIST, "Grotti", "1. Aviões\n2. Barcos\n3. Motos\n4. Esportivos", "Selecionar", "Fechar");
    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 2131.8108, -1150.8969, 24.1069)) Dialog_Show(playerid, Dealership_Init2, DIALOG_STYLE_LIST, "Coutt & Schutz", "1. Bicicletas\n2. Motos\n3. Sedans\n4. SUVs & Wagons\n5. Lowriders\n6. Industriais\n7. Caminhonetes\n8. Trailers Industriais", "Selecionar", "Fechar");
    else return SendErrorMessage(playerid, "Você não está em nenhuma concessionária.");

    GetPlayerPos(playerid, pInfo[playerid][pPositionX], pInfo[playerid][pPositionY], pInfo[playerid][pPositionZ]);
	GetPlayerFacingAngle(playerid, pInfo[playerid][pPositionA]);

	pInfo[playerid][pInterior] = GetPlayerInterior(playerid);
	pInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
    return true;
}

Dialog:Dealership_Init1(playerid, response, listitem, inputtext[]){
    if(response){
        if(listitem == 0){ // AVIÕES
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '1'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx001 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Aviões_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipAirplanes, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 1){ // BARCOS
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '2'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx002 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Barcos_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipBoats, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 2){ // MOTOS
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '4'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx003 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Motos_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipGrotti, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 3){ // ESPORTIVOS
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '8'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx004 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Esportivos_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipGrotti, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
    } else SendServerMessage(playerid, "Você desistiu de adquirir um veículo.");
    return true;
}

Dialog:Dealership_Init2(playerid, response, listitem, inputtext[]){
    if(response){
        if(listitem == 0){ // BICICLETAS
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '3'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx005 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Bicicletas_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipCoutt, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 1){ // MOTOS
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '4'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx006 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Motos_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipCoutt, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 2){ // SEDANS
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '5'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx007 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Sedans_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipCoutt, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 3){ // SUVs & Wagons
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '6'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx008 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "SUVs_&_Wagons_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipCoutt, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 4){ // Lowriders
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '7'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx009 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Lowriders_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipCoutt, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 5){ // Industriais
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '9'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx010 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Veículos_Industriais_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipCoutt, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 6){ // Caminhonetes
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '10'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx011 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Caminhonetes_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipCoutt, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
        else if(listitem == 7){ // Trailers Industriais
            new Cache:result = mysql_query(DBConn, "SELECT * FROM `vehicles_dealer` WHERE `category` = '12'");

            if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx012 - Não existe nenhum veículo registrado nessa categoria, reporte a um desenvolvedor.");

            new string[2048], model_id, price;
            for(new i; i < cache_num_rows(); i++){
                cache_get_value_name_int(i, "model_id", model_id);
                cache_get_value_name_int(i, "price", price);

                if(GetMoney(playerid) < price) format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~r~%s~n~~n~~n~~n~Valor~n~~r~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));
                else format(string, sizeof(string), "%s%d(0.0, 0.0, 50.0, 0.95, %d, %d)\t~g~%s~n~~n~~n~~n~Valor~n~~g~%s\n", string, model_id, random(127), random(127), ReturnVehicleModelName(model_id), FormatNumber(price));

            }
            cache_delete(result);
            new title[128];
            format(title, 128, "Trailers_Industriais_Disponíveis");
            AdjustTextDrawString(title);

            Dialog_Show(playerid, DealershipCoutt, DIALOG_STYLE_PREVIEW_MODEL, title, string, "Selecionar", "Fechar");
            return true;
        }
    } else SendServerMessage(playerid, "Você desistiu de adquirir um veículo.");
    return true;
}

Dialog:DealershipGrotti(playerid, response, listitem, inputtext[]) {
    if(response) {
        new model_id = strval(inputtext), price, premium;
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles_dealer` WHERE `model_id` = '%d'", model_id);
        new Cache:result = mysql_query(DBConn, query);

        if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx003 - Não existe nenhum veículo registrado com esse modelo, reporte a um desenvolvedor.");

        cache_get_value_name_int(0, "price", price);
        cache_get_value_name_int(0, "premium", premium);
        cache_delete(result);
        if(GetMoney(playerid) < price) return SendErrorMessage(playerid, "Você não possui %s em mãos para comprar %s.", FormatNumber(price), ReturnVehicleModelName(model_id));

        if(pInfo[playerid][pDonator] < premium) return SendErrorMessage(playerid, "Você precisa ser no mínimo %s para adquirir esse veículo.", PremiumType(premium));

        pInfo[playerid][dModel] = model_id;
        pInfo[playerid][dFinalPrice] = price;

        SetCarInside(playerid, model_id, price, 1);
    } else return ResetDealershipVars(playerid);
    return true;
}

Dialog:DealershipCoutt(playerid, response, listitem, inputtext[]) {
    if(response) {
        new model_id = strval(inputtext), price, premium;
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles_dealer` WHERE `model_id` = '%d'", model_id);
        new Cache:result = mysql_query(DBConn, query);

        if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx002 - Não existe nenhum veículo registrado com esse modelo, reporte a um desenvolvedor.");

        cache_get_value_name_int(0, "price", price);
        cache_get_value_name_int(0, "premium", premium);
        cache_delete(result);
        if(GetMoney(playerid) < price) return SendErrorMessage(playerid, "Você não possui %s em mãos para comprar %s.", FormatNumber(price), ReturnVehicleModelName(model_id));

        if(pInfo[playerid][pDonator] < premium) return SendErrorMessage(playerid, "Você precisa ser no mínimo %s para adquirir esse veículo.", PremiumType(premium));

        pInfo[playerid][dModel] = model_id;
        pInfo[playerid][dFinalPrice] = price;

        SetCarInside(playerid, model_id, price, 2);
    } else return ResetDealershipVars(playerid);
    return true;
}

Dialog:DealershipAirplanes(playerid, response, listitem, inputtext[]) {
    if(response) {
        new model_id = strval(inputtext), price, premium;
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles_dealer` WHERE `model_id` = '%d'", model_id);
        new Cache:result = mysql_query(DBConn, query);

        if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx002 - Não existe nenhum veículo registrado com esse modelo, reporte a um desenvolvedor.");

        cache_get_value_name_int(0, "price", price);
        cache_get_value_name_int(0, "premium", premium);
        cache_delete(result);
        if(GetMoney(playerid) < price) return SendErrorMessage(playerid, "Você não possui %s em mãos para comprar %s.", FormatNumber(price), ReturnVehicleModelName(model_id));

        if(pInfo[playerid][pDonator] < premium) return SendErrorMessage(playerid, "Você precisa ser no mínimo %s para adquirir esse veículo.", PremiumType(premium));

        pInfo[playerid][dModel] = model_id;
        pInfo[playerid][dFinalPrice] = price;

        SetCarInside(playerid, model_id, price, 3);
    } else return ResetDealershipVars(playerid);
    return true;
}

Dialog:DealershipBoats(playerid, response, listitem, inputtext[]) {
    if(response) {
        new model_id = strval(inputtext), price, premium;
        mysql_format(DBConn, query, sizeof query, "SELECT * FROM `vehicles_dealer` WHERE `model_id` = '%d'", model_id);
        new Cache:result = mysql_query(DBConn, query);

        if(!cache_num_rows()) return SendErrorMessage(playerid, "Dx002 - Não existe nenhum veículo registrado com esse modelo, reporte a um desenvolvedor.");

        cache_get_value_name_int(0, "price", price);
        cache_get_value_name_int(0, "premium", premium);
        cache_delete(result);
        if(GetMoney(playerid) < price) return SendErrorMessage(playerid, "Você não possui %s em mãos para comprar %s.", FormatNumber(price), ReturnVehicleModelName(model_id));

        if(pInfo[playerid][pDonator] < premium) return SendErrorMessage(playerid, "Você precisa ser no mínimo %s para adquirir esse veículo.", PremiumType(premium));

        pInfo[playerid][dModel] = model_id;
        pInfo[playerid][dFinalPrice] = price;

        SetCarInside(playerid, model_id, price, 4);
    } else return ResetDealershipVars(playerid);
    return true;
}

SetCarInside(playerid, model, price, cam) {
    TogglePlayerControllable(playerid, true);
    if(cam == 1) { // Grotti
		if(!IsValidVehicle(pInfo[playerid][dBuyVehicle])) {
			if(pInfo[playerid][dModel] == 450 || pInfo[playerid][dModel] == 584 || pInfo[playerid][dModel] == 591 || pInfo[playerid][dModel] == 435)
				pInfo[playerid][dBuyVehicle] = CreateVehicle(model, 552.0631, -1269.3943, 20.3316, 320.8407, pInfo[playerid][dColor1], pInfo[playerid][dColor2], -1);
			else
	    		pInfo[playerid][dBuyVehicle] = CreateVehicle(model,552.0631, -1269.3943, 17.3316, 320.8407, pInfo[playerid][dColor1], pInfo[playerid][dColor2], -1);

			ChangeVehicleColours(pInfo[playerid][dBuyVehicle], pInfo[playerid][dColor1], pInfo[playerid][dColor2]);
		}
		SetPlayerVirtualWorld(playerid, playerid+1000);
		SetVehicleVirtualWorld(pInfo[playerid][dBuyVehicle], playerid+1000);
        PutPlayerInVehicle(playerid, pInfo[playerid][dBuyVehicle], 0);
	}
    else if(cam == 2) { // Coutt And Schutz
		if(!IsValidVehicle(pInfo[playerid][dBuyVehicle])) {
			if(pInfo[playerid][dModel] == 450 || pInfo[playerid][dModel] == 584 || pInfo[playerid][dModel] == 591 || pInfo[playerid][dModel] == 435)
				pInfo[playerid][dBuyVehicle] = CreateVehicle(model, 2123.6782, -1125.8719, 27.5539, 340.7095, pInfo[playerid][dColor1], pInfo[playerid][dColor2], -1);
			else
	    		pInfo[playerid][dBuyVehicle] = CreateVehicle(model, 2123.6782, -1125.8719, 25.5539, 340.7095, pInfo[playerid][dColor1], pInfo[playerid][dColor2], -1);

			ChangeVehicleColours(pInfo[playerid][dBuyVehicle], pInfo[playerid][dColor1], pInfo[playerid][dColor2]);
		}
		SetPlayerVirtualWorld(playerid, playerid+2000);
		SetVehicleVirtualWorld(pInfo[playerid][dBuyVehicle], playerid+2000);
        PutPlayerInVehicle(playerid, pInfo[playerid][dBuyVehicle], 0);
	}
    else if(cam == 3) { // Aeroporto
	    SetPlayerPos(playerid, 1932.2606,-2251.5281,13.5469);
		if(!IsValidVehicle(pInfo[playerid][dBuyVehicle])) {
	    	pInfo[playerid][dBuyVehicle] = CreateVehicle(model, 1907.4602, -2292.1763, 14.7098, 273.5805, pInfo[playerid][dColor1], pInfo[playerid][dColor2], -1);
			ChangeVehicleColours(pInfo[playerid][dBuyVehicle], pInfo[playerid][dColor1], pInfo[playerid][dColor2]);
		}
		SetPlayerVirtualWorld(playerid, playerid+5000);
		SetVehicleVirtualWorld(pInfo[playerid][dBuyVehicle], playerid+5000);
		PutPlayerInVehicle(playerid, pInfo[playerid][dBuyVehicle], 0);
		SetPlayerCameraPos(playerid, 1925.9956, -2284.3994, 14.2212);
		SetPlayerCameraLookAt(playerid, 1925.0631, -2284.7654, 14.2113);
	}
    else if(cam == 4) { //Marina
	    SetPlayerPos(playerid, 715.4207,-1699.9086,2.4297);
		if(!IsValidVehicle(pInfo[playerid][dBuyVehicle]))
		{
	    	pInfo[playerid][dBuyVehicle] = CreateVehicle(model, 723.2198, -1698.6869, -0.0064, 0.0000, pInfo[playerid][dColor1], pInfo[playerid][dColor2], -1);
	    	ChangeVehicleColours(pInfo[playerid][dBuyVehicle],  pInfo[playerid][dColor1], pInfo[playerid][dColor2]);
		}
		SetPlayerVirtualWorld(playerid, playerid+6000);
		SetVehicleVirtualWorld(pInfo[playerid][dBuyVehicle], playerid+6000);
		PutPlayerInVehicle(playerid, pInfo[playerid][dBuyVehicle], 0);
		SetPlayerCameraPos(playerid, 728.2611, -1680.6938, 2.9265);
		SetPlayerCameraLookAt(playerid, 727.8109, -1681.5879, 2.7616);
	}
    new title[128], string[2048];
    pInfo[playerid][dModel] = model;
    pInfo[playerid][dVehPrice] = price;
    pInfo[playerid][dCam] = cam;

    new CarEnergyResource2, Float:carMaxVelocity2, Float:carMass2, Float:carEngine2, Float:carConsumation2, Float:carMaxFuel2;
	for (new i = 0; i < sizeof(arrBatteryEngine); i ++) {
	    if(model == arrBatteryEngine[i][VehModel]) {
	        CarEnergyResource2 = arrBatteryEngine[i][VehFuelType];
	        carMaxVelocity2 = arrBatteryEngine[i][VehMaxVelocity];
	        carMass2 = arrBatteryEngine[i][VehMass];
	        carEngine2 = arrBatteryEngine[i][VehEngine];
	        carConsumation2 = arrBatteryEngine[i][VehConsumation];
	        carMaxFuel2 =  arrBatteryEngine[i][VehMaxFuel];
	    }
	}

    format(title, sizeof(title), "{FFFFFF}%s ({36A717}US$ %s{FFFFFF})", ReturnVehicleModelName(pInfo[playerid][dModel]), FormatNumber(GetVehicleFinalPrice(playerid)));
    format(string, sizeof(string), "{FFFF00}Valor:\t\t\t\t{FFFFFF}%s\n", FormatNumber(price));
    format(string, sizeof(string), "%s{FFFF00}Velocidade Máx:\t\t{FFFFFF}%.0f mph\n", string, carMaxVelocity2);
	format(string, sizeof(string), "%s{FFFF00}HP Máx:\t\t\t{FFFFFF}1000.0\n", string);
	format(string, sizeof(string), "%s{FFFF00}Massa:\t\t\t\t{FFFFFF}%.1fkg\n", string, carMass2);
	format(string, sizeof(string), "%s\n", string);
    if(carEngine2) format(string, sizeof(string), "%s{FFFF00}Motor:\t\t\t\t{FFFFFF}Tração Traseira\n", string);
	else format(string, sizeof(string), "%s{FFFF00}Motor:\t\t\t\t{FFFFFF}Outro\n", string);
	
    if(CarEnergyResource2 == 1) { format(string, sizeof(string), "%s{FFFF00}Combustível:\t\t\t{FFFFFF}Gasolina\n", string); }
	else if(CarEnergyResource2 == 2) { format(string, sizeof(string), "%s{FFFF00}Combustível:\t\t\t{FFFFFF}Diesel\n", string); }
	else if(CarEnergyResource2 == 4) { format(string, sizeof(string), "%s{FFFF00}Combustível:\t\t\t{FFFFFF}Turbo/Querosene\n", string); }
	format(string, sizeof(string), "%s{FFFF00}Autonomia:\t\t\t{FFFFFF}%.0f mpg.\n", string, carConsumation2);
	format(string, sizeof(string), "%s{FFFF00}Cap. do Tanque:\t\t{FFFFFF}%.0f gal's.\n\n", string, carMaxFuel2);

    
    if(pInfo[playerid][dAlarm] > 0){
        new benefits[512];
        switch(pInfo[playerid][dAlarm]) {
            case 1: format(benefits, sizeof(benefits), "\t{FFFF00}+{FFFFFF}Alarme sonoro do veiculo.\n");
            case 2: format(benefits, sizeof(benefits), "\t{FFFF00}+{FFFFFF}Alarme sonoro do veiculo;\n\t{FFFF00}+{FFFFFF}Envio de SMS do monitoramento do alarme para o proprietário do veiculo.\n");
            case 3: format(benefits, sizeof(benefits), "\t{FFFF00}+{FFFFFF}Alarme sonoro do veiculo;\n\t{FFFF00}+{FFFFFF}Envio de SMS do monitoramento do alarme para o proprietário do veiculo;\n\t{FFFF00}+{FFFFFF}Alerta para a polícia com a localização do veiculo e envia um checkpoint\n\tpara a posição onde o veiculo se encontra.\n");
        }
        format(string, sizeof(string), "%s{FFFF00}Alarme nível %d\t\t\t{FFFFFF}%s\n%s", string, pInfo[playerid][dAlarm], FormatNumber(GetAlarmPrice(playerid)), benefits);
    }
    if(pInfo[playerid][dInsurance] > 0){
        new benefits[512];
        switch(pInfo[playerid][dInsurance]) {
            case 1: format(benefits, sizeof(benefits), "\t{FFFF00}+{FFFFFF}Restaura o HP do veiculo ao máximo após ser spawnado.\n");
            case 2: format(benefits, sizeof(benefits), "\t{FFFF00}+{FFFFFF}Restaura o HP do veiculo ao máximo após ser spawnado;\n\t{FFFF00}+{FFFFFF}Restaura a lataria do veiculo por completo ao ser spawnado.\n");
            case 3: format(benefits, sizeof(benefits), "\t{FFFF00}+{FFFFFF}Restaura o HP do veiculo ao máximo após ser spawnado;\n\t{FFFF00}+{FFFFFF}Restaura a lataria do veiculo por completo ao ser spawnado;\n\t{FFFF00}+{FFFFFF} Rastreador que localiza o veículo.\n");
        }
        format(string, sizeof(string), "%s{FFFF00}Seguro nível %d\t\t\t{FFFFFF}%s\n%s", string, pInfo[playerid][dInsurance], FormatNumber(GetInsurancePrice(playerid)), benefits);
    }
    if(pInfo[playerid][dSunpass] > 0){
        new benefits[512];
        format(benefits, sizeof(benefits), "\t{FFFF00}+{FFFFFF}Abertura automática da cancela nas faixas de Sun Pass nos pedágios\n\t{FFFF00}+{FFFFFF}Pagamento do pedágio das faixas Sun Pass a cada paycheck apenas.\n\t{BBBBBB}*{FFFFFF}(( Somente funcional com um pacote premium ativo. ))\n");
        format(string, sizeof(string), "%s{FFFF00}Sun Pass instalado\t\t{FFFFFF}%s\n%s", string, FormatNumber(GetSunpassPrice(playerid)), benefits);
    }
    if(pInfo[playerid][dLegalized] > 0){
        new benefits[512];
        format(benefits, sizeof(benefits), "\t{FFFF00}+{FFFFFF}Veículo legalizado e emplacado de acordo com as normas do DMV.\n");
        format(string, sizeof(string), "%s{FFFF00}Veículo legalizado\t\t{FFFFFF}%s\n%s", string, FormatNumber(GetLegalityPrice(playerid)), benefits);
    }

    Dialog_Show(playerid, EditorCheckOut, DIALOG_STYLE_MSGBOX, title, string, "Comprar", "Editar");
    return true;
}

Dialog:EditorCheckOut(playerid, response, listitem, inputtext[]) {
    new string[512], title[256];
    if(response){
        format(title, sizeof(title), "{FFFFFF}%s ({36A717}US$ %s{FFFFFF})", ReturnVehicleModelName(pInfo[playerid][dModel]), FormatNumber(GetVehicleFinalPrice(playerid)));

        format(string, sizeof(string), "Você realmente deseja comprar um(a) %s por %s?", ReturnVehicleModelName(pInfo[playerid][dModel]), FormatNumber(GetVehicleFinalPrice(playerid)));

        Dialog_Show(playerid, EditorCheckOutResponse, DIALOG_STYLE_MSGBOX, title, string, "Confirmar", "Cancelar");
    } else {
        format(title, sizeof(title), "{FFFFFF}%s ({36A717}US$ %s{FFFFFF})", ReturnVehicleModelName(pInfo[playerid][dModel]), FormatNumber(GetVehicleFinalPrice(playerid)));

        Dialog_Show(playerid, SelectEdit, DIALOG_STYLE_LIST, title, "Alarme\nSeguro\nLegalidade\nSun Pass\nCor 1\nCor 2", "Selecionar", "<<");
    }
    return true;
}

Dialog:SelectEdit(playerid, response, listitem, inputtext[]) {
    new string[512], title[128];
    format(title, sizeof(title), "{FFFFFF}%s ({36A717}US$ %s{FFFFFF})", ReturnVehicleModelName(pInfo[playerid][dModel]), FormatNumber(GetVehicleFinalPrice(playerid)));
    if(response){
        switch(listitem){
            case 0: {
                switch(pInfo[playerid][dAlarm]) {
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Nenhum\nAlarme Nível 1 - %s\nAlarme Nível 2 - %s\nAlarme Nível 3 - %s", FormatNumber(ALARM_PRICE_1), FormatNumber(ALARM_PRICE_2), FormatNumber(ALARM_PRICE_3));
                    case 1: format(string, sizeof(string), "Nenhum\n{BBBBBB}>>> {FFFFFF}Alarme Nível 1 - %s\nAlarme Nível 2 - %s\nAlarme Nível 3 - %s", FormatNumber(ALARM_PRICE_1), FormatNumber(ALARM_PRICE_2), FormatNumber(ALARM_PRICE_3));
                    case 2: format(string, sizeof(string), "Nenhum\nAlarme Nível 1 - %s\n{BBBBBB}>>> {FFFFFF}Alarme Nível 2 - %s\nAlarme Nível 3 - %s", FormatNumber(ALARM_PRICE_1), FormatNumber(ALARM_PRICE_2), FormatNumber(ALARM_PRICE_3));
                    case 3: format(string, sizeof(string), "Nenhum\nAlarme Nível 1 - %s\nAlarme Nível 2 - %s\n{BBBBBB}>>> {FFFFFF}Alarme Nível 3 - %s", FormatNumber(ALARM_PRICE_1), FormatNumber(ALARM_PRICE_2), FormatNumber(ALARM_PRICE_3));
                }
                pInfo[playerid][dBuyingEditMenu] = 1;
				Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 1: {
                switch(pInfo[playerid][dInsurance]) {
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Nenhum\nSeguro Nível 1 - %s\nSeguro Nível 2 - %s\nSeguro Nível 3 - %s", FormatNumber((pInfo[playerid][dVehPrice]/100)*10), FormatNumber((pInfo[playerid][dVehPrice]/100)*20), FormatNumber((pInfo[playerid][dVehPrice]/100)*30));
                    case 1: format(string, sizeof(string), "Nenhum\n{BBBBBB}>>> {FFFFFF}Seguro Nível 1 - %s\nSeguro Nível 2 - %s\nSeguro Nível 3 - %s", FormatNumber((pInfo[playerid][dVehPrice]/100)*10), FormatNumber((pInfo[playerid][dVehPrice]/100)*20), FormatNumber((pInfo[playerid][dVehPrice]/100)*30));
                    case 2: format(string, sizeof(string), "Nenhum\nSeguro Nível 1 - %s\n{BBBBBB}>>> {FFFFFF}Seguro Nível 2 - %s\nSeguro Nível 3 - %s", FormatNumber((pInfo[playerid][dVehPrice]/100)*10), FormatNumber((pInfo[playerid][dVehPrice]/100)*20), FormatNumber((pInfo[playerid][dVehPrice]/100)*30));
                    case 3: format(string, sizeof(string), "Nenhum\nSeguro Nível 1 - %s\nSeguro Nível 2 - %s\n{BBBBBB}>>> {FFFFFF}Seguro Nível 3 - %s", FormatNumber((pInfo[playerid][dVehPrice]/100)*10), FormatNumber((pInfo[playerid][dVehPrice]/100)*20), FormatNumber((pInfo[playerid][dVehPrice]/100)*30));
                }
                pInfo[playerid][dBuyingEditMenu] = 2;
				Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 2: {
                switch(pInfo[playerid][dLegalized]){
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Sem emplacamento\nCom emplacamento - %s", FormatNumber(LEGALITY_PRICE_1));
                    case 1: format(string, sizeof(string), "Sem emplacamento\n{BBBBBB}>>> {FFFFFF}Com emplacamento - %s", FormatNumber(LEGALITY_PRICE_1));
                }
                pInfo[playerid][dBuyingEditMenu] = 3;
				Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 3: {
                switch(pInfo[playerid][dSunpass]){
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Sun Pass inativo\nSun Pass ativo - %s", FormatNumber(SUNPASS_PRICE_1));
                    case 1: format(string, sizeof(string), "Sun Pass inativo\n{BBBBBB}>>> {FFFFFF}Sun Pass ativo - %s", FormatNumber(LEGALITY_PRICE_1));
                }
                pInfo[playerid][dBuyingEditMenu] = 4;
				Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 4: {
                switch(pInfo[playerid][dColor1]){
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Preto\nBranco\nAzul\nVermelho\nCinza");
                    case 1: format(string, sizeof(string), "Preto\n{BBBBBB}>>> {FFFFFF}Branco\nAzul\nVermelho\nCinza");
                    case 2: format(string, sizeof(string), "Preto\nBranco\n{BBBBBB}>>> {FFFFFF}Azul\nVermelho\nCinza");
                    case 3: format(string, sizeof(string), "Preto\nBranco\nAzul\n{BBBBBB}>>> {FFFFFF}Vermelho\nCinza");
                    case 4: format(string, sizeof(string), "Preto\nBranco\nAzul\nVermelho\n{BBBBBB}>>> {FFFFFF}Cinza");
                }
                pInfo[playerid][dBuyingEditMenu] = 5;
				Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
            case 5: {
                switch(pInfo[playerid][dColor2]){
                    case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Preto\nBranco\nAzul\nVermelho\nCinza");
                    case 1: format(string, sizeof(string), "Preto\n{BBBBBB}>>> {FFFFFF}Branco\nAzul\nVermelho\nCinza");
                    case 2: format(string, sizeof(string), "Preto\nBranco\n{BBBBBB}>>> {FFFFFF}Azul\nVermelho\nCinza");
                    case 3: format(string, sizeof(string), "Preto\nBranco\nAzul\n{BBBBBB}>>> {FFFFFF}Vermelho\nCinza");
                    case 4: format(string, sizeof(string), "Preto\nBranco\nAzul\nVermelho\n{BBBBBB}>>> {FFFFFF}Cinza");
                }
                pInfo[playerid][dBuyingEditMenu] = 6;
				Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
            }
        }
    } else SetCarInside(playerid, pInfo[playerid][dModel], pInfo[playerid][dVehPrice], pInfo[playerid][dCam]);
    return true;
}

Dialog:SelectEditOptions(playerid, response, listitem, inputtext[]) {
    new string[1024], title[128];
    format(title, sizeof(title), "{FFFFFF}%s ({36A717}US$ %s{FFFFFF})", ReturnVehicleModelName(pInfo[playerid][dModel]), FormatNumber(GetVehicleFinalPrice(playerid)));
    if(response) {
        if(pInfo[playerid][dBuyingEditMenu] == 1) {
            switch(listitem){
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Nenhum\nAlarme Nível 1 - %s\nAlarme Nível 2 - %s\nAlarme Nível 3 - %s", FormatNumber(ALARM_PRICE_1), FormatNumber(ALARM_PRICE_2), FormatNumber(ALARM_PRICE_3));
                case 1: format(string, sizeof(string), "Nenhum\n{BBBBBB}>>> {FFFFFF}Alarme Nível 1 - %s\nAlarme Nível 2 - %s\nAlarme Nível 3 - %s", FormatNumber(ALARM_PRICE_1), FormatNumber(ALARM_PRICE_2), FormatNumber(ALARM_PRICE_3));
                case 2: format(string, sizeof(string), "Nenhum\nAlarme Nível 1 - %s\n{BBBBBB}>>> {FFFFFF}Alarme Nível 2 - %s\nAlarme Nível 3 - %s", FormatNumber(ALARM_PRICE_1), FormatNumber(ALARM_PRICE_2), FormatNumber(ALARM_PRICE_3));
                case 3: format(string, sizeof(string), "Nenhum\nAlarme Nível 1 - %s\nAlarme Nível 2 - %s\n{BBBBBB}>>> {FFFFFF}Alarme Nível 3 - %s", FormatNumber(ALARM_PRICE_1), FormatNumber(ALARM_PRICE_2), FormatNumber(ALARM_PRICE_3));
            }
            pInfo[playerid][dAlarm] = listitem;
            Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
        }
        else if(pInfo[playerid][dBuyingEditMenu] == 2) {
            switch(listitem){
               case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Nenhum\nSeguro Nível 1 - %s\nSeguro Nível 2 - %s\nSeguro Nível 3 - %s", FormatNumber((pInfo[playerid][dVehPrice]/100)*10), FormatNumber((pInfo[playerid][dVehPrice]/100)*20), FormatNumber((pInfo[playerid][dVehPrice]/100)*30));
                case 1: format(string, sizeof(string), "Nenhum\n{BBBBBB}>>> {FFFFFF}Seguro Nível 1 - %s\nSeguro Nível 2 - %s\nSeguro Nível 3 - %s", FormatNumber((pInfo[playerid][dVehPrice]/100)*10), FormatNumber((pInfo[playerid][dVehPrice]/100)*20), FormatNumber((pInfo[playerid][dVehPrice]/100)*30));
                case 2: format(string, sizeof(string), "Nenhum\nSeguro Nível 1 - %s\n{BBBBBB}>>> {FFFFFF}Seguro Nível 2 - %s\nSeguro Nível 3 - %s", FormatNumber((pInfo[playerid][dVehPrice]/100)*10), FormatNumber((pInfo[playerid][dVehPrice]/100)*20), FormatNumber((pInfo[playerid][dVehPrice]/100)*30));
                case 3: format(string, sizeof(string), "Nenhum\nSeguro Nível 1 - %s\nSeguro Nível 2 - %s\n{BBBBBB}>>> {FFFFFF}Seguro Nível 3 - %s", FormatNumber((pInfo[playerid][dVehPrice]/100)*10), FormatNumber((pInfo[playerid][dVehPrice]/100)*20), FormatNumber((pInfo[playerid][dVehPrice]/100)*30));
            }
            pInfo[playerid][dInsurance] = listitem;
            Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
        }
        else if(pInfo[playerid][dBuyingEditMenu] == 3) {
            switch(listitem){
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Sem emplacamento\nCom emplacamento - %s", FormatNumber(LEGALITY_PRICE_1));
                case 1: format(string, sizeof(string), "Sem emplacamento\n{BBBBBB}>>> {FFFFFF}Com emplacamento - %s", FormatNumber(LEGALITY_PRICE_1));
            }
            pInfo[playerid][dLegalized] = listitem;
            Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
        }
        else if(pInfo[playerid][dBuyingEditMenu] == 4) {
            switch(listitem){
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Sun Pass inativo\nSun Pass ativo - %s", FormatNumber(SUNPASS_PRICE_1));
                case 1: format(string, sizeof(string), "Sun Pass inativo\n{BBBBBB}>>> {FFFFFF}Sun Pass ativo - %s", FormatNumber(LEGALITY_PRICE_1));
            }
            pInfo[playerid][dSunpass] = listitem;
            Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
        }
        else if(pInfo[playerid][dBuyingEditMenu] == 5) {
            switch(listitem){
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Preto\nBranco\nAzul\nVermelho\nCinza");
                case 1: format(string, sizeof(string), "Preto\n{BBBBBB}>>> {FFFFFF}Branco\nAzul\nVermelho\nCinza");
                case 2: format(string, sizeof(string), "Preto\nBranco\n{BBBBBB}>>> {FFFFFF}Azul\nVermelho\nCinza");
                case 3: format(string, sizeof(string), "Preto\nBranco\nAzul\n{BBBBBB}>>> {FFFFFF}Vermelho\nCinza");
                case 4: format(string, sizeof(string), "Preto\nBranco\nAzul\nVermelho\n{BBBBBB}>>> {FFFFFF}Cinza");
            }
            pInfo[playerid][dColor1] = listitem;
            ChangeVehicleColours(pInfo[playerid][dBuyVehicle], pInfo[playerid][dColor1], pInfo[playerid][dColor2]);
            Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
        }
        else if(pInfo[playerid][dBuyingEditMenu] == 6) {
            switch(listitem){
                case 0: format(string, sizeof(string), "{BBBBBB}>>> {FFFFFF}Preto\nBranco\nAzul\nVermelho\nCinza");
                case 1: format(string, sizeof(string), "Preto\n{BBBBBB}>>> {FFFFFF}Branco\nAzul\nVermelho\nCinza");
                case 2: format(string, sizeof(string), "Preto\nBranco\n{BBBBBB}>>> {FFFFFF}Azul\nVermelho\nCinza");
                case 3: format(string, sizeof(string), "Preto\nBranco\nAzul\n{BBBBBB}>>> {FFFFFF}Vermelho\nCinza");
                case 4: format(string, sizeof(string), "Preto\nBranco\nAzul\nVermelho\n{BBBBBB}>>> {FFFFFF}Cinza");
            }
            pInfo[playerid][dColor2] = listitem;
            ChangeVehicleColours(pInfo[playerid][dBuyVehicle], pInfo[playerid][dColor1], pInfo[playerid][dColor2]);
            Dialog_Show(playerid, SelectEditOptions, DIALOG_STYLE_LIST, title, string, "Selecionar", "<<");
        }
    } else Dialog_Show(playerid, SelectEdit, DIALOG_STYLE_LIST, title, "Alarme\nSeguro\nLegalidade\nSun Pass\nCor 1\nCor 2", "Selecionar", "<<");
    return true;
}

Dialog:EditorCheckOutResponse(playerid, response, listitem, inputtext[]) {
	if (response){
        if(GetMoney(playerid) < GetVehicleFinalPrice(playerid)) {
            SendErrorMessage(playerid, "Você não possui US$ %s para comprar esse veículo.", FormatNumber(GetVehicleFinalPrice(playerid)));
            ResetDealershipVars(playerid);
            SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
            SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
            SetSpawnInfo(playerid, false, pInfo[playerid][pSkin], 
                pInfo[playerid][pPositionX], 
                pInfo[playerid][pPositionY], 
                pInfo[playerid][pPositionZ],
                pInfo[playerid][pPositionA],
                WEAPON_FIST, 0, 
                WEAPON_FIST, 0, 
                WEAPON_FIST, 0);
            SpawnPlayer(playerid);
            SetWeapons(playerid);
            return true;
        }
        new id, vaga = randomEx(0, 193);
		new Float:xcar, Float:ycar, Float:zcar, Float:acar;

        if(pInfo[playerid][dModel] == 450 || pInfo[playerid][dModel] == 584 || pInfo[playerid][dModel] == 591 || pInfo[playerid][dModel] == 435) {
			xcar = DealershipSpawns[vaga][e_PosX];
			ycar = DealershipSpawns[vaga][e_PosY];
			zcar = DealershipSpawns[vaga][e_PosZ]+3.0;
			acar = DealershipSpawns[vaga][e_PosA];
        } else {
            xcar = DealershipSpawns[vaga][e_PosX];
			ycar = DealershipSpawns[vaga][e_PosY];
			zcar = DealershipSpawns[vaga][e_PosZ];
			acar = DealershipSpawns[vaga][e_PosA];
        }

	    if(pInfo[playerid][dLegalized] == 0) format(pInfo[playerid][pBuyingPlate], 120, "Invalid");
        else if(pInfo[playerid][dLegalized] == 1) SetPlateFree(playerid);
    
        id = VehicleCreate(pInfo[playerid][pID], pInfo[playerid][dModel], xcar, ycar, zcar, acar, pInfo[playerid][dColor1], pInfo[playerid][dColor2], pInfo[playerid][pBuyingPlate], pInfo[playerid][dInsurance], pInfo[playerid][dSunpass], pInfo[playerid][dAlarm]);

        if(IsValidVehicle(pInfo[playerid][dBuyVehicle])) {
            DestroyVehicle(pInfo[playerid][dBuyVehicle]);
            pInfo[playerid][dBuyVehicle] = INVALID_VEHICLE_ID;
        }

        if (id == -1) {
            SendErrorMessage(playerid, "O servidor atingiu o limite de veiculos.");
            TogglePlayerControllable(playerid, false);
            SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
            SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
            SetSpawnInfo(playerid, false, pInfo[playerid][pSkin], 
                pInfo[playerid][pPositionX], 
                pInfo[playerid][pPositionY], 
                pInfo[playerid][pPositionZ],
                pInfo[playerid][pPositionA],
                WEAPON_FIST, 0, 
                WEAPON_FIST, 0, 
                WEAPON_FIST, 0);
            SpawnPlayer(playerid);
            SetWeapons(playerid);
            ResetDealershipVars(playerid);
            return true;
        } 

        GiveMoney(playerid, -GetVehicleFinalPrice(playerid));
        SetPlayerCheckpoint(playerid, xcar, ycar, zcar, 3.0);
    	SendClientMessage(playerid, COLOR_YELLOW, "SERVER: A sua vaga de estacionamento está localizada na Mulholland Intersection.");
        SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Um checkpoint foi criado com a localização.");

        format(logString, sizeof(logString), "%s (%s) comprou um(a) %s por US$ %s na concessionária", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleModelName(pInfo[playerid][dModel]), FormatNumber(GetVehicleFinalPrice(playerid)));
	    logCreate(playerid, logString, 16);

        TogglePlayerControllable(playerid, false);
        SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
        SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
        SetSpawnInfo(playerid, false, pInfo[playerid][pSkin], 
            pInfo[playerid][pPositionX], 
            pInfo[playerid][pPositionY], 
            pInfo[playerid][pPositionZ],
            pInfo[playerid][pPositionA],
            WEAPON_FIST, 0, 
            WEAPON_FIST, 0, 
            WEAPON_FIST, 0);
        SpawnPlayer(playerid);
        SetWeapons(playerid);
        ResetDealershipVars(playerid);
    } else {
        SendErrorMessage(playerid, "Você desistiu da compra.");
        ResetDealershipVars(playerid);
        SetPlayerVirtualWorld(playerid, pInfo[playerid][pVirtualWorld]);
		SetPlayerInterior(playerid, pInfo[playerid][pInterior]);
	    SetSpawnInfo(playerid, false, pInfo[playerid][pSkin], 
            pInfo[playerid][pPositionX], 
            pInfo[playerid][pPositionY], 
            pInfo[playerid][pPositionZ],
            pInfo[playerid][pPositionA],
            WEAPON_FIST, 0, 
            WEAPON_FIST, 0, 
            WEAPON_FIST, 0);
        SpawnPlayer(playerid);
        SetWeapons(playerid);
    }
    return true;
}

public OnVehicleStreamIn(vehicleid, forplayerid) {
	if(IsValidVehicle(pInfo[forplayerid][dBuyVehicle])) {
		if(vehicleid == pInfo[forplayerid][dBuyVehicle]) {
            // Grotti
        	if(GetPlayerVirtualWorld(forplayerid) == forplayerid+1000) {
				PutPlayerInVehicle(forplayerid, pInfo[forplayerid][dBuyVehicle], 0);
                InterpolateCameraPos(forplayerid, 541.752685, -1278.650634, 26.411600, 550.738769, -1265.103027, 16.965684, 3000);
                InterpolateCameraLookAt(forplayerid, 540.849304, -1283.567260, 26.517061, 551.438171, -1270.032470, 17.425970, 3000);
			}
            // Coutt And Schutz
        	else if(GetPlayerVirtualWorld(forplayerid) == forplayerid+2000) {
				PutPlayerInVehicle(forplayerid, pInfo[forplayerid][dBuyVehicle], 0);
                InterpolateCameraPos(forplayerid, 2115.999755, -1136.640747, 30.675525, 2119.390625, -1122.038940, 25.275941, 3000);
                InterpolateCameraLookAt(forplayerid, 2119.793212, -1139.496582, 29.108930, 2121.748535, -1126.444580, 25.451234, 3000);
			}
            // Aeroporto
			else if(GetPlayerVirtualWorld(forplayerid) == forplayerid+5000) {
				PutPlayerInVehicle(forplayerid, pInfo[forplayerid][dBuyVehicle], 0);
	        	SetPlayerCameraPos(forplayerid, 1925.9956, -2284.3994, 14.2212);
				SetPlayerCameraLookAt(forplayerid, 1925.0631, -2284.7654, 14.2113);
			}
            // Marina
			else if(GetPlayerVirtualWorld(forplayerid) == forplayerid+6000) {
				PutPlayerInVehicle(forplayerid, pInfo[forplayerid][dBuyVehicle], 0);
	        	SetPlayerCameraPos(forplayerid, 728.2611, -1680.6938, 2.9265);
				SetPlayerCameraLookAt(forplayerid, 727.8109, -1681.5879, 2.7616);
			}
		}
	}
	return true;
}

GetAlarmPrice(playerid) {
    new price;
    switch(pInfo[playerid][dAlarm]){
        case 1: price = ALARM_PRICE_1;
        case 2: price = ALARM_PRICE_2;
        case 3: price = ALARM_PRICE_3;
        default: price = 0;
    }
    return price;
}

GetInsurancePrice(playerid) {
    new price;
    switch(pInfo[playerid][dInsurance]){
        case 1: price = (pInfo[playerid][dVehPrice]/100)*10;
        case 2: price = (pInfo[playerid][dVehPrice]/100)*20;
        case 3: price = (pInfo[playerid][dVehPrice]/100)*30;
        default: price = 0;
    }
    return price;
}

GetSunpassPrice(playerid) {
    new price;
    switch(pInfo[playerid][dSunpass]){
        case 1: price = SUNPASS_PRICE_1;
        default: price = 0;
    }
    return price;
}

GetLegalityPrice(playerid) {
    new price;
    switch(pInfo[playerid][dLegalized]){
        case 1: price = LEGALITY_PRICE_1;
        default: price = 0;
    }
    return price;
}

GetVehicleFinalPrice(playerid) {
	new price;

    price = pInfo[playerid][dVehPrice] + GetLegalityPrice(playerid) + GetSunpassPrice(playerid) + GetInsurancePrice(playerid) + GetAlarmPrice(playerid);
	return price;
}

ResetDealershipVars(playerid) {
    if(IsValidVehicle(pInfo[playerid][dBuyVehicle])) {
        DestroyVehicle(pInfo[playerid][dBuyVehicle]);
        pInfo[playerid][dBuyVehicle] = INVALID_VEHICLE_ID;
    }
	    	
    pInfo[playerid][dModel] =
    pInfo[playerid][dVehPrice] =
    pInfo[playerid][dAlarm] =
    pInfo[playerid][dInsurance] =
    pInfo[playerid][dSunpass] =
    pInfo[playerid][dLegalized] = 
    pInfo[playerid][dColor1] = 
    pInfo[playerid][dColor2] =
    pInfo[playerid][dBuyingEditMenu] =
    pInfo[playerid][dCam] =
    pInfo[playerid][dFinalPrice] = 0;

    pInfo[playerid][pBuyingPlate][0] = EOS;
    return true;
}