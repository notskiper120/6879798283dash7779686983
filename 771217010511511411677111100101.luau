local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local function safeCaption(text)
    pcall(function()
        local mainGame = game.Players.LocalPlayer.PlayerGui:WaitForChild("MainUI"):WaitForChild("Initiator"):WaitForChild("Main_Game")
        require(mainGame).caption(text, true)
    end)
end

task.wait(2)
safeCaption("U executed script")
task.wait(2)
safeCaption("Script by me(viet09544)")
task.wait(2)
safeCaption("The mode may buggy")
task.wait(2)
safeCaption("Have fun!")

-- Intro UI Effect
pcall(function()
    local playerGui = game.Players.LocalPlayer.PlayerGui
    local mainUI = playerGui:WaitForChild("MainUI")
    local initiator = mainUI:WaitForChild("Initiator")
    local shut = initiator:WaitForChild("Main_Game")

    local intro = shut:FindFirstChild("IntroText") or Instance.new("TextLabel") 
    intro.Visible = true
    intro.Text = "Th3 H0t3l"
    intro.TextTransparency = 0

    local underline = intro:FindFirstChild("Underline")
    if underline then
        local targetSize1 = UDim2.new(1.1, 0, 0.015, 6)
        TweenService:Create(underline, TweenInfo.new(3), {Size = targetSize1}):Play()
        task.wait(7)

        local targetSize2 = UDim2.new(0.95, 0, 0.015, 6)
        TweenService:Create(underline, TweenInfo.new(1.3), {Size = targetSize2}):Play()
        task.wait(1)

        TweenService:Create(underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
    end

    TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()

    if underline then
        TweenService:Create(underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
    end

    task.wait(2.3)
    intro.Visible = false
    task.wait(4)
end)

---==================================================
--- 1. ENTITY: SMILE
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(120)

        local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

        local Smile = Spawner.Create({
            Entity = {
                Name = "Smile",
                Asset = "rbxassetid://108764900572976",
                HeightOffset = 0
            },
            Movement = {
                Speed = 105,
                Delay = 2,
                Reversed = false
            },
            Damage = {
                Enabled = true,
                Range = 40,
                Amount = 125,
                IgnoreHiding = false
            },
            Rebounding = {
                Enabled = true,
                Type = "Ambush",
                Min = 4,
                Max = 7,
                Delay = 1.7
            },
            Lights = {
                Flicker = {
                    Enabled = true,
                    Duration = 1
                },
                Shatter = true,
                Repair = false
            },
            Earthquake = {
                Enabled = false
            },
            CameraShake = {
                Enabled = true,
                Values = {5, 25, 0.2, 3.2},
                Range = 100
            },
            Crucifixion = {
                Type = "Guiding",
                Enabled = true,
                Range = 40,
                Resist = false,
                Break = true
            },
            Death = {
                Type = "Guiding",
                Hints = {
                    "You died to the Smile...",
                    "It lurks in dark places and moves extremely fast.",
                    "Try hiding in a closet or breaking line of sight!"
                },
                Cause = "Smile"
            }
        })

        Smile:SetCallback("OnSpawned", function()
            print("Smile has spawned")
        end)

        Smile:SetCallback("OnStartMoving", function()
            print("Smile has started moving")
        end)

        Smile:SetCallback("OnEnterRoom", function(room: Model, firstTime: boolean)
            if firstTime == true then
                print("Smile has entered room: ".. room.Name.. " for the first time")
            else
                print("Smile has entered room: ".. room.Name.. " again")
            end
        end)

        Smile:SetCallback("OnLookAt", function(lineOfSight: boolean)
            if lineOfSight == true then
                print("Player is looking at Smile")
            else
                print("Player view is obstructed by something")
            end
        end)

        Smile:SetCallback("OnRebounding", function(startOfRebound: boolean)
            if startOfRebound == true then
                print("Smile has started rebounding")
            else
                print("Smile has finished rebounding")
            end
        end)

        Smile:SetCallback("OnDespawning", function()
            print("Smile is despawning")
        end)

        Smile:SetCallback("OnDespawned", function()
            print("Smile has despawned")
        end)

        Smile:SetCallback("OnDamagePlayer", function(newHealth: number)
            if newHealth <= 0 then
                print("Smile has killed the player")
            else
                print("Smile has damaged the player")
            end
        end)

        Smile:Run()
    end
end)()

---==================================================
--- 2. SCARY ENTITY
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(120)

        local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

        local originalAmbient = Lighting.Ambient
        local originalOutdoorAmbient = Lighting.OutdoorAmbient
        local originalClockTime = Lighting.ClockTime

        local defaultVolume = 5
        local spawnSound = Instance.new("Sound")
        spawnSound.Name = "ScarySpawnSound"
        spawnSound.SoundId = "rbxassetid://9114223297" 
        spawnSound.Volume = defaultVolume
        spawnSound.PlaybackSpeed = 0.5
        spawnSound.Parent = SoundService

        local function applyScarySky()
            if Lighting:FindFirstChild("ScarySky") then
                Lighting.ScarySky:Destroy()
            end

            local sky = Instance.new("Sky")
            sky.Name = "ScarySky"
            
            local skyId = "rbxassetid://13720474225"
            sky.SkyboxBk = skyId
            sky.SkyboxDn = skyId
            sky.SkyboxFt = skyId
            sky.SkyboxLf = skyId
            sky.SkyboxRt = skyId
            sky.SkyboxUp = skyId
            sky.Parent = Lighting

            Lighting.Ambient = Color3.fromRGB(40, 0, 0)
            Lighting.OutdoorAmbient = Color3.fromRGB(20, 0, 0)
            Lighting.ClockTime = 0
        end

        local function removeScarySky()
            if Lighting:FindFirstChild("ScarySky") then
                Lighting.ScarySky:Destroy()
            end
            Lighting.Ambient = originalAmbient
            Lighting.OutdoorAmbient = originalOutdoorAmbient
            Lighting.ClockTime = originalClockTime
        end

        local ScaryEntity = Spawner.Create({
            Entity = {
                Name = "Scary Entity",
                Asset = "rbxassetid://13124351651",
                HeightOffset = 0
            },
            Lights = {
                Flicker = {
                    Enabled = true,
                    Duration = 0
                },
                Shatter = true,
                Repair = false
            },
            Earthquake = {
                Enabled = true
            },
            CameraShake = {
                Enabled = true,
                Range = 100,
                Values = {1.5, 20, 0.1, 1}
            },
            Movement = {
                Speed = 100,
                Delay = 2,
                Reversed = false
            },
            Rebounding = {
                Enabled = true,
                Type = "Ambush",
                Min = 1,
                Max = 1,
                Delay = 2
            },
            Damage = {
                Enabled = true,
                IgnoreHiding = false,
                Range = 40,
                Amount = 125
            },
            Crucifixion = {
                Type = "Guiding",
                Enabled = true,
                Range = 40,
                Resist = false,
                Break = true
            },
            Death = {
                Type = "Curious",
                Hints = {"You died by Scary.... Thing", "Ground transit means it will arrive", "Hide", "Good luck next time"},
                Cause = "Scary Thing....?"
            }
        })

        ScaryEntity:SetCallback("OnSpawned", function()
            spawnSound.Volume = defaultVolume
            applyScarySky()
            spawnSound:Play()
            print("Scary Entity has spawned")
        end)

        ScaryEntity:SetCallback("OnStartMoving", function()
            print("Scary Entity has started moving")
        end)

        ScaryEntity:SetCallback("OnEnterRoom", function(room: Model, firstTime: boolean)
            if firstTime == true then
                print("Scary Entity has entered room: ".. room.Name.. " for the first time")
            else
                print("Scary Entity has entered room: ".. room.Name.. " again")
            end
        end)

        ScaryEntity:SetCallback("OnLookAt", function(lineOfSight: boolean)
            if lineOfSight == true then
                print("Player is looking at Scary Entity")
            else
                print("Player view is obstructed by something")
            end
        end)

        ScaryEntity:SetCallback("OnRebounding", function(startOfRebound: boolean)
            if startOfRebound == true then
                spawnSound.Volume = defaultVolume
                if not spawnSound.IsPlaying then
                    spawnSound:Play()
                end
                print("Scary Entity has started rebounding")
            else
                print("Scary Entity has finished rebounding")
            end
        end)

        ScaryEntity:SetCallback("OnDespawning", function()
            print("ScaryEntity is despawning")
        end)

        ScaryEntity:SetCallback("OnDespawned", function()
            -- Fade out sound volume to 0 over 2 seconds
            local fadeTween = TweenService:Create(
                spawnSound, 
                TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), 
                {Volume = 0}
            )
            
            fadeTween:Play()
            
            task.delay(2, function()
                spawnSound:Stop()
                spawnSound.Volume = defaultVolume
            end)

            removeScarySky()
            print("Scary Entity has despawned")
        end)

        ScaryEntity:SetCallback("OnDamagePlayer", function(newHealth: number)
            if newHealth <= 0 then
                print("Scary Entity has killed the player")
            else
                print("Scary Entity has damaged the player")
            end
        end)

        ScaryEntity:Run()
    end
end)()