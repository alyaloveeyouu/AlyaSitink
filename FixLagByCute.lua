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
    Title = "Disable Effect",
    Default = false,
    Callback = function(Value)
        _G.ClearMap = Value
        if Value then
            pcall(function()
                -- Thiết lập môi trường và ánh sáng theo code của bạn
                local g = game
                local w = g.Workspace
                local l = g.Lighting
                local t = w.Terrain
                
                t.WaterWaveSize = 0
                t.WaterWaveSpeed = 0
                t.WaterReflectance = 0
                t.WaterTransparency = 0
                
                l.GlobalShadows = false
                l.FogEnd = 9e9
                l.Brightness = 0
                l.OutdoorAmbient = Color3.fromRGB(163, 162, 165)
                
                settings().Rendering.QualityLevel = "Level01"

                -- Duyệt và biến tất cả thành màu xám + Smooth Plastic
                for i, v in pairs(g:GetDescendants()) do
                    if not _G.ClearMap then break end -- Dừng nếu tắt toggle
                    
                    if v:IsA("BasePart") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") or v:IsA("MeshPart") then 
                        v.Material = Enum.Material.SmoothPlastic
                        v.Reflectance = 0
                        v.CastShadow = false
                        v.Color = Color3.fromRGB(163, 162, 165) -- Màu xám
                        if v:IsA("MeshPart") then
                            v.TextureID = "" -- Xóa texture gốc thay vì để ID lạ để tránh lỗi load
                        end
                    elseif v:IsA("Decal") or v:IsA("Texture") then
                        v.Transparency = 1
                        v.Enabled = false
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Lifetime = NumberRange.new(0)
                        v.Enabled = false
                    elseif v:IsA("Explosion") then
                        v.BlastPressure = 1
                        v.BlastRadius = 1
                    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                        v.Enabled = false
                    end
                end

                -- Tắt các hiệu ứng hình ảnh
                for i, e in pairs(l:GetChildren()) do
                    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                        e.Enabled = false
                    end
                end
            end)
            
            Fluent:Notify({
                Title = "Fix Lag BF",
                Content = "Fix Lag Enabled",
                Duration = 2
            })
        end
    end
})
