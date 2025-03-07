if getgenv().keyCorrect then return end

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
        
        -- Ensure Vape loads only once
if not getgenv().vapeLoaded then
    getgenv().vapeLoaded = true -- Ensure it loads only once
    task.spawn(function()
        task.wait(0.5)
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
    end)
end
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

if identifyexecutor then
    local success, result = pcall(identifyexecutor)
    if success and table.find({'Argon', 'Wave'}, result) then
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
    local maxAttempts = 3
    for attempt = 1, maxAttempts do
        local suc, res = pcall(function()
            return game:HttpGet('https://raw.githubusercontent.com/ImDamc/VapeV4Reborn/main/'..path, true)
        end)
        if suc and res ~= '404: Not Found' then
            if path:find('.lua') then
                res = '-- Cache Control: Remove this line to keep file after updates.\n'..res
            end
            writefile(path, res)
            return (func or readfile)(path)
        end
        task.wait(1) -- Retry after waiting
    end
    error("Failed to download: " .. path)
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
