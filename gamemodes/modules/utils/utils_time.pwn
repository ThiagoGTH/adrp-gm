// Formatação do timestamp por meio da optimização do pawn-chrono, permitindo que acessemos da melhor forma e de maneira mais rápida.

#include <chrono>

#define FULL_DATETIME           "%d/%m/%Y às %H:%M:%S"
#define FULL_SHORT_DATETIME     "%d/%m/%Y - %H:%M:%S"

// Vai retornar tanto 'dd/MM/yy - HH:mm:ss' como  'dd/MM/yy às HH:mm:ss'

GetFullDate(timestamp, style = 0) {
    new convertedTimeZoned = timestamp - 10800;
    new  Timestamp:ts = Timestamp:convertedTimeZoned, returnDate[256];
    
    TimeFormat(ts, style > 0 ? (FULL_SHORT_DATETIME) : (FULL_DATETIME), returnDate);

    return timestamp > 0 ? (returnDate) : ("N/A");
}
