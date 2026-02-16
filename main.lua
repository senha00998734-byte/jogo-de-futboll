--// CONFIGURAÇÕES GERAIS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

--// VARIÁVEIS DE ESTADO
_G.GodMode = false
_G.WallHack = false
_G.FlyEnabled = false
local flySpeed = 50
local CONTROL = {F = 0, B = 0, L = 0, R = 0}

--// LIMPEZA DE UI
if CoreGui:FindFirstChild("BIELZIN_FINAL") then CoreGui["BIELZIN_FINAL"]:Destroy() end

--// INTERFACE PRINCIPAL
local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "BIELZIN_FINAL"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 220, 0, 250)
main.Position = UDim2.new(0.5, -110, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Active = true
main.Draggable = true -- Você pode arrastar o menu
Instance.new("UICorner", main)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(140, 0, 255)
stroke.Thickness = 2

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "BIELZIN V8"
title.TextColor3 = Color3.white
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

--// FUNÇÃO CRIAR BOTÕES
local function createButton(txt, pos, color, callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = pos
    btn.Text = txt
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.white
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

--// FUNÇÕES TÉCNICAS (CONSERTADAS)

-- 1. GOD MODE (Cura constante)
local godBtn = createButton("GOD MODE: OFF", UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(40, 40, 40), function()
    _G.GodMode = not _G.GodMode
    print("God Mode status: ", _G.GodMode)
end)

RunService.Heartbeat:Connect(function()
    if _G.GodMode and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = hum.MaxHealth end
    end
    godBtn.Text = _G.GodMode and "GOD MODE: ON" or "GOD MODE: OFF"
    godBtn.BackgroundColor3 = _G.GodMode and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

-- 2. WALL HACK (ESP)
local whBtn = createButton("WALL HACK: OFF", UDim2.new(0.05, 0, 0.4, 0), Color3.fromRGB(40, 40, 40), function()
    _G.WallHack = not _G.WallHack
end)

local function applyESP(p)
    local high = Instance.new("Highlight")
    high.FillColor = Color3.fromRGB(140, 0, 255)
    RunService.RenderStepped:Connect(function()
        if _G.WallHack and p.Character then 
            high.Parent = p.Character 
        else 
            high.Parent = nil 
        end
    end)
end
for _, p in pairs(Players:GetPlayers()) do if p ~= player then applyESP(p) end end
Players.PlayerAdded:Connect(applyESP)

-- 3. FLY (VOO ESTILO V8)
local flyBtn = createButton("FLY: OFF", UDim2.new(0.05, 0, 0.6, 0), Color3.fromRGB(40, 40, 40), function()
    _G.FlyEnabled = not _G.FlyEnabled
    if _G.FlyEnabled then
        local root = player.Character:WaitForChild("HumanoidRootPart")
        local bg = Instance.new("BodyGyro", root)
        bg.P = 9e4; bg.MaxTorque = Vector3.new(9e9, 9
