function AFKMenu()

  	local ply = LocalPlayer()

	local DermaMain = vgui.Create( "DFrame" )
	DermaMain:SetPos( ScrW()/2-100, ScrH()/2-100 )
	DermaMain:SetSize( 200, 130 )
	DermaMain:SetTitle( "" )
	DermaMain:SetVisible( true )
	DermaMain:SetDraggable( false )
	DermaMain:ShowCloseButton( false )
	DermaMain:MakePopup()
	function DermaMain:Paint( w, h )
		draw.RoundedBox(8, 0, 0, w, h, Color(0, 100, 100))
	end
  
	local DermaLabel = vgui.Create( "DLabel" )
	DermaLabel:SetParent( DermaMain )
	DermaLabel:SetPos( 10, 0 )
	DermaLabel:SetText( "AFK System" )
	DermaLabel:SetFont("CloseCaption_Normal")
	DermaLabel:SetTextColor( Color(0, 255, 255) )
	DermaLabel:SizeToContents()

	local DermaLabel2 = vgui.Create( "DLabel" )
	DermaLabel2:SetParent( DermaMain )
	DermaLabel2:SetPos( 40, 50 )
	DermaLabel2:SetText( "Reason and time for AFK:" )
	DermaLabel2:SetTextColor( Color(0, 255, 255) )
	DermaLabel2:SizeToContents()

	local DermaLabel3 = vgui.Create( "DLabel" )
	DermaLabel3:SetParent( DermaMain )
	DermaLabel3:SetPos( 30, 30 )
	DermaLabel3:SetText( "Addon created by viral32111" )
	DermaLabel3:SetTextColor( Color(0, 255, 255) )
	DermaLabel3:SizeToContents()

	local DermaReason = vgui.Create( "DTextEntry" )
	DermaReason:SetParent( DermaMain )
	DermaReason:SetPos( 10, 65 )
	DermaReason:SetSize( 180, 20 )
	DermaReason:SetText( "No Reason..." )

	local DermaButton3 = vgui.Create( "DButton" )
	DermaButton3:SetParent( DermaMain )
	DermaButton3:SetSize( 40, 20 )
	DermaButton3:SetPos( 155, 5 )
	DermaButton3:SetText( "Close" )
	DermaButton3:SetTextColor( Color(0, 200, 200) )
	function DermaButton3.DoClick()
		function DermaButton3:Paint( w, h )
			draw.RoundedBox(2, 0, 0, w, h, Color(0, 60, 60))
		end
		timer.Simple(0.1, function()
			function DermaButton3:Paint( w, h )
				draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 50))
			end
			DermaMain:Close()
		end )
	end
	function DermaButton3:Paint( w, h )
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 50))
	end

	local DermaButton = vgui.Create( "DButton" )
	DermaButton:SetParent( DermaMain )
	DermaButton:SetSize( 180, 30 )
	DermaButton:SetPos( 10, 90 )
	DermaButton:SetText( "Go AFK!" )
	DermaButton:SetTextColor( Color(0, 200, 200) )
	function DermaButton.DoClick()
		function DermaButton:Paint( w, h )
			draw.RoundedBox(2, 0, 0, w, h, Color(0, 60, 60))
		end
		timer.Simple(0.1, function()
			function DermaButton:Paint( w, h )
				draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 50))
			end
			if ( DermaReason:GetValue() == "" ) then
				ply:ChatPrint("[AFK System] You must include a reason")
				DermaReason:SetText("Reason...")
			else
				net.Start("public_afk_message_reason")
					net.WriteString( DermaReason:GetValue() )
				net.SendToServer()
				DermaMain:Close()
			end
		end )
	end
	function DermaButton:Paint( w, h )
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 50))
	end

end
concommand.Add("afksystem_open", AFKMenu)