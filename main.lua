--[[ 
    MAKAL-STYLE LOADER FOR INSTANT COLLECT
    Personalizado para: Escape Tsunami / Brainrots
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Criando a Interface (Estilo MakalHub)
local MakalUI = Instance.new("ScreenGui")
MakalUI.Name = "MakalLoader"
MakalUI.Parent = CoreGui

local MainFrame = Instance.new("Frame", MakalUI)
MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Começa invisível para o Tween
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(120, 0, 255) -- Cor roxa neon
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "MAKAL HUB - LOADER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold

local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0, 45)
Status.BackgroundTransparency = 1
Status.Text = "Verificando Script..."
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.TextSize = 14
Status.Font = Enum.Font.Gotham

-- Animação de Abertura
MainFrame:TweenSize(UDim2.new(0, 300, 0, 100), "Out", "Quad", 0.5, true)

-- Lógica de Carregamento
task.spawn(function()
    task.wait(1)
    Status.Text = "Injetando Instant Collect..."
    task.wait(1.5)
    Status.Text = "Sucesso! Aproveite."
    
    -- FUNÇÃO DE COLETA INSTANTÂNEA (O CORAÇÃO DO SCRIPT)
    local ProximityPromptService = game:GetService("ProximityPromptService")
    
    -- Isso aqui remove a "bolinha" de espera
    ProximityPromptService.PromptButtonHoldBegan:Connect(function(p)
        p.HoldDuration = 0
        fireproximityprompt(p)
    end)
    
    -- Garante que novos itens que aparecerem também sejam instantâneos
    game.DescendantAdded:Connect(function(d)
        if d:IsA("ProximityPrompt") then
            d.HoldDuration = 0
        end
    end)

    task.wait(1)
    
    -- Animação de Fechamento
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.5, true)
    task.wait(0.5)
    MakalUI:Destroy()
end)
