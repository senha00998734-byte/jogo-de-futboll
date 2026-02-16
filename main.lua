--[[
    BIELZIN HUB V8 - FINAL VERSION
    - Estilo: MakalHub (Loader) + V8 Engine
    - Funções: Fly, God Mode, WallHack e Coleta Instantânea
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

--// Variáveis de Configuração
local FLYING = false
local flySpeed = 50
local godMode = false
local wallHack = false
local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local bodyGyro, bodyVelocity

--// Limpeza de UI anterior para não travar
if CoreGui:FindFirstChild("BIELZIN_V8") then CoreGui["BIELZIN_V8"]:Destroy() end

--// Criando a ScreenGui principal
local MainGui = Instance.new("ScreenGui", CoreGui)
MainGui.Name = "BIELZIN_V8"
MainGui.ResetOnSpawn = false
MainGui.IgnoreGuiInset = true

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

local LStatus = Instance.new("TextLabel", LoaderFrame)
LStatus.Size = UDim2.new(1, 0, 0, 20)
LStatus.Position = UDim2.new(0, 0, 0.45, 0)
LStatus.Text = "Injetando Scripts..."
LStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
LStatus.Font = Enum.Font.Gotham
LStatus.TextSize = 14
LStatus.BackgroundTransparency = 1

local BarBack = Instance.new("Frame", LoaderFrame)
BarBack.Size = UDim2.new(0.8, 0, 0, 5)
BarBack.Position = UDim2.new(0.1, 0, 0.75, 0)
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
MainFrame.Size = UDim2.new(0, 240, 0, 250)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)
local MStroke = Instance.new("UIStroke", MainFrame)
MStroke.Color = Color3.fromRGB(140, 0, 255)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "BIELZIN V8 - MENU"
Title.TextColor3 = Color3.white
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

--// Estilo de Botão do V8
local function createBtn(text, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.Text = text
    btn.TextColor3 = Color3.white
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Botões
local flyBtn = createBtn("VOAR: DESLIGADO", UDim2.new(0.05, 0, 0.2, 0), function()
    FLYING = not FLYING
    _G.fBtn.Text = FLYING and "VOAR: LIGADO" or "VOAR: DESLIGADO"
    _G.fBtn.BackgroundColor3 = FLYING and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 45)
    if FLYING then startFly() end
end)
_G.fBtn = flyBtn

local godBtn = createBtn("GOD MODE: DESLIGADO", UDim2.new(0.05, 0, 0.38, 0), function()
    godMode = not godMode
    _G.gBtn.Text = godMode and "GOD MODE: LIGADO" or "GOD MODE: DESLIGADO"
    _G.gBtn.BackgroundColor3 = godMode and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 45)
end)
_G.gBtn = godBtn

local whBtn = createBtn("WALL HACK: DESLIGADO", UDim2.new(0.05, 0, 0.56, 0), function()
    wallHack = not wallHack
    _G.wBtn.Text = wallHack and "WALL HACK: LIGADO" or "WALL HACK: DESLIGADO"
    _G.wBtn.BackgroundColor3 = wallHack and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 45)
end)
_G.wBtn = whBtn

-- Velocidade
local speedLabel = Instance.new("TextLabel", MainFrame)
speedLabel.Size = UDim2.new(1, 0, 0, 30)
speedLabel.Position = UDim2.new(0, 0, 0.72, 0)
speedLabel.Text = "VELOCIDADE VOO: 50"
speedLabel.TextColor3 = Color3.white
speedLabel.Font = Enum.Font.Gotham
speedLabel.BackgroundTransparency = 1

local btnPlus = createBtn("+", UDim2.new(0.55, 0, 0.85, 0), function() flySpeed = flySpeed + 10 speedLabel.Text = "VELOCIDADE VOO: "..flySpeed end)
btnPlus.Size = UDim2.new(0.4, 0, 0, 30)

local btnMinus = createBtn("-", UDim2.new(0.05, 0, 0.85, 0), function() flySpeed = math.max(10, flySpeed - 10) speedLabel.Text = "VELOCIDADE VOO: "..flySpeed end)
btnMinus.Size = UDim2.new(0.4, 0, 0, 30)

--- ========================================== ---
---                LÓGICA FLY V8               ---
--- ========================================== ---

function startFly()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    local root = player.Character.HumanoidRootPart
    
    bodyGyro = Instance.new("BodyGyro", root)
    bodyGyro.P = 9e4; bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9); bodyGyro.CFrame = root.CFrame
    bodyVelocity = Instance.new("BodyVelocity", root)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0); bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    
    player.Character.Humanoid.PlatformStand = true
    
    task.spawn(function()
        while FLYING do
            local cam = workspace.CurrentCamera
            bodyVelocity.Velocity = ((cam.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((cam.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.Q + CONTROL.E) * 0.2, 0).Position) - cam.CFrame.Position)).Unit * flySpeed
            bodyGyro.CFrame = cam.CFrame
            RunService.RenderStepped:Wait()
        end
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
        if player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.PlatformStand = false end
    end)
end

-- Controles Fly
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

--- ========================================== ---
---               GOD & WALLHACK               ---
--- ========================================== ---

RunService.Heartbeat:Connect(function()
    if godMode and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
    end
end)

local function applyESP(p)
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(140, 0, 255)
    RunService.RenderStepped:Connect(function()
        if wallHack and p.Character then highlight.Parent = p.Character else highlight.Parent = nil end
    end)
end
for _, p in pairs(Players:GetPlayers()) do if p ~= player then applyESP(p) end end
Players.PlayerAdded:Connect(applyESP)

-- Coleta Instantânea
task.spawn(function()
    local function b(p) if p:IsA("ProximityPrompt") then p.HoldDuration = 0 end end
    for _, v in pairs(game:GetDescendants()) do b(v) end
    game.DescendantAdded:Connect(b)
end)

--- ========================================== ---
---               ATIVAR LOADER                ---
--- ========================================== ---

task.spawn(function()
    task.wait(0.5)
    LStatus.Text = "Injetando Bypass de Coleta..."
    TweenService:Create(BarFill, TweenInfo.new(1.5), {Size = UDim2.new(0.6, 0, 1, 0)}):Play()
    task.wait(1.5)
    LStatus.Text = "Configurando V8 Engine..."
    TweenService:Create(BarFill, TweenInfo.new(1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(1)
    LoaderFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Quad", 0.5, true)
    task.wait(0.5)
    LoaderFrame:Destroy()
    MainFrame.Visible = true
end)
