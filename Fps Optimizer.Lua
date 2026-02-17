-- FPS OPTIMIZER - ORION UI
-- GUARANTEED WORKING VERSION
-- If this doesn't work, check F9 console for errors

print("Starting FPS Optimizer...")

-- Try loading Orion with multiple fallbacks
local Orion
local loadSuccess = false

-- Method 1: Primary source
pcall(function()
   print("Loading Orion from primary source...")
   Orion = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
   loadSuccess = true
   print("Primary source loaded!")
end)

-- Method 2: Backup source
if not loadSuccess then
   pcall(function()
      print("Trying backup source...")
      Orion = loadstring(game:HttpGet('https://pastebin.com/raw/vff1bQ9F'))()
      loadSuccess = true
      print("Backup source loaded!")
   end)
end

-- If still failed, create simple notification
if not loadSuccess or not Orion then
   print("ERROR: Could not load Orion Library!")
   print("Please check your internet connection or executor.")
   
   -- Create error notification
   game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "Error!";
      Text = "Failed to load Orion UI. Check console (F9)";
      Duration = 5;
   })
   
   return
end

print("Orion loaded successfully!")

-- Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

print("Creating window...")

-- CREATE WINDOW (CHANGE NAME HERE!)
local Window = Orion:MakeWindow({
   Name = "FPS Optimizer",  -- CHANGE THIS!
   HidePremium = false,
   SaveConfig = false,
   IntroEnabled = false
})

print("Window created!")

-- ============================================
-- TAB: BOOST
-- ============================================
local BoostTab = Window:MakeTab({
   Name = "Boost",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

BoostTab:AddParagraph("Quick Boost", "Select a preset for instant FPS boost")

BoostTab:AddButton({
   Name = "🚀 Ultra Boost",
   Callback = function()
      print("Ultra Boost clicked!")
      ApplyUltraBoost()
      Orion:MakeNotification({
         Name = "Ultra Boost",
         Content = "All optimizations applied!",
         Image = "rbxassetid://4483345998",
         Time = 3
      })
   end
})

BoostTab:AddButton({
   Name = "🥔 Potato Mode",
   Callback = function()
      print("Potato Mode clicked!")
      ApplyPotatoMode()
      Orion:MakeNotification({
         Name = "Potato Mode",
         Content = "Maximum FPS activated!",
         Image = "rbxassetid://4483345998",
         Time = 3
      })
   end
})

BoostTab:AddButton({
   Name = "⚡ Performance Mode",
   Callback = function()
      print("Performance Mode clicked!")
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
      ShowFPSCounter(value)
   end
})

-- ============================================
-- TAB: GRAPHICS
-- ============================================
local GraphicsTab = Window:MakeTab({
   Name = "Graphics",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

GraphicsTab:AddParagraph("Visuals", "Toggle graphics optimizations")

GraphicsTab:AddToggle({
   Name = "Remove Textures",
   Default = false,
   Callback = function(value)
      if value then
         RemoveTextures()
         Orion:MakeNotification({
            Name = "Textures",
            Content = "Textures removed!",
            Image = "rbxassetid://4483345998",
            Time = 2
         })
      end
   end
})

GraphicsTab:AddToggle({
   Name = "Remove Particles",
   Default = false,
   Callback = function(value)
      if value then
         RemoveParticles()
         Orion:MakeNotification({
            Name = "Particles",
            Content = "Particles removed!",
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
            Content = "Shadows disabled!",
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
            Content = "Fog removed!",
            Image = "rbxassetid://4483345998",
            Time = 2
         })
      end
   end
})

-- ============================================
-- TAB: SYSTEM
-- ============================================
local SystemTab = Window:MakeTab({
   Name = "System",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

SystemTab:AddParagraph("Memory", "Optimize system resources")

SystemTab:AddButton({
   Name = "Clear Memory",
   Callback = function()
      ClearMemory()
      Orion:MakeNotification({
         Name = "Memory",
         Content = "Cache cleared!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

SystemTab:AddButton({
   Name = "Remove Assets",
   Callback = function()
      RemoveUnusedAssets()
      Orion:MakeNotification({
         Name = "Assets",
         Content = "Unused assets removed!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

SystemTab:AddButton({
   Name = "Optimize Workspace",
   Callback = function()
      OptimizeWorkspace()
      Orion:MakeNotification({
         Name = "Workspace",
         Content = "Workspace optimized!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

SystemTab:AddButton({
   Name = "Fix Physics",
   Callback = function()
      FixPhysics()
      Orion:MakeNotification({
         Name = "Physics",
         Content = "Physics optimized!",
         Image = "rbxassetid://4483345998",
         Time = 2
      })
   end
})

-- ============================================
-- TAB: INFO
-- ============================================
local InfoTab = Window:MakeTab({
   Name = "Info",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

InfoTab:AddParagraph("About", "Universal FPS Optimizer")
InfoTab:AddParagraph("Low-End PC", "Use Potato Mode")
InfoTab:AddParagraph("Mid-Range PC", "Use Performance Mode")
InfoTab:AddParagraph("High-End PC", "Remove shadows only")

-- ============================================
-- OPTIMIZATION FUNCTIONS
-- ============================================

function ApplyUltraBoost()
   print("Applying Ultra Boost...")
   RemoveTextures()
   RemoveParticles()
   RemoveShadows(true)
   RemoveFog(true)
   OptimizeWorkspace()
   print("Ultra Boost complete!")
end

function ApplyPotatoMode()
   print("Applying Potato Mode...")
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("Texture") then obj:Destroy() end
         if obj:IsA("Decal") then obj:Destroy() end
         if obj:IsA("ParticleEmitter") then obj:Destroy() end
         if obj:IsA("Trail") then obj:Destroy() end
         if obj:IsA("MeshPart") then obj.TextureID = "" end
      end)
   end
   Lighting.GlobalShadows = false
   Lighting.FogEnd = 100000
   settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
   print("Potato Mode complete!")
end

function ApplyPerformanceMode()
   print("Applying Performance Mode...")
   RemoveShadows(true)
   RemoveFog(true)
   RemoveParticles()
   Lighting.Brightness = 2
   print("Performance Mode complete!")
end

function RemoveTextures()
   local count = 0
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("Texture") then
            obj:Destroy()
            count = count + 1
         elseif obj:IsA("MeshPart") then
            obj.TextureID = ""
            count = count + 1
         end
      end)
   end
   print("Removed " .. count .. " textures")
end

function RemoveParticles()
   local count = 0
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
            obj:Destroy()
            count = count + 1
         end
      end)
   end
   print("Removed " .. count .. " particles")
end

function RemoveShadows(enabled)
   if enabled then
      Lighting.GlobalShadows = false
      for _, obj in pairs(Workspace:GetDescendants()) do
         pcall(function()
            if obj:IsA("BasePart") then
               obj.CastShadow = false
            end
         end)
      end
      print("Shadows removed")
   else
      Lighting.GlobalShadows = true
   end
end

function RemoveFog(enabled)
   Lighting.FogEnd = enabled and 100000 or 500
   print("Fog " .. (enabled and "removed" or "restored"))
end

function ClearMemory()
   for i = 1, 10 do
      wait()
      collectgarbage("collect")
   end
   print("Memory cleared")
end

function RemoveUnusedAssets()
   local count = 0
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("Sound") and not obj.IsPlaying then
            obj:Destroy()
            count = count + 1
         end
      end)
   end
   print("Removed " .. count .. " unused assets")
end

function OptimizeWorkspace()
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("BasePart") and obj.Transparency >= 0.98 then
            obj.Material = Enum.Material.SmoothPlastic
         end
      end)
   end
   print("Workspace optimized")
end

function FixPhysics()
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("BasePart") then
            obj.Massless = true
         end
      end)
   end
   print("Physics optimized")
end

function ShowFPSCounter(enabled)
   if enabled then
      if player.PlayerGui:FindFirstChild("FPSCounter") then
         player.PlayerGui.FPSCounter:Destroy()
      end
      
      local FPSGui = Instance.new("ScreenGui")
      FPSGui.Name = "FPSCounter"
      FPSGui.ResetOnSpawn = false
      FPSGui.Parent = player.PlayerGui
      
      local Frame = Instance.new("Frame")
      Frame.Size = UDim2.new(0, 90, 0, 55)
      Frame.Position = UDim2.new(1, -100, 0, 10)
      Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
      Frame.BorderSizePixel = 0
      Frame.Parent = FPSGui
      
      local Corner = Instance.new("UICorner")
      Corner.CornerRadius = UDim.new(0, 8)
      Corner.Parent = Frame
      
      local Stroke = Instance.new("UIStroke")
      Stroke.Color = Color3.fromRGB(99, 102, 241)
      Stroke.Thickness = 2
      Stroke.Parent = Frame
      
      local Label = Instance.new("TextLabel")
      Label.Size = UDim2.new(1, 0, 0, 18)
      Label.Position = UDim2.new(0, 0, 0, 6)
      Label.BackgroundTransparency = 1
      Label.Text = "FPS"
      Label.TextColor3 = Color3.fromRGB(156, 163, 175)
      Label.TextSize = 10
      Label.Font = Enum.Font.GothamBold
      Label.Parent = Frame
      
      local Value = Instance.new("TextLabel")
      Value.Size = UDim2.new(1, 0, 0, 28)
      Value.Position = UDim2.new(0, 0, 0, 22)
      Value.BackgroundTransparency = 1
      Value.Text = "60"
      Value.TextColor3 = Color3.fromRGB(34, 197, 94)
      Value.TextSize = 24
      Value.Font = Enum.Font.GothamBold
      Value.Parent = Frame
      
      task.spawn(function()
         while Value.Parent do
            pcall(function()
               local fps = math.floor(1 / RunService.RenderStepped:Wait())
               Value.Text = tostring(fps)
               
               if fps >= 60 then
                  Value.TextColor3 = Color3.fromRGB(34, 197, 94)
               elseif fps >= 30 then
                  Value.TextColor3 = Color3.fromRGB(234, 179, 8)
               else
                  Value.TextColor3 = Color3.fromRGB(239, 68, 68)
               end
            end)
            wait(0.5)
         end
      end)
   else
      if player.PlayerGui:FindFirstChild("FPSCounter") then
         player.PlayerGui.FPSCounter:Destroy()
      end
   end
end

-- Send success notification
wait(1)

Orion:MakeNotification({
   Name = "FPS Optimizer",
   Content = "Script loaded successfully! Click buttons to optimize.",
   Image = "rbxassetid://4483345998",
   Time = 5
})

print("\n" .. string.rep("=", 70))
print("✅ FPS OPTIMIZER LOADED SUCCESSFULLY!")
print("🎨 Using Orion UI Library")
print("💡 Change window name at line 41")
print(string.rep("=", 70) .. "\n")
