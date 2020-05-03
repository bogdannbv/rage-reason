#include <sourcemod>
#include <cstrike>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_NAME "RageReason"
#define PLUGIN_VERSION "0.1.0"
#define PLUGIN_ENABLED_DEFAULT "1"

#define RAGE_MAX_SECONDS_DEFAULT "10"
#define RAGE_REASON "RAGE QUIT"

ConVar cvarEnabled = null;
ConVar cvarMaxSeconds = null;

int playerDeathTimes[MAXPLAYERS+1];

public Plugin myinfo =
{
	name = PLUGIN_NAME,
	author = "BogdanNBV",
	description = "A plugin that tries to shed some light over sudden player disappearances.",
	version = PLUGIN_VERSION,
	url = "https://github.com/bogdannbv/rage-reason"
};

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion engineVersion = GetEngineVersion();
	if (engineVersion != Engine_CSS)
	{
		LogMessage("[WARNING] This plugin was tested ONLY on Counter-Strike: Source. Your mileage may vary.");
	}
}

public void OnPluginStart()
{
	AutoExecConfig(true);
	RegisterConVars();
	RegisterEventHooks();
}

public void RegisterConVars()
{
	CreateConVar("sm_rage-reason_version", PLUGIN_VERSION, "RageReason version.", FCVAR_NOTIFY|FCVAR_REPLICATED|FCVAR_DONTRECORD|FCVAR_SPONLY);

	cvarEnabled = CreateConVar("sm_rage-reason_enabled", PLUGIN_ENABLED_DEFAULT, "Determines if the plugin should be enabled.", FCVAR_NOTIFY|FCVAR_REPLICATED);

	cvarMaxSeconds = CreateConVar("sm_rage-reason_max_seconds", RAGE_MAX_SECONDS_DEFAULT, "The maximum number of seconds after a player's death to consider the disconnect a rage quit.", FCVAR_NOTIFY|FCVAR_REPLICATED);
}

public void RegisterEventHooks()
{
	HookEvent("player_death", EventPlayerDeathHandler, EventHookMode_Pre);
	HookEvent("player_disconnect", EventPlayerDisconnectHandler, EventHookMode_Pre);
}

public Action EventPlayerDisconnectHandler(Event event, char[] name, bool dontBroadcast)
{
	int playerClient = GetClientOfUserId(event.GetInt("userid"));

	int lastDeathTime = playerDeathTimes[playerClient];

	playerDeathTimes[playerClient] = 0; // Reset client's last death time

	if (!cvarEnabled.BoolValue || !IsRageQuit(lastDeathTime)) {
		return Plugin_Continue;
	}

	event.SetString("reason", RAGE_REASON);

	return Plugin_Changed;
}

public Action EventPlayerDeathHandler(Event event, char[] name, bool dontBroadcast)
{
	int playerClient = GetClientOfUserId(event.GetInt("userid"));

	int attackerClient = GetClientOfUserId(event.GetInt("attacker"));

	if (cvarEnabled.BoolValue || !IsSuicide(playerClient, attackerClient)) {
		playerDeathTimes[playerClient] = GetTime();
	}

	return Plugin_Continue;
}

public bool IsRageQuit(int lastDeathTime)
{
	return (GetTime() - lastDeathTime) <= cvarMaxSeconds.IntValue;
}

public bool IsSuicide(int playerClient, int attackerClient)
{
	return playerClient == attackerClient || attackerClient == 0;
}
