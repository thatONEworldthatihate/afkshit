task.spawn(function()
    while true do
        if Enabled then
            local event = game:GetService("ReplicatedStorage"):FindFirstChild("Events") and game.ReplicatedStorage.Events:FindFirstChild("SprintEvent")
            if event then event:FireServer(true) end
        end
        task.wait(25)
    end
end)
