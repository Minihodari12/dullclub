--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local Character = player.Character or player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// Constants
local VALID_KEY = "MinihodariDeveloper"
local discordLink = "https://discord.gg/yourserver" -- muuta tähän oikea linkki

--// GUI setup
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "DullClubGUI"

-- Key Entry Frame
local keyFrame = Instance.new("Frame", ScreenGui)
keyFrame.Size = UDim2.new(0, 350, 0, 150)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
keyFrame.Active = true
keyFrame.Draggable = true

local keyLabel = Instance.new("TextLabel", keyFrame)
keyLabel.Size = UDim2.new(1, -20, 0, 30)
keyLabel.Position = UDim2.new(0, 10, 0, 10)
keyLabel.BackgroundTransparency = 1
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextSize = 20
keyLabel.Text = "Enter Your Key:"

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(1, -20, 0, 40)
keyBox.Position = UDim2.new(0, 10, 0, 50)
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.Font = Enum.Font.GothamBold
keyBox.TextSize = 24
keyBox.ClearTextOnFocus = false
keyBox.PlaceholderText = "Type key here..."

local submitBtn = Instance.new("TextButton", keyFrame)
submitBtn.Size = UDim2.new(0.5, -15, 0, 40)
submitBtn.Position = UDim2.new(0.5, 5, 1, -50)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 20
submitBtn.Text = "Submit"

-- Main Menu Frame
local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 400)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

-- Close Button
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Text = "X"

-- Tabs Buttons
local tabNames = {"Update Log", "All Games", "Fly", "Credits"}
local tabButtons = {}

for i, name in ipairs(tabNames) do
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0, 100, 0, 30)
	btn.Position = UDim2.new(0, 10 + (i-1)*110, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Text = name
	tabButtons[name] = btn
end

-- Content Frame
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -90)
contentFrame.Position = UDim2.new(0, 10, 0, 80)
contentFrame.BackgroundTransparency = 1

-- Update Log Frame
local updateLogFrame = Instance.new("Frame", contentFrame)
updateLogFrame.Size = UDim2.new(1, 0, 1, 0)
updateLogFrame.BackgroundTransparency = 0
updateLogFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)

local updateLogText = Instance.new("TextLabel", updateLogFrame)
updateLogText.Size = UDim2.new(1, -20, 1, -20)
updateLogText.Position = UDim2.new(0, 10, 0, 10)
updateLogText.TextWrapped = true
updateLogText.TextColor3 = Color3.new(1,1,1)
updateLogText.BackgroundTransparency = 1
updateLogText.Font = Enum.Font.GothamBold
updateLogText.TextSize = 18
updateLogText.Text = [[
Dull Club - Update Log:

- Added key system
- Added All Games commands
- Fly with WASD + Space/Ctrl
- Discord link and copy button
- Movable GUI
- More commands coming soon!
]]

-- All Games Frame
local allGamesFrame = Instance.new("Frame", contentFrame)
allGamesFrame.Size = UDim2.new(1, 0, 1, 0)
allGamesFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
allGamesFrame.Visible = false

local allGamesLabel = Instance.new("TextLabel", allGamesFrame)
allGamesLabel.Size = UDim2.new(1, -20, 0, 30)
allGamesLabel.Position = UDim2.new(0, 10, 0, 10)
allGamesLabel.BackgroundTransparency = 1
allGamesLabel.TextColor3 = Color3.new(1,1,1)
allGamesLabel.Font = Enum.Font.GothamBold
allGamesLabel.TextSize = 20
allGamesLabel.Text = "All Games Demo Commands"

-- Toggle variables
local noclipOn = false
local speedOn = false
local invisOn = false
local jumpBoostOn = false

-- Functions for toggles
local function toggleNoclip()
	noclipOn = not noclipOn
	for _, part in pairs(Character:GetChildren()) do
		if part:IsA("BasePart") then
			part.CanCollide = not noclipOn and true or false
		end
	end
end

local originalWalkSpeed = Humanoid.WalkSpeed
local function toggleSpeed()
	speedOn = not speedOn
	if speedOn then
		Humanoid.WalkSpeed = originalWalkSpeed * 2
	else
		Humanoid.WalkSpeed = originalWalkSpeed
	end
end

local function toggleInvisibility()
	invisOn = not invisOn
	for _, part in pairs(Character:GetChildren()) do
		if part:IsA("BasePart") or part:IsA("Decal") then
			part.Transparency = invisOn and 1 or 0
		end
		if part:IsA("Accessory") then
			local handle = part:FindFirstChild("Handle")
			if handle then
				handle.Transparency = invisOn and 1 or 0
			end
		end
	end
end

local originalJumpPower = Humanoid.JumpPower
local function toggleJumpBoost()
	jumpBoostOn = not jumpBoostOn
	if jumpBoostOn then
		Humanoid.JumpPower = originalJumpPower * 2
	else
		Humanoid.JumpPower = originalJumpPower
	end
end

local function healPlayer()
	Humanoid.Health = Humanoid.MaxHealth
end

-- Buttons for All Games
local noclipBtn = Instance.new("TextButton", allGamesFrame)
noclipBtn.Size = UDim2.new(0.4, 0, 0, 35)
noclipBtn.Position = UDim2.new(0.05, 0, 0, 50)
noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 18
noclipBtn.Text = "Toggle Noclip"
noclipBtn.MouseButton1Click:Connect(toggleNoclip)

local speedBtn = Instance.new("TextButton", allGamesFrame)
speedBtn.Size = UDim2.new(0.4, 0, 0, 35)
speedBtn.Position = UDim2.new(0.55, 0, 0, 50)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 18
speedBtn.Text = "Toggle Speed x2"
speedBtn.MouseButton1Click:Connect(toggleSpeed)

local invisBtn = Instance.new("TextButton", allGamesFrame)
invisBtn.Size = UDim2.new(0.4, 0, 0, 35)
invisBtn.Position = UDim2.new(0.05, 0, 0, 100)
invisBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
invisBtn.TextColor3 = Color3.new(1,1,1)
invisBtn.Font = Enum.Font.GothamBold
invisBtn.TextSize = 18
invisBtn.Text = "Toggle Invisibility"
invisBtn.MouseButton1Click:Connect(toggleInvisibility)

local jumpBoostBtn = Instance.new("TextButton", allGamesFrame)
jumpBoostBtn.Size = UDim2.new(0.4, 0, 0, 35)
jumpBoostBtn.Position = UDim2.new(0.55, 0, 0, 100)
jumpBoostBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
jumpBoostBtn.TextColor3 = Color3.new(1,1,1)
jumpBoostBtn.Font = Enum.Font.GothamBold
jumpBoostBtn.TextSize = 18
jumpBoostBtn.Text = "Toggle Jump Boost"
jumpBoostBtn.MouseButton1Click:Connect(toggleJumpBoost)

local healBtn = Instance.new("TextButton", allGamesFrame)
healBtn.Size = UDim2.new(0.9, 0, 0, 35)
healBtn.Position = UDim2.new(0.05, 0, 0, 150)
healBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
healBtn.TextColor3 = Color3.new(1,1,1)
healBtn.Font = Enum.Font.GothamBold
healBtn.TextSize = 18
healBtn.Text = "Heal Player"
healBtn.MouseButton1Click:Connect(healPlayer)

local fakeKickBtn = Instance.new("TextButton", allGamesFrame)
fakeKickBtn.Size = UDim2.new(0.9, 0, 0, 35)
fakeKickBtn.Position = UDim2.new(0.05, 0, 0, 200)
fakeKickBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
fakeKickBtn.TextColor3 = Color3.new(1,1,1)
fakeKickBtn.Font = Enum.Font.GothamBold
fakeKickBtn.TextSize = 18
fakeKickBtn.Text = "Fake Kick (real kick)"
fakeKickBtn.MouseButton1Click:Connect(function()
	player:Kick("You got kicked by Fake Kick!")
end)

-- Fly Frame
local flyFrame = Instance.new("Frame", contentFrame)
flyFrame.Size = UDim2.new(1, 0, 1, 0)
flyFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
flyFrame.Visible = false

local flyLabel = Instance.new("TextLabel", flyFrame)
flyLabel.Size = UDim2.new(1, -20, 0, 30)
flyLabel.Position = UDim2.new(0, 10, 0, 10)
flyLabel.BackgroundTransparency = 1
flyLabel.TextColor3 = Color3.new(1,1,1)
flyLabel.Font = Enum.Font.GothamBold
flyLabel.TextSize = 20
flyLabel.Text = "Fly - Use WASD + Space/Ctrl"

local flying = false
local flySpeed = 50
local flyBodyVelocity = nil
local flyBodyGyro = nil

local function startFly()
	if flying then return end
	flying = true

	flyBodyVelocity = Instance.new("BodyVelocity", HumanoidRootPart)
	flyBodyVelocity.Velocity = Vector3.new(0,0,0)
	flyBodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)

	flyBodyGyro = Instance.new("BodyGyro", HumanoidRootPart)
	flyBodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
	flyBodyGyro.CFrame = HumanoidRootPart.CFrame

	RunService:BindToRenderStep("FlyControl", Enum.RenderPriority.Character.Value, function()
		local moveDir = Vector3.new()
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end
		moveDir = moveDir.Unit
		if moveDir ~= moveDir then moveDir = Vector3.new(0,0,0) end -- NaN check
		flyBodyVelocity.Velocity = moveDir * flySpeed
		flyBodyGyro.CFrame = workspace.CurrentCamera.CFrame
	end)
end

local function stopFly()
	if not flying then return end
	flying = false
	if flyBodyVelocity then flyBodyVelocity:Destroy() end
	if flyBodyGyro then flyBodyGyro:Destroy() end
	RunService:UnbindFromRenderStep("FlyControl")
end

local flyToggleBtn = Instance.new("TextButton", flyFrame)
flyToggleBtn.Size = UDim2.new(0.5, 0, 0, 40)
flyToggleBtn.Position = UDim2.new(0.25, 0, 0, 50)
flyToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
flyToggleBtn.TextColor3 = Color3.new(1,1,1)
flyToggleBtn.Font = Enum.Font.GothamBold
flyToggleBtn.TextSize = 24
flyToggleBtn.Text = "Toggle Fly"
flyToggleBtn.MouseButton1Click:Connect(function()
	if flying then
		stopFly()
		flyToggleBtn.Text = "Toggle Fly"
	else
		startFly()
		flyToggleBtn.Text = "Stop Fly"
	end
end)

-- Credits Frame
local creditsFrame = Instance.new("Frame", contentFrame)
creditsFrame.Size = UDim2.new(1, 0, 1, 0)
creditsFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
creditsFrame.Visible = false

local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -20, 1, -20)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.TextWrapped = true
creditsLabel.TextColor3 = Color3.new(1,1,1)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Font = Enum.Font.GothamBold
creditsLabel.TextSize = 20
creditsLabel.Text = "Created by Minihodari12\nDiscord server coming soon!\n\nDiscord Link:"

local discordTextBox = Instance.new("TextBox", creditsFrame)
discordTextBox.Size = UDim2.new(0.9, 0, 0, 30)
discordTextBox.Position = UDim2.new(0.05, 0, 0, 100)
discordTextBox.Text = discordLink
discordTextBox.ClearTextOnFocus = false
discordTextBox.TextEditable = false
discordTextBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
discordTextBox.TextColor3 = Color3.new(1,1,1)
discordTextBox.Font = Enum.Font.GothamBold
discordTextBox.TextSize = 18

local copyBtn = Instance.new("TextButton", creditsFrame)
copyBtn.Size = UDim2.new(0.4, 0, 0, 30)
copyBtn.Position = UDim2.new(0.3, 0, 0, 140)
copyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 18
copyBtn.Text = "Copy Link"
copyBtn.MouseButton1Click:Connect(function()
	setclipboard(discordLink)
	copyBtn.Text = "Copied!"
	wait(1.5)
	copyBtn.Text = "Copy Link"
end)

-- Function to hide all content frames
local function hideAllFrames()
	updateLogFrame.Visible = false
	allGamesFrame.Visible = false
	flyFrame.Visible = false
	creditsFrame.Visible = false
end

-- Connect tab buttons
tabButtons["Update Log"].MouseButton1Click:Connect(function()
	hideAllFrames()
	updateLogFrame.Visible = true
end)
tabButtons["All Games"].MouseButton1Click:Connect(function()
	hideAllFrames()
	allGamesFrame.Visible = true
end)
tabButtons["Fly"].MouseButton1Click:Connect(function()
	hideAllFrames()
	flyFrame.Visible = true
end)
tabButtons["Credits"].MouseButton1Click:Connect(function()
	hideAllFrames()
	creditsFrame.Visible = true
end)

-- Start with Update Log visible
hideAllFrames()
updateLogFrame.Visible = true

-- Close button with confirmation
closeBtn.MouseButton1Click:Connect(function()
	local result = game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Close Dull Club",
		Text = "Are you sure you want to close the script?",
		Duration = 5,
		Button1 = "Yes",
		Button2 = "No"
	})
	-- Roblox doesn't have native confirmation dialog, so we use simple workaround:
	local confirmed = false
	-- Fake confirmation by using a simple dialog, but since we can't pause easily,
	-- just immediately close for now or you can add your own confirmation logic if you want
	-- For demo, we'll just close immediately:
	ScreenGui:Destroy()
end)

-- Key submit handler
submitBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == VALID_KEY then
		keyFrame.Visible = false
		mainFrame.Visible = true
	else
		player:Kick("Invalid key entered! Please contact the code owner.")
	end
end)

-- Optional: Allow pressing Enter in TextBox to submit
keyBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		submitBtn.MouseButton1Click:Fire()
	end
end)

-- Reset Humanoid variables on respawn
player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = Character:WaitForChild("Humanoid")
	HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

