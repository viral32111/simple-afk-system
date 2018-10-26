# Simple AFK System
#### Version: 222

A feature rich AFK system for any gamemode in Garry's Mod.

Type !afk in chat to toggle AFK mode!

Features:
* Allows you to provide a reason.
* Stops other players from interacting with you.
* Blocks the player from doing anything when there AFK.
* Informs other players that your AFK.
* Remembers your weapons.
* Remembers your active weapon.
* Remembers your ammo.
* Change AFK reason while your AFK.
* Admins can set 'AFK Locations' where the player will be teleported to.

This addon includes a few hooks and functions for developers to use.
```lua
-- All hooks are in both server and client realms.

-- afkSystemPlayerEnter is called when the player becomes AFK.
hook.Add("afkSystemPlayerEnter", "playerIsNowAFK", function(ply, reason)
	print(ply:Nick() .. " is now AFK because " .. reason)
end)

-- afkSystemPlayerUpdate is called when the player updates their reason.
hook.Add("afkSystemPlayerUpdate", "playerUpdateReason", function(ply, reason)
	print(ply:Nick() .. " updated their AFK reason to " .. reason)
end)

-- afkSystemPlayerLeave is called when the player returns to the game.
hook.Add("afkSystemPlayerLeave", "playerIsNowAFK", function(ply)
	print(ply:Nick() .. " has returned to the game.")
end)

-- All functions are in both server and client realms.
-- 'PLAYER' in this case is a player object.
PLAYER:isAFK() -- Is the player AFK? Returns a boolean either true or false.
PLAYER:afkReason() -- Reason for AFK. Returns a string.
PLAYER:afkTime() -- Time they started being AFK. Returns a timestamp integer. (`os.time()`)
```

[Donate](https://viral32111.com/donate)

[Workshop Version](http://steamcommunity.com/sharedfiles/filedetails/?id=884852300)

###### [Copyright 2017-2018 viral32111](LICENCE.txt)
