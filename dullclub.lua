local player = game.Players.LocalPlayer

-- Luo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyPromptGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 220)
frame.Position = UDim2.new(0.5, -160, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Parent = screenGui

-- Update Log Label
local updateLog = Instance.new("TextLabel")
updateLog.Size = UDim2.new(1, -20, 0, 60)
updateLog.Position = UDim2.new(0, 10, 0, 10)
updateLog.BackgroundTransparency = 1
updateLog.TextColor3 = Color3.new(1,1,1)
updateLog.Font = Enum.Font.GothamBold
updateLog.TextSize = 14
updateLog.TextWrapped = true
updateLog.Text = "Update Log:\n- Added Fly\n- Added Fake Lag\n- Added Key GUI & Menu"
updateLog.Parent = frame

-- Key prompt label
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -20, 0, 30)
textLabel.Position = UDim2.new(0, 10, 0, 75)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Enter your key:"
textLabel.TextColor3 = Color3.new(1,1,1)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 20
textLabel.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0, 40)
textBox.Position = UDim2.new(0.1, 0, 0, 110)
textBox.ClearTextOnFocus = false
textBox.PlaceholderText = "Key"
textBox.Text = ""
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 18
textBox.Parent = frame

local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.8, 0, 0, 40)
submitButton.Position = UDim2.new(0.1, 0, 0, 160)
submitButton.Text = "Submit"
submitButton.Font = Enum.Font.GothamBold
submitButton.TextSize = 20
submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitButton.TextColor3 = Color3.new(1,1,1)
submitButton.Parent = frame

-- Funktiot
local function createMenu()
    -- Tyhjennä frame
    frame:ClearAllChildren()
    frame.Size = UDim2.new(0, 220, 0, 150)
    frame.Position = UDim2.new(0.5, -110, 0.5, -75)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Menu"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.TextColor3 = Color3.new(1,1,1)
    title.Parent = frame

    -- Fly button
    local flyButton = Instance.new("TextButton")
    flyButton.Size = UDim2.new(0.8, 0, 0, 40)
    flyButton.Position = UDim2.new(0.1, 0, 0, 50)
    flyButton.Text = "Fly"
    flyButton.Font = Enum.Font.GothamBold
    flyButton.TextSize = 20
    flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    flyButton.TextColor3 = Color3.new(1,1,1)
    flyButton.Parent = frame

    -- Fake Lag button
    local lagButton = Instance.new("TextButton")
    lagButton.Size = UDim2.new(0.8, 0, 0, 40)
    lagButton.Position = UDim2.new(0.1, 0, 0, 100)
    lagButton.Text = "Fake Lag"
    lagButton.Font = Enum.Font.GothamBold
    lagButton.TextSize = 20
    lagButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    lagButton.TextColor3 = Color3.new(1,1,1)
    lagButton.Parent = frame

    -- Fly toiminto
    local flying = false
    local playerChar = player.Character or player.CharacterAdded:Wait()
    local humanoid = playerChar:WaitForChild("Humanoid")
    local rootPart = playerChar:WaitForChild("HumanoidRootPart")
    local flyForce

    local function toggleFly()
        flying = not flying
        if flying then
            flyForce = Instance.new("BodyVelocity")
            flyForce.Velocity = Vector3.new(0,0,0)
            flyForce.MaxForce = Vector3.new(1e5,1e5,1e5)
            flyForce.Parent = rootPart
            flyButton.Text = "Stop Fly"
            spawn(function()
                while flying do
                    flyForce.Velocity = Vector3.new(0, 50, 0)
                    wait(0.1)
                end
                if flyForce then flyForce:Destroy() end
            end)
        else
            if flyForce then flyForce:Destroy() end
            flyButton.Text = "Fly"
        end
    end

    flyButton.MouseButton1Click:Connect(toggleFly)

    -- Fake lag toiminto
    local fakeLagActive = false
    local fakeLagConnection

    local function toggleFakeLag()
        fakeLagActive = not fakeLagActive
        if fakeLagActive then
            lagButton.Text = "Stop Fake Lag"
            fakeLagConnection = game:GetService("RunService").RenderStepped:Connect(function()
                wait(0.05)
            end)
        else
            lagButton.Text = "Fake Lag"
            if fakeLagConnection then
                fakeLagConnection:Disconnect()
                fakeLagConnection = nil
            end
        end
    end

    lagButton.MouseButton1Click:Connect(toggleFakeLag)
end

-- Submit-nappulan tapahtuma
local function onSubmit()
    local enteredKey = textBox.Text
    if enteredKey == "MinihodariDeveloper" then
        screenGui:Destroy()
        createMenu()
    else
        player:Kick("❌ Invalid key! Please contact the code creator to get the correct key.")
    end
end

submitButton.MouseButton1Click:Connect(onSubmit)
