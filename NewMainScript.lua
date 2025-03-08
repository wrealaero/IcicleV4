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
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Add a border radius for the main frame
local cornerRadius = Instance.new("UICorner")
cornerRadius.CornerRadius = UDim.new(0, 15)
cornerRadius.Parent = mainFrame

-- Create a smooth gradient background
local uiGradient = Instance.new("UIGradient")
uiGradient.Parent = mainFrame
uiGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
})

-- Drag Frame (for smooth dragging experience)
dragFrame.Size = UDim2.new(1, 0, 0, 40)
dragFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dragFrame.Parent = mainFrame
dragFrame.BorderSizePixel = 0

local dragUICorner = Instance.new("UICorner")
dragUICorner.CornerRadius = UDim.new(0, 10)
dragUICorner.Parent = dragFrame

-- Smooth dragging with Tween
dragFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local startPos = input.Position
        local startFramePos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - startPos
                mainFrame.Position = UDim2.new(startFramePos.X.Scale, startFramePos.X.Offset + delta.X, startFramePos.Y.Scale, startFramePos.Y.Offset + delta.Y)
            end
        end)
    end
end)

-- Key TextBox
keyBox.Size = UDim2.new(0.8, 0, 0, 40)
keyBox.Position = UDim2.new(0.1, 0, 0.25, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
keyBox.PlaceholderText = "Enter Key"
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.TextScaled = true
keyBox.Parent = mainFrame

local keyBoxUICorner = Instance.new("UICorner")
keyBoxUICorner.CornerRadius = UDim.new(0, 10)
keyBoxUICorner.Parent = keyBox

-- Submit Button
submitButton.Size = UDim2.new(0.8, 0, 0, 45)
submitButton.Position = UDim2.new(0.1, 0, 0.45, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
submitButton.Text = "Submit Key"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextSize = 18
submitButton.Parent = mainFrame

-- Smooth button hover effect
submitButton.MouseEnter:Connect(function()
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)

submitButton.MouseLeave:Connect(function()
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
end)

-- Discord Button
discordButton.Size = UDim2.new(0.8, 0, 0, 45)
discordButton.Position = UDim2.new(0.1, 0, 0.6, 0)
discordButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
discordButton.Text = "Join Discord"
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.TextSize = 18
discordButton.Parent = mainFrame

discordButton.MouseEnter:Connect(function()
    discordButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)

discordButton.MouseLeave:Connect(function()
    discordButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
end)

-- Get Key Button
getKeyButton.Size = UDim2.new(0.8, 0, 0, 45)
getKeyButton.Position = UDim2.new(0.1, 0, 0.75, 0)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
getKeyButton.Text = "Get Key"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextSize = 18
getKeyButton.Parent = mainFrame

getKeyButton.MouseEnter:Connect(function()
    getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)

getKeyButton.MouseLeave:Connect(function()
    getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
end)

-- Button Animation Effect
local function animateButtonClick(button)
    local originalSize = button.Size
    button:TweenSize(UDim2.new(0.85, 0, 0, 45), "Out", "Quad", 0.1, true)
    wait(0.1)
    button:TweenSize(originalSize, "Out", "Quad", 0.1, true)
end

-- Key Verification Logic
submitButton.MouseButton1Click:Connect(function()
    animateButtonClick(submitButton)
    if keyBox.Text == "123" and keyBox.Text ~= "" then  -- Change this to the manual key you set
        screenGui:Destroy()  -- Destroy the GUI upon successful verification

        -- Success Notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Success!";
            Text = "Key Verified! Script Loaded!";
            Duration = 5;
        })

        -- Begin Loading Script
        -- Insert your loading logic here
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
    animateButtonClick(getKeyButton)
    setclipboard("https://linkvertise.com/1233399/icicle-key-generator?o=sharing")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System";
        Text = "Link copied! Paste this in your browser";
        Duration = 5;
    })
end)

-- Discord Button Function
discordButton.MouseButton1Click:Connect(function()
    animateButtonClick(discordButton)
    setclipboard("https://discord.gg/icicle")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord";
        Text = "Invite copied! Join our Discord";
        Duration = 5;
    })
end)
