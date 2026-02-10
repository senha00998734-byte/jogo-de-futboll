--[[ 
    MAKALHUB LOADER - INSTANT COLLECT + GOD MODE (1 CHANCE)
    Foco: Escape Tsunami For Brainrots
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Limpeza de UI anterior
if CoreGui:FindFirstChild("MakalLoader") then CoreGui["MakalLoader"]:Destroy() end

-- Interface
local MakalUI = Instance.new("ScreenGui", CoreGui)
MakalUI.Name = "MakalLoader"

local MainFrame = Instance.new("Frame", MakalUI)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(140, 0, 255)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "MAKAL HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold

local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0, 45)
Status.BackgroundTransparency = 1
Status.StatusText = "Iniciando..."
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.TextSize = 14
Status.Font = Enum.Font.Gotham

local BarBack = Instance.new("Frame", MainFrame)
BarBack.Size = UDim2.new(0.8, 0, 0, 4)
BarBack.Position = UDim2.new(0.1, 0, 0, 85)
BarBack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", BarBack)

local BarFill = Instance.new("Frame", BarBack)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
Instance.new("UICorner", BarFill)

-- Animação e Ativação
MainFrame:TweenSize(UDim2.new(0, 320, 0, 120), "Out", "Quad", 0.5, true)

task.spawn(function()
    task.wait(0.6)
    
    Status.Text = "Ativando God Mode (1 Chance)..."
    TweenService:Create(BarFill, TweenInfo.new(1), {Size = UDim2.new(0.5, 0, 1, 0)}):Play()
    
    -- FUNÇÃO GOD MODE (Remove scripts de dano local)
    if lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("Script") and (v.Name:find("Dano") or v.Name:find("Kill")) then
                v.Disabled = true
            end
        end
    end

    task.wait(1)
    Status.Text = "Injetando Coleta Instantânea..."
    TweenService:Create(BarFill, TweenInfo.new(1), {Size = UDim2.new(0.8, 0, 1, 0)}):Play()
    
    -- COLETA INSTANTÂNEA
    game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
        p.HoldDuration = 0
        fireproximityprompt(p)
    end)

    task.wait(1)
    Status.Text = "Tudo Pronto!"
    TweenService:Create(BarFill, TweenInfo.new(0.5), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(0.5)

    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.5, true)
    task.wait(0.5)
    MakalUI:Destroy()
end)

-- Sistema de Notificação de Backup
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "God Mode Ativo";
    Text = "Você está protegido contra o Tsunami!";
    Duration = 5;
})
