#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <randweapons>


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

    // RegConsoleCmd("randwep", Command_RandWep);

    // Save a defaut config file
    AutoExecConfig(true, "randweapons");
    
    // Info
    PrintToChatAll("Random weapon plugin loaded");

    // Hook onto the round starting
    HookEvent("round_start", Event_RoundStart, EventHookMode_PostNoCopy);
}

/**
 * Dish out weapons when the round starts
 */
public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
    // Check if the plugin is enabled
    if (g_randWepEnabled.FloatValue == 0) return;

    // Check if we're in a pistol round
    bool isPistolRound = IsPistolRound();
    
    // Fancy print to all that random weapons will be assigned
    PrintToChatAll("=== \x02R\x09a\x05n\x04d\x03o\x02m\x09i\x05s\x04\x03i\x02n\x09g\x01 \x05w\x04e\x03a\x02p\x09o\x05n\x04s\x03!\x01 ===");
    
    // player 0 is "World"
    for(int i = 1; i < MAXPLAYERS; i++)
    {
        // Check if this slot is occupied
        if (!IsClientInGame(i)) continue;

        // Give them a random weapon and print the details of it
        SelectAndGiveRandomWeapon(i, isPistolRound);
    }
}

/**
 * Double weapon prices
 */
Action CS_OnGetWeaponPrice(int client, const char[] weapon, int& price)
{
    price = price * 2;

    return Plugin_Changed;
}