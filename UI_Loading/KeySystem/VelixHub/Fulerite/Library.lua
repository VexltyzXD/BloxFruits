--// VeLix Hub Premium Mobile Optimized FULL

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

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

-- MOBILE DETECT
local IsMobile = UIS.TouchEnabled

-- BLUR
local blur = Instance.new("BlurEffect")
blur.Name = "VeLixBlur"
blur.Size = IsMobile and 6 or 10
blur.Parent = Lighting

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "VeLixHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player.PlayerGui

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,0,0,0)
frame.Position = UDim2.new(0.5,0,0.5,0)
frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,16)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Parent = frame

-- MOBILE SIZE
local UIWidth = IsMobile and 320 or 380
local UIHeight = IsMobile and 230 or 260

-- OPEN ANIMATION
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

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,5)
title.BackgroundTransparency = 1
title.Text = "Velix Hub Premium"
title.Font = Enum.Font.GothamBold
title.TextSize = IsMobile and 21 or 25
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- KEY BOX
local box = Instance.new("TextBox")
box.Size = UDim2.new(0,UIWidth-50,0,40)
box.Position = UDim2.new(0.5,-((UIWidth-50)/2),0.30,0)

box.PlaceholderText = "Input Key......"
box.Text = ""

box.BackgroundColor3 = Color3.fromRGB(35,35,35)
box.TextColor3 = Color3.new(1,1,1)
box.PlaceholderColor3 = Color3.fromRGB(170,170,170)

box.Font = Enum.Font.Gotham
box.TextSize = 14
box.BorderSizePixel = 0
box.Parent = frame

Instance.new("UICorner",box).CornerRadius = UDim.new(0,10)

-- MULTI KEYS
local Keys = {
	"Free1Day1",
	"Free1Day2",
	"Free1Day3",
	"Free1Day4"
}

-- AUTO SAVE KEY
local SaveFile = "Velix Save Key.txt"

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

local SavedKey = LoadKey()

if SavedKey then
	box.Text = SavedKey
end

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

PlaySound("Open",1)

-- NOTIFICATION
local notif = Instance.new("Frame")
notif.Size = UDim2.new(0,0,0,70)
notif.Position = UDim2.new(1,-10,0.05,0)
notif.AnchorPoint = Vector2.new(1,0)

notif.BackgroundColor3 = Color3.fromRGB(25,25,25)
notif.BorderSizePixel = 0
notif.ClipsDescendants = true
notif.Parent = gui

Instance.new("UICorner",notif).CornerRadius = UDim.new(0,14)

local notifStroke = Instance.new("UIStroke")
notifStroke.Parent = notif
notifStroke.Thickness = 2

local notifText = Instance.new("TextLabel")
notifText.Size = UDim2.new(1,-20,1,0)
notifText.Position = UDim2.new(0,10,0,0)

notifText.BackgroundTransparency = 1
notifText.Font = Enum.Font.GothamBold
notifText.TextSize = 14
notifText.TextColor3 = Color3.new(1,1,1)

notifText.TextXAlignment = Enum.TextXAlignment.Left
notifText.Parent = notif

local notifyBusy = false

local function Notify(msg,color)

	if notifyBusy then return end
	notifyBusy = true

	notifText.Text = msg
	notifStroke.Color = color

	notif.Size = UDim2.new(0,0,0,70)

	TweenService:Create(
		notif,
		TweenInfo.new(0.3),
		{
			Size = UDim2.new(0,250,0,70)
		}
	):Play()

	wait(2.5)

	TweenService:Create(
		notif,
		TweenInfo.new(0.3),
		{
			Size = UDim2.new(0,0,0,70)
		}
	):Play()

	wait(0.4)

	notifyBusy = false
end

-- BUTTON FUNCTION
local function CreateButton(text,pos,color)

	local btn = Instance.new("TextButton")

	btn.Size = UDim2.new(0,110,0,38)
	btn.Position = pos

	btn.BackgroundColor3 = color
	btn.BorderSizePixel = 0

	btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13

	btn.Parent = frame

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,10)

	btn.MouseButton1Click:Connect(function()

		PlaySound("Click",0.7)

		TweenService:Create(
			btn,
			TweenInfo.new(0.1),
			{
				Size = UDim2.new(0,105,0,35)
			}
		):Play()

		wait(0.1)

		TweenService:Create(
			btn,
			TweenInfo.new(0.1),
			{
				Size = UDim2.new(0,110,0,38)
			}
		):Play()
	end)

	return btn
end

-- BUTTONS
local login = CreateButton(
	"Launch Script",
	UDim2.new(0.5,-120,0.57,0),
	Color3.fromRGB(120,0,255)
)

local getkey = CreateButton(
	"Get Key Free 24H",
	UDim2.new(0.5,10,0.57,0),
	Color3.fromRGB(50,50,50)
)

local discord = CreateButton(
	"Discord Velix Community",
	UDim2.new(0.5,-120,0.76,0),
	Color3.fromRGB(0,120,255)
)

local infoBtn = CreateButton(
	"Info",
	UDim2.new(0.5,10,0.76,0),
	Color3.fromRGB(255,170,0)
)

-- INFO TAB
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1,0,1,0)
infoFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
infoFrame.Visible = false
infoFrame.Parent = frame

Instance.new("UICorner",infoFrame).CornerRadius = UDim.new(0,16)

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1,0,0,40)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "Status"
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 20
infoTitle.TextColor3 = Color3.new(1,1,1)
infoTitle.Parent = infoFrame

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1,-20,1,-50)
infoText.Position = UDim2.new(0,10,0,45)

infoText.BackgroundTransparency = 1
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top

infoText.Font = Enum.Font.Code
infoText.TextSize = 13
infoText.TextColor3 = Color3.new(1,1,1)

infoText.RichText = true
infoText.Parent = infoFrame

local closeInfo = CreateButton(
	"Close Tab",
	UDim2.new(0.5,-55,0.82,0),
	Color3.fromRGB(255,60,60)
)

closeInfo.Parent = infoFrame

-- FPS
local FPS = 60

RunService.RenderStepped:Connect(function(dt)
	FPS = math.floor(1/dt)
end)

-- INFO LOOP
task.spawn(function()

	while true do

		local TimeVN = os.date("%H:%M:%S")

		infoText.Text =
			"👤 Client : "..(identifyexecutor and identifyexecutor() or "Unknown")..
			"\n\n📦 Version : V2 Premium"..
			"\n\n🛠 Update : 11/5/2026"..
			"\n\n🔑 Key Status : Active"..
			"\n\n⏳ Key Expire : Never"..
			"\n\n👑 Admin : Vexltyz"..
			"\n\n⚡ FPS : "..FPS..
			"\n\n🕒 Vietnam Time : "..TimeVN

		wait(1)
	end
end)

-- OPEN INFO
infoBtn.MouseButton1Click:Connect(function()

	infoFrame.Visible = true
	PlaySound("Click",1)
end)

-- CLOSE INFO
closeInfo.MouseButton1Click:Connect(function()

	infoFrame.Visible = false
	PlaySound("Click",1)
end)

-- RAINBOW
task.spawn(function()

	while true do

		for i = 0,1,0.005 do

			stroke.Color = Color3.fromHSV(i,1,1)

			wait()
		end
	end
end)

-- PARTICLES ( MOBILE OPTIMIZED )
task.spawn(function()

	local emojis = {
		"🤣",
		"🐧",
		"🗿"
	}

	while true do

		local e = Instance.new("TextLabel")

		e.BackgroundTransparency = 1
		e.TextScaled = true
		e.Size = UDim2.new(0,22,0,22)

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

		wait(IsMobile and 0.9 or 0.5)
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
			"Valid Key | Loading...",
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
			"Invalid Key!",
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
		"Copying Successful!",
		Color3.fromRGB(255,255,0)
	)
end)

discord.MouseButton1Click:Connect(function()

	PlaySound("Copy",1)

	toclipboard("https://discord.gg/yourserver")

	Notify(
		"Copying Successful",
		Color3.fromRGB(0,170,255)
	)
end)
