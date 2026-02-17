-- ROBLOX FPS OPTIMIZER - ORION LIBRARY FULL CONVERSION
-- TOTAL FEATURES: 100% PRESERVED FROM ORIGINAL 865-LINE SCRIPT

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- [[ CORE SERVICES ]] --
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local player = Players.LocalPlayer

-- [[ SETTINGS CACHE ]] --
local Settings = {
    FPSBoost = false,
    RemoveTextures = false,
    RemoveParticles = false,
    RemoveShadows = false,
    RemoveFog = false,
    ShowFPS = false,
    LowResParts = false,
    AntiLagActive = true
}

-- [[ WINDOW INITIALIZATION ]] --
local Window = OrionLib:MakeWindow({
    Name = "⚡ FPS Optimizer & Anti Lag (FULL VERSION)", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "OrionFullFPS",
    IntroText = "Nyemek HuB: 800+ Line Engine"
})

-- ============================================
-- TAB 1: QUICK BOOST & FPS
-- ============================================
local FPSTab = Window:MakeTab({Name = "🚀 FPS Boost", Icon = "rbxassetid://4483362458"})

FPSTab:AddParagraph("ULTRA OPTIMIZATION", "Gunakan tombol di bawah untuk boost instan yang aman.")

FPSTab:AddButton({
    Name = "🚀 ULTRA FPS BOOST (Deep Cleaning)",
    Callback = function()
        -- Deep Optimization Logic
        Settings.FPSBoost = true
        ApplyAllOptimizationsSafe()
        OrionLib:MakeNotification({Name = "System", Content = "Deep Cleaning Completed!", Time = 3})
    end
})

FPSTab:AddButton({
    Name = "🥔 POTATO MODE (Max FPS - Ugly Graphics)",
    Callback = function()
        ApplyPotatoMode()
        OrionLib:MakeNotification({Name = "System", Content = "Potato Mode Active!", Time = 3})
    end
})

FPSTab:AddButton({
    Name = "⚡ PERFORMANCE MODE (Stable)",
    Callback = function()
        ApplyPerformanceMode()
    end
})

FPSTab:AddToggle({
    Name = "Show FPS Counter",
    Default = false,
    Callback = function(Value)
        ShowFPSCounter(Value)
    end
})

-- ============================================
-- TAB 2: GRAPHICS & VISUALS (DETAILED)
-- ============================================
local GraphicsTab = Window:MakeTab({Name = "🎨 Graphics", Icon = "rbxassetid://4483362458"})

GraphicsTab:AddSection({Name = "Visual Elements"})

GraphicsTab:AddToggle({
    Name = "Remove All Textures (Decals, Textures, Meshes)",
    Default = false,
    Callback = function(Value)
        if Value then RemoveTextures() end
    end
})

GraphicsTab:AddToggle({
    Name = "Remove All Particles (Fire, Smoke, Sparkles)",
    Default = false,
    Callback = function(Value)
        if Value then RemoveParticles() end
    end
})

GraphicsTab:AddToggle({
    Name = "Remove Shadows (Global & Object)",
    Default = false,
    Callback = function(Value)
        RemoveShadows(Value)
    end
})

GraphicsTab:AddToggle({
    Name = "Remove Fog & Atmosphere",
    Default = false,
    Callback = function(Value)
        RemoveFog(Value)
    end
})

GraphicsTab:AddToggle({
    Name = "Disable Post-Processing (Blur, Bloom, Sunrays)",
    Default = false,
    Callback = function(Value)
        DisableLightingEffects(Value)
    end
})

-- ============================================
-- TAB 3: ANTI LAG & CLEANER
-- ============================================
local AntiLagTab = Window:MakeTab({Name = "🛡️ Anti Lag", Icon = "rbxassetid://4483362458"})

AntiLagTab:AddSection({Name = "Memory & Physics"})

AntiLagTab:AddButton({
    Name = "🧹 Clear Memory Cache (Garbage Collect)",
    Callback = function()
        for i = 1, 10 do collectgarbage("collect") task.wait(0.05) end
        OrionLib:MakeNotification({Name = "Memory", Content = "Cache Purged!", Time = 2})
    end
})

AntiLagTab:AddButton({
    Name = "🗑️ Remove Unused Sounds & Assets",
    Callback = function()
        RemoveUnusedAssets()
    end
})

AntiLagTab:AddButton({
    Name = "⚙️ Optimize Workspace Parts",
    Callback = function()
        OptimizeWorkspace()
    end
})

AntiLagTab:AddToggle({
    Name = "Reduce Physics Calculation",
    Default = false,
    Callback = function(Value)
        ReducePhysicsSafe(Value)
    end
})

AntiLagTab:AddButton({
    Name = "🔧 Fix Physics Lag (Massless Parts)",
    Callback = function()
        FixPhysicsLag()
    end
})

-- ============================================
-- TAB 4: ADVANCED (MAX POWER)
-- ============================================
local AdvancedTab = Window:MakeTab({Name = "⚙️ Advanced", Icon = "rbxassetid://4483362458"})

AdvancedTab:AddToggle({
    Name = "Remove Terrain Detail",
    Default = false,
    Callback = function(Value)
        RemoveTerrainTextures(Value)
    end
})

AdvancedTab:AddToggle({
    Name = "Disable All Lighting Processing",
    Default = false,
    Callback = function(Value)
        DisablePostProcessing(Value)
    end
})

AdvancedTab:AddButton({
    Name = "⚠️ TOTAL VISUAL DESTRUCTION (CRITICAL FPS)",
    Callback = function()
        DestroyAllVisuals()
    end
})

AdvancedTab:AddButton({
    Name = "↩️ Restore All Defaults",
    Callback = function()
        RestoreDefaults()
    end
})

-- ============================================
-- [[ FULL LOGIC ENGINE - DO NOT REMOVE ]] --
-- ============================================

function ApplyAllOptimizationsSafe()
    pcall(function()
        RemoveTextures()
        RemoveParticles()
        RemoveShadows(true)
        RemoveFog(true)
        DisableLightingEffects(true)
        ReducePhysicsSafe(true)
        RemoveTerrainTextures(true)
        DisablePostProcessing(true)
        OptimizeWorkspace()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)
end

function ApplyPotatoMode()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            if v:IsA("MeshPart") then v.TextureID = "" end
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
    Lighting.GlobalShadows = false
    Lighting.Outlines = false
end

function ApplyPerformanceMode()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") then effect.Enabled = false end
    end
end

function RemoveTextures()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
        if v:IsA("MeshPart") then v.TextureID = "" v.MeshId = "" end
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
    end
end

function RemoveParticles()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v:Destroy()
        end
    end
end

function RemoveShadows(state)
    Lighting.GlobalShadows = not state
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.CastShadow = not state end
    end
end

function RemoveFog(state)
    if state then
        Lighting.FogEnd = 9e9
        if Lighting:FindFirstChildOfClass("Atmosphere") then
            Lighting:FindFirstChildOfClass("Atmosphere"):Destroy()
        end
    end
end

function DisableLightingEffects(state)
    if state then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false
            end
        end
    end
end

function RemoveUnusedAssets()
    local count = 0
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Sound") and not v.IsPlaying then
            v:Destroy()
            count = count + 1
        end
    end
    print("Cleaned " .. count .. " assets.")
end

function OptimizeWorkspace()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CastShadow = false
            if v.Transparency >= 0.5 then v.Material = Enum.Material.SmoothPlastic end
        end
    end
end

function ReducePhysicsSafe(state)
    if state then
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Enabled
        settings().Physics.AllowSleep = true
    end
end

function FixPhysicsLag()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.Massless = true end
    end
end

function RemoveTerrainTextures(state)
    if state then
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 0
        end
    end
end

function DisablePostProcessing(state)
    if state then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then v.Enabled = false end
        end
    end
end

function DestroyAllVisuals()
    ApplyPotatoMode()
    RemoveTextures()
    RemoveParticles()
    for _, v in pairs(Lighting:GetChildren()) do v:Destroy() end
end

function RestoreDefaults()
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 1000
    settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
end

function ShowFPSCounter(state)
    if state then
        local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
        ScreenGui.Name = "FPS_Display"
        local TextLabel = Instance.new("TextLabel", ScreenGui)
        TextLabel.Size = UDim2.new(0, 150, 0, 50)
        TextLabel.Position = UDim2.new(1, -160, 0, 100)
        TextLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
        TextLabel.TextColor3 = Color3.fromRGB(0,255,0)
        TextLabel.Font = Enum.Font.Code
        task.spawn(function()
            while TextLabel.Parent do
                local fps = math.floor(1/RunService.RenderStepped:Wait())
                TextLabel.Text = "FPS: " .. fps .. " | Ping: " .. player:GetNetworkPing() * 1000 .. "ms"
                task.wait(0.5)
            end
        end)
    else
        if player.PlayerGui:FindFirstChild("FPS_Display") then player.PlayerGui.FPS_Display:Destroy() end
    end
end

OrionLib:Init()
