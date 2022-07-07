#include <cstrike>
#include <sdktools>
#include <sdktools_functions>
#include <randweapons>
#include <sourcemod>


public Plugin myinfo =
{
    name = "Rand weapons",
    author = "Villanelle",
    description = "idk",
    version = SOURCEMOD_VERSION,
    url = "http://www.sourcemod.net/"
};

// ConVars
ConVar g_randWepEnabled;

public OnPluginStart()
{
    // Seed the rng
    SetRandomSeed(RoundToFloor(GetEngineTime()));

    // Setup conVars
    g_randWepEnabled = CreateConVar("randwep",
            "0.0",
            "Sets the random weapons plugin to be enabled/dissabled",
            FCVAR_NOTIFY | FCVAR_REPLICATED,
            true,
            0.0,
            true,
            1.0
    );

    // Give a command to manually dish out weapons
    RegAdminCmd("randwepons_manual", Command_Manual, ADMFLAG_CHEATS, "Manually trigger the weapon dishing-out, ignoring if the plugin is \"enabled\"");

    // Save a defaut config file
    AutoExecConfig(true, "randweapons");
    
    // Info
    PrintToChatAll("Random weapon plugin loaded");

    // Hook onto the round starting
    HookEvent("round_start", Event_RoundStart, EventHookMode_PostNoCopy);

    // Hook onto the weapon price thingi
    // AddToForward(CS_OnGetWeaponPrice, handle)
}

/**
 * Manually trigger the weapon dishing-out, ignoring if the plugin is "enabled"
 */
public Action Command_Manual(int client, int args)
{
    DishOutWeapons();

    return Plugin_Handled;
}

/**
 * Dish out weapons when the round starts
 */
public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
    // Check if the plugin is enabled
    if (g_randWepEnabled.FloatValue == 0) return;

    DishOutWeapons();
}

/**
 * Double weapon prices
 */
public Action CS_OnGetWeaponPrice(int client, const char[] weapon, int& price)
{
    // Don't alter prices if the plugn is dissabled
    if (g_randWepEnabled.FloatValue == 0) return Plugin_Continue;

    price = price * 2;

    PrintToChat(client, "The \x0C%s\x01 costs \x05%i", weapon, price);

    return Plugin_Changed;
}