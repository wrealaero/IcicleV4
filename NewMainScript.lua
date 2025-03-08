local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundTransparency = 0.1
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)  -- Darker background with slight transparency
frame.BorderSizePixel = 0  -- No border
frame.Parent = screenGui
frame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Title Label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, -40)
title.Text = "Icicle Key System"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.TextAlignment = Enum.TextAlignment.Center
title.Parent = frame

-- Dragging functionality
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
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Key System TextBox
local keySystem = Instance.new("TextBox")
keySystem.Size = UDim2.new(0.8, 0, 0.2, 0)
keySystem.Position = UDim2.new(0.5, -150, 0.3, 0)
keySystem.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  -- Dark background with slight transparency
keySystem.TextColor3 = Color3.fromRGB(255, 255, 255)
keySystem.TextSize = 18
keySystem.Font = Enum.Font.Gotham
keySystem.BorderSizePixel = 0
keySystem.BackgroundTransparency = 0.3
keySystem.PlaceholderText = "Enter the Key"
keySystem.Parent = frame

-- Submit Button
local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.8, 0, 0.2, 0)
submitButton.Position = UDim2.new(0.5, -150, 0.6, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)  -- Blue
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextSize = 18
submitButton.Font = Enum.Font.Gotham
submitButton.Text = "Submit"
submitButton.BorderSizePixel = 0
submitButton.Parent = frame

submitButton.MouseEnter:Connect(function()
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 105, 217)  -- Hover color
end)

submitButton.MouseLeave:Connect(function()
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
end)

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -50, 0, -50)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.BorderSizePixel = 0
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Get Key Button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(0.8, 0, 0.2, 0)
getKeyButton.Position = UDim2.new(0.5, -150, 0.8, 0)
getKeyButton.BackgroundColor3 = Color3.fromRGB(34, 193, 195)
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextSize = 18
getKeyButton.Font = Enum.Font.Gotham
getKeyButton.Text = "Get Key"
getKeyButton.BorderSizePixel = 0
getKeyButton.Parent = frame

getKeyButton.MouseEnter:Connect(function()
    getKeyButton.BackgroundColor3 = Color3.fromRGB(24, 162, 164)  -- Hover color
end)

getKeyButton.MouseLeave:Connect(function()
    getKeyButton.BackgroundColor3 = Color3.fromRGB(34, 193, 195)
end)

-- Clipboard action for the "Get Key" button
getKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://link-hub.net/1233399/icicle-key-generator")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System",
        Text = "Link copied! Paste this on your browser",
        Duration = 5,
    })
end)

-- Fetch key logic
local HttpService = game:GetService("HttpService")
local function fetchKey()
    local success, response = pcall(function()
        return HttpService:GetAsync("https://wrealaero.github.io/IcicleKeyGen/")
    end)

    if success and response then
        getgenv().Key = response
    else
        getgenv().Key = "InvalidKey"
    end
end

fetchKey()

submitButton.MouseButton1Click:Connect(function()
    if not getgenv().Key or getgenv().Key == "InvalidKey" then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Invalid or missing key! Get a valid key from .gg/icicle",
            Duration = 5,
        })
        return
    end

    if keySystem.Text == getgenv().Key and keySystem.Text ~= "" then
        screenGui:Destroy()
        -- Your subsequent code logic...
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Access Denied",
            Text = "Incorrect key! Get the correct key from .gg/icicle",
            Duration = 5,
        })
    end
end)

    if KeySystem.Text == getgenv().Key and KeySystem.Text ~= nil and KeySystem.Text ~= "" then
        screenGui:Destroy()

        local isfile = isfile or function(file)
            local success, result = pcall(function()
                return readfile(file)
            end)
            return success and result ~= nil and result ~= ''
        end

        local delfile = delfile or function(file)
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

        return loadstring(downloadFile('newvape/main.lua'), 'main')()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Access Denied";
            Text = "Incorrect key! Get the correct key from .gg/icicle";
            Duration = 5;
        })
    end
end)

GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://link-hub.net/1233399/icicle-key-generator")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System";
        Text = "Link copied! Paste this on your browser";
        Duration = 5;
    })
end)
