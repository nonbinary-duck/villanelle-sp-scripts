#include <sourcemod>
#include <sdktools>
#include <clientprefs>
#include <cstrike>
#include <villanelle>


public Plugin myinfo =
{
    name = "Rand weapons",
    author = "Villanelle",
    description = "idk",
    version = SOURCEMOD_VERSION,
    url = "http://www.sourcemod.net/"
};


public OnPluginStart()
{
    // Seed the rng
    SetRandomSeed(RoundToFloor(GetEngineTime()));

    // Info
    PrintToChatAll("Random weapon plugin loaded");


    // Hook onto the round starting
    HookEvent("round_start", Event_RoundStart, EventHookMode_Pre);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
    // Fancy print to all that random weapons will be assigned
    PrintToChatAll("=== Randomising \x02w\x09e\x05a\x04p\x03o\x02n\x09s\x05!\x01 ===");
    
    for(int i = 1; i <= MAXPLAYERS; i++)
    {
        // Check if this slot is occupied
        if (!IsClientInGame(i)) continue;

        for(int j = 0; j <= 4; j++)
        {
            RemoveWeaponFromSlot(i, j);
        }

        // The weapon to give the player
        char weapon[30];
        char connector[30];
        char weaponName[30];
        // The "quality" of the weapon, red (x02), yellow (x09), light green (x05), green (x04) or purple (x03)
        // 0 (red) - 4 (purple)
        int tier = 0;

        switch(GetRandomInt(0, 31))
        {
            case 0:
            {
                weapon = "weapon_p250";
                connector = "a";
                weaponName = "P250";
                tier = 3;
            }
            case 1:
            {
                weapon = "weapon_elite";
                connector = "some";
                weaponName = "Dualies";
                tier = 3;
            }
            case 2:
            {
                weapon = "weapon_tec9";
                connector = "a";
                weaponName = "Tec-9";
                tier = 2;
            }
            case 3:
            {
                weapon = "weapon_fiveseven";
                connector = "a";
                weaponName = "Five-Seven";
                tier = 3;
            }
            case 4:
            {
                weapon = "weapon_cz75a";
                connector = "a";
                weaponName = "cz75";
                tier = 2;
            }
            case 5:
            {
                weapon = "weapon_deagle";
                connector = "a";
                weaponName = "Deagle";
                tier = 3;
            }
            case 6:
            {
                weapon = "weapon_revolver";
                connector = "a";
                weaponName = "heckin' Revolver";
                tier = 1;
            }
            // Shotguns
            case 7:
            {
                weapon = "weapon_nova";
                connector = "a";
                weaponName = "Nova";
                tier = 2;
            }
            case 8:
            {
                weapon = "weapon_sawedoff";
                connector = "a";
                weaponName = "Sawedoff, yikes";
                tier = 0;
            }
            case 9:
            {
                weapon = "weapon_mag7";
                connector = "a";
                weaponName = "mag7 XD";
                tier = 0;
            }
            case 10:
            {
                weapon = "weapon_xm1014";
                connector = "an";
                weaponName = "XM-1014";
                tier = 4;
            }
            // LMG
            case 11:
            {
                weapon = "weapon_negev";
                connector = "a";
                weaponName = "Naegev";
                tier = 2;
            }
            case 12:
            {
                weapon = "weapon_m249";
                connector = "an";
                weaponName = "m249";
                tier = 3;
            }
            // SMG
            case 13:
            {
                weapon = "weapon_mac10";
                connector = "a";
                weaponName = "mac-10";
                tier = 2;
            }
            case 14:
            {
                weapon = "weapon_mp9";
                connector = "an";
                weaponName = "mp9";
                tier = 3;
            }
            case 15:
            {
                weapon = "weapon_mp7";
                connector = "an";
                weaponName = "mp7";
                tier = 3;
            }
            case 16:
            {
                weapon = "weapon_ump45";
                connector = "a";
                weaponName = "UMP";
                tier = 1;
            }
            case 17:
            {
                weapon = "weapon_p90";
                connector = "a";
                weaponName = "P90";
                tier = 3;
            }
            case 18:
            {
                weapon = "weapon_bizon";
                connector = "a";
                weaponName = "Bizon";
                tier = 2;
            }
            case 19:
            {
                weapon = "weapon_galilar";
                connector = "a";
                weaponName = "Galil";
                tier = 3;
            }
            case 20:
            {
                weapon = "weapon_famas";
                connector = "a";
                weaponName = "famas";
                tier = 3;
            }
            case 21:
            {
                weapon = "weapon_ak47";
                connector = "an";
                weaponName = "AK-47";
                tier = 4;
            }
            case 22:
            {
                weapon = "weapon_m4a1";
                connector = "an";
                weaponName = "M4A1";
                tier = 4;
            }
            case 23:
            {
                weapon = "weapon_m4a1_silencer";
                connector = "a";
                weaponName = "Silenced M4A1";
                tier = 4;
            }
            case 24:
            {
                weapon = "weapon_ssg08";
                connector = "an";
                weaponName = "SSG08";
                tier = 3;
            }
            case 25:
            {
                weapon = "weapon_sg556";
                connector = "an";
                weaponName = "SG556";
                tier = 4;
            }
            case 26:
            {
                weapon = "weapon_aug";
                connector = "an";
                weaponName = "AUG";
                tier = 4;
            }
            case 27:
            {
                weapon = "weapon_awp";
                connector = "an";
                weaponName = "AWP";
                tier = 4;
            }
            case 28:
            {
                weapon = "weapon_g3sg1";
                connector = "a";
                weaponName = "G3-SG1";
                tier = 3;
            }
            case 29:
            {
                weapon = "weapon_scar20";
                connector = "a";
                weaponName = "SCAR20";
                tier = 3;
            }
            case 30:
            {
                weapon = "weapon_taser";
                connector = "a";
                weaponName = "Zeus";
                tier = 0;
            }
            default:
            {
                weapon = "chicken";
                connector = "a";
                weaponName = "heckin chicken lol";
                tier = 0;
            }
        }

        // Give them the gun
        GivePlayerItem(i, weapon);

        // Figure out what colour it should be
        char tierColour[3];

        switch (tier)
        {
            case 0:
                tierColour = "\x02";
            case 1:
                tierColour = "\x09";
            case 2:
                tierColour = "\x05";
            case 3:
                tierColour = "\x04";
            case 4:
                tierColour = "\x03";
            default:
                tierColour = "";
        }
        
        PrintToChat(i, "You got %s %s%s\x01!", connector, tierColour, weaponName);
    }
}
