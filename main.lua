local games = {
    [7211666966] = {name = "Tower Of Jump", url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/TOJ"},
    [118915549367482] = {name = "Dont Wake The Brainrots", url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/dont%20wake%20the%20brainrots"},
    [136801880565837] = {name = "[FPS] Flick", url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/flick"},
    [136407404714539] = {name = "Find the Brainrot [256]", url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/findbrainrots"},
    [120135584963579] = {name = "Don't Steal the Bubu 🐻", url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/dstb"},
    [118614517739521] = {name = "Blind Shot", url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/blindshot"},
    [18799085098] = {name = "💀 Hide or Die!", url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/hideordie"},
    [131623223084840] = {name = "Escape Tsunami For Brainrots!", url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/etfb"}
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- [Função de UI de Carregamento omitida para brevidade, mas permanece igual no seu original]
-- ... (mantenha as funções createLoadingUI e createUnsupportedUI que você já tem) ...

local currentPlaceId = game.PlaceId
local gameData = games[currentPlaceId]

if gameData then
    local ui, statusLabel = createLoadingUI(gameData.name)
    task.wait(0.5)  
    
    -- Execução direta sem checagem de Key
    local success, err = pcall(function()
        local scriptContent = game:HttpGet(gameData.url)
        loadstring(scriptContent)()
    end)

    if success then
        statusLabel.Text = "✅ Mystrix Hub Carregado!"
        statusLabel.TextColor3 = Color3.fromRGB(180, 240, 140)
        task.wait(1.5)
        ui:Destroy()
    else
        statusLabel.Text = "❌ Erro ao carregar: \n" .. tostring(err)
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(5)
        ui:Destroy()
    end
else
    createUnsupportedUI()
end
