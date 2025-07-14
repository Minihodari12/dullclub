-- Dull Club - Solaralle
-- Key: MinihodariDeveloper

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Luodaan GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DullClubGui"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 420, 0, 300)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Dull Club - Enter Key"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 24

local keyBox = Instance.new("TextBox", mainFrame)
keyBox.Size = UDim2.new(0.7, -10, 0, 35)
keyBox.Position = UDim2.new(0, 10, 0, 60)
keyBox.PlaceholderText = "Enter your key"
keyBox.ClearTextOnFocus = false
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 20
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
keyBox.BorderSizePixel = 0

local submitBtn = Instance.new("TextButton", mainFrame)
submitBtn.Size = UDim2.new(0.3, -10, 0, 35)
submitBtn.Position = UDim2.new(0.7, 0, 0, 60)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 20
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.BorderSizePixel = 0

local msgLabel = Instance.new("TextLabel", mainFrame)
msgLabel.Size = UDim2.new(1, -20, 0, 30)
msgLabel.Position = UDim2.new(0, 10, 0, 110)
msgLabel.BackgroundTransparency = 1
msgLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
msgLabel.Text = ""
msgLabel.Font = Enum.Font.GothamBold
msgLabel.TextSize = 18

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -160)
contentFrame.Position = UDim2.new(0, 10, 0, 140)
contentFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
contentFrame.Visible = false

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

-- All Games menu
local function setupAllGames()
    clearContent()

    local flyBtn = Instance.new("TextButton", contentFrame)
    flyBtn.Size = UDim2.new(0, 120, 0, 40)
    flyBtn.Position = UDim2.new(0, 10, 0, 10)
    flyBtn.Text = "Fly"
    flyBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
    flyBtn.TextColor3 = Color3.new(1,1,1)
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.TextSize = 20

    local fakeLagBtn = Instance.new("TextButton", contentFrame)
    fakeLagBtn.Size = UDim2.new(0, 120, 0, 40)
    fakeLagBtn.Position = UDim2.new(0, 150, 0, 10)
    fakeLagBtn.Text = "Fake Lag"
    fakeLagBtn.BackgroundColor3 = Color3.fromRGB(255,165,0)
    fakeLagBtn.TextColor3 = Color3.new(1,1,1)
    fakeLagBtn.Font = Enum.Font.GothamBold
    fakeLagBtn.TextSize = 20

    local fakeKickBtn = Instance.new("TextButton", contentFrame)
    fakeKickBtn.Size = UDim2.new(0, 260, 0, 40)
    fakeKickBtn.Position = UDim2.new(0, 10, 0, 60)
    fakeKickBtn.Text = "Fake Kick / Ban"
    fakeKickBtn.BackgroundColor3 = Color3.fromRGB(220,20,60)
    fakeKickBtn.TextColor3 = Color3.new(1,1,1)
    fakeKickBtn.Font = Enum.Font.GothamBold
    fakeKickBtn.TextSize = 20

    -- Fly logic
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
            flyForce.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            flyForce.Velocity = Vector3.new(0, 0, 0)
            flyForce.Parent = root

            spawn(function()
                while flying do
                    local dir = Vector3.new()
                    if mouse:IsKeyDown(Enum.KeyCode.W) then
                        dir = dir + workspace.CurrentCamera.CFrame.LookVector
                    end
                    if mouse:IsKeyDown(Enum.KeyCode.S) then
                        dir = dir - workspace.CurrentCamera.CFrame.LookVector
                    end
                    if mouse:IsKeyDown(Enum.KeyCode.A) then
                        dir = dir - workspace.CurrentCamera.CFrame.RightVector
                    end
                    if mouse:IsKeyDown(Enum.KeyCode.D) then
                        dir = dir + workspace.CurrentCamera.CFrame.RightVector
                    end
                    dir = Vector3.new(dir.X, 0, dir.Z)
                    if dir.Magnitude > 0 then
                        dir = dir.Unit * 50
                    end
                    flyForce.Velocity = Vector3.new(dir.X, 50, dir.Z)
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

    -- Fake Lag logic
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

    -- Fake Kick/Ban logic
    fakeKickBtn.MouseButton1Click:Connect(function()
        -- Luodaan fake kick/ban GUI
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
        reasonLabel.Position = UDim2.new(0, 10
