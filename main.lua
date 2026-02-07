local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Interface (Design Original que você gosta)
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Celestial_V5"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 110)
main.Position = UDim2.new(0, 50, 0.5, -55)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌊 OCEAN X - V5 🌊"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
Instance.new("UICorner", title)

local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 45)
waveLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
waveLabel.Text = "Procurando Onda..."
waveLabel.TextColor3 = Color3.white
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

--- [BUSCADOR DE ONDAS REFEITO] ---
-- Se a onda não estiver no Workspace, ele procura em pastas ocultas
local function getWaveDistance()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return 9999 end
    
    local closest = 9999
    
    -- Busca profunda para garantir que ache a onda onde quer que ela esteja
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Verifica se o nome tem 'wave' ou 'tsunami' e se é uma peça física
        if obj:IsA("BasePart") and (obj.Name:lower():find("wave") or obj.Name:lower():find("tsunami")) then
            -- Ignora partes invisíveis ou muito pequenas que não são a onda real
            if obj.Transparency < 1 and obj.Size.Y > 2 then
                local dist = (obj.Position - root.Position).Magnitude
                if dist < closest then closest = dist end
            end
        end
    end
    return math.floor(closest)
end

--- [COLETOR CELESTIAL COM AVISO] ---
local function collectRareCelestial()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        -- Alvos: Dug Dug Dug ou Celestial Lucky Block
        if (name:find("dug") or name:find("lucky block") or name:find("celestial")) and not obj:IsDescendantOf(char) then
            
            local targetPart = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Handle") or (obj:IsA("BasePart") and obj)
            
            if targetPart and targetPart:IsA("BasePart") and targetPart.Size.Magnitude < 30 then
                -- AVISO NO CHAT (Só você vê)
                game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                    Text = "⭐ CELESTIAL DETECTADO: " .. obj.Name .. "! Teleportando...";
                    Color = Color3.new(1, 0.5, 0);
                    Font = Enum.Font.SourceSansBold;
                })

                -- Teleport e Coleta
                root.CFrame = targetPart.CFrame
                task.wait(0.1)
                
                local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                if prompt then fireproximityprompt(prompt) end
                
                if firetouchinterest then
                    firetouchinterest(root, targetPart, 0)
                    firetouchinterest(root, targetPart, 1)
                end
                return 
            end
        end
    end
end

--- [LOOP PRINCIPAL] ---
RunService.Heartbeat:Connect(function()
    local d = getWaveDistance()
    if d < 120 then
        waveLabel.Text = "⚠️ PERIGO: " .. d .. "m"
        waveLabel.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    elseif d < 400 then
        waveLabel.Text = "AVISO: " .. d .. "m"
        waveLabel.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    elseif d > 5000 then
        waveLabel.Text = "🌊 Sem ondas..."
        waveLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    else
        waveLabel.Text = "Onda Segura: " .. d .. "m"
        waveLabel.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)

task.spawn(function()
    while true do
        pcall(collectRareCelestial)
        task.wait(1.5)
    end
end)
