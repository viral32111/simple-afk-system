hook.Add( "PlayerSay", "AFK", function( ply, text, public )
	text = string.lower( text )
	if ( text == "/afk" or text == "!afk" ) then
		ply:ConCommand("afksystem_open")
		print("[AFK] " .. ply:Nick() .. " opened the Simple AFK System menu")
		return ""
	end
end )

hook.Add( "PlayerSay", "NotAFK", function( ply, text, public )
	text = string.lower( text )
	if ( text == "/notafk" or text == "!notafk" ) then
		if ( ply:IsPlayer() ) then
	    	if ( ply:Alive() ) then
  		  		PrintMessage( HUD_PRINTTALK, ply:Nick() .. " has returned to the game!")
  		  		print("[AFK] " .. ply:Nick() .. " has returned to the game!")
  		  		ply:StripAmmo()
  		  		ply:StripWeapons()
  		  		ply:Give("weapon_physgun")
  		  		ply:Give("weapon_physcannon")
	    		ply:Give("gmod_tool")
	    		ply:Give("gmod_camera")
	    		ply:SelectWeapon("weapon_physgun")
	    		ply:UnLock()
      		end
	  	end
	  	return ""
	end
end )