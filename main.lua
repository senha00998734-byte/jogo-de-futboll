local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- Interface Principal
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Ultra_Farmer"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 230, 0, 140)
main.Position = UDim2.new(0, 50, 0.5, -70)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌊 OCEAN X - FARMER 🌊"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
Instance.new("UICorner", title)

-- Mostrador de Onda (Original)
local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 35)
waveLabel.Position = UDim2.new(0.05, 0, 0.28, 0)
waveLabel.Text = "Onda: Detectando..."
waveLabel.TextColor3 = Color3.white
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

-- Status dos Sistemas
local statusLabel = Instance.new("TextLabel", main)
statusLabel.Size = UDim2.new(0.9, 0, 0, 45)
statusLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
statusLabel.Text = "🛡️ Anti-Void/AFK: ON\n💰 Coletor (500m): ON"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statusLabel.BackgroundTransparency = 1
statusLabel.TextSize = 12

--- [LÓGICA DO RASTREADOR DE ONDA] ---
local function getWaveDistance()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return 9999 end
    local root = char.HumanoidRootPart
    local closest = 9999
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("wave") or obj.Name:lower():find("tsunami")) then
            local dist = (obj.Position - root.Position).Magnitude
            if dist < closest then closest = dist end
        end
    end
    return math.floor(closest)
end

--- [COLETOR DE MOEDAS (RAIO DE 500M)] ---
local function collectCoins()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        -- Filtra por nomes comuns de moedas/dinheiro
        local name = obj.Name:lower()
        if (name:find("coin") or name:find("moeda") or name:find("money") or name:find("cash")) and obj:IsA("BasePart") then
            local dist = (obj.Position - root.Position).Magnitude
            if dist <= 500 then -- Limite de 500 metros
                -- Coleta via toque (FireTouch)
                if firetouchinterest then
                    firetouchinterest(root, obj, 0)
                    firetouchinterest(root, obj, 1)
                end
                
                -- Coleta via ProximityPrompt (E) se existir
                local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    fireproximityprompt(prompt)
                end
            end
        end
    end
end

--- [ANTI-VOID & ANTI-AFK] ---
task.spawn(function()
    while true do
        -- Anti-Void
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root and root.Position.Y < -15 then
            root.Velocity = Vector3.new(0,0,0)
            root.CFrame = root.CFrame * CFrame.new(0, 100, 0)
        end
        task.wait(0.5)
    end
end)

player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

--- [LOOP DE ATUALIZAÇÃO] ---
RunService.Heartbeat:Connect(function()
    local d = getWaveDistance()
    waveLabel.Text = "Onda: " .. (d > 5000 and "Longe" or d .. "m")
    waveLabel.BackgroundColor3 = (d < 150) and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 60)
end)

-- Loop do Coletor (A cada 0.5s para eficiência)
task.spawn(function()
    while true do
        pcall(collectCoins)
        task.wait(0.5)
    end
end)
