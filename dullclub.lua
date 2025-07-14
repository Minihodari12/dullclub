local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local correctKey = "MinihodariDeveloper"

local gui = Instance.new("ScreenGui")
gui.Name = "SimpleDullClub"
gui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Simple DullClub"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 24

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
    Instance.new("UICorner", confirmFrame)

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

local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", keyFrame)

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

local tabNames = {"Update Log", "All Games", "Credits"}
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

local fakeLag = false
local lagConnection

local function startFakeLag()
    if fakeLag then return end
    fakeLag = true
    lagConnection = RunService.Heartbeat:Connect(function()
        if not fakeLag then
            lagConnection:Disconnect()
            return
        end
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
                wait(0.05)
                part.Transparency = 0
            end
        end
    end)
end

local function stopFakeLag()
    fakeLag = false
end

local noclip = false
local noclipConnection

local function toggleNoclip()
    noclip = not noclip
    local character = Player.Character or Player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    if noclip then
        noclipConnection = RunService.Stepped:Connect(function()
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide == true then
                    part.CanCollide = false
                end
            end
        end)
    else
        noclipConnection:Disconnect()
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local speedToggle = false
local normalWalkSpeed = 16

local function toggleSpeed()
    speedToggle = not speedToggle
    local character = Player.Character or Player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    if speedToggle then
        humanoid.WalkSpeed = 50
    else
        humanoid.WalkSpeed = normalWalkSpeed
    end
end

local invisibility = false
local function toggleInvisibility()
    invisibility = not invisibility
    local character = Player.Character or Player.CharacterAdded:Wait()
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.Transparency = invisibility and 1 or 0
        end
    end
end

local function buildUpdateLog()
    clearContent()
    local content = Instance.new("Frame", mainFrame)
    content.Name = "Content"
    content.Size = UDim2.new(1,0,1,-80)
    content.Position = UDim2.new(0,0,0,40)
    content.BackgroundTransparency = 1

    local logText = Instance.new("TextLabel", content)
    logText.Size = UDim2.new(1, -20, 1, -20)
    logText.Position = UDim2.new(0,10,0,10)
    logText.BackgroundTransparency = 1
    logText.TextColor3 = Color3.new(1,1,1)
    logText.Font = Enum.Font.Gotham
    logText.TextSize = 16
    logText.TextWrapped = true
    logText.Text = [[
Update Log:

- Added fly with full directional control (WASD + Space/Shift)
- Added fake lag toggle
- Added fake kick (real kick with reason)
- Added teleport to preset locations
- Added noclip toggle
- Added speed toggle
- Added invisibility toggle
- Added credits tab

Press Right Control to toggle menu visibility.
    ]]
end

local function buildAllGames()
    clearContent()
    local content = Instance.new("Frame", mainFrame)
    content.Name = "Content"
    content.Size = UDim2.new(1,0,1,-80)
    content.Position = UDim2.new(0,0,0,40)
    content.BackgroundTransparency = 1

    -- Fly button
    local flyBtn = Instance.new("TextButton", content)
    flyBtn.Size = UDim2.new(0.8, 0, 0, 40)
    flyBtn.Position = UDim2.new(0.1, 0, 0, 0)
    flyBtn.Text = "Toggle Fly"
    flyBtn.Font = Enum.Font.Gotham
    flyBtn.TextSize = 18
    flyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    flyBtn.TextColor3 = Color3.new(1,1,1)

    flyBtn.MouseButton1Click:Connect(function()
        if flying then
            stopFly()
            flyBtn.Text = "Toggle Fly"
        else
            startFly()
            flyBtn.Text = "Stop Fly"
        end
    end)

    -- Fake Lag button
    local lagBtn = Instance.new("TextButton", content)
    lagBtn.Size = UDim2.new(0.8, 0, 0, 40)
    lagBtn.Position = UDim2.new(0.1, 0, 0, 50)
    lagBtn.Text = "Start Fake Lag"
    lagBtn.Font = Enum.Font.Gotham
    lagBtn.TextSize = 18
    lagBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    lagBtn.TextColor3 = Color3.new(1,1,1)

    lagBtn.MouseButton1Click:Connect(function()
        if fakeLag then
            stopFakeLag()
            lagBtn.Text = "Start Fake Lag"
        else
            startFakeLag()
            lagBtn.Text = "Stop Fake Lag"
        end
    end)

    -- Fake Kick button
    local kickBtn = Instance.new("TextButton", content)
    kickBtn.Size = UDim2.new(0.8, 0, 0, 40)
    kickBtn.Position = UDim2.new(0.1, 0, 0, 100)
    kickBtn.Text = "Fake Kick"
    kickBtn.Font = Enum.Font.Gotham
    kickBtn.TextSize = 18
    kickBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    kickBtn.TextColor3 = Color3.new(1,1,1)

    kickBtn.MouseButton1Click:Connect(function()
        local inputFrame = Instance.new("Frame", gui)
        inputFrame.Size = UDim2.new(0, 300, 0, 120)
        inputFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
        inputFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        Instance.new("UICorner", inputFrame)

        local promptLabel = Instance.new("TextLabel", inputFrame)
        promptLabel.Size = UDim2.new(1, 0, 0, 40)
        promptLabel.BackgroundTransparency = 1
        promptLabel.Position = UDim2.new(0, 0, 0, 10)
        promptLabel.Text = "Enter kick reason:"
        promptLabel.Font = Enum.Font.GothamBold
        promptLabel.TextColor3 = Color3.new(1,1,1)
        promptLabel.TextSize = 18

        local reasonBox = Instance.new("TextBox", inputFrame)
        reasonBox.Size = UDim2.new(0.8, 0, 0, 40)
        reasonBox.Position = UDim2.new(0.1, 0, 0, 60)
        reasonBox.ClearTextOnFocus = false
        reasonBox.Font = Enum.Font.Gotham
        reasonBox.TextSize = 16
        reasonBox.PlaceholderText = "Reason..."

        local submitBtn = Instance.new("TextButton", inputFrame)
        submitBtn.Size = UDim2.new(0.5, 0, 0, 35)
        submitBtn.Position = UDim2.new(0.25, 0, 0, 110)
        submitBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
        submitBtn.Text = "Kick"
        submitBtn.Font = Enum.Font.GothamBold
        submitBtn.TextColor3 = Color3.new(1,1,1)
        submitBtn.TextSize = 18

        submitBtn.MouseButton1Click:Connect(function()
            local reason = reasonBox.Text
            inputFrame:Destroy()
            Player:Kick("Kicked by fake kick. Reason: " .. (reason ~= "" and reason or "No reason given") .. "\nDiscord server coming soon!")
        end)
    end)

    -- Teleport button + submenu
    local tpBtn = Instance.new("TextButton", content)
    tpBtn.Size = UDim2.new(0.8, 0, 0, 40)
    tpBtn.Position = UDim2.new(0.1, 0, 0, 150)
    tpBtn.Text = "Teleport"
    tpBtn.Font = Enum.Font.Gotham
    tpBtn.TextSize = 18
    tpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tpBtn.TextColor3 = Color3.new(1,1,1)

    tpBtn.MouseButton1Click:Connect(function()
        local tpFrame = Instance.new("Frame", gui)
        tpFrame.Size = UDim2.new(0, 300, 0, 200)
        tpFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
        tpFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        Instance.new("UICorner", tpFrame)

        local tpLabel = Instance.new("TextLabel", tpFrame)
        tpLabel.Size = UDim2.new(1, 0, 0, 40)
        tpLabel.BackgroundTransparency = 1
        tpLabel.Position = UDim2.new(0, 0, 0, 10)
        tpLabel.Text = "Select Teleport Location"
        tpLabel.Font = Enum.Font.GothamBold
        tpLabel.TextColor3 = Color3.new(1,1,1)
        tpLabel.TextSize = 18

        local locations = {
            {"Spawn", Vector3.new(0, 10, 0)},
            {"Tower", Vector3.new(100, 50, 100)},
            {"Secret Base", Vector3.new(-100, 20, -100)},
        }

        for i, loc in ipairs(locations) do
            local btn = Instance.new("TextButton", tpFrame)
            btn.Size = UDim2.new(0.8, 0, 0, 40)
            btn.Position = UDim2.new(0.1, 0, 0, 50 + (i-1)*45)
            btn.Text = loc[1]
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 18
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
            btn.TextColor3 = Color3.new(1,1,1)

            btn.MouseButton1Click:Connect(function()
                local character = Player.Character or Player.CharacterAdded:Wait()
                local hrp = character:WaitForChild("HumanoidRootPart")
                hrp.CFrame = CFrame.new(loc[2])
                tpFrame:Destroy()
            end)
        end

        local closeTpBtn = Instance.new("TextButton", tpFrame)
        closeTpBtn.Size = UDim2.new(0.2, 0, 0, 30)
        closeTpBtn.Position = UDim2.new(0.4, 0, 1, -35)
        closeTpBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
        closeTpBtn.Text = "Close"
        closeTpBtn.Font = Enum.Font.GothamBold
        closeTpBtn.TextColor3 = Color3.new(1,1,1)
        closeTpBtn.TextSize = 16

        closeTpBtn.MouseButton1Click:Connect(function()
            tpFrame:Destroy()
        end)
    end)

    -- Noclip toggle
    local noclipBtn = Instance.new("TextButton", content)
    noclipBtn.Size = UDim2.new(0.8, 0, 0, 40)
    noclipBtn.Position = UDim2.new(0.1, 0, 0, 200)
    noclipBtn.Text = "Toggle Noclip"
    noclipBtn.Font = Enum.Font.Gotham
    noclipBtn.TextSize = 18
    noclipBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    noclipBtn.TextColor3 = Color3.new(1,1,1)

    noclipBtn.MouseButton1Click:Connect(function()
        toggleNoclip()
    end)

    -- Speed toggle
    local speedBtn = Instance.new("TextButton", content)
    speedBtn.Size = UDim2.new(0.8, 0, 0, 40)
    speedBtn.Position = UDim2.new(0.1, 0, 0, 250)
    speedBtn.Text = "Toggle Speed"
    speedBtn.Font = Enum.Font.Gotham
    speedBtn.TextSize = 18
    speedBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    speedBtn.TextColor3 = Color3.new(1,1,1)

    speedBtn.MouseButton1Click:Connect(function()
        toggleSpeed()
    end)

    -- Invisibility toggle
    local invisBtn = Instance.new("TextButton", content)
    invisBtn.Size = UDim2.new(0.8, 0, 0, 40)
    invisBtn.Position = UDim2.new(0.1, 0, 0, 300)
    invisBtn.Text = "Toggle Invisibility"
    invisBtn.Font = Enum.Font.Gotham
    invisBtn.TextSize = 18
    invisBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    invisBtn.TextColor3 = Color3.new(1,1,1)

    invisBtn.MouseButton1Click:Connect(function()
        toggleInvisibility()
    end)
end

local function buildCredits()
    clearContent()
    local content = Instance.new("Frame", mainFrame)
    content.Name = "Content"
    content.Size = UDim2.new(1,0,1,-80)
    content.Position = UDim2.new(0,0,0,40)
    content.BackgroundTransparency = 1

    local creditsLabel = Instance.new("TextLabel", content)
    creditsLabel.Size = UDim2.new(1, -20, 1, -20)
    creditsLabel.Position = UDim2.new(0, 10, 0, 10)
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.TextColor3 = Color3.new(1,1,1)
    creditsLabel.Font = Enum.Font.GothamBold
    creditsLabel.TextSize = 24
    creditsLabel.TextWrapped = true
    creditsLabel.Text = "Created by Minihodari12\nThank you for using the script!"
end

local buttonsFrame = Instance.new("Frame", mainFrame)
buttonsFrame.Size = UDim2.new(1, 0, 0, 40)
buttonsFrame.Position = UDim2.new(0, 0, 1, -40)
buttonsFrame.BackgroundTransparency = 1

local function createTabButton(name, pos)
    local btn = Instance.new("TextButton", buttonsFrame)
    btn.Size = UDim2.new(1/#tabNames, 0, 1, 0)
    btn.Position = UDim2.new((pos-1)/#tabNames, 0, 0, 0)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    return btn
end

for i, name in ipairs(tabNames) do
    local btn = createTabButton(name, i)
    btn.MouseButton1Click:Connect(function()
        if name == "Update Log" then
            buildUpdateLog()
        elseif name == "All Games" then
            buildAllGames()
        elseif name == "Credits" then
            buildCredits()
        end
    end)
end

-- Start with Update Log tab
buildUpdateLog()

-- Toggle GUI visibility with Right Control
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        mainFrame.Visible = not mainFrame.Visible
    end
end)
