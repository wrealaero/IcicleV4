local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 200)
frame.Position = UDim2.new(0.5, -175, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Darker look
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Parent = screenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = frame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleBar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 1, 0)
title.Text = "Welcome to YoutubeExploit"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1
title.Parent = titleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 2)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Parent = titleBar

local function createButton(text, position, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.4, 0, 0, 35)
    button.Position = position
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BackgroundColor3 = color
    button.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = button
    return button
end

local GetKeyButton = createButton("Get Key", UDim2.new(0.1, 0, 0.55, 0), Color3.fromRGB(50, 200, 100))
local SubmitButton = createButton("Submit", UDim2.new(0.5, 0, 0.55, 0), Color3.fromRGB(0, 150, 255))
local DiscordButton = createButton("Join Discord Server", UDim2.new(0.1, 0, 0.75, 0), Color3.fromRGB(120, 120, 255))
DiscordButton.Size = UDim2.new(0.8, 0, 0, 35)

-- Smooth opening animation
frame.Size = UDim2.new(0, 0, 0, 0)
local tween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 350, 0, 200)})
tween:Play()

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    closeTween:Play()
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

-- Button functionality
GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://link-hub.net/1233399/icicle-key-generator")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System";
        Text = "Link copied! Paste this in your browser.";
        Duration = 5;
    })
end)

DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/icicle")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord Invite";
        Text = "Invite copied! Join our Discord server.";
        Duration = 5;
    })
end)
