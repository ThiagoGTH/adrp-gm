#include <YSI_Coding\y_hooks>

#define     HTTP_IP_API_URL			"ip-api.com/csv"
#define     HTTP_IP_API_END         "?fields=country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,reverse,query,status,message"
#define     HTTP_VPN_API_URL        "check.getipintel.net/check.php?contact=thiagogth13@gmail.com&ip="

enum dox_PlayerInfo
{
	Status[64],
	Country[64],
	CountryCode[64],
	Region[64],
	RegionName[64],
	City[64],
	Zip[64],
	Lat[64],
	Lon[64],
	TimeZone[64],
	Isp[64],
	Org[64],
	As[64],
	Reverse[64],
	IP[16],
};

new dPlayerInfo[MAX_PLAYERS][dox_PlayerInfo];
new targetID[MAX_PLAYERS];

hook OnPlayerConnect(playerid){
	targetID[playerid] = INVALID_PLAYER_ID;
	return false;
}

forward HttpVPNInfo(playerid, response_code, data[]);
public HttpVPNInfo(playerid, response_code, data[]){
    new vpnMessage[64], sdialog[512];
    
    if(response_code == 200 || response_code == 400) {
    	new Float:isVPN = floatstr(data);
	 	
	 	if(isVPN < 0) {
	 	    new tmp = floatround(isVPN);
	 	    
			switch(tmp) {
			    case -1: {
			        format(vpnMessage, sizeof(vpnMessage), "{F74222}ERRO (Sem entrada válida)");
			    }
			    case -2: {
			        format(vpnMessage, sizeof(vpnMessage), "{F74222}ERRO (IP inválido)");
			    }
			    case -3: {
			        format(vpnMessage, sizeof(vpnMessage), "{F74222}ERRO (Sem rota / IP privado)");
			    }
			    case -4: {
			        format(vpnMessage, sizeof(vpnMessage), "{F74222}ERRO (Não foi possível conectar a DB)");
			    }
			    case -5: {
			        format(vpnMessage, sizeof(vpnMessage), "{F74222}ERRO (IP original banido)");
			    }
			    case -6: {
			        format(vpnMessage, sizeof(vpnMessage), "{F74222}ERRO (Dados inválidos)");
			    }
				default: {
				    format(vpnMessage, sizeof(vpnMessage), "{F74222}ERRO (Cod: %d) (Data: %d)", response_code, tmp);
				}
			}
	 	}
		
	 	else if(isVPN == 0) {
       		format(vpnMessage, sizeof(vpnMessage), "{00FF00}Negativo");
	 	}
	 	else if(isVPN > 0 && isVPN < 0.6) {
	 	    format(vpnMessage, sizeof(vpnMessage), "{209120}Provavelmente não");
		}
		else if(isVPN >= 0.6 && isVPN < 0.8) {
		    format(vpnMessage, sizeof(vpnMessage), "{E8A42E}Talvez");
		}
		else if(isVPN >= 0.8 && isVPN < 1) {
		    format(vpnMessage, sizeof(vpnMessage), "{F7752F}Provavelmente sim");
		}
		else if(isVPN >= 1) {
		    format(vpnMessage, sizeof(vpnMessage), "{FF0000}Positivo");
		}
    }
    else {
        format(vpnMessage, sizeof(vpnMessage), "{F74222}ERRO (%d)", response_code);
    }
    
	format(sdialog, sizeof(sdialog),
	"Index\tValue\n\
	Status\t%s\n\
	IP\t%s\n\
	DNS\t%s\n\
	Hostname\t%s\n\
	Cidade\t%s\n\
	País\t%s\n\
	Código do País\t%s\n\
	ISP\t%s\n\
	Latitude\t%s\n\
	Longitude\t%s\n\
	Fuso horário\t%s\n\
	Org\t%s\n\
	Região ID\t%s\n\
	Região\t%s\n\
	Código Postal\t%s\n\
	VPN/Proxy\t%s",
	dPlayerInfo[targetID[playerid]][Status],
	dPlayerInfo[targetID[playerid]][IP],
	dPlayerInfo[targetID[playerid]][Reverse],
	dPlayerInfo[targetID[playerid]][As],
	dPlayerInfo[targetID[playerid]][City],
	dPlayerInfo[targetID[playerid]][Country],
	dPlayerInfo[targetID[playerid]][CountryCode],
	dPlayerInfo[targetID[playerid]][Isp],
	dPlayerInfo[targetID[playerid]][Lat],
	dPlayerInfo[targetID[playerid]][Lon],
	dPlayerInfo[targetID[playerid]][TimeZone],
	dPlayerInfo[targetID[playerid]][Org],
	dPlayerInfo[targetID[playerid]][Region],
	dPlayerInfo[targetID[playerid]][RegionName],
	dPlayerInfo[targetID[playerid]][Zip],
	vpnMessage);
	new stitle[128];
	format(stitle, sizeof(stitle),
	"IP de %s (%s)", pNome(targetID[playerid]), GetPlayerUserEx(targetID[playerid]));

	Dialog_Show(playerid, DIALOG_IP_CHECK, DIALOG_STYLE_TABLIST_HEADERS, stitle, sdialog, "Fechar", "");
    return true;
}


forward HttpIPInfo(playerid, response_code, data[]);
public HttpIPInfo(playerid, response_code, data[]){
    if(response_code == 200) {
    	new output[14][64], string[160];
    	
    	strexplode(output, data, ",");
    	
		dPlayerInfo[targetID[playerid]][Status] = output[0];
		
		if(strfind(output[0], "sucess")) {
		    format(dPlayerInfo[targetID[playerid]][Status], 64, "{00FF00}Sucesso");
		}
		else {
		    format(dPlayerInfo[targetID[playerid]][Status], 64, "{F74222}Erro");
		}
		
		dPlayerInfo[targetID[playerid]][Country] = output[1];
		dPlayerInfo[targetID[playerid]][CountryCode] = output[2];
		dPlayerInfo[targetID[playerid]][Region] = output[3];
		dPlayerInfo[targetID[playerid]][RegionName] = output[4];
		dPlayerInfo[targetID[playerid]][City] = output[5];
		dPlayerInfo[targetID[playerid]][Zip] = output[6];
		dPlayerInfo[targetID[playerid]][Lat] = output[7];
		dPlayerInfo[targetID[playerid]][Lon] = output[8];
		dPlayerInfo[targetID[playerid]][TimeZone] = output[9];
		dPlayerInfo[targetID[playerid]][Isp] = output[10];
		dPlayerInfo[targetID[playerid]][Org] = output[11];
		dPlayerInfo[targetID[playerid]][As] = output[12];
		dPlayerInfo[targetID[playerid]][Reverse] = output[13];
		
		RemoveChars(targetID[playerid]);

		format(string, sizeof(string), "%s%s", HTTP_VPN_API_URL, dPlayerInfo[targetID[playerid]][IP]);
		HTTP(playerid, HTTP_GET, string, "", "HttpVPNInfo");
    } else {
        va_SendClientMessage(playerid, COLOR_GREY, "ERRO: Não foi possível obter informações desse IP. (Cod: %d) (%s)", response_code, data);
    }

    return true;
}

RemoveChars(tID){
    strreplace(dPlayerInfo[tID][Country], "\"", "");
    strreplace(dPlayerInfo[tID][CountryCode], "\"", "");
    strreplace(dPlayerInfo[tID][Region], "\"", "");
    strreplace(dPlayerInfo[tID][RegionName], "\"", "");
    strreplace(dPlayerInfo[tID][City], "\"", "");
    strreplace(dPlayerInfo[tID][Zip], "\"", "");
    strreplace(dPlayerInfo[tID][Lat], "\"", "");
    strreplace(dPlayerInfo[tID][Lon], "\"", "");
    strreplace(dPlayerInfo[tID][TimeZone], "\"", "");
    strreplace(dPlayerInfo[tID][Isp], "\"", "");
    strreplace(dPlayerInfo[tID][Org], "\"", "");
    strreplace(dPlayerInfo[tID][As], "\"", "");
    strreplace(dPlayerInfo[tID][Reverse], "\"", "");
    
	return true;
}

CMD:checarip(playerid, params[]){
	if(uInfo[playerid][uAdmin] < 3) return SendPermissionMessage(playerid);
	if(uInfo[playerid][uAdmin] == 5000) return SendErrorMessage(playerid, "Desativado para beta-testers.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendSyntaxMessage(playerid, "/checarip [playerid/nome]");
  	if(!IsPlayerConnected(targetid)) return SendErrorMessage(playerid, "Este jogador não está online.");
		
	new string[160], playerIP[16];
	targetID[playerid] = targetid;
	GetPlayerIp(targetid, playerIP, sizeof(playerIP));
  	format(dPlayerInfo[targetid][IP], 16, playerIP);
	format(string, sizeof(string), "%s/%s%s", HTTP_IP_API_URL, playerIP, HTTP_IP_API_END);
	HTTP(playerid, HTTP_GET, string, "", "HttpIPInfo");
  	SendServerMessage(playerid, "Recebendo informações de %s [%s]", pNome(targetid), playerIP);

	format(logString, sizeof(logString), "%s (%s) checou o IP de %s [%s]", pNome(playerid), GetPlayerUserEx(playerid), pNome(targetid), playerIP);
	logCreate(playerid, logString, 1);
	return true;
}