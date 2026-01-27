-- CONFIGURAÇÕES (Ajuste aqui se precisar)
local TamanhoHitbox = Vector3.new(20, 20, 20) -- Diminuído de 100 para 20 (mais discreto)
local ForcaDoChute = 1.3 -- Reduzi um pouco para não isolar a bola
local AlcancePegarBola = 8 -- Distância que você consegue interagir com a bola

-- 1. AJUSTE DO GOL (Menor e Invisível)
local function adjustGoals()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Goal" or obj.Name == "Hitbox" then
            if obj:IsA("BasePart") then
                obj.Size = TamanhoHitbox
                obj.Transparency = 1 
                obj.CanCollide = false
            end
        end
    end
end

-- 2. CHUTE E ALCANCE (Detectando a bola)
task.spawn(function()
    while task.wait(0.1) do
        local char = game.Players.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if hrp then
            for _, bola in pairs(workspace:GetDescendants()) do
                if bola.Name == "Ball" or bola.Name == "Football" then
                    local distancia = (hrp.Position - bola.Position).Magnitude
                    
                    -- Se a bola estiver no seu alcance
                    if distancia < AlcancePegarBola then
                        -- Se você estiver muito perto, dá o impulso do chute
                        if distancia < 5 then
                            bola.AssemblyLinearVelocity = bola.AssemblyLinearVelocity * ForcaDoChute
                        end
                    end
                end
            end
        end
    end
end)

-- 3. VELOCIDADE E ESTAMINA
task.spawn(function()
    while true do
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 24 -- Velocidade levemente reduzida para parecer natural
        end
        task.wait(0.5)
    end
end)

adjustGoals()
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Mod Atualizado",
    Text = "Hitbox reduzida para 20x20",
    Duration = 5
})
