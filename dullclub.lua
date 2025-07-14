-- DullClub v1.0 | Key Protected UI Script

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local correctKey = "MinihodariDeveloper"

-- GUI Creator
local function createGUI()
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "DullClubUI"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 400, 0, 250)
    frame.Position = UDim2.new(0.5, -200, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BorderSizePixel = 0

    local corner = Instance.new("UICorner", frame)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "🔑 Enter Access Key"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22

    local box = Instance.new("TextBox", frame)
    box.Position = UDim2.new(0.1, 0, 0.3, 0)
    box.Size = UDim2.new(0.8, 0, 0, 40)
    box.PlaceholderText = "Enter key here..."
    box.Font = Enum.Font.Gotham
    box.TextColor3 = Color3.new(1,1,1)
    box.TextSize = 18
    box.BackgroundColor3 = Color3.fromRGB(40,40,40)

    local button = Instance.new("TextButton", frame)
    button.Position = UDim2.new(0.1, 0, 0.55, 0)
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Text = "Submit"
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    button.TextColor3 = Color3.new(1,1,1)
    button.BackgroundColor3 = Color3.fromRGB(70,130,180)

    local info = Instance.new("TextLabel", frame)
    info.Position = UDim2.new(0.1, 0, 0.8, 0)
    info.Size = UDim2.new(0.8, 0, 0, 30)
    info.Text = ""
    info.TextColor3 = Color3.fromRGB(255,255,255)
    info.Font = Enum.Font.Gotham
    info.TextSize = 14
    info.BackgroundTransparency = 1

    button.MouseButton1Click:Connect(function()
        if box.Text == correctKey then
            info.Text = "✅ Key accepted! Loading..."
            wait(1.2)
            gui:Destroy()
            loadMenu()
        else
            Player:Kick("❌ Wrong key! Ask the code from the developer.\nDiscord Server coming soon!")
        end
    end)
end

-- Menu After Key Accepted
function loadMenu()
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "DullClubMenu"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 450, 0, 300)
    frame.Position = UDim2.new(0.5, -225, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

    Instance.new("UICorner", frame)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "🎮 DullClub Menu"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24

    local categories = {"Update Log", "All Games", "Dandy's World"}

    for i, text in pairs(categories) do
        local btn = Instance.new("TextButton", frame)
        btn.Position = UDim2.new(0.1, 0, 0.2 + (i-1)*0.2, 0)
        btn.Size = UDim2.new(0.8, 0, 0, 40)
        btn.Text = text
        btn.Font = Enum.Font.Gotham
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)

        btn.MouseButton1Click:Connect(function()
            if text == "All Games" then
                -- Fly command example
                loadstring([[
                    local UIS = game:GetService("UserInputService")
                    local flying = false
                    local speed = 5
                    local player = game.Players.LocalPlayer
                    local char = player.Character or player.CharacterAdded:Wait()
                    local hrp = char:WaitForChild("HumanoidRootPart")

                    UIS.InputBegan:Connect(function(input)
                        if input.KeyCode == Enum.KeyCode.F then
                            flying = not flying
                            if flying then
                                local bv = Instance.new("BodyVelocity", hrp)
                                bv.Name = "FlyForce"
                                bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                                while flying and bv do
                                    bv.Velocity = Vector3.new(0, speed, 0)
                                    wait()
                                end
                                if bv then bv:Destroy() end
                            end
                        end
                    end)
                ]])()
            elseif text == "Update Log" then
                print("📢 Latest update: Fly, Anti Die, Fake Kick, GUI improvements.")
            elseif text == "Dandy's World" then
                print("🌟 Demo: Anti Die and Do All Tasks not yet active.")
            end
        end)
    end

    local close = Instance.new("TextButton", frame)
    close.Size = UDim2.new(0, 30, 0, 30)
    close.Position = UDim2.new(1, -35, 0, 5)
    close.Text = "X"
    close.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    close.TextColor3 = Color3.new(1,1,1)

    close.MouseButton1Click:Connect(function()
        if game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DullClub";
            Text = "Are you sure you want to close?";
            Duration = 3;
        }) then
            wait(3)
            gui:Destroy()
        end
    end)
end

-- Run GUI
createGUI()
