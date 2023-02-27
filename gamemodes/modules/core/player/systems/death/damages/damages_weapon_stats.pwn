#define MAX_WEAPONS_QTD     	(57)
#define MAX_WEAPON_NAME 		(32)

static const g_WeaponName[MAX_WEAPONS_QTD][MAX_WEAPON_NAME] = 
{
	{"Punho"            	}, {"Soco-inglês"		}, {"Taco de golf"          },
	{"Cassetete"       		}, {"Faca"         		}, {"Taco de baseball"      },
	{"Pá"           		}, {"Taco de sinuca"    }, {"Katana"              	},
	{"Motosserra"       	}, {"Dildo roxo"  		}, {"Dildo"               	},
	{"Vibrador"         	}, {"Vibrador"      	}, {"Flores"             	},
	{"Bengala"          	}, {"Granada"       	}, {"Gás lacrimogêneo"      },
	{"Molotov"          	}, {"Arma de veículo"   }, {"Arma de veículo"       },
	{"Arma de veículo"  	}, {"Colt 45"       	}, {"Silenced pistol"     	},
	{"Desert Eagle"     	}, {"Shotgun"       	}, {"Sawn-off shotgun"    	},
	{"Combat shotgun"   	}, {"Mac-10"        	}, {"MP5"                 	},
	{"AK-47"            	}, {"M4"            	}, {"Tec-9"               	},
	{"Cuntgun"          	}, {"Sniper"        	}, {"Rocket launcher"     	},
	{"Heat seeking RPG" 	}, {"Lança-chamas"  	}, {"Minigun"             	},
	{"Satchel"          	}, {"Detonator"     	}, {"Spraycan"            	},
	{"Extintor de incêndio"	}, {"Camera"        	}, {"Óculos noturno"		},
	{"Óculos infravermelho" }, {"Parachute"     	}, {"Pistola falsa"         },
	{"Coronhada"      		}, {"Veículo"       	}, {"Lâminas de helicóptero"},
	{"Explosão"        		}, {"Estacionamento"   	}, {"Afogado"            	},
	{"Colisão"        		}, {"Queda"         	}, {"Desconhecido"          }
};

static Float:s_WeaponDamage[MAX_WEAPONS_QTD] = 
{
	3.0, // 0 - Fist
	5.0, // 1 - Brass knuckles
	5.0, // 2 - Golf club
	5.0, // 3 - Nitestick
	10.0, // 4 - Knife
	5.0, // 5 - Bat
	5.0, // 6 - Shovel
	0.0, // 7 - Pool cue
	15.0, // 8 - Katana
	0.0, // 9 - Chainsaw
	1.0, // 10 - Dildo
	1.0, // 11 - Dildo 2
	1.0, // 12 - Vibrator
	1.0, // 13 - Vibrator 2
	1.0, // 14 - Flowers
	1.0, // 15 - Cane
	82.5, // 16 - Grenade
	0.0, // 17 - Teargas
	10.0, // 18 - Molotov
	9.9, // 19 - Vehicle M4 (custom)
	46.2, // 20 - Vehicle minigun (custom)
	82.5, // 21 - Vehicle rocket (custom)
	18.5, // 22 - Colt 45
	17.0, // 23 - Silenced
	46.2, // 24 - Deagle
	40.0, // 25 - Shotgun
	55.5, // 26 - Sawed-off 
	45.2, // 27 - Spas
	15.0, // 28 - UZI
	14.25, // 29 - MP5
	28.0, // 30 - AK47
	25.0, // 31 - M4
	10.0, // 32 - Tec9
	82.5, // 33 - Cuntgun
	500.00, // 34 - Sniper
	500.00, // 35 - Rocket launcher
	82.5, // 36 - Heatseeker
	1.0, // 37 - Flamethrower
	46.2, // 38 - Minigun
	82.5, // 39 - Satchel
	0.0, // 40 - Detonator
	0.33, // 41 - Spraycan
	0.33, // 42 - Fire extinguisher
	0.0, // 43 - Camera
	0.0, // 44 - Night vision
	0.0, // 45 - Infrared
	0.0, // 46 - Parachute
	0.0, // 47 - Fake pistol
	2.64, // 48 - Pistol whip (custom)
	9.9, // 49 - Vehicle
	330.0, // 50 - Helicopter blades
	82.5, // 51 - Explosion
	1.0, // 52 - Car park (custom)
	1.0, // 53 - Drowning
	165.0  // 54 - Splat
};

Float:GetWeaponDamageVal(weaponId) {
    return s_WeaponDamage[weaponId];
}

ReturnWeaponName(weaponid) {
	static
		name[32];
	format(name, sizeof(name), "%s", g_WeaponName[weaponid]);
	return name;
}

/*ReturnWeaponName2(weaponid) {
	static
		name[32];

	GetWeaponName(weaponid, name, sizeof(name));

	if (!weaponid)
	    name = "Nenhum";

	else if (weaponid == 0)
	    name = "Soco";

	else if (weaponid == 4)
		name = "Faca";

	else if (weaponid == 18)
	    name = "Molotov Cocktail";

	else if (weaponid == 44)
	    name = "Nightvision";

	else if (weaponid == 45)
	    name = "Infrared";

	return name;
}*/

SetPlayerWeaponSkill(playerid, skill) {
	switch(skill) {
	    case MINIMUM_SKILL: {
            for(new i = 0; i != 11;++i) SetPlayerSkillLevel(playerid, WEAPONSKILL:i, 200);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 0);
	    }
	    case MEDIUM_SKILL: {
            for(new i = 0; i != 11;++i) SetPlayerSkillLevel(playerid, WEAPONSKILL:i, 500);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 0);
	    }
	    case FULL_SKILL: {
            for(new i = 0; i != 11;++i) SetPlayerSkillLevel(playerid, WEAPONSKILL:i, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 0);
	    }
	}
}