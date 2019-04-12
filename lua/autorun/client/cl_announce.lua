--[[-------------------------------------------------------------------------
Copyright 2017-2019 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

net.Receive("afkSystemAnnounce", function()
	local ply = net.ReadEntity()
	local reason = net.ReadString()

	if (reason == "") then
		chat.AddText(Color(255, 255, 255), ply:Nick() .. " has returned to the game.")
	elseif (ply:isAFK()) then
		chat.AddText(Color(255, 255, 255), ply:Nick() .. " has updated their AFK status.", Color(66, 185, 244), " (" .. reason .. ")")
	else
		chat.AddText(Color(255, 255, 255), ply:Nick() .. " is now AFK.", Color(66, 185, 244), " (" .. reason .. ")")
	end
end)