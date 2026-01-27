-- Função de Notificação para saber se o script rodou
local function Avisar(t, m)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = t, Text = m, Duration = 5})
end

Avisar("Iniciando", "Procurando Gols e Estamina...")

-- 1. LOCALIZADOR DE GOLS DINÂMICO
-- Em vez de procurar "Stadium", procuramos por qualquer Hitbox perto de redes
task.spawn(function()
    local sucessoGol = false
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Procura por peças que costumam ser o sensor do gol
        if obj:IsA("BasePart") and (obj.Name:find("Goal") or obj.Name:find("Hitbox") or obj.Name:find("GoalArea")) then
            obj.Size = Vector3.new(25, 20, 15)
            obj.Transparency = 0.5 -- Deixei visível (meio transparente) para você confirmar se achou!
            obj.CanCollide = false
            obj.CFrame = obj.CFrame * CFrame.new(0, 0, -2) -- Move para frente
            sucessoGol = true
        end
    end
    if sucessoGol then Avisar("Gols", "Hitboxes localizadas!") end
end)

-- 2. RECARGA DE ESTAMINA (Método Forçado)
task.spawn(function()
    local player = game.Players.LocalPlayer
    while task.wait(0.2) do
        -- Busca no Personagem
        local char = player.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("NumberValue") or v:IsA("IntValue") then
                    if v.Name:lower():find("stamina") or v.Name:lower():find("energy") or v.Name:lower():find("sprint") then
                        v.Value = 100
                    end
                end
            end
        end
        -- Busca na PlayerGui (onde fica a barra visual)
        for _, v in pairs(player.PlayerGui:GetDescendants()) do
            if v:IsA("NumberValue") and (v.Name:lower():find("stamina") or v.Name:lower():find("energy")) then
                v.Value = 100
            end
        end
    end
end)

-- 3. VELOCIDADE E CHUTE
game:GetService("RunService").Heartbeat:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 24
    end
end)

Avisar("Pronto", "Mods ativos. Verifique os gols!")
