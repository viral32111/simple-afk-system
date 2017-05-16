-- Copyright 2017 viral32111. https://github.com/viral32111/simple-afk-system/blob/master/LICENCE

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
		draw.DrawText("Your AFK!\nTo return to the game type !notafk", "SimpleAFKSystemHUDFont", ScrW()/2, 400, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
end )