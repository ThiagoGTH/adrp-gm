#include <YSI_Coding\y_hooks>

new DCC_Channel:logChannels[33];

forward Discord_StartChannels();
public Discord_StartChannels(){
    logChannels[0] = DCC_FindChannelById("989303563622694942");  //Arrombar            (2)
    logChannels[1] = DCC_FindChannelById("989303575769403392");  //Refundos            (3)
    logChannels[2] = DCC_FindChannelById("989303590734692372");  //HotWire             (4)
    logChannels[3] = DCC_FindChannelById("989303613434253333");  //Deletar Char        (5)
    logChannels[4] = DCC_FindChannelById("989303628433092678");  //NameChange          (6)
    logChannels[5] = DCC_FindChannelById("989303644681801808");  //Donater             (7)
    logChannels[6] = DCC_FindChannelById("989303659408031784");  //AntiCheater         (8)
    logChannels[7] = DCC_FindChannelById("989303687589556235");  //Grafitti            (9)
    logChannels[8] = DCC_FindChannelById("989303697018331197");  //Itens               (10)
    logChannels[9] = DCC_FindChannelById("989303723392122900");  //WHs                 (11)
    logChannels[10] = DCC_FindChannelById("989303745022132224"); //Comprado veículo    (12)
    logChannels[11] = DCC_FindChannelById("989303757911261244"); //Dinheiro            (13)
    logChannels[12] = DCC_FindChannelById("989303773316911175"); //Ammu Nation         (14)
    logChannels[13] = DCC_FindChannelById("989303791797039164"); //Armazenamento casa  (15)
    logChannels[14] = DCC_FindChannelById("989303818896441345"); //Admin               (16)
    logChannels[15] = DCC_FindChannelById("989303844838178836"); //Casas e empresas    (17)
    logChannels[16] = DCC_FindChannelById("989303860285812747"); //Carros              (18)
    logChannels[17] = DCC_FindChannelById("989303879889981490"); //Faccoes             (19)
    logChannels[18] = DCC_FindChannelById("989303902883160115"); //Porte de armas      (20)
    logChannels[19] = DCC_FindChannelById("989303918645370951"); //Armas               (21)
    logChannels[20] = DCC_FindChannelById("989303945698615326"); //Permissões          (22)
    logChannels[21] = DCC_FindChannelById("989304001516408863"); //Quotes importantes  (23)
    logChannels[22] = DCC_FindChannelById("989304026501890068"); //Mobílias            (24)
    logChannels[23] = DCC_FindChannelById("989304049931268116"); //Login Logout        (25)
    logChannels[24] = DCC_FindChannelById("989304074681860186"); //Mortes              (26)
    logChannels[25] = DCC_FindChannelById("989304087927476224"); //Arrastar            (27)
    logChannels[26] = DCC_FindChannelById("989304108311789618"); //Chaves              (28)
    logChannels[27] = DCC_FindChannelById("989304137638379550"); //Objetos autorizado  (29)
    logChannels[28] = DCC_FindChannelById("989304154600128613"); //Auto leasing        (30)
    logChannels[29] = DCC_FindChannelById("989304164213481482"); //FPS                 (31)
    logChannels[30] = DCC_FindChannelById("989304202461339718"); // (/fac)            (32)
    return true;
}

stock ReturnDate()
{
	new sendString[90], month, day, year;
	new hour, minute, second;

	gettime(hour, minute, second);
	getdate(year, month, day);

	format(sendString, 90, "%d/%d/%d - %02d:%02d:%02d", day, month, year, hour, minute, second);
	return sendString;
}


