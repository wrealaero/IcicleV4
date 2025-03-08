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

-- Set your manual key here (Change this key whenever you want)
local manualKey = "YOUR_MANUAL_KEY"  -- Replace with your key

-- Key Verification
submitButton.MouseButton1Click:Connect(function()
    if keyBox.Text == manualKey and keyBox.Text ~= "" then
        screenGui:Destroy()
        
        -- File management functions
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
        
        -- Create necessary folders if they don't exist
        for _, folder in {'newvape', 'newvape/games', 'newvape/profiles', 'newvape/assets', 'newvape/libraries', 'newvape/guis'} do
            if not isfolder(folder) then
                makefolder(folder)
            end
        end
        
        -- Commit check (for script update)
        if not shared.VapeDeveloper then
            local commit = "main"
            if isfile('newvape/profiles/commit.txt') and readfile('newvape/profiles/commit.txt') ~= commit then
                wipeFolder('newvape')
            end
            writefile('newvape/profiles/commit.txt', commit)
        end
        
        -- Load the main script (adjust the URL to your specific one)
        loadstring(downloadFile('newvape/main.lua'), 'main')()
    else
        -- Incorrect key notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Access Denied";
            Text = "Incorrect key! Get the correct key from the website.";
            Duration = 5;
        })
    end
end)

-- Get Key Button Function
getKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://your-website.com")  -- Replace with the URL to your key generator website
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System";
        Text = "Link copied! Paste this on your browser";
        Duration = 5;
    })
end)

-- Discord Button Function
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/yourdiscordlink")  -- Replace with your Discord invite link
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord";
        Text = "Invite copied! Join our Discord";
        Duration = 5;
    })
end)
