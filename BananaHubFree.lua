local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Banana Cat Hub - Blox Fruit [ Free ]",
    SubTitle = "by tài",
    TabWidth = 170,
    Size = UDim2.fromOffset(520, 380),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- [[ NÚT TOGGLE MENU ]]
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Size, Btn.Position, Btn.BackgroundTransparency = UDim2.new(0,60,0,60), UDim2.new(0,15,0.02,0), 1
Btn.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=127470963031421&width=420&height=420&format=png"
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1,0)
Btn.MouseButton1Click:Connect(function() Window:Minimize() end)


-- [[ KHỞI TẠO ĐẦY ĐỦ TABS ]]
local Tabs = {
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Status = Window:AddTab({ Title = "Status And Server", Icon = "info" }),
    LocalPlayer = Window:AddTab({ Title = "LocalPlayer", Icon = "user" }),
    SettingFarm = Window:AddTab({ Title = "Setting Farm", Icon = "settings" }),
    Skills = Window:AddTab({ Title = "Hold and Select Skill", Icon = "zap" }),
    Farming = Window:AddTab({ Title = "Farming", Icon = "swords" }),
    StackFarming = Window:AddTab({ Title = "Stack Farming", Icon = "layers" }),
    FarmingOther = Window:AddTab({ Title = "Farming Other", Icon = "plus-circle" }),
    FruitRaid = Window:AddTab({ Title = "Fruit and Raid, Dungeon", Icon = "citrus" }),
    SeaEvent = Window:AddTab({ Title = "Sea Event", Icon = "waves" }),
    UpgradeRace = Window:AddTab({ Title = "Upgrade Race", Icon = "dna" }),
    Items = Window:AddTab({ Title = "Get and Upgrade Items", Icon = "package" }),
    Volcano = Window:AddTab({ Title = "Volcano Event", Icon = "flame" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
    PVP = Window:AddTab({ Title = "PVP", Icon = "crosshair" }),
    Webhook = Window:AddTab({ Title = "Tab Webhook", Icon = "message-square" }),
    Setting = Window:AddTab({ Title = "Setting", Icon = "settings" })
}
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local LP = game.Players.LocalPlayer
local activeTween, freezeY = nil, nil

local function SetVelocity(part, enable)
    if not part then return end
    if part:FindFirstChild("CatV") then part.CatV:Destroy() end
    if part:FindFirstChild("CatA") then part.CatA:Destroy() end
    if enable then
        local att = Instance.new("Attachment", part); att.Name = "CatA"
        local lv = Instance.new("LinearVelocity", part)
        lv.Name = "CatV"
        lv.MaxForce = math.huge
        lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        lv.VectorVelocity = Vector3.zero
        lv.Attachment0 = att
    end
end

RS.Stepped:Connect(function()
    if _G.Auto and freezeY and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
        local hum = LP.Character:FindFirstChild("Humanoid")
        if hum and hum.SeatPart and hum.SeatPart.Parent:FindFirstChild("PrimaryPart") then
            local boat = hum.SeatPart.Parent.PrimaryPart
            boat.Velocity = Vector3.new(boat.Velocity.X, 0, boat.Velocity.Z)
        end
    end
end)


-- [[ LOGIC FAST ATTACK MODULE ]]
local Attack = {}
Attack.__index = Attack
Attack.Alive = function(model)
    if not model then return false end
    local Humanoid = model:FindFirstChild("Humanoid")
    return Humanoid and Humanoid.Health > 0
end
Attack.Dist = function(model, dist)
    local Root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not Root or not model:FindFirstChild("HumanoidRootPart") then return false end
    return (Root.Position - model.HumanoidRootPart.Position).Magnitude <= dist
end

-- [[ VÒNG LẶP FAST ATTACK & AUTO CLICK NGOÀI MÀN HÌNH ]]
spawn(function()
    while task.wait(0.1) do
        if _G.FastAttackToggle then
            pcall(function()
                local LP = game.Players.LocalPlayer
                if not LP.Character or not LP.Character:FindFirstChildOfClass("Tool") then return end
                
                local Enemies = workspace:FindFirstChild("Enemies")
                if Enemies then
                    for _, v in pairs(Enemies:GetChildren()) do
                        if Attack.Alive(v) and Attack.Dist(v, 55) then
                            game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterAttack"):FireServer(0)
                            game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterHit"):FireServer(v.HumanoidRootPart)
                        end
                    end
                end
                
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0.01, -500, 0.01))
            end)
        end
    end
end)
-- [[ HÀM NOCLIP TỐI ƯU ]]
_G.NoClip = true -- Mặc định bật NoClip

task.spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            if _G.NoClip and game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end)


-- Tab Shop
do
    -- Section: Abilities Shop
    Tabs.Shop:AddSection("Abilities Shop")
    
    Tabs.Shop:AddButton({
        Title = "Buy Sky Jump",
        Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo") end
    })
    Tabs.Shop:AddButton({
        Title = "Buy Buso Haki",
        Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso") end
    })
    Tabs.Shop:AddButton({
        Title = "Buy Soru",
        Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru") end
    })
    Tabs.Shop:AddButton({
        Title = "Buy Observation Haki",
        Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Buy") end
    })

    -- Section: Teleport Sea
    Tabs.Shop:AddSection("Teleport Sea")
    Tabs.Shop:AddButton({Title = "Teleport Sea 1", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end})
    Tabs.Shop:AddButton({Title = "Teleport Sea 2", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end})
    Tabs.Shop:AddButton({Title = "Teleport Sea 3", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end})

    -- Section: Misc Shop & Codes
    Tabs.Shop:AddSection("Misc Shop")
    Tabs.Shop:AddButton({
        Title = "Redeem All Codes",
        Callback = function()
            local Codes = {"REWARDFUN","NEWTROLL","KITT_RESET","Sub2CaptainMaui","DEVSCOOKING","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK","Starcodeheo","Bluxxy","fudd10_v2","FUDD10","CHANDLER","BIGNEWS","BELUGASUB","Sub2OfficialNoobie","StrawHatMaine","SUB2NOOBMASTER123","Sub2UncleKizaru","Sub2Daigrock","Axiore","TantaiGaming"}
            for _, v in pairs(Codes) do game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v) end
            Fluent:Notify({Title = "Banana Cat", Content = "Redeemed All Code", Duration = 5})
        end
    })
    Tabs.Shop:AddButton({Title = "Buy Dual Flintlock", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock") end})
    Tabs.Shop:AddButton({Title = "Reroll Race", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2") end})
    Tabs.Shop:AddButton({Title = "Reset Stats", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2") end})
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
    -- Setting Farm
    -- Section: Farm Setting
    Tabs.SettingFarm:AddSection("Attack Settings")
    Tabs.SettingFarm:AddDropdown("WeaponDropdown", {
        Title = "Select Weapon",
        Values = {"Melee", "Sword", "Gun"},
        Multi = false,
        Default = "Melee",
        Callback = function(Value) _G.SelectWeapon = Value end
    })
    Tabs.SettingFarm:AddToggle("FastAttackToggle", {
        Title = "Fast Attack",
        Default = true,
        Callback = function(Value) _G.FastAttackToggle = Value end
    })
end
    -- [[ BIẾN TOÀN CỤC ]]
_G.SpeedTween = 325

-- [[ HÀM TWEEN SERVICE TÍCH HỢP SẴN ]]
function _G:Tween(Target)
    local Character = game.Players.LocalPlayer.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local Root = Character.HumanoidRootPart
        local Distance = (Target.Position - Root.Position).Magnitude
        
        -- Tính toán thời gian dựa trên tốc độ từ hộp văn bản
        local Time = Distance / _G.SpeedTween
        local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
        
        local CreateTween = game:GetService("TweenService"):Create(Root, Info, {CFrame = Target})
        CreateTween:Play()
        
        return CreateTween
    end
end

-- [[ GIAO DIỆN ]]
do
 
    Tabs.SettingFarm:AddInput("SpeedTweenInput", {
        Title = "Speed Tween",
        Default = "325",
        Placeholder = "Input Speed Tween",
        Numeric = true,
        Finished = false, -- Cập nhật ngay lập tức khi thay đổi số
        Callback = function(Value)
            _G.SpeedTween = tonumber(Value) or 325
        end
    })
end
   -------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-- [ ELITE HUNTER - FULL SCAN LOGIC ]
-------------------------------------------------------
local function GetEliteStatus()
    local Elites = {"Deandre", "Diablo", "Urban"}
    local Found = false
    
    -- Quét toàn bộ mọi thứ trong Workspace (bao gồm tất cả folder con)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            -- Kiểm tra máu để chắc chắn boss còn sống
            if v.Humanoid.Health > 0 then
                for _, name in pairs(Elites) do
                    -- Kiểm tra tên model hoặc tên hiển thị
                    if v.Name == name or (v.Humanoid.DisplayName and v.Humanoid.DisplayName:find(name)) then
                        Found = true
                        break
                    end
                end
            end
        end
        if Found then break end
    end
    
    return "Elite Hunter : " .. (Found and "✅" or "❌")
end

-- Tạo Paragraph gọn nhất
local EliteParagraph = Tabs.Status:AddParagraph({
    Title = GetEliteStatus(), 
    Content = "" 
})

-- Vòng lặp cập nhật mỗi 2 giây để tránh lag máy
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            EliteParagraph:SetTitle(GetEliteStatus())
        end)
    end
end)

Tabs.SeaEvent:AddButton({
    Title = "Teleport To Your Boat",
    Callback = function()
        local FoundBoat = false
        local MyID = game.Players.LocalPlayer.UserId
        local MyName = game.Players.LocalPlayer.Name

        -- Hàm kiểm tra xem một Object có phải thuyền của mình không
        local function IsMyBoat(v)
            if v:IsA("Model") and (v:FindFirstChild("Owner") or v:FindFirstChild("VehicleSeat")) then
                local ownerNode = v:FindFirstChild("Owner")
                -- Kiểm tra qua Value của Owner (có thể là Name hoặc UserId)
                if ownerNode and (tostring(ownerNode.Value) == MyName or tostring(ownerNode.Value) == tostring(MyID)) then
                    return true
                end
            end
            return false
        end

        -- Quét trong folder Boats (Chỗ phổ biến nhất)
        local BoatFolder = workspace:FindFirstChild("Boats")
        local SearchTarget = BoatFolder and BoatFolder:GetChildren() or workspace:GetChildren()

        for _, v in pairs(SearchTarget) do
            if IsMyBoat(v) then
                local Seat = v:FindFirstChildOfClass("VehicleSeat") or v:FindFirstChild("MainSeat", true)
                if Seat then
                    LP.Character.HumanoidRootPart.CFrame = Seat.CFrame + Vector3.new(0, 3, 0)
                    FoundBoat = true
                    Fluent:Notify({Title = "Banana Cat Hub", Content = "Found your boat!", Duration = 3})
                    break
                end
            end
        end

        -- Nếu vẫn không thấy, quét toàn bộ workspace (Trường hợp game đổi folder)
        if not FoundBoat then
            for _, v in pairs(workspace:GetChildren()) do
                if IsMyBoat(v) then
                    local Seat = v:FindFirstChildOfClass("VehicleSeat")
                    if Seat then
                        LP.Character.HumanoidRootPart.CFrame = Seat.CFrame + Vector3.new(0, 3, 0)
                        FoundBoat = true
                        break
                    end
                end
            end
        end

        if not FoundBoat then
            Fluent:Notify({Title = "Banana Cat Hub", Content = "Boat not found! Try spawning it again.", Duration = 3})
        end
    end
})

local ToggleFind = Tabs.SeaEvent:AddToggle("FindLevi", { Title = "Find Leviathan", Default = false })

ToggleFind:OnChanged(function(Value)
    _G.Auto = Value
    if Value then
        task.spawn(function()
            local notified = false
            while _G.Auto do
                pcall(function()
                    local hum = LP.Character:FindFirstChild("Humanoid")
                    local seat = hum and hum.SeatPart
                    
                    if seat and seat:IsA("VehicleSeat") then
                        local IsFrozen = workspace:FindFirstChild("FrozenDimension", true)
                        
                        if IsFrozen then
                            if activeTween then activeTween:Cancel() end
                            freezeY = nil
                            SetVelocity(seat.Parent.PrimaryPart, false)
                            if not notified then
                                Fluent:Notify({Title = "Banana Cat Hub", Content = "Frozen Dimension Spawned...", Duration = 5})
                                notified = true
                            end
                            repeat task.wait(0.5) until not workspace:FindFirstChild("FrozenDimension", true) or not _G.Auto
                        else
                            notified = false
                            local boat = seat.Parent.PrimaryPart
                            SetVelocity(boat, true)
                            
                            freezeY = 1000
                            boat.CFrame = CFrame.new(boat.Position.X, 1000, boat.Position.Z)
                            task.wait(1)
                            
                            if _G.Auto and not workspace:FindFirstChild("FrozenDimension", true) and hum.SeatPart == seat and boat.Position.Z < 14238 then
                                local dist = (Vector3.new(-13608, 1000, 14238) - boat.Position).Magnitude
                                activeTween = TS:Create(boat, TweenInfo.new(dist/250, Enum.EasingStyle.Linear), {CFrame = CFrame.new(-13608, 1000, 14238)})
                                activeTween:Play()
                                
                                while _G.Auto and activeTween and activeTween.PlaybackState == Enum.PlaybackState.Playing and hum.SeatPart == seat do
                                    if workspace:FindFirstChild("FrozenDimension", true) then activeTween:Cancel() break end
                                    task.wait(0.1)
                                end
                            end
                            
                            if _G.Auto and not workspace:FindFirstChild("FrozenDimension", true) and hum.SeatPart == seat then
                                if activeTween then activeTween:Cancel() end
                                freezeY = 175
                                boat.CFrame = CFrame.new(boat.Position.X, 175, boat.Position.Z)
                                task.wait(1)
                                
                                if _G.Auto and not workspace:FindFirstChild("FrozenDimension", true) and hum.SeatPart == seat then
                                    local targetCFrame = CFrame.new(boat.Position.X, 175, 1000000)
                                    activeTween = TS:Create(boat, TweenInfo.new(4000, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
                                    activeTween:Play()
                                    
                                    while _G.Auto and activeTween and activeTween.PlaybackState == Enum.PlaybackState.Playing and hum.SeatPart == seat do
                                        if workspace:FindFirstChild("FrozenDimension", true) then activeTween:Cancel() break end
                                        pcall(function() boat.CatV.VectorVelocity = boat.CFrame.LookVector * 250 end)
                                        task.wait(0.1)
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    else
        if activeTween then activeTween:Cancel() end
        freezeY = nil
        pcall(function()
            local hum = LP.Character:FindFirstChild("Humanoid")
            if hum and hum.SeatPart then
                SetVelocity(hum.SeatPart.Parent.PrimaryPart, false)
                hum.SeatPart.Parent.PrimaryPart.CFrame = CFrame.new(hum.SeatPart.Parent.PrimaryPart.Position.X, 28, hum.SeatPart.Parent.PrimaryPart.Position.Z)
            end
        end)
    end
end)

Tabs.LocalPlayer:AddDropdown("TeamDropdown", {
    Title = "Auto Select Team",
    Values = {"Pirates", "Marines"},
    Multi = false,
    Default = "Marines",
    Callback = function(Value)
        _G.SelectedTeam = Value -- Lưu lựa chọn vào biến toàn cục
    end
})


-- [[ QUẢN LÝ CẤU HÌNH ]]
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:BuildInterfaceSection(Tabs.Setting)
SaveManager:BuildConfigSection(Tabs.Setting)

Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
task.spawn(function()
    -- Đợi game load và cấu hình cũ được tải xong
    repeat task.wait() until game:IsLoaded()
    task.wait(1.5) -- Đợi SaveManager ổn định dữ liệu

    -- KIỂM TRA: Chỉ thực hiện nếu Team hiện tại là nil (Chưa chọn team)
    if game.Players.LocalPlayer.Team == nil then
        local TargetTeam = _G.SelectedTeam or "Pirates" -- Nếu không có cấu hình thì mặc định Pirates
        
        repeat
            task.wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", TargetTeam)
        until game.Players.LocalPlayer.Team ~= nil or not game:IsLoaded()
        
        Fluent:Notify({
            Title = "Banana Cat Hub",
            Content = "Đã tự động chọn phe: " .. TargetTeam,
            Duration = 5
        })
    else
        -- Nếu đã có team rồi thì thông báo để bạn biết
        print("Banana Cat: Bạn đã ở trong team, bỏ qua tự động chọn.")
    end
end)

Fluent:Notify({
    Title = "Banana Cat Hub [ Free ]",
    Content = "Loaded Successfully",
    Duration = 5
})

-- Anti-Idle
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
