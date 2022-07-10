#include <sourcemod>
#include <sdktools>
#include <clientprefs>
#include <cstrike>


public Plugin myinfo =
{
    name = "Damage Log",
    author = "Villanelle",
    description = "Provides a detailed log of damage dealt at the end of a round.",
    version = "1.0.0",
    url = "http://www.sourcemod.net/"
};

char damageLogs[MAXPLAYERS + 1][256][256];
int dmgPointer[MAXPLAYERS + 1];

public OnPluginStart()
{
	PrintToChatAll("\x011\x022\x033\x044\x055\x066\x077\x088\x099\x0AA\x0BB\x0CC\x0DD\x0EE\x0FF");

	PrintToChatAll("Damage Log Plugin loaded");

	HookEvent("player_hurt", Event_PlayerHurt);
	HookEvent("round_start", Event_RoundStart);
	HookEvent("round_end", Event_RoundEnd);
}

public void Event_PlayerHurt(Event event, const char[] name, bool dontBroadcast)
{
	int userID = event.GetInt("userid");
	int attackerID = event.GetInt("attacker");
	int user = GetClientOfUserId(userID);
	int attacker = GetClientOfUserId(attackerID);

	// If it's world damage, ignore it
	// If the damage log is at a maximum, just skip
	if (attacker == 0 || dmgPointer[attacker] >= 256)
	{
		return;
	}
	else if (!IsClientInGame(attacker)) return;
	
	// Get details about the damage
	int damage = event.GetInt("dmg_health");
	int health = event.GetInt("health");
	int armour = event.GetInt("armor");
	int hitgroup = event.GetInt("hitgroup");

	// Get the weapon they used
	char weapon[10];
	event.GetString("weapon", weapon, 10, "unknown");

	char clientName[20];
	GetClientName(user, clientName, 20);

	char hitgroupStr[10];
	TranslateHitGroup(hitgroup, hitgroupStr);

	if (GetClientTeam(user) == 3)
	{
		FormatEx(damageLogs[attacker][dmgPointer[attacker]], 256, "\x01[\x0D%s\x01] ", clientName);
	}
	else
	{
		FormatEx(damageLogs[attacker][dmgPointer[attacker]], 256, "\x01[\x09%s\x01] ", clientName);
	}


	FormatEx(damageLogs[attacker][dmgPointer[attacker]], 256, "%s\x0F%i\x01 damage \x03%s\x01 to \x04%s\x01 leaving \x05%i\x01:\x0C%i\x01", damageLogs[attacker][dmgPointer[attacker]], damage, weapon, hitgroupStr, health, armour);

	dmgPointer[attacker] += 1;
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	for (int i = 1; i < MAXPLAYERS; i++)
	{
		// Reset the damage log
		for (int z = 0; z <= dmgPointer[i]; z++)
		{
			damageLogs[i][z] = "";
		}

		dmgPointer[i] = 0;
	}
}

public void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	for (int i = 1; i < MAXPLAYERS; i++)
	{
		if (IsClientInGame(i))
		{
			if (dmgPointer[i] != 0)
			{
				// Print the damage log
				PrintToChat(i, "=== \x0EDamage Log\x01 ===");

				for (int z = 0; z <= dmgPointer[i]; z++)
				{
					PrintToChat(i, damageLogs[i][z]);
				}

				PrintToChat(i, "=== \x0EDamage Log\x01 ===");
			}
		}
	}
}

public void TranslateHitGroup(int group, char buffer[10])
{
	switch (group)
	{
		case 0:
			buffer = "body";
		case 1:
			buffer = "head";
		case 2:
			buffer = "chest";
		case 3:
			buffer = "stomach";
		case 4:
			buffer = "left arm";
		case 5:
			buffer = "right arm";
		case 6:
			buffer = "left leg";
		case 7:
			buffer = "right leg";
		case 10:
			buffer = "gear";
		default:
			buffer = "idk :/";
	}
}
