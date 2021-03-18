// FuckZones
#define FZ_EFF "surftimer"

public void fuckZones_OnZoneCreate(int zone, const char[] name, int type)
{

	// no idea if i need this

}

public void fuckZones_OnEffectsReady()
{

	fuckZones_RegisterEffect(FZ_EFF, OneZoneStartTouch, InZone, OnZoneEndTouch);

	fuckZones_RegisterEffectKey(FZ_EFF, "StartZone", "0");
	fuckZones_RegisterEffectKey(FZ_EFF, "EndZone", "0");
	fuckZones_RegisterEffectKey(FZ_EFF, "Stage", "0");
	fuckZones_RegisterEffectKey(FZ_EFF, "Checkpoint", "0");
	fuckZones_RegisterEffectKey(FZ_EFF, "Bonus", "0");
	fuckZones_RegisterEffectKey(FZ_EFF, "MiscZone", "0");

}

public void OneZoneStartTouch(int client, int entity, StringMap values)
{
	// PrintToChat(client, "OneZoneStartTouch");

	// if (IsEndZone(values))
	// {
	// 	if (Player[client].Time > 0.0)
	// 	{
	// 		PrintToChat(client, "Time: %.3f", GetGameTime()-Player[client].Time);
	// 	}
	// }

	// int iStage = GetStageNumber(values);

	// if (iStage > 1)
	// {
	// 	float fTime = GetGameTime();
	// 	Player[client].StageTimes.SetValue(iStage, fTime);

	// 	float fPrevTime;
	// 	if (Player[client].StageTimes.GetValue(iStage-1, fPrevTime))
	// 	{
	// 		PrintToChat(client, "Time for Stage %d to Stage %d: %.3f", iStage-1, iStage, fTime-fPrevTime);
	// 	}
	// }

	int action[3];

	if(IsStartZone(values)){
		action[0]=1;
		action[1]=0;
		action[2]=GetGroupID(values);
	}

	if(IsEndZone(values)){
		action[0]=2;
		action[1]=0;
		action[2]=GetGroupID(values);
	}

	if(IsStageZone(values)){
		action[0]=3;
		action[1]=GetStageNumber(values);
		action[2]=GetGroupID(values);
	}

	if(IsCheckpointZone(values)){
		action[0]=4;
		action[1]=GetCheckpointNumber(values);
		action[2]=GetGroupID(values);
	}

	StartTouch(client, action);
}

public void OnZoneEndTouch(int client, int entity, StringMap values)
{
	// PrintToChat(client, "OnZoneEndTouch");
	// int iStage = -1;

	// if (IsStartZone(values))
	// {
	// 	Player[client].Time = GetGameTime();
	// 	iStage = 1;
	// }

	// char sName[MAX_ZONE_NAME_LENGTH];
	// fuckZones_GetZoneName(entity, sName, sizeof(sName));

	// if (iStage < 1)
	// {
	// 	iStage = GetStageNumber(values);
	// }

	// if (iStage > 0)
	// {
	// 	Player[client].StageTimes.SetValue(iStage, GetGameTime());
	// }

	int action[3];

	if(IsStartZone(values)){
		action[0]=1;
		action[1]=0;
		action[2]=GetGroupID(values);
	}

	if(IsEndZone(values)){
		action[0]=2;
		action[1]=0;
		action[2]=GetGroupID(values);
	}

	if(IsStageZone(values)){
		action[0]=3;
		action[1]=GetStageNumber(values);
		action[2]=GetGroupID(values);
	}

	if(IsCheckpointZone(values)){
		action[0]=4;
		action[1]=GetCheckpointNumber(values);
		action[2]=GetGroupID(values);
	}


	EndTouch(client,action);
}

public void InZone(int client, int entity, StringMap values)
{

	// might be usefull later

}

bool IsStartZone(StringMap values)
{
	char sValue[MAX_KEY_VALUE_LENGTH];
	if (GetZoneValue(values, "StartZone", sValue, sizeof(sValue)))
	{
		return view_as<bool>(StringToInt(sValue));
	}
	return false;
}

bool IsEndZone(StringMap values)
{
	char sValue[MAX_KEY_VALUE_LENGTH];
	if (GetZoneValue(values, "EndZone", sValue, sizeof(sValue)))
	{
		return view_as<bool>(StringToInt(sValue));
	}
	return false;
}

bool IsStageZone(StringMap values)
{
	char sValue[MAX_KEY_VALUE_LENGTH];
	if (GetZoneValue(values, "Stage", sValue, sizeof(sValue)))
	{
		return view_as<bool>(StringToInt(sValue));
	}
	return false;
}

bool IsCheckpointZone(StringMap values)
{
	char sValue[MAX_KEY_VALUE_LENGTH];
	if (GetZoneValue(values, "Checkpoint", sValue, sizeof(sValue)))
	{
		return view_as<bool>(StringToInt(sValue));
	}
	return false;
}

int GetStageNumber(StringMap values)
{
	char sValue[MAX_KEY_VALUE_LENGTH];
	if (GetZoneValue(values, "Stage", sValue, sizeof(sValue)))
	{
		return StringToInt(sValue);
	}
	return -1;
}

int GetCheckpointNumber(StringMap values)
{
	char sValue[MAX_KEY_VALUE_LENGTH];
	if (GetZoneValue(values, "Checkpoint", sValue, sizeof(sValue)))
	{
		return StringToInt(sValue);
	}
	return -1;
}

int GetGroupID(StringMap values){
	char sValue[MAX_KEY_VALUE_LENGTH];
	if (GetZoneValue(values, "Bonus", sValue, sizeof(sValue)))
	{
		return StringToInt(sValue);
	}
	return -1;
}

bool GetZoneValue(StringMap values, const char[] key, char[] value, int length)
{
	char sKey[MAX_KEY_NAME_LENGTH];
	StringMapSnapshot keys = values.Snapshot();

	for (int x = 0; x < keys.Length; x++)
	{
		keys.GetKey(x, sKey, sizeof(sKey));

		if (strcmp(sKey, key, false) == 0)
		{
			values.GetString(sKey, value, length);

			delete keys;
			return true;
		}
	}

	delete keys;
	return false;
}