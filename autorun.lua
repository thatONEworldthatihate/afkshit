task.spawn(function()
    local lp = game.Players.LocalPlayer
    local rs = game:GetService("ReplicatedStorage")
    local sprintEvent = rs:WaitForChild("Events"):WaitForChild("SprintEvent")
    
    -- Local variables to track state without relying on complex logic
    local resumeThreshold = 40
    local stopThreshold = 20
    local isSprinting = false

    while task.wait(0.2) do
        local stats = workspace:FindFirstChild("InGamePlayers") 
            and workspace.InGamePlayers:FindFirstChild(lp.Name) 
            and workspace.InGamePlayers[lp.Name]:FindFirstChild("Stats")
            and workspace.InGamePlayers[lp.Name].Stats:FindFirstChild("CurrentStamina")

        if stats then
            local stam = stats.Value

            -- Start Sprinting Logic
            if not isSprinting and (stam > stopThreshold) then
                sprintEvent:FireServer(true)
                isSprinting = true
            -- Stop Sprinting Logic
            elseif isSprinting and (stam < stopThreshold) then
                sprintEvent:FireServer(false)
                isSprinting = false
            -- Resume Logic (Wait until 40)
            elseif not isSprinting and (stam >= resumeThreshold) then
                sprintEvent:FireServer(true)
                isSprinting = true
            end
        end
    end
end)
