#include <YSI_Coding\y_hooks>

stock ReturnDate()
{
	new sendString[90], month, day, year;
	new hour, minute, second;

	gettime(hour, minute, second);
	getdate(year, month, day);

	format(sendString, 90, "%d/%d/%d - %02d:%02d:%02d", day, month, year, hour, minute, second);
	return sendString;
}


