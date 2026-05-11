--// VeLix Hub Premium Technology UI (Mobile Optimized)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local IsMobile = UIS.TouchEnabled

-- REMOVE OLD UI
pcall(function()
	player.PlayerGui:FindFirstChild("VeLixHub"):Destroy()
end)

pcall(function()
	Lighting:FindFirstChild("VeLixBlur"):Destroy()
end)

-- BLUR
local blur = Instance.new("BlurEffect")
blur.Name = "VeLixBlur"
blur.Size = IsMobile and 5 or 9
blur.Parent = Lighting

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "VeLixHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player.PlayerGui

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,0,0,0)
frame.Position = UDim2.new(0.5,0,0.5,0)

frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BackgroundTransparency = 0.15

frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,18)

-- UI SIZE
local UIWidth = IsMobile and 315 or 370
local UIHeight = IsMobile and 235 or 265

frame:TweenSize(
	UDim2.new(0,UIWidth,0,UIHeight),
	Enum.EasingDirection.Out,
	Enum.EasingStyle.Quart,
	0.35,
	true
)

frame:TweenPosition(
	UDim2.new(0.5,-UIWidth/2,0.5,-UIHeight/2),
	Enum.EasingDirection.Out,
	Enum.EasingStyle.Quart,
	0.35,
	true
)

-- PREMIUM GLOW
local glow = Instance.new("ImageLabel")
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857084"

glow.ImageTransparency = 0.45
glow.Size = UDim2.new(1,100,1,100)

glow.Position = UDim2.new(0,-50,0,-50)
glow.ZIndex = 0
glow.Parent = frame

-- RAINBOW STROKE
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2.2
stroke.Parent = frame

task.spawn(function()

	while true do

		for i = 0,1,0.01 do

			stroke.Color = Color3.fromHSV(i,1,1)

			wait()
		end
	end
end)

-- TITLE
local title = Instance.new("TextLabel")

title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,6)

title.BackgroundTransparency = 1

title.Text = "🌈 VeLix Hub"
title.Font = Enum.Font.GothamBold

title.TextSize = IsMobile and 20 or 24
title.TextColor3 = Color3.new(1,1,1)

title.Parent = frame

task.spawn(function()

	while true do

		for i = 0,1,0.01 do

			title.TextColor3 = Color3.fromHSV(i,1,1)

			wait()
		end
	end
end)

-- KEY BOX
local box = Instance.new("TextBox")

box.Size = UDim2.new(0,UIWidth-50,0,38)
box.Position = UDim2.new(0.5,-((UIWidth-50)/2),0.30,0)

box.BackgroundColor3 = Color3.fromRGB(30,30,30)
box.BackgroundTransparency = 0.15

box.PlaceholderText = "Enter Key..."
box.PlaceholderColor3 = Color3.fromRGB(160,160,160)

box.Text = ""
box.TextColor3 = Color3.new(1,1,1)

box.Font = Enum.Font.Gotham
box.TextSize = 14

box.BorderSizePixel = 0
box.Parent = frame

Instance.new("UICorner",box).CornerRadius = UDim.new(0,12)

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = Color3.fromRGB(0,255,255)
boxStroke.Thickness = 1.5
boxStroke.Parent = box

-- SOUND
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

PlaySound("Open",1)

-- MULTI KEY
local Keys = {
	"Key1",
	"Key2",
	"Key3",
	"Key4"
}

-- SAVE KEY
local SaveFile = "VeLixKey.txt"

local function SaveKey(key)

	if writefile then
		writefile(SaveFile,key)
	end
end

local function LoadKey()

	if isfile and isfile(SaveFile) then
		return readfile(SaveFile)
	end

	return nil
end

local Saved = LoadKey()

if Saved then
	box.Text = Saved
end

-- NOTIFY
local notif = Instance.new("Frame")

notif.Size = UDim2.new(0,0,0,68)
notif.Position = UDim2.new(1,-10,0.05,0)

notif.AnchorPoint = Vector2.new(1,0)

notif.BackgroundColor3 = Color3.fromRGB(20,20,20)
notif.BackgroundTransparency = 0.12

notif.BorderSizePixel = 0
notif.ClipsDescendants = true

notif.Parent = gui

Instance.new("UICorner",notif).CornerRadius = UDim.new(0,14)

local notifStroke = Instance.new("UIStroke")
notifStroke.Thickness = 2
notifStroke.Parent = notif

local notifText = Instance.new("TextLabel")

notifText.Size = UDim2.new(1,-15,1,0)
notifText.Position = UDim2.new(0,12,0,0)

notifText.BackgroundTransparency = 1

notifText.Font = Enum.Font.GothamBold
notifText.TextSize = 14

notifText.TextXAlignment = Enum.TextXAlignment.Left

notifText.TextColor3 = Color3.new(1,1,1)
notifText.Parent = notif

local Busy = false

local function Notify(msg,color)

	if Busy then return end

	Busy = true

	notifText.Text = msg
	notifStroke.Color = color

	TweenService:Create(
		notif,
		TweenInfo.new(0.3),
		{
			Size = UDim2.new(0,240,0,68)
		}
	):Play()

	wait(2.5)

	TweenService:Create(
		notif,
		TweenInfo.new(0.3),
		{
			Size = UDim2.new(0,0,0,68)
		}
	):Play()

	wait(0.4)

	Busy = false
end

-- BUTTON
local function CreateButton(text,pos,color)

	local btn = Instance.new("TextButton")

	btn.Size = UDim2.new(0,100,0,36)
	btn.Position = pos

	btn.BackgroundColor3 = Color3.fromRGB(22,22,22)
	btn.BackgroundTransparency = 0.1

	btn.Text = text
	btn.TextColor3 = color

	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13

	btn.BorderSizePixel = 0
	btn.Parent = frame

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,12)

	local neon = Instance.new("UIStroke")
	neon.Color = color
	neon.Thickness = 1.7
	neon.Parent = btn

	-- CLICK EFFECT
	btn.MouseButton1Click:Connect(function()

		PlaySound("Click",0.7)

		local ripple = Instance.new("Frame")

		ripple.Size = UDim2.new(0,0,0,0)
		ripple.Position = UDim2.new(0.5,0,0.5,0)

		ripple.AnchorPoint = Vector2.new(0.5,0.5)

		ripple.BackgroundColor3 = color
		ripple.BackgroundTransparency = 0.5

		ripple.Parent = btn

		Instance.new("UICorner",ripple).CornerRadius = UDim.new(1,0)

		TweenService:Create(
			ripple,
			TweenInfo.new(0.35),
			{
				Size = UDim2.new(2,0,2,0),
				BackgroundTransparency = 1
			}
		):Play()

		Debris:AddItem(ripple,0.4)

		TweenService:Create(
			btn,
			TweenInfo.new(0.08),
			{
				Rotation = -2
			}
		):Play()

		wait(0.08)

		TweenService:Create(
			btn,
			TweenInfo.new(0.08),
			{
				Rotation = 2
			}
		):Play()

		wait(0.08)

		TweenService:Create(
			btn,
			TweenInfo.new(0.08),
			{
				Rotation = 0
			}
		):Play()
	end)

	return btn
end

-- BUTTONS
local login = CreateButton(
	"Login",
	UDim2.new(0.5,-112,0.56,0),
	Color3.fromRGB(180,0,255)
)

local getkey = CreateButton(
	"Get Key",
	UDim2.new(0.5,12,0.56,0),
	Color3.fromRGB(0,255,255)
)

local discord = CreateButton(
	"Discord",
	UDim2.new(0.5,-112,0.74,0),
	Color3.fromRGB(0,170,255)
)

local infoBtn = CreateButton(
	"Info",
	UDim2.new(0.5,12,0.74,0),
	Color3.fromRGB(255,170,0)
)

-- INFO FRAME
local infoFrame = Instance.new("Frame")

infoFrame.Size = UDim2.new(1,0,1,0)

infoFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
infoFrame.BackgroundTransparency = 0.08

infoFrame.Visible = false
infoFrame.ClipsDescendants = true

infoFrame.Parent = frame

Instance.new("UICorner",infoFrame).CornerRadius = UDim.new(0,18)

local infoTitle = Instance.new("TextLabel")

infoTitle.Size = UDim2.new(1,0,0,40)

infoTitle.BackgroundTransparency = 1

infoTitle.Text = "📋 VeLix Information"

infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 18

infoTitle.TextColor3 = Color3.new(1,1,1)

infoTitle.Parent = infoFrame

-- SCROLL
local scroll = Instance.new("ScrollingFrame")

scroll.Size = UDim2.new(1,-12,1,-58)
scroll.Position = UDim2.new(0,6,0,44)

scroll.CanvasSize = UDim2.new(0,0,0,420)

scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0

scroll.ScrollBarThickness = 2
scroll.Parent = infoFrame

-- INFO TEXT
local infoText = Instance.new("TextLabel")

infoText.Size = UDim2.new(1,-8,0,400)

infoText.BackgroundTransparency = 1

infoText.TextWrapped = true
infoText.TextScaled = false

infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top

infoText.Font = Enum.Font.Code
infoText.TextSize = IsMobile and 12 or 13

infoText.TextColor3 = Color3.new(1,1,1)

infoText.Parent = scroll

-- FPS
local FPS = 60

RunService.RenderStepped:Connect(function(dt)
	FPS = math.floor(1/dt)
end)

local GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name

task.spawn(function()

	while true do

		infoText.Text =
			"👤 Client : "..(identifyexecutor and identifyexecutor() or "Unknown")..
			"\n\n🎮 Game : "..GameName..
			"\n\n📦 Version : v6 Premium"..
			"\n\n🛠 Update : Technology Neon UI"..
			"\n\n🔑 Key Status : Active"..
			"\n\n⏳ Key Expire : Never"..
			"\n\n⚡ FPS : "..FPS..
			"\n\n🕒 VN Time : "..os.date("%H:%M:%S")..
			"\n\n📱 Device : "..(IsMobile and "Mobile" or "PC")..
			"\n\n🌈 Theme : Rainbow Neon"

		wait(1)
	end
end)

-- OPEN INFO
infoBtn.MouseButton1Click:Connect(function()

	infoFrame.Visible = true
end)

-- CLOSE INFO
local closeInfo = CreateButton(
	"Close",
	UDim2.new(0.5,-50,0.84,0),
	Color3.fromRGB(255,70,70)
)

closeInfo.Parent = infoFrame

closeInfo.MouseButton1Click:Connect(function()

	infoFrame.Visible = false
end)

-- PARTICLES
task.spawn(function()

	local emojis = {"💀","🔥","😭"}

	while true do

		local e = Instance.new("TextLabel")

		e.BackgroundTransparency = 1
		e.Size = UDim2.new(0,22,0,22)

		e.TextScaled = true
		e.Text = emojis[math.random(1,#emojis)]

		e.Position = UDim2.new(math.random(),0,-0.1,0)

		e.Parent = gui

		TweenService:Create(
			e,
			TweenInfo.new(4),
			{
				Position = UDim2.new(
					e.Position.X.Scale,
					0,
					1.1,
					0
				),
				TextTransparency = 1
			}
		):Play()

		Debris:AddItem(e,4)

		wait(IsMobile and 1 or 0.55)
	end
end)

-- DRAGGING
local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)

	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then

		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false
	end
end)

-- LOGIN
local function Login()

	local Correct = false

	for _,v in pairs(Keys) do

		if box.Text == v then
			Correct = true
			break
		end
	end

	if Correct then

		SaveKey(box.Text)

		PlaySound("Correct",1)

		Notify(
			"✅ Correct Key!",
			Color3.fromRGB(0,255,120)
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
			"❌ Wrong Key!",
			Color3.fromRGB(255,60,60)
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

	PlaySound("Copy",1)

	toclipboard("https://your-key-link.com")

	Notify(
		"🔑 GetKey Copied!",
		Color3.fromRGB(255,255,0)
	)
end)

discord.MouseButton1Click:Connect(function()

	PlaySound("Copy",1)

	toclipboard("https://discord.gg/yourserver")

	Notify(
		"💬 Discord Copied!",
		Color3.fromRGB(0,170,255)
	)
end)
