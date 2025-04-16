-- LocalScript
-- Este script resalta a los jugadores en color rojo a través de las paredes

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Agrega un Highlight para cada jugador
local function addHighlight(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = player.Character
        highlight.FillColor = Color3.new(1, 0, 0) -- Color rojo
        highlight.OutlineTransparency = 1 -- Sin contorno
        highlight.Parent = player.Character
    end
end

-- Remueve el Highlight cuando el jugador se va
local function removeHighlight(player)
    if player.Character and player.Character:FindFirstChildOfClass("Highlight") then
        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
    end
end

-- Maneja cuando un jugador se une
local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function()
        addHighlight(player)
    end)
end

-- Configura el script
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(removeHighlight)

-- Actualiza los Highlights en tiempo real
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            addHighlight(player)
        end
    end
end)
