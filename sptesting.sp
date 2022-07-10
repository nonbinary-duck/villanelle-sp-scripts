#pragma tabsize 4
#pragma semicolon 1

#include <entity>
#include <events>
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
int g_Offset_AttributeManager;
int g_Offset_BurstFireMode;

/**
 * Everything else
 */

public OnPluginStart()
{
    // Find offsets
    g_Offset_AttributeManager = FindSendPropInfo("CWeaponCSBaseGun", "m_AttributeManager");
    g_Offset_BurstFireMode = FindSendPropInfo("CWeaponCSBaseGun", "m_bBurstMode");

    PrintToChatAll("%i", g_Offset_AttributeManager);
    PrintToChatAll("%i", g_Offset_BurstFireMode);

    // Hook onto events
    HookEvent("weapon_fire", Event_WeaponFire, EventHookMode_Pre);
    HookEvent("player_use", Event_PlayerUse, EventHookMode_Post);

    // Print we've loaded
    PrintToConsoleAll("%s %s loaded successfully", PLUGIN_NAME, PLUGIN_VER);
}

public void Event_WeaponFire(Event event, const char[] name, bool dontBroadcast)
{
    
    int userEnt = GetClientOfUserId(event.GetInt("userid"));
    
    int secondary = GetPlayerWeaponSlot(userEnt, 1);

    // Check we found one
    if (secondary == -1) { PrintToChat(userEnt, "No deagle found"); return; }

    int currentBurstFire = GetEntData(secondary, g_Offset_BurstFireMode);

    PrintToChat(userEnt, "Secondary %i found, current burst-fire %i, setting to %i", secondary, currentBurstFire, (currentBurstFire + 1) % 2);
    
    SetEntData(secondary, g_Offset_BurstFireMode, (currentBurstFire + 1) % 2);
}
