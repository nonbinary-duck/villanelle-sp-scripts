///
/// Code coppied (and a little changed) from ata_tools from ata_rollthedice to make my life easier
///     ata_rollthedice: https://forums.alliedmods.net/showthread.php?p=849987
///
#include <entity>
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
