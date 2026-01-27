local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

local PlaceId = game.PlaceId
local UniverseID = game.GameId

local Window = Fluent:CreateWindow({
    Title = "Banana Cat Hub - Blox Fruit [ Free ]",
    SubTitle = "by tài",
    TabWidth = 170,
    Size = UDim2.fromOffset(520, 380),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Name = "BananaCatToggle"
Btn.Size = UDim2.new(0, 60, 0, 60)
Btn.Position = UDim2.new(0, 15, 0.02, 0)
Btn.BackgroundTransparency = 1
Btn.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=127470963031421&width=420&height=420&format=png"
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)
Btn.MouseButton1Click:Connect(function() Window:Minimize() end)

local Tabs = {
    Shop = Window:AddTab({ Title = "Shop" }),
    Status = Window:AddTab({ Title = "Status And Server" }),
    LocalPlayer = Window:AddTab({ Title = "LocalPlayer" }),
    SettingFarm = Window:AddTab({ Title = "Setting Farm" }),
    Skills = Window:AddTab({ Title = "Hold and Select Skill" }),
    Farming = Window:AddTab({ Title = "Farming" }),
    StackFarming = Window:AddTab({ Title = "Stack Farming" }),
    FarmingOther = Window:AddTab({ Title = "Farming Other" }),
    FruitRaid = Window:AddTab({ Title = "Fruit and Raid, Dungeon" }),
    SeaEvent = Window:AddTab({ Title = "Sea Event" }),
    UpgradeRace = Window:AddTab({ Title = "Upgrade Race" }),
    Items = Window:AddTab({ Title = "Get and Upgrade Items" }),
    Volcano = Window:AddTab({ Title = "Volcano Event" }),
    ESP = Window:AddTab({ Title = "ESP" }),
    PVP = Window:AddTab({ Title = "PVP" }),
    Webhook = Window:AddTab({ Title = "Tab Webhook" }),
    Setting = Window:AddTab({ Title = "Setting" })
}

do
    Tabs.Shop:AddSection("Misc Shop")

    Tabs.Shop:AddButton({
        Title = "Redeem Code",
        Callback = function()
            local Codes = {
                "REWARDFUN","NEWTROLL","KITT_RESET","Sub2CaptainMaui","DEVSCOOKING",
                "Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK","Starcodeheo",
                "Bluxxy","fudd10_v2","FUDD10","CHANDLER","BIGNEWS",
                "BELUGASUB","Sub2OfficialNoobie","StrawHatMaine","SUB2NOOBMASTER123","Sub2UncleKizaru",
                "Sub2Daigrock","Axiore","TantaiGaming","STRAWHATMAINE"
            }
            for i, v in pairs(Codes) do
                game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v)
            end
            Fluent:Notify({Title = "Banana Cat", Content = "Redeemed all available codes!", Duration = 5})
        end
    })

    Tabs.Shop:AddButton({
        Title = "Teleport Old World",
        Callback = function()
            if PlaceId ~= 2753915549 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
            else
                Fluent:Notify({Title = "Banana Cat", Content = "Already in Sea 1", Duration = 3})
            end
        end
    })

    Tabs.Shop:AddButton({
        Title = "Teleport New World",
        Callback = function()
            if PlaceId ~= 4442272183 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
            else
                Fluent:Notify({Title = "Banana Cat", Content = "Already in Sea 2", Duration = 3})
            end
        end
    })

    Tabs.Shop:AddButton({
        Title = "Teleport Third Sea",
        Callback = function()
            if PlaceId ~= 7449423635 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
            else
                Fluent:Notify({Title = "Banana Cat", Content = "Already in Sea 3", Duration = 3})
            end
        end
    })

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

    Tabs.SettingFarm:AddSection("Farm Settings")

    Tabs.SettingFarm:AddDropdown("WeaponDropdown", {
    Title = "Select Weapon",
    Values = {"Melee", "Sword", "Gun"},
    Multi = false,
    Default = "Melee",
    Callback = function(Value)
        _G.SelectWeapon = Value
    end
})

SaveManager:SetLibrary(Fluent)
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("BananaCatHub_Free")
SaveManager:LoadAutoloadConfig()

Window:SelectTab(1)
