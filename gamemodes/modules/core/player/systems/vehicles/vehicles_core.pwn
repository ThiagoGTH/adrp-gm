#include <YSI_Coding\y_hooks>


// COMANDOS
CMD:janela(playerid, params[]){
    if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Voc� n�o est� dentro de um ve�culo.");
    if(!IsDoorVehicle(GetPlayerVehicleID(playerid))) return SendErrorMessage(playerid, "Este ve�culo n�o possui janelas.");

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
	 				SendClientMessage(playerid, COLOR_BEGE, "USE: /janela [op��o]");
	 				SendClientMessage(playerid, COLOR_BEGE, "[Op��es]: todas, frenteesquerda(fe), frentedireita(fd), trasesquerda(te), trasdireita(td)");
                    SendClientMessage(playerid, COLOR_BEGE, "* O motorista do ve�culo pode utilizar par�metros extras para controlar todas as janelas do ve�culo.");
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
                SendErrorMessage(playerid, "Voc� n�o pode abrir esta janela.");
            }
        }
    } else if(!strcmp(windowOption, "frenteesquerda", true) || !strcmp(windowOption, "fe", true)){
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar par�metros adicionais.");

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
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar par�metros adicionais.");

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
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar par�metros adicionais.");

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
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar par�metros adicionais.");

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
            return SendErrorMessage(playerid, "Apenas o motorista pode utilizar par�metros adicionais.");

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
        SendErrorMessage(playerid, "Voc� digitou um par�metro inv�lido.");
    }

    return true;
}