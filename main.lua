--// Prevenção de execução duplicada
if _G.BielzinLoaded then return end
_G.BielzinLoaded = true

--// Serviços
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local dashForce = 150
local wallHackEnabled = false
local godModeEnabled = false

--// Interface
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "BIELZIN_HUB"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 220, 0, 220) -- Aumentado para caber o novo botão
mainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(140, 0, 255)
stroke.Thickness = 2

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "BIELZIN GOD MODE"
title.TextColor3 = Color3.white
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

--// BOTÃO GOD MODE
local godBtn = Instance.new("TextButton", mainFrame)
godBtn.Size = UDim2.new(0.9, 0, 0, 35)
godBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
godBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
godBtn.Text = "God Mode: OFF"
godBtn.TextColor3 = Color3.white
godBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", godBtn)

--// BOTÃO WALL HACK
local whBtn = Instance.new("TextButton", mainFrame)
whBtn.Size = UDim2.new(0.9, 0, 0, 35)
whBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
whBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
whBtn.Text = "Wall Hack: OFF"
whBtn.TextColor3 = Color3.white
whBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", whBtn)

--// CONTROLES DASH
local dashLabel = Instance.new("TextLabel", mainFrame)
dashLabel.Size = UDim2.new(1, 0, 0, 30)
dashLabel.Position = UDim2.new(0, 0, 0.6, 0)
dashLabel.Text = "Dash Force (Q): " .. dashForce
dashLabel.TextColor3 = Color3.white
dashLabel.BackgroundTransparency = 1

local btnUp = Instance.new("TextButton", mainFrame)
btnUp.Size = UDim2.new(0.4, 0, 0, 30)
btnUp.Position = UDim2.new(0.55, 0, 0.75, 0)
btnUp.Text = "+"
btnUp.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
Instance.new("UICorner", btnUp)

local btnDown = Instance.new("TextButton", mainFrame)
btnDown.Size = UDim2.new(0.4, 0, 0, 30)
btnDown.Position = UDim2.new(0.05, 0, 0.75, 0)
btnDown.Text = "-"
btnDown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", btnDown)

-- --- LÓGICA GOD MODE (INVENCIBILIDADE) ---
RunService.Stepped:Connect(function()
    if godModeEnabled then
        local char = player.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then
            -- Tenta múltiplos métodos de invencibilidade
            hum.Health = hum.MaxHealth -- Cura instantânea
            if char:FindFirstChild("ForceField") == nil then
                Instance.new("ForceField", char).Visible = false -- Campo de força invisível
            end
        end
    else
        -- Remove o ForceField se desativar o God Mode
        if player.Character and player.Character:FindFirstChild("ForceField") then
            player.Character.ForceField:Destroy()
        end
    end
end)

-- --- LÓGICA WALL HACK (ESP) ---
local function createESP(p)
    local highlight = Instance.new("Highlight")
    highlight.Name = "BielzinESP"
    highlight.FillColor = Color3.fromRGB(140, 0, 255)
    highlight.FillTransparency = 0.5
    
    RunService.RenderStepped:Connect(function()
        if wallHackEnabled and p.Character then
            highlight.Parent = p.Character
        else
            highlight.Parent = nil
        end
    end)
end
for _, p in pairs(Players:GetPlayers()) do if p ~= player then createESP(p) end end
Players.PlayerAdded:Connect(createESP)

-- --- LÓGICA DASH E COLETA ---
local function doDash()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(1, 1, 1) * 50000
        bv.Velocity = (root.CFrame.LookVector * dashForce) + Vector3.new(0, 2, 0)
        task.wait(0.15)
        bv:Destroy()
    end
end

UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.Q then doDash() end
end)

task.spawn(function()
    local function b(p) if p:IsA("ProximityPrompt") then p.HoldDuration = 0 end end
    for _, v in pairs(game:GetDescendants()) do b(v) end
    game.DescendantAdded:Connect(b)
end)

-- --- EVENTOS DE CLIQUE ---
godBtn.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    godBtn.Text = godModeEnabled and "God Mode: ON" or "God Mode: OFF"
    godBtn.BackgroundColor3 = godModeEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 50)
end)

whBtn.MouseButton1Click:Connect(function()
    wallHackEnabled = not wallHackEnabled
    whBtn.Text = wallHackEnabled and "Wall Hack: ON" or "Wall Hack: OFF"
    whBtn.BackgroundColor3 = wallHackEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 50)
end)

btnUp.MouseButton1Click:Connect(function() dashForce = dashForce + 50; dashLabel.Text = "Dash Force (Q): " .. dashForce end)
btnDown.MouseButton1Click:Connect(function() dashForce = math.max(50, dashForce - 50); dashLabel.Text = "Dash Force (Q): " .. dashForce end)

mainFrame.Active = true
mainFrame.Draggable = true
