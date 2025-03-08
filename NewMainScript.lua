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
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Parent = frame

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

local DiscordButton = Instance.new("TextButton")
DiscordButton.Size = UDim2.new(0.9, 0, 0, 30)
DiscordButton.Position = UDim2.new(0.05, 0, 1, 0)
DiscordButton.Text = "Join Discord"
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.TextColor3 = Color3.new(1, 1, 1)
DiscordButton.BackgroundColor3 = Color3.fromRGB(120, 70, 255)
DiscordButton.Parent = frame

-- Button functionality
SubmitButton.MouseButton1Click:Connect(function()
    if KeySystem.Text == "CorrectKey" then
        screenGui:Destroy()
        loadstring(game:HttpGet("https://your-script-url.com"))()
    else
        KeySystem.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
    end
end)

GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://link-hub.net/1233399/icicle-key-generator")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System",
        Text = "Link copied! Paste this in your browser.",
        Duration = 5,
    })
end)

DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("discord.gg/icicle")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord Server",
        Text = "Link copied! Join our community.",
        Duration = 5,
    })
end)
