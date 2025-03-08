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
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

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

-- Submit Button
submitButton.Size = UDim2.new(0.8, 0, 0, 30)
submitButton.Position = UDim2.new(0.1, 0, 0.5, 0)
submitButton.Text = "Submit Key"
submitButton.Parent = mainFrame

-- Discord Button
discordButton.Size = UDim2.new(0.8, 0, 0, 30)
discordButton.Position = UDim2.new(0.1, 0, 0.7, 0)
discordButton.Text = "Join Discord"
discordButton.Parent = mainFrame

-- Get Key Button
getKeyButton.Size = UDim2.new(0.8, 0, 0, 30)
getKeyButton.Position = UDim2.new(0.1, 0, 0.85, 0)
getKeyButton.Text = "Get Key"
getKeyButton.Parent = mainFrame

-- Key Verification
submitButton.MouseButton1Click:Connect(function()
    if keyBox.Text == "123" and keyBox.Text ~= "" then  -- Change this to the manual key you set
        screenGui:Destroy()
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "Success!";
            Text = "Key Verified! Script Loaded!";
            Duration = 5;
        })
    else
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
