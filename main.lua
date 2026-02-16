--[[
    BIELZIN HUB V8 - INTEGRATED SYSTEM
    - Loader MakalHub Style
    - Fly System (V8 Engine)
    - God Mode (Invencibilidade)
    - Wall Hack (ESP Highlight)
    - Instant Collect (Bypass)
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Configurações de Estado
local FLYING = false
local flySpeed = 50
local godMode = false
local wallHack = false
local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local bodyGyro, bodyVelocity

-- Limpeza de UI anterior
if CoreGui:FindFirstChild("BIELZIN_V8") then CoreGui["BIELZIN_V8"]:Destroy() end

-- Criando ScreenGui principal
local MainGui = Instance.new("ScreenGui", CoreGui)
MainGui.Name = "BIELZIN_V8"
MainGui.ResetOnSpawn = false

--- ========================================== ---
---              SISTEMA DE LOADER             ---
--- ========================================== ---

local LoaderFrame = Instance.new("Frame", MainGui)
LoaderFrame.Size = UDim2.new(0, 300, 0, 100)
LoaderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoaderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoaderFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", LoaderFrame)
local LStroke = Instance.new("UIStroke", LoaderFrame)
LStroke.Color = Color3.fromRGB(140, 0, 255)

local LTitle = Instance.new("TextLabel", LoaderFrame)
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.Text = "BIELZIN HUB V8"
LTitle.TextColor3 = Color3.white
LTitle.Font = Enum.Font.GothamBold
LTitle.TextSize = 18
LTitle.BackgroundTransparency = 1

local BarBack = Instance.new("Frame", LoaderFrame)
BarBack.Size = UDim2.new(0.8, 0, 0, 4)
BarBack.Position = UDim2.new(0.1, 0, 0.7, 0)
BarBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", BarBack)

local BarFill = Instance.new("Frame", BarBack)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
Instance.new("UICorner", BarFill)

--- ========================================== ---
---             PAINEL PRINCIPAL V8            ---
--- ========================================== ---

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 240)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)
local MStroke = Instance.new("UIStroke", MainFrame)
MStroke.Color = Color3.fromRGB(140, 0, 255)

-- Função para Criar Botões Estilo V8
local function createButton(text, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(40, 42, 48)
    btn.Text = text
    btn.TextColor3 = Color3.white
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Botões e Funções
local flyBtn = createButton("Fly: OFF", UDim2.new(0.05, 0, 0.15, 0), function()
    FLYING = not FLYING
    _G.btnFly.Text = FLYING and "Fly: ON" or "Fly: OFF"
    _G.btnFly.BackgroundColor3 = FLYING and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 42, 48)
    if FLYING then startFly() end
end)
_G.btnFly = flyBtn

local godBtn = createButton("God Mode: OFF", UDim2.new(0.05, 0, 0.35, 0), function()
    godMode = not godMode
    _G.btnGod.Text = godMode and "God Mode: ON" or "God Mode: OFF"
    _G.btnGod.BackgroundColor3 = godMode and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 42, 48)
end)
_G.btnGod = godBtn

local whBtn = createButton("Wall Hack: OFF", UDim2.new(0.05, 0, 0.55, 0), function()
    wallHack = not wallHack
    _G.btnWH.Text = wallHack and "Wall Hack: ON" or "Wall Hack: OFF"
    _G.btnWH.BackgroundColor3 = wallHack and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 42, 48)
end)
_G.btnWH = whBtn

-- Slider de Velocidade
local SpeedLabel = Instance.new("TextLabel", MainFrame)
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0, 0, 0.75, 0)
SpeedLabel.Text = "Fly Speed: 50"
SpeedLabel.TextColor3 = Color3.white
SpeedLabel.BackgroundTransparency = 1

local btnAdd = createButton("+", UDim2.new(0.55, 0, 0.85, 0), function() flySpeed = flySpeed + 10 SpeedLabel.Text = "Fly Speed: "..flySpeed end)
btnAdd.Size = UDim2.new(0.4, 0, 0, 30)

local btnSub = createButton("-", UDim2.new(0.05, 0, 0.85, 0), function() flySpeed = math.max(10, flySpeed - 10) SpeedLabel.Text = "Fly Speed: "..flySpeed end)
btnSub.Size = UDim2.new(0.4, 0, 0, 30)

--- ========================================== ---
---               LÓGICAS TÉCNICAS             ---
--- ========================================== ---

-- Função de Voo (Engine V8)
function startFly()
    local root = player.Character:WaitForChild("HumanoidRootPart")
    bodyGyro = Instance.new("BodyGyro", root)
    bodyGyro.P = 9e4; bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9); bodyGyro.CFrame = root.CFrame
    bodyVelocity = Instance.new("BodyVelocity", root)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0); bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    player.Character.Humanoid.PlatformStand = true
    
    task.spawn(function()
        repeat
            task.wait()
            local cam = workspace.CurrentCamera
            bodyVelocity.Velocity = ((cam.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((cam.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.Q + CONTROL.E) * 0.2, 0).Position) - cam.CFrame.Position)).Unit * flySpeed
            bodyGyro.CFrame = cam.CFrame
        until not FLYING
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
        player.Character.Humanoid.PlatformStand = false
    end)
end

-- Input para Voo
UserInputService.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.W then CONTROL.F = 1
    elseif i.KeyCode == Enum.KeyCode.S then CONTROL.B = -1
    elseif i.KeyCode == Enum.KeyCode.A then CONTROL.L = -1
    elseif i.KeyCode == Enum.KeyCode.D then CONTROL.R = 1
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.W then CONTROL.F = 0
    elseif i.KeyCode == Enum.KeyCode.S then CONTROL.B = 0
    elseif i.KeyCode == Enum.KeyCode.A then CONTROL.L = 0
    elseif i.KeyCode == Enum.KeyCode.D then CONTROL.R = 0
    end
end)

-- God Mode & ESP Loops
RunService.Stepped:Connect(function()
    if godMode and player.Character then
        local h = player.Character:FindFirstChild("Humanoid")
        if h then h.Health = h.MaxHealth end
    end
end)

local function applyESP(p)
    local h = Instance.new("Highlight")
    RunService.RenderStepped:Connect(function()
        if wallHack and p.Character then h.Parent = p.Character h.FillColor = Color3.fromRGB(140, 0, 255) else h.Parent = nil end
    end)
end
for _, p in pairs(Players:GetPlayers()) do if p ~= player then applyESP(p) end end
Players.PlayerAdded:Connect(applyESP)

-- Coleta Instantânea (Bypass)
task.spawn(function()
    local function b(p) if p:IsA("ProximityPrompt") then p.HoldDuration = 0 end end
    for _, v in pairs(game:GetDescendants()) do b(v) end
    game.DescendantAdded:Connect(b)
end)

-- Loader Sequence
MainFrame.Draggable = true
MainFrame.Active = true

task.spawn(function()
    TweenService:Create(BarFill, TweenInfo.new(2), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(2.2)
    LoaderFrame:Destroy()
    MainFrame.Visible = true
end)
