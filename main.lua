-- CONFIGURAÇÕES
local TamanhoHitbox = Vector3.new(100, 100, 100)
local ForcaDoChute = 1.5 -- 1.0 é o normal, 2.0 é o dobro de força

-- 1. AJUSTE DO GOL (Invisível)
local function adjustGoals()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Goal" or obj.Name == "Hitbox" then
            if obj:IsA("BasePart") then
                obj.Size = TamanhoHitbox
                obj.Transparency = 1 -- 1 deixa totalmente invisível
                obj.CanCollide = false
            end
        end
    end
end

-- 2. CHUTE MAIS FORTE (Impulso na Bola)
task.spawn(function()
    while task.wait(0.1) do
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Procura a bola perto do jogador
            for _, bola in pairs(workspace:GetDescendants()) do
                if bola.Name == "Ball" or bola.Name == "Football" then
                    local distancia = (char.HumanoidRootPart.Position - bola.Position).Magnitude
                    
                    -- Se a bola estiver perto (distância de chute)
                    if distancia < 6 then
                        -- Aplica uma força extra na direção que a bola já está indo
                        bola.AssemblyLinearVelocity = bola.AssemblyLinearVelocity * ForcaDoChute
                    end
                end
            end
        end
    end
end)

-- 3. VELOCIDADE E ESTAMINA (Melhorados)
task.spawn(function()
    while true do
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 28
            
            -- Tenta manter a estamina cheia
            local stats = char:FindFirstChild("Stats") or char:FindFirstChild("Values")
            if stats then
                local stamin = stats:FindFirstChild("Stamina")
                if stamin then stamin.Value = 100 end
            end
        end
        task.wait(0.5)
    end
end)

adjustGoals()
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Mod Ativado",
    Text = "Gol Invisível + Chute Forte",
    Duration = 5
})
