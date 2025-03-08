local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 200)
frame.Position = UDim2.new(0.5, -175, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Parent = screenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Universal Key System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
title.Parent = frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Parent = frame

local KeySystem = Instance.new("TextBox")
KeySystem.Size = UDim2.new(0.9, 0, 0, 35)
KeySystem.Position = UDim2.new(0.05, 0, 0.25, 0)
KeySystem.Text = "Enter the Key"
KeySystem.TextColor3 = Color3.new(1, 1, 1)
KeySystem.BackgroundTransparency = 0.3
KeySystem.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeySystem.Font = Enum.Font.Gotham
KeySystem.TextSize = 14
KeySystem.Parent = frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.9, 0, 0, 35)
SubmitButton.Position = UDim2.new(0.05, 0, 0.5, 0)
SubmitButton.Text = "Submit"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitButton.Parent = frame

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.9, 0, 0, 35)
GetKeyButton.Position = UDim2.new(0.05, 0, 0.7, 0)
GetKeyButton.Text = "Get Key"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextColor3 = Color3.new(1, 1, 1)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
GetKeyButton.Parent = frame

local DiscordButton = Instance.new("TextButton")
DiscordButton.Size = UDim2.new(0.9, 0, 0, 35)
DiscordButton.Position = UDim2.new(0.05, 0, 0.85, 0)
DiscordButton.Text = "Join Discord"
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.TextColor3 = Color3.new(1, 1, 1)
DiscordButton.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
DiscordButton.Parent = frame

-- Draggable UI
local dragging, dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
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

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Submit Key
SubmitButton.MouseButton1Click:Connect(function()
    if KeySystem.Text == getgenv().Key and KeySystem.Text ~= "" then
        screenGui:Destroy()
        loadstring(game:HttpGet("https://your-script-url.com"))()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Access Denied",
            Text = "Incorrect key! Get the correct key from .gg/icicle",
            Duration = 5,
        })
    end
end)

-- Copy Key Link
GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://link-hub.net/1233399/icicle-key-generator")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System",
        Text = "Link copied! Paste this in your browser.",
        Duration = 5,
    })
end)

-- Copy Discord Link
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/icicle")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord",
        Text = "Discord invite copied! Paste this in your browser.",
        Duration = 5,
    })
end)
