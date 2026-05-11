--// VeLix Hub Premium Rainbow UI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- REMOVE OLD GUI
pcall(function()
	player.PlayerGui:FindFirstChild("VeLixHub"):Destroy()
end)

-- BLUR
pcall(function()
	if Lighting:FindFirstChild("VeLixBlur") then
		Lighting.VeLixBlur:Destroy()
	end
end)

local blur = Instance.new("BlurEffect")
blur.Name = "VeLixBlur"
blur.Size = 12
blur.Parent = Lighting

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "VeLixHub"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,0,0,0)
frame.Position = UDim2.new(0.5,0,0.5,0)
frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,16)

-- STROKE
local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Parent = frame

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,45)
title.Position = UDim2.new(0,0,0,10)
title.BackgroundTransparency = 1
title.Text = "🌈 VeLix Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- PASSWORD BOX
local box = Instance.new("TextBox")
box.Size = UDim2.new(0,300,0,42)
box.Position = UDim2.new(0.5,-150,0.36,0)
box.PlaceholderText = "Enter Key..."
box.Text = ""
box.TextColor3 = Color3.new(1,1,1)
box.PlaceholderColor3 = Color3.fromRGB(170,170,170)
box.BackgroundColor3 = Color3.fromRGB(35,35,35)
box.Font = Enum.Font.Gotham
box.TextSize = 15
box.BorderSizePixel = 0
box.Parent = frame

Instance.new("UICorner",box).CornerRadius = UDim.new(0,10)

-- NOTIFY
local notify = Instance.new("TextLabel")
notify.Size = UDim2.new(1,0,0,30)
notify.Position = UDim2.new(0,0,1,-35)
notify.BackgroundTransparency = 1
notify.Text = ""
notify.Font = Enum.Font.GothamBold
notify.TextSize = 15
notify.TextTransparency = 1
notify.TextColor3 = Color3.new(1,1,1)
notify.Parent = frame

-- SOUND
local function Sound(id,vol)

	local s = Instance.new("Sound")
	s.SoundId = "rbxassetid://"..id
	s.Volume = vol or 1
	s.Parent = gui

	s:Play()

	Debris:AddItem(s,5)
end

-- NOTIFY
local debounce = false

local function Notify(text,color,sound)

	if debounce then return end
	debounce = true

	notify.Text = text
	notify.TextColor3 = color

	if sound then
		Sound(sound,1)
	end

	TweenService:Create(
		notify,
		TweenInfo.new(0.25),
		{TextTransparency = 0}
	):Play()

	wait(2)

	TweenService:Create(
		notify,
		TweenInfo.new(0.25),
		{TextTransparency = 1}
	):Play()

	wait(0.3)

	debounce = false
end

-- BUTTON CREATOR
local function CreateButton(text,pos,color)

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,125,0,40)
	btn.Position = pos
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	btn.Parent = frame

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,10)

	btn.MouseEnter:Connect(function()

		TweenService:Create(
			btn,
			TweenInfo.new(0.15),
			{
				BackgroundTransparency = 0.15
			}
		):Play()
	end)

	btn.MouseLeave:Connect(function()

		TweenService:Create(
			btn,
			TweenInfo.new(0.15),
			{
				BackgroundTransparency = 0
			}
		):Play()
	end)

	return btn
end

-- BUTTONS
local login = CreateButton(
	"Login",
	UDim2.new(0.5,-145,0.60,0),
	Color3.fromRGB(120,0,255)
)

local getkey = CreateButton(
	"Get Key",
	UDim2.new(0.5,20,0.60,0),
	Color3.fromRGB(45,45,45)
)

local discord = CreateButton(
	"Discord",
	UDim2.new(0.5,-62,0.78,0),
	Color3.fromRGB(0,120,255)
)

-- RAINBOW
task.spawn(function()

	while true do

		for i = 0,1,0.005 do

			stroke.Color = Color3.fromHSV(i,1,1)

			wait()
		end
	end
end)

-- MEME PARTICLES
task.spawn(function()

	local emojis = {
		"💀",
		"🔥",
		"😭",
		"🌈",
		"👻"
	}

	while true do

		local e = Instance.new("TextLabel")

		e.BackgroundTransparency = 1
		e.TextScaled = true
		e.Size = UDim2.new(0,28,0,28)

		e.Text = emojis[math.random(1,#emojis)]

		e.Position = UDim2.new(
			math.random(),
			0,
			-0.1,
			0
		)

		e.Rotation = math.random(-30,30)

		e.Parent = gui

		TweenService:Create(
			e,
			TweenInfo.new(
				math.random(3,5),
				Enum.EasingStyle.Linear
			),
			{
				Position = UDim2.new(
					e.Position.X.Scale,
					0,
					1.2,
					0
				),
				Rotation = math.random(-360,360),
				TextTransparency = 1
			}
		):Play()

		Debris:AddItem(e,5)

		wait(0.45)
	end
end)

-- DRAGGING
local dragging
local dragStart
local startPos

frame.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)

	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- OPEN
frame:TweenSize(
	UDim2.new(0,400,0,280),
	Enum.EasingDirection.Out,
	Enum.EasingStyle.Quart,
	0.4,
	true
)

frame:TweenPosition(
	UDim2.new(0.5,-200,0.5,-140),
	Enum.EasingDirection.Out,
	Enum.EasingStyle.Quart,
	0.4,
	true
)

-- PASSWORD
local key = "password123"

local function Login()

	if box.Text == key then

		Notify(
			"Correct Key!",
			Color3.fromRGB(0,255,120),
			906042564
		)

		wait(1)

		gui.Enabled = false
		blur:Destroy()

		loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/VexltyzXD/BloxFruits/refs/heads/Premium/TrueV1(BloxFruits).lua"
		))()

	else

		box.Text = ""

		Notify(
			"Wrong Key!",
			Color3.fromRGB(255,60,60),
			2865228021
		)
	end
end

-- EVENTS
login.MouseButton1Click:Connect(Login)

box.FocusLost:Connect(function(enter)

	if enter then
		Login()
	end
end)

getkey.MouseButton1Click:Connect(function()

	toclipboard("https://your-key-link.com")

	Notify(
		"GetKey Copied!",
		Color3.fromRGB(255,255,0),
		6534947240
	)
end)

discord.MouseButton1Click:Connect(function()

	toclipboard("https://discord.gg/yourserver")

	Notify(
		"Discord Copied!",
		Color3.fromRGB(0,170,255),
		6534947240
	)
end)
