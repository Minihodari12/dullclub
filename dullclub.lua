local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local VALID_KEY = "MinihodariDeveloper"

-- Luo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "DullClubGUI"
gui.Parent = Player:WaitForChild("PlayerGui")

-- Key -frame
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 350, 0, 150)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.Parent = gui

local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(1, 0, 0, 40)
keyLabel.BackgroundTransparency = 1
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextSize = 18
keyLabel.Text = "Enter Key to Access:"
keyLabel.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8, 0, 0, 40)
keyBox.Position = UDim2.new(0.1, 0, 0, 50)
keyBox.PlaceholderText = "Enter key here"
keyBox.Text = ""
keyBox.Parent = keyFrame

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.8, 0, 0, 40)
submitBtn.Position = UDim2.new(0.1, 0, 0, 100)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 18
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.Text = "Submit"
submitBtn.Parent = keyFrame

-- Päämenu frame (piilotettu aluksi)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.Visible = false
mainFrame.Parent = gui
mainFrame.Active = true

-- Otsikko ja X-nappi
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Text = "Dull Club"
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Text = "X"
closeButton.Parent = mainFrame

-- Sisältöalue
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -70)
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Tabit
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 30)
tabFrame.Position = UDim2.new(0, 0, 1, -30)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = mainFrame

local tabs = {"Update Log", "All Games", "Fly", "Credits"}
local tabButtons = {}

local function clearContent()
	for _, child in pairs(contentFrame:GetChildren()) do
		child:Destroy()
	end
end

local function showUpdateLog()
	clearContent()
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1,1,1)
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextWrapped = true
	label.Text = [[
Version 1.0 - Demo release
- Added fly teleport menu
- Added fake kick
- Added noclip, speed, invisibility toggles
- Added credits and update log tabs
]]
	label.Parent = contentFrame
end

local noclipEnabled = false
local speedEnabled = false
local invisEnabled = false

local function toggleNoclip()
	noclipEnabled = not noclipEnabled
	local char = Player.Character
	if not char then return end
	for _, part in pairs(char:GetChildren()) do
		if part:IsA("BasePart") then
			part.CanCollide = not noclipEnabled
		end
	end
end

local function toggleSpeed()
	speedEnabled = not speedEnabled
	local char = Player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		if speedEnabled then
			hum.WalkSpeed = 50
		else
			hum.WalkSpeed = 16
		end
	end
end

local function toggleInvisibility()
	invisEnabled = not invisEnabled
	local char = Player.Character
	if not char then return end
	for _, part in pairs(char:GetChildren()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			part.Transparency = invisEnabled and 1 or 0
			if part:FindFirstChildOfClass("Decal") then
				part:FindFirstChildOfClass("Decal").Transparency = invisEnabled and 1 or 0
			end
		end
	end
end

local function fakeKick()
	Player:Kick("You have been kicked (fake kick simulation).")
end

local function showAllGames()
	clearContent()

	local noclipBtn = Instance.new("TextButton")
	noclipBtn.Size = UDim2.new(0.8, 0, 0, 35)
	noclipBtn.Position = UDim2.new(0.1, 0, 0, 10)
	noclipBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	noclipBtn.TextColor3 = Color3.new(1,1,1)
	noclipBtn.Font = Enum.Font.Gotham
	noclipBtn.TextSize = 18
	noclipBtn.Text = "Toggle Noclip (Currently "..(noclipEnabled and "ON" or "OFF")..")"
	noclipBtn.Parent = contentFrame
	noclipBtn.MouseButton1Click:Connect(function()
		toggleNoclip()
		noclipBtn.Text = "Toggle Noclip (Currently "..(noclipEnabled and "ON" or "OFF")..")"
	end)

	local speedBtn = Instance.new("TextButton")
	speedBtn.Size = UDim2.new(0.8, 0, 0, 35)
	speedBtn.Position = UDim2.new(0.1, 0, 0, 55)
	speedBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	speedBtn.TextColor3 = Color3.new(1,1,1)
	speedBtn.Font = Enum.Font.Gotham
	speedBtn.TextSize = 18
	speedBtn.Text = "Toggle Speed (Currently "..(speedEnabled and "ON" or "OFF")..")"
	speedBtn.Parent = contentFrame
	speedBtn.MouseButton1Click:Connect(function()
		toggleSpeed()
		speedBtn.Text = "Toggle Speed (Currently "..(speedEnabled and "ON" or "OFF")..")"
	end)

	local invisBtn = Instance.new("TextButton")
	invisBtn.Size = UDim2.new(0.8, 0, 0, 35)
	invisBtn.Position = UDim2.new(0.1, 0, 0, 100)
	invisBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	invisBtn.TextColor3 = Color3.new(1,1,1)
	invisBtn.Font = Enum.Font.Gotham
	invisBtn.TextSize = 18
	invisBtn.Text = "Toggle Invisibility (Currently "..(invisEnabled and "ON" or "OFF")..")"
	invisBtn.Parent = contentFrame
	invisBtn.MouseButton1Click:Connect(function()
		toggleInvisibility()
		invisBtn.Text = "Toggle Invisibility (Currently "..(invisEnabled and "ON" or "OFF")..")"
	end)

	local fkBtn = Instance.new("TextButton")
	fkBtn.Size = UDim2.new(0.8, 0, 0, 35)
	fkBtn.Position = UDim2.new(0.1, 0, 0, 145)
	fkBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
	fkBtn.TextColor3 = Color3.new(1,1,1)
	fkBtn.Font = Enum.Font.GothamBold
	fkBtn.TextSize = 18
	fkBtn.Text = "Fake Kick Player"
	fkBtn.Parent = contentFrame
	fkBtn.MouseButton1Click:Connect(fakeKick)
end

-- Lentäminen
local flying = false
local speed = 50
local flightVelocity = nil

local function startFly()
	local char = Player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	flying = true
	hum.PlatformStand = true

	flightVelocity = Instance.new("BodyVelocity")
	flightVelocity.Velocity = Vector3.new(0,0,0)
	flightVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	flightVelocity.Parent = hrp
end

local function stopFly()
	local char = Player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	flying = false
	hum.PlatformStand = false
	if flightVelocity then
		flightVelocity:Destroy()
		flightVelocity = nil
	end
end

local function flyUpdate()
	if not flying then return end
	local char = Player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local direction = Vector3.new(0,0,0)
	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		direction = direction + workspace.CurrentCamera.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		direction = direction - workspace.CurrentCamera.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		direction = direction - workspace.CurrentCamera.CFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		direction = direction + workspace.CurrentCamera.CFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
		direction = direction + Vector3.new(0,1,0)
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		direction = direction - Vector3.new(0,1,0)
	end

	direction = direction.Unit
	if direction ~= direction then direction = Vector3.new(0,0,0) end -- check NaN

	if flightVelocity then
		flightVelocity.Velocity = direction * speed
	end
end

local function showFlyMenu()
	clearContent()

	local flyToggleBtn = Instance.new("TextButton")
	flyToggleBtn.Size = UDim2.new(0.8, 0, 0, 35)
	flyToggleBtn.Position = UDim2.new(0.1, 0, 0, 10)
	flyToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	flyToggleBtn.TextColor3 = Color3.new(1,1,1)
	flyToggleBtn.Font = Enum.Font.GothamBold
	flyToggleBtn.TextSize = 18
	flyToggleBtn.Text = flying and "Stop Flying" or "Start Flying"
	flyToggleBtn.Parent = contentFrame

	flyToggleBtn.MouseButton1Click:Connect(function()
		if flying then
			stopFly()
			flyToggleBtn.Text = "Start Flying"
		else
			startFly()
			flyToggleBtn.Text = "Stop Flying"
		end
	end)
end

RunService.Heartbeat:Connect(flyUpdate)

-- Discord linkki ja copy-nappi
local function showCredits()
	clearContent()

	local discordLink = "https://discord.gg/YOUR_SERVER_LINK"

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,0,60)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1,1,1)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 18
	label.TextWrapped = true
	label.Text = "Created by Minihodari12\nThanks for using Dull Club!\nDiscord server coming soon!"
	label.Parent = contentFrame

	local discordBox = Instance.new("TextBox")
	discordBox.Size = UDim2.new(0.8, 0, 0, 35)
	discordBox.Position = UDim2.new(0.1, 0, 0, 70)
	discordBox.Text = discordLink
	discordBox.ClearTextOnFocus = false
	discordBox.TextEditable = false
	discordBox.Parent = contentFrame

	local copyBtn = Instance.new("TextButton")
	copyBtn.Size = UDim2.new(0.3, 0, 0, 30)
	copyBtn.Position = UDim2.new(0.35, 0, 0, 110)
	copyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	copyBtn.TextColor3 = Color3.new(1,1,1)
	copyBtn.Font = Enum.Font.GothamBold
	copyBtn.TextSize = 16
	copyBtn.Text = "Copy Link"
	copyBtn.Parent = contentFrame

	copyBtn.MouseButton1Click:Connect(function()
		setclipboard(discordLink)
	end)
end

local function selectTab(tabName)
	if tabName == "Update Log" then
		showUpdateLog()
	elseif tabName == "All Games" then
		showAllGames()
	elseif tabName == "Fly" then
		showFlyMenu()
	elseif tabName == "Credits" then
		showCredits()
	end
end

-- Luo välilehtipainikkeet
for i, tabName in ipairs(tabs) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 100, 1, 0)
	btn.Position = UDim2.new(0, (i-1)*100, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Text = tabName
	btn.Parent = tabFrame
	btn.MouseButton1Click:Connect(function()
		selectTab(tabName)
	end)
	tabButtons[tabName] = btn
end

-- X-napin sulkemisvarmistus
closeButton.MouseButton1Click:Connect(function()
	local confirmFrame = Instance.new("Frame")
	confirmFrame.Size = UDim2.new(0, 300, 0, 150)
	confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
	confirmFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	confirmFrame.Parent = gui
	confirmFrame.ZIndex = 10

	local confirmText = Instance.new("TextLabel")
	confirmText.Size = UDim2.new(1,0,0,60)
	confirmText.Position = UDim2.new(0,0,0,10)
	confirmText.BackgroundTransparency = 1
	confirmText.TextColor3 = Color3.new(1,1,1)
	confirmText.Font = Enum.Font.GothamBold
	confirmText.TextSize = 18
	confirmText.TextWrapped = true
	confirmText.Text = "Are you sure you want to close the menu?"
	confirmText.Parent = confirmFrame

	local yesBtn = Instance.new("TextButton")
	yesBtn.Size = UDim2.new(0.4, 0, 0, 40)
	yesBtn.Position = UDim2.new(0.05, 0, 1, -50)
	yesBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	yesBtn.TextColor3 = Color3.new(1,1,1)
	yesBtn.Font = Enum.Font.GothamBold
	yesBtn.TextSize = 18
	yesBtn.Text = "Yes"
	yesBtn.Parent = confirmFrame

	local noBtn = Instance.new("TextButton")
	noBtn.Size = UDim2.new(0.4, 0, 0, 40)
	noBtn.Position = UDim2.new(0.55, 0, 1, -50)
	noBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
	noBtn.TextColor3 = Color3.new(1,1,1)
	noBtn.Font = Enum.Font.GothamBold
	noBtn.TextSize = 18
	noBtn.Text = "No"
	noBtn.Parent = confirmFrame

	yesBtn.MouseButton1Click:Connect(function()
		gui:Destroy()
	end)

	noBtn.MouseButton1Click:Connect(function()
		confirmFrame:Destroy()
	end)
end)

-- Make GUI draggable (for mainFrame and keyFrame)
local function makeDraggable(frame)
	local dragging = false
	local dragInput
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

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	RunService.RenderStepped:Connect(function()
		if dragging and dragInput then
			local delta = dragInput.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

makeDraggable(mainFrame)
makeDraggable(keyFrame)

-- Key submit toiminto
submitBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == VALID_KEY then
		keyFrame.Visible = false
		mainFrame.Visible = true
		selectTab("Update Log")
	else
		Player:Kick("Invalid key entered! Please contact the code owner. Discord server coming soon!")
	end
end)
