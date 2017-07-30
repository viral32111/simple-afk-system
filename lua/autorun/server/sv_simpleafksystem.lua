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

if ( CLIENT ) then return end

hook.Add("PlayerSay", "SimpleAFKSystemAFK", function( ply, text, team )
	local text = string.lower( text )
	if ( string.sub( text, 1, 4 ) == "!afk" ) then
		if ( ply:GetNWBool("IsAFK", false ) ) then
			-- Run everything to make the player not AFK
			for k, v in pairs( player.GetAll() ) do
				net.Start("SimpleAFKSystemAnnounce")
					net.WriteBool( false )
					net.WriteEntity( ply )
				net.Send( v )
				
				v:SendLua([[ surface.PlaySound("ambient/levels/canals/windchime2.wav") ]])
			end

			if not ( ply:Alive() ) then
				ply:Spawn()
			end

			ply:StripWeapons()

			local Weapons = string.Explode("\n", file.Read( string.Replace( ply:SteamID(), ":", "_" ) .. ".txt", "DATA" ) )
			
			for _, Weapon in pairs( Weapons ) do
				ply:Give( Weapon )
			end

			ply:SelectWeapon( file.Read( string.Replace( ply:SteamID(), ":", "_" ) .. "_Current.txt", "DATA" ) )
			
			file.Delete( string.Replace( ply:SteamID(), ":", "_" ) .. ".txt" )
			file.Delete( string.Replace( ply:SteamID(), ":", "_" ) .. "_Current.txt" )
			
			ply:UnLock()
			ply:SetCollisionGroup( 0 )
			ply:SetColor( Color( 255, 255, 255, 255 ) )
			ply:SetRenderMode( RENDERMODE_NORMAL )
			ply:SetNWBool("IsAFK", false )
		else
			-- If the player is wanting to enter afk make sure to ask for a reason
			if ( string.sub( text, 6 ) != "" ) then
				for k, v in pairs( player.GetAll() ) do
					net.Start("SimpleAFKSystemAnnounce")
						net.WriteBool( true )
						net.WriteEntity( ply )
						net.WriteString( string.sub( text, 6 ) )
					net.Send( v )

					v:SendLua([[ surface.PlaySound("ambient/levels/canals/windchine1.wav") ]])
				end

				if not ( ply:Alive() ) then
					ply:Spawn()
				end

				file.Write( string.Replace( ply:SteamID(), ":", "_" ) .. ".txt", "" )
				file.Write( string.Replace( ply:SteamID(), ":", "_" ) .. "_Current.txt", ply:GetActiveWeapon():GetClass() )
				
				for _, Weapon in pairs( ply:GetWeapons() ) do
					file.Append( string.Replace( ply:SteamID(), ":", "_" ) .. ".txt", Weapon:GetClass() .. "\n" )
				end

	  			ply:StripWeapons()
	  			ply:Lock()
	  			ply:SetCollisionGroup( 20 )
	  			ply:SetColor( Color( 255, 255, 255, 200 ) )
				ply:SetRenderMode( RENDERMODE_TRANSALPHA )
	  			ply:SetNWBool("IsAFK", true )
			else
				ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Simple AFK System) ", Color( 255, 255, 255 ), "Please provide a reason for being AFK" ) ]])
			end
		end
		return ""
	end
end )