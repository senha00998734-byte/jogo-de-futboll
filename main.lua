local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Interface (Seu Design Favorito)
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Celestial_Teleport"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 110)
main.Position = UDim2.new(0, 50, 0.5, -55)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌊 CELESTIAL AUTO-TP 🌊"
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

--- [AUTO TELEPORT PARA CELESTIAIS ESPECÍFICOS] ---
local function getRareCelestial()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        -- Alvos: Dug Dug Dug ou Celestial Lucky Block
        if (name:find("dug") or name:find("lucky block") or name:find("celestial")) and not obj:IsDescendantOf(char) then
            
            -- Encontra uma parte física para teleportar
            local targetPart = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Handle") or (obj:IsA("BasePart") and obj)
            
            if targetPart and targetPart:IsA("BasePart") then
                -- Verifica se é o item pequeno ou o modelo (evita o chão)
                if targetPart.Size.Magnitude < 30 then
                    -- Teleporta você até o item
                    local oldPos = root.CFrame
                    root.CFrame = targetPart.CFrame
                    
                    -- Tenta coletar
                    task.wait(0.1)
                    local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then fireproximityprompt(prompt) end
                    
                    if firetouchinterest then
                        firetouchinterest(root, targetPart, 0)
                        firetouchinterest(root, targetPart, 1)
                    end
                    
                    -- Volta para onde você estava (Opcional: remova a linha abaixo se quiser ficar no item)
                    -- root.CFrame = oldPos
                    return -- Para o loop após achar um
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

-- Coletor com Teleport (Executa a cada 2 segundos para ser seguro)
task.spawn(function()
    while true do
        pcall(getRareCelestial)
        task.wait(2)
    end
end)
