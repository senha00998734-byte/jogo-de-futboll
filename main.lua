local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

_G.OceanXActive = false

-- Interface super leve (pra não travar o Xeno)
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OceanX_Brenhot"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 200, 0, 100)
main.Position = UDim2.new(0.5, -100, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Active = true
main.Draggable = true

local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(1, 0, 1, 0)
btn.Text = "ATIVAR TUDO\n(Tsunami Brenhot)"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
btn.Font = Enum.Font.GothamBold

-- Lógica de Bypass
RunService.Stepped:Connect(function()
    if _G.OceanXActive then
        local char = player.Character
        if char then
            -- GOD MODE: Mantém as partes do corpo presas (evita morrer pro tsunami)
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanTouch = false -- Bypass de toque no tsunami
                end
            end
            
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            
            if hum and root then
                -- Vida infinita
                hum.MaxHealth = math.huge
                hum.Health = math.huge
                
                -- SPEED 500 BYPASS: Empurra o personagem fisicamente
                if hum.MoveDirection.Magnitude > 0 and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    root.Velocity = hum.MoveDirection * 500 -- Aqui está a força 500
                end
            end
        end
    end
end)

btn.MouseButton1Click:Connect(function()
    _G.OceanXActive = not _G.OceanXActive
    if _G.OceanXActive then
        btn.Text = "STATUS: LIGADO"
        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    else
        btn.Text = "STATUS: DESLIGADO"
        btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        -- Restaura colisões ao desligar
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanTouch = true end
            end
        end
    end
end)
