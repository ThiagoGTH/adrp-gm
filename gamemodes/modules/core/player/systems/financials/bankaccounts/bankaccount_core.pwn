enum E_PLAYER_BANKACCOUNT {
    aID,
    aOwner,
    aNumber[16],
    aPassword[16]
    bool:aBlocked,
    aAmount,
    aSavings,
    bool:aShared,
};

new aInfo[MAX_PLAYERS][E_PLAYER_BANKACCOUNT];

