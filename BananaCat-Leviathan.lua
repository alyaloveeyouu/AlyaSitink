-- Banana Cat Hub - Leviathan [ Premium ]
-- Subtitle: by tài

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

-- Tạo đầy đủ các Tab
local Tabs = {
    HuntLeviathan = Window:AddTab({ Title = "Hunt Leviathan" }),
    Skill = Window:AddTab({ Title = "Select And Hold Skill" }),
    Fruit = Window:AddTab({ Title = "Fruit" })
}

-- Nút Toggle UI (Hide/Show)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Size = UDim2.new(0, 60, 0, 60)
Btn.Position = UDim2.new(0, 15, 0.05, 0)
Btn.Image = "rbxassetid://127470963031421"
Btn.BackgroundTransparency = 1
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)
Btn.MouseButton1Click:Connect(function() Window:Minimize() end)

local activeTween, freezeY, lv = nil, nil, nil

-- Hàm tạo lực giữ thuyền không dùng Anchored
local function SetVelocity(part, enable)
    if part:FindFirstChild("CatV") then part.CatV:Destroy() end
    if part:FindFirstChild("CatA") then part.CatA:Destroy() end
    if enable then
        local att = Instance.new("Attachment", part); att.Name = "CatA"
        local newLV = Instance.new("LinearVelocity", part)
        newLV.Name = "CatV"
        newLV.MaxForce = math.huge
        newLV.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        newLV.VectorVelocity = Vector3.new(0, 0, 0)
        newLV.Attachment0 = att
    end
end

-- Khóa cao độ nhân vật độc lập
RS.Stepped:Connect(function()
    if _G.Auto and freezeY and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        hrp.CFrame = CFrame.new(hrp.Position.X, freezeY, hrp.Position.Z)
        hrp.Velocity = Vector3.zero
    end
end)

--- [ TAB: HUNT LEVIATHAN ] ---

local SPYING = Tabs.HuntLeviathan:AddParagraph({
    Title = " Spy Status ",
    Content = ""
})

spawn(function()
    while wait(.2) do
        pcall(function()
            local spycheck = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")
            if spycheck then
                SPYING:SetDesc(" Spy Leviathan  : " .. tostring(spycheck))
                if tostring(spycheck) == "5" then
                    SPYING:SetDesc(" Spy Leviathan : Already Done!!")
                end
            end
        end)
    end
end)
local FloD = Tabs.HuntLeviathan:AddParagraph({
    Title = " Frozen Dimension Status ",
    Content = ""
})

spawn(function()
    while wait(.2) do
        pcall(function()
            if workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
                FloD:SetDesc(' Frozen Dimension : True')
            else
                FloD:SetDesc(' Frozen Dimension : False')
            end
        end)
    end
end)
Tabs.HuntLeviathan:AddToggle("BuySpy", {
    Title = "Buy Spy",
    Default = false,
    Callback = function(Value)
        if Value then
            replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan", "2")
        end
    end
})
Tabs.HuntLeviathan:AddToggle("Find", { Title = "Find Leviathan", Default = false }):OnChanged(function(Value)
    _G.Auto = Value
    local hum = LP.Character:FindFirstChild("Humanoid")
    if Value then
        task.spawn(function()
            local seat = hum.SeatPart
            if not (seat and seat:IsA("VehicleSeat")) then 
                Fluent:Notify({Title = "Thông báo", Content = "Hãy ngồi vào ghế lái!", Duration = 5})
                return 
            end
            local boat = seat.Parent.PrimaryPart
            
            -- Quy trình lên 1000m
            freezeY = 1000
            SetVelocity(boat, true)
            boat.CFrame = CFrame.new(boat.Position.X, 1000, boat.Position.Z)
            repeat task.wait() until math.abs(LP.Character.HumanoidRootPart.Position.Y - 1000) < 5
            
            if boat.Position.Z < 14238 then
                local p1 = Vector3.new(-13608, 1000, 14238)
                activeTween = TS:Create(boat, TweenInfo.new((p1 - boat.Position).Magnitude/250, Enum.EasingStyle.Linear), {CFrame = CFrame.new(p1)})
                activeTween:Play()
                activeTween.Completed:Wait()
            end
            
            -- Quy trình xuống 175m
            if _G.Auto then
                freezeY = 175
                boat.CFrame = CFrame.new(boat.Position.X, 175, boat.Position.Z)
                repeat task.wait() until math.abs(LP.Character.HumanoidRootPart.Position.Y - 175) < 5
                task.wait(2)
                local p2 = boat.Position + Vector3.new(0, 0, 1000000)
                activeTween = TS:Create(boat, TweenInfo.new((p2 - boat.Position).Magnitude/250, Enum.EasingStyle.Linear), {CFrame = CFrame.new(p2)})
                activeTween:Play()
            end

            while _G.Auto and hum.SeatPart == seat do task.wait(0.5) end
            
            -- Dừng lại và hạ độ cao về 28 khi tắt
            if activeTween then activeTween:Cancel() end
            boat.CFrame = CFrame.new(boat.Position.X, 28, boat.Position.Z)
            task.wait(0.2)
            SetVelocity(boat, false)
            freezeY = nil
        end)
    else
        if activeTween then activeTween:Cancel() end
        pcall(function()
            local b = hum.SeatPart.Parent.PrimaryPart
            b.CFrame = CFrame.new(b.Position.X, 28, b.Position.Z)
            task.wait(0.1)
            SetVelocity(b, false)
        end)
        freezeY = nil
    end
end)
                    if GetFrozenDimension() then _G.Auto = false break end
                    task.wait(0.1)
                end
            end
            
            if _G.Auto then
                freezeY = 175
                boat.CFrame = CFrame.new(boat.Position.X, 175, boat.Position.Z)
                while _G.Auto and math.abs(LP.Character.HumanoidRootPart.Position.Y - 175) > 5 do
                    if GetFrozenDimension() then _G.Auto = false break end
                    task.wait(0.1)
                end
                
                if _G.Auto then
                    activeTween = TS:Create(boat, TweenInfo.new(1e6, Enum.EasingStyle.Linear), {CFrame = boat.CFrame + Vector3.new(0, 0, 1e6)})
                    activeTween:Play()
                    while _G.Auto and activeTween and activeTween.PlaybackState == Enum.PlaybackState.Playing do
                        if GetFrozenDimension() then _G.Auto = false break end
                        task.wait(0.1)
                    end
                end
            end

            if activeTween then activeTween:Cancel() end
            freezeY = nil
            
            if GetFrozenDimension() then
                ToggleFind:SetValue(false)
            end
            
            boat.CFrame = CFrame.new(boat.Position.X, 28, boat.Position.Z)
            task.wait(0.1)
            SetVelocity(boat, false)
        end)
    else
        if activeTween then activeTween:Cancel() end
        freezeY = nil
        pcall(function()
            local b = hum.SeatPart.Parent.PrimaryPart
            b.CFrame = CFrame.new(b.Position.X, 28, b.Position.Z)
            task.wait(0.1)
            SetVelocity(b, false)
        end)
    end
end)
local ToggleStart = Tabs.HuntLeviathan:AddToggle("StartLeviathan", {
    Title = "Start Leviathan",
    Default = false
})

ToggleStart:OnChanged(function(Value)
    _G.FrozenTP = Value
end)

spawn(function()
    while wait(.1) do
        if _G.FrozenTP then
            pcall(function()
                if workspace.Map:FindFirstChild("LeviathanGate") then
                    -- Sử dụng CFrame để dịch chuyển nhân vật tới cổng
                    LP.Character.HumanoidRootPart.CFrame = workspace.Map.LeviathanGate.CFrame
                    -- Gọi lệnh mở cổng từ Server
                    replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLeviathanGate")
                end
            end)
        end
    end
end)
local ToggleAttack = Tabs.HuntLeviathan:AddToggle("AutoAttackLeviathan", {
    Title = "Auto Attack Leviathan",
    Default = false
})

ToggleAttack:OnChanged(function(Value)
    _G.Leviathan1 = Value
end)

spawn(function()
    while task.wait() do
        if _G.Leviathan1 then
            pcall(function()
                if workspace.SeaBeasts:FindFirstChild("Leviathan") then
                    for _, b in pairs(workspace.SeaBeasts:GetChildren()) do
                        if b.Name == "Leviathan" and b:FindFirstChild("HumanoidRootPart") and b:FindFirstChild("Leviathan Segment") and b:FindFirstChild("Health") and b.Health.Value > 0 then
                            repeat
                                task.wait()
                                -- Dịch chuyển nhân vật lên trên Leviathan
                                pcall(function()
                                    LP.Character.HumanoidRootPart.CFrame = CFrame.new(b.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, b.HumanoidRootPart.Position.Z)
                                end)

                                -- Kiểm tra khoảng cách để bắt đầu tung chiêu
                                if LP:DistanceFromCharacter(b.HumanoidRootPart.Position) <= 500 then
                                    -- Thiết lập vị trí mục tiêu cho Skill (MousePos)
                                    _G.MousePos = b:FindFirstChild("Leviathan Segment").Position
                                    
                                    -- Logic dùng Skill (Sử dụng các hàm mẫu thường thấy trong Hub)
                                    if typeof(CheckF) == "function" and CheckF() then
                                        weaponSc("Blox Fruit")
                                        Useskills("Blox Fruit", "Z")
                                        Useskills("Blox Fruit", "X")
                                        Useskills("Blox Fruit", "C")
                                    else
                                        -- Combo tổng hợp
                                        Useskills("Melee", "Z")
                                        Useskills("Melee", "X")
                                        Useskills("Melee", "C")
                                        task.wait(.1)
                                        Useskills("Sword", "Z")
                                        Useskills("Sword", "X")
                                        task.wait(.1)
                                        Useskills("Blox Fruit", "Z")
                                        Useskills("Blox Fruit", "X")
                                        Useskills("Blox Fruit", "C")
                                        task.wait(.1)
                                        Useskills("Gun", "Z")
                                        Useskills("Gun", "X")
                                    end
                                end
                            until not _G.Leviathan1 or not b:FindFirstChild("HumanoidRootPart") or b.Health.Value <= 0 or not b.Parent
                        end
                    end
                end
            end)
        end
    end
end)
-- Khởi tạo dữ liệu lưu trữ cấu hình
_G.SelectedSkills = {
    Melee = {},
    Blox_Fruit = {},
    Sword = {},
    Gun = {}
}
_G.HoldTimes = {
    Melee = {Z = "0", X = "0", C = "0"},
    Blox_Fruit = {Z = "0", X = "0", C = "0", V = "0", F = "0"},
    Sword = {Z = "0", X = "0"},
    Gun = {Z = "0", X = "0"}
}
_G.FastMode = false

-- SECTION: SELECT SKILL
Tabs.Skill:AddSection("Select Skill")

Tabs.Skill:AddDropdown("SelectMelee", {
    Title = "Melee Skills",
    Values = {"Z", "X", "C"},
    Multi = true,
    Default = {},
    Callback = function(Value)
        _G.SelectedSkills.Melee = Value
    end
})

Tabs.Skill:AddDropdown("SelectFruit", {
    Title = "Blox Fruit Skills",
    Values = {"Z", "X", "C", "V", "F"},
    Multi = true,
    Default = {},
    Callback = function(Value)
        _G.SelectedSkills.Blox_Fruit = Value
    end
})

Tabs.Skill:AddDropdown("SelectSword", {
    Title = "Sword Skills",
    Values = {"Z", "X"},
    Multi = true,
    Default = {},
    Callback = function(Value)
        _G.SelectedSkills.Sword = Value
    end
})

Tabs.Skill:AddDropdown("SelectGun", {
    Title = "Gun Skills",
    Values = {"Z", "X"},
    Multi = true,
    Default = {},
    Callback = function(Value)
        _G.SelectedSkills.Gun = Value
    end
})

-- SECTION: HOLD SKILL
Tabs.Skill:AddSection("Hold Skill")

Tabs.Skill:AddToggle("FastMode", {
    Title = "Use Fast Don't Hold",
    Default = false,
    Callback = function(Value)
        _G.FastMode = Value
    end
})

-- Tạo các Input cho từng loại vũ khí (Tôi gộp để scannable hơn)
local function CreateHoldInput(weapon, key)
    Tabs.Skill:AddInput("Hold" .. weapon .. key, {
        Title = weapon .. " Skill " .. key .. " (Seconds)",
        Default = "0",
        Placeholder = "Example: 0.3",
        Callback = function(Value)
            _G.HoldTimes[weapon][key] = Value
        end
    })
end

-- Hiển thị các ô nhập thời gian giữ chiêu
Tabs.Skill:AddParagraph({Title = "--- Melee Hold ---", Content = ""})
for _, k in pairs({"Z", "X", "C"}) do CreateHoldInput("Melee", k) end

Tabs.Skill:AddParagraph({Title = "--- Blox Fruit Hold ---", Content = ""})
for _, k in pairs({"Z", "X", "C", "V", "F"}) do CreateHoldInput("Blox_Fruit", k) end

Tabs.Skill:AddParagraph({Title = "--- Sword Hold ---", Content = ""})
for _, k in pairs({"Z", "X"}) do CreateHoldInput("Sword", k) end

Tabs.Skill:AddParagraph({Title = "--- Gun Hold ---", Content = ""})
for _, k in pairs({"Z", "X"}) do CreateHoldInput("Gun", k) end
-- ==========================================================
-- PHẦN KẾT: LƯU CẤU HÌNH & KÍCH HOẠT SCRIPT
-- ==========================================================

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Cấu hình SaveManager để lưu các thiết lập đã setup
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("BananaCatHub/Leviathan-Premium")

-- Tạo Tab Settings để quản lý file Lưu/Tải
local SettingsTab = Window:AddTab({ Title = "Settings", Icon = "settings" })
InterfaceManager:BuildInterfaceSection(SettingsTab)
SaveManager:BuildConfigSection(SettingsTab)

-- Hàm dùng skill (Helper) để kết nối logic Tab Skill với Auto Attack
local VirtualInputManager = game:GetService("VirtualInputManager")
function Useskills(WeaponType, Key)
    local weaponKey = WeaponType:gsub(" ", "_")
    if _G.SelectedSkills[weaponKey] and _G.SelectedSkills[weaponKey][Key] then
        local holdTime = tonumber(_G.HoldTimes[weaponKey][Key]) or 0
        if _G.FastMode then holdTime = 0 end
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[Key], false, game)
        if holdTime > 0 then task.wait(holdTime) end
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[Key], false, game)
    end
end

-- Các hàm bổ trợ cần thiết để script không bị lỗi khi gọi
function weaponSc(WeaponName)
    pcall(function()
        local tool = LP.Backpack:FindFirstChild(WeaponName) or LP.Character:FindFirstChild(WeaponName)
        if tool then LP.Character.Humanoid:EquipTool(tool) end
    end)
end

function _tp(cf)
    pcall(function() LP.Character.HumanoidRootPart.CFrame = cf end)
end

function CheckF() return false end

-- Tự động tải lại các cài đặt đã lưu từ trước
SaveManager:LoadAutoloadConfig()

-- Mở Tab đầu tiên (Hunt Leviathan) khi bắt đầu chạy
Window:SelectTab(1)

-- Thông báo hoàn tất
Fluent:Notify({
    Title = "Banana Cat Hub - Leviathan [ Premium ]",
    Content = "Done Load Script",
    Duration = 5
})
