local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the frame for the GUI
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.5, -200, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Create Icicle Logo (replace with your logo URL)
local icicleLogo = Instance.new("ImageLabel")
icicleLogo.Size = UDim2.new(0, 100, 0, 100)
icicleLogo.Position = UDim2.new(0.5, -50, 0, -60)
icicleLogo.Image = "http://www.roblox.com/asset/?id=1234567890" -- Replace with actual logo asset ID
icicleLogo.BackgroundTransparency = 1
icicleLogo.Parent = frame

-- Add title label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, -30)
title.Text = "Universal Key System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextAlignment = Enum.TextAlignment.Center
title.BackgroundTransparency = 1
title.Parent = frame

-- Create draggable feature for frame
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
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

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Create TextBox for key input
local KeySystem = Instance.new("TextBox")
KeySystem.Size = UDim2.new(0.8, 0, 0.3, 0)
KeySystem.Position = UDim2.new(0.5, -160, 0, 30)
KeySystem.Text = "Enter the Key"
KeySystem.TextColor3 = Color3.fromRGB(255, 255, 255)
KeySystem.Font = Enum.Font.Gotham
KeySystem.TextSize = 18
KeySystem.BackgroundTransparency = 0.2
KeySystem.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeySystem.TextWrapped = true
KeySystem.Parent = frame

-- Create Submit Button
local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.5, 0, 0.2, 0)
SubmitButton.Position = UDim2.new(0.25, 0, 0.7, 0)
SubmitButton.Text = "Submit"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 18
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)  -- Button color: Ice Blue
SubmitButton.BackgroundTransparency = 0.2
SubmitButton.Parent = frame

-- Create the animation for the submit button
SubmitButton.MouseEnter:Connect(function()
    SubmitButton:TweenSize(UDim2.new(0.5, 0, 0.25, 0), "Out", "Quad", 0.2, true)
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)

SubmitButton.MouseLeave:Connect(function()
    SubmitButton:TweenSize(UDim2.new(0.5, 0, 0.2, 0), "Out", "Quad", 0.2, true)
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
end)

-- Close button functionality
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, -30)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Parent = frame

CloseButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Button functionality for submitting key
SubmitButton.MouseButton1Click:Connect(function()
    local KeySystemText = KeySystem.Text
    if KeySystemText == "123" then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Success!";
            Text = "Key accepted! Access granted.";
            Duration = 5;
        })
        screenGui:Destroy() -- Destroy GUI upon success
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error";
            Text = "Invalid key! Please try again.";
            Duration = 5;
        })
    end
end)
