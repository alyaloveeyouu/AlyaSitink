if not game:IsLoaded() then game.Loaded:Wait() end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local lp = game.Players.LocalPlayer

local MySea = 1
if game.PlaceId == 2753915549 then
    MySea = 1
elseif game.PlaceId == 4442272183 then
    MySea = 2
elseif game.PlaceId == 7449423635 then
    MySea = 3
end

local function TweenTP(targetCFrame)
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local distance = (targetCFrame.p - lp.Character.HumanoidRootPart.Position).Magnitude
    local speed = 350 
    local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    return tween
end

local Window = Fluent:CreateWindow({
    Title = "Alya Hub",
    SubTitle = "by Alya",
    TabWidth = 140,
    Size = UDim2.fromOffset(500, 320), 
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
    ["Tab Shop"] = Window:AddTab({ Title = "Tab Shop" }),
    ["Status And Server"] = Window:AddTab({ Title = "Status And Server" }),
    ["Tab Local Player"] = Window:AddTab({ Title = "Tab Local Player" }),
    ["Tab Setting Farm"] = Window:AddTab({ Title = "Tab Setting Farm" }),
    ["Tab Hold And Select Skill"] = Window:AddTab({ Title = "Tab Hold And Select Skill" }),
    ["Tab Farming"] = Window:AddTab({ Title = "Tab Farming" }),
    ["Tab Stack Farming"] = Window:AddTab({ Title = "Tab Stack Farming" }),
    ["Tab Farming Other"] = Window:AddTab({ Title = "Tab Farming Other" }),
    ["Tab Fruit And Raid"] = Window:AddTab({ Title = "Tab Fruit And Raid" }),
    ["Tab Sea Event"] = Window:AddTab({ Title = "Tab Sea Event" }),
    ["Tab Upgrade"] = Window:AddTab({ Title = "Tab Upgrade" }),
    ["Tab Volcano"] = Window:AddTab({ Title = "Tab Volcano" }),
    ["Tab Esp"] = Window:AddTab({ Title = "Tab Esp" }),
    ["Tab Webhook"] = Window:AddTab({ Title = "Tab Webhook" })
}
local MeleeData = {
    ["Godhuman"] = {[3] = {Pos = CFrame.new(-2863, 274, -4403), Remote = "BuyGodhuman"}},
    ["Sanguine Art"] = {[3] = {Pos = CFrame.new(-2519, 285, 2856), Remote = "BuySanguineArt", Double = true}},
    ["Dragon Talon"] = {[3] = {Pos = CFrame.new(-5450, 312, -315), Remote = "BuyDragonTalon"}}, 
    ["Electric Claw"] = {[3] = {Pos = CFrame.new(-1344, 332, -3306), Remote = "BuyElectricClaw"}},
    ["Sharkman Karate"] = {
        [2] = {Pos = CFrame.new(-2601, 239, -10312), Remote = "BuySharkmanKarate", Double = true},
        [3] = {Pos = CFrame.new(-9515, 164, 5786), Remote = "BuySharkmanKarate", Double = true} 
    },
    ["Death Step"] = {
        [2] = {Pos = CFrame.new(6356, 296, -6761), Remote = "BuyDeathStep"},
        [3] = {Pos = CFrame.new(-9515, 164, 5786), Remote = "BuyDeathStep"}
    },
    ["Superhuman"] = {
        [2] = {Pos = CFrame.new(1375, 247, -5189), Remote = "BuySuperhuman"},
        [3] = {Pos = CFrame.new(-9515, 164, 5786), Remote = "BuySuperhuman"}
    },
    ["Dragon Claw"] = {
        [2] = {Pos = CFrame.new(701, 187, 655), Remote = "BlackbeardReward", Args = {"DragonClaw", "1"}},
        [3] = {Pos = CFrame.new(-9515, 164, 5786), Remote = "BlackbeardReward", Args = {"DragonClaw", "1"}}
    },
    ["Black Leg"] = {
        [1] = {Pos = CFrame.new(-984, 14, 3987), Remote = "BuyBlackLeg"},
        [2] = {Pos = CFrame.new(-4996, 42, -4500), Remote = "BuyBlackLeg"},
        [3] = {Pos = CFrame.new(-9515, 164, 5786), Remote = "BuyBlackLeg"}
    },
    ["Electro"] = {
        [1] = {Pos = CFrame.new(-5382, 14, -2150), Remote = "BuyElectro"},
        [2] = {Pos = CFrame.new(-4947, 42, -4439), Remote = "BuyElectro"},
        [3] = {Pos = CFrame.new(-9515, 164, 5786), Remote = "BuyElectro"}
    },
    ["Fishman Karate"] = {
        [1] = {Pos = CFrame.new(61581, 18, 987), Remote = "BuyFishmanKarate"},
        [2] = {Pos = CFrame.new(-4992, 43, -4460), Remote = "BuyFishmanKarate"},
        [3] = {Pos = CFrame.new(-9515, 164, 5786), Remote = "BuyFishmanKarate"}
    }
}

Tabs["Tab Shop"]:AddSection("Melee")
local MeleeNames = {"Godhuman", "Sanguine Art", "Dragon Talon", "Electric Claw", "Sharkman Karate", "Death Step", "Superhuman", "Dragon Claw", "Black Leg", "Electro", "Fishman Karate"}

for _, name in ipairs(MeleeNames) do
    local toggleName = "AutoBuy" .. name:gsub(" ", "")
    Tabs["Tab Shop"]:AddToggle(toggleName, {
        Title = "Auto Buy " .. name,
        Default = false,
        Callback = function(Value)
            _G[toggleName] = Value
            task.spawn(function()
                while _G[toggleName] do
                    local data = MeleeData[name] and MeleeData[name][MySea]
                    if data then
                        local tw = TweenTP(data.Pos)
                        if tw then tw.Completed:Wait() end
                        task.wait(0.3)
                        if data.Double then
                            CommF:InvokeServer(data.Remote, true)
                            CommF:InvokeServer(data.Remote)
                        elseif data.Args then
                            CommF:InvokeServer(data.Remote, unpack(data.Args))
                        else
                            CommF:InvokeServer(data.Remote)
                        end
                    else
                        Fluent:Notify({Title = "Alya Hub", Content = "This Melee is not available in this Sea!", Duration = 5})
                        _G[toggleName] = false
                        break
                    end
                    task.wait(1)
                end
            end)
        end
    })
end
Tabs["Tab Shop"]:AddSection("Swords")
local Swords = {"Katana", "Cutlass", "Dual Katana", "Iron Mace", "Pipe", "Soul Cane", "Bisento", "Kabucha"}

for _, s in ipairs(Swords) do 
    Tabs["Tab Shop"]:AddButton({
        Title = "Buy " .. s, 
        Callback = function() 
            CommF:InvokeServer("BuyItem", s) 
        end
    }) 
end
Tabs["Tab Shop"]:AddSection("Guns")
local Guns = {"Musket", "Slingshot", "Flintlock", "Refined Flintlock", "Refined Musket", "Cannon"}

for _, g in ipairs(Guns) do 
    Tabs["Tab Shop"]:AddButton({
        Title = "Buy " .. g, 
        Callback = function() 
            CommF:InvokeServer("BuyItem", g) 
        end
    }) 
end
Tabs["Tab Shop"]:AddSection("Fragment Shop")

Tabs["Tab Shop"]:AddButton({
    Title = "Reroll Race", 
    Callback = function() 
        CommF:InvokeServer("BlackbeardReward", "Reroll", "1") 
        task.wait(0.1) 
        CommF:InvokeServer("BlackbeardReward", "Reroll", "2") 
    end
})

Tabs["Tab Shop"]:AddButton({
    Title = "Reset Stats", 
    Callback = function() 
        CommF:InvokeServer("BlackbeardReward", "Refund", "1") 
        task.wait(0.1) 
        CommF:InvokeServer("BlackbeardReward", "Refund", "2") 
    end
})

-- ==========================================
-- TAB: STATUS AND SERVER (CHỈ TIMER & ELITE)
-- ==========================================
Tabs["Status And Server"]:AddSection("Status")

local RuntimeLabel = Tabs["Status And Server"]:AddParagraph({Title = "Script Runtime", Content = "00:00:00"})
local EliteLabel = Tabs["Status And Server"]:AddParagraph({Title = "Elite Hunter", Content = "Checking..."})

local StartTime = tick()

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            -- Cập nhật Runtime (HH:MM:SS)
            local elapsed = math.floor(tick() - StartTime)
            local h = math.floor(elapsed / 3600)
            local m = math.floor((elapsed % 3600) / 60)
            local s = elapsed % 60
            RuntimeLabel:SetDesc("Time Elapsed: " .. string.format("%02d:%02d:%02d", h, m, s))

            -- Cập nhật Elite Hunter (Check ✅/❌)
            local TargetElite = nil
            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v.Name == "Deandre" or v.Name == "Diablo" or v.Name == "Urban" then
                    TargetElite = v.Name
                    break
                end
            end
            
            if TargetElite then
                EliteLabel:SetDesc(TargetElite .. " ✅")
            else
                EliteLabel:SetDesc("Not Spawned ❌")
            end
        end)
    end
end)
-- ==========================================
-- CHỈ LOGIC CAKE PRINCE (NỐI TIẾP)
-- ==========================================

            -- Logic Check Cake Prince (Nối ngay sau phần Elite của bạn)
            if MySea == 3 then
                local CakePrince = game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King")
                if CakePrince then
                    -- Nếu đang có Boss trong Server
                    CakePrinceLabel:SetDesc("Spawned ✅")
                else
                    -- Nếu chưa có, lấy số lượng mob từ Server
                    local Msg = CommF:InvokeServer("CakePrinceProgress")
                    local count = tostring(Msg):match("%d+")
                    if count then
                        CakePrinceLabel:SetDesc("(" .. count .. ") mobs")
                    else
                        -- Đã đủ 500 mob nhưng chưa ai nhấn triệu hồi
                        CakePrinceLabel:SetDesc("Ready! ✅")
                    end
                end
            else
                CakePrinceLabel:SetDesc("Sea 3 Only ❌")
            end
        end)
    end
end)

