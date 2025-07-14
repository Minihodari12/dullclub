local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local correctKey = "MinihodariDeveloper"

-- Luo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "SimpleDullClub"
gui.Parent = game.CoreGui

-- Tausta
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.Visible = false
mainFrame.ClipsDescendants = true

local uicorner = Instance.new("UICorner", mainFrame)

-- Otsikko
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Simple DullClub"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 24

-- Sulje-nappi (X)
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 20

closeBtn.MouseButton1Click:Connect(function()
    local confirmFrame = Instance.new("Frame", gui)
    confirmFrame.Size = UDim2.new(0, 300, 0, 120)
    confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
    confirmFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    local corner = Instance.new("UICorner", confirmFrame)

    local msg = Instance.new("TextLabel", confirmFrame)
    msg.Size = UDim2.new(1,0,0,50)
    msg.Position = UDim2.new(0,0,0,10)
    msg.BackgroundTransparency = 1
    msg.TextColor3 = Color3.new(1,1,1)
    msg.Font = Enum.Font.GothamBold
    msg.TextSize = 20
    msg.Text = "Are you sure you want to close?"

    local yesBtn = Instance.new("TextButton", confirmFrame)
    yesBtn.Size = UDim2.new(0.4,0,0,35)
    yesBtn.Position = UDim2.new(0.1,0,0,70)
    yesBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
    yesBtn.Text = "Yes"
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextColor3 = Color3.new(1,1,1)
    yesBtn.TextSize = 18

    local noBtn = Instance.new("TextButton", confirmFrame)
    noBtn.Size = UDim2.new(0.4,0,0,35)
    noBtn.Position = UDim2.new(0.5,0,0,70)
    noBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
    noBtn.Text = "No"
    noBtn.Font = Enum.Font.GothamBold
    noBtn.TextColor3 = Color3.new(1,1,1)
    noBtn.TextSize = 18

    yesBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    noBtn.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
    end)
end)

-- Key syöttö ikkuna
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local keyCorner = Instance.new("UICorner", keyFrame)

local keyLabel = Instance.new("TextLabel", keyFrame)
keyLabel.Size = UDim2.new(1, 0, 0, 40)
keyLabel.BackgroundTransparency = 1
keyLabel.Position = UDim2.new(0,0,0,10)
keyLabel.Text = "Enter Key:"
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.TextSize = 20

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8, 0, 0, 40)
keyBox.Position = UDim2.new(0.1, 0, 0, 60)
keyBox.ClearTextOnFocus = false
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.PlaceholderText = "Enter your key here"

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Size = UDim2.new(0.5, 0, 0, 35)
keyBtn.Position = UDim2.new(0.25, 0, 0, 110)
keyBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
keyBtn.Text = "Submit"
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextColor3 = Color3.new(1,1,1)
keyBtn.TextSize = 18

local function showMessage(text)
    local msg = Instance.new("TextLabel", keyFrame)
    msg.Size = UDim2.new(1,0,0,30)
    msg.Position = UDim2.new(0,0,1,5)
    msg.BackgroundTransparency = 1
    msg.TextColor3 = Color3.new(1,0,0)
    msg.Font = Enum.Font.GothamBold
    msg.TextSize = 18
    msg.Text = text
    game.Debris:AddItem(msg, 3)
end

keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == correctKey then
        keyFrame:Destroy()
        mainFrame.Visible = true
    else
        showMessage("Wrong key! Contact owner for code.")
        wait(1)
        Player:Kick("Wrong key used. Contact owner for code.")
    end
end)

-- Tabien luonti
local tabNames = {"Update Log", "All Games"}
local tabs = {}

local function clearContent()
    for _, child in pairs(mainFrame:GetChildren()) do
        if child.Name == "Content" then
            child:Destroy()
        end
    end
end

local flying = false
local bodyVelocity
local flyConnection

local function startFly()
    if flying then return end
    local character = Player.Character or Player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    flying = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Velocity = Vector3.new(0,0,0)
    bodyVelocity.Parent = hrp

    flyConnection = RunService.Heartbeat:Connect(function()
        if not flying then
            bodyVelocity:Destroy()
            flyConnection:Disconnect()
            return
        end
        local moveDir = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + hrp.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - hrp.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - hrp.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + hrp.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0,1,0) end

        if moveDir.Magnitude > 0 then
            bodyVelocity.Velocity = moveDir.Unit * 60
        else
            bodyVelocity.Velocity = Vector3.new(0,0,0)
        end
    end)
end

local function stopFly()
    flying = false
end

local function buildUpdateLog()
    clearContent()
    local content = Instance.new("TextLabel", mainFrame)
    content.Name = "Content"
    content.Size = UDim2.new(0.9, 0, 0.7, 0)
    content.Position = UDim2.new(0.05, 0, 0.25, 0)
    content.BackgroundColor3 = Color3.fromRGB(40,40,40)
    content.TextColor3 = Color3.new(1,1,1)
    content.Font = Enum.Font.Gotham
    content.TextSize = 16
    content.TextWrapped = true
    content.Text = [[
📢 Update Log:
- Added Fly mode (WASD + Space + Shift to move)
- Added tab switching with working buttons
- Added Close (X) button with confirmation
- Secure key check
]]
end

local function buildAllGames()
    clearContent()
    local content = Instance.new("Frame", mainFrame)
    content.Name = "Content"
    content.Size = UDim2.new(0.9, 0, 0.7, 0)
    content.Position = UDim2.new(0.05, 0, 0.25, 0)
    content.BackgroundColor3 = Color3.fromRGB(40,40,40)

    local flyBtn = Instance.new("TextButton", content)
    flyBtn.Size = UDim2.new(0.8, 0, 0, 40)
    flyBtn.Position = UDim2.new(0.1, 0, 0, 10)
    flyBtn.Text = flying and "Stop Fly" or "Start Fly"
    flyBtn.Font = Enum.Font.Gotham
    flyBtn.TextSize = 18
    flyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    flyBtn.TextColor3 = Color3.new(1,1,1)

    flyBtn.MouseButton1Click:Connect(function()
        if flying then
            stopFly()
            flyBtn.Text = "Start Fly"
        else
            startFly()
            flyBtn.Text = "Stop Fly"
        end
    end)
end

-- Tabit ylös
local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(1, 0, 0, 40)
tabFrame.Position = UDim2.new(0, 0, 0.12, 0)
tabFrame.BackgroundTransparency = 1

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", tabFrame)
    btn.Size = UDim2.new(1/#tabNames, -4, 1, 0)
    btn.Position = UDim2.new((i-1)/#tabNames, 2*i - 2, 0, 0)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.AutoButtonColor = true

    btn.MouseButton1Click:Connect(function()
        if name == "Update Log" then
            buildUpdateLog()
        elseif name == "All Games" then
            buildAllGames()
        end
    end)
end

-- Aloita Update Log näkymä
buildUpdateLog()
