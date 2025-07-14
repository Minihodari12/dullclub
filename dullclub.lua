local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local VALID_KEY = "MinihodariDeveloper"

local gui = Instance.new("ScreenGui")
gui.Name = "DullClubGUI"
gui.ResetOnSpawn = false
gui.Parent = Player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.Active = true
mainFrame.Parent = gui
mainFrame.Visible = false

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Text = "Dull Club"
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.PaddingLeft = UDim.new(0, 10)

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Text = "X"

local function askCloseConfirm()
    local confirmFrame = Instance.new("Frame", gui)
    confirmFrame.Size = UDim2.new(0, 300, 0, 120)
    confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
    confirmFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    confirmFrame.BorderSizePixel = 0

    local confirmText = Instance.new("TextLabel", confirmFrame)
    confirmText.Size = UDim2.new(1, -20, 0.6, 0)
    confirmText.Position = UDim2.new(0, 10, 0, 10)
    confirmText.BackgroundTransparency = 1
    confirmText.TextColor3 = Color3.new(1,1,1)
    confirmText.Font = Enum.Font.GothamBold
    confirmText.TextSize = 18
    confirmText.TextWrapped = true
    confirmText.Text = "Are you sure you want to close the menu?"

    local yesButton = Instance.new("TextButton", confirmFrame)
    yesButton.Size = UDim2.new(0.4, 0, 0, 40)
    yesButton.Position = UDim2.new(0.05, 0, 0.65, 0)
    yesButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    yesButton.Font = Enum.Font.GothamBold
    yesButton.TextSize = 18
    yesButton.TextColor3 = Color3.new(1,1,1)
    yesButton.Text = "Yes"

    local noButton = Instance.new("TextButton", confirmFrame)
    noButton.Size = UDim2.new(0.4, 0, 0, 40)
    noButton.Position = UDim2.new(0.55, 0, 0.65, 0)
    noButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    noButton.Font = Enum.Font.GothamBold
    noButton.TextSize = 18
    noButton.TextColor3 = Color3.new(1,1,1)
    noButton.Text = "No"

    yesButton.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    noButton.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
    end)
end

closeButton.MouseButton1Click:Connect(askCloseConfirm)

local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -20, 1, -70)
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.BackgroundTransparency = 1

local function clearContent()
    for _, child in pairs(contentFrame:GetChildren()) do
        if not (child:IsA("UIListLayout") or child:IsA("UIPadding")) then
            child:Destroy()
        end
    end
end

local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(1, 0, 0, 30)
tabFrame.Position = UDim2.new(0, 0, 1, -30)
tabFrame.BackgroundTransparency = 1

local tabs = {"Update Log", "All Games", "Fly", "Credits"}
local tabButtons = {}

local noclipEnabled = false
local speedEnabled = false
local invisEnabled = false

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    local char = Player.Character
    if not char then return end
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noclipEnabled
        end
    end
end

local function toggleSpeed()
    speedEnabled = not speedEnabled
    local char = Player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        if speedEnabled then
            hum.WalkSpeed = 50
        else
            hum.WalkSpeed = 16
        end
    end
end

local function toggleInvisibility()
    invisEnabled = not invisEnabled
    local char = Player.Character
    if not char then return end
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = invisEnabled and 1 or 0
            if part:FindFirstChildOfClass("Decal") then
                part:FindFirstChildOfClass("Decal").Transparency = invisEnabled and 1 or 0
            end
        end
    end
end

local function showUpdateLog()
    clearContent()
    local label = Instance.new("TextLabel", contentFrame)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextWrapped = true
    label.Text = [[
Version 1.0 - Demo release
- Added fly teleport menu
- Added fake kick
- Added noclip, speed, invisibility toggles
- Added credits and update log tabs
]]
end

local function flyToPosition(pos)
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    char.HumanoidRootPart.CFrame = CFrame.new(pos)
end

local function showFlyMenu()
    clearContent()
    local label = Instance.new("TextLabel", contentFrame)
    label.Size = UDim2.new(1,0,0,30)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.Text = "Fly Teleport Locations:"

    local locations = {
        {"Spawn", Vector3.new(0,10,0)},
        {"Tower", Vector3.new(100,50,100)},
        {"Secret Base", Vector3.new(-100,20,-100)},
    }

    for i, loc in ipairs(locations) do
        local btn = Instance.new("TextButton", contentFrame)
        btn.Size = UDim2.new(0.8, 0, 0, 35)
        btn.Position = UDim2.new(0.1, 0, 0, 40 + (i-1)*45)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 18
        btn.Text = loc[1]
        btn.MouseButton1Click:Connect(function()
            flyToPosition(loc[2])
        end)
    end
end

local function fakeKick()
    Player:Kick("You have been kicked (fake kick simulation).")
end

local function showAllGames()
    clearContent()

    local noclipBtn = Instance.new("TextButton", contentFrame)
    noclipBtn.Size = UDim2.new(0.8, 0, 0, 35)
    noclipBtn.Position = UDim2.new(0.1, 0, 0, 10)
    noclipBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    noclipBtn.TextColor3 = Color3.new(1,1,1)
    noclipBtn.Font = Enum.Font.Gotham
    noclipBtn.TextSize = 18
    noclipBtn.Text = "Toggle Noclip (Currently "..(noclipEnabled and "ON" or "OFF")..")"
    noclipBtn.MouseButton1Click:Connect(function()
        toggleNoclip()
        noclipBtn.Text = "Toggle Noclip (Currently "..(noclipEnabled and "ON" or "OFF")..")"
    end)

    local speedBtn = Instance.new("TextButton", contentFrame)
    speedBtn.Size = UDim2.new(0.8, 0, 0, 35)
    speedBtn.Position = UDim2.new(0.1, 0, 0, 55)
    speedBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    speedBtn.TextColor3 = Color3.new(1,1,1)
    speedBtn.Font = Enum.Font.Gotham
    speedBtn.TextSize = 18
    speedBtn.Text = "Toggle Speed (Currently "..(speedEnabled and "ON" or "OFF")..")"
    speedBtn.MouseButton1Click:Connect(function()
        toggleSpeed()
        speedBtn.Text = "Toggle Speed (Currently "..(speedEnabled and "ON" or "OFF")..")"
    end)

    local invisBtn = Instance.new("TextButton", contentFrame)
    invisBtn.Size = UDim2.new(0.8, 0, 0, 35)
    invisBtn.Position = UDim2.new(0.1, 0, 0, 100)
    invisBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    invisBtn.TextColor3 = Color3.new(1,1,1)
    invisBtn.Font = Enum.Font.Gotham
    invisBtn.TextSize = 18
    invisBtn.Text = "Toggle Invisibility (Currently "..(invisEnabled and "ON" or "OFF")..")"
    invisBtn.MouseButton1Click:Connect(function()
        toggleInvisibility()
        invisBtn.Text = "Toggle Invisibility (Currently "..(invisEnabled and "ON" or "OFF")..")"
    end)

    local fkBtn = Instance.new("TextButton", contentFrame)
    fkBtn.Size = UDim2.new(0.8, 0, 0, 35)
    fkBtn.Position = UDim2.new(0.1, 0, 0, 145)
    fkBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    fkBtn.TextColor3 = Color3.new(1,1,1)
    fkBtn.Font = Enum.Font.GothamBold
    fkBtn.TextSize = 18
    fkBtn.Text = "Fake Kick Player"
    fkBtn.MouseButton1Click:Connect(fakeKick)
end

local function showCredits()
    clearContent()
    local label = Instance.new("TextLabel", contentFrame)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    label.TextWrapped = true
    label.Text = [[
Created by Minihodari12
Thanks for using Dull Club!
Discord server coming soon!
]]
end

-- Tab buttons creation and handling
local function selectTab(tabName)
    if tabName == "Update Log" then
        showUpdateLog()
    elseif tabName == "All Games" then
        showAllGames()
    elseif tabName == "Fly" then
        showFlyMenu()
    elseif tabName == "Credits" then
        showCredits()
    end
end

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabFrame)
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Position = UDim2.new(0, (i-1)*100, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = tabName

    btn.MouseButton1Click:Connect(function()
        selectTab(tabName)
    end)

    tabButtons[tabName] = btn
end

-- Key Entry UI
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 350, 0, 150)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true

local keyLabel = Instance.new("TextLabel", keyFrame)
keyLabel.Size = UDim2.new(1, 0, 0, 40)
keyLabel.BackgroundTransparency = 1
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextSize = 18
keyLabel.Text = "Enter Key to Access:"

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8, 0, 0, 40)
keyBox.Position = UDim2.new(0.1, 0, 0, 50)
keyBox.ClearTextOnFocus = false
keyBox.PlaceholderText = "Enter key here"
keyBox.Text = ""

local submitBtn = Instance.new("TextButton", keyFrame)
submitBtn.Size = UDim2.new(0.8, 0, 0, 40)
submitBtn.Position = UDim2.new(0.1, 0, 0, 100)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 18
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.Text = "Submit"

submitBtn.MouseButton1Click:Connect(function()
    local enteredKey = keyBox.Text
    if enteredKey == VALID_KEY then
        keyFrame:Destroy()
        mainFrame.Visible = true
        showUpdateLog()
    else
        Player:Kick("Invalid key! Contact Minihodari12 for the key. Discord server coming soon!")
    end
end)
