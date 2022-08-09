/*  c_label.inc
 *
 *  (c) Copyright 2016, Emilijo "Correlli" Lovrich
 *
 *  Credits: - Incognito for streamer plugin,
 *			 - Y_Less for foreach/iterator.
*/

#define MAX_LABEL_CIRCLES														(20)
#define MAX_CIRCLE_LABELS														(360)
#define MAX_LABEL_STRING														(6)

#define C_LBL_X_POS																(0)
#define C_LBL_Y_POS																(1)
#define C_LBL_Z_POS																(2)
#define C_LBL_RAD																(3)
#define C_LBL_DIFF																(4)
#define C_LBL_STREAM															(5)
#define C_LBL_DRAW																(6)

//#define C_LBL_DBG_MSG

enum DataLabel
{
	Text[MAX_LABEL_STRING],
	Color,
	World,
	Interior,
	TestLOS,
	Float:Property_Float[7],
	Text3D:Label[MAX_CIRCLE_LABELS],
	Count
}

new
		LabelData[MAX_LABEL_CIRCLES][DataLabel], Iterator:Circle_Label<MAX_LABEL_CIRCLES>;

stock Label_CreateCircle(text[], color, Float:x_pos, Float:y_pos, Float:z_pos, Float:radius, Float:diff, testlos = 0, world = -1, interior = -1, Float:d_stream = 50.0, Float:d_draw = 0.0)
{
	new
			c_id = Iter_Free(Circle_Label);
	if(c_id == -1)
		return -1;

	Label_CircleFixDiff(diff);

	Iter_Add(Circle_Label, c_id);

	format(LabelData[c_id][Text], MAX_LABEL_STRING, "%s", text);
	LabelData[c_id][Color]							=				color;
	LabelData[c_id][World]							=				world;
	LabelData[c_id][Interior]						=			 interior;
	LabelData[c_id][TestLOS]						=			  testlos;
	LabelData[c_id][Property_Float][C_LBL_X_POS]	=				x_pos;
	LabelData[c_id][Property_Float][C_LBL_Y_POS]	=				y_pos;
	LabelData[c_id][Property_Float][C_LBL_Z_POS]	=				z_pos;
	LabelData[c_id][Property_Float][C_LBL_RAD]		=			   radius;
	LabelData[c_id][Property_Float][C_LBL_DIFF]		=				 diff;
	LabelData[c_id][Property_Float][C_LBL_STREAM]	=			 d_stream;
	LabelData[c_id][Property_Float][C_LBL_DRAW]		=			   d_draw;

	for(new a = 0; a < MAX_CIRCLE_LABELS; a++)
		LabelData[c_id][Label][a]					=	Text3D:INVALID_3DTEXT_ID;

	Label_UpdateCircle(c_id);
	return c_id;
}

stock Label_DestroyCircle(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	new
			a;

	Iter_Remove(Circle_Label, c_id);

	format(LabelData[c_id][Text], 2, " ");
	LabelData[c_id][Color]							=					0;
	LabelData[c_id][World]							=					0;
	LabelData[c_id][Interior]						=					0;
	LabelData[c_id][TestLOS]						=					0;
	for(a = 0; a < 7; a++)
		LabelData[c_id][Property_Float][a]			=				  0.0;
	for(a = 0; a < LabelData[c_id][Count]; a++)
	{
		if(IsValidDynamic3DTextLabel(LabelData[c_id][Label][a]))
		{
			DestroyDynamic3DTextLabel(LabelData[c_id][Label][a]);
			LabelData[c_id][Label][a]				=	Text3D:INVALID_3DTEXT_ID;
		}
	}
	LabelData[c_id][Count]							=					0;
	return true;
}

stock Label_SetCircleRadius(c_id, Float:radius)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	LabelData[c_id][Property_Float][C_LBL_RAD] = radius;

	Label_UpdateCircle(c_id);
	return true;
}

stock Float:Label_GetCircleRadius(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return -1.0;
	return LabelData[c_id][Property_Float][C_LBL_RAD];
}

stock Label_SetCircleDiff(c_id, Float:diff)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	Label_CircleFixDiff(diff);

	LabelData[c_id][Property_Float][C_LBL_DIFF] = diff;

	Label_UpdateCircle(c_id);
	return true;
}

stock Float:Label_GetCircleDiff(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return -1.0;
	return LabelData[c_id][Property_Float][C_LBL_DIFF];
}

stock Label_SetCirclePos(c_id, Float:x_pos, Float:y_pos, Float:z_pos)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	LabelData[c_id][Property_Float][C_LBL_X_POS] = x_pos;
	LabelData[c_id][Property_Float][C_LBL_Y_POS] = y_pos;
	LabelData[c_id][Property_Float][C_LBL_Z_POS] = z_pos;

	Label_UpdateCircle(c_id);
	return true;
}

stock Label_GetCirclePos(c_id, &Float:x_pos, &Float:y_pos, &Float:z_pos)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	x_pos = LabelData[c_id][Property_Float][C_LBL_X_POS];
	y_pos = LabelData[c_id][Property_Float][C_LBL_Y_POS];
	z_pos = LabelData[c_id][Property_Float][C_LBL_Z_POS];
	return true;
}

stock Label_SetCircleStreamDistance(c_id, Float:d_stream)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	for(new a = 0; a < LabelData[c_id][Count]; a++)
	{
		if(IsValidDynamic3DTextLabel(LabelData[c_id][Label][a]))
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, LabelData[c_id][Label][a], E_STREAMER_STREAM_DISTANCE, d_stream);
	}

	LabelData[c_id][Property_Float][C_LBL_STREAM] = d_stream;
	return true;
}

stock Float:Label_GetCircleStreamDistance(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return 0.0;
	return LabelData[c_id][Property_Float][C_LBL_STREAM];
}

stock Label_SetCircleDrawDistance(c_id, Float:d_draw)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	for(new a = 0; a < LabelData[c_id][Count]; a++)
	{
		if(IsValidDynamic3DTextLabel(LabelData[c_id][Label][a]))
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, LabelData[c_id][Label][a], E_STREAMER_DRAW_DISTANCE, d_draw);
	}

	LabelData[c_id][Property_Float][C_LBL_DRAW] = d_draw;
	return true;
}

stock Float:Label_GetCircleDrawDistance(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return -1.0;
	return LabelData[c_id][Property_Float][C_LBL_DRAW];
}

stock Label_SetCircleWorld(c_id, world)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	for(new a = 0; a < LabelData[c_id][Count]; a++)
	{
		if(IsValidDynamic3DTextLabel(LabelData[c_id][Label][a]))
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, LabelData[c_id][Label][a], E_STREAMER_WORLD_ID, world);
	}

	LabelData[c_id][World] = world;
	return true;
}

stock Label_GetCircleWorld(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return -2;
	return LabelData[c_id][World];
}

stock Label_SetCircleInterior(c_id, interior)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	for(new a = 0; a < LabelData[c_id][Count]; a++)
	{
		if(IsValidDynamic3DTextLabel(LabelData[c_id][Label][a]))
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, LabelData[c_id][Label][a], E_STREAMER_INTERIOR_ID, interior);
	}

	LabelData[c_id][Interior] = interior;
	return true;
}

stock Label_GetCircleInterior(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return -2;
	return LabelData[c_id][Interior];
}

stock Label_SetCircleTestLOS(c_id, testlos)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	for(new a = 0; a < LabelData[c_id][Count]; a++)
	{
		if(IsValidDynamic3DTextLabel(LabelData[c_id][Label][a]))
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, LabelData[c_id][Label][a], E_STREAMER_TEST_LOS, testlos);
	}

	LabelData[c_id][TestLOS] = testlos;
	return true;
}

stock Label_GetCircleTestLOS(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return -1;
	return LabelData[c_id][TestLOS];
}

stock Label_GetCircleCount(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;
	return LabelData[c_id][Count];
}

stock Label_UpdateCircle(c_id)
{
	if(!Iter_Contains(Circle_Label, c_id))
		return false;

	new
			a, count, Float:coord[3];

	for(a = 0; a < 360; a++)
	{
		coord[0] = (LabelData[c_id][Property_Float][C_LBL_X_POS] + (LabelData[c_id][Property_Float][C_LBL_RAD] * floatcos(coord[2], degrees)));
		coord[1] = (LabelData[c_id][Property_Float][C_LBL_Y_POS] + (LabelData[c_id][Property_Float][C_LBL_RAD] * floatsin(coord[2], degrees)));

		if(IsValidDynamic3DTextLabel(LabelData[c_id][Label][count]))
			DestroyDynamic3DTextLabel(LabelData[c_id][Label][count]);

		LabelData[c_id][Label][count] = CreateDynamic3DTextLabel(
			LabelData[c_id][Text],
			LabelData[c_id][Color],
			coord[0],
			coord[1],
			LabelData[c_id][Property_Float][C_LBL_Z_POS],
			LabelData[c_id][Property_Float][C_LBL_DRAW],
			.testlos = LabelData[c_id][TestLOS],
			.worldid = LabelData[c_id][World],
			.interiorid = LabelData[c_id][Interior],
			.streamdistance = LabelData[c_id][Property_Float][C_LBL_STREAM]
		);

		count++;

		coord[2] += LabelData[c_id][Property_Float][C_LBL_DIFF];
		if(!(coord[2] < 360.0))
			break;
	}

	if(count < LabelData[c_id][Count])
	{
		for(a = count; a < MAX_CIRCLE_LABELS; a++)
		{
			if(IsValidDynamic3DTextLabel(LabelData[c_id][Label][a]))
			{
				DestroyDynamic3DTextLabel(LabelData[c_id][Label][a]);
				LabelData[c_id][Label][a] = Text3D:INVALID_3DTEXT_ID;
			}
		}
	}

	LabelData[c_id][Count] = count;

	#if defined C_LBL_DBG_MSG
		printf("Created/updated %i labels at \"Label_UpdateCircle\" function for text \"%s\" (circle ID: %i).",
			count,
			LabelData[c_id][Text],
			c_id
		);
	#endif
	return count;
}

stock Label_CircleFixDiff(&Float:diff)
{
	if(diff < 1.0)
		diff = 1.0;
}
