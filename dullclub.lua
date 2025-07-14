local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local VALID_KEY = "MinihodariDeveloper"

-- LUO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "DullClubGui"

-- Key Frame
local keyFrame = Instance.new("Frame", ScreenGui)
keyFrame.Size = UDim2.new(0, 350, 0, 150)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true

local keyLabel = Instance.new("TextLabel", keyFrame)
keyLabel.Size = UDim2.new(1, 0, 0, 40)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "Enter your key:"
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextSize = 22

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.9, 0, 0, 40)
keyBox.Position = UDim2.new(0.05, 0, 0, 50)
keyBox.ClearTextOnFocus = false
keyBox.Text = ""
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyBox.Font = Enum.Font.GothamBold
keyBox.TextSize = 20
keyBox.PlaceholderText = "Key here..."

local submitBtn = Instance.new("TextButton", keyFrame)
submitBtn.Size = UDim2.new(0.9, 0, 0, 35)
submitBtn.Position = UDim2.new(0.05, 0, 0, 100)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 20
submitBtn.Text = "Submit Key"

-- Main Frame (menu)
local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Dull Club"
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Text = "X"

-- Tabs buttons container
local tabButtonsFrame = Instance.new("Frame", mainFrame)
tabButtonsFrame.Size = UDim2.new(1, 0, 0, 35)
tabButtonsFrame.Position = UDim2.new(0, 0, 0, 40)
tabButtonsFrame.BackgroundTransparency = 1

local function createTabButton(name, posX)
	local btn = Instance.new("TextButton", tabButtonsFrame)
	btn.Size = UDim2.new(0, 90, 1, 0)
	btn.Position = UDim2.new(0, posX, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Text = name
	return btn
end

local updateTabBtn = createTabButton("Update Log", 0)
local allGamesTabBtn = createTabButton("All Games", 95)
local flyTabBtn = createTabButton("Fly", 190)
local creditsTabBtn = createTabButton("Credits", 285)

-- Content Frames for tabs
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -80)
contentFrame.Position = UDim2.new(0, 10, 0, 75)
contentFrame.BackgroundTransparency = 1

local updateLogFrame = Instance.new("ScrollingFrame", contentFrame)
updateLogFrame.Size = UDim2.new(1, 0, 1, 0)
updateLogFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
updateLogFrame.Visible = false
updateLogFrame.BorderSizePixel = 0
updateLogFrame.CanvasSize = UDim2.new(0,0,1.5,0)

local updateText = Instance.new("TextLabel", updateLogFrame)
updateText.Size = UDim2.new(1, -20, 1, 0)
updateText.Position = UDim2.new(0, 10, 0, 0)
updateText.BackgroundTransparency = 1
updateText.TextColor3 = Color3.new(1,1,1)
updateText.TextWrapped = true
updateText.Font = Enum.Font.Gotham
updateText.TextSize = 18
updateText.Text = [[
Update Log:

- Initial demo release.
- Added Fly toggle with smooth control.
- Added All Games commands (demo).
- Credits with Discord link and copy button.
]]

local allGamesFrame = Instance.new("Frame", contentFrame)
allGamesFrame.Size = UDim2.new(1, 0, 1, 0)
allGamesFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
allGamesFrame.Visible = false

local allGamesLabel = Instance.new("TextLabel", allGamesFrame)
allGamesLabel.Size = UDim2.new(1, -20, 0, 30)
allGamesLabel.Position = UDim2.new(0, 10, 0, 10)
allGamesLabel.BackgroundTransparency = 1
allGamesLabel.TextColor3 = Color3.new(1,1,1)
allGamesLabel.Font = Enum.Font.GothamBold
allGamesLabel.TextSize = 20
allGamesLabel.Text = "All Games Demo Commands"

-- Demo toggle buttons (example)
local noclipBtn = Instance.new("TextButton", allGamesFrame)
noclipBtn.Size = UDim2.new(0.4, 0, 0, 35)
noclipBtn.Position = UDim2.new(0.05, 0, 0, 50)
noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 18
noclipBtn.Text = "Toggle Noclip"

local speedBtn = Instance.new("TextButton", allGamesFrame)
speedBtn.Size = UDim2.new(0.4, 0, 0, 35)
speedBtn.Position = UDim2.new(0.55, 0, 0, 50)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 18
speedBtn.Text = "Speed x2"

local fakeKickBtn = Instance.new("TextButton", allGamesFrame)
fakeKickBtn.Size = UDim2.new(0.9, 0, 0, 35)
fakeKickBtn.Position = UDim2.new(0.05, 0, 0, 100)
fakeKickBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
fakeKickBtn.TextColor3 = Color3.new(1,1,1)
fakeKickBtn.Font = Enum.Font.GothamBold
fakeKickBtn.TextSize = 18
fakeKickBtn.Text = "Fake Kick (real kick)"

-- Fly Frame
local flyFrame = Instance.new("Frame", contentFrame)
flyFrame.Size = UDim2.new(1, 0, 1, 0)
flyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
flyFrame.Visible = false

local flyLabel = Instance.new("TextLabel", flyFrame)
flyLabel.Size = UDim2.new(1, -20, 0, 30)
flyLabel.Position = UDim2.new(0, 10, 0, 10)
flyLabel.BackgroundTransparency = 1
flyLabel.TextColor3 = Color3.new(1,1,1)
flyLabel.Font = Enum.Font.GothamBold
flyLabel.TextSize = 20
flyLabel.Text = "Fly Controls"

local toggleFlyBtn = Instance.new("TextButton", flyFrame)
toggleFlyBtn.Size = UDim2.new(0.9, 0, 0, 40)
toggleFlyBtn.Position = UDim2.new(0.05, 0, 0, 50)
toggleFlyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleFlyBtn.TextColor3 = Color3.new(1,1,1)
toggleFlyBtn.Font = Enum.Font.GothamBold
toggleFlyBtn.TextSize = 20
toggleFlyBtn.Text = "Toggle Fly"

-- Credits Frame
local creditsFrame = Instance.new("Frame", contentFrame)
creditsFrame.Size = UDim2.new(1, 0, 1, 0)
creditsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
creditsFrame.Visible = false

local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -20, 0, 40)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.BackgroundTransparency = 1
creditsLabel.TextColor3 = Color3.new(1,1,1)
creditsLabel.Font = Enum.Font.GothamBold
creditsLabel.TextSize = 22
creditsLabel.Text = "Credits\nCreator: Minihodari12\nDiscord server coming soon!"

local discordLinkBox = Instance.new("TextBox", creditsFrame)
discordLinkBox.Size = UDim2.new(0.8, 0, 0, 35)
discordLinkBox.Position = UDim2.new(0.1, 0, 0, 60)
discordLinkBox.Text = "https://discord.gg/yourserver"
discordLinkBox.ClearTextOnFocus = false
discordLinkBox.TextColor3 = Color3.new(1,1,1)
discordLinkBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
discordLinkBox.Font = Enum.Font.Gotham
discordLinkBox.TextSize = 16
discordLinkBox.TextEditable = false

local copyBtn = Instance.new("TextButton", creditsFrame)
copyBtn.Size = UDim2.new(0.3, 0, 0, 35)
copyBtn.Position = UDim2.new(0.35, 0, 0, 105)
copyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 18
copyBtn.Text = "Copy Link"

-- Funktiot
local function showTab(tabName)
	updateLogFrame.Visible = false
	allGamesFrame.Visible = false
	flyFrame.Visible = false
	creditsFrame.Visible = false

	updateTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	allGamesTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	flyTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	creditsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

	if tabName == "Update Log" then
		updateLogFrame.Visible = true
		updateTabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	elseif tabName == "All Games" then
		allGamesFrame.Visible = true
		allGamesTabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	elseif tabName == "Fly" then
		flyFrame.Visible = true
		flyTabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	elseif tabName == "Credits" then
		creditsFrame.Visible = true
		creditsTabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	end
end

-- Aluksi keyFrame näkyy, menu piilossa
keyFrame.Visible = true
mainFrame.Visible = false

-- Key submit -toiminto
submitBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == VALID_KEY then
		keyFrame.Visible = false
		mainFrame.Visible = true
		showTab("Update Log")
	else
		Player:Kick("Wrong key entered.")
	end
end)

-- Sulkemisen varmistus
closeButton.MouseButton1Click:Connect(function()
	local confirmFrame = Instance.new("Frame", ScreenGui)
	confirmFrame.Size = UDim2.new(0, 300, 0, 140)
	confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -70)
	confirmFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	confirmFrame.BorderSizePixel = 0
	confirmFrame.ZIndex = 10
	confirmFrame.Active = true
	confirmFrame.Draggable = true

	local confirmText = Instance.new("TextLabel", confirmFrame)
	confirmText.Size = UDim2.new(1, -20, 0, 60)
	confirmText.Position = UDim2.new(0, 10, 0, 10)
	confirmText.BackgroundTransparency = 1
	confirmText.TextColor3 = Color3.new(1,1,1)
	confirmText.Font = Enum.Font.GothamBold
	confirmText.TextSize = 18
	confirmText.TextWrapped = true
	confirmText.Text = "Are you sure you want to close the menu?"

	local yesBtn = Instance.new("TextButton", confirmFrame)
	yesBtn.Size = UDim2.new(0.4, 0, 0, 40)
	yesBtn.Position = UDim2.new(0.05, 0, 1, -50)
	yesBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
	yesBtn.TextColor3 = Color3.new(1,1,1)
	yesBtn.Font = Enum.Font.GothamBold
	yesBtn.TextSize = 20
	yesBtn.Text = "Yes"

	local noBtn = Instance.new("TextButton", confirmFrame)
	noBtn.Size = UDim2.new(0.4, 0, 0, 40)
	noBtn.Position = UDim2.new(0.55, 0, 1, -50)
	noBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
	noBtn.TextColor3 = Color3.new(1,1,1)
	noBtn.Font = Enum.Font.GothamBold
	noBtn.TextSize = 20
	noBtn.Text = "No"

	yesBtn.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	noBtn.MouseButton1Click:Connect(function()
		confirmFrame:Destroy()
	end)
end)

-- Tab buttons click
updateTabBtn.MouseButton1Click:Connect(function() showTab("Update Log") end)
allGamesTabBtn.MouseButton1Click:Connect(function() showTab("All Games") end)
flyTabBtn.MouseButton1Click:Connect(function() showTab("Fly") end)
creditsTabBtn.MouseButton1Click:Connect(function() showTab("Credits") end)

-- Copy discord link
copyBtn.MouseButton1Click:Connect(function()
	setclipboard(discordLinkBox.Text)
	copyBtn.Text = "Copied!"
	wait(2)
	copyBtn.Text = "Copy Link"
end)

-- --- Lentämisen logiikka ---
local flying = false
local speed = 50
local flightVelocity

local function startFly()
	if flying then return end
	flying = true
	Humanoid.PlatformStand = true
	flightVelocity = Instance.new("BodyVelocity")
	flightVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	flightVelocity.Velocity = Vector3.new(0,0,0)
	flightVelocity.Parent = HumanoidRootPart
	toggleFlyBtn.Text = "Stop Flying"
end

local function stopFly()
	if not flying then return end
	flying = false
	Humanoid.PlatformStand = false
	if flightVelocity then
		flightVelocity:Destroy()
		flightVelocity = nil
	end
	toggleFlyBtn.Text = "Toggle Fly"
end

RunService.Heartbeat:Connect(function()
	if not flying then return end
	local direction = Vector3.new(0,0,0)
	local cameraCFrame = workspace.CurrentCamera.CFrame

	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		direction = direction + cameraCFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		direction = direction - cameraCFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		direction = direction - cameraCFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		direction = direction + cameraCFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
		direction = direction + Vector3.new(0,1,0)
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		direction = direction - Vector3.new(0,1,0)
	end

	if direction.Magnitude > 0 then
		direction = direction.Unit
	else
		direction = Vector3.new(0,0,0)
	end

	if flightVelocity then
		flightVelocity.Velocity = direction * speed
	end
end)

toggleFlyBtn.MouseButton1Click:Connect(function()
	if flying then
		stopFly()
	else
		startFly()
	end
end)
