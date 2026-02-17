-- ============================================
-- FLUX UI LIBRARY + FPS OPTIMIZER
-- All-in-One Script
-- Fully Customizable UI
-- ============================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

print("\n" .. string.rep("=", 70))
print("FLUX UI - FPS OPTIMIZER")
print("Custom UI with Natural Design")
print(string.rep("=", 70) .. "\n")

-- ============================================
-- FLUX UI LIBRARY
-- ============================================

local Flux = {}
Flux.__index = Flux

-- Theme
local DefaultTheme = {
   MainBg = Color3.fromRGB(18, 18, 22),
   SidebarBg = Color3.fromRGB(24, 24, 28),
   ElementBg = Color3.fromRGB(32, 32, 38),
   HoverBg = Color3.fromRGB(40, 40, 46),
   Accent = Color3.fromRGB(124, 58, 237),
   AccentHover = Color3.fromRGB(139, 92, 246),
   Success = Color3.fromRGB(34, 197, 94),
   Warning = Color3.fromRGB(234, 179, 8),
   Error = Color3.fromRGB(239, 68, 68),
   TextPrimary = Color3.fromRGB(248, 248, 252),
   TextSecondary = Color3.fromRGB(161, 161, 170),
   TextMuted = Color3.fromRGB(113, 113, 122),
}

-- Animation Presets
local Animations = {
   Fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
   Normal = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
   Smooth = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
   Bounce = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
}

-- Utility Functions
local function Tween(obj, props, info)
   return TweenService:Create(obj, info or Animations.Normal, props):Play()
end

local function AddCorner(parent, radius)
   local corner = Instance.new("UICorner")
   corner.CornerRadius = UDim.new(0, radius or 8)
   corner.Parent = parent
   return corner
end

local function AddStroke(parent, color, thickness)
   local stroke = Instance.new("UIStroke")
   stroke.Color = color or Color3.fromRGB(60, 60, 66)
   stroke.Thickness = thickness or 1
   stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
   stroke.Parent = parent
   return stroke
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
   
   handle.InputChanged:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseMovement then
         dragInput = input
      end
   end)
   
   UserInputService.InputChanged:Connect(function(input)
      if input == dragInput and dragging then
         local delta = input.Position - dragStart
         frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
         )
      end
   end)
end

-- Create Window
function Flux:Window(config)
   local self = setmetatable({}, Flux)
   
   self.Name = config.Name or "Flux UI"
   self.Subtitle = config.Subtitle or "by user"
   self.Theme = config.Theme or DefaultTheme
   self.Size = config.Size or {480, 560}
   
   -- ScreenGui
   self.Gui = Instance.new("ScreenGui")
   self.Gui.Name = "FluxUI"
   self.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   self.Gui.ResetOnSpawn = false
   self.Gui.IgnoreGuiInset = true
   self.Gui.Parent = player.PlayerGui
   
   -- Container
   self.Container = Instance.new("Frame")
   self.Container.Size = UDim2.new(0, 0, 0, 0)
   self.Container.Position = UDim2.new(0.5, 0, 0.5, 0)
   self.Container.AnchorPoint = Vector2.new(0.5, 0.5)
   self.Container.BackgroundTransparency = 1
   self.Container.Parent = self.Gui
   
   -- Shadow
   self.Shadow = Instance.new("ImageLabel")
   self.Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
   self.Shadow.BackgroundTransparency = 1
   self.Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
   self.Shadow.Size = UDim2.new(1, 30, 1, 30)
   self.Shadow.ZIndex = 0
   self.Shadow.Image = "rbxassetid://5554236805"
   self.Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
   self.Shadow.ImageTransparency = 0.7
   self.Shadow.ScaleType = Enum.ScaleType.Slice
   self.Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
   self.Shadow.Parent = self.Container
   
   -- Main Frame
   self.Main = Instance.new("Frame")
   self.Main.Size = UDim2.new(1, 0, 1, 0)
   self.Main.BackgroundColor3 = self.Theme.MainBg
   self.Main.BorderSizePixel = 0
   self.Main.ClipsDescendants = true
   self.Main.Parent = self.Container
   AddCorner(self.Main, 10)
   
   -- Sidebar
   self.Sidebar = Instance.new("Frame")
   self.Sidebar.Size = UDim2.new(0, 200, 1, 0)
   self.Sidebar.BackgroundColor3 = self.Theme.SidebarBg
   self.Sidebar.BorderSizePixel = 0
   self.Sidebar.Parent = self.Main
   AddCorner(self.Sidebar, 10)
   
   local SidebarCover = Instance.new("Frame")
   SidebarCover.Size = UDim2.new(0, 10, 1, 0)
   SidebarCover.Position = UDim2.new(1, -10, 0, 0)
   SidebarCover.BackgroundColor3 = self.Theme.SidebarBg
   SidebarCover.BorderSizePixel = 0
   SidebarCover.Parent = self.Sidebar
   
   -- Header
   local Header = Instance.new("Frame")
   Header.Size = UDim2.new(1, 0, 0, 65)
   Header.BackgroundTransparency = 1
   Header.Parent = self.Sidebar
   
   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, -30, 0, 24)
   Title.Position = UDim2.new(0, 20, 0, 18)
   Title.BackgroundTransparency = 1
   Title.Text = self.Name
   Title.TextColor3 = self.Theme.TextPrimary
   Title.TextSize = 18
   Title.Font = Enum.Font.GothamBold
   Title.TextXAlignment = Enum.TextXAlignment.Left
   Title.Parent = Header
   
   local Subtitle = Instance.new("TextLabel")
   Subtitle.Size = UDim2.new(1, -30, 0, 16)
   Subtitle.Position = UDim2.new(0, 20, 0, 42)
   Subtitle.BackgroundTransparency = 1
   Subtitle.Text = self.Subtitle
   Subtitle.TextColor3 = self.Theme.TextSecondary
   Subtitle.TextSize = 12
   Subtitle.Font = Enum.Font.Gotham
   Subtitle.TextXAlignment = Enum.TextXAlignment.Left
   Subtitle.Parent = Header
   
   -- Divider
   local Divider = Instance.new("Frame")
   Divider.Size = UDim2.new(1, -30, 0, 1)
   Divider.Position = UDim2.new(0, 15, 0, 65)
   Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
   Divider.BorderSizePixel = 0
   Divider.Parent = self.Sidebar
   
   -- Tabs Container
   self.TabsContainer = Instance.new("ScrollingFrame")
   self.TabsContainer.Size = UDim2.new(1, 0, 1, -75)
   self.TabsContainer.Position = UDim2.new(0, 0, 0, 70)
   self.TabsContainer.BackgroundTransparency = 1
   self.TabsContainer.BorderSizePixel = 0
   self.TabsContainer.ScrollBarThickness = 3
   self.TabsContainer.ScrollBarImageColor3 = self.Theme.Accent
   self.TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
   self.TabsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
   self.TabsContainer.Parent = self.Sidebar
   
   local TabsList = Instance.new("UIListLayout")
   TabsList.Padding = UDim.new(0, 6)
   TabsList.Parent = self.TabsContainer
   
   local TabsPadding = Instance.new("UIPadding")
   TabsPadding.PaddingLeft = UDim.new(0, 12)
   TabsPadding.PaddingRight = UDim.new(0, 12)
   TabsPadding.PaddingTop = UDim.new(0, 8)
   TabsPadding.Parent = self.TabsContainer
   
   -- Content Area
   self.Content = Instance.new("Frame")
   self.Content.Size = UDim2.new(1, -210, 1, -10)
   self.Content.Position = UDim2.new(0, 205, 0, 5)
   self.Content.BackgroundTransparency = 1
   self.Content.Parent = self.Main
   
   -- Controls
   local Controls = Instance.new("Frame")
   Controls.Size = UDim2.new(0, 80, 0, 32)
   Controls.Position = UDim2.new(1, -90, 0, 8)
   Controls.BackgroundTransparency = 1
   Controls.Parent = self.Content
   
   local ControlsList = Instance.new("UIListLayout")
   ControlsList.FillDirection = Enum.FillDirection.Horizontal
   ControlsList.HorizontalAlignment = Enum.HorizontalAlignment.Right
   ControlsList.Padding = UDim.new(0, 6)
   ControlsList.Parent = Controls
   
   -- Minimize
   local MinBtn = Instance.new("TextButton")
   MinBtn.Size = UDim2.new(0, 32, 0, 32)
   MinBtn.BackgroundColor3 = self.Theme.ElementBg
   MinBtn.BorderSizePixel = 0
   MinBtn.Text = ""
   MinBtn.AutoButtonColor = false
   MinBtn.Parent = Controls
   AddCorner(MinBtn, 6)
   
   local MinIcon = Instance.new("TextLabel")
   MinIcon.Size = UDim2.new(1, 0, 1, 0)
   MinIcon.BackgroundTransparency = 1
   MinIcon.Text = "—"
   MinIcon.TextColor3 = self.Theme.TextSecondary
   MinIcon.TextSize = 16
   MinIcon.Font = Enum.Font.GothamBold
   MinIcon.Parent = MinBtn
   
   -- Close
   local CloseBtn = Instance.new("TextButton")
   CloseBtn.Size = UDim2.new(0, 32, 0, 32)
   CloseBtn.BackgroundColor3 = self.Theme.Error
   CloseBtn.BorderSizePixel = 0
   CloseBtn.Text = ""
   CloseBtn.AutoButtonColor = false
   CloseBtn.Parent = Controls
   AddCorner(CloseBtn, 6)
   
   local CloseIcon = Instance.new("TextLabel")
   CloseIcon.Size = UDim2.new(1, 0, 1, 0)
   CloseIcon.BackgroundTransparency = 1
   CloseIcon.Text = "×"
   CloseIcon.TextColor3 = self.Theme.TextPrimary
   CloseIcon.TextSize = 20
   CloseIcon.Font = Enum.Font.GothamBold
   CloseIcon.Parent = CloseBtn
   
   -- Mini Button
   self.MiniBtn = Instance.new("TextButton")
   self.MiniBtn.Size = UDim2.new(0, 56, 0, 56)
   self.MiniBtn.Position = UDim2.new(1, -66, 0.5, -28)
   self.MiniBtn.BackgroundColor3 = self.Theme.Accent
   self.MiniBtn.BorderSizePixel = 0
   self.MiniBtn.Text = ""
   self.MiniBtn.Visible = false
   self.MiniBtn.AutoButtonColor = false
   self.MiniBtn.Parent = self.Gui
   AddCorner(self.MiniBtn, 28)
   
   local MiniGlow = Instance.new("UIGradient")
   MiniGlow.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, self.Theme.Accent),
      ColorSequenceKeypoint.new(1, self.Theme.AccentHover)
   })
   MiniGlow.Rotation = 45
   MiniGlow.Parent = self.MiniBtn
   
   local MiniText = Instance.new("TextLabel")
   MiniText.Size = UDim2.new(1, 0, 1, 0)
   MiniText.BackgroundTransparency = 1
   MiniText.Text = string.sub(self.Name, 1, 1)
   MiniText.TextColor3 = self.Theme.TextPrimary
   MiniText.TextSize = 24
   MiniText.Font = Enum.Font.GothamBold
   MiniText.Parent = self.MiniBtn
   
   -- Button Hovers
   for _, btn in pairs({MinBtn, CloseBtn}) do
      btn.MouseEnter:Connect(function()
         Tween(btn, {BackgroundColor3 = btn == CloseBtn and Color3.fromRGB(220, 38, 38) or self.Theme.HoverBg}, Animations.Fast)
      end)
      btn.MouseLeave:Connect(function()
         Tween(btn, {BackgroundColor3 = btn == CloseBtn and self.Theme.Error or self.Theme.ElementBg}, Animations.Fast)
      end)
   end
   
   -- Minimize Func
   local minimized = false
   MinBtn.MouseButton1Click:Connect(function()
      minimized = not minimized
      if minimized then
         Tween(self.Container, {Size = UDim2.new(0, self.Size[1], 0, 65)}, Animations.Smooth)
         self.Sidebar.Visible = false
         self.Content.Visible = false
      else
         Tween(self.Container, {Size = UDim2.new(0, self.Size[1], 0, self.Size[2])}, Animations.Smooth)
         self.Sidebar.Visible = true
         self.Content.Visible = true
      end
   end)
   
   -- Close Func
   CloseBtn.MouseButton1Click:Connect(function()
      Tween(self.Container, {Size = UDim2.new(0, 0, 0, 0)}, Animations.Bounce)
      task.wait(0.5)
      self.Container.Visible = false
      
      self.MiniBtn.Visible = true
      self.MiniBtn.Size = UDim2.new(0, 0, 0, 0)
      Tween(self.MiniBtn, {Size = UDim2.new(0, 56, 0, 56)}, Animations.Bounce)
      
      task.spawn(function()
         while self.MiniBtn.Visible do
            Tween(self.MiniBtn, {Size = UDim2.new(0, 60, 0, 60)}, Animations.Smooth)
            task.wait(1)
            Tween(self.MiniBtn, {Size = UDim2.new(0, 56, 0, 56)}, Animations.Smooth)
            task.wait(1)
         end
      end)
   end)
   
   -- Mini Click
   self.MiniBtn.MouseButton1Click:Connect(function()
      Tween(self.MiniBtn, {Size = UDim2.new(0, 0, 0, 0)}, Animations.Normal)
      task.wait(0.3)
      self.MiniBtn.Visible = false
      
      self.Container.Visible = true
      Tween(self.Container, {Size = UDim2.new(0, self.Size[1], 0, self.Size[2])}, Animations.Bounce)
      
      self:Notify({Title = "Welcome back!", Text = "UI reopened", Duration = 2})
   end)
   
   -- Mini Hover
   self.MiniBtn.MouseEnter:Connect(function()
      Tween(self.MiniBtn, {Size = UDim2.new(0, 64, 0, 64), BackgroundColor3 = self.Theme.AccentHover}, Animations.Fast)
   end)
   self.MiniBtn.MouseLeave:Connect(function()
      Tween(self.MiniBtn, {Size = UDim2.new(0, 56, 0, 56), BackgroundColor3 = self.Theme.Accent}, Animations.Fast)
   end)
   
   -- Draggable
   MakeDraggable(self.Container, Header)
   MakeDraggable(self.MiniBtn)
   
   -- Entrance
   Tween(self.Container, {Size = UDim2.new(0, self.Size[1], 0, self.Size[2])}, Animations.Bounce)
   task.wait(0.6)
   self:Notify({Title = "Welcome!", Text = self.Name .. " loaded", Duration = 3})
   
   self.Tabs = {}
   self.CurrentTab = nil
   return self
end

-- Create Tab
function Flux:Tab(config)
   local TabName = config.Name or "Tab"
   
   -- Tab Button
   local TabBtn = Instance.new("TextButton")
   TabBtn.Size = UDim2.new(1, 0, 0, 38)
   TabBtn.BackgroundColor3 = self.Theme.ElementBg
   TabBtn.BackgroundTransparency = 1
   TabBtn.BorderSizePixel = 0
   TabBtn.Text = ""
   TabBtn.AutoButtonColor = false
   TabBtn.Parent = self.TabsContainer
   AddCorner(TabBtn, 6)
   
   local TabIcon = Instance.new("TextLabel")
   TabIcon.Size = UDim2.new(0, 18, 0, 18)
   TabIcon.Position = UDim2.new(0, 14, 0.5, -9)
   TabIcon.BackgroundTransparency = 1
   TabIcon.Text = config.Icon or "●"
   TabIcon.TextColor3 = self.Theme.TextSecondary
   TabIcon.TextSize = 15
   TabIcon.Font = Enum.Font.GothamBold
   TabIcon.Parent = TabBtn
   
   local TabText = Instance.new("TextLabel")
   TabText.Size = UDim2.new(1, -50, 1, 0)
   TabText.Position = UDim2.new(0, 40, 0, 0)
   TabText.BackgroundTransparency = 1
   TabText.Text = TabName
   TabText.TextColor3 = self.Theme.TextSecondary
   TabText.TextSize = 13
   TabText.Font = Enum.Font.Gotham
   TabText.TextXAlignment = Enum.TextXAlignment.Left
   TabText.Parent = TabBtn
   
   -- Tab Content
   local TabContent = Instance.new("ScrollingFrame")
   TabContent.Size = UDim2.new(1, 0, 1, -45)
   TabContent.Position = UDim2.new(0, 0, 0, 45)
   TabContent.BackgroundTransparency = 1
   TabContent.BorderSizePixel = 0
   TabContent.ScrollBarThickness = 4
   TabContent.ScrollBarImageColor3 = self.Theme.Accent
   TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
   TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
   TabContent.Visible = false
   TabContent.Parent = self.Content
   
   local ContentList = Instance.new("UIListLayout")
   ContentList.Padding = UDim.new(0, 8)
   ContentList.Parent = TabContent
   
   local ContentPadding = Instance.new("UIPadding")
   ContentPadding.PaddingLeft = UDim.new(0, 10)
   ContentPadding.PaddingRight = UDim.new(0, 10)
   ContentPadding.PaddingTop = UDim.new(0, 8)
   ContentPadding.Parent = TabContent
   
   -- Select
   local function SelectTab()
      for _, tab in pairs(self.Tabs) do
         tab.Btn.BackgroundTransparency = 1
         tab.Icon.TextColor3 = self.Theme.TextSecondary
         tab.Text.TextColor3 = self.Theme.TextSecondary
         tab.Content.Visible = false
      end
      
      TabBtn.BackgroundTransparency = 0
      TabIcon.TextColor3 = self.Theme.Accent
      TabText.TextColor3 = self.Theme.TextPrimary
      TabContent.Visible = true
      self.CurrentTab = TabName
   end
   
   TabBtn.MouseButton1Click:Connect(SelectTab)
   
   TabBtn.MouseEnter:Connect(function()
      if self.CurrentTab ~= TabName then
         Tween(TabBtn, {BackgroundTransparency = 0.5}, Animations.Fast)
      end
   end)
   TabBtn.MouseLeave:Connect(function()
      if self.CurrentTab ~= TabName then
         Tween(TabBtn, {BackgroundTransparency = 1}, Animations.Fast)
      end
   end)
   
   local Tab = {Btn = TabBtn, Icon = TabIcon, Text = TabText, Content = TabContent, Select = SelectTab}
   self.Tabs[TabName] = Tab
   
   if not self.CurrentTab then SelectTab() end
   
   -- Elements
   local Elements = {}
   
   function Elements:Section(text)
      local Section = Instance.new("TextLabel")
      Section.Size = UDim2.new(1, 0, 0, 26)
      Section.BackgroundTransparency = 1
      Section.Text = text
      Section.TextColor3 = self.Theme.TextMuted
      Section.TextSize = 11
      Section.Font = Enum.Font.GothamBold
      Section.TextXAlignment = Enum.TextXAlignment.Left
      Section.TextTransparency = 0.5
      Section.Parent = TabContent
      return Section
   end
   
   function Elements:Button(config)
      local Btn = Instance.new("TextButton")
      Btn.Size = UDim2.new(1, 0, 0, 40)
      Btn.BackgroundColor3 = self.Theme.ElementBg
      Btn.BorderSizePixel = 0
      Btn.Text = ""
      Btn.AutoButtonColor = false
      Btn.Parent = TabContent
      AddCorner(Btn, 6)
      
      local BtnText = Instance.new("TextLabel")
      BtnText.Size = UDim2.new(1, -24, 1, 0)
      BtnText.Position = UDim2.new(0, 14, 0, 0)
      BtnText.BackgroundTransparency = 1
      BtnText.Text = config.Name or "Button"
      BtnText.TextColor3 = self.Theme.TextPrimary
      BtnText.TextSize = 13
      BtnText.Font = Enum.Font.Gotham
      BtnText.TextXAlignment = Enum.TextXAlignment.Left
      BtnText.Parent = Btn
      
      Btn.MouseEnter:Connect(function()
         Tween(Btn, {BackgroundColor3 = self.Theme.HoverBg}, Animations.Fast)
      end)
      Btn.MouseLeave:Connect(function()
         Tween(Btn, {BackgroundColor3 = self.Theme.ElementBg}, Animations.Fast)
      end)
      
      Btn.MouseButton1Click:Connect(function()
         local Ripple = Instance.new("Frame")
         Ripple.Size = UDim2.new(0, 0, 0, 0)
         Ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
         Ripple.AnchorPoint = Vector2.new(0.5, 0.5)
         Ripple.BackgroundColor3 = self.Theme.TextPrimary
         Ripple.BackgroundTransparency = 0.8
         Ripple.BorderSizePixel = 0
         Ripple.Parent = Btn
         AddCorner(Ripple, 100)
         
         Tween(Ripple, {Size = UDim2.new(0, 150, 0, 150), BackgroundTransparency = 1}, Animations.Smooth)
         task.delay(0.3, function() Ripple:Destroy() end)
         
         if config.Callback then pcall(config.Callback) end
      end)
      
      return Btn
   end
   
   function Elements:Toggle(config)
      local Toggle = Instance.new("Frame")
      Toggle.Size = UDim2.new(1, 0, 0, 40)
      Toggle.BackgroundColor3 = self.Theme.ElementBg
      Toggle.BorderSizePixel = 0
      Toggle.Parent = TabContent
      AddCorner(Toggle, 6)
      
      local ToggleText = Instance.new("TextLabel")
      ToggleText.Size = UDim2.new(1, -70, 1, 0)
      ToggleText.Position = UDim2.new(0, 14, 0, 0)
      ToggleText.BackgroundTransparency = 1
      ToggleText.Text = config.Name or "Toggle"
      ToggleText.TextColor3 = self.Theme.TextPrimary
      ToggleText.TextSize = 13
      ToggleText.Font = Enum.Font.Gotham
      ToggleText.TextXAlignment = Enum.TextXAlignment.Left
      ToggleText.Parent = Toggle
      
      local Switch = Instance.new("TextButton")
      Switch.Size = UDim2.new(0, 44, 0, 24)
      Switch.Position = UDim2.new(1, -54, 0.5, -12)
      Switch.BackgroundColor3 = Color3.fromRGB(60, 60, 66)
      Switch.BorderSizePixel = 0
      Switch.Text = ""
      Switch.AutoButtonColor = false
      Switch.Parent = Toggle
      AddCorner(Switch, 12)
      
      local Circle = Instance.new("Frame")
      Circle.Size = UDim2.new(0, 18, 0, 18)
      Circle.Position = UDim2.new(0, 3, 0.5, -9)
      Circle.BackgroundColor3 = self.Theme.TextPrimary
      Circle.BorderSizePixel = 0
      Circle.Parent = Switch
      AddCorner(Circle, 9)
      
      local enabled = config.Default or false
      
      local function Update()
         if enabled then
            Tween(Switch, {BackgroundColor3 = self.Theme.Accent}, Animations.Normal)
            Tween(Circle, {Position = UDim2.new(1, -21, 0.5, -9)}, Animations.Normal)
         else
            Tween(Switch, {BackgroundColor3 = Color3.fromRGB(60, 60, 66)}, Animations.Normal)
            Tween(Circle, {Position = UDim2.new(0, 3, 0.5, -9)}, Animations.Normal)
         end
      end
      
      Update()
      
      Switch.MouseButton1Click:Connect(function()
         enabled = not enabled
         Update()
         if config.Callback then pcall(config.Callback, enabled) end
      end)
      
      return Toggle
   end
   
   function Elements:Label(config)
      local Label = Instance.new("Frame")
      Label.Size = UDim2.new(1, 0, 0, 0)
      Label.AutomaticSize = Enum.AutomaticSize.Y
      Label.BackgroundColor3 = self.Theme.ElementBg
      Label.BorderSizePixel = 0
      Label.Parent = TabContent
      AddCorner(Label, 6)
      
      local LabelPadding = Instance.new("UIPadding")
      LabelPadding.PaddingLeft = UDim.new(0, 14)
      LabelPadding.PaddingRight = UDim.new(0, 14)
      LabelPadding.PaddingTop = UDim.new(0, 12)
      LabelPadding.PaddingBottom = UDim.new(0, 12)
      LabelPadding.Parent = Label
      
      local Title = Instance.new("TextLabel")
      Title.Size = UDim2.new(1, 0, 0, 18)
      Title.BackgroundTransparency = 1
      Title.Text = config.Title or "Label"
      Title.TextColor3 = self.Theme.TextPrimary
      Title.TextSize = 13
      Title.Font = Enum.Font.GothamBold
      Title.TextXAlignment = Enum.TextXAlignment.Left
      Title.Parent = Label
      
      local Text = Instance.new("TextLabel")
      Text.Size = UDim2.new(1, 0, 0, 0)
      Text.Position = UDim2.new(0, 0, 0, 22)
      Text.AutomaticSize = Enum.AutomaticSize.Y
      Text.BackgroundTransparency = 1
      Text.Text = config.Text or "Description"
      Text.TextColor3 = self.Theme.TextSecondary
      Text.TextSize = 12
      Text.Font = Enum.Font.Gotham
      Text.TextXAlignment = Enum.TextXAlignment.Left
      Text.TextWrapped = true
      Text.Parent = Label
      
      return Label
   end
   
   return Elements
end

-- Notifications
function Flux:Notify(config)
   local Notif = Instance.new("Frame")
   Notif.Size = UDim2.new(0, 280, 0, 70)
   Notif.Position = UDim2.new(1, 300, 1, -80)
   Notif.BackgroundColor3 = self.Theme.ElementBg
   Notif.BorderSizePixel = 0
   Notif.Parent = self.Gui
   AddCorner(Notif, 8)
   AddStroke(Notif, self.Theme.Accent, 1.5)
   
   local NotifTitle = Instance.new("TextLabel")
   NotifTitle.Size = UDim2.new(1, -20, 0, 20)
   NotifTitle.Position = UDim2.new(0, 12, 0, 10)
   NotifTitle.BackgroundTransparency = 1
   NotifTitle.Text = config.Title or "Notification"
   NotifTitle.TextColor3 = self.Theme.TextPrimary
   NotifTitle.TextSize = 13
   NotifTitle.Font = Enum.Font.GothamBold
   NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
   NotifTitle.Parent = Notif
   
   local NotifText = Instance.new("TextLabel")
   NotifText.Size = UDim2.new(1, -20, 0, 30)
   NotifText.Position = UDim2.new(0, 12, 0, 32)
   NotifText.BackgroundTransparency = 1
   NotifText.Text = config.Text or "Content"
   NotifText.TextColor3 = self.Theme.TextSecondary
   NotifText.TextSize = 11
   NotifText.Font = Enum.Font.Gotham
   NotifText.TextXAlignment = Enum.TextXAlignment.Left
   NotifText.TextWrapped = true
   NotifText.Parent = Notif
   
   Tween(Notif, {Position = UDim2.new(1, -290, 1, -80)}, Animations.Bounce)
   task.wait(config.Duration or 3)
   Tween(Notif, {Position = UDim2.new(1, 300, 1, -80)}, Animations.Normal)
   task.wait(0.3)
   Notif:Destroy()
end

-- ============================================
-- FPS OPTIMIZER
-- ============================================

-- CREATE WINDOW (CUSTOMIZE HERE!)
local Window = Flux:Window({
   Name = "FPS Booster",        -- CHANGE NAME HERE!
   Subtitle = "made by you",    -- CHANGE SUBTITLE HERE!
   Size = {480, 560}
})

local Settings = {ShowFPS = false}

-- TAB: BOOST
local BoostTab = Window:Tab({Name = "Boost", Icon = "⚡"})

BoostTab:Label({
   Title = "Quick Boost Modes",
   Text = "Select a preset to instantly boost your FPS. All modes preserve collision!"
})

BoostTab:Section("PRESETS")

BoostTab:Button({
   Name = "🚀 Ultra Boost (Recommended)",
   Callback = function()
      ApplyUltraBoost()
      Window:Notify({Title = "Ultra Boost", Text = "All optimizations applied!", Duration = 3})
   end
})

BoostTab:Button({
   Name = "🥔 Potato Mode (Low-End PC)",
   Callback = function()
      ApplyPotatoMode()
      Window:Notify({Title = "Potato Mode", Text = "Maximum FPS activated!", Duration = 3})
   end
})

BoostTab:Button({
   Name = "⚡ Performance Mode (Balanced)",
   Callback = function()
      ApplyPerformanceMode()
      Window:Notify({Title = "Performance", Text = "Balanced settings applied!", Duration = 3})
   end
})

BoostTab:Section("MONITOR")

BoostTab:Toggle({
   Name = "Show FPS Counter",
   Default = false,
   Callback = function(value)
      Settings.ShowFPS = value
      ShowFPSCounter(value)
   end
})

-- TAB: GRAPHICS
local GraphicsTab = Window:Tab({Name = "Graphics", Icon = "🎨"})

GraphicsTab:Section("VISUALS")

GraphicsTab:Toggle({
   Name = "Remove Textures",
   Default = false,
   Callback = function(value)
      if value then
         RemoveTextures()
         Window:Notify({Title = "Textures", Text = "Textures removed!", Duration = 2})
      end
   end
})

GraphicsTab:Toggle({
   Name = "Remove Particles",
   Default = false,
   Callback = function(value)
      if value then
         RemoveParticles()
         Window:Notify({Title = "Particles", Text = "Particles removed!", Duration = 2})
      end
   end
})

GraphicsTab:Toggle({
   Name = "Remove Shadows",
   Default = false,
   Callback = function(value)
      RemoveShadows(value)
      if value then
         Window:Notify({Title = "Shadows", Text = "Shadows disabled!", Duration = 2})
      end
   end
})

GraphicsTab:Toggle({
   Name = "Remove Fog",
   Default = false,
   Callback = function(value)
      RemoveFog(value)
      if value then
         Window:Notify({Title = "Fog", Text = "Fog removed!", Duration = 2})
      end
   end
})

-- TAB: SYSTEM
local SystemTab = Window:Tab({Name = "System", Icon = "🛠️"})

SystemTab:Section("MEMORY")

SystemTab:Button({
   Name = "Clear Memory Cache",
   Callback = function()
      ClearMemory()
      Window:Notify({Title = "Memory", Text = "Cache cleared!", Duration = 2})
   end
})

SystemTab:Button({
   Name = "Remove Unused Assets",
   Callback = function()
      RemoveUnusedAssets()
      Window:Notify({Title = "Assets", Text = "Assets removed!", Duration = 2})
   end
})

SystemTab:Button({
   Name = "Optimize Workspace",
   Callback = function()
      OptimizeWorkspace()
      Window:Notify({Title = "Workspace", Text = "Workspace optimized!", Duration = 2})
   end
})

SystemTab:Section("PHYSICS")

SystemTab:Button({
   Name = "Fix Physics Lag",
   Callback = function()
      FixPhysics()
      Window:Notify({Title = "Physics", Text = "Physics optimized!", Duration = 2})
   end
})

-- TAB: ABOUT
local AboutTab = Window:Tab({Name = "About", Icon = "ℹ️"})

AboutTab:Label({
   Title = "FPS Booster",
   Text = "Universal FPS optimization tool for all Roblox games. Boost performance and reduce lag!"
})

AboutTab:Section("TIPS")

AboutTab:Label({Title = "Low-End PC", Text = "Use Potato Mode for maximum FPS"})
AboutTab:Label({Title = "Mid-Range PC", Text = "Use Performance Mode for balance"})
AboutTab:Label({Title = "High-End PC", Text = "Remove shadows only"})

AboutTab:Section("MINI BUTTON")

AboutTab:Label({
   Title = "Quick Access",
   Text = "Close this UI and a mini button will appear. Click it to reopen instantly!"
})

-- OPTIMIZATION FUNCTIONS

function ApplyUltraBoost()
   print("\n⚡ ULTRA BOOST")
   RemoveTextures()
   RemoveParticles()
   RemoveShadows(true)
   RemoveFog(true)
   OptimizeWorkspace()
   print("✅ Complete!")
end

function ApplyPotatoMode()
   print("\n🥔 POTATO MODE")
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
   print("\n⚡ PERFORMANCE")
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
      local FPSGui = Instance.new("ScreenGui")
      FPSGui.Name = "FPSCounter"
      FPSGui.ResetOnSpawn = false
      FPSGui.Parent = player.PlayerGui
      
      local Frame = Instance.new("Frame")
      Frame.Size = UDim2.new(0, 90, 0, 55)
      Frame.Position = UDim2.new(1, -100, 0, 10)
      Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
      Frame.BorderSizePixel = 0
      Frame.Parent = FPSGui
      AddCorner(Frame, 8)
      AddStroke(Frame, Color3.fromRGB(124, 58, 237), 1.5)
      
      local Label = Instance.new("TextLabel")
      Label.Size = UDim2.new(1, 0, 0, 18)
      Label.Position = UDim2.new(0, 0, 0, 6)
      Label.BackgroundTransparency = 1
      Label.Text = "FPS"
      Label.TextColor3 = Color3.fromRGB(161, 161, 170)
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
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            Value.Text = tostring(fps)
            
            if fps >= 60 then
               Value.TextColor3 = Color3.fromRGB(34, 197, 94)
            elseif fps >= 30 then
               Value.TextColor3 = Color3.fromRGB(234, 179, 8)
            else
               Value.TextColor3 = Color3.fromRGB(239, 68, 68)
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

print("\n✅ FLUX UI - FPS OPTIMIZER LOADED!")
print("🎨 Custom UI with Natural Design")
print("🔘 Close UI to see mini button")
print("💡 Customize name at line 435-437!")
print(string.rep("=", 70) .. "\n")
