-- Variáveis extras para o sistema de velocidade
local walkSpeedActive = false
local normalSpeed = 16
local fastSpeed = 100 -- Ajuste aqui a velocidade que desejar

-- Função melhorada de God Mode e Velocidade
local function applyGodMode(character)
    if not character then return end
    task.wait(0.5)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        -- Torna invencível removendo estados de dano
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        
        -- Impede que o personagem morra por dano comum
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        
        -- Sistema de Velocidade (Run)
        local speedConnection
        speedConnection = RunService.RenderStepped:Connect(function()
            if not godMode then 
                speedConnection:Disconnect() 
                return 
            end
            
            -- Se segurar Shift, corre. Se não, volta ao normal.
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                humanoid.WalkSpeed = fastSpeed
            else
                humanoid.WalkSpeed = normalSpeed
            end
        end)
        
        -- Efeito visual de transparência para indicar God Mode
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0.5
            end
        end
    end
end

-- Função para desativar
local function removeGodMode(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid.WalkSpeed = normalSpeed
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
end

-- Função de Toggle atualizada
local function toggleGodMode()
    godMode = not godMode
    
    if godMode then
        godBtn.Text = "God Mode + Speed: ON"
        godBtn.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
        status.Text = "God Mode: Ativo (Segure SHIFT para correr)"
        
        applyGodMode(player.Character)
        
        -- Conexão para quando o player resetar
        _G.GodConn = player.CharacterAdded:Connect(function(char)
            applyGodMode(char)
        end)
    else
        godBtn.Text = "God Mode beta: OFF"
        godBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        status.Text = "God Mode: Inativo"
        
        if _G.GodConn then _G.GodConn:Disconnect() end
        removeGodMode(player.Character)
    end
end

-- Atualize o botão original para a nova função
godBtn.MouseButton1Click:Connect(toggleGodMode)
