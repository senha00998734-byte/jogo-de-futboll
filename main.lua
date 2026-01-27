-- Configurações de Tamanho do Gol
local newSize = Vector3.new(100, 100, 100)

-- Função para ajustar os gols com segurança
local function adjustGoals()
    pcall(function()
        workspace.Stadium.Teams.Away.Goal.Hitbox.Size = newSize
        workspace.Stadium.Teams.Home.Goal.Hitbox.Size = newSize
    end)
end

-- Estamina Infinita
getgenv().InfiniteStamina = true 
local StaminaModule = require(game.Players.LocalPlayer.PlayerScripts.Client.Controllers.Stamina)
getgenv().OriginalConsume = StaminaModule.Consume

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().InfiniteStamina then
            -- Sobrescreve a função de consumo
            StaminaModule.Consume = function() return true end
            
            -- Tenta setar o valor da estamina para 100
            if StaminaModule.Amount then 
                StaminaModule.Amount:set(100) 
            end
            
            -- Varre o módulo para garantir que variáveis numéricas fiquem em 100
            for k, v in pairs(StaminaModule) do
                if type(v) == "number" and v <= 100 then 
                    StaminaModule[k] = 100 
                end
            end
        else
            StaminaModule.Consume = getgenv().OriginalConsume
        end
    end
end)

-- Velocidade de Caminhada (WalkSpeed)
game:GetService("RunService").Heartbeat:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 27 -- Ajuste a velocidade aqui
    end
end)

adjustGoals()
