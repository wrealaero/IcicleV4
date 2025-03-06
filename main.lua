repeat task.wait() until game:IsLoaded()

-- Key system
local validKey = "YOUR_SECRET_KEY_HERE"  -- Replace this with your actual key
local userInputKey

local function requestKey()
    repeat
        userInputKey = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("KeyPrompt") or Instance.new("ScreenGui")
        userInputKey.Name = "KeyPrompt"
        userInputKey.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

        local frame = Instance.new("Frame", userInputKey)
        frame.Size = UDim2.new(0, 300, 0, 150)
        frame.Position = UDim2.new(0.5, -150, 0.5, -75)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

        local textBox = Instance.new("TextBox", frame)
        textBox.Size = UDim2.new(1, -20, 0, 50)
        textBox.Position = UDim2.new(0, 10, 0, 40)
        textBox.PlaceholderText = "Enter Key..."
        textBox.Text = ""

        local submitButton = Instance.new("TextButton", frame)
        submitButton.Size = UDim2.new(1, -20, 0, 40)
        submitButton.Position = UDim2.new(0, 10, 0, 100)
        submitButton.Text = "Submit"

        submitButton.MouseButton1Click:Connect(function()
            if textBox.Text == validKey then
                userInputKey:Destroy()
                loadVape()
            else
                textBox.Text = "Invalid Key!"
                task.wait(1)
                textBox.Text = ""
            end
        end)
    until false
end

-- Function to load Vape only if key is correct
local function loadVape()
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
        local suc, res = pcall(function()
            return readfile(file)
        end)
        return suc and res ~= nil and res ~= ''
    end
    local cloneref = cloneref or function(obj)
        return obj
    end
    local playersService = cloneref(game:GetService('Players'))

    local function downloadFile(path, func)
        if not isfile(path) then
            local suc, res = pcall(function()
                return game:HttpGet('https://raw.githubusercontent.com/ImDamc/VapeV4Reborn/refs/heads/main/'..'/'..select(1, path:gsub('newvape/', '')), true)
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

    local function finishLoading()
        vape.Init = nil
        vape:Load()
        task.spawn(function()
            repeat
                vape:Save()
                task.wait(10)
            until not vape.Loaded
        end)

        local teleportedServers
        vape:Clean(playersService.LocalPlayer.OnTeleport:Connect(function()
            if (not teleportedServers) and (not shared.VapeIndependent) then
                teleportedServers = true
                local teleportScript = [[
                    repeat task.wait() until game.HttpGet ~= nil
                    shared.vapereload = true
                    if shared.VapeDeveloper then
                        loadstring(readfile('newvape/loader.lua'), 'loader')()
                    else
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/ImDamc/VapeV4Reborn/refs/heads/main/main.lua", true))()
                    end
                ]]
                if shared.VapeDeveloper then
                    teleportScript = 'shared.VapeDeveloper = true\n'..teleportScript
                end
                if shared.VapeCustomProfile then
                    teleportScript = 'shared.VapeCustomProfile = "'..shared.VapeCustomProfile..'"\n'..teleportScript
                end
                vape:Save()
                queue_on_teleport(teleportScript)
            end
        end))

        if not shared.vapereload then
            if not vape.Categories then return end
            if vape.Categories.Main.Options['GUI bind indicator'].Enabled then
                vape:CreateNotification('Finished Loading', vape.VapeButton and 'Press the button in the top right to open GUI' or 'Press '..table.concat(vape.Keybind, ' + '):upper()..' to open GUI', 5)
            end
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
            loadstring(readfile('newvape/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(...)
        else
            if not shared.VapeDeveloper then
                local suc, res = pcall(function()
                    return game:HttpGet('https://raw.githubusercontent.com/ImDamc/VapeV4Reborn'..readfile('newvape/profiles/commit.txt')..'/games/'..game.PlaceId..'.lua', true)
                end)
                if suc and res ~= '404: Not Found' then
                    loadstring(downloadFile('newvape/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(...)
                end
            end
        end
        finishLoading()
    else
        vape.Init = finishLoading
        return vape
    end
end

requestKey()  -- Start the key request process
