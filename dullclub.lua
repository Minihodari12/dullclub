-- Minihodari12 GUI | Safe & Improved Version
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local UIS = game:GetService("UserInputService")

-- CONFIG
local KEY = "MinihodariDeveloper"
local DiscordInvite = "https://discord.gg/YOURDISCORD"

-- GUI Setup
local GUI = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
GUI.Name = "DullClubGUI"
GUI.ResetOnSpawn = false

-- Function: Draggable Frames
local function makeDraggable(frame)
	local drag = false
	local dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					drag = false
				end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and drag then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- Key Frame
local KeyFrame = Instance.new("Frame", GUI)
KeyFrame.Size = UDim2.new(0, 320, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyFrame.BorderSizePixel = 0
makeDraggable(KeyFrame)
Instance.new("UICorner", KeyFrame)

local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🔑 Enter Access Key"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
KeyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyBox.PlaceholderText = "Enter key here..."
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
KeyBox.Font = Enum.Font.SourceSansBold
KeyBox.TextSize = 18
Instance.new("UICorner", KeyBox)

local Submit = Instance.new("TextButton", KeyFrame)
Submit.Text = "✔️ Submit"
Submit.Size = UDim2.new(0.8, 0, 0, 30)
Submit.Position = UDim2.new(0.1, 0, 0.7, 0)
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Submit.TextColor3 = Color3.new(1,1,1)
Submit.Font = Enum.Font.SourceSansBold
Submit.TextSize = 18
Instance.new("UICorner", Submit)

-- Kick if wrong key
Submit.MouseButton1Click:Connect(function()
	if KeyBox.Text == KEY then
		KeyFrame:Destroy()

		-- Main Frame
		local Main = Instance.new("Frame", GUI)
		Main.Size = UDim2.new(0, 500, 0, 350)
		Main.Position = UDim2.new(0.5, -250, 0.5, -175)
		Main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Instance.new("UICorner", Main)
		makeDraggable(Main)

		local MenuLabel = Instance.new("TextLabel", Main)
		MenuLabel.Size = UDim2.new(1, 0, 0, 40)
		MenuLabel.Text = "🛠️ Dull Club Menu"
		MenuLabel.BackgroundTransparency = 1
		MenuLabel.TextColor3 = Color3.new(1, 1, 1)
		MenuLabel.Font = Enum.Font.GothamBold
		MenuLabel.TextSize = 22

		local Close = Instance.new("TextButton", Main)
		Close.Text = "❌"
		Close.Size = UDim2.new(0, 30, 0, 30)
		Close.Position = UDim2.new(1, -35, 0, 5)
		Close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
		Close.TextColor3 = Color3.new(1,1,1)
		Close.Font = Enum.Font.GothamBold
		Close.TextSize = 20
		Instance.new("UICorner", Close)

		Close.MouseButton1Click:Connect(function()
			if Main:FindFirstChild("ConfirmBox") then return end
			local confirm = Instance.new("TextLabel", Main)
			confirm.Name = "ConfirmBox"
			confirm.Size = UDim2.new(0.8, 0, 0, 30)
			confirm.Position = UDim2.new(0.1, 0, 0.9, 0)
			confirm.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
			confirm.Text = "Are you sure? Click again to confirm"
			confirm.TextColor3 = Color3.new(1,1,1)
			confirm.Font = Enum.Font.Gotham
			confirm.TextSize = 16
			task.delay(2, function() confirm:Destroy() end)
		end)

		Close.MouseButton1Click:Connect(function()
			if Main:FindFirstChild("ConfirmBox") then
				GUI:Destroy()
			end
		end)

		-- Fly button
		local flying = false
		local function toggleFly()
			local char = Player.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end

			flying = not flying
			local bv = Instance.new("BodyVelocity", hrp)
			local bg = Instance.new("BodyGyro", hrp)
			bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

			while flying do
				bv.Velocity = UIS:IsKeyDown(Enum.KeyCode.Space) and Vector3.new(0, 100, 0) or Vector3.zero
				bg.CFrame = workspace.CurrentCamera.CFrame
				task.wait()
			end
			bv:Destroy()
			bg:Destroy()
		end

		-- Buttons
		local function createButton(text, yPos, callback)
			local btn = Instance.new("TextButton", Main)
			btn.Text = text
			btn.Size = UDim2.new(0.8, 0, 0, 35)
			btn.Position = UDim2.new(0.1, 0, yPos, 0)
			btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
			btn.TextColor3 = Color3.new(1,1,1)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 18
			Instance.new("UICorner", btn)
			btn.MouseButton1Click:Connect(callback)
		end

		createButton("🚀 Fly (F)", 0.2, function()
			toggleFly()
		end)

		createButton("📜 Update Log", 0.35, function()
			print("New updates: Fly system, better UI, draggable windows.")
		end)

		createButton("📋 Copy Discord", 0.5, function()
			setclipboard(DiscordInvite)
			print("Copied Discord invite.")
		end)

		createButton("💻 Credits: Minihodari12", 0.65, function()
			print("Made by Minihodari12")
		end)

		-- F key toggles fly
		UIS.InputBegan:Connect(function(input, gpe)
			if gpe then return end
			if input.KeyCode == Enum.KeyCode.F then
				toggleFly()
			end
		end)
	else
		Player:Kick("❌ Wrong key. Ask Minihodari12 for the correct key.")
	end
end)
