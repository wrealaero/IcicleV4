-- Display key input GUI (Draggable)
local key = "123" -- Change this to your actual key
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local TextLabel = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local ConfirmButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Dark theme
Frame.AnchorPoint = Vector2.new(0.5, 0.5) -- Centers GUI correctly
Frame.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centers on screen
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 8)

UIStroke.Parent = Frame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(100, 100, 255) -- Blue outline

-- Centered "Enter Key:" text
TextLabel.Parent = Frame
TextLabel.Text = "Enter Key:"
TextLabel.TextSize = 18
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.5, -100, 0.2, 0) -- Centered horizontally
TextLabel.Size = UDim2.new(0, 200, 0, 20)
TextLabel.TextXAlignment = Enum.TextXAlignment.Center -- Align text to center

-- Centered Input Box
TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Slightly lighter input box
TextBox.Position = UDim2.new(0.5, -100, 0.4, 0) -- Centered horizontally
TextBox.Size = UDim2.new(0, 200, 0, 30)
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Paste Key Here"
TextBox.TextXAlignment = Enum.TextXAlignment.Center -- Align text to center

-- Centered Confirm Button
ConfirmButton.Parent = Frame
ConfirmButton.Text = "Confirm"
ConfirmButton.Position = UDim2.new(0.5, -100, 0.7, 0) -- Centered horizontally
ConfirmButton.Size = UDim2.new(0, 200, 0, 30)
ConfirmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255) -- Blue button
ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmButton.TextXAlignment = Enum.TextXAlignment.Center -- Align text to center

UICorner:Clone().Parent = TextBox
UICorner:Clone().Parent = ConfirmButton

ConfirmButton.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text
    if enteredKey == key then
        -- Mark key as correct and remove the GUI
        getgenv().keyCorrect = true
        ScreenGui:Destroy() -- Removes the key input GUI

        -- Show confirmation notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Correct Key!";
            Text = "Join .gg/icicle for more updates!";
            Duration = 5;
        })
        
        -- Wait for GUI removal before loading Vape
        task.wait(0.5)

        -- Ensure Vape loads only once
        if not getgenv().vapeLoaded then
            getgenv().vapeLoaded = true
            -- Load the Vape script
            local vapeScript = game:HttpGet("https://raw.githubusercontent.com/wrealaero/IcicleV4/refs/heads/main/main.lua", true)
            if vapeScript then
                loadstring(vapeScript)()
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Error";
                    Text = "Failed to load Vape script!";
                    Duration = 5;
                })
            end
        end
    else
        -- Show error notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Incorrect Key";
            Text = "Join .gg/icicle to get the correct key.";
            Duration = 3;
        })
    end
end)

-- Wait for correct key
repeat task.wait() until getgenv().keyCorrect -- Wait until correct key is entered

-- Prevent Vape from loading twice
if not getgenv().vapeLoaded then
    getgenv().vapeLoaded = true
    -- Continue executing your existing script only once
    local vapeScript = game:HttpGet("https://raw.githubusercontent.com/wrealaero/IcicleV4/refs/heads/main/main.lua", true)
    if vapeScript then
        loadstring(vapeScript)()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error";
            Text = "Failed to load Vape script!";
            Duration = 5;
        })
    end
end
