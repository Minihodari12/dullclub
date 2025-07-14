local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Luo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DullClubGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 320)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Sulje-nappi (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.TextSize = 22
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    local confirm = game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Confirm Close",
        Text = "Are you sure you want to close the script?",
        Duration = 5
    })
    local yesNoGui = Instance.new("ScreenGui", player.PlayerGui)
    local frame = Instance.new("Frame", yesNoGui)
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)

    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Text = "Are you sure you want to close the script?"
    textLabel.Size = UDim2.new(1,0,0,50)
    textLabel.TextColor3 = Color3.new(1,1,1)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 18
    textLabel.Position = UDim2.new(0,0,0,10)

    local yesBtn = Instance.new("TextButton", frame)
    yesBtn.Text = "Yes"
    yesBtn.Size = UDim2.new(0.4, 0, 0, 40)
    yesBtn.Position = UDim2.new(0.1, 0, 1, -50)
    yesBtn.BackgroundColor3 = Color3.fromRGB(50,150,50)
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextColor3 = Color3.new(1,1,1)
    yesBtn.TextSize = 18

    local noBtn = Instance.new("TextButton", frame)
    noBtn.Text = "No"
    noBtn.Size = UDim2.new(0.4, 0, 0, 40)
    noBtn.Position = UDim2.new(0.5, 0, 1, -50)
    noBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
    noBtn.Font = Enum.Font.GothamBold
    noBtn.TextColor3 = Color3.new(1,1,1)
    noBtn.TextSize = 18

    yesBtn.MouseButton1Click:Connect(function()
        yesNoGui:Destroy()
        screenGui:Destroy()
    end)

    noBtn.MouseButton1Click:Connect(function()
        yesNoGui:Destroy()
    end)
end)

-- Title label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Dull Club - Enter Key"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Parent = mainFrame

-- Key textbox
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

-- Submit button
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.3, -10, 0, 35)
submitBtn.Position = UDim2.new(0.7, 0, 0, 60)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 20
submitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.Parent = mainFrame

-- Funktiot
local function kickPlayer(reason)
    player:Kick(reason or "No reason provided")
end

local function createMainMenu()
    -- Tyhjennä vanhat
    for _, child in pairs(mainFrame:GetChildren()) do
        if child ~= closeButton and child ~= title then
            child:Destroy()
        end
    end

    title.Text = "Dull Club - Menu"

    local updateLog = Instance.new("TextLabel")
    updateLog.Size = UDim2.new(1, -20, 0, 60)
    updateLog.Position = UDim2.new(0, 10, 0, 10)
    updateLog.BackgroundColor3 = Color3.fromRGB(40,40,40)
    updateLog.TextColor3 = Color3.new(1,1,1)
    updateLog.TextWrapped = true
    updateLog.Text = "Update Log:\n- Added close button with confirmation\n- Improved Fly\n- Added Fake Kick that kicks for real\n- More commands in All Games\n- Kick on invalid key"
    updateLog.Font = Enum.Font.Gotham
    updateLog.TextSize = 14
    updateLog.Parent = mainFrame

    -- Valikon nappi: All Games
    local allGamesBtn = Instance.new("TextButton")
    allGamesBtn.Size = UDim2.new(0.45, -10, 0, 40)
    allGamesBtn.Position = UDim2.new(0, 10, 0, 80)
    allGamesBtn.Text = "All Games"
    allGamesBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    allGamesBtn.TextColor3 = Color3.new(1,1,1)
    allGamesBtn.Font = Enum.Font.GothamBold
    allGamesBtn.TextSize = 20
    allGamesBtn.Parent = mainFrame

    -- Valikon nappi: Dandys World
    local dandysBtn = Instance.new("TextButton")
    dandysBtn.Size = UDim2.new(0.45, -10, 0, 40)
    dandysBtn.Position = UDim2.new(0.5, 0, 0, 80)
    dandysBtn.Text = "Dandys World"
    dandysBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    dandysBtn.TextColor3 = Color3.new(1,1,1)
    dandysBtn.Font = Enum.Font.GothamBold
    dandysBtn.TextSize = 20
    dandysBtn.Parent = mainFrame

    -- Update Discord message
    local discordLabel = Instance.new("TextLabel")
    discordLabel.Size = UDim2.new(1, -20, 0, 30)
    discordLabel.Position = UDim2.new(0, 10, 1, -40)
    discordLabel.BackgroundTransparency = 1
    discordLabel.Text = "Discord server coming soon!"
    discordLabel.TextColor3 = Color3.new(0.8, 0.8, 1)
    discordLabel.Font = Enum.Font.GothamItalic
    discordLabel.TextSize = 14
    discordLabel.Parent = mainFrame

    -- All Games valikko
    allGamesBtn.MouseButton1Click:Connect(function()
        -- Tyhjennä
        for _, child in pairs(mainFrame:GetChildren()) do
            if child ~= closeButton and child ~= title and child ~= discordLabel then
                child:Destroy()
            end
        end
        title.Text = "All Games Commands"

        local flyBtn = Instance.new("TextButton")
        flyBtn.Size = UDim2.new(0.4, -10, 0, 40)
        flyBtn.Position = UDim2.new(0, 10, 0, 10)
        flyBtn.Text = "Fly"
        flyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        flyBtn.TextColor3 = Color3.new(1,1,1)
        flyBtn.Font = Enum.Font.GothamBold
        flyBtn.TextSize = 20
        flyBtn.Parent = mainFrame

        local fakeLagBtn = Instance.new("TextButton")
        fakeLagBtn.Size = UDim2.new(0.4, -10, 0, 40)
        fakeLagBtn.Position = UDim2.new(0.5, 0, 0, 10)
        fakeLagBtn.Text = "Fake Lag"
        fakeLagBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        fakeLagBtn.TextColor3 = Color3.new(1,1,1)
        fakeLagBtn.Font = Enum.Font.GothamBold
        fakeLagBtn.TextSize = 20
        fakeLagBtn.Parent = mainFrame

        local fakeKickBtn = Instance.new("TextButton")
        fakeKickBtn.Size = UDim2.new(0.4, -10, 0, 40)
        fakeKickBtn.Position = UDim2.new(0, 10, 0, 60)
        fakeKickBtn.Text = "Fake Kick/Ban"
        fakeKickBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        fakeKickBtn.TextColor3 = Color3.new(1,1,1)
        fakeKickBtn.Font = Enum.Font.GothamBold
        fakeKickBtn.TextSize = 20
        fakeKickBtn.Parent = mainFrame

        local backBtn = Instance.new("TextButton")
        backBtn.Size = UDim2.new(0.4, -10, 0, 40)
        backBtn.Position = UDim2.new(0.5, 0, 0, 60)
        backBtn.Text = "Back"
        backBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        backBtn.TextColor3 = Color3.new(1,1,1)
        backBtn.Font = Enum.Font.GothamBold
        backBtn.TextSize = 20
        backBtn.Parent = mainFrame

        flyBtn.MouseButton1Click:Connect(function()
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end

            local flying = true
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVelocity.Velocity = Vector3.new(0,0,0)
            bodyVelocity.Parent = character.HumanoidRootPart

            local userInputService = game:GetService("UserInputService")
            local flySpeed = 50

            local function updateFly()
                if not flying then return end
                local direction = Vector3.new(0,0,0)
                if userInputService:IsKeyDown(Enum.KeyCode.W) then
                    direction = direction + (workspace.CurrentCamera.CFrame.LookVector)
                end
                if userInputService:IsKeyDown(Enum.KeyCode.S) then
                    direction = direction - (workspace.CurrentCamera.CFrame.LookVector)
                end
                if userInputService:IsKeyDown(Enum.KeyCode.A) then
                    direction = direction - (workspace.CurrentCamera.CFrame.RightVector)
                end
                if userInputService:IsKeyDown(Enum.KeyCode.D) then
                    direction = direction + (workspace.CurrentCamera.CFrame.RightVector)
                end
                if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                    direction = direction + Vector3.new(0,1,0)
                end
                if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    direction = direction - Vector3.new(0,1,0)
                end
                bodyVelocity.Velocity = direction.Unit * flySpeed
            end

            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if not flying then
                    connection:Disconnect()
                    bodyVelocity:Destroy()
                    return
                end
                updateFly()
            end)

            -- Lopeta lentäminen kun poistutaan tai painetaan F uudestaan
            userInputService.InputBegan:Connect(function(input, gpe)
                if gpe then return end
                if input.KeyCode == Enum.KeyCode.F then
                    flying = false
                end
            end)
        end)

        fakeLagBtn.MouseButton1Click:Connect(function()
            -- Fake lag by setting HumanoidRootPart to anchor and unanchor quickly
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            for i=1,10 do
                hrp.Anchored = true
                wait(0.15)
                hrp.Anchored = false
                wait(0.15)
            end
        end)

        fakeKickBtn.MouseButton1Click:Connect(function()
            -- Kysy syy ja kickaa oikeasti
            local screenGui2 = Instance.new("ScreenGui")
            screenGui2.Name = "KickReasonGui"
            screenGui2.Parent = player.PlayerGui

            local frame = Instance.new("Frame", screenGui2)
            frame.Size = UDim2.new(0, 350, 0, 150)
            frame.Position = UDim2.new(0.5, -175, 0.5, -75)
            frame.BackgroundColor3 = Color3.fromRGB(40,40,40)

            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1,0,0,40)
            label.Position = UDim2.new(0,0,0,10)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.Text = "Enter reason for Kick/Ban"
            label.Font = Enum.Font.GothamBold
            label.TextSize = 18

            local reasonBox = Instance.new("TextBox", frame)
            reasonBox.Size = UDim2.new(0.9, 0, 0, 40)
            reasonBox.Position = UDim2.new(0.05, 0, 0, 60)
            reasonBox.PlaceholderText = "Reason"
            reasonBox.TextColor3 = Color3.new(1,1,1)
            reasonBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
            reasonBox.ClearTextOnFocus = false
            reasonBox.Font = Enum.Font.Gotham
            reasonBox.TextSize = 18

            local kickBtn2 = Instance.new("TextButton", frame)
            kickBtn2.Size = UDim2.new(0.4, -10, 0, 40)
            kickBtn2.Position = UDim2.new(0.05, 0, 1, -50)
            kickBtn2.Text = "Kick"
            kickBtn2.BackgroundColor3 = Color3.fromRGB(200,50,50)
            kickBtn2.TextColor3 = Color3.new(1,1,1)
            kickBtn2.Font = Enum.Font.GothamBold
            kickBtn2.TextSize = 18

            local banBtn2 = Instance.new("TextButton", frame)
            banBtn2.Size = UDim2.new(0.4, -10, 0, 40)
            banBtn2.Position = UDim2.new(0.55, 0, 1, -50)
            banBtn2.Text = "Ban"
            banBtn2.BackgroundColor3 = Color3.fromRGB(100,0,0)
            banBtn2.TextColor3 = Color3.new(1,1,1)
            banBtn2.Font = Enum.Font.GothamBold
            banBtn2.TextSize = 18

            kickBtn2.MouseButton1Click:Connect(function()
                if reasonBox.Text == "" then return end
                player:Kick("Kicked by script: "..reasonBox.Text)
            end)

            banBtn2.MouseButton1Click:Connect(function()
                if reasonBox.Text == "" then return end
                -- Ban toiminto, esimerkkinä kickataan (robloxissa ei oikeaa bannia helposti)
                player:Kick("Banned by script: "..reasonBox.Text)
            end)
        end)

        backBtn.MouseButton1Click:Connect(function()
            createMainMenu()
        end)
    end)

    -- Dandys World valikko
    dandysBtn.MouseButton1Click:Connect(function()
        -- Tyhjennä
        for _, child in pairs(mainFrame:GetChildren()) do
           
