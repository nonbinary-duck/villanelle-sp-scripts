#include <v_ata_tools_cpy>
#include <convars>
#include <cstrike>

/**
 * Removes a client's primary and secondary weapon and makes them equip their knife
 */
public void RemovePrimaryAndSecondaryWeapons(client)
{
	RemoveWeaponFromSlot(client, CS_SLOT_PRIMARY);
	RemoveWeaponFromSlot(client, CS_SLOT_SECONDARY);
}

public bool IsPistolRound()
{
	// Get the round number and get the max number of rounds
    int roundNumber = GetTeamScore(CS_TEAM_T) + GetTeamScore(CS_TEAM_CT);
    int maxrounds = FindConVar("mp_maxrounds").IntValue;
    int halfTime = maxrounds / 2;

    // Check if this is a pistol round
    bool isPistolRound = roundNumber % halfTime == 0;
    // If we're in overtime, don't enable pistol round
    return (roundNumber + 1 >= maxrounds)? false : isPistolRound;
}