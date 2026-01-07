--=====================================================
-- AlyaHub-Leviathan.lua
-- SAFE LOAD GAME
--=====================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")

repeat task.wait() until Players.LocalPlayer
repeat task.wait() until Players.LocalPlayer.Character
repeat task.wait() until Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

task.wait(1)
--=====================================================
-- SERVICES & PLAYER
--=====================================================

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end)
--=====================================================
-- UTILS
--=====================================================

local Utils = {}

function Utils.SafeCall(func)
    local ok, err = pcall(func)
    if not ok then warn("[AlyaHub]", err) end
end

function Utils.IsOnBoat()
    return Humanoid.SeatPart and Humanoid.SeatPart:IsA("VehicleSeat")
end

function Utils.DoubleJump()
    for i = 1, 2 do
        VirtualInputManager:SendKeyEvent(true, "Space", false, game)
        task.wait(0.15)
        VirtualInputManager:SendKeyEvent(false, "Space", false, game)
        task.wait(0.15)
    end
end

function Utils.FindModel(keyword)
    keyword = keyword:lower()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find(keyword) then
            return v
        end
    end
end
--=====================================================
-- AUTO BUSO HAKI + SAFE HP TELEPORT
--=====================================================

local AUTO_BUSO = true

local SAFE_HP_LOW = 4000
local SAFE_HP_HIGH = 8000
local SAFE_Y_OFFSET = 1000

local IsSafe = false
local ReturnCFrame = nil

--======================
-- AUTO BUSO HAKI
--======================

task.spawn(function()
    while task.wait(1) do
        if AUTO_BUSO and Character and Humanoid and Humanoid.Health > 0 then
            pcall(function()
                if not Character:FindFirstChild("HasBuso") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end
    end
end)

--======================
-- SAFE HP TELEPORT
--======================

task.spawn(function()
    while task.wait() do
        if not Character or not Humanoid or Humanoid.Health <= 0 then
            IsSafe = false
            continue
        end

        -- teleport lên cao khi yếu
        if Humanoid.Health < SAFE_HP_LOW and not IsSafe then
            IsSafe = true
            ReturnCFrame = HRP.CFrame
            HRP.CFrame = HRP.CFrame + Vector3.new(0, SAFE_Y_OFFSET, 0)
        end

        -- quay lại khi đủ máu
        if IsSafe and Humanoid.Health >= SAFE_HP_HIGH then
            IsSafe = false
            if ReturnCFrame then
                HRP.CFrame = ReturnCFrame
            end
        end
    end
end)
--=====================================================
-- TWEEN CONTROLLER
--=====================================================

local TweenCtrl = {}
TweenCtrl.Current = nil

function TweenCtrl:Stop()
    if self.Current then
        self.Current:Cancel()
        self.Current = nil
    end
end

function TweenCtrl:Move(part, cf, speed)
    self:Stop()
    local dist = (part.Position - cf.Position).Magnitude
    local time = dist / speed

    self.Current = TweenService:Create(
        part,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {CFrame = cf}
    )
    self.Current:Play()
end
--=====================================================
-- UI FLUENT
--=====================================================

local Fluent = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"
))()

local Window = Fluent:CreateWindow({
    Title = "AlyaHub - Leviathan",
    SubTitle = "by Alya",
    TabWidth = 160,
    Size = UDim2.fromOffset(530, 400),
    Acrylic = true,
    Theme = "Dark"
})

local Tabs = {
    Hunt = Window:AddTab({Title = "Hunt Leviathan"}),
    Skill = Window:AddTab({Title = "Hold And Select Skill"}),
    Fruit = Window:AddTab({Title = "Fruit"}),
    Webhook = Window:AddTab({Title = "Webhook"})
}
--=====================================================
-- CONFIG SAVE / LOAD
--=====================================================

local ConfigFolder = "AlyaHub"
local ConfigFile = ConfigFolder .. "/Leviathan.json"
local Config = {}

if makefolder and not isfolder(ConfigFolder) then
    makefolder(ConfigFolder)
end

local function SaveConfig()
    if not writefile then return end
    writefile(ConfigFile, HttpService:JSONEncode(Config))
end

local function LoadConfig()
    if not isfile or not isfile(ConfigFile) then return end
    local data = readfile(ConfigFile)
    local decoded = HttpService:JSONDecode(data)
    for k, v in pairs(decoded) do
        Config[k] = v
    end
end

LoadConfig()

function SetConfig(key, value)
    Config[key] = value
    SaveConfig()
end

function GetConfig(key, default)
    if Config[key] == nil then
        Config[key] = default
        SaveConfig()
    end
    return Config[key]
end
--=====================================================
-- TAB HUNT LEVIATHAN
--=====================================================

local StatusSpyText = "Waiting..."
local FindingLeviathan = false

--======================
-- STATUS SPY UI
--======================

local StatusParagraph = Tabs.Hunt:AddParagraph({
    Title = "Status Spy",
    Content = StatusSpyText
})

--======================
-- STATUS SPY LOGIC
--======================

local function UpdateStatusSpy()
    task.spawn(function()
        while true do
            local spy = Utils.FindModel("spy")
            if spy then
                -- không mở mailbox, chỉ đọc kết quả
                -- giả lập logic trả lời (do server xử lý)
                -- ta dựa theo object tồn tại

                if Workspace:FindFirstChild("FrozenDimension") then
                    StatusSpyText = "You can find leviathan now"
                else
                    -- không biết chính xác fragment state
                    -- nên chia theo tình huống phổ biến
                    StatusSpyText = "Buy Find Leviathan"
                end
            else
                StatusSpyText = "I don't know"
            end

            StatusParagraph:Set({
                Title = "Status Spy",
                Content = StatusSpyText
            })

            task.wait(3)
        end
    end)
end

UpdateStatusSpy()

--======================
-- FIND LEVIATHAN
--======================

Tabs.Hunt:AddToggle("FindLeviathan", {
    Title = "Find Leviathan",
    Default = GetConfig("FindLeviathan", false),
    Callback = function(state)
        SetConfig("FindLeviathan", state)
        FindingLeviathan = state

        if not state then
            TweenCtrl:Stop()
            return
        end

        -- bắt buộc phải ngồi ghế lái
        if not Utils.IsOnBoat() then
            FindingLeviathan = false
            SetConfig("FindLeviathan", false)
            return
        end

        -- giật lên trời 200m
        HRP.CFrame = HRP.CFrame + Vector3.new(0, 200, 0)

        task.wait(1)

        -- tween ra sea 6 (tọa độ giả định, chỉ dùng hướng)
        local targetCF = CFrame.new(
            HRP.Position.X,
            HRP.Position.Y,
            HRP.Position.Z - 200000
        )

        TweenCtrl:Move(HRP, targetCF, 275)

        -- detect frozen dimension
        task.spawn(function()
            while FindingLeviathan do
                local frozen = Utils.FindModel("frozen")
                if frozen then
                    TweenCtrl:Stop()
                    FindingLeviathan = false
                    SetConfig("FindLeviathan", false)

                    -- notify DUY NHẤT
                    Fluent:Notify({
                        Title = "Leviathan",
                        Content = "Frozen Dimension Spawned",
                        Duration = 5
                    })

                    -- webhook
                    if LogFrozen then
                        SendWebhook("❄️ Frozen Dimension Spawned")
                    end
                    break
                end
                task.wait()
            end
        end)
    end
})
--=====================================================
-- START LEVIATHAN
--=====================================================

local StartingLeviathan = false
local AttackingLeviathan = false

--======================
-- FIND FROZEN DIMENSION
--======================

local function GetFrozenDimension()
    return Utils.FindModel("frozen")
end

--======================
-- FIND NEAREST NPC
--======================

local function GetNearestNPC()
    local nearest, dist = nil, math.huge
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if v ~= Character then
                local d = (HRP.Position - v.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = v
                end
            end
        end
    end
    return nearest
end

--======================
-- START LEVIATHAN TOGGLE
--======================

Tabs.Hunt:AddToggle("StartLeviathan", {
    Title = "Start Leviathan",
    Default = GetConfig("StartLeviathan", false),
    Callback = function(state)
        SetConfig("StartLeviathan", state)
        StartingLeviathan = state

        if not state then
            TweenCtrl:Stop()
            return
        end

        -- chỉ chạy khi có Frozen Dimension
        if not GetFrozenDimension() then
            StartingLeviathan = false
            SetConfig("StartLeviathan", false)
            return
        end

        task.spawn(function()
            -- thoát thuyền
            Utils.DoubleJump()
            task.wait(0.3)

            local npc = GetNearestNPC()
            if npc and npc:FindFirstChild("HumanoidRootPart") then
                TweenCtrl:Move(
                    HRP,
                    npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4),
                    350
                )

                task.wait(1)

                -- tự nói chuyện (generic)
                Utils.SafeCall(function()
                    fireproximityprompt(
                        npc.HumanoidRootPart:FindFirstChildOfClass("ProximityPrompt")
                    )
                end)
            end

            StartingLeviathan = false
            SetConfig("StartLeviathan", false)
        end)
    end
})

--=====================================================
-- ATTACK LEVIATHAN
--=====================================================

--======================
-- FIND LEVIATHAN
--======================

local function GetLeviathan()
    return Utils.FindModel("leviathan")
end

local function GetLeviathanParts(levi)
    local bodies = {}
    local head = nil

    for _, v in ipairs(levi:GetDescendants()) do
        if v:IsA("BasePart") then
            if v.Name:lower():find("body") or v.Name:lower():find("segment") then
                table.insert(bodies, v)
            elseif v.Name:lower():find("head") then
                head = v
            end
        end
    end

    return bodies, head
end

--======================
-- MOVE & ATTACK
--======================

local function MoveToPart(part)
    TweenCtrl:Move(
        HRP,
        CFrame.new(part.Position + Vector3.new(0, 5, 0)),
        350
    )
end

local function UseSelectedSkill()
    -- placeholder: sẽ gắn logic skill ở KHỐI SKILL
    VirtualInputManager:SendKeyEvent(true, "Z", false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, "Z", false, game)
end

--======================
-- ATTACK TOGGLE
--======================

Tabs.Hunt:AddToggle("AttackLeviathan", {
    Title = "Attack Leviathan",
    Default = GetConfig("AttackLeviathan", false),
    Callback = function(state)
        SetConfig("AttackLeviathan", state)
        AttackingLeviathan = state

        if not state then
            TweenCtrl:Stop()
            return
        end

        task.spawn(function()
            while AttackingLeviathan do
                local levi = GetLeviathan()
                if not levi then
                    task.wait(1)
                    continue
                end

                -- nếu đang ngồi thuyền → nhảy
                if Utils.IsOnBoat() then
                    Utils.DoubleJump()
                    task.wait(0.2)
                end

                local bodies, head = GetLeviathanParts(levi)

                -- đánh thân trước
                for _, part in ipairs(bodies) do
                    if not AttackingLeviathan then break end
                    if part and part.Parent then
                        MoveToPart(part)
                        task.wait(0.3)
                        UseSelectedSkill()
                        task.wait(0.2)
                    end
                end

                -- sau khi hết thân → đánh đầu
                if head and AttackingLeviathan then
                    MoveToPart(head)
                    task.wait(0.3)
                    UseSelectedSkill()
                end

                task.wait()
            end
        end)
    end
})
--=====================================================
-- TAB HOLD AND SELECT SKILL
--=====================================================

--======================
-- VARIABLES
--======================

local UseFast = GetConfig("UseFast", false)

local SelectedSkill = {
    Melee = GetConfig("Skill_Melee", "Z"),
    Sword = GetConfig("Skill_Sword", "Z"),
    Gun = GetConfig("Skill_Gun", "Z"),
    Fruit = GetConfig("Skill_Fruit", "Z")
}

local HoldDelay = {
    Melee = {},
    Sword = {},
    Gun = {},
    Fruit = {}
}

--======================
-- USE SKILL FUNCTION
--======================

local function PressSkill(key, holdTime)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    if not UseFast and holdTime and holdTime > 0 then
        task.wait(holdTime)
    end
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

function UseSelectedSkill()
    -- ưu tiên Fruit → Sword → Melee → Gun
    local skillType = "Fruit"
    local key = SelectedSkill.Fruit

    local delay = HoldDelay.Fruit[key]

    PressSkill(key, delay)
end

--======================
-- UI : USE FAST
--======================

Tabs.Skill:AddToggle("UseFast", {
    Title = "Use Fast , Don't Hold",
    Default = UseFast,
    Callback = function(v)
        UseFast = v
        SetConfig("UseFast", v)
    end
})

--======================
-- SELECT SKILL
--======================

Tabs.Skill:AddSection("Select Skill")

Tabs.Skill:AddDropdown("SelectMelee", {
    Title = "Select Skill Melee",
    Values = {"Z","X","C"},
    Default = SelectedSkill.Melee,
    Callback = function(v)
        SelectedSkill.Melee = v
        SetConfig("Skill_Melee", v)
    end
})

Tabs.Skill:AddDropdown("SelectSword", {
    Title = "Select Skill Sword",
    Values = {"Z","X"},
    Default = SelectedSkill.Sword,
    Callback = function(v)
        SelectedSkill.Sword = v
        SetConfig("Skill_Sword", v)
    end
})

Tabs.Skill:AddDropdown("SelectGun", {
    Title = "Select Skill Gun",
    Values = {"Z","X"},
    Default = SelectedSkill.Gun,
    Callback = function(v)
        SelectedSkill.Gun = v
        SetConfig("Skill_Gun", v)
    end
})

Tabs.Skill:AddDropdown("SelectFruit", {
    Title = "Select Skill Blox Fruit",
    Values = {"Z","X","C","V","F"},
    Default = SelectedSkill.Fruit,
    Callback = function(v)
        SelectedSkill.Fruit = v
        SetConfig("Skill_Fruit", v)
    end
})

--======================
-- HOLD SKILL SECTION
--======================

Tabs.Skill:AddSection("Hold Skill")

local function AddHoldInput(tab, title, skillType, key)
    tab:AddInput(title, {
        Placeholder = "Hold (seconds)",
        Default = GetConfig("Hold_"..skillType.."_"..key, ""),
        Callback = function(v)
            local num = tonumber(v)
            if num then
                HoldDelay[skillType][key] = num
                SetConfig("Hold_"..skillType.."_"..key, num)
            end
        end
    })
end

-- Melee
for _, k in ipairs({"Z","X","C"}) do
    AddHoldInput(Tabs.Skill, "Set delay Melee "..k, "Melee", k)
end

-- Sword
for _, k in ipairs({"Z","X"}) do
    AddHoldInput(Tabs.Skill, "Set delay Sword "..k, "Sword", k)
end

-- Gun
for _, k in ipairs({"Z","X"}) do
    AddHoldInput(Tabs.Skill, "Set delay Gun "..k, "Gun", k)
end

-- Fruit
for _, k in ipairs({"Z","X","C","V","F"}) do
    AddHoldInput(Tabs.Skill, "Set delay Fruit "..k, "Fruit", k)
end
--=====================================================
-- TAB FRUIT : AUTO RANDOM + AUTO STORE
--=====================================================

local AutoRandomFruit = false
local AutoStoreFruit = false
local RandomCooldown = false
local StoredOnce = false

--======================
-- FIND GACHA NPC
--======================

local function GetFruitGachaNPC()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("blox fruit gacha") then
            return v
        end
    end
end

--======================
-- AUTO RANDOM FRUIT
--======================

Tabs.Fruit:AddToggle("AutoRandomFruit", {
    Title = "Auto Random",
    Default = GetConfig("AutoRandomFruit", false),
    Callback = function(v)
        AutoRandomFruit = v
        SetConfig("AutoRandomFruit", v)

        if not v then return end

        task.spawn(function()
            while AutoRandomFruit do
                if RandomCooldown then
                    task.wait(1)
                    continue
                end

                local npc = GetFruitGachaNPC()
                if npc and npc:FindFirstChild("HumanoidRootPart") then
                    RandomCooldown = true
                    HRP.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)

                    task.wait(0.5)
                    Utils.TalkToNPC(npc)

                    task.wait(5) -- chờ random xong
                    RandomCooldown = false
                end

                task.wait(2)
            end
        end)
    end
})

--======================
-- AUTO STORE FRUIT
--======================

Tabs.Fruit:AddToggle("AutoStoreFruit", {
    Title = "Auto Store",
    Default = GetConfig("AutoStoreFruit", false),
    Callback = function(v)
        AutoStoreFruit = v
        SetConfig("AutoStoreFruit", v)

        if not v then return end

        task.spawn(function()
            while AutoStoreFruit do
                if StoredOnce then
                    task.wait(3)
                    continue
                end

                for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name:lower():find("fruit") then
                        StoredOnce = true
                        Utils.StoreFruit(tool)
                        break
                    end
                end

                task.wait(2)
            end
        end)
    end
})
--=====================================================
-- TAB WEBHOOK
--=====================================================

local WebhookURL = GetConfig("WebhookURL", "")
local WebhookPing = GetConfig("WebhookPing", "")
local LogFrozen = GetConfig("LogFrozen", false)
local LogDrive = GetConfig("LogDrive", false)

--======================
-- SEND WEBHOOK
--======================

function SendWebhook(msg)
    if WebhookURL == "" then return end

    local ping = ""
    if WebhookPing ~= "" then
        ping = "<@" .. WebhookPing .. ">"
        if WebhookPing:lower() == "everyone" then
            ping = "@everyone"
        end
    end

    local data = {
        content = ping .. "\\n" .. msg
    }

    request({
        Url = WebhookURL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode(data)
    })
end

--======================
-- UI WEBHOOK
--======================

Tabs.Webhook:AddInput("WebhookURL", {
    Title = "Webhook Url",
    Default = WebhookURL,
    Callback = function(v)
        WebhookURL = v
        SetConfig("WebhookURL", v)
    end
})

Tabs.Webhook:AddInput("WebhookPing", {
    Title = "Ping Id / Everyone",
    Default = WebhookPing,
    Callback = function(v)
        WebhookPing = v
        SetConfig("WebhookPing", v)
    end
})

Tabs.Webhook:AddToggle("FrozenLog", {
    Title = "Frozen Dimension Spawn",
    Default = LogFrozen,
    Callback = function(v)
        LogFrozen = v
        SetConfig("LogFrozen", v)
    end
})

Tabs.Webhook:AddToggle("DriveLog", {
    Title = "Drive Boat To Tiki / Hydra",
    Default = LogDrive,
    Callback = function(v)
        LogDrive = v
        SetConfig("LogDrive", v)
    end
})
--=====================================================
-- ANTI STUCK / ANTI DESYNC
--=====================================================

local LastPosition = HRP.Position
local LastMoveTick = tick()

local STUCK_TIME = 4       -- đứng yên > 4s
local MOVE_CHECK = 0.5
local STUCK_DISTANCE = 3   -- di chuyển < 3 studs

--======================
-- RESET VELOCITY
--======================

local function ResetVelocity()
    HRP.AssemblyLinearVelocity = Vector3.zero
    HRP.AssemblyAngularVelocity = Vector3.zero
end

--======================
-- ANTI STUCK CHECK
--======================

task.spawn(function()
    while task.wait(MOVE_CHECK) do
        if not Character or not HRP or not Humanoid then
            continue
        end

        local dist = (HRP.Position - LastPosition).Magnitude

        if dist > STUCK_DISTANCE then
            LastMoveTick = tick()
            LastPosition = HRP.Position
            continue
        end

        if tick() - LastMoveTick >= STUCK_TIME then
            -- 🚑 STUCK DETECTED
            ResetVelocity()

            HRP.CFrame = HRP.CFrame + Vector3.new(
                math.random(-5,5),
                25,
                math.random(-5,5)
            )

            LastMoveTick = tick()
            LastPosition = HRP.Position
        end
    end
end)

--======================
-- ANTI DESYNC CHECK
--======================

task.spawn(function()
    while task.wait(1) do
        if not HRP then continue end

        local serverPos = HRP.Position
        task.wait()
        local clientPos = HRP.Position

        if (serverPos - clientPos).Magnitude > 80 then
            -- 🌐 DESYNC FIX
            ResetVelocity()
            HRP.CFrame = CFrame.new(serverPos)
        end
    end
end)
Window:SelectTab(1)

Fluent:Notify({
    Title = "AlyaHub",
    Content = "Alya Leviathan Loaded Successfully",
    Duration = 5
})