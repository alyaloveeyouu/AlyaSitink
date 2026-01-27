local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local PlaceId = game.PlaceId

-- [[ CẤU HÌNH BANANA CAT HUB ]]
local Window = Fluent:CreateWindow({
    Title = "Banana Cat Hub - Leviathan [ Premium ]",
    SubTitle = "by tài",
    TabWidth = 170,
    Size = UDim2.fromOffset(520, 380),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- [[ NUT TOGGLE UI ]]
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Name = "BananaCatToggle"
Btn.Size = UDim2.new(0, 60, 0, 60)
Btn.Position = UDim2.new(0, 15, 0.12, 0)
Btn.BackgroundTransparency = 1
Btn.Image = "rbxassetid://127470963031421"
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)
Btn.MouseButton1Click:Connect(function() Window:Minimize() end)

-- [[ KHỞI TẠO TABS ]]
local Tabs = {
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Status = Window:AddTab({ Title = "Status And Server", Icon = "info" }),
    LocalPlayer = Window:AddTab({ Title = "LocalPlayer", Icon = "user" }),
    SettingFarm = Window:AddTab({ Title = "Setting Farm", Icon = "settings" }),
    Skills = Window:AddTab({ Title = "Hold and Select Skill", Icon = "zap" }),
    Farming = Window:AddTab({ Title = "Farming", Icon = "swords" }),
    StackFarming = Window:AddTab({ Title = "Stack Farming", Icon = "layers" }),
    FarmingOther = Window:AddTab({ Title = "Farming Other", Icon = "plus-circle" }),
    FruitRaid = Window:AddTab({ Title = "Fruit and Raid", Icon = "citrus" }),
    SeaEvent = Window:AddTab({ Title = "Sea Event", Icon = "waves" }),
    UpgradeRace = Window:AddTab({ Title = "Upgrade Race", Icon = "dna" }),
    Items = Window:AddTab({ Title = "Get Items", Icon = "package" }),
    Volcano = Window:AddTab({ Title = "Volcano Event", Icon = "flame" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
    PVP = Window:AddTab({ Title = "PVP", Icon = "crosshair" }),
    Webhook = Window:AddTab({ Title = "Webhook", Icon = "message-square" }),
    Setting = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

	local Attack = {}
	Attack.__index = Attack
	Attack.Alive = function(model)
		if not model then
			return
		end
		local Humanoid = model:FindFirstChild("Humanoid")
		return Humanoid and Humanoid.Health > 0
	end
	Attack.Pos = function(model, dist)
		return (Root.Position - mode.Position).Magnitude <= dist
	end
	Attack.Dist = function(model, dist)
		return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist
	end
	Attack.DistH = function(model, dist)
		return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist
	end
	Attack.Kill = function(model, Succes)
		if model and Succes then
			if not model:GetAttribute("Locked") then
				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
			end
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0.01, -500, 0.01))
                end
            end)
        end
    end
end)

-- [[ ANTI IDLE ]]
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- [[ NỘI DUNG TABS ]]
do
    -- Shop Section
    Tabs.Shop:AddSection("Misc Shop")
    Tabs.Shop:AddButton({
        Title = "Redeem All Codes",
        Callback = function()
            local Codes = {"REWARDFUN","NEWTROLL","KITT_RESET","Sub2CaptainMaui","DEVSCOOKING","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK","Starcodeheo","Bluxxy","fudd10_v2","FUDD10","CHANDLER","BIGNEWS","BELUGASUB","Sub2OfficialNoobie","StrawHatMaine","SUB2NOOBMASTER123","Sub2UncleKizaru","Sub2Daigrock","Axiore","TantaiGaming","STRAWHATMAINE"}
            for _, v in pairs(Codes) do game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v) end
            Fluent:Notify({Title = "Banana Cat", Content = "Redeemed all codes!", Duration = 5})
        end
    })

    -- Teleports
    Tabs.Shop:AddButton({Title = "Teleport Sea 1", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end})
    Tabs.Shop:AddButton({Title = "Teleport Sea 2", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end})
    Tabs.Shop:AddButton({Title = "Teleport Sea 3", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end})
    Tabs.Shop:AddButton({
        Title = "Buy Dual Flintlock",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
        end
    })

    Tabs.Shop:AddButton({
        Title = "Reroll Race",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
        end
    })

    Tabs.Shop:AddButton({
        Title = "Reset Stats",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
        end
    })

    Tabs.Shop:AddButton({
        Title = "Buy Race Cyborg",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
        end
    })

    Tabs.Shop:AddButton({
        Title = "Buy Race Ghoul",
        Callback = function()
            local v366 = {[1] = "Ectoplasm", [2] = "Change", [3] = 4}
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v366))
        end
    })
    -- Setting Farm Section
    Tabs.SettingFarm:AddSection("Attack Settings")
    
    Tabs.SettingFarm:AddDropdown("WeaponDropdown", {
        Title = "Select Weapon",
        Values = {"Melee", "Sword", "Gun"},
        Multi = false,
        Default = "Melee"
    })

    Tabs.SettingFarm:AddToggle("FastAttackToggle", {
        Title = "Fast Attack",
        Default = true
        Callback = function()
        local Attack = {}
	Attack.__index = Attack
	Attack.Alive = function(model)
		if not model then
			return
		end
		local Humanoid = model:FindFirstChild("Humanoid")
		return Humanoid and Humanoid.Health > 0
	end
	Attack.Pos = function(model, dist)
		return (Root.Position - mode.Position).Magnitude <= dist
	end
	Attack.Dist = function(model, dist)
		return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist
	end
	Attack.DistH = function(model, dist)
		return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist
	end
	Attack.Kill = function(model, Succes)
		if model and Succes then
			if not model:GetAttribute("Locked") then
				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
			end
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0.01, -500, 0.01))
                end
            end)
        end
    end
end)

-- [[ ANTI IDLE ]]
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
    })
    end
    -- [[ QUẢN LÝ LƯU CẤU HÌNH ]]
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Thiết lập các tùy chọn bỏ qua (nếu có)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

-- Xây dựng giao diện lưu/tải cấu hình trong Tab Setting
InterfaceManager:BuildInterfaceSection(Tabs.Setting)
SaveManager:BuildConfigSection(Tabs.Setting)

-- Chọn Tab mặc định khi mở Script (Tab 1 là Shop)
Window:SelectTab(1)

-- Tự động tải cấu hình đã lưu từ trước (Autoload)
SaveManager:LoadAutoloadConfig()

-- Thông báo cho người dùng khi Script đã sẵn sàng
Fluent:Notify({
    Title = "Banana Cat Hub - Leviathan",
    Content = "Tất cả cấu hình đã được áp dụng!",
    Duration = 5
})

-- In log kiểm tra để chắc chắn script đã chạy đến dòng cuối cùng
print("Banana Cat Hub - Premium [ Loaded Successfully ]")
