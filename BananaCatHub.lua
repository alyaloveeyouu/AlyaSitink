local CoreGui=game:GetService("CoreGui")

if CoreGui:FindFirstChild("AlyaToggleUI") then
CoreGui.AlyaToggleUI:Destroy()
end

local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="AlyaToggleUI"
ScreenGui.ResetOnSpawn=false
ScreenGui.Parent=CoreGui

local Btn=Instance.new("ImageButton")
Btn.Parent=ScreenGui
Btn.Size=UDim2.new(0,60,0,60)
Btn.Position=UDim2.new(0,15,0.02,0)
Btn.BackgroundTransparency=1
Btn.Image="https://www.roblox.com/asset-thumbnail/image?assetId=127470963031421&width=420&height=420&format=png"

local Corner=Instance.new("UICorner")
Corner.CornerRadius=UDim.new(1,0)
Corner.Parent=Btn

local Fluent=loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window=Fluent:CreateWindow({
Title="Alya Hub",
SubTitle="Fluent Base",
TabWidth=160,
Size=UDim2.fromOffset(520,350),
Acrylic=true,
Theme="Dark",
MinimizeKey=Enum.KeyCode.LeftControl
})

Btn.MouseButton1Click:Connect(function()
Window:Minimize()
end)
local plr = game:GetService("Players").LocalPlayer

repeat
    local loading = plr.PlayerGui:FindFirstChild("Main")
    loading = loading and loading:FindFirstChild("Loading")
    task.wait()
until game:IsLoaded() and not (loading and loading.Visible)

World1 = false
World2 = false
World3 = false

local placeId = game.PlaceId

if placeId == 2753915549 or placeId == 85211729168715 then
    World1 = true
elseif placeId == 4442272183 or placeId == 79091703265657 then
    World2 = true
elseif placeId == 7449423635 or placeId == 100117331123089 then
    World3 = true
else
    plr:Kick("❌ Error Blox Fruits - World not recognized")
end

Sea = World1 or World2 or World3
local Services=setmetatable({},{__index=function(self,name)local s=game:GetService(name) rawset(self,name,s) return s end})

local Players=Services.Players
local ReplicatedStorage=Services.ReplicatedStorage
local TweenService=Services.TweenService
local RunService=Services.RunService

local player=Players.LocalPlayer

local function Character()
return player.Character or player.CharacterAdded:Wait()
end

local function Humanoid()
return Character():WaitForChild("Humanoid")
end

local function Root()
return Character():WaitForChild("HumanoidRootPart")
end

local function SetCFrame(cf)
Root().CFrame=cf
end

local function CommF(...)
return ReplicatedStorage.Remotes.CommF_:InvokeServer(...)
end

local function CommE(...)
return ReplicatedStorage.Remotes.CommE:FireServer(...)
end

local function TweenPlayer(cf,speed)
local dist=(Root().Position-cf.Position).Magnitude
local time=dist/(speed or 350)
local tween=TweenService:Create(Root(),TweenInfo.new(time,Enum.EasingStyle.Linear),{CFrame=cf})
tween:Play()
return tween
end

local function GetBoat()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("VehicleSeat") then
return v
end
end
end

local function TweenBoat(cf,speed)
local boat=GetBoat()
if boat and boat.PrimaryPart then
local dist=(boat.PrimaryPart.Position-cf.Position).Magnitude
local time=dist/(speed or 300)
local tween=TweenService:Create(boat.PrimaryPart,TweenInfo.new(time,Enum.EasingStyle.Linear),{CFrame=cf})
tween:Play()
return tween
end
end

local FastAttackEnabled=false

local Net=ReplicatedStorage.Modules.Net
local RegisterAttack=Net:WaitForChild("RE/RegisterAttack")
local RegisterHit=Net:WaitForChild("RE/RegisterHit")

local COMBAT_CONFIG={
attacksPerTarget=3,
maxTargets=5,
baseRange=100,
minDelay=0.05,
maxDelay=0.1,
hitDelay=0.02,
randomization={range={min=-2,max=2},timing={min=-0.05,max=0.05}}
}

local function GetPrimaryPart(model)
return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("PrimaryPart")
end

local function IsValidTarget(target)
local humanoid=target:FindFirstChildOfClass("Humanoid")
if not humanoid or humanoid.Health<=0 then return false end
local targetPlayer=Players:GetPlayerFromCharacter(target)
if targetPlayer and targetPlayer.Team==player.Team then return false end
return true
end

local function GetNearbyTargets()
local character=player.Character
if not character or not character.PrimaryPart then return {} end
local charPos=character.PrimaryPart.Position
local targets={}
for _,folder in ipairs({workspace.Characters,workspace.Enemies}) do
if folder then
for _,entity in ipairs(folder:GetChildren()) do
if entity~=character and IsValidTarget(entity) then
local primaryPart=GetPrimaryPart(entity)
if primaryPart then
local distance=(primaryPart.Position-charPos).Magnitude
local range=COMBAT_CONFIG.baseRange+math.random(COMBAT_CONFIG.randomization.range.min,COMBAT_CONFIG.randomization.range.max)
if distance<=range then
table.insert
local Tabs={
Shop=Window:AddTab({Title="Tab Shop"}),
StatusServer=Window:AddTab({Title="Tab Status And Server"}),
LocalPlayer=Window:AddTab({Title="Tab LocalPlayer"}),
HoldSkill=Window:AddTab({Title="Tab Hold And Select Skill"}),
SettingFarm=Window:AddTab({Title="Tab Setting Farm"}),
MainFarm=Window:AddTab({Title="Tab Main Farm"}),
StackFarm=Window:AddTab({Title="Tab Stack Farm"}),
FarmOther=Window:AddTab({Title="Tab Farm Other"}),
FruitsRaid=Window:AddTab({Title="Tab Fruits And Raid"}),
Upgrade=Window:AddTab({Title="Tab Upgrade"}),
SeaEvent=Window:AddTab({Title="Tab SeaEvent"}),
Volcano=Window:AddTab({Title="Tab Volcano"}),
GetItem=Window:AddTab({Title="Tab Get Item"}),
Esp=Window:AddTab({Title="Tab Esp"})
}
Tabs.Shop:AddParagraph({
    Title = "Fighting Shop\n^^^^^^^^^^^^^"
})
local Shop = Tabs.Shop

Shop:AddToggle({
    Title = "Black Leg",
    Default = false,
    Callback = function(v)
        _G.BlackLeg = v
        task.spawn(function()
            while _G.BlackLeg do
                if World3 then
                    TweenTo(CFrame.new(-5045,372,-3182))
                elseif World2 then
                    TweenTo(CFrame.new(-4753,37,-4845))
                elseif World1 then
                    TweenTo(CFrame.new(-981,16,3993))
                end
                CommF("BuyBlackLeg")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "Fishman Karate",
    Callback = function(v)
        _G.Fishman = v
        task.spawn(function()
            while _G.Fishman do
                if World3 then
                    TweenTo(CFrame.new(-5026,375,-3196))
                elseif World2 then
                    TweenTo(CFrame.new(-4960,39,-4663))
                elseif World1 then
                    TweenTo(CFrame.new(61590,23,988))
                end
                CommF("BuyFishmanKarate")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "Electro",
    Callback = function(v)
        _G.Electro = v
        task.spawn(function()
            while _G.Electro do
                if World3 then
                    TweenTo(CFrame.new(-5000,375,-3196))
                elseif World2 then
                    TweenTo(CFrame.new(-4871,37,-4769))
                elseif World1 then
                    TweenTo(CFrame.new(-5383,16,-2153))
                end
                CommF("BuyElectro")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "Dragon Breath",
    Callback = function(v)
        _G.DragonBreath = v
        task.spawn(function()
            while _G.DragonBreath do
                if World3 then
                    TweenTo(CFrame.new(-4985,374,-3207))
                elseif World2 then
                    TweenTo(CFrame.new(701,189,651))
                end
                CommF("BlackbeardReward","DragonClaw","1")
                CommF("BlackbeardReward","DragonClaw","2")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "SuperHuman",
    Callback = function(v)
        _G.SuperHuman = v
        task.spawn(function()
            while _G.SuperHuman do
                if World3 then
                    TweenTo(CFrame.new(-5002,374,-3202))
                elseif World2 then
                    TweenTo(CFrame.new(1373,250,-5191))
                end
                CommF("BuySuperhuman")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "Death Step",
    Callback = function(v)
        _G.DeathStep = v
        task.spawn(function()
            while _G.DeathStep do
                if World3 then
                    TweenTo(CFrame.new(-5000,318,-3218))
                elseif World2 then
                    TweenTo(CFrame.new(6354,330,-6766))
                end
                CommF("BuyDeathStep")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "Sharkman Karate",
    Callback = function(v)
        _G.Sharkman = v
        task.spawn(function()
            while _G.Sharkman do
                if World3 then
                    TweenTo(CFrame.new(-5002,374,-3201))
                elseif World2 then
                    TweenTo(CFrame.new(-2603,242,-10313))
                end
                CommF("BuySharkmanKarate",true)
                CommF("BuySharkmanKarate")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "Electric Claw",
    Callback = function(v)
        _G.ElectricClaw = v
        task.spawn(function()
            while _G.ElectricClaw do
                if World3 then
                    TweenTo(CFrame.new(-10368,334,-10134))
                end
                CommF("BuyElectricClaw")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "Dragon Talon",
    Callback = function(v)
        _G.DragonTalon = v
        task.spawn(function()
            while _G.DragonTalon do
                if World3 then
                    TweenTo(CFrame.new(5665,1214,862))
                end
                CommF("BuyDragonTalon")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "God Human",
    Callback = function(v)
        _G.GodHuman = v
        task.spawn(function()
            while _G.GodHuman do
                if World3 then
                    TweenTo(CFrame.new(-13773,337,-9877))
                end
                CommF("BuyGodhuman")
                task.wait(1)
            end
        end)
    end
})

Shop:AddToggle({
    Title = "Sanguine Art",
    Callback = function(v)
        _G.Sanguine = v
        task.spawn(function()
            while _G.Sanguine do
                if World3 then
                    TweenTo(CFrame.new(-16512,26,-191))
                end
                CommF("BuySanguineArt",true)
                CommF("BuySanguineArt")
                task.wait(1)
            end
        end)
    end
})
Tabs.Shop:AddParagraph({
    Title = "Other Shop\n^^^^^^^^^^"
})
local SelectedSword = nil

Tabs.Shop:AddDropdown("SwordDropdown",{
    Title = "Select Sword",
    Values = {
        "Cutlass",
        "Katana",
        "Iron Mace",
        "Dual Katana",
        "Triple Katana",
        "Pipe",
        "Dual-Headed Blade",
        "Bisento",
        "Soul Cane"
    },
    Multi = false,
    Callback = function(Value)
        SelectedSword = Value
    end
})

Tabs.Shop:AddButton({
    Title = "Buy Sword Selected",
    Callback = function()

        if SelectedSword then
            CommF("BuyItem", SelectedSword)
        end

    end
})
local SelectedGun = nil

Tabs.Shop:AddDropdown("GunDropdown",{
    Title = "Select Gun",
    Values = {
        "Slingshot",
        "Musket",
        "Flintlock",
        "Refined Slingshot",
        "Refined Flintlock",
        "Cannon",
        "Kabucha",
        "Bizarre Rifle"
    },
    Multi = false,
    Callback = function(Value)
        SelectedGun = Value
    end
})

Tabs.Shop:AddButton({
    Title = "Buy Gun Selected",
    Callback = function()

        if SelectedGun then

            if SelectedGun == "Kabucha" then
                CommF("BlackbeardReward","Slingshot","2")

            elseif SelectedGun == "Bizarre Rifle" then
                CommF("Ectoplasm","BuyGun")

            else
                CommF("BuyItem", SelectedGun)
            end

        end

    end
})
local SelectedAbility = nil

Tabs.Shop:AddDropdown("AbilityDropdown",{
    Title = "Select Ability",
    Values = {
        "Sky Jump",
        "Flash Step",
        "Buso Haki",
        "Observation Haki"
    },
    Multi = false,
    Callback = function(Value)
        SelectedAbility = Value
    end
})

Tabs.Shop:AddButton({
    Title = "Buy Ability Selected",
    Callback = function()

        if SelectedAbility == "Sky Jump" then
            CommF("BuyHaki","Geppo")

        elseif SelectedAbility == "Flash Step" then
            CommF("BuyHaki","Soru")

        elseif SelectedAbility == "Buso Haki" then
            CommF("BuyHaki","Buso")

        elseif SelectedAbility == "Observation Haki" then
            CommF("KenTalk","Buy")

        end

    end
})
Shop:AddButton({
    Title = "Reset Stats",
    Callback = function()
        local Remote = game:GetService("ReplicatedStorage").Remotes.CommF_
        Remote:InvokeServer("BlackbeardReward","Refund","1")
        Remote:InvokeServer("BlackbeardReward","Refund","2")
    end
})

Shop:AddButton({
    Title = "Reroll Race",
    Callback = function()
        local Remote = game:GetService("ReplicatedStorage").Remotes.CommF_
        Remote:InvokeServer("BlackbeardReward","Reroll","1")
        Remote:InvokeServer("BlackbeardReward","Reroll","2")
    end
})

Shop:AddButton({
    Title = "Buy Draco",
    Callback = function()

        local targetCF = CFrame.new(5814.4272,1208.3267,884.5785)

        TweenTo(targetCF)

        local args = {
            [1] = {
                ["NPC"] = "Dragon Wizard",
                ["Command"] = "DragonRace"
            }
        }

        game:GetService("ReplicatedStorage")
        .Modules.Net
        :FindFirstChild("RF/InteractDragonQuest")
        :InvokeServer(unpack(args))
    end
})

Shop:AddButton({
    Title = "Buy Ghoul Race",
    Callback = function()
        local args = {
            [1] = "Ectoplasm",
            [2] = "Change",
            [3] = 4
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Shop:AddButton({
    Title = "Buy Cyborg Race (2500F)",
    Callback = function()
        local args = {
            [1] = "CyborgTrainer",
            [2] = "Buy"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})