-- Dull Club Complete GUI Script with Key System and Features

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local VALID_KEY = "MinihodariDeveloper"
local discordLink = "https://discord.gg/yourserver" -- vaihda oma linkki tähän

-- Utility function: luo tekstiä helposti
local function CreateTextLabel(parent, size, pos, text, fontSize, bold, color, bgTransparency)
	local label = Instance.new("TextLabel")
	label.Size = size
	label.Position = pos
	label.Text = text
	label.Font = fontSize or Enum.Font.GothamBold
	label.TextSize = fontSize or 18
	label.TextColor3 = color or Color3.new(1,1,1)
	label.BackgroundTransparency = bgTransparency or 1
	label.Parent = parent
	label.TextWrapped = true
	label.RichText = true
	label.TextScaled = false
	if bold then label.Font = Enum.Font.GothamBold end
	return label
end

local function CreateButton(parent, size, pos, text, func)
	local btn = Instance.new("TextButton")
	btn.Size = size
	btn.Position = pos
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 20
	btn.Parent = parent
	btn.AutoButtonColor = true
	btn.MouseButton1Click:Connect(func)
	return btn
end

-- Alku GUI -- Avain kyselyikkuna
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DullClubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local keyFrame = Instance.new("Frame", screenGui)
keyFrame.Size = UDim2.new(0, 350, 0, 150)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true

local keyLabel = CreateTextLabel(keyFrame, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 10), "Enter Key:", 20, true)
local keyTextBox = Instance.new("TextBox", keyFrame)
keyTextBox.Size = UDim2.new(1, -20, 0, 40)
keyTextBox.Position = UDim2.new(0, 10, 0, 50)
keyTextBox.ClearTextOnFocus = false
keyTextBox.Text = ""
keyTextBox.Font = Enum.Font.GothamBold
keyTextBox.TextSize = 22
keyTextBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
keyTextBox.TextColor3 = Color3.new(1,1,1)

local keySubmitBtn = CreateButton(keyFrame, UDim2.new(0.4, 0, 0, 40), UDim2.new(0.3, 0, 0, 100), "Submit", function()
	local enteredKey = keyTextBox.Text
	if enteredKey == VALID_KEY then
		keyFrame.Visible = false
		mainFrame.Visible = true
	else
		player:Kick("Invalid key! Contact Minihodari12 for the correct code.")
	end
end)

-- Pää GUI
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 420, 0, 360)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

-- Sulje-nappi (X) ja vahvistusruutu
local closeBtn = CreateButton(mainFrame, UDim2.new(0, 30, 0, 30), UDim2.new(1, -35, 0, 5), "X", function()
	if screenGui:FindFirstChild("ConfirmClose") then return end
	local confirmFrame = Instance.new("Frame", screenGui)
	confirmFrame.Name = "ConfirmClose"
	confirmFrame.Size = UDim2.new(0, 300, 0, 130)
	confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -65)
	confirmFrame.BackgroundColor3 = Color3.fromRGB(45,45,45)
	confirmFrame.BorderSizePixel = 0
	confirmFrame.Active = true
	confirmFrame.Draggable = true

	local confirmLabel = CreateTextLabel(confirmFrame, UDim2.new(1, -20, 0, 60), UDim2.new(0, 10, 0, 10), "Are you sure you want to close the script?", 18, true)

	local yesBtn = CreateButton(confirmFrame, UDim2.new(0.4, 0, 0, 40), UDim2.new(0.1, 0, 1, -50), "Yes", function()
		screenGui:Destroy()
	end)

	local noBtn = CreateButton(confirmFrame, UDim2.new(0.4, 0, 0, 40), UDim2.new(0.5, 0, 1, -50), "No", function()
		confirmFrame:Destroy()
	end)
end)

-- Välilehdet
local tabs = {"Update Log", "All Games", "Fly", "Credits", "Discord"}
local tabButtons = {}
local contentFrames = {}

local tabHeight = 35
local tabWidth = 80
local tabSpacing = 5

for i, tabName in ipairs(tabs) do
	local btn = CreateButton(mainFrame, UDim2.new(0, tabWidth, 0, tabHeight), UDim2.new(0, (tabWidth + tabSpacing) * (i-1) + 10, 0, 45), tabName, function()
		for _, frame in pairs(contentFrames) do
			frame.Visible = false
		end
		contentFrames[tabName].Visible = true
	end)
	tabButtons[tabName] = btn

	local frame = Instance.new("Frame", mainFrame)
	frame.Size = UDim2.new(1, -20, 1, -90)
	frame.Position = UDim2.new(0, 10, 0, 90)
	frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	frame.Visible = false
	contentFrames[tabName] = frame
end

-- Aloita näyttämällä Update Log
contentFrames["Update Log"].Visible = true

-- Update Log -sisältö
local updateLogLabel = CreateTextLabel(contentFrames["Update Log"], UDim2.new(1, -20, 1, -20), UDim2.new(0, 10, 0, 10), 
[[
Update Log:
- Added key system with kick on invalid key
- Improved Fly with WASD + Space/Ctrl
- Added All Games commands (Heal, Fake Kick)
- Discord tab with copy link button
- Draggable GUI & close confirmation dialog
]], 18, false)

-- All Games -komennot
local allGamesFrame = contentFrames["All Games"]

local function healPlayer()
	local char = player.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum and hum.Health < hum.MaxHealth then
			hum.Health = hum.MaxHealth
		end
	end
end

CreateButton(allGamesFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 10), "Heal Player", healPlayer)

CreateButton(allGamesFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 60), "Fake Kick (Real Kick!)", function()
	player:Kick("You got kicked by Fake Kick command!")
end)

-- Lisää demo komentoja All Gamesiin:
CreateButton(allGamesFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 110), "Teleport to Spawn", function()
	local char = player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		char.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
	end
end)

CreateButton(allGamesFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 160), "Set WalkSpeed to 50", function()
	local char = player.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then
			hum.WalkSpeed = 50
		end
	end
end)

CreateButton(allGamesFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 210), "Reset WalkSpeed", function()
	local char = player.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then
			hum.WalkSpeed = 16
		end
	end
end)

-- Fly välilehti
local flyFrame = contentFrames["Fly"]

local flying = false
local flySpeed = 50
local flyDirection = Vector3.new(0,0,0)
local playerRoot = nil

local function startFly()
	local char = player.Character
	if not char then return end
	playerRoot = char:FindFirstChild("HumanoidRootPart")
	if not playerRoot then return end
	flying = true
end

local function stopFly()
	flying = false
	if playerRoot then
		playerRoot.AssemblyLinearVelocity = Vector3.new(0,0,0)
	end
end

local flyToggleBtn = CreateButton(flyFrame, UDim2.new(0.5, 0, 0, 50), UDim2.new(0.25, 0, 0, 20), "Toggle Fly", function()
	if flying then
		stopFly()
		flyToggleBtn.Text = "Start Fly"
	else
		startFly()
		flyToggleBtn.Text = "Stop Fly"
	end
end)

local flySpeedLabel = CreateTextLabel(flyFrame, UDim2.new(0.8, 0, 0, 30), UDim2.new(0.1, 0, 0, 80), "Fly Speed: 50", 18)

-- Liiketoiminta lentoa varten
local moveDir = Vector3.new()

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.W then moveDir = moveDir + Vector3.new(0,0,-1) end
	if input.KeyCode == Enum.KeyCode.S then moveDir = moveDir + Vector3.new(0,0,1) end
	if input.KeyCode == Enum.KeyCode.A then moveDir = moveDir + Vector3.new(-1,0,0) end
	if input.KeyCode == Enum.KeyCode.D then moveDir = moveDir + Vector3.new(1,0,0) end
	if input.KeyCode == Enum.KeyCode.Space then moveDir = moveDir + Vector3.new(0,1,0) end
	if input.KeyCode == Enum.KeyCode.LeftControl then moveDir = moveDir + Vector3.new(0,-1,0) end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.W then moveDir = moveDir - Vector3.new(0,0,-1) end
	if input.KeyCode == Enum.KeyCode.S then moveDir = moveDir - Vector3.new(0,0,1) end
	if input.KeyCode == Enum.KeyCode.A then moveDir = moveDir - Vector3.new(-1,0,0) end
	if input.KeyCode == Enum.KeyCode.D then moveDir = moveDir - Vector3.new(1,0,0) end
	if input.KeyCode == Enum.KeyCode.Space then moveDir = moveDir - Vector3.new(0,1,0) end
	if input.KeyCode == Enum.KeyCode.LeftControl then moveDir = moveDir - Vector3.new(0,-1,0) end
end)

RunService.RenderStepped:Connect(function()
	if flying and playerRoot then
		playerRoot.Velocity = moveDir.Unit * flySpeed
		if moveDir.Magnitude == 0 then
			playerRoot.Velocity = Vector3.new(0,0,0)
		end
	end
end)

-- Credits välilehti
local creditsFrame = contentFrames["Credits"]
local creditsText = CreateTextLabel(creditsFrame, UDim2.new(1, -20, 1, -20), UDim2.new(0, 10, 0, 10),
"Script by Minihodari12\nThanks for using!\n\nHave fun!",
18, false)

-- Discord välilehti
local discordFrame = contentFrames["Discord"]

local discordLabel = CreateTextLabel(discordFrame, UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 0, 10),
"Join our Discord server!\nClick the button below to copy the invite link.", 18, false)

local copyBtn = CreateButton(discordFrame, UDim2.new(0.6, 0, 0, 50), UDim2.new(0.2, 0, 0, 70), "Copy Link", function()
	setclipboard(discordLink)
end)
