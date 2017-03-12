-- Copyright 2017 viral32111. https://github.com/viral32111/simple-afk-system/blob/master/LICENCE

if ( SERVER ) then return end

net.Receive( "SimpleAFKSystemAnnounce", function()
	local mode = net.ReadBool()
	local ply = net.ReadEntity()

	if ( mode ) then	
		local reason = net.ReadString()

		chat.AddText( Color( 0, 180, 255 ), "(Simple AFK System) ", Color( 255, 255, 255 ), ply:Nick() .. " is now AFK! (" .. reason .. ")" )
	else
		chat.AddText( Color( 0, 180, 255 ), "(Simple AFK System) ", Color( 255, 255, 255 ), ply:Nick() .. " has returned to the game!" )
	end
end )