local AFK_VERSION = "2.0.1"
local AFK_UPDATE = 1

if ( SERVER ) then
	print("[AFK] Simple AFK System, Version: " .. AFK_VERSION .. ", Created by viral32111")
	print("[AFK] Loading all addon files...")

	AddCSLuaFile("autorun/client/cl_afkmenu.lua")
	print("[AFK] Added: cl_afkmenu.lua")
	include("autorun/client/cl_afkmenu.lua")
	print("[AFK] Loaded: cl_afkmenu.lua")
	include("autorun/server/sv_commands.lua")
	print("[AFK] Loaded: sv_commands.lua")
	include("autorun/server/sv_publicmessage.lua")
	print("[AFK] Loaded: sv_publicmessage.lua")
	print("[AFK] Loaded all serverside files")

	if ( file.Exists("viral32111s_scripts/simple_afk_system", "DATA") ) then
	else
		file.CreateDir("viral32111s_scripts")
		file.CreateDir("viral32111s_scripts/simple_afk_system")
	end

	if ( file.Exists("viral32111s_scripts/simple_afk_system/version_" .. AFK_VERSION .. ".txt", "DATA") ) then
	else
		file.Write( "viral32111s_scripts/simple_afk_system/version_" .. AFK_VERSION .. ".txt", AFK_VERSION )
	end

	if ( file.Exists("viral32111s_scripts/simple_afk_system/version_2.0." .. tostring(AFK_UPDATE-1) .. ".txt", "DATA") ) then
		file.Delete("viral32111s_scripts/simple_afk_system/version_2.0." .. tostring(AFK_UPDATE-1) .. ".txt")
		print("[AFK] Updated to most recent update successfully")
	else
		print("[AFK] Most recent update is not installed correctly")
	end

	print("[AFK] Finished loading all addon files")
end

if ( CLIENT ) then
	print("[AFK] Simple AFK System, Version: " .. AFK_VERSION .. ", Created by viral32111")
end