if getgenv().keyCorrect then return end  -- Prevent GUI from appearing again

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
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 8)

UIStroke.Parent = Frame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(100, 100, 255)

TextLabel.Parent = Frame
TextLabel.Text = "Enter Key:"
TextLabel.TextSize = 18
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.5, -100, 0.2, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 20)
TextLabel.TextXAlignment = Enum.TextXAlignment.Center

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.Position = UDim2.new(0.5, -100, 0.4, 0)
TextBox.Size = UDim2.new(0, 200, 0, 30)
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Paste Key Here"
TextBox.TextXAlignment = Enum.TextXAlignment.Center

ConfirmButton.Parent = Frame
ConfirmButton.Text = "Confirm"
ConfirmButton.Position = UDim2.new(0.5, -100, 0.7, 0)
ConfirmButton.Size = UDim2.new(0, 200, 0, 30)
ConfirmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmButton.TextXAlignment = Enum.TextXAlignment.Center

UICorner:Clone().Parent = TextBox
UICorner:Clone().Parent = ConfirmButton

ConfirmButton.MouseButton1Click:Connect(function()
    if TextBox.Text == key then
        getgenv().keyCorrect = true
        ScreenGui:Destroy()  -- Remove GUI after correct key entry
        loadVapeScript() -- Load Vape script
    else
        TextLabel.Text = "Incorrect Key. Try Again."
    end
end)

function loadVapeScript()
    repeat task.wait() until game:IsLoaded()
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
                return game:HttpGet('https://raw.githubusercontent.com/wrealaero/IcicleV4/main/'..path, true)
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
                    return game:HttpGet('https://raw.githubusercontent.com/wrealaero/IcicleV4/main/games/'..game.PlaceId..'.lua', true)
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
