local Players=game:GetService("Players")
local Player=Players.LocalPlayer
local correctKey="MinihodariDeveloper"

local function createKeyGUI()
    local gui=Instance.new("ScreenGui",game.CoreGui)
    gui.Name="DullClubKey"
    local frame=Instance.new("Frame",gui)
    frame.Size=UDim2.new(0,400,0,220)
    frame.Position=UDim2.new(0.5,-200,0.5,-110)
    frame.BackgroundColor3=Color3.fromRGB(30,30,30)
    Instance.new("UICorner",frame)
    
    local title=Instance.new("TextLabel",frame)
    title.Size=UDim2.new(1,0,0,40)
    title.Text="🔑 Enter Access Key"
    title.TextColor3=Color3.new(1,1,1)
    title.BackgroundTransparency=1
    title.Font=Enum.Font.GothamBold
    title.TextSize=22
    
    local box=Instance.new("TextBox",frame)
    box.Size=UDim2.new(0.8,0,0,40)
    box.Position=UDim2.new(0.1,0,0.3,0)
    box.PlaceholderText="Enter key here..."
    box.TextColor3=Color3.new(1,1,1)
    box.BackgroundColor3=Color3.fromRGB(40,40,40)
    box.Font=Enum.Font.Gotham
    box.TextSize=18
    
    local button=Instance.new("TextButton",frame)
    button.Size=UDim2.new(0.8,0,0,40)
    button.Position=UDim2.new(0.1,0,0.55,0)
    button.Text="Submit"
    button.Font=Enum.Font.GothamBold
    button.TextSize=20
    button.BackgroundColor3=Color3.fromRGB(70,130,180)
    button.TextColor3=Color3.new(1,1,1)
    
    local info=Instance.new("TextLabel",frame)
    info.Size=UDim2.new(0.8,0,0,30)
    info.Position=UDim2.new(0.1,0,0.8,0)
    info.Text=""
    info.TextColor3=Color3.new(1,1,1)
    info.BackgroundTransparency=1
    info.Font=Enum.Font.Gotham
    info.TextSize=14
    
    button.MouseButton1Click:Connect(function()
        local inputKey = box.Text:lower():gsub("%s+","")
        if inputKey == correctKey:lower() then
            info.Text = "✅ Key accepted! Loading menu..."
            wait(1)
            gui:Destroy()
            loadMenu()
        else
            Player:Kick("❌ Wrong key! Ask developer for access.\nDiscord coming soon!")
        end
    end)
end

function loadMenu()
    local gui=Instance.new("ScreenGui",game.CoreGui)
    gui.Name="DullClubMenu"
    local frame=Instance.new("Frame",gui)
    frame.Size=UDim2.new(0,400,0,260)
    frame.Position=UDim2.new(0.5,-200,0.5,-130)
    frame.BackgroundColor3=Color3.fromRGB(25,25,25)
    Instance.new("UICorner",frame)
    
    local title=Instance.new("TextLabel",frame)
    title.Size=UDim2.new(1,0,0,40)
    title.Text="🎮 DullClub Menu"
    title.TextColor3=Color3.new(1,1,1)
    title.BackgroundTransparency=1
    title.Font=Enum.Font.GothamBold
    title.TextSize=24
    
    local btnFly=Instance.new("TextButton",frame)
    btnFly.Size=UDim2.new(0.8,0,0,40)
    btnFly.Position=UDim2.new(0.1,0,0.3,0)
    btnFly.Text="Fly (Press F to toggle)"
    btnFly.Font=Enum.Font.Gotham
    btnFly.TextColor3=Color3.new(1,1,1)
    btnFly.BackgroundColor3=Color3.fromRGB(40,40,40)
    
    local btnFakeLag=Instance.new("TextButton",frame)
    btnFakeLag.Size=UDim2.new(0.8,0,0,40)
    btnFakeLag.Position=UDim2.new(0.1,0,0.55,0)
    btnFakeLag.Text="Fake Lag"
    btnFakeLag.Font=Enum.Font.Gotham
    btnFakeLag.TextColor3=Color3.new(1,1,1)
    btnFakeLag.BackgroundColor3=Color3.fromRGB(40,40,40)
    
    local closeBtn=Instance.new("TextButton",frame)
    closeBtn.Size=UDim2.new(0,30,0,30)
    closeBtn.Position=UDim2.new(1,-35,0,5)
    closeBtn.Text="X"
    closeBtn.TextColor3=Color3.new(1,1,1)
    closeBtn.BackgroundColor3=Color3.fromRGB(170,0,0)
    
    local flying = false
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local UIS = game:GetService("UserInputService")
    local bv
    
    btnFly.MouseButton1Click:Connect(function()
        flying = not flying
        if flying then
            bv = Instance.new("BodyVelocity", hrp)
            bv.MaxForce = Vector3.new(1e5,1e5,1e5)
            bv.Velocity = Vector3.new(0,0,0)
            while flying do
                local moveDir = Vector3.new(0,0,0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + hrp.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - hrp.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - hrp.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + hrp.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0,1,0) end
                bv.Velocity = moveDir.Unit * 50
                wait()
                if not flying then break end
            end
            if bv then bv:Destroy() end
        else
            if bv then bv:Destroy() end
        end
    end)
    
    btnFakeLag.MouseButton1Click:Connect(function()
        for i=1,5 do
            wait(0.5)
            print("Fake lagging...")
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        local confirm = Instance.new("ScreenGui",game.CoreGui)
        local confFrame = Instance.new("Frame",confirm)
        confFrame.Size=UDim2.new(0,300,0,150)
        confFrame.Position=UDim2.new(0.5,-150,0.5,-75)
        confFrame.BackgroundColor3=Color3.fromRGB(30,30,30)
        Instance.new("UICorner",confFrame)
        
        local text = Instance.new("TextLabel",confFrame)
        text.Text = "Are you sure you want to close?"
        text.Size = UDim2.new(1,0,0,50)
        text.Position = UDim2.new(0,0,0,20)
        text.TextColor3 = Color3.new(1,1,1)
        text.BackgroundTransparency = 1
        text.Font = Enum.Font.GothamBold
        text.TextSize = 18
        
        local yesBtn = Instance.new("TextButton",confFrame)
        yesBtn.Size = UDim2.new(0.4,0,0,40)
        yesBtn.Position = UDim2.new(0.1,0,0.7,0)
        yesBtn.Text = "Yes"
        yesBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
        yesBtn.TextColor3 = Color3.new(1,1,1)
        
        local noBtn = Instance.new("TextButton",confFrame)
        noBtn.Size = UDim2.new(0.4,0,0,40)
        noBtn.Position = UDim2.new(0.5,0,0.7,0)
        noBtn.Text = "No"
        noBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
        noBtn.TextColor3 = Color3.new(1,1,1)
        
        yesBtn.MouseButton1Click:Connect(function()
            gui:Destroy()
            confirm:Destroy()
        end)
        noBtn.MouseButton1Click:Connect(function()
            confirm:Destroy()
        end)
    end)
end

createKeyGUI()
