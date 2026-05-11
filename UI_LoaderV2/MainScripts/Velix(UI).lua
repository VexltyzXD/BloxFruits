--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.Enabled = false

-- Create the frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.new(1, 0, 0)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.new(0.5, 0, 0)
frame.Parent = screenGui

-- Create the password box
local passwordBox = Instance.new("TextBox")
passwordBox.Size = UDim2.new(0, 250, 0, 30)
passwordBox.Position = UDim2.new(0.5, -125, 0.4, 0)
passwordBox.Text = ""
passwordBox.PlaceholderText = "Enter Password"
passwordBox.BackgroundColor3 = Color3.new(0.7, 0, 0)
passwordBox.TextColor3 = Color3.new(1, 1, 1)
passwordBox.BorderSizePixel = 1
passwordBox.BorderColor3 = Color3.new(0.3, 0, 0)
passwordBox.Parent = frame

-- Create the submit button
local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0, 100, 0, 30)
submitButton.Position = UDim2.new(0.5, -50, 0.6, 0)
submitButton.Text = "Submit"
submitButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
submitButton.TextColor3 = Color3.new(1, 1, 1)
submitButton.BorderSizePixel = 1
submitButton.BorderColor3 = Color3.new(0.3, 0, 0)
submitButton.Parent = frame

-- Create the get key button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(0, 100, 0, 30)
getKeyButton.Position = UDim2.new(0.5, -50, 0.7, 0)
getKeyButton.Text = "Get Key" 
getKeyButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
getKeyButton.TextColor3 = Color3.new(1, 1, 1)
getKeyButton.BorderSizePixel = 1
getKeyButton.BorderColor3 = Color3.new(0.3, 0, 0)
getKeyButton.Parent = frame

-- Create the title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 0, 30)
titleLabel.Position = UDim2.new(0.5, -100, 0.2, 0)
titleLabel.Text = "Password Required"
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.FontSize = Enum.FontSize.Size24
titleLabel.Parent = frame

-- Create the script
local correctPassword = "password123" -- password here
local code = "print('VeLix Hub, Welcome!')"

local function enableGui()
    screenGui.Enabled = true
    frame:TweenSize(UDim2.new(0, 400, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.5)
    frame:TweenPosition(UDim2.new(0.5, -200, 0.5, -175), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.5)
end

local function checkPassword()
    if passwordBox.Text == correctPassword then
        frame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.5, true, function()
            screenGui.Enabled = false
            local func, err = 
loadstring(game:HttpGet("https://raw.githubusercontent.com/VexltyzXD/BloxFruits/refs/heads/Premium/TrueV1(BloxFruits).lua"))()
            if func then
                func()
            else
                warn(err)
            end
        end)
    else
        print("Password incorrect")
        passwordBox.Text = ""
    end
end

getKeyButton.MouseButton1Click:Connect(function()
toclipboard("GetKey") -- how the player get your key
end)

wait(1)
enableGui()

submitButton.MouseButton1Click:Connect(checkPassword)
passwordBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkPassword()
    end
end)
