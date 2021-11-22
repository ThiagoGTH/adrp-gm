#include <YSI_Coding\y_hooks>

#define DIALOG_WEAPONS  	(12920)
#define DIALOG_ADMDEALER	(12921)
#define DIALOG_CRTCR    	(12922)
#define DIALOG_CRTGO    	(12923)
#define DIALOG_CRTET    	(12924)
#define DIALOG_CRTED    	(12925)
#define DIALOG_CRTEY    	(12926)
#define DIALOG_CRTEZ    	(12927)
#define DIALOG_CRTEP    	(12928)
#define DIALOG_DELETEDEALER (12929)
#define MAX_DEALERS 10

enum WeapDealers
{
	ActorID,
	Text3D:Label,
	Weapon1,
	Weapon2,
	Weapon3,
	Weapon4,
	Weapon5,
	Weapon6,
	Weapon7,
	Weapon8,
	Weapon9,
	Weapon10,
	Cost1,
	Cost2,
	Cost3,
	Cost4,
	Cost5,
	Cost6,
	Cost7,
	Cost8,
	Cost9,
	Cost10,
	Ammo1,
	Ammo2,
	Ammo3,
	Ammo4,
	Ammo5,
	Ammo6,
	Ammo7,
	Ammo8,
	Ammo9,
	Ammo10,
	dSkin,
	Float:dAngle,
	Float:dX,
	Float:dY,
	Float:dZ,
	dWorld
};

new Iterator:DealerLoop<MAX_DEALERS>;

new dInfo[MAX_DEALERS][WeapDealers];

hook OnGameModeInit()
{
	mysql_tquery(DBConn, "SELECT * FROM `dealers`", "LoadDealers", "");
	return 1;
}

/*Callbacks*/
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_WEAPONS)
	{
		if(response)
		{
			new string[512];
		    if(GetMaterial(playerid) < pInfo[playerid][CurrentCost][listitem]) return SendErrorMessage(playerid, "Você não possui todo esse material.");

		    GiveWeaponToPlayer(playerid, pInfo[playerid][CurrentItem][listitem], pInfo[playerid][CurrentAmmo][listitem]);
			GiveMaterial(playerid, -pInfo[playerid][CurrentCost][listitem]);
			va_SendClientMessage(playerid, COLOR_YELLOW, "Você pegou um(a) %s (%d munições) por %s materiais.", ReturnWeaponName(pInfo[playerid][CurrentItem][listitem]), pInfo[playerid][CurrentAmmo][listitem], FormatNumber(pInfo[playerid][CurrentCost][listitem]));
			
			format(string, sizeof(string), "`LOG-WF:` [%s] **%s** (%s) pegou **%s** (%d municoes)  por %s materiais na WF.", ReturnDate(), pNome(playerid), PlayerIP(playerid), ReturnWeaponName(pInfo[playerid][CurrentItem][listitem]), pInfo[playerid][CurrentAmmo][listitem], pInfo[playerid][CurrentCost][listitem]);
  			DCC_SendChannelMessage(DC_LogFac, string);
		}
	}
	if(dialogid == DIALOG_ADMDEALER)
	{
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0:
				{
					ShowPlayerDialog(playerid,DIALOG_DELETEDEALER, DIALOG_STYLE_INPUT, "Weapon Factory » Deletar Weapon Factory", "Digite o ID da Weapon Factory:", "Ir", "Cancelar");
				}
				case 1:
				{
				    new count = -1;
					foreach(new i: DealerLoop)
					{
					    if(IsPlayerInRangeOfPoint(playerid, 1.5, dInfo[i][dX], dInfo[i][dY], dInfo[i][dZ]))
						{
							count = i;
						}
					}
					if(count == -1) return SendErrorMessage(playerid, "Você não está perto de nenhuma Weapon Factory!");
					RemoveDealer(count);
				}
				case 2:
				{
				    new count = -1;
					foreach(new i: DealerLoop)
					{
					    if(IsPlayerInRangeOfPoint(playerid, 1.5, dInfo[i][dX], dInfo[i][dY], dInfo[i][dZ]))
						{
							count = i;
						}
					}
					if(count == -1) return SendErrorMessage(playerid, "Você não está perto de nenhuma Weapon Factory!");
					dInfo[count][Weapon1] = dInfo[count][Weapon2] = dInfo[count][Weapon3] = dInfo[count][Weapon4] = dInfo[count][Weapon5] = dInfo[count][Weapon6] =
					dInfo[count][Weapon7] = dInfo[count][Weapon8] = dInfo[count][Weapon9] = dInfo[count][Weapon10] = -1;
					UpdateDealers(pInfo[playerid][CurrentDealer],0);
				}
				case 3:
				{
				    ShowPlayerDialog(playerid,DIALOG_CRTCR, DIALOG_STYLE_INPUT, "Weapon Factory » Criar WF", "Digite a SKIN da Weapon Factory:", "Criar", "Cancelar");
				}
				case 4:
				{
				    ShowPlayerDialog(playerid,DIALOG_CRTGO, DIALOG_STYLE_INPUT, "Weapon Factory » Ir WF", "Digite o ID da Weapon Factory:", "Ir", "Cancelar");
				}
				case 5:
				{
				    ShowPlayerDialog(playerid,DIALOG_CRTET, DIALOG_STYLE_INPUT, "Weapon Factory » Editar WF", "Digite o ID da Weapon Factory:", "Editar", "Cancelar");
				}
	        }
	    }
	}
	if(dialogid == DIALOG_CRTCR)
	{
	    if(response)
	    {
			new Float:X,Float:Y,Float:Z,Float:F;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,F);
	    	CreateDealer(strval(inputtext), X, Y, Z, F, GetPlayerVirtualWorld(playerid));
			SetPlayerPos(playerid,X+2,Y,Z+1);
		}
	}
	if(dialogid == DIALOG_CRTGO)
	{
 		if(response)
   		{
    		if (!Iter_Contains(DealerLoop, strval(inputtext))) return SendErrorMessage(playerid,"Não existe Weapon Factory com este ID.");
     		SetPlayerPos(playerid,dInfo[strval(inputtext)][dX]+2,dInfo[strval(inputtext)][dY],dInfo[strval(inputtext)][dZ]+1);
		}
	}
	if(dialogid == DIALOG_DELETEDEALER)
	{
 		if(response)
   		{
			new count = -1;
			foreach(new i: DealerLoop)
			{
				if (!Iter_Contains(DealerLoop, strval(inputtext))) return SendErrorMessage(playerid,"Não existe Weapon Factory com este ID.");
				{
					count = i;
				}
			}
			if(count == -1) return SendErrorMessage(playerid, "Você não específicou uma Weapon Factory válida!");
			SendServerMessage(playerid, "Você deletou a Weapon Factory.");
			RemoveDealer(count);
		}
	}
	if(dialogid == DIALOG_CRTET)
	{
 		if(response)
   		{
    		if (!Iter_Contains(DealerLoop, strval(inputtext))) return SendErrorMessage(playerid,"Não existe Weapon Factory com este ID.");
			pInfo[playerid][CurrentDealer] = strval(inputtext);
     		ShowPlayerDialog(playerid,DIALOG_CRTED, DIALOG_STYLE_INPUT, "Weapon Factory » Editar WF", "Coloque o ID do slot\nOs slots variam entre: 1-10", "Editar", "Cancelar");
		}
	}
	if(dialogid == DIALOG_CRTED)
	{
 		if(response)
   		{
    		if( 1 < strval(inputtext) > 10) return SendErrorMessage(playerid, "Slot inválido.");
    		pInfo[playerid][CurrentItem][0] = strval(inputtext);
     		ShowPlayerDialog(playerid,DIALOG_CRTEY, DIALOG_STYLE_INPUT, "Weapon Factory » Editar WF", "Coloque o ID da arma\nPara remover use '-1' como ID", "Editar", "Cancelar");
		}
	}
	if(dialogid == DIALOG_CRTEY)
	{
		if(response)
		{
		    switch(pInfo[playerid][CurrentItem][0])
		    {
		        case 1: dInfo[pInfo[playerid][CurrentDealer]][Weapon1] = strval(inputtext);
		        case 2: dInfo[pInfo[playerid][CurrentDealer]][Weapon2] = strval(inputtext);
		        case 3: dInfo[pInfo[playerid][CurrentDealer]][Weapon3] = strval(inputtext);
		        case 4: dInfo[pInfo[playerid][CurrentDealer]][Weapon4] = strval(inputtext);
		        case 5: dInfo[pInfo[playerid][CurrentDealer]][Weapon5] = strval(inputtext);
		        case 6: dInfo[pInfo[playerid][CurrentDealer]][Weapon6] = strval(inputtext);
		        case 7: dInfo[pInfo[playerid][CurrentDealer]][Weapon7] = strval(inputtext);
		        case 8: dInfo[pInfo[playerid][CurrentDealer]][Weapon8] = strval(inputtext);
		        case 9: dInfo[pInfo[playerid][CurrentDealer]][Weapon9] = strval(inputtext);
		        case 10: dInfo[pInfo[playerid][CurrentDealer]][Weapon10] = strval(inputtext);
		    }
		    UpdateDealers(pInfo[playerid][CurrentDealer],0);
			if(strval(inputtext) == -1) return SendServerMessage(playerid,"Arma removida com sucesso.");
			ShowPlayerDialog(playerid,DIALOG_CRTEZ, DIALOG_STYLE_INPUT, "Weapon Factory » Editar WF", "Digite a quantidade máxima de munição\nO máximo de munições é: 9999.", "Editar", "Cancelar");
		}
	}
	if(dialogid == DIALOG_CRTEZ)
	{
	    if(response)
		{
		    switch(pInfo[playerid][CurrentItem][0])
		    {
		        case 1: dInfo[pInfo[playerid][CurrentDealer]][Ammo1] = strval(inputtext);
		        case 2: dInfo[pInfo[playerid][CurrentDealer]][Ammo2] = strval(inputtext);
		        case 3: dInfo[pInfo[playerid][CurrentDealer]][Ammo3] = strval(inputtext);
		        case 4: dInfo[pInfo[playerid][CurrentDealer]][Ammo4] = strval(inputtext);
		        case 5: dInfo[pInfo[playerid][CurrentDealer]][Ammo5] = strval(inputtext);
		        case 6: dInfo[pInfo[playerid][CurrentDealer]][Ammo6] = strval(inputtext);
		        case 7: dInfo[pInfo[playerid][CurrentDealer]][Ammo7] = strval(inputtext);
		        case 8: dInfo[pInfo[playerid][CurrentDealer]][Ammo8] = strval(inputtext);
		        case 9: dInfo[pInfo[playerid][CurrentDealer]][Ammo9] = strval(inputtext);
		        case 10: dInfo[pInfo[playerid][CurrentDealer]][Ammo10] = strval(inputtext);
		    }
		    UpdateDealers(pInfo[playerid][CurrentDealer],1);
		    ShowPlayerDialog(playerid,DIALOG_CRTEP, DIALOG_STYLE_INPUT, "Weapon Factory » Editar WF", "Digite o custo da arma.", "Editar", "Cancelar");
		}
	}
	if(dialogid == DIALOG_CRTEP)
	{
	    if(response)
		{
		    switch(pInfo[playerid][CurrentItem][0])
		    {
		        case 1: dInfo[pInfo[playerid][CurrentDealer]][Cost1] = strval(inputtext);
		        case 2: dInfo[pInfo[playerid][CurrentDealer]][Cost2] = strval(inputtext);
		        case 3: dInfo[pInfo[playerid][CurrentDealer]][Cost3] = strval(inputtext);
		        case 4: dInfo[pInfo[playerid][CurrentDealer]][Cost4] = strval(inputtext);
		        case 5: dInfo[pInfo[playerid][CurrentDealer]][Cost5] = strval(inputtext);
		        case 6: dInfo[pInfo[playerid][CurrentDealer]][Cost6] = strval(inputtext);
		        case 7: dInfo[pInfo[playerid][CurrentDealer]][Cost7] = strval(inputtext);
		        case 8: dInfo[pInfo[playerid][CurrentDealer]][Cost8] = strval(inputtext);
		        case 9: dInfo[pInfo[playerid][CurrentDealer]][Cost9] = strval(inputtext);
		        case 10: dInfo[pInfo[playerid][CurrentDealer]][Cost10] = strval(inputtext);
		    }
		    UpdateDealers(pInfo[playerid][CurrentDealer],2);
		    SendServerMessage(playerid,"Slot de arma atualizado com sucesso.");
		}
	}
	return 1;
}

forward LoadDealers();
public LoadDealers()
{
	new t,string[55];
	static 
		rows;
	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_DEALERS)
	{
		
	   cache_get_value_name_int(i, "ID", t); 
       Iter_Add(DealerLoop,t);
       
       cache_get_value_name_int(i, "dSkin", dInfo[t][dSkin]);

       cache_get_value_name_float(i, "dX", dInfo[t][dX]);
       cache_get_value_name_float(i, "dY", dInfo[t][dY]);
       cache_get_value_name_float(i, "dZ", dInfo[t][dZ]);

       cache_get_value_name_float(i, "dAngle", dInfo[t][dAngle]);

       format(string,sizeof(string),"[Weapon Factory %i]\n{FFFFFF}/wf para acessar.", t);
	   dInfo[t][ActorID] = CreateActor(dInfo[t][dSkin], dInfo[t][dX], dInfo[t][dY], dInfo[t][dZ], dInfo[t][dAngle]);
   	   dInfo[t][Label] = Create3DTextLabel(string, COLOR_DARKBLUE,dInfo[t][dX],dInfo[t][dY],dInfo[t][dZ]+0.4, 5.0,0, 0);

	   cache_get_value_name_int(i, "Weapon1", dInfo[t][Weapon1]);
	   cache_get_value_name_int(i, "Weapon2", dInfo[t][Weapon2]);
	   cache_get_value_name_int(i, "Weapon3", dInfo[t][Weapon3]);
	   cache_get_value_name_int(i, "Weapon4", dInfo[t][Weapon4]);
	   cache_get_value_name_int(i, "Weapon5", dInfo[t][Weapon5]);
	   cache_get_value_name_int(i, "Weapon6", dInfo[t][Weapon6]);
	   cache_get_value_name_int(i, "Weapon7", dInfo[t][Weapon7]);
	   cache_get_value_name_int(i, "Weapon8", dInfo[t][Weapon8]);
	   cache_get_value_name_int(i, "Weapon9", dInfo[t][Weapon9]);
	   cache_get_value_name_int(i, "Weapon10", dInfo[t][Weapon10]);
	   
	   cache_get_value_name_int(i, "Cost1", dInfo[t][Cost1]);
	   cache_get_value_name_int(i, "Cost2", dInfo[t][Cost2]);
	   cache_get_value_name_int(i, "Cost3", dInfo[t][Cost3]);
	   cache_get_value_name_int(i, "Cost4", dInfo[t][Cost4]);
	   cache_get_value_name_int(i, "Cost5", dInfo[t][Cost5]);
	   cache_get_value_name_int(i, "Cost6", dInfo[t][Cost6]);
	   cache_get_value_name_int(i, "Cost7", dInfo[t][Cost7]);
	   cache_get_value_name_int(i, "Cost8", dInfo[t][Cost8]);
	   cache_get_value_name_int(i, "Cost9", dInfo[t][Cost9]);
	   cache_get_value_name_int(i, "Cost10", dInfo[t][Cost10]);

	   cache_get_value_name_int(i, "Ammo1", dInfo[t][Ammo1]);
	   cache_get_value_name_int(i, "Ammo2", dInfo[t][Ammo2]);
	   cache_get_value_name_int(i, "Ammo3", dInfo[t][Ammo3]);
	   cache_get_value_name_int(i, "Ammo4", dInfo[t][Ammo4]);
	   cache_get_value_name_int(i, "Ammo5", dInfo[t][Ammo5]);
	   cache_get_value_name_int(i, "Ammo6", dInfo[t][Ammo6]);
	   cache_get_value_name_int(i, "Ammo7", dInfo[t][Ammo7]);
	   cache_get_value_name_int(i, "Ammo8", dInfo[t][Ammo8]);
	   cache_get_value_name_int(i, "Ammo9", dInfo[t][Ammo9]);
	   cache_get_value_name_int(i, "Ammo10", dInfo[t][Ammo10]);
    }
	printf("FACTION SYSTEM: %d weapon factorys foram carregadas.", rows);
	return 1;
}

CreateDealer(Skin, Float:X, Float:Y, Float:Z, Float:Angle, World)
{
    new FreeID = Iter_Free(DealerLoop),string[55];
    format(string,sizeof(string),"[Weapon Factory %i]\n\n/wf para acessar.", FreeID);
    Iter_Add(DealerLoop, FreeID);
    dInfo[FreeID][dAngle] = Angle;
	dInfo[FreeID][dWorld] = World;
	dInfo[FreeID][dSkin] = Skin;
    dInfo[FreeID][dX] = X,dInfo[FreeID][dY] = Y,dInfo[FreeID][dZ] = Z;
    dInfo[FreeID][Weapon1] = dInfo[FreeID][Weapon2] = dInfo[FreeID][Weapon3] = dInfo[FreeID][Weapon4] = dInfo[FreeID][Weapon5] =
    dInfo[FreeID][Weapon6] = dInfo[FreeID][Weapon7] = dInfo[FreeID][Weapon8] = dInfo[FreeID][Weapon9] = dInfo[FreeID][Weapon10] = -1;
	dInfo[FreeID][ActorID] = CreateActor(Skin, X, Y, Z, Angle);
	SetActorVirtualWorld(dInfo[FreeID][ActorID], World);
	dInfo[FreeID][Label] = Create3DTextLabel(string, -1,dInfo[FreeID][dX],dInfo[FreeID][dY],dInfo[FreeID][dZ]+0.4, 5.0,0, 0);

    mysql_format(DBConn, query, sizeof(query), "INSERT INTO `dealers` (`ID`, `dSkin`, `dX`, `dY`, `dZ`, `dAngle`, `Weapon1`, `Weapon2` , `Weapon3`, `Weapon4`, `Weapon5`, `Weapon6`, `Weapon7`, `Weapon8`, `Weapon9`, `Weapon10`) VALUES ('%i', '%i', '%f', '%f', \
	'%f', '%f', '%i', '%i', '%i','%i', '%i', '%i', '%i', '%i', '%i', '%i')",
	FreeID,dInfo[FreeID][dSkin],dInfo[FreeID][dX],dInfo[FreeID][dY],dInfo[FreeID][dZ],dInfo[FreeID][dAngle],dInfo[FreeID][Weapon1],dInfo[FreeID][Weapon2],dInfo[FreeID][Weapon3],dInfo[FreeID][Weapon4],dInfo[FreeID][Weapon5],dInfo[FreeID][Weapon6],dInfo[FreeID][Weapon7],dInfo[FreeID][Weapon8],dInfo[FreeID][Weapon9],dInfo[FreeID][Weapon10]);
    mysql_tquery(DBConn, query, "","");
}

RemoveDealer(dealerid)
{
    Iter_Remove(DealerLoop, dealerid);
    DestroyActor(dInfo[dealerid][ActorID]);
    Delete3DTextLabel(dInfo[dealerid][Label]);
    dInfo[dealerid][Weapon1] = dInfo[dealerid][Weapon2] = dInfo[dealerid][Weapon3] = dInfo[dealerid][Weapon4] = dInfo[dealerid][Weapon5] =
    dInfo[dealerid][Weapon6] = dInfo[dealerid][Weapon7] = dInfo[dealerid][Weapon8] = dInfo[dealerid][Weapon9] = dInfo[dealerid][Weapon10] = -1;
    mysql_format(DBConn,query,sizeof(query),"DELETE FROM `dealers` WHERE `ID` ='%i'",dealerid);
 	mysql_tquery(DBConn,query,"","");
}

UpdateDealers(i,updateid)
{
	switch(updateid)
	{
	    case 0:
		{
    		mysql_format(DBConn, query, sizeof(query), "UPDATE `dealers` SET `Weapon1` ='%i' , `Weapon2` ='%i' , `Weapon3` ='%i' , `Weapon4` ='%i', `Weapon5` = '%i', `Weapon6` ='%i', `Weapon7` ='%i', `Weapon8` ='%i', `Weapon9` ='%i', `Weapon10` ='%i' WHERE `ID` = '%i'",
			dInfo[i][Weapon1],dInfo[i][Weapon2],dInfo[i][Weapon3],dInfo[i][Weapon4],dInfo[i][Weapon5],dInfo[i][Weapon6],dInfo[i][Weapon7],dInfo[i][Weapon8],dInfo[i][Weapon9],dInfo[i][Weapon10],i);
            mysql_tquery(DBConn,query,"","");
		}
		case 1:
		{
            mysql_format(DBConn, query, sizeof(query), "UPDATE `dealers` SET `Ammo1` ='%i' , `Ammo2` ='%i' , `Ammo3` ='%i' , `Ammo4` ='%i', `Ammo5` = '%i', `Ammo6` ='%i', `Ammo7` ='%i', `Ammo8` ='%i', `Ammo9` ='%i', `Ammo10` ='%i' WHERE `ID` = '%i'",
			dInfo[i][Ammo1],dInfo[i][Ammo2],dInfo[i][Ammo3],dInfo[i][Ammo4],dInfo[i][Ammo5],dInfo[i][Ammo6],dInfo[i][Ammo7],dInfo[i][Ammo8],dInfo[i][Ammo9],dInfo[i][Ammo10],i);
            mysql_tquery(DBConn,query,"","");
		}
		case 2:
		{
		    mysql_format(DBConn, query, sizeof(query), "UPDATE `dealers` SET `Cost1` ='%i' , `Cost2` ='%i' , `Cost3` ='%i' , `Cost4` ='%i', `Cost5` = '%i', `Cost6` ='%i', `Cost7` ='%i', `Cost8` ='%i', `Cost9` ='%i', `Cost10` ='%i' WHERE `ID` = '%i'",
			dInfo[i][Cost1],dInfo[i][Cost2],dInfo[i][Cost3],dInfo[i][Cost4],dInfo[i][Cost5],dInfo[i][Cost6],dInfo[i][Cost7],dInfo[i][Cost8],dInfo[i][Cost9],dInfo[i][Cost10],i);
            mysql_tquery(DBConn, query,"","");
		}
	}
}

ShowWeaps(playerid,dealerid)
{
	new i[1043],z,x,y;
	format(i,sizeof(i),"Arma\tMateriais\tMunições\n");
	for(new p = 2; p < 12; p++)
	{
	    if(dInfo[dealerid][WeapDealers:p] != -1)
	    {
	        z = p+10;
	        x = p+20;
	        pInfo[playerid][CurrentCost][y] = dInfo[dealerid][WeapDealers:z];
	        pInfo[playerid][CurrentAmmo][y] = dInfo[dealerid][WeapDealers:x];
	        pInfo[playerid][CurrentItem][y] = dInfo[dealerid][WeapDealers:p];
	        format(i,sizeof(i),"%s{FFFFFF}%s\t{00FF00}%i\t{FFFFFF}%i\n",i,GetWeaponNameEx(dInfo[dealerid][WeapDealers:p]),dInfo[dealerid][WeapDealers:z],dInfo[dealerid][WeapDealers:x]);
            y++;
		}
	}
	if(y == 0) return SendErrorMessage(playerid, "Essa fábrica não tem armas.");
	ShowPlayerDialog(playerid, DIALOG_WEAPONS, DIALOG_STYLE_TABLIST_HEADERS, "Comprar Arma",i,"Selecionar","Cancelar");
	return 1;
}

GetWeaponNameEx(weaponid)
{
	new weaponna[32];
    switch(weaponid)
    {
        case 18: weaponna = "Molotov";
        case 44: weaponna = "Óculos de Visão Noturna";
        case 45: weaponna = "Óculos de Visão Térmica";
        default: GetWeaponName(weaponid, weaponna, sizeof(weaponna));
    }
    return weaponna;
}

// COMANDOS
CMD:wf(playerid)
{
    if (GetFactionType(playerid) != FACTION_GANG)
	    return SendErrorMessage(playerid, "Você não é membro de uma facção ilegal.");

	new count;
	foreach(new i: DealerLoop)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1.5, dInfo[i][dX], dInfo[i][dY], dInfo[i][dZ]))
		{
			pInfo[playerid][CurrentDealer] = i;
			count++;
		}
	}
	if(count == 0) return SendErrorMessage(playerid, "Você não está perto de nenhuma Weapon Factory.");
	ShowWeaps(playerid, pInfo[playerid][CurrentDealer]);
	return 1;
}

CMD:wfmenu(playerid)
{
	if (uInfo[playerid][uFactionMod] < 1) return SendPermissionMessage(playerid);

	if (uInfo[playerid][uAdmin] < 4) return SendPermissionMessage(playerid);

	new count, string[2048];
	foreach(new c: DealerLoop)
	{
		count++;
	}
	format(string,sizeof(string),"%s» Destruir Weapon Factory por ID\n{FFFFFF}» Destruir Weapon Factory próximo\n» Resetar Weapon Factory mais próxima\n» Criar Weapon Factory\n» Ir Weapon Factory\n» Editar Weapon Factory",string);
	ShowPlayerDialog(playerid, DIALOG_ADMDEALER, DIALOG_STYLE_LIST, "Weapon Factory",string, "Selecionar", "Cancelar");
	return 1;
}


CMD:darmaterial(playerid, params[])
{
	static
		userid,
	    amount;

	if (uInfo[playerid][uFactionMod] < 1)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (uInfo[playerid][uAdmin] < 4)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "ud", userid, amount))
		return SendUsageMessage(playerid, "/darmaterial [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	GiveMaterial(userid, amount);

	format(textdc, sizeof(textdc), "AdmCmd: %s deu %s materiais para %s.", pNome(playerid), FormatNumber(amount), pNome(userid));
	admin_chat(VERMELHO, textdc, 1);

    format(textdc, sizeof textdc, "`LOG-MATERIAL:` [%s] %s **%s** *(%s)* deu **%s** materiais para **%s** *(%s)*.", 
	ReturnDate(), AdminRankName(playerid), pNome(playerid), pInfo[playerid][pUser], FormatNumber(amount), pNome(userid), PlayerIP(userid));
	discord(DC_LogFac, textdc);
	return 1;
}

CMD:materiais(playerid, params[])
{
	if(pInfo[playerid][pMaterial] == 0) return SendServerMessage(playerid, "Você não possui materiais.");
	va_SendClientMessage(playerid, COLOR_WHITE, "SERVER: Você possui %s materiais disponíveis.", FormatNumber(pInfo[playerid][pMaterial]));
	return 1;
}