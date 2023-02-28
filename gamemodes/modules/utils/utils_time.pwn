// Formatação do timestamp por meio da optimização do pawn-chrono, permitindo que acessemos da melhor forma e de maneira mais rápida.

#include <chrono>

#define FULL_DATETIME           "%d/%m/%Y às %H:%M:%S"
#define FULL_SHORT_DATETIME     "%d/%m/%Y - %H:%M:%S"
#define FULL_DATEONLY           "%d/%m/%Y"

new // Fix Time
	ghour = 0,
	gminute = 0,
	gsecond = 0,
	timeshift = 0,
	shifthour
;
// Vai retornar tanto 'dd/MM/yy - HH:mm:ss' como  'dd/MM/yy às HH:mm:ss'
GetFullDate(timestamp, style = 0) {
    new convertedTimeZoned = timestamp - 10800;
    new  Timestamp:ts = Timestamp:convertedTimeZoned, returnDate[256];
    
    switch(style){
        case 0: TimeFormat(ts, FULL_SHORT_DATETIME, returnDate);
        case 1: TimeFormat(ts, FULL_DATETIME, returnDate);
        case 2: TimeFormat(ts, FULL_DATEONLY, returnDate);
    }

    return timestamp > 0 ? (returnDate) : ("N/A");
}

FormatDate(timestamp, _form=0) {
    new year=1970, day=0, month=0, hourt=0, mins=0, sec=0;

    new days_of_month[12] = {31,28,31,30,31,30,31,31,30,31,30,31};
    new names_of_month[12][10] = {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"};
    new returnstring[32];

    while(timestamp>31622400){
        timestamp -= 31536000;
        if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) timestamp -= 86400;
        year++;
    }

    if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )
        days_of_month[1] = 29;
    else
        days_of_month[1] = 28;


    while(timestamp>86400) {
        timestamp -= 86400, day++;
        if(day==days_of_month[month]) day=0, month++;
    }

    while(timestamp>60) {
        timestamp -= 60, mins++;
        if( mins == 60) mins=0, hourt++;
    }

    sec=timestamp;

    switch(_form) {
        case 1: format(returnstring, 31, "%02d/%02d/%d %02d:%02d:%02d", day+1, month+1, year, hourt, mins, sec);
        case 2: format(returnstring, 31, "%s %02d, %d, %02d:%02d:%02d", names_of_month[month],day+1,year, hourt, mins, sec);
        case 3: format(returnstring, 31, "%d %c%c%c %d, %02d:%02d", day+1,names_of_month[month][0],names_of_month[month][1],names_of_month[month][2], year,hourt,mins);
        case 4: format(returnstring, 31, "%02d de %s de %d", day+1, names_of_month[month], year);
        default: format(returnstring, 31, "%02d.%02d.%d-%02d:%02d:%02d", day+1, month+1, year, hourt, mins, sec);
    }

    return returnstring;
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

	strcat(str, " atrás");
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