local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Luo pää-GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DullClubGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 300)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Otsikko
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Dull Club - Enter Key"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Parent = mainFrame

-- Key TextBox
local keyBox = Instance.new("TextBox")
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
keyBox.Parent = mainFrame

-- Submit nappi
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.3, -10, 0, 35)
submitBtn.Position = UDim2.new(0.7, 0, 0, 60)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 20
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.BorderSizePixel = 0
submitBtn.Parent = mainFrame

-- Viestilaatikko virheille
local msgLabel = Instance.new("TextLabel")
msgLabel.Size = UDim2.new(1, -20, 0, 30)
msgLabel.Position = UDim2.new(0, 10, 0, 110)
msgLabel.BackgroundTransparency = 1
msgLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
msgLabel.Text = ""
msgLabel.Font = Enum.Font.GothamBold
msgLabel.TextSize = 18
msgLabel.Parent = mainFrame

-- Valikon napit (piilotetaan aluksi)
local buttons = {}

local function createMenuButton(text, posX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 35)
    btn.Position = UDim2.new(0, posX, 0, 100)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(20, 120, 255)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    btn.Visible = false
    btn.Parent = mainFrame
    return btn
end

buttons.updateLog = createMenuButton("Update Log", 10)
buttons.allGames = createMenuButton("All Games", 140)
buttons.dandysWorld = createMenuButton("Dandys World", 270)

-- Content frame näkyviin valikossa
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -160)
contentFrame.Position = UDim2.new(0, 10, 0, 140)
contentFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
contentFrame.Parent = mainFrame
contentFrame.Visible = false

-- Tyhjennä contentFrame
local function clearContent()
    for _, child in pairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
end

-- Päivitysloki tekstinä
local updateLogText = [[
Update Log:
- Added Fly, Fake Lag, Fake Kick/Ban
- Added Key check system
- Added menus for All Games and Dandys World
]]

-- Näytä päivitysloki
local function showUpdateLog()
    clearContent()
    contentFrame.Visible = true

    local logLabel = Instance.new("TextLabel")
    logLabel.Size = UDim2.new(1, -20, 1, -20)
    logLabel.Position = UDim2.new(0, 10, 0, 10)
    logLabel.BackgroundTransparency = 1
    logLabel.TextColor3 = Color3.new(1,1,1)
    logLabel.Text = updateLogText
    logLabel.Font = Enum.Font.Gotham
    logLabel.TextSize = 16
    logLabel.TextWrapped = true
    logLabel.TextYAlignment = Enum.TextYAlignment.Top
    logLabel.Parent = contentFrame
end

-- All Games valikko
local function setupAllGames()
    clearContent()
    contentFrame.Visible = true

    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(0, 120, 0, 40)
    flyBtn.Position = UDim2.new(0, 10, 0, 10)
    flyBtn.Text = "Fly"
    flyBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
    flyBtn.TextColor3 = Color3.new(1,1,1)
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.TextSize = 20
    flyBtn.Parent = contentFrame

    local fakeLagBtn = Instance.new("TextButton")
    fakeLagBtn.Size = UDim2.new(0, 120, 0, 40)
    fakeLagBtn.Position = UDim2.new(0, 150, 0, 10)
    fakeLagBtn.Text = "Fake Lag"
    fakeLagBtn.BackgroundColor3 = Color3.fromRGB(255,165,0)
    fakeLagBtn.TextColor3 = Color3.new(1,1,1)
    fakeLagBtn.Font = Enum.Font.GothamBold
    fakeLagBtn.TextSize = 20
    fakeLagBtn.Parent = contentFrame

    local fakeKickBtn = Instance.new("TextButton")
    fakeKickBtn.Size = UDim2.new(0, 260, 0, 40)
    fakeKickBtn.Position = UDim2.new(0, 10, 0, 60)
    fakeKickBtn.Text = "Fake Kick / Ban"
    fakeKickBtn.BackgroundColor3 = Color3.fromRGB(220,20,60)
    fakeKickBtn.TextColor3 = Color3.new(1,1,1)
    fakeKickBtn.Font = Enum.Font.GothamBold
    fakeKickBtn.TextSize = 20
    fakeKickBtn.Parent = contentFrame

    -- Fly toiminto
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

    -- Fake Lag toiminto
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

    -- Fake Kick / Ban
    fakeKickBtn.MouseButton1Click:Connect(function()
        -- Luodaan fake kick/ban GUI
        local kickGui = Instance.new("ScreenGui")
        kickGui.Name = "FakeKickGui"
        kickGui.Parent = player.PlayerGui

        local kickFrame = Instance.new("Frame")
        kickFrame.Size = UDim2.new(0, 300, 0, 220)
        kickFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
        kickFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        kickFrame.Parent = kickGui

        local selectLabel = Instance.new("TextLabel")
        selectLabel.Size = UDim2.new(1, -20, 0, 40)
        selectLabel.Position = UDim2.new(0, 10, 0, 10)
        selectLabel.BackgroundTransparency = 1
        selectLabel.Text = "Select Kick or Ban:"
        selectLabel.TextColor3 = Color3.new(1,1,1)
        selectLabel.Font = Enum.Font.GothamBold
        selectLabel.TextSize = 20
        selectLabel.Parent = kickFrame

        local kickRadio = Instance.new("TextButton")
        kickRadio.Size = UDim2.new(0.4, 0, 0, 40)
        kickRadio.Position = UDim2.new(0.05, 0, 0, 60)
        kickRadio.Text = "Kick"
        kickRadio.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        kickRadio.TextColor3 = Color3.new(1,1,1)
        kickRadio.Font = Enum.Font.GothamBold
        kickRadio.TextSize = 20
        kickRadio.Parent = kickFrame

        local banRadio = Instance.new("TextButton")
        banRadio.Size = UDim2.new(0.4, 0, 0, 40)
        banRadio.Position = UDim2.new(0.55, 0, 0, 60)
        banRadio.Text = "Ban"
        banRadio.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
        banRadio.TextColor3 = Color3.new(1,1,1)
        banRadio.Font = Enum.Font.GothamBold
        banRadio.TextSize = 20
        banRadio.Parent = kickFrame

        local reasonLabel = Instance.new("TextLabel")
        reasonLabel.Size = UDim2.new(1, -20, 0, 30)
        reasonLabel.Position = UDim2.new(0, 10, 0, 110)
        reasonLabel.BackgroundTransparency = 1
        reasonLabel.Text = "Reason:"
        reasonLabel.TextColor3 = Color3.new(1,1,1)
        reasonLabel.Font = Enum.Font.GothamBold
        reasonLabel.TextSize = 18
        reasonLabel.Parent = kickFrame

        local reasonBox = Instance.new("TextBox")
        reasonBox.Size = UDim2.new(1, -20, 0, 40)
        reasonBox.Position = UDim2.new(0, 10, 0, 140)
        reasonBox.PlaceholderText = "Enter reason here..."
        reasonBox.ClearTextOnFocus = false
        reasonBox.Text = ""
        reasonBox.Font = Enum.Font.Gotham
        reasonBox.TextSize = 18
        reasonBox.TextColor3 = Color3.new(1,1,1)
        reasonBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        reasonBox.BorderSizePixel = 0
        reasonBox.Parent = kickFrame

        local submitKick = Instance.new("TextButton")
        submitKick.Size = UDim2.new(1, -20, 0, 40)
        submitKick.Position = UDim2.new(0, 10, 0, 190)
        submitKick.Text = "Submit"
        submitKick.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        submitKick.TextColor3 = Color3.new(1,1,1)
        submitKick.Font = Enum.Font.GothamBold
        submitKick.TextSize = 20
        submitKick.Parent = kickFrame

        local chosenAction = nil

        kickRadio.MouseButton1Click:Connect(function()
            chosenAction = "Kick"
            kickRadio.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            banRadio.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
        end)

        banRadio.MouseButton1Click:Connect(function()
            chosenAction = "Ban"
            banRadio.BackgroundColor3 = Color3.fromRGB(180, 20, 0)
            kickRadio.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        end)

        submitKick.MouseButton1Click:Connect(function()
            if not chosenAction then
                reasonLabel.Text = "Select Kick or Ban first!"
                reasonLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                return
            end
            local reason = reasonBox.Text
            if reason == "" then
                reasonLabel.Text = "Please enter a reason!"
                reasonLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                return
            end

            -- Näytetään fake kick/ban -viesti pelaajalle
            local notice = Instance.new("ScreenGui")
            notice.Name = "FakeNoticeGui"
            notice.Parent = player.PlayerGui

            local noticeFrame = Instance.new("Frame")
            noticeFrame.Size = UDim2.new(0, 300, 0, 150)
            noticeFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
            noticeFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            noticeFrame.Parent = notice

            local noticeLabel = Instance.new("TextLabel")
            noticeLabel.Size = UDim2.new(1, -20, 1, -20)
            noticeLabel.Position = UDim2.new(0, 10, 0, 10)
            noticeLabel.BackgroundTransparency = 1
            noticeLabel.TextColor3 = Color3.new(1, 1, 1)
            noticeLabel.Font = Enum.Font.GothamBold
            noticeLabel.TextSize = 20
            noticeLabel.TextWrapped = true
            noticeLabel.Text = chosenAction .. "ed from server.\nReason:\n" .. reason
            noticeLabel.Parent = noticeFrame

            kickGui:Destroy()

            -- Suljetaan gui 5 sekunnin päästä
            delay(5, function()
                notice:Destroy()
            end)
        end)
    end)
end

-- Dandys World (placeholder)
local function setupDandysWorld()
    clearContent()
    contentFrame.Visible = true

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, -20)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Text = "Dandys World features will be added here."
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    label.TextWrapped = true
    label.Parent = contentFrame
end

-- Näytä valikko ja napit keyn jälkeen
local function showMenu()
    title.Text = "Dull Club - Menu"
    keyBox.Visible = false
    submitBtn.Visible = false
    msgLabel.Text = ""
    contentFrame.Visible = false

    for _, btn in pairs(buttons) do
        btn.Visible = true
    end
end

-- Napit valikon toiminnoksi
buttons.updateLog.MouseButton1Click:Connect(showUpdateLog)
buttons.allGames.MouseButton1Click:Connect(setupAllGames)
buttons.dandysWorld.MouseButton1Click:Connect(setupDandysWorld)

-- Submit nappi keylle
submitBtn.MouseButton1Click:Connect(function()
    local inputKey = keyBox.Text
    if inputKey == "MinihodariDeveloper" then
        showMenu()
    else
        msgLabel.Text = "Invalid key! Access denied."
        wait(3)
        msgLabel.Text = ""
    end
end)
