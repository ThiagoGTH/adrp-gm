/*  c_textdraw.inc
 *
 *  (c) Copyright 2016, Emilijo "Correlli" Lovrich
 *
 *  Credits: - Y_Less for foreach/iterator.
*/

#define TD_CIRCLE_TIMER_INTERVAL												(100)

//#define C_TD_DBG_MSG

enum Data_Circle_TD
{
	Count,
	PlayerText:cTextDraw[MAX_PLAYER_TEXT_DRAWS],
	Color[2],
	Speed[2],
	Slot
}

new
		TD_Circle_Data[MAX_PLAYERS][Data_Circle_TD], Iterator:Player_Circle_TD<MAX_PLAYERS>, g_TD_Circle_Timer;

static
		bool:gFunc = false;

forward OnPlayerCircleFinish(playerid);

stock TD_CreateCircle(playerid, text[], color, Float:x_pos, Float:y_pos, Float:radius, Float:diff)
{
	if(TD_Circle_Data[playerid][Count])
		return false;

	TD_CircleFixDiff(diff);

	y_pos -= 20.0;

	new
			count[2], Float:rot;

	for(new a = 0; a < 360; a++)
	{
		rot += diff;
		count[0]++;
		if(!(rot < 360.0))
			break;
	}

	rot = 0.0;
	for(new a = 0; a < 360; a++)
	{
		if(count[1] == MAX_PLAYER_TEXT_DRAWS)
		{
			printf("Error at \"TD_CreateCircle\" function for text \"%s\" (player ID: %i) - limit is reached (%i/%i).",
				text,
				playerid,
				count[0],
				MAX_PLAYER_TEXT_DRAWS
			);
			break;
		}

		if(!CreateTD(
			playerid,
			text,
			color,
			a,
			(x_pos + (radius * floatcos(rot + 270.0, degrees))),
			(y_pos + (radius * floatsin(rot + 270.0, degrees)))
		))
		{
			printf("Error at \"TD_CreateCircle\" function for text \"%s\" (player ID: %i) - limit is reached (%i/%i).",
				text,
				playerid,
				count[0],
				MAX_PLAYER_TEXT_DRAWS
			);
			break;
		}

		count[1]++;

		rot += diff;
		if(!(rot < 360.0))
			break;
	}

	TD_Circle_Data[playerid][Count]		=	count[1];
	TD_Circle_Data[playerid][Color][0]  =	   color;

	#if defined C_TD_DBG_MSG
		printf("TD_CreateCircle(playerid: %i, count: %i);", playerid, count[1]);
	#endif
	return true;
}

stock CreateTD(playerid, text[], color, slot, Float:x_pos, Float:y_pos)
{
	TD_Circle_Data[playerid][cTextDraw][slot] = CreatePlayerTextDraw(playerid, x_pos, y_pos, text);
	if(TD_Circle_Data[playerid][cTextDraw][slot] == PlayerText:INVALID_TEXT_DRAW)
		return false;
	PlayerTextDrawFont(playerid,			TD_Circle_Data[playerid][cTextDraw][slot],			1);
	PlayerTextDrawLetterSize(playerid,		TD_Circle_Data[playerid][cTextDraw][slot],	 0.5, 1.0);
	PlayerTextDrawColour(playerid,			TD_Circle_Data[playerid][cTextDraw][slot],		color);
	PlayerTextDrawSetOutline(playerid,		TD_Circle_Data[playerid][cTextDraw][slot],			0);
	PlayerTextDrawSetProportional(playerid,	TD_Circle_Data[playerid][cTextDraw][slot],			1);
	PlayerTextDrawSetShadow(playerid,		TD_Circle_Data[playerid][cTextDraw][slot],			0);
	PlayerTextDrawShow(playerid,			TD_Circle_Data[playerid][cTextDraw][slot]			 );
	return true;
}

stock TD_DestroyCircle(playerid, bool:loop = false)
{
	if(!TD_Circle_Data[playerid][Count])
		return false;

	new
			a;

	TD_Circle_RemoveIter(playerid, loop);

	for(a = 0; a < TD_Circle_Data[playerid][Count]; a++)
		PlayerTextDrawDestroy(playerid, TD_Circle_Data[playerid][cTextDraw][a]);

	TD_Circle_Data[playerid][Count]			=	0;
	for(a = 0; a < 2; a++)
	{
		TD_Circle_Data[playerid][Color][a]	=	0;
		TD_Circle_Data[playerid][Speed][a]	=	0;
	}
	TD_Circle_Data[playerid][Slot]			=	0;
	return true;
}

stock TD_IsCircleCreated(playerid)
	return TD_Circle_Data[playerid][Count];

stock TD_ActivateCircle(playerid, color, speed)
{
	if(!TD_Circle_Data[playerid][Count])
		return false;
	if(Iter_Contains(Player_Circle_TD, playerid))
		return false;

	new
			a;

	for(a = 0; a < TD_Circle_Data[playerid][Count]; a++)
		TD_SetCircleSlotColor(
			playerid,
			a,
			TD_Circle_Data[playerid][Color][0]
		)
	;

	if(speed < 1)
		speed = 1;

	TD_Circle_AddIter(playerid);

	TD_Circle_Data[playerid][Color][1]		=	color;
	for(a = 0; a < 2; a++)
		TD_Circle_Data[playerid][Speed][a]	=	speed;
	TD_Circle_Data[playerid][Slot]			=		0;
	return true;
}

stock TD_StopCircle(playerid)
{
	if(!TD_Circle_Data[playerid][Count])
		return false;
	if(!Iter_Contains(Player_Circle_TD, playerid))
		return false;

	new
			a;

	TD_Circle_RemoveIter(playerid);

	TD_Circle_Data[playerid][Color][1]		=		0;
	for(a = 0; a < 2; a++)
		TD_Circle_Data[playerid][Speed][a]	=		0;
	TD_Circle_Data[playerid][Slot]			=		0;

	for(a = 0; a < TD_Circle_Data[playerid][Count]; a++)
		TD_SetCircleSlotColor(
			playerid,
			a,
			TD_Circle_Data[playerid][Color][0]
		)
	;
	return true;
}

stock TD_ResumeCircle(playerid)
{
	if(!TD_Circle_Data[playerid][Count])
		return false;
	if(Iter_Contains(Player_Circle_TD, playerid))
		return false;
	if(!TD_Circle_Data[playerid][Color][1])
		return false;

	TD_Circle_AddIter(playerid);
	return true;
}

stock TD_PauseCircle(playerid)
{
	if(!TD_Circle_Data[playerid][Count])
		return false;
	if(!Iter_Contains(Player_Circle_TD, playerid))
		return false;

	TD_Circle_RemoveIter(playerid);
	return true;
}

stock TD_SetCircleSlotColor(playerid, slot, color)
{
	PlayerTextDrawColour(
		playerid,
		TD_Circle_Data[playerid][cTextDraw][slot],
		color
	);
	PlayerTextDrawShow(
		playerid,
		TD_Circle_Data[playerid][cTextDraw][slot]
	);
	return true;
}

stock TD_Circle_AddIter(playerid)
{
	if(!Iter_Count(Player_Circle_TD))
		g_TD_Circle_Timer = SetTimer("TD_Circle_Timer", TD_CIRCLE_TIMER_INTERVAL, true);

	Iter_Add(Player_Circle_TD, playerid);
	return true;
}

stock TD_Circle_RemoveIter(playerid, bool:loop = false)
{
	if(Iter_Count(Player_Circle_TD) == 1)
		KillTimer(g_TD_Circle_Timer);

	if(!loop)
		Iter_Remove(Player_Circle_TD, playerid);
	return true;
}

forward TD_Circle_Timer();
public TD_Circle_Timer()
{
	new
			iter_next;
	foreach(Player_Circle_TD, u)
	{
		if(TD_Circle_Data[u][Speed][0] == TD_Circle_Data[u][Speed][1])
		{
			TD_Circle_Data[u][Speed][0] = 0;
			if(TD_Circle_Data[u][Slot] < TD_Circle_Data[u][Count])
			{
				new
						color = TD_Circle_Data[u][Color][1];
				if(color == -1)
					color = GetRandomColor();
				TD_SetCircleSlotColor(
					u,
					TD_Circle_Data[u][Slot],
					color
				);
				TD_Circle_Data[u][Slot]++;
			}
			else
			{
				TD_DestroyCircle(u, true);
				CallLocalFunction("OnPlayerCircleFinish", "i", u);
				Iter_SafeRemove(Player_Circle_TD, u, iter_next);
				u = iter_next;
			}
		}
		else
			TD_Circle_Data[u][Speed][0]++;
	}
	return true;
}

stock TD_CircleFixDiff(&Float:diff)
{
	if(diff < 1.40625)
		diff = 1.40625;
}

stock GetRandomColor()
{
	new
			color;
	switch(random(8))
	{
		case 0: color = 0xFF0000FF;
		case 1: color = 0x00FF00FF;
		case 2: color = 0x0000FFFF;
		case 3: color = 0xFFFF00FF;
		case 4: color = 0xFF00FFFF;
		case 5: color = 0x00FFFFFF;
		case 6: color = 0xF0F0F0FF;
		case 7: color = 0x0F0F0FFF;
	}
	return color;
}

public OnPlayerDisconnect(playerid, reason)
{
	TD_DestroyCircle(playerid);

	if(gFunc)
		CallLocalFunction("TD_Circle_OnPlayerDisconnect", "ii", playerid, reason);
	return true;
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect TD_Circle_OnPlayerDisconnect

forward TD_Circle_OnPlayerDisconnect(playerid, reason);

public OnGameModeInit()
{
	gFunc = (funcidx("TD_Circle_OnPlayerDisconnect") != -1);
	CallLocalFunction("TD_Circle_OnGameModeInit", "");
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit TD_Circle_OnGameModeInit

forward TD_Circle_OnGameModeInit();
