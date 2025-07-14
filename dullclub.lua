-- Dull Club Script for Solara
-- Key: MinihodariDeveloper

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DullClubGui"

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 420, 0, 300)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Dull Club - Enter Key"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Position = UDim2.new(0, 0, 0, 5)

-- Key Input
local keyBox = Instance.new("TextBox", mainFrame)
keyBox.Size = UDim2.new(0.7, -10, 0, 35)
keyBox.Position = UDim2.new(0, 10, 0, 60)
keyBox.PlaceholderText = "Enter your key"
keyBox.ClearTextOnFocus = false
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 20
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
keyBox.BorderSizePixel = 0

-- Submit Button
local submitBtn = Instance.new("TextButton", mainFrame)
submitBtn.Size = UDim2.new(0.3, -10, 0, 35)
submitBtn.Position = UDim2.new(0.7, 0, 0, 60)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 20
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.BorderSizePixel = 0

-- Message Label for errors
local msgLabel = Instance.new("TextLabel", mainFrame)
msgLabel.Size = UDim2.new(1, -20, 0, 30)
msgLabel.Position = UDim2.new(0, 10, 0, 110)
msgLabel.BackgroundTransparency = 1
msgLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
msgLabel.Text = ""
msgLabel.Font = Enum.Font.GothamBold
msgLabel.TextSize = 18

-- Content Frame for menu
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -160)
contentFrame.Position = UDim2.new(0, 10, 0, 140)
contentFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
contentFrame.Visible = false

-- Menu buttons container
local buttons = {}

local function createMenuButton(text, posX)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(0, 120, 0, 35)
    btn.Position = UDim2.new(0, posX, 0, 100)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(20, 120, 255)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    btn.Visible = false
    return btn
end

buttons.updateLog = createMenuButton("Update Log", 10)
buttons.allGames = createMenuButton("All Games", 140)
buttons.dandysWorld = createMenuButton("Dandys World", 270)

-- Update Log text
local updateLogText = [[
Update Log:
- Added Fly, Fake Lag, Fake Kick/Ban
- Added Key check system
- Added menus for All Games and Dandys World
]]

local function clearContent()
    for _, child in pairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
end

-- Functions for All Games Menu

local function setupAllGames()
    clearContent()

    -- Fly button
    local flyBtn = Instance.new("TextButton", contentFrame)
    flyBtn.Size = UDim2.new(0, 120, 0, 40)
    flyBtn.Position = UDim2.new(0, 10, 0, 10)
    flyBtn.Text = "Fly"
    flyBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
    flyBtn.TextColor3 = Color3.new(1,1,1)
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.TextSize = 20

    -- Fake Lag button
    local fakeLagBtn = Instance.new("TextButton", contentFrame)
    fakeLagBtn.Size = UDim2.new(0, 120, 0, 40)
    fakeLagBtn.Position = UDim2.new(0, 150, 0, 10)
    fakeLagBtn.Text = "Fake Lag"
    fakeLagBtn.BackgroundColor3 = Color3.fromRGB(255,165,0)
    fakeLagBtn.TextColor3 = Color3.new(1,1,1)
    fakeLagBtn.Font = Enum.Font.GothamBold
    fakeLagBtn.TextSize = 20

    -- Fake Kick/Ban button
    local fakeKickBtn = Instance.new("TextButton", contentFrame)
    fakeKickBtn.Size = UDim2.new(0, 260, 0, 40)
    fakeKickBtn.Position = UDim2.new(0, 10, 0, 60)
    fakeKickBtn.Text = "Fake Kick / Ban"
    fakeKickBtn.BackgroundColor3 = Color3.fromRGB(220,20,60)
    fakeKickBtn.TextColor3 = Color3.new(1,1,1)
    fakeKickBtn.Font = Enum.Font.GothamBold
    fakeKickBtn.TextSize = 20

    -- Fly implementation
    local flying = false
    local flyForce

    flyBtn.MouseButton1Click:Connect(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        flying = not flying
        if flying then
            flyBtn.Text = "Stop Fly"
            flyForce = Instance.new("BodyVelocity")
            flyForce.MaxForce = Vector3.new(1e5,1e5,1e5)
            flyForce.Velocity = Vector3.new(0,0,0)
            flyForce.Parent = root

            spawn(function()
                while flying do
                    local direction = Vector3.new()
                    if mouse:IsKeyDown(Enum.KeyCode.W) then
                        direction = direction + workspace.CurrentCamera.CFrame.LookVector
                    end
                    if mouse:IsKeyDown(Enum.KeyCode.S) then
                        direction = direction - workspace.CurrentCamera.CFrame.LookVector
                    end
                    if mouse:IsKeyDown(Enum.KeyCode.A) then
                        direction = direction - workspace.CurrentCamera.CFrame.RightVector
                    end
                    if mouse:IsKeyDown(Enum.KeyCode.D) then
                        direction = direction + workspace.CurrentCamera.CFrame.RightVector
                    end
                    direction = Vector3.new(direction.X, 0, direction.Z)
                    if direction.Magnitude > 0 then
                        direction = direction.Unit * 50
                    end
                    flyForce.Velocity = Vector3.new(direction.X, 50, direction.Z)
                    wait(0.1)
                end
                if flyForce then flyForce:Destroy() end
            end)
        else
            flying = false
            flyBtn.Text = "Fly"
            if flyForce then flyForce:Destroy() end
        end
    end)

    -- Fake Lag implementation
    local lagging = false
    fakeLagBtn.MouseButton1Click:Connect(function()
        lagging = not lagging
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if lagging then
            fakeLagBtn.Text = "Fake Lag ON"
            if humanoid then
                humanoid.WalkSpeed = 4
            end
        else
            fakeLagBtn.Text = "Fake Lag"
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end)

    -- Fake Kick/Ban implementation
    fakeKickBtn.MouseButton1Click:Connect(function()
        -- Create kick/ban GUI
        local kickGui = Instance.new("ScreenGui", player.PlayerGui)
        kickGui.Name = "FakeKickGui"

        local kickFrame = Instance.new("Frame", kickGui)
        kickFrame.Size = UDim2.new(0, 300, 0, 220)
        kickFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
        kickFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)

        local selectLabel = Instance.new("TextLabel", kickFrame)
        selectLabel.Size = UDim2.new(1, -20, 0, 40)
        selectLabel.Position = UDim2.new(0, 10, 0, 10)
        selectLabel.BackgroundTransparency = 1
        selectLabel.Text = "Select Kick or Ban:"
        selectLabel.TextColor3 = Color3.new(1,1,1)
        selectLabel.Font = Enum.Font.GothamBold
        selectLabel.TextSize = 20

        local kickRadio = Instance.new("TextButton", kickFrame)
        kickRadio.Size = UDim2.new(0.4, 0, 0, 40)
        kickRadio.Position = UDim2.new(0.05, 0, 0, 60)
        kickRadio.Text = "Kick"
        kickRadio.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        kickRadio.TextColor3 = Color3.new(1,1,1)
        kickRadio.Font = Enum.Font.GothamBold
        kickRadio.TextSize = 20

        local banRadio = Instance.new("TextButton", kickFrame)
        banRadio.Size = UDim2.new(0.4, 0, 0, 40)
        banRadio.Position = UDim2.new(0.55, 0, 0, 60)
        banRadio.Text = "Ban"
        banRadio.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
        banRadio.TextColor3 = Color3.new(1,1,1)
        banRadio.Font = Enum.Font.GothamBold
        banRadio.TextSize = 20

        local reasonLabel = Instance.new("TextLabel", kickFrame)
        reasonLabel.Size = UDim2.new(1, -20, 0, 30)
        reasonLabel.Position = UDim2.new(0, 10, 0, 110)
        reasonLabel.BackgroundTransparency = 1
        reasonLabel.Text = "Enter reason:"
        reasonLabel.TextColor3 = Color3.new(1,1,1)
        reasonLabel.Font = Enum.Font.Gotham
        reasonLabel.TextSize = 18

        local reasonBox = Instance.new("TextBox", kickFrame)
        reasonBox.Size = UDim2.new(0.9, 0, 0, 30)
        reasonBox.Position = UDim2.new(0.05, 0, 0, 140)
        reasonBox.PlaceholderText = "Reason for kick/ban"
        reasonBox.Font = Enum.Font.Gotham
        reasonBox.TextSize = 18

        local confirmBtn = Instance.new("TextButton", kickFrame)
        confirmBtn.Size = UDim2.new(0.9, 0, 0, 40)
        confirmBtn.Position = UDim2.new(0.05, 0, 0, 180)
        confirmBtn.Text = "Confirm"
        confirmBtn.BackgroundColor3 = Color3.fromRGB(220,20,60)
        confirmBtn.TextColor3 = Color3.new(1,1,1)
        confirmBtn.Font = Enum.Font.GothamBold
        confirmBtn.TextSize = 20

        local selectedAction = nil

        kickRadio.MouseButton1Click:Connect(function()
            selectedAction = "Kick"
            kickRadio.BackgroundColor3 = Color3.fromRGB(0,255,255)
            banRadio.BackgroundColor3 = Color3.fromRGB(255,69,0)
        end)
        banRadio.MouseButton1Click:Connect(function()
            selectedAction = "Ban"
            banRadio.BackgroundColor3 = Color3.fromRGB(255,140,0)
            kickRadio.BackgroundColor3 = Color3.fromRGB(0,170,255)
        end)

        confirmBtn.MouseButton1Click:Connect(function()
            if not selectedAction then
                reasonLabel.Text = "Please select Kick or Ban!"
                return
            end
            if reasonBox.Text == "" then
                reasonLabel.Text = "Please enter a reason!"
                return
            end

            kickGui:Destroy()

            local fakeMsgGui = Instance.new("ScreenGui", player.PlayerGui)
            fakeMsgGui.Name = "FakeKickMessageGui"

            local msgFrame = Instance.new("Frame", fakeMsgGui)
            msgFrame.Size = UDim2.new(0, 400, 0, 150)
            msgFrame.Position = UDim2.new(0.5, -200, 0.5, -75)
            msgFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)

            local titleLabel = Instance.new("TextLabel", msgFrame)
            titleLabel.Size = UDim2.new(1, 0, 0, 50)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = selectedAction .. " executed"
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextSize = 30
            titleLabel.TextColor3 = Color3.new(1,1,1)
            titleLabel.Position = UDim2.new(0,0,0,0)

            local reasonLabel2 = Instance.new("TextLabel", msgFrame)
            reasonLabel2.Size = UDim2.new(1, -20, 0, 40)
            reasonLabel2.Position = UDim2.new(0,10,0,60)
            reasonLabel2.BackgroundTransparency = 1
            reasonLabel2.Text = "Reason: " .. reasonBox.Text
            reasonLabel2.Font = Enum.Font.Gotham
            reasonLabel2.TextSize = 20
            reasonLabel2.TextColor3 = Color3.new(1,1,1)

            wait(3)
            fakeMsgGui:Destroy()
        end)
    end)
end

-- Dandys World Menu (placeholder, lisää anti die, teleport jne.)
local function setupDandysWorld()
    clearContent()

    local label = Instance.new("TextLabel", contentFrame)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Text = "Dandys World features go here.\n(anti-die, invisible, teleport, etc.)"
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.TextWrapped = true
    label.TextYAlignment = Enum.TextYAlignment.Top
end

-- Update Log Menu
local function setupUpdateLog()
    clearContent()

    local logLabel = Instance.new("TextLabel", contentFrame)
    logLabel.Size = UDim2.new(1, 0, 1, 0)
    logLabel.BackgroundTransparency = 1
    logLabel.TextColor3 = Color3.new(1,1,1)
    logLabel.Text = updateLogText
    logLabel.Font = Enum.Font.Gotham
    logLabel.TextSize = 18
    logLabel.TextWrapped = true
    logLabel.TextYAlignment = Enum.TextYAlignment.Top
end

-- Connect menu buttons
buttons.updateLog.MouseButton1Click:Connect(setupUpdateLog)
buttons.allGames.MouseButton1Click:Connect(setupAllGames)
buttons.dandysWorld.MouseButton1Click:Connect(set
