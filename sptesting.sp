#pragma tabsize 4
#pragma semicolon 1

#include <cstrike>
#include <sdktools>
#include <sdktools_trace>
#include <sourcemod>


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
    
    // Hooks
    // HookEvent("weapon_fire", Event_WeaponFire, EventHookMode_Pre);
}

public Action Event_WeaponFire(Event event, const char[] name, bool dontBroadcast)
{
    // PrintToConsoleAll(name);
    
    // TR_TraceRay()

    char info[64];
    GetClientInfo(GetClientOfUserId(event.GetInt("userid")), "targetname", info, 64);

    PrintToChatAll("Info: %s", info);

    return Plugin_Continue;
}