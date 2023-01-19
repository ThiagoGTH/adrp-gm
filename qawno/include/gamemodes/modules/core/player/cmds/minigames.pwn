#include <YSI_Coding\y_hooks>

// DADOS
CMD:dados(playerid, params[]){
    static type;
    new number;
    if (sscanf(params, "d", type)){
        SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
        SendClientMessage(playerid, COLOR_BEGE, "USE: /dados [número da opção]");
        SendClientMessage(playerid, COLOR_BEGE, "[Opções]: 1. Seis lados (1-6), 2. Oito lados (1-8), 3. Dez lados (1-10)");
        SendClientMessage(playerid, COLOR_BEGE, "[Opções]: 4. Doze lados (1-12), 5. Vinte lados (1-20)");
        SendClientMessage(playerid, COLOR_BEGE, "_____________________________________________");
        return true;
    }

    switch(type){
        case 1: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s rola o dado de seis lados, caindo no número %d.", pNome(playerid), number = randomEx(1, 6));
        case 2: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s rola o dado de oito lados, caindo no número %d.", pNome(playerid), number = randomEx(1, 8));       
        case 3: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s rola o dado de dez lados, caindo no número %d.", pNome(playerid), number = randomEx(1, 10));       
        case 4: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s rola o dado de doze lados, caindo no número %d.", pNome(playerid), number = randomEx(1, 12));       
        case 5: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s rola o dado de vinte lados, caindo no número %d.", pNome(playerid), number = randomEx(1, 20));       
        default: SendErrorMessage(playerid, "O tipo de dado selecionado é inválido. Utilize /dados para ver as opções.");
    }
    return true;
}

// CARA OU COROA
CMD:moeda(playerid){
    new hand = random(2);
    switch(hand){
        case 0: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s joga uma moeda para o alto, caindo em cara.", pNome(playerid));
        case 1: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s joga uma moeda para o alto, caindo em coroa.", pNome(playerid)); 
    }
    return true;
}

// PEDRA, PAPEL OU TESOURA
CMD:jokenpo(playerid){
    new hand = random(3);
    switch(hand){
        case 0: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s mostra o sinal de pedra com a mão.", pNome(playerid));       
        case 1: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s mostra o sinal de papel com a mão.", pNome(playerid));
        case 2: SendNearbyMessage(playerid, 7.0, COLOR_PURPLE, "** %s mostra o sinal de tesoura com a mão.", pNome(playerid));
        
    }
    return true;
}