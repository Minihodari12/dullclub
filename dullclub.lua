-- Dull Club Script with Key Input and Menu

local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local correctKey = "MinihodariDeveloper"

-- GUI creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DullClubGui"
ScreenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

-- Close button with confirmation
local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    local confirm = Instance.new("TextButton")
    confirm.Text = "Are you sure? Click to close."
    confirm.Size = UDim2.new(0, 300, 0, 50)
    confirm.Position = UDim2.new(0.5, -150, 0.5, -25)
    confirm.BackgroundColor3 = Color3.fromRGB(50,50,50)
    confirm.TextColor3 = Color3.new(1,1,1)
    confirm.Font = Enum.Font.SourceSansBold
    confirm.TextSize = 18
    confirm.Parent = mainFrame

    closeButton.Visible = false

    confirm.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end)

-- Key input UI
local keyLabel = Instance.new("TextLabel")
keyLabel.Text = "Enter Key:"
keyLabel.Size = UDim2.new(0, 100, 0, 30)
keyLabel.Position = UDim2.new(0, 20, 0, 20)
keyLabel.BackgroundTransparency = 1
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.Font = Enum.Font.SourceSansBold
keyLabel.TextSize = 20
keyLabel.Parent = mainFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 250, 0, 30)
keyBox.Position = UDim2.new(0, 130, 0, 20)
keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.ClearTextOnFocus = false
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 20
keyBox.PlaceholderText = "Enter your key here"
keyBox.Parent = mainFrame

local submitButton = Instance.new("TextButton")
submitButton.Text = "Submit"
submitButton.Size = UDim2.new(0, 80, 0, 30)
submitButton.Position = UDim2.new(0, 300, 0, 20)
submitButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
submitButton.TextColor3 = Color3.new(1,1,1)
submitButton.Font = Enum.Font.SourceSansBold
submitButton.TextSize = 20
submitButton.Parent = mainFrame

local messageLabel = Instance.new("TextLabel")
messageLabel.Size = UDim2.new(1, -40, 0, 30)
messageLabel.Position = UDim2.new(0, 20, 0, 60)
messageLabel.BackgroundTransparency = 1
messageLabel.TextColor3 = Color3.new(1,0,0)
messageLabel.Font = Enum.Font.SourceSansBold
messageLabel.TextSize = 18
messageLabel.Text = ""
messageLabel.Parent = mainFrame

local menuFrame

local function clearContent()
    if menuFrame then
        menuFrame:Destroy()
        menuFrame = nil
    end
end

local function createContentFrame()
    clearContent()
    menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(1, -40, 1, -100)
    menuFrame.Position = UDim2.new(0, 20, 0, 90)
    menuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    menuFrame.Parent = mainFrame
    return menuFrame
end

-- Fly logic
local flying = false
local flySpeed = 150
local bodyVelocity

local function toggleFly()
    local character = LocalPlayer.Character
    if not character then return end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    if not flying then
        flying = true
        messageLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        messageLabel.Text = "Fly enabled (Press F to toggle off)"

        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Velocity = Vector3.new(0,0,0)
        bodyVelocity.Parent = humanoidRootPart

        local flyConnection
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flying then
                bodyVelocity:Destroy()
                flyConnection:Disconnect()
                messageLabel.Text = "Fly disabled"
                return
            end

            local moveDir = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDir = moveDir + Vector3.new(0,1,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDir = moveDir - Vector3.new(0,1,0)
            end

            if moveDir.Magnitude > 0 then
                bodyVelocity.Velocity = moveDir.Unit * flySpeed
            else
                bodyVelocity.Velocity = Vector3.new(0,0,0)
            end
        end)

        local toggleConnection
        toggleConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.F then
                flying = false
                toggleConnection:Disconnect()
            end
        end)

    else
        flying = false
        messageLabel.Text = "Fly disabled"
    end
end

-- Fake Lag demo
local function fakeLagDemo()
    messageLabel.Text = "Fake Lag (Demo activated)."
    task.delay(2, function()
        messageLabel.Text = ""
    end)
end

-- Fake Kick logic
local function showFakeKickGui()
    local fakeKickGui = Instance.new("ScreenGui")
    fakeKickGui.Name = "FakeKickGui"
    fakeKickGui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BorderSizePixel = 0
    frame.Parent = fakeKickGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 50)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 20
    label.TextWrapped = true
    label.Text = "Choose Kick or Ban for Fake Kick:"
    label.Parent = frame

    local kickButton = Instance.new("TextButton")
    kickButton.Size = UDim2.new(0.4, 0, 0, 40)
    kickButton.Position = UDim2.new(0.05, 0, 0, 70)
    kickButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    kickButton.Text = "Kick"
    kickButton.TextColor3 = Color3.new(1,1,1)
    kickButton.Font = Enum.Font.SourceSansBold
    kickButton.TextSize = 22
    kickButton.Parent = frame

    local banButton = Instance.new("TextButton")
    banButton.Size = UDim2.new(0.4, 0, 0, 40)
    banButton.Position = UDim2.new(0.55, 0, 0, 70)
    banButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    banButton.Text = "Ban"
    banButton.TextColor3 = Color3.new(1,1,1)
    banButton.Font = Enum.Font.SourceSansBold
    banButton.TextSize = 22
    banButton.Parent = frame

    local function askReason(isBan)
        label.Text = "Enter reason for " .. (isBan and "ban" or "kick") .. ":"
        kickButton.Visible = false
        banButton.Visible = false

        local reasonBox = Instance.new("TextBox")
        reasonBox.Size = UDim2.new(0.9, 0, 0, 35)
        reasonBox.Position = UDim2.new(0.05, 0, 0, 70)
        reasonBox.PlaceholderText = "Reason..."
        reasonBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
        reasonBox.TextColor3 = Color3.new(1,1,1)
        reasonBox.Font = Enum.Font.SourceSans
        reasonBox.TextSize = 22
        reasonBox.Parent = frame

        local sendButton = Instance.new("TextButton")
        sendButton.Size = UDim2.new(0.4, 0, 0, 40)
        sendButton.Position = UDim2.new(0.3, 0, 0, 115)
        sendButton.BackgroundColor3 = Color3.fromRGB(70,130,180)
        sendButton.Text = "Send"
        sendButton.TextColor3 = Color3.new(1,1,1)
        sendButton.Font = Enum.Font.SourceSansBold
        sendButton.TextSize = 22
        sendButton.Parent = frame

        sendButton.MouseButton1Click:Connect(function()
            local reason = reasonBox.Text
            if reason == "" then
                reasonBox.PlaceholderText = "Please enter a reason!"
                return
            end
            fakeKickGui:Destroy()
            LocalPlayer:Kick((isBan and "Ban" or "Kick") .. " reason: " .. reason)
        end)
    end

    kickButton.MouseButton1Click:Connect(function()
        askReason(false)
    end)

    banButton.MouseButton1Click:Connect(function()
        askReason(true)
    end)
end

-- Menu buttons and content
local function createMenu()
    -- Clear key input UI
    keyLabel.Visible = false
    keyBox.Visible = false
    submitButton.Visible = false
    messageLabel.Text = ""
    messageLabel.TextColor3 = Color3.new(1,1,1)

    -- Menu buttons frame
    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Size = UDim2.new(1, -40, 0, 40)
    buttonsFrame.Position = UDim2.new(0, 20, 0, 20)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = mainFrame

    local function createButton(text, pos)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 120, 1, 0)
        btn.Position = pos
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 18
        btn.Text = text
        btn.Parent = buttonsFrame
        return btn
    end

    local btnUpdateLog = createButton("Update Log", UDim2.new(0, 0, 0, 0))
    local btnAllGames = createButton("All Games", UDim2.new(0, 130, 0, 0))
    local btnDandysWorld = createButton("Dandys World", UDim2.new(0, 260, 0, 0))

    -- Content frame
    local contentFrame = createContentFrame()

    local messageLabelMenu = Instance.new("TextLabel")
    messageLabelMenu.Size = UDim2.new(1, -20, 0, 30)
    messageLabelMenu.Position = UDim2.new(0, 10, 0, 10)
    messageLabelMenu.BackgroundTransparency = 1
    messageLabelMenu.TextColor3 = Color3.new(1,1,1)
    messageLabelMenu.Font = Enum.Font.SourceSansBold
    messageLabelMenu.TextSize = 18
    messageLabelMenu.Text = ""
    messageLabelMenu.Parent = contentFrame

    -- Tabs content
    local function showUpdateLog()
        contentFrame:ClearAllChildren()
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 1, -20)
        label.Position = UDim2.new(0, 10, 0, 10)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1,1,1)
        label.Font = Enum.Font.SourceSans
        label.TextSize = 18
        label.TextWrapped = true
        label.Text = [[
Welcome to Dull Club!
- Added demo Dandys World commands.
- Added fly and fakelag placeholders.
]]
        label.Parent = contentFrame
    end

    local function showAllGames()
        contentFrame:ClearAllChildren()

        local flyButton = Instance.new("TextButton")
        flyButton.Size = UDim2.new(0.8, 0, 0, 40)
        flyButton.Position = UDim2.new(0.1, 0, 0, 20)
        flyButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
        flyButton.TextColor3 = Color3.new(1,1,1)
        flyButton.Font = Enum.Font.SourceSansBold
        flyButton.TextSize = 20
        flyButton.Text = "Toggle Fly"
        flyButton.Parent = contentFrame

        flyButton.MouseButton1Click:Connect(function()
            toggleFly()
        end)

        local fakeLagButton = Instance.new("TextButton")
        fakeLagButton.Size = UDim2.new(0.8, 0, 0, 40)
        fakeLagButton.Position = UDim2.new(0.1, 0, 0, 70)
        fakeLagButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
        fakeLagButton.TextColor3 = Color3.new(1,1,1)
        fakeLagButton.Font = Enum.Font.SourceSansBold
        fakeLagButton.TextSize = 20
        fakeLagButton.Text = "Fake Lag (Demo)"
        fakeLagButton.Parent = contentFrame

        fakeLagButton.MouseButton1Click:Connect(function()
            fakeLagDemo()
        end)

        local fakeKickButton = Instance.new("TextButton")
        fakeKickButton.Size = UDim2.new(0.8, 0, 0, 40)
        fakeKickButton.Position = UDim2.new(0.1, 0, 0, 120)
        fakeKickButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
        fakeKickButton.TextColor3 = Color3.new(1,1,1)
        fakeKickButton.Font = Enum.Font.SourceSansBold
        fakeKickButton.TextSize = 20
        fakeKickButton.Text = "Fake Kick"
        fakeKickButton.Parent = contentFrame

        fakeKickButton.MouseButton1Click:Connect(function()
            showFakeKickGui()
        end)
    end

    local function showDandysWorld()
        contentFrame:ClearAllChildren()

        local demoLabel = Instance.new("TextLabel")
        demoLabel.Size = UDim2.new(1, -20, 0, 50)
        demoLabel.Position = UDim2.new(0, 10, 0, 20)
        demoLabel.BackgroundTransparency = 1
        demoLabel.TextColor3 = Color3.new(1,1,1)
        demoLabel.Font = Enum.Font.SourceSansBold
        demoLabel.TextSize = 20
        demoLabel.Text = "Dandys World Demo Commands"
        demoLabel.Parent = contentFrame

        local antiDieButton = Instance.new("TextButton")
        antiDieButton.Size = UDim2.new(0.8, 0, 0, 40)
        antiDieButton.Position = UDim2.new(0.1, 0, 0, 80)
        antiDieButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        antiDieButton.TextColor3 = Color3.new(1,1,1)
        antiDieButton.Font = Enum.Font.SourceSansBold
        antiDieButton.TextSize = 20
        antiDieButton.Text = "Anti Die (Demo)"
        antiDieButton.Parent = contentFrame

        antiDieButton.MouseButton1Click:Connect(function()
            messageLabelMenu.Text = "Anti Die demo activated."
            task.delay(3, function()
                messageLabelMenu.Text = ""
            end)
        end)
    end

    btnUpdateLog.MouseButton1Click:Connect(showUpdateLog)
    btnAllGames.MouseButton1Click:Connect(showAllGames)
    btnDandysWorld.MouseButton1Click:Connect(showDandysWorld)

    showUpdateLog()
end

submitButton.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if key == correctKey then
        messageLabel.TextColor3 = Color3.fromRGB(100,255,100)
        messageLabel.Text = "Key accepted! Loading menu..."
        task.wait(1)
        createMenu()
    else
        messageLabel.TextColor3 = Color3.fromRGB(255,50,50)
        messageLabel.Text = "Wrong key! Contact the code owner for the correct key. Discord coming soon!"
        task.wait(2)
        LocalPlayer:Kick("Wrong key entered! Please contact the code owner.")
    end
end)
