task.spawn(function()
    local LocalPlayer = game.Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local SprintEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("SprintEvent")
    
    local sprinting = false

    while true do
        local playerFolder = workspace:WaitForChild("InGamePlayers"):FindFirstChild(LocalPlayer.Name)
        local staminaVal = playerFolder and playerFolder:FindFirstChild("Stats") and playerFolder.Stats:FindFirstChild("CurrentStamina")

        if staminaVal then
            local stamina = staminaVal.Value

            -- Logic: Sprint if > 20, Stop if < 20, Resume at 40
            if not sprinting and stamina > 20 then
                sprinting = true
                SprintEvent:FireServer(true)
            elseif sprinting and stamina < 20 then
                sprinting = false
                SprintEvent:FireServer(false)
            elseif not sprinting and stamina >= 40 then
                sprinting = true
                SprintEvent:FireServer(true)
            end
        end
        
        task.wait(0.5) -- Prevents script lag
    end
end)
