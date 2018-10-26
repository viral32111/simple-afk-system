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

local version = 222

AddCSLuaFile("autorun/client/cl_announce.lua")
AddCSLuaFile("autorun/client/cl_hud.lua")
AddCSLuaFile("autorun/client/cl_menu.lua")

AddCSLuaFile("autorun/shared/sh_functions.lua")
include("autorun/shared/sh_functions.lua")

hook.Add("PlayerConnect", "afkSystemVersionCheck", function()
	http.Fetch("https://raw.githubusercontent.com/viral32111/simple-afk-system/master/README.md", function(body, size, headers, code)
		local latestVersion = tonumber(string.sub(body, string.len("Simple AFK System")+18, string.len("Simple AFK System")+21))

		if (latestVersion != version) then
			print("[Simple AFK System] Please update the addon to version: " .. latestVersion .. ". You are running version: " .. version .. ".")
		end
	end, function(error)
		print("[Simple AFK System] Failed to get addon version! (" .. error .. ")")
	end )

	hook.Remove("PlayerConnect", "afkSystemVersionCheck")
end )

print("[Simple AFK System] Loaded Version: " .. version)