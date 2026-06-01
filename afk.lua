local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local cooldown = 0
local interval = 55
local enabled = true
local totalPings = 0
local sessionTime = 0

-- Bypass Roblox idle detection
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(0.1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

RunService.Heartbeat:Connect(function(dt)
    if not enabled then return end

    cooldown -= dt
    sessionTime += dt

    if cooldown <= 0 then
        cooldown = interval

        -- Method 1: VirtualUser click
        pcall(function()
            VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(0.1)
            VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)

        -- Method 2: Camera CFrame nudge
        pcall(function()
            local cam = workspace.CurrentCamera
            local cf = cam.CFrame
            cam.CFrame = cf * CFrame.Angles(0, 0.0001, 0)
            task.wait(0.05)
            cam.CFrame = cf
        end)

        -- Method 3: Fake keypress
        pcall(function()
            VirtualUser:KeyDown(string.char(0))
            task.wait(0.05)
            VirtualUser:KeyUp(string.char(0))
        end)

        totalPings += 1
        print("Anti AFK ping " .. totalPings .. " | Session: " .. math.floor(sessionTime / 60) .. "m " .. math.floor(sessionTime % 60) .. "s")
    end
end)

print("Anti AFK loaded â€” triple bypass active")
print("Will ping every " .. interval .. " seconds")
