local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Interface Original (Design que você gosta)
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Celestial_Hunter"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 110)
main.Position = UDim2.new(0, 50, 0.5, -55)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌊 CELESTIAL HUNTER 🌊"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
Instance.new("UICorner", title)

local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 45)
waveLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
waveLabel.Text = "Onda: Detectando..."
waveLabel.TextColor3 = Color3.white
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

--- [LÓGICA DO RASTREADOR ORIGINAL] ---
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

--- [COLETOR PARA DUG DUG CELESTIAL] ---
local function collectDugDug()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        -- Procura pelo nome "Dug" ou pela tag "Celestial" que aparece na imagem
        local name = obj.Name:lower()
        if (name:find("dug") or name:find("celestial") or name:find("ufo")) then
            
            -- Se for o personagem da imagem, ele terá uma parte principal (HumanoidRootPart ou Head)
            local targetPart = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or (obj:IsA("BasePart") and obj)
            
            if targetPart and obj ~= char then -- Não coletar a si mesmo
                -- Tenta interagir via ProximityPrompt
                local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                
                if prompt then
                    fireproximityprompt(prompt)
                end
                
                -- Tenta o toque (FireTouch) para garantir a coleta
                if firetouchinterest and targetPart:IsA("BasePart") then
                    firetouchinterest(root, targetPart, 0)
                    firetouchinterest(root, targetPart, 1)
                end
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

task.spawn(function()
    while true do
        pcall(collectDugDug)
        task.wait(0.5) -- Intervalo equilibrado para não dar lag
    end
end)
