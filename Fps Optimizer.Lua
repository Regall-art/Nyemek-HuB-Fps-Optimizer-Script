-- FPS OPTIMIZER - ORION UI
-- Using Orion Library
-- Modern & Clean Design

local Orion = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

print("\n" .. string.rep("=", 70))
print("FPS OPTIMIZER - ORION UI")
print("Modern Interface with Smooth Animations")
print(string.rep("=", 70) .. "\n")

-- Settings
local Settings = {
   ShowFPS = false,
}

-- CREATE WINDOW (CUSTOMIZE HERE!)
local Window = Orion:MakeWindow({
   Name = "FPS Optimizer Pro",           -- CHANGE THIS!
   HidePremium = false,
   SaveConfig = true,
   ConfigFolder = "FPSOptimizer",
   IntroEnabled = true,
   IntroText = "FPS Optimizer",
   IntroIcon = "rbxassetid://4483345998",
   Icon = "rbxassetid://4483345998"
})

-- ============================================
-- TAB: BOOST
-- ============================================
local BoostTab = Window:MakeTab({
   Name = "⚡ Boost",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

BoostTab:AddParagraph("Quick Boost Modes", "Select a preset to instantly boost your FPS. All modes are collision-safe!")

BoostTab:AddButton({
   Name = "🚀 Ultra Boost (Recommended)",
   Callback = function()
      ApplyUltraBoost()
      Orion:MakeNotification({
         Name = "Ultra Boost",
         Content = "All optimizations applied successfully!",
         Image = "rbxassetid://4483345998",
         Time = 3
      })
   end
})

BoostTab:AddButton({
   Name = "🥔 Potato Mode (Low-End PC)",
   Callback = function()
      ApplyPotatoMode()
      Orion:MakeNotification({
         Name = "Potato Mode",
         Content = "Maximum FPS mode activated!",
         Image = "rbxassetid://4483345998",
         Time = 3
      })
   end
})

BoostTab:AddButton({
   Name = "⚡ Performance Mode (Balanced)",
   Callback = function()
      ApplyPerformanceMode()
      Orion:MakeNotification({
         Name = "Performance Mode",
         Content = "Balanced settings applied!",
         Image = "rbxassetid://4483345998",
         Time = 3
      })
   end
})

BoostTab:AddToggle({
   Name = "Show FPS Counter",
   Default = false,
   Callback = function(value)
      Settings.ShowFPS = value
      ShowFPSCounter(value)
   end
})

-- ============================================
-- TAB: GRAPHICS
-- ============================================
local GraphicsTab = Window:MakeTab({
   Name = "🎨 Graphics",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

GraphicsTab:AddParagraph("Visual Optimization", "Toggle individual graphics optimizations")

GraphicsTab:AddToggle({
   Name = "Remove Textures",
   Default = false,
   Callback = function(value)
      if value then
         RemoveTextures()
         Orion:MakeNotification({
            Name = "Textures",
            Content = "All textures have been removed!",
            Image = "rbxassetid://4483345998",
            Time = 2
         })
      end
   end
})

GraphicsTab:AddToggle({
   Name = "Remove Particles & Effects",
   Default = false,
   Callback = function(value)
      if value then
         RemoveParticles()
         Orion:MakeNotification({
            Name = "Particles",
            Content = "All particle effects removed!",
            Image = "rbxassetid://4483345998",
            Time = 2
         })
      end
   end
})

GraphicsTab:AddToggle({
   Name = "Remove Shadows",
   Default = false,
   Callback = function(value)
      RemoveShadows(value)
      if value then
         Orion:MakeNotification({
            Name = "Shadows",
            Content = "Shadows have been disabled!",
            Image = "rbxassetid://4483345998",
            Time = 2
         })
      end
   end
})

GraphicsTab:AddToggle({
   Name = "Remove Fog",
   Default = false,
   Callback = function(value)
      RemoveFog(value)
      if value then
         Orion:MakeNotification({
            Name = "Fog",
            Content = "Distance fog removed!",
            Image = "rbxassetid://4483345998",
            Time = 2
         })
      end
   end
})

GraphicsTab:AddToggle({
   Name = "Disable Blur & Color Effects",
   Default = false,
   Callback = function(value)
      DisableLightingEffects(value)
   end
})

-- ============================================
-- TAB: SYSTEM
-- ============================================
local SystemTab = Window:MakeTab({
   Name = "🛠️ System",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

SystemTab:AddParagraph("Memory Optimization", "Clean up memory and optimize system resources")

SystemTab:AddButton({
   Name = "🧹 Clear Memory Cache",
   Callback = function()
      ClearMemory()
      Orion:MakeNotification({
         Name = "Memory Cleared",
         Content = "Memory cache has been cleared!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

SystemTab:AddButton({
   Name = "🗑️ Remove Unused Assets",
   Callback = function()
      RemoveUnusedAssets()
      Orion:MakeNotification({
         Name = "Assets Removed",
         Content = "Unused assets have been removed!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

SystemTab:AddButton({
   Name = "⚙️ Optimize Workspace",
   Callback = function()
      OptimizeWorkspace()
      Orion:MakeNotification({
         Name = "Workspace Optimized",
         Content = "Workspace has been optimized!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

SystemTab:AddParagraph("Physics Optimization", "Optimize physics calculations")

SystemTab:AddToggle({
   Name = "Reduce Physics Quality",
   Default = false,
   Callback = function(value)
      ReducePhysicsSafe(value)
   end
})

SystemTab:AddButton({
   Name = "🔧 Fix Physics Lag",
   Callback = function()
      FixPhysics()
      Orion:MakeNotification({
         Name = "Physics Fixed",
         Content = "Physics lag has been reduced!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

-- ============================================
-- TAB: ADVANCED
-- ============================================
local AdvancedTab = Window:MakeTab({
   Name = "⚙️ Advanced",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

AdvancedTab:AddParagraph("Advanced Options", "Advanced optimization settings")

AdvancedTab:AddToggle({
   Name = "Remove Terrain Textures",
   Default = false,
   Callback = function(value)
      RemoveTerrainTextures(value)
   end
})

AdvancedTab:AddToggle({
   Name = "Disable Post-Processing",
   Default = false,
   Callback = function(value)
      DisablePostProcessing(value)
   end
})

AdvancedTab:AddButton({
   Name = "⚠️ DESTROY ALL VISUALS (MAX FPS)",
   Callback = function()
      DestroyAllVisuals()
      Orion:MakeNotification({
         Name = "Maximum Optimization",
         Content = "All visuals destroyed! Max FPS mode!",
         Image = "rbxassetid://4483345998",
         Time = 3
      })
   end
})

AdvancedTab:AddButton({
   Name = "↩️ Restore Default Settings",
   Callback = function()
      RestoreDefaults()
      Orion:MakeNotification({
         Name = "Defaults Restored",
         Content = "All settings restored to default!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

-- ============================================
-- TAB: INFO
-- ============================================
local InfoTab = Window:MakeTab({
   Name = "ℹ️ Info",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

InfoTab:AddParagraph("About This Script", "Universal FPS Optimizer for all Roblox games. Boost FPS, reduce lag, and optimize performance!")

InfoTab:AddParagraph("🎮 Low-End PC", "Recommended: Ultra FPS Boost + Potato Mode. Remove all textures and particles.")

InfoTab:AddParagraph("💻 Mid-Range PC", "Recommended: Performance Mode. Remove shadows and fog only.")

InfoTab:AddParagraph("🖥️ High-End PC", "Recommended: Remove shadows only to maintain visual quality while boosting FPS.")

InfoTab:AddButton({
   Name = "📈 Show Performance Stats",
   Callback = function()
      ShowPerformanceStats()
   end
})

-- ============================================
-- OPTIMIZATION FUNCTIONS
-- ============================================

function ApplyUltraBoost()
   print("\n⚡ ULTRA FPS BOOST")
   RemoveTextures()
   RemoveParticles()
   RemoveShadows(true)
   RemoveFog(true)
   DisableLightingEffects(true)
   ReducePhysicsSafe(true)
   RemoveTerrainTextures(true)
   DisablePostProcessing(true)
   OptimizeWorkspace()
   print("✅ All optimizations complete!")
end

function ApplyPotatoMode()
   print("\n🥔 POTATO MODE")
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

function ApplyPerformanceMode()
   print("\n⚡ PERFORMANCE MODE")
   RemoveShadows(true)
   RemoveFog(true)
   RemoveParticles()
   DisableLightingEffects(true)
   Lighting.Brightness = 2
   print("✅ Performance mode complete!")
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

function ClearMemory()
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

function FixPhysics()
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
   
   Orion:MakeNotification({
      Name = "Performance Stats",
      Content = "Check console (F9) for details!",
      Image = "rbxassetid://4483345998",
      Time = 3
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
      
      local Stroke = Instance.new("UIStroke")
      Stroke.Color = Color3.fromRGB(99, 102, 241)
      Stroke.Thickness = 2
      Stroke.Parent = Frame
      
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

-- Initialize Orion
Orion:Init()

print("\n✅ FPS OPTIMIZER LOADED!")
print("🎨 Using Orion UI Library")
print("💡 Change name at line 22!")
print(string.rep("=", 70) .. "\n")
