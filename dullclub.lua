-- Dull Club Script

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local correctKey = "MinihodariDeveloper"
local key

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DullClubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.Text = "Dull Club - Enter Key"
titleLabel.Parent = mainFrame

-- Close button (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.Parent = mainFrame

local function closeConfirm()
    local confirmFrame = Instance.new("Frame")
    confirmFrame.Size = UDim2.new(0, 300, 0, 150)
    confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    confirmFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    confirmFrame.BorderSizePixel = 0
    confirmFrame.Parent = ScreenGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 70)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 20
    label.TextWrapped = true
    label.Text = "Are you sure you want to close the script?"
    label.Parent = confirmFrame

    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0, 100, 0, 40)
    yesButton.Position = UDim2.new(0.25, -50, 1, -50)
    yesButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    yesButton.Text = "Yes"
    yesButton.TextColor3 = Color3.new(1,1,1)
    yesButton.Font = Enum.Font.SourceSansBold
    yesButton.TextSize = 22
    yesButton.Parent = confirmFrame

    local noButton = Instance.new("TextButton")
    noButton.Size = UDim2.new(0, 100, 0, 40)
    noButton.Position = UDim2.new(0.75, -50, 1, -50)
    noButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    noButton.Text = "No"
    noButton.TextColor3 = Color3.new(1,1,1)
    noButton.Font = Enum.Font.SourceSansBold
    noButton.TextSize = 22
    noButton.Parent = confirmFrame

    yesButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    noButton.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
    end)
end

closeButton.MouseButton1Click:Connect(closeConfirm)

-- Key Input UI
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0, 60)
keyBox.PlaceholderText = "Enter your key here"
keyBox.ClearTextOnFocus = false
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 22
keyBox.Parent = mainFrame

local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.4, 0, 0, 35)
submitButton.Position = UDim2.new(0.3, 0, 0, 105)
submitButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
submitButton.Text = "Submit"
submitButton.TextColor3 = Color3.new(1,1,1)
submitButton.Font = Enum.Font.SourceSansBold
submitButton.TextSize = 24
submitButton.Parent = mainFrame

local messageLabel = Instance.new("TextLabel")
messageLabel.Size = UDim2.new(1, -20, 0, 40)
messageLabel.Position = UDim2.new(0, 10, 0, 145)
messageLabel.BackgroundTransparency = 1
messageLabel.TextColor3 = Color3.fromRGB(255,100,100)
messageLabel.Font = Enum.Font.SourceSansBold
messageLabel.TextSize = 18
messageLabel.TextWrapped = true
messageLabel.Text = ""
messageLabel.Parent = mainFrame

-- Functions for fly and fake lag

local flying = false
local flySpeed = 100

local function startFly()
    if flying then return end
    flying = true
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Parent = rootPart

    local connection
    connection = RunService.Heartbeat:Connect(function()
        local direction = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction += workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction -= workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction -= workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction += workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction += Vector3.new(0,1,0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            direction -= Vector3.new(0,1,0)
        end
        if direction.Magnitude > 0 then
            direction = direction.Unit * flySpeed
        end
        bodyVelocity.Velocity = direction
    end)

    return bodyVelocity, connection
end

local function stopFly(bodyVelocity, connection)
    if bodyVelocity then bodyVelocity:Destroy() end
    if connection then connection:Disconnect() end
    flying = false
end

-- Fake Lag implementation (simple example)
local fakeLag = false
local originalWalkSpeed = 16

local function startFakeLag()
    fakeLag = true
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 0
    end
end

local function stopFakeLag()
    fakeLag = false
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = originalWalkSpeed
    end
end

-- Fake Kick: kicks the player with a reason
local function fakeKick(reason)
    LocalPlayer:Kick(reason or "You have been kicked by Dull Club Fake Kick.")
end

-- Menu after key is accepted

local function createMenu()
    -- Clear the mainFrame contents first
    for _, child in pairs(mainFrame:GetChildren()) do
        if child ~= closeButton then
            child:Destroy()
        end
    end

    -- Title update
    titleLabel.Text = "Dull Club - Main Menu"

    -- Tabs
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 0, 40)
    tabFrame.Position = UDim2.new(0, 0, 0, 40)
    tabFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    tabFrame.Parent = mainFrame

    local buttons = {}

    local function clearContent()
        for _, c in pairs(mainFrame:GetChildren()) do
            if c.Name == "Content" then
                c:Destroy()
            end
        end
    end

    local function createContentFrame()
        local frame = Instance.new("Frame")
        frame.Name = "Content"
        frame.Size = UDim2.new(1, 0, 1, -80)
        frame.Position = UDim2.new(0, 0, 0, 80)
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        frame.Parent = mainFrame
        return frame
    end

    -- Update Log Tab
    buttons.UpdateLog = Instance.new("TextButton")
    buttons.UpdateLog.Size = UDim2.new(0, 120, 1, 0)
    buttons.UpdateLog.Position = UDim2.new(0, 0, 0, 0)
    buttons.UpdateLog.BackgroundColor3 = Color3.fromRGB(50,50,50)
    buttons.UpdateLog.Text = "Update Log"
    buttons.UpdateLog.TextColor3 = Color3.new(1,1,1)
    buttons.UpdateLog.Font = Enum.Font.SourceSansBold
    buttons.UpdateLog.TextSize = 18
    buttons.UpdateLog.Parent = tabFrame

    -- All Games Tab
    buttons.AllGames = Instance.new("TextButton")
    buttons.AllGames.Size = UDim2.new(0, 120, 1, 0)
    buttons.AllGames.Position = UDim2.new(0, 130, 0, 0)
    buttons.AllGames.BackgroundColor3 = Color3.fromRGB(50,50,50)
    buttons.AllGames.Text = "All Games"
    buttons.AllGames.TextColor3 = Color3.new(1,1,1)
    buttons.AllGames.Font = Enum.Font.SourceSansBold
    buttons.AllGames.TextSize = 18
    buttons.AllGames.Parent = tabFrame

    -- Dandys World Tab
    buttons.DandysWorld = Instance.new("TextButton")
    buttons.DandysWorld.Size = UDim2.new(0, 120, 1, 0)
    buttons.DandysWorld.Position = UDim2.new(0, 260, 0, 0)
    buttons.DandysWorld.BackgroundColor3 = Color3.fromRGB(50,50,50)
    buttons.DandysWorld.Text = "Dandys World"
    buttons.DandysWorld.TextColor3 = Color3.new(1,1,1)
    buttons.DandysWorld.Font = Enum.Font.SourceSansBold
    buttons.DandysWorld.TextSize = 18
    buttons.DandysWorld.Parent = tabFrame

    -- Content for each tab
    local function showUpdateLog()
        clearContent()
        local content = createContentFrame()
        local logLabel = Instance.new("TextLabel")
        logLabel.Size = UDim2.new(1, -20, 1, -20)
        logLabel.Position = UDim2.new(0, 10, 0, 10)
        logLabel.BackgroundTransparency = 1
        logLabel.TextColor3 = Color3.new(1,1,1)
        logLabel.Font = Enum.Font.SourceSans
        logLabel.TextSize = 18
        logLabel.TextWrapped = true
        logLabel.Text = [[
Version 0.0.5
- Added key system with demo version.
- Added menu with tabs.
- Added Dandys World demo commands.
- Added fly and fakelag placeholders.
        ]]
        logLabel.Parent = content
    end

    local function showAllGames()
        clearContent()
        local content = createContentFrame()
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 1, -20)
        label.Position = UDim2.new(0, 10, 0, 10)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1,1,1)
        label.Font = Enum.Font.SourceSans
        label.TextSize = 18
        label.TextWrapped = true
        label.Text = "This tab will contain all game scripts in the future."
        label.Parent = content
    end

    local function showDandysWorld()
        clearContent()
        local content = createContentFrame()

        local infoLabel = Instance.new("TextLabel")
        infoLabel.Size = UDim2.new(1, -20, 0, 40)
        infoLabel.Position = UDim2.new(0, 10, 0, 10)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = Color3.new(1,1,1)
        infoLabel.Font = Enum.Font.SourceSansBold
        infoLabel.TextSize = 20
        infoLabel.Text = "Dandys World Demo - Commands"
        infoLabel.Parent = content

        local buttonsList = {
            {Name = "Fly", Description = "Toggle Fly (Demo - no effect)"},
            {Name = "Fake Lag", Description = "Toggle Fake Lag (Demo - no effect)"},
            {Name = "Fake Kick", Description = "Fake Kick yourself (Demo)"},
        }

        local yPos = 60
        for _, btnInfo in pairs(buttonsList) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.8, 0, 0, 40)
            btn.Position = UDim2.new(0.1, 0, 0, yPos)
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.SourceSansBold
            btn.TextSize = 20
            btn.Text = btnInfo.Name
            btn.Parent = content

            btn.MouseButton1Click:Connect(function()
                if btnInfo.Name == "Fly" then
                    -- Demo only
                    messageLabel.Text = "Fly command is a demo version only."
                    task.delay(2, function() messageLabel.Text = "" end)
                elseif btnInfo.Name == "Fake Lag" then
                    messageLabel.Text = "Fake Lag command is a demo version only."
                    task.delay(2, function() messageLabel.Text = "" end)
                elseif btnInfo.Name == "Fake Kick" then
                    messageLabel.Text = "Fake Kick command demo activated. You will be kicked."
                    task.delay(1, function()
                        LocalPlayer:Kick("Demo Fake Kick by Dull Club.")
                    end)
                end
            end)

            yPos = yPos + 50
        end

    end

    -- Connect tab buttons
    buttons.UpdateLog.MouseButton1Click:Connect(showUpdateLog)
    buttons.AllGames.MouseButton1Click:Connect(showAllGames)
    buttons.DandysWorld.MouseButton1Click:Connect(showDandysWorld)

    -- Show default tab
    showUpdateLog()
end

submitButton.MouseButton1Click:Connect(function()
    key = keyBox.Text
    if key == correctKey then
        messageLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        messageLabel.Text = "Correct key! Loading menu..."
        task.wait(1)
        createMenu()
    else
        messageLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        messageLabel.Text = "Incorrect key! Try again."
    end
end)
