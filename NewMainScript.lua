local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = screenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Universal Key System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

local KeySystem = Instance.new("TextBox")
KeySystem.Size = UDim2.new(0.9, 0, 0, 40)
KeySystem.Position = UDim2.new(0.05, 0, 0.2, 0)
KeySystem.Text = "Enter the Key"
KeySystem.TextColor3 = Color3.new(1, 1, 1)
KeySystem.BackgroundTransparency = 0.3
KeySystem.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeySystem.Font = Enum.Font.Gotham
KeySystem.TextSize = 16
KeySystem.Parent = frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.9, 0, 0, 40)
SubmitButton.Position = UDim2.new(0.05, 0, 0.45, 0)
SubmitButton.Text = "Submit"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitButton.Parent = frame

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.9, 0, 0, 40)
GetKeyButton.Position = UDim2.new(0.05, 0, 0.7, 0)
GetKeyButton.Text = "Get Key"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextColor3 = Color3.new(1, 1, 1)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
GetKeyButton.Parent = frame

local DiscordButton = Instance.new("TextButton")
DiscordButton.Size = UDim2.new(0.9, 0, 0, 40)
DiscordButton.Position = UDim2.new(0.05, 0, 0.9, 0)
DiscordButton.Text = "Join Discord"
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.TextColor3 = Color3.new(1, 1, 1)
DiscordButton.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
DiscordButton.Parent = frame

SubmitButton.MouseButton1Click:Connect(function()
    if KeySystem.Text == getgenv().Key and KeySystem.Text ~= nil and KeySystem.Text ~= "" then
        screenGui:Destroy()
        
        local isfile = function(file)
            local success, result = pcall(function()
                return readfile(file)
            end)
            return success and result ~= nil and result ~= ''
        end

        local delfile = function(file)
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

        loadstring(downloadFile('newvape/main.lua'), 'main')()
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

DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/icicle")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord Invite";
        Text = "Discord link copied! Paste this in your browser.";
        Duration = 5;
    })
end)
