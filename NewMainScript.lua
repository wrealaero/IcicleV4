-- Create GUI
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local keyBox = Instance.new("TextBox")
local submitButton = Instance.new("TextButton")
local discordButton = Instance.new("TextButton")
local getKeyButton = Instance.new("TextButton")
local dragFrame = Instance.new("Frame")

-- Parent GUI to Player
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Corner Radius for mainFrame
local cornerRadius = Instance.new("UICorner")
cornerRadius.CornerRadius = UDim.new(0, 12)
cornerRadius.Parent = mainFrame

-- Drag Frame
dragFrame.Size = UDim2.new(1, 0, 0, 35)
dragFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dragFrame.Parent = mainFrame
dragFrame.BorderSizePixel = 0

local dragUICorner = Instance.new("UICorner")
dragUICorner.CornerRadius = UDim.new(0, 8)
dragUICorner.Parent = dragFrame

-- Key TextBox
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
keyBox.PlaceholderText = "Enter Key"
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.TextScaled = true
keyBox.Parent = mainFrame

local keyBoxUICorner = Instance.new("UICorner")
keyBoxUICorner.CornerRadius = UDim.new(0, 10)
keyBoxUICorner.Parent = keyBox

-- Submit Button
submitButton.Size = UDim2.new(0.8, 0, 0, 40)
submitButton.Position = UDim2.new(0.1, 0, 0.35, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitButton.Text = "Submit Key"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextSize = 18
submitButton.Parent = mainFrame

submitButton.MouseEnter:Connect(function()
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)

submitButton.MouseLeave:Connect(function()
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)

-- Get Key Button
getKeyButton.Size = UDim2.new(0.8, 0, 0, 40)
getKeyButton.Position = UDim2.new(0.1, 0, 0.5, 0)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
getKeyButton.Text = "Get Key"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextSize = 18
getKeyButton.Parent = mainFrame

getKeyButton.MouseEnter:Connect(function()
    getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 220, 0)
end)

getKeyButton.MouseLeave:Connect(function()
    getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
end)

-- Discord Button
discordButton.Size = UDim2.new(0.8, 0, 0, 40)
discordButton.Position = UDim2.new(0.1, 0, 0.65, 0)
discordButton.BackgroundColor3 = Color3.fromRGB(58, 98, 255)
discordButton.Text = "Join Discord"
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.TextSize = 18
discordButton.Parent = mainFrame

discordButton.MouseEnter:Connect(function()
    discordButton.BackgroundColor3 = Color3.fromRGB(58, 120, 255)
end)

discordButton.MouseLeave:Connect(function()
    discordButton.BackgroundColor3 = Color3.fromRGB(58, 98, 255)
end)

-- Key Verification Logic
submitButton.MouseButton1Click:Connect(function()
    if keyBox.Text == "123" and keyBox.Text ~= "" then  -- Change this to the manual key you set
        screenGui:Destroy()  -- Destroy the GUI upon successful verification

        -- Success Notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Success!";
            Text = "Key Verified! Loading script...";
            Duration = 5;
        })

        -- Script loading logic here...

    else
        -- Access Denied Notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Access Denied";
            Text = "Incorrect key! Get the correct key from the website.";
            Duration = 5;
        })
    end
end)

-- Get Key Button Function
getKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://linkvertise.com/1233399/icicle-key-generator?o=sharing")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System";
        Text = "Link copied! Paste this in your browser";
        Duration = 5;
    })
end)

-- Discord Button Function
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/icicle")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord";
        Text = "Invite copied! Join our Discord";
        Duration = 5;
    })
end)
