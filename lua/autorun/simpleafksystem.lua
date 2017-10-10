--[[-------------------------------------------------------------------------
Copyright 2017 viral32111

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

local SimpleAFKSystemVersion = "2.2.0"
local SimpleAFKSystemVersionChecked = false

if ( SERVER ) then
	print("[Simple AFK System] Loaded! (Author: viral32111) (Version: " .. SimpleAFKSystemVersion .. ")")

	util.AddNetworkString("SimpleAFKSystemAnnounce")

	include("autorun/server/sv_simpleafksystem.lua")

	AddCSLuaFile("autorun/client/cl_simpleafksystem.lua")
	include("autorun/client/cl_simpleafksystem.lua")
end

if ( CLIENT ) then
	print("This server is running Simple AFK System, Created by viral32111! (www.github.com/viral32111)")
end

hook.Add("PlayerConnect", "SimpleAFKSystemVersionCheck", function()
	if not ( SimpleAFKSystemVersionChecked ) then
		SimpleAFKSystemVersionChecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/simple-afk-system/master/VERSION.txt",
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