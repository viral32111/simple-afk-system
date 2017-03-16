-- Copyright 2017 viral32111. https://github.com/viral32111/simple-afk-system/blob/master/LICENCE

local addonVersion = "2.1.0"
local versionchecked = false

if ( SERVER ) then
	print("[Simple AFK System] Loaded addon!")
	print("[Simple AFK System] Author: viral32111 (www.github.com/viral32111)")
	print("[Simple AFK System] Version: " .. addonVersion )

	util.AddNetworkString("SimpleAFKSystemAnnounce")

	include("autorun/server/sv_simpleafksystem.lua")

	AddCSLuaFile("autorun/client/cl_announce.lua")
	include("autorun/client/cl_announce.lua")
end

if ( CLIENT ) then
	print("This server is running Simple AFK System, Created by viral32111! (www.github.com/viral32111)")
end

hook.Add( "PlayerConnect", "SimpleAFKSystemLoad", function()
	if not ( versionchecked ) then
		versionchecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/simple-afk-system/master/VERSION.md",
		function( body, len, headers, code )
			local formattedBody = string.gsub( body, "\n", "")
			if ( formattedBody == addonVersion ) then
				print("[Simple AFK System] You are running the most recent version of Simple AFK System!")
			elseif ( formattedBody == "404: Not Found" ) then
				Error("[Simple AFK System] Version page does not exist\n")
			else
				print("[Simple AFK System] You are using outdated version of Simple AFK System! (Latest: " .. formattedBody .. ", Yours: " .. addonVersion .. ")" )
			end
		end,
		function( error )
			Error("[Simple AFK System] Failed to get addon version\n")
		end
		)
	end
end )