-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.Enabled = false

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = screenGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

-- Stroke
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120, 0, 255)
stroke.Thickness = 2
stroke.Parent = frame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 15)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "VeLix Hub"
titleLabel.TextColor3 = Color3.fromRGB(170, 85, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 24
titleLabel.Parent = frame

-- Password Box
local passwordBox = Instance.new("TextBox")
passwordBox.Size = UDim2.new(0, 280, 0, 38)
passwordBox.Position = UDim2.new(0.5, -140, 0.4, 0)
passwordBox.PlaceholderText = "Enter Key..."
passwordBox.Text = ""
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 16
passwordBox.TextColor3 = Color3.new(1,1,1)
passwordBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
passwordBox.BorderSizePixel = 0
passwordBox.Parent = frame

Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

-- Submit Button
local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0, 130, 0, 38)
submitButton.Position = UDim2.new(0.5, -140, 0.62, 0)
submitButton.Text = "Login"
submitButton.Font = Enum.Font.GothamBold
submitButton.TextSize = 15
submitButton.TextColor3 = Color3.new(1,1,1)
submitButton.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
submitButton.BorderSizePixel = 0
submitButton.Parent = frame

Instance.new("UICorner", submitButton).CornerRadius = UDim.new(0, 8)

-- Get Key Button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(0, 130, 0, 38)
getKeyButton.Position = UDim2.new(0.5, 10, 0.62, 0)
getKeyButton.Text = "Get Key"
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.TextSize = 15
getKeyButton.TextColor3 = Color3.new(1,1,1)
getKeyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
getKeyButton.BorderSizePixel = 0
getKeyButton.Parent = frame

Instance.new("UICorner", getKeyButton).CornerRadius = UDim.new(0, 8)

-- Password
local correctPassword = "password123"

local function enableGui()
    screenGui.Enabled = true

    frame:TweenSize(
        UDim2.new(0, 380, 0, 230),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quart,
        0.35
    )

    frame:TweenPosition(
        UDim2.new(0.5, -190, 0.5, -115),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quart,
        0.35
    )
end

local function checkPassword()
    if passwordBox.Text == correctPassword then

        frame:TweenSize(
            UDim2.new(0,0,0,0),
            Enum.EasingDirection.In,
            Enum.EasingStyle.Quart,
            0.25,
            true
        )

        wait(0.3)

        screenGui.Enabled = false

        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/VexltyzXD/BloxFruits/refs/heads/Premium/TrueV1(BloxFruits).lua"
        ))()

    else
        passwordBox.Text = ""
        passwordBox.PlaceholderText = "Wrong Key!"
    end
end

submitButton.MouseButton1Click:Connect(checkPassword)

passwordBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkPassword()
    end
end)

getKeyButton.MouseButton1Click:Connect(function()
    toclipboard("GetKey")
end)

wait(1)
enableGui()
