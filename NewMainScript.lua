local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Darker modern look
frame.BackgroundTransparency = 0.25 -- Slightly higher transparency for a more subtle look
frame.BorderSizePixel = 0
frame.Parent = screenGui

local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 8, 1, 8)
shadow.Position = UDim2.new(0, -4, 0, -4)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://4615421078"  -- Custom shadow texture
shadow.Parent = frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12) -- Slightly rounder corners
UICorner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "Universal Key System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18 -- Larger text for better visibility
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Parent = frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Parent = frame

local KeySystem = Instance.new("TextBox")
KeySystem.Size = UDim2.new(0.9, 0, 0, 30)
KeySystem.Position = UDim2.new(0.05, 0, 0.3, 0)
KeySystem.Text = "Enter the Key"
KeySystem.TextColor3 = Color3.new(1, 1, 1)
KeySystem.BackgroundTransparency = 0.3
KeySystem.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeySystem.Font = Enum.Font.Gotham
KeySystem.TextSize = 14
KeySystem.Parent = frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.9, 0, 0, 30)
SubmitButton.Position = UDim2.new(0.05, 0, 0.6, 0)
SubmitButton.Text = "Submit"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitButton.Parent = frame

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.9, 0, 0, 30)
GetKeyButton.Position = UDim2.new(0.05, 0, 0.8, 0)
GetKeyButton.Text = "Get Key"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextColor3 = Color3.new(1, 1, 1)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
GetKeyButton.Parent = frame

-- Add UICorner effect to buttons
for _, button in pairs({CloseButton, SubmitButton, GetKeyButton}) do
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12) -- Slightly rounder corners
    buttonCorner.Parent = button
end

-- Smooth opening animation
frame.Size = UDim2.new(0, 0, 0, 0)
local tween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 150)})
tween:Play()

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    closeTween:Play()
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

-- Draggable window
local dragging, dragStart, startPos
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

title.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Button Hover Effects
local function hoverEffect(button, color)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = button.BackgroundColor3}):Play()
    end)
end

hoverEffect(SubmitButton, Color3.fromRGB(0, 180, 255))
hoverEffect(GetKeyButton, Color3.fromRGB(60, 220, 120))
hoverEffect(CloseButton, Color3.fromRGB(255, 80, 80))

-- TextBox Focus Animation
KeySystem.Focused:Connect(function()
    TweenService:Create(KeySystem, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
end)
KeySystem.FocusLost:Connect(function()
    TweenService:Create(KeySystem, TweenInfo.new(0.3), {BackgroundTransparency = 0.3}):Play()
end)

-- Visual feedback for Key validity
SubmitButton.MouseButton1Click:Connect(function()
    if not getgenv().Key or getgenv().Key == "InvalidKey" then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error";
            Text = "Invalid or missing key! Get a valid key from Linkvertise.";
            Duration = 5;
        })
        return
    end
    if KeySystem.Text == getgenv().Key and KeySystem.Text ~= "" then
        KeySystem.BackgroundColor3 = Color3.fromRGB(60, 220, 120) -- Green for valid key
        screenGui:Destroy()
        loadstring(game:HttpGet("https://your-script-url.com"))() -- Load main script
    else
        KeySystem.BackgroundColor3 = Color3.fromRGB(220, 70, 70) -- Red for invalid key
    end
end)

GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://link-hub.net/1233399/icicle-key-generator")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System";
        Text = "Link copied! Paste this in your browser.";
        Duration = 5;
    })
end)
