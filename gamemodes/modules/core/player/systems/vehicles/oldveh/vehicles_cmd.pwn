#include <YSI_Coding\y_hooks>

// ADMIN COMMANDS
CMD:darveiculo(playerid, params[]) {
	static
		userid,
	    model[32];

    
	if(GetPlayerAdmin(playerid) < 4) return SendPermissionMessage(playerid);

	if (sscanf(params, "us[32]", userid, model)) return SendSyntaxMessage(playerid, "/darveiculo [id/nome] [id do modelo/nome]");

	if (GetPlayerAdmin(playerid) < 1337 && Car_GetCount(userid) >= MAX_OWNABLE_CARS) return SendErrorMessage(playerid, "Este jogador já possui %d veículos(quantidade máxima).", MAX_OWNABLE_CARS);

    if ((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "O ID do modelo especificado é inválido.");

	static
	    Float:x,
		Float:y,
		Float:z,
		Float:angle,
		id = -1;

    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, angle);
	SetPlateFree(playerid);

	id = Car_Create(pInfo[userid][pID], model[0], x, y + 2, z + 1, angle, random(127), random(127), 0, 0, 0, 0, 0, pInfo[playerid][pBuyingPlate]);

	if (id == -1)
	    return SendErrorMessage(playerid, "O servidor chegou ao limite máximo de veículos dinâmicos.");

	SendServerMessage(playerid, "Você criou o veículo de ID: %d para %s.", CarData[id][carVehicle], pNome(userid));

	SendClientMessage(userid, COLOR_LIGHTGREEN, "PROCESSANDO: Reorganizando sua lista de veiculos...");
	SetTimerEx("AdaptandoLista", 1000, false, "d", userid);

    format(logString, sizeof(logString), "%s (%s) deu o veículo %s para %s.", pNome(playerid), GetPlayerUserEx(playerid), ReturnVehicleName(CarData[id][carVehicle]), pNome(userid));
	logCreate(playerid, logString, 1);

	return true;
}

// VEHICLE COMMANDS
CMD:v(playerid, params[]){
    new type[128], string[2048];

    if (sscanf(params, "s[128]S()[64]", type, string)) {
        SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	 	SendClientMessage(playerid, COLOR_BEGE, "USE: /v [parâmetro]");
		SendClientMessage(playerid, COLOR_BEGE, "[Parâmetros]: lista, estacionar, mudarvaga, trancar");
		SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
        return true;
    }
    else if (!strcmp(type, "lista", true)) 
        return ListPlayerVehicle(playerid);
    else if (!strcmp(type, "estacionar", true))
 		return ParkPlayerVehicle(playerid);
 	else if (!strcmp(type, "mudarvaga", true))
	    return CarBuyPark(playerid);
	else if (!strcmp(type, "trancar", true))
 		return SetVehicleLock(playerid);

    return true;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if (dialogid == 9998) {
        if(response) {
            new id = CheckCountVehicle(playerid);

            if(id >= pInfo[playerid][pSpawnVehicle])
                return SendErrorMessage(playerid, "Você atingiu o limite de veiculos spawnados ao mesmo tempo. (Seu limite de spawn é %d veiculo(s))", pInfo[playerid][pSpawnVehicle]);

            if (pInfo[playerid][pTimerSpawn] > 0)
                return va_SendClientMessage(playerid, COLOR_LIGHTRED, "Aguarde... faltam %d segundos para utilizar esse comando novamente.", pInfo[playerid][pTimerSpawn]);

            new count = 0;

            for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) {
                if(CarData[i][carExists] && Car_IsOwner(playerid, i)) {
                    if(count == listitem) {
                        if(CarData[i][carVehicle]) {
                            SendErrorMessage(playerid, "Este veiculo já está spawnado.");
                            break;
                        }

                        if(CarData[i][carImpounded] != -1) {
                            CarData[i][carParkTime] = -1;

                            Car_Spawn(i);

                            if(CarData[i][carHealth] == 0) {
                                CarData[i][carHealth] = 300;
                                CarData[i][carHealthUpdate] = 300;
                            }
                            if(CarData[i][carInsurance] >= 1) {
                                if(CarData[i][carHealth] == 0) {
                                    CarData[i][carHealth] = 1000;
                                    CarData[i][carHealthUpdate] = 1000;
                                }
                            }

                            CoreVehicles[CarData[i][carVehicle]][vehFuel] = CarData[i][carFuel];
                            SetVehicleHealth(CarData[i][carVehicle], CarData[i][carHealth]);
                            CarData[i][carHealthUpdate] = CarData[i][carHealth];
                            va_SendClientMessage(playerid, COLOR_GREEN, "%s foi spawnado no local onde você estacionou:", ReturnVehicleModelName(CarData[i][carModel]));

                            if(CarData[i][carModel] == 481 || CarData[i][carModel] == 509 || CarData[i][carModel] == 510)
                                va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Engrenagem[%.2f], Milhas Rodadas[%.1f]", CarData[i][carEngine], CarData[i][carMiles]);
                            else
                                va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Motor[%.2f], Bateria[%.2f], Milhas Rodadas[%.1f]", CarData[i][carEngine], CarData[i][carBattery], CarData[i][carMiles]);

                            if(CarData[i][carVW] == 0) {
                                va_SendClientMessage(playerid, 0xFF00FFFF, "Info: Você pode usar a marca vermelha no mapa para achar seu veiculo.");
                                SetPlayerCheckpoint(playerid, CarData[i][carPos][0], CarData[i][carPos][1], CarData[i][carPos][2], 3.0);
                            }

                            pInfo[playerid][pSpawnVeh] = 1;
                            
                            GetVehiclePos(CarData[i][carVehicle], CoreVehicles[CarData[i][carVehicle]][MilesPos][0], CoreVehicles[CarData[i][carVehicle]][MilesPos][1], CoreVehicles[CarData[i][carVehicle]][MilesPos][2]);
                            
                            SetVehicleVelocity(CarData[i][carVehicle], 0, 0, 0);

                            pInfo[playerid][pTimerSpawn] = 5;
                
                        } else {
                            CarData[i][carParkTime] = -1;

                            Car_Spawn(i);

                            if(CarData[i][carHealth] == 0)
                            {
                                CarData[i][carHealth] = 300;
                                CarData[i][carHealthUpdate] = 300;
                            }
                            if(CarData[i][carInsurance] >= 1)
                            {
                                if(CarData[i][carHealth] == 0)
                                {
                                    CarData[i][carHealth] = 1000;
                                    CarData[i][carHealthUpdate] = 1000;
                                }
                            }

                            CoreVehicles[CarData[i][carVehicle]][vehFuel] = CarData[i][carFuel];
                            SetVehicleHealth(CarData[i][carVehicle], CarData[i][carHealth]);
                            CarData[i][carHealthUpdate] = CarData[i][carHealth];
                            va_SendClientMessage(playerid, COLOR_GREEN, "%s foi spawnado no local onde você estacionou:", ReturnVehicleModelName(CarData[i][carModel]));

                            if(CarData[i][carModel] == 481 || CarData[i][carModel] == 509 || CarData[i][carModel] == 510)
                                va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Engrenagem[%.2f], Milhas Rodadas[%.1f]", CarData[i][carEngine], CarData[i][carMiles]);
                            else
                                va_SendClientMessage(playerid, COLOR_WHITECYAN, "Vida útil: Motor[%.2f], Bateria[%.2f], Milhas Rodadas[%.1f]", CarData[i][carEngine], CarData[i][carBattery], CarData[i][carMiles]);

                            if(CarData[i][carVW] == 0)
                            {
                                va_SendClientMessage(playerid, 0xFF00FFFF, "Info: Você pode usar a marca vermelha no mapa para achar seu veiculo.");
                                SetPlayerCheckpoint(playerid, CarData[i][carPos][0], CarData[i][carPos][1], CarData[i][carPos][2], 3.0);
                            }

                            pInfo[playerid][pSpawnVeh] = 1;
                            
                            GetVehiclePos(CarData[i][carVehicle], CoreVehicles[CarData[i][carVehicle]][MilesPos][0], CoreVehicles[CarData[i][carVehicle]][MilesPos][1], CoreVehicles[CarData[i][carVehicle]][MilesPos][2]);
                            
                            SetVehicleVelocity(CarData[i][carVehicle], 0, 0, 0);

                            pInfo[playerid][pTimerSpawn] = 5;
                        
                        }
                    }
                    else 
                        count++;
                }
            }
        }
        return true;
    }
    return true;
}

// CORE COMMANDS
CMD:motor(playerid, params[]) {
	static id;
	new vehicleid;
	new string[64];
	vehicleid = GetPlayerVehicleID(playerid);
	id = Car_GetID(vehicleid);

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você deve ser o motorista para ligar ou desligar o veículo.");

	if (GetPVarType(playerid, "EditObjectSiren") != PLAYER_VARTYPE_NONE && GetPVarType(playerid, "EditVehicleSiren") != PLAYER_VARTYPE_NONE)
		return SendErrorMessage(playerid, "Você não pode ligar o motor enquanto estiver configurando uma sirene.");

	new model = GetVehicleModel(vehicleid);

	if(model == 481 || model == 509 || model == 510){
		SendErrorMessage(playerid, "Este veiculo não possui motor.");
		SetEngineStatus(vehicleid, true);
		return true;
	}

	if(GetEngineStatus(vehicleid)){
	    SetEngineStatus(vehicleid, false);
    	//SetLightStatus(vehicleid, false);
		format(string, sizeof(string), "~r~MOTOR DESLIGADO");
	    GameTextForPlayer(playerid, string, 2500, 4);
	    return true;
	}


	if (CoreVehicles[vehicleid][vehFuel] < 1.0)
	    return SendErrorMessage(playerid, "O tanque de combustível está vazio.");

	if (ReturnVehicleHealth(vehicleid) <= 300)
	    return SendErrorMessage(playerid, "Este veículo está danificado e não pode ser ligado.");

	/*if (pInfo[playerid][pRefill] == vehicleid)
	    return SendErrorMessage(playerid, "Você não pode ligar o veiculo enquanto estiver abastecendo.");*/

	//if ((pInfo[playerid][pJob] == JOB_UNLOADER && GetVehicleModel(vehicleid) == 530 || pInfo[playerid][pJob] == JOB_GARBAGE && GetVehicleModel(vehicleid) == 408))
        //return Vehicle_Turn(playerid, vehicleid);

	if (Car_IsOwner(playerid, id))
	{
	    if(CarData[id][carFaction] != 0){
	        CarData[id][carBattery] = 100.000;
	        CarData[id][carBattery] = 100.000;
	    }

		if(CarData[id][carBattery] > 5.000){
			switch (GetEngineStatus(vehicleid)){
	    		case false:{
	    	    	SetEngineStatus(vehicleid, true);
	        		format(string, sizeof(string), "~g~MOTOR LIGADO");
	        		GameTextForPlayer(playerid, string, 2500, 4);
	        		if(CarData[id][carBattery] > 0.001){
	        			CarData[id][carBattery] -= 0.001;
					}
	        		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s insere a chave na ignição e liga o motor.", pNome(playerid));
				}
				case true:{
		    		SetEngineStatus(vehicleid, false);
		    		format(string, sizeof(string), "~r~MOTOR DESLIGADO");
	        		GameTextForPlayer(playerid, string, 2500, 4);
	        		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s gira a chave na ignição e desliga o motor.", pNome(playerid));
				}
			}
		} else {
			switch (GetEngineStatus(vehicleid))
			{
				case false:
	    		{
					new randomex;
					randomex = random(6);
					switch(randomex) {
					    case 1,3,5: {
	    	    			SetEngineStatus(vehicleid, true);
	        				format(string, sizeof(string), "~g~MOTOR LIGADO");
	        				GameTextForPlayer(playerid, string, 2500, 4);
	        				if(CarData[id][carBattery] > 0.001)
	        				{
	        					CarData[id][carBattery] -= 0.001;
							}
							SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s insere a chave na ignição e liga o motor.", pNome(playerid));
						}
						default: {
						    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s insere a chave na ignição e tenta ligar o motor, porém sem sucesso.", pNome(playerid));
						}
					}
				}
				case true:
				{
		    		SetEngineStatus(vehicleid, false);
		    		format(string, sizeof(string), "~r~MOTOR DESLIGADO");
	        		GameTextForPlayer(playerid, string, 2500, 4);
	        		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s gira a chave na ignição e desliga o motor.", pNome(playerid));
				}
			}
		}
		return true;
	}
	return true;
}

CMD:luzes(playerid, params[]) {
	new vehicleid = GetPlayerVehicleID(playerid);
	if (!IsEngineVehicle(vehicleid)) return SendErrorMessage(playerid, "Você não está em nenhum veículo.");
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Você deve ser o motorista para ligar as luzes do veículo.");

	switch (GetLightStatus(vehicleid)) {
	    case false:
	    {
	        SetLightStatus(vehicleid, true);
         	GameTextForPlayer(playerid, "Luzes Ligadas", 2400, 4);
		}
		case true:
		{
		    SetLightStatus(vehicleid, false);
		    GameTextForPlayer(playerid, "Luzes Desligadas", 2400, 4);
		}
	}
	return true;
}

CMD:capo(playerid, params[]) {
	for (new i = 1; i != GetVehiclePoolSize()+1; i ++) if (IsValidVehicle(i) && IsPlayerNearHood(playerid, i))
	{
	    if (!IsDoorVehicle(i))
	        return SendErrorMessage(playerid, "Este veículo não possui capô.");

	    if (!GetHoodStatus(i)){
	        SetHoodStatus(i, true);
	        GameTextForPlayer(playerid, "Capo Aberto", 2400, 4);
		}else{
			SetHoodStatus(i, false);
	        GameTextForPlayer(playerid, "Capo Fechado", 2400, 4);
		}
	    return true;
	}
	SendErrorMessage(playerid, "Você não está próximo de nenhum veículo.");
	return true;
}

CMD:janela(playerid, params[]) {
    if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Você não está dentro de um veículo.");
    if(!IsDoorVehicle(GetPlayerVehicleID(playerid))) return SendErrorMessage(playerid, "Este veículo não possui janelas.");

    new
        windowOption[20],
        vehicleid = GetPlayerVehicleID(playerid),
        seat = GetPlayerVehicleSeat(playerid),
        driver,
        passenger,
        backleft,
        backright,
		string[128];

    if(sscanf(params, "S(mine)[20]", windowOption)){
        return true;
    }

    GetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright);

    if(!strcmp(windowOption, "mine", true)){
        switch(seat){
            case 0:{ //Motorista
                if(driver != 0){
                    SetVehicleParamsCarWindows(vehicleid, 0, passenger, backleft, backright);
                    CoreVehicles[vehicleid][vehWindowsDown] = true;
                    format(string, sizeof(string), "* %s abaixa a sua janela.", pNome(playerid), params);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
					va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa a sua janela.", pNome(playerid));

                    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
	 				SendClientMessage(playerid, COLOR_BEGE, "USE: /janela [opção]");
	 				SendClientMessage(playerid, COLOR_BEGE, "[Opções]: todas, frenteesquerda(fe), frentedireita(fd), trasesquerda(te), trasdireita(td)");
                    SendClientMessage(playerid, COLOR_BEGE, "* O motorista do veículo pode utilizar parâmetros extras para controlar todas as janelas do veículo.");
                    SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
		        } else {
                    SetVehicleParamsCarWindows(vehicleid, 1, passenger, backleft, backright);
					CoreVehicles[vehicleid][vehWindowsDown] = false;

					format(string, sizeof(string), "* %s levanta a sua janela.", pNome(playerid), params);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
					va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta a sua janela.", pNome(playerid));
                }
            }
            case 1:{ //Passageiro
                if(passenger != 0){
                    SetVehicleParamsCarWindows(vehicleid, driver, 0, backleft, backright);
                    CoreVehicles[vehicleid][vehWindowsDown] = true;
					format(string, sizeof(string), "* %s abaixa a sua janela.", pNome(playerid), params);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
					va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa a sua janela.", pNome(playerid));
                } else {
                    SetVehicleParamsCarWindows(vehicleid, driver, 1, backleft, backright);
                    CoreVehicles[vehicleid][vehWindowsDown] = false;
					format(string, sizeof(string), "* %s levanta a sua janela.", pNome(playerid), params);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
					va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta a sua janela.", pNome(playerid));
                }
            }
            case 2:{ //Traseiro Esquerdo
                if(backleft != 0){
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, 0, backright);
                    CoreVehicles[vehicleid][vehWindowsDown] = true;
                    format(string, sizeof(string), "* %s abaixa a sua janela.", pNome(playerid), params);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
					va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa a sua janela.", pNome(playerid));
                } else {
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, 1, backright);
                    CoreVehicles[vehicleid][vehWindowsDown] = false;
                    format(string, sizeof(string), "* %s levanta a sua janela.", pNome(playerid), params);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
					va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta a sua janela.", pNome(playerid));
                }
            }
            case 3:{ //Traseiro Direito
                if(backright != 0){
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 0);
                    CoreVehicles[vehicleid][vehWindowsDown] = true;
                    format(string, sizeof(string), "* %s abaixa a sua janela.", pNome(playerid), params);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
					va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa a sua janela.", pNome(playerid));
                } else {
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 1);
					CoreVehicles[vehicleid][vehWindowsDown] = false;
                    format(string, sizeof(string), "* %s levanta a sua janela.", pNome(playerid), params);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
					va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta a sua janela.", pNome(playerid));
                }
            }
            default:{
                SendErrorMessage(playerid, "Você não pode abrir esta janela.");
            }
        }
    } else if(!strcmp(windowOption, "frenteesquerda", true) || !strcmp(windowOption, "fe", true)){
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar parâmetros adicionais.");

        if(driver != 0){
            SetVehicleParamsCarWindows(vehicleid, 0, passenger, backleft, backright);
            CoreVehicles[vehicleid][vehWindowsDown] = true;
			format(string, sizeof(string), "* %s abaixa a janela dianteira esquerda.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa a janela dianteira esquerda.", pNome(playerid));
        } else {
            SetVehicleParamsCarWindows(vehicleid, 1, passenger, backleft, backright);
			CoreVehicles[vehicleid][vehWindowsDown] = false;
			format(string, sizeof(string), "* %s levanta a janela dianteira esquerda.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta a janela dianteira esquerda.", pNome(playerid));
        }
    } else if(!strcmp(windowOption, "frentedireita", true) || !strcmp(windowOption, "fd", true)){
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar parâmetros adicionais.");

        if(passenger != 0){
            SetVehicleParamsCarWindows(vehicleid, driver, 0, backleft, backright);
            CoreVehicles[vehicleid][vehWindowsDown] = true;
			format(string, sizeof(string), "* %s abaixa a janela dianteira direita.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa a janela dianteira direita.", pNome(playerid));
        } else {
            SetVehicleParamsCarWindows(vehicleid, driver, 1, backleft, backright);
			CoreVehicles[vehicleid][vehWindowsDown] = false;
			format(string, sizeof(string), "* %s levanta a janela dianteira direita.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta a janela dianteira direita.", pNome(playerid));
        }
    } else if(!strcmp(windowOption, "trasesquerda", true) || !strcmp(windowOption, "te", true)){
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar parâmetros adicionais.");

        if(backleft != 0){
            SetVehicleParamsCarWindows(vehicleid, driver, passenger, 0, backright);
            CoreVehicles[vehicleid][vehWindowsDown] = true;

			format(string, sizeof(string), "* %s abaixa a janela traseira esquerda.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa a janela traseira esquerda.", pNome(playerid));
        } else {
            SetVehicleParamsCarWindows(vehicleid, driver, passenger, 1, backright);
            CoreVehicles[vehicleid][vehWindowsDown] = false;

			format(string, sizeof(string), "* %s levanta a janela traseira esquerda.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta a janela traseira esquerda.", pNome(playerid));
        }
    } else if(!strcmp(windowOption, "trasdireita", true) || !strcmp(windowOption, "td", true)){
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar parâmetros adicionais.");

        if(backright != 0){
            SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 0);
            CoreVehicles[vehicleid][vehWindowsDown] = true;

			format(string, sizeof(string), "* %s abaixa a janela traseira direita.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa a janela traseira direita.", pNome(playerid));
        } else {
            SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 1);
            CoreVehicles[vehicleid][vehWindowsDown] = false;

			format(string, sizeof(string), "* %s levanta a janela traseira direita.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta a janela traseira direita.", pNome(playerid));
        }
    } else if(!strcmp(windowOption, "todas", true)){
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar parâmetros adicionais.");

        if(driver != 0 || passenger != 0 || backleft != 0 || backright != 0){
            SetVehicleParamsCarWindows(vehicleid, 0, 0, 0, 0);
            CoreVehicles[vehicleid][vehWindowsDown] = true;

			format(string, sizeof(string), "* %s abaixa todas as janelas.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s abaixa todas as janelas.", pNome(playerid));
        } else {
            SetVehicleParamsCarWindows(vehicleid, 1, 1, 1, 1);
			CoreVehicles[vehicleid][vehWindowsDown] = false;

			format(string, sizeof(string), "* %s levanta todas as janelas.", pNome(playerid), params);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 40.0, 15000);
			va_SendClientMessage(playerid, COLOR_PURPLE, "> %s levanta todas as janelas.", pNome(playerid));
        }
    } else {
        SendErrorMessage(playerid, "Você digitou um parâmetro inválido.");
    }
    return true;
}