#include <randweapons_tables>
#include <villanelle>
#include <sourcemod>

void SelectAndGiveRandomWeapon(int client, bool isPistolRound, char[] whatToSay = "You got", bool spesificRange = false, int min = 0, int max = 33)
{
    // Info to store about the weapon to give the player
    char weapon[30];
    char connector[30];
    char weaponName[30];
    // The eventual "quality" of the weapon, red (x02), yellow (x09), light green (x05), green (x04) or purple (x03)
    // 0 (red) - 4 (purple)
    int tier = 0;
    
    // Get which weapon to give the player
    int result = GetRandomInt(0, 30);

    // Give a 1/4 chance of including special weapons & chicken
    if (GetRandomInt(0, 3) == 0) result = GetRandomInt(0, 33);

    // If there is a spesific range, use that instead (unless there's a pistol round)
    if (spesificRange) result = GetRandomInt(min, max);

    // Re-Roll for just pistols if it's a pistol round
    if (isPistolRound) result = GetRandomInt(0, 6);

    // Sort out the variables
    ChooseRandWeapon(result, weapon, connector, weaponName, tier, 30);

    // Get what colour to use in the chat
    char tierColour[3];
    GetTierColour(tier, tierColour, 3);

    // Give them the "gun"
    GivePlayerItem(client, weapon);

    PrintToChat(client, "%s %s %s%s\x01!", whatToSay, connector, tierColour, weaponName);
}

/**
 * The function to give all user their weapon(s)
 */
void DishOutWeapons()
{
    // Check if we're in a pistol round
    bool isPistolRound = IsPistolRound();
    
    // Fancy print to all that random weapons will be assigned
    PrintToChatAll("=== \x02R\x09a\x05n\x04d\x03o\x02m\x09i\x05s\x04\x03i\x02n\x09g\x01 \x05w\x04e\x03a\x02p\x09o\x05n\x04s\x03!\x01 ===");
    
    // player 0 is "World"
    for(int i = 1; i < MAXPLAYERS; i++)
    {
        // Check if this slot is occupied
        if (!IsClientInGame(i)) continue;

        // Remove the player's weapons
        RemovePrimaryAndSecondaryWeapons(i);

        // Give them a random weapon and print the details of it
        SelectAndGiveRandomWeapon(i, isPistolRound, "You got");

        // Have a 1/20 chance of an extra special item
        if (GetRandomInt(0,19) == 0) SelectAndGiveRandomWeapon(i, false, "And you \x03also\x01 got", true, 30, 33);
        // Have a 1/5 chance of an extra pistol
        else if (GetRandomInt(0,4) == 0) SelectAndGiveRandomWeapon(i, true, "And you \x03also\x01 got");
    }
}
