-- Função para Notificação (Para você saber que funcionou)
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 5;
    })
end

Notify("Script FIFA", "Iniciando modificações...")

-- 1. AJUSTE DO GOL (Hitbox)
-- No FIFA, os gols geralmente ficam dentro de 'Map' ou 'Field'
local function adjustGoals()
    local goalFound = false
    -- Procura em todo o workspace por objetos chamados 'Goal' ou 'Hitbox'
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Goal" or obj.Name == "Hitbox" then
            if obj:IsA("BasePart") then
                obj.Size = Vector3.new(80, 80, 80)
                obj.Transparency = 0.6
                obj.CanCollide = false
                obj.Color = Color3.fromRGB(255, 0, 0) -- Fica vermelho para você ver
                goalFound = true
            end
        end
    end
    
    if goalFound then
        Notify("Gols", "Hitboxes gigantes ativadas!")
    else
        warn("Gols não encontrados no mapa.")
    end
end

-- 2. VELOCIDADE (WalkSpeed)
-- FIFA costuma resetar a velocidade, então precisamos forçar em um loop
task.spawn(function()
    while true do
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 25 -- Ajuste aqui
        end
        task.wait(0.1)
    end
end)

-- 3. ESTAMINA (Tentativa Genérica)
-- Como o FIFA usa sistemas protegidos, tentamos resetar valores comuns de estamina
task.spawn(function()
    while true do
        local char = game.Players.LocalPlayer.Character
        if char then
            -- Procura por valores de estamina dentro do personagem
            for _, val in pairs(char:GetDescendants()) do
                if val.Name:lower():find("stamina") or val.Name:lower():find("energy") then
                    if val:IsA("NumberValue") or val:IsA("IntValue") then
                        val.Value = 100
                    end
                end
            end
        end
        task.wait(1)
    end
end)

-- Executar
adjustGoals()
Notify("Status", "Script pronto!")
