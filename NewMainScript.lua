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
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Key TextBox
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
keyBox.PlaceholderText = "Enter Key"
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.TextScaled = true
keyBox.Parent = mainFrame

-- Submit Button
submitButton.Size = UDim2.new(0.8, 0, 0, 40)
submitButton.Position = UDim2.new(0.1, 0, 0.35, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitButton.Text = "Submit Key"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextSize = 18
submitButton.Parent = mainFrame

submitButton.MouseButton1Click:Connect(function()
    if keyBox.Text == "123" then  -- Change this to your actual key
        -- Success Notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Success!";
            Text = "Key Verified! Loading script...";
            Duration = 5;
        })

        -- Load the script with error handling
        local function downloadFile(path)
            local success, response = pcall(function()
                return game:HttpGet("https://raw.githubusercontent.com/wrealaero/AeroutV4/main/" .. path, true)
            end)
            
            if success and response then
                local loadSuccess, err = pcall(function()
                    return loadstring(response)()
                end)
                
                if not loadSuccess then
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Error";
                        Text = "Failed to load script: " .. err;
                        Duration = 5;
                    })
                    return false
                end
                return true
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Error";
                    Text = "Failed to download script.";
                    Duration = 5;
                })
                return false
            end
        end

        if downloadFile("newvape/main.lua") then
            screenGui:Destroy()  -- Destroy the GUI only if the script loads successfully
        end
    else
        -- Access Denied Notification
        game.StarterGui:SetCore("SendNotification", {
            Title = "Access Denied";
            Text = "Incorrect key! Get the correct key from the website.";
            Duration = 5;
        })
    end
end)
