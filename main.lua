local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

_G.GodModeActive = false

-- Interface Minimalista
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.15, 0)
btn.Text = "SUPER GOD: OFF"
btn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
btn.TextColor3 = Color3.new(1, 1, 1)

-- Sistema de Noclip e Velocidade
RunService.Stepped:Connect(function()
    if _G.GodModeActive then
        local char = player.Character
        if char then
            -- NOCLIP: Você atravessa a onda, ela não te empurra nem te mata
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.CanTouch = false -- Isso impede que o script de morte do Brenhot te detecte
                end
            end
            
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if root and hum then
                -- Anti-Morte por HP
                hum.MaxHealth = 9e9
                hum.Health = 9e9

                -- Velocidade 500 Forçada (Bypass)
                if hum.MoveDirection.Magnitude > 0 and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    root.Velocity = Vector3.new(hum.MoveDirection.X * 500, 2, hum.MoveDirection.Z * 500)
                else
                    -- Pequena força para cima para você não afundar no chão
                    root.Velocity = Vector3.new(0, 1.5, 0) 
                end
            end
        end
    end
end)

btn.MouseButton1Click:Connect(function()
    _G.GodModeActive = not _G.GodModeActive
    if _G.GodModeActive then
        btn.Text = "SUPER GOD: ON"
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        print("Bypass Brenhot Ativado!")
    else
        btn.Text = "SUPER GOD: OFF"
        btn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    end
end)
