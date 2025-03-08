-- Create GUI
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local keyBox = Instance.new("TextBox")
local submitButton = Instance.new("TextButton")
local discordButton = Instance.new("TextButton")
local getKeyButton = Instance.new("TextButton")
local dragFrame = Instance.new("Frame")
local uiGradient = Instance.new("UIGradient")
local uiCorner = Instance.new("UICorner")
local blurEffect = Instance.new("BlurEffect")

-- Parent GUI to Player
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BackgroundTransparency = 0.2

-- Add a nice border radius to the main frame for smoother edges
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

-- Add a Gradient Background
uiGradient.Parent = mainFrame
uiGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
})

-- Add Blur Effect (for more advanced look)
local camera = game:GetService("Workspace").CurrentCamera
blurEffect.Parent = camera
blurEffect.Size = 10  -- Controls the strength of the blur

-- Drag Frame (for better dragging experience)
dragFrame.Size = UDim2.new(1, 0, 0, 40)
dragFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
keyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
keyBox.PlaceholderText = "Enter Key"
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.TextScaled = true
keyBox.Parent = mainFrame

local keyBoxUICorner = Instance.new("UICorner")
keyBoxUICorner.CornerRadius = UDim.new(0, 10)
keyBoxUICorner.Parent = keyBox

-- Submit Button
submitButton.Size = UDim2.new(0.8, 0, 0, 40)
submitButton.Position = UDim2.new(0.1, 0, 0.55, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
submitButton.Text = "Submit Key"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextSize = 18
submitButton.Parent = mainFrame

-- Smooth button hover effect
submitButton.MouseEnter:Connect(function()
    submitButton.BackgroundColor3 = Color3.fromRGB(70, 200, 255)
end)

submitButton.MouseLeave:Connect(function()
    submitButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
end)

-- Discord Button
discordButton.Size = UDim2.new(0.8, 0, 0, 40)
discordButton.Position = UDim2.new(0.1, 0, 0.75, 0)
discordButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
discordButton.Text = "Join Discord"
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.TextSize = 18
discordButton.Parent = mainFrame

discordButton.MouseEnter:Connect(function()
    discordButton.BackgroundColor3 = Color3.fromRGB(70, 200, 255)
end)

discordButton.MouseLeave:Connect(function()
    discordButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
end)

-- Get Key Button
getKeyButton.Size = UDim2.new(0.8, 0, 0, 40)
getKeyButton.Position = UDim2.new(0.1, 0, 0.9, 0)
getKeyButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
getKeyButton.Text = "Get Key"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextSize = 18
getKeyButton.Parent = mainFrame

getKeyButton.MouseEnter:Connect(function()
    getKeyButton.BackgroundColor3 = Color3.fromRGB(70, 200, 255)
end)

getKeyButton.MouseLeave:Connect(function()
    getKeyButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
end)

-- Smooth button click effect
local function animateButtonClick(button)
    local originalSize = button.Size
    button:TweenSize(UDim2.new(0.85, 0, 0, 40), "Out", "Quad", 0.1, true)
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

        local function isfile(file)
            local success, result = pcall(function()
                return readfile(file)
            end)
            return success and result ~= nil and result ~= ''
        end

        local function delfile(file)
            writefile(file, '')
        end

        local function downloadFile(path, func)
            if not isfile(path) then
                local success, response = pcall(function()
                    return game:HttpGet('https://raw.githubusercontent.com/miacheats/VapeV4ForRoblox/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true)
                end)
                if not success or response == '404: Not Found' then
                    error(response)
                end
                writefile(path, response)
            end
            return (func or readfile)(path)
        end

        local function wipeFolder(path)
            if not isfolder(path) then return end
            for _, file in listfiles(path) do
                if isfile(file) and readfile(file):find('--This watermark is used') then
                    delfile(file)
                end
            end
        end

        -- Create necessary folders
        for _, folder in {'newvape', 'newvape/games', 'newvape/profiles', 'newvape/assets', 'newvape/libraries', 'newvape/guis'} do
            if not isfolder(folder) then
                makefolder(folder)
            end
        end

        if not shared.VapeDeveloper then
            local commit = "main"
            if isfile('newvape/profiles/commit.txt') and readfile('newvape/profiles/commit.txt') ~= commit then
                wipeFolder('newvape')
            end
            writefile('newvape/profiles/commit.txt', commit)
        end
        
        -- Load your main script after key verification
        loadstring(downloadFile('newvape/main.lua'), 'main')()

        -- End Loading Script

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
