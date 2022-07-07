#include <sdktools_functions>

/**
 * Taken from ata_tools
 */
public bool:RemoveWeaponFromSlot(client, slot)
{
	new nEntityID = GetPlayerWeaponSlot(client, slot);
	if(nEntityID < 0)
		return false;

	decl String:sEntityName[32];
	GetEdictClassname(nEntityID, sEntityName, sizeof(sEntityName));

	if(strcmp(sEntityName, "weapon_knife") == 0)
		return true;

	RemovePlayerItem(client, nEntityID);
	RemoveEdict(nEntityID);

	return true;
}

/**
 * Removes a client's primary and secondary weapon
 */
public void RemovePrimaryAndSecondaryWeapons(client)
{
	RemoveWeaponFromSlot(client, 0);
	RemoveWeaponFromSlot(client, 1);
}