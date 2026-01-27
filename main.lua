-- CONFIGURAÇÕES
local TamanhoHitbox = Vector3.new(25, 20, 15)
local DeslocamentoParaFrente = 1.5 
local VelocidadeRecargaEstamina = 50 -- Valor alto para carregar instantâneo

-- 1. AJUSTE DO GOL (Posicionado para frente)
local function adjustGoals()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Goal" or obj.Name == "Hitbox" then
            if obj:IsA("BasePart") then
                obj.Size = TamanhoHitbox
                obj.Transparency = 1 
                obj.CanCollide = false
                -- Move a hitbox levemente para frente
                obj.CFrame = obj.CFrame * CFrame.new(0, 0, -DeslocamentoParaFrente)
            end
        end
    end
end

-- 2. ESTAMINA ULTRA RÁPIDA
task.spawn(function()
    while true do
        local player = game.Players.LocalPlayer
        local char = player.Character
        
        if char then
            -- Procura por valores de estamina no personagem e na pasta de Stats
            for _, v in pairs(char:GetDescendants()) do
                if v.Name:lower():find("stamina") or v.Name:lower():find("energy") then
                    if v:IsA("NumberValue") or v:IsA("IntValue") then
                        v.Value = 100 -- Mantém sempre cheio
                    end
                end
            end
            
            -- Tenta forçar a regeneração via Humanoid (comum em alguns jogos de esporte)
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = 24 -- Velocidade que combinamos
            end
        end
        
        -- Tenta acessar o módulo de UI da estamina para resetar o delay de recarga
        pcall(function()
            local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            -- Varre as interfaces procurando pela barra de estamina para forçar o preenchimento visual
            for _, gui in pairs(PlayerGui:GetDescendants()) do
                if gui.Name:lower():find("stamina") and gui:IsA("Frame") then
                    if gui:FindFirstChild("Bar") then
                        gui.Bar.Size = UDim2.new(1,
