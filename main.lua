--[[
    VELOCITY CONTROL PANEL + INSTANT COLLECT
    Use as setas para ajustar ou os botões na tela
]]

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Variáveis de Controle
_G.SpeedValue = 16
_G.InfJump = true

-- 1. Interface de Controle
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "SpeedControlUI"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 200, 0, 150)
Main.Position = UDim2.new(0, 50, 0.5, 0) -- Fica no lado esquerdo da tela
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true
Main.Draggable = true -- Você pode arrastar com o mouse
Instance.new("UICorner", Main)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(130, 0, 255)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Ajuste de Speed"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local Display = Instance.new("TextLabel", Main)
Display.Size = UDim2.new(1, 0, 0, 40)
Display.Position = UDim2.new(0, 0, 0, 30)
Display.Text = tostring(_G.SpeedValue)
Display.TextColor3 = Color3.fromRGB(130, 0, 255)
Display.TextSize = 25
Display.BackgroundTransparency = 1
Display.Font = Enum.Font.GothamBold

-- Botão Aumentar (+50)
local Add = Instance.new("TextButton", Main)
Add.Size = UDim2.new(0, 80, 0, 30)
Add.Position = UDim2.new(0.5, 5, 0, 80)
Add.Text = "+50"
Add.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Add.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Add)

-- Botão Diminuir (-50)
local Sub = Instance.new("TextButton", Main)
Sub.Size = UDim2.new(0, 80, 0, 30)
Sub.Position = UDim2.new(0.5, -85, 0, 80)
Sub.Text = "-50"
Sub.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Sub.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Sub)

-- Loop de Velocidade
task.spawn(function()
    while task.wait(0.1) do
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = _G.SpeedValue
            Display.Text = math.floor(_G.SpeedValue)
        end
    end
end)

-- Funções dos Botões
Add.MouseButton1Click:Connect(function()
    if _G.SpeedValue < 2000 then
        _G.SpeedValue = _G.SpeedValue + 50
    end
end)

Sub.MouseButton1Click:Connect(function()
    if _G.SpeedValue > 16 then
        _G.SpeedValue = _G.SpeedValue - 50
    else
        _G.SpeedValue = 16
    end
end)

-- 2. COLETA INSTANTÂNEA (Sempre Ativa)
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
    p.HoldDuration = 0
    fireproximityprompt(p)
end)

-- 3. PULO INFINITO
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Painel Ativo!";
    Text = "Arraste o menu para onde quiser.";
    Duration = 5;
})
