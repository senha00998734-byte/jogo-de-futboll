local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Interface Original Otimizada
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Elite_Only"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 100)
main.Position = UDim2.new(0, 50, 0.5, -50)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌊 OCEAN X - RARE ONLY 🌊"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(100, 0, 255) -- Cor roxa para Celestiais
Instance.new("UICorner", title)

local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 40)
waveLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
waveLabel.Text = "Onda: Detectando..."
waveLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

--- [LÓGICA DO RASTREADOR (ESTILO ORIGINAL)] ---
local function getWaveDistance()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return 9999 end
    
    local closest = 9999
    for _, obj in pairs(workspace:GetChildren()) do -- GetChildren é mais leve
        if obj.Name:lower():find("wave") or obj.Name:lower():find("tsunami") then
            if obj:IsA("BasePart") then
                local dist = (obj.Position - root.Position).Magnitude
                if dist < closest then closest = dist end
            end
        end
    end
    return math.floor(closest)
end

--- [COLETOR EXCLUSIVO: CELESTIAL & DIVINO] ---
local function collectRareItems()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        -- Foco exclusivo em Celestiais e Divinos
        if (name:find("celestial") or name:find("divino") or name:find("divine")) and obj:IsA("BasePart") then
            
            -- Coleta por ProximityPrompt
            local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
            if prompt then
                fireproximityprompt(prompt)
            end
            
            -- Coleta por Toque (firetouchinterest)
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
    elseif d > 5000 then
        waveLabel.Text = "Calmaria..."
        waveLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    else
        waveLabel.Text = "Onda Segura: " .. d .. "m"
        waveLabel.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)

-- Loop de busca de raros (Roda a cada 1 segundo para manter o script leve)
task.spawn(function()
    while true do
        pcall(collectRareItems)
        task.wait(1) 
    end
end)
