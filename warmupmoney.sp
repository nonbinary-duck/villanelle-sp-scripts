#pragma tabsize 4
#pragma semicolon 1

#include <entity>
#include <console>
#include <convars>
#include <sdktools_gamerules>

/**
 * Static Definitions
 */

#define PLUGIN_NAME "Warmup Money"
#define PLUGIN_VER  "1.0.0"

public Plugin myinfo =
{
    name = PLUGIN_NAME,
    author = PLUGIN_VER,
    description = "Gives money during warmpup",
    version = "1.0.0",
    url = "http://www.sourcemod.net/"
};

/**
 * Globals
 */

// Offsets
int g_Offset_Money;

// ConVars
ConVar g_ConVar_MaxMoney;

/**
 * Everything else
 */

public OnPluginStart()
{
    // Find offsets
    g_Offset_Money = FindSendPropInfo("CCSPlayer", "m_iAccount");

    g_ConVar_MaxMoney = FindConVar("mp_maxmoney");

    // Hook onto events
    HookEvent("weapon_fire", Event_WeaponFire, EventHookMode_Pre);

    // Print we've loaded
    PrintToConsoleAll("%s %s loaded successfully", PLUGIN_NAME, PLUGIN_VER);
}

public void Event_WeaponFire(Event event, const char[] name, bool dontBroadcast)
{
    // If we're in the warmup, give users money every time they shoot
    if (GameRules_GetProp("m_bWarmupPeriod") == 0) return;

    // Get the entity ID of the user
    int ent = GetClientOfUserId(event.GetInt("userid"));
    
    // Add 100 to their balance
    int money = GetEntData(ent, g_Offset_Money);

    // If the money woud put them over the max, set it to the max instead
    if (money + 100 > g_ConVar_MaxMoney.IntValue) SetEntData(ent, g_Offset_Money, g_ConVar_MaxMoney.IntValue);
    else SetEntData(ent, g_Offset_Money, money + 100);
}
