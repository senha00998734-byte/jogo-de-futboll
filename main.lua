-- Script para Coleta Instantânea (Ignorar tempo de espera)
local ProximityPromptService = game:GetService("ProximityPromptService")

-- Sempre que um círculo de coleta aparecer ou for clicado
ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    -- Define o tempo de espera para zero e finaliza a ação na hora
    prompt.HoldDuration = 0
    fireproximityprompt(prompt)
end)

print("Coleta Instantânea Ativada!")
