#include <randweapons_tables>
#include <villanelle>

void SelectAndGiveRandomWeapon(int client, bool isPistolRound)
{
    // Remove the player's weapons
    RemovePrimaryAndSecondaryWeapons(client);

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
    if (GetRandomInt(0, 3) == 0) result = GetRandomInt(0, 34);

    // Re-Roll for just pistols if it's a pistol round
    if (isPistolRound) result = GetRandomInt(0, 6);

    // Sort out the variables
    ChooseRandWeapon(result, weapon, connector, weaponName, tier, 30);

    // Get what colour to use in the chat
    char tierColour[3];
    GetTierColour(tier, tierColour, 3);

    // Give them the "gun"
    GivePlayerItem(client, weapon);

    PrintToChat(client, "You got %s %s%s\x01!", connector, tierColour, weaponName);
}