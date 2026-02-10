--[[ 
    INSTANT COLLECT + NOTIFICAÇÃO DE ATIVAÇÃO
]]

local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- Função para mandar notificação oficial do Roblox (sempre aparece)
local function Notificar(titulo, texto)
    StarterGui:SetCore("SendNotification", {
        Title = titulo;
        Text = texto;
        Duration = 5;
    })
end

-- 1. Criando a Interface Visual de Loading (Bypass de segurança)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NotificacaoAtiva"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 60)
MainFrame.Position = UDim2.new(0.5, -125, 0, -100) -- Começa fora da tela (topo)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(130, 0, 255)

local Label = Instance.new("TextLabel", MainFrame)
Label.Size = UDim2.new(1, 0, 1, 0)
Label.Text = "COLETA INSTANTÂNEA ATIVA ✅"
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.BackgroundTransparency = 1
Label.Font = Enum.Font.GothamBold
Label.TextSize = 14

-- Animação de descida
MainFrame:TweenPosition(UDim2.new(0.5, -125, 0, 50), "Out", "Back", 0.5, true)

-- 2. FUNÇÃO DE COLETA (O SCRIPT EM SI)
local function aplicarBypass(prompt)
    prompt.HoldDuration = 0
end

for _, v in pairs(game:GetDescendants()) do
    if v:IsA("ProximityPrompt") then aplicarBypass(v) end
end

game.DescendantAdded:Connect(function(v)
    if v:IsA("ProximityPrompt") then aplicarBypass(v) end
end)

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
    p.HoldDuration = 0
    fireproximityprompt(p)
end)

-- Feedback final
Notificar("Sucesso!", "O Bypass de Coleta foi injetado.")
print("✅ SCRIPT ATIVO!")

-- Fecha a janelinha após 3 segundos
task.delay(3, function()
    MainFrame:TweenPosition(UDim2.new(0.5, -125, 0, -100), "In", "Quad", 0.5, true)
    task.wait(0.5)
    ScreenGui:Destroy()
end)
