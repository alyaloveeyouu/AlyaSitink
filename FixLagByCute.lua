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
local FixLag = Window:AddTab({ Title = "Fix Lag" , Icon = "" })
-- Toggle Clear Map: Xóa texture/hiệu ứng nhưng giữ nguyên Part để không rơi khỏi map
FixLag:AddToggle("ClearMapToggle", {
    Title = "Clear Map",
    Default = false,
    Callback = function(Value)
        _G.ClearMap = Value
        if Value then
            -- Tối ưu hóa cực hạn
            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.CastShadow = false
                elseif v:IsA("Texture") or v:IsA("Decal") then
                    v.Enabled = false
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end
            
            -- Tắt hiệu ứng ánh sáng
            local Lighting = game:GetService("Lighting")
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            
            Fluent:Notify({
                Title = "Fix Lag BF",
                Content = "Đã dọn dẹp Map thành công!",
                Duration = 2
            })
        end
    end
})

-- Tự động nhảy vào tab này
Window:SelectTab(1)


