-- 🔹 Carregando a Redz Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wx-sources/LibraryBrancoAZuL/refs/heads/main/Redzhubui%20(1).txt",true))()
workspace.FallenPartsDestroyHeight = -math.huge
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 🔹 Criando a Janela Principal
local Window = Library:MakeWindow({
    Title = "🔱 Zynora Hub V2 🔱 | Brookhaven RP 🏡",
    SubTitle = "           Made by WxDeveloper x Jaozin777",
    LoadText = "Carregando Zyn Hub...",
    Flags = "Zynora_h_Hub"
})

-- 🔹 Botão de minimizar
Window:AddMinimizeButton({
    Button = { Image = "0", BackgroundTransparency = 1 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

-- =========================================================
-- 🔹 ABAS TESTE (7 abas)
-- =========================================================
local InfoTab = Window:MakeTab({ "Info", "info" })



InfoTab:AddSection({ "Informations" })



InfoTab:AddSection({ "Credits" })

InfoTab:AddParagraph({ "Programmer:", "WxDeveloper \n Jaozin777" })

InfoTab:AddParagraph({ "Team:", "Zynora V2 Hub Community" })


InfoTab:AddSection({ "Internet Things" })

InfoTab:AddDiscordInvite({

    Name = "Zynora Hub Community",

    Description = "Discord Zynora V2",

    Logo = "rbxassetid://0",

    Invite = "https://discord.gg/PwXfb96EHR",

})






InfoTab:AddSection({ "Information" })

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local Stats = game:GetService("Stats")

local UserInputService = game:GetService("UserInputService")

local LocalizationService = game:GetService("LocalizationService")

local player = Players.LocalPlayer



local function getStatValue(parent, name)

    if parent then

        local obj = parent:FindFirstChild(name)

        if obj and obj.GetValue then

            local success, value = pcall(function() return obj:GetValue() end)

            if success then

                return math.floor(value)

            end

        end

    end

    return "Unidentified"

end



local info = {}



info["You Username:"] = player.Name or "Unidentified"

info["You Display Name:"] = player.DisplayName or "Unidentified"

info["You User Id:"] = player.UserId or "Unidentified"

info["You Account Age:"] = player.AccountAge or "Unidentified"



local netStats = Stats:FindFirstChild("Network")

local serverStats = netStats and netStats:FindFirstChild("ServerStatsItem")

info["You Ping:"] = (serverStats and getStatValue(serverStats, "Data Ping") .. " ms") or "Unidentified"



if identifyexecutor then

    local success, name, version = pcall(function() return identifyexecutor() end)

    info["You Executor:"] = success and (name .. (version and (" v" .. version) or "")) or "Unidentified"

else

    info["You Executor:"] = "Unidentified"

end







InfoTab:AddSection({ "Warns" })



InfoTab:AddSection({ "Others" })

InfoTab:AddButton({

    Name = "Rejoin",

    Callback = function()

        local TeleportService = game:GetService("TeleportService")

        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)

    end

})

local FunTab = Window:MakeTab({
    Title = "Fun",
    Icon = "rbxassetid://6023426926"
})

local InfiniteJumpEnabled = false
local UltimateNoclip = { Enabled = false, Connections = {}, SoccerBalls = {} }
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local tcs = game:GetService("TextChatService")

-- Sliders
FunTab:AddSlider({
    Name = "Speed Player",
    Increase = 1,
    MinValue = 16,
    MaxValue = 888,
    Default = 16,
    Callback = function(Value)
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = Value end
    end
})

FunTab:AddSlider({
    Name = "Jumppower",
    Increase = 1,
    MinValue = 50,
    MaxValue = 500,
    Default = 50,
    Callback = function(Value)
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.JumpPower = Value end
    end
})

FunTab:AddSlider({
    Name = "Gravity",
    Increase = 1,
    MinValue = 0,
    MaxValue = 10000,
    Default = 196.2,
    Callback = function(Value)
        game.Workspace.Gravity = Value
    end
})

-- Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

FunTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end
})

-- Reset button
FunTab:AddButton({
    Name = "Reset Speed/Gravity/Jumppower ✅",
    Callback = function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
        game.Workspace.Gravity = 196.2
        InfiniteJumpEnabled = false
    end
})

-- Ultimate Noclip
local function managePlayerCollisions(character)
    if not character then return end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not UltimateNoclip.Enabled
            part.Anchored = false
        end
    end
end

local function voidProtection(rootPart)
    if rootPart.Position.Y < -500 then
        rootPart.CFrame = CFrame.new(0, 100, 0)
    end
end

local function manageSoccerBalls()
    local soccerFolder = workspace:FindFirstChild("Com", true) and workspace.Com:FindFirstChild("001_SoccerBalls")
    if soccerFolder then
        for _, ball in ipairs(soccerFolder:GetChildren()) do
            if ball.Name:match("^Soccer") then
                pcall(function()
                    ball.CanCollide = not UltimateNoclip.Enabled
                    ball.Anchored = UltimateNoclip.Enabled
                end)
                UltimateNoclip.SoccerBalls[ball] = true
            end
        end
    end
end

local function mainLoop()
    UltimateNoclip.Connections.Heartbeat = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char then
            managePlayerCollisions(char)
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then voidProtection(hrp) end
        end
        if tick() % 2 < 0.1 then manageSoccerBalls() end
    end)
end

local NoclipToggle = FunTab:AddToggle({
    Name = "Ultimate Noclip",
    Description = "Noclip + Controle de bolas integrado",
    Default = false
})
NoclipToggle:Callback(function(state)
    UltimateNoclip.Enabled = state
    if state then
        mainLoop()
        manageSoccerBalls()
        UltimateNoclip.Connections.CharAdded = LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.5)
            managePlayerCollisions(LocalPlayer.Character)
        end)
    else
        for _, conn in pairs(UltimateNoclip.Connections) do
            pcall(function() conn:Disconnect() end)
        end
        if LocalPlayer.Character then managePlayerCollisions(LocalPlayer.Character) end
        for ball in pairs(UltimateNoclip.SoccerBalls) do
            if ball.Parent then pcall(function()
                ball.CanCollide = true
                ball.Anchored = false
            end) end
        end
    end
end)

-- Fly Universal Button
FunTab:AddButton({
    Name = "Ativar Fly GUI",
    Description = "Carrega um GUI de fly universal",
    Callback = function()
        local success, _ = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-gui-v3-30439"))()
        end)
        game.StarterGui:SetCore("SendNotification", {
            Title = success and "Sucesso" or "Erro",
            Text = success and "Fly GUI carregado!" or "Falha ao carregar o Fly GUI.",
            Duration = 5
        })
    end
})

-- CHAT FUNÇÕES
local TextSave
local chat = tcs.ChatInputBarConfiguration and tcs.ChatInputBarConfiguration.TargetTextChannel

local Section = FunTab:AddSection({
    Name = "Chat"
})

function sendchat(msg)
    if not msg or msg == "" then return end
    if tcs.ChatVersion == Enum.ChatVersion.LegacyChatService then
        pcall(function()
            game:GetService("ReplicatedStorage")
                :FindFirstChild("DefaultChatSystemChatEvents")
                .SayMessageRequest:FireServer(msg, "All")
        end)
    elseif chat then
        pcall(function()
            chat:SendAsync(msg)
        end)
    end
end

FunTab:AddTextBox({
    Name = "Enter Text",
    PlaceholderText = "Uh... Hi!",
    Callback = function(text)
        TextSave = text
    end
})

FunTab:AddButton({
    Name = "Send Chat",
    Callback = function()
        sendchat(TextSave)
    end
})

getgenv().ChaosHubEnviarDelay = 1
FunTab:AddSlider({
    Name = "Delay Spam",
    Min = 0.4,
    Max = 10,
    Default = 1,
    Increment = 0.1,
    Callback = function(Value)
        getgenv().ChaosHubEnviarDelay = Value
    end
})

FunTab:AddToggle({
    Name = "Spam Chat",
    Default = false,
    Flag = "SpamXhati",
    Callback = function(Value)
        getgenv().ChaosHubSpawnText = Value
        while getgenv().ChaosHubSpawnText do
            sendchat(TextSave)
            task.wait(getgenv().ChaosHubEnviarDelay)
        end
    end
})

FunTab:AddButton({
    Name = "Spam Chat - Hacked by S4turn Hub",
    Callback = function()
        if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
            tcs.TextChannels.RBXGeneral:SendAsync("System: Hacked by S4turn Hub")
        end
    end
})

FunTab:AddButton({
    Name = "Clear Chat",
    Callback = function()
        if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
            tcs.TextChannels.RBXGeneral:SendAsync("Server: Chat Cleared")
        end
    end
})


local HalloweenTab = Window:MakeTab({
    Title = "Halloween",
    Icon = "Gift"
})

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Teleporte antes de pegar doces
local TELEPORT_POSITION = Vector3.new(223.67, 3.40, -163.13)
local TELEPORT_YAW = 109.28 -- grau que o personagem vai olhar

-- Lista de categorias de doces e remotes
local candyLists = {
    {name="Baby", folderName="EggHunt_Baby1", prefix="BABY_CandyCorn_", min=1, max=10, remoteName="Baby1"},
    {name="Easy", folderName="EggHunt_Easy1", prefix="EASY_CandyCorn_", min=1, max=15, remoteName="Easy1"},
    {name="Medium", folderName="EggHunt_Medium1", prefix="NORMAL_CandyCorn_", min=1, max=20, remoteName="Medium1"},
    {name="Hard", folderName="EggHunt_Hard1", prefix="HARD_CandyCorn_", min=1, max=25, remoteName="Hard1"},
    {name="Extreme", folderName="EggHunt_Extreme1", prefix="EXTREME_CandyCorn_", min=1, max=30, remoteName="Extreme1"},
}

-- Função de movimento suave
local function moveToPosition(position, time)
    local tweenInfo = TweenInfo.new(time or 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local goal = {CFrame = CFrame.new(position)}
    local tween = TweenService:Create(rootPart, tweenInfo, goal)
    tween:Play()
    tween.Completed:Wait()
end

-- Executa remotes da categoria
local function executeRemotes(remoteName)
    local changeDifficultyRemote = ReplicatedStorage.Remotes.ChangeDifficulty
    local requestEggsRemote = ReplicatedStorage.Remotes.RequestEggs

    -- Teleporta e ajusta orientação
    rootPart.CFrame = CFrame.new(TELEPORT_POSITION) * CFrame.Angles(0, math.rad(TELEPORT_YAW), 0)
    task.wait(0.1)

    local args = {[1] = remoteName}
    pcall(function()
        changeDifficultyRemote:FireServer(unpack(args))
        requestEggsRemote:InvokeServer(unpack(args))
    end)
end

-- Função que coleta automaticamente todos os doces de uma categoria
local function autoCollectCandies(list)
    -- Executa remotes antes de pegar os doces
    task.spawn(function()
        executeRemotes(list.remoteName)
    end)

    task.wait(0.1) -- pequeno delay
    local folder = workspace:FindFirstChild(list.folderName)
    if folder and folder:IsA("Folder") then
        for i = list.min, list.max do
            local candy = folder:FindFirstChild(list.prefix .. i)
            if candy and candy:IsA("BasePart") then
                moveToPosition(candy.Position, 5)
            end
        end
    else
        warn("Pasta não encontrada: " .. list.folderName)
    end
end

-- Cria seção principal de botões
HalloweenTab:AddSection({Name="Categorias"})

for _, list in ipairs(candyLists) do
    HalloweenTab:AddButton({
        Name = list.name,
        Callback = function()
            autoCollectCandies(list)
        end
    })
end

local Tab = Window:MakeTab({"Música All", "music"})



Tab:AddSection({"Música All //"})



Tab:AddParagraph({"Warn", "Everyone on the servers can hear the sound"})



local audios = {

    {Name = "Yamete Kudasai", ID = 108494476595033},

    {Name = "Gritinho", ID = 5710016194},

    {Name = "Jumpscare Horroroso", ID = 85435253347146},

    {Name = "Áudio Alto", ID = 6855150757},

    {Name = "Ruído", ID = 120034877160791},

    {Name = "Jumpscare 2", ID = 110637995610528},

    {Name = "Risada Da Bruxa Minecraft", ID = 116214940486087},

    {Name = "The Boiled One", ID = 137177653817621},

    {Name = "Deitei Um Ave Maria Doido", ID = 128669424001766},

    {Name = "Mandrake Detected", ID = 9068077052},

    {Name = "Aaaaaaaaa", ID = 80156405968805},

    {Name = "AAAHHHH", ID = 9084006093},

    {Name = "amongus", ID = 6651571134},

    {Name = "Sus", ID = 6701126635},

    {Name = "Gritao AAAAAAAAA", ID = 5853668794},

    {Name = "UHHHHH COFFCOFF", ID = 7056720271},

    {Name = "SUS", ID = 7153419575},

    {Name = "Sonic.exe", ID = 2496367477},

    {Name = "Tubers93 1", ID = 270145703},

    {Name = "Tubers93 2", ID = 18131809532},

    {Name = "John's Laugh", ID = 130759239},

    {Name = "Nao sei KKKK", ID = 6549021381},

    {Name = "Grito", ID = 80156405968805},

    {Name = "audio estranho", ID = 7705506391},

    {Name = "AAAH", ID = 7772283448},

    {Name = "Gay, gay", ID = 18786647417},

    {Name = "Bat Hit", ID = 7129073354},

    {Name = "Nuclear Siren", ID = 675587093},

    {Name = "Sem ideia de nome KK", ID = 7520729342},

    {Name = "Grito 2", ID = 91412024101709},

    {Name = "Estora tímpano", ID = 268116333},

    --{Name = "[ Content Deleted ]", ID = 106835463235574},

    {Name = "Toma Jack", ID = 132603645477541},

    {Name = "Pede ifood pede", ID = 133843750864059},

    {Name = "I Ghost The down", ID = 84663543883498},

    {Name = "Compre OnLine Na shoope", ID = 8747441609},

    {Name = "Meu nome é ???", ID = 7339658122},

    {Name = "FAZ O L!!!!", ID = 94350012510206},

    {Name = "Uh Que Nojo", ID = 103440368630269},

    {Name = "Sai dai Lava Prato", ID = 101232400175829},

    {Name = "Seloko num compensa", ID = 78442476709262},

    --{Name = "Chimpanzini Bananini Funk", ID = 137148228908678},

    --{Name = "Candyland Tobu", ID = 118939739460633},

    {Name = "Meme do Dom pollo What the hell", ID = 100656590080703},

    {Name = "Não to entendendo nada Estourado", ID = 7962533987},

    {Name = "Cachorro Rindo", ID = 8449305114},

}



local selectedAudioID



Tab:AddTextBox({

    Name = "Enter Sound ID",

    PlaceholderText = "Type Here...",

    Callback = function(value)

        selectedAudioID = tonumber(value)

    end

})



local audioNames = {}

for _, audio in ipairs(audios) do

    table.insert(audioNames, audio.Name)

end



Tab:AddDropdown({

    Name = "Select Sound",

    Description = "Choose an audio from the list",

    Options = audioNames,

    Default = audioNames[1],

    Flag = "selected_audio",

    Callback = function(value)

        for _, audio in ipairs(audios) do

            if audio.Name == value then

                selectedAudioID = audio.ID

                break

            end

        end

    end

})



local audioLoop = false



Tab:AddSection({"Loop Sound"})



local function playLoopedAudio()

    while audioLoop do

        if selectedAudioID then

            local args = {

                [1] = game:GetService("Workspace"),

                [2] = selectedAudioID,

                [3] = 1,

            }

            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))



            local sound = Instance.new("Sound")

            sound.SoundId = "rbxassetid://" .. selectedAudioID

            sound.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

            sound:Play()

        else

        end



        task.wait(0.5) 

    end

end



Tab:AddToggle({

    Name = "Loop Play Sound",

    Default = false,

    Flag = "audio_loop",

    Callback = function(value)

        audioLoop = value

        if audioLoop then

            task.spawn(playLoopedAudio) 

        end

    end

})



local function playAudio()

    if selectedAudioID then

        local args = {

            [1] = game:GetService("Workspace"),

            [2] = selectedAudioID,

            [3] = 1,

        }

        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))



        local sound = Instance.new("Sound")

        sound.SoundId = "rbxassetid://" .. selectedAudioID

        sound.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

        sound:Play()

    else

    end

end



Tab:AddButton({"Play Sound", function()

    playAudio()

end})



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local audioID = 6314880174



local function Audio_All_ClientSide(ID)

    local function CheckFolderAudioAll()

        local FolderAudio = workspace:FindFirstChild("Audio all client")

        if not FolderAudio then

            FolderAudio = Instance.new("Folder")

            FolderAudio.Name = "Audio all client"

            FolderAudio.Parent = workspace

        end

        return FolderAudio

    end



    local function CreateSound(ID)

        if type(ID) ~= "number" then

            return nil

        end



        local Folder_Audio = CheckFolderAudioAll()

        if Folder_Audio then

            local Sound = Instance.new("Sound")

            Sound.SoundId = "rbxassetid://" .. ID

            Sound.Volume = 1

            Sound.Looped = false

            Sound.Parent = Folder_Audio

            Sound:Play()

            task.wait(1) 

            Sound:Destroy()

        end

    end



    CreateSound(ID)

end



local function Audio_All_ServerSide(ID)

    if type(ID) ~= "number" then

        return nil

    end



    local GunSoundEvent = ReplicatedStorage:FindFirstChild("1Gu1nSound1s", true)

    if GunSoundEvent then

        GunSoundEvent:FireServer(workspace, ID, 1)

    end

end



Tab:AddToggle({

    Name = "Blow everyone's ears... lol...",

    Description = "Play burst audio repeatedly for everyone",

    Default = false,

    Flag = "audio_spam",

    Callback = function(value)

        getgenv().Audio_All_loop_fast = value



        while getgenv().Audio_All_loop_fast do

            Audio_All_ServerSide(audioID)

            task.spawn(function()

                Audio_All_ClientSide(audioID)

            end)

            task.wait(0.03) 

        end

    end

})

local ShadersTab = Window:MakeTab({ "Shaders", "server" })



ShadersTab:AddSection({ "Shaders" })



ShadersTab:AddSection({ "Type 1 // " })

ShadersTab:AddButton({

Name = "Ativa Shaders (Irreversível)",

Callback = function()

local workspace = game:GetService("Workspace")

local Lighting = game:GetService("Lighting")

local RunService = game:GetService("RunService")

local Debris = game:GetService("Debris")

local TweenService = game:GetService("TweenService")

local SoundService = game:GetService("SoundService")

local Players = game:GetService("Players")

local player = Players.LocalPlayer

local model = workspace:FindFirstChild("Model")



if model then

    local function setMat(obj)

        for _, c in pairs(obj:GetChildren()) do

            if c:IsA("BasePart") then

                c.Material = Enum.Material.Basalt

            elseif c:IsA("Model") or c:IsA("Folder") then

                setMat(c)

            end

        end

    end

    if model:FindFirstChild("001_SnowStreet") then

        setMat(model["001_SnowStreet"])

    end

    if model:FindFirstChild("Street") then

        for _, o in pairs(model.Street:GetDescendants()) do

            if o:IsA("BasePart") then

                o.Material = Enum.Material.Basalt

            end

        end

    end

    for _, o in pairs(model:GetChildren()) do

        if o:IsA("BasePart") and (o.Name == "Sidewalk" or o.Name == "Wedge") and o.Material == Enum.Material.SmoothPlastic then

            o.Material = Enum.Material.Cobblestone

        end

    end

    model.ChildAdded:Connect(function(obj)

        if obj:IsA("BasePart") and (obj.Name == "Sidewalk" or obj.Name == "Wedge") and obj.Material == Enum.Material.SmoothPlastic then

            obj.Material = Enum.Material.Cobblestone

        end

    end)

end



local soundPart = Instance.new("Part")

soundPart.Size = Vector3.new(1,1,1)

soundPart.Transparency = 1

soundPart.Anchored = true

soundPart.CanCollide = false

soundPart.Parent = workspace

local character = player.Character or player.CharacterAdded:Wait()

local hrp = character:WaitForChild("HumanoidRootPart")



local birdSound = Instance.new("Sound")

birdSound.Name = "BirdsSound"

birdSound.SoundId = "rbxassetid://1237969272"

birdSound.Looped = true

birdSound.Volume = 0.05

birdSound.Parent = soundPart



local wolfSound = Instance.new("Sound")

wolfSound.SoundId = "rbxassetid://6654360741"

wolfSound.Volume = 0.05

wolfSound.Looped = false

wolfSound.Parent = workspace



RunService.Heartbeat:Connect(function()

    if hrp and hrp.Parent then

        soundPart.Position = hrp.Position + Vector3.new(0,10,0)

    end

end)



local function isNight()

    local t = Lighting.ClockTime

    return (t >= 18 or t <= 6)

end



task.spawn(function()

    while true do

        if isNight() then

            if birdSound.IsPlaying then birdSound:Stop() end

            if wolfSound.IsPlaying then wolfSound:Stop() end

            wolfSound:Play()

        else

            if wolfSound.IsPlaying then wolfSound:Stop() end

            if not birdSound.IsPlaying then birdSound:Play() end

        end

        wait(20)

    end

end)



local fountainPart = Instance.new("Part")

fountainPart.Anchored = true

fountainPart.CanCollide = false

fountainPart.Transparency = 1

fountainPart.Size = Vector3.new(1,1,1)

fountainPart.Position = Vector3.new(-27,19,15)

fountainPart.Parent = workspace



local attachment = Instance.new("Attachment")

attachment.Position = Vector3.new(-27,19,15)

attachment.Parent = fountainPart



local fountainSound = Instance.new("Sound")

fountainSound.Name = "FountainSound"

fountainSound.SoundId = "rbxassetid://4766793559"

fountainSound.Looped = true

fountainSound.Volume = 0.03

fountainSound.EmitterSize = 10

fountainSound.RollOffMode = Enum.RollOffMode.Linear

fountainSound.MaxDistance = 100

fountainSound.Parent = attachment

fountainSound:Play()



local customSound = Instance.new("Sound")

customSound.Name = "MyCustomSound"

customSound.SoundId = "rbxassetid://9048659736"

customSound.Volume = 0.01

customSound.Looped = true

customSound.PlayOnRemove = false

customSound.Parent = workspace

customSound:Play()



local active = false

local stars = {}

local shootingStarsFolder = Instance.new("Folder",workspace)

shootingStarsFolder.Name = "ShootingStars"

local STAR_COUNT = 300

local SHOOTING_STAR_CHANCE = 0.3

local SHOOTING_STAR_MAX = 12

local shootingStarCooldown = 0.1



local spaceSound = Instance.new("Sound",workspace)

spaceSound.SoundId = "rbxassetid://1843520836"

spaceSound.Volume = 0.3

spaceSound.Looped = true

spaceSound.Name = "SpaceAmbience"



local function createStar()

    local star = Instance.new("Part")

    local size = math.random(1,3)*0.5

    star.Size = Vector3.new(size,size,size)

    star.Position = Vector3.new(math.random(-1000,1000),math.random(300,700),math.random(-1000,1000))

    star.Anchored = true

    star.CanCollide = false

    star.Material = Enum.Material.Neon

    local colors = {Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,180),Color3.fromRGB(180,200,255)}

    star.Color = colors[math.random(1,#colors)]

    star.Name = "Star"

    star.Parent = workspace

    local light = Instance.new("PointLight",star)

    light.Brightness = 2 + math.random()*1.5

    light.Range = 12

    spawn(function()

        while star.Parent and active do

            star.Transparency = 0.2 + math.sin(tick()*math.random(2,5))*0.2

            RunService.Heartbeat:Wait()

        end

        if star.Parent then star:Destroy() end

    end)

    table.insert(stars,star)

end



local function createShootingStar()

    if not active then return end

    local startPos = Vector3.new(math.random(-1000,1000),math.random(350,600),math.random(-1000,1000))

    local dir = Vector3.new(math.random(-1,1),math.random(-0.1,0.1),math.random(-1,1)).Unit

    local speed = math.random(350,550)

    local isFire = math.random() <= SHOOTING_STAR_CHANCE

    local color = isFire and Color3.fromRGB(255,50,50) or Color3.fromRGB(255,255,220)

    local trailColor = isFire and ColorSequence.new(Color3.fromRGB(255,120,0),Color3.fromRGB(255,230,50)) or ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,180))

    local star = Instance.new("Part")

    star.Size = Vector3.new(0.5,0.5,3)

    star.Position = startPos

    star.Anchored = true

    star.CanCollide = false

    star.Material = Enum.Material.Neon

    star.Color = color

    star.Name = "ShootingStar"

    star.Parent = shootingStarsFolder

    local att0 = Instance.new("Attachment",star)

    local att1 = Instance.new("Attachment",star)

    att1.Position = Vector3.new(0,0,-3)

    local trail = Instance.new("Trail",star)

    trail.Attachment0 = att0

    trail.Attachment1 = att1

    trail.Lifetime = 0.35

    trail.Color = trailColor

    trail.LightEmission = 1

    trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)})

    local light = Instance.new("PointLight",star)

    light.Brightness = isFire and 12 or 7

    light.Range = 35

    light.Color = color

    if isFire then

        local fire = Instance.new("Fire",star)

        fire.Heat = 15

        fire.Size = 3.5

        fire.Color = Color3.fromRGB(255,110,0)

        fire.SecondaryColor = Color3.fromRGB(255,210,0)

    end

    local lifetime = math.random(1,1.5)

    local timePassed = 0

    local moveConn

    moveConn = RunService.Heartbeat:Connect(function(dt)

        if not active then moveConn:Disconnect() if star.Parent then star:Destroy() end return end

        timePassed += dt

        if timePassed >= lifetime then moveConn:Disconnect() if star.Parent then star:Destroy() end return end

        local curve = math.sin(timePassed*20)*0.5

        star.Position += (dir+Vector3.new(0,curve,0)).Unit*speed*dt

    end)

    Debris:AddItem(star,4)

end



local function updateSky()

    local hour = Lighting.ClockTime

    local shouldBeActive = hour >= 18 or hour < 6

    if shouldBeActive and not active then

        active = true

        Lighting.FogColor = Color3.fromRGB(10,10,30)

        Lighting.FogEnd = 5000

        Lighting.Brightness = 2

        for _,s in ipairs(stars) do if s and s.Parent then s:Destroy() end end

        stars = {}

        for _,p in ipairs(shootingStarsFolder:GetChildren()) do p:Destroy() end

        for i=1,STAR_COUNT do createStar() end

        spaceSound:Play()

    elseif not shouldBeActive and active then

        active = false

        for _,s in ipairs(stars) do if s and s.Parent then s:Destroy() end end

        stars = {}

        for _,p in ipairs(shootingStarsFolder:GetChildren()) do p:Destroy() end

        spaceSound:Stop()

        Lighting.FogColor = Color3.fromRGB(192,192,192)

        Lighting.FogEnd = 100000

        Lighting.Brightness = 2

    end

end



task.spawn(function()

    while true do

        if active then

            for i=1,SHOOTING_STAR_MAX do

                createShootingStar()

                task.wait(shootingStarCooldown)

            end

        else

            task.wait(1)

        end

    end

end)



task.spawn(function()

    while true do

        updateSky()

        task.wait(1)

    end

end)



local rainFolder = Instance.new("Folder",workspace)

rainFolder.Name = "FakeRain"

local isRaining = false



local birds = Instance.new("Sound",SoundService)

birds.SoundId = "rbxassetid://9111139882"

birds.Volume = 0.2

birds.Looped = true

birds:Play()



local rainSound = Instance.new("Sound",SoundService)

rainSound.SoundId = "rbxassetid://9118823106"

rainSound.Volume = 0.3

rainSound.Looped = true

rainSound:Play()



local thunder = Instance.new("Sound",SoundService)

thunder.SoundId = "rbxassetid://9120018695"

thunder.Volume = 0.4



local function updateBirdSound()

    birds.Volume = isRaining and 0 or 0.2

end



local function spawnRain()

    isRaining = true

    updateBirdSound()

    for i=1,120 do

        local drop = Instance.new("Part")

        drop.Size = Vector3.new(0.1,2,0.1)

        drop.Anchored = true

        drop.CanCollide = false

        drop.Material = Enum.Material.Glass

        drop.Transparency = 0.5

        drop.Color = Color3.fromRGB(160,160,255)

        drop.Position = Vector3.new(math.random(-150,150),100,math.random(-150,150))

        drop.Parent = rainFolder

        local tween = TweenService:Create(drop,TweenInfo.new(1),{Position=drop.Position-Vector3.new(0,60,0)})

        tween:Play()

        Debris:AddItem(drop,1.5)

    end

    wait(1.5)

    isRaining = false

    updateBirdSound()

end



local function lightningStrike()

    local flash = Instance.new("Part")

    flash.Size = Vector3.new(1,1000,1)

    flash.Anchored = true

    flash.CanCollide = false

    flash.Transparency = 0.4

    flash.Material = Enum.Material.Neon

    flash.Color = Color3.new(1,1,1)

    flash.Position = Vector3.new(math.random(-100,100),500,math.random(-100,100))

    flash.Parent = workspace

    Lighting.Brightness = Lighting.Brightness + 1.5

    thunder:Play()

    wait(0.1)

    Lighting.Brightness = Lighting.Brightness - 1.5

    flash:Destroy()

end



for _,part in pairs(workspace:GetDescendants()) do

    if part:IsA("BasePart") and part.Material == Enum.Material.SmoothPlastic then

        part.Reflectance = 0.25

    end

end



task.spawn(function()

    while true do

        spawnRain()

        if math.random() < 0.2 then lightningStrike() end

        wait(1)

    end

end)



Lighting.Brightness = 2

Lighting.GlobalShadows = true

Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)

Lighting.FogColor = Color3.fromRGB(120, 130, 140)

Lighting.FogStart = 80

Lighting.FogEnd = 600

Lighting.EnvironmentSpecularScale = 1

Lighting.EnvironmentDiffuseScale = 0.5



local sky = Instance.new("Sky")

sky.SkyboxBk = "rbxassetid://159454299"

sky.SkyboxDn = "rbxassetid://159454296"

sky.SkyboxFt = "rbxassetid://159454293"

sky.SkyboxLf = "rbxassetid://159454286"

sky.SkyboxRt = "rbxassetid://159454300"

sky.SkyboxUp = "rbxassetid://159454304"

sky.Parent = Lighting



local color = Instance.new("ColorCorrectionEffect", Lighting)

color.Brightness = 0.03

color.Contrast = 0.15

color.Saturation = 0.05

color.TintColor = Color3.fromRGB(255, 240, 220)



local bloom = Instance.new("BloomEffect", Lighting)

bloom.Intensity = 0.8

bloom.Size = 56

bloom.Threshold = 0.9



local sunRays = Instance.new("SunRaysEffect", Lighting)

sunRays.Intensity = 0.05

sunRays.Spread = 0.8



local blur = Instance.new("BlurEffect", Lighting)

blur.Size = 0

end

})





local TrollTab = Window:MakeTab({
    Title = "Anooy",
    Icon = "rbxassetid://6034509993"
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Variáveis
local selectedPlayerName = nil
local selectedPlayer = nil
local lagAtivo = false
local lagConnection
local lagAllAtivo = false
local lagAllConnection
local indice = 1
local whitelist = {}

local crashAtivo = false
local crashConnection

----------------------------------------------------
-- Funções Auxiliares
----------------------------------------------------
local function getPlayerList()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(list, p.Name)
        end
    end
    return list
end

-- Lag Player
local function AtivarLagPlayer(player)
    if lagConnection then lagConnection:Disconnect() end
    selectedPlayer = player
    lagAtivo = true
    lagConnection = RunService.Stepped:Connect(function()
        if not lagAtivo or not selectedPlayer or selectedPlayer == LocalPlayer then return end
        local character = selectedPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local vetorlouco = Vector3.new(math.random(1e14,1e15), math.random(1e14,1e15), math.random(1e14,1e15))
            local args = {
                [1] = character.HumanoidRootPart,
                [2] = character.HumanoidRootPart,
                [3] = vetorlouco,
                [4] = character.HumanoidRootPart.Position,
                [5] = LocalPlayer.Backpack:FindFirstChild("Assault") 
                        and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") 
                        and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("MuzzleEffect"),
                [6] = LocalPlayer.Backpack:FindFirstChild("Assault") 
                        and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") 
                        and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("ImpactEffect"),
                [7] = 0,[8]=0,[9] = {[1]=false},
                [10] = {[1]=25,[2]=Vector3.new(100,100,100),[3]=BrickColor.new("Bright red"),[4]=0.25,[5]=Enum.Material.SmoothPlastic,[6]=0.25},
                [11] = true,[12] = false
            }
            if ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1Gu1n") then
                ReplicatedStorage.RE["1Gu1n"]:FireServer(unpack(args))
            end
        end
    end)
end

local function DesativarLagPlayer()
    lagAtivo = false
    selectedPlayer = nil
    if lagConnection then
        lagConnection:Disconnect()
        lagConnection = nil
    end
end

-- Lag ALL
local function AtivarLagAll()
    if lagAllConnection then lagAllConnection:Disconnect() end
    lagAllConnection = RunService.Stepped:Connect(function()
        if not lagAllAtivo then return end
        local allPlayers = Players:GetPlayers()
        if #allPlayers < 2 then return end
        indice += 1
        if indice > #allPlayers then indice = 1 end
        local target = allPlayers[indice]

        if target == LocalPlayer or table.find(whitelist, target.Name) then
            indice += 1
            if indice > #allPlayers then indice = 1 end
            target = allPlayers[indice]
        end

        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local vetorlouco = Vector3.new(math.random(1e14,1e15), math.random(1e14,1e15), math.random(1e14,1e15))
            local args = {
                [1] = target.Character.HumanoidRootPart,
                [2] = target.Character.HumanoidRootPart,
                [3] = vetorlouco,
                [4] = target.Character.HumanoidRootPart.Position,
                [5] = LocalPlayer.Backpack:FindFirstChild("Assault") 
                        and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") 
                        and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("MuzzleEffect"),
                [6] = LocalPlayer.Backpack:FindFirstChild("Assault") 
                        and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") 
                        and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("ImpactEffect"),
                [7] = 0,[8]=0,[9] = {[1]=false},
                [10] = {[1]=25,[2]=Vector3.new(100,100,100),[3]=BrickColor.new("Bright red"),[4]=0.25,[5]=Enum.Material.SmoothPlastic,[6]=0.25},
                [11] = true,[12] = false
            }
            if ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1Gu1n") then
                ReplicatedStorage.RE["1Gu1n"]:FireServer(unpack(args))
            end
        end
    end)
end

local function ToggleLagAll(state)
    lagAllAtivo = state
    if state then
        AtivarLagAll()
    elseif lagAllConnection then
        lagAllConnection:Disconnect()
        lagAllConnection = nil
    end
end

-- Crash Player
local function GerarVetorCrash()
    local base = math.random(1e15, 1e16)
    return Vector3.new(base*math.random(50,150), base*math.random(50,150), base*math.random(50,150))
end

local function TriggerCrashOn(target, times)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = target.Character.HumanoidRootPart
    local remote = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1Gu1n")
    if not remote then return end
    times = times or 10
    for i=1,times do
        task.spawn(function()
            local vetorlouco = GerarVetorCrash()
            local args = {
                [1]=hrp,[2]=hrp,[3]=vetorlouco,[4]=hrp.Position,
                [5]=LocalPlayer.Backpack:FindFirstChild("Assault") and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("MuzzleEffect"),
                [6]=LocalPlayer.Backpack:FindFirstChild("Assault") and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("ImpactEffect"),
                [7]=0,[8]=0,[9]={[1]=false},
                [10]={[1]=25,[2]=Vector3.new(100,100,100),[3]=BrickColor.new("Bright red"),[4]=0.25,[5]=Enum.Material.SmoothPlastic,[6]=0.25},
                [11]=true,[12]=false
            }
            pcall(function() remote:FireServer(unpack(args)) end)
        end)
    end
end

----------------------------------------------------
-- GUI - Lag Player + Crash
----------------------------------------------------
TrollTab:AddSection({ Name = "Lag Player" })

local playerDropdown = TrollTab:AddDropdown({
    Name = "Selecionar Jogador",
    Options = getPlayerList(),
    Default = "",
    Callback = function(value)
        selectedPlayerName = value
        selectedPlayer = Players:FindFirstChild(value)
        print("Player selecionado: " .. tostring(value))
    end
})

TrollTab:AddButton({
    Name = "Atualizar Player List",
    Callback = function()
        local list = getPlayerList()
        if playerDropdown then
            playerDropdown:Set(list)
            print("Lista atualizada: " .. table.concat(list,", "))
        end
    end
})

TrollTab:AddToggle({
    Name = "Ativar Lag Player",
    Default = false,
    Callback = function(value)
        if value then
            if selectedPlayer then
                AtivarLagPlayer(selectedPlayer)
                print("Lag ativado em: " .. selectedPlayer.Name)
            else
                print("Nenhum player selecionado")
            end
        else
            DesativarLagPlayer()
            print("Lag desativado")
        end
    end
})

-- Crash Player toggle movido para aqui
TrollTab:AddToggle({
    Name = "Ativar Crash Player",
    Default = false,
    Callback = function(state)
        crashAtivo = state
        if crashConnection then
            crashConnection:Disconnect()
            crashConnection = nil
        end

        if crashAtivo then
            if selectedPlayer then
                crashConnection = RunService.Stepped:Connect(function()
                    if selectedPlayer and selectedPlayer.Character then
                        TriggerCrashOn(selectedPlayer, 10)
                    end
                end)
                print("Crash ativo em: " .. selectedPlayer.Name)
            else
                print("Nenhum player selecionado para crash")
                crashAtivo = false
            end
        else
            print("Crash desativado")
        end
    end
})

----------------------------------------------------
-- GUI - Lag Server (Lag ALL + Whitelist)
----------------------------------------------------
TrollTab:AddSection({ Name = "Lag Server" })

local whitelistDropdown = TrollTab:AddDropdown({
    Name = "Selecionar Player",
    Options = getPlayerList(),
    Default = "",
    Callback = function(value)
        selectedPlayerName = value
    end
})

TrollTab:AddButton({
    Name = "Adicionar Whitelist",
    Callback = function()
        if selectedPlayerName then
            if not table.find(whitelist, selectedPlayerName) then
                table.insert(whitelist, selectedPlayerName)
                print(selectedPlayerName .. " adicionado à whitelist.")
            else
                print(selectedPlayerName .. " já está na whitelist.")
            end
        else
            print("Nenhum player selecionado.")
        end
    end
})

TrollTab:AddButton({
    Name = "Ver Whitelist",
    Callback = function()
        if #whitelist == 0 then
            print("Whitelist vazia.")
        else
            print("Whitelist: " .. table.concat(whitelist,", "))
        end
    end
})

TrollTab:AddButton({
    Name = "Limpar Whitelist",
    Callback = function()
        whitelist = {}
        print("Whitelist limpa.")
    end
})

TrollTab:AddToggle({
    Name = "Ativar Lag ALL (Protege Whitelist)",
    Default = false,
    Callback = function(value)
        ToggleLagAll(value)
        print("Lag ALL: " .. tostring(value))
    end
})

----------------------------------------------------
-- Atualiza dropdowns quando players entram/saem
----------------------------------------------------
Players.PlayerAdded:Connect(function()
    playerDropdown:Set(getPlayerList())
    whitelistDropdown:Set(getPlayerList())
end)

Players.PlayerRemoving:Connect(function()
    playerDropdown:Set(getPlayerList())
    whitelistDropdown:Set(getPlayerList())
end)

local AnimeTab = Window:MakeTab({ Title = "Anime Scripts", Icon = "star" })
AnimeTab:AddSection({"Anime"})
AnimeTab:AddButton({
    Name = "Domain Expansion",
    Callback = function()
-- Serviços
local TextChatService = game:GetService("TextChatService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- Aviso no chat (com \r conforme seu pedido)
if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then 
    TextChatService.TextChannels.RBXGeneral:SendAsync(
        "hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r[Yowai-mo!] Domain Expansion..."
    )
else 
    print("gojo chorou no banho F")
end

-- Função para ativar Expansão de Domínio
local function ativarDominio()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local dominio = Instance.new("Model", workspace)
    dominio.Name = "InfiniteVoid"

    local esfera = Instance.new("Part")
    esfera.Shape = Enum.PartType.Ball
    esfera.Size = Vector3.new(300, 300, 300)
    esfera.Position = hrp.Position
    esfera.Anchored = true
    esfera.CanCollide = false
    esfera.Material = Enum.Material.ForceField
    esfera.Transparency = 0.3
    esfera.Color = Color3.fromRGB(0, 0, 0)
    esfera.Parent = dominio

    local luz = Instance.new("PointLight", esfera)
    luz.Color = Color3.fromRGB(0, 153, 255)
    luz.Brightness = 10
    luz.Range = 300

    local ps = Instance.new("ParticleEmitter", esfera)
    ps.Texture = "rbxassetid://243660364"
    ps.Color = ColorSequence.new(Color3.fromRGB(0, 153, 255))
    ps.LightEmission = 1
    ps.Size = NumberSequence.new(3)
    ps.Transparency = NumberSequence.new(0.2)
    ps.Rate = 1000
    ps.Lifetime = NumberRange.new(2)
    ps.Speed = NumberRange.new(0)
    ps.VelocitySpread = 180

    local som = Instance.new("Sound", esfera)
    som.SoundId = "rbxassetid://1843527678"
    som.Volume = 2
    som.Looped = true
    som:Play()

    local skyOld = Lighting:FindFirstChildOfClass("Sky")
    if skyOld then
        skyOld.Parent = nil
    end

    local newSky = Instance.new("Sky", Lighting)
    newSky.SkyboxBk = "rbxassetid://159454299"
    newSky.SkyboxDn = "rbxassetid://159454296"
    newSky.SkyboxFt = "rbxassetid://159454293"
    newSky.SkyboxLf = "rbxassetid://159454286"
    newSky.SkyboxRt = "rbxassetid://159454300"
    newSky.SkyboxUp = "rbxassetid://159454288"
end

-- Executa a expansão de domínio
ativarDominio()

-- Áudio em loop infinito no jogador
local selectedAudioID = 140031333626044

task.spawn(function()
    while true do
        local remote = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1Gu1nSound1s")
        if remote then
            remote:FireServer(workspace, selectedAudioID, 1)
        end

        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://" .. selectedAudioID
            sound.Volume = 1
            sound.Looped = false
            sound.Parent = root
            sound:Play()
            sound.Ended:Connect(function() sound:Destroy() end)
            task.wait(sound.TimeLength + 0.1)
        else
            warn("HumanoidRootPart não encontrado")
            break
        end
    end
end)

-- ========================
-- ATAQUE COM ARMA: Assault
-- ========================

local RE = ReplicatedStorage:WaitForChild("RE")
local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
local ToolEvent = RE:FindFirstChild("1Too1l")
local FireEvent = RE:FindFirstChild("1Gu1n")

-- Limpa ferramentas
local function clearAllTools()
    if ClearEvent then
        ClearEvent:FireServer("ClearAllTools")
    end
end

-- Solicita Assault
local function getAssault()
    if ToolEvent then
        ToolEvent:InvokeServer("PickingTools", "Assault")
    end
end

-- Verifica se recebeu Assault
local function hasAssault()
    return Player.Backpack:FindFirstChild("Assault") ~= nil
end

-- Atira em parte
local function fireAtPart(targetPart)
    local gunScript = Player.Backpack:FindFirstChild("Assault")
        and Player.Backpack.Assault:FindFirstChild("GunScript_Local")

    if not gunScript or not targetPart then return end

    local args = {
        targetPart,
        targetPart,
        Vector3.new(1e14, 1e14, 1e14),
        targetPart.Position,
        gunScript:FindFirstChild("MuzzleEffect"),
        gunScript:FindFirstChild("HitEffect"),
        0,
        0,
        { false },
        {
            25,
            Vector3.new(100, 100, 100),
            BrickColor.new(29),
            0.25,
            Enum.Material.SmoothPlastic,
            0.25
        },
        true,
        false
    }

    FireEvent:FireServer(unpack(args))
end

-- Atira em todos os jogadores
local function fireAtAllPlayers(times)
    for i = 1, times do
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                fireAtPart(player.Character.HumanoidRootPart)
                task.wait(0.1)
            end
        end
    end
end

-- Loop automático de ataque
task.spawn(function()
    while true do
        clearAllTools()
        getAssault()

        repeat
            task.wait(0.2)
        until hasAssault()

        fireAtAllPlayers(3)
        task.wait(1)
    end
end)
end
})
AnimeTab:AddButton({
    Name = "Sharingan", 
    Callback = function()
-- Serviços
local TextChatService = game:GetService("TextChatService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- Aviso no chat (com \r conforme seu pedido)
if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then 
    TextChatService.TextChannels.RBXGeneral:SendAsync(
        "hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r[📈] Sharingan Ativado"
    )
else 
    print("naruto chorou no banho F")
end

-- Função para ativar Expansão de Domínio
local function ativarDominio()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local dominio = Instance.new("Model", workspace)
    dominio.Name = "InfiniteVoid"

    local esfera = Instance.new("Part")
    esfera.Shape = Enum.PartType.Ball
    esfera.Size = Vector3.new(300, 300, 300)
    esfera.Position = hrp.Position
    esfera.Anchored = true
    esfera.CanCollide = false
    esfera.Material = Enum.Material.ForceField
    esfera.Transparency = 0.3
    esfera.Color = Color3.fromRGB(0, 0, 0)
    esfera.Parent = dominio

    local luz = Instance.new("PointLight", esfera)
    luz.Color = Color3.fromRGB(255, 0, 0)
    luz.Brightness = 10
    luz.Range = 300

    local ps = Instance.new("ParticleEmitter", esfera)
    ps.Texture = "rbxassetid://243660364"
    ps.Color = ColorSequence.new(Color3.fromRGB(0, 153, 255))
    ps.LightEmission = 1
    ps.Size = NumberSequence.new(3)
    ps.Transparency = NumberSequence.new(0.2)
    ps.Rate = 1000
    ps.Lifetime = NumberRange.new(2)
    ps.Speed = NumberRange.new(0)
    ps.VelocitySpread = 180

    local som = Instance.new("Sound", esfera)
    som.SoundId = "rbxassetid://1843527678"
    som.Volume = 2
    som.Looped = true
    som:Play()

    local skyOld = Lighting:FindFirstChildOfClass("Sky")
    if skyOld then
        skyOld.Parent = nil
    end

    local newSky = Instance.new("Sky", Lighting)
    newSky.SkyboxBk = "rbxassetid://159454299"
    newSky.SkyboxDn = "rbxassetid://159454296"
    newSky.SkyboxFt = "rbxassetid://159454293"
    newSky.SkyboxLf = "rbxassetid://159454286"
    newSky.SkyboxRt = "rbxassetid://159454300"
    newSky.SkyboxUp = "rbxassetid://159454288"
end

-- Executa a expansão de domínio
ativarDominio()

-- Áudio em loop infinito no jogador
local selectedAudioID = 405593386

task.spawn(function()
    while true do
        local remote = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1Gu1nSound1s")
        if remote then
            remote:FireServer(workspace, selectedAudioID, 1)
        end

        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://" .. selectedAudioID
            sound.Volume = 1
            sound.Looped = false
            sound.Parent = root
            sound:Play()
            sound.Ended:Connect(function() sound:Destroy() end)
            task.wait(sound.TimeLength + 0.1)
        else
            warn("HumanoidRootPart não encontrado")
            break
        end
    end
end)

-- ========================
-- ATAQUE COM ARMA: Assault
-- ========================

local RE = ReplicatedStorage:WaitForChild("RE")
local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
local ToolEvent = RE:FindFirstChild("1Too1l")
local FireEvent = RE:FindFirstChild("1Gu1n")

-- Limpa ferramentas
local function clearAllTools()
    if ClearEvent then
        ClearEvent:FireServer("ClearAllTools")
    end
end

-- Solicita Assault
local function getAssault()
    if ToolEvent then
        ToolEvent:InvokeServer("PickingTools", "Assault")
    end
end

-- Verifica se recebeu Assault
local function hasAssault()
    return Player.Backpack:FindFirstChild("Assault") ~= nil
end

-- Atira em parte
local function fireAtPart(targetPart)
    local gunScript = Player.Backpack:FindFirstChild("Assault")
        and Player.Backpack.Assault:FindFirstChild("GunScript_Local")

    if not gunScript or not targetPart then return end

    local args = {
        targetPart,
        targetPart,
        Vector3.new(1e14, 1e14, 1e14),
        targetPart.Position,
        gunScript:FindFirstChild("MuzzleEffect"),
        gunScript:FindFirstChild("HitEffect"),
        0,
        0,
        { false },
        {
            25,
            Vector3.new(100, 100, 100),
            BrickColor.new(29),
            0.25,
            Enum.Material.SmoothPlastic,
            0.25
        },
        true,
        false
    }

    FireEvent:FireServer(unpack(args))
end

-- Atira em todos os jogadores
local function fireAtAllPlayers(times)
    for i = 1, times do
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                fireAtPart(player.Character.HumanoidRootPart)
                task.wait(0.1)
            end
        end
    end
end

-- Loop automático de ataque
task.spawn(function()
    while true do
        clearAllTools()
        getAssault()

        repeat
            task.wait(0.2)
        until hasAssault()

        fireAtAllPlayers(3)
        task.wait(1)
    end
end)
end
})

local TabProtector = Window:MakeTab({
    Title = "Protector",
    Icon = "shield"
})

TabProtector:AddSection("Proteção")

--// ANTI BUG
local antiBugEnabled = false

local function ProtectionBug()
    local blacklist = {
        {Name = "water", Class = "Part"},
    }

    local function neutralize(part)
        if part and part:IsA("BasePart") then
            pcall(function()
                part.Anchored = true
                part.CanCollide = false
                part.Massless = true
                part.Transparency = 1
                part:ClearAllChildren()
            end)
            pcall(function()
                part:Destroy()
            end)
        end
    end

    workspace.DescendantAdded:Connect(function(obj)
        for _, rule in ipairs(blacklist) do
            if obj.Name == rule.Name and obj.ClassName == rule.Class then
                neutralize(obj)
            end
        end
    end)

    for _, obj in ipairs(workspace:GetDescendants()) do
        for _, rule in ipairs(blacklist) do
            if obj.Name == rule.Name and obj.ClassName == rule.Class then
                neutralize(obj)
            end
        end
    end

    task.spawn(function()
        while antiBugEnabled and task.wait(0.25) do
            for _, rule in ipairs(blacklist) do
                for _, v in next, getnilinstances() do
                    if v.Name == rule.Name and v.ClassName == rule.Class then
                        neutralize(v)
                    end
                end
            end
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")
        hum.Touched:Connect(function(hit)
            for _, rule in ipairs(blacklist) do
                if hit.Name == rule.Name and hit.ClassName == rule.Class then
                    neutralize(hit)
                end
            end
        end)
    end)
end

TabProtector:AddToggle({
    Name = "Anti Bug",
    Default = false,
    Callback = function(state)
        antiBugEnabled = state
        if state then
            ProtectionBug()
            print("Anti Bug ATIVADO")
        else
            print("Anti Bug DESATIVADO")
        end
    end
})

--// ANTI VOID
local antiVoidEnabled = false
TabProtector:AddToggle({
    Name = "Anti Void",
    Default = false,
    Callback = function(state)
        antiVoidEnabled = state
    end
})

RunService.Heartbeat:Connect(function()
    if antiVoidEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        if rootPart.Position.Y < -500 then
            local safeCFrame = CFrame.new(0, 100, 0)
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
            local result = workspace:Raycast(rootPart.Position, Vector3.new(0, 500, 0), rayParams)
            rootPart.CFrame = result and CFrame.new(result.Position + Vector3.new(0,5,0)) or safeCFrame
        end
    end
end)

--// ANTI SIT
local antiSitConnection = nil
local antiSitEnabled = false

TabProtector:AddToggle({
    Name = "Anti-Sit",
    Default = false,
    Callback = function(state)
        antiSitEnabled = state
        local LocalPlayer = game:GetService("Players").LocalPlayer

        if state then
            local function applyAntiSit(character)
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Sit = false
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    if antiSitConnection then
                        antiSitConnection:Disconnect()
                    end
                    antiSitConnection = humanoid.Seated:Connect(function(isSeated)
                        if isSeated then
                            humanoid.Sit = false
                            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                        end
                    end)
                end
            end

            if LocalPlayer.Character then
                applyAntiSit(LocalPlayer.Character)
            end

            local characterAddedConnection
            characterAddedConnection = LocalPlayer.CharacterAdded:Connect(function(character)
                if not antiSitEnabled then
                    characterAddedConnection:Disconnect()
                    return
                end
                local humanoid = character:WaitForChild("Humanoid", 5)
                if humanoid then
                    applyAntiSit(character)
                end
            end)
        else
            if antiSitConnection then
                antiSitConnection:Disconnect()
                antiSitConnection = nil
            end
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                end
            end
        end
    end
})

--// 🔇 ANTI-ÁUDIO TOTAL
local antiAudioEnabled = false
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

local function blockAllAudio()
    -- Função que remove e bloqueia sons
    local function muteSound(obj)
        if obj:IsA("Sound") then
            obj.Playing = false
            obj.Volume = 0
            obj:Destroy()
            warn("[ANTI-ÁUDIO] Som bloqueado e removido:", obj.Name)
        end
    end

    -- Sons existentes
    for _, descendant in pairs(Workspace:GetDescendants()) do
        muteSound(descendant)
    end
    for _, descendant in pairs(SoundService:GetDescendants()) do
        muteSound(descendant)
    end
    if LocalPlayer.Character then
        for _, descendant in pairs(LocalPlayer.Character:GetDescendants()) do
            muteSound(descendant)
        end
    end

    -- Bloqueia sons futuros
    Workspace.DescendantAdded:Connect(function(obj)
        if antiAudioEnabled then muteSound(obj) end
    end)
    SoundService.DescendantAdded:Connect(function(obj)
        if antiAudioEnabled then muteSound(obj) end
    end)
    LocalPlayer.CharacterAdded:Connect(function(char)
        char.DescendantAdded:Connect(function(obj)
            if antiAudioEnabled then muteSound(obj) end
        end)
    end)
end

TabProtector:AddToggle({
    Name = "Anti-Áudio",
    Default = false,
    Callback = function(state)
        antiAudioEnabled = state
        if state then
            blockAllAudio()
            print("🔇 Anti-Áudio ATIVADO: nenhum som poderá ser reproduzido.")
        else
            print("🔈 Anti-Áudio DESATIVADO: sons liberados.")
        end
    end
})

local Tab = Window:MakeTab({"Avatar", "rbxassetid://10734952036"})

Tab:AddSection({ Name = "Copiar Skin" })



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Target = nil

-- FunÃ§Ã£o para obter os nomes dos jogadores
local function GetPlayerNames()
    local PlayerNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        table.insert(PlayerNames, player.Name)
    end
    return PlayerNames
end

-- Dropdown de seleÃ§Ã£o de jogador
local Dropdown = Tab:AddDropdown({
    Name = "Selecionar Jogador",
    Options = GetPlayerNames(),
    Default = Target,
    Callback = function(Value)
        Target = Value
    end
})

-- Atualiza opÃ§Ãµes do dropdown quando alguÃ©m entra ou sai
local function UpdateDropdown()
    Dropdown:Refresh(GetPlayerNames(), true)
end

Players.PlayerAdded:Connect(UpdateDropdown)
Players.PlayerRemoving:Connect(UpdateDropdown)

Tab:AddButton({
    Name = "Copiar Avatar",
    Callback = function()
        if not Target then return end

        local LP = Players.LocalPlayer
        local LChar = LP.Character
        local TPlayer = Players:FindFirstChild(Target)

        if TPlayer and TPlayer.Character then
            local LHumanoid = LChar and LChar:FindFirstChildOfClass("Humanoid")
            local THumanoid = TPlayer.Character:FindFirstChildOfClass("Humanoid")

            if LHumanoid and THumanoid then
                -- RESETAR LOCALPLAYER
                local LDesc = LHumanoid:GetAppliedDescription()

                -- Remover acessÃ³rios, roupas e face atuais
                for _, acc in ipairs(LDesc:GetAccessories(true)) do
                    if acc.AssetId and tonumber(acc.AssetId) then
                        Remotes.Wear:InvokeServer(tonumber(acc.AssetId))
                        task.wait(0.2)
                    end
                end

                if tonumber(LDesc.Shirt) then
                    Remotes.Wear:InvokeServer(tonumber(LDesc.Shirt))
                    task.wait(0.2)
                end

                if tonumber(LDesc.Pants) then
                    Remotes.Wear:InvokeServer(tonumber(LDesc.Pants))
                    task.wait(0.2)
                end

                if tonumber(LDesc.Face) then
                    Remotes.Wear:InvokeServer(tonumber(LDesc.Face))
                    task.wait(0.2)
                end

                -- COPIAR DO JOGADOR ALVO
                local PDesc = THumanoid:GetAppliedDescription()

                -- Enviar partes do corpo
                local argsBody = {
                    [1] = {
                        [1] = PDesc.Torso,
                        [2] = PDesc.RightArm,
                        [3] = PDesc.LeftArm,
                        [4] = PDesc.RightLeg,
                        [5] = PDesc.LeftLeg,
                        [6] = PDesc.Head
                    }
                }
                Remotes.ChangeCharacterBody:InvokeServer(unpack(argsBody))
                task.wait(0.5)

                if tonumber(PDesc.Shirt) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.Shirt))
                    task.wait(0.3)
                end

                if tonumber(PDesc.Pants) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.Pants))
                    task.wait(0.3)
                end

                if tonumber(PDesc.Face) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.Face))
                    task.wait(0.3)
                end

                for _, v in ipairs(PDesc:GetAccessories(true)) do
                    if v.AssetId and tonumber(v.AssetId) then
                        Remotes.Wear:InvokeServer(tonumber(v.AssetId))
                        task.wait(0.3)
                    end
                end

                local SkinColor = TPlayer.Character:FindFirstChild("Body Colors")
                if SkinColor then
                    Remotes.ChangeBodyColor:FireServer(tostring(SkinColor.HeadColor))
                    task.wait(0.3)
                end

                if tonumber(PDesc.IdleAnimation) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.IdleAnimation))
                    task.wait(0.3)
                end

                -- Nome, bio e cor
                local Bag = TPlayer:FindFirstChild("PlayersBag")
                if Bag then
                    if Bag:FindFirstChild("RPName") and Bag.RPName.Value ~= "" then
                        Remotes.RPNameText:FireServer("RolePlayName", Bag.RPName.Value)
                        task.wait(0.3)
                    end
                    if Bag:FindFirstChild("RPBio") and Bag.RPBio.Value ~= "" then
                        Remotes.RPNameText:FireServer("RolePlayBio", Bag.RPBio.Value)
                        task.wait(0.3)
                    end
                    if Bag:FindFirstChild("RPNameColor") then
                        Remotes.RPNameColor:FireServer("PickingRPNameColor", Bag.RPNameColor.Value)
                        task.wait(0.3)
                    end
                    if Bag:FindFirstChild("RPBioColor") then
                        Remotes.RPNameColor:FireServer("PickingRPBioColor", Bag.RPBioColor.Value)
                        task.wait(0.3)
                    end
                end
            end
        end
    end
})

-- Definir cores para o efeito RGB
local colors = {
    Color3.new(1, 0, 0),       -- Vermelho
    Color3.new(0, 1, 0),       -- Verde
    Color3.new(0, 0, 1),       -- Azul
    Color3.new(1, 1, 0),       -- Amarelo
    Color3.new(0, 1, 1),       -- Ciano
    Color3.new(1, 0, 1)        -- Magenta
}

-- Variável para controlar o estado do toggle House RGB
local isHouseRGBActive = false

-- Função para alterar a cor da casa
local function changeColor()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local remoteEvent = replicatedStorage:FindFirstChild("RE") and replicatedStorage.RE:FindFirstChild("1Player1sHous1e")
    
    if not remoteEvent then
        warn("RemoteEvent '1Player1sHous1e' não encontrado.")
        return
    end

    while isHouseRGBActive do
        for _, color in ipairs(colors) do
            if not isHouseRGBActive then return end
            local args = {
                [1] = "ColorPickHouse",
                [2] = color
            }
            pcall(function()
                remoteEvent:FireServer(unpack(args))
            end)
            task.wait(0.8)
        end
    end
end

local function toggleHouseRGB(state)
    isHouseRGBActive = state
    if isHouseRGBActive then
        print("House RGB Activated")
        spawn(changeColor)
    else
        print("House RGB Deactivated")
    end
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local lp = Players.LocalPlayer

local Tab9 = Window:MakeTab({"Trolling", "user"})

---------------------------------------------------------------------------------------------------------------------------------
                                                   -- === Tab 9: troll === --
-----------------------------------------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local selectedPlayer = nil
local isFollowingKill = false
local isFollowingPull = false
local running = false
local connection = nil
local flingConnection = nil
local originalPosition = nil
local savedPosition = nil
local originalProperties = {}
local selectedKillPullMethod = nil
local selectedFlingMethod = nil
local soccerBall = nil
local couch = nil
local isSpectating = false
local spectatedPlayer = nil
local characterConnection = nil
local flingToggle = nil

local SetNetworkOwnerEvent = Instance.new("RemoteEvent")
SetNetworkOwnerEvent.Name = "SetNetworkOwnerEvent_" .. tostring(math.random(1000, 9999))
SetNetworkOwnerEvent.Parent = ReplicatedStorage

local serverScriptCode = [[
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local event = ReplicatedStorage:WaitForChild("]] .. SetNetworkOwnerEvent.Name .. [[")
    
    event.OnServerEvent:Connect(function(player, part, networkOwner)
        if part and part:IsA("BasePart") then
            pcall(function()
                part:SetNetworkOwner(networkOwner)
                part.Anchored = false
                part.CanCollide = true
                part.CanTouch = true
            end)
        end
    end)
]]

pcall(function()
    loadstring(serverScriptCode)()
end)

local function disableCarClient()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local carClient = backpack:FindFirstChild("CarClient")
    if carClient and carClient:IsA("LocalScript") then
        carClient.Disabled = true
    end
end

local function enableCarClient()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local carClient = backpack:FindFirstChild("CarClient")
    if carClient and carClient:IsA("LocalScript") then
        carClient.Disabled = false
    end
end

local function getPlayerNames()
    local playerNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    return playerNames
end

local function updateDropdown(dropdown, spectateToggle)
    pcall(function()
        local currentValue = dropdown:Get()
        local playerNames = getPlayerNames()
        dropdown:Set(playerNames) -- Usando :Set como solicitado
        if currentValue and not table.find(playerNames, currentValue) then
            dropdown:Set("")
            selectedPlayer = nil
            if isSpectating then
                stopSpectating()
                if spectateToggle then
                    pcall(function() spectateToggle:Set(false) end)
                end
            end
            if running or isFollowingKill or isFollowingPull then
                running = false
                isFollowingKill = false
                isFollowingPull = false
                if connection then connection:Disconnect() connection = nil end
                if flingConnection then flingConnection:Disconnect() flingConnection = nil end
                if flingToggle then pcall(function() flingToggle:Set(false) end) end
            end
        elseif currentValue and table.find(playerNames, currentValue) then
            dropdown:Set(currentValue) -- Mantém seleção se jogador ainda está no jogo
        end
    end)
end





local function spectatePlayer(playerName)
    if characterConnection then
        characterConnection:Disconnect()
        characterConnection = nil
    end

    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer ~= LocalPlayer then
        spectatedPlayer = targetPlayer
        isSpectating = true

        local function updateCamera()
            if not isSpectating or not spectatedPlayer then return end
            if spectatedPlayer.Character and spectatedPlayer.Character:FindFirstChild("Humanoid") then
                Workspace.CurrentCamera.CameraSubject = spectatedPlayer.Character.Humanoid
            else
                Workspace.CurrentCamera.CameraSubject = nil
            end
        end

        updateCamera()




        characterConnection = RunService.Heartbeat:Connect(function()
            if not isSpectating then
                characterConnection:Disconnect()
                characterConnection = nil
                return
            end
            pcall(updateCamera)
        end)

        spectatedPlayer.CharacterAdded:Connect(function()
            if isSpectating then updateCamera() end
        end)
    else
        isSpectating = false
        spectatedPlayer = nil
    end
end

local function stopSpectating()
    if characterConnection then
        characterConnection:Disconnect()
        characterConnection = nil
    end

    isSpectating = false
    spectatedPlayer = nil

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    else
        Workspace.CurrentCamera.CameraSubject = nil
        Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end
end

-- Função para teletransportar para o jogador selecionado (com ancoragem segura)
local function teleportToPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local myHumanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if not myHRP or not myHumanoid then
            print("Seu personagem não está totalmente carregado para teletransporte.")
            return
        end

        -- Zerar a física do personagem antes do teleporte
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Velocity = Vector3.zero
                part.RotVelocity = Vector3.zero
                part.Anchored = true -- Ancorar temporariamente para evitar movimento
            end
        end

        -- Teleportar para a posição do jogador-alvo
        local success, errorMessage = pcall(function()
            myHRP.CFrame = CFrame.new(targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)) -- Leve elevação para evitar colisão com o chão
        end)
        if not success then
            warn("Erro ao teletransportar: " .. tostring(errorMessage))
            return
        end

        -- Garantir que o Humanoid saia do estado sentado ou voando
        myHumanoid.Sit = false
        myHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

        -- Aguardar 0,5 segundos com o personagem ancorado
        task.wait(0.5)

        -- Desancorar todas as partes do personagem e restaurar física
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = false
                part.Velocity = Vector3.zero
                part.RotVelocity = Vector3.zero
            end
        end

        print("Teletransportado para o jogador: " .. playerName .. " com ancoragem segura.")
    else
        print("Jogador ou personagem não encontrado para teletransporte.")
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    if isSpectating then
        stopSpectating()
        pcall(function() SpectateToggleTab10:Set(false) end)
    end
end)

local valor_do_nome_do_joagdor

local DropdownPlayerTab2 = Tab9:AddDropdown({
    Name = "Selecionar Jogador",
    Description = "Escolha um jogador para matar, puxar, visualizar ou aplicar fling",
    Default = "",
    Multi = false,
    Options = getPlayerNames(),
    Flag = "player list",
    Callback = function(selectedPlayerName)
        valor_do_nome_do_joagdor = selectedPlayerName
        if selectedPlayerName == "" or selectedPlayerName == nil then
            selectedPlayer = nil
            if running or isFollowingKill or isFollowingPull then
                running = false
                isFollowingKill = false
                isFollowingPull = false
                if connection then connection:Disconnect() end
                if flingConnection then flingConnection:Disconnect() end
                if flingToggle then pcall(function() flingToggle:Set(false) end) end
            end
            if isSpectating then stopSpectating() end
        else
            selectedPlayer = Players:FindFirstChild(selectedPlayerName)
            if isSpectating then
                stopSpectating()
                spectatePlayer(selectedPlayerName)
            end
        end
    end
})

function UptadePlayers()
    local playerNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name ~= LocalPlayer.Name then
            table.insert(playerNames, player.Name)
        end
    end
    DropdownPlayerTab2:Set(playerNames)
end

Tab9:AddButton({"Atualizar lista", function()
    UptadePlayers()
end})

UptadePlayers()


Tab9:AddButton({
    Title = "Teleportar para Jogador",
    Desc = "Clique para teletransportar para o jogador selecionado",
    Callback = function()
        local selectedPlayerName = valor_do_nome_do_joagdor
        if selectedPlayerName and selectedPlayerName ~= "" then
            local success, errorMessage = pcall(teleportToPlayer, selectedPlayerName)
            if not success then
                warn("Erro ao teletransportar: " .. tostring(errorMessage))
            end
        else
            print("Selecione um jogador antes de teletransportar.")
        end
    end
})

local SpectateToggleTab10 = Tab9:AddToggle({
    Name = "Visualizar Jogador",
    Description = "Ativa/desativa a visualização do jogador selecionado",
    Default = false,
    Callback = function(state)
        if state then
            if selectedPlayer then
                pcall(spectatePlayer, selectedPlayer.Name)
            else
                SpectateToggleTab10:Set(false)
            end
        else
            pcall(stopSpectating)
        end
    end
})

-- Remoção automática de jogadores que saem
Players.PlayerRemoving:Connect(function(player)
    updateDropdown(DropdownPlayerTab2, SpectateToggleTab10)
    if selectedPlayer == player then
        selectedPlayer = nil
        if isSpectating then stopSpectating() end
        if running then
            running = false
            if connection then connection:Disconnect() connection = nil end
            if flingConnection then flingConnection:Disconnect() flingConnection = nil end
            if flingToggle then flingToggle:Set(false) end
        end
        SpectateToggleTab10:Set(false)
        DropdownPlayerTab2:Set("")
    end
end)

-- Atualização automática quando um novo jogador entra
Players.PlayerAdded:Connect(function()
    task.wait(1) -- pequeno delay para garantir que o jogador esteja pronto
    updateDropdown(DropdownPlayerTab2, SpectateToggleTab10)
end)

-- Inicializa o dropdown
updateDropdown(DropdownPlayerTab2, SpectateToggleTab10)


local Section = Tab9:AddSection({"Kill"})

local DropdownKillPullMethod = Tab9:AddDropdown({
    Name = "Selecionar Método (Matar/Puxar)",
    Description = "Escolha o método para matar ou puxar",
    Options = {"Sofá", "Ônibus"},
    Callback = function(value)
        selectedKillPullMethod = value
    end
})

------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                   --fling com sofa--
------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function equipSofa()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local sofa = backpack:FindFirstChild("Couch") or LocalPlayer.Character:FindFirstChild("Couch")
    if not sofa then
        local args = { [1] = "PickingTools", [2] = "Couch" }
        local success = pcall(function()
            ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Too1l"):InvokeServer(unpack(args))
        end)
        if not success then return false end
        repeat
            sofa = backpack:FindFirstChild("Couch")
            task.wait()
        until sofa or task.wait(5)
        if not sofa then return false end
    end
    if sofa.Parent ~= LocalPlayer.Character then
        sofa.Parent = LocalPlayer.Character
    end
    return true
end

local function killWithSofa(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then return end
    if not equipSofa() then return end
    isFollowingKill = true
    originalPosition = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
end

local function pullWithSofa(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then return end
    if not equipSofa() then return end
    isFollowingPull = true
    originalPosition = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
end

----------------------------------------------------------------------------
                                                   --fling com onibus--
----------------------------------------------------------------------------


local function killWithBus(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then return end
    local character = LocalPlayer.Character
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local myHRP = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not myHRP then return end
    savedPosition = myHRP.Position
    pcall(function()
        myHRP.Anchored = true
        myHRP.CFrame = CFrame.new(Vector3.new(1181.83, 76.08, -1158.83))
        task.wait(0.2)
        myHRP.Velocity = Vector3.zero
        myHRP.RotVelocity = Vector3.zero
        myHRP.Anchored = false
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end)
    task.wait(0.5)

    disableCarClient()

    local args = { [1] = "DeleteAllVehicles" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)
    args = { [1] = "PickingCar", [2] = "SchoolBus" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)
    task.wait(1)
    local vehiclesFolder = Workspace:FindFirstChild("Vehicles")
    if not vehiclesFolder then return end
    local busName = LocalPlayer.Name .. "Car"
    local bus = vehiclesFolder:FindFirstChild(busName)
    if not bus then return end
    pcall(function()
        myHRP.Anchored = true
        myHRP.CFrame = CFrame.new(Vector3.new(1171.15, 79.45, -1166.2))
        task.wait(0.2)
        myHRP.Velocity = Vector3.zero
        myHRP.RotVelocity = Vector3.zero
        myHRP.Anchored = false
        humanoid:ChangeState(Enum.HumanoidStateType.Seated)
    end)
    local sitStart = tick()
    repeat
        task.wait()
        if tick() - sitStart > 10 then return end
    until humanoid.Sit
    for _, part in ipairs(bus:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            pcall(function() part:SetNetworkOwner(nil) end)
        end
    end
    running = true
    connection = RunService.Stepped:Connect(function()
        if not running then return end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
    local lastUpdate = tick()
    local updateInterval = 0.05
    local startTime = tick()
    flingConnection = RunService.Heartbeat:Connect(function()
        if not running then return end
        local targetCharacter = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
        local newTargetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
        local newTargetHumanoid = targetCharacter:FindFirstChild("Humanoid")
        if not newTargetHRP or not newTargetHumanoid then return end
        if not myHRP or not humanoid then running = false return end
        if tick() - lastUpdate < updateInterval then return end
        lastUpdate = tick()
        local offset = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
        pcall(function()
            local targetPosition = newTargetHRP.Position + offset
            bus:PivotTo(
                CFrame.new(targetPosition) * CFrame.Angles(
                    math.rad(Workspace.DistributedGameTime * 12000),
                    math.rad(Workspace.DistributedGameTime * 15000),
                    math.rad(Workspace.DistributedGameTime * 18000)
                )
            )
        end)
        local playerSeated = false
        for _, seat in ipairs(bus:GetDescendants()) do
            if (seat:IsA("Seat") or seat:IsA("VehicleSeat")) and seat.Name ~= "VehicleSeat" then
                if seat.Occupant == newTargetHumanoid then
                    playerSeated = true
                    break
                end
            end
        end
        if playerSeated or tick() - startTime > 10 then
            running = false
            if connection then connection:Disconnect() connection = nil end
            if flingConnection then flingConnection:Disconnect() flingConnection = nil end
            pcall(function()
                bus:PivotTo(CFrame.new(Vector3.new(-76.6, -401.97, -84.26)))
            end)
            task.wait(0.5)

            disableCarClient()

            local args = { [1] = "DeleteAllVehicles" }
            pcall(function()
                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
            end)
            if character then
                local myHRP = character:FindFirstChild("HumanoidRootPart")
                if myHRP and savedPosition then
                    pcall(function()
                        myHRP.Anchored = true
                        myHRP.CFrame = CFrame.new(savedPosition + Vector3.new(0, 5, 0))
                        task.wait(0.2)
                        myHRP.Velocity = Vector3.zero
                        myHRP.RotVelocity = Vector3.zero
                        myHRP.Anchored = false
                        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
                    end)
                end
            end
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                        part.Velocity = Vector3.zero
                        part.RotVelocity = Vector3.zero
                    end
                end
            end
            local myHumanoid = character and character:FindFirstChild("Humanoid")
            if myHumanoid then myHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
            for _, seat in ipairs(Workspace:GetDescendants()) do
                if seat:IsA("Seat") or seat:IsA("VehicleSeat") then seat.Disabled = false end
            end
            pcall(function()
                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clothe1s"):FireServer("CharacterSizeUp", 1)
            end)
        end
    end)
end

local followConnection
if followConnection then followConnection:Disconnect() end
followConnection = RunService.Heartbeat:Connect(function()
    if (isFollowingKill or isFollowingPull) and selectedPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        pcall(function()
            local targetPosition = selectedPlayer.Character.HumanoidRootPart.Position
            LocalPlayer.Character:SetPrimaryPartCFrame(
                CFrame.new(targetPosition) * CFrame.Angles(
                    math.rad(Workspace.DistributedGameTime * 12000),
                    math.rad(Workspace.DistributedGameTime * 15000),
                    math.rad(Workspace.DistributedGameTime * 18000)
                )
            )
        end)
    end
end)

local sitCheckConnection
if sitCheckConnection then sitCheckConnection:Disconnect() end
sitCheckConnection = RunService.Heartbeat:Connect(function()
    if (isFollowingKill or isFollowingPull) and selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") then
        pcall(function()
            if selectedPlayer.Character.Humanoid.Sit then
                if isFollowingKill then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(0, -500, 0))
                        task.wait(0.5)
                        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Too1l"):InvokeServer("PickingTools", "Couch")
                        task.wait(1)
                    end
                end
                isFollowingKill = false
                isFollowingPull = false
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and originalPosition then
                    local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local myHumanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    if myHRP then
                        myHRP.Anchored = true
                        myHRP.CFrame = CFrame.new(originalPosition + Vector3.new(0, 5, 0))
                        task.wait(0.2)
                        myHRP.Velocity = Vector3.zero
                        myHRP.RotVelocity = Vector3.zero
                        myHRP.Anchored = false
                        if myHumanoid then myHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
                    end
                    originalPosition = nil
                end
            end
        end)
    end
end)

Tab9:AddButton({
    Name = "Matar",
    Description = "Inicia o matar com o método selecionado",
    Callback = function()
        if isFollowingKill or isFollowingPull or running then return end
        if not selectedPlayer or not selectedKillPullMethod then return end
        if selectedKillPullMethod == "Sofá" then
            killWithSofa(selectedPlayer)
        elseif selectedKillPullMethod == "Ônibus" then
            killWithBus(selectedPlayer)
        end
    end
})

Tab9:AddButton({
    Name = "Puxar",
    Description = "Inicia o puxar com o método selecionado",
    Callback = function()
        if isFollowingKill or isFollowingPull or running then return end
        if not selectedPlayer or not selectedKillPullMethod or selectedKillPullMethod ~= "Sofá" then return end
        pullWithSofa(selectedPlayer)
    end
})

Tab9:AddButton({
    Name = "Parar (Matar ou Puxar)",
    Description = "Para o movimento de matar ou puxar",
    Callback = function()
        isFollowingKill = false
        isFollowingPull = false
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.Velocity = Vector3.zero
                part.RotVelocity = Vector3.zero
            end
        end
        local myHumanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if myHumanoid then myHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
        for _, seat in ipairs(Workspace:GetDescendants()) do
            if seat:IsA("Seat") or seat:IsA("VehicleSeat") then seat.Disabled = false end
        end
        if originalPosition then
            local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myHRP then
                myHRP.Anchored = true
                myHRP.CFrame = CFrame.new(originalPosition + Vector3.new(0, 5, 0))
                task.wait(0.2)
                myHRP.Velocity = Vector3.zero
                myHRP.RotVelocity = Vector3.zero
                myHRP.Anchored = false
                if myHumanoid then myHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
            end
            originalPosition = nil
        end

        disableCarClient()

        local args = { [1] = "DeleteAllVehicles" }
        pcall(function()
            ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
        end)
    end
})

local Section = Tab9:AddSection({" flings"})

local DropdownFlingMethod = Tab9:AddDropdown({
    Name = "Selecionar Método de Fling",
    Description = "Escolha o método para aplicar fling",
    Options = {"Sofá", "Ônibus", "Bola", "Bola V2", "Barco", "Caminhão"},
    Callback = function(value)
        selectedFlingMethod = value
    end
})


----------------------------------------------------------------------------------------------------------------------------------------------------------
                                                   --fling com sofa--
----------------------------------------------------------------------------------------------------------------------------------------------------------

local function flingWithSofa(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then
        return
    end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local myHRP = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not myHRP then
        return
    end
    savedPosition = myHRP.Position
    if not equipSofa() then return end
    task.wait(0.5)
    couch = character:FindFirstChild("Couch")
    if not couch then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if (obj.Name == "Couch" or obj.Name == "Couch" .. LocalPlayer.Name) and (obj:IsA("BasePart") or obj:IsA("Tool")) then
                couch = obj
                break
            end
        end
    end
    if not couch then
        return
    end
    if couch:IsA("BasePart") then
        originalProperties = {
            Anchored = couch.Anchored,
            CanCollide = couch.CanCollide,
            CanTouch = couch.CanTouch
        }
        couch.Anchored = false
        couch.CanCollide = true
        couch.CanTouch = true
        pcall(function() couch:SetNetworkOwner(nil) end)
    end
    running = true
    connection = RunService.Stepped:Connect(function()
        if not running then return end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
    local startTime = tick()
    local walkFlingInstance = nil
    flingConnection = RunService.Heartbeat:Connect(function()
        if not running then return end
        if not targetPlayer or not targetPlayer.Character then
            running = false
            return
        end
        local newTargetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local newTargetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
        if not newTargetHRP or not newTargetHumanoid then
            running = false
            return
        end
        if not myHRP or not humanoid then
            running = false
            return
        end
        pcall(function()
            local targetPosition = newTargetHRP.Position
            character:SetPrimaryPartCFrame(
                CFrame.new(targetPosition) * CFrame.Angles(
                    math.rad(Workspace.DistributedGameTime * 12000),
                    math.rad(Workspace.DistributedGameTime * 15000),
                    math.rad(Workspace.DistributedGameTime * 18000)
                )
            )
        end)
        if newTargetHumanoid.Sit or tick() - startTime > 10 then
            running = false
            flingConnection:Disconnect()
            flingConnection = nil
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    pcall(function() part:SetNetworkOwner(nil) end)
                end
            end
            walkFlingInstance = Instance.new("BodyVelocity")
            walkFlingInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            walkFlingInstance.Velocity = Vector3.new(math.random(-5, 5), 5, math.random(-5, 5)).Unit * 1000000 + Vector3.new(0, 1000000, 0)
            walkFlingInstance.Parent = myHRP
            pcall(function()
                myHRP.Anchored = true
                myHRP.CFrame = CFrame.new(Vector3.new(-59599.73, 2040070.50, -293391.16))
                myHRP.Anchored = false
            end)
            local spinStart = tick()
            local spinConnection
            spinConnection = RunService.Heartbeat:Connect(function()
                if tick() - spinStart >= 0.5 then
                    spinConnection:Disconnect()
                    return
                end
                pcall(function()
                    character:SetPrimaryPartCFrame(
                        myHRP.CFrame * CFrame.Angles(
                            math.rad(Workspace.DistributedGameTime * 12000),
                            math.rad(Workspace.DistributedGameTime * 15000),
                            math.rad(Workspace.DistributedGameTime * 18000)
                        )
                    )
                end)
            end)
            task.wait(0.5)
            local args = { [1] = "PlayerWantsToDeleteTool", [2] = "Couch" }
            pcall(function()
                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
            end)
            pcall(function()
                myHRP.Anchored = true
                myHRP.CFrame = CFrame.new(savedPosition + Vector3.new(0, 5, 0))
                task.wait(0.2)
                myHRP.Velocity = Vector3.zero
                myHRP.RotVelocity = Vector3.zero
                myHRP.Anchored = false
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end)
            if walkFlingInstance then
                walkFlingInstance:Destroy()
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            if flingToggle then
                flingToggle:SetValue(false)
            end
        end
    end)
end


---------------------------------------------------------------------------------------------------------------------------------------------------------
                                                   --fling com bola--
---------------------------------------------------------------------------------------------------------------------------------------------------------

local function equipBola()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local bola = backpack:FindFirstChild("SoccerBall") or LocalPlayer.Character:FindFirstChild("SoccerBall")
    if not bola then
        local args = { [1] = "PickingTools", [2] = "SoccerBall" }
        local success = pcall(function()
            ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Too1l"):InvokeServer(unpack(args))
        end)
        if not success then return false end
        repeat
            bola = backpack:FindFirstChild("SoccerBall")
            task.wait()
        until bola or task.wait(5)
        if not bola then return false end
    end
    if bola.Parent ~= LocalPlayer.Character then
        bola.Parent = LocalPlayer.Character
    end
    return true
end

local function flingWithBall(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local myHRP = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not myHRP then return end
    if not equipBola() then return end
    task.wait(0.5)
    local args = { [1] = "PlayerWantsToDeleteTool", [2] = "SoccerBall" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
    end)
    local workspaceCom = Workspace:FindFirstChild("WorkspaceCom")
    if not workspaceCom then return end
    local soccerBalls = workspaceCom:FindFirstChild("001_SoccerBalls")
    if not soccerBalls then return end
    soccerBall = soccerBalls:FindFirstChild("Soccer" .. LocalPlayer.Name)
    if not soccerBall then return end
    originalProperties = {
        Anchored = soccerBall.Anchored,
        CanCollide = soccerBall.CanCollide,
        CanTouch = soccerBall.CanTouch
    }
    soccerBall.Anchored = false
    soccerBall.CanCollide = true
    soccerBall.CanTouch = true
    pcall(function() soccerBall:SetNetworkOwner(nil) end)
    savedPosition = myHRP.Position
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    if humanoid then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        humanoid.Sit = false
    end
    for _, seat in ipairs(Workspace:GetDescendants()) do
        if seat:IsA("Seat") or seat:IsA("VehicleSeat") then seat.Disabled = true end
    end
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clothe1s"):FireServer("CharacterSizeDown", 4)
    end)
    running = true
    local lastFlingTime = 0
    connection = RunService.Heartbeat:Connect(function()
        if not running or not targetPlayer.Character then return end
        local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local hum = targetPlayer.Character:FindFirstChild("Humanoid")
        local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp or not hum or not myHRP then return end
        local moveDir = hum.MoveDirection
        local isStill = moveDir.Magnitude < 0.1
        local isSitting = hum.Sit
        if isSitting then
            local y = math.sin(tick() * 50) * 2
            soccerBall.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 0.75 + y, 0))
        elseif isStill then
            local z = math.sin(tick() * 50) * 3
            soccerBall.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 0.75, z))
        else
            local offset = moveDir.Unit * math.clamp(hrp.Velocity.Magnitude * 0.15, 5, 12)
            soccerBall.CFrame = CFrame.new(hrp.Position + offset + Vector3.new(0, 0.75, 0))
        end
        myHRP.CFrame = CFrame.new(soccerBall.Position + Vector3.new(0, 1, 0))
    end)
    flingConnection = RunService.Heartbeat:Connect(function()
        if not running or not targetPlayer.Character then return end
        local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local dist = (soccerBall.Position - hrp.Position).Magnitude
        if dist < 4 and tick() - lastFlingTime > 0.4 then
            lastFlingTime = tick()
            for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            local fling = Instance.new("BodyVelocity")
            fling.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            fling.Velocity = Vector3.new(math.random(-5, 5), 5, math.random(-5, 5)).Unit * 500000 + Vector3.new(0, 250000, 0)
            fling.Parent = hrp
            task.delay(0.3, function()
                fling:Destroy()
                for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end)
        end
    end)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                  --fling bola v2--
------------------------------------------------------------------------------------------------------------------------------------------------------------


local function flingWithBallV2(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local myHRP = character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    if not equipBola() then return end
    task.wait(0.5)
    local args = { [1] = "PlayerWantsToDeleteTool", [2] = "SoccerBall" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
    end)
    local workspaceCom = Workspace:FindFirstChild("WorkspaceCom")
    if not workspaceCom then return end
    local soccerBalls = workspaceCom:FindFirstChild("001_SoccerBalls")
    if not soccerBalls then return end
    soccerBall = soccerBalls:FindFirstChild("Soccer" .. LocalPlayer.Name)
    if not soccerBall then return end
    originalProperties = {
        Anchored = soccerBall.Anchored,
        CanCollide = soccerBall.CanCollide,
        CanTouch = soccerBall.CanTouch
    }
    soccerBall.Anchored = false
    soccerBall.CanCollide = true
    soccerBall.CanTouch = true
    pcall(function() soccerBall:SetNetworkOwner(nil) end)
    savedPosition = myHRP.Position
    running = true
    local lastFlingTime = 0
    connection = RunService.Heartbeat:Connect(function()
        if not running or not targetPlayer.Character then return end
        local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local hum = targetPlayer.Character:FindFirstChild("Humanoid")
        if not hrp or not hum then return end
        local speed = hrp.Velocity.Magnitude
        local isMoving = hum.MoveDirection.Magnitude > 0.05
        local isJumping = hum:GetState() == Enum.HumanoidStateType.Jumping
        local offset
        if isMoving or isJumping then
            local extra = math.clamp(speed / 1.5, 6, 15)
            offset = hrp.CFrame.LookVector * extra + Vector3.new(0, 1, 0)
        else
            local wave = math.sin(tick() * 25) * 4
            local side = math.cos(tick() * 20) * 1.5
            offset = Vector3.new(side, 1, wave)
        end
        pcall(function()
            soccerBall.CFrame = CFrame.new(hrp.Position + offset)
            soccerBall.AssemblyLinearVelocity = Vector3.new(9999, 9999, 9999)
        end)
    end)
    flingConnection = RunService.Heartbeat:Connect(function()
        if not running or not targetPlayer.Character then return end
        local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local dist = (soccerBall.Position - hrp.Position).Magnitude
        if dist < 4 and tick() - lastFlingTime > 0.4 then
            lastFlingTime = tick()
            for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            local fling = Instance.new("BodyVelocity")
            fling.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            fling.Velocity = Vector3.new(math.random(-5, 5), 5, math.random(-5, 5)).Unit * 500000 + Vector3.new(0, 250000, 0)
            fling.Parent = hrp
            task.delay(0.3, function()
                fling:Destroy()
                for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end)
        end
    end)
end




-----------------------------------------------------------------------------------------------------------------------------------------------------
                                                   --fling com ônibus--
-----------------------------------------------------------------------------------------------------------------------------------------------------


local function flingWithBus(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then return end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local myHRP = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not myHRP then return end
    savedPosition = myHRP.Position
    pcall(function()
        myHRP.Anchored = true
        myHRP.CFrame = CFrame.new(Vector3.new(1181.83, 76.08, -1158.83))
        task.wait(0.2)
        myHRP.Velocity = Vector3.zero
        myHRP.RotVelocity = Vector3.zero
        myHRP.Anchored = false
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end)
    task.wait(0.5)

    disableCarClient()

    local args = { [1] = "DeleteAllVehicles" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)
    args = { [1] = "PickingCar", [2] = "SchoolBus" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)
    task.wait(1)
    local vehiclesFolder = Workspace:FindFirstChild("Vehicles")
    if not vehiclesFolder then return end
    local busName = LocalPlayer.Name .. "Car"
    local bus = vehiclesFolder:FindFirstChild(busName)
    if not bus then return end
    pcall(function()
        myHRP.Anchored = true
        myHRP.CFrame = CFrame.new(Vector3.new(1171.15, 79.45, -1166.2))
        task.wait(0.2)
        myHRP.Velocity = Vector3.zero
        myHRP.RotVelocity = Vector3.zero
        myHRP.Anchored = false
        humanoid:ChangeState(Enum.HumanoidStateType.Seated)
    end)
    local sitStart = tick()
    repeat
        task.wait()
        if tick() - sitStart > 10 then return end
    until humanoid.Sit
    for _, part in ipairs(bus:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            pcall(function() part:SetNetworkOwner(nil) end)
        end
    end
    running = true
    connection = RunService.Stepped:Connect(function()
        if not running then return end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
    local startTime = tick()
    local walkFlingInstancePlayer = nil
    flingConnection = RunService.Heartbeat:Connect(function()
        if not running then return end
        if not targetPlayer or not targetPlayer.Character then running = false return end
        local newTargetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local newTargetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
        if not newTargetHRP or not newTargetHumanoid then running = false return end
        if not myHRP or not humanoid then running = false return end
        local offset = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
        pcall(function()
            local targetPosition = newTargetHRP.Position + offset
            bus:PivotTo(
                CFrame.new(targetPosition) * CFrame.Angles(
                    math.rad(Workspace.DistributedGameTime * 12000),
                    math.rad(Workspace.DistributedGameTime * 15000),
                    math.rad(Workspace.DistributedGameTime * 18000)
                )
            )
        end)
        local playerSeated = false
        for _, seat in ipairs(bus:GetDescendants()) do
            if (seat:IsA("Seat") or seat:IsA("VehicleSeat")) and seat.Name ~= "VehicleSeat" then
                if seat.Occupant == newTargetHumanoid then
                    playerSeated = true
                    break
                end
            end
        end
        if playerSeated or tick() - startTime > 10 then
            running = false
            flingConnection:Disconnect()
            flingConnection = nil
            pcall(function()
                bus:PivotTo(CFrame.new(Vector3.new(-59599.73, 2040070.50, -293391.16)))
            end)

            walkFlingInstancePlayer = Instance.new("BodyVelocity")
            walkFlingInstancePlayer.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            walkFlingInstancePlayer.Velocity = Vector3.new(math.random(-5, 5), 5, math.random(-5, 5)).Unit * 1000000 + Vector3.new(0, 1000000, 0)
            walkFlingInstancePlayer.Parent = myHRP
            task.wait(0.5)

            disableCarClient()

            local args = { [1] = "DeleteAllVehicles" }
            pcall(function()
                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
            end)
            if walkFlingInstancePlayer then
                walkFlingInstancePlayer:Destroy()
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
            pcall(function()
                myHRP.Anchored = true
                myHRP.CFrame = CFrame.new(savedPosition + Vector3.new(0, 5, 0))
                task.wait(0.2)
                myHRP.Velocity = Vector3.zero
                myHRP.RotVelocity = Vector3.zero
                myHRP.Anchored = false
                if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
            end)
            if flingToggle then flingToggle:Set(false) end
        end
    end)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------
                                                   --fling com barco--
-----------------------------------------------------------------------------------------------------------------------------------------------------------

local function flingWithBoat(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then return end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local myHRP = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not myHRP then return end
    savedPosition = myHRP.Position
    pcall(function()
        myHRP.Anchored = true
        myHRP.CFrame = CFrame.new(Vector3.new(-3359.52, -5.05, -501.94))
        task.wait(0.2)
        myHRP.Velocity = Vector3.zero
        myHRP.RotVelocity = Vector3.zero
        myHRP.Anchored = false
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end)

    disableCarClient()

    local args = { [1] = "DeleteAllVehicles" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)
    task.wait(0.4)
    args = { [1] = "PickingBoat", [2] = "MilitaryBoatFree" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)
    task.wait(1.5)
    local vehiclesFolder = Workspace:FindFirstChild("Vehicles")
    if not vehiclesFolder then return end
    local boatName = LocalPlayer.Name .. "Car"
    local boat = vehiclesFolder:FindFirstChild(boatName)
    if not boat then return end
    pcall(function()
        myHRP.Anchored = true
        myHRP.CFrame = CFrame.new(Vector3.new(-3358.85, 5.25, -521.95))
        task.wait(0.2)
        myHRP.Velocity = Vector3.zero
        myHRP.RotVelocity = Vector3.zero
        myHRP.Anchored = false
        humanoid:ChangeState(Enum.HumanoidStateType.Seated)
    end)
    local sitStart = tick()
    repeat
        task.wait()
        if tick() - sitStart > 10 then return end
    until humanoid.Sit
    for _, part in ipairs(boat:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            pcall(function() part:SetNetworkOwner(nil) end)
        end
    end
    running = true
    connection = RunService.Stepped:Connect(function()
        if not running then return end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
    local startTime = tick()
    flingConnection = RunService.Heartbeat:Connect(function()
        if not running then return end
        if not targetPlayer or not targetPlayer.Character then running = false return end
        local newTargetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local newTargetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
        if not newTargetHRP or not newTargetHumanoid then running = false return end
        if not myHRP or not humanoid then running = false return end
        local offset = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
        pcall(function()
            local targetPosition = newTargetHRP.Position + offset
            boat:PivotTo(
                CFrame.new(targetPosition) * CFrame.Angles(
                    math.rad(Workspace.DistributedGameTime * 12000),
                    math.rad(Workspace.DistributedGameTime * 15000),
                    math.rad(Workspace.DistributedGameTime * 18000)
                )
            )
        end)
        local playerSeated = false
        for _, seat in ipairs(boat:GetDescendants()) do
            if (seat:IsA("Seat") or seat:IsA("VehicleSeat")) and seat.Name ~= "VehicleSeat" then
                if seat.Occupant == newTargetHumanoid then
                    playerSeated = true
                    break
                end
            end
        end
        if playerSeated or tick() - startTime > 10 then
            running = false
            if connection then connection:Disconnect() connection = nil end
            if flingConnection then flingConnection:Disconnect() flingConnection = nil end
            pcall(function()
                boat:PivotTo(CFrame.new(Vector3.new(-76.6, -401.97, -84.26)))
            end)
            task.wait(0.5)

            disableCarClient()

            local args = { [1] = "DeleteAllVehicles" }
            pcall(function()
                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
            end)
            if character then
                local myHRP = character:FindFirstChild("HumanoidRootPart")
                if myHRP and savedPosition then
                    pcall(function()
                        myHRP.Anchored = true
                        myHRP.CFrame = CFrame.new(savedPosition + Vector3.new(0, 5, 0))
                        task.wait(0.2)
                        myHRP.Velocity = Vector3.zero
                        myHRP.RotVelocity = Vector3.zero
                        myHRP.Anchored = false
                        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
                    end)
                end
            end
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                        part.Velocity = Vector3.zero
                        part.RotVelocity = Vector3.zero
                    end
                end
            end
            local myHumanoid = character and character:FindFirstChild("Humanoid")
            if myHumanoid then myHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
            for _, seat in ipairs(Workspace:GetDescendants()) do
                if seat:IsA("Seat") or seat:IsA("VehicleSeat") then seat.Disabled = false end
            end
            pcall(function()
                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clothe1s"):FireServer("CharacterSizeUp", 1)
            end)
            if flingToggle then flingToggle:Set(false) end
        end
    end)
end



------------------------------------------------------------------------------------------------------------------------------------------------
                                      --fling com caminhão--
------------------------------------------------------------------------------------------------------------------------------------------------


local function flingWithTruck(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then return end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local myHRP = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not myHRP then return end
    savedPosition = myHRP.Position

    -- Teletransporta para a posição inicial do ônibus para invocar o caminhão
    pcall(function()
        myHRP.Anchored = true
        myHRP.CFrame = CFrame.new(Vector3.new(1181.83, 76.08, -1158.83))
        task.wait(0.2)
        myHRP.Velocity = Vector3.zero
        myHRP.RotVelocity = Vector3.zero
        myHRP.Anchored = false
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end)
    task.wait(0.5)

    -- Desativa o cliente de carro para evitar interferências
    disableCarClient()

    -- Deleta qualquer veículo existente
    local args = { [1] = "DeleteAllVehicles" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)

    -- Invoca o caminhão (Semi) usando o comando fornecido
    args = { [1] = "PickingCar", [2] = "Semi" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)
    task.wait(1)

    -- Encontra o caminhão invocado
    local vehiclesFolder = Workspace:FindFirstChild("Vehicles")
    if not vehiclesFolder then return end
    local truckName = LocalPlayer.Name .. "Car"
    local truck = vehiclesFolder:FindFirstChild(truckName)
    if not truck then return end

    -- Teletransporta para a posição do assento do caminhão
    pcall(function()
        myHRP.Anchored = true
        myHRP.CFrame = CFrame.new(Vector3.new(1176.56, 79.90, -1166.65))
        task.wait(0.2)
        myHRP.Velocity = Vector3.zero
        myHRP.RotVelocity = Vector3.zero
        myHRP.Anchored = false
        humanoid:ChangeState(Enum.HumanoidStateType.Seated)
    end)

    -- Espera o jogador sentar no caminhão
    local sitStart = tick()
    repeat
        task.wait()
        if tick() - sitStart > 10 then return end
    until humanoid.Sit

    -- Desativa a colisão das partes do caminhão e define a posse de rede
    for _, part in ipairs(truck:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            pcall(function() part:SetNetworkOwner(nil) end)
        end
    end

    -- Inicia o processo de fling
    running = true
    connection = RunService.Stepped:Connect(function()
        if not running then return end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)

    local startTime = tick()
    local lastFlingTime = 0
    flingConnection = RunService.Heartbeat:Connect(function()
        if not running then return end
        if not targetPlayer or not targetPlayer.Character then running = false return end
        local newTargetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local newTargetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
        if not newTargetHRP or not newTargetHumanoid then running = false return end
        if not myHRP or not humanoid then running = false return end

        -- Encontra a parte Trailer para o fling
        local trailer = truck:FindFirstChild("Body") and truck.Body:FindFirstChild("Trailer")
        if not trailer then return end

        -- Faz o trailer se mover para cima e para baixo muito rapidamente
        local verticalOffset = math.sin(tick() * 30) * 5 -- Oscila entre -5 e 5 unidades na vertical, ainda mais rápido
        pcall(function()
            local targetPosition = newTargetHRP.Position + Vector3.new(0, verticalOffset, 0)
            trailer:PivotTo(CFrame.new(targetPosition)) -- Apenas movimento vertical, sem rotação
        end)

        -- Verifica a distância entre o trailer e o jogador-alvo para aplicar o fling
        local dist = (trailer.Position - newTargetHRP.Position).Magnitude
        if dist < 5 and tick() - lastFlingTime > 0.4 then -- Aplica o fling se o jogador estiver a menos de 5 unidades
            lastFlingTime = tick()
            for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            -- Aplica um fling extremamente forte
            local fling = Instance.new("BodyVelocity")
            fling.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            fling.Velocity = Vector3.new(math.random(-10, 10), 50, math.random(-10, 10)).Unit * 10000000 + Vector3.new(0, 5000000, 0)
            fling.Parent = newTargetHRP
            task.delay(0.5, function()
                fling:Destroy()
                for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end)
        end

        -- Para o fling se o jogador-alvo estiver sentado ou após 10 segundos
        local playerSeated = false
        for _, seat in ipairs(truck:GetDescendants()) do
            if (seat:IsA("Seat") or seat:IsA("VehicleSeat")) and seat.Name ~= "VehicleSeat" then
                if seat.Occupant == newTargetHumanoid then
                    playerSeated = true
                    break
                end
            end
        end

        if playerSeated or tick() - startTime > 10 then
            running = false
            if connection then connection:Disconnect() connection = nil end
            if flingConnection then flingConnection:Disconnect() flingConnection = nil end

            -- Teletransporta o caminhão para uma posição fora do mapa
            pcall(function()
                truck:PivotTo(CFrame.new(Vector3.new(-59599.73, 2040070.50, -293391.16)))
            end)
            task.wait(0.5)

            -- Limpeza: Deleta o caminhão e reseta o jogador
            disableCarClient()
            local args = { [1] = "DeleteAllVehicles" }
            pcall(function()
                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
            end)

            if character then
                local myHRP = character:FindFirstChild("HumanoidRootPart")
                if myHRP and savedPosition then
                    pcall(function()
                        myHRP.Anchored = true
                        myHRP.CFrame = CFrame.new(savedPosition + Vector3.new(0, 5, 0))
                        task.wait(0.2)
                        myHRP.Velocity = Vector3.zero
                        myHRP.RotVelocity = Vector3.zero
                        myHRP.Anchored = false
                        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
                    end)
                end
            end

            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                        part.Velocity = Vector3.zero
                        part.RotVelocity = Vector3.zero
                    end
                end
            end

            local myHumanoid = character and character:FindFirstChild("Humanoid")
            if myHumanoid then myHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
            for _, seat in ipairs(Workspace:GetDescendants()) do
                if seat:IsA("Seat") or seat:IsA("VehicleSeat") then seat.Disabled = false end
            end
            pcall(function()
                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clothe1s"):FireServer("CharacterSizeUp", 1)
            end)

            if flingToggle then flingToggle:Set(false) end
        end
    end)
end



------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------



local function stopFling()
    running = false
    if connection then
        connection:Disconnect()
        connection = nil
    end
    if flingConnection then
        flingConnection:Disconnect()
        flingConnection = nil
    end
    if soccerBall then
        soccerBall.Anchored = originalProperties.Anchored
        soccerBall.CanCollide = originalProperties.CanCollide
        soccerBall.CanTouch = originalProperties.CanTouch
    end
    if couch and couch:IsA("BasePart") then
        couch.Anchored = originalProperties.Anchored
        couch.CanCollide = originalProperties.CanCollide
        couch.CanTouch = originalProperties.CanTouch
    end

    disableCarClient()

    local args = { [1] = "DeleteAllVehicles" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
    end)
    task.wait(0.2)
    local character = LocalPlayer.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.Velocity = Vector3.zero
                part.RotVelocity = Vector3.zero
            end
        end
    end
    local myHumanoid = character and character:FindFirstChild("Humanoid")
    if myHumanoid then myHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
    for _, seat in ipairs(Workspace:GetDescendants()) do
        if seat:IsA("Seat") or seat:IsA("VehicleSeat") then seat.Disabled = false end
    end
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clothe1s"):FireServer("CharacterSizeUp", 1)
    end)
    if savedPosition then
        local myHRP = character and character:FindFirstChild("HumanoidRootPart")
        if myHRP then
            pcall(function()
                myHRP.Anchored = true
                myHRP.CFrame = CFrame.new(savedPosition + Vector3.new(0, 5, 0))
                task.wait(0.2)
                myHRP.Velocity = Vector3.zero
                myHRP.RotVelocity = Vector3.zero
                myHRP.Anchored = false
                if myHumanoid then myHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
            end)
        end
    end
end

 
                
flingToggle = Tab9:AddToggle({
    Name = "Ativar Fling",
    Description = "Ativa ou desativa o fling com o método selecionado",
    Default = false,
    Callback = function(state)
        if state then
            if isFollowingKill or isFollowingPull or running then
                flingToggle:Set(false)
                return
            end
            if selectedFlingMethod == "Sofá" then
                flingWithSofa(selectedPlayer)
            elseif selectedFlingMethod == "Bola" then
                flingWithBall(selectedPlayer)
            elseif selectedFlingMethod == "Bola V2" then
                flingWithBallV2(selectedPlayer)
            elseif selectedFlingMethod == "Barco" then
                flingWithBoat(selectedPlayer)
            elseif selectedFlingMethod == "Caminhão" then
                flingWithTruck(selectedPlayer)
            elseif selectedFlingMethod == "Ônibus" then
                flingWithBus(selectedPlayer)
            end
        else
            stopFling()
        end
    end
})

local Section = Tab9:AddSection({" fling ALL e desligue os RGB antes de usar"})

-- Variáveis globais no início do Tab2
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

orbitando = false
orbitConn = nil
allFling = false
allConn = nil
currentPlayerList = nil
currentPlayerIndex = nil
lastSwitchTime = nil
allFling2 = false
allConn2 = nil
soccerBall = nil
originalProperties = nil
excludedPlayers = {} -- Tabela para jogadores excluídos dos flings

-- Função auxiliar para obter a foto de perfil do jogador
local function getPlayerThumbnail(userId)
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local success, result = pcall(function()
        return Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
    end)
    if success then
        return result
    else
        warn("Erro ao obter thumbnail: " .. tostring(result))
        return nil
    end
end

-- Função auxiliar para encontrar jogador por parte do nome
local function findPlayerByPartialName(partialName)
    partialName = partialName:lower()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Name:lower():find(partialName) then
            return plr
        end
    end
    return nil
end

-- Função para exibir notificação
local function showNotification(title, description, icon)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = description,
            Icon = icon or "",
            Duration = 5
        })
    end)
end

-- TextBox para excluir jogador
Tab9:AddTextBox({
    Name = "adicionar jogador na whaitelist",
    Description = "Digite parte do nome do jogador",
    PlaceholderText = "Ex.: rt para (player123)",
    Callback = function(Value)
        if Value == "" then
            showNotification("Nenhuma Ação", "Digite um nome para adicionar um jogador.", nil)
            return
        end

        local player = findPlayerByPartialName(Value)
        if player then
            -- Verifica se o jogador já está excluído
            for _, excluded in ipairs(excludedPlayers) do
                if excluded == player then
                    showNotification("Jogador Já esta na whaitelist", "Jogador " .. player.Name .. " já foi adicionado.", getPlayerThumbnail(player.UserId))
                    return
                end
            end
            table.insert(excludedPlayers, player)
            local thumbnail = getPlayerThumbnail(player.UserId)
            showNotification("Jogador adicionado", "Jogador " .. player.Name .. " foi removido dos flings.", thumbnail)
        else
            showNotification("Jogador Não Encontrado", "Nenhum jogador encontrado com '" .. Value .. "'.", nil)
        end
    end
})

-- Botão para verificar jogadores excluídos
Tab9:AddButton({"Verificar Excluídos", function()
    if #excludedPlayers == 0 then
        showNotification("Nenhum na whaitelist", "Nenhum jogador está removido dos flings.", nil)
        return
    end
    for i, player in ipairs(excludedPlayers) do
        local thumbnail = getPlayerThumbnail(player.UserId)
        showNotification("Jogador adicionado " .. i, "Jogador " .. player.Name .. " está removido dos flings.", thumbnail)
        task.wait(0.5) -- Pequeno atraso entre notificações para evitar sobreposição
    end
end})

-- Botão para remover todos os jogadores excluídos
Tab9:AddButton({"Remover Excluídos", function()
    if #excludedPlayers == 0 then
        showNotification("Nenhum removido", "Nenhum jogador para remover da whaitelist.", nil)
        return
    end
    excludedPlayers = {}
    showNotification("whaitelists Removidas", "Todos os jogadores foram removidos da whaitelist.", nil)
end})

-- Bola Fling Orbitando
Tab9:AddButton({"Bola Fling Orbitando", function()
    if orbitando then return end
    if not equipBola() then return end
    task.wait(0.5)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local myHRP = character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    local workspaceCom = Workspace:FindFirstChild("WorkspaceCom")
    local soccerBalls = workspaceCom and workspaceCom:FindFirstChild("001_SoccerBalls")
    soccerBall = soccerBalls and soccerBalls:FindFirstChild("Soccer" .. LocalPlayer.Name)
    if not soccerBall then return end
    originalProperties = {
        Anchored = soccerBall.Anchored,
        CanCollide = soccerBall.CanCollide,
        CanTouch = soccerBall.CanTouch
    }
    soccerBall.Anchored = false
    soccerBall.CanCollide = true
    soccerBall.CanTouch = true
    pcall(function() soccerBall:SetNetworkOwner(nil) end)
    orbitando = true
    orbitConn = RunService.Heartbeat:Connect(function()
        if not orbitando or not soccerBall or not soccerBall.Parent or not myHRP or not myHRP.Parent or not character or not character.Parent then
            if orbitConn then
                orbitConn:Disconnect()
                orbitConn = nil
            end
            orbitando = false
            if soccerBall and originalProperties then
                soccerBall.Anchored = originalProperties.Anchored
                soccerBall.CanCollide = originalProperties.CanCollide
                soccerBall.CanTouch = originalProperties.CanTouch
            end
            soccerBall = nil
            originalProperties = nil
            return
        end
        local t = tick() * 10
        local radius = 3
        local offset = Vector3.new(math.cos(t) * radius, -1, math.sin(t) * radius)
        soccerBall.CFrame = CFrame.new(myHRP.Position + offset)
        soccerBall.AssemblyLinearVelocity = Vector3.new(9999, 9999, 9999)
    end)
end})

-- Fling Bola ALL V1
Tab9:AddButton({"Fling Bola ALL V1", function()
    if allFling then return end
    if not equipBola() then return end
    task.wait(0.5)
    local args = { [1] = "PlayerWantsToDeleteTool", [2] = "SoccerBall" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
    end)
    local workspaceCom = Workspace:FindFirstChild("WorkspaceCom")
    local soccerBalls = workspaceCom and workspaceCom:FindFirstChild("001_SoccerBalls")
    soccerBall = soccerBalls and soccerBalls:FindFirstChild("Soccer" .. LocalPlayer.Name)
    if not soccerBall then return end
    originalProperties = {
        Anchored = soccerBall.Anchored,
        CanCollide = soccerBall.CanCollide,
        CanTouch = soccerBall.CanTouch
    }
    soccerBall.Anchored = false
    soccerBall.CanCollide = true
    soccerBall.CanTouch = true
    pcall(function() soccerBall:SetNetworkOwner(nil) end)
    allFling = true

    local function getShuffledPlayers()
        local playerList = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            local isExcluded = false
            for _, excluded in ipairs(excludedPlayers) do
                if plr == excluded then
                    isExcluded = true
                    break
                end
            end
            if plr ~= LocalPlayer and not isExcluded and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                table.insert(playerList, plr)
            end
        end
        for i = #playerList, 2, -1 do
            local j = math.random(i)
            playerList[i], playerList[j] = playerList[j], playerList[i]
        end
        return playerList
    end

    allConn = RunService.Heartbeat:Connect(function()
        if not allFling or not soccerBall or not soccerBall.Parent then
            if allConn then
                allConn:Disconnect()
                allConn = nil
            end
            allFling = false
            if soccerBall and originalProperties then
                soccerBall.Anchored = originalProperties.Anchored
                soccerBall.CanCollide = originalProperties.CanCollide
                soccerBall.CanTouch = originalProperties.CanTouch
            end
            soccerBall = nil
            originalProperties = nil
            currentPlayerList = nil
            currentPlayerIndex = nil
            lastSwitchTime = nil
            return
        end

        if not currentPlayerList or #currentPlayerList == 0 then
            currentPlayerList = getShuffledPlayers()
            currentPlayerIndex = 1
            lastSwitchTime = tick()
        end

        if #currentPlayerList == 0 then
            return
        end

        if tick() - lastSwitchTime >= 4 then
            currentPlayerIndex = currentPlayerIndex + 1
            if currentPlayerIndex > #currentPlayerList then
                currentPlayerList = getShuffledPlayers()
                currentPlayerIndex = 1
            end
            lastSwitchTime = tick()
        end

        local target = currentPlayerList[currentPlayerIndex]
        if not target or not target.Character then
            return
        end

        local targetChar = target.Character
        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("Humanoid") then
            local hrp = targetChar.HumanoidRootPart
            local humanoid = targetChar.Humanoid
            local velocity = hrp.Velocity
            local speed = velocity.Magnitude
            local isJumping = humanoid:GetState() == Enum.HumanoidStateType.Jumping
            local isMoving = humanoid.MoveDirection.Magnitude > 0.05
            local offset
            if isMoving or isJumping then
                local moveDir = hrp.CFrame.LookVector
                local extraDist = math.clamp(speed / 1.5, 6, 18)
                offset = moveDir * extraDist + Vector3.new(0, 1, 0)
            else
                local waveZ = math.sin(tick() * 25) * 4
                local sideX = math.cos(tick() * 20) * 1.5
                offset = Vector3.new(sideX, 1, waveZ)
            end
            soccerBall.CFrame = CFrame.new(hrp.Position + offset)
            soccerBall.AssemblyLinearVelocity = Vector3.new(9999, 9999, 9999)
            if (soccerBall.Position - hrp.Position).Magnitude < 4 then
                local fling = Instance.new("BodyVelocity")
                fling.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                fling.Velocity = Vector3.new(math.random(-5, 5), 5, math.random(-5, 5)).Unit * 500000 + Vector3.new(0, 250000, 0)
                fling.Parent = hrp
                task.delay(0.3, function()
                    fling:Destroy()
                end)
            end
        end
    end)
end})

-- Fling Bola ALL V2
Tab9:AddButton({"Fling Bola ALL V2", function()
    if allFling2 then return end
    if not equipBola() then return end
    task.wait(0.5)
    local args = { [1] = "PlayerWantsToDeleteTool", [2] = "SoccerBall" }
    pcall(function()
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
    end)
    local workspaceCom = Workspace:FindFirstChild("WorkspaceCom")
    local soccerBalls = workspaceCom and workspaceCom:FindFirstChild("001_SoccerBalls")
    soccerBall = soccerBalls and soccerBalls:FindFirstChild("Soccer" .. LocalPlayer.Name)
    if not soccerBall then return end
    originalProperties = {
        Anchored = soccerBall.Anchored,
        CanCollide = soccerBall.CanCollide,
        CanTouch = soccerBall.CanTouch
    }
    soccerBall.Anchored = false
    soccerBall.CanCollide = true
    soccerBall.CanTouch = true
    pcall(function() soccerBall:SetNetworkOwner(nil) end)
    allFling2 = true
    allConn2 = RunService.Heartbeat:Connect(function()
        if not allFling2 or not soccerBall or not soccerBall.Parent then
            if allConn2 then
                allConn2:Disconnect()
                allConn2 = nil
            end
            allFling2 = false
            if soccerBall and originalProperties then
                soccerBall.Anchored = originalProperties.Anchored
                soccerBall.CanCollide = originalProperties.CanCollide
                soccerBall.CanTouch = originalProperties.CanTouch
            end
            soccerBall = nil
            originalProperties = nil
            return
        end
        local playerList = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            local isExcluded = false
            for _, excluded in ipairs(excludedPlayers) do
                if plr == excluded then
                    isExcluded = true
                    break
                end
            end
            if plr ~= LocalPlayer and not isExcluded and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                table.insert(playerList, plr)
            end
        end
        for i = #playerList, 2, -1 do
            local j = math.random(i)
            playerList[i], playerList[j] = playerList[j], playerList[i]
        end
        for _, target in ipairs(playerList) do
            if not allFling2 then break end
            local targetChar = target.Character
            if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("Humanoid") then
                local hrp = targetChar.HumanoidRootPart
                local humanoid = targetChar.Humanoid
                local velocity = hrp.Velocity
                local speed = velocity.Magnitude
                local isJumping = humanoid:GetState() == Enum.HumanoidStateType.Jumping
                local isMoving = humanoid.MoveDirection.Magnitude > 0.05
                local offset
                if isMoving or isJumping then
                    local moveDir = hrp.CFrame.LookVector
                    local extraDist = math.clamp(speed / 1.5, 6, 18)
                    offset = moveDir * extraDist + Vector3.new(0, 1, 0)
                else
                    local waveZ = math.sin(tick() * 25) * 4
                    local sideX = math.cos(tick() * 20) * 1.5
                    offset = Vector3.new(sideX, 1, waveZ)
                end
                soccerBall.CFrame = CFrame.new(hrp.Position + offset)
                soccerBall.AssemblyLinearVelocity = Vector3.new(9999, 9999, 9999)
                if (soccerBall.Position - hrp.Position).Magnitude < 4 then
                    local fling = Instance.new("BodyVelocity")
                    fling.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    fling.Velocity = Vector3.new(math.random(-5, 5), 5, math.random(-5, 5)).Unit * 1000000 + Vector3.new(0, 1000000, 0)
                    fling.Parent = hrp
                    task.delay(0.3, function()
                        fling:Destroy()
                    end)
                end
            end
            task.wait(0.1)
        end
    end)
end})

-- Parar Tudo
Tab9:AddButton({"Parar Tudo", function()
    -- Parar Orbitando
    orbitando = false
    if orbitConn then
        orbitConn:Disconnect()
        orbitConn = nil
    end
    -- Parar Fling ALL V1
    allFling = false
    if allConn then
        allConn:Disconnect()
        allConn = nil
    end
    currentPlayerList = nil
    currentPlayerIndex = nil
    lastSwitchTime = nil
    -- Parar Fling ALL V2
    allFling2 = false
    if allConn2 then
        allConn2:Disconnect()
        allConn2 = nil
    end
    -- Restaurar propriedades da bola
    if soccerBall and originalProperties then
        soccerBall.Anchored = originalProperties.Anchored
        soccerBall.CanCollide = originalProperties.CanCollide
        soccerBall.CanTouch = originalProperties.CanTouch
    end
    soccerBall = nil
    originalProperties = nil
    showNotification("Tudo Parado", "Todas as funções foram desativadas.", nil)
end})










local Tab = Window:MakeTab({"Rgb", "brush"})

local isNameActive = false
local isBioActive = false
local isNameBioActive = false
local rgbSpeed = 0.7 -- Valor padrão do slider

local SectionRGBName = Tab:AddSection({
    Name = "Nome Rgb"
})

Tab:AddToggle({
    Name = "Nome Rgb",
    Default = false,
    Callback = function(value)
        isNameActive = value
        print(value and "RGB Name ativado" or "RGB Name desativado")
    end
})

local SectionRGBBio = Tab:AddSection({
    Name = "Descrição Rgb"
})

Tab:AddToggle({
    Name = "Descrição Rgb",
    Default = false,
    Callback = function(value)
        isBioActive = value
        print(value and "RGB BIO ativado" or "RGB BIO desativado")
    end
})


