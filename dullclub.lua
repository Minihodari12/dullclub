-- Dull Club GUI Script (päivitetty)

local player = game.Players.LocalPlayer
local Character = player.Character or player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local VALID_KEY = "MinihodariDeveloper"
local discordLink = "https://discord.gg/yourserver" -- vaihda oma linkki tähän

-- Luodaan ScreenGui
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "DullClubGUI"
ScreenGui.ResetOnSpawn = false

-- Pääkehys
local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

-- Sulje nappi
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20

-- Tab-painikkeet
local tabs = {"Update Log", "All Games", "Fly", "Credits", "Discord"}
local tabButtons = {}
local contentFrames = {}

local tabHeight = 30
local tabWidth = 75
local tabSpacing = 5

for i, tabName in ipairs(tabs) do
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0, tabWidth, 0, tabHeight)
	btn.Position = UDim2.new(0, (tabWidth + tabSpacing) * (i-1) + 10, 0, 40)
	btn.Text = tabName
	btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	tabButtons[tabName] = btn

	local frame = Instance.new("Frame", mainFrame)
	frame.Size = UDim2.new(1, -20, 1, -90)
	frame.Position = UDim2.new(0, 10, 0, 75)
	frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	frame.Visible = false
	contentFrames[tabName] = frame
end

-- Update Log sisältö
local updateLogLabel = Instance.new("TextLabel", contentFrames["Update Log"])
updateLogLabel.Size = UDim2.new(1, -20, 1, -20)
updateLogLabel.Position = UDim2.new(0, 10, 0, 10)
updateLogLabel.TextWrapped = true
updateLogLabel.TextColor3 = Color3.new(1,1,1)
updateLogLabel.BackgroundTransparency = 1
updateLogLabel.Font = Enum.Font.GothamBold
updateLogLabel.TextSize = 18
updateLogLabel.Text = [[
Update Log:
- Added All Games tab with more commands
- Improved Fly mechanics
- Added Discord tab with copy link button
- Fixed GUI draggable and close confirmation
]]

-- All Games -välilehti napit ja funktiot
local allGamesFrame = contentFrames["All Games"]

local function healPlayer()
	if Humanoid and Humanoid.Health < Humanoid.MaxHealth then
		Humanoid.Health = Humanoid.MaxHealth
	end
end

local healBtn = Instance.new("TextButton", allGamesFrame)
healBtn.Size = UDim2.new(0.9, 0, 0, 35)
healBtn.Position = UDim2.new(0.05, 0, 0, 10)
healBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
healBtn.TextColor3 = Color3.new(1,1,1)
healBtn.Font = Enum.Font.GothamBold
healBtn.TextSize = 18
healBtn.Text = "Heal Player"
healBtn.MouseButton1Click:Connect(healPlayer)

local fakeKickBtn = Instance.new("TextButton", allGamesFrame)
fakeKickBtn.Size = UDim2.new(0.9, 0, 0, 35)
fakeKickBtn.Position = UDim2.new(0.05, 0, 0, 60)
fakeKickBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
fakeKickBtn.TextColor3 = Color3.new(1,1,1)
fakeKickBtn.Font = Enum.Font.GothamBold
fakeKickBtn.TextSize = 18
fakeKickBtn.Text = "Fake Kick (real kick)"
fakeKickBtn.MouseButton1Click:Connect(function()
	player:Kick("You got kicked by Fake Kick!")
end)

-- Lisää muita All Games komentoja halutessasi tähän

-- Fly välilehti
local flyFrame = contentFrames["Fly"]

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
		if moveDir.Magnitude > 0 then
			moveDir = moveDir.Unit
		else
			moveDir = Vector3.new(0,0,0)
		end
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

-- Credits välilehti
local creditsFrame = contentFrames["Credits"]

local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -20, 1, -20)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.TextWrapped = true
creditsLabel.TextColor3 = Color3.new(1,1,1)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Font = Enum.Font.GothamBold
creditsLabel.TextSize = 20
creditsLabel.Text = [[
Created by Minihodari12
Discord server coming soon!
]]

-- Discord välilehti
local discordFrame = contentFrames["Discord"]

local discordLabel = Instance.new("TextLabel", discordFrame)
discordLabel.Size = UDim2.new(1, -20, 0, 30)
discordLabel.Position = UDim2.new(0, 10, 0, 10)
discordLabel.TextColor3 = Color3.new(1,1,1)
discordLabel.BackgroundTransparency = 1
discordLabel.Font = Enum.Font.GothamBold
discordLabel.TextSize = 20
discordLabel.Text = "Discord Link:"

local discordTextBox = Instance.new("TextBox", discordFrame)
discordTextBox.Size = UDim2.new(0.9, 0, 0, 30)
discordTextBox.Position = UDim2.new(0.05, 0, 0, 50)
discordTextBox.Text = discordLink
discordTextBox.ClearTextOnFocus = false
discordTextBox.TextEditable = false
discordTextBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
discordTextBox.TextColor3 = Color3.new(1,1,1)
discordTextBox.Font = Enum.Font.GothamBold
discordTextBox.TextSize = 18

local copyBtn = Instance.new("TextButton", discordFrame)
copyBtn.Size = UDim2.new(0.4, 0, 0, 30)
copyBtn.Position = UDim2.new(0.3, 0, 0, 90)
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

-- Funktio kaikkien content-framejen piilottamiseksi
local function hideAllFrames()
	for _, frame in pairs(contentFrames) do
		frame.Visible = false
	end
end

-- Tab-painikkeiden toimintojen yhdistäminen
for tabName, btn in pairs(tabButtons) do
	btn.MouseButton1Click:Connect(function()
		hideAllFrames()
		contentFrames[tabName].Visible = true
	end)
end

-- Aloita näyttämällä Update Log
hideAllFrames()
contentFrames["Update Log"].Visible = true
mainFrame.Visible = true

-- Sulje nappi kysymyksellä
closeBtn.MouseButton1Click:Connect(function()
	local confirm = Instance.new("TextButton", ScreenGui)
	confirm.Size = UDim2.new(0, 250, 0, 100)
	confirm.Position = UDim2.new(0.5, -125, 0.5, -50)
	confirm.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	confirm.TextColor3 = Color3.new(1,1,1)
	confirm.Font = Enum.Font.GothamBold
	confirm.TextSize = 22
	confirm.Text = "Are you sure you want to close?\nClick to confirm"
	confirm.AutoButtonColor = true

	confirm.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	wait(5)
	if confirm and confirm.Parent then
		confirm:Destroy()
	end
end)

-- Humanoid päivitys respawnissa
player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = Character:WaitForChild("Humanoid")
	HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)
