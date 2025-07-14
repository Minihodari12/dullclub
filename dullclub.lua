local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local correctKey = "MinihodariDeveloper"

local gui = Instance.new("ScreenGui")
gui.Name = "SimpleDullClub"
gui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
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
        local character = Player.Character
        if character then
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(math.sin(tick()*5)*5,0,math.cos(tick()*5)*5)
            end
        end
    end)
end

local function stopFakeLag()
    fakeLag = false
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
- Added Fake Lag effect
- Added Fake Kick with reason prompt (kick is real!)
- Added Teleport menu
- Added Close (X) button with confirmation
]]
end

local function buildAllGames()
    clearContent()
    local content = Instance.new("Frame", mainFrame)
    content.Name = "Content"
    content.Size = UDim2.new(0.9, 0, 0.7, 0)
    content.Position = UDim2.new(0.05, 0, 0.25, 0)
    content.BackgroundColor3 = Color3.fromRGB(40,40,40)

    -- Fly button
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

    -- Fake Lag button
    local lagBtn = Instance.new("TextButton", content)
    lagBtn.Size = UDim2.new(0.8, 0, 0, 40)
    lagBtn.Position = UDim2.new(0.1, 0, 0, 60)
    lagBtn.Text = fakeLag and "Stop Fake Lag" or "Start Fake Lag"
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
    kickBtn.Position = UDim2.new(0.1, 0, 0, 110)
    kickBtn.Text = "Fake Kick"
    kickBtn.Font = Enum.Font.Gotham
    kickBtn.TextSize = 18
    kickBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    kickBtn.TextColor3 = Color3.new(1,1,1)

    kickBtn.MouseButton1Click:Connect(function()
        local reason = ""
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
            reason = reasonBox.Text
            inputFrame:Destroy()
            Player:Kick("Kicked: ".. (reason ~= "" and reason or "No reason given"))
        end)
    end)

    -- Teleport button + submenu
    local tpBtn = Instance.new("TextButton", content)
    tpBtn.Size = UDim2.new(0.8, 0, 0, 40)
    tpBtn.Position = UDim2.new(0.1, 0, 0, 160)
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
            {Name = "Spawn", Position = Vector3.new(0,5,0)},
            {Name = "High Tower", Position = Vector3.new(100,50,100)},
            {Name = "Secret Room", Position = Vector3.new(-50,10,-50)},
        }

        for i, loc in ipairs(locations) do
            local locBtn = Instance.new("TextButton", tpFrame)
            locBtn.Size = UDim2.new(0.8, 0, 0, 40)
            locBtn.Position = UDim2.new(0.1, 0, 0, 40 + (i-1)*45)
            locBtn.Text = loc.Name
            locBtn.Font = Enum.Font.Gotham
            locBtn.TextSize = 16
            locBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            locBtn.TextColor3 = Color3.new(1,1,1)

            locBtn.MouseButton1Click:Connect(function()
                local char = Player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(loc.Position)
                end
                tpFrame:Destroy()
            end)
        end

        local closeTP = Instance.new("TextButton", tpFrame)
        closeTP.Size = UDim2.new(0.3, 0, 0, 30)
        closeTP.Position = UDim2.new(0.35, 0, 1, -35)
        closeTP.Text = "Close"
        closeTP.Font = Enum.Font.GothamBold
        closeTP.TextSize = 16
        closeTP.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
        closeTP.TextColor3 = Color3.new(1,1,1)
        closeTP.MouseButton1Click:Connect(function()
            tpFrame:Destroy()
        end)
    end)

end

for i, tabName in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton", mainFrame)
    tabBtn.Size = UDim2.new(0.5, 0, 0, 30)
    tabBtn.Position = UDim2.new((i-1)*0.5, 0, 0, 40)
    tabBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    tabBtn.TextColor3 = Color3.new(1,1,1)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 18
    tabBtn.Text = tabName

    tabBtn.MouseButton1Click:Connect(function()
        if tabName == "Update Log" then
            buildUpdateLog()
        elseif tabName == "All Games" then
            buildAllGames()
        end
    end)
end

-- Show update log initially
buildUpdateLog()

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        mainFrame.Visible = not mainFrame.Visible
    end
end)
