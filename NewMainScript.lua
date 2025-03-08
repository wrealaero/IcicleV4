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
mainFrame.Size = UDim2.new(0, 400, 0, 300)  
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local cornerRadius = Instance.new("UICorner")
cornerRadius.CornerRadius = UDim.new(0, 10)
cornerRadius.Parent = mainFrame

-- Drag Frame
dragFrame.Size = UDim2.new(1, 0, 0, 35)
dragFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
submitButton.Position = UDim2.new(0.1, 0, 0.45, 0)
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

-- Key Verification Logic
submitButton.MouseButton1Click:Connect(function()
    if keyBox.Text == "wfEuSxy5FHA7sKOj" and keyBox.Text ~= "" then  -- Change this to the manual key you set
        screenGui:Destroy()  -- Destroy the GUI upon successful verification

        -- Success Notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Success!";
            Text = "Key Verified! Loading script...";
            Duration = 5;
        })

        -- Load the Script for the VapeV4 Cheat
        local isfile = isfile or function(file)
            local suc, res = pcall(function()
                return readfile(file)
            end)
            return suc and res ~= nil and res ~= ''
        end

        local delfile = delfile or function(file)
            writefile(file, '')
        end

        local function downloadFile(path, func)
            if not isfile(path) then
                local suc, res = pcall(function()
                    return game:HttpGet('https://raw.githubusercontent.com/miacheats/VapeV4ForRoblox/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true)
                end)
                if not suc or res == '404: Not Found' then
                    error(res)
                end
                if path:find('.lua') then
                    res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res
                end
                writefile(path, res)
            end
            return (func or readfile)(path)
        end

        local function wipeFolder(path)
            if not isfolder(path) then return end
            for _, file in listfiles(path) do
                if file:find('loader') then continue end
                if isfile(file) and select(1, readfile(file):find('--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.')) == 1 then
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
            local _, subbed = pcall(function()
                return game:HttpGet('https://github.com/miacheats/VapeV4ForRoblox')
            end)
            local commit = subbed:find('currentOid')
            commit = commit and subbed:sub(commit + 13, commit + 52) or nil
            commit = commit and #commit == 40 and commit or 'main'
            if commit == 'main' or (isfile('newvape/profiles/commit.txt') and readfile('newvape/profiles/commit.txt') or '') ~= commit then
                wipeFolder('newvape')
                wipeFolder('newvape/games')
                wipeFolder('newvape/guis')
                wipeFolder('newvape/libraries')
            end
            writefile('newvape/profiles/commit.txt', commit)
        end

        return loadstring(downloadFile('newvape/main.lua'), 'main')()
        
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
