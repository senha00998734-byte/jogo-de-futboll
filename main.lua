local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- Interface
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_God_Farmer"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 230, 0, 160)
main.Position = UDim2.new(0, 50, 0.5, -80)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌊 OCEAN X - GOD MODE 🌊"
title.TextColor3 = Color3.white
title.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
Instance.new("UICorner", title)

local waveLabel = Instance.new("TextLabel", main)
waveLabel.Size = UDim2.new(0.9, 0, 0, 35)
waveLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
waveLabel.Text = "Onda: Detectando..."
waveLabel.TextColor3 = Color3.white
waveLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Instance.new("UICorner", waveLabel)

local statusLabel = Instance.new("TextLabel", main)
statusLabel.Size = UDim2.new(0.9, 0, 0, 60)
statusLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
statusLabel.Text = "🛡️ Anti-Queda: ATIVO\n💰 Coletor (500m): ATIVO\n🛡️ Anti-Void/AFK: ATIVO"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statusLabel.BackgroundTransparency = 1
statusLabel.TextSize = 11

--- [LÓGICA ANTI-QUEDA / NO R
