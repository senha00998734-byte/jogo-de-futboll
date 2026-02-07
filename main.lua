local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Configurações de Coleta
_G.AutoCollect = true 

-- Interface Simplificada
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Lite"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 220, 0, 130)
main.Position = UDim2.new(0, 50, 0.5, -65)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "OCEAN X - WAVE & COLLECT"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Instance.new("UICorner", title)

local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 40)
waveLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
waveLabel.Text = "Onda: Detectando..."
waveLabel.TextColor3 = Color3.white
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

local statusLabel = Instance.new("TextLabel", main)
statusLabel.Size = UDim2.new(0.9, 0, 0, 30)
statusLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
statusLabel.Text = "Auto-Collect: ATIVO"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statusLabel.BackgroundTransparency = 1

--- [LÓGICA DE DETECÇÃO DA ONDA] ---
local function getWaveDistance()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return 9999 end
    
    local root = char.HumanoidRootPart
    local closest = 9999
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if (obj.Name:lower():find("wave") or obj.Name:lower():find("tsunami")) and obj:IsA("BasePart") then
            local dist = (obj.Position - root.Position).Magnitude
            if dist < closest then closest = dist end
        end
    end
    return math.floor(closest)
end

--- [COLETOR INSTANTÂNEO (BRAINHOT)] ---
local function instantCollect()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart

    for _, obj in pairs(workspace:GetDescendants()) do
        -- Filtra por nomes comuns de itens/caixas/brainhot
        if (obj.Name:lower():find("box") or obj.Name:lower():find("caixa") or obj.Name:lower():find("item")) 
            and obj:IsA("BasePart") and obj.Transparency < 1 then
            
            -- Teleporta o item para você (ou você para o item, dependendo da segurança do jogo)
            -- A forma mais segura é disparar o ProximityPrompt se houver
            local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
            if prompt then
                fireproximityprompt(prompt)
            else
                -- Tenta coletar por toque/proximidade física
                local oldPos = obj.CFrame
                obj.CFrame = root.CFrame
                task.wait(0.1)
            end
        end
    end
end

--- [LOOP PRINCIPAL] ---
RunService.Heartbeat:Connect(function()
    -- Monitor de Onda
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

-- Loop de Coleta Rápida
task.spawn(function()
    while true do
        if _G.AutoCollect then
            instantCollect()
        end
        task.wait(0.5) -- Intervalo curto para não dar lag, mas ser "instantâneo"
    end
end)
