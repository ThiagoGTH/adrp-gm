/*  c_pickup.inc
 *
 *  (c) Copyright 2016, Emilijo "Correlli" Lovrich
 *
 *  Credits: - Incognito for streamer plugin,
 *			 - Y_Less for foreach/iterator.
*/

#define MAX_PICKUP_CIRCLES														(20)
#define MAX_CIRCLE_PICKUPS														(360)

#define C_PCK_X_POS																(0)
#define C_PCK_Y_POS																(1)
#define C_PCK_Z_POS																(2)
#define C_PCK_RAD																(3)
#define C_PCK_DIFF																(4)
#define C_PCK_STREAM															(5)

//#define C_PCK_DBG_MSG

enum DataPickup
{
	Model,
	Type,
	World,
	Interior,
	Float:Property_Float[6],
	Pickup[MAX_CIRCLE_PICKUPS],
	Count
}

new
		PickupData[MAX_PICKUP_CIRCLES][DataPickup], Iterator:Circle_Pickup<MAX_PICKUP_CIRCLES>;

stock Pickup_CreateCircle(model, type, Float:x_pos, Float:y_pos, Float:z_pos, Float:radius, Float:diff, world = -1, interior = -1, Float:d_stream = 200.0)
{
	new
			c_id = Iter_Free(Circle_Pickup);
	if(c_id == -1)
		return -1;

	Pickup_CircleFixType(type);
	Pickup_CircleFixDiff(diff);

	Iter_Add(Circle_Pickup, c_id);

	PickupData[c_id][Model]							=				model;
	PickupData[c_id][Type]							=				 type;
	PickupData[c_id][World]							=				world;
	PickupData[c_id][Interior]						=			 interior;
	PickupData[c_id][Property_Float][C_PCK_X_POS]	=				x_pos;
	PickupData[c_id][Property_Float][C_PCK_Y_POS]	=				y_pos;
	PickupData[c_id][Property_Float][C_PCK_Z_POS]	=				z_pos;
	PickupData[c_id][Property_Float][C_PCK_RAD]		=			   radius;
	PickupData[c_id][Property_Float][C_PCK_DIFF]	=				 diff;
	PickupData[c_id][Property_Float][C_PCK_STREAM]	=			 d_stream;

	for(new a = 0; a < MAX_CIRCLE_PICKUPS; a++)
		PickupData[c_id][Pickup][a]					=			   0xFFFF;

	Pickup_UpdateCircle(c_id);
	return c_id;
}

stock Pickup_DestroyCircle(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	new
			a;

	Iter_Remove(Circle_Pickup, c_id);

	PickupData[c_id][Model]							=					0;
	PickupData[c_id][Type]							=					0;
	PickupData[c_id][World]							=					0;
	PickupData[c_id][Interior]						=					0;
	for(a = 0; a < 6; a++)
		PickupData[c_id][Property_Float][a]			=				  0.0;
	for(a = 0; a < PickupData[c_id][Count]; a++)
	{
		if(IsValidDynamicPickup(PickupData[c_id][Pickup][a]))
		{
			DestroyDynamicPickup(PickupData[c_id][Pickup][a]);
			PickupData[c_id][Pickup][a]				=			   0xFFFF;
		}
	}
	PickupData[c_id][Count]							=					0;
	return true;
}

stock Pickup_SetCircleModel(c_id, model, Float:radius, Float:diff)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	for(new a = 0; a < PickupData[c_id][Count]; a++)
	{
		if(IsValidDynamicPickup(PickupData[c_id][Pickup][a]))
			Streamer_SetIntData(STREAMER_TYPE_PICKUP, PickupData[c_id][Pickup][a], E_STREAMER_MODEL_ID, model);
	}

	Pickup_CircleFixDiff(diff);

	PickupData[c_id][Model]							=				model;
	PickupData[c_id][Property_Float][C_PCK_RAD]		=			   radius;
	PickupData[c_id][Property_Float][C_PCK_DIFF]	=				 diff;

	Pickup_UpdateCircle(c_id);
	return true;
}

stock Pickup_GetCircleModel(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;
	return PickupData[c_id][Model];
}

stock Float:Pickup_GetCircleRadius(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return -1.0;
	return PickupData[c_id][Property_Float][C_PCK_RAD];
}

stock Float:Pickup_GetCircleDiff(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return -1.0;
	return PickupData[c_id][Property_Float][C_PCK_DIFF];
}

stock Pickup_SetCircleType(c_id, type)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	Pickup_CircleFixType(type);

	for(new a = 0; a < PickupData[c_id][Count]; a++)
	{
		if(IsValidDynamicPickup(PickupData[c_id][Pickup][a]))
			Streamer_SetIntData(STREAMER_TYPE_PICKUP, PickupData[c_id][Pickup][a], E_STREAMER_TYPE, type);
	}

	PickupData[c_id][Type] = type;
	return true;
}

stock Pickup_GetCircleType(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return -1;
	return PickupData[c_id][Type];
}

stock Pickup_SetCirclePos(c_id, Float:x_pos, Float:y_pos, Float:z_pos)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	PickupData[c_id][Property_Float][C_PCK_X_POS] = x_pos;
	PickupData[c_id][Property_Float][C_PCK_Y_POS] = y_pos;
	PickupData[c_id][Property_Float][C_PCK_Z_POS] = z_pos;

	Pickup_UpdateCircle(c_id);
	return true;
}

stock Pickup_GetCirclePos(c_id, &Float:x_pos, &Float:y_pos, &Float:z_pos)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	x_pos = PickupData[c_id][Property_Float][C_PCK_X_POS];
	y_pos = PickupData[c_id][Property_Float][C_PCK_Y_POS];
	z_pos = PickupData[c_id][Property_Float][C_PCK_Z_POS];
	return true;
}

stock Pickup_SetCircleStreamDistance(c_id, Float:d_stream)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	for(new a = 0; a < PickupData[c_id][Count]; a++)
	{
		if(IsValidDynamicPickup(PickupData[c_id][Pickup][a]))
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, PickupData[c_id][Pickup][a], E_STREAMER_STREAM_DISTANCE, d_stream);
	}

	PickupData[c_id][Property_Float][C_PCK_STREAM] = d_stream;
	return true;
}

stock Float:Pickup_GetCircleStreamDistance(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return 0.0;
	return PickupData[c_id][Property_Float][C_PCK_STREAM];
}

stock Pickup_SetCircleWorld(c_id, world)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	for(new a = 0; a < PickupData[c_id][Count]; a++)
	{
		if(IsValidDynamicPickup(PickupData[c_id][Pickup][a]))
			Streamer_SetIntData(STREAMER_TYPE_PICKUP, PickupData[c_id][Pickup][a], E_STREAMER_WORLD_ID, world);
	}

	PickupData[c_id][World] = world;
	return true;
}

stock Pickup_GetCircleWorld(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return -2;
	return PickupData[c_id][World];
}

stock Pickup_SetCircleInterior(c_id, interior)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	for(new a = 0; a < PickupData[c_id][Count]; a++)
	{
		if(IsValidDynamicPickup(PickupData[c_id][Pickup][a]))
			Streamer_SetIntData(STREAMER_TYPE_PICKUP, PickupData[c_id][Pickup][a], E_STREAMER_INTERIOR_ID, interior);
	}

	PickupData[c_id][Interior] = interior;
	return true;
}

stock Pickup_GetCircleInterior(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return -2;
	return PickupData[c_id][Interior];
}

stock Pickup_GetCircleCount(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;
	return PickupData[c_id][Count];
}

stock Pickup_UpdateCircle(c_id)
{
	if(!Iter_Contains(Circle_Pickup, c_id))
		return false;

	new
			a, count, Float:coord[3];

	for(a = 0; a < 360; a++)
	{
		coord[0] = (PickupData[c_id][Property_Float][C_PCK_X_POS] + (PickupData[c_id][Property_Float][C_PCK_RAD] * floatcos(coord[2], degrees)));
		coord[1] = (PickupData[c_id][Property_Float][C_PCK_Y_POS] + (PickupData[c_id][Property_Float][C_PCK_RAD] * floatsin(coord[2], degrees)));

		if(IsValidDynamicPickup(PickupData[c_id][Pickup][count]))
			DestroyDynamicPickup(PickupData[c_id][Pickup][count]);

		PickupData[c_id][Pickup][count] = CreateDynamicPickup(
			PickupData[c_id][Model],
			PickupData[c_id][Type],
			coord[0],
			coord[1],
			PickupData[c_id][Property_Float][C_PCK_Z_POS],
			PickupData[c_id][World],
			PickupData[c_id][Interior],
			.streamdistance = PickupData[c_id][Property_Float][C_PCK_STREAM]
		);

		count++;

		coord[2] += PickupData[c_id][Property_Float][C_PCK_DIFF];
		if(!(coord[2] < 360.0))
			break;
	}

	if(count < PickupData[c_id][Count])
	{
		for(a = count; a < MAX_CIRCLE_PICKUPS; a++)
		{
			if(IsValidDynamicPickup(PickupData[c_id][Pickup][a]))
			{
				DestroyDynamicPickup(PickupData[c_id][Pickup][a]);
				PickupData[c_id][Pickup][a] = 0xFFFF;
			}
		}
	}

	PickupData[c_id][Count] = count;

	#if defined C_PCK_DBG_MSG
		printf("Created/updated %i pickups at \"Pickup_UpdateCircle\" function for model %i (circle ID: %i).",
			count,
			PickupData[c_id][Model],
			c_id
		);
	#endif
	return count;
}

stock Pickup_CircleFixType(&type)
{
	if(type == 0)
		type = 1;
}

stock Pickup_CircleFixDiff(&Float:diff)
{
	if(diff < 1.0)
		diff = 1.0;
}
