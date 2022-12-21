// Formata��o do timestamp por meio da optimiza��o do pawn-chrono, permitindo que acessemos da melhor forma e de maneira mais r�pida.

#include <chrono>

#define FULL_DATETIME           "%d/%m/%Y �s %H:%M:%S"
#define FULL_SHORT_DATETIME     "%d/%m/%Y - %H:%M:%S"

new // Fix Time
	ghour = 0,
	gminute = 0,
	gsecond = 0,
	timeshift = 0,
	shifthour
;
// Vai retornar tanto 'dd/MM/yy - HH:mm:ss' como  'dd/MM/yy �s HH:mm:ss'
GetFullDate(timestamp, style = 0) {
    new convertedTimeZoned = timestamp - 10800;
    new  Timestamp:ts = Timestamp:convertedTimeZoned, returnDate[256];
    
    TimeFormat(ts, style > 0 ? (FULL_SHORT_DATETIME) : (FULL_DATETIME), returnDate);

    return timestamp > 0 ? (returnDate) : ("N/A");
}

GetDuration(time){
	new str[32];

	if (time < 0 || time == gettime()) {
	    format(str, sizeof(str), "Nunca");
	    return str;
	}
	else if (time < 60)
		format(str, sizeof(str), "%d segundos", time);

	else if (time >= 0 && time < 60)
		format(str, sizeof(str), "%d segundos", time);

	else if (time >= 60 && time < 3600)
		format(str, sizeof(str), (time >= 120) ? ("%d minutos") : ("%d minuto"), time / 60);

	else if (time >= 3600 && time < 86400)
		format(str, sizeof(str), (time >= 7200) ? ("%d horas") : ("%d hora"), time / 3600);

	else if (time >= 86400 && time < 2592000)
 		format(str, sizeof(str), (time >= 172800) ? ("%d dias") : ("%d dia"), time / 86400);

	else if (time >= 2592000 && time < 31536000)
 		format(str, sizeof(str), (time >= 5184000) ? ("%d meses") : ("%d mes"), time / 2592000);

	else if (time >= 31536000)
		format(str, sizeof(str), (time >= 63072000) ? ("%d anos") : ("%d ano"), time / 31536000);

	strcat(str, " atr�s");
	return str;
}

hook OnGameModeInit(){
	gettime(ghour, gminute, gsecond);
	FixHour(ghour);
	ghour = shifthour;
	SetWorldTime(ghour);
	SetWeather(14);

	SetTimer("SyncUp", 60000, true);
	return true;
}

forward FixHour(hour);
public FixHour(hour) {
	hour = timeshift+hour;
	if (hour < 0) hour = hour+24;
	else if (hour > 23) hour = hour-24;
	shifthour = hour;
	return true;
}

forward SyncUp();
public SyncUp() {
    new tmphour, tmpminute, tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;

	if ((tmphour > ghour) || (tmphour == 0 && ghour == 23)) {
		ghour = tmphour;
		InvestmentUpdate();
		SetWorldTime(tmphour);
		SetWeather(14);
	}
}

ConvertTime(&cts, &ctm=-1,&cth=-1,&ctd=-1,&ctw=-1,&ctmo=-1,&cty=-1)
{
    #define PLUR(%0,%1,%2) (%0),((%0) == 1)?((#%1)):((#%2))

    #define CTM_cty 31536000
    #define CTM_ctmo 2628000
    #define CTM_ctw 604800
    #define CTM_ctd 86400
    #define CTM_cth 3600
    #define CTM_ctm 60

    #define CT(%0) %0 = cts / CTM_%0; cts %= CTM_%0

    new strii[128];

    if(cty != -1 && (cts/CTM_cty))
    {
        CT(cty); CT(ctmo); CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(cty,"year","years"),PLUR(ctmo,"month","months"),PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctmo != -1 && (cts/CTM_ctmo))
    {
        cty = 0; CT(ctmo); CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(ctmo,"month","months"),PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctw != -1 && (cts/CTM_ctw))
    {
        cty = 0; ctmo = 0; CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctd != -1 && (cts/CTM_ctd))
    {
        cty = 0; ctmo = 0; ctw = 0; CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, and %d %s",PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(cth != -1 && (cts/CTM_cth))
    {
        cty = 0; ctmo = 0; ctw = 0; ctd = 0; CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, and %d %s",PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctm != -1 && (cts/CTM_ctm))
    {
        cty = 0; ctmo = 0; ctw = 0; ctd = 0; cth = 0; CT(ctm);
        format(strii, sizeof(strii), "%d %s, and %d %s",PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    cty = 0; ctmo = 0; ctw = 0; ctd = 0; cth = 0; ctm = 0;
    format(strii, sizeof(strii), "%d %s", PLUR(cts,"second","seconds"));
    return strii;
}