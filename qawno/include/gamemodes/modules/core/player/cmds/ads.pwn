/*

Este módulo é dedicado ao /anuncio.

*/

#include <YSI_Coding\y_hooks>

// DEFINES
#define MAX_AD_QUEUE    (20)
#define PRICE_AD        (100)
#define PRICE_BIZ_AD    (50)

// VARIABLES
enum Advert_Data
{
    ad_owner[24],
    ad_id,
    ad_time,
    ad_type,
    ad_number,
	ad_text[128],
}

new AdvertData[MAX_AD_QUEUE][Advert_Data];

// COMMANDS
CMD:anuncio(playerid, params[]){
    
    // Posição ainda não definida
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM advertisement WHERE `TIME` > UNIX_TIMESTAMP() ORDER BY `ID` ASC");
    new Cache:result = mysql_query(DBConn, query);

    new string[1024], adText[128];
    format(string, sizeof(string), "#\tAnúncio\tPublicará em\n");
    format(string, sizeof(string), "%s{BBBBBB}Publicar anúncio\n", string);
    for(new i; i < cache_num_rows(); i++){
        cache_get_value_name(i, "text", adText);        
        format(string, sizeof(string), "%s%d\t%s\t%ds\n", string, i+1, adText, AdvertData[i][ad_time]);
    }
    cache_delete(result);

    Dialog_Show(playerid, showAdvertise, DIALOG_STYLE_TABLIST_HEADERS, "Anúncios", string, "Selecionar", "Fechar");
    
    return true;
}
alias:anuncio("an", "anuncios")

// FUNCTIONS
Dialog:showAdvertise(playerid, response, listitem, inputtext[]){
    if(response){
        if(pInfo[playerid][pAdTick]) return SendErrorMessage(playerid, "Você precisa esperar %d segundos antes de anunciar novamente.", pInfo[playerid][pAdTick]);

        if(GetMoney(playerid) < PRICE_AD) return SendErrorMessage(playerid, "Você não possui $%d para fazer um anúncio.", PRICE_AD);

        if(!strcmp(inputtext, "Publicar anúncio", true)){ // Publicar
            Dialog_Show(playerid, pubAdvertise, DIALOG_STYLE_INPUT, "Anúncios > Publicar", "Digite o anúncio que deseja publicar:", "Publicar", "Voltar");
        }
    } 
    return true;
}

Dialog:pubAdvertise(playerid, response, listitem, inputtext[]){
    if(response){
        if(isnull(inputtext)) return Dialog_Show(playerid, pubAdvertise, DIALOG_STYLE_INPUT, "Anúncios > Publicar", "ERRO: Você não digitou algo válido.\nDigite o anúncio que deseja publicar:", "Publicar", "Voltar");
        if(strlen(inputtext) > 128) return Dialog_Show(playerid, pubAdvertise, DIALOG_STYLE_INPUT, "Anúncios > Publicar", "ERRO: O anúncio não pode conter mais de 128 caracteres.\nDigite o anúncio que deseja publicar:", "Publicar", "Voltar");

        new exists = -1;

		for(new i = 0; i != MAX_AD_QUEUE; i++) {
			if(!AdvertData[i][ad_id]) {
			    exists = i;
				break;
			}
		}

        if(exists != -1 && (!CountPlayerAdvert(playerid))){
            new adText[128], time = gettime();
            AdvertData[exists][ad_time] = 60 * (CountAdvert() + 1);
            format(adText, 128, "%s", inputtext);

            format(AdvertData[exists][ad_owner], 24, "%s", pInfo[playerid][pName]);
			format(AdvertData[exists][ad_text], 128, "%s", inputtext);
			AdvertData[exists][ad_type] = 0;
            AdvertData[exists][ad_number] = pInfo[playerid][pPhoneNumber];

            mysql_format(DBConn, query, sizeof query, "INSERT INTO advertisement (`player`, `text`, `time`, `number`) VALUES ('%s', '%s', '%d', '%d');", AdvertData[exists][ad_owner], adText, time+AdvertData[exists][ad_time], pInfo[playerid][pPhoneNumber]);
            new Cache:result = mysql_query(DBConn, query);

            new insertid = cache_insert_id();
            AdvertData[exists][ad_id] = insertid;

            GiveMoney(playerid, -PRICE_AD);
            if(pInfo[playerid][pDonator] == 1) pInfo[playerid][pAdTick] = 90;
            else if(pInfo[playerid][pDonator] == 2) pInfo[playerid][pAdTick] = 60;
            else if(pInfo[playerid][pDonator] == 3) pInfo[playerid][pAdTick] = 30;
            else pInfo[playerid][pAdTick] = 120;
            cache_delete(result);
            SendServerMessage(playerid, "Seu anúncio entrou na lista, isso custou $%d.", PRICE_AD);
            SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s enviou um anúncio.", pNome(playerid));
            format(logString, sizeof(logString), "%s (%s) enviou o anúncio [%s].", pNome(playerid), GetPlayerUserEx(playerid), adText);
	        logCreate(playerid, logString, 10);
        } else return SendErrorMessage(playerid, "A lista de anúncios está cheia ou você já tem um anúncio em espera. Tente novamente mais tarde.");
    } 
    return true;
}

hook OnGameModeInit(){
    SetTimer("adsTimer", 1000, true);
    return true;
}

forward adsTimer();
public adsTimer(){
    foreach (new i : Player){
        if(pInfo[i][pAdTick]) pInfo[i][pAdTick]--;
    }

    for(new i = 0; i != MAX_AD_QUEUE; i++){
        if(AdvertData[i][ad_id]) {
			AdvertData[i][ad_time]--;
			if(AdvertData[i][ad_time] <= 0) {
                new str[256];
                if(AdvertData[i][ad_type]) {
                    if(strlen(AdvertData[i][ad_text]) > 80) {
						format(str, sizeof(str), "[Anúncio de Empresa] %.80s ...", AdvertData[i][ad_text]);
						SendClientMessageToAll(COLOR_GREEN, str);
						format(str, sizeof(str), "[Anúncio de Empresa] ... %s", AdvertData[i][ad_text][80]);
						SendClientMessageToAll(COLOR_GREEN, str);
					} else {
						format(str, sizeof(str), "[Anúncio de Empresa] %s", AdvertData[i][ad_text]);
						SendClientMessageToAll(COLOR_GREEN, str);
					}
                    new text[1024], title[32];
                    format(text, 1024, "%s", AdvertData[i][ad_text]);
                    utf8encode(text, text);
                    format(title, 32, "Anúncio de Empresa");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0x00A3D9);
                    DCC_SetEmbedDescription(embed, text);
                    new footer[128];
                    format(footer, 128, "Anúncio enviado em %s.", GetFullDate(gettime()));
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("1018291872545910845"), embed);
                } else {
					if(strlen(AdvertData[i][ad_text]) > 80) {
						format(str, sizeof(str), "[Anúncio] %.80s ...", AdvertData[i][ad_text]);
						SendClientMessageToAll(COLOR_GREEN, str);
						format(str, sizeof(str), "[Anúncio] ... %s [PH: %d]", AdvertData[i][ad_text][80], AdvertData[i][ad_number]);
						SendClientMessageToAll(COLOR_GREEN, str);
					} else {
						format(str, sizeof(str), "[Anúncio] %s [PH: %d]", AdvertData[i][ad_text], AdvertData[i][ad_number]);
						SendClientMessageToAll(COLOR_GREEN, str);
					}
                    new text[1024], title[32];
                    format(text, 1024, "%s [PH: %d]", AdvertData[i][ad_text], pInfo[i][pPhoneNumber]);
                    utf8encode(text, text);
                    format(title, 32, "Anúncio");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0x238C00);
                    DCC_SetEmbedDescription(embed, text);
                    new footer[128];
                    format(footer, 128, "Anúncio enviado em %s.", GetFullDate(gettime()));
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("1018291872545910845"), embed);
			    }

                AdvertData[i][ad_id] = 0;
			    AdvertData[i][ad_time] = 0;
                AdvertData[i][ad_number] = 0;
                AdvertData[i][ad_text] = EOS;
			    AdvertData[i][ad_owner] = INVALID_PLAYER_ID;
            }
        }
    }

    return true;
}

CountAdvert() {
    new num = 0;
	for(new i = 0; i != MAX_AD_QUEUE; i++) if(AdvertData[i][ad_id]) num++;
	return num;
}

CountPlayerAdvert(playerid) {
    new num = 0;
	for(new i=0; i != MAX_AD_QUEUE; i++) if(AdvertData[i][ad_id] && AdvertData[i][ad_owner] == playerid) num++;
	return num;
}