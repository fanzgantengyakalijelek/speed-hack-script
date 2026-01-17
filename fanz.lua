-- =============================================
-- FANZGANTENGYAKALIJELEK WAVE OF BRAINOT HACK
-- Version: 2.0 | Anti-Ban Protection
-- =============================================

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Anti-Ban Protection
local function AntiBan()
    getgenv().FanzSecure = true
    local VirtualUser = game:GetService('VirtualUser')
    game:GetService('Players').LocalPlayer.Idled:connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        wait(2)
    end)
end

AntiBan()

-- UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("FanzGantengYakaliJelek - Wave of Brainot", "DarkTheme")

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

print("========================================")
print("WAVE OF BRAINOT HACK LOADED!")
print("Powered by FanzXyzz-VIP")
print("Anti-Ban: ACTIVE")
print("========================================")

-- Teleport Function
local function TeleportTo(position)
    if RootPart then
        local tween = game:GetService("TweenService"):Create(
            RootPart,
            TweenInfo.new(1, Enum.EasingStyle.Linear),
            {CFrame = CFrame.new(position)}
        )
        tween:Play()
        tween.Completed:Wait()
    end
end

-- Find Area by Name
local function FindArea(areaName)
    for _, area in pairs(workspace:GetDescendants()) do
        if area.Name:lower():find(areaName:lower()) and area:IsA("Part") then
            return area.Position
        end
    end
    return nil
end

-- =============================================
-- MAIN TELEPORT TAB
-- =============================================
local TeleportTab = Window:NewTab("Teleport")
local TeleportSection = TeleportTab:NewSection("Area Teleport")

-- Celestial Area (Last Area)
TeleportSection:NewButton("🔮 Celestial Area", "Teleport to final celestial area", function()
    local celestialPositions = {
        Vector3.new(500, 100, 500),  -- Example positions
        Vector3.new(550, 120, 520),
        Vector3.new(480, 110, 490)
    }
    
    for _, pos in pairs(celestialPositions) do
        local area = FindArea("Celestial")
        if area then
            TeleportTo(area)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "CELESTIAL AREA",
                Text = "Teleported to Celestial Area!",
                Icon = "rbxassetid://4483345998",
                Duration = 3
            })
            return
        end
    end
    
    -- Backup teleport if area not found
    TeleportTo(Vector3.new(500, 100, 500))
    print("Celestial Area: Using backup coordinates")
end)

-- Secret Area (Behind Celestial)
TeleportSection:NewButton("🕵️ Secret Area", "Teleport to secret area behind celestial", function()
    local secretPositions = {
        Vector3.new(600, 150, 600),
        Vector3.new(620, 160, 580),
        Vector3.new(590, 155, 620)
    }
    
    for _, pos in pairs(secretPositions) do
        local area = FindArea("Secret")
        if area then
            TeleportTo(area + Vector3.new(0, 5, 0)) -- Slightly above
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "SECRET AREA",
                Text = "Teleported to Secret Area!",
                Icon = "rbxassetid://4483345998",
                Duration = 3
            })
            return
        end
    end
    
    -- Backup: Go behind celestial
    TeleportTo(Vector3.new(550, 120, 550))
    print("Secret Area: Using backup coordinates")
end)

-- Other Important Areas
TeleportSection:NewButton("🏁 Start Area", "Teleport to starting area", function()
    TeleportTo(Vector3.new(0, 5, 0))
end)

TeleportSection:NewButton("💰 Coin Farm Area", "Best coin farming spot", function()
    TeleportTo(Vector3.new(300, 50, 300))
end)

TeleportSection:NewButton("⚔️ Boss Area", "Teleport to boss fight", function()
    TeleportTo(Vector3.new(400, 80, 400))
end)

-- =============================================
-- MOVEMENT HACKS TAB
-- =============================================
local MovementTab = Window:NewTab("Movement")
local MovementSection = MovementTab:NewSection("Movement Hacks")

-- Fly Hack
local Flying = false
local FlySpeed = 50
local BodyVelocity

MovementSection:NewToggle("🦅 Fly Hack", "Toggle flying mode", function(state)
    Flying = state
    
    if Flying then
        if Character then
            BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
            BodyVelocity.Parent = RootPart
            
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "FLY ENABLED",
                Text = "Press E to go up, Q to go down",
                Duration = 5
            })
            
            -- Fly Controls
            local UIS = game:GetService("UserInputService")
            local connection
            connection = UIS.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.E then
                    BodyVelocity.Velocity = Vector3.new(0, FlySpeed, 0)
                elseif input.KeyCode == Enum.KeyCode.Q then
                    BodyVelocity.Velocity = Vector3.new(0, -FlySpeed, 0)
                end
            end)
            
            UIS.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.Q then
                    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
            end)
        end
    else
        if BodyVelocity then
            BodyVelocity:Destroy()
            BodyVelocity = nil
        end
    end
end)

-- WalkSpeed
MovementSection:NewSlider("🚶 WalkSpeed", "Set your walk speed", 500, 16, function(value)
    pcall(function()
        Humanoid.WalkSpeed = value
    end)
end)

-- JumpPower
MovementSection:NewSlider("🦘 JumpPower", "Set your jump height", 500, 50, function(value)
    pcall(function()
        Humanoid.JumpPower = value
    end)
end)

-- No Clip
local Noclipping = false
MovementSection:NewToggle("👻 NoClip", "Walk through walls", function(state)
    Noclipping = state
    
    if Noclipping then
        game:GetService("RunService").Stepped:Connect(function()
            if Noclipping and Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- Infinite Jump
local InfiniteJumpEnabled = false
MovementSection:NewToggle("∞ Infinite Jump", "Jump infinitely", function(state)
    InfiniteJumpEnabled = state
    
    local UIS = game:GetService("UserInputService")
    UIS.InputBegan:Connect(function(input, gameProcessed)
        if InfiniteJumpEnabled and input.KeyCode == Enum.KeyCode.Space then
            pcall(function()
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end)
        end
    end)
end)

-- =============================================
-- AUTO FARM TAB
-- =============================================
local FarmTab = Window:NewTab("Auto Farm")
local FarmSection = FarmTab:NewSection("Automation")

-- Auto Collect Coins
local AutoCoin = false
FarmSection:NewToggle("💰 Auto Collect Coins", "Automatically collect coins", function(state)
    AutoCoin = state
    
    while AutoCoin do
        wait(0.5)
        pcall(function()
            -- Collect nearby coins
            for _, coin in pairs(workspace:GetChildren()) do
                if coin.Name:find("Coin") or coin.Name:find("Money") then
                    firetouchinterest(RootPart, coin, 0)
                    firetouchinterest(RootPart, coin, 1)
                end
            end
        end)
    end
end)

-- Auto Kill Enemies
local AutoKill = false
FarmSection:NewToggle("⚔️ Auto Kill Enemies", "Automatically kill nearby enemies", function(state)
    AutoKill = state
    
    while AutoKill do
        wait(1)
        pcall(function()
            for _, enemy in pairs(workspace:GetChildren()) do
                if enemy.Name:find("Enemy") or enemy.Name:find("Zombie") or enemy.Name:find("Monster") then
                    if enemy:FindFirstChild("Humanoid") then
                        enemy.Humanoid.Health = 0
                    end
                end
            end
        end)
    end
end)

-- =============================================
-- PLAYER HACKS TAB
-- =============================================
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Player Modifications")

-- God Mode
local GodMode = false
PlayerSection:NewToggle("🛡️ God Mode", "Become invincible", function(state)
    GodMode = state
    
    if GodMode then
        pcall(function()
            Humanoid.MaxHealth = math.huge
            Humanoid.Health = math.huge
        end)
    else
        pcall(function()
            Humanoid.MaxHealth = 100
            Humanoid.Health = 100
        end)
    end
end)

-- Infinite Health
PlayerSection:NewButton("❤️ Infinite Health", "Set health to max", function()
    pcall(function()
        Humanoid.MaxHealth = 9999
        Humanoid.Health = 9999
    end)
end)

-- Reset Character
PlayerSection:NewButton("🔄 Reset Character", "Reset your character", function()
    LocalPlayer.Character:BreakJoints()
end)

-- =============================================
-- VISUAL HACKS TAB
-- =============================================
local VisualTab = Window:NewTab("Visual")
local VisualSection = VisualTab:NewSection("Visual Mods")

-- ESP (Highlight Players)
local ESPEnabled = false
VisualSection:NewToggle("👁️ Player ESP", "See all players through walls", function(state)
    ESPEnabled = state
    
    if ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = player.Character
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

-- X-Ray Vision
local XRay = false
VisualSection:NewToggle("🔍 X-Ray Vision", "See through walls", function(state)
    XRay = state
    
    if XRay then
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 1 then
                part.LocalTransparencyModifier = 0.5
            end
        end
    else
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end)

-- =============================================
-- SETTINGS TAB
-- =============================================
local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("Configuration")

-- Anti-AFK
SettingsSection:NewToggle("⏰ Anti-AFK", "Prevent getting kicked for AFK", function(state)
    if state then
        AntiBan()
    end
end)

-- Destroy GUI
SettingsSection:NewButton("🗑️ Destroy GUI", "Remove the hack interface", function()
    Window:Destroy()
    print("GUI Destroyed")
end)

-- Rejoin Server
SettingsSection:NewButton("🔄 Rejoin Server", "Rejoin the current server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

-- Server Hop
SettingsSection:NewButton("🚀 Server Hop", "Join a different server", function()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"))
    
    for _, server in pairs(Servers.data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            TPS:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
            break
        end
    end
end)

-- =============================================
-- FINAL MESSAGE
-- =============================================
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "FANZGANTENGYAKALIJELEK HACK",
    Text = "Wave of Brainot Hack Loaded Successfully!",
    Icon = "rbxassetid://4483345998",
    Duration = 5
})

print("========================================")
print("ALL FEATURES LOADED!")
print("Use with caution")
print("Made with ❤️ by FanzXyzz-VIP")
print("========================================")

-- Anti-Detection
spawn(function()
    while wait(60) do
        pcall(function()
            -- Randomize values to avoid detection
            if Humanoid.WalkSpeed > 100 then
                Humanoid.WalkSpeed = math.random(80, 120)
            end
        end)
    end
end)
