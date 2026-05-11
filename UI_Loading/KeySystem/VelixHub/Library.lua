--// VeLix Hub Premium Rainbow UI FULL FIXED

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- REMOVE OLD GUI
pcall(function()
	if player.PlayerGui:FindFirstChild("VeLixHub") then
		player.PlayerGui:FindFirstChild("VeLixHub"):Destroy()
	end
end)

pcall(function()
	if Lighting:FindFirstChild("VeLixBlur") then
		Lighting.VeLixBlur:Destroy()
	end
end)

-- BLUR
local blur = Instance.new("BlurEffect")
blur.Name = "VeLixBlur"
blur.Size = 10
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
box.Position = UDim2.new(0.5,-150,0.35,0)
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

-- SOUND SYSTEM
local Sounds = {
	Correct = "rbxassetid://906042564",
	Wrong = "rbxassetid://2865228021",
	Copy = "rbxassetid://6534947240",
	Open = "rbxassetid://9120289498",
	Click = "rbxassetid://6895079853"
}

local function PlaySound(name,volume)

	local sound = Instance.new("Sound")

	sound.SoundId = Sounds[name]
	sound.Volume = volume or 1
	sound.Parent = gui

	sound:Play()

	Debris:AddItem(sound,5)
end

-- MODERN NOTIFICATION
local notifFrame = Instance.new("Frame")
notifFrame.Size = UDim2.new(0,0,0,75)
notifFrame.Position = UDim2.new(1,-15,0.05,0)
notifFrame.AnchorPoint = Vector2.new(1,0)
notifFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
notifFrame.BorderSizePixel = 0
notifFrame.ClipsDescendants = true
notifFrame.Parent = gui

Instance.new("UICorner",notifFrame).CornerRadius = UDim.new(0,14)

local notifStroke = Instance.new("UIStroke")
notifStroke.Thickness = 2
notifStroke.Color = Color3.fromRGB(120,0,255)
notifStroke.Parent = notifFrame

local notifIcon = Instance.new("TextLabel")
notifIcon.Size = UDim2.new(0,40,0,40)
notifIcon.Position = UDim2.new(0,10,0.5,-20)
notifIcon.BackgroundTransparency = 1
notifIcon.Text = "🔔"
notifIcon.TextScaled = true
notifIcon.Parent = notifFrame

local notifTitle = Instance.new("TextLabel")
notifTitle.Size = UDim2.new(1,-60,0,24)
notifTitle.Position = UDim2.new(0,55,0,12)
notifTitle.BackgroundTransparency = 1
notifTitle.Text = "VeLix Hub"
notifTitle.Font = Enum.Font.GothamBold
notifTitle.TextSize = 15
notifTitle.TextColor3 = Color3.new(1,1,1)
notifTitle.TextXAlignment = Enum.TextXAlignment.Left
notifTitle.Parent = notifFrame

local notifText = Instance.new("TextLabel")
notifText.Size = UDim2.new(1,-60,0,20)
notifText.Position = UDim2.new(0,55,0,38)
notifText.BackgroundTransparency = 1
notifText.Text = ""
notifText.Font = Enum.Font.Gotham
notifText.TextSize = 13
notifText.TextColor3 = Color3.fromRGB(220,220,220)
notifText.TextXAlignment = Enum.TextXAlignment.Left
notifText.Parent = notifFrame

local notifyBusy = false

local function Notify(msg,color,emoji)

	if notifyBusy then return end
	notifyBusy = true

	notifText.Text = msg
	notifStroke.Color = color
	notifIcon.Text = emoji or "🔔"

	notifFrame.Size = UDim2.new(0,0,0,75)

	TweenService:Create(
		notifFrame,
		TweenInfo.new(0.35,Enum.EasingStyle.Quart),
		{
			Size = UDim2.new(0,290,0,75)
		}
	):Play()

	wait(3)

	TweenService:Create(
		notifFrame,
		TweenInfo.new(0.3,Enum.EasingStyle.Quart),
		{
			Size = UDim2.new(0,0,0,75)
		}
	):Play()

	wait(0.4)

	notifyBusy = false
end

-- BUTTON FUNCTION
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

	btn.MouseButton1Click:Connect(function()
		PlaySound("Click",0.7)
	end)

	return btn
end

-- BUTTONS
local login = CreateButton(
	"Login",
	UDim2.new(0.5,-145,0.58,0),
	Color3.fromRGB(120,0,255)
)

local getkey = CreateButton(
	"Get Key",
	UDim2.new(0.5,20,0.58,0),
	Color3.fromRGB(45,45,45)
)

local discord = CreateButton(
	"Discord",
	UDim2.new(0.5,-62,0.76,0),
	Color3.fromRGB(0,120,255)
)

-- RAINBOW EFFECT
task.spawn(function()

	while true do

		for i = 0,1,0.005 do

			stroke.Color = Color3.fromHSV(i,1,1)

			wait()
		end
	end
end)

-- PARTICLES
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

		e.Position = UDim2.new(math.random(),0,-0.1,0)

		e.Parent = gui

		TweenService:Create(
			e,
			TweenInfo.new(math.random(3,5)),
			{
				Position = UDim2.new(
					e.Position.X.Scale,
					0,
					1.2,
					0
				),
				TextTransparency = 1,
				Rotation = math.random(-360,360)
			}
		):Play()

		Debris:AddItem(e,5)

		wait(0.45)
	end
end)

-- DRAGGING
local dragging = false
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

-- OPEN UI
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

PlaySound("Open",1)

-- MULTI KEY SYSTEM

local Keys = {
	"Key1",
	"Key2",
	"Key3",
	"Key4"
}

local function Login()

	local Correct = false

	for _,v in pairs(Keys) do

		if box.Text == v then
			Correct = true
			break
		end
	end

	if Correct then

		PlaySound("Correct",1)

		Notify(
			"Correct Key!",
			Color3.fromRGB(0,255,120),
			"✅"
		)

		wait(1)

		gui.Enabled = false

		if blur then
			blur:Destroy()
		end

		loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/VexltyzXD/BloxFruits/refs/heads/Premium/TrueV1(BloxFruits).lua"
		))()

	else

		box.Text = ""

		PlaySound("Wrong",1)

		Notify(
			"Wrong Key!",
			Color3.fromRGB(255,60,60),
			"❌"
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

-- GET KEY
getkey.MouseButton1Click:Connect(function()

	PlaySound("Copy",1)

	toclipboard("https://your-key-link.com")

	Notify(
		"GetKey Copied!",
		Color3.fromRGB(255,255,0),
		"🔑"
	)
end)

-- DISCORD
discord.MouseButton1Click:Connect(function()

	PlaySound("Copy",1)

	toclipboard("https://discord.gg/yourserver")

	Notify(
		"Discord Copied!",
		Color3.fromRGB(0,170,255),
		"💬"
	)
end)
