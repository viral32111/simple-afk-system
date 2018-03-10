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

SimpleAFKSystem = {}
SimpleAFKSystem.Version = 221
SimpleAFKSystem.Name = "Simple AFK System"

AddCSLuaFile("autorun/client/cl_simpleafksystem.lua")

if ( SERVER ) then
	util.AddNetworkString("SimpleAFKSystemAnnounce")
end

hook.Add("PlayerConnect", SimpleAFKSystem.Name .. "VersionCheck", function()
	http.Fetch("https://raw.githubusercontent.com/viral32111/simple-afk-system/master/README.md", function( LatestVersion )
		local LatestVersion = tonumber( string.sub( LatestVersion, string.len( SimpleAFKSystem.Name )+18, string.len( SimpleAFKSystem.Name )+21 ) )
		if ( LatestVersion == SimpleAFKSystem.Version ) then
			print("[" .. SimpleAFKSystem.Name .. "] You are running the latest version!")
		elseif ( LatestVersion > SimpleAFKSystem.Version ) then
			print("[" .. SimpleAFKSystem.Name .. "] You are running an outdated version! (Latest: " .. LatestVersion .. ", Current: " .. SimpleAFKSystem.Version .. ")")
		elseif ( LatestVersion < SimpleAFKSystem.Version ) then
			print("[" .. SimpleAFKSystem.Name .. "] You are running a future version, Please reinstall the addon. (Latest: " .. LatestVersion .. ", Current: " .. SimpleAFKSystem.Version .. ")")
		else
			print("[" .. SimpleAFKSystem.Name .. "] Failed to parse addon version! (Latest: " .. LatestVersion .. ", Current: " .. SimpleAFKSystem.Version .. ")")
		end
	end, function( error )
		print("[" .. SimpleAFKSystem.Name .. "] Failed to get addon version! (" .. error .. ")")
	end )

	hook.Remove("PlayerConnect", SimpleAFKSystem.Name .. "VersionCheck")
end )

print("[" .. SimpleAFKSystem.Name .. "] Loaded Version: " .. SimpleAFKSystem.Version)