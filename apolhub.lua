-- ИСПРАВЛЕННАЯ ФУНКЦИЯ ДЛЯ ЗАГРУЗКИ СКРИПТОВ (ВСТАВИТЬ В ЧАСТЬ 1)
local function createScriptLoader(parent, title, desc, loadStringStr)
    local f = Instance.new("Frame", parent)
    f.Size, f.BackgroundColor3 = UDim2.new(1, -6, 0, 42), Color3.fromRGB(24, 20, 20)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel", f)
    lbl.Size, lbl.Position, lbl.BackgroundTransparency = UDim2.new(1, -110, 1, 0), UDim2.new(0, 10, 0, 0), 1
    lbl.TextColor3, lbl.Text, lbl.Font, lbl.TextSize, lbl.TextXAlignment = Color3.fromRGB(255, 255, 255), title .. " \n" .. desc, Enum.Font.Gotham, 11, Enum.TextXAlignment.Left

    local b = Instance.new("TextButton", f)
    b.Size, b.Position, b.BackgroundColor3, b.TextColor3 = UDim2.new(0, 90, 0, 26), UDim2.new(1, -100, 0, 8), Color3.fromRGB(45, 15, 15), Color3.fromRGB(255, 50, 50)
    b.Text, b.Font, b.TextSize = "ЗАПУСТИТЬ", Enum.Font.GothamBold, 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    local bStroke = Instance.new("UIStroke", b) bStroke.Color = Color3.fromRGB(255, 30, 30)
    
    b.MouseButton1Click:Connect(function()
        b.Text = "ЗАГРУЗКА..."
        task.spawn(function()
            local success, rawCode = pcall(function() 
                return game:HttpGet(loadStringStr) 
            end)
            
            if success and rawCode then
                b.Text = "АКТИВЕН"
                b.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
                b.TextColor3 = Color3.fromRGB(50, 255, 50)
                bStroke.Color = Color3.fromRGB(30, 255, 30)
                
                -- Выполняем скрипт без изоляции pcall, чтобы он имел полный доступ к эксплоиту
                local func = loadstring(rawCode)
                if func then 
                    func() 
                end
            else
                b.Text = "ОШИБКА HTTP"
                b.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
                b.TextColor3 = Color3.fromRGB(255, 100, 100)
                warn("Apol.hub: Не удалось скачать скрипт " .. title)
            end
        end)
    end)
end
-- ==================== ИСПРАВЛЕННАЯ ФУНКЦИЯ ЗАГРУЗКИ (БЕЗ БЛОКИРОВОК) ====================
local function createScriptLoader(parent, title, desc, loadStringStr)
    local f = Instance.new("Frame", parent)
    f.Size, f.BackgroundColor3 = UDim2.new(1, -6, 0, 42), Color3.fromRGB(24, 20, 20)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel", f)
    lbl.Size, lbl.Position, lbl.BackgroundTransparency = UDim2.new(1, -110, 1, 0), UDim2.new(0, 10, 0, 0), 1
    lbl.TextColor3, lbl.Text, lbl.Font, lbl.TextSize, lbl.TextXAlignment = Color3.fromRGB(255, 255, 255), title .. " \n" .. desc, Enum.Font.Gotham, 11, Enum.TextXAlignment.Left

    local b = Instance.new("TextButton", f)
    b.Size, b.Position, b.BackgroundColor3, b.TextColor3 = UDim2.new(0, 90, 0, 26), UDim2.new(1, -100, 0, 8), Color3.fromRGB(45, 15, 15), Color3.fromRGB(255, 50, 50)
    b.Text, b.Font, b.TextSize = "ЗАПУСТИТЬ", Enum.Font.GothamBold, 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    local bStroke = Instance.new("UIStroke", b) bStroke.Color = Color3.fromRGB(255, 30, 30)
    
    b.MouseButton1Click:Connect(function()
        b.Text = "ЗАГРУЗКА..."
        task.spawn(function()
            local success, rawCode = pcall(function() 
                return game:HttpGet(loadStringStr) 
            end)
            
            if success and rawCode then
                b.Text = "АКТИВЕН"
                b.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
                b.TextColor3 = Color3.fromRGB(50, 255, 50)
                bStroke.Color = Color3.fromRGB(30, 255, 30)
                
                local func = loadstring(rawCode)
                if func then 
                    func() 
                end
            else
                b.Text = "ОШИБКА HTTP"
                b.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
                b.TextColor3 = Color3.fromRGB(255, 100, 100)
                warn("Apol.hub: Не удалось скачать скрипт " .. title)
            end
        end)
    end)
end

-- НАПОЛНЕНИЕ: ВКЛАДКА СКРИПТЫ
createScriptLoader(scriptsPage, "🎯 Hitbox Expander", "Увеличивает хитбоксы врагов", "https://githubusercontent.com")
createScriptLoader(scriptsPage, "🕺 Bundle Animations", "Кастомные паки анимаций движения", "https://githubusercontent.com")
createScriptLoader(scriptsPage, "🦑 Squid Game X", "Чит-модуль для Squid Game X", "https://githubusercontent.com")
createScriptLoader(scriptsPage, "🌌 Кастомные Шейдеры", "Улучшение графики и пост-обработки", "https://githubusercontent.com")
createScriptLoader(scriptsPage, "🛠 Infinite Yield", "Универсальный админ-скрипт", "https://githubusercontent.com")
scriptsPage.CanvasSize = UDim2.new(0, 0, 0, 240)

-- ==================== СТРАНИЦА 2: OBSERVER (НАБЛЮДЕНИЕ) ====================
local function stopSpec()
    specP = nil
    Cam.CameraSubject = LP.Character and LP.Character:FindFirstChild("Humanoid")
    Title.Text = "「 Apol.hub 」"
end

local function buildObserver()
    for _, item in ipairs(observerPage:GetChildren()) do if item:IsA("Frame") then item:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local Row = Instance.new("Frame", observerPage)
            Row.Size, Row.BackgroundColor3 = UDim2.new(1, -6, 0, 42), Color3.fromRGB(24, 20, 20)
            Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)

            local TeamBar = Instance.new("Frame", Row)
            TeamBar.Size, TeamBar.BorderSizePixel, TeamBar.BackgroundColor3 = UDim2.new(0, 4, 1, 0), 0, p.Team and p.TeamColor.Color or Color3.fromRGB(150, 150, 150)
            Instance.new("UICorner", TeamBar).CornerRadius = UDim.new(0, 4)

            local Disp = Instance.new("TextLabel", Row)
            Disp.Size, Disp.Position, Disp.BackgroundTransparency = UDim2.new(1, -120, 0, 18), UDim2.new(0, 12, 0, 4), 1
            Disp.TextColor3, Disp.Text, Disp.Font, Disp.TextSize, Disp.TextXAlignment = Color3.fromRGB(255, 255, 255), p.DisplayName .. " (@" .. p.Name .. ")", Enum.Font.GothamBold, 11, Enum.TextXAlignment.Left

            local TeamL = Instance.new("TextLabel", Row)
            TeamL.Size, TeamL.Position, TeamL.BackgroundTransparency = UDim2.new(0, 110, 0, 14), UDim2.new(0, 12, 0, 22), 1
            TeamL.TextColor3, TeamL.Text, TeamL.Font, TeamL.TextSize, TeamL.TextXAlignment = p.Team and p.TeamColor.Color or Color3.fromRGB(120, 120, 120), p.Team and p.Team.Name or "Без команды", Enum.Font.Gotham, 10, Enum.TextXAlignment.Left

            local Eye = Instance.new("TextButton", Row)
            Eye.Size, Eye.Position = UDim2.new(0, 26, 0, 26), UDim2.new(1, -34, 0, 8)
            Eye.BackgroundColor3 = (specP == p) and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(45, 15, 15)
            Eye.TextColor3 = (specP == p) and Color3.fromRGB(12, 12, 12) or Color3.fromRGB(255, 100, 100)
            Eye.Text, Eye.Font, Eye.TextSize = "👁", Enum.Font.GothamBold, 11
            Instance.new("UICorner", Eye).CornerRadius = UDim.new(0, 5)
            local EyeStroke = Instance.new("UIStroke", Eye) EyeStroke.Color = Color3.fromRGB(255, 30, 30)

            local TpBtn = Instance.new("TextButton", Row)
            TpBtn.Size, TpBtn.Position, TpBtn.BackgroundColor3, TpBtn.TextColor3 = UDim2.new(0, 45, 0, 26), UDim2.new(1, -85, 0, 8), Color3.fromRGB(35, 15, 15), Color3.fromRGB(220, 220, 220)
            TpBtn.Text, TpBtn.Font, TpBtn.TextSize = "ТП", Enum.Font.GothamBold, 10
            Instance.new("UICorner", TpBtn).CornerRadius = UDim.new(0, 5)
            local TpStroke = Instance.new("UIStroke", TpBtn) TpStroke.Color = Color3.fromRGB(255, 50, 50)

            TpBtn.MouseButton1Click:Connect(function()
                if LP.Character and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LP.Character:FindFirstChild("HumanoidRootPart") then
                    stopSpec()
                    LP.Character.HumanoidRootPart.Velocity = Vector3.zero
                    LP.Character:PivotTo(p.Character.HumanoidRootPart.CFrame)
                end
            end)

            Eye.MouseButton1Click:Connect(function()
                if specP == p then stopSpec() else
                    if p.Character and p.Character:FindFirstChild("Humanoid") then
                        specP = p Cam.CameraSubject = p.Character.Humanoid
                        Title.Text = "👀 Apol СМОТРИТ: " .. p.Name
                    end
                end
                buildObserver()
            end)
        end
    end
    observerPage.CanvasSize = UDim2.new(0, 0, 0, #observerPage:GetChildren() * 48)
end
Players.PlayerAdded:Connect(buildObserver) Players.PlayerRemoving:Connect(buildObserver)
buildObserver()
-- ==================== СТРАНИЦА 3: TARGET ESP & TEAM ESP ====================
local EspMasterBtn = Instance.new("TextButton", espPage)
EspMasterBtn.Size, EspMasterBtn.BackgroundColor3, EspMasterBtn.TextColor3 = UDim2.new(1, -6, 0, 35), Color3.fromRGB(55, 15, 15), Color3.fromRGB(255, 75, 75)
EspMasterBtn.Text, EspMasterBtn.Font, EspMasterBtn.TextSize = "КОМАНДНЫЙ ESP [B]: ВЫКЛ", Enum.Font.GothamBold, 11
Instance.new("UICorner", EspMasterBtn).CornerRadius = UDim.new(0, 6)
local EspMStroke = Instance.new("UIStroke", EspMasterBtn) EspMStroke.Color = Color3.fromRGB(255, 30, 30)

local EspListTitle = Instance.new("TextLabel", espPage)
EspListTitle.Size, EspListTitle.BackgroundTransparency, EspListTitle.TextColor3 = UDim2.new(1, -6, 0, 25), 1, Color3.fromRGB(255, 50, 50)
EspListTitle.Text, EspListTitle.Font, EspListTitle.TextSize, EspListTitle.TextXAlignment = "  ВЫБОР ЦЕЛИ ДЛЯ ФИОЛЕТОВОГО ESP:", Enum.Font.GothamBold, 11, Enum.TextXAlignment.Left

local EspPlayersContainer = Instance.new("Frame", espPage)
EspPlayersContainer.Size, EspPlayersContainer.BackgroundTransparency = UDim2.new(1, -6, 0, 180), 1
local EspListLayout = Instance.new("UIListLayout", EspPlayersContainer) EspListLayout.Padding = UDim.new(0, 5)

local function updateEspUI()
    if espEnabled then
        EspMasterBtn.Text = "КОМАНДНЫЙ ESP [B]: АКТИВЕН"
        EspMasterBtn.BackgroundColor3, EspMasterBtn.TextColor3 = Color3.fromRGB(20, 50, 20), Color3.fromRGB(75, 255, 75)
        EspMStroke.Color = Color3.fromRGB(30, 255, 30)
    else
        EspMasterBtn.Text = "КОМАНДНЫЙ ESP [B]: ВЫКЛ"
        EspMasterBtn.BackgroundColor3, EspMasterBtn.TextColor3 = Color3.fromRGB(55, 15, 15), Color3.fromRGB(255, 75, 75)
        EspMStroke.Color = Color3.fromRGB(255, 30, 30)
    end
end

local function rebuildEspList()
    for _, item in ipairs(EspPlayersContainer:GetChildren()) do if item:IsA("TextButton") then item:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local btn = Instance.new("TextButton", EspPlayersContainer)
            btn.Size, btn.BorderSizePixel = UDim2.new(1, 0, 0, 30), 0
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
            local bStroke = Instance.new("UIStroke", btn)
            
            if selectedTarget == p then
                btn.BackgroundColor3, btn.TextColor3 = Color3.fromRGB(70, 0, 110), Color3.fromRGB(220, 140, 255)
                btn.Text = "  🎯 [ПРИОРЕТЕТНАЯ ЦЕЛЬ] " .. p.DisplayName .. " (@" .. p.Name .. ")"
                bStroke.Color = Color3.fromRGB(185, 0, 255)
            else
                btn.BackgroundColor3, btn.TextColor3 = Color3.fromRGB(24, 20, 20), Color3.fromRGB(220, 220, 220)
                btn.Text = "  " .. p.DisplayName .. " (@" .. p.Name .. ")"
                bStroke.Color = Color3.fromRGB(255, 30, 30)
            end
            btn.Font, btn.TextSize, btn.TextXAlignment = Enum.Font.Gotham, 11, Enum.TextXAlignment.Left

            btn.MouseButton1Click:Connect(function()
                selectedTarget = (selectedTarget == p) and nil or p
                rebuildEspList()
            end)
        end
    end
    espPage.CanvasSize = UDim2.new(0, 0, 0, 80 + (#Players:GetPlayers() * 35))
end

EspMasterBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    updateEspUI()
    if not espEnabled then
        for _, h in pairs(highlights) do h:Destroy() end
        table.clear(highlights)
    end
end)

Players.PlayerAdded:Connect(rebuildEspList) Players.PlayerRemoving:Connect(rebuildEspList)
rebuildEspList()

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local function checkWall(targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end
    rayParams.FilterDescendantsInstances = {LP.Character, targetPlayer.Character}
    local res = workspace:Raycast(Cam.CFrame.Position, targetPlayer.Character.HumanoidRootPart.Position - Cam.CFrame.Position, rayParams)
    return res == nil
end
-- ==================== СТРАНИЦА 4: NEXUS GHOST PROXY (ПРИЗРАК) ====================
local GhostMasterBtn = Instance.new("TextButton", ghostPage)
GhostMasterBtn.Size, GhostMasterBtn.BackgroundColor3, GhostMasterBtn.TextColor3 = UDim2.new(1, -6, 0, 35), Color3.fromRGB(55, 15, 15), Color3.fromRGB(255, 75, 75)
GhostMasterBtn.Text, GhostMasterBtn.Font, GhostMasterBtn.TextSize = "РЕЖИМ ПРИЗРАКА: ВЫКЛ", Enum.Font.GothamBold, 11
Instance.new("UICorner", GhostMasterBtn).CornerRadius = UDim.new(0, 6)
local GhostMStroke = Instance.new("UIStroke", GhostMasterBtn) GhostMStroke.Color = Color3.fromRGB(255, 30, 30)

local GSpeedFrame = Instance.new("Frame", ghostPage)
GSpeedFrame.Size, GSpeedFrame.BackgroundTransparency = UDim2.new(1, -6, 0, 35), 1
local GSpeedLabel = Instance.new("TextLabel", GSpeedFrame)
GSpeedLabel.Size, GSpeedLabel.BackgroundTransparency, GSpeedLabel.TextColor3 = UDim2.new(0, 150, 1, 0), 1, Color3.fromRGB(200, 200, 200)
GSpeedLabel.Text, GSpeedLabel.Font, GSpeedLabel.TextSize, GSpeedLabel.TextXAlignment = "Скорость полета: " .. ghostSpeed, Enum.Font.Gotham, 11, Enum.TextXAlignment.Left

local function makeGhostAdjustBtn(txt, xPos, offset)
    local b = Instance.new("TextButton", GSpeedFrame)
    b.Size, b.Position, b.BackgroundColor3, b.TextColor3 = UDim2.new(0, 30, 0, 26), xPos, Color3.fromRGB(24, 20, 20), Color3.fromRGB(255, 50, 50)
    b.Text, b.Font, b.TextSize = txt, Enum.Font.GothamBold, 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    local bStroke = Instance.new("UIStroke", b) bStroke.Color = Color3.fromRGB(255, 30, 30)
    
    b.MouseButton1Click:Connect(function()
        ghostSpeed = math.max(10, ghostSpeed + offset)
        GSpeedLabel.Text = "Скорость полета: " .. ghostSpeed
    end)
end
makeGhostAdjustBtn("-", UDim2.new(1, -70, 0, 4), -5)
makeGhostAdjustBtn("+", UDim2.new(1, -34, 0, 4), 5)

local GInfo = Instance.new("TextLabel", ghostPage)
GInfo.Size, GInfo.BackgroundTransparency, GInfo.TextColor3 = UDim2.new(1, -6, 0, 50), 1, Color3.fromRGB(140, 140, 140)
GInfo.Text, GInfo.Font, GInfo.TextSize = "Управление полетом сферной формы:\nДвижение: W, A, S, D\nПодняться: Space | Опуститься: Левый Shift", Enum.Font.Gotham, 10
ghostPage.CanvasSize = UDim2.new(0, 0, 0, 140)

local function toggleGhost()
    local char, hrp, hum = getChar()
    if not char or not hrp or not hum then return end
    ghostActive = not ghostActive
    if ghostActive then
        GhostMasterBtn.BackgroundColor3, GhostMasterBtn.TextColor3, GhostMasterBtn.Text = Color3.fromRGB(20, 50, 20), Color3.fromRGB(75, 255, 75), "РЕЖИМ ПРИЗРАКА: АКТИВЕН"
        GhostMStroke.Color = Color3.fromRGB(30, 255, 30)
        originalCFrame = hrp.CFrame
        ghostPart = Instance.new("Part")
        ghostPart.Name = "ApolHubGhostPart"
        ghostPart.Size = Vector3.new(2, 2, 2)
        ghostPart.Shape = Enum.PartType.Ball
        ghostPart.Color = Color3.fromRGB(255, 30, 30)
        ghostPart.Material = Enum.Material.Neon
        ghostPart.Transparency = 0.4
        ghostPart.CanCollide = false
        ghostPart.Anchored = true
        ghostPart.CFrame = hrp.CFrame
        ghostPart.Parent = workspace
        Cam.CameraSubject = ghostPart
    else
        GhostMasterBtn.BackgroundColor3, GhostMasterBtn.TextColor3, GhostMasterBtn.Text = Color3.fromRGB(55, 15, 15), Color3.fromRGB(255, 75, 75), "РЕЖИМ ПРИЗРАКА: ВЫКЛ"
        GhostMStroke.Color = Color3.fromRGB(255, 30, 30)
        Cam.CameraSubject = hum
        if ghostPart and hrp then
            hrp.Velocity = Vector3.zero
            char:PivotTo(ghostPart.CFrame)
        end
        if ghostPart then ghostPart:Destroy() ghostPart = nil end
    end
end
GhostMasterBtn.MouseButton1Click:Connect(toggleGhost)

-- ==================== ЛОГИКА РЕНДЕРА И ОБРАБОТКИ ESP ====================
local function applyESP(player)
    local char = player.Character
    if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
        if highlights[player] then highlights[player]:Destroy(); highlights[player] = nil end
        return
    end

    if player == selectedTarget then
        if highlights[player] then highlights[player]:Destroy(); highlights[player] = nil end
        if not targetHighlight or targetHighlight.Parent ~= char then
            if targetHighlight then targetHighlight:Destroy() end
            targetHighlight = Instance.new("Highlight")
            targetHighlight.Parent = char
        end
        targetHighlight.FillColor = Color3.fromRGB(185, 0, 255)
        targetHighlight.FillTransparency = 0.2
        targetHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        targetHighlight.OutlineTransparency = 0.1
        return
    end

    if not espEnabled or player == LP then
        if highlights[player] then highlights[player]:Destroy(); highlights[player] = nil end
        return
    end

    local hl = highlights[player]
    if not hl or hl.Parent ~= char then
        if hl then hl:Destroy() end
        hl = Instance.new("Highlight")
        hl.Parent = char
        highlights[player] = hl
    end

    local color = player.TeamColor.Color
    if checkWall(player) then
        hl.FillTransparency = 1
        hl.OutlineColor = color
        hl.OutlineTransparency = 0.2
    else
        hl.FillColor = color
        hl.FillTransparency = 0.1
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.OutlineTransparency = 0.3
    end
end

-- ==================== СЕРВИСНЫЕ ЦИКЛЫ И БИНДЫ ====================
UIS.InputBegan:Connect(function(input, proc)
    if proc then return end
    -- Открытие/скрытие Apol.hub на Insert или Правый Shift
    if input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.RightShift then
        hubVisible = not hubVisible
        Main.Visible = hubVisible
    -- Клавиша L для сброса наблюдения (камера возвращается к персонажу)
    elseif input.KeyCode == Enum.KeyCode.L or input.KeyCode == Enum.KeyCode.Return then
        if specP then stopSpec() buildObserver() end
    -- Клавиша B для быстрого переключения командного ESP
    elseif input.KeyCode == Enum.KeyCode.B then
        espEnabled = not espEnabled
        updateEspUI()
        if not espEnabled then
            for _, h in pairs(highlights) do h:Destroy() end
            table.clear(highlights)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if ghostActive and ghostPart then
        local char, hrp, _ = getChar()
        if hrp then
            hrp.Velocity = Vector3.zero
            hrp.CFrame = originalCFrame
        end
        local moveDir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end

        if moveDir.Magnitude > 0 then
            ghostPart.CFrame = ghostPart.CFrame + (moveDir.Unit * (ghostSpeed * task.wait()))
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.03)
        if specP and (not specP.Character or not specP.Character:FindFirstChild("Humanoid")) then
            stopSpec()
            buildObserver()
        end
        if (not selectedTarget or not selectedTarget.Character) and targetHighlight then
            targetHighlight:Destroy()
            targetHighlight = nil
        end
        for _, p in ipairs(Players:GetPlayers()) do
            pcall(applyESP, p)
        end
    end
end)

local function fullRebuild()
    buildObserver()
    rebuildEspList()
end
Players.PlayerAdded:Connect(fullRebuild)
Players.PlayerRemoving:Connect(function(p)
    if selectedTarget == p then selectedTarget = nil end
    fullRebuild()
end)

fullRebuild()
print("[Apol.hub]: Полная сборка успешно завершена. Меню готово к использованию!")
