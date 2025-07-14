local KEY = "MinihodariDeveloper"
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- UI Protection
if not game:IsLoaded() then game.Loaded:Wait() end

-- Key GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "DullClubKeyGui"
screenGui.ResetOnSpawn = false

local keyFrame = Instance.new("Frame", screenGui)
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.BorderSizePixel = 0

local title = Instance.new("TextLabel", keyFrame)
title.Text = "Dull Club Key System"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local textBox = Instance.new("TextBox", keyFrame)
textBox.Size = UDim2.new(1, -20, 0, 30)
textBox.Position = UDim2.new(0, 10, 0, 40)
textBox.PlaceholderText = "Enter Key..."
textBox.Text = ""
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.TextColor3 = Color3.new(1,1,1)

local submit = Instance.new("TextButton", keyFrame)
submit.Text = "Submit"
submit.Size = UDim2.new(0.5, -15, 0, 30)
submit.Position = UDim2.new(0, 10, 0, 90)
submit.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
submit.TextColor3 = Color3.new(1,1,1)

local info = Instance.new("TextLabel", keyFrame)
info.Text = "Join Discord! Link coming soon."
info.Size = UDim2.new(1, -20, 0, 20)
info.Position = UDim2.new(0, 10, 1, -25)
info.BackgroundTransparency = 1
info.TextColor3 = Color3.fromRGB(200, 200, 200)
info.TextScaled = true

local function createMainUI()
	screenGui:ClearAllChildren()
	
	local mainFrame = Instance.new("Frame", screenGui)
	mainFrame.Size = UDim2.new(0, 400, 0, 300)
	mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
	mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
	mainFrame.BorderSizePixel = 0
	mainFrame.Active = true
	mainFrame.Draggable = true
	
	local topBar = Instance.new("Frame", mainFrame)
	topBar.Size = UDim2.new(1, 0, 0, 30)
	topBar.BackgroundColor3 = Color3.fromRGB(45,45,45)

	local close = Instance.new("TextButton", topBar)
	close.Size = UDim2.new(0, 30, 0, 30)
	close.Position = UDim2.new(1, -30, 0, 0)
	close.Text = "X"
	close.TextColor3 = Color3.new(1,1,1)
	close.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	close.MouseButton1Click:Connect(function()
		local confirm = Instance.new("TextButton", mainFrame)
		confirm.Text = "Are you sure? Click to exit."
		confirm.Size = UDim2.new(0, 200, 0, 40)
		confirm.Position = UDim2.new(0.5, -100, 0.5, -20)
		confirm.BackgroundColor3 = Color3.fromRGB(255,80,80)
		confirm.TextColor3 = Color3.new(1,1,1)
		confirm.MouseButton1Click:Connect(function()
			screenGui:Destroy()
		end)
	end)

	local tabAllGames = Instance.new("TextButton", topBar)
	tabAllGames.Text = "All Games"
	tabAllGames.Size = UDim2.new(0, 100, 0, 30)
	tabAllGames.BackgroundColor3 = Color3.fromRGB(70,70,70)
	tabAllGames.TextColor3 = Color3.new(1,1,1)

	local tabUpdateLog = Instance.new("TextButton", topBar)
	tabUpdateLog.Text = "Update Log"
	tabUpdateLog.Size = UDim2.new(0, 100, 0, 30)
	tabUpdateLog.Position = UDim2.new(0, 100, 0, 0)
	tabUpdateLog.BackgroundColor3 = Color3.fromRGB(70,70,70)
	tabUpdateLog.TextColor3 = Color3.new(1,1,1)

	local contentFrame = Instance.new("Frame", mainFrame)
	contentFrame.Position = UDim2.new(0, 0, 0, 30)
	contentFrame.Size = UDim2.new(1, 0, 1, -30)
	contentFrame.BackgroundTransparency = 1

	local function clearContent()
		for _, v in pairs(contentFrame:GetChildren()) do v:Destroy() end
	end

	local function showAllGames()
		clearContent()

		local function button(name, func, y)
			local b = Instance.new("TextButton", contentFrame)
			b.Size = UDim2.new(1, -20, 0, 30)
			b.Position = UDim2.new(0, 10, 0, y)
			b.Text = name
			b.BackgroundColor3 = Color3.fromRGB(60,60,60)
			b.TextColor3 = Color3.new(1,1,1)
			b.MouseButton1Click:Connect(func)
		end

		button("Fly (toggle)", function()
			local UIS = game:GetService("UserInputService")
			local flying = false
			local vel = Instance.new("BodyVelocity")
			vel.MaxForce = Vector3.new(1e5, 1e5, 1e5)

			UIS.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.F then
					flying = not flying
					if flying then
						vel.Parent = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
						while flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
							local move = Vector3.new(0, 0, 0)
							if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0,0,-1) end
							if UIS:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0,0,1) end
							if UIS:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-1,0,0) end
							if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(1,0,0) end
							if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
							if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0,-1,0) end
							vel.Velocity = move * 50
							task.wait()
						end
						vel.Parent = nil
					end
				end
			end)
		end, 10)

		button("Fake Kick", function()
			LocalPlayer:Kick("Fake Kick: Disconnected by Admin")
		end, 50)

		button("Teleport to Spawn", function()
			local char = LocalPlayer.Character
			if char and workspace:FindFirstChild("SpawnLocation") then
				char:MoveTo(workspace.SpawnLocation.Position)
			end
		end, 90)

		button("WalkSpeed 50", function()
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 50
		end, 130)

		button("Reset WalkSpeed", function()
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
		end, 170)

	end

	local function showUpdateLog()
		clearContent()
		local log = Instance.new("TextLabel", contentFrame)
		log.Text = "✅ Update Log:\n- GUI Menu\n- Fly (F key)\n- Key Protection\n- Discord Coming Soon"
		log.Size = UDim2.new(1, -20, 1, -20)
		log.Position = UDim2.new(0, 10, 0, 10)
		log.TextColor3 = Color3.new(1,1,1)
		log.BackgroundTransparency = 1
		log.TextWrapped = true
		log.TextYAlignment = Enum.TextYAlignment.Top
	end

	tabAllGames.MouseButton1Click:Connect(showAllGames)
	tabUpdateLog.MouseButton1Click:Connect(showUpdateLog)

	showAllGames()
end

submit.MouseButton1Click:Connect(function()
	if textBox.Text == KEY then
		createMainUI()
	else
		LocalPlayer:Kick("❌ Wrong key. Ask the creator for access.")
	end
end)
