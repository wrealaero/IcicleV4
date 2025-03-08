-- Create GUI
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local keyBox = Instance.new("TextBox")
local submitButton = Instance.new("TextButton")
local discordButton = Instance.new("TextButton")
local getKeyButton = Instance.new("TextButton")
local dragFrame = Instance.new("Frame")
local background = Instance.new("ImageLabel")

-- Parent GUI to Player
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Background Animation (Animated background for visual appeal)
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.Image = "rbxassetid://12651041455" -- You can replace this with any image ID you prefer for the background.
background.Parent = mainFrame
background.BackgroundTransparency = 1
background.ZIndex = -1
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(60, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)

local goal = {Position = UDim2.new(0, 0, 0, -250)} -- Create an effect where the background moves up and down
local tween = tweenService:Create(background, tweenInfo, goal)
tween:Play()

-- Drag Frame (for better dragging experience)
dragFrame.Size = UDim2.new(1, 0, 0, 30)
dragFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dragFrame.Parent = mainFrame

dragFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        mainFrame:TweenPosition(UDim2.new(0, input.Position.X, 0, input.Position.Y), "Out", "Linear", 0.2, true)
    end
end)

-- Key TextBox
keyBox.Size = UDim2.new(0.8, 0, 0, 30)
keyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
keyBox.PlaceholderText = "Enter Key"
keyBox.Parent = mainFrame
keyBox.BackgroundTransparency = 0.3
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.BorderSizePixel = 2
keyBox.BorderColor3 = Color3.fromRGB(200, 200, 200)

-- Submit Button
submitButton.Size = UDim2.new(0.8, 0, 0, 30)
submitButton.Position = UDim2.new(0.1, 0, 0.5, 0)
submitButton.Text = "Submit Key"
submitButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.Parent = mainFrame
submitButton.BorderSizePixel = 2
submitButton.BorderColor3 = Color3.fromRGB(200, 200, 200)

-- Discord Button
discordButton.Size = UDim2.new(0.8, 0, 0, 30)
discordButton.Position = UDim2.new(0.1, 0, 0.7, 0)
discordButton.Text = "Join Discord"
discordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.Parent = mainFrame
discordButton.BorderSizePixel = 2
discordButton.BorderColor3 = Color3.fromRGB(200, 200, 200)

-- Get Key Button
getKeyButton.Size = UDim2.new(0.8, 0, 0, 30)
getKeyButton.Position = UDim2.new(0.1, 0, 0.85, 0)
getKeyButton.Text = "Get Key"
getKeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.Parent = mainFrame
getKeyButton.BorderSizePixel = 2
getKeyButton.BorderColor3 = Color3.fromRGB(200, 200, 200)

-- The Key You Will Manually Set on Your Website (Same Key Every Day, Change Every 24 Hours)
local storedKey = "123"  -- Manually change this key every 24 hours

-- Key Verification
submitButton.MouseButton1Click:Connect(function()
    if keyBox.Text == storedKey and keyBox.Text ~= "" then
        screenGui:Destroy() -- If the key is correct, remove the GUI
        
        -- Insert your Roblox script or functionality here
        print("Key is correct, launching the script...")
        -- Your code here to run the actual game script or functions
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Access Denied";
            Text = "Incorrect key! Get the correct key from your website.";
            Duration = 5;
        })
    end
end)

-- Get Key Button Function (this will copy the website link for the user to visit)
getKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://linkvertise.com/1233399/icicle-key-generator?o=sharing")  -- Linkvertise URL
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System";
        Text = "Link copied! Paste this in your browser";
        Duration = 5;
    })
end)

-- Discord Button Function
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/icicle")  -- Your Discord link
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord";
        Text = "Invite copied! Join our Discord";
        Duration = 5;
    })
end)
