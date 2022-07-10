#pragma tabsize 4
#pragma semicolon 1

#include <entity>
#include <events>
#include <cstrike>
#include <clients>
#include <console>
#include <convars>
#include <halflife>
#include <sdktools_gamerules>
#include <sdktools_functions>


/**
 * Static Definitions
 */
#define PLUGIN_NAME "SP Testing"
#define PLUGIN_VER  "0.0.0"

public Plugin myinfo =
{
    name = PLUGIN_NAME,
    author = "Villanelle",
    description = "My testing plugin",
    version = PLUGIN_VER,
    url = "http://www.sourcemod.net/"
};

/**
 * Globals
 */

// Offsets
int g_Offset_Attributes;
int g_Offset_CustomName;
int g_Offset_BurstFireMode;
int g_Offset_BurstFireShotsRemaining;
int g_Offset_PlayerLastPinged;
int g_Offset_PlayerHasHelmet;

/**
 * Everything else
 */

public OnPluginStart()
{
    // Find offsets
    g_Offset_Attributes = FindSendPropInfo("CWeaponCSBaseGun", "m_Attributes");
    g_Offset_CustomName = FindSendPropInfo("CWeaponCSBaseGun", "m_szCustomName");
    g_Offset_BurstFireMode = FindSendPropInfo("CWeaponCSBaseGun", "m_bBurstMode");
    g_Offset_BurstFireShotsRemaining = FindSendPropInfo("CWeaponCSBaseGun", "m_iBurstShotsRemaining");
    g_Offset_PlayerLastPinged = FindSendPropInfo("CCSPlayer", "m_hPlayerPing");
    g_Offset_PlayerHasHelmet = FindSendPropInfo("CCSPlayer", "m_bHasHelmet");

    PrintToChatAll("Attributes %i", g_Offset_Attributes);
    PrintToChatAll("Custom Name %i", g_Offset_CustomName);
    PrintToChatAll("Burst-fire %i", g_Offset_BurstFireMode);
    PrintToChatAll("Burst-fire Shots Reamining %i", g_Offset_BurstFireShotsRemaining);
    PrintToChatAll("Player ping %i", g_Offset_PlayerLastPinged);
    PrintToChatAll("Player has helmet %i", g_Offset_PlayerLastPinged);

    // Hook onto events
    HookEvent("weapon_fire", Event_WeaponFire, EventHookMode_Pre);
    HookEvent("player_ping", Event_PlayerPing, EventHookMode_Pre);

    // Print we've loaded
    PrintToConsoleAll("%s %s loaded successfully", PLUGIN_NAME, PLUGIN_VER);
}

public void Event_PlayerPing(Event event, const char[] name, bool dontBroadcast)
{
    int userEnt = GetClientOfUserId(event.GetInt("userid"));

    int secondaryEnt = GetPlayerWeaponSlot(userEnt, CS_SLOT_SECONDARY);

    int currentBurstFireMode = GetEntData(secondaryEnt, g_Offset_BurstFireMode);

    PrintToConsole(userEnt, "Burst fire is now %s", (currentBurstFireMode == 0)? "on" : "off");

    SetEntData(secondaryEnt, g_Offset_BurstFireMode, (currentBurstFireMode + 1) % 2);
    SetEntData(secondaryEnt, g_Offset_BurstFireShotsRemaining, 4);
}

public void Event_WeaponFire(Event event, const char[] name, bool dontBroadcast)
{
    
}
