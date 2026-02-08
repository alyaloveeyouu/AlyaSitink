local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local LP = game.Players.LocalPlayer
local replicated = game:GetService("ReplicatedStorage")

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

local Tabs = {
    HuntLeviathan = Window:AddTab({ Title = "Hunt Leviathan", Icon = "map" }),
    Skill = Window:AddTab({ Title = "Select And Hold Skill", Icon = "zap" }),
    Fruit = Window:AddTab({ Title = "Fruit", Icon = "cherry" })
}

local activeTween, freezeY = nil, nil

local function GetFrozenDimension()
    return workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations") and workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension")
end

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

do
    Tabs.HuntLeviathan:AddButton({
        Title = "Teleport To Your Boat",
        Description = "Bay đến ghế lái thuyền của bạn (Speed 350)",
        Callback = function()
            local targetSeat = nil
            for _, b in pairs(workspace.Boats:GetChildren()) do
                if b:FindFirstChild("Owner") and (tostring(b.Owner.Value) == LP.Name or b.Owner.Value == LP.UserId) then
                    targetSeat = b:FindFirstChildWhichIsA("VehicleSeat", true)
                    break
                end
            end
            if targetSeat and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LP.Character.HumanoidRootPart
                local dist = (targetSeat.Position - hrp.Position).Magnitude
                local noclip = RS.Stepped:Connect(function()
                    for _, v in pairs(LP.Character:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                end)
                local tw = TS:Create(hrp, TweenInfo.new(dist / 350, Enum.EasingStyle.Linear), {CFrame = targetSeat.CFrame + Vector3.new(0, 5, 0)})
                tw:Play()
                tw.Completed:Connect(function() noclip:Disconnect() end)
            end
        end
    })

    local SPYING = Tabs.HuntLeviathan:AddParagraph({
        Title = "Status Spy",
        Content = ""
    })
    
    task.spawn(function()
        while task.wait(.2) do
            pcall(function()
                local spycheck = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")
                if spycheck then
                    if tostring(spycheck) == "5" then
                        SPYING:SetContent(" Spy Leviathan : Already Done!!")
                    else
                        SPYING:SetContent(" Spy Leviathan : " .. tostring(spycheck))
                    end
                end
            end)
        end
    end)

    local FloD = Tabs.HuntLeviathan:AddParagraph({
        Title = "Frozen Dimension",
        Content = ""
    })
    
    task.spawn(function()
        while task.wait(.2) do
            pcall(function()
                if GetFrozenDimension() then
                    FloD:SetContent(" Flozen Dimension : True")
                else
                    FloD:SetContent(" Flozen Dimension : False")
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

    local ToggleFind = Tabs.HuntLeviathan:AddToggle("Find", { Title = "Find Leviathan", Default = false })
    ToggleFind:OnChanged(function(Value)
        _G.Auto = Value
        if Value then
            task.spawn(function()
                while _G.Auto do
                    local hum = LP.Character:FindFirstChild("Humanoid")
                    local seat = hum and hum.SeatPart
                    if seat and seat:IsA("VehicleSeat") then
                        if GetFrozenDimension() then
                            if activeTween then activeTween:Cancel() end
                            Fluent:Notify({Title = "Banana Cat Hub", Content = "Frozen Dimension Spawned", Duration = 5})
                            repeat task.wait(1) until not GetFrozenDimension() or not _G.Auto
                        else
                            Fluent:Notify({Title = "Banana Cat Hub", Content = "Finding Leviathan", Duration = 3})
                            local boat = seat.Parent.PrimaryPart
                            SetVelocity(boat, true)
                            freezeY = 1000
                            boat.CFrame = CFrame.new(boat.Position.X, 1000, boat.Position.Z)
                            task.wait(1)
                            
                            if _G.Auto and not GetFrozenDimension() and hum.SeatPart == seat and boat.Position.Z < 14238 then
                                local dist = (Vector3.new(-13608, 1000, 14238) - boat.Position).Magnitude
                                activeTween = TS:Create(boat, TweenInfo.new(dist/250, Enum.EasingStyle.Linear), {CFrame = CFrame.new(-13608, 1000, 14238)})
                                activeTween:Play()
                                while _G.Auto and activeTween.PlaybackState == Enum.PlaybackState.Playing and hum.SeatPart == seat do
                                    if GetFrozenDimension() then break end
                                    task.wait(0.2)
                                end
                            end
                            
                            if _G.Auto and not GetFrozenDimension() and hum.SeatPart == seat then
                                if activeTween then activeTween:Cancel() end
                                freezeY = 175
                                boat.CFrame = CFrame.new(boat.Position.X, 175, boat.Position.Z)
                                task.wait(1)
                                local targetCF = CFrame.new(boat.Position.X, 175, 1000000)
                                activeTween = TS:Create(boat, TweenInfo.new(4000, Enum.EasingStyle.Linear), {CFrame = targetCF})
                                activeTween:Play()
                                while _G.Auto and activeTween.PlaybackState == Enum.PlaybackState.Playing and hum.SeatPart == seat do
                                    if GetFrozenDimension() then break end
                                    pcall(function() boat.CatV.VectorVelocity = boat.CFrame.LookVector * 250 end)
                                    task.wait(0.2)
                                end
                            end
                            
                            if activeTween then activeTween:Cancel() end
                            freezeY = nil
                            pcall(function()
                                SetVelocity(boat, false)
                                boat.CFrame = CFrame.new(boat.Position.X, 28, boat.Position.Z)
                            end)
                        end
                    end
                    task.wait(1)
                end
            end)
        else
            if activeTween then activeTween:Cancel() end
            freezeY = nil
            pcall(function()
                local hum = LP.Character:FindFirstChild("Humanoid")
                if hum and hum.SeatPart then
                    local boat = hum.SeatPart.Parent.PrimaryPart
                    SetVelocity(boat, false)
                    boat.CFrame = CFrame.new(boat.Position.X, 28, boat.Position.Z)
                end
            end)
        end
    end)
end

RS.Stepped:Connect(function()
    if _G.Auto and freezeY and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.Velocity = Vector3.new(LP.Character.HumanoidRootPart.Velocity.X, 0, LP.Character.HumanoidRootPart.Velocity.Z)
        pcall(function()
            local boat = LP.Character.Humanoid.SeatPart.Parent.PrimaryPart
            boat.Velocity = Vector3.new(boat.Velocity.X, 0, boat.Velocity.Z)
        end)
    end
end)

Window:SelectTab(1)
