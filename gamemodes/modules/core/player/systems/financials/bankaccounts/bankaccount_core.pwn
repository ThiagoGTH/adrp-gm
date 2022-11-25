enum E_PLAYER_BANKACCOUNT {
    aID,                // ID da conta no MySQL
    aOwner,             // ID do jogador dono da conta
    aSubOwner,          // ID do segundo jogador dono da cont caso Conta Compartilhada
    aNumber[16],        // Numero de Identificaçao da Conta para Acesso Ingame
    aPassword[16]       // Senha de Identificaçao da Conta para Acesso Ingame
    bool:aBlocked,      // Conta Bloqueada
    aAmount,            // Valor total disponível na conta
    aSavings,           // Valor total da conta em savings
    bool:aShared,       // Conta compartilhada
};

new aInfo[MAX_PLAYERS][E_PLAYER_BANKACCOUNT];
