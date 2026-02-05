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
boxLabel.Text
