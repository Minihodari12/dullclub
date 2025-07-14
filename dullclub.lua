local player = game.Players.LocalPlayer

-- Luo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyPromptGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 40)
textLabel.Position = UDim2.new(0, 0, 0, 10)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Enter your key:"
textLabel.TextColor3 = Color3.new(1,1,1)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 20
textLabel.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0, 40)
textBox.Position = UDim2.new(0.1, 0, 0, 60)
textBox.ClearTextOnFocus = false
textBox.PlaceholderText = "Key"
textBox.Text = ""
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 18
textBox.Parent = frame

local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.8, 0, 0, 40)
submitButton.Position = UDim2.new(0.1, 0, 0, 110)
submitButton.Text = "Submit"
submitButton.Font = Enum.Font.GothamBold
submitButton.TextSize = 20
submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitButton.TextColor3 = Color3.new(1,1,1)
submitButton.Parent = frame

-- Funktio tarkistaa keyn
local function onSubmit()
    local enteredKey = textBox.Text
    if enteredKey == "MinihodariDeveloper" then
        screenGui:Destroy()
        -- Tästä alkaa pääskriptisi, laita se tähän
        print("Key correct! Script starting...")

        -- Esim. tässä voit kutsua pääskriptiä:
        -- loadstring(game:HttpGet("https://raw.githubusercontent.com/Minisi/dullclub/main/dullclub.lua"))()

    else
        player:Kick("❌ Invalid key! Get your key from MinihodariDeveloper.")
    end
end

submitButton.MouseButton1Click:Connect(onSubmit)
