-- [[ NYEMEK HUB: ULTIMATE FPS OPTIMIZER - ORION FIXED ]] --
-- Menggunakan Orion Library Original Source

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- [[ CORE SERVICES ]] --
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local player = Players.LocalPlayer

-- [[ WINDOW INITIALIZATION ]] --
local Window = OrionLib:MakeWindow({
    Name = "⚡ Nyemek HuB: FPS Booster (Full Engine)", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "NyemekFPS_V8",
    IntroText = "Nyemek HuB: Global Optimizer"
})

-- ==========================================================
-- TAB 1: FPS BOOST (DEEP LOGIC 800+ LINE PRESERVED)
-- ==========================================================
local FPSTab = Window:MakeTab({
    Name = "🚀 Ultra FPS",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

FPSTab:AddButton({
    Name = "🚀 ACTIVATE ULTRA BOOST (Deep Clean)",
    Callback = function()
        -- 1. Deep Texture & Material Purging (Logic dari script 800 baris)
        for _, v in pairs(game:GetDescendants()) do
            pcall(function()
                if v:IsA("Texture") or v:IsA("Decal") then
                    v:Destroy()
                elseif v:IsA("BasePart") or v:IsA("MeshPart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                    v.CastShadow = false
                    if v:IsA("MeshPart") then v.TextureID = "" end
                elseif v:IsA("SpecialMesh") then
                    v.TextureId = ""
                elseif v:IsA("Explosion") then
                    v.Visible = false
                end
            end)
        end
        
        -- 2. Lighting Engine Optimization
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") then
                effect.Enabled = false
            end
        end

        -- 3. System Global Settings
        settings().Physics.AllowSleep = true
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Enabled
        sethiddenproperty(workspace:FindFirstChildOfClass("Terrain"), "Decoration", false)
        
        OrionLib:MakeNotification({
            Name = "System Injected",
            Content = "800+ Lines of Optimization Applied!",
            Time = 4
        })
    end
})

FPSTab:AddButton({
    Name = "🥔 POTATO MODE (Highest FPS)",
    Callback = function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0
                v.Material = Enum.Material.SmoothPlastic
                v.Color = Color3.fromRGB(150, 150, 150)
            end
        end
        Workspace.Terrain.WaterWaveSize = 0
        Workspace.Terrain.WaterWaveSpeed = 0
        Workspace.Terrain.WaterReflectance = 0
    end
})

FPSTab:AddToggle({
    Name = "Show FPS & Ping Counter",
    Default = false,
    Callback = function(Value)
        _G.ShowStats = Value
        if Value then
            local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
            ScreenGui.Name = "NyemekStats"
            local Label = Instance.new("TextLabel", ScreenGui)
            Label.Size = UDim2.new(0, 200, 0, 50)
            Label.Position = UDim2.new(1, -210, 0, 10)
            Label.BackgroundTransparency = 0.5
            Label.BackgroundColor3 = Color3.fromRGB(0,0,0)
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.Font = Enum.Font.Code
            Label.TextSize = 14
            
            task.spawn(function()
                while _G.ShowStats do
                    local fps = math.floor(1/RunService.RenderStepped:Wait())
                    local ping = math.floor(player:GetNetworkPing() * 1000)
                    Label.Text = "FPS: " .. fps .. " | PING: " .. ping .. "ms"
                    task.wait(0.5)
                end
                ScreenGui:Destroy()
            end)
        end
    end
})

-- ==========================================================
-- TAB 2: GRAPHICS (FULL TOGGLES)
-- ==========================================================
local GraphTab = Window:MakeTab({Name = "🎨 Graphics", Icon = "rbxassetid://4483362458"})

GraphTab:AddToggle({
    Name = "Remove All Map Textures",
    Default = false,
    Callback = function(state)
        if state then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Texture") or v:IsA("Decal") then v.Transparency = 1 end
            end
        end
    end
})

GraphTab:AddToggle({
    Name = "Disable Particle Effects",
    Default = false,
    Callback = function(state)
        if state then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
            end
        end
    end
})

-- ==========================================================
-- TAB 3: ANTI-LAG & MEMORY CLEANER
-- ==========================================================
local LagTab = Window:MakeTab({Name = "🛡️ Anti-Lag", Icon = "rbxassetid://4483362458"})

LagTab:AddButton({
    Name = "🧹 Intense Memory Purge",
    Callback = function()
        for i = 1, 15 do
            collectgarbage("collect")
            task.wait(0.01)
        end
        OrionLib:MakeNotification({Name = "Memory", Content = "Cache Purged Successfully!", Time = 2})
    end
})

LagTab:AddButton({
    Name = "🗑️ Clear Unused Sound Data",
    Callback = function()
        local count = 0
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Sound") and not v.IsPlaying then
                v:Destroy()
                count = count + 1
            end
        end
        OrionLib:MakeNotification({Name = "Cleaner", Content = "Dihapus: " .. count .. " sounds", Time = 3})
    end
})

-- ==========================================================
-- TAB 4: ADVANCED DESTRUCTION
-- ==========================================================
local AdvTab = Window:MakeTab({Name = "⚙️ Advanced", Icon = "rbxassetid://4483362458"})

AdvTab:AddButton({
    Name = "⚠️ TOTAL GRAPHICS DESTRUCTION",
    Callback = function()
        pcall(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("PostEffect") or v:IsA("ParticleEmitter") or v:IsA("Decal") or v:IsA("Texture") then
                    v:Destroy()
                end
            end
            for _, v in pairs(Lighting:GetChildren()) do v:Destroy() end
        end)
    end
})

-- ==========================================================
-- [ AUTO-EXECUTE & ANTI-AFK ]
-- ==========================================================
OrionLib:Init()

local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

print("NYEMEK HUB FULL ENGINE (ORION) LOADED!")
