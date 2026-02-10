--[[ 
    MAKALHUB LOADER - APENAS COLETA INSTANTÂNEA
    Remove a "bolinha" de espera e ativa o Loader visual.
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Limpeza de UI anterior
if CoreGui:FindFirstChild("BIELZIN") then CoreGui["BIELZIN"]:Destroy() end

-- Criando a Interface (Estilo MakalHub)
local MakalUI = Instance.new("ScreenGui", CoreGui)
MakalUI.Name = "BIELZIN"

local MainFrame = Instance.new("Frame", MakalUI)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(140, 0, 255)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "BIELZIN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold

local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0, 45)
Status.BackgroundTransparency = 1
Status.Text = "Verificando Jogo..."
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.TextSize = 14
Status.Font = Enum.Font.Gotham

local BarBack = Instance.new("Frame", MainFrame)
BarBack.Size = UDim2.new(0.8, 0, 0, 4)
BarBack.Position = UDim2.new(0.1, 0, 0, 85)
BarBack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
BarBack.BorderSizePixel = 0
Instance.new("UICorner", BarBack)

local BarFill = Instance.new("Frame", BarBack)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
BarFill.BorderSizePixel = 0
Instance.new("UICorner", BarFill)

-- Animação de Entrada
MainFrame:TweenSize(UDim2.new(0, 320, 0, 120), "Out", "Quad", 0.5, true)

task.spawn(function()
    task.wait(0.6)
    
    Status.Text = "Injetando Bypass de Coleta..."
    TweenService:Create(BarFill, TweenInfo.new(1.5), {Size = UDim2.new(0.7, 0, 1, 0)}):Play()
    
    -- FUNÇÃO DE COLETA (REMOVE A BOLINHA)
    local function aplicarBypass(p)
        if p:IsA("ProximityPrompt") then
            p.HoldDuration = 0
        end
    end

    -- Aplica nos itens que já existem
    for _, v in pairs(game:GetDescendants()) do
        aplicarBypass(v)
    end

    -- Aplica em itens novos que aparecerem
    game.DescendantAdded:Connect(aplicarBypass)

    -- Bypass de clique forçado
    game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
        p.HoldDuration = 0
        fireproximityprompt(p)
    end)

    task.wait(1.5)
    Status.Text = "Ativado com Sucesso!"
    TweenService:Create(BarFill, TweenInfo.new(0.5), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(0.8)

    -- Animação de Saída
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.5, true)
    task.wait(0.5)
    MakalUI:Destroy()
end)
