-- Copyright 2017 viral32111. https://github.com/viral32111/simple-afk-system/blob/master/LICENCE

local SimpleAFKSystemVersion = "2.1.4"
local SimpleAFKSystemVersionChecked = false

if ( SERVER ) then
	print("[Simple AFK System] Loaded! (Author: viral32111) (Version: " .. SimpleAFKSystemVersion .. ")")

	util.AddNetworkString("SimpleAFKSystemAnnounce")

	include("simpleafksystem/sv_chatcommands.lua")

	AddCSLuaFile("autorun/client/cl_afk_announce.lua")
	include("autorun/client/cl_afk_announce.lua")
end

if ( CLIENT ) then
	print("This server is running Simple AFK System, Created by viral32111! (www.github.com/viral32111)")
end

hook.Add( "PlayerConnect", "SimpleAFKSystemVersionCheck", function()
	if not ( SimpleAFKSystemVersionChecked ) then
		SimpleAFKSystemVersionChecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/simple-afk-system/master/VERSION.md",
		function( body, len, headers, code )
			local formattedBody = string.gsub( body, "\n", "")
			if ( formattedBody == SimpleAFKSystemVersion ) then
				MsgC( Color( 0, 255, 0 ), "[Simple AFK System] You are running the most recent version of Simple AFK System!\n")
			elseif ( formattedBody == "404: Not Found" ) then
				MsgC( Color( 255, 0, 0 ), "[Simple AFK System] Version page does not exist\n")
			else
				MsgC( Color( 255, 255, 0 ), "[Simple AFK System] You are using outdated version of Simple AFK System! (Latest: " .. formattedBody .. ", Yours: " .. SimpleAFKSystemVersion .. ")\n" )
			end
		end,
		function( error )
			MsgC( Color( 255, 0, 0 ), "[Simple AFK System] Failed to get addon version\n")
		end
		)
	end
end )