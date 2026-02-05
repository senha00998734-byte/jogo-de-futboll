-- Configurações de Velocidade Extrema
local speedValue = 500 

local function applyGodMode(character)
    if not character then return end
    task.wait(0.5)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        -- God Mode (Invencibilidade)
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        
        -- Loop de Velocidade Forçada (Bypass para o Tsunami do Brenhot)
        -- Usamos um loop para garantir que o jogo não mude de volta para 16
        task.spawn(function()
            while godMode and task.wait() do
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    humanoid.WalkSpeed = speedValue
                else
                    humanoid.WalkSpeed = 16 -- Velocidade normal quando não está correndo
                end
                
                -- Se o humanoide morrer ou sumir, para o loop
                if not humanoid or not humanoid.Parent then break end
            end
        end)

        -- Efeito visual
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then part.Transparency = 0.5 end
        end
    end
end
