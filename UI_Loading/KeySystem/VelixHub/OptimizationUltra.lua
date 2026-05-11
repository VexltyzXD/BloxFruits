--// VeLix Hub Premium + Anime Girl Welcome

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
	if player.PlayerGui:FindFirstChild("VeLixHub") then
		player.PlayerGui.VeLixHub:Destroy()
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
blur.Size = IsMobile and 5 or 8
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

frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
frame.BackgroundTransparency = 0.12

frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,18)

local UIWidth = IsMobile and 320 or 380
local UIHeight = IsMobile and 240 or 275

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

-- RAINBOW STROKE
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Parent = frame

task.spawn(function()

	while true do

		for i = 0,1,0.01 do

			stroke.Color = Color3.fromHSV(i,1,1)

			task.wait()
		end
	end
end)

-- GLOW
local glow = Instance.new("ImageLabel")
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857084"

glow.ImageTransparency = 0.45
glow.Size = UDim2.new(1,120,1,120)

glow.Position = UDim2.new(0,-60,0,-60)
glow.ZIndex = 0
glow.Parent = frame

-- TITLE
local title = Instance.new("TextLabel")

title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,8)

title.BackgroundTransparency = 1

title.Text = "🌈 VeLix Hub"

title.Font = Enum.Font.GothamBlack
title.TextSize = IsMobile and 20 or 24

title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextStrokeTransparency = 0.8

title.Parent = frame

task.spawn(function()

	while true do

		for i = 0,1,0.01 do

			title.TextColor3 = Color3.fromHSV(i,1,1)

			task.wait()
		end
	end
end)

-- KEY BOX
local box = Instance.new("TextBox")

box.Size = UDim2.new(0,UIWidth-50,0,38)
box.Position = UDim2.new(0.5,-((UIWidth-50)/2),0.30,0)

box.BackgroundColor3 = Color3.fromRGB(25,25,25)
box.BackgroundTransparency = 0.1

box.PlaceholderText = "Enter Key..."
box.PlaceholderColor3 = Color3.fromRGB(180,180,180)

box.Text = ""
box.TextColor3 = Color3.fromRGB(255,255,255)

box.Font = Enum.Font.GothamMedium
box.TextSize = IsMobile and 14 or 15

box.BorderSizePixel = 0
box.Parent = frame

Instance.new("UICorner",box).CornerRadius = UDim.new(0,12)

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = Color3.fromRGB(0,255,255)
boxStroke.Thickness = 1.6
boxStroke.Parent = box

-- SOUNDS
local Sounds = {
	Correct = "rbxassetid://906042564",
	Wrong = "rbxassetid://2865228021",
	Copy = "rbxassetid://6534947240",
	Open = "rbxassetid://9120289498",
	Click = "rbxassetid://6895079853",

	-- ANIME GIRL
	Welcome = "rbxassetid://7147454322"
}

local function PlaySound(name,volume)

	local sound = Instance.new("Sound")

	sound.SoundId = Sounds[name]
	sound.Volume = volume or 1

	sound.Parent = gui
	sound:Play()

	Debris:AddItem(sound,6)
end

PlaySound("Open",1)

task.wait(0.5)

PlaySound("Welcome",1)

-- KEYS
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
end

local saved = LoadKey()

if saved then
	box.Text = saved
end

-- NOTIFY
local notif = Instance.new("Frame")

notif.Size = UDim2.new(0,0,0,65)
notif.Position = UDim2.new(1,-10,0.05,0)

notif.AnchorPoint = Vector2.new(1,0)

notif.BackgroundColor3 = Color3.fromRGB(18,18,18)
notif.BackgroundTransparency = 0.08

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
notifText.TextSize = IsMobile and 13 or 14

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
			Size = UDim2.new(0,250,0,65)
		}
	):Play()

	task.wait(2.5)

	TweenService:Create(
		notif,
		TweenInfo.new(0.3),
		{
			Size = UDim2.new(0,0,0,65)
		}
	):Play()

	task.wait(0.3)

	Busy = false
end

Notify(
	"🌸 Welcome To VeLix Hub Premium",
	Color3.fromRGB(255,120,255)
)

-- BUTTON
local function CreateButton(text,pos,color)

	local btn = Instance.new("TextButton")

	btn.Size = UDim2.new(0,102,0,36)
	btn.Position = pos

	btn.BackgroundColor3 = Color3.fromRGB(22,22,22)
	btn.BackgroundTransparency = 0.08

	btn.Text = text

	btn.Font = Enum.Font.GothamBold
	btn.TextSize = IsMobile and 13 or 14

	btn.TextColor3 = Color3.fromRGB(255,255,255)

	btn.BorderSizePixel = 0
	btn.Parent = frame

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,12)

	local neon = Instance.new("UIStroke")
	neon.Color = color
	neon.Thickness = 1.8
	neon.Parent = btn

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
	end)

	return btn
end

-- BUTTONS
local login = CreateButton(
	"Login",
	UDim2.new(0.5,-114,0.57,0),
	Color3.fromRGB(170,0,255)
)

local getkey = CreateButton(
	"Get Key",
	UDim2.new(0.5,12,0.57,0),
	Color3.fromRGB(0,255,255)
)

local discord = CreateButton(
	"Discord",
	UDim2.new(0.5,-114,0.75,0),
	Color3.fromRGB(0,170,255)
)

local infoBtn = CreateButton(
	"Info",
	UDim2.new(0.5,12,0.75,0),
	Color3.fromRGB(255,170,0)
)

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

		task.wait(1)

		gui.Enabled = false

		if blur then
			blur:Destroy()
		end

		-- YOUR SCRIPT
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
