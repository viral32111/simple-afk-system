util.AddNetworkString("public_afk_message_reason", false)
net.Receive("public_afk_message_reason", function( len, pl )
	local networkstring = net.ReadString()
	PrintMessage( HUD_PRINTTALK, pl:Nick() .. " is now AFK! (" .. networkstring .. ")")
	print( "[AFK] " .. pl:Nick() .. " is now AFK! (" .. networkstring .. ")" )
	if ( pl:IsPlayer() ) then
		if ( pl:Alive() ) then
			pl:StripWeapons()
			pl:StripAmmo()
			pl:Lock()
		end
  	end
end )