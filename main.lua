local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Configurações
_G.GodMode = false
_G.Speed = 500
local normalSpeed = 16

-- Criar a interface (Menu)
local gui = Instance.new("ScreenGui")
gui.Name = "OceanX_Fix"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 250, 0, 150)
main.Position = UDim2.new(0.5, -125, 0.5, -75)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
main.BorderSizePixel = 2
main.Active = true
main.Draggable = true
main.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "🌊 OCEAN X (XENO FIX) 🌊"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
title.TextColor3 = Color3.new(1, 1, 1)
title.Parent = main

-- Botão de God + Speed
local godBtn = Instance.new("TextButton")
godBtn.Size = UDim2.new(0.9, 0, 0, 40)
godBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
godBtn.Text = "Ativar God + Speed (500)"
godBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
godBtn.TextColor3 = Color3.new(1, 1, 1)
godBtn.Parent = main

-- Lógica de Velocidade e Invencibilidade (Otimizada para não travar)
local function startLoop()
    RunService.Stepped:Connect(function()
        if _G.GodMode then
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Invencibilidade
                    hum.MaxHealth = math.huge
                    hum.Health = math.huge
                    
                    -- Velocidade ao segurar Shift
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        hum.WalkSpeed = _G.Speed
                    else
                        hum.WalkSpeed = normalSpeed
                    end
                end
            end
        end
    end)
end

godBtn.MouseButton1Click:Connect(function()
    _G.GodMode = not _G.GodMode
    if _G.GodMode then
        godBtn.Text = "ON (God + Speed 500)"
        godBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        print("OceanX: Ativado!")
    else
        godBtn.Text = "OFF (God + Speed 500)"
        godBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = normalSpeed
        end
    end
end)

startLoop()
print("Menu OceanX Carregado!")
