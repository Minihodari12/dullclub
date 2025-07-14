-- Dull Club (Safe & Local Version)
-- Created by Minihodari12

-- CONFIG
local KEY = "MinihodariDeveloper"
local DISCORD_LINK = "https://discord.gg/yourserver"

-- SERVICES
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "DullClubUI"

-- DRAG FUNCTION
local function makeDraggable(frame)
	local dragging, offset
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			offset = input.Position - frame.AbsolutePosition
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	uis.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			frame.Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
		end
	end)
end

-- KEY GUI
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
makeDraggable(keyFrame)

Instance.new("UICorner", keyFrame)

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.PlaceholderText = "Enter Key"
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.Font = Enum.Font.SourceSansBold
keyBox.TextSize = 18
Instance.new("UICorner", keyBox)

local submit = Instance.new("TextButton", keyFrame)
submit.Text = "Submit"
submit.Size = UDim2.new(0.8, 0, 0, 30)
submit.Position = UDim2.new(0.1, 0, 0.65, 0)
submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submit.TextColor3 = Color3.new(1, 1, 1)
submit.Font = Enum.Font.SourceSansBold
submit.TextSize = 18
Instance.new("UICorner", submit)

submit.MouseButton1Click:Connect(function()
	if keyBox.Text == KEY then
		keyFrame:Destroy()

		-- MAIN GUI
		local mainFrame = Instance.new("Frame", gui)
		mainFrame.Size = UDim2.new(0, 400, 0, 300)
		mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
		mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		makeDraggable(mainFrame)
		Instance.new("UICorner", mainFrame)

		local function createTab(name, posY, onClick)
			local btn = Instance.new("TextButton", mainFrame)
			btn.Text = name
			btn.Size = UDim2.new(0.3, 0, 0, 30)
			btn.Position = UDim2.new(0.05, 0, posY, 0)
			btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			btn.TextColor3 = Color3.new(1,1,1)
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 18
			Instance.new("UICorner", btn)
			btn.MouseButton1Click:Connect(onClick)
		end

		local contentLabel = Instance.new("TextLabel", mainFrame)
		contentLabel.Size = UDim2.new(0.6, 0, 0.6, 0)
		contentLabel.Position = UDim2.new(0.35, 0, 0.2, 0)
		contentLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		contentLabel.TextColor3 = Color3.new(1,1,1)
		contentLabel.TextWrapped = true
		contentLabel.Font = Enum.Font.SourceSans
		contentLabel.TextSize = 16
		contentLabel.Text = "Welcome to Dull Club!"
		contentLabel.TextXAlignment = Enum.TextXAlignment.Left
		contentLabel.TextYAlignment = Enum.TextYAlignment.Top
		contentLabel.ClipsDescendants = true
		Instance.new("UICorner", contentLabel)

		-- Fly system
		local flying = false
		local bodyGyro, bodyVel

		local function toggleFly()
			local char = player.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end

			if not flying then
				flying = true
				bodyGyro = Instance.new("BodyGyro", hrp)
				bodyGyro.P = 9e4
				bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
				bodyGyro.CFrame = hrp.CFrame

				bodyVel = Instance.new("BodyVelocity", hrp)
				bodyVel.Velocity = Vector3.new(0, 0, 0)
				bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

				while flying do
					bodyGyro.CFrame = workspace.CurrentCamera.CFrame
					bodyVel.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
					task.wait()
				end
			else
				flying = false
				if bodyGyro then bodyGyro:Destroy() end
				if bodyVel then bodyVel:Destroy() end
			end
		end

		-- TABS
		createTab("All Games", 0.1, function()
			contentLabel.Text = "All Games Commands:\n\n- Fly (F key)\n- Fake Lag\n- Fake Kick (Only in your game)\n- Copy Discord"
		end)

		createTab("Update Log", 0.25, function()
			contentLabel.Text = "Update Log:\n\n- Added Fly\n- GUI tabs improved\n- Key system enhanced"
		end)

		createTab("Discord", 0.4, function()
			setclipboard(DISCORD_LINK)
			contentLabel.Text = "Discord link copied to clipboard!"
		end)

		createTab("Fly", 0.55, function()
			toggleFly()
			contentLabel.Text = flying and "Fly enabled" or "Fly disabled"
		end)

		createTab("Credits", 0.7, function()
			contentLabel.Text = "Script made by Minihodari12"
		end)

		-- Close Button
		local closeBtn = Instance.new("TextButton", mainFrame)
		closeBtn.Size = UDim2.new(0, 30, 0, 30)
		closeBtn.Position = UDim2.new(1, -35, 0, 5)
		closeBtn.Text = "X"
		closeBtn.TextColor3 = Color3.new(1,0.5,0.5)
		closeBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
		Instance.new("UICorner", closeBtn)

		closeBtn.MouseButton1Click:Connect(function()
			local confirm = Instance.new("TextLabel", mainFrame)
			confirm.Text = "Are you sure you want to close?"
			confirm.Size = UDim2.new(0.9, 0, 0, 30)
			confirm.Position = UDim2.new(0.05, 0, 0.85, 0)
			confirm.TextColor3 = Color3.new(1,1,1)
			confirm.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
			Instance.new("UICorner", confirm)
			task.wait(2)
			gui:Destroy()
		end)

	else
		player:Kick("Wrong key. Ask the owner for the correct key.")
	end
end)
