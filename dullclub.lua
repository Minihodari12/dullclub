local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local correctKey = "MinihodariDeveloper"

local gui, mainFrame
local currentTab = "UpdateLog"

-- Apufunktio napin luontiin
local function createButton(parent, text, posY)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, posY, 0)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.AutoButtonColor = true
    return btn
end

local function clearMenu()
    for _, child in pairs(mainFrame:GetChildren()) do
        if child.Name ~= "Title" and child.Name ~= "CloseButton" and child.Name ~= "TabsFrame" then
            child:Destroy()
        end
    end
end

local function flyToggle()
    local flying = false
    local player = Player
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local UIS = game:GetService("UserInputService")
    local bv

    return function()
        flying = not flying
        if flying then
            bv = Instance.new("BodyVelocity", hrp)
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.new(0,0,0)
            spawn(function()
                while flying do
                    local moveDir = Vector3.new(0,0,0)
                    if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + hrp.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - hrp.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - hrp.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + hrp.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0,1,0) end
                    if moveDir.Magnitude > 0 then
                        bv.Velocity = moveDir.Unit * 50
                    else
                        bv.Velocity = Vector3.new(0,0,0)
                    end
                    wait()
                end
            end)
        else
            if bv then bv:Destroy() end
        end
    end
end

local flyFunc = flyToggle()

local function buildUpdateLog()
    clearMenu()
    local label = Instance.new("TextLabel", mainFrame)
    label.Size = UDim2.new(0.8, 0, 0, 160)
    label.Position = UDim2.new(0.1, 0, 0.15, 0)
    label.BackgroundColor3 = Color3.fromRGB(40,40,40)
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextWrapped = true
    label.Text = "📢 Update Log:\n\n- Added Fly\n- Added Fake Lag\n- Added multiple menus\n- Fixed key input\n- Discord coming soon!"
end

local function buildAllGames()
    clearMenu()
    local btnFly = createButton(mainFrame, "Fly (Toggle with F)", 0.15)
    btnFly.MouseButton1Click:Connect(function()
        flyFunc()
    end)
    local btnFakeLag = createButton(mainFrame, "Fake Lag", 0.45)
    btnFakeLag.MouseButton1Click:Connect(function()
        for i=1,5 do
            wait(0.5)
            print("Fake lagging...")
        end
    end)
    local btnFakeKick = createButton(mainFrame, "Fake Kick (Actually kicks!)", 0.75)
    btnFakeKick.MouseButton1Click:Connect(function()
        Player:Kick("Fake Kick used by player. This is a real kick!")
    end)
end

local function buildDandysWorld()
    clearMenu()
    local btnAntiDie = createButton(mainFrame, "Anti Die (Demo)", 0.15)
    btnAntiDie.MouseButton1Click:Connect(function()
        print("Anti Die demo active.")
    end)
    local btnInvisible = createButton(mainFrame, "Invisible (Demo)", 0.45)
    btnInvisible.MouseButton1Click:Connect(function()
        print("Invisible demo active.")
    end)
    local btnDoTasks = createButton(mainFrame, "Do All Tasks (Demo)", 0.75)
    btnDoTasks.MouseButton1Click:Connect(function()
        print("Doing all tasks demo.")
    end)
end

local function switchTab(tab)
    currentTab = tab
    if tab == "UpdateLog" then
        buildUpdateLog()
    elseif tab == "AllGames" then
        buildAllGames()
    elseif tab == "DandysWorld" then
        buildDandysWorld()
    end
end

local function createMenu()
    gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "DullClubMenu"
    mainFrame = Instance.new("Frame", gui)
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", mainFrame)
    
    local title = Instance.new("TextLabel", mainFrame)
    title.Name = "Title"
    title.Size = UDim2.new(1,0,0,40)
    title.BackgroundTransparency = 1
    title.Text = "🎮 DullClub Menu"
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.new(1,1,1)
    title.TextSize = 24
    
    local closeBtn = Instance.new("TextButton", mainFrame)
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(0,30,0,30)
    closeBtn.Position = UDim2.new(1,-35,0,5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    
    closeBtn.MouseButton1Click:Connect(function()
        local confirmGui = Instance.new("ScreenGui", game.CoreGui)
        confirmGui.Name = "ConfirmClose"
        local frame = Instance.new("Frame", confirmGui)
        frame.Size = UDim2.new(0, 300, 0, 150)
        frame.Position = UDim2.new(0.5, -150, 0.5, -75)
        frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        Instance.new("UICorner", frame)
        
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, 0, 0, 50)
        label.Position = UDim2.new(0, 0, 0, 20)
        label.Text = "Are you sure you want to close?"
        label.TextColor3 = Color3.new(1,1,1)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        
        local yesBtn = Instance.new("TextButton", frame)
        yesBtn.Size = UDim2.new(0.4, 0, 0, 40)
        yesBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
        yesBtn.Text = "Yes"
        yesBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        yesBtn.TextColor3 = Color3.new(1,1,1)
        
        local noBtn = Instance.new("TextButton", frame)
        noBtn.Size = UDim2.new(0.4, 0, 0, 40)
        noBtn.Position = UDim2.new(0.5, 0, 0.7, 0)
        noBtn.Text = "No"
        noBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        noBtn.TextColor3 = Color3.new(1,1,1)
        
        yesBtn.MouseButton1Click:Connect(function()
            gui:Destroy()
            confirmGui:Destroy()
        end)
        noBtn.MouseButton1Click:Connect(function()
            confirmGui:Destroy()
        end)
    end)
    
    -- Tab buttons container
    local tabsFrame = Instance.new("Frame", mainFrame)
    tabsFrame.Name = "TabsFrame"
    tabsFrame.Size = UDim2.new(1,0,0,40)
    tabsFrame.Position = UDim2.new(0,0,0.12,0)
    tabsFrame.BackgroundTransparency = 1
    
    local tabNames = {"UpdateLog", "AllGames", "DandysWorld"}
    local tabLabels = {"Update Log", "All Games", "Dandys World"}
    for i, tab in ipairs(tabNames) do
        local tabBtn = Instance.new("TextButton", tabsFrame)
        tabBtn.Size = UDim2.new(1/#tabNames, -4, 1, 0)
        tabBtn.Position = UDim2.new((i-1)/#tabNames, 2, 0, 0)
        tabBtn.Text = tabLabels[i]
        tabBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        tabBtn.TextColor3 = Color3.new(1,1,1)
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.TextSize = 16
        tabBtn.AutoButtonColor = true
        tabBtn.Name = tab
        
        tabBtn.MouseButton1Click:Connect(function()
            switchTab(tab)
        end)
    end
    
    switchTab(currentTab)
end

-- Key GUI
local function createKeyGUI()
    local keyGui = Instance.new("ScreenGui", game.CoreGui)
    keyGui.Name = "DullClubKey"
    local frame = Instance.new("Frame", keyGui)
    frame.Size = UDim2.new(0, 400, 0, 180)
    frame.Position = UDim2.new(0.5, -200, 0.5, -90)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Instance.new("UICorner", frame)
    
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "🔑 Enter Access Key"
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    
    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.8, 0, 0, 40)
    box.Position = UDim2.new(0.1, 0, 0.3, 0)
    box.PlaceholderText = "Enter key here..."
    box.TextColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.fromRGB(40,40,40)
    box.Font = Enum.Font.Gotham
    box.TextSize = 18
    
    local submit = Instance.new("TextButton", frame)
    submit.Size = UDim2.new(0.8, 0, 0, 40)
    submit.Position = UDim2.new(0.1, 0, 0.65, 0)
    submit.Text = "Submit"
    submit.Font = Enum.Font.GothamBold
    submit.TextSize = 20
    submit.BackgroundColor3 = Color3.fromRGB(70,130,180)
    submit.TextColor3 = Color3.new(1,1,1)
    
    local info = Instance.new("TextLabel", frame)
    info.Size = UDim2.new(0.8, 0, 0, 30)
    info.Position = UDim2.new(0.1, 0, 0.9, 0)
    info.BackgroundTransparency = 1
    info.TextColor3 = Color3.new(1,1,1)
    info.Font = Enum.Font.Gotham
    info.TextSize = 14
    
    submit.MouseButton1Click:Connect(function()
        local inputKey = box.Text:lower():gsub("%s+", "")
        if inputKey == correctKey:lower() then
            info.Text = "✅ Key accepted! Loading menu..."
            wait(1)
            keyGui:Destroy()
            createMenu()
        else
            Player:Kick("❌ Wrong key! Ask developer for access.\nDiscord coming soon!")
        end
    end)
