local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Criar Interface (Design Original)
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Final_V3_Lite"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 150) -- Ajustado para o novo foco
main.Position = UDim2.new(0, 50, 0.5, -75)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌊 OCEAN X - ELITE 🌊"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
Instance.new("UICorner", title)

-- Monitor de Distância da Onda (Idêntico ao seu)
local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 40)
waveLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
waveLabel.Text = "Onda: Detectando..."
waveLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

local collectLabel = Instance.new("TextLabel", main)
collectLabel.Size = UDim2.new(0.9, 0, 0, 30)
collectLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
collectLabel.Text = "📦 Coletor Braihot: ATIVO"
collectLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
collectLabel.BackgroundTransparency = 1

--- [LÓGICA ORIGINAL DO RASTREADOR] ---
local function getWaveDistance()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return 9999 end
    
    local root = char.HumanoidRootPart
    local closest = 9999
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("wave") or obj.Name:lower():find("tsunami") then
            if obj:IsA("BasePart") then
                local dist = (obj.Position - root.Position).Magnitude
                if dist < closest then closest = dist end
            end
        end
    end
    return math.floor(closest)
end

--- [COLETOR INSTANTÂNEO MELHORADO] ---
local function instantCollect()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        -- Busca por Braihot, Caixas ou Itens Coletáveis
        if (obj.Name:lower():find("braihot") or obj.Name:lower():find("box") or obj.Name:lower():find("caixa")) and obj:IsA("BasePart") then
            
            -- Tenta o ProximityPrompt (E)
            local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
            if prompt then
                fireproximityprompt(prompt)
            end
            
            -- Tenta o Toque Físico (Mais rápido para moedas e Braihot)
            if firetouchinterest then
                firetouchinterest(root, obj, 0)
                firetouchinterest(root, obj, 1)
            end
        end
    end
end

--- [LOOP PRINCIPAL] ---
RunService.Heartbeat:Connect(function()
    local d = getWaveDistance()
    if d < 100 then
        waveLabel.Text = "⚠️ PERIGO: " .. d .. "m"
        waveLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    elseif d < 300 then
        waveLabel.Text = "AVISO: " .. d .. "m"
        waveLabel.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    else
        waveLabel.Text = "Onda Segura: " .. d .. "m"
        waveLabel.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)

-- Loop de coleta rápida
task.spawn(function()
    while true do
        pcall(instantCollect)
        task.wait(0.1)
    end
end)
