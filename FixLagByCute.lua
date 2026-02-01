local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fix Lag Blox Fruits",
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
local FixLagTab = Window:AddTab({ Title = "Fix Lag" , Icon = "" })
-- Toggle Clear Map: Xóa texture/hiệu ứng nhưng giữ nguyên Part để không rơi khỏi map
FixLagTab:AddToggle("ClearMapGrey", {
    Title = "Clear Map",
    Default = false,
    Callback = function(Value)
        _G.ClearMap = Value
        if Value then
            pcall(function()
                for _, v in ipairs(game:GetDescendants()) do
                    if not _G.ClearMap then break end
                    
                    if v:IsA("BasePart") then
                        v.Material = Enum.Material.SmoothPlastic
                        v.Color = Color3.fromRGB(163, 162, 165) -- Biến tất cả thành màu xám
                        v.CastShadow = false
                    elseif v:IsA("Texture") or v:IsA("Decal") or v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Enabled = false
                    end
                end
                
                -- Tối ưu hóa Lighting để đồng bộ màu xám
                local Lighting = game:GetService("Lighting")
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(163, 162, 165)
            end)
            
            Fluent:Notify({
                Title = "Fix Lag BF",
                Content = "Đã chuyển Map sang chế độ tối giản xám!",
                Duration = 2
            })
        end
    end
})
