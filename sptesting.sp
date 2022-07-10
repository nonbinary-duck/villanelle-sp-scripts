#pragma tabsize 4
#pragma semicolon 1

#include <cstrike>
#include <sdktools>
#include <sdktools_trace>
#include <sourcemod>
#include <villanelle>

// Offsets
int g_Offset_Money = -1;

public Plugin myinfo =
{
    name = "SP Testing",
    author = "Villanelle",
    description = "idk",
    version = "0.0",
    url = "http://www.sourcemod.net/"
};

public OnPluginStart()
{
    PrintToChatAll("\x03SPTesting Plugin Loading");

    // Sort out offsets
    g_Offset_Money = FindSendPropInfo("CCSPlayer", "m_iAccount");
    PrintToChatAll("Offset: %i", g_Offset_Money);
    
    
    // Hooks
    HookEvent("weapon_fire", Event_WeaponFire, EventHookMode_Pre);
}

public Action Event_WeaponFire(Event event, const char[] name, bool dontBroadcast)
{
    // If we're in the warmup, give users money every time they shoot
    if (GameRules_GetProp("m_bWarmupPeriod") == 0) return Plugin_Continue;
    int ent = GetClientOfUserId(event.GetInt("userid"));
    
    int money = GetEntData(ent, g_Offset_Money);
    SetEntData(ent, g_Offset_Money, money + 100);

    return Plugin_Continue;
}