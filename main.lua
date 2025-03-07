-- yes, this script was made with GUI to Lua, now shut up
-- around line 112 is where you put your script


local suskey = "123"


local GUI = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Key = Instance.new("ImageLabel")
local Text = Instance.new("TextLabel")
local VerifyFrame = Instance.new("Frame")
local KeyBox = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local VerifyButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UICorner_4 = Instance.new("UICorner")
local GetKey = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local GuiRemoval = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")



GUI.Name = "GUI"
GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Main.Name = "Main"
Main.Parent = GUI
Main.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
Main.BorderColor3 = Color3.fromRGB(27, 42, 53)
Main.Position = UDim2.new(0.413353175, 0, 0.441176474, 0)
Main.Size = UDim2.new(0.172441572, 0, 0.117647059, 0)

UICorner.Parent = Main

Key.Name = "Key"
Key.Parent = Main
Key.BackgroundTransparency = 1.000
Key.Position = UDim2.new(0.435148925, 0, 0.115340024, 0)
Key.Size = UDim2.new(0.128056228, 0, 0.338304013, 0)
Key.ZIndex = 2
Key.Image = "rbxassetid://3926307971"
Key.ImageColor3 = Color3.fromRGB(255, 38, 38)
Key.ImageRectOffset = Vector2.new(44, 324)
Key.ImageRectSize = Vector2.new(36, 36)

Text.Name = "Text"
Text.Parent = Main
Text.BackgroundColor3 = Color3.fromRGB(26, 26, 2)
Text.BackgroundTransparency = 1.000
Text.BorderColor3 = Color3.fromRGB(26, 26, 26)
Text.Position = UDim2.new(0.0327102803, 0, 0.370000005, 0)
Text.Size = UDim2.new(0.934579492, 0, 0.5, 0)
Text.Font = Enum.Font.SourceSansSemibold
Text.Text = "Key Required"
Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Text.TextSize = 35.000
Text.TextWrapped = true

VerifyFrame.Name = "Verify Frame"
VerifyFrame.Parent = GUI
VerifyFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
VerifyFrame.Position = UDim2.new(0.388749182, 0, 0.569411755, 0)
VerifyFrame.Size = UDim2.new(0.222401291, 0, 0.15529412, 0)

KeyBox.Name = "Key Box"
KeyBox.Parent = VerifyFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyBox.Position = UDim2.new(0.216714069, 0, 0.0933334902, 0)
KeyBox.Size = UDim2.new(0.552679658, 0, 0.298396379, 0)
KeyBox.Font = Enum.Font.SourceSansSemibold
KeyBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
KeyBox.PlaceholderText = "Key"
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextScaled = true
KeyBox.TextSize = 14.000
KeyBox.TextWrapped = true

UICorner_2.Parent = KeyBox

VerifyButton.Name = "Verify Button"
VerifyButton.Parent = VerifyFrame
VerifyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
VerifyButton.Position = UDim2.new(0.13767235, 0, 0.491583407, 0)
VerifyButton.Size = UDim2.new(0.724637687, 0, 0.378787875, 0)
VerifyButton.Font = Enum.Font.SourceSansSemibold
VerifyButton.Text = "Verify Key"
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.TextSize = 34.000
VerifyButton.MouseButton1Down:connect(function()
	if KeyBox.Text == suskey then
		local TweenService = game:GetService("TweenService")
		local key = game.Players.LocalPlayer.PlayerGui.GUI.Main.Key
		local info = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false)

		local tween = TweenService:Create(key, info, {ImageColor3 = Color3.fromRGB(106, 255, 106)})

		tween:Play()
		
		game.StarterGui:SetCore("SendNotification", {Title = "correct key", Text = "welcome", Icon = "rbxassetid://12206884774", Duration = 5})

		wait(7)

		GUI.Parent = nil


		repeat task.wait() until game:IsLoaded()
		if shared.vape then shared.vape:Uninject() end
		
		getgenv().getcustomasset = nil
		
		-- why do exploits fail to implement anything correctly? Is it really that hard?
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
					return game:HttpGet('https://raw.githubusercontent.com/wrealaero/IcicleV4/refs/heads/main/'..'/'..select(1, path:gsub('newvape/', '')), true)
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
							loadstring(game:HttpGet("https://raw.githubusercontent.com/wrealaero/IcicleV4/refs/heads/main/main.lua", true))()
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
						return game:HttpGet('https://raw.githubusercontent.com/wrealaero/IcicleV4'..readfile('newvape/profiles/commit.txt')..'/games/'..game.PlaceId..'.lua', true)
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
end)

UICorner_3.Parent = VerifyButton

UICorner_4.Parent = VerifyFrame

GetKey.Name = "GetKey"
GetKey.Parent = VerifyFrame
GetKey.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
GetKey.Position = UDim2.new(0.235357329, 0, -1.38818645, 0)
GetKey.Size = UDim2.new(0.505842388, 0, 0.447802067, 0)
GetKey.Font = Enum.Font.SourceSansSemibold
GetKey.Text = "Get Key"
GetKey.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKey.TextSize = 42.000
GetKey.TextWrapped = true
GetKey.MouseButton1Down:connect(function()
	setclipboard(suskey)
	
	game.StarterGui:SetCore("SendNotification", {Title = "key copied", Text = "the key was copied into your clipboard", Icon = "", Duration = 5})
end)

UICorner_5.Parent = GetKey

GuiRemoval.Name = "Gui Removal"
GuiRemoval.Parent = VerifyFrame
GuiRemoval.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
GuiRemoval.Position = UDim2.new(2.59248304, 0, -0.608146846, 0)
GuiRemoval.Size = UDim2.new(0.126419857, 0, 0.321553528, 0)
GuiRemoval.Font = Enum.Font.SourceSansSemibold
GuiRemoval.Text = "X"
GuiRemoval.TextColor3 = Color3.fromRGB(255, 148, 148)
GuiRemoval.TextSize = 42.000
GuiRemoval.TextWrapped = true
GuiRemoval.MouseButton1Down:connect(function()
	GUI.Parent = nil
	
	game.StarterGui:SetCore("SendNotification", {Title = "i hate you", Text = "i hate you now because you closed the script", Icon = "", Duration = 5})
end)

UICorner_6.Parent = GuiRemoval
