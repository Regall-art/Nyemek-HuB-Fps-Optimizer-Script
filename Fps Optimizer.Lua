-- FLUX UI - RAYFIELD STYLE
-- Custom UI that looks exactly like Rayfield
-- With Rayfield animations and design

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

print("\n" .. string.rep("=", 70))
print("FLUX UI - RAYFIELD STYLE")
print("Custom UI with Rayfield Design")
print(string.rep("=", 70) .. "\n")

-- Rayfield Colors (Exact Match)
local RayfieldTheme = {
   Background = Color3.fromRGB(25, 25, 25),
   Topbar = Color3.fromRGB(30, 30, 30),
   TabBackground = Color3.fromRGB(20, 20, 20),
   ElementBackground = Color3.fromRGB(35, 35, 35),
   ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
   SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
   ElementStroke = Color3.fromRGB(50, 50, 50),
   SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
   SliderBackground = Color3.fromRGB(43, 105, 224),
   SliderProgress = Color3.fromRGB(43, 105, 224),
   SliderStroke = Color3.fromRGB(48, 119, 255),
   ToggleBackground = Color3.fromRGB(30, 30, 30),
   ToggleEnabled = Color3.fromRGB(0, 125, 255),
   ToggleDisabled = Color3.fromRGB(180, 180, 180),
   ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
   ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
   Divider = Color3.fromRGB(60, 60, 60),
   TextColor = Color3.fromRGB(240, 240, 240),
   TextDark = Color3.fromRGB(150, 150, 150)
}

-- Rayfield Animations (Exact Match)
local RayfieldAnimations = {
   Quart = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
   Quint = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
   Back = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
   Linear = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
}

local function Tween(obj, props, info)
   TweenService:Create(obj, info or RayfieldAnimations.Quart, props):Play()
end

local function MakeDraggable(frame, handle)
   local dragging, dragInput, dragStart, startPos
   handle = handle or frame
   
   handle.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 then
         dragging = true
         dragStart = input.Position
         startPos = frame.Position
         
         input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
               dragging = false
            end
         end)
      end
   end)
   
   UserInputService.InputChanged:Connect(function(input)
      if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
         local delta = input.Position - dragStart
         Tween(frame, {
            Position = UDim2.new(
               startPos.X.Scale,
               startPos.X.Offset + delta.X,
               startPos.Y.Scale,
               startPos.Y.Offset + delta.Y
            )
         }, RayfieldAnimations.Linear)
      end
   end)
end

-- Create Rayfield-style UI
local Rayfield = {}

function Rayfield:CreateWindow(config)
   local WindowName = config.Name or "Rayfield UI"
   
   -- ScreenGui
   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "RayfieldUI"
   ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   ScreenGui.ResetOnSpawn = false
   
   pcall(function()
      ScreenGui.Parent = CoreGui
   end)
   
   if ScreenGui.Parent ~= CoreGui then
      ScreenGui.Parent = player.PlayerGui
   end
   
   -- Main Frame
   local Main = Instance.new("Frame")
   Main.Name = "Main"
   Main.Size = UDim2.new(0, 0, 0, 0)
   Main.Position = UDim2.new(0.5, 0, 0.5, 0)
   Main.AnchorPoint = Vector2.new(0.5, 0.5)
   Main.BackgroundColor3 = RayfieldTheme.Background
   Main.BorderSizePixel = 0
   Main.ClipsDescendants = true
   Main.Parent = ScreenGui
   
   local MainCorner = Instance.new("UICorner")
   MainCorner.CornerRadius = UDim.new(0, 6)
   MainCorner.Parent = Main
   
   local MainStroke = Instance.new("UIStroke")
   MainStroke.Color = Color3.fromRGB(60, 60, 60)
   MainStroke.Thickness = 1
   MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
   MainStroke.Parent = Main
   
   -- Shadow
   local Shadow = Instance.new("ImageLabel")
   Shadow.Name = "Shadow"
   Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
   Shadow.BackgroundTransparency = 1
   Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
   Shadow.Size = UDim2.new(1, 47, 1, 47)
   Shadow.ZIndex = 0
   Shadow.Image = "rbxassetid://5554236805"
   Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
   Shadow.ImageTransparency = 0.5
   Shadow.ScaleType = Enum.ScaleType.Slice
   Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
   Shadow.Parent = Main
   
   -- Topbar
   local Topbar = Instance.new("Frame")
   Topbar.Name = "Topbar"
   Topbar.Size = UDim2.new(1, 0, 0, 42)
   Topbar.BackgroundColor3 = RayfieldTheme.Topbar
   Topbar.BorderSizePixel = 0
   Topbar.Parent = Main
   
   local TopbarCorner = Instance.new("UICorner")
   TopbarCorner.CornerRadius = UDim.new(0, 6)
   TopbarCorner.Parent = Topbar
   
   local TopbarCover = Instance.new("Frame")
   TopbarCover.Size = UDim2.new(1, 0, 0, 6)
   TopbarCover.Position = UDim2.new(0, 0, 1, -6)
   TopbarCover.BackgroundColor3 = RayfieldTheme.Topbar
   TopbarCover.BorderSizePixel = 0
   TopbarCover.Parent = Topbar
   
   -- Title
   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, -50, 1, 0)
   Title.Position = UDim2.new(0, 12, 0, 0)
   Title.BackgroundTransparency = 1
   Title.Text = WindowName
   Title.TextColor3 = RayfieldTheme.TextColor
   Title.TextSize = 15
   Title.Font = Enum.Font.GothamBold
   Title.TextXAlignment = Enum.TextXAlignment.Left
   Title.Parent = Topbar
   
   -- Close Button
   local CloseButton = Instance.new("ImageButton")
   CloseButton.Size = UDim2.new(0, 18, 0, 18)
   CloseButton.Position = UDim2.new(1, -30, 0.5, -9)
   CloseButton.BackgroundTransparency = 1
   CloseButton.Image = "rbxassetid://7733717447"
   CloseButton.ImageColor3 = RayfieldTheme.TextColor
   CloseButton.Parent = Topbar
   
   -- Tab Container
   local TabContainer = Instance.new("Frame")
   TabContainer.Name = "TabContainer"
   TabContainer.Size = UDim2.new(0, 155, 1, -52)
   TabContainer.Position = UDim2.new(0, 5, 0, 47)
   TabContainer.BackgroundColor3 = RayfieldTheme.TabBackground
   TabContainer.BorderSizePixel = 0
   TabContainer.Parent = Main
   
   local TabContainerCorner = Instance.new("UICorner")
   TabContainerCorner.CornerRadius = UDim.new(0, 6)
   TabContainerCorner.Parent = TabContainer
   
   local TabList = Instance.new("UIListLayout")
   TabList.Padding = UDim.new(0, 3)
   TabList.SortOrder = Enum.SortOrder.LayoutOrder
   TabList.Parent = TabContainer
   
   local TabPadding = Instance.new("UIPadding")
   TabPadding.PaddingTop = UDim.new(0, 5)
   TabPadding.PaddingLeft = UDim.new(0, 5)
   TabPadding.PaddingRight = UDim.new(0, 5)
   TabPadding.Parent = TabContainer
   
   -- Content Container
   local ContentContainer = Instance.new("Frame")
   ContentContainer.Name = "ContentContainer"
   ContentContainer.Size = UDim2.new(1, -170, 1, -52)
   ContentContainer.Position = UDim2.new(0, 165, 0, 47)
   ContentContainer.BackgroundTransparency = 1
   ContentContainer.Parent = Main
   
   -- Mini Button
   local MiniButton = Instance.new("TextButton")
   MiniButton.Name = "MiniButton"
   MiniButton.Size = UDim2.new(0, 50, 0, 50)
   MiniButton.Position = UDim2.new(1, -60, 0.95, -60)
   MiniButton.BackgroundColor3 = Color3.fromRGB(0, 125, 255)
   MiniButton.BorderSizePixel = 0
   MiniButton.Text = ""
   MiniButton.Visible = false
   MiniButton.AutoButtonColor = false
   MiniButton.Parent = ScreenGui
   
   local MiniCorner = Instance.new("UICorner")
   MiniCorner.CornerRadius = UDim.new(1, 0)
   MiniCorner.Parent = MiniButton
   
   local MiniStroke = Instance.new("UIStroke")
   MiniStroke.Color = Color3.fromRGB(0, 170, 255)
   MiniStroke.Thickness = 2
   MiniStroke.Parent = MiniButton
   
   local MiniIcon = Instance.new("TextLabel")
   MiniIcon.Size = UDim2.new(1, 0, 1, 0)
   MiniIcon.BackgroundTransparency = 1
   MiniIcon.Text = string.sub(WindowName, 1, 1)
   MiniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
   MiniIcon.TextSize = 20
   MiniIcon.Font = Enum.Font.GothamBold
   MiniIcon.Parent = MiniButton
   
   -- Close Button Functionality
   CloseButton.MouseButton1Click:Connect(function()
      Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, RayfieldAnimations.Back)
      task.wait(0.5)
      Main.Visible = false
      
      MiniButton.Visible = true
      MiniButton.Size = UDim2.new(0, 0, 0, 0)
      Tween(MiniButton, {Size = UDim2.new(0, 50, 0, 50)}, RayfieldAnimations.Back)
      
      task.spawn(function()
         while MiniButton.Visible do
            Tween(MiniButton, {Size = UDim2.new(0, 54, 0, 54)}, RayfieldAnimations.Quart)
            task.wait(1)
            Tween(MiniButton, {Size = UDim2.new(0, 50, 0, 50)}, RayfieldAnimations.Quart)
            task.wait(1)
         end
      end)
   end)
   
   -- Mini Button Click
   MiniButton.MouseButton1Click:Connect(function()
      Tween(MiniButton, {Size = UDim2.new(0, 0, 0, 0)}, RayfieldAnimations.Quart)
      task.wait(0.3)
      MiniButton.Visible = false
      
      Main.Visible = true
      Tween(Main, {Size = UDim2.new(0, 500, 0, 475)}, RayfieldAnimations.Back)
   end)
   
   -- Mini Button Hover
   MiniButton.MouseEnter:Connect(function()
      Tween(MiniButton, {BackgroundColor3 = Color3.fromRGB(0, 140, 255)}, RayfieldAnimations.Quart)
   end)
   
   MiniButton.MouseLeave:Connect(function()
      Tween(MiniButton, {BackgroundColor3 = Color3.fromRGB(0, 125, 255)}, RayfieldAnimations.Quart)
   end)
   
   -- Draggable
   MakeDraggable(Main, Topbar)
   MakeDraggable(MiniButton)
   
   -- Entrance Animation
   Tween(Main, {Size = UDim2.new(0, 500, 0, 475)}, RayfieldAnimations.Back)
   
   task.wait(0.6)
   Rayfield:Notify({
      Title = "Welcome!",
      Content = WindowName .. " has loaded successfully",
      Duration = 3
   })
   
   local Window = {
      Main = Main,
      ContentContainer = ContentContainer,
      TabContainer = TabContainer,
      Tabs = {},
      CurrentTab = nil
   }
   
   return Window
end

function Rayfield:CreateTab(Window, config)
   local TabName = config.Name or "Tab"
   local TabIcon = config.Icon or 4483362458
   
   -- Tab Button
   local TabButton = Instance.new("TextButton")
   TabButton.Name = TabName
   TabButton.Size = UDim2.new(1, 0, 0, 32)
   TabButton.BackgroundColor3 = RayfieldTheme.ElementBackground
   TabButton.BackgroundTransparency = 1
   TabButton.BorderSizePixel = 0
   TabButton.Text = ""
   TabButton.AutoButtonColor = false
   TabButton.Parent = Window.TabContainer
   
   local TabButtonCorner = Instance.new("UICorner")
   TabButtonCorner.CornerRadius = UDim.new(0, 5)
   TabButtonCorner.Parent = TabButton
   
   local TabIcon = Instance.new("ImageLabel")
   TabIcon.Size = UDim2.new(0, 20, 0, 20)
   TabIcon.Position = UDim2.new(0, 8, 0.5, -10)
   TabIcon.BackgroundTransparency = 1
   TabIcon.Image = "rbxassetid://" .. TabIcon
   TabIcon.ImageColor3 = RayfieldTheme.TextDark
   TabIcon.Parent = TabButton
   
   local TabTitle = Instance.new("TextLabel")
   TabTitle.Size = UDim2.new(1, -40, 1, 0)
   TabTitle.Position = UDim2.new(0, 35, 0, 0)
   TabTitle.BackgroundTransparency = 1
   TabTitle.Text = TabName
   TabTitle.TextColor3 = RayfieldTheme.TextDark
   TabTitle.TextSize = 13
   TabTitle.Font = Enum.Font.GothamMedium
   TabTitle.TextXAlignment = Enum.TextXAlignment.Left
   TabTitle.Parent = TabButton
   
   -- Tab Content
   local TabContent = Instance.new("ScrollingFrame")
   TabContent.Name = TabName .. "Content"
   TabContent.Size = UDim2.new(1, -10, 1, -10)
   TabContent.Position = UDim2.new(0, 5, 0, 5)
   TabContent.BackgroundTransparency = 1
   TabContent.BorderSizePixel = 0
   TabContent.ScrollBarThickness = 3
   TabContent.ScrollBarImageColor3 = Color3.fromRGB(0, 125, 255)
   TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
   TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
   TabContent.Visible = false
   TabContent.Parent = Window.ContentContainer
   
   local ContentList = Instance.new("UIListLayout")
   ContentList.Padding = UDim.new(0, 8)
   ContentList.SortOrder = Enum.SortOrder.LayoutOrder
   ContentList.Parent = TabContent
   
   local ContentPadding = Instance.new("UIPadding")
   ContentPadding.PaddingLeft = UDim.new(0, 5)
   ContentPadding.PaddingRight = UDim.new(0, 5)
   ContentPadding.PaddingTop = UDim.new(0, 5)
   ContentPadding.Parent = TabContent
   
   -- Select Tab Function
   local function SelectTab()
      for _, tab in pairs(Window.Tabs) do
         tab.Button.BackgroundTransparency = 1
         tab.Icon.ImageColor3 = RayfieldTheme.TextDark
         tab.Title.TextColor3 = RayfieldTheme.TextDark
         tab.Content.Visible = false
      end
      
      Tween(TabButton, {BackgroundTransparency = 0}, RayfieldAnimations.Quart)
      Tween(TabIcon, {ImageColor3 = Color3.fromRGB(0, 125, 255)}, RayfieldAnimations.Quart)
      Tween(TabTitle, {TextColor3 = RayfieldTheme.TextColor}, RayfieldAnimations.Quart)
      TabContent.Visible = true
      Window.CurrentTab = TabName
   end
   
   TabButton.MouseButton1Click:Connect(SelectTab)
   
   TabButton.MouseEnter:Connect(function()
      if Window.CurrentTab ~= TabName then
         Tween(TabButton, {BackgroundTransparency = 0.5}, RayfieldAnimations.Quart)
      end
   end)
   
   TabButton.MouseLeave:Connect(function()
      if Window.CurrentTab ~= TabName then
         Tween(TabButton, {BackgroundTransparency = 1}, RayfieldAnimations.Quart)
      end
   end)
   
   local Tab = {
      Button = TabButton,
      Icon = TabIcon,
      Title = TabTitle,
      Content = TabContent,
      Select = SelectTab
   }
   
   Window.Tabs[TabName] = Tab
   
   if not Window.CurrentTab then
      SelectTab()
   end
   
   return Tab
end

function Rayfield:CreateButton(Tab, config)
   local ButtonFrame = Instance.new("Frame")
   ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
   ButtonFrame.BackgroundColor3 = RayfieldTheme.ElementBackground
   ButtonFrame.BorderSizePixel = 0
   ButtonFrame.Parent = Tab.Content
   
   local ButtonCorner = Instance.new("UICorner")
   ButtonCorner.CornerRadius = UDim.new(0, 5)
   ButtonCorner.Parent = ButtonFrame
   
   local ButtonStroke = Instance.new("UIStroke")
   ButtonStroke.Color = RayfieldTheme.ElementStroke
   ButtonStroke.Thickness = 1
   ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
   ButtonStroke.Parent = ButtonFrame
   
   local Button = Instance.new("TextButton")
   Button.Size = UDim2.new(1, 0, 1, 0)
   Button.BackgroundTransparency = 1
   Button.Text = ""
   Button.Parent = ButtonFrame
   
   local ButtonTitle = Instance.new("TextLabel")
   ButtonTitle.Size = UDim2.new(1, -20, 1, 0)
   ButtonTitle.Position = UDim2.new(0, 10, 0, 0)
   ButtonTitle.BackgroundTransparency = 1
   ButtonTitle.Text = config.Name or "Button"
   ButtonTitle.TextColor3 = RayfieldTheme.TextColor
   ButtonTitle.TextSize = 13
   ButtonTitle.Font = Enum.Font.Gotham
   ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
   ButtonTitle.Parent = ButtonFrame
   
   Button.MouseEnter:Connect(function()
      Tween(ButtonFrame, {BackgroundColor3 = RayfieldTheme.ElementBackgroundHover}, RayfieldAnimations.Quart)
   end)
   
   Button.MouseLeave:Connect(function()
      Tween(ButtonFrame, {BackgroundColor3 = RayfieldTheme.ElementBackground}, RayfieldAnimations.Quart)
   end)
   
   Button.MouseButton1Click:Connect(function()
      local OriginalSize = ButtonFrame.Size
      Tween(ButtonFrame, {Size = UDim2.new(OriginalSize.X.Scale, OriginalSize.X.Offset, 0, 32)}, RayfieldAnimations.Quart)
      task.wait(0.1)
      Tween(ButtonFrame, {Size = OriginalSize}, RayfieldAnimations.Quart)
      
      if config.Callback then
         pcall(config.Callback)
      end
   end)
   
   return ButtonFrame
end

function Rayfield:CreateToggle(Tab, config)
   local ToggleFrame = Instance.new("Frame")
   ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
   ToggleFrame.BackgroundColor3 = RayfieldTheme.ElementBackground
   ToggleFrame.BorderSizePixel = 0
   ToggleFrame.Parent = Tab.Content
   
   local ToggleCorner = Instance.new("UICorner")
   ToggleCorner.CornerRadius = UDim.new(0, 5)
   ToggleCorner.Parent = ToggleFrame
   
   local ToggleStroke = Instance.new("UIStroke")
   ToggleStroke.Color = RayfieldTheme.ElementStroke
   ToggleStroke.Thickness = 1
   ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
   ToggleStroke.Parent = ToggleFrame
   
   local ToggleTitle = Instance.new("TextLabel")
   ToggleTitle.Size = UDim2.new(1, -60, 1, 0)
   ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
   ToggleTitle.BackgroundTransparency = 1
   ToggleTitle.Text = config.Name or "Toggle"
   ToggleTitle.TextColor3 = RayfieldTheme.TextColor
   ToggleTitle.TextSize = 13
   ToggleTitle.Font = Enum.Font.Gotham
   ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
   ToggleTitle.Parent = ToggleFrame
   
   local ToggleButton = Instance.new("TextButton")
   ToggleButton.Size = UDim2.new(0, 40, 0, 20)
   ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
   ToggleButton.BackgroundColor3 = RayfieldTheme.ToggleBackground
   ToggleButton.BorderSizePixel = 0
   ToggleButton.Text = ""
   ToggleButton.AutoButtonColor = false
   ToggleButton.Parent = ToggleFrame
   
   local ToggleButtonCorner = Instance.new("UICorner")
   ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
   ToggleButtonCorner.Parent = ToggleButton
   
   local ToggleButtonStroke = Instance.new("UIStroke")
   ToggleButtonStroke.Color = RayfieldTheme.ToggleDisabledStroke
   ToggleButtonStroke.Thickness = 1
   ToggleButtonStroke.Parent = ToggleButton
   
   local ToggleIndicator = Instance.new("Frame")
   ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
   ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
   ToggleIndicator.BackgroundColor3 = RayfieldTheme.ToggleDisabled
   ToggleIndicator.BorderSizePixel = 0
   ToggleIndicator.Parent = ToggleButton
   
   local IndicatorCorner = Instance.new("UICorner")
   IndicatorCorner.CornerRadius = UDim.new(1, 0)
   IndicatorCorner.Parent = ToggleIndicator
   
   local toggled = config.CurrentValue or false
   
   local function UpdateToggle()
      if toggled then
         Tween(ToggleIndicator, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = RayfieldTheme.ToggleEnabled}, RayfieldAnimations.Quart)
         Tween(ToggleButtonStroke, {Color = RayfieldTheme.ToggleEnabledStroke}, RayfieldAnimations.Quart)
      else
         Tween(ToggleIndicator, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = RayfieldTheme.ToggleDisabled}, RayfieldAnimations.Quart)
         Tween(ToggleButtonStroke, {Color = RayfieldTheme.ToggleDisabledStroke}, RayfieldAnimations.Quart)
      end
   end
   
   UpdateToggle()
   
   ToggleButton.MouseButton1Click:Connect(function()
      toggled = not toggled
      UpdateToggle()
      if config.Callback then
         pcall(config.Callback, toggled)
      end
   end)
   
   return ToggleFrame
end

function Rayfield:CreateParagraph(Tab, config)
   local ParagraphFrame = Instance.new("Frame")
   ParagraphFrame.Size = UDim2.new(1, 0, 0, 0)
   ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y
   ParagraphFrame.BackgroundColor3 = RayfieldTheme.ElementBackground
   ParagraphFrame.BorderSizePixel = 0
   ParagraphFrame.Parent = Tab.Content
   
   local ParagraphCorner = Instance.new("UICorner")
   ParagraphCorner.CornerRadius = UDim.new(0, 5)
   ParagraphCorner.Parent = ParagraphFrame
   
   local ParagraphStroke = Instance.new("UIStroke")
   ParagraphStroke.Color = RayfieldTheme.ElementStroke
   ParagraphStroke.Thickness = 1
   ParagraphStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
   ParagraphStroke.Parent = ParagraphFrame
   
   local ParagraphPadding = Instance.new("UIPadding")
   ParagraphPadding.PaddingTop = UDim.new(0, 10)
   ParagraphPadding.PaddingBottom = UDim.new(0, 10)
   ParagraphPadding.PaddingLeft = UDim.new(0, 10)
   ParagraphPadding.PaddingRight = UDim.new(0, 10)
   ParagraphPadding.Parent = ParagraphFrame
   
   local ParagraphTitle = Instance.new("TextLabel")
   ParagraphTitle.Size = UDim2.new(1, 0, 0, 16)
   ParagraphTitle.BackgroundTransparency = 1
   ParagraphTitle.Text = config.Title or "Paragraph"
   ParagraphTitle.TextColor3 = RayfieldTheme.TextColor
   ParagraphTitle.TextSize = 13
   ParagraphTitle.Font = Enum.Font.GothamBold
   ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
   ParagraphTitle.Parent = ParagraphFrame
   
   local ParagraphContent = Instance.new("TextLabel")
   ParagraphContent.Size = UDim2.new(1, 0, 0, 0)
   ParagraphContent.Position = UDim2.new(0, 0, 0, 20)
   ParagraphContent.AutomaticSize = Enum.AutomaticSize.Y
   ParagraphContent.BackgroundTransparency = 1
   ParagraphContent.Text = config.Content or "Content"
   ParagraphContent.TextColor3 = RayfieldTheme.TextDark
   ParagraphContent.TextSize = 12
   ParagraphContent.Font = Enum.Font.Gotham
   ParagraphContent.TextXAlignment = Enum.TextXAlignment.Left
   ParagraphContent.TextWrapped = true
   ParagraphContent.Parent = ParagraphFrame
   
   return ParagraphFrame
end

function Rayfield:Notify(config)
   local NotificationHolder = Instance.new("Frame")
   NotificationHolder.Size = UDim2.new(0, 300, 0, 75)
   NotificationHolder.Position = UDim2.new(1, 310, 1, -85)
   NotificationHolder.BackgroundColor3 = RayfieldTheme.ElementBackground
   NotificationHolder.BorderSizePixel = 0
   
   pcall(function()
      NotificationHolder.Parent = CoreGui:FindFirstChild("RayfieldUI")
   end)
   
   if not NotificationHolder.Parent then
      NotificationHolder.Parent = player.PlayerGui:FindFirstChild("RayfieldUI") or player.PlayerGui
   end
   
   local NotificationCorner = Instance.new("UICorner")
   NotificationCorner.CornerRadius = UDim.new(0, 6)
   NotificationCorner.Parent = NotificationHolder
   
   local NotificationStroke = Instance.new("UIStroke")
   NotificationStroke.Color = Color3.fromRGB(0, 125, 255)
   NotificationStroke.Thickness = 1
   NotificationStroke.Parent = NotificationHolder
   
   local NotificationTitle = Instance.new("TextLabel")
   NotificationTitle.Size = UDim2.new(1, -20, 0, 18)
   NotificationTitle.Position = UDim2.new(0, 10, 0, 10)
   NotificationTitle.BackgroundTransparency = 1
   NotificationTitle.Text = config.Title or "Notification"
   NotificationTitle.TextColor3 = RayfieldTheme.TextColor
   NotificationTitle.TextSize = 14
   NotificationTitle.Font = Enum.Font.GothamBold
   NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
   NotificationTitle.Parent = NotificationHolder
   
   local NotificationContent = Instance.new("TextLabel")
   NotificationContent.Size = UDim2.new(1, -20, 0, 37)
   NotificationContent.Position = UDim2.new(0, 10, 0, 33)
   NotificationContent.BackgroundTransparency = 1
   NotificationContent.Text = config.Content or "Content"
   NotificationContent.TextColor3 = RayfieldTheme.TextDark
   NotificationContent.TextSize = 12
   NotificationContent.Font = Enum.Font.Gotham
   NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
   NotificationContent.TextWrapped = true
   NotificationContent.Parent = NotificationHolder
   
   Tween(NotificationHolder, {Position = UDim2.new(1, -310, 1, -85)}, RayfieldAnimations.Quint)
   
   task.wait(config.Duration or 3)
   
   Tween(NotificationHolder, {Position = UDim2.new(1, 310, 1, -85)}, RayfieldAnimations.Quint)
   task.wait(0.3)
   NotificationHolder:Destroy()
end

-- ============================================
-- FPS OPTIMIZER
-- ============================================

-- CREATE WINDOW (CUSTOMIZE HERE!)
local Window = Rayfield:CreateWindow({
   Name = "FPS Optimizer Pro"  -- CHANGE THIS!
})

-- CREATE TABS
local BoostTab = Rayfield:CreateTab(Window, {
   Name = "Boost",
   Icon = 4483362458
})

local GraphicsTab = Rayfield:CreateTab(Window, {
   Name = "Graphics",
   Icon = 4483362458
})

local SystemTab = Rayfield:CreateTab(Window, {
   Name = "System",
   Icon = 4483362458
})

local InfoTab = Rayfield:CreateTab(Window, {
   Name = "Info",
   Icon = 4483362458
})

-- BOOST TAB
Rayfield:CreateParagraph(BoostTab, {
   Title = "Quick Boost Modes",
   Content = "Select a preset to instantly boost your FPS. All modes are collision-safe!"
})

Rayfield:CreateButton(BoostTab, {
   Name = "🚀 Ultra Boost",
   Callback = function()
      ApplyUltraBoost()
      Rayfield:Notify({
         Title = "Ultra Boost",
         Content = "All optimizations applied!",
         Duration = 3
      })
   end
})

Rayfield:CreateButton(BoostTab, {
   Name = "🥔 Potato Mode",
   Callback = function()
      ApplyPotatoMode()
      Rayfield:Notify({
         Title = "Potato Mode",
         Content = "Maximum FPS activated!",
         Duration = 3
      })
   end
})

Rayfield:CreateButton(BoostTab, {
   Name = "⚡ Performance Mode",
   Callback = function()
      ApplyPerformanceMode()
      Rayfield:Notify({
         Title = "Performance Mode",
         Content = "Balanced settings applied!",
         Duration = 3
      })
   end
})

Rayfield:CreateToggle(BoostTab, {
   Name = "Show FPS Counter",
   CurrentValue = false,
   Callback = function(value)
      ShowFPSCounter(value)
   end
})

-- GRAPHICS TAB
Rayfield:CreateParagraph(GraphicsTab, {
   Title = "Visual Optimization",
   Content = "Toggle individual graphics optimizations"
})

Rayfield:CreateToggle(GraphicsTab, {
   Name = "Remove Textures",
   CurrentValue = false,
   Callback = function(value)
      if value then
         RemoveTextures()
         Rayfield:Notify({Title = "Textures", Content = "Textures removed!", Duration = 2})
      end
   end
})

Rayfield:CreateToggle(GraphicsTab, {
   Name = "Remove Particles",
   CurrentValue = false,
   Callback = function(value)
      if value then
         RemoveParticles()
         Rayfield:Notify({Title = "Particles", Content = "Particles removed!", Duration = 2})
      end
   end
})

Rayfield:CreateToggle(GraphicsTab, {
   Name = "Remove Shadows",
   CurrentValue = false,
   Callback = function(value)
      RemoveShadows(value)
      if value then
         Rayfield:Notify({Title = "Shadows", Content = "Shadows disabled!", Duration = 2})
      end
   end
})

Rayfield:CreateToggle(GraphicsTab, {
   Name = "Remove Fog",
   CurrentValue = false,
   Callback = function(value)
      RemoveFog(value)
      if value then
         Rayfield:Notify({Title = "Fog", Content = "Fog removed!", Duration = 2})
      end
   end
})

-- SYSTEM TAB
Rayfield:CreateParagraph(SystemTab, {
   Title = "Memory & Performance",
   Content = "Optimize system resources"
})

Rayfield:CreateButton(SystemTab, {
   Name = "Clear Memory",
   Callback = function()
      ClearMemory()
      Rayfield:Notify({Title = "Memory", Content = "Cache cleared!", Duration = 2})
   end
})

Rayfield:CreateButton(SystemTab, {
   Name = "Remove Unused Assets",
   Callback = function()
      RemoveUnusedAssets()
      Rayfield:Notify({Title = "Assets", Content = "Assets removed!", Duration = 2})
   end
})

Rayfield:CreateButton(SystemTab, {
   Name = "Optimize Workspace",
   Callback = function()
      OptimizeWorkspace()
      Rayfield:Notify({Title = "Workspace", Content = "Workspace optimized!", Duration = 2})
   end
})

Rayfield:CreateButton(SystemTab, {
   Name = "Fix Physics",
   Callback = function()
      FixPhysics()
      Rayfield:Notify({Title = "Physics", Content = "Physics optimized!", Duration = 2})
   end
})

-- INFO TAB
Rayfield:CreateParagraph(InfoTab, {
   Title = "FPS Optimizer",
   Content = "Universal FPS optimization tool for all Roblox games"
})

Rayfield:CreateParagraph(InfoTab, {
   Title = "Low-End PC",
   Content = "Use Potato Mode for maximum FPS boost"
})

Rayfield:CreateParagraph(InfoTab, {
   Title = "Mid-Range PC",
   Content = "Use Performance Mode for balanced quality"
})

Rayfield:CreateParagraph(InfoTab, {
   Title = "High-End PC",
   Content = "Remove shadows only to maintain visuals"
})

-- OPTIMIZATION FUNCTIONS
function ApplyUltraBoost()
   print("⚡ Ultra Boost")
   RemoveTextures()
   RemoveParticles()
   RemoveShadows(true)
   RemoveFog(true)
   OptimizeWorkspace()
   print("✅ Complete!")
end

function ApplyPotatoMode()
   print("🥔 Potato Mode")
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
   print("✅ Complete!")
end

function ApplyPerformanceMode()
   print("⚡ Performance Mode")
   RemoveShadows(true)
   RemoveFog(true)
   RemoveParticles()
   Lighting.Brightness = 2
   print("✅ Complete!")
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
   print("✅ Removed " .. count .. " textures")
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
   print("✅ Removed " .. count .. " particles")
end

function RemoveShadows(enabled)
   if enabled then
      Lighting.GlobalShadows = false
      for _, obj in pairs(Workspace:GetDescendants()) do
         pcall(function()
            if obj:IsA("BasePart") then obj.CastShadow = false end
         end)
      end
      print("✅ Shadows removed")
   else
      Lighting.GlobalShadows = true
   end
end

function RemoveFog(enabled)
   Lighting.FogEnd = enabled and 100000 or 500
   print("✅ Fog " .. (enabled and "removed" or "restored"))
end

function ClearMemory()
   for i = 1, 10 do
      wait()
      collectgarbage("collect")
   end
   print("✅ Memory cleared")
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
   print("✅ Removed " .. count .. " assets")
end

function OptimizeWorkspace()
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("BasePart") and obj.Transparency >= 0.98 then
            obj.Material = Enum.Material.SmoothPlastic
         end
      end)
   end
   print("✅ Workspace optimized")
end

function FixPhysics()
   for _, obj in pairs(Workspace:GetDescendants()) do
      pcall(function()
         if obj:IsA("BasePart") then obj.Massless = true end
      end)
   end
   print("✅ Physics optimized")
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
      Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
      Frame.BorderSizePixel = 0
      Frame.Parent = FPSGui
      
      local Corner = Instance.new("UICorner")
      Corner.CornerRadius = UDim.new(0, 6)
      Corner.Parent = Frame
      
      local Stroke = Instance.new("UIStroke")
      Stroke.Color = Color3.fromRGB(0, 125, 255)
      Stroke.Thickness = 1
      Stroke.Parent = Frame
      
      local Label = Instance.new("TextLabel")
      Label.Size = UDim2.new(1, 0, 0, 18)
      Label.Position = UDim2.new(0, 0, 0, 6)
      Label.BackgroundTransparency = 1
      Label.Text = "FPS"
      Label.TextColor3 = Color3.fromRGB(150, 150, 150)
      Label.TextSize = 10
      Label.Font = Enum.Font.GothamBold
      Label.Parent = Frame
      
      local Value = Instance.new("TextLabel")
      Value.Size = UDim2.new(1, 0, 0, 28)
      Value.Position = UDim2.new(0, 0, 0, 22)
      Value.BackgroundTransparency = 1
      Value.Text = "60"
      Value.TextColor3 = Color3.fromRGB(0, 200, 255)
      Value.TextSize = 24
      Value.Font = Enum.Font.GothamBold
      Value.Parent = Frame
      
      task.spawn(function()
         while Value.Parent do
            pcall(function()
               local fps = math.floor(1 / RunService.RenderStepped:Wait())
               Value.Text = tostring(fps)
               
               if fps >= 60 then
                  Value.TextColor3 = Color3.fromRGB(0, 200, 255)
               elseif fps >= 30 then
                  Value.TextColor3 = Color3.fromRGB(255, 200, 0)
               else
                  Value.TextColor3 = Color3.fromRGB(255, 50, 50)
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

print("\n✅ FLUX UI - RAYFIELD STYLE LOADED!")
print("🎨 Design & Animations from Rayfield")
print("💡 Change name at line 486")
print(string.rep("=", 70) .. "\n")
