local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundTransparency = 0.2  -- For transparency effect
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Darker background
frame.BorderSizePixel = 2  -- Adding a border
frame.BorderColor3 = Color3.fromRGB(100, 100, 100)  -- Border color
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, 0, -20)
title.Text = "Icicle Key System"
title.Font = Enum.Font.GothamBold  -- Modern font style
title.TextSize = 18  -- Adjust the size to make it stand out
title.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White color
title.BackgroundTransparency = 0.8  -- Transparent background for the title
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Slight background tint
title.Parent = frame

local dragging, dragInput, dragStart, startPos

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
    if dragging and input == dragInput then
    update(input)
    end
end)

local KeySystem = Instance.new("TextBox")
KeySystem.Size = UDim2.new(1, 0, 0.5, 0)
KeySystem.Text = "Enter the Key"
KeySystem.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Dark background
KeySystem.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
KeySystem.TextSize = 16
KeySystem.Font = Enum.Font.Gotham
KeySystem.BorderSizePixel = 0
KeySystem.BackgroundTransparency = 0.3  -- Slight transparency
KeySystem.Parent = frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.5, 0, 0.5, 0)
SubmitButton.Position = UDim2.new(0, 0, 0.5, 0)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)  -- Blue background for submit
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
SubmitButton.TextSize = 16
SubmitButton.Font = Enum.Font.Gotham

-- Hover effect
SubmitButton.MouseEnter:Connect(function()
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 105, 217)
end)
SubmitButton.MouseLeave:Connect(function()
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
end)
SubmitButton.Parent = frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red color
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18

-- Rounded edges
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 5) -- Adjust radius for smoother edges
UICorner.Parent = SubmitButton

local UICorner2 = UICorner:Clone()
UICorner2.Parent = GetKeyButton

local UICorner3 = UICorner:Clone()
UICorner3.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.5, 0, 0.5, 0)
GetKeyButton.Position = UDim2.new(0.5, 0, 0.5, 0)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(34, 193, 195)
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.TextSize = 16
GetKeyButton.Font = Enum.Font.Gotham

GetKeyButton.MouseEnter:Connect(function()
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(24, 162, 164)
end)
GetKeyButton.MouseLeave:Connect(function()
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(34, 193, 195)
end)
GetKeyButton.Parent = frame

local HttpService = game:GetService("HttpService")

local function fetchKey()
    local response
    local success, err = pcall(function()
        response = HttpService:GetAsync("https://wrealaero.github.io/IcicleKeyGen/", true)
    end)

    getgenv().Key = (success and response and response ~= "") and response or "InvalidKey"
end

fetchKey()

-- File check functions
local isfile = function(file)
    local success, result = pcall(function()
        return readfile(file)
    end)
    return success and result ~= nil and result ~= ''
end

local delfile = function(file)
    local success, err = pcall(function()
        writefile(file, '')
    end)
    return success, err
end

local function downloadFile(path, func)
    if not isfile(path) then
        local success, response = pcall(function()
            return game:HttpGet('https://raw.githubusercontent.com/miacheats/VapeV4ForRoblox/' .. readfile('newvape/profiles/commit.txt') .. '/' .. select(1, path:gsub('newvape/', '')), true)
        end)
        if not success or response == '404: Not Found' then
            error("Failed to download file: " .. (response or "Unknown error"))
        end
        writefile(path, response)
    end
    return (func or readfile)(path)
end

local function wipeFolder(path)
    if not isfolder(path) then return end
    for _, file in pairs(listfiles(path)) do
        if isfile(file) then
            local success, fileContent = pcall(function()
                return readfile(file)
            end)
            if success and fileContent and fileContent:find('--This watermark is used') then
                delfile(file)
            end
        end
    end
end

-- Folder creation and wipe logic
for _, folder in pairs({'newvape', 'newvape/games', 'newvape/profiles', 'newvape/assets', 'newvape/libraries', 'newvape/guis'}) do
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

-- Load the main vape script
local function loadVapeScript()
    local success, script = pcall(function()
        return downloadFile('newvape/main.lua')
    end)
    if success then
        loadstring(script, 'main')()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Failed to load Vape script!",
            Duration = 5,
        })
    end
end

SubmitButton.MouseButton1Click:Connect(function()
    if not getgenv().Key or getgenv().Key == "InvalidKey" then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Invalid or missing key! Get a valid key from .gg/icicle",
            Duration = 5,
        })
        return
    end 

    if KeySystem.Text == getgenv().Key and KeySystem.Text:match("%S") then
        screenGui:Destroy()
        loadVapeScript()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Access Denied",
            Text = "Incorrect key! Get the correct key from .gg/icicle",
            Duration = 5,
        })
    end
end)

GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://link-hub.net/1233399/icicle-key-generator")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System",
        Text = "Link copied! Paste this on your browser",
        Duration = 5,
    })
end)
