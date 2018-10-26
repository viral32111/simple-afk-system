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

net.Receive("afkSystemMenu", function()
	local frame = vgui.Create("DFrame")
	frame:SetSize(300, 400)
	frame:SetTitle("Players that are currently AFK.")
	frame:SetDraggable(true)
	frame:SetScreenLock(true)
	frame:SetSizable(false)
	frame:ShowCloseButton(true)
	frame:Center()
	frame.btnMaxim:Hide()
	frame.btnMinim:Hide()
	frame:MakePopup()

	local playerList = vgui.Create("DListView", frame)
	playerList:Dock(FILL)
	playerList:SetMultiSelect(false)
	playerList:AddColumn("Name")
	playerList:AddColumn("Reason")
	playerList:AddColumn("Started")

	for k, v in pairs(player.GetAll()) do
		if (v:isAFK()) then
			playerList:AddLine(v:Nick(), v:afkReason(), os.date("%H:%M:%S" , v:afkStarted()))
		end
	end
end)