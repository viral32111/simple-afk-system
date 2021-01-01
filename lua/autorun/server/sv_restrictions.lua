--[[-------------------------------------------------------------------------
Copyright 2017 - 2021 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
Player spawns prop, effect or ragdoll.
---------------------------------------------------------------------------]]
hook.Add("PlayerSpawnObject", "afkSystemObject", function(ply, model, skin)
	if (ply:isAFK()) then
		ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> attempted to spawn object: '" .. model .. "' while AFK.\n")

		ply:SendLua('notification.AddLegacy("You cannot spawn objects while AFK.", NOTIFY_ERROR, 4) surface.PlaySound("buttons/button10.wav")')

		return false
	end
end)

--[[-------------------------------------------------------------------------
Player spawns a weapon
---------------------------------------------------------------------------]]
hook.Add("PlayerSpawnSWEP", "afkSystemSWEP", function(ply, weapon, swep)
	if (ply:isAFK()) then
		ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> attempted to spawn weapon: '" .. weapon .. "' while AFK.\n")

		ply:SendLua('notification.AddLegacy("You cannot spawn weapons while AFK.", NOTIFY_ERROR, 4) surface.PlaySound("buttons/button10.wav")')

		return false
	end
end)

--[[-------------------------------------------------------------------------
Player spawns an entity
---------------------------------------------------------------------------]]
hook.Add("PlayerSpawnSENT", "afkSystemSENT", function(ply, class)
	if (ply:isAFK()) then
		ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> attempted to spawn entity: '" .. class .. "' while AFK.\n")

		ply:SendLua('notification.AddLegacy("You cannot spawn entities while AFK.", NOTIFY_ERROR, 4) surface.PlaySound("buttons/button10.wav")')

		return false
	end
end)

--[[-------------------------------------------------------------------------
Player spawns an NPC
---------------------------------------------------------------------------]]
hook.Add("PlayerSpawnNPC", "afkSystemNPC", function(ply, npc_type, weapon)
	if (ply:isAFK()) then
		ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> attempted to spawn npc: '" .. npc_type .. "' while AFK.\n")

		ply:SendLua('notification.AddLegacy("You cannot spawn NPCs while AFK.", NOTIFY_ERROR, 4) surface.PlaySound("buttons/button10.wav")')

		return false
	end
end)

--[[-------------------------------------------------------------------------
Player spawns a vehicle
---------------------------------------------------------------------------]]
hook.Add("PlayerSpawnVehicle", "afkSystemVehicle", function(ply, model, name, table)
	if (ply:isAFK()) then
		ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> attempted to spawn vehicle: '" .. name .. "' while AFK.\n")

		ply:SendLua('notification.AddLegacy("You cannot spawn vehicles while AFK.", NOTIFY_ERROR, 4) surface.PlaySound("buttons/button10.wav")')

		return false
	end
end)

--[[-------------------------------------------------------------------------
Player tries to pickup a weapon
---------------------------------------------------------------------------]]
hook.Add("PlayerCanPickupWeapon", "afkSystemPickupSWEP", function(ply, weapon)
	if (ply:isAFK()) then
		ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> attempted to pickup weapon: '" .. weapon:GetClass() .. "' while AFK.\n")

		return false
	end
end)

--[[-------------------------------------------------------------------------
Player tries to pickup an item
---------------------------------------------------------------------------]]
hook.Add("PlayerCanPickupItem", "afkSystemPickupItem", function(ply, item)
	if (ply:isAFK()) then
		ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> attempted to pickup weapon: '" .. item:GetClass() .. "' while AFK.\n")

		return false
	end
end)

--[[-------------------------------------------------------------------------
Player tries to drive
---------------------------------------------------------------------------]]
hook.Add("CanDrive", "afkSystemCanDrive", function(ply, ent)
	if (ply:isAFK()) then
		ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> attempted to drive entity: '" .. ent:GetClass() .. "' while AFK.\n")

		ply:SendLua('notification.AddLegacy("You cannot drive while AFK.", NOTIFY_ERROR, 4) surface.PlaySound("buttons/button10.wav")')

		return false
	end
end)