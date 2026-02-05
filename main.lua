local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

_G.SkyActive = false
local platform = nil

-- Criar Interface
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Final_V3"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 260) -- Aumentado para caber o tracker
main.Position = UDim2.new(0, 50, 0.5, -130)
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

-- Botão Voar
local flyBtn = Instance.new("TextButton", main)
flyBtn.Size = UDim2.new(0.9, 0, 0, 35)
flyBtn.Position = UDim2.new(0.05, 0, 0.18, 0)
flyBtn.Text = "SUBIR 500M: OFF"
flyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Instance.new("UICorner", flyBtn)

-- Monitor de Distância da Onda (NOVO)
local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 40)
waveLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
waveLabel.Text = "Onda: Detectando..."
waveLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

-- Detector de Ranks e Caixas
local detectorLabel = Instance.new("TextLabel", main)
detectorLabel.Size = UDim2.new(0.9, 0, 0, 30)
detectorLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
detectorLabel.Text = "Buscando Celestiais..."
detectorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
detectorLabel.BackgroundTransparency = 1
detectorLabel.TextSize = 11

local boxLabel = Instance.new("TextLabel", main)
boxLabel.Size = UDim2.new(0.9, 0, 0, 30)
boxLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
boxLabel.Text = "📦 Caixas: 0"
boxLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
boxLabel.BackgroundTransparency = 1

--- [LÓGICA DO RASTREADOR DE ONDA] ---
local function getWaveDistance()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return 9999 end
    
    local root = char.HumanoidRootPart
    local closest = 9999
    
    -- No Brenhot as ondas costumam estar em pastas como 'ActiveTsunamis' ou ter 'Wave' no nome
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

--- [SISTEMA DE ESP DE CAIXAS] ---
local function applyBoxESP(obj)
    if not obj:FindFirstChild("BoxESP") then
        local highlight = Instance.new("Highlight", obj)
        highlight.Name = "BoxESP"
        highlight.FillColor = Color3.fromRGB(255, 165, 0)
        
        local bill = Instance.new("BillboardGui", obj)
        bill.Size = UDim2.new(0, 80, 0, 40)
        bill.AlwaysOnTop = true
        bill.ExtentsOffset = Vector3.new(0, 3, 0)
        local t = Instance.new("TextLabel", bill)
        t.Size = UDim2.new(1,0,1,0)
        t.Text = "📦 CAIXA"
        t.TextColor3 = Color3.new(1, 0.6, 0)
        t.BackgroundTransparency = 1
    end
end

--- [LOOP PRINCIPAL] ---
RunService.Heartbeat:Connect(function()
    -- Atualiza Distância da Onda
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

    -- Mantém Plataforma no Ar
    if _G.SkyActive and platform and player.Character then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then platform.CFrame = CFrame.new(root.Position.X, 497, root.Position.Z) end
    end
end)

-- Loop de Scanner (Caixas e Ranks)
task.spawn(function()
    while true do
        local boxCount = 0
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("box") or obj.Name:lower():find("caixa") then
                if obj:IsA("BasePart") then applyBoxESP(obj) boxCount = boxCount + 1 end
            end
        end
        boxLabel.Text = "📦 Caixas no Mapa: " .. boxCount
        
        -- Scanner Celestiais
        local foundC = false
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") then
                for _, tag in pairs(p.Character.Head:GetDescendants()) do
                    if tag:IsA("TextLabel") and (tag.Text:lower():find("celestial") or tag.Text:lower():find("divino")) then
                        detectorLabel.Text = "👑 " .. p.Name .. ": " .. tag.Text:upper()
                        foundC = true
                    end
                end
            end
        end
        if not foundC then detectorLabel.Text = "Nenhum Rank Especial detectado." end
        task.wait(2.5)
    end
end)

flyBtn.MouseButton1Click:Connect(function()
    _G.SkyActive = not _G.SkyActive
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if _G.SkyActive and root then
        platform = Instance.new("Part", workspace)
        platform.Size = Vector3.new(40, 1, 40)
        platform.Anchored = true
        platform.CFrame = CFrame.new(root.Position.X, 500, root.Position.Z)
        root.CFrame = platform.CFrame + Vector3.new(0, 3, 0)
        flyBtn.Text = "VOLTAR AO CHÃO"
        flyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    elseif platform then
        platform:Destroy()
        flyBtn.Text = "SUBIR 500M: OFF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)
