--[[-------------------------------------------------------------------------
Copyright 2017-2018 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

-- Add vector positions here if you want to send the player to a specific place when they go AFK. Leave blank to not update their position.
-- The position will be randomly selected out of the vectors in the list.
-- For more information on Vector objects, check out: http://wiki.garrysmod.com/page/Global/Vector
local afkPositions = {
	-- Example where X is 100, Y is 200 and Z is 300: Vector(100, 200, 300)
	
}

-- Don't touch code below this line, only config above.
util.AddNetworkString("afkSystemAnnounce")
util.AddNetworkString("afkSystemMenu")

hook.Add("PlayerSay", "afkSystemCommand", function(ply, text, team)
	local lowText = string.lower(text)

	if (lowText == "!afkplayers") then
		net.Start("afkSystemMenu")
		net.Send(ply)
	elseif (string.sub(lowText, 1, 4) == "!afk") then
		if (ply:isAFK()) then
			local reason = string.sub(text, 6)

			if (reason != "") then
				-- Announce it
				net.Start("afkSystemAnnounce")
					net.WriteEntity(ply)
					net.WriteString(reason)
				net.Broadcast()

				-- Call all hooks
				hook.Call("afkSystemPlayerUpdate", GAMEMODE, ply, reason)

				-- Log it
				ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> has changed their AFK reason to: '" .. reason .. "'\n")

				-- Old sound: "ambient/levels/canals/windchine1.wav"
			else
				-- Firstly update their state so restrictions don't apply.
				ply:SetNWBool("isAFK", false)

				-- Respawn the player
				if not (ply:Alive()) then
					ply:Spawn()
				end

				-- Fetch info from database them remove the row
				local result = sql.Query("SELECT weapons, position FROM afkSystem WHERE steamid = '" .. ply:SteamID64() .. "'")
				sql.Query("DELETE FROM afksystem WHERE steamid = '" .. ply:SteamID64() .. "'")

				-- Update position
				local position = result[1]["position"]
				local position = string.Explode(";", position)
				local position = Vector(position[1], position[2], position[3])

				timer.Simple(0.01, function()
					ply:SetPos(position)
				end)

				-- Give back weapons
				local weapons = result[1]["weapons"]
				local weapons = string.Explode(";", weapons)

				for _, weaponClass in pairs(weapons) do
					ply:Give(weaponClass)
				end

				ply:SelectWeapon(weapons[1])

				-- Announce it
				net.Start("afkSystemAnnounce")
					net.WriteEntity(ply)
				net.Broadcast()

				-- Call all hooks
				hook.Call("afkSystemPlayerLeave", GAMEMODE, ply)

				-- Log it
				ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> has returned to the game.\n")
				
				-- Update the player
				ply:UnLock()
				ply:SetCollisionGroup(0)
				
				local color = ply:GetColor()
				ply:SetColor(Color(color.r, color.g, color.b, 200))
				ply:SetRenderMode(RENDERMODE_TRANSALPHA)

				-- Old sound: "ambient/levels/canals/windchime2.wav"
			end
		else
			-- Respawn the player
			local oldPos = ply:GetPos()

			if not (ply:Alive()) then
				ply:Spawn()
			end

			-- Update position
			timer.Simple(0.01, function()
				if (table.Count(afkPositions) >= 1) then
					local vector = table.Random(afkPositions)
					ply:SetPos(vector)
					ply:SetEyeAngles(Angle(0, 0, 0))
				else
					ply:SetPos(oldPos)
				end
			end)

			-- Fetch the players weapons
			local weapons = "none"

			if (table.Count(ply:GetWeapons()) >= 1) then
				weapons = ply:GetActiveWeapon():GetClass() .. ";"

				for _, weapon in pairs(ply:GetWeapons()) do
					if (weapon:GetClass() != ply:GetActiveWeapon():GetClass()) then
						weapons = weapons .. weapon:GetClass() .. ";"
					end
				end

				weapons = string.sub(weapons, 0, string.len(weapons)-1)
			end

			-- Convert position into string.
			local position = oldPos.x .. ";" .. oldPos.y .. ";" .. oldPos.z

			-- Save to the database
			sql.Query("DELETE FROM afksystem WHERE steamid = '" .. ply:SteamID64() .. "'")
			sql.Query("INSERT INTO afksystem (steamid, weapons, position) VALUES ('" .. ply:SteamID64() .. "', '" .. weapons .. "', '" .. position .. "')")

			-- Update player
			ply:StripWeapons()
			ply:Lock()
			ply:SetCollisionGroup(20)

			local color = ply:GetColor()
			ply:SetColor(Color(color.r, color.g, color.b, 200))
			ply:SetRenderMode(RENDERMODE_TRANSALPHA)

			-- Announce it
			local reason = string.sub(text, 6)
			if (reason == "") then
				reason = "No reason provided."
			end

			net.Start("afkSystemAnnounce")
				net.WriteEntity(ply)
				net.WriteString(reason)
			net.Broadcast()

			-- Call all hooks
			hook.Call("afkSystemPlayerEnter", GAMEMODE, ply, reason)

			-- Log it
			ServerLog(ply:Nick() .. "<" .. ply:SteamID() .. "> is now AFK. (" .. reason .. ")\n")

			-- Update their AFK state
			ply:SetNWBool("isAFK", true)
			ply:SetNWString("afkReason", reason)
			ply:SetNWInt("afkStarted", os.time())

			-- Old sound: "ambient/levels/canals/windchine1.wav"
		end

		return ""
	end
end)