local games = {
    [7211666966] = {
        name = "Tower Of Jump",
        url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/TOJ"
    },
    [118915549367482] = {
        name = "Dont Wake The Brainrots",
        url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/dont%20wake%20the%20brainrots"
    },
    [136801880565837] = {
        name = "[FPS] Flick",
        url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/flick"
    },
    [136407404714539] = {
        name = "Find the Brainrot [256]",
        url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/findbrainrots"
    },
    [120135584963579] = {
        name = "Don't Steal the Bubu 🐻",
        url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/dstb"
    },
    [118614517739521] = {
        name = "Blind Shot",
        url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/blindshot"
    },
    [18799085098] = {
        name = "💀 Hide or Die!",
        url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/hideordie"
    },
    [131623223084840] = {
        name = "Escape Tsunami For Brainrots!",
        url = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/etfb"
    }
}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local function createLoadingUI(gameName)
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Status = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    ScreenGui.Name = "MystrixLoader"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    Frame.BorderSizePixel = 0
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    if isMobile then
        Frame.Size = UDim2.new(0.85, 0, 0, 220)
    else
        Frame.Size = UDim2.new(0, 440, 0, 220)
    end
    local BGGradient = Instance.new("UIGradient")
    BGGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 26)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 20, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 26))
    }
    BGGradient.Rotation = 45
    BGGradient.Parent = Frame
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 18)
    Corner.Parent = Frame
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(40, 40, 60)
    Stroke.Thickness = 3
    local StrokeGradient = Instance.new("UIGradient")
    StrokeGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 70, 150)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 100, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 70, 150))
    }
    StrokeGradient.Rotation = 135
    StrokeGradient.Parent = Stroke
    Stroke.Parent = Frame
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = Frame
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Size = UDim2.new(1, 44, 1, 44)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(80, 60, 120)
    Shadow.ImageTransparency = 0.4
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Parent = Frame
    Glow.BackgroundTransparency = 1
    Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Glow.AnchorPoint = Vector2.new(0.5, 0.5)
    Glow.Size = UDim2.new(1, 60, 1, 60)
    Glow.ZIndex = 0
    Glow.Image = "rbxassetid://5554236805"
    Glow.ImageColor3 = Color3.fromRGB(140, 100, 200)
    Glow.ImageTransparency = 0.7
    Glow.ScaleType = Enum.ScaleType.Slice
    Glow.SliceCenter = Rect.new(23, 23, 277, 277)
    Title.Parent = Frame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 0, 0, 30)
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Font = Enum.Font.GothamBlack
    Title.Text = "MYSTRIX HUB"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = isMobile and 32 or 38
    Title.TextStrokeTransparency = 1
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 140, 240)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 140, 240))
    }
    TitleGradient.Rotation = 90
    TitleGradient.Parent = Title
    local Divider = Instance.new("Frame")
    Divider.Name = "Divider"
    Divider.Parent = Frame
    Divider.BackgroundColor3 = Color3.fromRGB(140, 100, 200)
    Divider.BorderSizePixel = 0
    Divider.AnchorPoint = Vector2.new(0.5, 0)
    Divider.Position = UDim2.new(0.5, 0, 0, 90)
    if isMobile then
        Divider.Size = UDim2.new(0.85, 0, 0, 3)
    else
        Divider.Size = UDim2.new(0, 380, 0, 3)
    end
    local DividerGradient = Instance.new("UIGradient")
    DividerGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 70, 150)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180, 140, 240)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180, 140, 240)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 70, 150))
    }
    DividerGradient.Rotation = 90
    DividerGradient.Parent = Divider
    Status.Parent = Frame
    Status.BackgroundTransparency = 1
    Status.Position = UDim2.new(0, 0, 0, 105)
    Status.Size = UDim2.new(1, 0, 0, 80)
    Status.Font = Enum.Font.GothamMedium
    Status.Text = "Detected: " .. gameName .. "\n\nLoading script..."
    Status.TextColor3 = Color3.fromRGB(200, 200, 220)
    Status.TextSize = isMobile and 14 or 15
    Status.TextWrapped = true
    Status.TextXAlignment = Enum.TextXAlignment.Center
    Status.TextYAlignment = Enum.TextYAlignment.Top
    Status.TextStrokeTransparency = 1
    local LoadingBarBg = Instance.new("Frame")
    LoadingBarBg.Parent = Frame
    LoadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 26, 40)
    LoadingBarBg.BorderSizePixel = 0
    LoadingBarBg.AnchorPoint = Vector2.new(0.5, 0)
    LoadingBarBg.Position = UDim2.new(0.5, 0, 0, 160)
    if isMobile then
        LoadingBarBg.Size = UDim2.new(0.7, 0, 0, 8)
    else
        LoadingBarBg.Size = UDim2.new(0, 280, 0, 8)
    end
    local LoadingBarBgCorner = Instance.new("UICorner")
    LoadingBarBgCorner.CornerRadius = UDim.new(1, 0)
    LoadingBarBgCorner.Parent = LoadingBarBg
    local LoadingBar = Instance.new("Frame")
    LoadingBar.Parent = LoadingBarBg
    LoadingBar.BackgroundColor3 = Color3.fromRGB(180, 140, 240)
    LoadingBar.BorderSizePixel = 0
    LoadingBar.Size = UDim2.new(0, 0, 1, 0)
    local LoadingBarGradient = Instance.new("UIGradient")
    LoadingBarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 100, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 140, 240))
    }
    LoadingBarGradient.Rotation = 90
    LoadingBarGradient.Parent = LoadingBar 
    local LoadingBarCorner = Instance.new("UICorner")
    LoadingBarCorner.CornerRadius = UDim.new(1, 0)
    LoadingBarCorner.Parent = LoadingBar
    task.spawn(function()
        for i = 1, 100 do
            if LoadingBar and LoadingBar.Parent then
                LoadingBar.Size = UDim2.new(i/100, 0, 1, 0)
                task.wait(0.03)
            else
                break
            end
        end
    end)
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Frame
    CloseButton.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -40, 0, 16)
    CloseButton.Size = UDim2.new(0, 28, 0, 28)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    CloseButton.TextStrokeTransparency = 1 
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseButton
    if not isMobile then
        CloseButton.MouseEnter:Connect(function()
            TweenService:Create(CloseButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(180, 140, 240)
            }):Play()
        end)
        CloseButton.MouseLeave:Connect(function()
            TweenService:Create(CloseButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 55, 80)
            }):Play()
        end)
    end
    local originalSize = CloseButton.Size
    CloseButton.MouseButton1Down:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.1), {
            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 4, originalSize.Y.Scale, originalSize.Y.Offset - 4)
        }):Play()
    end)
    CloseButton.MouseButton1Up:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.1), {
            Size = originalSize
        }):Play()
    end)
    CloseButton.MouseButton1Click:Connect(function()
        local shrinkTween = TweenService:Create(
            Frame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        ) 
        local fadeTween = TweenService:Create(
            Frame,
            TweenInfo.new(0.3),
            {BackgroundTransparency = 1}
        )    
        shrinkTween:Play()
        fadeTween:Play()
        wait(0.3)
        ScreenGui:Destroy()
    end)
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(0, 0, 0, 0)
    local targetSize = isMobile and UDim2.new(0.85, 0, 0, 220) or UDim2.new(0, 440, 0, 220)
    TweenService:Create(
        Frame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = targetSize}
    ):Play()
    TweenService:Create(
        Frame,
        TweenInfo.new(0.4),
        {BackgroundTransparency = 0}
    ):Play()
    return ScreenGui, Status, LoadingBar
end
local function createUnsupportedUI()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Message = Instance.new("TextLabel")
    local DiscordButton = Instance.new("TextButton")
    local CloseButton = Instance.new("TextButton")
    ScreenGui.Name = "MystrixLoader"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    Frame.BorderSizePixel = 0
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    if isMobile then
        Frame.Size = UDim2.new(0.85, 0, 0, 250)
    else
        Frame.Size = UDim2.new(0, 440, 0, 250)
    end
    local BGGradient = Instance.new("UIGradient")
    BGGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 26)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 20, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 26))
    }
    BGGradient.Rotation = 45
    BGGradient.Parent = Frame
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 18)
    Corner.Parent = Frame
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(40, 40, 60)
    Stroke.Thickness = 3
    local StrokeGradient = Instance.new("UIGradient")
    StrokeGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 70, 150)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 100, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 70, 150))
    }
    StrokeGradient.Rotation = 135
    StrokeGradient.Parent = Stroke
    Stroke.Parent = Frame
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = Frame
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Size = UDim2.new(1, 44, 1, 44)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(80, 60, 120)
    Shadow.ImageTransparency = 0.4
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Parent = Frame
    Glow.BackgroundTransparency = 1
    Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Glow.AnchorPoint = Vector2.new(0.5, 0.5)
    Glow.Size = UDim2.new(1, 60, 1, 60)
    Glow.ZIndex = 0
    Glow.Image = "rbxassetid://5554236805"
    Glow.ImageColor3 = Color3.fromRGB(140, 100, 200)
    Glow.ImageTransparency = 0.7
    Glow.ScaleType = Enum.ScaleType.Slice
    Glow.SliceCenter = Rect.new(23, 23, 277, 277)
    Title.Parent = Frame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 0, 0, 30)
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Font = Enum.Font.GothamBlack
    Title.Text = "MYSTRIX HUB"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = isMobile and 32 or 38
    Title.TextStrokeTransparency = 1 
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 140, 240)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 140, 240))
    }
    TitleGradient.Rotation = 90
    TitleGradient.Parent = Title
    local Divider = Instance.new("Frame")
    Divider.Name = "Divider"
    Divider.Parent = Frame
    Divider.BackgroundColor3 = Color3.fromRGB(140, 100, 200)
    Divider.BorderSizePixel = 0
    Divider.AnchorPoint = Vector2.new(0.5, 0)
    Divider.Position = UDim2.new(0.5, 0, 0, 90)
    if isMobile then
        Divider.Size = UDim2.new(0.85, 0, 0, 3)
    else
        Divider.Size = UDim2.new(0, 380, 0, 3)
    end 
    local DividerGradient = Instance.new("UIGradient")
    DividerGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 70, 150)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180, 140, 240)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180, 140, 240)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 70, 150))
    }
    DividerGradient.Rotation = 90
    DividerGradient.Parent = Divider
    Message.Parent = Frame
    Message.BackgroundTransparency = 1
    Message.Position = UDim2.new(0, 0, 0, 105)
    Message.Size = UDim2.new(1, 0, 0, 80)
    Message.Font = Enum.Font.GothamMedium
    Message.Text = "⚠️ Game not supported\n\nPlace ID: " .. tostring(game.PlaceId)
    Message.TextColor3 = Color3.fromRGB(255, 200, 100)
    Message.TextSize = isMobile and 14 or 15
    Message.TextWrapped = true
    Message.TextXAlignment = Enum.TextXAlignment.Center
    Message.TextYAlignment = Enum.TextYAlignment.Top
    Message.TextStrokeTransparency = 1 
    DiscordButton.Name = "DiscordButton"
    DiscordButton.Parent = Frame
    DiscordButton.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
    DiscordButton.BorderSizePixel = 0
    DiscordButton.AnchorPoint = Vector2.new(0.5, 0)
    DiscordButton.Position = UDim2.new(0.5, 0, 0, 180)
    if isMobile then
        DiscordButton.Size = UDim2.new(0.7, 0, 0, 40)
    else
        DiscordButton.Size = UDim2.new(0, 200, 0, 40)
    end
    DiscordButton.Font = Enum.Font.GothamBold
    DiscordButton.Text = "JOIN DISCORD"
    DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordButton.TextSize = isMobile and 14 or 15
    DiscordButton.TextStrokeTransparency = 1
    local DiscordGradient = Instance.new("UIGradient")
    DiscordGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 100, 240)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 120, 255))
    }
    DiscordGradient.Rotation = 45
    DiscordGradient.Parent = DiscordButton
    local DiscordCorner = Instance.new("UICorner")
    DiscordCorner.CornerRadius = UDim.new(0, 10)
    DiscordCorner.Parent = DiscordButton  
    DiscordButton.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/XV66VWqAaN")
        DiscordButton.Text = "COPIED!"
        wait(2)
        DiscordButton.Text = "JOIN DISCORD"
    end)
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Frame
    CloseButton.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -40, 0, 16)
    CloseButton.Size = UDim2.new(0, 28, 0, 28)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    CloseButton.TextStrokeTransparency = 1 
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseButton
    if not isMobile then
        CloseButton.MouseEnter:Connect(function()
            TweenService:Create(CloseButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(180, 140, 240)
            }):Play()
        end)
        CloseButton.MouseLeave:Connect(function()
            TweenService:Create(CloseButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 55, 80)
            }):Play()
        end)
        DiscordButton.MouseEnter:Connect(function()
            TweenService:Create(DiscordButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(140, 120, 255)
            }):Play()
        end)
        DiscordButton.MouseLeave:Connect(function()
            TweenService:Create(DiscordButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(100, 80, 200)
            }):Play()
        end)
    end
    local function addButtonAnimation(button)
        local originalSize = button.Size
        button.MouseButton1Down:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 4, originalSize.Y.Scale, originalSize.Y.Offset - 4)
            }):Play()
        end)   
        button.MouseButton1Up:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.1), {
                Size = originalSize
            }):Play()
        end)
    end
    addButtonAnimation(DiscordButton)
    addButtonAnimation(CloseButton)    
    CloseButton.MouseButton1Click:Connect(function()
        local shrinkTween = TweenService:Create(
            Frame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )    
        shrinkTween:Play()
        wait(0.3)
        ScreenGui:Destroy()
    end)
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(0, 0, 0, 0)
    local targetSize = isMobile and UDim2.new(0.85, 0, 0, 250) or UDim2.new(0, 440, 0, 250)
    TweenService:Create(
        Frame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = targetSize}
    ):Play()  
    TweenService:Create(
        Frame,
        TweenInfo.new(0.4),
        {BackgroundTransparency = 0}
    ):Play()  
    return ScreenGui
end
local currentPlaceId = game.PlaceId
local gameData = games[currentPlaceId]
if gameData then
    local ui, statusLabel = createLoadingUI(gameData.name)
    wait(0.5)  
    local success, err = pcall(function()
        local script = game:HttpGet(gameData.url)
        loadstring(script)()
    end)
    if success then
        statusLabel.Text = "Loaded successfully!\n\nClosing..."
        statusLabel.TextColor3 = Color3.fromRGB(180, 240, 140)
        wait(1.5)
        ui:Destroy()
    else
        statusLabel.Text = "Error loading script:\n" .. tostring(err)
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(5)
        ui:Destroy()
    end
else
    createUnsupportedUI()
end
