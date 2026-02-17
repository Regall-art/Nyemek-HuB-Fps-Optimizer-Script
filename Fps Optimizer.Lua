-- ROBLOX FPS OPTIMIZER - RAYFIELD UI + MINI TOGGLE
-- Universal FPS Boost with Rayfield interface
-- Mini button appears after close for quick reopen

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Settings
local Settings = {
   FPSBoost = false,
   RemoveTextures = false,
   RemoveParticles = false,
   RemoveShadows = false,
   RemoveFog = false,
   ShowFPS = false,
}

print("\n" .. string.rep("=", 70))
print("FPS OPTIMIZER - RAYFIELD UI")
print("With Mini Toggle Button Feature")
print(string.rep("=", 70) .. "\n")

local Window = Rayfield:CreateWindow({
   Name = "⚡Nyemek HuB FPS Optimizer & Anti Lag",
   LoadingTitle = "Nyemek HuB FPS Optimizer",
   LoadingSubtitle = "Made By Love",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "FPSOptimizer_Rayfield"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- ============================================
-- MINI TOGGLE BUTTON (appears after close)
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FPSOptimizerMini"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui

local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniToggle"
MiniButton.Size = UDim2.new(0, 60, 0, 60)
MiniButton.Position = UDim2.new(1, -70, 0.5, -30)
MiniButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
MiniButton.BorderSizePixel = 0
MiniButton.Text = ""
MiniButton.Visible = false
MiniButton.AutoButtonColor = false
MiniButton.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(1, 0)
MiniCorner.Parent = MiniButton

local MiniGradient = Instance.new("UIGradient")
MiniGradient.Color = ColorSequence.new({
   ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 101, 242)),
   ColorSequenceKeypoint.new(1, Color3.fromRGB(114, 137, 218))
})
MiniGradient.Rotation = 45
MiniGradient.Parent = MiniButton

local MiniIcon = Instance.new("TextLabel")
MiniIcon.Size = UDim2.new(1, 0, 1, 0)
MiniIcon.BackgroundTransparency = 1
MiniIcon.Text = "⚡"
MiniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniIcon.TextSize = 28
MiniIcon.Font = Enum.Font.GothamBold
MiniIcon.Parent = MiniButton

-- Pulse animation
local function PulseMini()
   while MiniButton.Visible do
      TweenService:Create(MiniButton, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
         Size = UDim2.new(0, 65, 0, 65)
      }):Play()
      task.wait(1)
      TweenService:Create(MiniButton, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
         Size = UDim2.new(0, 60, 0, 60)
      }):Play()
      task.wait(1)
   end
end

-- Hover effect
MiniButton.MouseEnter:Connect(function()
   TweenService:Create(MiniButton, TweenInfo.new(0.2), {
      Size = UDim2.new(0, 70, 0, 70),
      BackgroundColor3 = Color3.fromRGB(114, 137, 218)
   }):Play()
   TweenService:Create(MiniIcon, TweenInfo.new(0.2), {
      Rotation = 15
   }):Play()
end)

MiniButton.MouseLeave:Connect(function()
   TweenService:Create(MiniButton, TweenInfo.new(0.2), {
      Size = UDim2.new(0, 60, 0, 60),
      BackgroundColor3 = Color3.fromRGB(88, 101, 242)
   }):Play()
   TweenService:Create(MiniIcon, TweenInfo.new(0.2), {
      Rotation = 0
   }):Play()
end)

-- Click to reopen
MiniButton.MouseButton1Click:Connect(function()
   TweenService:Create(MiniButton, TweenInfo.new(0.3), {
      Size = UDim2.new(0, 0, 0, 0)
   }):Play()
   
   task.wait(0.3)
   MiniButton.Visible = false
   
   -- Reopen Rayfield
   Rayfield:LoadConfiguration()
   
   Rayfield:Notify({
      Title = "Welcome Back!",
      Content = "UI reopened successfully!",
      Duration = 3,
      Image = 4483362458,
   })
end)

-- Make draggable
local dragging = false
local dragStart
local startPos

MiniButton.InputBegan:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      dragStart = input.Position
      startPos = MiniButton.Position
      
      input.Changed:Connect(function()
         if input.UserInputState == Enum.UserInputState.End then
            dragging = false
         end
      end)
   end
end)

UserInputService.InputChanged:Connect(function(input)
   if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
      local delta = input.Position - dragStart
      MiniButton.Position = UDim2.new(
         startPos.X.Scale,
         startPos.X.Offset + delta.X,
         startPos.Y.Scale,
         startPos.Y.Offset + delta.Y
      )
   end
end)

-- Intercept Rayfield close to show mini button
local RayfieldUI = player.PlayerGui:WaitForChild("RayFieldUI", 10)
if RayfieldUI then
   local MainFrame = RayfieldUI:FindFirstChild("Main")
   if MainFrame then
      -- Monitor for close
      MainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
         if not MainFrame.Visible then
            -- Show mini button when Rayfield closes
            MiniButton.Visible = true
            MiniButton.Size = UDim2.new(0, 0, 0, 0)
            
            TweenService:Create(MiniButton, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
               Size = UDim2.new(0, 60, 0, 60)
            }):Play()
            
            task.spawn(PulseMini)
         end
      end)
   end
end

-- ============================================
-- TAB: FPS BOOST
-- ============================================
local FPSTab = Window:CreateTab("⚡ FPS Boost", 4483362458)

FPSTab:CreateParagraph({
   Title = "🚀 Quick Boost Modes",
   Content = "Choose a preset optimization level for instant FPS boost!"
})

FPSTab:CreateButton({
   Name = "🚀 ULTRA FPS BOOST",
   Callback = function()
      Settings.FPSBoost = true
      Settings.RemoveTextures = true
      Settings.RemoveParticles = true
      Settings.RemoveShadows = true
      Settings.RemoveFog = true
      
      ApplyAllOptimizationsSafe()
      
      Rayfield:Notify({
         Title = "Ultra FPS Boost",
         Content = "All optimizations applied! Parts remain walkable!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

FPSTab:CreateButton({
   Name = "🥔 POTATO MODE",
   Callback = function()
      ApplyPotatoMode()
      
      Rayfield:Notify({
         Title = "Potato Mode",
         Content = "Maximum FPS mode! Graphics will be minimal!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

FPSTab:CreateButton({
   Name = "⚡ PERFORMANCE MODE",
   Callback = function()
      ApplyPerformanceMode()
      
      Rayfield:Notify({
         Title = "Performance Mode",
         Content = "Balanced settings applied!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

FPSTab:CreateSection("FPS Counter")

FPSTab:CreateToggle({
   Name = "Show FPS Counter",
   CurrentValue = false,
   Flag = "ShowFPS",
   Callback = function(Value)
      Settings.ShowFPS = Value
      ShowFPSCounter(Value)
   end,
})

-- ============================================
-- TAB: GRAPHICS
-- ============================================
local GraphicsTab = Window:CreateTab("🎨 Graphics", 4483362458)

GraphicsTab:CreateSection("Visual Optimization")

GraphicsTab:CreateToggle({
   Name = "Remove Textures",
   CurrentValue = false,
   Flag = "RemoveTextures",
   Callback = function(Value)
      Settings.RemoveTextures = Value
      if Value then
         RemoveTextures()
         Rayfield:Notify({
            Title = "Textures Removed",
            Content = "All textures have been removed!",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

GraphicsTab:CreateToggle({
   Name = "Remove Particles & Effects",
   CurrentValue = false,
   Flag = "RemoveParticles",
   Callback = function(Value)
      Settings.RemoveParticles = Value
      if Value then
         RemoveParticles()
         Rayfield:Notify({
            Title = "Particles Removed",
            Content = "All particle effects removed!",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

GraphicsTab:CreateToggle({
   Name = "Remove Shadows",
   CurrentValue = false,
   Flag = "RemoveShadows",
   Callback = function(Value)
      Settings.RemoveShadows = Value
      RemoveShadows(Value)
      if Value then
         Rayfield:Notify({
            Title = "Shadows Removed",
            Content = "All shadows have been disabled!",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

GraphicsTab:CreateToggle({
   Name = "Remove Fog",
   CurrentValue = false,
   Flag = "RemoveFog",
   Callback = function(Value)
      Settings.RemoveFog = Value
      RemoveFog(Value)
      if Value then
         Rayfield:Notify({
            Title = "Fog Removed",
            Content = "Distance fog has been removed!",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

GraphicsTab:CreateToggle({
   Name = "Disable Blur & Color Effects",
   CurrentValue = false,
   Flag = "DisableEffects",
   Callback = function(Value)
      DisableLightingEffects(Value)
   end,
})

-- ============================================
-- TAB: ANTI LAG
-- ============================================
local AntiLagTab = Window:CreateTab("🛡️ Anti Lag", 4483362458)

AntiLagTab:CreateButton({
   Name = "🗑️ Remove Unused Assets",
   Callback = function()
      RemoveUnusedAssets()
      Rayfield:Notify({
         Title = "Assets Removed",
         Content = "Unused assets have been removed!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

AntiLagTab:CreateButton({
   Name = "⚙️ Optimize Workspace",
   Callback = function()
      OptimizeWorkspace()
      Rayfield:Notify({
         Title = "Workspace Optimized",
         Content = "Workspace has been optimized!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

AntiLagTab:CreateSection("Physics Optimization")

AntiLagTab:CreateToggle({
   Name = "Reduce Physics Quality",
   CurrentValue = false,
   Flag = "ReducePhysics",
   Callback = function(Value)
      ReducePhysicsSafe(Value)
   end,
})

AntiLagTab:CreateButton({
   Name = "🔧 Fix Physics Lag",
   Callback = function()
      FixPhysicsLag()
      Rayfield:Notify({
         Title = "Physics Fixed",
         Content = "Physics lag has been reduced!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- ============================================
-- TAB: ADVANCED
-- ============================================
local AdvancedTab = Window:CreateTab("⚙️ Advanced", 4483362458)

AdvancedTab:CreateSection("Advanced Optimizations")

AdvancedTab:CreateToggle({
   Name = "Remove Terrain Textures",
   CurrentValue = false,
   Flag = "RemoveTerrain",
   Callback = function(Value)
      RemoveTerrainTextures(Value)
   end,
})

AdvancedTab:CreateToggle({
   Name = "Disable Post-Processing",
   CurrentValue = false,
   Flag = "DisablePostProcessing",
   Callback = function(Value)
      DisablePostProcessing(Value)
   end,
})

AdvancedTab:CreateButton({
   Name = "⚠️ DESTROY ALL VISUALS (MAX FPS)",
   Callback = function()
      DestroyAllVisuals()
      
      Rayfield:Notify({
         Title = "Maximum Optimization",
         Content = "All visuals destroyed! Max FPS mode!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

AdvancedTab:CreateButton({
   Name = "↩️ Restore Default Settings",
   Callback = function()
      RestoreDefaults()
      Rayfield:Notify({
         Title = "Defaults Restored",
         Content = "All settings restored to default!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- ============================================
-- TAB: INFO
-- ============================================
local InfoTab = Window:CreateTab("ℹ️ Info", 4483362458)

InfoTab:CreateParagraph({
   Title = "📊 System Information",
   Content = "This script optimizes FPS and reduces lag for ALL Roblox games."
})

InfoTab:CreateButton({
   Name = "📈 Show Performance Stats",
   Callback = function()
      ShowPerformanceStats()
   end,
})

InfoTab:CreateSection("Recommendations")

InfoTab:CreateParagraph({
   Title = "🎮 Low-End PC",
   Content = "Recommended: Ultra FPS Boost + Potato Mode\nRemove all textures and particles"
})

InfoTab:CreateParagraph({
   Title = "💻 Mid-Range PC",
   Content = "Recommended: Performance Mode\nRemove shadows and fog only"
})

InfoTab:CreateParagraph({
   Title = "🖥️ High-End PC",
   Content = "Recommended: Graphics optimizations only\nKeep visuals, remove shadows"
})

InfoTab:CreateParagraph({
   Title = "🔘 Mini Toggle Button",
   Content = "After closing this UI, a small button will appear on the right side of your screen. Click it to reopen the UI anytime!"
})

-- ============================================
-- OPTIMIZATION FUNCTIONS
-- ============================================

function ApplyAllOptimizationsSafe()
   print("\n⚡ Applying ALL optimizations (Safe Mode)...")
   
   RemoveTextures()
   RemoveParticles()
   RemoveShadows(true)
   RemoveFog(true)
   DisableLightingEffects(true)
   ReducePhysicsSafe(true)
   RemoveTerrainTextures(true)
   DisablePostProcessing(true)
   OptimizeWorkspace()
   
   print("✅ All optimizations applied (collision preserved)!")
end

function ApplyPerformanceMode()
   print("\n⚡ Applying Performance Mode...")
   
   RemoveShadows(true)
   RemoveFog(true)
   RemoveParticles()
   DisableLightingEffects(true)
   
   Lighting.Brightness = 2
   Lighting.GlobalShadows = false
   
   print("✅ Performance mode applied!")
end

function ApplyPotatoMode()
   print("\n🥔 Applying POTATO MODE...")
   
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("Texture") then obj:Destroy() end
         if obj:IsA("Decal") then obj:Destroy() end
         if obj:IsA("ParticleEmitter") then obj:Destroy() end
         if obj:IsA("Trail") then obj:Destroy() end
         if obj:IsA("Smoke") then obj:Destroy() end
         if obj:IsA("Fire") then obj:Destroy() end
         if obj:IsA("Sparkles") then obj:Destroy() end
         if obj:IsA("MeshPart") then obj.TextureID = "" end
         if obj:IsA("Part") then obj.Material = Enum.Material.SmoothPlastic end
      end)
   end
   
   Lighting.GlobalShadows = false
   Lighting.FogEnd = 100000
   Lighting.Brightness = 0
   
   for _, effect in pairs(Lighting:GetChildren()) do
      if effect:IsA("PostEffect") then
         effect.Enabled = false
      end
   end
   
   settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
   
   print("✅ POTATO MODE activated!")
end

function RemoveTextures()
   print("\n🎨 Removing textures...")
   local removed = 0
   
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("Texture") then
            obj:Destroy()
            removed = removed + 1
         elseif obj:IsA("MeshPart") then
            obj.TextureID = ""
            removed = removed + 1
         elseif obj:IsA("Part") then
            obj.Material = Enum.Material.SmoothPlastic
         end
      end)
   end
   
   print("✅ Removed " .. removed .. " textures")
end

function RemoveParticles()
   print("\n✨ Removing particles...")
   local removed = 0
   
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or 
            obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj:Destroy()
            removed = removed + 1
         end
      end)
   end
   
   print("✅ Removed " .. removed .. " particle effects")
end

function RemoveShadows(enabled)
   if enabled then
      Lighting.GlobalShadows = false
      Lighting.Brightness = 2
      
      for _, obj in pairs(Workspace:GetDescendants()) do
         pcall(function()
            if obj:IsA("Part") or obj:IsA("MeshPart") then
               obj.CastShadow = false
            end
         end)
      end
      
      print("✅ Shadows removed")
   else
      Lighting.GlobalShadows = true
      Lighting.Brightness = 1
   end
end

function RemoveFog(enabled)
   if enabled then
      Lighting.FogEnd = 100000
      Lighting.FogStart = 0
      print("✅ Fog removed")
   else
      Lighting.FogEnd = 500
   end
end

function DisableLightingEffects(enabled)
   if enabled then
      for _, effect in pairs(Lighting:GetChildren()) do
         pcall(function()
            if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or 
               effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") or
               effect:IsA("DepthOfFieldEffect") then
               effect.Enabled = false
            end
         end)
      end
      print("✅ Lighting effects disabled")
   end
end

function ReducePhysicsSafe(enabled)
   if enabled then
      settings().Physics.AllowSleep = true
      settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.DefaultAuto
      
      for _, obj in pairs(Workspace:GetDescendants()) do
         pcall(function()
            if obj:IsA("BasePart") then
               obj.Massless = true
            end
         end)
      end
      
      print("✅ Physics quality reduced (collision preserved)")
   end
end

function ClearMemoryCache()
   print("\n🧹 Clearing memory cache...")
   
   for i = 1, 10 do
      wait()
      collectgarbage("collect")
   end
   
   print("✅ Memory cache cleared")
end

function RemoveUnusedAssets()
   print("\n🗑️ Removing unused assets...")
   local removed = 0
   
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("Sound") and not obj.IsPlaying then
            obj:Destroy()
            removed = removed + 1
         end
      end)
   end
   
   print("✅ Removed " .. removed .. " unused assets")
end

function OptimizeWorkspace()
   print("\n⚙️ Optimizing workspace...")
   
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("BasePart") then
            if obj.Transparency >= 0.98 then
               if obj.Material ~= Enum.Material.Air then
                  obj.Material = Enum.Material.SmoothPlastic
               end
            end
         end
      end)
   end
   
   print("✅ Workspace optimized (collision preserved)")
end

function FixPhysicsLag()
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("BasePart") then
            obj.Massless = true
         end
      end)
   end
   
   print("✅ Physics optimized")
end

function RemoveTerrainTextures(enabled)
   if enabled then
      pcall(function()
         Workspace.Terrain.Decoration = false
         Workspace.Terrain.WaterWaveSize = 0
         Workspace.Terrain.WaterWaveSpeed = 0
         Workspace.Terrain.WaterReflectance = 0
         Workspace.Terrain.WaterTransparency = 0
      end)
      print("✅ Terrain textures removed")
   end
end

function DisablePostProcessing(enabled)
   if enabled then
      for _, effect in pairs(Lighting:GetChildren()) do
         pcall(function()
            if effect:IsA("PostEffect") then
               effect.Enabled = false
            end
         end)
      end
      print("✅ Post-processing disabled")
   end
end

function DestroyAllVisuals()
   ApplyPotatoMode()
   RemoveTextures()
   RemoveParticles()
end

function RestoreDefaults()
   Lighting.GlobalShadows = true
   Lighting.FogEnd = 500
   Lighting.Brightness = 1
   
   for _, effect in pairs(Lighting:GetChildren()) do
      pcall(function()
         if effect:IsA("PostEffect") then
            effect.Enabled = true
         end
      end)
   end
   
   settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
   
   print("✅ Defaults restored")
end

function ShowPerformanceStats()
   local stats = game:GetService("Stats")
   
   print("\n" .. string.rep("=", 70))
   print("PERFORMANCE STATISTICS")
   print(string.rep("=", 70))
   print("FPS: " .. math.floor(1 / RunService.RenderStepped:Wait()))
   print("Memory: " .. math.floor(stats:GetTotalMemoryUsageMb()) .. " MB")
   print("Ping: " .. math.floor(player:GetNetworkPing()) .. " ms")
   print(string.rep("=", 70) .. "\n")
   
   Rayfield:Notify({
      Title = "Performance Stats",
      Content = "Check console (F9) for details!",
      Duration = 3,
      Image = 4483362458,
   })
end

function ShowFPSCounter(enabled)
   if enabled then
      local FPSGui = Instance.new("ScreenGui")
      FPSGui.Name = "FPSCounter"
      FPSGui.ResetOnSpawn = false
      FPSGui.Parent = player.PlayerGui
      
      local Frame = Instance.new("Frame")
      Frame.Size = UDim2.new(0, 100, 0, 60)
      Frame.Position = UDim2.new(1, -110, 0, 10)
      Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
      Frame.BorderSizePixel = 0
      Frame.Parent = FPSGui
      
      local Corner = Instance.new("UICorner")
      Corner.CornerRadius = UDim.new(0, 10)
      Corner.Parent = Frame
      
      local Label = Instance.new("TextLabel")
      Label.Size = UDim2.new(1, 0, 0, 20)
      Label.Position = UDim2.new(0, 0, 0, 5)
      Label.BackgroundTransparency = 1
      Label.Text = "FPS"
      Label.TextColor3 = Color3.fromRGB(180, 180, 190)
      Label.TextSize = 12
      Label.Font = Enum.Font.GothamBold
      Label.Parent = Frame
      
      local Value = Instance.new("TextLabel")
      Value.Size = UDim2.new(1, 0, 0, 30)
      Value.Position = UDim2.new(0, 0, 0, 25)
      Value.BackgroundTransparency = 1
      Value.Text = "60"
      Value.TextColor3 = Color3.fromRGB(87, 242, 135)
      Value.TextSize = 24
      Value.Font = Enum.Font.GothamBold
      Value.Parent = Frame
      
      task.spawn(function()
         while Value.Parent do
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            Value.Text = tostring(fps)
            
            if fps >= 60 then
               Value.TextColor3 = Color3.fromRGB(87, 242, 135)
            elseif fps >= 30 then
               Value.TextColor3 = Color3.fromRGB(254, 231, 92)
            else
               Value.TextColor3 = Color3.fromRGB(237, 66, 69)
            end
            
            wait(0.5)
         end
      end)
   else
      if player.PlayerGui:FindFirstChild("FPSCounter") then
         player.PlayerGui.FPSCounter:Destroy()
      end
   end
end

-- Load notification
Rayfield:Notify({
   Title = "FPS Optimizer Loaded!",
   Content = "Click 'Ultra FPS Boost' for best results! Mini button will appear when you close the UI.",
   Duration = 5,
   Image = 4483362458,
})

print("\n✅ RAYFIELD UI LOADED!")
print("🔘 Mini toggle button will appear when you close the UI!")
print("💡 Click the mini button to reopen UI anytime!")
print(string.rep("=", 70) .. "\n")
