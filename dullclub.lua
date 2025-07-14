--[[
    Dull Club (Safe Edition)
    Created by Minihodari12
    GUI with key check, fly (in your own game), and more.
--]]

-- CONFIGURATION
local correctKey = "MinihodariDeveloper"
local discordInvite = "https://discord.gg/yourserver"

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Create main GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DullClubSafe"

-- Draggable Frame
local function makeDraggable(frame)
	local dragToggle, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- Key Frame
local keyFrame = Instance.new("Frame", screenGui)
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyFrame.BorderSizePixel = 0
makeDraggable(keyFrame)

local title = Instance.new("TextLabel", keyFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Enter Key"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
keyBox.Size = UDim2.new(0.8, 0, 0, 30)
keyBox.PlaceholderText = "Enter key..."
keyBox.Text = ""
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 18
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(60,60,60)

local submit = Instance.new("TextButton", keyFrame)
submit.Position = UDim2.new(0.25, 0, 0.7, 0)
submit.Size = UDim2.new(0.5, 0, 0, 30)
submit.Text = "Submit"
submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submit.TextColor3 = Color3.new(1,1,1)
submit.Font = Enum.Font.SourceSansBold
submit.TextSize = 18

submit.MouseButton1Click:Connect(function()
	if keyBox.Text == correctKey then
		keyFrame:Destroy()
		-- Load Main GUI
		local mainFrame = Instance.new("Frame", screenGui)
		mainFrame.Size = UDim2.new(0, 350, 0, 250)
		mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
		mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		makeDraggable(mainFrame)

		local menuTitle = Instance.new("TextLabel", mainFrame)
		menuTitle.Size = UDim2.new(1, 0, 0, 30)
		menuTitle.Text = "Dull Club"
		menuTitle.Font = Enum.Font.SourceSansBold
		menuTitle.TextSize = 22
		menuTitle.TextColor3 = Color3.new(1,1,1)
		menuTitle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

		local function createButton(name, posY, callback)
			local btn = Instance.new("TextButton", mainFrame)
			btn.Position = UDim2.new(0.1, 0, posY, 0)
			btn.Size = UDim2.new(0.8, 0, 0, 30)
			btn.Text = name
			btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
			btn.TextColor3 = Color3.new(1,1,1)
			btn.Font = Enum.Font.SourceSansBold
			btn.TextSize = 18
			btn.MouseButton1Click:Connect(callback)
		end

		createButton("Fly (toggle F)", 0.2, function()
			local flying = false
			local velocity = Instance.new("BodyVelocity")
			velocity.MaxForce = Vector3.new(100000, 100000, 100000)
			local character = player.Character or player.CharacterAdded:Wait()
			local hrp = character:WaitForChild("HumanoidRootPart")

			UserInputService.InputBegan:Connect(function(input)
				if input.KeyCode == Enum.KeyCode.F then
					flying = not flying
					if flying then
						velocity.Parent = hrp
						while flying and character and hrp do
							velocity.Velocity = (player:GetMouse().Hit.p - hrp.Position).unit * 100
							wait()
						end
					else
						velocity:Destroy()
					end
				end
			end)
		end)

		createButton("Update Log", 0.35, function()
			print("Update Log: New features added.")
		end)

		createButton("Copy Discord", 0.5, function()
			setclipboard(discordInvite)
		end)

		createButton("Credits", 0.65, function()
			print("Created by Minihodari12.")
		end)

		-- Close Button
		local closeBtn = Instance.new("TextButton", mainFrame)
		closeBtn.Size = UDim2.new(0, 30, 0, 30)
		closeBtn.Position = UDim2.new(1, -35, 0, 5)
		closeBtn.Text = "X"
		closeBtn.TextColor3 = Color3.new(1,0.5,0.5)
		closeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
		closeBtn.MouseButton1Click:Connect(function()
			local confirm = Instance.new("TextLabel", mainFrame)
			confirm.Text = "Are you sure you want to close?"
			confirm.Position = UDim2.new(0.1, 0, 0.8, 0)
			confirm.Size = UDim2.new(0.8, 0, 0, 30)
			confirm.TextColor3 = Color3.new(1,1,1)
			confirm.BackgroundColor3 = Color3.fromRGB(80,0,0)
			wait(2)
			screenGui:Destroy()
		end)

	else
		player:Kick("Wrong key! Ask the creator for the correct one.")
	end
end)
