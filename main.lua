repeat task.wait() until game:IsLoaded()
if shared.vape then shared.vape:Uninject() end

getgenv().getcustomasset = nil

-- Display key input GUI (Draggable)
local key = "YOUR_SECRET_KEY_HERE" -- Change this to your actual key
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

local textLabel = Instance.new("TextLabel")
textLabel.Text = "Enter Key:"
textLabel.Size = UDim2.new(1, 0, 0.3, 0)
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1
textLabel.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0.3, 0)
textBox.Position = UDim2.new(0.1, 0, 0.4, 0)
textBox.Text = ""
textBox.Parent = frame

local submitButton = Instance.new("TextButton")
submitButton.Text = "Submit"
submitButton.Size = UDim2.new(0.8, 0, 0.3, 0)
submitButton.Position = UDim2.new(0.1, 0, 0.75, 0)
submitButton.Parent = frame

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Key Required",
    Text = "Join .gg/icicle for key",
    Duration = 5
})

local keyCorrect = false

submitButton.MouseButton1Click:Connect(function()
    if textBox.Text == key then
        keyCorrect = true
        screenGui:Destroy()
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Key Incorrect",
            Text = "Join .gg/icicle for key",
            Duration = 5
        })
    end
end)

repeat task.wait() until keyCorrect -- Wait until the correct key is entered

-- Continue executing your existing script
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
