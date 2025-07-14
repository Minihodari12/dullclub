local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

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
- Added Fly with teleport selection
- Simple All Games menu
- Secure key check
]]
end

local flying = false
local bodyVelocity

local function flyMode()
    local character = Player.Character or Player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    -- Kysy teleporttipaikka tekstikentällä
    local teleportFrame = Instance.new("Frame", gui)
    teleportFrame.Size = UDim2.new(0, 300, 0, 150)
    teleportFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    teleportFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    teleportFrame.Name = "TeleportFrame"
    local corner = Instance.new("UICorner", teleportFrame)

    local label = Instance.new("TextLabel", teleportFrame)
    label.Size = UDim2.new(1,0,0,40)
    label.BackgroundTransparency = 1
    label.Text = "Enter Teleport Position (x,y,z):"
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.new(1,1,1)
    label.TextSize = 18

    local inputBox = Instance.new("TextBox", teleportFrame)
    inputBox.Size = UDim2.new(0.8,0,0,40)
    inputBox.Position = UDim2.new(0.1,0,0,50)
    inputBox.ClearTextOnFocus = false
    inputBox.Font = Enum.Font.Gotham
    inputBox.TextSize = 18
    inputBox.PlaceholderText = "Example: 0,10,0"

    local btn = Instance.new("TextButton", teleportFrame)
    btn.Size = UDim2.new(0.5,0,0,35)
    btn.Position = UDim2.new(0.25,0,0,100)
    btn.BackgroundColor3 = Color3.fromRGB(0,170,0)
    btn.Text = "Teleport & Fly"
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 18

    btn.MouseButton1Click:Connect(function()
        local text = inputBox.Text
        local x,y,z = text:match("([^,]+),([^,]+),([^,]+)")
        if x and y and z then
            x,y,z = tonumber(x), tonumber(y), tonumber(z)
            if x and y and z then
                hrp.CFrame = CFrame.new(x,y,z)
                teleportFrame:Destroy()

                -- Aloita lento
                if bodyVelocity then bodyVelocity:Destroy() end
                flying = true
                bodyVelocity = Instance.new("BodyVelocity", hrp)
                bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                bodyVelocity.Velocity = Vector3.new(0,0,0)

                -- Hallinta
                local conn
                conn = game:GetService("RunService").Heartbeat:Connect(function()
                    if not flying then
                        bodyVelocity:Destroy()
                        conn:Disconnect()
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
            else
                warn("Invalid coordinates")
            end
        else
            warn("Invalid input format")
        end
    end)
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
    flyBtn.Text = "Fly (Choose teleport location)"
    flyBtn.Font = Enum.Font.Gotham
    flyBtn.TextSize = 18
    flyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    flyBtn.TextColor3 = Color3.new(1,1,1)

    flyBtn.MouseButton1Click:Connect(flyMode)
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
