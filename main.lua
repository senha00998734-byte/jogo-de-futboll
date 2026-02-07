local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Interface Final com Timer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Celestial_Timer_V7"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 160) -- Aumentado para caber o Timer
main.Position = UDim2.new(0, 50, 0.5, -80)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌊 OCEAN X - ELITE V7 🌊"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
Instance.new("UICorner", title)

-- Mostrador de Onda
local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 35)
waveLabel.Position = UDim2.new(0.05, 0, 0.28, 0)
waveLabel.Text = "Onda: Detectando..."
waveLabel.TextColor3 = Color3.white
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

-- NOVO: Mostrador de Tempo para Celestial
local timerLabel = Instance.new("TextLabel", main)
timerLabel.Size = UDim2.new(0.9, 0, 0, 35)
timerLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
timerLabel.Text = "Próximo Celestial: --:--"
timerLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
timerLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Instance.new("UICorner", timerLabel)

local statusLabel = Instance.new("TextLabel", main)
statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
statusLabel.Position = UDim2.new(0.05, 0, 0.82, 0)
statusLabel.Text = "Aguardando Spawn..."
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statusLabel.BackgroundTransparency = 1
statusLabel.TextSize = 12

--- [LÓGICA DO TIMER] ---
-- Tenta capturar o tempo do evento na tela ou faz uma contagem regressiva baseada no ciclo
local function updateCelestialTimer()
    local eventTimer = "00:00"
    
    -- Busca por textos de tempo na tela do jogo (como o que aparece na sua foto de 95s)
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        if v:IsA("TextLabel") and v.Visible then
            local match = v.Text:match("%d+s") or v.Text:match("%d+:%d+")
            if match then
                eventTimer = match
                break
            end
        end
    end
    
    timerLabel.Text = "Evento/Spawn: " .. eventTimer
end

--- [LÓGICA DA ONDA] ---
local function getWaveDistance()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return 9999 end
    local closest = 9999
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("wall") or obj.Name:lower():find("wave")) then
            if obj.Size.Y > 15 and obj.Transparency < 1 then
                local dist = (obj.Position - root.Position).Magnitude
                if dist < closest then closest = dist end
            end
        end
    end
    return math.floor(closest)
end

--- [COLETOR AUTO-TP] ---
local function collectCelestials()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:find("dug") or name:find("lucky") or name:find("celestial") then
            local p = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
            if p and p.Size.Magnitude < 40 and not obj:IsDescendantOf(char) then
                statusLabel.Text = "⭐ COLETANDO: " .. obj.Name:upper()
                root.CFrame = p.CFrame
                task.wait(0.1)
                local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                if prompt then fireproximityprompt(prompt) end
                if firetouchinterest then
                    firetouchinterest(root, p, 0)
                    firetouchinterest(root, p, 1)
                end
                return
            end
        end
    end
    statusLabel.Text = "Buscando Celestiais..."
end

--- [LOOP PRINCIPAL] ---
RunService.Heartbeat:Connect(function()
    -- Atualiza Onda
    local d = getWaveDistance()
    waveLabel.Text = "Onda: " .. (d > 5000 and "Longe" or d .. "m")
    waveLabel.BackgroundColor3 = d < 150 and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 60)
    
    -- Atualiza Timer
    updateCelestialTimer()
end)

task.spawn(function()
    while true do
        pcall(collectCelestials)
        task.wait(1)
    end
end)
