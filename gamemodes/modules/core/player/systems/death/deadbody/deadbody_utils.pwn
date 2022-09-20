enum E_DEAD_BODYS {
    e_ACTOR,
	e_SKIN,
	Float:e_POS[4],
	e_WORLD,
	e_INTERIOR,
	e_TIME,
    Text3D:e_TEXT,
	e_DEADBY[256],
	e_NAME[24]
};

new DeadBody[MAX_PLAYERS][E_DEAD_BODYS];