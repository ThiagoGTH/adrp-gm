/*  c_object.inc
 *
 *  (c) Copyright 2016, Emilijo "Correlli" Lovrich
 *
 *  Credits: - Incognito for streamer plugin,
 *			 - Y_Less for foreach/iterator.
*/

#define MAX_OBJECT_CIRCLES														(20)
#define MAX_CIRCLE_OBJECTS														(360)

#define C_OBJ_X_POS																(0)
#define C_OBJ_Y_POS																(1)
#define C_OBJ_Z_POS																(2)
#define C_OBJ_X_ROT																(3)
#define C_OBJ_Y_ROT																(4)
#define C_OBJ_Z_ROT																(5)
#define C_OBJ_RAD																(6)
#define C_OBJ_DIFF																(7)
#define C_OBJ_STREAM															(8)
#define C_OBJ_DRAW																(9)

//#define C_OBJ_DBG_MSG

enum DataObject
{
	Model,
	World,
	Interior,
	Float:Property_Float[10],
	Object[MAX_CIRCLE_OBJECTS],
	Count
}

new
		ObjectData[MAX_OBJECT_CIRCLES][DataObject], Iterator:Circle_Object<MAX_OBJECT_CIRCLES>;

stock Object_CreateCircle(model, Float:x_pos, Float:y_pos, Float:z_pos, Float:x_rot, Float:y_rot, Float:z_rot, Float:radius, Float:diff, world = -1, interior = -1, Float:d_stream = 200.0, Float:d_draw = 0.0)
{
	new
			c_id = Iter_Free(Circle_Object);
	if(c_id == -1)
		return -1;

	Object_CircleFixDiff(diff);

	Iter_Add(Circle_Object, c_id);

	ObjectData[c_id][Model]							=				model;
	ObjectData[c_id][World]							=				world;
	ObjectData[c_id][Interior]						=			 interior;
	ObjectData[c_id][Property_Float][C_OBJ_X_POS]		=				x_pos;
	ObjectData[c_id][Property_Float][C_OBJ_Y_POS]		=				y_pos;
	ObjectData[c_id][Property_Float][C_OBJ_Z_POS]		=				z_pos;
	ObjectData[c_id][Property_Float][C_OBJ_X_ROT]		=				x_rot;
	ObjectData[c_id][Property_Float][C_OBJ_Y_ROT]		=				y_rot;
	ObjectData[c_id][Property_Float][C_OBJ_Z_ROT]		=				z_rot;
	ObjectData[c_id][Property_Float][C_OBJ_RAD]			=			   radius;
	ObjectData[c_id][Property_Float][C_OBJ_DIFF]		=				 diff;
	ObjectData[c_id][Property_Float][C_OBJ_STREAM]		=			 d_stream;
	ObjectData[c_id][Property_Float][C_OBJ_DRAW]		=			   d_draw;

	for(new a = 0; a < MAX_CIRCLE_OBJECTS; a++)
		ObjectData[c_id][Object][a]					=	INVALID_OBJECT_ID;

	Object_UpdateCircle(c_id);
	return c_id;
}

stock Object_DestroyCircle(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	new
			a;

	Iter_Remove(Circle_Object, c_id);

	ObjectData[c_id][Model]							=					0;
	ObjectData[c_id][World]							=					0;
	ObjectData[c_id][Interior]						=					0;
	for(a = 0; a < 10; a++)
		ObjectData[c_id][Property_Float][a]			=				  0.0;
	for(a = 0; a < ObjectData[c_id][Count]; a++)
	{
		if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
		{
			DestroyDynamicObject(ObjectData[c_id][Object][a]);
			ObjectData[c_id][Object][a]				=	INVALID_OBJECT_ID;
		}
	}
	ObjectData[c_id][Count]							=					0;
	return true;
}

stock Object_SetCircleTexture(c_id, m_index, txd_model, txd_name[], texture_name[], m_color = 0)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	for(new a = 0; a < ObjectData[c_id][Count]; a++)
	{
		if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
			SetDynamicObjectMaterial(ObjectData[c_id][Object][a], m_index, txd_model, txd_name, texture_name, m_color);
	}
	return true;
}

stock Object_SetCircleObjectTexture(c_id, slot, m_index, txd_model, txd_name[], texture_name[], m_color = 0)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;
	if(slot < 0 || slot >= MAX_CIRCLE_OBJECTS)
		return false;
	if(!IsValidDynamicObject(ObjectData[c_id][Object][slot]))
		return false;
	SetDynamicObjectMaterial(ObjectData[c_id][Object][slot], m_index, txd_model, txd_name, texture_name, m_color);
	return true;
}

stock Object_SetCircleModel(c_id, model, Float:radius, Float:diff)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	for(new a = 0; a < ObjectData[c_id][Count]; a++)
	{
		if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, ObjectData[c_id][Object][a], E_STREAMER_MODEL_ID, model);
	}

	Object_CircleFixDiff(diff);

	ObjectData[c_id][Model]							=				model;
	ObjectData[c_id][Property_Float][C_OBJ_RAD]		=			   radius;
	ObjectData[c_id][Property_Float][C_OBJ_DIFF]	=				 diff;

	Object_UpdateCircle(c_id);
	return true;
}

stock Object_GetCircleModel(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;
	return ObjectData[c_id][Model];
}

stock Float:Object_GetCircleRadius(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return -1.0;
	return ObjectData[c_id][Property_Float][C_OBJ_RAD];
}

stock Float:Object_GetCircleDiff(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return -1.0;
	return ObjectData[c_id][Property_Float][C_OBJ_DIFF];
}

stock Object_SetCirclePos(c_id, Float:x_pos, Float:y_pos, Float:z_pos)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	ObjectData[c_id][Property_Float][C_OBJ_X_POS] = x_pos;
	ObjectData[c_id][Property_Float][C_OBJ_Y_POS] = y_pos;
	ObjectData[c_id][Property_Float][C_OBJ_Z_POS] = z_pos;

	Object_UpdateCircle(c_id);
	return true;
}

stock Object_GetCirclePos(c_id, &Float:x_pos, &Float:y_pos, &Float:z_pos)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	x_pos = ObjectData[c_id][Property_Float][C_OBJ_X_POS];
	y_pos = ObjectData[c_id][Property_Float][C_OBJ_Y_POS];
	z_pos = ObjectData[c_id][Property_Float][C_OBJ_Z_POS];
	return true;
}

stock Object_SetCircleRot(c_id, Float:x_rot, Float:y_rot, Float:z_rot)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	for(new a = 0; a < ObjectData[c_id][Count]; a++)
	{
		if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
			SetDynamicObjectRot(ObjectData[c_id][Object][a], x_rot, y_rot, z_rot);
	}

	ObjectData[c_id][Property_Float][C_OBJ_X_ROT] = x_rot;
	ObjectData[c_id][Property_Float][C_OBJ_Y_ROT] = y_rot;
	ObjectData[c_id][Property_Float][C_OBJ_Z_ROT] = z_rot;
	return true;
}

stock Object_GetCircleRot(c_id, &Float:x_rot, &Float:y_rot, &Float:z_rot)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	x_rot = ObjectData[c_id][Property_Float][C_OBJ_X_ROT];
	y_rot = ObjectData[c_id][Property_Float][C_OBJ_Y_ROT];
	z_rot = ObjectData[c_id][Property_Float][C_OBJ_Z_ROT];
	return true;
}

stock Object_SetCircleStreamDistance(c_id, Float:d_stream)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	for(new a = 0; a < ObjectData[c_id][Count]; a++)
	{
		if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, ObjectData[c_id][Object][a], E_STREAMER_STREAM_DISTANCE, d_stream);
	}

	ObjectData[c_id][Property_Float][C_OBJ_STREAM] = d_stream;
	return true;
}

stock Float:Object_GetCircleStreamDistance(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return 0.0;
	return ObjectData[c_id][Property_Float][C_OBJ_STREAM];
}

stock Object_SetCircleDrawDistance(c_id, Float:d_draw)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	for(new a = 0; a < ObjectData[c_id][Count]; a++)
	{
		if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, ObjectData[c_id][Object][a], E_STREAMER_DRAW_DISTANCE, d_draw);
	}

	ObjectData[c_id][Property_Float][C_OBJ_DRAW] = d_draw;
	return true;
}

stock Float:Object_GetCircleDrawDistance(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return -1.0;
	return ObjectData[c_id][Property_Float][C_OBJ_DRAW];
}

stock Object_SetCircleWorld(c_id, world)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	for(new a = 0; a < ObjectData[c_id][Count]; a++)
	{
		if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, ObjectData[c_id][Object][a], E_STREAMER_WORLD_ID, world);
	}

	ObjectData[c_id][World] = world;
	return true;
}

stock Object_GetCircleWorld(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return -2;
	return ObjectData[c_id][World];
}

stock Object_SetCircleInterior(c_id, interior)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	for(new a = 0; a < ObjectData[c_id][Count]; a++)
	{
		if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, ObjectData[c_id][Object][a], E_STREAMER_INTERIOR_ID, interior);
	}

	ObjectData[c_id][Interior] = interior;
	return true;
}

stock Object_GetCircleInterior(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return -2;
	return ObjectData[c_id][Interior];
}

stock Object_GetCircleCount(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;
	return ObjectData[c_id][Count];
}

stock Object_UpdateCircle(c_id)
{
	if(!Iter_Contains(Circle_Object, c_id))
		return false;

	new
			a, count, Float:coord[3];

	for(a = 0; a < 360; a++)
	{
		coord[0] = (ObjectData[c_id][Property_Float][C_OBJ_X_POS] + (ObjectData[c_id][Property_Float][C_OBJ_RAD] * floatcos(coord[2], degrees)));
		coord[1] = (ObjectData[c_id][Property_Float][C_OBJ_Y_POS] + (ObjectData[c_id][Property_Float][C_OBJ_RAD] * floatsin(coord[2], degrees)));

		if(!IsValidDynamicObject(ObjectData[c_id][Object][count]))
		{
			ObjectData[c_id][Object][count] = CreateDynamicObject(
				ObjectData[c_id][Model],
				coord[0],
				coord[1],
				ObjectData[c_id][Property_Float][C_OBJ_Z_POS],
				ObjectData[c_id][Property_Float][C_OBJ_X_ROT],
				ObjectData[c_id][Property_Float][C_OBJ_Y_ROT],
				(ObjectData[c_id][Property_Float][C_OBJ_Z_ROT] + coord[2]),
				ObjectData[c_id][World],
				ObjectData[c_id][Interior],
				.streamdistance = ObjectData[c_id][Property_Float][C_OBJ_STREAM],
				.drawdistance = ObjectData[c_id][Property_Float][C_OBJ_DRAW]
			);
		}
		else
		{
			SetDynamicObjectPos(
				ObjectData[c_id][Object][count],
				coord[0],
				coord[1],
				ObjectData[c_id][Property_Float][C_OBJ_Z_POS]
			);

			SetDynamicObjectRot(
				ObjectData[c_id][Object][count],
				ObjectData[c_id][Property_Float][C_OBJ_X_ROT],
				ObjectData[c_id][Property_Float][C_OBJ_Y_ROT],
				(ObjectData[c_id][Property_Float][C_OBJ_Z_ROT] + coord[2])
			);
		}

		count++;

		coord[2] += ObjectData[c_id][Property_Float][C_OBJ_DIFF];
		if(!(coord[2] < 360.0))
			break;
	}

	if(count < ObjectData[c_id][Count])
	{
		for(a = count; a < MAX_CIRCLE_OBJECTS; a++)
		{
			if(IsValidDynamicObject(ObjectData[c_id][Object][a]))
			{
				DestroyDynamicObject(ObjectData[c_id][Object][a]);
				ObjectData[c_id][Object][a] = INVALID_OBJECT_ID;
			}
		}
	}

	ObjectData[c_id][Count] = count;

	#if defined C_OBJ_DBG_MSG
		printf("Created/updated %i objects at \"Object_UpdateCircle\" function for model %i (circle ID: %i).",
			count,
			ObjectData[c_id][Model],
			c_id
		);
	#endif
	return count;
}

stock Object_CircleFixDiff(&Float:diff)
{
	if(diff < 1.0)
		diff = 1.0;
}
