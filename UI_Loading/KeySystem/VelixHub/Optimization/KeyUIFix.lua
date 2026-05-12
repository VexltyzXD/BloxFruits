--// PREMIUM SUPER UI MOBILE OPTIMIZED

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer

--// CONFIG
local ScriptToLoad = 'loadstring(game:HttpGet("https://..."))()'

local VALID_KEYS = {
	"1","2","3","4","5",
	"6","7","8","9","10"
}

local DISCORD = "https://discord.gg/example"

--// MOBILE SCALE
local isMobile = UserInputService.TouchEnabled

local UISizeX = isMobile and 0.92 or 0
local UISizeY = isMobile and 0.55 or 0

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PremiumSuperUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

--// SOUND
local click = Instance.new("Sound",gui)
click.SoundId = "rbxassetid://9118823102"
click.Volume = 1

local notifySound = Instance.new("Sound",gui)
notifySound.SoundId = "rbxassetid://4590662766"
notifySound.Volume = 1

local function Play()
	click:Play()
end

--// RAINBOW
local rainbow = Color3.fromRGB(255,0,0)

task.spawn(function()
	while true do
		for i = 0,1,0.01 do
			rainbow = Color3.fromHSV(i,1,1)
			task.wait()
		end
	end
end)

--// NOTIFY
local function Notify(text)

	notifySound:Play()

	local f = Instance.new("Frame")
	f.Parent = gui
	f.Size = UDim2.new(0,300,0,40)
	f.Position = UDim2.new(1,320,1,-70)
	f.BackgroundColor3 = Color3.fromRGB(15,15,15)

	local s = Instance.new("UIStroke",f)
	s.Color = rainbow

	Instance.new("UICorner",f)

	local t = Instance.new("TextLabel")
	t.Parent = f
	t.Size = UDim2.new(1,0,1,0)
	t.BackgroundTransparency = 1
	t.Text = text
	t.Font = Enum.Font.GothamBold
	t.TextSize = 14
	t.TextColor3 = Color3.new(1,1,1)

	TweenService:Create(f,TweenInfo.new(.35),{
		Position = UDim2.new(1,-310,1,-70)
	}):Play()

	task.wait(3)

	TweenService:Create(f,TweenInfo.new(.35),{
		Position = UDim2.new(1,320,1,-70)
	}):Play()

	task.wait(.4)

	f:Destroy()
end

Notify("Welcome "..player.Name.." 👋")

--// MEME PARTICLES
local Memes = {
	"🔥","💀","😂","✨","🎉","⚡"
}

task.spawn(function()

	while task.wait(.12) do

		local p = Instance.new("TextLabel")
		p.Parent = gui

		p.BackgroundTransparency = 1
		p.Text = Memes[math.random(1,#Memes)]

		p.TextSize = math.random(14,28)

		p.Position = UDim2.new(math.random(),0,-0.1,0)

		p.Size = UDim2.new(0,30,0,30)

		p.TextColor3 = rainbow

		TweenService:Create(p,TweenInfo.new(5),{
			Position = UDim2.new(p.Position.X.Scale,0,1.2,0),
			Rotation = math.random(-360,360),
			TextTransparency = 1
		}):Play()

		game.Debris:AddItem(p,5)
	end
end)

--// KEY FRAME
local frame = Instance.new("Frame")
frame.Parent = gui

frame.Size = isMobile
	and UDim2.new(UISizeX,0,UISizeY,0)
	or UDim2.new(0,400,0,240)

frame.Position = UDim2.new(.5,-200,.5,-120)

frame.BackgroundColor3 = Color3.fromRGB(10,10,10)

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke",frame)
stroke.Thickness = 2

--// RAINBOW STROKE
task.spawn(function()
	while true do
		stroke.Color = rainbow
		task.wait()
	end
end)

--// TOPBAR
local top = Instance.new("Frame")
top.Parent = frame
top.Size = UDim2.new(1,0,0,42)
top.BackgroundColor3 = Color3.fromRGB(18,18,18)

Instance.new("UICorner",top).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel")
title.Parent = top
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,1,0)
title.Text = " PREMIUM SUPER UI "
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = isMobile and 15 or 17

--// CLOSE UI
local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,.5,-15)
close.Text = "X"

close.BackgroundColor3 = Color3.fromRGB(255,70,70)
close.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",close)

--// INPUT
local keyBox = Instance.new("TextBox")
keyBox.Parent = frame

keyBox.Size = UDim2.new(.82,0,0,42)
keyBox.Position = UDim2.new(.09,0,.38,0)

keyBox.PlaceholderText = "Enter Premium Key..."
keyBox.Text = ""

keyBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
keyBox.TextColor3 = Color3.new(1,1,1)

keyBox.Font = Enum.Font.GothamBold
keyBox.TextSize = 14

Instance.new("UICorner",keyBox)

local boxStroke = Instance.new("UIStroke",keyBox)

--// VERIFY
local verify = Instance.new("TextButton")
verify.Parent = frame

verify.Size = UDim2.new(.82,0,0,42)
verify.Position = UDim2.new(.09,0,.64,0)

verify.Text = "VERIFY KEY"

verify.BackgroundColor3 = Color3.fromRGB(0,170,255)
verify.TextColor3 = Color3.new(1,1,1)

verify.Font = Enum.Font.GothamBlack
verify.TextSize = 14

Instance.new("UICorner",verify)

local verifyStroke = Instance.new("UIStroke",verify)

--// DISCORD
local discord = Instance.new("TextButton")
discord.Parent = frame

discord.Size = UDim2.new(.35,0,0,30)
discord.Position = UDim2.new(.325,0,.86,0)

discord.Text = "DISCORD"

discord.BackgroundColor3 = Color3.fromRGB(88,101,242)
discord.TextColor3 = Color3.new(1,1,1)

discord.Font = Enum.Font.GothamBold
discord.TextSize = 13

Instance.new("UICorner",discord)

local discordStroke = Instance.new("UIStroke",discord)

--// RAINBOW UPDATE
task.spawn(function()
	while true do

		boxStroke.Color = rainbow
		verifyStroke.Color = rainbow
		discordStroke.Color = rainbow

		task.wait()
	end
end)

--// BUTTON FX
local function FX(btn)

	btn.MouseButton1Click:Connect(function()

		Play()

		local r = Instance.new("Frame")
		r.Parent = btn

		r.AnchorPoint = Vector2.new(.5,.5)

		r.Position = UDim2.new(.5,0,.5,0)

		r.Size = UDim2.new(0,0,0,0)

		r.BackgroundColor3 = Color3.new(1,1,1)
		r.BackgroundTransparency = .4

		Instance.new("UICorner",r).CornerRadius = UDim.new(1,0)

		TweenService:Create(r,TweenInfo.new(.4),{
			Size = UDim2.new(2,0,2,0),
			BackgroundTransparency = 1
		}):Play()

		game.Debris:AddItem(r,.4)
	end)

	btn.MouseEnter:Connect(function()

		TweenService:Create(btn,TweenInfo.new(.15),{
			BackgroundTransparency = .15
		}):Play()
	end)

	btn.MouseLeave:Connect(function()

		TweenService:Create(btn,TweenInfo.new(.15),{
			BackgroundTransparency = 0
		}):Play()
	end)
end

FX(close)
FX(verify)
FX(discord)

--// CLOSE
close.MouseButton1Click:Connect(function()

	Play()

	gui.Enabled = false
end)

--// DISCORD
discord.MouseButton1Click:Connect(function()

	if setclipboard then
		setclipboard(DISCORD)
	end

	Notify("Discord Link Copied!")
end)

--// VERIFY
verify.MouseButton1Click:Connect(function()

	Play()

	local success = false

	for _,key in pairs(VALID_KEYS) do
		if keyBox.Text == key then
			success = true
		end
	end

	if success then

		Notify("Correct Key! Loading Script...")

		task.wait(1)

		loadstring(game:HttpGet("https://..."))()

	else

		Notify("Wrong Key! Kicked.")

		task.wait(1)

		player:Kick("Wrong Premium Key")
	end
end)

--// INFO LABEL
local info = Instance.new("TextLabel")
info.Parent = frame

info.BackgroundTransparency = 1

info.Size = UDim2.new(1,0,0,25)
info.Position = UDim2.new(0,0,.2,0)

info.TextColor3 = Color3.new(1,1,1)

info.Font = Enum.Font.GothamBold
info.TextSize = 13

task.spawn(function()

	local gameName = "Unknown"

	pcall(function()
		gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
	end)

	while true do

		info.Text =
			"👤 "..player.Name..
			" | 🎮 "..gameName

		task.wait(1)
	end
end)

--// MOBILE DRAG
local dragging
local dragInput
local dragStart
local startPos

top.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

top.InputChanged:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then

		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if input == dragInput and dragging then

		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false
	end
end)
