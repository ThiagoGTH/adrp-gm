// Formatação do timestamp por meio da optimização do pawn-chrono, permitindo que acessemos da melhor forma e de maneira mais rápida.

#include <chrono>

#define FULL_DATETIME           "%d/%m/%Y às %H:%M:%S"
#define FULL_SHORT_DATETIME     "%d/%m/%Y - %H:%M:%S"

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

	strcat(str, " atrás");
	return str;
}

hook OnGameModeInit(){
	gettime(ghour, gminute, gsecond);
	FixHour(ghour);
	ghour = shifthour;
	SetWorldTime(ghour);

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
    new tmphour;
	new tmpminute;
	new tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;

	if ((tmphour > ghour) || (tmphour == 0 && ghour == 23)) {
		ghour = tmphour;

		//OnTradingUpdate();
		SetWorldTime(tmphour);
	}
}