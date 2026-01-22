-- Raft 101 | Bring + Auto Kill | Delta Mobile

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local bring, kill = false, false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0, 20, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local function btn(text, y)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1,-10,0,45)
    b.Position = UDim2.new(0,5,0,y)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    return b
end

local b1 = btn("BRING: OFF", 5)
local b2 = btn("AUTO KILL: OFF", 60)

b1.MouseButton1Click:Connect(function()
    bring = not bring
    b1.Text = bring and "BRING: ON" or "BRING: OFF"
end)

b2.MouseButton1Click:Connect(function()
    kill = not kill
    b2.Text = kill and "AUTO KILL: ON" or "AUTO KILL: OFF"
end)

RunService.Heartbeat:Connect(function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, v in pairs(workspace:GetDescendants()) do
        if bring then
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                v.Handle.CFrame = hrp.CFrame * CFrame.new(0,0,-3)
            end
        end

        if kill and v:IsA("Model")
        and v:FindFirstChild("Humanoid")
        and v:FindFirstChild("HumanoidRootPart")
        and not Players:GetPlayerFromCharacter(v) then
            v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,0,-4)
            v.Humanoid:TakeDamage(9999)
        end
    end
end)
