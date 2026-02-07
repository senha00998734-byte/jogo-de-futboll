local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Interface
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_FinalFix"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 200, 0, 100)
main.Position = UDim2.new(0, 20, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(1, 0, 0.5, 0)
waveLabel.Text = "Procurando Onda..."
waveLabel.TextColor3 = Color3.white
waveLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Instance.new("UICorner", waveLabel)

local collectLabel = Instance.new("TextLabel", main)
collectLabel.Size = UDim2.new(1, 0, 0.5, 0)
collectLabel.Position = UDim2.new(0, 0, 0.5, 0)
collectLabel.Text = "Coletor: Ativo"
collectLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
collectLabel.BackgroundTransparency = 1

--- [DETECTOR DE ONDA RADICAL] ---
local function getWave()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local closestDist = 9999
    
    -- Varre TUDO no Workspace que seja uma peça grande e se mova ou tenha nome de água
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency < 1 then
            local name = v.Name:lower()
            -- Filtro por nomes e tamanhos típicos de ondas de tsunami no Roblox
            if name:find("wave") or name:find("tsunami") or name:find("water") or (v.Size.X > 60 and v.Size.Z > 60) then
                -- Verifica se a peça está acima do nível do mar (geralmente ondas de tsunami sobem)
                if v.Position.Y > -5 then
                    local dist = (v.Position - root.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                    end
                end
            end
        end
    end
    return math.floor(closestDist)
end

--- [COLETOR INSTANTÂNEO POR TOQUE E PROMPT] ---
local function instantCollect()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, v in pairs(workspace:GetDescendants()) do
        -- Adicionei "Handle" e "Part" porque às vezes o item é um Tool no chão
        if v:IsA("BasePart") then
            local name = v.Name:lower()
            if name:find("braihot") or name:find("box") or name:find("caixa") or name:find("gift") or v:FindFirstChild("TouchInterest") then
                
                -- 1. Tenta disparar o ProximityPrompt (E)
                local prompt = v:FindFirstChildOfClass("ProximityPrompt") or v.Parent:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    fireproximityprompt(prompt)
                end
                
                -- 2. Simula o toque físico (Teleporta o toque para o jogador)
                if firetouchinterest then
                    firetouchinterest(root, v, 0) -- Toca
                    firetouchinterest(root, v, 1) -- Solta
                end
            end
        end
    end
end

--- [LOOP] ---
RunService.Heartbeat:Connect(function()
    local dist = getWave()
    if dist and dist < 9000 then
        if dist < 150 then
            waveLabel.Text = "⚠️ PERIGO: " .. dist .. "m"
            waveLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        else
            waveLabel.Text = "🌊 Onda a: " .. dist .. "m"
            waveLabel.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        end
    else
        waveLabel.Text = "Calmaria..."
        waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

task.spawn(function()
    while task.wait(0.1) do -- 0.1 para ser o mais rápido possível sem crashar
        pcall(instantCollect)
    end
end)
