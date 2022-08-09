/*  c_mapicon.inc
 *
 *  (c) Copyright 2016, Emilijo "Correlli" Lovrich
 *
 *  Credits: - Incognito for streamer plugin,
 *			 - Y_Less for foreach/iterator.
*/

#define MAX_MAPICON_CIRCLES														(20)
#define MAX_CIRCLE_MAPICONS														(360)

#define C_MPC_X_POS																(0)
#define C_MPC_Y_POS																(1)
#define C_MPC_Z_POS																(2)
#define C_MPC_RAD																(3)
#define C_MPC_DIFF																(4)
#define C_MPC_STREAM															(5)

//#define C_MPC_DBG_MSG

enum DataMapIcon
{
	Type,
	Color,
	World,
	Interior,
	Style,
	Float:Property_Float[6],
	MapIcon[MAX_CIRCLE_MAPICONS],
	Count
}

new
		MapIconData[MAX_MAPICON_CIRCLES][DataMapIcon], Iterator:Circle_MapIcon<MAX_MAPICON_CIRCLES>;

stock MapIcon_CreateCircle(Float:x_pos, Float:y_pos, Float:z_pos, type, color, Float:radius, Float:diff, world = -1, interior = -1, Float:d_stream = 150.0, style = MAPICON_LOCAL)
{
	new
			c_id = Iter_Free(Circle_MapIcon);
	if(c_id == -1)
		return -1;

	MapIcon_CircleFixDiff(diff);

	Iter_Add(Circle_MapIcon, c_id);

	MapIconData[c_id][Type]							=				 type;
	MapIconData[c_id][Color]						=				color;
	MapIconData[c_id][World]						=				world;
	MapIconData[c_id][Interior]						=			 interior;
	MapIconData[c_id][Style]						=				style;
	MapIconData[c_id][Property_Float][C_MPC_X_POS]	=				x_pos;
	MapIconData[c_id][Property_Float][C_MPC_Y_POS]	=				y_pos;
	MapIconData[c_id][Property_Float][C_MPC_Z_POS]	=				z_pos;
	MapIconData[c_id][Property_Float][C_MPC_RAD]	=			   radius;
	MapIconData[c_id][Property_Float][C_MPC_DIFF]	=				 diff;
	MapIconData[c_id][Property_Float][C_MPC_STREAM]	=			 d_stream;

	for(new a = 0; a < MAX_CIRCLE_MAPICONS; a++)
		MapIconData[c_id][MapIcon][a]				=			   0xFFFF;

	MapIcon_UpdateCircle(c_id);
	return c_id;
}

stock MapIcon_DestroyCircle(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	new
			a;

	Iter_Remove(Circle_MapIcon, c_id);

	MapIconData[c_id][Type]							=					0;
	MapIconData[c_id][Color]						=					0;
	MapIconData[c_id][World]						=					0;
	MapIconData[c_id][Interior]						=					0;
	MapIconData[c_id][Style]						=					0;
	for(a = 0; a < 6; a++)
		MapIconData[c_id][Property_Float][a]		=				  0.0;
	for(a = 0; a < MapIconData[c_id][Count]; a++)
	{
		if(IsValidDynamicMapIcon(MapIconData[c_id][MapIcon][a]))
		{
			DestroyDynamicMapIcon(MapIconData[c_id][MapIcon][a]);
			MapIconData[c_id][MapIcon][a]			=			   0xFFFF;
		}
	}
	MapIconData[c_id][Count]						=					0;
	return true;
}

stock MapIcon_SetCircleType(c_id, type, Float:radius, Float:diff)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	for(new a = 0; a < MapIconData[c_id][Count]; a++)
	{
		if(IsValidDynamicMapIcon(MapIconData[c_id][MapIcon][a]))
			Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, MapIconData[c_id][MapIcon][a], E_STREAMER_TYPE, type);
	}

	MapIcon_CircleFixDiff(diff);

	MapIconData[c_id][Type]							=				 type;
	MapIconData[c_id][Property_Float][C_MPC_RAD]	=			   radius;
	MapIconData[c_id][Property_Float][C_MPC_DIFF]	=				 diff;

	MapIcon_UpdateCircle(c_id);
	return true;
}

stock MapIcon_GetCircleType(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return -1;
	return MapIconData[c_id][Type];
}

stock Float:MapIcon_GetCircleRadius(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return -1.0;
	return MapIconData[c_id][Property_Float][C_MPC_RAD];
}

stock Float:MapIcon_GetCircleDiff(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return -1.0;
	return MapIconData[c_id][Property_Float][C_MPC_DIFF];
}

stock MapIcon_SetCirclePos(c_id, Float:x_pos, Float:y_pos, Float:z_pos)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	MapIconData[c_id][Property_Float][C_MPC_X_POS] = x_pos;
	MapIconData[c_id][Property_Float][C_MPC_Y_POS] = y_pos;
	MapIconData[c_id][Property_Float][C_MPC_Z_POS] = z_pos;

	MapIcon_UpdateCircle(c_id);
	return true;
}

stock MapIcon_GetCirclePos(c_id, &Float:x_pos, &Float:y_pos, &Float:z_pos)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	x_pos = MapIconData[c_id][Property_Float][C_MPC_X_POS];
	y_pos = MapIconData[c_id][Property_Float][C_MPC_Y_POS];
	z_pos = MapIconData[c_id][Property_Float][C_MPC_Z_POS];
	return true;
}

stock MapIcon_SetCircleStreamDistance(c_id, Float:d_stream)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	for(new a = 0; a < MapIconData[c_id][Count]; a++)
	{
		if(IsValidDynamicMapIcon(MapIconData[c_id][MapIcon][a]))
			Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, MapIconData[c_id][MapIcon][a], E_STREAMER_STREAM_DISTANCE, d_stream);
	}

	MapIconData[c_id][Property_Float][C_MPC_STREAM] = d_stream;
	return true;
}

stock Float:MapIcon_GetCircleStreamDistance(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return 0.0;
	return MapIconData[c_id][Property_Float][C_MPC_STREAM];
}

stock MapIcon_SetCircleWorld(c_id, world)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	for(new a = 0; a < MapIconData[c_id][Count]; a++)
	{
		if(IsValidDynamicMapIcon(MapIconData[c_id][MapIcon][a]))
			Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, MapIconData[c_id][MapIcon][a], E_STREAMER_WORLD_ID, world);
	}

	MapIconData[c_id][World] = world;
	return true;
}

stock MapIcon_GetCircleWorld(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return -2;
	return MapIconData[c_id][World];
}

stock MapIcon_SetCircleInterior(c_id, interior)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	for(new a = 0; a < MapIconData[c_id][Count]; a++)
	{
		if(IsValidDynamicMapIcon(MapIconData[c_id][MapIcon][a]))
			Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, MapIconData[c_id][MapIcon][a], E_STREAMER_INTERIOR_ID, interior);
	}

	MapIconData[c_id][Interior] = interior;
	return true;
}

stock MapIcon_GetCircleInterior(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return -2;
	return MapIconData[c_id][Interior];
}

stock MapIcon_SetCircleStyle(c_id, style)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	for(new a = 0; a < MapIconData[c_id][Count]; a++)
	{
		if(IsValidDynamicMapIcon(MapIconData[c_id][MapIcon][a]))
			Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, MapIconData[c_id][MapIcon][a], E_STREAMER_STYLE, style);
	}

	MapIconData[c_id][Style] = style;
	return true;
}

stock MapIcon_GetCircleStyle(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return -1;
	return MapIconData[c_id][Style];
}

stock MapIcon_GetCircleCount(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;
	return MapIconData[c_id][Count];
}

stock MapIcon_UpdateCircle(c_id)
{
	if(!Iter_Contains(Circle_MapIcon, c_id))
		return false;

	new
			a, count, Float:coord[3];

	for(a = 0; a < 360; a++)
	{
		coord[0] = (MapIconData[c_id][Property_Float][C_MPC_X_POS] + (MapIconData[c_id][Property_Float][C_MPC_RAD] * floatcos(coord[2], degrees)));
		coord[1] = (MapIconData[c_id][Property_Float][C_MPC_Y_POS] + (MapIconData[c_id][Property_Float][C_MPC_RAD] * floatsin(coord[2], degrees)));

		if(IsValidDynamicMapIcon(MapIconData[c_id][MapIcon][count]))
			DestroyDynamicMapIcon(MapIconData[c_id][MapIcon][count]);

		MapIconData[c_id][MapIcon][count] = CreateDynamicMapIcon(
			coord[0],
			coord[1],
			MapIconData[c_id][Property_Float][C_MPC_Z_POS],
			MapIconData[c_id][Type],
			MapIconData[c_id][Color],
			MapIconData[c_id][World],
			MapIconData[c_id][Interior],
			.streamdistance = MapIconData[c_id][Property_Float][C_MPC_STREAM],
			.style = MapIconData[c_id][Style]
		);

		count++;

		coord[2] += MapIconData[c_id][Property_Float][C_MPC_DIFF];
		if(!(coord[2] < 360.0))
			break;
	}

	if(count < MapIconData[c_id][Count])
	{
		for(a = count; a < MAX_CIRCLE_MAPICONS; a++)
		{
			if(IsValidDynamicMapIcon(MapIconData[c_id][MapIcon][a]))
			{
				DestroyDynamicMapIcon(MapIconData[c_id][MapIcon][a]);
				MapIconData[c_id][MapIcon][a] = 0xFFFF;
			}
		}
	}

	MapIconData[c_id][Count] = count;

	#if defined C_MPC_DBG_MSG
		printf("Created/updated %i map icons at \"MapIcon_UpdateCircle\" function for type %i (circle ID: %i).",
			count,
			MapIconData[c_id][Type],
			c_id
		);
	#endif
	return count;
}

stock MapIcon_CircleFixDiff(&Float:diff)
{
	if(diff < 1.0)
		diff = 1.0;
}
