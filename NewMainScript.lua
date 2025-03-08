local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Darker modern look
frame.BackgroundTransparency = 0.15 -- Adjust transparency for a softer look
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Darker modern background
frame.BorderSizePixel = 0
frame.BorderRadius = UDim.new(0, 12) -- Rounded corners for modern look
frame.BorderSizePixel = 0
frame.Parent = screenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "Universal Key System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18 -- Increase text size for readability
title.BackgroundTransparency = 0.3 -- Slightly transparent background
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Parent = frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "" -- Remove the "X" text
local closeIcon = Instance.new("TextLabel")
closeIcon.Size = UDim2.new(1, 0, 1, 0)
closeIcon.Text = "✖" -- Unicode cross symbol for better look
closeIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
closeIcon.TextSize = 16
closeIcon.BackgroundTransparency = 1
closeIcon.Parent = CloseButton
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Parent = frame


local KeySystem = Instance.new("TextBox")
local SubmitButton = Instance.new("TextButton")
local GetKeyButton = Instance.new("TextButton")

-- Position buttons after creation
SubmitButton.Position = UDim2.new(0.05, 0, 0.6, 0)
GetKeyButton.Position = UDim2.new(0.05, 0, 0.8, 0)
KeySystem.Text = "Enter the Key"
KeySystem.TextColor3 = Color3.new(1, 1, 1)
KeySystem.Font = Enum.Font.Gotham
KeySystem.TextSize = 14
KeySystem.Parent = frame
KeySystem.PlaceholderText = "Enter the key here" -- Add placeholder text
KeySystem.BorderSizePixel = 1 -- Make the border visible
KeySystem.BorderColor3 = Color3.fromRGB(70, 70, 70) -- Color for border
KeySystem.BackgroundTransparency = 0.25 -- Slight transparency
KeySystem.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Dark background color

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
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
end

-- Smooth opening animation
frame.Size = UDim2.new(0, 0, 0, 0)
local tween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 150)})
tween:Play()

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    closeTween:Play()
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

local function addButtonShadow(button)
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 5, 1, 5)
    shadow.Position = UDim2.new(0, 5, 0, 5)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.4
    shadow.BorderSizePixel = 0
    shadow.Parent = button
end

-- Add shadow to buttons
addButtonShadow(SubmitButton)
addButtonShadow(GetKeyButton)
addButtonShadow(CloseButton)

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

-- Apply hover effects to buttons
hoverEffect(SubmitButton, Color3.fromRGB(0, 180, 255))
hoverEffect(GetKeyButton, Color3.fromRGB(60, 220, 120))
hoverEffect(CloseButton, Color3.fromRGB(220, 70, 70))

local function pressEffect(button, color)
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = color}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = button.BackgroundColor3}):Play()
    end)
end

-- Apply press effect to buttons
pressEffect(SubmitButton, Color3.fromRGB(0, 120, 255))
pressEffect(GetKeyButton, Color3.fromRGB(50, 180, 90))
pressEffect(CloseButton, Color3.fromRGB(200, 60, 60))

-- Functionality
local HttpService = game:GetService("HttpService")

local function fetchKey()
    local success, response = pcall(function()
        return HttpService:GetAsync("https://yourwebsite.com/key.txt") -- Replace with actual key storage
    end)
    getgenv().Key = success and response or "InvalidKey"
end

fetchKey()

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
        screenGui:Destroy()
        loadstring(game:HttpGet("https://your-script-url.com"))() -- Load main script
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
