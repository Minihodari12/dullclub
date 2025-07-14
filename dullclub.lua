-- 🧠 DULL CLUB | Dandy's World Script
-- 🟨 GUI + Features + Fixed Key System

-- Settings
local correctKey = "DULL123" -- set your key here
local linkvertiseURL = "https://linkvertise.com/yourkeypage" -- your monetized key page

-- Key Input UI
local inputKey = tostring(game:HttpGet("https://pastebin.com/raw/YOUR_USER_INPUT")) -- or replace with your key prompt method

if inputKey ~= correctKey then
	game.Players.LocalPlayer:Kick("❌ Invalid key. Get it here:\n" .. linkvertiseURL)
	return
end

-- GUI Creation
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "DullClubGui"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 230, 0, 370)
frame.Position = UDim2.new(0, 50, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🪩 DULL CLUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24

local featureList = {
	"Fly", "Anti Die", "Teleport",
	"Speed Boost", "Invisible", "Do All Tasks"
}

local buttons = {}

for i, name in ipairs(featureList) do
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, (i - 1) * 50 + 50)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 20
	buttons[name] = btn
end

-- FLY
buttons["Fly"].MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/robloxscriptss/fly/main/fly.lua"))()
end)

-- ANTI DIE
buttons["Anti Die"].MouseButton1Click:Connect(function()
	local char = plr.Character
	if char then
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("TouchTransmitter") then v:Destroy() end
		end
		char.DescendantAdded:Connect(function(part)
			if part:IsA("TouchTransmitter") then part:Destroy() end
		end)
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			hum.Health = hum.MaxHealth
		end
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end
end)

-- TELEPORT
buttons["Teleport"].MouseButton1Click:Connect(function()
	local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if root then
		root.CFrame = CFrame.new(0, 100, 0) -- change coordinates if needed
	end
end)

-- SPEED BOOST
buttons["Speed Boost"].MouseButton1Click:Connect(function()
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = 100 end
end)

-- INVISIBLE
buttons["Invisible"].MouseButton1Click:Connect(function()
	local char = plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if root then
		local fake = root:Clone()
		root:Destroy()
		fake.Parent = char
	end
end)

-- DO ALL TASKS
buttons["Do All Tasks"].MouseButton1Click:Connect(function()
	local tasks = workspace:FindFirstChild("Tasks") or workspace:FindFirstChildOfClass("Folder")
	if not tasks then return end

	for _, task in pairs(tasks:GetChildren()) do
		if task:IsA("BasePart") then
			plr.Character:WaitForChild("HumanoidRootPart").CFrame = task.CFrame + Vector3.new(0,2,0)
			wait(1.2)
			local prompt = task:FindFirstChildWhichIsA("ProximityPrompt", true)
			if prompt then fireproximityprompt(prompt) end
		end
	end
end)
