
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local LP = game.Players.LocalPlayer

local Window = Fluent:CreateWindow({
    Title = "Banana Cat Hub - Leviathan [ Premium ]",
    SubTitle = "by tài",
    TabWidth = 160,
    Size = UDim2.fromOffset(530, 430),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Size, Btn.Position, Btn.BackgroundTransparency = UDim2.new(0,60,0,60), UDim2.new(0,15,0.02,0), 1
Btn.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=127470963031421&width=420&height=420&format=png"
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1,0)
Btn.MouseButton1Click:Connect(function() Window:Minimize() end)
Attack.Kill = function(model, Succes)
		if model and Succes then
			if not model:GetAttribute("Locked") then
				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
			end
			PosMon = model:GetAttribute("Locked").Position
			BringEnemy()
			EquipWeapon(_G.SelectWeapon)
			local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
			local ToolTip = Equipped.ToolTip
			if ToolTip == "Blox Fruit" then
				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0))
			else
				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(180), 0))
			end
			if RandomCFrame then
				wait(.5)
				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(.5)
				_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
				wait(.5)
				_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 , 0))
				wait(.5)
				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(.5)
				_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			end
		end
	end
	Attack.KillSea = function(model, Succes)
		if model and Succes then
			if not model:GetAttribute("Locked") then
				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
			end
			PosMon = model:GetAttribute("Locked").Position
			BringEnemy()
			EquipWeapon(_G.SelectWeapon)
			local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
			local ToolTip = Equipped.ToolTip
			if ToolTip == "Blox Fruit" then
				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0))
			else
				notween(model.HumanoidRootPart.CFrame * CFrame.new(0, 50, 8))
				wait(.85)
				notween(model.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0))
				wait(1)
			end
		end
	end
	Useskills = function(weapon, skill)
		if weapon == "Melee" then
			weaponSc("Melee")
			if skill == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif skill == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			elseif skill == "C" then
				vim1:SendKeyEvent(true, "C", false, game);
				vim1:SendKeyEvent(false, "C", false, game);
			end
		elseif weapon == "Sword" then
			weaponSc("Sword")
			if skill == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif skill == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			end
		elseif weapon == "Blox Fruit" then
			weaponSc("Blox Fruit")
			if skill == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif skill == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			elseif skill == "C" then
				vim1:SendKeyEvent(true, "C", false, game);
				vim1:SendKeyEvent(false, "C", false, game);
			elseif skill == "V" then
				vim1:SendKeyEvent(true, "V", false, game);
				vim1:SendKeyEvent(false, "V", false, game);
			end
		elseif weapon == "Gun" then
			weaponSc("Gun")
			if skill == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif skill == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			end
		end
		if weapon == "nil" and skill == "Y" then
			vim1:SendKeyEvent(true, "Y", false, game);
			vim1:SendKeyEvent(false, "Y", false, game);
		end
	end
	CheckBoat = function()
		for i, v in pairs(workspace.Boats:GetChildren()) do
			if tostring(v.Owner.Value) == tostring(plr.Name) then
				return v
			end;
		end;
		return false
	end;
	CheckEnemiesBoat = function()
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if (v.Name == "FishBoat") and v:FindFirstChild("Health").Value > 0 then
				return true
			end;
		end;
		return false
	end;
	CheckPirateGrandBrigade = function()
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if (v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade") and v:FindFirstChild("Health").Value > 0 then
				return true
			end
		end
		return false
	end
	CheckShark = function()
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if v.Name == "Shark" and Attack.Alive(v) then
				return true
			end;
		end;
		return false
	end;
	CheckTerrorShark = function()
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if v.Name == "Terrorshark" and Attack.Alive(v) then
				return true
			end;
		end;
		return false
	end;
	CheckPiranha = function()
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if v.Name == "Piranha" and Attack.Alive(v) then
				return true
			end;
		end;
		return false
	end;
	CheckFishCrew = function()
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if (v.Name == "Fish Crew Member" or v.Name == "Haunted Crew Member") and Attack.Alive(v) then
				return true
			end;
		end;
		return false
	end;
	CheckHauntedCrew = function()
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if (v.Name == "Haunted Crew Member") and Attack.Alive(v) then
				return true
			end;
		end;
		return false
	end;
	CheckSeaBeast = function()
		if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
			return true
		end;
		return false
	end;
	CheckLeviathan = function()
		if workspace.SeaBeasts:FindFirstChild("Leviathan") then
			return true
		end;
		return false
	end;
GetWP = function(nametool)
		for _, v4 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(v4) == "table" then
				if v4.Type == "Sword" then
					if v4.Name == nametool or plr.Character:FindFirstChild(nametool) or plr.Backpack:FindFirstChild(nametool) then
						return true
					end
				end
			end
		end
		return false
	end 
spawn(function()
		while task.wait() do
			pcall(function()
				if _G.SailBoat_Hydra or _G.WardenBoss or _G.FarmBoss or _G.tpSubmarineWorker or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago  or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or getgenv().AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.AutoPole or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.Auto_StartRaid or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S or _G.FarmPhaBinh or _G.FarmTyrant or _G.HalloweenToggle or _G.AutoDefeatHalloweenDoorEnemie or _G.Werewolf then
					shouldTween = true
					if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						local Noclip = Instance.new("BodyVelocity")
						Noclip.Name = "BodyClip"
						Noclip.Parent = plr.Character.HumanoidRootPart
						Noclip.MaxForce = Vector3.new(100000, 100000, 100000)
						Noclip.Velocity = Vector3.new(0, 0, 0)
					end
					if not plr.Character:FindFirstChild('highlight') then
						local Test = Instance.new('Highlight')
						Test.Name = "highlight"
						Test.Enabled = true
						Test.FillColor = Color3.fromRGB(0, 191, 255) -- xanh nước biển
						Test.OutlineColor = Color3.fromRGB(255, 255, 255)
						Test.FillTransparency = 0.5
						Test.OutlineTransparency = 0.2
						Test.Parent = plr.Character
					end
					for _, no in pairs(plr.Character:GetDescendants()) do
						if no:IsA("BasePart") then
							no.CanCollide = false
						end
					end
				else
					shouldTween = false
					if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
					end
					if plr.Character:FindFirstChild('highlight') then
						plr.Character:FindFirstChild('highlight'):Destroy()
					end
				end
			end)
		end
	end)
local Tabs = {
 local HuntLeviathan = Window:AddTab({ Title = "Hunt Leviathan", Icon = "map" }),
local Skill = Window:AddTab({ Title = "Select And Hold Skill", Icon = "zap" }),
 local Fruit = Window:AddTab({ Title = "Fruit", Icon = "cherry" })
}

Tabs.HuntLeviathan:AddSection("Sea Event / Setting Sail")
	local ListSeaBoat = {
		"Guardian",
		"PirateGrandBrigade",
		"MarineGrandBrigade",
		"PirateBrigade",
		"MarineBrigade",
		"PirateSloop",
		"MarineSloop",
		"Beast Hunter"
	}
	local ListSeaZone = {
		"Lv 1",
		"Lv 2",
		"Lv 3",
		"Lv 4",
		"Lv 5",
		"Lv 6",
		"Lv Infinite"
	}
	local SPYING = Tabs.SeaEvent:AddParagraph({
		Title = " Spy Status ",
		Content = ""
	})
	spawn(function()
		while wait(.2) do
			pcall(function()
				local spycheck = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")
				if spycheck then
					SPYING:SetDesc(" Spy Leviathan  : " .. tostring(spycheck))
					if tostring(spycheck) == 5 then
						SPYING:SetDesc(" Spy Leviathan : Already Done!!")
					end
				end
			end)
		end
	end)
	Tabs.HuntLeviathan:AddButton({
		Title = "Buy Fracments with Spy",
		Description = "Buy the spy for finding leviathan",
		Callback = function()
			replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan", "2")
		end
	})
	local FloD = Tabs.HuntLeviathan:AddParagraph({
		Title = " FlozenDimension Status ",
		Content = ""
	})
	spawn(function()
		pcall(function()
			while wait(.2) do
				if workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
					FloD:SetDesc(' Flozen Dimension : True')
				else
					FloD:SetDesc(' Flozen Dimension : False')
				end
			end
		end)
	end)
	local Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Teleport Frozen Dimension",
		Description = "turn on for teleport to frozen dimension and start the leviathan gate",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.FrozenTP = Value
	end)
	spawn(function()
		while wait(.1) do
			if _G.FrozenTP then
				pcall(function()
					if workspace.Map:FindFirstChild("LeviathanGate") then
						_tp(workspace.Map.LeviathanGate.CFrame)
						replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLeviathanGate")
					end
				end)
			end
		end
	end)
	local Q = Tabs.Leviathan:AddToggle("Q", {
		Title = "Auto Drive To Hydra Island",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.SailBoat_Hydra = Value
	end)
	spawn(function()
		while wait() do
			if _G.SailBoat_Hydra then
				pcall(function()
					local myBoat = CheckBoat()
					if not myBoat then
						local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
						TeleportToTarget(buyBoatCFrame)
						if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end
					elseif myBoat then
						if plr.Character.Humanoid.Sit == false then
							local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
							_tp(boatSeatCFrame)
						else
							repeat
								wait()
								if CheckEnemiesBoat() or CheckPirateGrandBrigade() or CheckTerrorShark() then
									_tp(CFrame.new(5433, 150, 290))
								else
									_tp(CFrame.new(5433, 35, 290))
								end
							until _G.SailBoat_Hydra == false or plr.Character:WaitForChild("Humanoid").Sit == false
							plr.Character.Humanoid.Sit = false
						end
					end
				end)
			end
		end
	end)
	local Q = Tabs.HuntLeviathan:AddDropdown("Q", {
		Title = "Choose Boats",
		Values = ListSeaBoat,
		Multi = false,
		Default = 1
	})
	Q:OnChanged(function(Value)
		_G.SelectedBoat = Value
	end)
	Tabs.HuntLeviathan:AddButton({
		Title = "Buy Boats",
		Description = "Buy the select boats",
		Callback = function()
			replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
		end
	})
	local Q = Tabs.HuntLeviathan:AddDropdown("Q", {
		Title = "Choose Sea Level",
		Values = ListSeaZone,
		Multi = false,
		Default = 1
	})
	Q:OnChanged(function(Value)
		_G.DangerSc = Value
	end)
	local Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Sail Boat",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.SailBoats = Value
	end)
	spawn(function()
		while wait() do
			if _G.SailBoats then
				pcall(function()
					local myBoat = CheckBoat()
					if not myBoat and not(CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha) and not(CheckEnemiesBoat() and _G.FishBoat) and not(CheckSeaBeast() and _G.SeaBeast1) and not(_G.PGB and CheckPirateGrandBrigade()) and not(_G.HCM and CheckHauntedCrew()) and not(_G.Leviathan1 and CheckLeviathan()) then
						local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
						TeleportToTarget(buyBoatCFrame)
						if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end
					elseif myBoat and not(CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha) and not(CheckEnemiesBoat() and _G.FishBoat) and not(CheckSeaBeast() and _G.SeaBeast1) and not(_G.PGB and CheckPirateGrandBrigade()) and not(_G.HCM and CheckHauntedCrew()) and not(_G.Leviathan1 and CheckLeviathan()) then
						if plr.Character.Humanoid.Sit == false then
							local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
							_tp(boatSeatCFrame)
						else
							if _G.DangerSc == "Lv 1" then
								CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143)
							elseif _G.DangerSc == "Lv 2" then
								CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032)
							elseif _G.DangerSc == "Lv 3" then
								CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774)
							elseif _G.DangerSc == "Lv 4" then
								CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012)
							elseif _G.DangerSc == "Lv 5" then
								CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023)
							elseif _G.DangerSc == "Lv 6" then
								CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584)
							elseif _G.DangerSc == "Lv Infinite" then
								CFrameSelectedZone = CFrame.new(-10000000, 31, 37016.25)
							end
							repeat
								wait()
								if (not _G.FishBoat and CheckEnemiesBoat()) or (not _G.PGB and CheckPirateGrandBrigade()) or (not _G.TerrorShark and CheckTerrorShark()) then
									_tp(CFrameSelectedZone * CFrame.new(0, 150, 0))
								else
									_tp(CFrameSelectedZone)
								end
							until _G.SailBoats == false or (CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha) or CheckSeaBeast() and _G.SeaBeast1 or CheckEnemiesBoat() and _G.FishBoat or _G.Leviathan1 and CheckLeviathan() or _G.HCM and CheckHauntedCrew() or _G.PGB and CheckPirateGrandBrigade() or plr.Character:WaitForChild("Humanoid").Sit == false
							plr.Character.Humanoid.Sit = false
						end
					end
				end)
			end
		end
	end)
	spawn(function()
		while wait(Sec) do
			pcall(function()
				for a, b in pairs(workspace.Boats:GetChildren()) do
					for c, d in pairs(workspace.Boats[b.Name]:GetDescendants()) do
						if d:IsA("BasePart") then
							if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.AutofindKitIs then
								d.CanCollide = false
							else
								d.CanCollide = true
							end
						end
					end
				end
			end)
		end
	end)
	Tabs.HuntLeviathan:AddSection("Entity Sea Event")
	Q = Tabs.SeaEvent:AddToggle("Q", {
		Title = "Auto Shark",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.Shark = Value
	end)
	Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Piranha",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.Piranha = Value
	end)
	Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Terror Shark",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.TerrorShark = Value
	end)
	Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Fish Crew Member",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.MobCrew = Value
	end)
	Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Haunted Crew Member",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.HCM = Value
	end)
	Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Attack PirateGrandBrigade",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.PGB = Value
	end)
	Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Attack Fish Boat",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.FishBoat = Value
	end)
	Q = Tabs.HubtLeviathan:AddToggle("Q", {
		Title = "Auto Attack Sea Beast",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.SeaBeast1 = Value
	end)
	Q = Tabs.HuntLeviathan:AddToggle("Q", {
		Title = "Auto Attack Leviathan",
		Description = "",
		Default = false
	})
	Q:OnChanged(function(Value)
		_G.Leviathan1 = Value
	end)
	spawn(function()
		while wait() do
			pcall(function()
				if _G.Shark then
					local a = {
						"Shark"
					}
					if CheckShark() then
						for b, c in pairs(workspace.Enemies:GetChildren()) do
							if table.find(a, c.Name) then
								if Attack.Alive(c) then
									repeat
										task.wait()
										Attack.Kill(c, _G.Shark)
									until _G.Shark == false or not c.Parent or c.Humanoid.Health <= 0
								end
							end
						end
					end
				end
				if _G.TerrorShark then
					local a = {
						"Terrorshark"
					}
					if CheckTerrorShark() then
						for b, c in pairs(workspace.Enemies:GetChildren()) do
							if table.find(a, c.Name) then
								if Attack.Alive(c) then
									repeat
										task.wait()
										Attack.KillSea(c, _G.TerrorShark)
									until _G.TerrorShark == false or not c.Parent or c.Humanoid.Health <= 0
								end
							end
						end
					end
				end
				if _G.Piranha then
					local a = {
						"Piranha"
					}
					if CheckPiranha() then
						for b, c in pairs(workspace.Enemies:GetChildren()) do
							if table.find(a, c.Name) then
								if Attack.Alive(c) then
									repeat
										task.wait()
										Attack.Kill(c, _G.Piranha)
									until _G.Piranha == false or not c.Parent or c.Humanoid.Health <= 0
								end
							end
						end
					end
				end
				if _G.MobCrew then
					local a = {
						"Fish Crew Member"
					}
					if CheckFishCrew() then
						for b, c in pairs(workspace.Enemies:GetChildren()) do
							if table.find(a, c.Name) then
								if Attack.Alive(c) then
									repeat
										task.wait()
										Attack.Kill(c, _G.MobCrew)
									until _G.MobCrew == false or not c.Parent or c.Humanoid.Health <= 0
								end
							end
						end
					end
				end
				if _G.HCM then
					local a = {
						"Haunted Crew Member"
					}
					if CheckHauntedCrew() then
						for b, c in pairs(workspace.Enemies:GetChildren()) do
							if table.find(a, c.Name) then
								if Attack.Alive(c) then
									repeat
										task.wait()
										Attack.Kill(c, _G.HCM)
									until _G.HCM == false or not c.Parent or c.Humanoid.Health <= 0
								end
							end
						end
					end
				end
				if _G.SeaBeast1 then
					if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
						for a, b in pairs(workspace.SeaBeasts:GetChildren()) do
							if b:FindFirstChild("HumanoidRootPart") and b:FindFirstChild("Health") and b.Health.Value > 0 then
								repeat
									task.wait()
									spawn(function()
										_tp(CFrame.new(b.HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 200, b.HumanoidRootPart.Position.Z))
									end)
									if plr:DistanceFromCharacter(b.HumanoidRootPart.CFrame.Position) <= 500 then
										AitSeaSkill_Custom = b.HumanoidRootPart.CFrame;
										MousePos = AitSeaSkill_Custom.Position;
										if CheckF() then
											weaponSc("Blox Fruit")
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
										else
											Useskills("Melee", "Z")
											Useskills("Melee", "X")
											Useskills("Melee", "C")
											wait(.1)
											Useskills("Sword", "Z")
											Useskills("Sword", "X")
											wait(.1)
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
											wait(.1)
											Useskills("Gun", "Z")
											Useskills("Gun", "X")
										end
									end
								until _G.SeaBeast1 == false or not b:FindFirstChild("HumanoidRootPart") or not b.Parent or b.Health.Value <= 0
							end
						end
					end
				end
				if _G.Leviathan1 then
					if workspace.SeaBeasts:FindFirstChild("Leviathan") then
						for a, b in pairs(workspace.SeaBeasts:GetChildren()) do
							if b:FindFirstChild("HumanoidRootPart") and b:FindFirstChild("Leviathan Segment") and b:FindFirstChild("Health") and b.Health.Value > 0 then
								repeat
									task.wait()
									spawn(function()
										_tp(CFrame.new(b.HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 200, b.HumanoidRootPart.Position.Z))
									end)
									if plr:DistanceFromCharacter(b.HumanoidRootPart.CFrame.Position) <= 500 then
										MousePos = b:FindFirstChild("Leviathan Segment").Position;
										if CheckF() then
											weaponSc("Blox Fruit")
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
										else
											Useskills("Melee", "Z")
											Useskills("Melee", "X")
											Useskills("Melee", "C")
											wait(.1)
											Useskills("Sword", "Z")
											Useskills("Sword", "X")
											wait(.1)
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
											wait(.1)
											Useskills("Gun", "Z")
											Useskills("Gun", "X")
										end
									end
								until _G.Leviathan1 == false or not b:FindFirstChild("HumanoidRootPart") or not b.Parent or b.Health.Value <= 0
							end
						end
					end
				end
				if _G.FishBoat then
					if CheckEnemiesBoat() then
						for a, b in pairs(workspace.Enemies:GetChildren()) do
							if b:FindFirstChild("Health") and b.Health.Value > 0 and b:FindFirstChild("VehicleSeat") then
								repeat
									task.wait()
									spawn(function()
										if b.Name == "FishBoat" then
											_tp(b.Engine.CFrame * CFrame.new(0, -50, -25))
										end
									end)
									if plr:DistanceFromCharacter(b.Engine.CFrame.Position) <= 150 then
										AitSeaSkill_Custom = b.Engine.CFrame;
										MousePos = AitSeaSkill_Custom.Position;
										if CheckF() then
											weaponSc("Blox Fruit")
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
										else
											Useskills("Melee", "Z")
											Useskills("Melee", "X")
											Useskills("Melee", "C")
											wait(.1)
											Useskills("Sword", "Z")
											Useskills("Sword", "X")
											wait(.1)
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
											wait(.1)
											Useskills("Gun", "Z")
											Useskills("Gun", "X")
										end
									end
								until _G.FishBoat == false or not b:FindFirstChild("VehicleSeat") or b.Health.Value <= 0
							end
						end
					end
				end
				if _G.PGB then
					if CheckPirateGrandBrigade() then
						for a, b in pairs(workspace.Enemies:GetChildren()) do
							if b:FindFirstChild("Health") and b.Health.Value > 0 and b:FindFirstChild("VehicleSeat") then
								repeat
									task.wait()
									spawn(function()
										if b.Name == "PirateBrigade" then
											_tp(b.Engine.CFrame * CFrame.new(0, -30, -10))
										elseif b.Name == "PirateGrandBrigade" then
											_tp(b.Engine.CFrame * CFrame.new(0, -50, -50))
										end
									end)
									if plr:DistanceFromCharacter(b.Engine.CFrame.Position) <= 150 then
										AitSeaSkill_Custom = b.Engine.CFrame;
										MousePos = AitSeaSkill_Custom.Position;
										if CheckF() then
											weaponSc("Blox Fruit")
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
										else
											Useskills("Melee", "Z")
											Useskills("Melee", "X")
											Useskills("Melee", "C")
											wait(.1)
											Useskills("Sword", "Z")
											Useskills("Sword", "X")
											wait(.1)
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
											wait(.1)
											Useskills("Gun", "Z")
											Useskills("Gun", "X")
										end
									end
								until _G.PGB == false or not b:FindFirstChild("VehicleSeat") or b.Health.Value <= 0
							end
						end
					end
				end
			end)
		end
	end)

Window:SelectTab(1)
