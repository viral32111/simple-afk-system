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

if ( SERVER ) then return end

surface.CreateFont("SimpleAFKSystemHUDFont", {
	font = "Trebuchet MS",
	size = 40
})

--[[-------------------------------------------------------------------------
Announcement
---------------------------------------------------------------------------]]
net.Receive("SimpleAFKSystemAnnounce", function()
	local mode = net.ReadBool()
	local ply = net.ReadEntity()

	if ( mode ) then	
		local reason = net.ReadString()

		chat.AddText( Color( 26, 198, 255 ), "(Simple AFK System) ", Color( 255, 255, 255 ), ply:Nick() .. " is now AFK!", Color( 255, 255, 0 ), " (" .. reason .. ")" )
	else
		chat.AddText( Color( 26, 198, 255 ), "(Simple AFK System) ", Color( 255, 255, 255 ), ply:Nick() .. " has returned to the game!" )
	end
end )

--[[-------------------------------------------------------------------------
HUD When AFK
---------------------------------------------------------------------------]]
hook.Add("HUDPaint", "SimpleAFKSystemHUD", function()
	local ply = LocalPlayer()

	if ( ply:GetNWBool("IsAFK", false ) ) then
		draw.DrawText("Your AFK!\nTo return to the game type !afk", "SimpleAFKSystemHUDFont", ScrW()/2, 400, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
end )