repeat task.wait() until game:IsLoaded()

-- Key system
local validKey = "123"  -- Replace this with your actual key

local function requestKey()
    local player = game:GetService("Players").LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    
    if not playerGui then
        repeat task.wait() until player:FindFirstChild("PlayerGui")
        playerGui = player:FindFirstChild("PlayerGui")
    end

    -- Remove old UI if it exists
    local existingGui = playerGui:FindFirstChild("KeyPrompt")
    if existingGui then
        existingGui:Destroy()
    end

    -- Create new Key UI
    local keyGui = Instance.new("ScreenGui", playerGui)
    keyGui.Name = "KeyPrompt"

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = keyGui

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -20, 0, 50)
    textBox.Position = UDim2.new(0, 10, 0, 40)
    textBox.PlaceholderText = "Enter Key..."
    textBox.Text = ""
    textBox.Parent = frame

    local submitButton = Instance.new("TextButton")
    submitButton.Size = UDim2.new(1, -20, 0, 40)
    submitButton.Position = UDim2.new(0, 10, 0, 100)
    submitButton.Text = "Submit"
    submitButton.Parent = frame

    submitButton.MouseButton1Click:Connect(function()
        local inputKey = textBox.Text:gsub("%s+", "") -- Trim whitespace
        if inputKey == validKey then
            keyGui:Destroy()
            print("Key accepted. Loading Vape...")
            loadVape()
        else
            textBox.Text = "Invalid Key!"
            task.wait(1)
            textBox.Text = ""
        end
    end)
end

-- Function to load Vape only if key is correct
local function loadVape()
    print("Loading Vape...")  -- Debug message
    if shared.vape then shared.vape:Uninject() end
    getgenv().getcustomasset = nil

    if identifyexecutor then
        if table.find({'Argon', 'Wave'}, ({identifyexecutor()})[1]) then
            getgenv().setthreadidentity = nil
        end
    end

    local vape
    local loadstring = function(...)
        local res, err = loadstring(...)
        if err and vape then
            vape:CreateNotification('Vape', 'Failed to load : '..err, 30, 'alert')
        end
        return res
    end

    local queue_on_teleport = queue_on_teleport or function() end
    local isfile = isfile or function(file)
        local suc, res = pcall(function() return readfile(file) end)
        return suc and res ~= nil and res ~= ''
    end
    local cloneref = cloneref or function(obj) return obj end
    local playersService = cloneref(game:GetService('Players'))

    local function downloadFile(path, func)
        if not isfile(path) then
            local suc, res = pcall(function()
                return game:HttpGet('https://raw.githubusercontent.com/ImDamc/VapeV4Reborn/main/'..path, true)
            end)
            if not suc or res == '404: Not Found' then
                error(res)
            end
            if path:find('.lua') then
                res = '-- This watermark is used to delete the file if its cached, remove it to persist.\n'..res
            end
            writefile(path, res)
        end
        return (func or readfile)(path)
    end

    local function finishLoading()
        vape.Init = nil
        vape:Load()
        task.spawn(function()
            repeat
                vape:Save()
                task.wait(10)
            until not vape.Loaded
        end)

        vape:Clean(playersService.LocalPlayer.OnTeleport:Connect(function()
            if not shared.VapeIndependent then
                local teleportScript = [[
                    repeat task.wait() until game.HttpGet ~= nil
                    shared.vapereload = true
                    if shared.VapeDeveloper then
                        loadstring(readfile('newvape/loader.lua'), 'loader')()
                    else
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/ImDamc/VapeV4Reborn/main/main.lua", true))()
                    end
                ]]
                vape:Save()
                queue_on_teleport(teleportScript)
            end
        end))

        if not shared.vapereload and vape.Categories then
            vape:CreateNotification('Finished Loading', 'Press the GUI button to open', 5)
        end
    end

    if not isfile('newvape/profiles/gui.txt') then
        writefile('newvape/profiles/gui.txt', 'new')
    end
    local gui = readfile('newvape/profiles/gui.txt')

    if not isfolder('newvape/assets/'..gui) then
        makefolder('newvape/assets/'..gui)
    end
    vape = loadstring(downloadFile('newvape/guis/'..gui..'.lua'), 'gui')()
    shared.vape = vape

    if not shared.VapeIndependent then
        loadstring(downloadFile('newvape/games/universal.lua'), 'universal')()
        if isfile('newvape/games/'..game.PlaceId..'.lua') then
            loadstring(readfile('newvape/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))()
        else
            local suc, res = pcall(function()
                return game:HttpGet('https://raw.githubusercontent.com/ImDamc/VapeV4Reborn/main/games/'..game.PlaceId..'.lua', true)
            end)
            if suc and res ~= '404: Not Found' then
                loadstring(downloadFile('newvape/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))()
            end
        end
        finishLoading()
    else
        vape.Init = finishLoading
        return vape
    end
end

requestKey()  -- Start the key request process
